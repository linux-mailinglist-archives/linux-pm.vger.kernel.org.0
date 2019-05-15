Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A28181F60A
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2019 15:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfEONyY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 May 2019 09:54:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33138 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725953AbfEONyY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 May 2019 09:54:24 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4FDsApq171151
        for <linux-pm@vger.kernel.org>; Wed, 15 May 2019 09:54:23 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2sgjn3dbr2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Wed, 15 May 2019 09:54:18 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <parth@linux.ibm.com>;
        Wed, 15 May 2019 14:53:36 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 15 May 2019 14:53:34 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4FDrXMd59899980
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 May 2019 13:53:33 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D2A452052;
        Wed, 15 May 2019 13:53:33 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.102.18.182])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 1919552051;
        Wed, 15 May 2019 13:53:30 +0000 (GMT)
From:   Parth Shah <parth@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, dietmar.eggemann@arm.com,
        dsmythies@telus.net
Subject: [RFCv2 0/6] TurboSched: A scheduler for sustaining Turbo Frequencies for longer durations
Date:   Wed, 15 May 2019 19:23:16 +0530
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 19051513-0016-0000-0000-0000027C0337
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051513-0017-0000-0000-000032D8D3F5
Message-Id: <20190515135322.19393-1-parth@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-15_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905150087
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Abstract
========

The modern servers allows multiple cores to run at range of
frequencies higher than rated range of frequencies. But the power budget
of the system inhibits sustaining these higher frequencies for
longer durations.

However when certain cores are put to idle states, the power can be
effectively channelled to other busy cores, allowing them to sustain
the higher frequency.

One way to achieve this is to pack tasks onto fewer cores keeping others idle,
but it may lead to performance penalty for such tasks and sustaining higher
frequencies proves to be of no benefit. But if one can identify unimportant low
utilization tasks which can be packed on the already active cores then waking up
of new cores can be avoided. Such tasks are short and/or bursty "jitter tasks"
and waking up new core is expensive for such case.

Current CFS algorithm in kernel scheduler is performance oriented and hence
tries to assign any idle CPU first for the waking up of new tasks. This policy
is perfect for major categories of the workload, but for jitter tasks, one
can save energy by packing it onto active cores and allow other cores to run at
higher frequencies.

These patch-set tunes the task wake up logic in scheduler to pack exclusively
classified jitter tasks onto busy cores. The work involves the use of additional
attributes inside "cpu" cgroup controller to manually classify tasks as jitter. 


Implementation
==============

These patches uses UCLAMP mechanism from "cpu" cgroup controller which
can be used to classify the jitter tasks. The task wakeup logic uses
this information to pack such tasks onto cores which are busy running
other workloads. The task packing is done at `select_task_rq_fair` only
so that in case of wrong decision load balancer may pull the classified
jitter tasks to performance giving CPU.

Any tasks added to the "cpu" cgroup tagged with cpu.util.max=1 are
classified as jitter. We define a core to be non-idle if it is over
12.5% utilized; the jitters are packed over these cores using First-fit
approach.

To demonstrate/benchmark, one can use a synthetic workload generator
`turbo_bench.c` available at
https://github.com/parthsl/tools/blob/master/benchmarks/turbo_bench.c

Following snippet demonstrates the use of TurboSched feature:
```
mkdir -p /sys/fs/cgroup/cpu/jitter
echo 0 > /proc/sys/kernel/sched_uclamp_util_min;
echo 0 > /sys/fs/cgroup/cpu/jitter/cpu.util.min;
echo 0 > /sys/fs/cgroup/cpu/jitter/cpu.util.max;
i=8;
./turbo_bench -t 30 -h $i -n $i &
./turbo_bench -t 30 -h 0 -n $i &
echo $! > /sys/fs/cgroup/cpu/jitter/cgroup.procs
```

Current implementation uses only jitter classified tasks to be packed on any
busy cores, but can be further optimized by getting userspace input of
important tasks and keeping track of such tasks. This leads to optimized
searching of non idle cores and also more accurate as userspace hints
are safer than auto classified busy cores/tasks.


Result
======

