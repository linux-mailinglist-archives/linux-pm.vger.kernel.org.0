Return-Path: <linux-pm+bounces-20198-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 792FDA08FB7
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 12:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 952063A2003
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 11:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469A320A5D0;
	Fri, 10 Jan 2025 11:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FdBOWeFK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647C01ACEDF;
	Fri, 10 Jan 2025 11:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736509834; cv=none; b=YUd4upDKo/KsHfE2XDfbpfC71ug2A49tILoNWr+w7YcpyAZBTJjlse27eewer8Y4dVPactRIWJToBB+E3tHLiWKSPsYTJqSJMK+2eCvesNSNUuE7bCfZq/ryQWBqkfLaBcnH8EoD/DWGAFfRjsHUyyt7xj34XOYHu1W+9Co3kuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736509834; c=relaxed/simple;
	bh=SR0y+MfZAmx4RcGses6gdMVT6e5ck5ppZOFp2XXH4ac=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VOoRQ5ASb7SVA6WO4OWJJg2NEiJ5af1JepJTMXoH4yxxCQ0GvghbYj61btKlA0vuSq0RS8f5LU3iEK9eWFuaBj34UaaEpELa9pW48VhdYRZ/tAx2tmKWyAHYit2xo1O6TtF5jgU9lrs17ArHla3LWVGCEbOP5yvvI2WiBpe0ocQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FdBOWeFK; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736509832; x=1768045832;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=SR0y+MfZAmx4RcGses6gdMVT6e5ck5ppZOFp2XXH4ac=;
  b=FdBOWeFK9+wIGr3gIkeFurc2FtkkJ8qYPHfUktZDVr5r4G0v7g5lZi9+
   HWAzcHRr9Xalu95IeZg9TPY8DKUoZISU5Y4Wo35ZeYEpUMTFIyfxFdyL3
   kk4ccTRkPgpmK+EZV6kiCIM0+aS0nWxCWtUbNqSqMWrt4Imz8BGt9iKpB
   LkOAYYioZjyyenoVjDxQMC0M2HNdh4c1cBUjgPsSUHee91dVkdyAwsfG3
   mMwE+piGFbrfTlMHcyyweP+tRSKAF9KR8BPqzdnKXpc90pK/gzQouPtmQ
   HqgNGCiaBPmXY65u3UAJB/+ZiUUxt4Gxcj8r5yrYI45L6XkkmJkdet9te
   Q==;
X-CSE-ConnectionGUID: dP/3sMoWQ1G/LTYfeXuGKw==
X-CSE-MsgGUID: LqUsl+ZKQO6dTcnHKXWzqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="54340886"
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="54340886"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 03:50:31 -0800
X-CSE-ConnectionGUID: YGqlHPX5QUOaPtRcj6P1KA==
X-CSE-MsgGUID: PCDjfgT7RFC6A9OOBhluhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108350976"
Received: from apaszkie-mobl2.apaszkie-mobl2 (HELO localhost) ([10.245.244.158])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 03:50:28 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 10 Jan 2025 13:50:24 +0200 (EET)
To: Xi Pardee <xi.pardee@linux.intel.com>
cc: rajvi0912@gmail.com, irenic.rajneesh@gmail.com, 
    david.e.box@linux.intel.com, Hans de Goede <hdegoede@redhat.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 4/6] platform/x86/intel/pmc: Create architecture
 specific callback
In-Reply-To: <20250110002612.244782-5-xi.pardee@linux.intel.com>
Message-ID: <63e0fb3a-e1ab-e756-fea7-1f317eaad009@linux.intel.com>
References: <20250110002612.244782-1-xi.pardee@linux.intel.com> <20250110002612.244782-5-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 9 Jan 2025, Xi Pardee wrote:

