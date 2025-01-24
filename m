Return-Path: <linux-pm+bounces-20909-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2109A1AF91
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 05:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5F701882A6E
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 04:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D53E5733A;
	Fri, 24 Jan 2025 04:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GylOoa/b"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1C319AD87;
	Fri, 24 Jan 2025 04:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737693919; cv=none; b=ttRecHiunoWWTYbU7y2c3bij0MIIXgGPFnYntx0yUxinOHw4A8CNijzExuBaO+IjPLdFesYZ7OSP/5TLj8rDVVcdnwJw5+P0S9NTTPnPJ02ykYeKZm9vUUlmQ9I1mHzv7ANnaSYNK7jXUyDXxmpldpH9uTMHH3k1Xjhgy8Umopw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737693919; c=relaxed/simple;
	bh=sVFUOJ0YAj6hx4IiUO/y+3vL+lCeYfrQ8ypn98d6+5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iXtXJ9JXVl2BzdOEg0LbpJh38JGYLK3jQ5qZyQQ4/csCSIALg7k9rsKfHdKGCGGmARABKDLEPFH5dXyjMgwcS4coaGluYstTF6ThJAnzZMmfY5jel7mJQaMjZP/roRnCd1FIllBctz2Nh/hvxmGg1ZDQXCTXxZH48Z446B5XgAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GylOoa/b; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.193.133] (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id CC5132109A4E;
	Thu, 23 Jan 2025 20:45:13 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CC5132109A4E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1737693917;
	bh=+20Fk7zyp2RtNpIMRSC1POlfQ3etXop9xutsBlpZu2o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GylOoa/b7uIZmPHUubKyuKJiom+DF/cIZ08dUsmrxl6niNCvsENNXYCX464tVNTTy
	 OqvzbUfaYlgiLai86dE6KzPiS3Cj3SwfqGQxrTyfrpAApL0ZZJf9w+bIvRQqT3T1o9
	 t7l3RtYeDKOxfPlkl+WQ2xiRfF7bp6tdWyt3UZCo=
Message-ID: <fe4c48e0-5bc5-4a16-8df2-e848b55c1015@linux.microsoft.com>
Date: Fri, 24 Jan 2025 10:15:11 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 5/5] arm64: Update AMU-based freq scale factor on
 entering idle
To: Beata Michalska <beata.michalska@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
 ionela.voinescu@arm.com, sudeep.holla@arm.com, will@kernel.org,
 catalin.marinas@arm.com, rafael@kernel.org, viresh.kumar@linaro.org
Cc: sumitg@nvidia.com, yang@os.amperecomputing.com,
 vanshikonda@os.amperecomputing.com, lihuisong@huawei.com,
 zhanjie9@hisilicon.com
References: <20250121084435.2839280-1-beata.michalska@arm.com>
 <20250121084435.2839280-6-beata.michalska@arm.com>
Content-Language: en-US
From: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
In-Reply-To: <20250121084435.2839280-6-beata.michalska@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 21-01-2025 14:14, Beata Michalska wrote:
> Now that the frequency scale factor has been activated for retrieving
> current frequency on a given CPU, trigger its update upon entering
> idle. This will, to an extent, allow querying last known frequency
> in a non-invasive way. It will also improve the frequency scale factor
> accuracy when a CPU entering idle did not receive a tick for a while.
> As a consequence, for idle cores, the reported frequency will be the
> last one observed before entering the idle state.
>
> Suggested-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
> Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> ---
>   arch/arm64/kernel/topology.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index 5f5738b174c7..6c43aafac77c 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -213,6 +213,19 @@ static __always_inline bool amu_fie_cpu_supported(unsigned int cpu)
>   		cpumask_test_cpu(cpu, amu_fie_cpus);
>   }
>   
> +void arch_cpu_idle_enter(void)
> +{
> +	unsigned int cpu = smp_processor_id();
> +
> +	if (!amu_fie_cpu_supported(cpu))
> +		return;
> +
> +	/* Kick in AMU update but only if one has not happened already */
> +	if (housekeeping_cpu(cpu, HK_TYPE_TICK) &&
> +	    time_is_before_jiffies(per_cpu(cpu_amu_samples.last_scale_update, cpu)))
> +		amu_scale_freq_tick();
> +}
> +
>   #define AMU_SAMPLE_EXP_MS	20
>   
>   int arch_freq_get_on_cpu(int cpu)

Looks good to me.

Reviewed-by: Prasanna Kumar T S M <ptsm@linux.microsoft.com>


