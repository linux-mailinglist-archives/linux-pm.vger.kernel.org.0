Return-Path: <linux-pm+bounces-14442-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CD797C635
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 10:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D1C0281D32
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 08:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1110C194C61;
	Thu, 19 Sep 2024 08:49:40 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC10FC0E;
	Thu, 19 Sep 2024 08:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726735780; cv=none; b=X48avAPHJfG8LNJILTYwpH896fyLGyogSiM9tHlq3ehZXwnZ5u41yr3p1EoVwwpeEnxpH2xNtH1Xj3t8+6QsWukMD7lnozOlPRgA5+yTHNbVWudsENNZ540yqY9BZh/x8WcfTGtdxMzG+7biWgquEZWXz49Iy8Ga+jjMogmTgM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726735780; c=relaxed/simple;
	bh=LtBtuzcFJbYvJIJ6u4O/BwThQXONclKeT84VCPquw30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=orLqb3NrXCztTYU1UH/wITsV+QggRB+IxGKYMTG/zBX5yLOcKwXBK5PtGIEDjBIWo1JvbV/Exf6iAPUxKCVxOVcKuaTGEoNJsrXJFXHC0vyVGGzfUVl3OHqHchCfDAZq4YXyAhpgxY712wt+I3IUhohd5/WwfmMCak1jzaVIQC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E63181007;
	Thu, 19 Sep 2024 01:50:06 -0700 (PDT)
Received: from [192.168.0.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F3863F71A;
	Thu, 19 Sep 2024 01:49:36 -0700 (PDT)
Message-ID: <6ae997ca-9712-4497-b666-11b976b1816d@arm.com>
Date: Thu, 19 Sep 2024 09:49:34 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] cpuidle/menu: Address performance drop from favoring
 physical over polling cpuidle state
To: Aboorva Devarajan <aboorvad@linux.ibm.com>, rafael@kernel.org,
 daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: gautam@linux.ibm.com
References: <20240809073120.250974-1-aboorvad@linux.ibm.com>
 <93d9ffb2-482d-49e0-8c67-b795256d961a@arm.com>
 <9e5ef8ab0f0f3e7cb128291cd60591e3d07b33e4.camel@linux.ibm.com>
 <4c897ab4-d592-427b-9a97-79c2b14d5c46@arm.com>
 <6371848e9c260743f381be6e0114743ffab5e5bb.camel@linux.ibm.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <6371848e9c260743f381be6e0114743ffab5e5bb.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/19/24 06:02, Aboorva Devarajan wrote:
> On Wed, 2024-08-21 at 11:55 +0100, Christian Loehle wrote:
> 
>> On 8/20/24 09:51, Aboorva Devarajan wrote:
>>> On Tue, 2024-08-13 at 13:56 +0100, Christian Loehle wrote:
>>>
> ...
>> The wakeup source(s), since they don't seem to be timer events would be
>> interesting, although a bit of a hassle to get right. 
>> What's the workload anyway?
>>
> 
> Hi Christian,
> 
> Apologies for the delayed response.

No worries!

