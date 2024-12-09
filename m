Return-Path: <linux-pm+bounces-18829-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 824B59E9A43
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 16:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35FA218874EB
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 15:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A721F0E5F;
	Mon,  9 Dec 2024 15:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KTGbg1eZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9781F0E20;
	Mon,  9 Dec 2024 15:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733757505; cv=none; b=CyRRJ5v20ohX0FgeCGARCVM4ao6x6D6vQVzYgBAH2jX9TbqnHq0Mxa37OwB2gA9YL7ik2j8v6hv7WVMRexq5D1IuVoIzIdgg7orZQmlnIWMQK1a/2x+ga8xOos2HjY99AJHW7DQ8OWVaDGNY5DWwfNIdQGg4y+uRFTMjHodXFAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733757505; c=relaxed/simple;
	bh=gI2qNtFYnW75fraXNbboTDNcdxl/zpGRAljaNN0+FWU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WzYA0UUaad1o72G/F06gt3p5RI7u7W00KMM1jLUF/96w7OWCHZjo+ye3YOeBO+3v86VQE7P2MZ80HB3IeVVcmGKBIx81l4zRfnb6lf2CHHeM8+wjg4qsEbJuX9cpuWIEPaPHwc/2g4f2tCGyPNCBPB0IzCH47bDct6eQ1Nsetbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KTGbg1eZ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733757504; x=1765293504;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=gI2qNtFYnW75fraXNbboTDNcdxl/zpGRAljaNN0+FWU=;
  b=KTGbg1eZADrK+9/Djhfm+3xn8MoQyqUelkQAb1B2R/l2riChkm39wZUM
   xaBY8NAlziVKjJPxUIP6SmxJTaXs+bOUtsxkgpz0E3wSbruOP3ZOSc70I
   a8UJ8F6oGSNtDQpw5db0QbGnGAPsmIRvk8YwI7IdrkqfE5zouXxkoN3Qc
   S3xLfPl4wYA+ImhI2Ftz+uyf7ehvtx5SDMFTIJk6PGZsABEkzl18mt8wc
   DgyWauyMrIAy1STwghNuNluDdAEE8Rii6ZoWb3f1AnkkygkQ5uMkOeaP6
   5JS8shyC62TxN4QqHONRaZNIJ0Nqv0xUmOuYnOsH0myJ3vSXHyqNH6dAm
   w==;
X-CSE-ConnectionGUID: R1ClQcwNQyCCJ5iZvFOf2A==
X-CSE-MsgGUID: rOeoDVFUToa8XHgVJBTfEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="34118531"
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="34118531"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 07:18:23 -0800
X-CSE-ConnectionGUID: bAb3zxMgQmGHQXCR9Acs7Q==
X-CSE-MsgGUID: cT/dnomUSLaLKf0ylOtq0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="95458641"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.121])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 07:18:21 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 9 Dec 2024 17:18:17 +0200 (EET)
To: Xi Pardee <xi.pardee@linux.intel.com>
cc: rajvi0912@gmail.com, irenic.rajneesh@gmail.com, 
    david.e.box@linux.intel.com, Hans de Goede <hdegoede@redhat.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/3] platform/x86:intel/pmc: Create info structure for
 pmc device
In-Reply-To: <20241207053607.14806-3-xi.pardee@linux.intel.com>
Message-ID: <a8c0ba82-9ea0-d761-f6c3-193de5fe2bbd@linux.intel.com>
References: <20241207053607.14806-1-xi.pardee@linux.intel.com> <20241207053607.14806-3-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 6 Dec 2024, Xi Pardee wrote:

