# Buildup of Speaking Skills in an Online Learning Community: A Network-Analytic Exploration

Please install the MATLAB package CVX from http://cvxr.com/cvx/.

The simulation.m file simulates the skill diffusion process as described in the paper.

The folders group1 to group6 contain the interaction and ratings dataset of the six online communities. Each folder has the interaction data of five prompts, and the ratings of the participants. The interaction data files are formetted as follows. The file group<k>_prompt<m>.csv contains the interaction data from the k-th group (out of 6) in the m-th prompt (out of 5). In the file, IDs in the column 'source' gave 'weight' number of comments to the IDs in the column 'target'. The file group<k>_rating_table.csv contains the ratings (from 1-5) of all the IDs in the five prompts.

The TV_prediction.m file loads the data of one of the six online communities at a time, and reports the 5th prompt rating prediction accuracy based on the framework described in the paper. At the beginning of the program, the Group variable lets anyone choose which group's data to load and analyze.
