Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 633A81DCBA8
	for <lists+linux-pm@lfdr.de>; Thu, 21 May 2020 13:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgEULJb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 May 2020 07:09:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31962 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728414AbgEULJb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 May 2020 07:09:31 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04LB44CY096940;
        Thu, 21 May 2020 07:09:12 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 314ua5dr40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 May 2020 07:09:12 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04LB4C5U097610;
        Thu, 21 May 2020 07:09:11 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 314ua5dr35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 May 2020 07:09:11 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04LB16NO031979;
        Thu, 21 May 2020 11:09:09 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 313wne2a80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 May 2020 11:09:09 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04LB96Jf59048006
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 May 2020 11:09:06 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B78EA405B;
        Thu, 21 May 2020 11:09:06 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02C42A4060;
        Thu, 21 May 2020 11:09:04 +0000 (GMT)
Received: from [9.85.82.119] (unknown [9.85.82.119])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 21 May 2020 11:09:03 +0000 (GMT)
From:   Pratik Sampat <psampat@linux.ibm.com>
Subject: Re: [RFC 0/1] Alternate history mechanism for the TEO governor
To:     Doug Smythies <dsmythies@telus.net>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael.j.wysocki@intel.com, peterz@infradead.org,
        daniel.lezcano@linaro.org, ego@linux.vnet.ibm.com,
        svaidy@linux.ibm.com, pratik.sampat@in.ibm.com,
        pratik.r.sampat@gmail.com
References: <20200511141055.43029-1-psampat@linux.ibm.com>
 <000101d62c76$a16ac360$e4404a20$@net>
Message-ID: <fca35bce-b1ae-7137-4bf8-aa385c371be4@linux.ibm.com>
Date:   Thu, 21 May 2020 16:39:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <000101d62c76$a16ac360$e4404a20$@net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-21_05:2020-05-21,2020-05-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0 phishscore=0
 cotscore=-2147483648 suspectscore=0 bulkscore=0 spamscore=0 clxscore=1015
 mlxscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005210078
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Doug,

Thanks a lot for running these benchmarks on an Intel box.


On 17/05/20 11:41 pm, Doug Smythies wrote:
> On 2020.05.11 Pratik Rajesh Sampat wrote:
>> First RFC posting:https://lkml.org/lkml/2020/2/22/27
> Summary:
>
> On that thread I wrote:
>
>    > I have done a couple of other tests with this patch set,
>    > but nothing to report yet, as the differences have been
>    > minor so far.
>
> I tried your tests, or as close as I could find, and still
> do not notice much difference.

That is quite unfortunate. At least it doesn't seem to regress.

Nevertheless, as Rafael suggested aging is crucial, this patch doesn't age
weights. I do have a version with aging but I had a lot of run to run variance
so I had refrained from posting that.
I'm tweaking around the logic for aging as well as distribution of weights,
hopefully that may help.

