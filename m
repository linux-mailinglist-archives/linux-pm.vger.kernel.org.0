Return-Path: <linux-pm+bounces-18809-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 269309E909A
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 11:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 053DA18870C4
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 10:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B1A21767D;
	Mon,  9 Dec 2024 10:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="moObM4C8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E40D215071;
	Mon,  9 Dec 2024 10:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733740747; cv=none; b=K9wMy7UnMgqDKpbsDEm7jOdR6q93NU+vgqmwvWKJ2zYmkiYZyHe6LHfG5zIMNVNIkHEeDs5Da5mYkh3wWQ0uNOYFFnNFIUu0L0Z3lIn4hBZlCBZRMf/V9wIlTJDD4Bv6Wu0nFatloaaV6tjNLvGkDyKGChE8LSD/CyIT6VxLx5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733740747; c=relaxed/simple;
	bh=/JJ5xuhZMmN+7I/M37TWgPtKyGD3AwfUs61Os4hBQYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HQqdT4Nhht2xabT6HncY9Kw3Y/hvNeXM+KC8EeZvlq4tP6b2fvGgxl1TpwLhD9OkcEwpqhQ/1ZdJH+uKGIZ1W2oVBOz1jFsoagm2hggb4hTEME3gCa6FaZxqcl3x7vMLk9oMhVoSueXXhcf7OKmtnh83Ja2IvRwlTr4XF4SL46c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=moObM4C8; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733740746; x=1765276746;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=/JJ5xuhZMmN+7I/M37TWgPtKyGD3AwfUs61Os4hBQYc=;
  b=moObM4C88tNU2+NrV8hm8IFUf8t0dWHLFKwx1sdmRrp2Ddd3pf4mJLo1
   Ph7ZfbmBBa8yoQhHKNa2DcWi2r/6vLGirpMtL2RWHg7Uf6/yatayXF5Lp
   re5sooFTPIlnEqF95oV8M7czwjEc/no0o53eQFpkcutEbYeaJSJ6/WHjq
   iuPmiK0NQFPHanlduioSlzhEACLhDeDCfMgx+aiC9S7wUW5ndb2rbzNRl
   qkjGZyPVyZSQ8WdHfkiGr1MgGqBae23I3YiRvVAOq+zZoCOt9mICzgGgf
   +oWDRWOxPrOpCK63BhQvzT4kCU2IY0MJGgrf6CiEvosaN7X275kBJTBRW
   g==;
X-CSE-ConnectionGUID: rmWm8sWPTRethexDBLhMxw==
X-CSE-MsgGUID: yhwAKaw5RNq7DdG30nHGww==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="34175700"
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="34175700"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 02:39:05 -0800
X-CSE-ConnectionGUID: R4y3m4cXR82ZRbOk8/nYFQ==
X-CSE-MsgGUID: +UKR2m5vSoSZWh4hm6wkYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="99851197"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.89.141])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 02:39:02 -0800
Message-ID: <7b5fcb3e-e3e7-4d87-9a7b-5570e2e85a0e@intel.com>
Date: Mon, 9 Dec 2024 12:38:59 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] mmc: sdhci: Use EXPORT_PM_FN_NS_GPL() for
 exporting PM functions
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Victor Shih <victor.shih@genesyslogic.com.tw>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <20241101101441.3518612-1-andriy.shevchenko@linux.intel.com>
 <20241101101441.3518612-2-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20241101101441.3518612-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/11/24 12:11, Andy Shevchenko wrote:
> Switch from ugly ifdeffery to using EXPORT_PM_FN_NS_GPL()
> for exporting PM functions. This helps cleaning up the other
> SDHCI drivers in the future.

It seems sdhci is the first code in the kernel to use
EXPORT_PM_FN_NS_GPL() but it was not asked for ;-)

As such, can you fill in a little background.  I am not
sure what it achieves.  Why have CONFIG_PM if not to
#ifdef dependent code behind it?

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mmc/host/sdhci.c | 14 ++++----------
>  drivers/mmc/host/sdhci.h |  2 --
>  2 files changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index f4a7733a8ad2..2214280ca5fb 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3733,8 +3733,6 @@ EXPORT_SYMBOL_GPL(sdhci_thread_irq);
>   *                                                                           *
>  \*****************************************************************************/
>  
> -#ifdef CONFIG_PM
> -
>  static bool sdhci_cd_irq_can_wakeup(struct sdhci_host *host)
>  {
>  	return mmc_card_is_removable(host->mmc) &&
> @@ -3814,8 +3812,7 @@ int sdhci_suspend_host(struct sdhci_host *host)
>  
>  	return 0;
>  }
> -
> -EXPORT_SYMBOL_GPL(sdhci_suspend_host);
> +EXPORT_PM_FN_GPL(sdhci_suspend_host);
>  
>  int sdhci_resume_host(struct sdhci_host *host)
>  {
> @@ -3853,8 +3850,7 @@ int sdhci_resume_host(struct sdhci_host *host)
>  
>  	return ret;
>  }
> -
> -EXPORT_SYMBOL_GPL(sdhci_resume_host);
> +EXPORT_PM_FN_GPL(sdhci_resume_host);
>  
>  int sdhci_runtime_suspend_host(struct sdhci_host *host)
>  {
> @@ -3876,7 +3872,7 @@ int sdhci_runtime_suspend_host(struct sdhci_host *host)
>  
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(sdhci_runtime_suspend_host);
> +EXPORT_PM_FN_GPL(sdhci_runtime_suspend_host);
>  
>  int sdhci_runtime_resume_host(struct sdhci_host *host, int soft_reset)
>  {
> @@ -3927,9 +3923,7 @@ int sdhci_runtime_resume_host(struct sdhci_host *host, int soft_reset)
>  
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(sdhci_runtime_resume_host);
> -
> -#endif /* CONFIG_PM */
> +EXPORT_PM_FN_GPL(sdhci_runtime_resume_host);
>  
>  /*****************************************************************************\
>   *                                                                           *
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index cd0e35a80542..4ee2695b0202 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -874,12 +874,10 @@ irqreturn_t sdhci_thread_irq(int irq, void *dev_id);
>  void sdhci_adma_write_desc(struct sdhci_host *host, void **desc,
>  			   dma_addr_t addr, int len, unsigned int cmd);
>  
> -#ifdef CONFIG_PM
>  int sdhci_suspend_host(struct sdhci_host *host);
>  int sdhci_resume_host(struct sdhci_host *host);
>  int sdhci_runtime_suspend_host(struct sdhci_host *host);
>  int sdhci_runtime_resume_host(struct sdhci_host *host, int soft_reset);
> -#endif
>  
>  void sdhci_cqe_enable(struct mmc_host *mmc);
>  void sdhci_cqe_disable(struct mmc_host *mmc, bool recovery);


