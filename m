Return-Path: <linux-pm+bounces-15613-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE8799C722
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 12:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B2FD1F230B6
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 10:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9653215B966;
	Mon, 14 Oct 2024 10:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cp1UTgKR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65DA1581F4;
	Mon, 14 Oct 2024 10:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728901680; cv=none; b=gfyuSM1r0UWRlm7IXz2IfdifUJObSuAjiK61lor8msgZ+scc53Mu/MO3R/6yUJo/95rLDEm0hMNxztXwboUzM43fnKZ+qd84dc6pJzum5HGFEM+WxEQG0+qph8+h04Xp5toQ/2r5kpTTw/TlCqELfS4pUGysvyHzfsFtxpbSCKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728901680; c=relaxed/simple;
	bh=/x/LsY/aVu7s1s285cFiXfR6VzB7TchgvYMbmfm557M=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Eq/2EbfQ2/2QZvb5wUzhC74s2l+176H4gfo6STLFwVmQCOCaCah985vtCSBESh1ceu1pH+ZHm++yrsb1BaxRFL4nytRiMFkp/yhAGey7REghCHUjw2sf+LW8vPPbUrrwzYWNZh0Edf0I0G1ZowEhQROLZ9ne1/lavElKC+L4e2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cp1UTgKR; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728901679; x=1760437679;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/x/LsY/aVu7s1s285cFiXfR6VzB7TchgvYMbmfm557M=;
  b=cp1UTgKRh3DZfzOXwfT8oYVvO3VwRh70IAzxfIEnnlk1mBX68qqkDy+H
   s7RFCUP3+MCa8lyx4yYmG4LpoGnWCi5nUVr5eym+GZ75a+9SuJTv++WXY
   G75//bIp9Ib/x5WioKkTPoPL4hqB3b76t2OY476VntJ116MOe6yoAG96R
   LBIcLq/6y5UTAG6hIxysRROC1wbvVyCF2gRhspYQNOqMyZg5t1ai6ryAb
   3VsbI2Wf+FlBO7eOU1AsV9b4abFS3uX1VWJG7h6iHN0q53zZXdSDv+t5i
   4j9c0P0u539B3JOw6gbiV91VYFg63oKEIcBEUZYfjSY/9TCTllX+KFl7p
   g==;
X-CSE-ConnectionGUID: gBerMYiPThmOnnuVAxvtOQ==
X-CSE-MsgGUID: x3Hvu1glRdatw2c7U737/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11224"; a="53661957"
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="53661957"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 03:27:58 -0700
X-CSE-ConnectionGUID: qSpQVaiOSMiJ4jPHFsHBhA==
X-CSE-MsgGUID: 85xHFdkyTDO5DHKm5mdtnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="77464082"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.80])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 03:27:55 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 14 Oct 2024 13:27:51 +0300 (EEST)
To: Mario Limonciello <mario.limonciello@amd.com>
cc: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>, 
    x86@kernel.org, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, 
    Perry Yuan <perry.yuan@amd.com>, LKML <linux-kernel@vger.kernel.org>, 
    linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, 
    platform-driver-x86@vger.kernel.org, 
    Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
    Perry Yuan <Perry.Yuan@amd.com>
Subject: Re: [PATCH v2 08/13] platform/x86: hfi: add online and offline
 callback support
In-Reply-To: <20241010193705.10362-9-mario.limonciello@amd.com>
Message-ID: <55ddb80c-abfa-f3e2-442a-65f270dadbf2@linux.intel.com>
References: <20241010193705.10362-1-mario.limonciello@amd.com> <20241010193705.10362-9-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 10 Oct 2024, Mario Limonciello wrote:

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
> v2:
>  * Rebase
> ---
>  drivers/platform/x86/amd/hfi/hfi.c | 90 +++++++++++++++++++++++++++++-
>  1 file changed, 89 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
> index c0065ba0ed18..c969ee7ea5ee 100644
> --- a/drivers/platform/x86/amd/hfi/hfi.c
> +++ b/drivers/platform/x86/amd/hfi/hfi.c
> @@ -244,6 +244,89 @@ static int amd_set_hfi_ipcc_score(struct amd_hfi_cpuinfo *hfi_cpuinfo, int cpu)
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
> +	if (!zalloc_cpumask_var(&hfi_info->cpus, GFP_KERNEL))
> +		return -ENOMEM;
> +
> +	mutex_lock(&hfi_cpuinfo_lock);

Use guard()

> +	cpumask_set_cpu(cpu, hfi_info->cpus);
> +
> +	/*
> +	 * Check if @cpu as an associated, initialized and ranking data must be filled
> +	 */
> +	hfi_classes = hfi_info->amd_hfi_classes;
> +	if (!hfi_classes)
> +		goto unlock;
> +
> +	/* Enable the workload classification interface */
> +	ret = amd_hfi_set_state(cpu, true);
> +	if (ret)
> +		pr_err("wct enable failed for cpu %d\n", cpu);

CPU

Should wct too be capitalized?

Is it okay to return 0 when this error occurs?

> +
> +	mutex_unlock(&hfi_cpuinfo_lock);
> +	return 0;
> +
> +unlock:
> +	free_cpumask_var(hfi_info->cpus);
> +	mutex_unlock(&hfi_cpuinfo_lock);
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
> +	mutex_lock(&hfi_cpuinfo_lock);

guard or scoped_guard.

> +
> +	/* Disable the workload classification interface */
> +	ret = amd_hfi_set_state(cpu, false);
> +	if (ret)
> +		pr_err("wct disable failed for cpu %d\n", cpu);
> +
> +	mutex_unlock(&hfi_cpuinfo_lock);
> +
> +	free_cpumask_var(hfi_info->cpus);
> +
> +	return 0;
> +}
> +
>  static int update_hfi_ipcc_scores(struct amd_hfi_data *amd_hfi_data)
>  {
>  	int cpu;
> @@ -362,8 +445,13 @@ static int amd_hfi_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto out;
>  
> +	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/amd_hfi:online",
> +				amd_hfi_online, amd_hfi_offline);
> +	if (ret < 0)
> +		goto out;

return ret;

> +
>  out:
> -	return ret;
> +	return ret < 0 ? ret : 0;
>  }
>  
>  static struct platform_driver amd_hfi_driver = {
> 

-- 
 i.


