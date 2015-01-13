function [VtxNormals, TriNormals] = avgNormal(coords, triangles)

    numVertex = length(coords(:,1));
    VtxNormals = zeros(size(coords));
    
    
    %% method 1
    V1_V0 = coords(triangles(:,2),:) - coords(triangles(:,1),:);
    V2_V0 = coords(triangles(:,3),:) - coords(triangles(:,1),:);
    TriNormals = cross(V1_V0,V2_V0,2);
    
    for v = 1:numVertex
        VtxNormals(v,:) = sum(TriNormals(sum(triangles == v,2) > 0,:),1);
    end
    
%     %% method 2
%     numTri = length(triangles(:,1));
%     TriNormals = zeros(size(triangles));
%     for t = 1:numTri
%         v0 = coords(triangles(t,1),:);
%         v1 = coords(triangles(t,2),:);
%         v2 = coords(triangles(t,3),:);
%         TriNormals(t,:) = cross(v1 - v0, v2 - v0);
%         VtxNormals(triangles(t,1),:) = VtxNormals(triangles(t,1),:) + TriNormals(t,:);
%         VtxNormals(triangles(t,2),:) = VtxNormals(triangles(t,2),:) + TriNormals(t,:);
%         VtxNormals(triangles(t,3),:) = VtxNormals(triangles(t,3),:) + TriNormals(t,:);
%     end
    %% normalization
    VtxNormals = VtxNormals./repmat(sqrt(sum(VtxNormals.^2,2)),[1 3]);
    TriNormals = TriNormals./repmat(sqrt(sum(TriNormals.^2,2)),[1 3]);
    
