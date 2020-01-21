Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3888143720
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2020 07:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgAUGdS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jan 2020 01:33:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14220 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727817AbgAUGdS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jan 2020 01:33:18 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00L6WcJb022268
        for <linux-pm@vger.kernel.org>; Tue, 21 Jan 2020 01:33:18 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xmgdknv9r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Tue, 21 Jan 2020 01:33:17 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <parth@linux.ibm.com>;
        Tue, 21 Jan 2020 06:33:15 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 21 Jan 2020 06:33:11 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00L6XAgO48890036
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jan 2020 06:33:10 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 57696A4053;
        Tue, 21 Jan 2020 06:33:10 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58B42A4057;
        Tue, 21 Jan 2020 06:33:08 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.35.158])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 21 Jan 2020 06:33:08 +0000 (GMT)
From:   Parth Shah <parth@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, patrick.bellasi@matbug.net,
        valentin.schneider@arm.com, pavel@ucw.cz, dsmythies@telus.net,
        qperret@google.com, tim.c.chen@linux.intel.com
Subject: [RFC v6 0/5] TurboSched: A scheduler for sustaining Turbo Frequencies for longer durations
Date:   Tue, 21 Jan 2020 12:03:02 +0530
X-Mailer: git-send-email 2.17.2
X-TM-AS-GCONF: 00
x-cbid: 20012106-4275-0000-0000-000003997BEF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012106-4276-0000-0000-000038AD8348
Message-Id: <20200121063307.17221-1-parth@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-21_01:2020-01-20,2020-01-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 bulkscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 adultscore=0 malwarescore=0 impostorscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001210056
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is the 5th version of the patch series to sustain Turbo frequencies
for longer durations.

The previous versions can be found here:
v5: https://lkml.org/lkml/2019/10/7/118
v4: https://lkml.org/lkml/2019/7/25/296
v3: https://lkml.org/lkml/2019/6/25/25
v2: https://lkml.org/lkml/2019/5/15/1258
v1: https://lwn.net/Articles/783959/

The changes in this versions are:
v5 -> v6:
- Addressed comments from Vincent Guittot and Hillf Danton
- Re based the series on the top of latency_nice patch series defined at
  https://lkml.org/lkml/2020/1/16/319. This allows [1] to use the
  latency_nice framework for small background tasks classification from the
  userspace.
ToDo:
- Add Documentation for TurboSched including possible regression as per the
  comment from Pavel Machek

v4 -> v5:
- Remove Core capacity calculation for finding non-idle core
- Use idle_cpu() and cpu_overutilized() to find the core for task packing
- This changes functionality a bit. Updated new results for POWER9 system
- Re-named ambiguous naming "jitter" to "small background" tasks

v3 -> v4:
- Based on Patrick Bellasi's comments, removed the use of UCLAMP based
  mechanism to classify tasks as jitter
- Added support to sched_setattr to mark the task as jitter by adding a new
  flag to the existing task_struct->flags attribute. This is decided to not
  have any new variable inside task_struct and thus get rid of size
  bloating.
- No functional changes

v2 -> v3:
- Added a new attribute in task_struct to allow per task jitter
  classification so that scheduler can use this as request to change wakeup
  path for task packing
- Use syscall for jitter classification, removed cgroup based task
  classification
- Use mutex over spinlock to get rid of task sleeping problem
- Changed _Bool->int everywhere
- Split few patches to have arch specific code separate from core scheduler
  code

v1 -> v2:
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
manner by only packing tasks with latency_nice==19 and util <= 12.5%.


Implementation
==============

These patches uses latency_nice [3] syscall based mechanism to classify the
tasks as small background noises. The task wakeup logic uses this
information to pack such tasks onto cores which are already running busy
with CPU intensive tasks.  The task packing is done at
`select_task_rq_fair` only so that in case of wrong decision load balancer
may pull the classified background tasks for maximizing performance.

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
POWER 9 system shows the frequency benefit can be up to 18% which can be
translated to the maximum workload benefit up to 14%.

