Return-Path: <linux-pm+bounces-21680-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A762FA2EC0F
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 12:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABA5E188469F
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 11:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475171FC115;
	Mon, 10 Feb 2025 11:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FhW7dZuf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F611F63E8;
	Mon, 10 Feb 2025 11:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739188695; cv=none; b=OJsohykqp/m7TIJRmWGc4MnzNw6TqpDcsb92TA2JYDpQXBFG5jUAowrUAEp7FrmBSozDQ1T5bMVZ5ABBRcg8LS49Ru2WHEhT4dGABHPz34H0M/S2DRgEes07icvD6d/ggNnnSv/B1MAryVVd2Zzn6+wtBlE2dGFO+QDo9PSh5hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739188695; c=relaxed/simple;
	bh=Avi8Jp4lXtNhe6dygVfFalnwotyIhkW4f+KRhkFCo4g=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jp5wnhEA1OTLz4wEyEab3C+phxDJb9+DWUDFT9dCCUMAot7W5Vbi/mYsVVv9kYSkPk/fA4XAfn2G9szbvtRNXP+h8hh0uTSJc/MW9owxhdwXGVYpt70IcYQmklzeAPq4NvHI+4MPrZtTxOGkJpSjvrQpNzlAks2+6N0lW/JvBF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FhW7dZuf; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739188693; x=1770724693;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Avi8Jp4lXtNhe6dygVfFalnwotyIhkW4f+KRhkFCo4g=;
  b=FhW7dZufJQan6AsxqFTAwEO83bKujX+FhxBvPxXbFH5MF9Y3wTA6byIN
   3JZ5VElnvZlfBHYGinrqH+jIZ8Z4Kv/ReUU6/+3eqpqlTjRl5kBeldPCX
   RsMXV9zvdt4zrZ/f+Tljo68GRLMtvVv5X6e4IxCmO9qxSU/I55JvxP+Kl
   3goIudxy9SgEeTqr9gHWKxhB56HbKvC6v7m9sopMNSpSXN3tNfTypo+gi
   DSJM/VbbrZncMzNhLZv2FE2xzfdX8LKbLYSze08gCLdo+58uHp3kIPGcD
   vPhNeJzMl4QnE5lB+df8Lz0eqMgYSw7uv6FzYbh4YkgvpHewB78e0LU4m
   A==;
X-CSE-ConnectionGUID: PdRbncyOTZ2CTukDyM4L7g==
X-CSE-MsgGUID: r64XYF0sTyybZKJb14fAfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="51156162"
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="51156162"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 03:58:13 -0800
X-CSE-ConnectionGUID: tGsI6Nf+RcK38Fr/ELC9lA==
X-CSE-MsgGUID: eeot4O6BQRawInG5lVj1Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112010875"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.72])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 03:58:09 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 10 Feb 2025 13:58:06 +0200 (EET)
To: Xi Pardee <xi.pardee@linux.intel.com>
cc: rajvi0912@gmail.com, irenic.rajneesh@gmail.com, 
    david.e.box@linux.intel.com, Hans de Goede <hdegoede@redhat.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 5/6] platform/x86:intel/pmc: Move arch specific action
 to init function
In-Reply-To: <20250207225615.401235-6-xi.pardee@linux.intel.com>
Message-ID: <69b2b41b-5fcd-a7f2-576a-b00f2d390d8e@linux.intel.com>
References: <20250207225615.401235-1-xi.pardee@linux.intel.com> <20250207225615.401235-6-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 7 Feb 2025, Xi Pardee wrote:

> Move arch specific action from core.c to the init() function of spt.c.
> 
> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
> ---
>  drivers/platform/x86/intel/pmc/core.c | 13 -------------
>  drivers/platform/x86/intel/pmc/spt.c  | 21 +++++++++++++++++++++
>  2 files changed, 21 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
> index 628cb22221fbc..06821c41fbeb9 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c
> @@ -1416,11 +1416,6 @@ static const struct x86_cpu_id intel_pmc_core_ids[] = {
>  
>  MODULE_DEVICE_TABLE(x86cpu, intel_pmc_core_ids);
>  
> -static const struct pci_device_id pmc_pci_ids[] = {
> -	{ PCI_VDEVICE(INTEL, SPT_PMC_PCI_DEVICE_ID) },
> -	{ }
> -};
> -
>  /*
>   * This quirk can be used on those platforms where
>   * the platform BIOS enforces 24Mhz crystal to shutdown
> @@ -1531,14 +1526,6 @@ static int pmc_core_probe(struct platform_device *pdev)
>  	if (!pmcdev->pkgc_res_cnt)
>  		return -ENOMEM;
>  
> -	/*
> -	 * Coffee Lake has CPU ID of Kaby Lake and Cannon Lake PCH. So here
> -	 * Sunrisepoint PCH regmap can't be used. Use Cannon Lake PCH regmap
> -	 * in this case.
> -	 */
> -	if (pmc_dev_info == &spt_pmc_dev && !pci_dev_present(pmc_pci_ids))
> -		pmc_dev_info = &cnp_pmc_dev;
> -
>  	mutex_init(&pmcdev->lock);
>  
>  	if (pmc_dev_info->init)
> diff --git a/drivers/platform/x86/intel/pmc/spt.c b/drivers/platform/x86/intel/pmc/spt.c
> index 956b2ec1c7510..9289cd76b0145 100644
> --- a/drivers/platform/x86/intel/pmc/spt.c
> +++ b/drivers/platform/x86/intel/pmc/spt.c
> @@ -8,6 +8,8 @@
>   *
>   */
>  
> +#include <linux/pci.h>
> +
>  #include "core.h"
>  
>  const struct pmc_bit_map spt_pll_map[] = {
> @@ -134,6 +136,25 @@ const struct pmc_reg_map spt_reg_map = {
>  	.pm_vric1_offset = SPT_PMC_VRIC1_OFFSET,
>  };
>  
> +static const struct pci_device_id pmc_pci_ids[] = {
> +	{ PCI_VDEVICE(INTEL, SPT_PMC_PCI_DEVICE_ID) },
> +	{ }
> +};
> +
> +static int spt_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
> +{
> +	/*
> +	 * Coffee Lake has CPU ID of Kaby Lake and Cannon Lake PCH. So here
> +	 * Sunrisepoint PCH regmap can't be used. Use Cannon Lake PCH regmap
> +	 * in this case.
> +	 */
> +	if (!pci_dev_present(pmc_pci_ids))
> +		return generic_core_init(pmcdev, &cnp_pmc_dev);
> +
> +	return generic_core_init(pmcdev, pmc_dev_info);
> +}
> +
>  struct pmc_dev_info spt_pmc_dev = {
>  	.map = &spt_reg_map,
> +	.init = spt_core_init,
>  };
> 

Hi,

I've applied all but this patch into the review-ilpo-next branch.

This change is good otherwise but I'd prefer the pmc_pci_ids be named 
better such that it actually relates to why it exists :-). So please 
respin this patch.

-- 
 i.


