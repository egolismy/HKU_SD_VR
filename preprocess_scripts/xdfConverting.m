% converting xdf file into set and fdt
% Aug 2021 Version
% Ziyi
fPathIn= 'D:\dataset\HKU\VR&EEG_Plot\EEG\RawData';
fPathOut= 'D:\dataset\HKU\VR&EEG_Plot\EEG\1_RawData';

fPathIn=fullfile('D:\dataset\HKU\VR&EEG_Plot\EEG\0_RawData');
  
fileNames=dir(fullfile(myDir,'*.xdf'));

eeglab

for i = 1:length(fileNames)
  baseFileName = fileNames(i).name;
  fullFileName = fullfile(fPathIn, baseFileName);
  fprintf(1, 'Now reading %s\n', fullFileName);
  % all of your actions for filtering and plotting go here
end

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
  EEG = pop_saveset( EEG, 'filename',fileName,'filepath','D:\\dataset\\HKU\\VR&EEG_Plot\\EEG\\1_RawData\\');
end
    



