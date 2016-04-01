(: Extract RACI information from ArchiMate :)

declare namespace xsi = "http://www.w3.org/2001/XMLSchema-instance";
declare namespace archimate = "http://www.archimatetool.com/archimate";
<html>
  <head>
    <title>RACI matrix for {//archimate:model/@name/data()}</title>
    <link href="raci.css" rel="stylesheet" />
  </head>
  <body>
  <table>{
let $rels := //element[@xsi:type = "archimate:AssignmentRelationship"]

(: Only include roles that have an assignment :)
let $roles := 
  for $r in //element[@xsi:type = "archimate:BusinessRole"][@id = $rels/@source]
  return <role>{$r/@id, $r/@name, $r/documentation/text()}</role>
let $roleIDs := $roles/@id
let $processes := //element[@xsi:type = "archimate:BusinessProcess"]
let $functions := //element[@xsi:type = "archimate:BusinessFunction"]

(: Header row: process/function name, role names :)
let $header_row := 
  <tr>
    <th>Process or function name</th>
    {for $role_name in $roles/@name
     return <th class="role">{$role_name/data()}</th>}
  </tr>

let $process_rows :=
  for $process in $processes
  let $process_id := $process/@id
  
  let $prelt := 
    for $role in $roles
    let $assignment := $rels[@source = $role/@id][@target = $process_id]
    let $relname := 
      if ($assignment/@name)
      then $assignment/@name/data()
      else if ($assignment)
        then "X"
        else ()
    let $raci_code := 
      if ($assignment/property[@key="RACI"])
      then concat("(", $assignment/property[@key="RACI"]/@value/data(), ")")
      else ()
    return <td>{$relname, $raci_code}</td>
  
    
  return <tr><td>P: {$process/@name/data()}</td>{$prelt}</tr>

let $function_rows :=
  for $function in $functions
  let $function_id := $function/@id
  
  let $prelt := 
    for $role in $roles
    let $assignment := $rels[@source = $role/@id][@target = $function_id]
    let $relname := 
      if ($assignment/@name)
      then $assignment/@name/data()
      else if ($assignment)
        then "X"
        else ()
    
    return <td>{$relname}</td>
  
    
  return <tr><td>F: {$function/@name/data()}</td>{$prelt}</tr>

return ($header_row, $process_rows, $function_rows)
}</table>
</body>
</html>
