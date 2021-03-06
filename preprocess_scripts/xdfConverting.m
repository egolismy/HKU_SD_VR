% HUK_SD_VR Preprocessing
% Aug 2021 Version
% Ziyi
fPathIn= 'D:\dataset\HKU\VR&EEG_Plot\EEG\0_RawData';
fPathOut= 'D:\dataset\HKU\VR&EEG_Plot\EEG\1_PreprocessedData';
% declare input and output path

fPathIn=fullfile('D:\dataset\HKU\VR&EEG_Plot\EEG\0_RawData');
fileNames=dir(fullfile(fPathIn,'*.xdf'));
% get names of datasets

eeglab


for i = 1:length(fileNames)
  baseFileName = fileNames(i).name;
  
  dotLocations = find(baseFileName == '.');
  if isempty(dotLocations)
      fileName = baseFileName;
  else
      fileName = baseFileName(1:dotLocations(1)-1);
  end

  inFileName = fullfile(fPathIn, baseFileName);
  outFileName = fullfile(fPathOut, baseFileName);
  fprintf(1, 'Now reading %s\n', inFileName);
  EEG = pop_loadxdf(inFileName , 'streamtype', 'EEG', 'exclude_markerstreams', {});
  [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 0,'setname',baseFileName,'gui','off'); 
  EEG = eeg_checkset( EEG );
  % converting xdf files to set
  
  EEG = pop_resample( EEG, 256);
  % resampling to 256 Hz
  
  EEG=pop_chanedit(EEG, 'load',{'C:\\Users\\Administrator\\HKU_SD_VR\\preprocess_scripts\\smartinglocation.ced' 'filetype' 'autodetect'});
  % read channel location file
  % change file path needed
  
  EEG = pop_eegfiltnew(EEG, 'locutoff',1);
  % high-pass filter
  
  EEG = pop_clean_rawdata(EEG, 'FlatlineCriterion',5,'ChannelCriterion',0.8,'LineNoiseCriterion',4,'Highpass','off','BurstCriterion',20,'WindowCriterion',0.25,'BurstRejection','on','Distance','Euclidian','WindowCriterionTolerances',[-Inf 7] );
  % apply clean_rawdata
  
  [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
  EEG = pop_saveset( EEG, 'filename',fileName,'filepath',fPathOut);
  
  eeglab redraw
end
    



