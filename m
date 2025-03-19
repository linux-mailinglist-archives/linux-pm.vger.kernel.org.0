Return-Path: <linux-pm+bounces-24285-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11480A68E93
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 15:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AC083A81CC
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 14:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E23E1B0F33;
	Wed, 19 Mar 2025 14:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nsnGL11R"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B6223AD;
	Wed, 19 Mar 2025 14:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742393112; cv=none; b=rLYSLNhItW76WO3uXy2dlw+i12+w6JeXnZk0ddb9iZr0tNl725WsLMJ2WNBge9rGjiZgXU3fXNwCGwCbgAwOCVfyTtL9OJDro5cnfU/xW39dCER+lyOcPRkJnbmMdwyHAexGZ88Yl5PdHpbg84IVeu/nSaINw58xYorM5AoUqZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742393112; c=relaxed/simple;
	bh=auuj8U0iIZPEnK1LHdzsygpODXcIt/+SyEI16lyN7Eo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PpE/Sg/2dcS+2DXJ9cmQHrYrtCJRi7qpYQj/nnHlY1bguJN7T8/xOyPeb6EiGha9NsLGF/o27dA2n8TBh+UR8S8AZ3Z3t36GUBRaGV2JHr7jpQ9PnDubUvs+AL8iRylf/eDVV1A10hafahjrKqXkP8F8MCHFhqzIg4DBMqIWSac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nsnGL11R; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742393111; x=1773929111;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=auuj8U0iIZPEnK1LHdzsygpODXcIt/+SyEI16lyN7Eo=;
  b=nsnGL11RzyFIT2D2ZW3Z0Bgrc/G7v5clCxlCz3PIMTeo6E2Ogz88BFPR
   F+1oAsMmITkW2w5w/MN8D4iL6WMCp16BVibHlsqcyt1ICougG3HL93Y8V
   Z/gJxUxgMe4DadNVaMafm+i4fVMKZavhX9YbVolivAR9Rl/AlSoRYha/1
   xWjElhL9V1d9yBQn/NKTomDgi9Av6M83LVFbAqjNKJNrwGjmrq0DyP0nY
   bCjCRx0583q1gc+PcB83TGDZ8LEb7OPiw8TlGmj4bGTJL8WpOZMRlz6sv
   MGjoZFbhh09J3hsIlkcqcu4nwfPz0URHSPlX/LRalO7dmcgJMdqds2lK3
   Q==;
X-CSE-ConnectionGUID: hdpH3kv1Qf++MTe0Tbskdg==
X-CSE-MsgGUID: d4sEPQUNT06ihujwSqbc+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="60977797"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="60977797"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 07:04:52 -0700
X-CSE-ConnectionGUID: 8ypkxE1JQJ2856hFDMdnqQ==
X-CSE-MsgGUID: wr1YiOOiTR6BDJYmJW9OEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="159812919"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.21])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 07:04:44 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 19 Mar 2025 16:04:40 +0200 (EET)
To: Mario Limonciello <superm1@kernel.org>
cc: Hans de Goede <hdegoede@redhat.com>, 
    Mario Limonciello <mario.limonciello@amd.com>, 
    Perry Yuan <perry.yuan@amd.com>, Thomas Gleixner <tglx@linutronix.de>, 
    Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
    Dave Hansen <dave.hansen@linux.intel.com>, 
    "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, 
    "H . Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, 
    Huang Rui <ray.huang@amd.com>, 
    "Gautham R . Shenoy" <gautham.shenoy@amd.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, 
    Viresh Kumar <viresh.kumar@linaro.org>, 
    "open list:AMD HETERO CORE HARDWARE FEEDBACK DRIVER" <platform-driver-x86@vger.kernel.org>, 
    "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>, 
    "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
    "open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>, 
    Perry Yuan <Perry.Yuan@amd.com>
Subject: Re: [PATCH v8 07/13] platform/x86: hfi: add online and offline
 callback support
In-Reply-To: <20250218190822.1039982-8-superm1@kernel.org>
Message-ID: <529e9c45-df4f-440e-3232-106cbec12faf@linux.intel.com>
References: <20250218190822.1039982-1-superm1@kernel.org> <20250218190822.1039982-8-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 18 Feb 2025, Mario Limonciello wrote:

> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> There are some firmware parameters that need to be configured
> when a CPU core is brought online or offline.
> 
> when CPU is online, it will initialize the workload classification
> parameters to CPU firmware which will trigger the workload class ID
> updating function.
> 
> Once the CPU is going to offline, it will need to disable the workload
> classification function and clear the history.
> 
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v8:
>  * Move cpus member to this patch
>  * Add comment about online
> v7:
>  * move mutex to this patch
> ---
>  drivers/platform/x86/amd/hfi/hfi.c | 87 ++++++++++++++++++++++++++++++
>  1 file changed, 87 insertions(+)
> 
> diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
> index e1550f4463275..90b57175ccd97 100644
> --- a/drivers/platform/x86/amd/hfi/hfi.c
> +++ b/drivers/platform/x86/amd/hfi/hfi.c
> @@ -93,6 +93,7 @@ struct amd_hfi_classes {
>   * struct amd_hfi_cpuinfo - HFI workload class info per CPU
>   * @cpu:		cpu index
>   * @apic_id:		apic id of the current cpu
> + * @cpus:		mask of cpus associated with amd_hfi_cpuinfo
>   * @class_index:	workload class ID index
>   * @nr_class:		max number of workload class supported
>   * @ipcc_scores:	ipcc scores for each class
> @@ -103,6 +104,7 @@ struct amd_hfi_classes {
>  struct amd_hfi_cpuinfo {
>  	int		cpu;
>  	u32		apic_id;
> +	cpumask_var_t	cpus;
>  	s16		class_index;
>  	u8		nr_class;
>  	int		*ipcc_scores;
> @@ -111,6 +113,8 @@ struct amd_hfi_cpuinfo {
>  
>  static DEFINE_PER_CPU(struct amd_hfi_cpuinfo, amd_hfi_cpuinfo) = {.class_index = -1};
>  
> +static DEFINE_MUTEX(hfi_cpuinfo_lock);

Please mention what this protects.

> +
>  static int find_cpu_index_by_apicid(unsigned int target_apicid)
>  {
>  	int cpu_index;
> @@ -234,6 +238,80 @@ static int amd_set_hfi_ipcc_score(struct amd_hfi_cpuinfo *hfi_cpuinfo, int cpu)
>  	return 0;
>  }
>  
> +static int amd_hfi_set_state(unsigned int cpu, bool state)
> +{
> +	int ret;
> +
> +	ret = wrmsrl_on_cpu(cpu, AMD_WORKLOAD_CLASS_CONFIG, state);

I'd prefer bool -> u64 conversion be done explicitly, eg. ,with ?: 
operator.

> +	if (ret)
> +		return ret;
> +
> +	return wrmsrl_on_cpu(cpu, AMD_WORKLOAD_HRST, 0x1);
> +}
> +
> +/**
> + * amd_hfi_online() - Enable workload classification on @cpu
> + * @cpu: CPU in which the workload classification will be enabled
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +static int amd_hfi_online(unsigned int cpu)
> +{
> +	struct amd_hfi_cpuinfo *hfi_info = per_cpu_ptr(&amd_hfi_cpuinfo, cpu);
> +	struct amd_hfi_classes *hfi_classes;
> +	int ret;
> +
> +	if (WARN_ON_ONCE(!hfi_info))
> +		return -EINVAL;
> +
> +	/*
> +	 * Check if @cpu as an associated, initialized and ranking data must be filled

Please fold to 80 characters.

> +	 */
> +	hfi_classes = hfi_info->amd_hfi_classes;
> +	if (!hfi_classes)
> +		return -EINVAL;
> +
> +	guard(mutex)(&hfi_cpuinfo_lock);
> +
> +	if (!zalloc_cpumask_var(&hfi_info->cpus, GFP_KERNEL))
> +		return -ENOMEM;
> +
> +	cpumask_set_cpu(cpu, hfi_info->cpus);
> +
> +	ret = amd_hfi_set_state(cpu, true);
> +	if (ret)
> +		pr_err("WCT enable failed for CPU %d\n", cpu);

%u

> +
> +	return ret;
> +}
> +
> +/**
> + * amd_hfi_offline() - Disable workload classification on @cpu
> + * @cpu: CPU in which the workload classification will be disabled
> + *
> + * Remove @cpu from those covered by its HFI instance.
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +static int amd_hfi_offline(unsigned int cpu)
> +{
> +	struct amd_hfi_cpuinfo *hfi_info = &per_cpu(amd_hfi_cpuinfo, cpu);
> +	int ret;
> +
> +	if (WARN_ON_ONCE(!hfi_info))
> +		return -EINVAL;
> +
> +	guard(mutex)(&hfi_cpuinfo_lock);
> +
> +	ret = amd_hfi_set_state(cpu, false);
> +	if (ret)
> +		pr_err("WCT disable failed for CPU %d\n", cpu);

%u

> +
> +	free_cpumask_var(hfi_info->cpus);
> +
> +	return ret;
> +}
> +
>  static int update_hfi_ipcc_scores(void)
>  {
>  	int cpu;
> @@ -339,6 +417,15 @@ static int amd_hfi_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	/*
> +	 * Tasks will already be running at the time this happens. This is
> +	 * OK because rankings will be adjusted by the callbacks.
> +	 */
> +	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/amd_hfi:online",
> +				amd_hfi_online, amd_hfi_offline);
> +	if (ret < 0)
> +		return ret;
> +
>  	return 0;
>  }
>  
> 

-- 
 i.