> For detail, but likely little added value, read on:
>
> Kernel: 5.7-rc4:
> "teo": unmodified kernel.
> "wtteo": with this patch added.
> "menu": the menu idle governor, for comparison.
> CPU frequency scaling driver: intel-cpufreq
> CPU frequency scaling governor: schedutil
> CPU idle driver: intel_idle
>
> ...
>
>> Benchmarks:
>> Schbench
>> --------
>> Benchmarks scheduler wakeup latencies
>>
>> 1. latency 99th percentile - usec
> I found a Phoronix schbench test.
> It defaults to 99.9th percentile.
>
> schbench (usec, 99.9th Latency Percentile, less is better)(8 workers)					
>
> threads	teo		wtteo				menu	
> 	2	14197		14194		99.98%	14467		101.90%
> 	4	46733		46490		99.48%	46554		99.62%
> 	6	57306		58291		101.72%	57754		100.78%
> 	8	81408		80768		99.21%	81715		100.38%
> 	16	157286	156570	99.54%	156621	99.58%
> 	32	314573	310784	98.80%	315802	100.39%
>
> Powers and other idle statistics were similar. [1]
>
>> 2. Power - watts
>> Machine - IBM Power 9
>>
>> Latency and Power - Normalized
>> +---------+--------------+-----------------+---------------+
>> | Threads | TEO Baseline | Wt. TEO Latency | Wt. TEO Power |
>> +---------+--------------+-----------------+---------------+
>> | 2       | 100          | 101.3           | 85.29         |
>> +---------+--------------+-----------------+---------------+
>> | 4       | 100          | 105.06          | 113.63        |
>> +---------+--------------+-----------------+---------------+
>> | 8       | 100          | 92.32           | 90.36         |
>> +---------+--------------+-----------------+---------------+
>> | 16      | 100          | 99.1            | 92.43         |
>> +---------+--------------+-----------------+---------------+
>>
>> Accuracy
>>
>> Vanilla TEO Governor - Prediction distribution %
>> +---------+------+------+------+-------+-------+-------+---------+
>> | Threads | US 1 | US 2 | US 3 | US 4  | US 5  | US 6  | Correct |
>> +---------+------+------+------+-------+-------+-------+---------+
>> | 2       | 6.12 | 1.08 | 1.76 | 20.41 | 9.2   | 28.74 | 22.51   |
>> +---------+------+------+------+-------+-------+-------+---------+
>> | 4       | 8.54 | 1.56 | 1.25 | 20.24 | 10.75 | 25.17 | 22.67   |
>> +---------+------+------+------+-------+-------+-------+---------+
>> | 8       | 5.88 | 2.67 | 1.09 | 13.72 | 17.08 | 32.04 | 22.95   |
>> +---------+------+------+------+-------+-------+-------+---------+
>> | 16      | 6.29 | 2.43 | 0.86 | 13.21 | 15.33 | 26.52 | 29.34   |
>> +---------+------+------+------+-------+-------+-------+---------+
>> +---------+------+------+------+
>> | Threads | OS 1 | OS 2 | OS 3 |
>> +---------+------+------+------+
>> | 2       | 1.77 | 1.27 | 7.14 |
>> +---------+------+------+------+
>> | 4       | 1.8  | 1.31 | 6.71 |
>> +---------+------+------+------+
>> | 8       | 0.65 | 0.72 | 3.2  |
>> +---------+------+------+------+
>> | 16      | 0.63 | 1.71 | 3.68 |
>> +---------+------+------+------+
>>
>> Weighted TEO Governor - Prediction distribution %
>> +---------+------+------+------+-------+-------+-------+---------+
>> | Threads | US 1 | US 2 | US 3 | US 4  | US 5  | US 6  | Correct |
>> +---------+------+------+------+-------+-------+-------+---------+
>> | 2       | 7.26 | 2.07 | 0.02 | 15.85 | 13.29 | 36.26 | 22.13   |
>> +---------+------+------+------+-------+-------+-------+---------+
>> | 4       | 4.33 | 1.45 | 0.15 | 14.17 | 14.68 | 40.36 | 21.01   |
>> +---------+------+------+------+-------+-------+-------+---------+
>> | 8       | 4.73 | 2.46 | 0.12 | 12.48 | 14.68 | 32.38 | 28.9    |
>> +---------+------+------+------+-------+-------+-------+---------+
>> | 16      | 7.68 | 1.25 | 0.98 | 12.15 | 11.19 | 24.91 | 35.92   |
>> +---------+------+------+------+-------+-------+-------+---------+
>> +---------+------+------+------+
>> | Threads | OS 1 | OS 2 | OS 3 |
>> +---------+------+------+------+
>> | 2       | 0.39 | 0.42 | 2.31 |
>> +---------+------+------+------+
>> | 4       | 0.45 | 0.51 | 2.89 |
>> +---------+------+------+------+
>> | 8       | 0.53 | 0.66 | 3.06 |
>> +---------+------+------+------+
>> | 16      | 0.97 | 1.9  | 3.05 |
>> +---------+------+------+------+
>>
>> Sleeping Ebizzy
>> ---------------
>> Program to generate workloads resembling web server workloads.
>> The benchmark is customized to allow for a sleep interval -i
> I found a Phoronix ebizzy, but without the customization,
> which I suspect is important to demonstrate your potential
> improvement.
>
> Could you send me yours to try?

