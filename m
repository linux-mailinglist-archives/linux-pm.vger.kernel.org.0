Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A09325221E
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2019 06:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfFYEhg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 00:37:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63252 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726053AbfFYEhg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jun 2019 00:37:36 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5P4XkiU011623
        for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2019 00:37:34 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tb9sadva0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2019 00:37:34 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <parth@linux.ibm.com>;
        Tue, 25 Jun 2019 05:37:32 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 25 Jun 2019 05:37:29 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5P4bJkf38928884
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jun 2019 04:37:19 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C82F511C05B;
        Tue, 25 Jun 2019 04:37:28 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9541011C04A;
        Tue, 25 Jun 2019 04:37:27 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.35.87])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 25 Jun 2019 04:37:27 +0000 (GMT)
From:   Parth Shah <parth@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com
Subject: [RFCv3 0/8] TurboSched: A scheduler for sustaining Turbo Frequencies for longer durations
Date:   Tue, 25 Jun 2019 10:07:18 +0530
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 19062504-0012-0000-0000-0000032C1B4D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062504-0013-0000-0000-000021654EDC
Message-Id: <20190625043726.21490-1-parth@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-25_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906250036
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


This is the 3rd version of the patchset to sustain Turbo frequencies for
longer durations.

The previous versions can be found here:
v2: https://lkml.org/lkml/2019/5/15/1258
v1: https://lwn.net/Articles/783959/

The changes in this versions are:
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
ToDo:
- Recompute core capacity only during CPU-Hotplug operation
- Remove smt capacity 

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
and/or bursty "jitter tasks" and waking up new core is expensive for such
case.

Current CFS algorithm in kernel scheduler is performance oriented and hence
tries to assign any idle CPU first for the waking up of new tasks. This
policy is perfect for major categories of the workload, but for jitter
tasks, one can save energy by packing them onto the active cores and allow
those cores to run at higher frequencies.

These patch-set tunes the task wake up logic in scheduler to pack
exclusively classified jitter tasks onto busy cores. The work involves the
jitter tasks classifications by using syscall based mechanisms.

In brief, if we can pack jitter tasks on busy cores then we can save power
by keeping other cores idle and allow busier cores to run at turbo
frequencies, patch-set tries to meet this solution in simplest manner.
Though, there are some challenges in implementing it(like smt_capacity,
un-needed arch hooks, etc) and I'm trying to work around that, it would be
great to have a discussion around this patches.


Implementation
==============

These patches uses UCLAMP mechanism[2] used to clamp utilization from the
userspace, which can be used to classify the jitter tasks. The task wakeup
logic uses this information to pack such tasks onto cores which are already
running busy with CPU intensive tasks. The task packing is done at
`select_task_rq_fair` only so that in case of wrong decision load balancer
may pull the classified jitter tasks for maximizing performance.

Any tasks clamped with cpu.util.max=1 (with sched_setattr syscall) are
classified as jitter tasks. We define a core to be non-idle if it is over
12.5% utilized of its capacity; the jitters are packed over these cores
using First-fit approach.

To demonstrate/benchmark, one can use a synthetic workload generator
`turbo_bench.c`[1] available at
https://github.com/parthsl/tools/blob/master/benchmarks/turbo_bench.c

Following snippet demonstrates the use of TurboSched feature:
```
i=8; ./turbo_bench -t 30 -h $i -n $((i*2)) -j
```

Current implementation uses only jitter classified tasks to be packed on
the first busy cores, but can be further optimized by getting userspace
input of important tasks and keeping track of such tasks. This leads to
optimized searching of non idle cores and also more accurate as userspace
hints are safer than auto classified busy cores/tasks.


Result
======

The patch-set proves to be useful for the system and the workload where
frequency boost is found to be useful than packing tasks into cores. IBM
POWER 9 system shows the benefit for a workload can be up to 13%.

                Performance benefit of TurboSched w.r.t. CFS 
   +--+--+--+--+--+--+-+--+--+--+--+--+--+--+--+--+--+--+-+--+--+--+--+--+
   |  +  +  +  +  +  + +  +  +  +  +  +  +  +  +  +  +  + +  +  +  +  +  |
15 +-+                                  Performance benefit in %       +-+
   |                         **                                          |
   |                         ** **                                       |
