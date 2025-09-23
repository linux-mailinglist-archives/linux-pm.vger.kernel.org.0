Return-Path: <linux-pm+bounces-35205-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 421D7B954D8
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 11:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87A321883C94
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 09:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EA3320CB3;
	Tue, 23 Sep 2025 09:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="zH+DBw9j"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B756D320A3F;
	Tue, 23 Sep 2025 09:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758620689; cv=none; b=gOOWYSByUqDUkPOVD6NHp7Bdfs/7DiT+jnldAP3Zg6T4xnkiQNawJDzWLpudvbOcmac4zBm3IWhxxPgJlmQA5CBvKC5cEddGK/6sOqUVOCrOanobw4R2xLRclN6XSAq40k70XzlpJOGV2o8kvpSst600NuL4Jmz12cS+SQffBN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758620689; c=relaxed/simple;
	bh=EYJuMjT+v7CF9/3Hn64+X0R627O39fsTNYIIvMmp59U=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pvihAzdbbk/Dy5bUgphCNqBwtEkHZCjasALtIatU0Z5sxh8wdk8DZ1EYp+fQT85Q0pk1FXIUdejjIVXvhLhLVoEl5tJzuVn9g1zxbOp8Ckm36DOLjjn2Lh10RmaX6yb+oo6MSAv2w1mp3mxjy0mLZHbEpxD30sySP9u0oscJGQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=zH+DBw9j; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58N9iFhl965751;
	Tue, 23 Sep 2025 04:44:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758620655;
	bh=NyBPtCHg5D/EjT8uTbQbLQ8LVoszQDo0Ue2taA2mz7k=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=zH+DBw9jgG1XKscE5MCC6KXkbyh5nnikp6dGToCoShbQ00epKAy/o+fg1Hc7bJ8zm
	 12f5w4pBziulisj7Ae3nYS7/p9V6OvHx1FsLZglT66A3gX2WRE8o8sIEsAsmY4dowZ
	 gbkA/WbYZsRXDmKHwdkaQJ+5AaDRp+PL1gOsEPRQ=
Received: from DFLE206.ent.ti.com (dfle206.ent.ti.com [10.64.6.64])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58N9iFTE988034
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Sep 2025 04:44:15 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Sep
 2025 04:44:14 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Sep 2025 04:44:14 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58N9iDEa4041921;
	Tue, 23 Sep 2025 04:44:14 -0500
Date: Tue, 23 Sep 2025 15:14:13 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Peng Fan <peng.fan@nxp.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Chen <peter.chen@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha
 Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team
	<kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Thinh Nguyen
	<Thinh.Nguyen@synopsys.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 2/5] PM: domains: Allow power-off for out-of-band
 wakeup-capable devices
Message-ID: <20250923094413.quvxrj2ru46qdjgb@lcpd911>
References: <20250922-pm-v4-v4-0-ef48428e8fe0@nxp.com>
 <20250922-pm-v4-v4-2-ef48428e8fe0@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250922-pm-v4-v4-2-ef48428e8fe0@nxp.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Sep 22, 2025 at 10:21:07 +0800, Peng Fan wrote:
> Currently, if a device is configured as a system wakeup source, the PM
> domain core avoids powering off its power domain during system-wide
> suspend. However, this can lead to unnecessary power consumption,
> especially for devices whose wakeup logic resides in an always-on domain,
> i.e., devices with out-of-band wakeup capability.
> 
> To address this, add a check for device_out_band_wakeup() in
> genpd_finish_suspend(). If the device supports out-of-band wakeup, its
> power domain can be safely powered off, just like regular devices without
> wakeup enabled. And same check in genpd_finish_resume().

Seems very well structured now! Thanks.

> 
> This change improves power efficiency without compromising wakeup
> functionality.

On a lighter note-
This seems like an AI generated sentence to me :P

I've often seen LLMs throw around terms like improve code / power
efficiency, etc...

> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/pmdomain/core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 61c2277c9ce39fcd2f7e77df549626e49a4d5310..4925bc1c441078a8d38600192ee696bf550e80f0 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -1545,7 +1545,8 @@ static int genpd_finish_suspend(struct device *dev,
>  	if (ret)
>  		return ret;
>  
> -	if (device_awake_path(dev) && genpd_is_active_wakeup(genpd))
> +	if (device_awake_path(dev) && genpd_is_active_wakeup(genpd) &&
> +	    !device_out_band_wakeup(dev))
>  		return 0;
>  
>  	if (genpd->dev_ops.stop && genpd->dev_ops.start &&
> @@ -1600,7 +1601,8 @@ static int genpd_finish_resume(struct device *dev,
>  	if (IS_ERR(genpd))
>  		return -EINVAL;
>  
> -	if (device_awake_path(dev) && genpd_is_active_wakeup(genpd))
> +	if (device_awake_path(dev) && genpd_is_active_wakeup(genpd) &&
> +	    !device_out_band_wakeup(dev))
>  		return resume_noirq(dev);

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

