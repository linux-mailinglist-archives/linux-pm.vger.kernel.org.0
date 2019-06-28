Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBBC5A132
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2019 18:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfF1Qma (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Jun 2019 12:42:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53298 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726667AbfF1Qma (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Jun 2019 12:42:30 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5SGfxYW009954
        for <linux-pm@vger.kernel.org>; Fri, 28 Jun 2019 12:42:27 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tdkvuevg2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Fri, 28 Jun 2019 12:42:26 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <parth@linux.ibm.com>;
        Fri, 28 Jun 2019 17:42:24 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 28 Jun 2019 17:42:20 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5SGgJLF32899302
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 16:42:19 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C3804A405B;
        Fri, 28 Jun 2019 16:42:19 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 016B6A4051;
        Fri, 28 Jun 2019 16:42:18 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.62.39])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 28 Jun 2019 16:42:17 +0000 (GMT)
From:   Parth Shah <parth@linux.ibm.com>
Subject: Re: [RFCv3 0/8] TurboSched: A scheduler for sustaining Turbo
 Frequencies for longer durations
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, dietmar.eggemann@arm.com
References: <20190625043726.21490-1-parth@linux.ibm.com>
 <20190628131430.qmbfocgujeyi3dbt@e110439-lin>
Date:   Fri, 28 Jun 2019 22:12:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20190628131430.qmbfocgujeyi3dbt@e110439-lin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19062816-0012-0000-0000-0000032D73CB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062816-0013-0000-0000-00002166B72D
Message-Id: <95d58f4e-4429-d3d6-0962-bb33a9aa4b75@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-28_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906280191
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Patrick,

Thank you for taking interest at the patch set.


On 6/28/19 6:44 PM, Patrick Bellasi wrote:
> On 25-Jun 10:07, Parth Shah wrote:
> 
> [...]
> 
>> Implementation
>> ==============
>>
>> These patches uses UCLAMP mechanism[2] used to clamp utilization from the
>> userspace, which can be used to classify the jitter tasks. The task wakeup
>> logic uses this information to pack such tasks onto cores which are already
>> running busy with CPU intensive tasks. The task packing is done at
>> `select_task_rq_fair` only so that in case of wrong decision load balancer
>> may pull the classified jitter tasks for maximizing performance.
>>
>> Any tasks clamped with cpu.util.max=1 (with sched_setattr syscall) are
>> classified as jitter tasks.
> 
> I don't like this approach, it's overloading the meaning of clamps and
> it also brings in un-wanted side effects, like running jitter tasks at
> the minimum OPP.
> 
> Do you have any expected minimum frequency for those jitter tasks ?
> I expect those to be relatively small tasks but still perhaps it makes
> sense to run them on higher then minimal OPP.
>

I absolutely agree with you as it may overload the meaning of clamps.
AFAIK, the only way to detect jitters is by looking at its utilization,
where low util tasks are possibly jitters unless they are important tasks. If
userspace tells if the task is clamped to least OPP, then it is an indication of
low utilization or unimportant tasks, which we say a jitter.

Also, as we discussed in OSPM as well, if all the jitters are given a dedicated
core by the scheduler, then UCLAMP ensures least OPP for such tasks which can help
saving power a further bit, which can be channeled to busier core thus allowing
them to sustain or boost turbo frequencies.

I agree that it may have side-effects but I'm just putting idea out here.
Also, I understand that task packing and frequency are not co-related but for
this specific purpose of Turbo sustaining problem, jitters should be given least
power so that others can have extra one, hence jitters should be given less
frequency.

> Why not just adding a new dedicated per-task scheduling attribute,
> e.g. SCHED_FLAG_LATENCY_TOLERANT, and manage it via
> sched_{set,get}attr() ?
> 
> I guess such a concept could work well on defining a generic
> spread-vs-pack wakeup policy which is something Android also could
> benefit from.
> 

I have made attempts to use per-task attributes for task classification in first
series of TurboSched and it works fine.
https://lwn.net/ml/linux-pm/20190322060621.27021-3-parth015@linux.vnet.ibm.com/

Then from inputs from Dietmar, I thought of giving a try to UCLAMP for this purpose.
But, now I guess having one more task attribute is useful as it can serve multiple
purpose including android and task packing. I will add it v4 then.

> However, what we will still be missing is a proper cgroups support.
> Not always is possible and/or convenient to explicitly set per-task
> attributes. But at the same time, AFAIK using cgroups to define
> task properties which do not represent a "resource repartition" is
> something very difficult to get accepted mainline.
> 

Yeah, I faced that problem in v2.
https://lkml.org/lkml/2019/5/15/1395

> In the past, back in 2011, there was an attempt to introduce a timer
> slack controller, but apparently it was not very well received:
> 
>    Message-ID: <1300111524-5666-1-git-send-email-kirill@shutemov.name>
>    https://lore.kernel.org/lkml/20110314164652.5b44fb9e.akpm@linux-foundation.org/
> 
> But perhaps now the times are more mature and we can try to come up
> with compelling cases from both the server and the mobile world.
> 

The pointed patch series seems appealing and I will have a look at it. 

>> We define a core to be non-idle if it is over 12.5% utilized of its
>> capacity;
> 
> This looks like a random number, can you elaborate on that?

It is an experimental value to define whether a "core" should be considered to be
idle or not. This is because, even-though core is running few bunch of tasks summing
upto around 10% of utilization in a core, it maybe going to shallower idle-states
periodically which is kind of power-saving; placing new tasks on such core should
be avoided as far as possible.

I have just tested this on SMT-4/8 systems and it works as expected but at the end it
is still an experimental value.

> 
>> the jitters are packed over these cores using First-fit
>> approach.
>>
>> To demonstrate/benchmark, one can use a synthetic workload generator
>> `turbo_bench.c`[1] available at
>> https://github.com/parthsl/tools/blob/master/benchmarks/turbo_bench.c
>>
>> Following snippet demonstrates the use of TurboSched feature:
>> ```
>> i=8; ./turbo_bench -t 30 -h $i -n $((i*2)) -j
>> ```
>>
>> Current implementation uses only jitter classified tasks to be packed on
>> the first busy cores, but can be further optimized by getting userspace
>> input of important tasks and keeping track of such tasks.
>> This leads to optimized searching of non idle cores and also more
>> accurate as userspace hints are safer than auto classified busy
>> cores/tasks.
> 
> Hints from user-space looks like an interesting concept, could you
> better elaborate what you are thinking about in this sense?
> 

Currently, we are just tagging tasks as jitters and packing it on already busier
cores (>12.5% core utilization). Packing strategy is a simple first-fit algorithm
looking for first core in a DIE where the waking-up jitter task can be accommodated.
This is a lot of work in fast-path but can be optimized out. If user can also tag
CPU intensive and/or important tasks then we can keep track of the cores occupying
such tasks which can be used for task packing reducing the effort of finding non-idle.
Again, this can be set with UCLAMP by cpu.util-min=SCHED_CAPACITY_SCALE.

Infact, v1 does this but then I thought of breaking down problem into steps and this
optimization can be introduced later.
https://lwn.net/ml/linux-pm/20190322060621.27021-6-parth015@linux.vnet.ibm.com/

So we can have some task attributes like task_type or similar which hints scheduler on
several features like packing, spreading, or giving dedicated core where siblings will
not be scheduled or even core scheduling, which in certain ways affect scheduling
decisions.


Thanks
Parth

