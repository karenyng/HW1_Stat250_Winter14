HW1_Stat250_Winter14
====================

benchmarking different approaches to computing statistics of large csv files.

For details see:
http://nbviewer.ipython.org/github/karenyng/HW1_Stat250_Winter14/blob/master/writeup/hw1.ipynb?create=1

Or in R, load "results.rda" 

Dependency:
----------
* Put data (.csv files NOT .csv.bz files) in a directory ${PATH TO GIT DIRECTORY}/data 

To run:
-----
* Method 1 : $Rscript ${PATH TO GIT DIRECTORY}/method1.R 
* Method 2 : $Rscript ${PATH TO GIT DIRECTORY}/method2.R 


Returns:
----
Method 1: 
* results1.rda ---- All results are in the R object results1.rd for all 81
  csv files uncompressed from
  http://eeyore.ucdavis.edu/stat250/Data/Airlines/Delays1987_2013.tar.bz2 
* freq_count.txt ---- by-product of my laziness

Method 2: 
* results2.rda
* results2.txt

Machine specification: 
---------------------
  * Corsair Vengeance 2x8GB DDR3 1600 MHz Desktop Memory, 
  * Intel(R) Core(TM) i7-4770K CPU @ 3.50GHz,
http://www.cpubenchmark.net/cpu.php?cpu=Intel+Core+i7-4770K+%40+3.50GHz&id=1919
  * GeForce GTX 770 SuperClocked
  * Samsung 840 Pro 256 GB SSD
  * Motherboard: Asus Z87-Deluxe DDR3 1600 LGA 1150 
  * Linux Mint 15 Olivia (GNU/Linux 3.8.0-19-generic x86_64)
  * R version 3.0.2 (2013-09-25) -- "Frisbee Sailing"
  * Python v. 2.7.4, numpy v.1.7.1, pandas v.0.10.1  

Wallclock time 
-----
* Method 1: ~5.4 mins 
* Method 2: ~3.1 mins

Results
----
Method 1 agrees with Method 2 up to 6 decimal places


Method 2: 

mean = 6.56650421703

median = 0.0

std. dev. = 31.5563262623