Sure thing, sleeping ebizzy is hosted here:
https://github.com/pratiksampat/sleeping-ebizzy

>
> ebizzy (records per second, more is better)					
>
> teo		wtteo				menu	
> 132344	132228	99.91%	130926	98.93%
>
> Powers and other idle statistics were similar. [2]
>
>> 1. Number of records
>> 2. Power - watts
>> Machine - IBM Power 9
>>
>> Parameters:
>> 1. -m -> Always use mmap instead of malloc
>> 2. -M -> Never use mmap
>> 3. -S <seconds> -> Number of seconds to run
>> 4. -i <interval> -> Sleep interval
> What are the units of this interval?
> They must be microseconds, as that is the only thing that makes sense.

Yes, it is in microseconds

> I have tried to simulate the resulting actual workflow
> myself, but didn't get results like yours. (I may have done a poorly.)
> My test does not produce performance data, as it just has to do its work
> before the next time to do a chunk of work.
> The test is:
>
> forever
>    do 100 times
>      very short sleep
>    enddo
>    sleep for 10 milliseconds
> endforever

Yes, In logic this is very similar to what benchmark emulates.

> The overheads result in enough activity.
> Powers and other idle statistics were similar. [3]
>
>> Number of records and power normalized
>> +-------------------+---------------+------------------+-----------------+
>> | Parameters        | TEO baseline  | Wt TEO records   | Wt. TEO Power   |
>> +-------------------+---------------+------------------+-----------------+
>> | -S 60 -i 10000    | 100           | 106.56           | 93.95           |
>> +-------------------+---------------+------------------+-----------------+
>> | -m -S 60 -i 10000 | 100           | 100.62           | 82.14           |
>> +-------------------+---------------+------------------+-----------------+
>> | -M -S 60 -i 10000 | 100           | 104.97           | 95.19           |
>> +-------------------+---------------+------------------+-----------------+
>>
>> Accuracy
>>
>> Vanilla TEO Governor - Prediction distribution %
>> +-------------------+-------+------+------+-------+------+-------+
>> | Parameters        | US 1  | US 2 | US 3 | US 4  | US 5 | US 6  |
>> +-------------------+-------+------+------+-------+------+-------+
>> | -S 60 -i 10000    | 45.46 | 0.52 | 1.5  | 15.34 | 2.44 | 8.61  |
>> +-------------------+-------+------+------+-------+------+-------+
>> | -m -S 60 -i 10000 | 4.22  | 2.08 | 0.71 | 90.01 | 0    | 0.01  |
>> +-------------------+-------+------+------+-------+------+-------+
>> | -M -S 60 -i 10000 | 15.78 | 1.42 | 2.4  | 22.39 | 1.68 | 11.25 |
>> +-------------------+-------+------+------+-------+------+-------+
>> +-------------------+---------+------+------+------+------+
>> | Parameters        | Correct | OS 1 | OS 2 | OS 3 | OS 4 |
>> +-------------------+---------+------+------+------+------+
>> | -S 60 -i 10000    | 17.03   | 1.73 | 1.1  | 6.27 | 0    |
>> +-------------------+---------+------+------+------+------+
>> | -m -S 60 -i 10000 | 2.44    | 0.18 | 0.13 | 0.22 | 0    |
>> +-------------------+---------+------+------+------+------+
>> | -M -S 60 -i 10000 | 31.65   | 3.45 | 1.8  | 8.18 | 0    |
>> +-------------------+---------+------+------+------+------+
>>
>> Weigted TEO Governor - Prediction distribution %
>> +-------------------+-------+------+------+-------+------+-------+
>> | Parameters        | US 1  | US 2 | US 3 | US 4  | US 5 | US 6  |
>> +-------------------+-------+------+------+-------+------+-------+
>> | -S 60 -i 10000    | 8.25  | 0.87 | 0.98 | 19.23 | 4.05 | 26.35 |
>> +-------------------+-------+------+------+-------+------+-------+
>> | -m -S 60 -i 10000 | 7.69  | 4.35 | 0.93 | 82.74 | 0.01 | 0.01  |
>> +-------------------+-------+------+------+-------+------+-------+
>> | -M -S 60 -i 10000 | 3.73  | 3.29 | 0.73 | 13.33 | 7.38 | 18.61 |
>> +-------------------+-------+------+------+-------+------+-------+
>> +-------------------+---------+------+------+------+------+
>> | Parameters        | Correct | OS 1 | OS 2 | OS 3 | OS 4 |
>> +-------------------+---------+------+------+------+------+
>> | -S 60 -i 10000    | 32.86   | 3.27 | 2.05 | 2.09 | 0    |
>> +-------------------+---------+------+------+------+------+
>> | -m -S 60 -i 10000 | 3.4     | 0.29 | 0.28 | 0.3  | 0    |
>> +-------------------+---------+------+------+------+------+
>> | -M -S 60 -i 10000 | 48.19   | 1.8  | 0.93 | 1.97 | 0.04 |
>> +-------------------+---------+------+------+------+------+
> For accuracy numbers, it would help to know the sample size
> and the importance.
>
> For this 60 second test, I wonder if the number of times
> each idle state was entered and exited was large enough to
> draw any conclusion. I often find for tests that some states are
> only used a few times in 1 minute, and so don't really care about the accuracy.

