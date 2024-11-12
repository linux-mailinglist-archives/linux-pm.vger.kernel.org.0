Return-Path: <linux-pm+bounces-17405-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 868CF9C577D
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 13:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B76828518D
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 12:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744D71C303A;
	Tue, 12 Nov 2024 12:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sc4MF+Wk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DB984D2B;
	Tue, 12 Nov 2024 12:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731413822; cv=none; b=Kk6HJkt+j4bBzeOISx0DMLPUC4V5Um3pu5zBufgHRpPY5LVMEYFXDMbZkkTEFTbuezqXPO4hHNiNFiNbCiCugkqlUfvWHyZzHHy4jObkNnofT5K3ivRq/NbNolSO99Sga+Wjmf5MU3yXuhQaZY6KcT4oYfxTbYyCFn/AToOsTWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731413822; c=relaxed/simple;
	bh=s3xLRKr3f419fYPU6PB/kHAOhOABMEaamyvZW4/7k6M=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Jz1VyqB8NppF3m76Uro+VFqLhRBNT/U/KiD34CY2cExgL6N4icqpdz+MvwxygO511EKDk43mcqQL2LRxG7vrQ2tfdOnf5RDwiPgrY06XDgfaUfCNuzotTU51Fbflq9l3cUmze7sq/qctrjjP51OQTF57GZuStpa1eEocW8f5Kl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sc4MF+Wk; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731413821; x=1762949821;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=s3xLRKr3f419fYPU6PB/kHAOhOABMEaamyvZW4/7k6M=;
  b=Sc4MF+WkpY0SenT22CUfw786G3+GP0iJQY98evfijMB9NKqJa0Jh5luS
   Gm8KJfa6Qf7aCj4SquNXKyzT9beYuN15FkQh4C49CEzranePncskwoJJy
   vVSfye8hAMhovnGx3OLtPmrZRyoO8O2EXuByDJuO4jVA8vtzmTDhJhXvV
   U4TVg46h5Oxk6tWO3l/6lU+ViJlCVaVrzQAPx/80HzRm9hT5e+4It7iMr
   tV8GUOy8Wkc4pXMnbwHXd9+D6lR9qjZFQywdBnOyDaj3YQyUnGexDkhDe
   NdYON1VvibaaLJ3EReeDTkLKVg797TloS9B+4hwiP5JnQ4qV1kn89Lx4Y
   g==;
X-CSE-ConnectionGUID: D+u5sGEnQeOgguk8emCxJQ==
X-CSE-MsgGUID: 5N09NnycT72CoKrDuDa+EA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="48699694"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="48699694"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 04:17:01 -0800
X-CSE-ConnectionGUID: tS7BO2LFRleFpECaFnqibg==
X-CSE-MsgGUID: OlATpCQtTNOM99rxgsUCzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="87549164"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.234])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 04:16:55 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 12 Nov 2024 14:16:52 +0200 (EET)
To: Mario Limonciello <mario.limonciello@amd.com>
cc: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>, 
    x86@kernel.org, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, 
    Perry Yuan <perry.yuan@amd.com>, LKML <linux-kernel@vger.kernel.org>, 
    linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, 
    platform-driver-x86@vger.kernel.org, 
    Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
    Perry Yuan <Perry.Yuan@amd.com>
Subject: Re: [PATCH v6 06/12] platform/x86: hfi: init per-cpu scores for each
 class
In-Reply-To: <20241104175407.19546-7-mario.limonciello@amd.com>
Message-ID: <7fa961b4-894d-8805-8a23-2ed8ef04fe7f@linux.intel.com>
References: <20241104175407.19546-1-mario.limonciello@amd.com> <20241104175407.19546-7-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 4 Nov 2024, Mario Limonciello wrote:

> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> Initialize per cpu score `amd_hfi_ipcc_scores` which store energy score
> and performance score data for each class.
> 
> `Classic core` and `Dense core` are ranked according to those values as
> energy efficiency capability or performance capability.
> OS scheduler will pick cores from the ranking list on each class ID for
> the thread which provide the class id got from hardware feedback
> interface.
> 
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/platform/x86/amd/hfi/hfi.c | 31 ++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
> index 708d7d18fe2f2..9bdd9d9a615b8 100644
> --- a/drivers/platform/x86/amd/hfi/hfi.c
> +++ b/drivers/platform/x86/amd/hfi/hfi.c
> @@ -113,6 +113,8 @@ struct amd_hfi_cpuinfo {
>  
>  static DEFINE_PER_CPU(struct amd_hfi_cpuinfo, amd_hfi_cpuinfo) = {.class_index = -1};
>  
> +static DEFINE_MUTEX(hfi_cpuinfo_lock);

No users in this patch?

-- 
 i.


> +
>  static int find_cpu_index_by_apicid(unsigned int target_apicid)
>  {
>  	int cpu_index;
> @@ -226,6 +228,31 @@ static int amd_hfi_alloc_class_data(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static int amd_set_hfi_ipcc_score(struct amd_hfi_cpuinfo *hfi_cpuinfo, int cpu)
> +{
> +	for (int i = 0; i < hfi_cpuinfo->nr_class; i++)
> +		WRITE_ONCE(hfi_cpuinfo->ipcc_scores[i],
> +			   hfi_cpuinfo->amd_hfi_classes[i].perf);
> +
> +	return 0;
> +}
> +
> +static int update_hfi_ipcc_scores(void)
> +{
> +	int cpu;
> +	int ret;
> +
> +	for_each_present_cpu(cpu) {
> +		struct amd_hfi_cpuinfo *hfi_cpuinfo = per_cpu_ptr(&amd_hfi_cpuinfo, cpu);
> +
> +		ret = amd_set_hfi_ipcc_score(hfi_cpuinfo, cpu);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  static int amd_hfi_metadata_parser(struct platform_device *pdev,
>  				   struct amd_hfi_data *amd_hfi_data)
>  {
> @@ -311,6 +338,10 @@ static int amd_hfi_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	ret = update_hfi_ipcc_scores();
> +	if (ret)
> +		return ret;
> +
>  	return 0;
>  }
>  
> 

