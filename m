Return-Path: <linux-pm+bounces-20910-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23745A1AF93
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 05:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AE7F16C4DD
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 04:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5691155759;
	Fri, 24 Jan 2025 04:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kWv1NEQV"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBF929A0;
	Fri, 24 Jan 2025 04:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737694095; cv=none; b=D2SHsows2ZDpxJZ1oeo6LfpgeDPaEVO3hZD5HpZfC4gobON3XDDwJ8pspbNgVaEKDyVSmStblDianQzDWASYDMk2H9QivoV3Hf0uQV4EqdFx+hwLtRVk2LJoMjixuV8eVESnrmU+PDJChMJj1WWywn5Z28hlqgcs7fh1IJECtos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737694095; c=relaxed/simple;
	bh=kH6UcAV7u2+79dAhGdbI9ggw9A+1NALbqVGovin7JQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SHUdD1ADZH07E0nxBV9jzYfanBrcUpTcCt0SmZPzUFMIoPO6+eSi69aPMxoylJSxYCzxY0qLy+Q/iBmbr3ap1ifqh3pGiJcVZ+LBNsHKjPDbQQ2oil5xZHICsSeOd5gOAe4m/OPOTstQGZwF5H4IkqOPVOIm/MbQ+jirb51EJGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kWv1NEQV; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.193.133] (unknown [4.194.122.144])
	by linux.microsoft.com (Postfix) with ESMTPSA id 56D112109A4E;
	Thu, 23 Jan 2025 20:48:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 56D112109A4E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1737694093;
	bh=CHlPyp9Wsuk1//JTHYevQVMmyaXun/9BTDCPm9l+sfA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kWv1NEQVs7Epi4AflhK354YKrJsnt7W1bJdhPnm0tiNEr9iXNhxRQCthDKtFMXzgQ
	 1Fz2WJ3rusE6h43nEL7z9lJgXHiviiqHta0zOv5YGagYMJioGSetjFcKcSC/j+SWgB
	 lffGBtaGu6d+tLFgN2eyTTrZj1nXv4uFOFdNkBao=
Message-ID: <d44f53b1-c028-45c9-b3e9-cc0afd9925f2@linux.microsoft.com>
Date: Fri, 24 Jan 2025 10:18:08 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/5] arm64: amu: Delay allocating cpumask for AMU FIE
 support
To: Beata Michalska <beata.michalska@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
 ionela.voinescu@arm.com, sudeep.holla@arm.com, will@kernel.org,
 catalin.marinas@arm.com, rafael@kernel.org, viresh.kumar@linaro.org
Cc: sumitg@nvidia.com, yang@os.amperecomputing.com,
 vanshikonda@os.amperecomputing.com, lihuisong@huawei.com,
 zhanjie9@hisilicon.com
References: <20250121084435.2839280-1-beata.michalska@arm.com>
 <20250121084435.2839280-4-beata.michalska@arm.com>
Content-Language: en-US
From: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
In-Reply-To: <20250121084435.2839280-4-beata.michalska@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 21-01-2025 14:14, Beata Michalska wrote:
> For the time being, the amu_fie_cpus cpumask is being exclusively used
> by the AMU-related internals of FIE support and is guaranteed to be
> valid on every access currently made. Still the mask is not being
> invalidated on one of the error handling code paths, which leaves
> a soft spot with theoretical risk of UAF for CPUMASK_OFFSTACK cases.
> To make things sound, delay allocating said cpumask
> (for CPUMASK_OFFSTACK) avoiding otherwise nasty sanitising case failing
> to register the cpufreq policy notifications.
>
> Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> ---
>   arch/arm64/kernel/topology.c | 22 ++++++++++------------
>   1 file changed, 10 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index 1a2c72f3e7f8..cb180684d10d 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -194,12 +194,19 @@ static void amu_fie_setup(const struct cpumask *cpus)
>   	int cpu;
>   
>   	/* We are already set since the last insmod of cpufreq driver */
> -	if (unlikely(cpumask_subset(cpus, amu_fie_cpus)))
> +	if (cpumask_available(amu_fie_cpus) &&
> +	    unlikely(cpumask_subset(cpus, amu_fie_cpus)))
>   		return;
>   
> -	for_each_cpu(cpu, cpus) {
> +	for_each_cpu(cpu, cpus)
>   		if (!freq_counters_valid(cpu))
>   			return;
> +
> +	if (!cpumask_available(amu_fie_cpus) &&
> +	    !zalloc_cpumask_var(&amu_fie_cpus, GFP_KERNEL)) {
> +		WARN_ONCE(1, "Failed to allocate FIE cpumask for CPUs[%*pbl]\n",
> +			  cpumask_pr_args(cpus));
> +		return;
>   	}
>   
>   	cpumask_or(amu_fie_cpus, amu_fie_cpus, cpus);
> @@ -237,17 +244,8 @@ static struct notifier_block init_amu_fie_notifier = {
>   
>   static int __init init_amu_fie(void)
>   {
> -	int ret;
> -
> -	if (!zalloc_cpumask_var(&amu_fie_cpus, GFP_KERNEL))
> -		return -ENOMEM;
> -
> -	ret = cpufreq_register_notifier(&init_amu_fie_notifier,
> +	return cpufreq_register_notifier(&init_amu_fie_notifier,
>   					CPUFREQ_POLICY_NOTIFIER);
> -	if (ret)
> -		free_cpumask_var(amu_fie_cpus);
> -
> -	return ret;
>   }
>   core_initcall(init_amu_fie);
>   

This patch appears useful, irrespective of the feature introduced by 
this series. Isn't it? Can you please carve out this into an individual 
patch?

The change looks good to me.

Reviewed-by: Prasanna Kumar T S M <ptsm@linux.microsoft.com>.

Please feel free to add my reviewed-by tag even if you are carving this 
patch out.


