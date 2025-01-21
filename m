Return-Path: <linux-pm+bounces-20768-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1C6A17C26
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 11:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 059BB3A6AAD
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 10:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3344F1F12E2;
	Tue, 21 Jan 2025 10:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lAopDuXA"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9723F1B0F1E;
	Tue, 21 Jan 2025 10:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737456455; cv=none; b=AWGtzA0YKlrb8tuw7QzMlNoquwNGHPhHMURkizg+ueYi10NB0IxRdpjwqn2JFf+klOX5RG3S+duLrUwC95IEH6HdPHEo0vXcPEVK8k07Ioy9gce8fTS5/FhLLzybZMCD9keyCSeYi40J+zeKYBpM6HiBkdKWxfVvNMcoEGPqIHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737456455; c=relaxed/simple;
	bh=EWaUNnruHpal+zW0Tc0ycVqyE0sHBEGQZtpuE9Jg4dk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UyydlAPCI/lXJYsmpCNZ6Ejn5i4lhuJ+Hin4rtLdxX6lSYFI7eGpKJkvR/zU/W1VHjRi27wrEjQDBxfXK8w89rFyHkSCtGoHQ7pmVqLCDMSLZF74Q8hh8JVacMe9HfODjq1FJr2KT4OPxZuXlbp+tetuMOcoqfyigN168DtnZaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=lAopDuXA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.156.205.88] (unknown [167.220.238.88])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3571C205A9D6;
	Tue, 21 Jan 2025 02:47:28 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3571C205A9D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1737456453;
	bh=0p9kCPX0kFOEZOIBaQgiLe2sNq8cghl604dX/e+fCK8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lAopDuXA60YAgdosgvAgfkgCazTII9V7wWa/8Mlz02BIA7k/oczJScx2D4fM9nVLm
	 YYkon7r8GCQhgmxjqvEaoSNBbUz6Jqatsr1fFT0NOE68Dlfag33/rqCcEcX2ZqnaJq
	 jyxqxweMzxBITuutSmC4d3G0o8+GRUZMu39raYaM=
Message-ID: <f9606b7c-e20c-43cb-bc03-1deecb0d7539@linux.microsoft.com>
Date: Tue, 21 Jan 2025 16:17:27 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/5] cpufreq: Allow arch_freq_get_on_cpu to return an
 error
To: Beata Michalska <beata.michalska@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
 ionela.voinescu@arm.com, sudeep.holla@arm.com, will@kernel.org,
 catalin.marinas@arm.com, rafael@kernel.org, viresh.kumar@linaro.org
Cc: sumitg@nvidia.com, yang@os.amperecomputing.com,
 vanshikonda@os.amperecomputing.com, lihuisong@huawei.com,
 zhanjie9@hisilicon.com
References: <20250121084435.2839280-1-beata.michalska@arm.com>
 <20250121084435.2839280-2-beata.michalska@arm.com>
Content-Language: en-US
From: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
In-Reply-To: <20250121084435.2839280-2-beata.michalska@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 21-01-2025 14:14, Beata Michalska wrote:
> Allow arch_freq_get_on_cpu to return an error for cases when retrieving
> current CPU frequency is not possible, whether that being due to lack of
> required arch support or due to other circumstances when the current
> frequency cannot be determined at given point of time.
>
> Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> ---
>   arch/x86/kernel/cpu/aperfmperf.c | 2 +-
>   arch/x86/kernel/cpu/proc.c       | 7 +++++--
>   drivers/cpufreq/cpufreq.c        | 8 ++++----
>   include/linux/cpufreq.h          | 2 +-
>   4 files changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
> index f642de2ebdac..6cf31a1649c4 100644
> --- a/arch/x86/kernel/cpu/aperfmperf.c
> +++ b/arch/x86/kernel/cpu/aperfmperf.c
> @@ -498,7 +498,7 @@ void arch_scale_freq_tick(void)
>    */
>   #define MAX_SAMPLE_AGE	((unsigned long)HZ / 50)
>   
> -unsigned int arch_freq_get_on_cpu(int cpu)
> +int arch_freq_get_on_cpu(int cpu)
>   {
>   	struct aperfmperf *s = per_cpu_ptr(&cpu_samples, cpu);
>   	unsigned int seq, freq;
> diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
> index 41ed01f46bd9..d79f5845a463 100644
> --- a/arch/x86/kernel/cpu/proc.c
> +++ b/arch/x86/kernel/cpu/proc.c
> @@ -86,9 +86,12 @@ static int show_cpuinfo(struct seq_file *m, void *v)
>   		seq_printf(m, "microcode\t: 0x%x\n", c->microcode);
>   
>   	if (cpu_has(c, X86_FEATURE_TSC)) {
> -		unsigned int freq = arch_freq_get_on_cpu(cpu);
> +		int freq = arch_freq_get_on_cpu(cpu);
>   
> -		seq_printf(m, "cpu MHz\t\t: %u.%03u\n", freq / 1000, (freq % 1000));
> +		if (freq <= 0)
> +			seq_puts(m, "cpu MHz\t\t: Unknown\n");
> +		else
> +			seq_printf(m, "cpu MHz\t\t: %u.%03u\n", freq / 1000, (freq % 1000));
>   	}
>   
>   	/* Cache size */
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 418236fef172..6f45684483c4 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -728,18 +728,18 @@ show_one(cpuinfo_transition_latency, cpuinfo.transition_latency);
>   show_one(scaling_min_freq, min);
>   show_one(scaling_max_freq, max);
>   
> -__weak unsigned int arch_freq_get_on_cpu(int cpu)
> +__weak int arch_freq_get_on_cpu(int cpu)
>   {
> -	return 0;
> +	return -EOPNOTSUPP;
>   }
>   
>   static ssize_t show_scaling_cur_freq(struct cpufreq_policy *policy, char *buf)
>   {
>   	ssize_t ret;
> -	unsigned int freq;
> +	int freq;
>   
>   	freq = arch_freq_get_on_cpu(policy->cpu);
> -	if (freq)
> +	if (freq > 0)
>   		ret = sysfs_emit(buf, "%u\n", freq);
>   	else if (cpufreq_driver->setpolicy && cpufreq_driver->get)
>   		ret = sysfs_emit(buf, "%u\n", cpufreq_driver->get(policy->cpu));
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 7fe0981a7e46..02fd4746231d 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -1184,7 +1184,7 @@ static inline int of_perf_domain_get_sharing_cpumask(int pcpu, const char *list_
>   }
>   #endif
>   
> -extern unsigned int arch_freq_get_on_cpu(int cpu);
> +extern int arch_freq_get_on_cpu(int cpu);
>   
>   #ifndef arch_set_freq_scale
>   static __always_inline

Looks good to me.

Reviewed-by: Prasanna Kumar T S M <ptsm@linux.microsoft.com>



