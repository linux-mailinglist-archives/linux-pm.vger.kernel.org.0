Return-Path: <linux-pm+bounces-33260-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E27AFB39E35
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 15:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3537B3AC1EF
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 13:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7EF31079B;
	Thu, 28 Aug 2025 13:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SXsc+YDk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040CD31063B;
	Thu, 28 Aug 2025 13:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756386561; cv=none; b=Xlskx8vib2udDUwPNJTWticaSCKfKAHom3b68BGHdlseZcj/mz0LIhx3Gea2HNw1eBtCB6feAThjNiOstXHw4+YY6EtD3Nqwsjl9AwxEddZeeFQAe6AAeneFdvZCPDoipmWqHqXrmItjok7tT3tLPp4jVF7viffmOpS7shtIkKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756386561; c=relaxed/simple;
	bh=qGjo9AY3DKPnioRDKtJTSiypvsidCmZIsJK2GK04oCY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZwKSLcSuK5jlh2VmG5xgsejizDK3HWuecvpwO+CByZG1EGJamJMLPBdSC7m4T5DUgexUhbQt19JwZd68i4nAvrN9rdXYW3bHWotv109f2yxiNnjuSvqbqwck4MId2aK6NctqqWI9swcCA9s1FsNxXfulQGINyVyHZRAWt1DIftA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SXsc+YDk; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756386559; x=1787922559;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qGjo9AY3DKPnioRDKtJTSiypvsidCmZIsJK2GK04oCY=;
  b=SXsc+YDk9nY/jYP/eb625bveA+ZM8SQH+WwsNCgktZBeKEvqvfcIN11h
   hABtiP9RhtcHVODlC13XCGrObB3xcYihD9iBbEv6mO2l5zOV3+DalTa75
   TeZSKYbgkkbYMdUSqnNlzuC/Mzk85u57A5j2+8I/hPLcqlMDw71W3rl5m
   jgKgoEIEps7t8SAvTmofS9GI+59mlA9j0C4ig2UhYuC4xxoKSMrFtGCMP
   ENNbwr2PcP9VCTvwpgo6Dtku9B6BQrO7ON/4PqdX1QVUwcPdR5VciONM9
   3ZvM8SKBP20gPljH6qknMIiMdVBycrdzE/X498MYwBW5umyQArpcPpan3
   w==;
X-CSE-ConnectionGUID: XDqnAWlbRra7s60LO1SAtw==
X-CSE-MsgGUID: xndoc6dnS22ByqU0Fd8erQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="76103692"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="76103692"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 06:09:18 -0700
X-CSE-ConnectionGUID: LiiHkF11TYqXxVlPXHyDSg==
X-CSE-MsgGUID: 2EHUJjTUQA+SbRdB2tlswQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="174275455"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 06:09:15 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 28 Aug 2025 16:09:11 +0300 (EEST)
To: Xi Pardee <xi.pardee@linux.intel.com>
cc: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com, 
    hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, 
    platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 3/6] platform/x86:intel/pmc: Improve function to show
 substate header
In-Reply-To: <20250815224611.2460255-4-xi.pardee@linux.intel.com>
Message-ID: <6690bc98-a396-0d8a-dae6-b141a8667585@linux.intel.com>
References: <20250815224611.2460255-1-xi.pardee@linux.intel.com> <20250815224611.2460255-4-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 15 Aug 2025, Xi Pardee wrote:

> Refactor pmc_core_substate_req_header_show() to accept a new argument.
> This is a preparation patch to introduce a new way to show Low Power
> Mode substate requirement data for platforms starting from Panther
> Lake. Increased the size for the name column as the Low Power Mode
> requirement register name is longer in newer platforms.
> 
> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
> ---
>  drivers/platform/x86/intel/pmc/core.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
> index a1dd80bdbd413..cbfdcdc50ad21 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c
> @@ -11,6 +11,11 @@
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
> +enum header_type {
> +	HEADER_STATUS,
> +	HEADER_VALUE

Please have the comma in any non-terminating entry.

> +};
> +
>  #include <linux/bitfield.h>
>  #include <linux/debugfs.h>
>  #include <linux/delay.h>
> @@ -828,17 +833,22 @@ static int pmc_core_substate_l_sts_regs_show(struct seq_file *s, void *unused)
>  }
>  DEFINE_SHOW_ATTRIBUTE(pmc_core_substate_l_sts_regs);
>  
> -static void pmc_core_substate_req_header_show(struct seq_file *s, int pmc_index)
> +static void pmc_core_substate_req_header_show(struct seq_file *s, int pmc_index,
> +					      enum header_type type)
>  {
>  	struct pmc_dev *pmcdev = s->private;
>  	int mode;
>  
> -	seq_printf(s, "%30s |", "Element");
> +	seq_printf(s, "%40s |", "Element");
>  	pmc_for_each_mode(mode, pmcdev)
>  		seq_printf(s, " %9s |", pmc_lpm_modes[mode]);
>  
> -	seq_printf(s, " %9s |", "Status");
> -	seq_printf(s, " %11s |\n", "Live Status");
> +	if (type == HEADER_STATUS) {
> +		seq_printf(s, " %9s |", "Status");
> +		seq_printf(s, " %11s |\n", "Live Status");
> +	} else {
> +		seq_printf(s, " %9s |\n", "Value");
> +	}
>  }
>  
>  static int pmc_core_substate_req_regs_show(struct seq_file *s, void *unused)
> @@ -872,7 +882,7 @@ static int pmc_core_substate_req_regs_show(struct seq_file *s, void *unused)
>  			continue;
>  
>  		/* Display the header */
> -		pmc_core_substate_req_header_show(s, pmc_index);
> +		pmc_core_substate_req_header_show(s, pmc_index, HEADER_STATUS);
>  
>  		/* Loop over maps */
>  		for (mp = 0; mp < num_maps; mp++) {
> @@ -910,7 +920,7 @@ static int pmc_core_substate_req_regs_show(struct seq_file *s, void *unused)
>  				}
>  
>  				/* Display the element name in the first column */
> -				seq_printf(s, "pmc%d: %26s |", pmc_index, map[i].name);
> +				seq_printf(s, "pmc%d: %34s |", pmc_index, map[i].name);
>  
>  				/* Loop over the enabled states and display if required */
>  				pmc_for_each_mode(mode, pmcdev) {
> 

-- 
 i.


