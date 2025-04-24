Return-Path: <linux-pm+bounces-26126-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB2AA9B00F
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 16:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3351D468493
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 14:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3E91A0B08;
	Thu, 24 Apr 2025 14:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ByijDquL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7422D18CBE1;
	Thu, 24 Apr 2025 14:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745503371; cv=none; b=S+lEQJAGlB35tNXvLWlNwoEcdaQQJMLMJvj/aSL+eBVELBtUpxFwin68EO88/8WaEP+nIJ4r4xIB65gwCk0PFIq6WG2iZ0vQ6nRZJNyhC4qJ9y9CdnH2KarlzKePZiSSOLz75X5Ip3Q/BOylmNrsHCcp4wPYCexYIm6kPvsGm10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745503371; c=relaxed/simple;
	bh=CzBSxiQ0r9//6su1LCZFDqfXoC1J0y6r/T1XHaz8+K8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YkfT67AcdZ13K1SAdu4QFaL7m0IJM9v1KVJ4i0F2PxI2DrYH5Oq+urr0ZtTsmI6qjeBZueM9PjHJeXKdONluKZ1XZyf2aq0hvTtc/HPwk7JD9DbQt3AK2kk42ibAfRljnf10X0cmKZYsAsVacCdNp+9konCmnuIgmJjctrMGik4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ByijDquL; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745503370; x=1777039370;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=CzBSxiQ0r9//6su1LCZFDqfXoC1J0y6r/T1XHaz8+K8=;
  b=ByijDquL4j5XJB3kc7xOaw99juatle7/56EoBPhGxat0ahH6psE1rTMy
   y9cocMcDhqIB/+Ys7R6PkF/8TCJf8BezxEt4o0akvmaHckNgHQnFl5j4m
   +TWhm/MxIDrn/uhI9A70lGGUGH+ACqggl3PrFqkh00CRah8IDtehmBfom
   QzkQE8OikLsHfNjcZyUdEmjTQGO5Orj/hLxyPG5nQTJUAZgNSYtZcxlAI
   u5w5nkyLqHmdyga8LVpD8DAI7T9N8aeeC4hecsI0iSbxuMK5Mz71XLeX8
   u7xCWb8a8ltWRxJanstqH54NMdGe7yl4viOGZ4Lu746GzRcP4+VHD0Hai
   Q==;
X-CSE-ConnectionGUID: ICV5ceIlQ7+g98yAB9j/AQ==
X-CSE-MsgGUID: 567OBCkIRHmuvEkpHAjmFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="46259200"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="46259200"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 07:02:49 -0700
X-CSE-ConnectionGUID: 0scftaRKQmWrSJFAVVptYg==
X-CSE-MsgGUID: yKdVHd+tQOmNW7k2Kru+wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="132535191"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.213])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 07:02:46 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 24 Apr 2025 17:02:42 +0300 (EEST)
To: Xi Pardee <xi.pardee@linux.intel.com>
cc: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com, 
    Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 3/4] platform/x86:intel/pmc: Move error handling to
 init function
In-Reply-To: <20250421211100.687250-4-xi.pardee@linux.intel.com>
Message-ID: <c468af86-4bb8-4a8b-b601-07e29d4907e3@linux.intel.com>
References: <20250421211100.687250-1-xi.pardee@linux.intel.com> <20250421211100.687250-4-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 21 Apr 2025, Xi Pardee wrote:

> Move error handling code to generic_core_init() function. The previous
> implementation is that init function called for "full cleanup" function
> when error occurs which is error prone. The init function should handle
> the error path itself to improve code maintainability.
> 
> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
> ---
>  drivers/platform/x86/intel/pmc/core.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
> index 042b60c1185f..e09a97564398 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c
> @@ -1583,10 +1583,26 @@ int generic_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
>  	if (pmc_dev_info->dmu_guid)
>  		pmc_core_punit_pmt_init(pmcdev, pmc_dev_info->dmu_guid);
>  
> -	if (ssram)
> -		return pmc_core_ssram_get_lpm_reqs(pmcdev, pmc_dev_info->pci_func);
> +	if (ssram) {
> +		ret = pmc_core_ssram_get_lpm_reqs(pmcdev, pmc_dev_info->pci_func);
> +		if (ret)
> +			goto unmap_regbase;
> +	}
>  
>  	return 0;
> +
> +unmap_regbase:
> +	for (unsigned int i = 0; i < ARRAY_SIZE(pmcdev->pmcs); ++i) {
> +		struct pmc *pmc = pmcdev->pmcs[i];
> +
> +		if (pmc && pmc->regbase)
> +			iounmap(pmc->regbase);
> +	}
> +
> +	if (pmcdev->punit_ep)
> +		pmt_telem_unregister_endpoint(pmcdev->punit_ep);
> +
> +	return ret;
>  }
>  
>  static const struct x86_cpu_id intel_pmc_core_ids[] = {
> @@ -1734,7 +1750,8 @@ static int pmc_core_probe(struct platform_device *pdev)
>  		ret = generic_core_init(pmcdev, pmc_dev_info);
>  
>  	if (ret) {
> -		pmc_core_clean_structure(pdev);
> +		platform_set_drvdata(pdev, NULL);
> +		mutex_destroy(&pmcdev->lock);

Please change also the mutex init to use devm_mutex_init(), don't forget 
to include error handling for it as it devm_mutex_init() can fail.

>  		return ret;
>  	}
>  
> 

-- 
 i.


