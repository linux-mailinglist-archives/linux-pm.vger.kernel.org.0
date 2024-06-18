Return-Path: <linux-pm+bounces-9428-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F22A90CA36
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 13:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFF37290566
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 11:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4EA1A0720;
	Tue, 18 Jun 2024 11:17:34 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B707515A489;
	Tue, 18 Jun 2024 11:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718709454; cv=none; b=uqW6rUN/rwa3fuUfDfjiEUx65W1JwIpVma2MAoJwlL99eDdYg6/TZheuHv6ggIj2oyeaDX4X4WPsiHGvAWMO/CIRZ+EnhDAPqnh7hJhDdQbgUAsuNW3D7c5yRUA8s+6FYXCu4n9sBVZoMxNJ82d6sTVKK6PDIJdFz0/KfiEhlWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718709454; c=relaxed/simple;
	bh=wJHDjjOM5QTpiOE86i73EAvliq7P4OYqHAgjgEd7wow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TeXO1DKVAsTNul0wVUwayI3Vsax73+0v0BNReghC7DzHyR/lQhIFeR4sIyVqUlntWTZAy2qMXluQLXHkfTOOeO1g7IrakVW2ZF4zTtSzZPFaarpNFiO8Kk9vCOXGvbz1csSSoUw1xlqvfNcKfRsypS64V52GUVOfm/z8EV64bto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAF21DA7;
	Tue, 18 Jun 2024 04:17:55 -0700 (PDT)
Received: from arm.com (e127648.arm.com [10.1.33.10])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B3DA63F6A8;
	Tue, 18 Jun 2024 04:17:30 -0700 (PDT)
Date: Tue, 18 Jun 2024 12:17:29 +0100
From: Christian Loehle <christian.loehle@arm.com>
To: Doug Smythies <dsmythies@telus.net>
Cc: rafael@kernel.org, vincent.guittot@linaro.org, qyousef@layalina.io,
	peterz@infradead.org, daniel.lezcano@linaro.org,
	ulf.hansson@linaro.org, anna-maria@linutronix.de,
	kajetan.puchalski@arm.com, lukasz.luba@arm.com,
	dietmar.eggemann@arm.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 0/3] cpuidle: teo: Fixing utilization and intercept
 logic
Message-ID: <20240618111729.hqywobxh3gm7rfgq@e127648.arm.com>
References: <20240611112413.1241352-1-christian.loehle@arm.com>
 <004a01dac04c$314c4360$93e4ca20$@telus.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004a01dac04c$314c4360$93e4ca20$@telus.net>

On Sun, Jun 16, 2024 at 05:20:43PM -0700, Doug Smythies wrote:
> On 2024.06.11 04:24 Christian Loehle wrote:
>
> ...
> > Happy for anyone to take a look and test as well.
> ...
>
> I tested the patch set.
> I do a set of tests adopted over some years now.
> Readers may recall that some of the tests search over a wide range of operating conditions looking for areas to focus on in more detail.
> One interesting observation is that everything seems to run much slower than the last time I did this, last August, Kernel 6.5-rc4.
>

Thank you very much Doug, that is helpful indeed!

> Test system:
> Processor: Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz (6 cores, 2 thread per core, 12 CPUs)
> CPU Frequency scaling driver: intel_pstate
> HWP (HardWare Pstate) control: Disabled
> CPU frequency scaling governor: Performance
> Idle states: 4: name : description:
>    state0/name:POLL		desc:CPUIDLE CORE POLL IDLE
>    state1/name:C1_ACPI		desc:ACPI FFH MWAIT 0x0
>    state2/name:C2_ACPI		desc:ACPI FFH MWAIT 0x30
>    state3/name:C3_ACPI		desc:ACPI FFH MWAIT 0x60

What are target residencies and exit latencies?

> Ilde driver: intel_idle
> Idle governor: as per individual test
> Kernel: 6.10-rc2 and with V1 and V2 patch sets (1000 Hz tick rate)
> Legend:
>    teo: unmodified 6.10-rc2
>    menu:
>    ladder:
>    cl: Kernel 6.10-rc2 + Christian Loehle patch set V1
>    clv2: Kernel 6.10-rc2 + Christian Loehle patch set V2
> System is extremely idle, other than the test work.

If you don't mind spinning up another one, I'd be very curious about
results from just the Util-awareness revert (i.e. v2 1/3).
If not I'll try to reproduce your tests.

>
> Test 1: 2 core ping pong sweep:
>
> Pass a token between 2 CPUs on 2 different cores.
> Do a variable amount of work at each stop.

Hard to interpret the results here, as state residencies would be the
most useful one, but from the results I assume that residencies are
calculated over all possible CPUs, so 4/6 CPUs are pretty much idle
the entire time, resulting in >75% state3 residency overall.

>
> Purpose: To utilize the shallowest idle states
> and observe the transition from using more of 1
> idle state to another.
>
> Results relative to teo (negative is better):
> 		menu		ladder		clv2		cl
> average		-2.09%		11.11%		2.88%		1.81%
> max		10.63%		33.83%		9.45%		10.13%
> min		-11.58%	6.25%		-3.61%		-3.34%
>
> While there are a few operating conditions where clv2 performs better than teo, overall it is worse.
>
> Further details:
> http://smythies.com/~doug/linux/idle/teo-util3/ping-sweep/2-1/2-core-pp-relative.png
> http://smythies.com/~doug/linux/idle/teo-util3/ping-sweep/2-1/2-core-pp-data.png
> http://smythies.com/~doug/linux/idle/teo-util3/ping-sweep/2-1/perf/
>
> Test 2: 6 core ping pong sweep:
>
> Pass a token between 6 CPUs on 6 different cores.
> Do a variable amount of work at each stop.
>

