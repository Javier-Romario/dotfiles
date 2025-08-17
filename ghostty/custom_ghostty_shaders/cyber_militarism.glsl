// const float Deg2Rad = 0.017453292519943295;

const float Ratio30Deg = 0.577350269189626; // tan(30deg) / 1

float line(in vec2 p, in vec2 a, in vec2 b) {
	vec2 ba = b - a;
	vec2 pa = p - a;
	float h = clamp(dot(pa, ba) / dot(ba, ba), 0.0, 1.0);
	return length(pa - h * ba);
}

float hut(in vec2 p, in float size, in float flip, in float lines) {
	vec2 mid = vec2(size * 0.5, size * 0.5 * Ratio30Deg * flip);

	if (lines < 1.5) {
		return line(p, vec2(0, 0), mid);
	} else {
		return min(
			line(p, vec2(0, 0), mid),
			line(p, mid, vec2(size, 0))
		);
	}
}

float tripleHut(in vec2 p, in float flip, in float lines) {
	return min(
		min(
			hut(p, 8.0, flip, lines),
			hut(p - vec2(1.0, -Ratio30Deg * flip), 6.0, flip, lines)
		), 
		hut(p - vec2(2.0, -Ratio30Deg * 2.0 * flip), 4.0, flip, lines)
	);
}

float completeSquigle(in vec2 p, in float innerSpacing) {
	float d = tripleHut(p, 1.0, 2.0);
	d = min(d, tripleHut(p - vec2(6, -innerSpacing), -1.0, 2.0));

	// lines going down
	d = min(d, line(p, vec2(8, 0), vec2(8, -innerSpacing + Ratio30Deg * 2.0)));
	d = min(d, line(p, vec2(7, -Ratio30Deg), vec2(7, -innerSpacing + Ratio30Deg)));
	d = min(d, line(p, vec2(6, -Ratio30Deg * 2.0), vec2(6, -innerSpacing)));
	
	// lines going back up
	d = min(d, line(p, vec2(12, 0), vec2(12, -innerSpacing + Ratio30Deg * 2.0)));
	d = min(d, line(p, vec2(13, -Ratio30Deg), vec2(13, -innerSpacing + Ratio30Deg)));
	d = min(d, line(p, vec2(14, -Ratio30Deg * 2.0), vec2(14, -innerSpacing)));

	// last triple hut
	d = min(d, tripleHut(p - vec2(12, 0), 1.0, 1.0));

	return d;
}

