//#define ORBIT_CAM

#define ITERATIONS 96
#define SHADOW_ITERATIONS 8

#ifdef ORBIT_CAM
const float aperture=0.0001,focalDistance=1000.0;
#else
const float aperture=0.025,focalDistance=10.0;
#endif


const float streetWidth = 30.0;
const float blockWidth = 200.0;
const float totalBlock = blockWidth + streetWidth;
const float halfStreetWidth = streetWidth*0.5;
const float maxBlockHeight = 600.00;

#define sat(x) clamp(x,0.0, 1.0)

float CircleOfConfusion(float t){//calculates the radius of the circle of confusion at length t
//	return 0.01;
//	return max(0.01,abs(focalDistance-t)*1.0*aperture);
	return clamp(abs(focalDistance-t)*1.0*aperture, 0.01, halfStreetWidth);
}
float linstep(float a, float b, float t){
	float v=(t-a)/(b-a);
	return clamp(v,0.,1.);
}
float rand(vec2 co){// implementation found at: lumina.sourceforge.net/Tutorials/Noise.html
	return fract(sin(dot(co*0.123,vec2(12.9898,78.233))) * 43758.5453);
}

float smin( float a, float b, float k )
{
    float h = clamp( 0.5+0.5*(b-a)/k, 0.0, 1.0 );
    return mix( b, a, h ) - k*h*(1.0-h);
}
float udRoundBox( vec3 p, vec3 b, float r )
{
  return length(max(abs(p)-b,0.0))-r;
}
float udBox( vec3 p, vec3 b )
{
  return length(max(abs(p)-b,0.0));
}
float sdBox( vec3 p, vec3 b )
{
  vec3 d = abs(p) - b;
  return min(max(d.x,max(d.y,d.z)),0.0) +
         length(max(d,0.0));
}
float smoothstep2( float min1, float max1, float min2, float max2, float p )
{
	return smoothstep(min1, max1, p) * (1.0 - smoothstep(min2, max2, p));
}
float softstep( float min1, float p )
{
	return smoothstep(min1, min1+0.01, p);
}
float softstep2( float min1, float min2, float p )
{
	return softstep(min1, p) * (1.0 - softstep(min2, p));
}



