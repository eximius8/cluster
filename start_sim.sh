hostt=$(hostname)
for i in $(seq 0 $((${#state}/6-1)))
do 
  loadtext="'dim 3 setup 2000 setpf 0.${state:$((i*6)):2} SIG 1.1547 EPS ${state:$((i*6+2)):4} iter 100 epsS 0 multiple 40'"
  savetext="Super_comp_setpf_0.${state:$((i*6)):2}_eps_${state:$((i*6+2)):4}.pos_$hostt"
  echo ${loadtext} | ./bin/EDMD3d >  ${savetext} &   
done
wait

