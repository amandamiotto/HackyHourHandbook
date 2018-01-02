## Looping with HPC inside Node using PBSpro

So it looks like inside a pbs script you can run a loop :
```
#PBS -J 1-30
```
is a loop that is 1 to 30 in 1 steps. You can change the steps etc.
The index number its up to is represented by the env var $PBS_ARRAY_INDEX 

You can add steps too. 
http://www.pbsworks.com/pdfs/PBSUserGuide13.0.pdf
Section: 9.4.3 File Staging for Job Arrays

So for example 

```[scratch]$ more test.pbs 
#!/bin/bash
#
#PBS -N simp
#                HH:MM:SS
#PBS -l walltime=02:00:00
#PBS -l nodes=3:ppn=1,mem=2g
#PBS -J 1-3

echo 'job running' $PBS_ARRAY_INDEX  $PBS_ARRAY_ID >> $HOME/output

Returns:
job running 1 4814333[].pbsserver
job running 2 4814333[].pbsserver
job running 3 4814333[].pbsserver
```


You can use that to loop 1-30 or 1-300 and span up to 300 at once as they become available. Each node can talk to $HOME or $SCRATCH. Do note that all jobs will run serially on the same node.

## (Quick and Dirty) Looping with HPC across nodes

You should be doing proper neat parallel code. But if you've decided you need a dirty hack, you can use these two scripts to run up a number of pbs jobs- each with its own node, running the same script (but perhaps different parameters).

You can change the numbers it loops through from 1 - 5 to anything in Parser.test.sh. 

Looping script: [parser.test.sh](ExampleCode/HPCLooping/parser.test.sh)

Example PBS script: [test.pbs](ExampleCode/HPCLooping/test.pbs)


## Writing Parallel code
Long Term- Run segments of code parallel via OpenMP with c++

Pawsey HPC do a great tutorial of this here : https://support.pawsey.org.au/documentation/download/attachments/2162899/Parallelize%20your%20Code%20with%20OpenMP.pdf?api=v2

Basically segments of your code are parked with a pragma segment and that segment is looped and treated as parallel, fired off to numerous nodes. 

Doing some googling on OpenMP with c++ should give you a bucketful of tutorials as well.


|Topic| Name |  Description |Free for AU/NZ| Free for All| URL|
|--------------|----------------------|-----------------------------|----------------------------------------|------|-----|
|HPC| NCI Slides|  Slides around HPC training with Parallel/MPI/OpenMP | Yes| Yes| <http://nci.org.au/user-support/training/>|
|HPC| Pawsey training material| Slides around HPC training with Parallel/MPI/OpenMP | Yes| Yes|<https://support.pawsey.org.au/documentation/display/US/Training+Material>
|HPC|HPC in a day lessons| Lessons around HPC and how to use |Yes| |Yes| <https://psteinb.github.io/hpc-in-a-day/>|
