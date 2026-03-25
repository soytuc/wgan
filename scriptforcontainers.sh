for i in {0..7};do docker exec -e PORTROS=$i imageservice$i bash -c "/root/runservices.sh"
