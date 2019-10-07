Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07D21CDD55
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2019 10:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfJGIbF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Oct 2019 04:31:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53116 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727103AbfJGIbE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Oct 2019 04:31:04 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x978SM8Q150440
        for <linux-pm@vger.kernel.org>; Mon, 7 Oct 2019 04:31:03 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2veptygkg1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Mon, 07 Oct 2019 04:31:02 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <parth@linux.ibm.com>;
        Mon, 7 Oct 2019 09:30:59 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 7 Oct 2019 09:30:55 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x978UPBd22348050
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Oct 2019 08:30:25 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9826C11C058;
        Mon,  7 Oct 2019 08:30:54 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5545811C04C;
        Mon,  7 Oct 2019 08:30:52 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.35.220])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  7 Oct 2019 08:30:52 +0000 (GMT)
From:   Parth Shah <parth@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, patrick.bellasi@matbug.net,
        valentin.schneider@arm.com, pavel@ucw.cz, dsmythies@telus.net,
        quentin.perret@arm.com, rafael.j.wysocki@intel.com,
        tim.c.chen@linux.intel.com, daniel.lezcano@linaro.org
Subject: [RFC v5 0/6] TurboSched: A scheduler for sustaining Turbo Frequencies for longer durations
Date:   Mon,  7 Oct 2019 14:00:45 +0530
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 19100708-0008-0000-0000-0000031EBB9A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100708-0009-0000-0000-00004A3DCBB4
Message-Id: <20191007083051.4820-1-parth@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-07_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910070088
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is the 5th version of the patchset to sustain Turbo frequencies for
longer durations.

The previous versions can be found here:
v4: https://lkml.org/lkml/2019/7/25/296
v3: https://lkml.org/lkml/2019/6/25/25
v2: https://lkml.org/lkml/2019/5/15/1258
v1: https://lwn.net/Articles/783959/

The changes in this versions are:
v[4] -> v[5]:
- Remove Core capacity calculation for finding non-idle core
- Use idle_cpu() and cpu_overutilized() to find the core for task packing
- This changes functionality a bit. Updated new results for POWER9 system
- Re-named ambiguous naming "jitter" to "small background" tasks
ToDo:
- Hopefully, once the attribute like per-task latency-nice[1] is added, the
  TurboSched can leverage that as a means of background task classification
- Add Documentation for TurboSched including possible regression as per the
  comment from Pavel Machek

v[3] -> v[4]:
- Based on Patrick Bellasi's comments, removed the use of UCLAMP based
  mechanism to classify tasks as jitter
- Added support to sched_setattr to mark the task as jitter by adding a new
  flag to the existing task_struct->flags attribute. This is decided to not
  have any new variable inside task_struct and thus get rid of size
  bloating.
- No functional changes

v[2] -> v[3]:
- Added a new attribute in task_struct to allow per task jitter
  classification so that scheduler can use this as request to change wakeup
  path for task packing
- Use syscall for jitter classification, removed cgroup based task
  classification
- Use mutex over spinlock to get rid of task sleeping problem
- Changed _Bool->int everywhere
- Split few patches to have arch specific code separate from core scheduler
  code

v[1] -> v[2]:
- No CPU bound tasks' classification, only jitter tasks are classified from
  the cpu cgroup controller
- Use of Spinlock rather than mutex to count number of jitters in the
  system classified from cgroup
- Architecture specific implementation of Core capacity multiplication
  factor changes dynamically based on the number of active threads in the
  core
- Selection of non idle core in the system is bounded by DIE domain
- Use of UCLAMP mechanism to classify jitter tasks
- Removed "highutil_cpu_mask", and rather uses sd for DIE domain to find
  better fit



Abstract
========

The modern servers allows multiple cores to run at range of frequencies
higher than rated range of frequencies. But the power budget of the system
inhibits sustaining these higher frequencies for longer durations.

However when certain cores are put to idle states, the power can be
effectively channelled to other busy cores, allowing them to sustain the
higher frequency.

One way to achieve this is to pack tasks onto fewer cores keeping others
idle, but it may lead to performance penalty for such tasks and sustaining
higher frequencies proves to be of no benefit. But if one can identify
unimportant low utilization tasks which can be packed on the already active
cores then waking up of new cores can be avoided. Such tasks are short
and/or bursty "background tasks" and waking up new core is expensive for
such case.

Current CFS algorithm in kernel scheduler is performance oriented and hence
tries to assign any idle CPU first for the waking up of new tasks. This
policy is perfect for major categories of the workload, but for background
tasks, one can save energy by packing them onto the active cores and allow
those cores to run at higher frequencies.

These patch-set tunes the task wake up logic in scheduler to pack
exclusively classified background tasks onto busy cores. The work involves
the such tasks classifications by using syscall based mechanisms.

In brief, if we can pack such small background tasks on busy cores then we
can save power by keeping other cores idle and allow busier cores to run at
turbo frequencies, patch-set tries to meet this solution in simplest
manner.  Though, there are some challenges in implementing it(like
smt_capacity, un-needed arch hooks, etc) and I'm trying to work around
that, it would be great to have a discussion around this patches.


Implementation
==============

