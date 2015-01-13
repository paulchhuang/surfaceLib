function visualizeSklColor(coords, vjLabel)

if exist('COLORCODE','var')
else
    load Color_Parents
end

for i = unique(vjLabel)' 
    plot3(coords(vjLabel==i,1),coords(vjLabel==i,2),coords(vjLabel==i,3),'.','Color',COLORCODE(unique(vjLabel)==i,:)/255);
    hold on;    
end 