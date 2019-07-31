Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 282307C8E1
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 18:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729830AbfGaQjv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 12:39:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64404 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729820AbfGaQjv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2019 12:39:51 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6VGcp01027035
        for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2019 12:39:50 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u3d8bmt5q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2019 12:39:46 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <parth@linux.ibm.com>;
        Wed, 31 Jul 2019 17:39:32 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 31 Jul 2019 17:39:29 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6VGdSqj47972570
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Jul 2019 16:39:28 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B7AFE42049;
        Wed, 31 Jul 2019 16:39:28 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D81B942047;
        Wed, 31 Jul 2019 16:39:25 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.49.237])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 31 Jul 2019 16:39:25 +0000 (GMT)
Subject: Re: [RFC v4 0/8] TurboSched: A scheduler for sustaining Turbo
 Frequencies for longer durations
To:     Pavel Machek <pavel@ucw.cz>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        patrick.bellasi@arm.com, dietmar.eggemann@arm.com,
        daniel.lezcano@linaro.org, subhra.mazumdar@oracle.com
References: <20190725070857.6639-1-parth@linux.ibm.com>
 <20190728133102.GD8718@xo-6d-61-c0.localdomain>
From:   Parth Shah <parth@linux.ibm.com>
Date:   Wed, 31 Jul 2019 22:09:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20190728133102.GD8718@xo-6d-61-c0.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19073116-0028-0000-0000-00000389B4C2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19073116-0029-0000-0000-0000244A0661
Message-Id: <4fcd3488-6ba0-bc22-a08d-ceebbce1c120@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-31_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907310166
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 7/28/19 7:01 PM, Pavel Machek wrote:
> Hi!
> 
>> Abstract
>> ========
>>
>> The modern servers allows multiple cores to run at range of frequencies
>> higher than rated range of frequencies. But the power budget of the system
>> inhibits sustaining these higher frequencies for longer durations.
> 
> Thermal budget?

Right, it is a good point, and there can be possibility of Thermal throttling
which is not covered here.
But the thermal throttling is less often seen in the servers than the throttling
due to the Power budget constraints. Also one can change the power cap which leads
to increase in the throttling and task packing can handle in such cases.

BTW, Task packing allows few more cores to remain idle for longer time, so
shouldn't this decrease thermal throttles upto certain extent?

> 
> Should this go to documentation somewhere?
> 

Sure, I can add to the Documentation/scheduler or under selftest.

>> Current CFS algorithm in kernel scheduler is performance oriented and hence
>> tries to assign any idle CPU first for the waking up of new tasks. This
>> policy is perfect for major categories of the workload, but for jitter
>> tasks, one can save energy by packing them onto the active cores and allow
>> those cores to run at higher frequencies.
>>
>> These patch-set tunes the task wake up logic in scheduler to pack
>> exclusively classified jitter tasks onto busy cores. The work involves the
>> jitter tasks classifications by using syscall based mechanisms.
>>
>> In brief, if we can pack jitter tasks on busy cores then we can save power
>> by keeping other cores idle and allow busier cores to run at turbo
>> frequencies, patch-set tries to meet this solution in simplest manner.
>> Though, there are some challenges in implementing it(like smt_capacity,
> 
> Space before (.

My bad, somehow missed it. Thanks for pointing out.

> >> These numbers are w.r.t. `turbo_bench.c` multi-threaded test benchmark
>> which can create two kinds of tasks: CPU bound (High Utilization) and
>> Jitters (Low Utilization). N in X-axis represents N-CPU bound and N-Jitter
>> tasks spawned.
> 
> Ok, so you have description how it causes 13% improvements. Do you also have metrics how
> it harms performance.. how much delay is added to unimportant tasks etc...?
> 

Yes, if we try to pack the tasks despite of no frequency throttling, we see a regression
around 5%. For instance, in the synthetic benchmark I used to show performance benefit,
for lower count of CPU intensive threads (N=2) there is -5% performance drop.

Talking about the delay added to an unimportant tasks, the result can be lower throughput
or higher latency for such tasks.

1. Throughput
For instance, when classifying 8 running tasks as jitters, we can have performance
drop "based on the task characteristics".

Below table shows the performance (total operations performed) drop observed when
jitters have different utilization on a CPU set at max Frequency.
+-------------------+-------------+
| Utilization(in %) | Performance |
+-------------------+-------------+
| 10-20             | -0.32%      |
| 30-40             | -0.003%     |
+-------------------+-------------+

Jitters here are frequency insensitive and does only X-operations in N-period time. Hence
it doesn't show much drop in throughput.

2.  Latency
The wakeup latency of the jitter tasks gives below results
Test-1:
- 8 CPU intensive tasks, 40 jitter low utilization tasks
+-------+-------------+--------------+
| %ile  | w/o patches | with patches |
+-------+-------------+--------------+
| Min   |           3 | 5 (-66%)     |
| 50    |          64 | 64 (0%)      |
| 90    |          66 | 67 (-1.5%)   |
| 99    |          67 | 68 (-1.4%)   |
| 99.99 |          78 | 439 (-462%)  |
| Max   |         159 | 1023 (-543%) |
+-------+-------------+--------------+

Test-2:
- 8 CPU intensive tasks, 8 jitter tasks
+-------+-------------+--------------+
| %ile  | w/o patches | with patches |
+-------+-------------+--------------+
| Min   |           4 | 6 (-50%)     |
| 50    |          65 | 55 (+15%)    |
| 90    |          65 | 55 (+15%)    |
| 99    |          66 | 56 (+15%)    |
| 99.99 |          76 | 69 (+9%)     |
| Max   |          78 | 672 (-761%)  |
+-------+-------------+--------------+

Note: I used the synthetic workload generator to compute wakeup latency for jitter tasks,
the source code for the same can be found at
https://github.com/parthsl/tools/blob/master/benchmarks/turbosched_delay.c


Also, the jitter tasks would create regression on CPU intensive tasks when placed
on the sibling thread, but the performance gain with sustained frequency is more
enough here to overcome this regression. Hence, if there is no throttling, there
will be performance penalty for both the type of tasks.


Thanks,
Parth