These patches uses syscall based mechanism to classify the tasks as small
background noises. The task wakeup logic uses this information to pack such
tasks onto cores which are already running busy with CPU intensive tasks.
The task packing is done at `select_task_rq_fair` only so that in case of
wrong decision load balancer may pull the classified background tasks for
maximizing performance.

We define a core to be non-idle if any CPU has >12.5% utilization and not
more than 1 CPU is overutilized (>80% utilization); the background tasks
are packed over these cores using First-fit approach.

The value 12.5% utilization indicates the CPU is sufficiently busy to not
go to deeper IDLE-states (target_residency >= 10ms) and tasks can be packed
here.

To demonstrate/benchmark, patches uses turbo_bench, a synthetic workload
generator [2].

Following snippet demonstrates the use of TurboSched feature:
```
i=8; ./turbo_bench -t 30 -h $i -n $((i*2)) -j
```
This spawns 2*i total threads: of which i-CPU bound and i-low util threads.

Current implementation uses only small background classified tasks to be
packed on the first busy cores, but can be further optimized by getting
userspace input of important tasks and keeping track of such tasks. This
leads to optimized searching of non idle cores and also more accurate as
userspace hints are safer than auto classified busy cores/tasks.


Result
======

The patch-set proves to be useful for the system and the workload where
frequency boost is found to be useful than packing tasks into cores. IBM
POWER 9 system shows the benefit for a workload can be up to 15%.

                 Frequency benefit of TurboSched w.r.t. CFS
   +-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+
20 +-+ + + +  + + + + + + + +  + + + + + + + +  + + + + + + + +  + + + +-+
   |                                      Frequency benefit in %         |
   |                  **                                                 |
15 +-+                **    **                                         +-+
   |              ************                                           |
   |       **     ************ *                                         |
10 +-+     ** *   ************ *                                       +-+
   |       ** * * ************ * *                                       |
   |     **** * * ************ * * **                                    |
 5 +-+   **** * * ************ * * ******                              +-+
   | **  **** * * ************ * * ********                              |
 0 +-******** * * ************ * * ************ * * * ********** * * * **+
   |                                                                     |
   |                                                                     |
-5 +-+                                                                 +-+
   | + + + +  + + + + + + + +  + + + + + + + +  + + + + + + + +  + + + + |
   +-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+
     1 2 3 4  5 6 7 8 9101112 1314151617181920 2122232425262728 29303132  
                           No. of workload threads                        

                                                                          
                Performance (OPS) benefit of TurboSched w.r.t. CFS       
20 +-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+
   | + + + +  + + + + + + + +  + + + + + + + +  + + + + + + + +  + + + + |
   |                                    Performance benefit in %         |
15 +-+                      **                                         +-+
   |                  **  **** *                                         |
   |                  **  **** *   **                                    |
10 +-+                ******** * * **                                  +-+
   |                ********** * * **                                    |
   |                ********** * * ******                                |
 5 +-+            ************ * * ******                              +-+
   |              ************ * * **********                            |
   |            * ************ * * ************                          |
 0 +-******** * * ************ * * ************ * * * ********** * * * **+
   |                                              * * ********** * * * **|
   |                                                                   **|
-5 +-+                                                                 +-+
   | + + + +  + + + + + + + +  + + + + + + + +  + + + + + + + +  + + + + |
   +-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+
     1 2 3 4  5 6 7 8 9101112 1314151617181920 2122232425262728 29303132  
                           No. of workload threads                        
 

These numbers are w.r.t. `turbo_bench.c` multi-threaded test benchmark
which can create two kinds of tasks: CPU bound (High Utilization) and
Background (Low Utilization). N in X-axis represents N-CPU bound and
N-background tasks spawned. The performance (Operations per Seconds) graph
indicates the benefit with TurboSched can be upto 14% compared to the CFS
task placement strategy for such background classified tasks.


Series organization
==============
- Patches [01-03]: Small background tasks classification using syscall
- Patche  [04]   : Tune CFS task wakeup logic to pack tasks onto busy cores
- Patches [05-06]: Change non-idle core search domain to LLC by default and
  		   provide arch hooks to change to NUMA for powerpc.

Series can be applied on the top of tip/sched/core at
commit af24bde8df20 ("sched/uclamp: Add uclamp support to energy_compute()")

References
==========
[1]. https://lkml.org/lkml/2019/9/30/215
[2]. https://github.com/parthsl/tools/blob/master/benchmarks/turbo_bench.c


Parth Shah (6):
  sched/core: Add manual background task classification using
    sched_setattr syscall
  sched: Introduce switch to enable TurboSched for task packing
  sched/core: Update turbo_sched count only when required
  sched/fair: Tune task wake-up logic to pack small background tasks on
    fewer cores
  sched/fair: Provide arch hook to find domain for non idle core search
    scan
  powerpc: Set turbo domain to NUMA node for task packing

 arch/powerpc/include/asm/topology.h |   3 +
 arch/powerpc/kernel/smp.c           |   7 ++
 include/linux/sched.h               |   1 +
 include/uapi/linux/sched.h          |   4 +-
 kernel/sched/core.c                 |  39 +++++++++++
 kernel/sched/fair.c                 | 104 +++++++++++++++++++++++++++-
 kernel/sched/sched.h                |   9 +++
 7 files changed, 165 insertions(+), 2 deletions(-)

-- 
2.17.1

