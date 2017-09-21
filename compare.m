clear
deta_V=0.03;%the area difference between substrate and B layer
lattice_B=[6.0571999999999999    0.0000000000000000     0.0000000000000000    
    0.4660000000000000    8.8773999999999997    0.0000000000000000    
    0.0000000000000000    0.0000000000000000   22.0000000000000000
    6.0716479583388203    0.0000000000000000     0.0000000000000000
    1.1674135998390900   11.7300507026572909     0.0000000000000000
     0.0000000000000000    0.0000000000000000    22.0000000000000000  
     6.0644000000000000    0.0000000000000000   0.0000000000000000    
     1.6327000000000000   20.6040999999999990     0.0000000000000000    
     0.0000000000000000    0.0000000000000000   22.0000000000000000 ];%the  lattice of  B 2s 3s 23s 
 valum_B=[abs(det(lattice_B(1:2,1:2))) 2
                  abs(det(lattice_B(4:5,1:2))) 3
                  abs(det(lattice_B(7:8,1:2))) 23];%the area in xy plane
 lattice_Ag=[2.9463000298         0.0000000000         0.0000000000
        0.0000000000         2.9463000298         0.0000000000
        0.0000000000         0.0000000000        22.3334999084
        4.1666998863         0.0000000000         0.0000000000
        0.0000000000         2.9463000298         0.0000000000
        0.0000000000         0.0000000000        19.8927001953
        2.9463000298         0.0000000000         0.0000000000
       -1.4731500149         2.5515706729         0.0000000000
        0.0000000000         0.0000000000        23.6226997375];%the lattice of Ag 100 110 111 plane
valum_Ag=[abs(det(lattice_Ag(1:2,1:2))) 100
                          abs(det(lattice_Ag(4:5,1:2))) 110
                          abs(det(lattice_Ag(7:8,1:2))) 111];%the area in xy plane
  ratio=[];%the ratio to get similar area
 for ii=1:size(valum_B,1)
     for jj=1:size(valum_Ag,1)
         for n=1:32
             for m=1:64
                 if abs(n*valum_B(ii,1)-m*valum_Ag(jj,1))/min(n*valum_B(ii,1),m*valum_Ag(jj,1))<deta_V
                     ratio=[ratio;valum_B(ii,2)  valum_Ag(jj,2) n,m n*valum_B(ii,1) m*valum_Ag(jj,1)];%name(B)  name(Ag)  valume(B)  valume(Ag)  area 
                  end
             end
         end
     end
 end
 for kk=1:1%size(ratio,1)
     ratio(kk,2)
     direction_Ag=['/home/qiusb/Projects/runaba/find_superL_Ag/Ag',int2str(ratio(kk,2)),'/Ag_',int2str(ratio(kk,2)),'/SUPLAT_Ag_',int2str(ratio(kk,2)),'_',int2str(ratio(kk,4)),'/']
     fileFolder_Ag=fullfile(direction_Ag);
     dirOutput=dir(fullfile(fileFolder_Ag,'*'))
     message1=import_poscar([direction_Ag,dirOutput(3).name])
 end
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 