Return-Path: <linux-pm+bounces-36053-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD44BD8997
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 11:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1A983A20A4
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 09:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81ADD27FD62;
	Tue, 14 Oct 2025 09:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wCd5dMyn"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E49220686
	for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 09:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760435753; cv=none; b=NG3qW2d5bMexwoLHWd3P3y9A6oGEtJAYA5jPlj9X8S52/TafBviZg3H9IGXCh71w+ublIRN1KI3DOR8tjCVl8RecITLkoRhMU4u0u0lE6taT1iw114o3NAP1Z3XMSzYyJsxpILP/qt1o71wPruxHChhDOHpNZ1U4nXtkFfdGAFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760435753; c=relaxed/simple;
	bh=3cuvrbPMv7j0LlHTsA3h9NOZQWrKkRKKQ5F90/2aeU0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PchWU1+PVWOa4ybxKgG/8Gx2Gawjrb9Gztx7ch8Mptk3e4JXvrfW9wI33RRnFqDmn0KVuSPmS2vrlO68MM3Vw/Z9b91njTZ0KVMAxbygIXKAe2rmTkWadjNymSJnCHPz1D5wOsz+fcRQAGidXzLe304NUDFLQ3UZ0THb6Qww4Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wCd5dMyn; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59E9tk0v1120202;
	Tue, 14 Oct 2025 04:55:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1760435746;
	bh=wNaK5GeZGa/JCZnnRyx5gF7OrkH+JZ9rYFlcZIOacj4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=wCd5dMyn8wcmv20kydb3ne8UcK5RaeoK+kKMLpFDx1Zy2ODUvrVG9pSV27wMIV9gf
	 +Pj1zMnur1OOthzLLr4BoMG8J6/8Z8krYGbDFuPVcEKB5nDbkJUrIMIEUT+XDNQ2Ys
	 lTu/+GP5Lt4TnPRn2LGGQi+lTF9shDTxANvH6rOU=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59E9tkqU355118
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 14 Oct 2025 04:55:46 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 14
 Oct 2025 04:55:45 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 14 Oct 2025 04:55:45 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59E9tioK3369863;
	Tue, 14 Oct 2025 04:55:45 -0500
Date: Tue, 14 Oct 2025 15:25:44 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
CC: <rafael@kernel.org>, <pavel@kernel.org>, <dakr@kernel.org>,
        <gregkh@linuxfoundation.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2] PM: Introduce DEFINE_PM_GENERIC_FUNC macro to reduce
 code duplication
Message-ID: <20251014095544.flxkpnzuxun2t7ky@lcpd911>
References: <20251014072203.979292-1-kaushlendra.kumar@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251014072203.979292-1-kaushlendra.kumar@intel.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Oct 14, 2025 at 12:52:03 +0530, Kaushlendra Kumar wrote:
> Add DEFINE_PM_GENERIC_FUNC macro to completely eliminate repetitive
> code patterns in power management generic operations. This macro
> generates the entire function definition including signature,
> implementation, and symbol export for each pm_generic_* function.
> 
> This reduces code duplication significantly while maintaining the
> same functionality and improving code maintainability.
> 
> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> ---
> Changes in v2:
> - Include function signature and symbol export in macro as suggested
> ---
>  drivers/base/power/generic_ops.c | 158 +++++--------------------------
>  1 file changed, 26 insertions(+), 132 deletions(-)
> 
> diff --git a/drivers/base/power/generic_ops.c b/drivers/base/power/generic_ops.c
> index 6502720bb564..0afea5d8f8ef 100644
> --- a/drivers/base/power/generic_ops.c
> +++ b/drivers/base/power/generic_ops.c
> @@ -8,6 +8,14 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/export.h>
>  
> +#define DEFINE_PM_GENERIC_FUNC(func_name, op_name) \
> +int pm_generic_##func_name(struct device *dev) \
> +{ \
> +	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL; \
> +	return pm && pm->op_name ? pm->op_name(dev) : 0; \
> +} \
> +EXPORT_SYMBOL_GPL(pm_generic_##func_name)
> +

NAK.

Honestly, I am not okay with this level of optimization just to reduce
lines of code. It was much more verbose and clear earlier and I don't
really understand the full benefit of this patch.

If we look at this from the eyes of a newcomer to the kernel, who does
not follow the PM lists/ is coming from older kernels and tries to jump
to the definitions of pm_generic_runtime_suspend or whatever - it's
going to break for them. I use ctags to jump around kernel definitions
extensively and after this patch I will have to jump through hoops to
find what pm_generic_XYZ is doing and where it even is defined. grep
will break too.

Unless there's real proof that this greatly improves code readability or
performance that I can't think of right now.

Perhaps Greg/ Rafael can comment on whether this is truly justified
from a maintainence perspective, but as a PM susbsys user it will make
things just complicated for consumers of these ops to dig into IMO.

>  #ifdef CONFIG_PM
>  /**
>   * pm_generic_runtime_suspend - Generic runtime suspend callback for subsystems.
> @@ -17,16 +25,7 @@
>   * ->runtime_suspend(), execute it and return its error code.  Otherwise,
>   * return 0.
>   */
> -int pm_generic_runtime_suspend(struct device *dev)
> -{
> -	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
> -	int ret;
> -
> -	ret = pm && pm->runtime_suspend ? pm->runtime_suspend(dev) : 0;
> -
> -	return ret;
> -}
> -EXPORT_SYMBOL_GPL(pm_generic_runtime_suspend);
> +DEFINE_PM_GENERIC_FUNC(runtime_suspend, runtime_suspend);
[...]

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

