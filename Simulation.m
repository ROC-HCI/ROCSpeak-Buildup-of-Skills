% This code implements the model in equation (7)
% and analyzes the total variation (tv) and average ratings (avg).
% Finally plots the average of tv and avg over monte carlo realizations.
clear; clc; close all
N_N = 100; % number of experiments
m = 70; % Number of prompts
tv = zeros(N_N,m); % collects total variations for different experiments over prompts
avg = zeros(N_N,m); % % collects average ratings for different experiments over prompts
for n_n = 1:N_N
    
    
N = 26; % Number of Vertices
r_max = 5; % maximum rating
C = 0.01; % diffusion constant (chosen in a way to simulate our network)
p = 0.5; % Probability of an edge existence (to simulate our number of edges)
A = rand(N,N) < p; % A is Adjacency matrix
A = triu(A,1);
A = A + A'; % symmetric (undirected graph)
L = diag(A*ones(N,1))-A; % Laplacian matrix
r_1 = randi(r_max , N , 1); % Initial ratings
R = zeros(N,m); % matrix of ratings over prompts
R(:,1) = r_1;
for prom = 2:m
    A = rand(N,N) < p; % A is Adjacency matrix
    A = triu(A,1);
    A = A + A';
    L = diag(A*ones(N,1))-A; %Laplacian matrix
    r = min( R(:,prom-1) - C .* L * R(:,prom-1) + normrnd(0.05,0.1,[N,1])   , r_max); % Eq. (7)
    R(:,prom) = r;
end

%% Total Variation Analysis

TV = zeros(m,1);
for i =1:m
    TV(i) = R(:,i)' * L * R(:,i); % total variation
end
tv (n_n,:) = TV';
avg(n_n,:) = mean(R);
n_n
end
%% plot
avg_tv = mean(tv); % average over the experiments
avg_avg = mean(avg);  % average over the experiments
figure
plot (avg_tv, 'LineWidth',2)
xlim([1 m]);
xlabel ('Prompt','FontSize',14)
ylabel ('Total Variation','FontSize',16)
grid on
figure
plot(avg_avg,'LineWidth',2)
xlim([1 m]);
ylim([3 5]);
xlabel ('Prompt','FontSize',14)
ylabel ('Ratings Average','FontSize',16)
grid on