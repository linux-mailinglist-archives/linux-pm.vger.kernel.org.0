Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 090A8C1F73
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2019 12:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730621AbfI3KoJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Sep 2019 06:44:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56176 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730851AbfI3KoI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Sep 2019 06:44:08 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8UAgXMk109108
        for <linux-pm@vger.kernel.org>; Mon, 30 Sep 2019 06:44:07 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vbdt76qrk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Mon, 30 Sep 2019 06:44:06 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <parth@linux.ibm.com>;
        Mon, 30 Sep 2019 11:44:03 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 30 Sep 2019 11:43:58 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8UAhveV23396518
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Sep 2019 10:43:57 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E3F3A4057;
        Mon, 30 Sep 2019 10:43:57 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F239A4051;
        Mon, 30 Sep 2019 10:43:54 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.35.136])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 30 Sep 2019 10:43:53 +0000 (GMT)
From:   Parth Shah <parth@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, patrick.bellasi@matbug.net,
        tim.c.chen@linux.intel.com, valentin.schneider@arm.com,
        qais.yousef@arm.com, linux-pm@vger.kernel.org
Cc:     peterz@infradead.org, vincent.guittot@linaro.org, pavel@ucw.cz,
        David.Laight@ACULAB.COM, mingo@redhat.com,
        morten.rasmussen@arm.com, pjt@google.com, dietmar.eggemann@arm.com,
        tj@kernel.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org, dhaval.giani@oracle.com,
        quentin.perret@arm.com,
        subhra mazumdar <subhra.mazumdar@oracle.com>,
        ggherdovich@suse.cz, viresh.kumar@linaro.org,
        Doug Smythies <dsmythies@telus.net>
Subject: [Discussion v2] Usecases for the per-task latency-nice attribute
Date:   Mon, 30 Sep 2019 16:13:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19093010-0012-0000-0000-0000035204E5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19093010-0013-0000-0000-0000218CA691
Message-Id: <2bd46086-43ff-f130-8720-8eec694eb55b@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-30_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909300116
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello everyone,

This is the v2 of the discussion started for introducing per-task
latency-nice attribute for providing scheduler hints.

v1: https://lkml.org/lkml/2019/9/18/555

In brief, we face two challenges with the introduction of such attr.

1. Name:
==============
( Should be relevant to all the possible usecases, not confuse end-user and
reflect the functionality it provides to the scheduler behaviour )

Curated list of proposed names:

1. latency-nice:
   should have a better understanding based on pre-existing concepts

- But poses two interpretation ambiguity
  a) -20 (least nice to latency, i.e. sacrifice latency for throughput)
     +19 (most nice to latency, i.e. sacrifice throughput for latency)
  b) -20 (least nice to other task in terms of sacrificing latency, i.e.
	  latency-sensitive)
     +19 (most nice to other tasks in terms of sacrificing latency, i.e.
	  latency-forgoing)

2. latency-tolerant:
   decouples a bit its meaning from the niceness thus giving maybe a bit
   more freedom in its complete definition and perhaps avoid any
   possible interpretation confusion

3. latency-nasty

4. latency-sensible



2. Value(s):
==============
( Boolean/Ternary, Range of values, profile tagging )

- Recent discussion plots the range of [-20, 19] to be the most agreed upon.

1. Range:
- [-20, 19]:
    Which has similarities with the niceness concept and gives a minimal
    continuous range. This can be on hand for things like scaling the
    vruntime normalization [3]

2. Profile tagging:
- Can be used just like a flag attribute
  e.g., Background, foreground, latency-sensible, reduce-idle-search, etc.

3. Binary:
- 0 for: Latency sensitive/sensible/in-tolerant/hungry...
- 1 for Latency insensitive/insensible/tolerant/nice-to-others/...

  Ternary:
-  0: no effect
- -1: require least latency
- +1: no restrictions in terms of lower/higher latency


