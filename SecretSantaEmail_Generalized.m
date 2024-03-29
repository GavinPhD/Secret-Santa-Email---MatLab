clc
clear all

%Written by Gavin Hester, 2019.

%The code is designed to send emails to a variable number of people,
%assigning them to other people. DO NOT run this code without changing the
%emails for the people.

%% Email Preferences
%For this to work in Gmail you must allow less secure connections in gmail.
setpref('Internet','SMTP_Server','smtp.gmail.com');
%Your email goes below.
setpref('Internet','E_mail','myemail@gmail.com');
%Your username.
setpref('Internet','SMTP_Username','myemail');
%Your password.
setpref('Internet','SMTP_Password','password');
props = java.lang.System.getProperties;
props.setProperty('mail.smtp.auth','true');
props.setProperty('mail.smtp.socketFactory.class', 'javax.net.ssl.SSLSocketFactory');
props.setProperty('mail.smtp.socketFactory.port','465');



%% People being loaded in.
people = {};
test = 0; %If test = 1, will send out a test email to everyone. If test = 0,
% will send actual secret santa email.

%The first column in the matrix corresponds to someones name. The second
%corresponds to their email.
people{1,1} = 'Pikachu';
people{1,2} = 'fakeemail1@gmail.com';
people{2,1} = 'Charmander';
people{2,2} = 'fakeemail2@gmail.com';
people{3,1} = 'Bulbasaur';
people{3,2} = 'fakeemail3@gmail.com';
people{4,1} = 'Squirtle';
people{4,2} = 'fakeemail4@gmail.com';
people{5,1} = 'Articuno';
people{5,2} = 'fakeemail5@yahoo.com';
people{6,1} = 'Moltres';
people{6,2} = 'fakeemail6@gmail.com';

%Finding the number of people.
numPeople = size(people,1);
%A simple matrix to be used for comparison. The Gift Giver
numHolder = linspace(1, numPeople, numPeople);
%Generating the first set of assignments. The Gift Receivers
assignments = randperm(numPeople);


%This checks that no one is assigned to themselves and then regenerates
%this matrix if it
while any((numHolder(1:numPeople) == assignments(1:numPeople)) == 1 )
    assignments = randperm(numPeople);
end


%Sending email
for ii = 1:numPeople
    if ii ~= assignments(ii) && test == 0
        personName =  people{assignments(ii)}; %Grabs the gift receivers name.
        message = [people{ii,1}, ' your Secret Santa is ', personName, '.']; %Creates the message.
        reminder = 'DO NOT LOSE THIS EMAIL';
        %Below sends the email.
        sendmail(people{ii,2}, 'Secret Santa Assignment', [message, ' ', reminder])
    elseif test == 1
       message = 'Tell Blank you got this';
       sendmail(people{ii,2}, 'Secret Santa Test', message)
    end
end
clear all %keeps it anonymous.    






