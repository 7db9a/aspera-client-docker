# Setup

**Build.**

`docker build -t aspera-client-docker .`

# Usage

**Download.**

```
docker run -ti --rm \
-v $(pwd)/data:/home/aspera \
aspera-client-docker \
idr0040 20180215/3105/Pos0/img_000000001_07-YFPtriple_000.tif .
```

# IDR Download

The https://hub.docker.com/r/imagedata/download image can be used to acquire
the original files which were imported into IDR:

        docker run -ti --rm -v /tmp/data:/data imagedata/download idr0001 20151116-verified/JL_120731_S6A /data/JL_120731_S6A

Some exemplary source directories are listed below:

| study   | source                                                                                                      | plate                                       | size   |
|---------|-------------------------------------------------------------------------------------------------------------|---------------------------------------------|--------|
| idr0001 | 20151116-verified/JL_120731_S6A                                                                             | JL_120731_S6A                               | 99G  |
| idr0002 | 20150401-original/chr_cond_screen/plate1_1_013/experiment_descriptor.xml                                    | plate1_1_013                                | 164G |
| idr0003 | 201301120/Images/DTT/p1                                                                                     | DTT p1                                      | 2.4G |
| idr0005 | 20150520-original-jcb/v2/001/2011-04-19                                                                     | Primary_001                                 | 811M |
| idr0005 | 20150520-original-jcb/v2/Secondary 001a/2011-08-29-plate-001.HTD                                            | Secondary_001a                              | 811M |
| idr0006 | 20150915-glencoe-jcb/11001-11089/plate 11001_Plate_136/TimePoint_1                                          | 11001                                       | 8.3G |
| idr0007 | 20150522-original-jcb/wt/Plate1                                                                             | WT_plate1                                   | 1.5G |
| idr0008 | original-actinome2/Plate10_Actinome2                                                                        | Plate10_Actinome2                           | 2.7G |
| idr0008 | original-actinome1/Plate10_Actinome1                                                                        | Plate10_Actinome1                           | 2.4G |
| idr0008 | original-drosophila/Drosophila screen//001B30_S2R                                                           | 001B30_S2R                                  | 2.0G |
| idr0009 | 20150507-VSVG/VSVG/0305-01--2007-04-03                                                                      | 0305-01--2007-04-03                         | 3.0G |
| idr0009 | 20150507-VSVG/VSVG/0001-03--2005-08-01                                                                      | 0001-03--2005-08-01                         | 3.0G |
| idr0017 | 20151124/14_X-Man_10x/source/2011-11-17_X-Man_LOPAC_X01_LP_S01_1                                            | AKT1-/-_&_AKT2-/-_LOPAC_Plate_1_Replicate_1 | 25G  |
| idr0019 | 20160414-original/22 Cell Lines Sero MSB 2015/Raw images - OME tif files by plate/22_lines_HC_EGF_200145913 | 22_lines_HC_EGF_200145913                   | 3.8G |
| idr0020 | 20160414-original/chTOG genetic interaction screen/chTOGsh MAP screen/Alexis 040413 hMAP screen[2056]       | 200972429 TOG[2702]                         | 5.8G |
| idr0028 | 20160818-original/Images/MDA-MB-231_GEFGAP_siGENOME/MDA-MB-231_GEFGAP_siGENOME_1A                           | MDA-MB-231_siGENOME_1A                      | 12G  |
| idr0028 | 20160818-original/Images/LM2_GEFGAP_ONTARGETPlus/LM2_GEFGAP_ONTARGETPlus_1A                                 | LM2_ONTARGETPlus_1A                         | 12G  |
| idr0028 | 20160818-original/Images/LM2_GEFGAP_siGENOME /LM2_GEFGAP_siGENOME_1A                                        | LM2_siGENOME_1A                             | 7.3G |
| idr0028 | 20160818-original/Images/MDA-MB-231_GEFGAP_ONTARGETPlus/MDA-MB-231_GEFGAP_ONTARGETPlus_1A                   | MDA-MB-231_ONTARGETPlus_1A                  | 11G  |
| idr0030 | 20170110-original/200972726[5176]_kinome_YAP_TAZ/MeasurementIndex.ColumbusIDX.xml                           | 200972726[5176]_kinome_YAP_TAZ              | 13G  |
| idr0034 | 20170421-original/Nathalie/HipSci Experiment 10 Plate 1__2014-08-21T17_57_35-Measurement1                   | experiment_10                               | 5.1G |

## Docker environment variables

Calling `docker run` as above envokes `ascp` to download the specified IDR dataset.

Note that you can modify the environment variables in the dockerfile directly in the command line.
For example, to increase the download rate to `100 Mbps`, add an environment variable to the `docker run` command line:

```bash
docker run -ti --rm -v /tmp/data:/data -e ASCP_LIMIT=100m imagedata/download idr0001 20151116-verified/JL_120731_S6A /data/JL_120731_S6A
```

You can modify additional variables as well

| Variable | ASCP flag | Default | Description |
| :------- | :-------- | :------ | :---------- |
| ASCP_KEY | `-i` | /home/data/.aspera/connect/etc/asperaweb_id_dsa.openssh | private_key_file |
| ASCP_LIMIT | `-l` | 40m | max_rate |
| ASCP_RETRANSFER_FILE | `-k` | 0 | Transfer file overwrite |
| ASCP_PORT | `-P` | 33001 | ssh-port|
| ASCP_SERVER | NA | fasp.ebi.ac.uk | host |

For a more detailed description of these commands, see the [ascp documentation](https://www.ibm.com/docs/en/aci/3.9.2?topic=ascp-command-reference).

# Changes to fork

- Dockerfile works of `/home/aspera` instead of `/tmp`.