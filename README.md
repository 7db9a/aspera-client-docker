Download IDR data using a containerized aspera client.

# Setup

**Build.**

`docker build -t aspera-client-docker .`

# Usage

**Download.**

Make the dir where you want the data to be downloaded to.

`mkdir DIR`

Enter the dir.

`cd DIR`

Run the docker command, but edit out `DATASET` and `DATASET_FILEPATH` (more on that below).

```
docker run -ti --rm \
-v $(pwd):/home/aspera \
aspera-client-docker \
DATASET DATASET_FILE_PATH .
```

## Example

Below demonstrates how to do a partial download of the idr0040 dataset.

**Find your dataset.**

https://idr.openmicroscopy.org/webclient

**Get the file path.**

On the `General` tab on right pane, select the file path icon with the tooltip "Show file path on server". You'll have to select the dir or file for the pane to show up, as of the current state of the website. The path it gives is `uod/idr/filesets/idr0040-aymoz-singlecell/20180215/3105/Pos0/`.

In this case, dataset is `idr0040` and the filepath is `20180215/3105/Pos0/`

**Download**

```
docker run -ti --rm \
-v $(pwd):/home/aspera \
aspera-client-docker \
idr0040 20180215/3105/Pos0/ .
```

According to the website (https://github.com/IDR/idr-metadata), you can get the filepaths from the tsv files. However, for `idr0010`, the filepaths aren't shown in the tsv. Therefore, try the above workflow

## Another example

Here we download one that is bit more trick from idr0010. Use the above example as a guide and see how the command applies below.

```
docker run -ti --rm \
-v $(pwd):/home/aspera \
aspera-client-docker \
idr0010 20150501-original/Restored\ GW\ screen/1-23 .
```

# Changes to fork

https://github.com/IDR/aspera-client-docker.

Dockerfile works of `/home/aspera` instead of `/tmp`. Otherwise, you can't mount `/tmp` to your host dir.