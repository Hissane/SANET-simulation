BEGIN {
       reno_sent_pkt = 0
       vegas_sent_pkt = 0
       reno_rcv_pkt = 0
       vegas_rcv_pkt = 0
       startTime = 50
       stopTime = 350
       reno_arrival_rate = 0
       vegas_arrival_rate = 0
  }
   
  {
             event = $1
             time = $2
             node_id = $3
             pkt_type = $6
             level = $4
   

  # for sent
  if (startTime <= time && time <= stopTime && event == "s" && pkt_type == "tcp" ) {
      if(node_id == 0 || node_id == 2 ){
          reno_sent_pkt++
      }
      if(node_id == 1 || node_id == 3 ){
          vegas_sent_pkt++
      }
  }

  # for received packets
  if (startTime <= time && time <= stopTime && event == "r" && pkt_type == "tcp") {
      if(node_id == 0 || node_id == 2 ){
          reno_rcv_pkt++
      }
      if(node_id == 1 || node_id == 3 ){
          vegas_rcv_pkt++
      }     
  }


  ### awk -f script.awk sanet.tr
  ###ajouter des courbes, evolution, taille du packet
  ##reno + vegas 
  ## reno + reno 
  ## vegas + vegas 
  ## reno l'emporte sur vegas ??
  }
   
  END {
      reno_arrival_rate = (reno_rcv_pkt / reno_sent_pkt)*100
      vegas_arrival_rate = (vegas_rcv_pkt / vegas_sent_pkt)*100
      
      printf("Reno arrival rate = %f \n", reno_arrival_rate)
      printf("Reno arrival rate = %f \n", vegas_rcv_pkt)     
  }