> 
> I identified the part of the internal workload responsible for performance
> improvement with the patch and it appears to be the OLTP queries, and yes
> the wakeup sources are not timer events.
> 
> ---------------------------------------------------------------------
> 
> Additionally to reproduce the issue using a more open and accessible
> benchmark, conducted similar experiments using pgbench and I observed
> similar improvements with the patch, particularly when running the
> read intensive select query benchmarks.
> 
> ---------------------------------------------------------------------
> System Details
> ---------------------------------------------------------------------
> $ lscpu
> Architecture:             ppc64le
>   Byte Order:             Little Endian
> CPU(s):                   224
>   On-line CPU(s) list:    0-223
> Model name:               POWER10 (architected), altivec supported
>   Model:                  2.0 (pvr 0080 0200)
>   Thread(s) per core:     8
>   Core(s) per socket:     3
>   Socket(s):              8
> Virtualization features:  
>   Hypervisor vendor:      pHyp
>   Virtualization type:    para
> ---------------------------------------------------------------------
> 
> $ cpupower idle-info
> CPUidle driver: pseries_idle
> CPUidle governor: menu
> analyzing CPU 0:
> 
> Number of idle states: 2
> Available idle states: snooze CEDE
> snooze:
> Flags/Description: snooze
> 
> Latency: 0
> Residency: 0
> Usage: 6229
> Duration: 402142
> CEDE:
> Flags/Description: CEDE
> Latency: 12
> Residency: 120
> Usage: 191411
> Duration: 36329999037
> 
> ---------------------------------------------------------------------
> PostgreSQL Benchmark:
> ---------------------------------------------------------------------
> 
> I ran pgbench with 224 clients and 20 threads for 600 seconds,
> performing only SELECT queries against the pgbench database to 
> evaluate performance under read-intensive workloads:
> 
> $ pgbench -c 224 -j 20 -T 600 -S pgbench
> 
> Latency:
> 
> |---|-------------|------------|------------|
> | # | Before (ms) | After (ms) | Change (%) |
> |Run| Patch       | Patch      |            |
> |---|-------------|------------|------------|
> | 1 | 0.343       | 0.287      | -16.31%    |
> | 2 | 0.334       | 0.286      | -14.37%    |
> | 3 | 0.333       | 0.286      | -14.11%    |
> | 4 | 0.341       | 0.288      | -15.55%    |
> | 5 | 0.342       | 0.288      | -15.79%    |
> |---|-------------|------------|------------|
> 
> Latency Reduction: After applying the patch, the latency decreased
> by 14% to 16% across multiple runs.
> 
> Throughput per second:
> 
> |---|-------------|------------|------------|
> | # | Before      | After      | Change (%) |
> |Run| Patch       | Patch      |            |
> |---|-------------|------------|------------|
> | 1 | 652,544.23  | 780,613.42 | +19.63%    |
> | 2 | 670,243.45  | 784,348.44 | +17.04%    |
> | 3 | 673,495.39  | 784,458.12 | +16.48%    |
> | 4 | 656,609.16  | 778,531.20 | +18.57%    |
> | 5 | 654,644.52  | 778,322.88 | +18.88%    |
> |---|-------------|------------|------------|

Do you happen to have the idle stats here, too?
Especially above/below see comment below.

> 
> Transactions per second Improvement: The patch led to an increase in
> TPS, ranging from 16% to 19%.
> 
> This indicates that the patch significantly reduces latency while
> improving throughput (TPS).  pgbench is an OLTP benchmark and doesn't
> do timer based wakeups, this is in-line with the improvements
> I saw in the originally reported OLTP workload as well. 
> 
> ---------------------------------------------------------------------
> Additional CPU Idle test with custom benchmark:
> ---------------------------------------------------------------------
> I also wrote a simple benchmark [1] to analyze the impact of cpuidle
> state selection, comparing timer-based wakeups and non-timer
> (pipe-based) wakeups.
> 
> This test involves a single waker thread periodically waking up a
> single wakee thread, simulating a repeating sleep-wake pattern. The
> test was run with both timer-based and pipe-based wakeups, and cpuidle
> statistics (usage, time, above, below) were collected.

Thanks, pretty cool and just quickly checking it seems to be all there:
hrtimer, different cpusets for wakee and waker, the pipe wakeup.
That could be useful, only thing missing is the license header ;)

