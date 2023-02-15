#!/bin/sh
#SBATCH -N 1
#SBATCH --cpus-per-task 1
#SBATCH -n 4
#SBATCH --mem 16G
#SBATCH --time 00:45:00
#SBATCH --reservation latt_6700
#SBATCH --partition shared-gpu
#SBATCH --gres=gpu:1

module purge
module load GCC/12.2.0 CUDA/11.6.0
cd
wget https://julialang-s3.julialang.org/bin/linux/x64/1.8/julia-1.8.5-linux-x86_64.tar.gz
tar xf julia-1.8.5-linux-x86_64.tar.gz
echo 'export PATH=~/julia-1.8.5/bin:$PATH' >> ~/.bashrc
export PATH=~/julia-1.8.5/bin:$PATH
srun julia -e 'import Pkg; Pkg.add.(["Distributed","SIMD",
                                     "LoopVectorization",
                                     "Folds","BenchmarkTools",
                                     "LinearAlgebra",
                                     "StaticArrays","Random",
                                     "CSV","YAML",
                                     "Plots","CUDA","ClusterManagers"])'
