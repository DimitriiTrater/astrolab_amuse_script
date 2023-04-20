#!/bin/bash

# DimitriiTrater

amuse_modules_installation() 
{
    modules_to_install=(aarsethzare athena bhtree brutus bse capreole evtwin fastkick fi fractalcluster gadget2 galactics galaxia halogen hermite hop huayno kepler-orbiters kepler mercury mameclot mesa-r15140 mesa-r2208 mesa mikkola mmams mobse mosse petar ph4 phantom phigrape seba secularmultiple simplex smalln sphray sse tests twobody vader)
    
    for module in "${modules_to_install[@]}"; do
        pip install amuse-"$module"
    done

    return 0
}


# AMUSE installation

# Installing the prerequisites

echo "Choose your mpi program"
echo "[1] openmpi"
echo "[2] mpich"

read mpi_name

# For openmpi
if [[ "$mpi_name" == 1 ]]; then
    sudo apt-get install build-essential gfortran python3-dev \
    libopenmpi-dev openmpi-bin \
    libgsl-dev cmake libfftw3-3 libfftw3-dev \
    libgmp3-dev libmpfr6 libmpfr-dev \
    libhdf5-serial-dev hdf5-tools \
    libblas-dev liblapack-dev \
    python3-venv python3-pip git    
fi


# For mpich
if [[ "$mpi_name" == 2 ]]; then
    sudo apt-get install build-essential gfortran python3-dev \
    mpich libmpich-dev \
    libgsl-dev cmake libfftw3-3 libfftw3-dev \
    libgmp3-dev libmpfr6 libmpfr-dev \
    libhdf5-serial-dev hdf5-tools \
    libblas-dev liblapack-dev \
    python3-venv python3-pip git
fi


# Installing AMUSE

mkdir amuse_install_dir
cd amuse_install_dir

python3 -m venv amuse-env
. amuse-env/bin/activate

pip install --upgrade pip

# STD modules
pip install numpy docutils mpi4py h5py wheel

# Additional modules
pip install scipy astropy jupyter pandas seaborn matplotlib 

# AMUSE modules
pip install amuse-framework

echo "You installed the minimal version of AMUSE"
echo "Do you want to install all AMUSE modules and starts the tests"
echo "This will help expected errors in installation"
echo "[Y/n]"

read ans

if [["$ans" == "Y" || "$ans" == ""]]; then
    amuse_modules_installation    
fi

echo "Good Luck! Have Fun!"