My first guess would've been that this is the perfect workload for the
very low utilization threshold, but even teo has >40% state3 residency
consistently here.

> Purpose: To utilize the midrange idle states
> and observe the transitions between use of
> idle states.
>
> Note: This test has uncertainty in an area where the performance is bi-stable for all idle governors,
> transitioning between much less power and slower performance and much more power and higher performance.
> On either side of this area, the differences between all idle governors are negligible.
> Only data from before this area (from results 1 t0 95) was included in the below results.
>

I see and agree with your interpretation. Difference in power between
all tested seems to be negligible during that window. Interestingly
the residencies of idle states seem to be very different, like ladder
being mostly in deepest state3. Maybe total package power is too coarse
to show the differences for this test.

> Results relative to teo (negative is better):
> 		menu	ladder	cl	clv2
> average		0.16%	4.32%	2.54%	2.64%
> max		0.92%	14.32%	8.78%	8.50%
> min		-0.44%	0.27%	0.09%	0.05%
>
> One large clv2 difference seems to be excessive use of the deepest idle state,
> with corresponding 100% hit rate on the "Idle State 3 was to deep" metric.
> Example (20 second sample time):
>
> teo: Idle state 3 entries: 600, 74.33% were to deep or 451. Processor power was 38.0 watts.
> clv2: Idle state 3 entries: 4,375,243, 100.00% were to deep or 4,375,243. Processor power was 40.6 watts.
> clv2 loop times were about 8% worse than teo.
>

Some of the idle state 3 residencies seem to be >100% at the end here,
not sure what's up with that.

> Further details:
> http://smythies.com/~doug/linux/idle/teo-util3/ping-sweep/6-1/6-core-pp-data-detail-a.png
> http://smythies.com/~doug/linux/idle/teo-util3/ping-sweep/6-1/6-core-pp-data-detail-b.png
> http://smythies.com/~doug/linux/idle/teo-util3/ping-sweep/6-1/6-core-pp-data.png
> http://smythies.com/~doug/linux/idle/teo-util3/ping-sweep/6-1/perf/
>
> Test 3: sleeping ebizzy - 128 threads.
>
> Purpose: This test has given interesting results in the past.
> The test varies the sleep interval between record lookups.
> The result is varying usage of idle states.
>
> Results: relative to teo (negative is better):
> 		menu	clv2	ladder	cl
> average		0.06%	0.38%	0.81%	0.35%
> max		2.53%	3.20%	5.00%	2.87%
> min		-2.13%	-1.66%	-3.30%	-2.13%
>
> No strong conclusion here, from just the data.
> However, clv2 seems to use a bit more processor power, on average.

Not sure about that, from the residencies ladder and teo should be
decisive losers in terms of power. While later in the test teo seems
to be getting worse in power it doesn't quite reflect the difference
in states.
E.g. clv2 finishing with 65% state2 residency while teo has 40%, but
I'll try to get per-CPU power measurements on this one.
Interestingly ladder is a clear winner if anything, if that is reliable
as a result that could indicate a too aggressive tick stop from the
other governors, but cl isn't that much better than clv2 here, even
though it stops the tick less aggressively.

>
> Further details:

Link is missing, but I found
http://smythies.com/~doug/linux/idle/teo-util3/ebizzy/
from browsing your page.

>
> Test4: adrestia wakeup latency tests. 500 threads.
>
> Purpose: The test was reported in 2023.09 by the kernel test robot and looked
> both interesting and gave interesting results, so I added it to the tests I run.

http://smythies.com/~doug/linux/idle/teo-util3/adrestia/periodic/perf/
So interestingly we can see, what I would call, the misbehavior of teo
here, with teo skipping state2 and state3 entirely. You would expect
a power regressionhere, but it doesn't translate into package power
anyway.

>
> Results:
> teo:wakeup cost (periodic, 20us): 3130nSec reference
> clv2:wakeup cost (periodic, 20us): 3179nSec +1.57%
> cl:wakeup cost (periodic, 20us): 3206nSec +2.43%
> menu:wakeup cost (periodic, 20us): 2933nSec -6.29%
> ladder:wakeup cost (periodic, 20us): 3530nSec +12.78%

Is this measured as wakeup latency?
I can't find much info about the test setup here, do you mind sharing
something on it?

>
> No strong conclusion here, from just the data.
> However, clv2 seems to use a bit more processor power, on average.
> teo: 69.72 watts
> clv2: 72.91 watts +4.6%
> Note 1: The first 5 minutes of the test powers were discarded to allow for thermal stabilization.
> Note 2: More work is required for this test, because the teo one actually took longer to execute, due to more outlier results than the other tests.
>
> There were several other tests run but are not written up herein.
>

Because results are on par for all? Or inconclusive / not reproducible?

Some final words:
I was hoping to get rid of Util-awareness with fixed the fixed intercept logic
and my test showed that this isn't unreasonable.
Here we do see a case where there is some regression vs Util-awareness.
The intercept logic is currently decaying quite aggressively, maybe
that could be tuned to improve teo behavior.

Kind Regards,
Christian


