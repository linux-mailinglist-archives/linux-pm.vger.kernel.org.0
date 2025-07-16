Return-Path: <linux-pm+bounces-30933-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DD3B07BE9
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 19:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F2EC7B59B1
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 17:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B172F5C3E;
	Wed, 16 Jul 2025 17:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRsMma7h"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACD3277030;
	Wed, 16 Jul 2025 17:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752686602; cv=none; b=TTlPpZV30B/jJWYGSMnQOgQnoo9e5Vqh6K08bTn6I3bTma0dlpLphDW0eKhvIX/GJlznvmTur9sqTAzP/Kx5Odk0WwIuFKWuBM8k3ReSf/kfLsSEibN4Jp4nKAziam87jKRuD7GoqRKnUS0rybFo5I0Z834e22CmmvR7ly9kN34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752686602; c=relaxed/simple;
	bh=bJxiXdwctcFMQP5AgOq36xKafUcwzCVsY55BID2xUfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TcV4biwAZg3wgffFJe/oZBoEBB65LhsGBB0BUF5u96JE7+hsyv/gZViLFw1seyLkUhrz5JmM8okajwfNB4dsfgPExafSX2znij+CN57WajtYSFn07ME59bSF+EsBvU7US45rN2emDFc0izIH72jU3XfSt1XoDL9cRqGfWu3nVbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRsMma7h; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6159fb8b2aaso31925eaf.0;
        Wed, 16 Jul 2025 10:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752686595; x=1753291395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TYaF4rQQYYQxNckUKR5qLC2a/dsvjDTTBdvWeL+AwCI=;
        b=MRsMma7hLJtXQSDrmToWOofmlYNSVm2vRARAJH61UCyMPChDhsxsTkRo87TlAhJBxn
         x8mliFcHifrKQzLVbh+6Crou7nZD2M5nnl52SF4qs/5YcVASNNZxSW+0Ka+2IV/gySv3
         /yGqZu0ILj8okh/f4I8lMxA0rJUx2m1Gaofn0KiRpyUT3yqSK8IMEqO58Pq2UI/RQNim
         lN0snIl2HbikWXA32hJewfmjc0AbtYY/yKMRxr6OTEUupHzs0HmZJDzSKTSxlOPIDRNx
         c0++mhjMbtQaadbPNYoITuB2wAoZMIM/3/SzintyWdBYZ0BkdGQYeJo5hc6BzZR7NiAY
         9GIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752686595; x=1753291395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TYaF4rQQYYQxNckUKR5qLC2a/dsvjDTTBdvWeL+AwCI=;
        b=iKqQqhVvvqSy4Fw7GXd4V5WpwTn31HeoElaeCIaWUMT1svpSyCMfzBOh4OtJCLhbxM
         LI/sgDXEg62hnbqno9Ux7FVzeCYrUAYY1tFK7n4Es3ZrjdqGsrtUTS1yTlZf1UbrWYI5
         jmdmaKZ9cH1/RunECm7JAuksWxI5idTcl0OeEB5TFBHn7osEp7ZSiUE/lm8GeMpLNOhx
         M5m4uWDKr/IcFKTOpHXviq979BWTBjhGKpsHhMSSvS6QBaEFXZtXCMZPiNPYlH0IB4/4
         LwehdssQilvzalmYV6HbtxRk3aCTCqflaPPd3iFlg4KENCoC2Ig03DmUUTinO4RbqHma
         AhZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUb6t6HOyetJ0/e3RWII+MAM2LhkxPVoi3M001NT/qtvMueSqlSl5J+mr0F3WssJ5I+z2PEPKlHDYYv7Kg=@vger.kernel.org, AJvYcCW/vBre4RuK7R84wJGih2rrSyngtNGuwee+W7n+BpqLYi6vlS0xTnl406HTsXpkKfi+wzNzKGCrFUY=@vger.kernel.org, AJvYcCWJDPKxTS3DjaaOoiZjO0QsBOSJH+0xsUU0DwDRUG1U+Hqs7k2HvgGYPf9pnNJuFa+2CMnc/3I0+OnfwUjSiaKRBw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCUlMzcgu2YdpYzba2obtMRpr4WadKI+toeiNhdpYimQSIXXmu
	Qb9gS41Pj1rI7T8fRPLYOneMHRTvyBzYj9mOMdaN1X8Hmni/Wua9GoXd