The patch-set proves to be useful for the system and the workload where
frequency boost is found to be useful than packing tasks into cores. IBM POWER 9
system shows the benefit for a workload can be up to 13%.

                   Performance benefit of TurboSched over CFS                  
     +-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+   
     | + + + +  + + + + + + + +  + + + + + + + +  + + + + + + + +  + + + + |   
  15 +-+                                  Performance benefit in %       +-+   
     |                    **                                               |   
     |                    **                                               |   
  10 +-+                ********                                         +-+   
     |                  ********                                           |   
     |              ************   *                                       |   
   5 +-+            ************   *                                     +-+   
     |            * ************   * ****                                  |   
     |       ** * * ************ * * ******                                |   
     |       ** * * ************ * * ************ *                        |   
   0 +-******** * * ************ * * ************ * * * ********** * * * **+   
     |     **                                           ****               |   
     |     **                                                              |   
  -5 +-+   **                                                            +-+   
     | + + + +  + + + + + + + +  + + + + + + + +  + + + + + + + +  + + + + |   
     +-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+   
       1 2 3 4  5 6 7 8 9101112 1314151617181920 2122232425262728 29303132     
                             Workload threads count                            


                     Frequency benefit of TurboSched over CFS                   
  20 +-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+   
     | + + + +  + + + + + + + +  + + + + + + + +  + + + + + + + +  + + + + |   
     |                                      Frequency benefit in %         |   
  15 +-+                  **                                             +-+   
     |                    **                                               |   
     |              ********                                               |   
  10 +-+          * ************                                         +-+   
     |            * ************                                           |   
     |            * ************                                           |   
   5 +-+        * * ************   *                                     +-+   
     |       ** * * ************ * *                                       |   
     |     **** * * ************ * * ******                 **             |   
   0 +-******** * * ************ * * ************ * * * ********** * * * **+   
     |   **                                                                |   
     |   **                                                                |   
  -5 +-+ **                                                              +-+   
     | + + + +  + + + + + + + +  + + + + + + + +  + + + + + + + +  + + + + |   
     +-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+   
       1 2 3 4  5 6 7 8 9101112 1314151617181920 2122232425262728 29303132     
                             Workload threads count                            

These numbers are w.r.t. `turbo_bench.c` test benchmark which spawns multiple
threads of a mix of High Utilization and Low Utilization(jitters). X-axis
represents the count of both the categories of tasks spawned.


Series organization
==============
- Patches [01-03]: Cgroup based jitter tasks classification
- Patches [04]: Defines Core Capacity to limit task packing
- Patches [05-06]: Tune CFS task wakeup logic to pack tasks onto busy
  cores

Series can be applied on top of Patrick Bellasi's UCLAMP RFCv8[3]
patches with branch on tip/sched/core and UCLAMP_TASK_GROUP config
options enabled.


Changelogs
=========
This patch set is a respin of TurboSched RFCv1
https://lwn.net/Articles/783959/
which includes the following main changes

- No WOF tasks classification, only jitter tasks are classified from
  the cpu cgroup controller
- Use of Spinlock rather than mutex to count number of jitters in the
  system classified from cgroup
- Architecture specific implementation of Core capacity multiplication
  factor changes dynamically based on the number of active threads in
  the core
- Selection of non idle core in the system is bounded by DIE domain
- Use of UCLAMP mechanism to classify jitter tasks
- Removed "highutil_cpu_mask", and rather uses sd for DIE domain to find
  better fit


References
==========

[1] "TurboSched : A scheduler for sustaining Turbo frequency for longer
durations" https://lwn.net/Articles/783959/

[2] "Turbo_bench: Synthetic workload generator"
https://github.com/parthsl/tools/blob/master/benchmarks/turbo_bench.c

[3] "Patrick Bellasi, Add utilization clamping support"
https://lore.kernel.org/lkml/20190402104153.25404-1-patrick.bellasi@arm.com/


Parth Shah (6):
  sched/core: Add manual jitter classification from cgroup interface
  sched: Introduce switch to enable TurboSched mode
  sched/core: Update turbo_sched count only when required
  sched/fair: Define core capacity to limit task packing
  sched/fair: Tune task wake-up logic to pack jitter tasks
  sched/fair: Bound non idle core search by DIE domain

 arch/powerpc/include/asm/topology.h |   7 ++
 arch/powerpc/kernel/smp.c           |  37 ++++++++
 kernel/sched/core.c                 |  32 +++++++
 kernel/sched/fair.c                 | 127 +++++++++++++++++++++++++++-
 kernel/sched/sched.h                |   8 ++
 5 files changed, 210 insertions(+), 1 deletion(-)

-- 
2.17.1

