---
title: "Azure Cloud - Makin' It Rain"
date: 2018-09-04T19:13:44-05:00
---

![image alt text](/rain.jpg)

One of the biggest advantages of deploying to the cloud is the ability to spin up large and spin up fast. You want a 64 x 1024 SQL box to run midnight batch jobs like no one's business, you bet. How about a 128 x 4000 beast with massive SSD IOPs and storage, sure not a problem. Need to quickly scale these boxes horizontally at a specific time or trigger on CPU spikes?

You can do all of the above with just a few clicks in the portal, handful of lines in Powershell, and about 15 minutes cooking time. This is great if you have a need for near-instant massive compute power and a bottomless bank account. Unfortunately, we live in the real world which requires us to be good stewards of our resources. In this real world those servers cost real money: $7K and $27K per month respectively.

![image alt text](/sizes.png)

We recently had a customer who worked with the vendor to create a POC to rival their on-prem environment. Our customer was told to make it happen and let the bean counters worry about the cost. With the vendor's help they MADE IT RAIN. Massive VMs with 30 day full backups, ~100 unattached premium disks that were used once then left to rot like a 6th Street cigarette butt, and no way to understand how they were predicted to spend $1 million that year on infrastructure alone. Here's how we got to the bottom of the issue.

1. First, we checked out the Azure Advisor which only recommended about $100/month in savings.
2. Then, we checked all of our backups and noticed that during the Microsoft Architect guided POC backups were setup to store a 30 days of full backups which we lowered to 3 days.
3. Finally, we created an Azure automation runbook [Get-UnusedAutomation.ps1](https://github.com/josephglaspie/Azure/blob/master/Get-UnusedAutomation.ps1) to gather all unattached disks and disks attacked to deallocated VMs and email our business analysis with the results weekly. Once we got approval to delete we imported the csv created in the previous step and used the following to remove the disks [Remove-UnusedDisk.ps1](https://github.com/josephglaspie/Azure/blob/master/Remove-UnusedDisk.ps1). 


Using those strategies we were able to cut the monthly bill in half!

![image alt text](/before.png)

Thanks for reading.