float repeatablePattern(in vec2 p, in float innerSpacing) {
	float d = completeSquigle(p + vec2(0, 0), innerSpacing);
	
	d = min(d, tripleHut(p + vec2(0, innerSpacing + Ratio30Deg * 6.0), 1.0, 2.0));
	d = min(d, tripleHut(p - vec2(6, Ratio30Deg * 6.0), -1.0, 2.0));

	// rest of the lines

	float yTop = Ratio30Deg * 6.0;
	float yBottom = -innerSpacing - Ratio30Deg * 6.0;

	d = min(d, line(p, vec2(0, yTop), vec2(0, yBottom)));

	d = min(d, line(p, vec2(1, yTop), vec2(1, yTop - Ratio30Deg * 5.0)));
	d = min(d, line(p, vec2(1, yTop - Ratio30Deg * 7.0), vec2(1, yBottom + Ratio30Deg)));

	d = min(d, line(p, vec2(2, yTop), vec2(2, yTop - Ratio30Deg * 4.0)));
	d = min(d, line(p, vec2(2, yTop - Ratio30Deg * 8.0), vec2(2, yBottom + Ratio30Deg * 2.0)));

	d = min(d, line(p, vec2(3, yTop), vec2(3, yTop - Ratio30Deg * 3.0)));
	d = min(d, line(p, vec2(3, yTop - Ratio30Deg * 7.0), vec2(3, yBottom + Ratio30Deg * 3.0)));

	d = min(d, line(p, vec2(4, yTop), vec2(4, yTop - Ratio30Deg * 2.0)));
	d = min(d, line(p, vec2(4, yTop - Ratio30Deg * 6.0), vec2(4, yBottom + Ratio30Deg * 4.0)));

	d = min(d, line(p, vec2(5, yTop), vec2(5, yTop - Ratio30Deg * 3.0)));
	d = min(d, line(p, vec2(5, yTop - Ratio30Deg * 7.0), vec2(5, yBottom + Ratio30Deg * 3.0)));

	d = min(d, line(p, vec2(6, yTop), vec2(6, yTop - Ratio30Deg * 4.0)));
	d = min(d, line(p, vec2(6, yBottom + Ratio30Deg * 6.0), vec2(6, yBottom + Ratio30Deg * 2.0)));

	d = min(d, line(p, vec2(7, yTop - Ratio30Deg), vec2(7, yTop - Ratio30Deg * 5.0)));
	d = min(d, line(p, vec2(7, yBottom + Ratio30Deg * 5.0), vec2(7, yBottom + Ratio30Deg)));

	d = min(d, line(p, vec2(8, yTop - Ratio30Deg * 2.0), vec2(8, yTop - Ratio30Deg * 6.0)));
	d = min(d, line(p, vec2(8, yBottom + Ratio30Deg * 4.0), vec2(8, yBottom)));

	d = min(d, line(p, vec2(9, yTop - Ratio30Deg * 3.0), vec2(9, yBottom + Ratio30Deg * 7.0)));
	d = min(d, line(p, vec2(9, yBottom + Ratio30Deg * 3.0), vec2(9, yBottom)));

	d = min(d, line(p, vec2(10, yTop - Ratio30Deg * 4.0), vec2(10, yBottom + Ratio30Deg * 6.0)));
	d = min(d, line(p, vec2(10, yBottom + Ratio30Deg * 2.0), vec2(10, yBottom)));

	d = min(d, line(p, vec2(11, yTop - Ratio30Deg * 3.0), vec2(11, yBottom + Ratio30Deg * 7.0)));
	d = min(d, line(p, vec2(11, yBottom + Ratio30Deg * 3.0), vec2(11, yBottom)));

	d = min(d, line(p, vec2(12, yTop - Ratio30Deg * 2.0), vec2(12, yTop - Ratio30Deg * 6.0)));
	d = min(d, line(p, vec2(12, yBottom + Ratio30Deg * 4.0), vec2(12, yBottom)));

	d = min(d, line(p, vec2(13, yTop - Ratio30Deg), vec2(13, yTop - Ratio30Deg * 5.0)));
	d = min(d, line(p, vec2(13, yBottom + Ratio30Deg * 5.0), vec2(13, yBottom + Ratio30Deg)));

	d = min(d, line(p, vec2(14, yTop), vec2(14, yTop - Ratio30Deg * 4.0)));
	d = min(d, line(p, vec2(14, yBottom + Ratio30Deg * 6.0), vec2(14, yBottom + Ratio30Deg * 2.0)));

	return d;
}

float infinitePattern(in vec2 p)
{
	float innerSpacing = Ratio30Deg * 10.0; // hexagon!

	vec2 size = vec2(12.0, innerSpacing + Ratio30Deg * 6.0);
	vec2 pos = vec2(-8.0, innerSpacing * 0.5);

	// repeat
    vec2 q = p - size * round(p/size);
	q -= pos;

	// vec2 q = p + vec2(10,0);

	float d = repeatablePattern(q, innerSpacing);
	
	return d;
}

