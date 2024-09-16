Return-Path: <linux-pm+bounces-14335-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBDF97A214
	for <lists+linux-pm@lfdr.de>; Mon, 16 Sep 2024 14:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D8DDB22024
	for <lists+linux-pm@lfdr.de>; Mon, 16 Sep 2024 12:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3A614F9D5;
	Mon, 16 Sep 2024 12:21:29 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9109446D1;
	Mon, 16 Sep 2024 12:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726489289; cv=none; b=KvD47/hrZcpIDnoA/WEtrMJ95v9Q8P4CbklS5WqwX3zg9Drz07XiLVxFsL8D419BHYb3f9iH1vJmy9UWyJAqZmHjKsJ3+1sPy58zN0jGDqLklmAK6IFAZDubX8Z1y7SmpXjD+YfO6t2DJT013dUiGkEt2jmF+BS5QgQsk6Xbh5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726489289; c=relaxed/simple;
	bh=AWbWNHgiLrwlQTxSpQ1d+i0Ir4h8gtzshA7DctivCSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h+GfSERFlkO2NnUOc1nQI+fVMJXqM+v6pWqRZv6X0kh52tJKPMRoQ6YOonG5YzgRJdPulDTGcKCQyQP9HGFyJFpVKNX7RcYWTH8KIxp5OtO0uxwLIA8QpYg1QJiGLRmpR27/65rU4TPNcZZI4uPd2EPunT25Mzzlqq+iKyK4klo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49A6E11FB;
	Mon, 16 Sep 2024 05:21:55 -0700 (PDT)
Received: from [192.168.2.132] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF2143F66E;
	Mon, 16 Sep 2024 05:21:23 -0700 (PDT)
Message-ID: <3b19e52e-b223-4753-b81c-5b47c8d0cf97@arm.com>
Date: Mon, 16 Sep 2024 14:21:18 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/16] sched/fair/schedutil: Better manage system
 response time
To: Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 John Stultz <jstultz@google.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240820163512.1096301-1-qyousef@layalina.io>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <20240820163512.1096301-1-qyousef@layalina.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/08/2024 18:34, Qais Yousef wrote:
> This series is a re-incarnation of Remove Hardcoded Margings posted a while ago
> 
> 	https://lore.kernel.org/lkml/20231208002342.367117-1-qyousef@layalina.io/
>

Looks like some of the ideas were already discussed under
https://lkml.kernel.org/r/20230827233203.1315953-1-qyousef@layalina.io
back in Aug/Sept 23.

> The original series attempted to address response time related issues stemming
> from hardcoding migration margin in fits_capacity() on HMP system, and DVFS
> headroom which had a constant 25% boost that is bad for power and thermal on
> powerful systems. Saving power was the main goal by reducing these values to
> the smallest possible value automatically based on anticipated worst case
> scenario.
> 
> A tricky point was uncovered and demonstrated in the migration margin table in
> this posting
> 
> 	https://lore.kernel.org/lkml/20240205223344.2280519-4-qyousef@layalina.io/
> 
> is that to make the system responsive to sudden changes, we actually need large
> migration margin the smaller the core capacity is
> 
> 	cap		threshold	%		threshold-tick	%
> 	0		0		0		0		0
> 	16		0		0		0		0
> 	32		1		3.12		0		0
> 	48		3		6.25		2		4.16
> 	64		4		6.25		2		3.12
> 	80		6		7.5		5		6.25
> 	96		10		10.41		8		8.33
> 	112		14		12.5		11		9.82
> 	128		18		14.06		16		12.5
> 	144		21		14.58		18		12.5
> 	160		26		16.25		23		14.37

Not sure what this 'misfit threshold' should be?

160 * 1024 / 1280 = 128 so threshold = 32 ?

I know that you want to make the threshold bigger for smaller CPUs
[PATCH 04/16]. I get:

update_cpu_capacity(): cpu=0 arch_scale_cpu_capacity=160
approx_runtime=8 limit=4000 rq->fits_capacity_threshold=83

for the little CPU on Pix6, I just don't know how this relates to 26 or 23.

