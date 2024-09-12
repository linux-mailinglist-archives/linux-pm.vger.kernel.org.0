Return-Path: <linux-pm+bounces-14102-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F652976F3A
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2024 18:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 546D01F243DE
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2024 16:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882721BE84E;
	Thu, 12 Sep 2024 16:59:00 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEF517D378;
	Thu, 12 Sep 2024 16:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726160340; cv=none; b=NGRFtLlgDdWtA+hShzUtP25PKOBuLGf8/Xtx9xE/FApU7thZcrZ/l+OhbSUKXFcmqCiyurgt2mpT9pi1amWo5dpvIgYRX/QDdT42kB+WkdeEuqc0fYQlMVpGIt+RfmLAApfri7Y1bMjcNxGlQZ/umeeunG8uMoGlv9MM9STqFf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726160340; c=relaxed/simple;
	bh=5zAlQuDaCjaVxWXLfveEOsWn82gqV8bielTw+IZnz5E=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nrzh4g28E473eQrJqH7Vt2WWkewNFGMD51NTrTwjFtwVVqpX94RbC5ZByecwlGff7lX6DnaymbAtV9IQjgvn1L8NxnNaR99ViT2Z8zN8qke4fMpkhtWxelR/LhzF5AQaiVOb50+C4QFd1mhegzI+cVBxI3MwEhK61Ov1+4WKQTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A17F7339;
	Thu, 12 Sep 2024 09:59:25 -0700 (PDT)
Received: from [10.1.32.61] (e127648.arm.com [10.1.32.61])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A87AE3F64C;
	Thu, 12 Sep 2024 09:58:54 -0700 (PDT)
Message-ID: <826fbcc9-8bd5-4598-ae5d-d65092823b7c@arm.com>
Date: Thu, 12 Sep 2024 17:58:53 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq/schedutil: Only bind threads if needed
From: Christian Loehle <christian.loehle@arm.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-pm <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Qais Yousef <qyousef@layalina.io>, Juri Lelli <juri.lelli@redhat.com>,
 Ingo Molnar <mingo@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Pierre Gondois <pierre.gondois@arm.com>
References: <480f2140-ea59-4e1d-a68d-18cbcec10941@arm.com>
Content-Language: en-US
In-Reply-To: <480f2140-ea59-4e1d-a68d-18cbcec10941@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/24 14:53, Christian Loehle wrote:
> Remove the unconditional binding of sugov kthreads to the affected CPUs
> if the cpufreq driver indicates that updates can happen from any CPU.
> This allows userspace to set affinities to either save power (waking up
> bigger CPUs on HMP can be expensive) or increasing performance (by
> letting the utilized CPUs run without preemption of the sugov kthread).
> 
> Without this patch the behavior of sugov threads will basically be a
> boot-time dice roll on which CPU of the PD has to handle all the
> cpufreq updates. With the recent decreases of update filtering these
> two basic problems become more and more apparent:
> 1. The wake_cpu might be idle and we are waking it up from another
> CPU just for the cpufreq update. Apart from wasting power, the exit
> latency of it's idle state might be longer than the sugov threads
> running time, essentially delaying the cpufreq update unnecessarily.
> 2. We are preempting either the requesting or another busy CPU of the
> PD, while the update could be done from a CPU that we deem less
> important and pay the price of an IPI and two context-switches.
> 
> The change is essentially not setting PF_NO_SETAFFINITY on
> dvfs_possible_from_any_cpu, no behavior change if userspace doesn't
> touch affinities.
> 
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>

I'll add some numbers to illustrate, although the example might not be
particularly realistic.
The classic fio workload will trigger cpufreq update very often, so
I used that on the Pixel6, affinity set to CPU7 (bitmask 80)(Big PD is
[6,7]).
Without this patch we have either all sugov enqueues on CPU6 or CPU7,
depending on where the first CPU frequency request (since boot) was
issued from (the deadline select_task_rq is rather simple, so it
will just wake_cpu if that is still valid, which here it always is).

I set different affinities for the sugov:6 worker and annotate
IOPS (throughput) and power (mW average), the test is for 30s each.
cpumask IOPS
80	7477
	888.3 mW	{'CPU-Big': 742.5668631414397, 'CPU-Mid': 11.919500003712095, 'CPU-Little': 133.79554163073317}
40	7378
	942.8 mW	{'CPU-Big': 797.4037245094225, 'CPU-Mid': 12.440698878099667, 'CPU-Little': 132.98899390286172}
f	7469
	873.7 mW	{'CPU-Big': 718.2933574826287, 'CPU-Mid': 11.89176754939742, 'CPU-Little': 143.55634276873246}
2	7501
	872.8 mW	{'CPU-Big': 718.6036614909397, 'CPU-Mid': 11.711731623773632, 'CPU-Little': 142.4830173663132}
1	7392
	859.5 mW	{'CPU-Big': 704.926078017567, 'CPU-Mid': 12.196892652625284, 'CPU-Little': 142.4231989686622}

Throughput is somewhat comparable for all, anyway the frequency only
bounces from capacity 1024 to 512 because of the instability of
iowait boost.
For 40 (CPU6) we see significantly more power usage, as the sugov
will prevent CPU6 from power down, as it gets woken up by the sugov
worker often.
f,2 and 1 affinities have slightly higher power coming from the
littles (as expected), but significantly less power from the bigs,
since they don't have the double context-switch on preemption and
the actual sugov CPU cycles.
1 has by far the least power, as it's always in WFI anyway, it
handles the IO interrupts from fio on CPU7.

Granted that is a somewhat worst-case scenario just to illustrate
the problem.

I also have a patch for preferring wake_cpu = smp_processor_id() for
the sugov worker, which is somewhat adjacent to this, the numbers
above make a case for that even without touching affinities.
I thought this might be less controversial for now.

