function batchToVisualWords(numCores, dictionaryName) 

% Does parallel computation of the visual words 
%
% Input:
%   numCores - number of cores to use (default 2)

if nargin < 1
    %default to 2 cores
    numCores = 2;
end

% Close the pools, if any
try
    fprintf('Closing any pools...\n');
%     matlabpool close; 
    delete(gcp('nocreate'))
catch ME
    disp(ME.message);
end

fprintf('Starting a pool of workers with %d cores\n', numCores);
% matlabpool('local',numCores);
parpool('local', numCores);

%load the files and texton dictionary
load('traintest.mat','all_imagenames','mapping');
if strcmp(dictionaryName, 'random')
    load('dictionaryRandom.mat','filterBank','dictionary');
elseif strcmp(dictionaryName, 'harris')
    load('dictionaryHarris.mat','filterBank','dictionary');
elseif strcmp(dictionaryName, 'randomGabor')
    load('../ec/dictionaryRandomGabor.mat', 'dictionary')
end

source = '../data/';
if strcmp(dictionaryName, 'random')
    target = '../data/dictionaryRandom/'; 
elseif strcmp(dictionaryName, 'harris')
    target = '../data/dictionaryHarris/'; 
elseif strcmp(dictionaryName, 'randomGabor')
    target = '../data/dictionaryRandomGabor/';
    addpath('../ec/');
    n_scales = 5;
    n_orients = 8;
    r = 39;
    c = 39;
    gaborArray = gaborFilterBank(n_scales, n_orients, r, c);
    filterBank = cell(n_scales * n_orients,1);
    for i = 1:length(gaborArray)
        filterBank{i} = gaborArray(1, i).FFTkernel;
    end
end

if ~exist(target,'dir')
    mkdir(target);
end

for category = mapping
    if ~exist([target,category{1}],'dir')
        mkdir([target,category{1}]);
    end
end

%This is a peculiarity of loading inside of a function with parfor. We need to 
%tell MATLAB that these variables exist and should be passed to worker pools.
filterBank = filterBank;
dictionary = dictionary;

%matlab can't save/load inside parfor; accumulate
%them and then do batch save
l = length(all_imagenames);

wordRepresentation = cell(l,1);
parfor i=1:l
    fprintf('Converting to visual words %s\n', all_imagenames{i});
    image = imread([source, all_imagenames{i}]);
    wordRepresentation{i} = getVisualWords(image, filterBank, dictionary);
end

%dump the files
fprintf('Dumping the files\n');
for i=1:l
    wordMap = wordRepresentation{i};
    save([target, strrep(all_imagenames{i},'.jpg','.mat')],'wordMap');
end

%close the pool
fprintf('Closing the pool\n');
%matlabpool close

end