> 	176		33		18.75		29		16.47
> 	192		39		20.31		35		18.22
> 	208		47		22.59		43		20.67
> 	224		55		24.55		50		22.32
> 	240		63		26.25		59		24.58
> 	256		73		28.51		68		26.56
> 	272		82		30.14		77		28.30
> 	288		93		32.29		87		30.20
> 	304		103		33.88		97		31.90
> 	320		114		35.62		108		33.75
> 	336		126		37.5		120		35.71
> 	352		138		39.20		132		37.5
> 	368		151		41.03		144		39.13
> 	384		163		42.44		157		40.88
> 
> The current 80% margin is valid for CPU with capacities in the 700-750 range,
> which might have been true in the original generations of HMP systems.
> 
> 	704		557		79.11		550		78.12
> 	720		578		80.27		572		79.44
> 	736		606		82.33		600		81.52
> 	752		633		84.17		627		83.37
> 
> This result contradicts the original goal of saving power as it indicates we
> must be more aggressive with the margin, while the original observation was
> that there are workloads with steady utilization that is hovering at a level
> that is higher than this margin but lower than the capacity of the CPU (mid
> CPUs particularly) and the aggressive upmigration is not desired, nor the
> higher push to run at max freq where we could have run at a lower freq with no
> impact on perf.
> 
> Further analysis using a simple rampup [1] test that spawns a busy task that
> starts from util_avg/est = 0 and never goes to sleep. The purpose is to measure
> the actual system response time for workloads that are bursty and need to
> transition from lower to higher performance level quickly.
> 
> This lead to more surprising discovery due to utilization invariance, I call it
> the black hole effect.
> 
> There's a black hole in the scheduler:
> ======================================
> 
> It is no surprise to anyone that DVFS and HMP system have a time stretching
> effect where the same workload will take longer to do the same amount of work
> the lower the frequency/capacity.
> 
> This is countered in the system via clock_pelt which is central for
> implementing utilization invariance. This helps ensure that the utilization
> signal still accurately represent the computation demand of sched_entities.
> 
> But this introduces this black hole effect of time dilation. The concept of
> passage of time is now different from task's perspective compared to an
> external observer. The task will think 1ms has passed, but depending on the
> capacity or the freq, the time from external observer point of view has passed
> for 25 or even 30ms in reality.

But only the PELT angle (and here especially p->se.avg.util_avg) of the
task related accounting, right?

> This has a terrible impact on utilization signal rise time. And since
> utilization signal is central in making many scheduler decision like estimating
> how loaded the CPU is, whether a task is misfit, and what freq to run at when
> schedutil is being used, this leads to suboptimal decision being made and give
> the external observer (userspace) that the system is not responsive or
> reactive. This manifests as problems like:

This can be described by:

t = 1/cap_factor * hl * ln(1 - S_n/S_inv)/ln(0.5)

cap_factor ... arch_scale_cpu_capacity(cpu)/SCHED_CAPACITY_SCALE
S_n        ... partial sum
S_inf      ... infinitive sum
hl         ... halflife

t_1024(cap=1024) = 323ms

t_1024(cap=160)  = 2063ms

[...]

> Computational domain vs Time domain:
> ------------------------------------
> 
> The util_avg is a good representation of compute demand of periodic tasks. And
> should remain as such. But when they are no longer periodic, then looking at
> computational domain doesn't make sense as we have no idea what's the actual
> compute demand of the task, it's in transition. During this transition we need
> to fallback to time domain based signal. Which is simply done by ignoring
> invariance and let the util accumulate based on observer's time.

And this is achieved by:

   time = approximate_runtime(util)

and

   util_avg_end = approximate_util_avg(util_avg_start, time_delta)

These functions allow you to switch between both domains. They do not
consider invariance and are based on the 'util_avg - time curve' of the
big CPU at max CPU frequency.

> Coherent response time:
> -----------------------
> 
> Moving transient tasks to be based on observer's time will create a coherent
> and constant response time. Which is the time it takes util_avg to rampup from
> 0 to max on the biggest core running at max freq (or performance level
> 1024/max).
> 
> IOW, the rampup time of util signal should appear to be the same on all
> capacities/frequencies as if we are running at the highest performance level
> all the time. This will give the observer (userspace) the expected behavior of
> things moving through the motions in a constant response time regardless of
> initial conditions.
> 
> util_est extension:
> -------------------
> 
> The extension is quite simple. util_est currently latches to util_avg at
> enqueue/dequeue to act as a hold function for when busy tasks sleep for long
> period and decay prematurely.
> 
> The extension is to account for RUNNING time of the task in util_est too, which
> is currently ignored.
> 
> when a task is RUNNING, we accumulate delta_exec across context switches and
> accumulate util_est as we're accumulating util_avg, but simply without any
> invariance taken into account. This means when tasks are RUNNABLE, and continue
> to run, util_est will act as our time based signal to help with the faster and
> 'constant' rampup response.
> 
> Periodic vs Transient tasks:
> ----------------------------
> 
> It is important to make a distinction now between tasks that are periodic and
> their util_avg is a good faithful presentation of its compute demand. And
> transient tasks that need help to move faster to their next steady state point.
> 
> In the code this distinction is made based on util_avg. In theory (I think we
> have bugs, will send a separate report), util_avg should be near constant for

Do you mean bugs in maintaining util_avg signal for tasks/taskgroups or
cfs_rq?

> a periodic task. So simply transient tasks are ones that lead to util_avg being
> higher across activations. And this is our trigger point to know whether we

Activations as in enqueue_entity()/dequeue_entity() or
set_next_entity()/put_prev_entity().

[...]

> Patch 7 adds a multiplier to change PELT time constant. I am not sure if this
> is necessary now after introducing per task rampup multipliers. The original
> rationale was to help cater different hadware against the constant util_avg
> response time. I might drop this in future postings. I haven't tested the
> latest version which follows a new implementation suggested by Vincent.

This one definitely stands out here. I remember that PELT halflife
multiplier never had a chance in mainline so far (compile-time or
boot-time) since the actual problem it solves couldn't be explained
sufficiently so far.

In previous discussions we went via the UTIL_EST_FASTER discussion to
'runnable boosting' which is in mainline so far.

https://lkml.kernel.org/r/20230907130805.GE10955@noisy.programming.kicks-ass.net

[...]

