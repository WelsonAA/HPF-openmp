# High-Pass Filter in C++ Using OpenCV and OpenMP

This repository implements a **high-pass filter** in C++ for image processing. It leverages **OpenCV** for handling image operations and **OpenMP** for parallelizing the computationally intensive convolution process. The high-pass filter emphasizes edges and fine details in images, making it a powerful tool for preprocessing and feature extraction.

---

## **Features**
- Dynamically generates high-pass filter kernels of varying sizes.
- Processes images of any resolution with proper boundary handling.
- Parallelized using OpenMP for efficient performance on multi-core systems.
- Flexible input size and configurable number of threads for scalability.

---

## **Getting Started**

### **Prerequisites**
1. **Ubuntu 20.04+**
2. **C++ Compiler**:
   - GCC with OpenMP support (`g++`).
3. **OpenCV**:
   - Install OpenCV development libraries:
     ```bash
     sudo apt update
     sudo apt install libopencv-dev
     ```
4. **CMake**:
   - Install build tools:
     ```bash
     sudo apt install cmake build-essential
     ```

---

### **Installation**
1. Clone the repository:
   ```bash
   git clone https://github.com/WelsonAA/HPF-openmp.git
   cd high-pass-filter
   ```
2. Create a build directory and compile:
   ```bash
   mkdir build_openmp
   cd build_openmp
   cmake ..
   make
   ```

---

## **Usage**

### **Running the Program**
Execute the `run_openmp.sh` script to apply the high-pass filter.

#### **Basic Example**:
```bash
./run_openmp.sh -t 4 -f 9 -p ./random_noise_images/random_noise_360p.png
```

- `-t`: Number of OpenMP threads (default: 4).
- `-f`: Filter size (must be odd, e.g., 3, 5, 7, etc.).
- `-p`: Path to the input image.

#### **Benchmarking**:
```bash
./run_openmp.sh -t 8 -f 7 -p ./random_noise_images/random_noise_720p.png -m
```

---

### **Using the Quick Run Script**
Use `quick_run_openmp.sh` for predefined resolutions and thread counts.

#### **Example**:
```bash
./quick_run_openmp.sh 720 8
```

- `720`: Resolution of the input image (360, 480, 720, 1080, 2K, 4K).
- `8`: Number of threads.

---

## **Code Overview**

### **Core Functions**
1. **`generateHighPassFilter(int size)`**:
   Dynamically generates a high-pass filter kernel of the specified size.

2. **`applyKernel(const Mat &image, const vector<vector<int>> &kernel, int x, int y)`**:
   Applies the kernel to a specific pixel, handling boundaries to avoid out-of-bounds errors.

3. **OpenMP Parallelization**:
   The convolution process is parallelized using `#pragma omp parallel for` to distribute row processing across threads.

---

## **Project Structure**
```plaintext
high-pass-filter/
├── high_pass_filter.cpp         # Main C++ file for image filtering
├── run_openmp.sh                # Script to run the program with configurable options
├── quick_run_openmp.sh          # Quick run script for predefined settings
├── random_noise_images/         # Sample input images
├── build_openmp/                # Build directory (generated)
├── CMakeLists.txt               # Build configuration
└── README.md                    # Project documentation
```

---

## **Customization**
- Modify filter size in `run_openmp.sh` using the `-f` flag.
- Adjust the number of OpenMP threads with `-t`.
- Add custom images to the `random_noise_images/` directory and provide their path using `-p`.

---

## **Performance Optimization**
- **Dynamic Scheduling**:
  - Used in the OpenMP loop for better load balancing, especially with images of varying content complexity.
- **Multi-Core Utilization**:
  - OpenMP ensures efficient parallel processing by leveraging all available CPU cores.

---

## **Troubleshooting**
1. **Missing Dependencies**:
   - Ensure OpenCV and OpenMP are installed.
   - Rebuild the project if changes are made:
     ```bash
     rm -rf build_openmp/*
     cd build_openmp
     cmake ..
     make
     ```

2. **Invalid Filter Size**:
   - Ensure the filter size (`-f`) is an odd number.

3. **Image Not Found**:
   - Verify the input image path exists.

---

## **License**
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---
