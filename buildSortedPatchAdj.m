function sadj = buildSortedPatchAdj(patching, tri)
    num_P = max(patching)+1;
    num_T = length(tri(:,1));
    
    sadj = cell(num_P,1);
    patch_vertex_triangleForm = patching(tri) + 1;
    
    for ti = 1:num_T
        patch_tri_i  = patch_vertex_triangleForm(ti,:);
        patch_idx    = unique(patch_tri_i);
        num_P_ti     = numel(patch_idx);
        if  num_P_ti > 1
            for vi = 1:num_P_ti
                patch_idx_vi        = patch_idx(vi);
                neighbors_idx       = (patch_tri_i~=patch_idx_vi);
                old_neighbors       = sadj{patch_idx_vi};
                new_neighbors       = unique([old_neighbors patch_tri_i(neighbors_idx)]);
                sadj(patch_idx_vi)  = {new_neighbors};
            end
        end
        
    end
end