float BlockDe( vec3 pos, float blockId, inout vec4 m )
{
	if( blockId < 0.33 )
		return 99999.9;
	float h = blockId;
	
	h = maxBlockHeight*0.01 + h*maxBlockHeight*0.99;
	h *= 0.5;
	
	float wScale = fract(blockId+0.5);
	
	float w = blockWidth*0.5;
	float xz = w*0.6 + w*0.4*wScale;
	
	pos.xz -= totalBlock*0.5;
	
	float bulk = sdBox( pos - vec3(0,h,0), vec3(xz,h,xz) );
	float de = bulk;
	
	float bounds = sdBox( pos - vec3(0,h+1.0,0), vec3(xz+2.0,h+2.0,xz+2.0) );
	
	float bands;
	{
		vec3 p = pos;
		float addHeight = 10.0;
		p.y += 2.0;
		float r = addHeight + addHeight + 20.0 * (fract(1.3-blockId*7.0));
		p.y = mod(p.y,r);//-0.5*r;
		xz = xz+1.0*wScale;
		bands = sdBox(p, vec3(xz, addHeight, xz));
		bands = max(bands,bounds);
		de = smin( de, bands, 10.0 );
	}
	
	float base;
	{
		float baseW = w*0.9 + w*0.1*wScale;
		float baseH = 0.1;//0.5 + 4.0 * (1.0-blockId);
		base = sdBox( pos - vec3(0,baseH,0), vec3(baseW,baseH,baseW) );
		de = min(de,base);
	}
	
	//m.x += 1.0;
	/*
	m.x += clamp(1.0-smoothstep(0.0,de,bulk), 0.0, 1.0);
	m.y += clamp(1.0-smoothstep(0.0,de,bands), 0.0, 1.0);
	m.z += clamp(1.0-smoothstep(0.0,de,base), 0.0, 1.0);*/
	
	//if( base -de < 0.001 ) m.x += 1.0;
	//if( bands-de < 0.001 ) m.y += 1.0;
	//if( base -de < 0.001 ) m.z += 1.0;
	
	float alpha = clamp((bulk-bands)*100.0,0.0,1.0);
	m = mix( vec4(1,0,0,0), vec4(0,1,0,0), alpha );
	alpha = clamp((base-bulk+2.0)*10000.0,0.0,1.0);
	m = mix( vec4(0,0,1,0), m, alpha );
	
	
	/*
	float dentHeight = 10.0;
	float dentDepth = 10.0 + 20.0 * (fract(blockId+0.7));
	pos.y -= dentHeight+2.0;
	float r = dentHeight + 1.0 + 20.0 * (fract(1.3-blockId*7.0));
	pos.y = mod(pos.y,r);//-0.5*r;
	
	xz+=halfStreetWidth;
	float carve = sdBox(pos, vec3(xz,dentHeight,xz));

	carve = 999999.0;
*/
	//addLower = 999999.0;
	//addLower = min(addLower,bulk);
	//carveLower = min(carveLower,bulk);
	//addLower = 999999.9;
	
	//return smin( bulk, add, 1.0 );
	return de;
}
float BlockId( vec2 pos )
{
	//return 1.0;
	return rand(floor(pos/totalBlock));
}
//close to the surface of a building
float DeN( vec3 pos )
{
	float blockId1 = BlockId(pos.xz);
	pos.x = mod(pos.x,totalBlock);
	pos.z = mod(pos.z,totalBlock);
	vec4 m = vec4(0);
	return BlockDe(pos, blockId1, m);
}
//within city volume
float DeWithin( vec3 pos, vec3 rd, out float maxStep, inout vec4 m )
{
	float startBlockX = floor((pos.x)/totalBlock);
	float startBlockZ = floor((pos.z)/totalBlock);
	float xDir = rd.x > 0.0 ? 1.0 : -1.0;
	float zDir = rd.z > 0.0 ? 1.0 : -1.0;
	vec3 p1N = normalize(vec3(-1,0,0));
	vec3 p2N = normalize(vec3(0,0,-1));
	float p1Offs = rd.x > 0.0 ? (startBlockX+1.0)*totalBlock : (startBlockX)*totalBlock;
	float p2Offs = rd.z > 0.0 ? (startBlockZ+1.0)*totalBlock : (startBlockZ)*totalBlock;
	float e1 = -(dot(p1N,pos) + p1Offs) / (dot(p1N, rd));
	float e2 = -(dot(p2N,pos) + p2Offs) / (dot(p2N, rd));
	maxStep = min(e1,e2);
	
	float blockId1 = BlockId(pos.xz);
	pos.x = mod(pos.x,totalBlock);
	pos.z = mod(pos.z,totalBlock);
	return BlockDe(pos, blockId1, m);
}
//above city volume
float DeAbove( vec3 pos, vec3 rd, out float maxStep, inout vec4 m )
{
	float de;
	if( pos.y > maxBlockHeight+0.1 )
	{//if ray is above buildings, continue until you're at roof height
		de = (pos.y-maxBlockHeight) / (abs(rd.y));
		de = max(de, 0.1);
	}
	else
	{
		return DeWithin(pos, rd, maxStep, m);
		//return DeN(pos);
	}
	return maxStep=de;
}

vec3 N0=vec3(0.0001);
vec3 N1=vec3(0.0001);
vec3 N2=vec3(0.0001);
vec3 N3=vec3(0.0001);

vec4 hit0=vec4(0);
vec4 hit1=vec4(0);
vec4 hit2=vec4(0);
vec4 hit3=vec4(0);

void onHit(float de, vec3 p, float rCoC, inout float coverage, vec4 c, inout vec4 material)
{
	vec2 v=vec2(0.5*rCoC,0.0);
	vec3 N=normalize(vec3(-DeN(p-v.xyy)+DeN(p+v.xyy),-DeN(p-v.yxy)+DeN(p+v.yxy),-DeN(p-v.yyx)+DeN(p+v.yyx)));
	
	float alpha=(1.0-coverage)*linstep(-rCoC,rCoC,-de);
	
	material += c*alpha;
	//float lit = 1.0 * (dot(N,L)*0.5+0.5);
	//float lit = 1.0;
	
	//col += (N*0.5+0.5) * alpha;
	
//	col += lit * vec3(0.5,.5,1.0) * (sin(p.y*0.5)*0.25+0.75) * alpha;
//	avgN += N*alpha;
	coverage += alpha;
	
	hit0 = alpha > hit0.w ? vec4(p,alpha) : hit0;
	hit1 = alpha > hit1.w ? vec4(p,alpha) : hit1;
	hit2 = alpha > hit2.w ? vec4(p,alpha) : hit2;
	hit3 = alpha > hit3.w ? vec4(p,alpha) : hit3;
	
	N0 += N * alpha * c.x;
	N1 += N * alpha * c.y;
	N2 += N * alpha * c.z;
	N3 += N * alpha * c.w;
}

