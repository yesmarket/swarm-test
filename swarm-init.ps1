$json = (Get-Content "nodes.json" -Raw) | ConvertFrom-Json
$nodes = $json | Select -ExpandProperty ip
foreach ($node in $nodes) {
   $Env:DOCKER_HOST = "tcp://$node`:2376"
   docker swarm leave --force
}
$manager = $json | where { $_.name -like "manager*" } | Select -ExpandProperty ip
$Env:DOCKER_HOST = "tcp://$manager`:2376"
iex -Command "docker swarm init --advertise-addr $manager"
$token = docker swarm join-token worker -q
$workers = $json | where { $_.name -like "worker*" } | Select -ExpandProperty ip
foreach ($worker in $workers) {
   $Env:DOCKER_HOST = "tcp://$worker`:2376"
   iex -Command "docker swarm join --token $token $manager`:2377"
}
$Env:DOCKER_HOST = "tcp://$manager`:2376"
