texx=""
time="19:00:00"
j=0
for setpf in  $(awk 'BEGIN{ for (i=46; i < 53.5; i+=1) printf("%.0f\n", i); }')
do
  for liam in $(awk 'BEGIN{ for (i=0.5; i < 5.01; i+=0.5) printf("%.2f\n", i); }')
  do
    if [ ${#texx} -eq "18" ]
    then
      qsub -N EDmd$(printf %02d ${j}) \
           -o "job$(printf %02d $j).out" \
           -e "job$(printf %02d $j).er" \
           -l nodes=1:ppn=4:any \
           -l walltime=${time} \
           -v state="${texx}" \
           ./start_sim.sh &
      texx=${setpf}${liam}
    else
      texx=${texx}${setpf}${liam}
    fi
    j=$((j+1))
  done
done

qsub -N EDmdLast \
     -o "jobLast.out" \
     -e "jobLast.er" \
     -l nodes=1:ppn=4:any \
     -l walltime=${time} \
     -v state="${texx}" \
     ./start_sim.sh &
