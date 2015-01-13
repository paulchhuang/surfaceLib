function mesh = loadOff(filename,colorFlag)
mesh.name = filename;
mesh_tmp = importdata(mesh.name);
mesh.numV = mesh_tmp.data(1,1);  
mesh.numT = mesh_tmp.data(1,2);

%% color mesh or not?
if colorFlag
    idx_v = 2:3:(2+(mesh.numV-1)*3);
    idx_T = idx_v(end)+3:2:(idx_v(end)+3+2*(mesh.numT-1));
    mesh.colors = mesh_tmp.data(idx_v+1,:);
else       
    idx_v = 2:1:(2+(mesh.numV-1)*1);   
    idx_T = idx_v(end)+1:2:(idx_v(end)+1+2*(mesh.numT-1));
end

%%  
    mesh.coords = mesh_tmp.data(idx_v,:);    
    mesh.tri = mesh_tmp.data(idx_T,2:3);
    mesh.tri = [mesh.tri mesh_tmp.data(idx_T+1,1)] + 1;    