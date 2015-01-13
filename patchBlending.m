function Y_new  = patchRenderingBlend(coords, centers, RT, patching, sadj, distVar)
    
    numV        = length(coords(:,1));
    numP        = length(centers(:,1));

    Y_new       = zeros(numV,3);
    coords_patch= zeros(numV,3);


    for pi = 1:numP
        coords_patch(patching==pi-1,:) = coords(patching==pi-1,:) - repmat(centers(pi,:),[sum(patching==pi-1) 1]);
    end
    
    for pi = 1:numP

        sadj_pi             = sadj{pi};
        num_Neighbors_pi    = length(sadj_pi);
        
        %% determine the weights
        coords_tmp          = coords_patch(patching==pi-1,:);
        w = exp(-dot(coords_tmp,coords_tmp,2)/distVar);

        for ni = 1:num_Neighbors_pi
            coords_tmp      = coords(patching==pi-1,:) - repmat(centers(sadj_pi(ni),:),[sum(patching==pi-1) 1]);        
            w               = [w exp(-dot(coords_tmp,coords_tmp,2)/distVar)];        
        end

        w = w./repmat(sum(w,2),[1 num_Neighbors_pi+1]);

        %% blend: self
        try
            Y_new(patching==pi-1,:) = repmat(w(:,1),[1 3]).*((RT{pi,1}*coords(patching==pi-1,:)')' + repmat( RT{pi,2},[sum(patching==pi-1) 1]));
        catch            
            display(['sth wrong in the RT, patch #: ' num2str(pi)]);
        end
        %% blend: neighbors
        for ni = 1:num_Neighbors_pi
            try
                Y_new(patching==pi-1,:) = Y_new(patching==pi-1,:) + repmat(w(:,ni+1),[1 3]).*((RT{sadj_pi(ni),1}*coords(patching==pi-1,:)')' + repmat(RT{sadj_pi(ni),2},[sum(patching==pi-1) 1]));
            catch                
                display(['sth wrong in the RT, patch : ' pi ', neighborhood: ' sun2str(sadj_pi(ni))]);
            end
        end
    end
