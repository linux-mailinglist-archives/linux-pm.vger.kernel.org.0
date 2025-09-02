Return-Path: <linux-pm+bounces-33609-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CE4B3F698
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 09:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6953E7A8CD7
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 07:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6EC2E6CD5;
	Tue,  2 Sep 2025 07:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cglrKSiU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60431FBC92;
	Tue,  2 Sep 2025 07:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756797935; cv=none; b=K0FONRoYJHfCatD2PfaXYFC+ddznX2+VDOwwUwMgVsHXVoe+TAViiQuXA/96oBNHwUDbrB39hZwEjxsAJ/dP3AzN2JCQUwC39jmHEaWoITFXZl5QTndDstPgx0qapdKta68HBEYTkuWJkODRLSujzvwaH63zMq4XWWbXiAh1aLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756797935; c=relaxed/simple;
	bh=a3yelBm/hyKGoL78tvyn3nQRc8ynp8Q/nWg1vSscgXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQbfjOBbrbatQQPIeFcCoDHwacEcszVCzLEWuqdmHkd/f/YtQ0Uc2ba92Yo6+FG2HYcQ//QtTZuRn4q5mFvfOugZBVUgdHAYSZkQ3WsEf6yQ5iSM8NUYRN6RFeP1WshmzThvHfu6gb9OJbXwSk4edi/K/eWN149sbcn+VapznIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cglrKSiU; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756797934; x=1788333934;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a3yelBm/hyKGoL78tvyn3nQRc8ynp8Q/nWg1vSscgXE=;
  b=cglrKSiUorS0xR6VH+2J9k4jtWuMD52NkfdbV+z5k+X33PdENyqLgTyQ
   tIGh6+JNvN1k+oO1UtelNVjlcY59kzv+kaKH3XsiD97O5kyhayCAK4i/y
   3DgQGWDRKtAj66X+8N1OT9Z4vgt1m3ZrSYFNT2CbrJxmMBBxVIGH/zlku
   lzfpevZlW8cD/ENdXUszVlgllE5sTWUiL0Mjrwohjmu3xKyLbvt2ZPBhJ
   ScxR0+z24HQUxk9Ru2C2Ac+gMCkr0tudcuk/ZeRFDsFCIYvk/MEB5nh+d
   7yvu3du33Mm1D9JkSH3g2gyCvT+8C12C1KhioTbDTi/AFxEUG1c0VUBaq
   w==;
X-CSE-ConnectionGUID: GibEawFTRPqCux1mIQUqdg==
X-CSE-MsgGUID: V5kREh1YRmCrXK32Dbclrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="58756189"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="58756189"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 00:25:32 -0700
X-CSE-ConnectionGUID: vXLZx0CaQE6YHmi2dDSB7w==
X-CSE-MsgGUID: iSV6uzNzRgC5M8hbrekRFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="172053825"
Received: from agladkov-desk.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.32])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 00:25:30 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 9EC6E121F49;
	Tue, 02 Sep 2025 10:25:27 +0300 (EEST)
Date: Tue, 2 Sep 2025 10:25:27 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	kunit-dev@googlegroups.com, Len Brown <lenb@kernel.org>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] PM: runtime: Make put{,_sync}() return 1 when
 already suspended
Message-ID: <aLab51BTgvnULBUd@kekkonen.localdomain>
References: <20250829003319.2785282-1-briannorris@chromium.org>
 <20250829003319.2785282-2-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829003319.2785282-2-briannorris@chromium.org>

Hi Brian,

On Thu, Aug 28, 2025 at 05:28:27PM -0700, Brian Norris wrote:
> The pm_runtime.h docs say pm_runtime_put() and pm_runtime_put_sync()
> return 1 when already suspended, but this is not true -- they return
> -EAGAIN. On the other hand, pm_runtime_put_sync_suspend() and
> pm_runtime_put_sync_autosuspend() *do* return 1.
> 
> This is an artifact of the fact that the former are built on rpm_idle(),
> whereas the latter are built on rpm_suspend().
> 
> There are precious few pm_runtime_put()/pm_runtime_put_sync() callers
> that check the return code at all, but most of them only log errors, and
> usually only for negative error codes. None of them should be treating
> this as an error, so:
> 
>  * at best, this may fix some case where a driver treats this condition
>    as an error, when it shouldn't;
> 
>  * at worst, this should make no effect; and
> 
>  * somewhere in between, we could potentially clear up non-fatal log
>    messages.
> 
> Fix the pm_runtime_already_suspended_test() while tweaking the behavior.
> The test makes a lot more sense when these all return 1 when the device
> is already suspended:
> 
>     pm_runtime_put(dev);
>     pm_runtime_put_sync(dev);
>     pm_runtime_suspend(dev);
>     pm_runtime_autosuspend(dev);
>     pm_request_autosuspend(dev);
>     pm_runtime_put_sync_autosuspend(dev);
>     pm_runtime_put_autosuspend(dev);
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> 
>  drivers/base/power/runtime-test.c | 8 ++------
>  drivers/base/power/runtime.c      | 3 +++
>  2 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/base/power/runtime-test.c b/drivers/base/power/runtime-test.c
> index 263c28d5fc50..1be18e871f1d 100644
> --- a/drivers/base/power/runtime-test.c
> +++ b/drivers/base/power/runtime-test.c
> @@ -43,15 +43,11 @@ static void pm_runtime_already_suspended_test(struct kunit *test)
>  	KUNIT_EXPECT_EQ(test, 0, pm_runtime_barrier(dev)); /* no wakeup needed */
>  
>  	KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> -	/*
> -	 * We never actually left RPM_SUSPENDED, but rpm_idle() still treats
> -	 * this as -EAGAIN / "runtime PM status change ongoing".
> -	 */
> -	KUNIT_EXPECT_EQ(test, -EAGAIN, pm_runtime_put(dev));
> +	KUNIT_EXPECT_EQ(test, 1, pm_runtime_put(dev));
>  
>  	pm_runtime_get_noresume(dev);
>  	KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> -	KUNIT_EXPECT_EQ(test, -EAGAIN, pm_runtime_put_sync(dev));
> +	KUNIT_EXPECT_EQ(test, 1, pm_runtime_put_sync(dev));
>  
>  	KUNIT_EXPECT_EQ(test, 1, pm_runtime_suspend(dev));
>  	KUNIT_EXPECT_EQ(test, 1, pm_runtime_autosuspend(dev));
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 3e84dc4122de..17cf111d16aa 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -498,6 +498,9 @@ static int rpm_idle(struct device *dev, int rpmflags)
>  	if (retval < 0)
>  		;	/* Conditions are wrong. */
>  
> +	else if ((rpmflags & RPM_GET_PUT) && (retval == 1))
> +		;	/* put() is allowed in RPM_SUSPENDED */

Ah, I missed this while reviewing the 3rd patch. Makes sense. Please ignore
my comments regarding the 3rd patch on whether the return value 1 is
applicable.

The latter parentheses are redundant (the former, too, actually, but the
compiler warns so let them be).

> +
>  	/* Idle notifications are allowed only in the RPM_ACTIVE state. */
>  	else if (dev->power.runtime_status != RPM_ACTIVE)
>  		retval = -EAGAIN;

-- 
Kind regards,

Sakari Ailus

