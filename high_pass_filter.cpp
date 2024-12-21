//
// Created by mladmin on 12/21/24.
//
#include <opencv2/opencv.hpp>
#include <iostream>
#include <vector>
#include <cmath>
#include <omp.h>

using namespace std;
using namespace cv;

// Function to generate a high-pass filter matrix dynamically
vector<vector<int>> generateHighPassFilter(int size)
{
    int centerValue = size * size - 1;
    vector<vector<int>> kernel(size, vector<int>(size, -1));
    kernel[size / 2][size / 2] = centerValue;
    return kernel;
}

// Function to apply the kernel on a specific pixel
double applyKernel(const Mat &image, const vector<vector<int>> &kernel, int x, int y)
{
    int kernelSize = kernel.size();
    int half = kernelSize / 2;
    double sum = 0.0;

    for (int i = -half; i <= half; ++i)
    {
        for (int j = -half; j <= half; ++j)
        {
            int row = min(max(x + i, 0), image.rows - 1);
            int col = min(max(y + j, 0), image.cols - 1);
            sum += image.at<uchar>(row, col) * kernel[i + half][j + half];
        }
    }

    return sum;
}

int main(int argc, char *argv[])
{
    if (argc != 3)
    {
        cerr << "Usage: " << argv[0] << " <FILTER_SIZE> <IMAGE_PATH>" << endl;
        return -1;
    }

    int FILTER_SIZE = atoi(argv[1]);
    if (FILTER_SIZE % 2 == 0 || FILTER_SIZE < 1)
    {
        cerr << "Error: FILTER_SIZE must be an odd positive integer." << endl;
        return -1;
    }

    const char *imagePath = argv[2];
    Mat image = imread(imagePath, IMREAD_GRAYSCALE);

    if (image.empty())
    {
        cerr << "Error: Image cannot be loaded from path: " << imagePath << endl;
        return -1;
    }

    int rows = image.rows;
    int cols = image.cols;

    cout << "Image Loaded: " << rows << "x" << cols << endl;

    // Generate the high-pass filter kernel dynamically
    vector<vector<int>> kernel = generateHighPassFilter(FILTER_SIZE);

    // Output image
    Mat output(rows, cols, CV_8UC1, Scalar(0));

    // Start timing
    double startTime = omp_get_wtime();

    // Apply the high-pass filter using OpenMP
    #pragma omp parallel for schedule(dynamic)
    for (int i = 0; i < rows; ++i)
    {
        for (int j = 0; j < cols; ++j)
        {
            double newValue = applyKernel(image, kernel, i, j);
            output.at<uchar>(i, j) = saturate_cast<uchar>(newValue);
        }
    }

    // End timing
    double endTime = omp_get_wtime();
    cout << "Processing Time: " << (endTime - startTime) << " seconds" << endl;

    // Save the output image
    imwrite("output.png", output);
    cout << "Filtered image saved as output.png" << endl;

    return 0;
}