The sample size does go upto early double digit thousands but I don't really
know the physical importance of such a number.
So, I get what you're saying and maybe I need to benchmark with a longer duration
as your experience shows.

> Anyway, for my attempts that this test, I had to extend to a 5 minute sample
> time to get adequate numbers in all idle states for the accuracy statistics.
> (which showed no difference, by the way (for those not looking at the graphs).)
>
> For my test all three governors, teo, wtteo, and menu, were
> using idle state 0 about 7 to 8 thousand times per 5 minutes,
> and 100% of time the assessment was the state was too shallow.
> However, I don't really care because it is only 0.003% of the time,
> and if idle state 0 is disabled (teo-0disable on [3] (it is enabled
> again at minute 35), the power doesn't change.
>
> All that being said, your power/accuracy results do seem correlated.
>
This I believe is a good affirmation to have. I would be worried if
we predicted more correctly and somehow ended up doing worse or vise-versa.

>> Pgbench
>> -------
>> pgbench is a simple program for running benchmark tests on PostgreSQL.
>> It runs the same sequence of SQL commands over and over, possibly in
>> multiple concurrent database sessions, and then calculates the average
>> transaction rate (transactions per second).
> I did not try this test or anything similar.
> ...
>
>> Hackbench
>> ---------
>> Creates a specified number of pairs of schedulable entities
>> which communicate via either sockets or pipes and time how long  it
>> takes for each pair to send data back and forth.
>>
> I found a Phoronix version, but it doesn't like
> your low loops counts, so I stayed with the default 50,000.
>
> I suspect your low loop count results in a workflow somewhat like
> your special ebizzy test. Anyway, maybe I should try your version
> and low loop counts.
>
> I did many tests, and get inconsistent results.
>
> You use these terms like "sockets" and "pipes", but
> the phoronix test uses "count" and "thread" or "process".
>
> I only used "process" for the simple reason that there was very
> very little use of idle at all with "thread", so there was no value
> in any test.
>
> hackbench test 1: all - process (seconds, less is better)					
> 						
> test	count	teo		wtteo				menu	
> 1	1	8.7		8.99		103.33%	9.071		104.26%
> 2	2	16.509	16.96		102.73%	17.159	103.94%
> 3	4	33.451	34.081	101.88%	34.101	101.94%
> 4	8	69.037	71.647	103.78%	69.914	101.27%
> 5	16	161.64	165.569	102.43%	165.015	102.09%
>
> Powers and other idle statistics were similar. [4]
>
> hackbench test 2: count 1 - process (seconds, less is better)					
> 		teo	wtteo			menu	
> average	8.906	8.703	97.72%	9.032	101.41%
> max		9.263	8.856			9.228	
> min		8.761	8.599			8.876	
> Std. Dev.	0.83%	0.46%			0.80%	
> runs		256	256			200	
>
> Powers and other idle statistics were similar. [5]
> However, idle state 3 is worthy of a look.
>
> hackbench test 3: count 2 - process (seconds, less is better)					
> 		teo		wtteo			menu	
> average	16.702	16.65	99.69%	16.796	100.56%
> max		16.853	16.966		17.058	
> min		16.542	16.487		16.659	
> Std. Dev.	0.41%		0.59%			0.56%	
> runs		100		100			100	
>
> Powers and other idle statistics were similar. [6]
> However, idle state 3 is worthy of a look.
>
>> Machine - IBM Power 9
>>
>> Scale of measurement:
>> 1. Time (s)
>> 2. Power (watts)
>> Time is normalized
>>
>> +---------+----------+----------------------+-------------------+
>> | Loops   | TEO Time | Wt. TEO Time Sockets | Wt. TEO Time Pipe |
>> +---------+----------+----------------------+-------------------+
>> | 100     | 100      | 95.23                | 87.09             |
>> +---------+----------+----------------------+-------------------+
>> | 1000    | 100      | 105.81               | 98.67             |
>> +---------+----------+----------------------+-------------------+
>> | 10000   | 100      | 99.33                | 92.73             |
>> +---------+----------+----------------------+-------------------+
>> | 100000  | 100      | 98.88                | 101.99            |
>> +---------+----------+----------------------+-------------------+
>> | 1000000 | 100      | 100.04               | 100.2             |
>> +---------+----------+----------------------+-------------------+
>>
>> Power :Socket: Consistent between 135-140 watts for both TEO and Wt. TEO
>>         Pipe: Consistent between 125-130 watts for both TEO and Wt. TEO
>>
>> Pratik Rajesh Sampat (1):
>>    Weighted approach to gather and use history in TEO governor
>>
>>   drivers/cpuidle/governors/teo.c | 96 +++++++++++++++++++++++++++++++--
>>   1 file changed, 91 insertions(+), 5 deletions(-)
>>
>> --
>> 2.17.1
> I also tried Giovanni's and Mel's mmtests, (uses idle states 0 and 1 a lot)
> but couldn't extract the performance report. [7]
>
> Old sweep test, which doesn't produce performance data. [8]
> Old system idle test. [9]
>
> [1]http://www.smythies.com/~doug/linux/idle/wtteo/schbench/
> [2]http://www.smythies.com/~doug/linux/idle/wtteo/ebizzy/
> [3]http://www.smythies.com/~doug/linux/idle/wtteo/pn01/
> [4]http://www.smythies.com/~doug/linux/idle/wtteo/hackbench/
> [5]http://www.smythies.com/~doug/linux/idle/wtteo/hackbench2/
> [6]http://www.smythies.com/~doug/linux/idle/wtteo/hackbench3/
> [7]http://www.smythies.com/~doug/linux/idle/wtteo/mmtests-udp/
> [8]http://www.smythies.com/~doug/linux/idle/wtteo/sweep/
> [9]http://www.smythies.com/~doug/linux/idle/wtteo/idle/
>
> ... Doug
>
>
Thanks again for these comprehensive results.
~ Pratik

