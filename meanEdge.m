function [meanEL, stdEL] = meanEdge(coords,tri)
    E1  = coords(tri(:,1),:)-coords(tri(:,2),:);
    E2  = coords(tri(:,2),:)-coords(tri(:,3),:);
    E3  = coords(tri(:,3),:)-coords(tri(:,1),:);
    
    EL1 = sqrt(sum(E1.^2,2));
    EL2 = sqrt(sum(E2.^2,2));
    EL3 = sqrt(sum(E3.^2,2));
    
    meanEL = mean([EL1/2;EL2/2;EL3/2]);
    stdEL = std([EL1/2;EL2/2;EL3/2]);
end