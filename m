Return-Path: <linux-pm+bounces-12149-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D511F9505AE
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 14:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 062B11C20BA4
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 12:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9680819B3D3;
	Tue, 13 Aug 2024 12:56:17 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAE319ADA8;
	Tue, 13 Aug 2024 12:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723553777; cv=none; b=ccEqyDWurR1BgcHQm8V4NwW90CQfqX/W9XxwYb3cgRcLRGPNMbEtUcO73p1Lco8YH/xY0dAbj66aKudGvlj6hQNWEQi9Bvtkrq8gXSBYsj0fwYDssewfYUsU0+z3+8lfkXDlvMet57SZ7YOQ0P9JVo/cP1E8zbNhF3iQkRfwk80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723553777; c=relaxed/simple;
	bh=wFtTI19K2p9zqVAIUz0fc1eIvdJ9DNFocqaSowv19pg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X9oGhijQ7QyJWex6Mbt+j1ntJmypX0v7dqx1M4IIkv3d66t06y8B7bm3vetcYxNbQL/rzWap5HHDtOciNGJfX/bUSJNb1eLv+OKbpafrxdXVuzGbM/jPHPJIAuozUn+ve/+7A25VtIPTs8T5Q+sSMSPkzhSu7jGD+rWRAW1yaq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A028312FC;
	Tue, 13 Aug 2024 05:56:40 -0700 (PDT)
Received: from [10.57.84.20] (unknown [10.57.84.20])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B3FA3F73B;
	Tue, 13 Aug 2024 05:56:13 -0700 (PDT)
Message-ID: <93d9ffb2-482d-49e0-8c67-b795256d961a@arm.com>
Date: Tue, 13 Aug 2024 13:56:11 +0100
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
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20240809073120.250974-1-aboorvad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/9/24 08:31, Aboorva Devarajan wrote:
> This patch aims to discuss a potential performance degradation that can occur
> in certain workloads when the menu governor prioritizes selecting a physical
> idle state over a polling state for short idle durations. 
> 
> Note: This patch is intended to showcase a performance degradation, applying
> this patch could lead to increased power consumption due to the trade-off between
> performance and power efficiency, potentially causing a higher preference for
> performance at the expense of power usage.
> 

Not really a menu expert, but at this point I don't know who dares call
themselves one.
The elephant in the room would be: Does teo work better for you?

> ==================================================
> System details in which the degradation is observed:
> 
> $ uname -r
> 6.10.0+
> 
> $ lscpu
> Architecture:             ppc64le
>   Byte Order:             Little Endian
> CPU(s):                   160
>   On-line CPU(s) list:    0-159
> Model name:               POWER10 (architected), altivec supported
>   Model:                  2.0 (pvr 0080 0200)
>   Thread(s) per core:     8
>   Core(s) per socket:     3
>   Socket(s):              6
>   Physical sockets:       4
>   Physical chips:         2
>   Physical cores/chip:    6
> Virtualization features:
>   Hypervisor vendor:      pHyp
>   Virtualization type:    para
> Caches (sum of all):
>   L1d:                    1.3 MiB (40 instances)
>   L1i:                    1.9 MiB (40 instances)
>   L2:                     40 MiB (40 instances)
>   L3:                     160 MiB (40 instances)
> NUMA:
>   NUMA node(s):           6
>   NUMA node0 CPU(s):      0-31
>   NUMA node1 CPU(s):      32-71
>   NUMA node2 CPU(s):      72-79
>   NUMA node3 CPU(s):      80-87
>   NUMA node4 CPU(s):      88-119
>   NUMA node5 CPU(s):      120-159
> 
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
> ==================================================
> 
> The menu governor contains a condition that selects physical idle states over,
> such as the CEDE state over polling state, by checking if their exit latency meets
> the latency requirements. This can lead to performance drops in workloads with
> frequent short idle periods.
> 
> The specific condition which causes degradation is as below (menu governor):
> 
> ```
> if (s->target_residency_ns > predicted_ns) {
>     ...
>     if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) &&
>         s->exit_latency_ns <= latency_req &&
>         s->target_residency_ns <= data->next_timer_ns) {
>         predicted_ns = s->target_residency_ns;
>         idx = i;
>         break;
>     }
>     ...
> }
> ```
> 
> This condition can cause the menu governor to choose the CEDE state on Power
> Systems (residency: 120 us, exit latency: 12 us) over a polling state, even
> when the predicted idle duration is much shorter than the target residency
> of the physical state. This misprediction leads to performance degradation
> in certain workloads.
> 

So clearly the condition
s->target_residency_ns <= data->next_timer_ns)
is supposed to prevent this, but data->next_timer_ns isn't accurate,
have you got any idea what it's set to in your workload usually?
Seems like your workload is timer-based, so the idle duration should be
predicted accurately.


> ==================================================
> Test Results
> ==================================================
> 
> This issue can be clearly observed with the below test.
> 
> A test with multiple wakee threads and a single waker thread was run to
> demonstrate this issue. The waker thread periodically wakes up the wakee
> threads after a specific sleep duration, creating a repeating of sleep -> wake
> pattern. The test was run for a stipulated period, and cpuidle statistics are
> collected.
> 
> ./cpuidle-test -a 0 -b 10 -b 20 -b 30 -b 40 -b 50 -b 60 -b 70 -r 20 -t 60
> 
> ==================================================
> Results (Baseline Kernel):
> ==================================================
> Wakee 0[PID 8295] affined to CPUs: 10,
> Wakee 2[PID 8297] affined to CPUs: 30,
> Wakee 3[PID 8298] affined to CPUs: 40,
> Wakee 1[PID 8296] affined to CPUs: 20,
> Wakee 4[PID 8299] affined to CPUs: 50,
> Wakee 5[PID 8300] affined to CPUs: 60,
> Wakee 6[PID 8301] affined to CPUs: 70,
> Waker[PID 8302] affined to CPUs: 0,
> 
> |-----------------------------------|-------------------------|-----------------------------|
> | Metric                            | snooze                  | CEDE                        |
> |-----------------------------------|-------------------------|-----------------------------|
> | Usage                             | 47815                   | 2030160                     |
> | Above                             | 0                       | 2030043                     |
> | Below                             | 0                       | 0                           |
> | Time Spent (us)                   | 976317 (1.63%)          | 51046474 (85.08%)           |
> | Overall average sleep duration    | 28.721 us               |                             |
> | Overall average wakeup latency    | 6.858 us                |                             |
> |-----------------------------------|-------------------------|-----------------------------|
> 
> In this test, without the patch, the CPU often enters the CEDE state for
> sleep durations of around 20-30 microseconds, even though the CEDE state's
> residency time is 120 microseconds. This happens because the menu governor
> prioritizes the physical idle state (CEDE) if its exit latency is within
> the latency limits. It also uses next_timer_ns for comparison, which can
> be farther off than the actual idle duration as it is more predictable,
> instead of using predicted idle duration as a comparision point with the
> target residency.

Ideally that shouldn't be the case though (next_timer_ns be farther off the
actual idle duration).

> [snip]


