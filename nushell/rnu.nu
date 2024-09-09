def rnu [searchStr] {
  rg -n $searchStr | lines | each {|line|  split column ":" file_name number file_line}
}
