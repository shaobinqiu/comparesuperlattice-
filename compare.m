clear
deta_V=0.03;%the area difference between substrate and B layer
deta_L=1e-2;%the Lattice difference between substrate and B layer   (^2)
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
 U=[];
 number=1;%the number of suitable structures
 for kk=1:size(ratio,1)
     kk
     direction_B=['/home/qiusb/Projects/runaba/find_superL_Ag/B_',int2str(ratio(kk,1)),'s/B_',int2str(ratio(kk,1)),'s/SUPLAT_B_',int2str(ratio(kk,1)),'s_',int2str(ratio(kk,3)),'/'];
     fileFolder_B=fullfile(direction_B);
     dirOutput_B=dir(fullfile(fileFolder_B,'*'));%get the filename in direction
     direction_Ag=['/home/qiusb/Projects/runaba/find_superL_Ag/Ag',int2str(ratio(kk,2)),'/Ag_',int2str(ratio(kk,2)),'/SUPLAT_Ag_',int2str(ratio(kk,2)),'_',int2str(ratio(kk,4)),'/'];
     fileFolder_Ag=fullfile(direction_Ag);
     dirOutput_Ag=dir(fullfile(fileFolder_Ag,'*'));%get the filename in direction
     
     for ll=3:size(dirOutput_B,1)
         message_B=import_poscar([direction_B,dirOutput_B(ll).name]);
         lattice_B=message_B.lattice;
         for pp=3:size(dirOutput_Ag,1)
             message_Ag=import_poscar([direction_Ag,dirOutput_Ag(pp).name]);
             lattice_Ag=message_Ag.lattice;
             u=lattice_Ag/lattice_B;
             dif =u-round(u);
             if dif(1,1)^2<deta_L  && dif(1,2)^2<deta_L  &&  dif(1,3)^2<deta_L  &&  dif(2,1)^2<deta_L  &&  dif(2,2)^2<deta_L  &&  dif(2,3)^2<deta_L  &&  dif(3,1)^2<deta_L  &&  dif(3,2)^2<deta_L  &&  dif(3,3)^2<deta_L   &&  abs((sum(u(1,:).^2))-1)<deta_L  &&  abs((sum(u(2,:).^2))-1)<deta_L  &&  abs((sum(u(3,:).^2))-1)<deta_L  ; 
                 U=[U;u];
                 filedirname=['/home/qiusb/Projects/runaba/find_superL_Ag/suitablestructers/','collection_B',int2str(ratio(kk,1)),'s_Ag',int2str(ratio(kk,2)),'_',int2str(number)];
                 mkdir(filedirname );
                 copyfile([direction_B,dirOutput_B(ll).name],  filedirname);
                 copyfile([direction_Ag,dirOutput_Ag(pp).name], filedirname);
                 number=number+1;
             end
             
             
         end
     end
 end
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 