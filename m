Return-Path: <linux-pm+bounces-15773-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF019A0A7F
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 14:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E86E2837D7
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 12:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A6C208980;
	Wed, 16 Oct 2024 12:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GQwALbME"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF32720968C;
	Wed, 16 Oct 2024 12:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729082542; cv=none; b=lPg6UHLfRoT00xOcjks6PxUgUdlSKBE/y3YX+uitF0+lZhm3xS2F2/AcsYOoZ56PkcjMaFnZuqhNzqb6BP6bjxhBFnGU7DatBZdRmxxs5z+kNlVi/XVFzwekkdw3M94otJj9Nwj3+q2WS+z+Hu3e8+HSc29/EvLEGis/56lKZUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729082542; c=relaxed/simple;
	bh=mfZCS/YvQRfbKpF5PwATL1VgEMe7ftuAp3U7oxYxOcY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=aXFidbwHxOPvvzCmb7UUX7236/kTgBglV2Xo0Z3NPbbIm3Qm1dZGClrZEbeQun5hfEsz1HkJh3KtwAvXEtzMaVHTAT83sPwEp2uztnIwTxUhxG0yyAN/7SlWomLjk3zVu6YAxJ+frohaBg4Fm1pnKMjqlOPfKBeh1w4oYxPJnP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GQwALbME; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729082541; x=1760618541;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=mfZCS/YvQRfbKpF5PwATL1VgEMe7ftuAp3U7oxYxOcY=;
  b=GQwALbMEucedPIyH6C5l1NToilDMgL3rvMbsJdLqnr2OP5dbXVzbeKI5
   QBGRChCJ5hJ2/dm++kKWRHcgw3rXATQoQsdh0xTXB2gihIrjrIiTkNWWx
   qWzd0BQ6GfpbY6WiKVBDvDgPm3ywuR9bgvkDFPIkHjXjbxeLGpJ7oLCBb
   FN0F1nFbilTRyU/OQ7l3J1s774wHPlWqGuekVOpgdz9zi/o9AE9xBn8bC
   F2sKONPwsGVFsjW2pqQzA+mix/d/tUH4mz5XkX/v7Cvw/gAK+U8guw/3f
   2t/AG95WOHBPoiiwtHAPH+o+8u8Mmo4WRjK9lKcagkEh7XUAwzSB+Ja+r
   w==;
X-CSE-ConnectionGUID: l4N3fxzzRrq1JoppQe0iuA==
X-CSE-MsgGUID: RrsPbNbdSwGTlHsW0keocw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28671998"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28671998"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 05:42:18 -0700
X-CSE-ConnectionGUID: RvbG9njdQ3eEa7qBocmhhA==
X-CSE-MsgGUID: GpQNHvBGTCOvagr6XZctEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="78559016"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.221])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 05:42:14 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 16 Oct 2024 15:42:10 +0300 (EEST)
To: Mario Limonciello <mario.limonciello@amd.com>
cc: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>, 
    x86@kernel.org, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, 
    Perry Yuan <perry.yuan@amd.com>, LKML <linux-kernel@vger.kernel.org>, 
    linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, 
    platform-driver-x86@vger.kernel.org, 
    Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
    Perry Yuan <Perry.Yuan@amd.com>
Subject: Re: [PATCH v3 08/14] platform/x86: hfi: add online and offline
 callback support
In-Reply-To: <20241015213645.1476-9-mario.limonciello@amd.com>
Message-ID: <9b401086-5020-b85c-697b-39a8be5b49fa@linux.intel.com>
References: <20241015213645.1476-1-mario.limonciello@amd.com> <20241015213645.1476-9-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 15 Oct 2024, Mario Limonciello wrote:

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
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v2->v3:
>  * Use guard() (Ilpo)
>  * Whitespace changes (Ilpo)
>  * Remove labels for unwind (Ilpo)
> ---
>  drivers/platform/x86/amd/hfi/hfi.c | 79 ++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
> 
> diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
> index 63e66ab60655..d971ec1124af 100644
> --- a/drivers/platform/x86/amd/hfi/hfi.c
> +++ b/drivers/platform/x86/amd/hfi/hfi.c
> @@ -249,6 +249,80 @@ static int amd_set_hfi_ipcc_score(struct amd_hfi_cpuinfo *hfi_cpuinfo, int cpu)
>  	return 0;
>  }
>  
> +static int amd_hfi_set_state(unsigned int cpu, bool state)
> +{
> +	int ret;
> +
> +	ret = wrmsrl_on_cpu(cpu, AMD_WORKLOAD_CLASS_CONFIG, state);
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
> +		pr_err("WCT enable failed for cpu %d\n", cpu);

cpu -> CPU

-- 
 i.

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
> +
> +	free_cpumask_var(hfi_info->cpus);
> +
> +	return ret;
> +}
> +
>  static int update_hfi_ipcc_scores(void)
>  {
>  	int cpu;
> @@ -352,6 +426,11 @@ static int amd_hfi_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/amd_hfi:online",
> +				amd_hfi_online, amd_hfi_offline);
> +	if (ret < 0)
> +		return ret;
> +
>  	return 0;
>  }
>  
> 

