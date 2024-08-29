Return-Path: <linux-pm+bounces-13159-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4147964408
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 14:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D4F21F23EC6
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 12:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A3419309C;
	Thu, 29 Aug 2024 12:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mTMDJ8p6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05DC14B96F;
	Thu, 29 Aug 2024 12:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724933626; cv=none; b=JAPKjS7A9H0BMy1zuBlgxo8SqJ+/3jVq+HfOFlL2SGG71NcC2WKeV40iZONZch7wgGrSNGRSi4lPSwqVw9F0V20QA0r60tYIvGUS7z8j+mNo+d7Q0Jc2KMOj26A0YdI/9XlsM98vH7YSmZA5BJ/KnWgLlKjkCgcb66FJ3QANoKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724933626; c=relaxed/simple;
	bh=2KyLLxd8wexFXb7qhd4G8G2cF1mUUrYj5uMZiu0R7mI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BrRNEIGgM3immmIE3xQF4bBG3FCnhmNffggG4cwG43pjWXoKtBs2F+nVmT/Ji/sgl4yoBG69YgGFrmcLISZGletF+tKP2OZxPubTLbS2Zftd+qt5f9CTFNf8LPgy/XMZnxXV/W1QwJCphhsjEvDMjnKVQSF/QJWt+sGujvhH4wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mTMDJ8p6; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724933625; x=1756469625;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=2KyLLxd8wexFXb7qhd4G8G2cF1mUUrYj5uMZiu0R7mI=;
  b=mTMDJ8p64kVBxiYlXGvpyj12QvWD9EP7hx/4q+9sIhJEu5AgQe1NdHio
   D4XpMjFTC1tpqRvX7lj0H0R2pGZKsC2BFoehhXXKfE+P9gXCLXcQ8CdNY
   EbEX4XacfK+YUTjCCqoswuQQen4mGjLZlz7hXCSJcnLdCjb2Thi1qkSDj
   8LgbgRyzD1sYYr3Wegt6/tgIJOLJ1pqRnEIG0Gx9XuwTu37S/QC+ciPoQ
   TxE8ClNaDY3Y4vftLYwV15UIktCbIzrUnU6jrSAtHJbQo0gdUQVafaJnJ
   4U8sjCN1n6UeHYbZYJvmwh6or/hXM7riwXgl9ysNOYLFXXVAeNt/7E4K0
   A==;
X-CSE-ConnectionGUID: YgDXsz07SEGonYhSEQMlyw==
X-CSE-MsgGUID: MNPKddd4RF6sAGq4QNB1bA==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="34132738"
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="34132738"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 05:13:44 -0700
X-CSE-ConnectionGUID: z6ju57FHQ4uNEGtpk+FkzA==
X-CSE-MsgGUID: Q3APdeuhQWibsCqpAUtUIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="63244180"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.59])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 05:13:41 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 29 Aug 2024 15:13:37 +0300 (EEST)
To: Xi Pardee <xi.pardee@linux.intel.com>
cc: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com, 
    Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 11/11] platform/x86:intel/pmc: Get LPM information
 for Lunar Lake
In-Reply-To: <20240828222932.1279508-12-xi.pardee@linux.intel.com>
Message-ID: <d270b60b-f136-a520-1703-efa4cbfb0aba@linux.intel.com>
References: <20240828222932.1279508-1-xi.pardee@linux.intel.com> <20240828222932.1279508-12-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 28 Aug 2024, Xi Pardee wrote:

> Add support to find and read the requirements from the telemetry
> entries for Lunar Lake platforms.
> 
> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
> ---
>  drivers/platform/x86/intel/pmc/lnl.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel/pmc/lnl.c b/drivers/platform/x86/intel/pmc/lnl.c
> index 109b08d43fc8..f5fee9e105e2 100644
> --- a/drivers/platform/x86/intel/pmc/lnl.c
> +++ b/drivers/platform/x86/intel/pmc/lnl.c
> @@ -13,8 +13,13 @@
>  
>  #include "core.h"
>  
> +#define SOCM_LPM_REQ_GUID	0x15099748
> +
> +static const u8 LNL_LPM_REG_INDEX[] = {0, 4, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 20};
> +
>  static struct pmc_info lnl_pmc_info_list[] = {
>  	{
> +		.guid	= SOCM_LPM_REQ_GUID,
>  		.devid	= PMC_DEVID_LNL_SOCM,
>  		.map	= &lnl_socm_reg_map,
>  	},
> @@ -536,6 +541,7 @@ const struct pmc_reg_map lnl_socm_reg_map = {
>  	.lpm_live_status_offset = MTL_LPM_LIVE_STATUS_OFFSET,
>  	.s0ix_blocker_maps = lnl_blk_maps,
>  	.s0ix_blocker_offset = LNL_S0IX_BLOCKER_OFFSET,
> +	.lpm_reg_index = LNL_LPM_REG_INDEX,
>  };
>  
>  #define LNL_NPU_PCI_DEV		0x643e
> @@ -561,6 +567,8 @@ static int lnl_resume(struct pmc_dev *pmcdev)
>  
>  int lnl_core_init(struct pmc_dev *pmcdev)
>  {
> +	bool ssram_init = true;
> +	int func = 2;
>  	int ret;
>  	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_SOC];
>  
> @@ -578,6 +586,7 @@ int lnl_core_init(struct pmc_dev *pmcdev)
>  
>  	/* If regbase not assigned, set map and discover using legacy method */
>  	if (ret) {
> +		ssram_init = false;
>  		pmc->map = &lnl_socm_reg_map;
>  		ret = get_primary_reg_base(pmc);
>  		if (ret)
> @@ -586,5 +595,11 @@ int lnl_core_init(struct pmc_dev *pmcdev)
>  
>  	pmc_core_get_low_power_modes(pmcdev);
>  
> +	if (ssram_init)	{
> +		ret = pmc_core_ssram_get_lpm_reqs(pmcdev, func);
> +		if (ret)
> +			return ret;

There's quite much duplication related to this legacy/ssram init in
the per arch core init functions. And some inconsistencies too which
seem incidental such as mtl.c using return directly here.

-- 
 i.


