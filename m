Return-Path: <linux-pm+bounces-21210-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA61A24915
	for <lists+linux-pm@lfdr.de>; Sat,  1 Feb 2025 13:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B36DC1649C1
	for <lists+linux-pm@lfdr.de>; Sat,  1 Feb 2025 12:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AD51A23BE;
	Sat,  1 Feb 2025 12:43:14 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76ABAD39;
	Sat,  1 Feb 2025 12:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738413794; cv=none; b=u7RRKZYQy9M1DPGYgxe5sL838ckqq3abtMea6GsX6CUhG5fltkqXhtdC8CTPodMM9i7JF9g9qn1WajHJc+RyvChyyp+MvhhU9dIBfqqgHmzAa6QAjXFeMBgS60CEw4VfkxeP9s8YRP8Jqv00lRRR0OCf48sDW6bcgVCef3A6gQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738413794; c=relaxed/simple;
	bh=GNMY0qMhhZCbl6+kaMsUuxtmkZfRtOSFWGDSkd4IvC0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=XQJys+751uMbusefaPZ0guMPtpglWhSetx+CMfxe/Pz5d2OhTm5RkoWQBts2JTsftZQexi0SzzTZKzfDODN7mBvmsR4aim+Bx3G1HZBkg3J1R8L3QD9wBiuLnHAMnQ9RJi7STV4LtiS6E5i/wYGsztdunTJUMFbb6yiIBV6/cXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0BD7339;
	Sat,  1 Feb 2025 04:43:35 -0800 (PST)
Received: from [10.57.36.53] (unknown [10.57.36.53])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24D023F63F;
	Sat,  1 Feb 2025 04:43:07 -0800 (PST)
Message-ID: <3861524b-b266-4e54-b7ab-fdccbb7b4177@arm.com>
Date: Sat, 1 Feb 2025 12:43:05 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Christian Loehle <christian.loehle@arm.com>
Subject: Re: [RFC][PATCH v021 0/9] cpufreq: intel_pstate: Enable EAS on hybrid
 platforms without SMT
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Pierre Gondois <pierre.gondois@arm.com>, "Zhang, Rui" <rui.zhang@intel.com>
References: <5861970.DvuYhMxLoT@rjwysocki.net>
 <be830a7a-410e-4864-adaf-0c68bb1135f1@arm.com>
 <CAJZ5v0hHc5y6LhVRRePr2n2nu=C4XE+Xi-A+D=uxDcsFZDjOJg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAJZ5v0hHc5y6LhVRRePr2n2nu=C4XE+Xi-A+D=uxDcsFZDjOJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/27/25 13:57, Rafael J. Wysocki wrote:
> On Sat, Jan 25, 2025 at 12:18 PM Dietmar Eggemann
> <dietmar.eggemann@arm.com> wrote:
>>
>> On 29/11/2024 16:55, Rafael J. Wysocki wrote:
>>
>> [...]
>>
>>> For easier access, the series is available on the experimental/intel_ostate
>>> branch in linux-pm.git:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?h=experimental/intel_pstate
>>
>> I was wondering how we can test the EAS behaviour (power/perf) on Intel
>> hybrid machines.
> 
> Thanks a lot for looking into this, much appreciated!
> 
>> I have system-wide RAPL 'power/energy-{cores,pkg}' events for power
>> (energy) on my i7-13700K (nosmt) so I can run an rt-app workload
>> (e.g. 30 5% tasks (0.8ms/16ms)) with:
>>
>> perf stat -e power/energy-cores/,power/energy-pkg/ --repeat 10 ./rt-app.sh
>>
>> Plus I can check for negative slack for those rt-app-test tasks (perf)
>> and do ftrace-based task placement evaluation.
>>
>> base:
>>
>>  Performance counter stats for 'system wide' (10 runs):
>>
>>        52.67 Joules power/energy-cores/       ( +-  1.24% )
>>        85.09 Joules power/energy-pkg/         ( +-  0.83% )
>>
>>    34.922801 +- 0.000736 seconds time elapsed ( +-  0.00% )
>>
>>
>> EAS:
>>
>>  Performance counter stats for 'system wide' (10 runs):
>>
>>        45.55 Joules power/energy-cores/       ( +-  1.07% )
>>        75.73 Joules power/energy-pkg/         ( +-  0.67% )
>>
>>    34.93183 +- 0.00514 seconds time elapsed  ( +-  0.01% )
>>
>> Do you have another (maybe more sophisticated) test methodology?
> 
> Not really more sophisticated, but we cast a wider net, so to speak.
> 
> For taks placement testing we use an internal utility that can create
> arbitrary synthetic workloads and plot CPU utilization (and other
> things) while they are running.  It is kind of similar to rt-app
> AFAICS.
> 
> We also run various benchmarks and measure energy usage during these
> runs, first in order to check if EAS helps in the cases when it is
> expected to help, but also to see how it affects the benchmark scores
> in general (because we don't want it to make too much of a "negative"
> difference for "performance" workloads).

