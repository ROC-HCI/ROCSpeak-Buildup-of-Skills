# Buildup of Speaking Skills in an Online Learning Community: A Network-Analytic Exploration

This repository holds the dataset files and analysis codes for the publication of the same name as the title:

R. Shafipour*, R. A. Baten*, M. K. Hasan, G. Ghoshal, G. Mateos, and M. E. Hoque. Buildup of speaking-skills in an online learning community: A network-analytic exploration. Palgrave Communications, 4(1):1-10, 2018. (* equal contributions)

The main manuscript can be found at: https://www.nature.com/articles/s41599-018-0116-6. The codes were developed by Rasoul Shafipour and Raiyan Abdul Baten.

## What's in this Repository

The folders group1 to group6 contain the interaction and rating data of the six online communities. The interaction data files are formatted as follows. The file group_{k}\_prompt_{m}.csv contains the interaction data from the k-th group (1<=k<=6) in the m-th prompt (1<=m<=5). In the files, IDs in the column 'source' gave 'weight' number of comments to the IDs in the column 'target'. The file group_{k}\_rating_table.csv contains the ratings (in a Likert scale of 1-5) of all the group members in the five prompts.

The simulation.m file simulates the skill diffusion process as described in the paper.

The TV_prediction.m file loads the data of one of the six online communities at a time, and reports the 5th prompt rating prediction accuracy based on the framework described in the paper. At the beginning of the program, the variable 'Group' allows to choose which group's data to load and analyze.

## Installation and Usage

Please install the MATLAB package CVX from http://cvxr.com/cvx/.

The simulation.m and TV_prediction.m scripts can then be run from the MATLAB interface.

## Abstract

Studies in learning communities have consistently found evidence that peer-interactions contribute to students' performance outcomes. A particularly important competence in the modern context is the ability to communicate ideas effectively. One metric of this is speaking, which is an important skill in professional and casual settings. In this study, we explore peer-interaction effects in online networks on speaking skill development. In particular, we present an evidence for gradual buildup of skills in a small-group setting that has not been reported in the literature. Evaluating the development of such skills requires studying objective evidence, for which purpose, we introduce a novel dataset of six online communities consisting of 158 participants focusing on improving their speaking skills. They video-record speeches for 5 prompts in 10 days and exchange comments and performanceratings with their peers. We ask (i) whether the participants' ratings are affected by their interaction patterns with peers, and (ii) whether there is any gradual buildup of speaking skills in the communities towards homogeneity. To analyze the data, we employ tools from the emerging field of Graph Signal Processing (GSP). GSP enjoys a distinction from Social Network Analysis in that the latter is concerned primarily with the connection structures of graphs, while the former studies signals on top of graphs. We study the performance ratings of the participants as graph signals atop underlying interaction topologies. Total variation analysis of the graph signals show that the participants' rating differences decrease with time (slope < 0, p < 0.01), while average ratings increase (slope > 0, p < 0.05)—thereby gradually building up the ratings towards community-wide homogeneity. We provide evidence for peer-influence through a prediction formulation. Our consensus-based prediction model outperforms baseline network-agnostic regression models by about 23% in predicting performance ratings. This in turn shows that participants' ratings are affected by their peers' ratings and the associated interaction patterns, corroborating previous findings. Then, we formulate a consensus-based diffusion model that captures these observations of peer-influence from our analyses. We anticipate that this study will open up future avenues for a broader exploration of peer-influenced skill development mechanisms, and potentially help design innovative interventions in small-groups to maximize peer-effects.
