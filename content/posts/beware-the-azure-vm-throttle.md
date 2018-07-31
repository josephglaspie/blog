---
title: "Beware the Azure VM throttle"
date: "2018-07-28"
---

One of my customers went live with their datawarehouse solution in Azure a few weeks back. Everything went smoothly until the analysts hit the boxes with more than they could handle and we had to rearchitect a new solution on the fly.

I wanted to explain what we saw from at a high-level and in common language without making my fellow engineers cringe too much.

When building a Virtual Machine (VM) in the cloud there are many specs to look at. We typically focus on things like HDD size and speed, amount of RAM and CPU counts and cores. 

However, to keep all the VMs in the cloud from stomping all over each other Azure throttles the VMs much like an HOA throttles your neighbor from building a body shop on their front yard. 

The machines we are using are spec’d for High Memory usage but have a cached Disk IO of 512MB/s total.

![image alt text](/Picture1.png)

…This means that it only takes two 2TB disks at full utilization (250MB/s) to hit the Azure VM throttle of 512MB as highlighted above.

![image alt text](/disklimits.png)

Our VM has multiple > 2TB disks attached with SQL running full speed. The CPU and RAM on the server are underutilized but the transaction times on the disks are at > 1000ms instead of 15-20 in a healthy non-throttled machine. We have validated this with PerfMon the local windows performance counter tool.

Currently, the L series VMs that have no storage throttles are available in East Us 2 where our subscription lives.


TLDR
------------------
We have a pontoon boat (optimized for memory) and even though we keep attaching motors and props the shape of the hull (VM) will only allow it to go about 15 MPHs. If you want it to go faster need to get a boat with a streamlined hull.

References:
------------------
* [Azure VMs](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sizes-memory#esv3-series)
* [Azure Disks](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/premium-storage#scalability-and-performance-targets)
* [On Azure VM Throttling](https://blogs.technet.microsoft.com/xiangwu/2017/05/14/azure-vm-storage-performance-and-throttling-demystify/)
