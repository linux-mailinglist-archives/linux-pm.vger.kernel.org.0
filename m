Return-Path: <linux-pm+bounces-24380-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B67DA6BD92
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 15:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B1C317ACC8
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 14:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B451D5ADC;
	Fri, 21 Mar 2025 14:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R11z5zxD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1F11388;
	Fri, 21 Mar 2025 14:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742568567; cv=none; b=Tc8Rx6JWRPdEXbNz+B7En3APZCZhuMpjAC1jvQ4lupuee87GhUACLv7rZHsdcIvqvKlu/osa9ud11ua7sPcz1d8amKNcQo3OfokjBiuV9TTJvKHNnKUKCSuJ8SMOad8RlwQ4jU1z3xjvskKdz2BYKt8ipW2fRfuhWznaMfLZb9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742568567; c=relaxed/simple;
	bh=aVhUuTJqUnb+X5iwVusMDvsLR5i0p7vUkHZcj+ddVAo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GzAapPoh8zwh6WhIBsLQUA5kcF33N6vyHg0co7SvTEpjLTeieYZOWmwqtYKvAsUAnjEhrJ2o6kO6CqQQe6UVihnMGG2sFYHeQbo2ecU7skAZfdnFmxTRiUx8KS0oWgYZzJ13zijauxL7z92l1DIuVCARj18/KMLHENQDU5mGmMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R11z5zxD; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742568567; x=1774104567;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=aVhUuTJqUnb+X5iwVusMDvsLR5i0p7vUkHZcj+ddVAo=;
  b=R11z5zxDnY5GpOb44Qq7a1FeYlwABT+TCPlsGuDZgWNXD1onUPyxhLaz
   8chmKfr5qtYzyCEw3xLUkMvTo911pkr2P32423NyuBWWzsIpQI5nmO/AJ
   zrpOGVCnxiZH0PmgK7zm4ZGcLPgbxqVzmwsaoJw0EnM3jUyHmNmtsvbdN
   z9v2b2Cw5LcR5RgXm9mUNxnuFfy8sRP+3tQmqddckXpllYVn1M8WP5lVs
   LUw4VKAgoWiVi9+YEefgsO9twi80QLh+jtZNXMKWAyXBeaqVcG4CXQ/Q1
   gZNq8FBibj45jqgn2QJzSuij8weIaQ04xK67lFyQkPLK8mg1ZtlfSE7Vj
   A==;
X-CSE-ConnectionGUID: 3Otq0Na/QyybCJJvWQaBVw==
X-CSE-MsgGUID: pPrrrp0rQJqL1I+IM1wcJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="55221023"
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="55221023"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 07:49:26 -0700
X-CSE-ConnectionGUID: TbVKqvsfSVmoccHibrQJoA==
X-CSE-MsgGUID: hUyV+CN3To+ZGfYzKffOQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="160655390"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.112])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 07:49:23 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 21 Mar 2025 16:49:19 +0200 (EET)
To: Xi Pardee <xi.pardee@linux.intel.com>
cc: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com, 
    Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] platform/x86: intel/pmc: Fix iounmap call for valid
 addresses
In-Reply-To: <20250319224410.788273-1-xi.pardee@linux.intel.com>
Message-ID: <66c1a0f1-7d7a-da07-e80f-027964c503b8@linux.intel.com>
References: <20250319224410.788273-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 19 Mar 2025, Xi Pardee wrote:

> pmc_core_clean_structure() is called when generic_core_init() fails.
> generic_core_init() could fail before ioremap() is called to get
> a valid regbase for pmc structure. The current code does not check
> regbase before calling iounmap(). Add a check to fix it.

Hi,

The approach that calls the same "full cleanup" function as deinit uses 
when init function fails midway is very error prone as once again is 
demonstrated. Is this the only error handling problem? Are you 100% sure?

Think about it, init is x% (<100%) done when it fails, then it calls a 
function that tries to undo 100%. One needs to add lots of special logic 
to handle 0-100% rollback into that cleanup function. The init function, 
on the other hand, knows exactly where it was so it can rollback just what 
is needed and not even try to rollback for more.

It's also very inconsistent to rollback ssram_pcidev in this file as ssram 
code was moved into core_ssram so I think the ssram deinit should be moved 
there too.

I think these init functions should be converted to do proper rollback 
within the init function(s) to avoid very hard to track error handling.
I tried to check the error handling now in the pmc driver and after I 
would have needed to jump between the files, I gave up.

> Fixes: 1b8c7b843c00 ("platform/x86:intel/pmc: Discover PMC devices")
> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
> ---
>  drivers/platform/x86/intel/pmc/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
> index 7a1d11f2914f..de5fc06232e5 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c
> @@ -1471,7 +1471,7 @@ static void pmc_core_clean_structure(struct platform_device *pdev)
>  	for (i = 0; i < ARRAY_SIZE(pmcdev->pmcs); ++i) {
>  		struct pmc *pmc = pmcdev->pmcs[i];
>  
> -		if (pmc)
> +		if (pmc && pmc->regbase)
>  			iounmap(pmc->regbase);

-- 
 i.


