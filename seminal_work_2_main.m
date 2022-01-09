% physionetdb('eegmmidb');
% [success, files] = wfdbdownload('mitdb/102');
% [sigs, freq, tm] = rdsamp('mitdb/100');
% intvl=1:360;
% plot(tm(intvl), sigs(intvl,1));

artifact_removal_filtering_and_thresholding('database/eegmidb/S001R03.edf', 22);

function artifact_removal_filtering_and_thresholding(filedir, electrode_num)

    artefact_len = 6;
    tiledlayout(3,1);

    [sigs, freq, tm] = rdsamp(filedir);

    % 22 and 24 are frontal electrodes
    insig = sigs(:, electrode_num);

    % input signal
    nexttile;
    plot(tm(1:length(insig)), insig(1:length(insig))); 
    ylim([-500, 500]);
    title('Vhodni signal');

    sig_filtered = artifact_removal_filtering(insig, freq);

    threshold = find_artefact_threshold(sig_filtered);
    disp("calculated threshold: " + threshold);
    % threshold = 150;

    % filtered signal
    nexttile;
    plot(tm(1:length(sig_filtered)), sig_filtered(1:length(sig_filtered))); 
    ylim([-500, 500]);
    title('Filtriran signal');

    sig_thresholded = artifact_removal_thresholding(sig_filtered, freq, threshold, artefact_len);

    % filtered and thresholded signal
    nexttile;
    plot(tm(1:length(sig_thresholded)), sig_thresholded(1:length(sig_thresholded))); 
    ylim([-500, 500]);
    title('Filtriran signal z odstranjenimi artefakti');
    
    hold on;
end