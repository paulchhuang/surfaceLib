function RT = RTfromCloud(coords_s, coords_t, patching, corr_flag)
    if nargin < 3        
        RT = cell(1,2);
        
        num_ptr     = length(coords_s(:,1));
        data_s      = coords_s;   mean_s = mean(data_s);       
        data_t      = coords_t;   mean_t = mean(data_t);

        %% estimation of rotation matrix, ref: http://www.kwon3d.com/theory/jkinem/rotmat.html
        cross_cov   = (data_t'*data_s)/num_ptr - mean_t'*mean_s;
        [U,~,V]     = svd(cross_cov);
        R           = U*[1 0 0;0 1 0; 0 0 det(U*V')]*V';
        T           = mean_t - (R*mean_s')';

        %%
        RT{1,1}    = R;
        RT{1,2}    = T;
        
    elseif nargin==3
        num_P = max(patching) + 1;
        RT = cell(num_P,2);

        for pi = 1:num_P
            idx         = (patching==pi-1);
            num_ptr     = sum(idx);
            data_s      = coords_s(idx,:);   mean_s = mean(data_s);       
            data_t      = coords_t(idx,:);   mean_t = mean(data_t);

            %% estimation of rotation matrix, ref: http://www.kwon3d.com/theory/jkinem/rotmat.html
            cross_cov   = (data_t'*data_s)/num_ptr - mean_t'*mean_s;
            [U,~,V]     = svd(cross_cov);
            R           = U*[1 0 0;0 1 0; 0 0 det(U*V')]*V';
            T           = mean_t - (R*mean_s')';

            %%
            RT{pi,1}    = R;
            RT{pi,2}    = T;
        end
    else
        num_P = max(patching) + 1;
        RT = cell(num_P,2);

        for pi = 1:num_P
            idx         = (patching==pi-1) & corr_flag;
            num_ptr     = sum(idx);
            data_s      = coords_s(idx,:);   mean_s = mean(data_s);       
            data_t      = coords_t(idx,:);   mean_t = mean(data_t);

            %% estimation of rotation matrix, ref: http://www.kwon3d.com/theory/jkinem/rotmat.html
            cross_cov   = (data_t'*data_s)/num_ptr - mean_t'*mean_s;
            [U,~,V]     = svd(cross_cov);
            R           = U*[1 0 0;0 1 0; 0 0 det(U*V')]*V';
            T           = mean_t - (R*mean_s')';

            %%
            RT{pi,1}    = R;
            RT{pi,2}    = T;
        end
    end
end