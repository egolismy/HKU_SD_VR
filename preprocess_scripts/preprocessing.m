% converting xdf file into set and fdt
% Aug 2021 Version
% Ziyi
fPathIn= 'D:\dataset\HKU\VR&EEG_Plot\EEG\1_RawData';
fPathOut= 'D:\dataset\HKU\VR&EEG_Plot\EEG\2_FilteredData';
% declare input and output path

fPathIn=fullfile('D:\dataset\HKU\VR&EEG_Plot\EEG\1_RawData');
fileNames=dir(fullfile(fPathIn,'*.set'));
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
  
  
  [ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
  EEG = pop_loadset('filename',inFileName,'filepath','D:\\dataset\\HKU\\VR&EEG_Plot\\EEG\\1_RawData\\');
  [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
  EEG = eeg_checkset( EEG );
  
  EEG=pop_chanedit(EEG, 'load',{'C:\\Users\\Administrator\\HKU_SD_VR\\preprocess_scripts\\smartinglocation.ced' 'filetype' 'autodetect'});
  % import channel location
  
  EEG = pop_resample( EEG, 256);
  % resampling dataset to 256 Hz
  
  EEG = pop_eegfiltnew(EEG, 'locutoff',1);
  [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off'); 
  % high pass filter 1 Hz
  
  EEG = pop_clean_rawdata(EEG, 'FlatlineCriterion',5,'ChannelCriterion',0.8,'LineNoiseCriterion',4,'Highpass','off','BurstCriterion',20,'WindowCriterion',0.25,'BurstRejection','on','Distance','Euclidian','WindowCriterionTolerances',[-Inf 7] );
  % apply clean_rawdata
  
  [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
  EEG = pop_saveset( EEG, 'filename',fileName,'filepath','D:\\dataset\\HKU\\VR&EEG_Plot\\EEG\\2_FilteredData\\');
end
    
eeglab redraw



