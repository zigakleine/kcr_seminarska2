function threshold_val = find_artefact_threshold(insig)

    epochs = 60;
    epoch_len = 125;

    if length(insig) > (epochs*epoch_len)
        epochs = 60;
    else
        epochs = floor(length(insig)/125);
    end

        insig_to_use = abs(insig(1:(epochs*epoch_len)));

        sig_split = reshape(insig_to_use, epoch_len, []);

        epoch_means= mean(sig_split);
        epoch_standard_deviations = std(sig_split);
        
       
        [max_val, max_index] = max(epoch_standard_deviations);
        [min_val, min_index] = min(epoch_standard_deviations);

        threshold_val = (epoch_means(min_index) + epoch_means(max_index))/2;
end
    