10 +-+                       ** ** **                                  +-+
   |                         ** ** **                                    |
   |                         ** ** **                                    |
 5 +-+                 ** ** ** ** **    **                            +-+
   |                   ** ** ** ** ** ** ** **                           |
   |                   ** ** ** ** ** ** ** ** ** **                     |
   |                 * ** ** ** ** ** ** ** ** ** ** ** *                |
 0 +-+** ** ** ** ** * ** ** ** ** ** ** ** ** ** ** ** * ** ** ** ** **-+
   |  ** ** ** **                                                        |
   |  **                                                                 |
-5 +-+                                                                 +-+
   |  +  +  +  +  +  + +  +  +  +  +  +  +  +  +  +  +  + +  +  +  +  +  |
   +--+--+--+--+--+--+-+--+--+--+--+--+--+--+--+--+--+--+-+--+--+--+--+--+
      2  3  4  5  6  7 8  9 10 11 12 13 14 15 16 17 18 1920 21 22 23 24   
                           No. of workload threads                        


                      Frequency benefit of TurboSched w.r.t. CFS
   +--+--+--+--+--+--+-+--+--+--+--+--+--+--+--+--+--+--+-+--+--+--+--+--+
   |  +  +  +  +  +  + +  +  +  +  +  +  +  +  +  +  +  + +  +  +  +  +  |
15 +-+                                    Frequency benefit in %       +-+
   |                         **                                          |
   |                         **                                          |
10 +-+            **         **                                        +-+
   |              **         ** **                                       |
   |        **    ** * **    ** **                                       |
 5 +-+      ** ** ** * ** ** ** **                                     +-+
   |     ** ** ** ** * ** ** ** **    **                                 |
   |  ** ** ** ** ** * ** ** ** ** ** **                                 |
   |  ** ** ** ** ** * ** ** ** ** ** ** ** ** **                        |
 0 +-+** ** ** ** ** * ** ** ** ** ** ** ** ** ** ** ** * ** ** ** ** **-+
   |                                                                     |
   |                                                                     |
-5 +-+                                                                 +-+
   |  +  +  +  +  +  + +  +  +  +  +  +  +  +  +  +  +  + +  +  +  +  +  |
   +--+--+--+--+--+--+-+--+--+--+--+--+--+--+--+--+--+--+-+--+--+--+--+--+
      2  3  4  5  6  7 8  9 10 11 12 13 14 15 16 17 18 1920 21 22 23 24   
                             No. of workload threads                      

 
These numbers are w.r.t. `turbo_bench.c` multi-threaded test benchmark
which can create two kinds of tasks: CPU bound (High Utilization) and
Jitters (Low Utilization). N in X-axis represents N-CPU bound and N-Jitter
tasks spawned.


Series organization
==============
- Patches [01-03]: Jitter tasks classification using syscall
- Patches [04-05]: Defines Core Capacity to limit task packing
- Patches [06-08]: Tune CFS task wakeup logic to pack tasks onto busy
  cores

Series can be applied on top of Patrick Bellasi's UCLAMP RFCv9[2]
patches with branch on tip/sched/core and UCLAMP_TASK_GROUP config
options enabled.


References
==========

[1] "Turbo_bench: Synthetic workload generator"
https://github.com/parthsl/tools/blob/master/benchmarks/turbo_bench.c

[2] "Patrick Bellasi, Add utilization clamping support"
https://lkml.org/lkml/2019/5/15/212



Parth Shah (8):
  sched/core: Add manual jitter classification using sched_setattr
    syscall
  sched: Introduce switch to enable TurboSched mode
  sched/core: Update turbo_sched count only when required
  sched/fair: Define core capacity to limit task packing
  powerpc: Define Core Capacity for POWER systems
  sched/fair: Tune task wake-up logic to pack jitter tasks
  sched/fair: Bound non idle core search within LLC domain
  powerpc: Set turbo domain to NUMA node for task packing

 arch/powerpc/include/asm/topology.h |   7 ++
 arch/powerpc/kernel/smp.c           |  38 ++++++++
 include/linux/sched.h               |   6 ++
 kernel/sched/core.c                 |  35 +++++++
 kernel/sched/fair.c                 | 141 +++++++++++++++++++++++++++-
 kernel/sched/sched.h                |   9 ++
 6 files changed, 235 insertions(+), 1 deletion(-)

-- 
2.17.1