Any insights always appreciated.
I have an OSPM talk accepted about the recent EAS overutilized
proposals, which does touch upon being able to switch out of EAS
quickly enough, too. I will be including some x86 results from our
test machine, too.

> 
> The above results are basically in-line with what we are observing,
> but we often see less of a difference in terms of energy usage between
> the baseline and EAS enabled.
> 
> We also see a lot of task migrations between CPUs in the "low-cost"
> PD, mostly in the utilization range where we would expect EAS to make
> a difference.  Those migrations are a bit of a concern although they
> don't seem to affect benchmark scores.
> 
> We think that those migrations are related to the preference of CPUs
> with the largest spare capacity, so I'm working on an alternative
> approach to enabling EAS that will use per-CPU PDs to see if the
> migrations can be reduced this way.

We've had something like this actually, you might be interested [1].
You'd want something more flexible in terms of the margins (or a
non-energy-based approach based on e.g. spare-cap [2]), but just
sidestepping the CPU selection within the cluster?

Is there anything specifically worrying you about frequent e-core
wakeup migrations? A few things come to mind immediately like:
Idle state latency, cache, DVFS, per-core internals like branch
predictor training, maybe turbo states would also favor the same
core(s) to be active?
(I've played with the series, too and still have lots of questions
on how this interact with turbo states, but given that we can't
really deterministically trigger them, trying to experiment/measure
anything seems rather futile?)

Interestingly if anything we were more interested in reducing CPU
wakeups in the big cores, because of their higher static leakage,
while little cores have low static leakage and low cpuidle wakeup
cost and latency.

[1]
It should be noted that we were always more concerned between the
uArch differences instead of breaking ties between intra-cluster CPUs,
simply because that's where the big efficiency gains are.

https://lore.kernel.org/lkml/20220412134220.1588482-1-vincent.donnefort@arm.com/

[2]
Vincent Guittot's is currently proposing this, I don't think it would
work well ootb because of the single-OPP approach you took, but maybe
going from "same OPP" to e.g. "5% cap diff" remedies that?
https://lore.kernel.org/lkml/20241217160720.2397239-4-vincent.guittot@linaro.org/


Anyway to provide something useful on this thread as well, testing
on our Raptor Lake with nosmt (=8+8) (note that this doesn't necessarily
translate into the lunar lake series that is the focus here).
I can reproduce the same efficiency gains of around 20-25% on
common workloads, e.g. 20 iterations of 5mins Firefox 4K youtube
video playback (Acquired by RAPL power/energy-cores/ in Joules):

EAS:
628.6145 +-30.4479693342421
CAS:
829.172 +-29.422507961369337
(-24.2% energy used with EAS)

FWIW Dietmar's patch of adding cpu_capacity sysfs for the intel_pstate
setup path is pretty handy for testing at least, maybe it could still
be considered for upstream:
https://lore.kernel.org/lkml/91b37d34-6d9a-4623-87d8-0ff648ea2415@arm.com/