// snoise minified
vec3 mod289(vec3 x) {return x - floor(x * (1.0 / 289.0)) * 289.0;}vec4 mod289(vec4 x) {return x - floor(x * (1.0 / 289.0)) * 289.0;}vec4 permute(vec4 x) { return mod289(((x*34.0)+1.0)*x);}vec4 taylorInvSqrt(vec4 r){return 1.79284291400159 - 0.85373472095314 * r;}float snoise(vec3 v){ const vec2  C = vec2(1.0/6.0, 1.0/3.0) ;const vec4  D = vec4(0.0, 0.5, 1.0, 2.0);vec3 i  = floor(v + dot(v, C.yyy) );vec3 x0 =   v - i + dot(i, C.xxx) ;vec3 g = step(x0.yzx, x0.xyz);vec3 l = 1.0 - g;vec3 i1 = min( g.xyz, l.zxy );vec3 i2 = max( g.xyz, l.zxy );vec3 x1 = x0 - i1 + C.xxx;vec3 x2 = x0 - i2 + C.yyy; vec3 x3 = x0 - D.yyy;      i = mod289(i); vec4 p = permute( permute( permute(  i.z + vec4(0.0, i1.z, i2.z, 1.0 )) + i.y + vec4(0.0, i1.y, i2.y, 1.0 ))  + i.x + vec4(0.0, i1.x, i2.x, 1.0 ));float n_ = 0.142857142857; vec3  ns = n_ * D.wyz - D.xzx;vec4 j = p - 49.0 * floor(p * ns.z * ns.z);  vec4 x_ = floor(j * ns.z);vec4 y_ = floor(j - 7.0 * x_ );    vec4 x = x_ *ns.x + ns.yyyy;vec4 y = y_ *ns.x + ns.yyyy;vec4 h = 1.0 - abs(x) - abs(y);vec4 b0 = vec4( x.xy, y.xy );vec4 b1 = vec4( x.zw, y.zw );vec4 s0 = floor(b0)*2.0 + 1.0;vec4 s1 = floor(b1)*2.0 + 1.0;vec4 sh = -step(h, vec4(0.0));vec4 a0 = b0.xzyw + s0.xzyw*sh.xxyy ;vec4 a1 = b1.xzyw + s1.xzyw*sh.zzww ;vec3 p0 = vec3(a0.xy,h.x);vec3 p1 = vec3(a0.zw,h.y);vec3 p2 = vec3(a1.xy,h.z);vec3 p3 = vec3(a1.zw,h.w);vec4 norm = taylorInvSqrt(vec4(dot(p0,p0), dot(p1,p1), dot(p2, p2), dot(p3,p3)));p0 *= norm.x;p1 *= norm.y;p2 *= norm.z;p3 *= norm.w;vec4 m = max(0.6 - vec4(dot(x0,x0), dot(x1,x1), dot(x2,x2), dot(x3,x3)), 0.0);m = m * m;return 42.0 * dot( m*m, vec4( dot(p0,x0), dot(p1,x1), dot(p2,x2), dot(p3,x3) ) );}