X-Gm-Gg: ASbGncsBIiLptj/lYEddbN4CITbzIImDGRRrhn9lSbWgzw8HdtsJIaO2RAu/NiN4BFC
	zWuQWaRVB4YhSA5R3rVprkZhaj1EVXeD7t4BZtPWJM8f8DxKRdL3VRjQgJFKKlq+zgFiEiZXtSe
	iU5r1LX3+lXSUHYxy30WnIqYvibJr7vXTQqGoBwzpcAoOMrBTh/CfplLESPix3T+4jFTkrzNFWT
	JbImoo965KnrpUaNjkdmcitLxdo6YS0qSMk+yFNb/SrPfOD+S5mXJVSIVjix+g5FMHozB/VpBUK
	wj0kvEGjx1cvBDMmki0HX6mHdAqnBJgW1L6D/1cHHK7Cktvu2SBocKOThjHYJzNaxGc/PA+zvdN
	nqn7SYIaOXe44v/bm0x0=
X-Google-Smtp-Source: AGHT+IG9SWP+MHsh8szcrl8wNTXVHhSFgBCOXHKMiWzbcl8aU95a6gY+Zlw34P4nvAj5tKAF9dH35A==
X-Received: by 2002:a05:6870:5b9e:b0:2e9:9e9:d94b with SMTP id 586e51a60fabf-2ffb257d356mr2547792fac.39.1752686595050;
        Wed, 16 Jul 2025 10:23:15 -0700 (PDT)
Received: from hiagonb ([2804:1b3:a7c1:459e:e3dd:d2e:b1ee:b9ec])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ff8dea112bsm1724708fac.43.2025.07.16.10.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 10:23:14 -0700 (PDT)
Date: Wed, 16 Jul 2025 14:23:08 -0300
From: Hiago De Franco <hiagofranco@gmail.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Hiago De Franco <hiago.franco@toradex.com>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@oss.nxp.com>, daniel.baluta@nxp.com,
	iuliana.prodan@oss.nxp.com,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v7 3/3] remoteproc: imx_rproc: detect and attach to
 pre-booted remote cores
Message-ID: <20250716172308.lzh3aak24d6mt4cs@hiagonb>
References: <aHZ0nK4ZZShAr6Xz@p14s>
 <CAPDyKFrWng0CY-ayKoEbnS_yanghSqogxfuizxEVbVogJ4DT=g@mail.gmail.com>
 <20250716132552.bra37ucw4fcjwril@hiagonb>
 <aHfYQFvkJcdfq9K_@p14s>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHfYQFvkJcdfq9K_@p14s>