vec2 GetUv(vec3 N0, vec3 hit0)
{
	N0 = abs(N0);
	return N0.x > N0.y
		? (N0.z > N0.x ? hit0.xy : hit0.zy)
		: (N0.z > N0.y ? hit0.xy : hit0.xz);
}

float noise( in vec2 x )
{
	return sin(1.5*x.x)*sin(1.5*x.y);
}

float fbm4( vec2 p )
{
	const mat2 m = mat2( 0.80,  0.60, -0.60,  0.80 );
    float f = 0.0;
    f += 0.5000*noise( p ); p = m*p*2.02;
    f += 0.2500*noise( p ); p = m*p*2.03;
    f += 0.1250*noise( p ); p = m*p*2.01;
    f += 0.0625*noise( p );
    return f/0.9375;
}

float fbm6( vec2 p )
{
	const mat2 m = mat2( 0.80,  0.60, -0.60,  0.80 );
    float f = 0.0;
    f += 0.500000*(0.5+0.5*noise( p )); p = m*p*2.02;
    f += 0.250000*(0.5+0.5*noise( p )); p = m*p*2.03;
    f += 0.125000*(0.5+0.5*noise( p )); p = m*p*2.01;
    f += 0.062500*(0.5+0.5*noise( p )); p = m*p*2.04;
    f += 0.031250*(0.5+0.5*noise( p )); p = m*p*2.01;
    f += 0.015625*(0.5+0.5*noise( p ));
    return f/0.96875;
}


vec3 DoLighting( vec3 pos, vec3 V, vec3 N, vec3 color, vec2 fragCoord )
{
	float specular = 0.0;
	float diffuse = 0.0;
	
	vec3 ambientL = normalize(vec3(-1,2,1));
	vec3 ambientH = normalize(ambientL + V);
	
	vec3 L = ambientL;
	float shadow = 0.0;
	float t = 1.0;
	//pos += N*1.0;
	pos += V*1.0;
	for(int i=1;i<SHADOW_ITERATIONS;i++){//march loop
		
		vec3 p = pos+L*t;
		float rCoC=CircleOfConfusion(t);
		
		float maxStep = 9999999.0;
		vec4 c = vec4(0);
		float de=DeWithin( p, L, maxStep, c );// +0.25*rCoC;
		
		rCoC = (100.0 - 100.0/(t*0.02));
		if(de<rCoC){
			shadow += (1.0-sat(de/rCoC))*sat(45.0/t);
		}
		
		//de = de + 1.0*fract(de);// + t;//de;// * 2.0 + 5.0;
		//de = 15.0 + 15.0*rand(fragCoord.xy*vec2(i));
		//de = 15.0 + 15.0*fract(abs(pos.z*de+V.x));
		de = max( de * 2.0, 10.0 );
		de = min(de,maxStep);
		de += 1.0*rand(fragCoord.xy*vec2(i));
		t += de;
	}
	shadow = 1.0-sat(shadow)*0.55;
	
	diffuse += (dot(N,ambientL)*0.5+0.5) * shadow;
	specular += sat(dot(N,ambientL))* pow(sat(dot(N,ambientH)), 10.0) * shadow;
	
	//return vec3(shadow);
	
	float specMask = sat(1.0-dot(vec3(1./3.), color));
	return diffuse * color + specular * specMask;
}

