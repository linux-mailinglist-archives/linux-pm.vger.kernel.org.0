Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52F5A59CBE
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2019 15:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfF1NOe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Jun 2019 09:14:34 -0400
Received: from foss.arm.com ([217.140.110.172]:47914 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726606AbfF1NOe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 28 Jun 2019 09:14:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 843D12B;
        Fri, 28 Jun 2019 06:14:33 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E2AD3F706;
        Fri, 28 Jun 2019 06:14:32 -0700 (PDT)
Date:   Fri, 28 Jun 2019 14:14:30 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Parth Shah <parth@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, dietmar.eggemann@arm.com
Subject: Re: [RFCv3 0/8] TurboSched: A scheduler for sustaining Turbo
 Frequencies for longer durations
Message-ID: <20190628131430.qmbfocgujeyi3dbt@e110439-lin>
References: <20190625043726.21490-1-parth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625043726.21490-1-parth@linux.ibm.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25-Jun 10:07, Parth Shah wrote:

[...]

> Implementation
> ==============
> 
> These patches uses UCLAMP mechanism[2] used to clamp utilization from the
> userspace, which can be used to classify the jitter tasks. The task wakeup
> logic uses this information to pack such tasks onto cores which are already
> running busy with CPU intensive tasks. The task packing is done at
> `select_task_rq_fair` only so that in case of wrong decision load balancer
> may pull the classified jitter tasks for maximizing performance.
> 
> Any tasks clamped with cpu.util.max=1 (with sched_setattr syscall) are
> classified as jitter tasks.

I don't like this approach, it's overloading the meaning of clamps and
it also brings in un-wanted side effects, like running jitter tasks at
the minimum OPP.

Do you have any expected minimum frequency for those jitter tasks ?
I expect those to be relatively small tasks but still perhaps it makes
sense to run them on higher then minimal OPP.

Why not just adding a new dedicated per-task scheduling attribute,
e.g. SCHED_FLAG_LATENCY_TOLERANT, and manage it via
sched_{set,get}attr() ?

I guess such a concept could work well on defining a generic
spread-vs-pack wakeup policy which is something Android also could
benefit from.

However, what we will still be missing is a proper cgroups support.
Not always is possible and/or convenient to explicitly set per-task
attributes. But at the same time, AFAIK using cgroups to define
task properties which do not represent a "resource repartition" is
something very difficult to get accepted mainline.

In the past, back in 2011, there was an attempt to introduce a timer
slack controller, but apparently it was not very well received:

   Message-ID: <1300111524-5666-1-git-send-email-kirill@shutemov.name>
   https://lore.kernel.org/lkml/20110314164652.5b44fb9e.akpm@linux-foundation.org/

But perhaps now the times are more mature and we can try to come up
with compelling cases from both the server and the mobile world.

> We define a core to be non-idle if it is over 12.5% utilized of its
> capacity;

This looks like a random number, can you elaborate on that?

> the jitters are packed over these cores using First-fit
> approach.
> 
> To demonstrate/benchmark, one can use a synthetic workload generator
> `turbo_bench.c`[1] available at
> https://github.com/parthsl/tools/blob/master/benchmarks/turbo_bench.c
> 
> Following snippet demonstrates the use of TurboSched feature:
> ```
> i=8; ./turbo_bench -t 30 -h $i -n $((i*2)) -j
> ```
> 
> Current implementation uses only jitter classified tasks to be packed on
> the first busy cores, but can be further optimized by getting userspace
> input of important tasks and keeping track of such tasks.
> This leads to optimized searching of non idle cores and also more
> accurate as userspace hints are safer than auto classified busy
> cores/tasks.

Hints from user-space looks like an interesting concept, could you
better elaborate what you are thinking about in this sense?

-- 
#include <best/regards.h>

Patrick Bellasi