vec3 gnomeDarkStripes(in float t)
{
    // t 0 to 1 -> 1 to 0 to 1
    t = abs((mod(t, 1.0) * 2.0) - 1.0);

    vec3 a = vec3(0x24, 0x1F, 0x31) / 255.0;
    vec3 b = vec3(0x30, 0x22, 0x3B) / 255.0;
    vec3 c = vec3(0x4E, 0x25, 0x4A) / 255.0;
    vec3 d = vec3(0x56, 0x24, 0x4B) / 255.0;
    vec3 e = vec3(0x5F, 0x24, 0x4C) / 255.0;
    vec3 f = vec3(0x67, 0x23, 0x4D) / 255.0;
    vec3 g = vec3(0x70, 0x23, 0x4E) / 255.0;
    vec3 h = vec3(0x92, 0x1F, 0x48) / 255.0;
    vec3 i = vec3(0xAF, 0x24, 0x38) / 255.0;
    vec3 j = vec3(0xB3, 0x29, 0x31) / 255.0;
    vec3 k = vec3(0xB8, 0x2E, 0x2A) / 255.0;
    vec3 l = vec3(0xBC, 0x33, 0x23) / 255.0;
    vec3 m = vec3(0xC1, 0x38, 0x1D) / 255.0;
    vec3 n = vec3(0xC6, 0x46, 0x00) / 255.0;
    vec3 o = vec3(0xE6, 0x61, 0x00) / 255.0;

    float x = mod(t, 1.0); // * 15

    float y = 310.0 / 2810.0;
    if (x < y) return a;
    y += 310.0 / 2810.0;
    if (x < y) return b;
    y += 80.0 / 2810.0;
    if (x < y) return c;
    y += 80.0 / 2810.0;
    if (x < y) return d;
    y += 80.0 / 2810.0;
    if (x < y) return e;
    y += 80.0 / 2810.0;
    if (x < y) return f;
    y += 310.0 / 2810.0;
    if (x < y) return g;
    y += 310.0 / 2810.0;
    if (x < y) return h;
    y += 80.0 / 2810.0;
    if (x < y) return i;
    y += 80.0 / 2810.0;
    if (x < y) return j;
    y += 80.0 / 2810.0;
    if (x < y) return k;
    y += 80.0 / 2810.0;
    if (x < y) return l;
    y += 310.0 / 2810.0;
    if (x < y) return m;
    y += 310.0 / 2810.0;
    if (x < y) return n;

    return o;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
	vec2 uv = (fragCoord - iResolution.xy * .5) / iResolution.y;
    
    // for rendering to texture
    //
    // vec2(12.0, 9.23760430703);
    // * 13 or 80
    // vec2(960, 739.0083445624);
    // can render sdf to 960x739 texture
    //
    
    /*
    {
        vec2 size = vec2(6.75, Ratio30Deg * 10.0 + Ratio30Deg * 6.0);
        uv *= size;    
        uv += vec2(-2.0,0);
        
        float dist = infinitePattern(uv);
        
        //fragColor = vec4(vec3(dist * 2.0), 1.0);
        //return;
        
        dist -= 0.16;
        
        //vec2 ddist = vec2(dFdx(dist), dFdy(dist));
        //float pixelDist = dist / length(ddist);
        //float alpha = clamp(0.5 - pixelDist, 0.0, 1.0); 
        
        float alpha = dist < 0.0 ? 1.0 : 0.0;
        
        fragColor = vec4(vec3(alpha), 1.0);
        return;
    }
    */
    
    // testing

    /*
    {
        uv *= 24.0;    
        uv += vec2(-2.0,0);
        
        float dist = infinitePattern(uv);
    
        vec3 col = vec3(1.0) - sign(dist) * vec3(0.1, 0.4, 0.7);
        col *= 1.0 - exp(-3.0 * abs(dist));
        col *= 0.8 + 0.2 * cos(120.0 * dist);
        col = mix(col, vec3(1.0), 1.0 - smoothstep(0.0, 0.015, abs(dist)));

        fragColor = vec4(col, 1);
        return;
	}
    */
    
    uv *= 16.0;
	uv += vec2(iTime, sin(iTime * 0.5) * 0.5);

	float dist = infinitePattern(uv);
    dist -= 0.12;
    
    vec2 ddist = vec2(dFdx(dist), dFdy(dist));
    float pixelDist = dist / length(ddist);
    float alpha = clamp(0.5 - pixelDist, 0.0, 1.0); 

	float n = snoise(vec3(uv * 0.1, iTime * 0.1)) * 0.5 + 0.5;

	vec3 color = gnomeDarkStripes(n * 1.0);

	fragColor = vec4(mix(
        mix(vec3(gnomeDarkStripes(0.5)), vec3(0), 0.5),
        color,
        alpha
    ), 1.0);
  vec4 terminalColor = texture(iChannel0, q);
  fragColor = mix(fragColor, terminalColor, step(0.05, length(terminalColor.rgb)));
}
