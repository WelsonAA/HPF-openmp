cmake_minimum_required(VERSION 3.10)

# Project Name
project(hpc-welson)

# Enable OpenMP
find_package(OpenMP REQUIRED)

# Set C++ Standard
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# Find OpenCV
find_package(OpenCV REQUIRED)

# Add Executable
add_executable(high_pass_filter ../high_pass_filter.cpp)

# Link Libraries
target_link_libraries(high_pass_filter PUBLIC OpenMP::OpenMP_CXX ${OpenCV_LIBS})

# Include Directories
include_directories(${OpenCV_INCLUDE_DIRS})