(higher is better)

                 Frequency benefit of TurboSched w.r.t. CFS               
   +-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+
20 +-+ + + +  + + + + + + + +  + + + + + + + +  + + + + + + + +  + + + +-+
   |                    **                Frequency benefit in %         |
   |                    **                                               |
15 +-+                  **                                             +-+
   |              ****  **  **                                           |
   |            * ****  ******                                           |
10 +-+          * ****  ******                                         +-+
   |            * ****  ******                                           |
   |          * * ************   *                                       |
 5 +-+        * * ************ * *   **                                +-+
   |       ** * * ************ * *   ****                                |
 0 +-******** * * ************ * * ************ * * * ********** * * * **+
   |   **                                                                |
   |                                                                     |
-5 +-+                                                                 +-+
   | + + + +  + + + + + + + +  + + + + + + + +  + + + + + + + +  + + + + |
   +-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+
     0 1 2 3  4 5 6 7 8 91011 1213141516171819 2021222324252627 28293031  
                           No. of workload threads                        

                 Performance benefit of TurboSched w.r.t. CFS             
20 +-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+
   | + + + +  + + + + + + + +  + + + + + + + +  + + + + + + + +  + + + + |
   |                                    Performance benefit in %         |
15 +-+                  **                                             +-+
   |                    **                                               |
   |                    ******                                           |
10 +-+                  ******                                         +-+
   |                **********                                           |
   |              ************                                           |
 5 +-+            ************   *     **                              +-+
   |              ************   *   ****                                |
   |            * ************ * *   ******  **                          |
 0 +-******** * * ************ * * ************ * * * ********** * * * **+
   |                                       **             **     *       |
   |                                                                     |
-5 +-+                                                                 +-+
   | + + + +  + + + + + + + +  + + + + + + + +  + + + + + + + +  + + + + |
   +-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+
     0 1 2 3  4 5 6 7 8 91011 1213141516171819 2021222324252627 28293031  
                           No. of workload threads                        
                                                                       

These numbers are w.r.t. `turbo_bench.c` multi-threaded test benchmark
which can create two kinds of tasks: CPU bound (High Utilization) and
Background (Low Utilization). N in X-axis represents N-CPU bound and
N-background tasks spawned. The performance (Operations per Seconds) graph
indicates the benefit with TurboSched can be upto 14% compared to the CFS
task placement strategy for such background classified tasks.


Series organization
==============
- Patches 1-2: Small background tasks classification using syscall
- Patch   3  : Tune CFS task wakeup logic to pack tasks onto busy cores
- Patches 4-5: Change non-idle core search domain to LLC by default and
  	       provide arch hooks to change to NUMA for powerpc.

Series can be applied on top of latency_nice attribute introduction
patches [3].


References
==========
[1]. Usecases for the per-task latency-nice attribute,
     https://lkml.org/lkml/2019/9/30/215
[2]. Test Benchmark: turbobench,
     https://github.com/parthsl/tools/blob/master/benchmarks/turbo_bench.c
[3]. Introduce per-task latency_nice for scheduler hints,
     https://lkml.org/lkml/2020/1/16/319


Parth Shah (5):
  sched: Introduce switch to enable TurboSched for task packing
  sched/core: Update turbo_sched count only when required
  sched/fair: Tune task wake-up logic to pack small background tasks on
    fewer cores
  sched/fair: Provide arch hook to find domain for non idle core search
    scan
  powerpc: Set turbo domain to NUMA node for task packing

 arch/powerpc/include/asm/topology.h |  3 +
 arch/powerpc/kernel/smp.c           |  7 +++
 kernel/sched/core.c                 | 37 +++++++++++
 kernel/sched/fair.c                 | 95 ++++++++++++++++++++++++++++-
 kernel/sched/sched.h                | 15 +++++
 5 files changed, 156 insertions(+), 1 deletion(-)

-- 
2.17.2

