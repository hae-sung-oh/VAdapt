import os

# Define the dataset root directory
DATASET_ROOT = "."
INDEX_FILE_PATH = os.path.join(DATASET_ROOT, "dataset_index.txt")


# Function to count the number of frames in a directory
def count_frames(route_dir):
    # Assuming the frame data is stored in directories like 'rgb', 'rgb_front', etc.
    frame_folders = "rgb_front"
    total_frames = 0
    folder_path = os.path.join(route_dir, frame_folders)
    if os.path.exists(folder_path):
        # Counting the number of files (assuming files are frames)
        frame_count = len([file for file in os.listdir(folder_path) if os.path.isfile(os.path.join(folder_path, file))])
    else:
        raise FileExistsError
    return frame_count


def generate_dataset_index():
    entries = []

    # Traverse each weather directory
    for weather_dir in os.listdir(DATASET_ROOT):
        weather_path = os.path.join(DATASET_ROOT, weather_dir)
        if os.path.isdir(weather_path):
            # Traverse the 'data' subdirectory within each weather directory
            data_path = os.path.join(weather_path, "data")
            if os.path.exists(data_path):
                for route_dir in os.listdir(data_path):
                    route_path = os.path.join(data_path, route_dir)
                    if os.path.isdir(route_path):
                        # Count the frames in this route directory
                        num_frames = count_frames(route_path)
                        # Collect the relative route directory path and frame count
                        relative_route_path = os.path.relpath(route_path, DATASET_ROOT)
                        entries.append(f"{relative_route_path} {num_frames}")

    # Sort entries alphabetically
    entries.sort()

    # Write the sorted entries to dataset_index.txt
    with open(INDEX_FILE_PATH, "w") as index_file:
        for entry in entries:
            index_file.write(f"{entry}\n")

    print(f"dataset_index.txt has been successfully generated and sorted at {INDEX_FILE_PATH}")


# Function to add a new route to the dataset_index.txt
def add_route_to_index(route_path, frame_count):
    with open(INDEX_FILE_PATH, "a") as index_file:
        relative_route_path = os.path.relpath(route_path, DATASET_ROOT)
        index_file.write(f"{relative_route_path} {frame_count}\n")
    print(f"Added {route_path} with {frame_count} frames to dataset_index.txt")


# Main function to call
if __name__ == "__main__":
    generate_dataset_index()
