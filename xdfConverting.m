% converting xdf file into set and fdt
% Aug 2021 Version
% Ziyi
fPathIn= 'D:\dataset\HKU\VR&EEG_Plot\EEG\RawData';
fPathOut= 'D:\dataset\HKU\VR&EEG_Plot\EEG\1_RawData';

fPathIn=fullfile('D:\dataset\HKU\VR&EEG_Plot\EEG\0_RawData');
  
fileNames=dir(fullfile(fPathIn,'*.xdf'));

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
  
  EEG=pop_chanedit(EEG, 'load',{'C:\\Users\\Administrator\\HKU_SD_VR\\preprocess_scripts\\smartinglocation.ced' 'filetype' 'autodetect'});
  [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
  EEG = pop_saveset( EEG, 'filename',fileName,'filepath','D:\\dataset\\HKU\\VR&EEG_Plot\\EEG\\1_RawData\\');
end
    
eeglab redraw



