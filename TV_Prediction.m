% This code analyzes the total variation (Eq. (1)) and performs the prediction under
% equations (5) and (6), respectively. Note that for lambda = 0, the
% framework boils down to a linear regression. 

clc; 
clear all;
close all;

%% input

Group = 1; % can be 1,2,3,4,5 or 6 representing the six different groups
lambda = 0.004; % Regularization parameter in equations (5) and (6) selected using model selection approaches (e.g., leave-one-out)

%% Reading files and analyzing TV

n_promt = 5; % Number of prompts
TV_cont = zeros(n_promt,1); % Total Variation accross the network

hhh = strcat('group',num2str(Group),'/group',num2str(Group));
ggg = strcat(hhh,'_rating_table.csv');
iii = strcat(hhh,'_prompt1.csv');
cont_ratings = csvread(ggg,1,0); % Ratings for different prompts
cont_1 = csvread(iii,1,0); % Interactions
max_id = max(cont_ratings(:,1)); % maximum user ID
A_cont_1 = zeros(max_id,max_id);
x = size(cont_1);
m_cont_1 = x(1,1); % Number of edges
for i = 1:m_cont_1
    A_cont_1(cont_1(i,1),cont_1(i,2)) = cont_1(i,3);
end
A_cont_1 = (A_cont_1 + A_cont_1'); % Adjacency Matrix of the group in prompt 1
L_cont_1 = diag(A_cont_1 * ones(max_id,1)) - A_cont_1; % Laplacian Matrix
x_cont_1 = zeros(max_id,1);% Ratings vector of the group
x = size(cont_ratings);
n_users = x(1,1); % Number of users
for i = 1:n_users
    x_cont_1(cont_ratings(i,1)) = cont_ratings(i,2);
end
TV_cont(1) = x_cont_1' * L_cont_1 * x_cont_1; % Total variation  in prompt 1


iii = strcat(hhh,'_prompt2.csv');
cont_2 = csvread(iii,1,0);
A_cont_2 = zeros(max_id,max_id);
x = size(cont_2);
m_cont_2 = x(1,1); % Number of edges
for i = 1:m_cont_2
    A_cont_2(cont_2(i,1),cont_2(i,2)) = cont_2(i,3);
end
A_cont_2 = (A_cont_2 + A_cont_2'); % Adjacency Matrix of the group in prompt 2
L_cont_2 = diag(A_cont_2 * ones(max_id,1)) - A_cont_2; % Laplacian Matrix 
x_cont_2 = zeros(max_id,1);% Ratings vector
x = size(cont_ratings);
n_users = x(1,1); % Number of users
for i = 1:n_users
    x_cont_2(cont_ratings(i,1)) = cont_ratings(i,3);
end
TV_cont(2) = x_cont_2' * L_cont_2 * x_cont_2; % Total variation in prompt 2


iii = strcat(hhh,'_prompt3.csv');
cont_3 = csvread(iii,1,0);
A_cont_3 = zeros(max_id,max_id);
x = size(cont_3);
m_cont_3 = x(1,1); % Number of edges
for i = 1:m_cont_3
    A_cont_3(cont_3(i,1),cont_3(i,2)) = cont_3(i,3);
end
A_cont_3 = (A_cont_3 + A_cont_3'); % Adjacency Matrix in prompt 3
L_cont_3 = diag(A_cont_3 * ones(max_id,1)) - A_cont_3; % Laplacian Matrix 
x_cont_3 = zeros(max_id,1);% Ratings vector 
x = size(cont_ratings);
n_users = x(1,1); % Number of users
for i = 1:n_users
    x_cont_3(cont_ratings(i,1)) = cont_ratings(i,4);
end
TV_cont(3) = x_cont_3' * L_cont_3 * x_cont_3; % Total variation in prompt 3



iii = strcat(hhh,'_prompt4.csv');
cont_4 = csvread(iii,1,0);
A_cont_4 = zeros(max_id,max_id);
x = size(cont_4);
m_cont_4 = x(1,1); % Number of edges
for i = 1:m_cont_4
    A_cont_4(cont_4(i,1),cont_4(i,2)) = cont_4(i,3);
end
A_cont_4 = (A_cont_4 + A_cont_4'); % Adjacency Matrix in prompt 4
L_cont_4 = diag(A_cont_4 * ones(max_id,1)) - A_cont_4; % Laplacian Matrix 
x_cont_4 = zeros(max_id,1);% Ratings vector of cont group 1
x = size(cont_ratings);
n_users = x(1,1); % Number of users
for i = 1:n_users
    x_cont_4(cont_ratings(i,1)) = cont_ratings(i,5);
end
TV_cont(4) = x_cont_4' * L_cont_4 * x_cont_4; % Total variation in prompt 4



iii = strcat(hhh,'_prompt5.csv');
cont_5 = csvread(iii,1,0);
A_cont_5 = zeros(max_id,max_id);
x = size(cont_5);
m_cont_5 = x(1,1); % Number of edges
x = size(cont_ratings);
n_users = x(1,1); % Number of users
for i = 1:m_cont_5
    A_cont_5(cont_5(i,1),cont_5(i,2)) = cont_5(i,3);
end
A_cont_5 = (A_cont_5 + A_cont_5'); % Adjacency Matrix in prompt 5
L_cont_5 = diag(A_cont_5 * ones(max_id,1)) - A_cont_5; % Laplacian Matrix 
x_cont_5 = zeros(max_id,1);% Ratings vector of cont group 1
for i = 1:n_users
    x_cont_5(cont_ratings(i,1)) = cont_ratings(i,6);
end
TV_cont(5) = x_cont_5' * L_cont_5 * x_cont_5; % Total variation in prompt 5



%% Plot Total Variation

plot(TV_cont/norm(TV_cont),'-bo',...
               'LineWidth',2,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor',[.49 1 .63],...
                'MarkerSize',5)

xlabel('Prompt')
ylabel('Normalized Total Variation')
ylim([0.2 0.7])
grid on


%% Prediction
n = 2; % # Features
m = n_promt - 1; % # Experiments

x = size(cont_ratings);
N = x(1,1); % Number of users

teta = zeros (N,n);
X_1 = [ones(1,N) ; 1 * ones(1,N)]; % features matrix for the first week
X_2 = [ones(1,N) ; 2 * ones(1,N)];
X_3 = [ones(1,N) ; 3 * ones(1,N)];
X_4 = [ones(1,N) ; 4 * ones(1,N)];
X_5 = [ones(1,N) ; 5 * ones(1,N)];
r_1 = nonzeros(x_cont_1); % ratings vector for the first week
r_2 = nonzeros(x_cont_2);
r_3 = nonzeros(x_cont_3);
r_4 = nonzeros(x_cont_4);
r_5 = nonzeros(x_cont_5);

% Deleting zero rows and columns
L_cont_1( ~any(L_cont_1,2), : ) = [];  %rows
L_cont_1( :, ~any(L_cont_1,1) ) = [];  %columns

L_cont_2( ~any(L_cont_2,2), : ) = [];  %rows
L_cont_2( :, ~any(L_cont_2,1) ) = [];  %columns

L_cont_3( ~any(L_cont_3,2), : ) = [];  %rows
L_cont_3( :, ~any(L_cont_3,1) ) = [];  %columns

L_cont_4( ~any(L_cont_4,2), : ) = [];  %rows
L_cont_4( :, ~any(L_cont_4,1) ) = [];  %columns

L_cont_5( ~any(L_cont_5,2), : ) = [];  %rows
L_cont_5( :, ~any(L_cont_5,1) ) = [];  %columns


cvx_begin
    variable teta(N,n);
    minimize( (1/8)*norm(diag(teta * X_1) - r_1) + lambda * (diag(teta * X_1))' * L_cont_1 * diag(teta * X_1)...
    + (1/8)*norm(diag(teta * X_2) - r_2) + lambda * (diag(teta * X_2))' * L_cont_2 * diag(teta * X_2)...
    + (1/8)*norm(diag(teta * X_3) - r_3) + lambda * (diag(teta * X_3))' * L_cont_3 * diag(teta * X_3)...
    + (1/8)*norm(diag(teta * X_4) - r_4) + lambda * (diag(teta * X_4))' * L_cont_4 * diag(teta * X_4) );
cvx_end

estimated_and_true = [diag(teta * X_5),r_5]
percentage_prediction_error = norm(diag(teta * X_5) - r_5)/norm(r_5)*100 % prediction for the group