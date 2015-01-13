function writeOff(varargin)
    filename    = varargin{1};
    coords      = varargin{2};
    triangles   = varargin{3};
    if length(varargin)==4
        color = varargin{4};
        assert(length(color(:,1))==length(coords(:,1)));
    end
    num_V = length(coords(:,1));
    num_T = length(triangles(:,1));

    %%
    
    fid = fopen(filename,'w');
    if(nargin==4)
        
        fprintf(fid,'%s\n','COFF');
        fprintf(fid,'%d %d %d\n',[num_V num_T 0]);
        for vi = 1:num_V
            fprintf(fid,'%.8g %.8g %.8g %.8g %.8g %.8g %d\n',[coords(vi,:) color(vi,:) 255]);
        end
        for ti = 1:num_T
            fprintf(fid,'%d %d %d %d\n',[3 triangles(ti,:)-1]);
        end
    else
    
        fprintf(fid,'%s\n','OFF');
        fprintf(fid,'%d %d %d\n',[num_V num_T 0]);
        for vi = 1:num_V
            fprintf(fid,'%.8g %.8g %.8g\n',coords(vi,:));
        end
        for ti = 1:num_T
            fprintf(fid,'%d %d %d %d\n',[3 triangles(ti,:)-1]);
        end
        
    end
    fclose(fid);
end