On Wed, Jul 16, 2025 at 10:50:08AM -0600, Mathieu Poirier wrote:
> On Wed, Jul 16, 2025 at 10:25:52AM -0300, Hiago De Franco wrote:
> > Hi Mathieu, Ulf,
> > 
> > On Tue, Jul 15, 2025 at 09:32:44AM -0600, Mathieu Poirier wrote:
> > > On Sun, Jun 29, 2025 at 02:25:12PM -0300, Hiago De Franco wrote:
> > > > From: Hiago De Franco <hiago.franco@toradex.com>
> > > > 
> > > > When the Cortex-M remote core is started and already running before
> > > > Linux boots (typically by the Cortex-A bootloader using a command like
> > > > bootaux), the current driver is unable to attach to it. This is because
> > > > the driver only checks for remote cores running in different SCFW
> > > > partitions. However in this case, the M-core is in the same partition as
> > > > Linux and is already powered up and running by the bootloader.
> > > > 
> > > > This patch adds a check using dev_pm_genpd_is_on() to verify whether the
> > > > M-core's power domains are already on. If all power domain devices are
> > > > on, the driver assumes the M-core is running and proceed to attach to
> > > > it.
> > > > 
> > > > To accomplish this, we need to avoid passing any attach_data or flags to
> > > > dev_pm_domain_attach_list(), allowing the platform device become a
> > > > consumer of the power domain provider without changing its current
> > > > state.
> > > > 
> > > > During probe, also enable and sync the device runtime PM to make sure
> > > > the power domains are correctly managed when the core is controlled by
> > > > the kernel.
> > > > 
> > > > Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > Reviewed-by: Peng Fan <peng.fan@nxp.com>
> > > > Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
> > > > ---
> > > > v6 -> v7:
> > > >  - Added Peng reviewed-by.
> > > > v5 -> v6:
> > > >  - Commit description improved, as suggested. Added Ulf Hansson reviewed
> > > >    by. Comment on imx-rproc.c improved.
> > > > v4 -> v5:
> > > >  - pm_runtime_get_sync() removed in favor of
> > > >    pm_runtime_resume_and_get(). Now it also checks the return value of
> > > >    this function.
> > > >  - Added pm_runtime_disable() and pm_runtime_put() to imx_rproc_remove()
> > > >    function.
> > > > v3 -> v4:
> > > >  - Changed to use the new dev_pm_genpd_is_on() function instead, as
> > > >    suggested by Ulf. This will now get the power status of the two
> > > >    remote cores power domains to decided if imx_rpoc needs to attach or
> > > >    not. In order to do that, pm_runtime_enable() and
> > > >    pm_runtime_get_sync() were introduced and pd_data was removed.
> > > > v2 -> v3:
> > > >  - Unchanged.
> > > > v1 -> v2:
> > > >  - Dropped unecessary include. Removed the imx_rproc_is_on function, as
> > > >    suggested.
> > > > ---
> > > >  drivers/remoteproc/imx_rproc.c | 37 +++++++++++++++++++++++++++++-----
> > > >  1 file changed, 32 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> > > > index 627e57a88db2..24597b60c5b0 100644
> > > > --- a/drivers/remoteproc/imx_rproc.c
> > > > +++ b/drivers/remoteproc/imx_rproc.c
> > > > @@ -18,6 +18,7 @@
> > > >  #include <linux/of_reserved_mem.h>
> > > >  #include <linux/platform_device.h>
> > > >  #include <linux/pm_domain.h>
> > > > +#include <linux/pm_runtime.h>
> > > >  #include <linux/reboot.h>
> > > >  #include <linux/regmap.h>
> > > >  #include <linux/remoteproc.h>
> > > > @@ -890,10 +891,8 @@ static int imx_rproc_partition_notify(struct notifier_block *nb,
> > > >  static int imx_rproc_attach_pd(struct imx_rproc *priv)
> > > >  {
> > > >  	struct device *dev = priv->dev;
> > > > -	int ret;
> > > > -	struct dev_pm_domain_attach_data pd_data = {
> > > > -		.pd_flags = PD_FLAG_DEV_LINK_ON,
> > > > -	};
> > > > +	int ret, i;
> > > > +	bool detached = true;
> > > >  
> > > >  	/*
> > > >  	 * If there is only one power-domain entry, the platform driver framework
> > > > @@ -902,7 +901,22 @@ static int imx_rproc_attach_pd(struct imx_rproc *priv)
> > > >  	if (dev->pm_domain)
> > > >  		return 0;
> > > >  
> > > > -	ret = dev_pm_domain_attach_list(dev, &pd_data, &priv->pd_list);
> > > > +	ret = dev_pm_domain_attach_list(dev, NULL, &priv->pd_list);
> > > > +	/*
> > > > +	 * If all the power domain devices are already turned on, the remote
> > > > +	 * core is already powered up and running when the kernel booted (e.g.,
> > > > +	 * started by U-Boot's bootaux command). In this case attach to it.
> > > > +	 */
> > > > +	for (i = 0; i < ret; i++) {
> > > > +		if (!dev_pm_genpd_is_on(priv->pd_list->pd_devs[i])) {
> > > > +			detached = false;
> > > > +			break;
> > > > +		}
> > > > +	}
> > > 
> > > I was doing one final review of this work when I noticed the return code for
> > > dev_pm_domain_attach_list() is never checked for error.
> > 
> > As Ulf pointed out, the 'return' a few lines below will return the
> > negative value to the caller of 'imx_rproc_attach_pd', which ultimately
> > will fail 'imx_rproc_detect_mode' and fail the probe of imx_rproc.
> > 
> > Please notice that even tough 'dev_pm_domain_attach_list' fails, the
> > rproc->state will still be set as RPROC_DETACHED because we are starting
> > 'detached' as true, but I am not seeing this as an issue because as
> > mentioned above the probe will fail anyway. Please let me know if you
> > see this as an issue.
> 
> Two things to consider here: 
> 
> (1) It is only a matter of time before someone with a cleaver coccinelle script
> sends me a patch that adds the missing error check.
> 
> (2) I think that @rproc->state being changed on error conditions is a bug
> waiting to happen.  This kind of implicit error handling is difficult to
> maintain and even more difficult for people to make enhancements to the driver.
> 
> Adding a simple error check will make sure neither of the above will happen.  It
> is a simple change and we are at rc6 - this work can still go in the merge
> window.

Sure, I can submit a new revision with this error check. Sorry I did not
see this before, I only had a close look at this '->state' now that you
asked on the previous email.

Thanks,

Hiago.

> 
> > 
> > > 
> > > Thanks,
> > > Mathieu
> > > 
> > > > +
> > > > +	if (detached)
> > > > +		priv->rproc->state = RPROC_DETACHED;
> > > > +
> > > >  	return ret < 0 ? ret : 0;
> > > >  }
> > > >  
> > > > @@ -1146,6 +1160,15 @@ static int imx_rproc_probe(struct platform_device *pdev)
> > > >  		}
> > > >  	}
> > > >  
> > > > +	if (dcfg->method == IMX_RPROC_SCU_API) {
> > > > +		pm_runtime_enable(dev);
> > > > +		ret = pm_runtime_resume_and_get(dev);
> > > > +		if (ret) {
> > > > +			dev_err(dev, "pm_runtime get failed: %d\n", ret);
> > > > +			goto err_put_clk;
> > > > +		}
> > > > +	}
> > > > +
> > > >  	ret = rproc_add(rproc);
> > > >  	if (ret) {
> > > >  		dev_err(dev, "rproc_add failed\n");
> > > > @@ -1171,6 +1194,10 @@ static void imx_rproc_remove(struct platform_device *pdev)
> > > >  	struct rproc *rproc = platform_get_drvdata(pdev);
> > > >  	struct imx_rproc *priv = rproc->priv;
> > > >  
> > > > +	if (priv->dcfg->method == IMX_RPROC_SCU_API) {
> > > > +		pm_runtime_disable(priv->dev);
> > > > +		pm_runtime_put(priv->dev);
> > > > +	}
> > > >  	clk_disable_unprepare(priv->clk);
> > > >  	rproc_del(rproc);
> > > >  	imx_rproc_put_scu(rproc);
> > > > -- 
> > > > 2.39.5
> > > > 
> > 
> > On Tue, Jul 15, 2025 at 06:03:44PM +0200, Ulf Hansson wrote:
> > > On Tue, 15 Jul 2025 at 17:32, Mathieu Poirier
> > > <mathieu.poirier@linaro.org> wrote:
> > > >
> > > > On Sun, Jun 29, 2025 at 02:25:12PM -0300, Hiago De Franco wrote:
> > > > > From: Hiago De Franco <hiago.franco@toradex.com>
> > > > >
> > > > > When the Cortex-M remote core is started and already running before
> > > > > Linux boots (typically by the Cortex-A bootloader using a command like
> > > > > bootaux), the current driver is unable to attach to it. This is because
> > > > > the driver only checks for remote cores running in different SCFW
> > > > > partitions. However in this case, the M-core is in the same partition as
> > > > > Linux and is already powered up and running by the bootloader.
> > > > >
> > > > > This patch adds a check using dev_pm_genpd_is_on() to verify whether the
> > > > > M-core's power domains are already on. If all power domain devices are
> > > > > on, the driver assumes the M-core is running and proceed to attach to
> > > > > it.
> > > > >
> > > > > To accomplish this, we need to avoid passing any attach_data or flags to
> > > > > dev_pm_domain_attach_list(), allowing the platform device become a
> > > > > consumer of the power domain provider without changing its current
> > > > > state.
> > > > >
> > > > > During probe, also enable and sync the device runtime PM to make sure
> > > > > the power domains are correctly managed when the core is controlled by
> > > > > the kernel.
> > > > >
> > > > > Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > > Reviewed-by: Peng Fan <peng.fan@nxp.com>
> > > > > Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
> > > > > ---
> > > > > v6 -> v7:
> > > > >  - Added Peng reviewed-by.
> > > > > v5 -> v6:
> > > > >  - Commit description improved, as suggested. Added Ulf Hansson reviewed
> > > > >    by. Comment on imx-rproc.c improved.
> > > > > v4 -> v5:
> > > > >  - pm_runtime_get_sync() removed in favor of
> > > > >    pm_runtime_resume_and_get(). Now it also checks the return value of
> > > > >    this function.
> > > > >  - Added pm_runtime_disable() and pm_runtime_put() to imx_rproc_remove()
> > > > >    function.
> > > > > v3 -> v4:
> > > > >  - Changed to use the new dev_pm_genpd_is_on() function instead, as
> > > > >    suggested by Ulf. This will now get the power status of the two
> > > > >    remote cores power domains to decided if imx_rpoc needs to attach or
> > > > >    not. In order to do that, pm_runtime_enable() and
> > > > >    pm_runtime_get_sync() were introduced and pd_data was removed.
> > > > > v2 -> v3:
> > > > >  - Unchanged.
> > > > > v1 -> v2:
> > > > >  - Dropped unecessary include. Removed the imx_rproc_is_on function, as
> > > > >    suggested.
> > > > > ---
> > > > >  drivers/remoteproc/imx_rproc.c | 37 +++++++++++++++++++++++++++++-----
> > > > >  1 file changed, 32 insertions(+), 5 deletions(-)
> > > > >
> > > > > diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> > > > > index 627e57a88db2..24597b60c5b0 100644
> > > > > --- a/drivers/remoteproc/imx_rproc.c
> > > > > +++ b/drivers/remoteproc/imx_rproc.c
> > > > > @@ -18,6 +18,7 @@
> > > > >  #include <linux/of_reserved_mem.h>
> > > > >  #include <linux/platform_device.h>
> > > > >  #include <linux/pm_domain.h>
> > > > > +#include <linux/pm_runtime.h>
> > > > >  #include <linux/reboot.h>
> > > > >  #include <linux/regmap.h>
> > > > >  #include <linux/remoteproc.h>
> > > > > @@ -890,10 +891,8 @@ static int imx_rproc_partition_notify(struct notifier_block *nb,
> > > > >  static int imx_rproc_attach_pd(struct imx_rproc *priv)
> > > > >  {
> > > > >       struct device *dev = priv->dev;
> > > > > -     int ret;
> > > > > -     struct dev_pm_domain_attach_data pd_data = {
> > > > > -             .pd_flags = PD_FLAG_DEV_LINK_ON,
> > > > > -     };
> > > > > +     int ret, i;
> > > > > +     bool detached = true;
> > > > >
> > > > >       /*
> > > > >        * If there is only one power-domain entry, the platform driver framework
> > > > > @@ -902,7 +901,22 @@ static int imx_rproc_attach_pd(struct imx_rproc *priv)
> > > > >       if (dev->pm_domain)
> > > > >               return 0;
> > > > >
> > > > > -     ret = dev_pm_domain_attach_list(dev, &pd_data, &priv->pd_list);
> > > > > +     ret = dev_pm_domain_attach_list(dev, NULL, &priv->pd_list);
> > > > > +     /*
> > > > > +      * If all the power domain devices are already turned on, the remote
> > > > > +      * core is already powered up and running when the kernel booted (e.g.,
> > > > > +      * started by U-Boot's bootaux command). In this case attach to it.
> > > > > +      */
> > > > > +     for (i = 0; i < ret; i++) {
> > > > > +             if (!dev_pm_genpd_is_on(priv->pd_list->pd_devs[i])) {
> > > > > +                     detached = false;
> > > > > +                     break;
> > > > > +             }
> > > > > +     }
> > > >
> > > > I was doing one final review of this work when I noticed the return code for
> > > > dev_pm_domain_attach_list() is never checked for error.
> > > 
> > > The for loop covers the error condition correctly, I think. It's only
> > > when ret >=1 when the loop should be started - and ret is propagated
> > > to the caller a few lines below.
> > > 
> > > >
> > > > Thanks,
> > > > Mathieu
> > > >
> > > 
> > > Kind regards
> > > Uffe
> > > 
> > > > > +
> > > > > +     if (detached)
> > > > > +             priv->rproc->state = RPROC_DETACHED;
> > > > > +
> > > > >       return ret < 0 ? ret : 0;
> > > > >  }
> > > > >
> > > > > @@ -1146,6 +1160,15 @@ static int imx_rproc_probe(struct platform_device *pdev)
> > > > >               }
> > > > >       }
> > > > >
> > > > > +     if (dcfg->method == IMX_RPROC_SCU_API) {
> > > > > +             pm_runtime_enable(dev);
> > > > > +             ret = pm_runtime_resume_and_get(dev);
> > > > > +             if (ret) {
> > > > > +                     dev_err(dev, "pm_runtime get failed: %d\n", ret);
> > > > > +                     goto err_put_clk;
> > > > > +             }
> > > > > +     }
> > > > > +
> > > > >       ret = rproc_add(rproc);
> > > > >       if (ret) {
> > > > >               dev_err(dev, "rproc_add failed\n");
> > > > > @@ -1171,6 +1194,10 @@ static void imx_rproc_remove(struct platform_device *pdev)
> > > > >       struct rproc *rproc = platform_get_drvdata(pdev);
> > > > >       struct imx_rproc *priv = rproc->priv;
> > > > >
> > > > > +     if (priv->dcfg->method == IMX_RPROC_SCU_API) {
> > > > > +             pm_runtime_disable(priv->dev);
> > > > > +             pm_runtime_put(priv->dev);
> > > > > +     }
> > > > >       clk_disable_unprepare(priv->clk);
> > > > >       rproc_del(rproc);
> > > > >       imx_rproc_put_scu(rproc);
> > > > > --
> > > > > 2.39.5
> > > > >
> > 
> > Best Regards,
> > 
> > Hiago.

