Return-Path: <linux-pm+bounces-15045-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6F298CF3E
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2024 10:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46DEB1C216B9
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2024 08:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF88196C67;
	Wed,  2 Oct 2024 08:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kMEO8pPD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C7D155735;
	Wed,  2 Oct 2024 08:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727859134; cv=none; b=pK7bXyc6qU/3D9Bu1cohKQsx8/3Zyx8xn15M+tYP8Nc5OGnoZcoEIVvIfhOIPeQEDyLks06OquLD5XXgot5b7MBuRlN6UtcMrWZJ3I9DBEMrzbhBVYpdrMNrcsfDql8GtdsqtqgWDGs5+KeSp9KsJBfF6uNkdbOL1O5k+FqeMSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727859134; c=relaxed/simple;
	bh=5+ziiLC6A4yJME60m/zYgegUux01ipdOi7FzldB4D7w=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CZ5ltBI3DohgET1SDG+DjGsl+JZ59qqaluUWCvTGj63tWqd1/X/VIMxqwWQme1yP5B5i9KoKtTDNwush8OCEh4dwpnL33D9bmYAC7gBn/Tdiiszzvprmt6wRSMzETZ2WPfNKXR9VlRxNi8Zjx4vKpzwJN05fivloJ82kiXCuLKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kMEO8pPD; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727859132; x=1759395132;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=5+ziiLC6A4yJME60m/zYgegUux01ipdOi7FzldB4D7w=;
  b=kMEO8pPDJKonrXdtnTytfSo+q4/rUwfjcpKxdZek1xDAwfHnj/pOuG0K
   l6VGYlIpT6q8jc/elt48h9kcRr7Z/ZJv01ULr1zFz3FqWizhdNzi+C8Gq
   48MJf4OoKm+/AQ1UJkAeVMaEbgTsRgfQxaToLnK+OcK5BXVbSsWgqviSE
   Vne59FUJ+wo+jApIMXAt4BZAA+9h3m6DzNWK+B6F5SHLeiSo/D/Qo3YED
   MBdawlHzSFugLp7XsHtE1YEKPva+W4FpMNa0clHEQHjceUVssAkGHHMnk
   1Cl3jR4Zcahe4A2IJ2DfDXrZcZCe079YKxsiUJwWdymQjaaOv7GyjOzfa
   Q==;
X-CSE-ConnectionGUID: 6Y/2ndPLQMe/HsqIZOJlJA==
X-CSE-MsgGUID: mKynD2hmQgK/LDpHrU7QUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="38399085"
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; 
   d="scan'208";a="38399085"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 01:52:12 -0700
X-CSE-ConnectionGUID: 7C/8hBmMREGyE6zLMmed/g==
X-CSE-MsgGUID: svfZ9Zh5RyCH0ZJvLfUvgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; 
   d="scan'208";a="78474272"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.31])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 01:52:09 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 2 Oct 2024 11:52:06 +0300 (EEST)
To: "David E. Box" <david.e.box@linux.intel.com>, 
    Hans de Goede <hdegoede@redhat.com>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc: david.e.box@intel.com, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, 
    rjw@rjwysocki.net
Subject: Re: [PATCH] platform/x86/intel/pmc: Disable C1 auto-demotion during
 suspend
In-Reply-To: <20241001225901.135564-1-david.e.box@linux.intel.com>
Message-ID: <f621da34-32a7-c56e-2c99-54a5f03c7e6f@linux.intel.com>
References: <20241001225901.135564-1-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 1 Oct 2024, David E. Box wrote:

> On some platforms, aggressive C1 auto-demotion may lead to failure to enter
> the deepest C-state during suspend-to-idle, causing high power consumption.
> To prevent this, disable C1 auto-demotion during suspend and re-enable on
> resume.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  drivers/platform/x86/intel/pmc/arl.c |  3 +--
>  drivers/platform/x86/intel/pmc/cnp.c | 28 +++++++++++++++++++++++++++-
>  drivers/platform/x86/intel/pmc/lnl.c |  3 +--
>  drivers/platform/x86/intel/pmc/mtl.c |  3 +--
>  4 files changed, 30 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/intel/pmc/arl.c
> index e10527c4e3e0..05dec4f5019f 100644
> --- a/drivers/platform/x86/intel/pmc/arl.c
> +++ b/drivers/platform/x86/intel/pmc/arl.c
> @@ -687,9 +687,8 @@ static void arl_d3_fixup(void)
>  static int arl_resume(struct pmc_dev *pmcdev)
>  {
>  	arl_d3_fixup();
> -	pmc_core_send_ltr_ignore(pmcdev, 3, 0);
>  
> -	return pmc_core_resume_common(pmcdev);
> +	return cnl_resume(pmcdev);
>  }
>  
>  int arl_core_init(struct pmc_dev *pmcdev)
> diff --git a/drivers/platform/x86/intel/pmc/cnp.c b/drivers/platform/x86/intel/pmc/cnp.c
> index 513c02670c5a..5b8b3ac7f061 100644
> --- a/drivers/platform/x86/intel/pmc/cnp.c
> +++ b/drivers/platform/x86/intel/pmc/cnp.c
> @@ -7,7 +7,8 @@
>   * All Rights Reserved.
>   *
>   */
> -
> +#define DEBUG

