% This code analyzes the total variation (Eq. (1)) and performs the prediction under
% equations (5) and (6), respectively. Note that for lambda = 0, the
% framework boils down to a linear regression. 

clc; 
clear all;
close all;

%% input

Group = 1; % can be 1,2,3,4,5 or 6 representing the six different groups
lambda = 0.004; % Regularization parameter in equations (5) and (6) selected 
%using model selection approaches (e.g., leave-one-out)

%% Reading files and analyzing TV

n_promt = 5; % Number of prompts
TV_cont = zeros(n_promt,1); % Total Variation accross the network
hhh = strcat('group',num2str(Group),'/group',num2str(Group));
ggg = strcat(hhh,'_rating_table.csv');
x_cont = [];
cont_ratings = csvread(ggg,1,0); % Ratings for different prompts
max_id = max(cont_ratings(:,1)); % maximum user ID
L_cont = zeros(max_id,max_id,5);

for round = 1:5
    ps = strcat('_prompt',num2str(round),'.csv');
    iii = strcat(hhh,ps);
    cont_1 = csvread(iii,1,0); % Interactions
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
        x_cont_1(cont_ratings(i,1)) = cont_ratings(i,round+1);
    end
    TV_cont(round) = x_cont_1' * L_cont_1 * x_cont_1; % Total variation  in prompt 1
    x_cont = [x_cont x_cont_1];
    L_cont(:,:,round) = L_cont_1;
end


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
r_1 = nonzeros(x_cont(:,1)); % ratings vector for the first week
r_2 = nonzeros(x_cont(:,2));
r_3 = nonzeros(x_cont(:,3));
r_4 = nonzeros(x_cont(:,4));
r_5 = nonzeros(x_cont(:,5));

% Deleting zero rows and columns
L_cont_1 = L_cont(:,:,1);
L_cont_1( ~any(L_cont_1,2), : ) = [];  %rows
L_cont_1( :, ~any(L_cont_1,1) ) = [];  %columns

L_cont_2 = L_cont(:,:,2);
L_cont_2( ~any(L_cont_2,2), : ) = [];  %rows
L_cont_2( :, ~any(L_cont_2,1) ) = [];  %columns

L_cont_3 = L_cont(:,:,3);
L_cont_3( ~any(L_cont_3,2), : ) = [];  %rows
L_cont_3( :, ~any(L_cont_3,1) ) = [];  %columns

L_cont_4 = L_cont(:,:,4);
L_cont_4( ~any(L_cont_4,2), : ) = [];  %rows
L_cont_4( :, ~any(L_cont_4,1) ) = [];  %columns

L_cont_5 = L_cont(:,:,5);
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
