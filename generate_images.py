import numpy as np
from PIL import Image
import os

# List of resolutions for 1:1 aspect ratio
RESOLUTIONS = {
    "360p": (360, 360),
    "480p": (480, 480),
    "720p": (720, 720),
    "1080p": (1080, 1080),
    "2K": (2048, 2048),
    "4K": (4096, 4096),
}

# Output folder
OUTPUT_FOLDER = "random_noise_images"

# Create output folder if it doesn't exist
os.makedirs(OUTPUT_FOLDER, exist_ok=True)

def generate_random_noise_image(width, height, filename):
    """
    Generates a random noise image of the given width and height and saves it as a PNG file.
    """
    # Generate random pixel data
    random_data = np.random.randint(0, 256, (height, width, 3), dtype=np.uint8)

    # Create an image using Pillow
    image = Image.fromarray(random_data, 'RGB')

    # Save the image
    image.save(filename)
    print(f"Saved: {filename}")

def main():
    """
    Main function to generate random noise images for different resolutions.
    """
    print("Generating random noise images...")
    for resolution_name, (width, height) in RESOLUTIONS.items():
        # Generate file name
        filename = os.path.join(OUTPUT_FOLDER, f"random_noise_{resolution_name}.png")

        # Generate and save the random noise image
        generate_random_noise_image(width, height, filename)
    print("All images have been generated successfully!")

if __name__ == "__main__":
    main()