> 
> Timer based wakeup:
> 
> +------------------------+---------------------+---------------------+
> | Metric                 | Without Patch       | With Patch          |
> +------------------------+---------------------+---------------------+
> | Wakee thread - CPU     | 110                 | 110                 |
> | Waker thread - CPU     | 20                  | 20                  |
> | Sleep Interval         | 50 us               | 50 us               |
> | Total Wakeups          | -                   | -                   |
> | Avg Wakeup Latency     | -                   | -                   |
> | Actual Sleep time      | 52.639 us           | 52.627 us           |
> +------------------------+---------------------+---------------------+
> | Idle State 0 Usage Diff| 94,879              | 94,879              |
> | Idle State 0 Time Diff | 4,700,323 ns        | 4,697,576 ns        |
> | Idle State 1 Usage Diff| 0                   | 0                   |
> | Idle State 1 Time Diff | 0 ns                | 0 ns                |
> +------------------------+---------------------+---------------------+
> | Total Above Usage      | 0 (0.00%)           | (0.00%)             |
> +------------------------+---------------------+---------------------+
> | Total Below Usage      | 0 (0.00%)           | 0 (0.00%)           |
> +------------------------+---------------------+---------------------+
> 
> In timer-based wakeups, the menu governor effectively predicts the idle
> duration both with and without the patch. This ensures that there are
> few or no instances of "Above" usage, allowing the CPU to remain in the
> correct idle state.
> 
> The condition (s->target_residency_ns <= data->next_timer_ns) in the menu
> governor ensures that a physical idle state is not prioritized when a
> timer event is expected before the target residency of the first physical
> idle state.
> 
> As a result, the patch has no impact in this case, and performance
> remains stable with timer based wakeups.
> 
> Pipe based wakeup (non-timer wakeup):
> 
> +------------------------+---------------------+---------------------+
> | Metric                 | Without Patch       | With Patch          |
> +------------------------+---------------------+---------------------+
> | Wakee thread - CPU     | 110                 | 110                 |
> | Waker thread - CPU     | 20                  | 20                  |
> | Sleep Interval         | 50 us               | 50 us               |
> | Total Wakeups          | 97031               | 96583               |
> | Avg Wakeup Latency     | 7.070 us            | 4.879 us            |
> | Actual Sleep time      | 51.366 us           | 51.605 us           |
> +------------------------+---------------------+---------------------+
> | Idle State 0 Usage Diff| 1209                | 96,586              |
> | Idle State 0 Time Diff | 55,579 ns           | 4,510,003 ns        |
> | Idle State 1 Usage Diff| 95,826              | 5                   |
> | Idle State 1 Time Diff | 4,522,639 ns        | 198 ns              |
> +------------------------+---------------------+---------------------+
> +------------------------+---------------------+---------------------+
> | **Total Above Usage**  | 95,824 (98.75%)     | 5 (0.01%)           |
> +------------------------+---------------------+---------------------+     
> +------------------------+---------------------+---------------------+
> | Total Below Usage      | 0 (0.00%)           | 0 (0.00%)           |
> +------------------------+---------------------+---------------------+
> 
> In the pipe-based wakeup scenario, before the patch was applied, the 
> "Above" metric was notably high around 98.75%. This suggests that the
> menu governor frequently selected a deeper idle state like CEDE, even
> when the idle period was relatively short.
> 
> This happened because the menu governor is inclined to prioritize the
> physical idle state (CEDE) even when the target residency time of the
> physical idle state (s->target_residency_ns) was longer than the
> predicted idle time (predicted_ns), so data->next_timer_ns won't be
> relevant here in non-timer wakeups.
> 
> In this test, despite the actual idle period being around 50 microseconds,
> the menu governor still chose CEDE state, which has a target residency of
> 120 microseconds.

And the idle_miss statistics confirms that this was mostly wrong decisions
in hindsight.
I'll go through the menu code again, this indeed shouldn't be happening.
I'd be very surprised if upstream teo performed as badly (or actually badly
at all) on this, although it doesn't seem to help your actual workload,
would you mind giving that a try too?

Regards,
Christian

> 
> ---------------------------------------------------------------------
> 
> While timer-based wakeups performed well even without the patch, workloads
> that don't have timers as wakeup source but have predictable idle durations
> shorter than the first idle state's target residency benefit significantly
> from the patch.
> 
> It will be helpful to understand why prioritizing deep physical idle
> states over shallow ones even for short idle periods that don’t meet
> the target residency like mentioned above is considered more beneficial.
> 
> Is there something I could be missing here?
> 
> Any comments or suggestions will be really helpful.
> 
> [1] https://github.com/AboorvaDevarajan/linux-utils/tree/main/cpuidle/cpuidle_wakeup
> 
> Thanks,
> Aboorva
> 