> Add architecture specific callback field in pmc_dev_info structure.
> Architecture specific action could be handled in this callback instead
> of per architecture init functions. Convert Arrow Lake, Lunar Lake,
> Meteor Lake and Tiger Lake platforms to use this field.
> 
> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
> ---
>  drivers/platform/x86/intel/pmc/arl.c  | 15 +++++++--------
>  drivers/platform/x86/intel/pmc/core.c |  3 +++
>  drivers/platform/x86/intel/pmc/core.h |  7 +++++++
>  drivers/platform/x86/intel/pmc/lnl.c  | 15 +++++++--------
>  drivers/platform/x86/intel/pmc/mtl.c  | 15 +++++++--------
>  drivers/platform/x86/intel/pmc/tgl.c  | 15 +++++----------
>  6 files changed, 36 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/intel/pmc/arl.c
> index dedf752237ca0..9ff90d32a635f 100644
> --- a/drivers/platform/x86/intel/pmc/arl.c
> +++ b/drivers/platform/x86/intel/pmc/arl.c
> @@ -698,16 +698,15 @@ static struct pmc_dev_info arl_pmc_dev = {
>  	.map = &arl_socs_reg_map,
>  	.suspend = cnl_suspend,
>  	.resume = arl_resume,
> +	.arch_specific = arl_specific_init,
>  };
>  
> -int arl_core_init(struct pmc_dev *pmcdev)
> +void arl_specific_init(struct pmc_dev *pmcdev)
>  {
> -	int ret;
> -
> -	ret = generic_core_init(pmcdev, &arl_pmc_dev);
> -	if (ret)
> -		return ret;
> -
>  	arl_d3_fixup();
> -	return 0;
> +}

As I tried to explain already earlier I think the older form is better 
here because it would allow arch specific things in any order:

void xx_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
{
	int ret;

	xx_pre_fixup();

	ret = generic_core_init(pmcdev, pmc_dev_info);
	if (ret)
		return ret;

	xx_post_fixup();

	return 0;
}

If you make it a callback, you have pick either pre or post but cannot do 
both with a single callback. My suggestion would also allow replacing 
generic_core_init() completely if needed in future.

Note how I pass the info parameter above to xx_init() so it can call into
generic_core_init(). In the core, you'd do this to pick which init 
function to use:

	if (pmc_dev_info->init)
		ret = pmc_dev_info->init(pmcdev, pmc_dev_info);
	else
		ret = generic_core_init(pmcdev, pmc_dev_info);

-- 
 i.

