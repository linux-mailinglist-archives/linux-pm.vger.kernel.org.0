Return-Path: <linux-pm+bounces-29123-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E627AE11F5
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 05:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 987273BB9A1
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 03:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6CF1E285A;
	Fri, 20 Jun 2025 03:53:56 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1EB1E2607;
	Fri, 20 Jun 2025 03:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750391636; cv=none; b=rb+jqH1Iro7Yr5ZvtmpszYOlUkp6lZ0hm3JM2zujF1k9/RgsdSgLNeZtYuN+X4SyMRVcJBe+34aIonam500j8Wi2tcUfk/y4mzg9ZxCBnSc/2CiVH7zj+l8H4jF3WKYuLCvBT+uFaYoR8k0DFZ1OlxyGNgy/JUqj0yOGohe43Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750391636; c=relaxed/simple;
	bh=ZbMmurYJaKY5lkw0VcwClw93/1JlV36rPOejef/6RLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:CC:From:
	 In-Reply-To:Content-Type; b=GEioNvHMpuvPezEEbwAMgTpVhey11+SVFDSIOShKmWmTRMbt6HVaCFgs6sTWmZX1kj1yA0lJNjEc7r7JW2IbfdZoX5eKkSLYysx0k0hUxVjtuc7/5gyUBc+YpBvEfbI4O88smCBzXRn8pQyAuo7V95JDqJKPtQ6R4FFIutwsAWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bNk7k2SW8z2BdWC;
	Fri, 20 Jun 2025 11:52:18 +0800 (CST)
Received: from kwepemo100006.china.huawei.com (unknown [7.202.195.47])
	by mail.maildlp.com (Postfix) with ESMTPS id 6C2B1140294;
	Fri, 20 Jun 2025 11:53:48 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemo100006.china.huawei.com
 (7.202.195.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 20 Jun
 2025 11:53:47 +0800
Message-ID: <ff65b997-eb14-798f-1d2f-c375bf763e71@hisilicon.com>
Date: Fri, 20 Jun 2025 11:53:47 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v2 2/2] cpufreq: CPPC: Dont read counters for idle CPUs
To: Prashant Malani <pmalani@google.com>
References: <20250619000925.415528-1-pmalani@google.com>
 <20250619000925.415528-3-pmalani@google.com>
CC: Ben Segall <bsegall@google.com>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>, Juri Lelli
	<juri.lelli@redhat.com>, open list <linux-kernel@vger.kernel.org>, "open
 list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>, Mel Gorman
	<mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Valentin Schneider
	<vschneid@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh
 Kumar <viresh.kumar@linaro.org>, Ionela Voinescu <ionela.voinescu@arm.com>,
	Beata Michalska <beata.michalska@arm.com>, z00813676
	<zhenglifeng1@huawei.com>
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20250619000925.415528-3-pmalani@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo100006.china.huawei.com (7.202.195.47)

Hi Prashant,

Thanks for spotting this.
Cc'd a few more developers.

Jie

On 19/06/2025 08:09, Prashant Malani wrote:
> AMU performance counters tend to be inaccurate when measured on idle CPUs.
> On an idle CPU which is programmed to 3.4 GHz (verified through firmware),
> here is a measurement and calculation of operating frequency:
> 
> t0: ref=899127636, del=3012458473
> t1: ref=899129626, del=3012466509
> perf=40

In this case, the target cpu is mostly idle but not fully idle during the
sampling window since the counter grows a little bit.
Perhaps some interrupts happen to run on the cpu shortly.

Thus, the actual issue is the accuracy of frequency sampling becomes poor
when the delta of counters are too small to obtain a reliable accuracy.

Would it be more sensible to put a minimum threshold of the delta of
counters when sampling the frequency?

If the threshold is not met, we can go to the existing out_invalid_counters
path.  Then we don't have to export idle_cpu() either, and BTW, that ABI
doesn't seem to be synchronous at all, i.e. the cpu might be busy when we
check and then become idle when sampling.

> 
> For reference, when we measure the same CPU with stress-ng running, we have
> a more accurate result:
> t0: ref=30751756418, del=104490567689
> t1: ref=30751760628, del=104490582296
> perf=34
> 
> (t0 and t1 are 2 microseconds apart)
> 
> In the above, the prescribed method[1] of calculating frequency from CPPC
> counters was used.
> 
> The follow-on effect is that the inaccurate frequency is stashed in the
> cpufreq policy struct when the CPU is brought online. Since CPUs are mostly
> idle when they are brought online, this means cpufreq has an inaccurate
> view of the programmed clock rate.
> 
> Consequently, if userspace tries to actually set the frequency to the
> previously erroneous rate (4 GHz in the above example), cpufreq returns
> early without calling in to the CPPC driver to send the relevant PCC
> command; it thinks the CPU is already at that frequency.
> 
> Update the CPPC get_rate() code to skip sampling counters if we know a CPU
> is idle, and go directly to the fallback response of returning the
> “desired” frequency. The code intends to do that anyway if the counters
> happen to return an “idle” reading.
> 
> [1] https://docs.kernel.org/admin-guide/acpi/cppc_sysfs.html#computing-average-delivered-performance
> 
> Signed-off-by: Prashant Malani <pmalani@google.com>
> ---
> 
> Changes in v2:
> - Add sched.h header for usage when compiled as module.
> 
>  drivers/cpufreq/cppc_cpufreq.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index b7c688a5659c..5ed04774e569 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -18,6 +18,7 @@
>  #include <linux/cpufreq.h>
>  #include <linux/irq_work.h>
>  #include <linux/kthread.h>
> +#include <linux/sched.h>
>  #include <linux/time.h>
>  #include <linux/vmalloc.h>
>  #include <uapi/linux/sched/types.h>
> @@ -753,6 +754,10 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
>  
>  	cpufreq_cpu_put(policy);
>  
> +	/* Idle CPUs have unreliable counters, so skip to the end. */
> +	if (idle_cpu(cpu))
> +		goto out_invalid_counters;
> +
>  	ret = cppc_get_perf_ctrs_sample(cpu, &fb_ctrs_t0, &fb_ctrs_t1);
>  	if (ret) {
>  		if (ret == -EFAULT)