Debug leftover.

> +#include <linux/suspend.h>
>  #include "core.h"
>  
>  /* Cannon Lake: PGD PFET Enable Ack Status Register(s) bitmap */
> @@ -206,8 +207,24 @@ const struct pmc_reg_map cnp_reg_map = {
>  	.etr3_offset = ETR3_OFFSET,
>  };
>  
> +

Extra newline.

> +static DEFINE_PER_CPU(u64, pkg_cst_config);
> +
>  void cnl_suspend(struct pmc_dev *pmcdev)
>  {
> +	if (!pm_suspend_via_firmware()) {
> +		u64 val;
> +		int cpunum;
> +
> +		for_each_online_cpu(cpunum) {
> +			rdmsrl_on_cpu(cpunum, MSR_PKG_CST_CONFIG_CONTROL, &val);
> +			per_cpu(pkg_cst_config, cpunum) = val;

I'm not sure about this. It feels abuse of per cpu stuff as here a single 
thread is just recording something for every CPU (not the CPUs 
themselves).

(But my thinking of what's the purpose of per cpu stuff might be 
incomplete so I'm open to changing my mind about this if proven 
otherwise.)

Any thoughts about this Hans? Or Andy?

> +			val &= ~NHM_C1_AUTO_DEMOTE;
> +			wrmsrl_on_cpu(cpunum, MSR_PKG_CST_CONFIG_CONTROL, val);
> +			pr_debug("%s: cpu:%d cst %llx\n", __func__, cpunum, val);
> +		}
> +	}
> +
>  	/*
>  	 * Due to a hardware limitation, the GBE LTR blocks PC10
>  	 * when a cable is attached. To unblock PC10 during suspend,
> @@ -220,6 +237,15 @@ int cnl_resume(struct pmc_dev *pmcdev)
>  {
>  	pmc_core_send_ltr_ignore(pmcdev, 3, 0);
>  
> +	if (!pm_suspend_via_firmware()) {
> +		int cpunum;
> +
> +		for_each_online_cpu(cpunum) {
> +			pr_debug("%s: cpu:%d cst %llx\n", __func__, cpunum, per_cpu(pkg_cst_config, cpunum));
> +			wrmsrl_on_cpu(cpunum, MSR_PKG_CST_CONFIG_CONTROL, per_cpu(pkg_cst_config, cpunum));

Is the set of onlined CPUs iterated by the suspend and resume handlers 
guaranteed to be the same?

-- 
 i.

> +		}
> +	}
> +
>  	return pmc_core_resume_common(pmcdev);
>  }
>  
> diff --git a/drivers/platform/x86/intel/pmc/lnl.c b/drivers/platform/x86/intel/pmc/lnl.c
> index e7a8077d1a3e..be029f12cdf4 100644
> --- a/drivers/platform/x86/intel/pmc/lnl.c
> +++ b/drivers/platform/x86/intel/pmc/lnl.c
> @@ -546,9 +546,8 @@ static void lnl_d3_fixup(void)
>  static int lnl_resume(struct pmc_dev *pmcdev)
>  {
>  	lnl_d3_fixup();
> -	pmc_core_send_ltr_ignore(pmcdev, 3, 0);
>  
> -	return pmc_core_resume_common(pmcdev);
> +	return cnl_resume(pmcdev);
>  }
>  
>  int lnl_core_init(struct pmc_dev *pmcdev)
> diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
> index 91f2fa728f5c..fc6a89b8979f 100644
> --- a/drivers/platform/x86/intel/pmc/mtl.c
> +++ b/drivers/platform/x86/intel/pmc/mtl.c
> @@ -988,9 +988,8 @@ static void mtl_d3_fixup(void)
>  static int mtl_resume(struct pmc_dev *pmcdev)
>  {
>  	mtl_d3_fixup();
> -	pmc_core_send_ltr_ignore(pmcdev, 3, 0);
>  
> -	return pmc_core_resume_common(pmcdev);
> +	return cnl_resume(pmcdev);
>  }
>  
>  int mtl_core_init(struct pmc_dev *pmcdev)
> 

