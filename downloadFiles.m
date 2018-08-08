%% This script will pings the free music archive and downloads all the files
%I need. Using the Free Music Archive API

clc; clear;
%% Setup: edit these params
API_Key = 'CFEFES9JPKBN4T7H';
%this query gets the tracks
api_url = 'https://freemusicarchive.org/api/get/';
typeOfQuery = 'tracks.json?api_key='; %other possible queries are albums, genres, curators, etc

%num of mp3s we want to download
numToDownload = 1000;

%POSSIBLE PARAMETERS
%these IDs were found manually by me using a webserver
classicalID = 5;
hipHopID = 21;
%this is the 'child' id under hipHop. if we want to specifically look at
%rap
rapID = 539;

numPerPage = num2str(50);
genre_id = num2str(hipHopID);

%% make the url and download all the files
base_url = strcat(api_url, typeOfQuery, API_Key, '&limit=' ,numPerPage, ...
        '&genre_id=', genre_id);

data = webread(base_url);
data = jsondecode(data);

totalResults = data.total;
totalPages = data.total_pages;

numPerPage = str2double(numPerPage);
numDownloaded = 0;

options = weboptions('Timeout', 30);
for i = 9:totalPages
    pageNum = num2str(i);
    url = strcat(base_url, '&page=',pageNum);
    data = webread(url, options);
    data = jsondecode(data);
    
    for j = 1:numPerPage
        duration = str2double(data.dataset(j).track_duration(1:2));
        if(duration(1) > 1)
            continue;
        end
        download_url = strcat(data.dataset(j).track_url, '/download');
        stat = web(download_url, '-browser');
        pause(5);
        r = sprintf(strcat('downloaded file num= ' , num2str(numDownloaded)), '/n');
        disp(r);
        if(stat == 0)
            numDownloaded = numDownloaded+1;
        end
    end
    
    if numDownloaded == numToDownload
        break;
    end
end

%downloads using chrome; set the default download location using chrome

