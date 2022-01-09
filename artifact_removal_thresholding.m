function outsig = artifact_removal_thresholding(insig, f_s, threshold, artefact_len)

    % disp(threshold)
    % odstrani artefakte --> kjer signal presega threshold
    
    artefact_indices = [];
    sig_len = length(insig);

    for i = 1 : sig_len
        
        if abs(insig(i)) > abs(threshold)
            artefact_start = i - (artefact_len/2 - 1);
            artefact_end = i + (artefact_len/2);   
            
            if artefact_start < 1
                artefact_start = 1;
            end
            
            if artefact_end > sig_len
                artefact_start = sig_len;
            end            
            
            for j = artefact_start : artefact_end
               insig(j) = 0;
               artefact_indices(end + 1) = j;
            end
             
        end
        
    end
        
    insig(artefact_indices) = [];
    outsig = insig;
end
            
    
    