------------------
**Usecases**
-----------------

1> Reduce search scan time for idle Cores
( -Subhra Mazumadar )
=====================================
Currently, CFS makes search across LLC domain to search for idle core which
is sometimes exhaustive when the core count increases beyond certain count.
This impacts the latency-sensitive tasks where scheduler spends much of it
time to search for idle core to wakeup a task. This could potentially be
solved by limiting the idle core search for the tasks which requires least
latency. The userland providing hints to the scheduler by tagging such
tasks is a solution proposed in the community and has shown positive
results [1].


2> TurboSched
( -Parth Shah )
====================
TurboSched [2] tries to minimize the number of active cores in a socket by
packing an un-important and low-utilization (named jitter) task on an
already active core and thus refrains from waking up of a new core if
possible. This requires tagging of tasks from the userspace hinting which
tasks are un-important and thus waking-up a new core to minimize the
latency is un-necessary for such tasks.
As per the discussion on the posted RFC, it will be appropriate to use the
task latency property where a task with the highest latency-nice value can
be packed.
But for this specific use-cases, having just a binary value to know which
task is latency-sensitive and which not is sufficient enough, but having a
range is also a good way to go where above some threshold the task can be
packed.


3> Wakeup path tunings
( -Patrick Bellasi )
==========================
Some additional possible use-cases was already discussed in [3]:

 - dynamically tune the policy of a task among SCHED_{OTHER,BATCH,IDLE}
   depending on crossing certain pre-configured threshold of latency
   niceness.

 - dynamically bias the vruntime updates we do in place_entity()
   depending on the actual latency niceness of a task.
   Tuning the tweaks we already have for:
	 - START_DEBIT
	 - GENTLE_FAIR_SLEEPERS
   a bit more parametric and proportional to the latency-nice of a task.

 - bias the decisions we take in check_preempt_tick() still depending
   on a relative comparison of the current and wakeup task latency
   niceness values.


4> Load balance tuning
( -Valentin Schneider )
======================
Already mentioned these in [4]:
- Increase (reduce) nr_balance_failed threshold when trying to active
  balance a latency-sensitive (non-latency-sensitive) task.

- Increase (decrease) sched_migration_cost factor in task_hot() for
  latency-sensitive (non-latency-sensitive) tasks.


5> Separating AVX512 tasks and latency sensitive tasks on separate cores
( -Tim Chen )
===========================================================================
Another usecase we are considering is to segregate those workload that will
pull down core cpu frequency (e.g. AVX512) from workload that are latency
sensitive. There are certain tasks that need to provide a fast response
time (latency sensitive) and they are best scheduled on cpu that has a
lighter load and not have other tasks running on the sibling cpu that could
pull down the cpu core frequency.

Some users are running machine learning batch tasks with AVX512, and have
observed that these tasks affect the tasks needing a fast response.  They
have to rely on manual CPU affinity to separate these tasks.  With
appropriate latency hint on task, the scheduler can be taught to separate them.


6> EAS
( -Qais Yousef )
====================
The new knob can help EAS path to switch to spreading behavior when
latency-nice is set instead of packing tasks on the most energy efficient CPU.
ie: pick the most energy efficient idle CPU.



Further doubts requiring community attention
---------------------------------------------
1. Who is the intended user for setting this value? (- Qais Yousef)
   - system admin or application developer ?


Thanks everyone for providing your valuable inputs, hence again asking for
the same. (◠﹏◠)

---------------
**References**
---------------
[1]. https://lkml.org/lkml/2019/8/30/829
[2]. https://lkml.org/lkml/2019/7/25/296
[3]. Message-ID: <20190905114709.GM2349@hirez.programming.kicks-ass.net>
https://lore.kernel.org/lkml/20190905114709.GM2349@hirez.programming.kicks-ass.net/
[4]. https://lkml.kernel.org/r/3d3306e4-3a78-5322-df69-7665cf01cc43@arm.com

