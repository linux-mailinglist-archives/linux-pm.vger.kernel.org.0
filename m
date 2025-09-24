Return-Path: <linux-pm+bounces-35269-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3BEB993B6
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 11:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D0B616BDEA
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 09:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F272E2580D7;
	Wed, 24 Sep 2025 09:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="knzpppIY"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DC21E520E;
	Wed, 24 Sep 2025 09:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758707321; cv=none; b=d6N3FwmF5xhQ98op+67ACT7CF2kBEc7XkS+BwKQiuuF5KctXSNhx+ysu+E814JBTWqtGEeAmSqAt8XQe+cwsSwBrtXtuN+z956lzCDYGcR0N8R6JCUvJ9k9p61Vxz/xgAPEUxXRCZlEwCsshps2wFmR/2B/pcqA+dfcLWI2lXh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758707321; c=relaxed/simple;
	bh=0XQqldii0ogvEJhYIqs/UJNHv33XTocGr6ZCVQejLTY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sYBvNrrt2IOi62PLQ/xMScUojuGzNSAZ7wjjlTwZVeAURoqYL0UbJl9COFoB26eM++icUCWxRcikCeD2l2eQUnyTrfzKWXzOXxK4OQ2GNjRx2s2syNkPZEDhYyQpi7tkU4MIsr6dLDziEow95ZpwZvLc6oH1vFm6dlXBqhRxWvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=knzpppIY; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58O9mBjm1184080;
	Wed, 24 Sep 2025 04:48:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758707291;
	bh=1H55ciLspOeaCKCXcKZzvxqPw6u58HfYhWx4Xna4xhg=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=knzpppIY0BIWPBurE0M6oLPHGa5ORu2DOjWBhowrJkDpAYEcxpqJMDRW18of3zWtF
	 3RVc3GwGMKl/BVBGuhCyf0L6Tbb6LNQlYwgYsp0v5hOzMe98EUMN7QCJa3+TZredDJ
	 ZqBD27/soL2M/4A8uZ2H9jsKiVNvGUEc6XQUnz8U=
Received: from DFLE211.ent.ti.com (dfle211.ent.ti.com [10.64.6.69])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58O9mBMW2348214
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 24 Sep 2025 04:48:11 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 24 Sep
 2025 04:48:10 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 24 Sep 2025 04:48:10 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58O9m96d1811362;
	Wed, 24 Sep 2025 04:48:10 -0500
Date: Wed, 24 Sep 2025 15:18:09 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Brian Norris <briannorris@chromium.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        <kunit-dev@googlegroups.com>, Len Brown <lenb@kernel.org>,
        Sakari Ailus
	<sakari.ailus@linux.intel.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] PM: runtime: Make put{,_sync}() return 1 when
 already suspended
Message-ID: <20250924094809.g7vuy75vm3gqzc4d@lcpd911>
References: <20250829003319.2785282-1-briannorris@chromium.org>
 <20250829003319.2785282-2-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250829003319.2785282-2-briannorris@chromium.org>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Aug 28, 2025 at 17:28:27 -0700, Brian Norris wrote:
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

Right, just doing a $> git grep -A5 "= pm_runtime_put"    gave me quite a few
callers who actually do check the return codes, and in some cases even
directly backpropagate them! So like you say with this patch best case even
might fix a few cases where it's unnecessary.


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
> +

No objections from my side,
Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

