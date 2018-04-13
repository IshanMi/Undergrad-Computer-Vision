clc
clear all
close all

tic
Database = imageSet('db', 'recursive'); % Import several images at once

criminal_id = 1;
random_int = round(rand*10); 

ensemble = read(Database(criminal_id),1);
figure;
for i = 1:size(Database,2)
    mugshots(i) = Database(i).ImageLocation(random_int);
end




[practise_set, test_set] = partition(Database, [0.8,0.2]); % Significant errors upon using a training size less than 75% of DB.

criminal_id = round(rand*10);
[~, vplot] = extractHOGFeatures(read(practise_set(criminal_id),1)); % HoG features for the face you input.

subplot(1,2,1); imshow(ensemble); % This is the person you're looking to find in your database.
title('The Accused')
subplot(1,2,2); montage(mugshots); % This is all the people you're trying to find the person amongst.
title('The Suspects')


figure

%{
subplot(1,2,1); 
imshow(read(practise_set(Suspect_index),1)); 
title('Suspect Face');

subplot(1,2,2); 
plot(vplot); 
title('Corresponding HoG Features');
%}
relevant_features = zeros(size(practise_set,2)*practise_set(1).Count,12*390);
C = 1;

for i = 1:size(practise_set,2)
    for j = 1:practise_set(i).Count
        relevant_features(C,:) = extractHOGFeatures(read(practise_set(i),j)); %training is the first 80% of your database.
        annotation{C} = practise_set(i).Description;
        C = C + 1;
    end
    PI{i} = practise_set(i).Description;
end


Classifier = fitcecoc(relevant_features,annotation); % ECOC = Error-Correcting Output Code (Multiclass Model):
% Reduces the problem of classification with 3 or more classes to a set of binary classifiers

criminal_id = 1;
Suspect = read(test_set(criminal_id),1);
HOGF = extractHOGFeatures(Suspect);
name = predict(Classifier,HOGF);

consensus = strcmp(name, PI); % binary value
binary = find(consensus); % Number of non-zero entries in Comparison

subplot(1,2,1);
imshow(Suspect);
title('Our Suspect');

subplot(1,2,2);
imshow(read(practise_set(binary),1));
title('Suspect Matched with: ');

figure;
plot_num = 1;
for criminal_id = 1:40 % size of database
    for j = 1:test_set(criminal_id).Count
        Suspect = read(test_set(criminal_id),j); % Try running one time using the entire ATT_Facial_Database
        HOGF = extractHOGFeatures(Suspect);
        name = predict(Classifier,HOGF);
        
        consensus = strcmp(name, PI);
        binary = find(consensus);
        
        subplot(2,2,plot_num);
        imshow(imresize(Suspect,3));
        title('Suspect');
        
        subplot(2,2,plot_num+1);
        imshow(imresize(read(practise_set(binary),1),3));
        title('Matched');
        
        plot_num = plot_num+2;
        
    end
    figure;
    plot_num = 1;
end
close
toc