vec3 RoadTexture(vec3 pos)
{
	float f = abs(sin(pos.x*10.0))*abs(sin(pos.z*12.0));
	vec3 road = mix(vec3(0.10,0.12,0.13), vec3(0.13,0.1,0.08), f);
	
	vec2 xz = abs(mod(pos.xz, totalBlock)-totalBlock*0.5)-blockWidth*0.5;
	xz /= halfStreetWidth;
	
	const float lineWidth = 0.1;
	const float lnpcnt = 0.5*lineWidth/halfStreetWidth;
	vec3 paint = vec3(0.5,0.5,0.4);
	float lane;
	
	road = mix(road, paint, softstep(1.0-lnpcnt*5.0,xz.x) );
	lane = 3.0/halfStreetWidth;
	road = mix(road, paint, softstep2(1.0-lane-lnpcnt, 1.0-lane+lnpcnt, xz.x) );
	lane = 6.0/halfStreetWidth;
	road = mix(road, paint, softstep2(1.0-lane-lnpcnt, 1.0-lane+lnpcnt, xz.x) );
	lane = 9.0/halfStreetWidth;
	road = mix(road, paint, softstep2(1.0-lane-lnpcnt, 1.0-lane+lnpcnt, xz.x) );
	lane = 12.0/halfStreetWidth;
	road = mix(road, paint, softstep2(1.0-lane-lnpcnt*5.0, 1.0-lane+lnpcnt*5.0, xz.x) );
	
	road = mix(road, paint, softstep(1.0-lnpcnt*5.0,xz.y) );
	lane = 3.0/halfStreetWidth;
	road = mix(road, paint, softstep2(1.0-lane-lnpcnt, 1.0-lane+lnpcnt, xz.y) );
	lane = 6.0/halfStreetWidth;
	road = mix(road, paint, softstep2(1.0-lane-lnpcnt, 1.0-lane+lnpcnt, xz.y) );
	lane = 9.0/halfStreetWidth;
	road = mix(road, paint, softstep2(1.0-lane-lnpcnt, 1.0-lane+lnpcnt, xz.y) );
	lane = 12.0/halfStreetWidth;
	road = mix(road, paint, softstep2(1.0-lane-lnpcnt*5.0, 1.0-lane+lnpcnt*5.0, xz.y) );
	return road;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	float time = iTime;
#ifdef ORBIT_CAM
	vec3 ro = vec3(sin(time*0.5)*1000.0, 1000, cos(time*0.5)*1000.0);
	vec3 ta = vec3(0, (sin(time)*0.5+0.5)*200.0, 0);
#else
	vec3 ro = vec3(pow(sin(time*0.5),3.0)*5.0+6.0, 1.4, time*100.0);
	vec3 ta = ro + vec3(sin(time*0.8)*3.0,(sin(time)*0.5+0.5)*2.0,10);
#endif

	vec2 q = fragCoord.xy/iResolution.xy;
    vec2 p = -1.0+2.0*q;
	p.x *= iResolution.x/iResolution.y;
	vec3 cw = normalize( ta-ro );
	vec3 cp = vec3( 0.0, 1.0, 0.0 );
	vec3 cu = normalize( cross(cw,cp) );
	vec3 cv = normalize( cross(cu,cw) );
	vec3 rd = normalize( p.x*cu + p.y*cv + 1.0*cw );
	
	float distToGround = - (dot(vec3(0,1,0),ro) + 0.0) / (dot(vec3(0,1,0), rd));
	distToGround = distToGround < 0.0 ? 999999.0 : distToGround;
	
	float coverage = 0.0;
	vec4 material = vec4(0.001, 0, 0, 0);
	vec3 col = vec3(0);
	vec4 c;
	float lastT = 0.0;
	float t=0.0;//distance traveled
	//float didHit = 0.0;
	for(int i=0;i<ITERATIONS;i++){//march loop
		if( t >= distToGround || coverage > 0.99 ) continue;
		
		vec3 pos = ro+rd*t;
		float rCoC=CircleOfConfusion(t);
		
		float maxStep = 999999.0;
		c = vec4(0);
		float de=DeAbove( pos, rd, maxStep, c ) +0.25*rCoC;
		//float de=DeN( pos ) +0.25*rCoC;
		
		if(de<rCoC){
			onHit(de, pos, rCoC, coverage, c, material);
		}
		
		de=abs(de)*(0.5+0.5*rand(fragCoord.xy*vec2(i)));
		de = min(de, maxStep+halfStreetWidth);
		
		lastT = t;
		t += de;
	}
	
	t = min(t,abs(distToGround));
	vec3 pos = ro + rd*t;
	
	float bgAlpha = 1.0-coverage;
	
//		col += vec3(0.5,.5,1.0) * (sin(pos.y*0.5)*0.25+0.75) * bgAlpha;
	
	//vec3 N = normalize(avgN);
	N0 = normalize(N0);	
	N1 = normalize(N1);	
	N2 = normalize(N2);	
	N3 = normalize(N3);
	
	vec3 _mtl0 = vec3(0.34, 0.40, 0.24);
	vec3 _mtl1 = vec3(0.38, 0.54, 0.51);
	vec3 _mtl2 = vec3(0.38, 0.40, 0.61);
	vec3 _mtl3 = vec3(0.03, 0.42, 0.64);
	/*vec3 mtl0 = vec3(1, 0, 0);
	vec3 mtl1 = vec3(0, 1, 0);
	vec3 mtl2 = vec3(0, 0, 1);
	vec3 mtl3 = vec3(0, 0, 0);*/
	
	float id = BlockId(pos.xz);
	
	vec3 mtl0 = mix(_mtl0, _mtl1, fract(id*2.0));
	     mtl0 = mix( mtl0, _mtl3, fract(id*2.0+1.0));
	vec3 mtl1 = mix(_mtl1, _mtl2, fract(id*4.0+0.4));
	     mtl1 = mix( mtl1, _mtl0, fract(id*1.0+0.3));
	vec3 mtl2 = mix(_mtl2, _mtl3, fract(id*2.0+0.7));
	     mtl2 = mix( mtl2,  mtl1, fract(id*0.1+0.7));
	vec3 mtl3 = mix(_mtl3, _mtl0, fract(id*8.0+0.6));
	     mtl3 = mix( mtl3, _mtl1, fract(id*0.5+0.6));
	
	if( pos.y < 0.01 )
	{
		mtl3 = RoadTexture(pos) * bgAlpha;
		material = vec4(0,0,0,1);
		N3 = vec3(0,1,0);
		coverage = 1.0;
	}
//	else if( rd.y > 0.0 && t > 1000.0 )
//	else if( rd.y > 0.0 && pos.y >= maxBlockHeight-1.1 )
	else if( pos.y >= maxBlockHeight-10.1 )
	{
		vec3 sky = mix( vec3(.17, .13, .3), vec3(.1, .13, .47), rd.y );
		col += sky * bgAlpha;
	}
	else
	{
		vec3 pos = ro+rd*t;
		float rCoC=CircleOfConfusion(t);
		onHit(0.0, pos, rCoC, coverage, c, material);
	}
	
	hit0.xyz = pos;
	hit1.xyz = pos;
	hit2.xyz = pos;
	hit3.xyz = pos;
	
	//vec3 u = cross(N0, vec3(0,0,1));
	//vec3 v = cross(N0, u);
	//vec2 uv0 = vec2( dot(hit0.xyz,u), dot(hit0.xyz,v) );
			
	vec2 uv0 = GetUv(N0, hit0.xyz);
	vec2 uv1 = GetUv(N1, hit1.xyz);
	vec2 uv2 = GetUv(N2, hit2.xyz);
	vec2 uv3 = GetUv(N3, hit3.xyz);
	//mtl0 = vec3( fract(uv0*0.1), 0 );
	//mtl0 = v*0.5+0.5;
	//mtl0 = fract(hit0.xyz*0.1);
//	mtl0 = texture(iChannel0, uv0*0.1).rgb;
//	mtl1 = texture(iChannel1, uv1*0.1).rgb;
//	mtl2 = texture(iChannel2, uv2*0.1).rgb;
//	mtl3 = texture(iChannel3, uv3*0.1).rgb;
	
	//uv0.x *= fbm4(uv0.xy*0.01);
	mtl0 *= (fbm4(uv0*0.041)*0.25+0.75) * vec3(1);
	mtl1 *= (fbm4(uv1*0.031)*0.25+0.75) * vec3(1);
	mtl2 *= (fbm4(uv2*0.011)*0.25+0.75) * vec3(1);
	mtl3 *= (fbm4(uv3*0.021)*0.25+0.75) * vec3(1);
	
	material /= dot(vec4(1),material);
	material *= coverage;
	
	vec3 V = -normalize(pos - ro);
	
	col.rgb += DoLighting( pos, V, N0, mtl0, fragCoord ) * material.x;
	col.rgb += DoLighting( pos, V, N1, mtl1, fragCoord ) * material.y;
	col.rgb += DoLighting( pos, V, N2, mtl2, fragCoord ) * material.z;
	col.rgb += DoLighting( pos, V, N3, mtl3 , fragCoord) * material.w;

	// col = col * (dot(N,L)*0.5+0.5);
  // col = mix( col, vec3(1,0,0), coverage>0.0?0.0:1.0 );
	fragColor = vec4(col,1);
  vec4 terminalColor = texture(iChannel0, q);
  fragColor = mix(fragColor, terminalColor, step(0.05, length(terminalColor.rgb)));
}