> Create an info structure to store platform specific information.
> For Tiger Lake and Arrow Lake platforms, multiple platform variations
> could share one generic init function. Using info structure could
> avoid if () forest. Modify tgl.c to use the info structure.
> 
> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
> ---
>  drivers/platform/x86/intel/pmc/core.h | 15 ++++++++++++
>  drivers/platform/x86/intel/pmc/tgl.c  | 33 +++++++++++++++------------
>  2 files changed, 33 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
> index a1886d8e1ef3e..3124315d2b925 100644
> --- a/drivers/platform/x86/intel/pmc/core.h
> +++ b/drivers/platform/x86/intel/pmc/core.h
> @@ -428,6 +428,21 @@ struct pmc_dev {
>  	struct pmc_info *regmap_list;
>  };
>  
> +/**
> + * struct pmc_dev_info - Structure to keep pmc device info
> + * @func:		function number of the primary pmc
> + * @map:		pointer to a pmc_reg_map struct that contains platform
> + *			specific attributes of the primary pmc
> + * @suspend:		Function to perform platform specific suspend
> + * @resume:		Function to perform platform specific resume
> + */
> +struct pmc_dev_info {
> +	u8 func;
> +	const struct pmc_reg_map *map;
> +	void (*suspend)(struct pmc_dev *pmcdev);
> +	int (*resume)(struct pmc_dev *pmcdev);
> +};
> +
>  enum pmc_index {
>  	PMC_IDX_MAIN,
>  	PMC_IDX_SOC = PMC_IDX_MAIN,
> diff --git a/drivers/platform/x86/intel/pmc/tgl.c b/drivers/platform/x86/intel/pmc/tgl.c
> index 4fec43d212d01..c6fc3a0225a55 100644
> --- a/drivers/platform/x86/intel/pmc/tgl.c
> +++ b/drivers/platform/x86/intel/pmc/tgl.c
> @@ -13,11 +13,6 @@
>  #define ACPI_S0IX_DSM_UUID		"57a6512e-3979-4e9d-9708-ff13b2508972"
>  #define ACPI_GET_LOW_MODE_REGISTERS	1
>  
> -enum pch_type {
> -	PCH_H,
> -	PCH_LP
> -};
> -
>  const struct pmc_bit_map tgl_pfear_map[] = {
>  	{"PSF9",		BIT(0)},
>  	{"RES_66",		BIT(1)},
> @@ -285,18 +280,26 @@ void pmc_core_get_tgl_lpm_reqs(struct platform_device *pdev)
>  	ACPI_FREE(out_obj);
>  }
>  
> -static int tgl_core_generic_init(struct pmc_dev *pmcdev, int pch_tp)
> +static struct pmc_dev_info tgl_l_pmc_dev = {
> +	.map = &tgl_reg_map,
> +	.suspend = cnl_suspend,
> +	.resume = cnl_resume,
> +};
> +
> +static struct pmc_dev_info tgl_pmc_dev = {
> +	.map = &tgl_h_reg_map,
> +	.suspend = cnl_suspend,
> +	.resume = cnl_resume,
> +};
> +
> +static int tgl_core_generic_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
>  {
>  	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
>  	int ret;
>  
> -	if (pch_tp == PCH_H)
> -		pmc->map = &tgl_h_reg_map;
> -	else
> -		pmc->map = &tgl_reg_map;
> -
> -	pmcdev->suspend = cnl_suspend;
> -	pmcdev->resume = cnl_resume;
> +	pmc->map = pmc_dev_info->map;
> +	pmcdev->suspend = pmc_dev_info->suspend;
> +	pmcdev->resume = pmc_dev_info->resume;
>  
>  	ret = get_primary_reg_base(pmc);
>  	if (ret)
> @@ -310,10 +313,10 @@ static int tgl_core_generic_init(struct pmc_dev *pmcdev, int pch_tp)
>  
>  int tgl_l_core_init(struct pmc_dev *pmcdev)
>  {
> -	return tgl_core_generic_init(pmcdev, PCH_LP);
> +	return tgl_core_generic_init(pmcdev, &tgl_l_pmc_dev);
>  }
>  
>  int tgl_core_init(struct pmc_dev *pmcdev)
>  {
> -	return tgl_core_generic_init(pmcdev, PCH_H);
> +	return tgl_core_generic_init(pmcdev, &tgl_pmc_dev);
>  }
> 

While adding the struct seems right direction, I don't feel good about the 
scoping in this patch. It seems that we'll still end up duplicating lots
of init code.

If I do (in drivers/platform/x86/intel/pmc):

git grep -A7 -B7 -e 'suspend =' -e 'resume =' -e '->map ='

...I see basically:

- assign those variables (minor variations: PMC_IDX_MAIN/PMC_IDX_SOC 
  index, NULL resume/suspend that is already handled)
- if regmap_list is set, call to pmc_core_ssram_init() (the pointer put 
  into ->regmap_list seems another candidate to be included into the info 
  struct.)
- else (or if ssram init failed), call get_primary_reg_base()
- call pmc_core_get_low_power_modes()

Why cannot we like have a common init function which handles all those and 
remove all that duplication from per arch files? I don't see anything that 
looked meaningful variations so the current archs should be all 
generalizable I think. Why leave all those into per arch init as done in 
this series?

-- 
 i.