> +
> +int arl_core_init(struct pmc_dev *pmcdev)
> +{
> +	return generic_core_init(pmcdev, &arl_pmc_dev);
>  }
> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
> index 64b1c15e0c81d..45efe0e948831 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c
> @@ -1380,6 +1380,9 @@ int generic_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
>  	if (pmc_dev_info->dmu_guid)
>  		pmc_core_punit_pmt_init(pmcdev, pmc_dev_info->dmu_guid);
>  
> +	if (pmc_dev_info->arch_specific)
> +		pmc_dev_info->arch_specific(pmcdev);
> +
>  	if (ssram)
>  		return pmc_core_ssram_get_lpm_reqs(pmcdev);
>  
> diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
> index 80adae582ce5f..9430e4209ce97 100644
> --- a/drivers/platform/x86/intel/pmc/core.h
> +++ b/drivers/platform/x86/intel/pmc/core.h
> @@ -446,6 +446,7 @@ enum pmc_index {
>   *			specific attributes of the primary PMC
>   * @suspend:		Function to perform platform specific suspend
>   * @resume:		Function to perform platform specific resume
> + * @arch_specific:	Function to perform platform specific init action
>   */
>  struct pmc_dev_info {
>  	u8 func;
> @@ -454,6 +455,7 @@ struct pmc_dev_info {
>  	const struct pmc_reg_map *map;
>  	void (*suspend)(struct pmc_dev *pmcdev);
>  	int (*resume)(struct pmc_dev *pmcdev);
> +	void (*arch_specific)(struct pmc_dev *pmcdev);
>  };
>  
>  extern const struct pmc_bit_map msr_map[];
> @@ -623,6 +625,11 @@ int mtl_core_init(struct pmc_dev *pmcdev);
>  int arl_core_init(struct pmc_dev *pmcdev);
>  int lnl_core_init(struct pmc_dev *pmcdev);
>  
> +void arl_specific_init(struct pmc_dev *pmcdev);
> +void mtl_specific_init(struct pmc_dev *pmcdev);
> +void lnl_specific_init(struct pmc_dev *pmcdev);
> +void tgl_specific_init(struct pmc_dev *pmcdev);
> +
>  void cnl_suspend(struct pmc_dev *pmcdev);
>  int cnl_resume(struct pmc_dev *pmcdev);
>  
> diff --git a/drivers/platform/x86/intel/pmc/lnl.c b/drivers/platform/x86/intel/pmc/lnl.c
> index 2e6d4fddd2858..957d7a9062397 100644
> --- a/drivers/platform/x86/intel/pmc/lnl.c
> +++ b/drivers/platform/x86/intel/pmc/lnl.c
> @@ -554,16 +554,15 @@ static struct pmc_dev_info lnl_pmc_dev = {
>  	.map = &lnl_socm_reg_map,
>  	.suspend = cnl_suspend,
>  	.resume = lnl_resume,
> +	.arch_specific = lnl_specific_init,
>  };
>  
> -int lnl_core_init(struct pmc_dev *pmcdev)
> +void lnl_specific_init(struct pmc_dev *pmcdev)
>  {
> -	int ret;
> -
> -	ret = generic_core_init(pmcdev, &lnl_pmc_dev);
> -	if (ret)
> -		return ret;
> -
>  	lnl_d3_fixup();
> -	return 0;
> +}
> +
> +int lnl_core_init(struct pmc_dev *pmcdev)
> +{
> +	return generic_core_init(pmcdev, &lnl_pmc_dev);
>  }
> diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
> index 3bc0b64d19141..2a7d79dd37d6a 100644
> --- a/drivers/platform/x86/intel/pmc/mtl.c
> +++ b/drivers/platform/x86/intel/pmc/mtl.c
> @@ -997,16 +997,15 @@ static struct pmc_dev_info mtl_pmc_dev = {
>  	.map = &mtl_socm_reg_map,
>  	.suspend = cnl_suspend,
>  	.resume = mtl_resume,
> +	.arch_specific = mtl_specific_init,
>  };
>  
> -int mtl_core_init(struct pmc_dev *pmcdev)
> +void mtl_specific_init(struct pmc_dev *pmcdev)
>  {
> -	int ret;
> -
> -	ret = generic_core_init(pmcdev, &mtl_pmc_dev);
> -	if (ret)
> -		return ret;
> -
>  	mtl_d3_fixup();
> -	return 0;
> +}
> +
> +int mtl_core_init(struct pmc_dev *pmcdev)
> +{
> +	return generic_core_init(pmcdev, &mtl_pmc_dev);
>  }
> diff --git a/drivers/platform/x86/intel/pmc/tgl.c b/drivers/platform/x86/intel/pmc/tgl.c
> index bc3cb949c672e..29a9109afc782 100644
> --- a/drivers/platform/x86/intel/pmc/tgl.c
> +++ b/drivers/platform/x86/intel/pmc/tgl.c
> @@ -289,32 +289,27 @@ static struct pmc_dev_info tgl_l_pmc_dev = {
>  	.map = &tgl_reg_map,
>  	.suspend = cnl_suspend,
>  	.resume = cnl_resume,
> +	.arch_specific = tgl_specific_init,
>  };
>  
>  static struct pmc_dev_info tgl_pmc_dev = {
>  	.map = &tgl_h_reg_map,
>  	.suspend = cnl_suspend,
>  	.resume = cnl_resume,
> +	.arch_specific = tgl_specific_init,
>  };
>  
> -static int tgl_core_generic_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
> +void tgl_specific_init(struct pmc_dev *pmcdev)
>  {
> -	int ret;
> -
> -	ret = generic_core_init(pmcdev, pmc_dev_info);
> -	if (ret)
> -		return ret;
> -
>  	pmc_core_get_tgl_lpm_reqs(pmcdev->pdev);
> -	return 0;
>  }
>  
>  int tgl_l_core_init(struct pmc_dev *pmcdev)
>  {
> -	return tgl_core_generic_init(pmcdev, &tgl_l_pmc_dev);
> +	return generic_core_init(pmcdev, &tgl_l_pmc_dev);
>  }
>  
>  int tgl_core_init(struct pmc_dev *pmcdev)
>  {
> -	return tgl_core_generic_init(pmcdev, &tgl_pmc_dev);
> +	return generic_core_init(pmcdev, &tgl_pmc_dev);
>  }
> 

