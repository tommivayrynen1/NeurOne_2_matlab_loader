%OPEN BINARY NeurOne Brain Vision Data exports (IEEE_float_32) in matlab.
% input: 'filename.eeg'; output raw,srate

function [raw,srate] = load_neurone(filename)

filename_eeg = string(filename);
filename_eeg = strsplit(filename_eeg,'.');filename_eeg = filename_eeg{1,1};

    fid = fopen(sprintf('%s.vhdr',filename_eeg));
    istring = fscanf(fid,'%s');
    fclose(fid);   
    dataformat = strsplit(istring,'DataFormat=');
    dataformat = strsplit(dataformat{1,2},'D');dataformat=string(dataformat{1,1});
    
    if dataformat == 'BINARY'
        chan_lkm = strsplit(istring,'NumberOfChannels=');
        chan_lkm= strsplit(chan_lkm{1,2},'SamplingInterval');chan_lkm=str2num(chan_lkm{1,1});

        orientation = strsplit(istring,'DataOrientation=');
        orientation = strsplit(orientation{1,2},'DataType');orientation=string(orientation{1,1});

        samplinginter = strsplit(istring,'SamplingInterval=');
        samplinginter = strsplit(samplinginter{1,2},'[');samplinginter=str2num(samplinginter{1,1});
        srate = 1000000 / samplinginter;

         if orientation == 'MULTIPLEXED'
         a = fopen(sprintf('%s.eeg',filename_eeg));
         raw = fread(a,[chan_lkm inf],'float32');
         raw = raw.*0.001; % convert units to microvolts.
         fclose(a);
         end
    end

end
