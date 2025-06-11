Return-Path: <linux-pm+bounces-28495-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AAFAD5ACE
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 17:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1538C18825ED
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 15:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E911D130E;
	Wed, 11 Jun 2025 15:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVbcNRxg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342581C863B;
	Wed, 11 Jun 2025 15:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749656198; cv=none; b=nnSFGR8tO4mN9e0Z+5aVRpgkZF7kR4cKVCxP5Ii4bDdZDbBLNVG4STOPt4KNv+XdAAk69R0axKwI9YW34DRLqvAVc7NaSDjI8JFJ0VVLjbJJa9zk9HHUB/tN707kayYX3OsfxJ4FKZ5h7twZoyn6FXRFQeo4UZK2YRuJXu55za0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749656198; c=relaxed/simple;
	bh=LyVLCRHuClsXY5dOkj29N2LMCsbwRgq0yNd8xOudTmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFKJk09AXgEbztltKQpy/k12i+vYNzkXbHlEF/zbQ3nOi85RDaibcLM/6jKBvinzAyN9j+ZzQsJXv8N9jM2YwAbKZn2qEhhfZLfwh+Z9LtwFlCqk4u55S6D8hofiZWbZSIrsmNyrZz9YToEgsM1ZLhhkYGv8HdrdUtQB/ZnfaDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVbcNRxg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9C3C4CEE3;
	Wed, 11 Jun 2025 15:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749656196;
	bh=LyVLCRHuClsXY5dOkj29N2LMCsbwRgq0yNd8xOudTmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KVbcNRxg/ExhHdo55MEUt8LWVxUyul1jmU7fWCbI2Mywv/tZ402qVZosE7+1CqCOp
	 LFequLsoy/u33gyfKjKN8Vtw/CKeqrRFZTWThzCaPLwYmKOzqTLALOJ0WWecGpWm5W
	 nxcwwUdaXZLlX8a00582ZCTGOqSDL8F3PSxckujyt2eROlaDeVhccbCa+FFBWodgNE
	 I5HzZLSmPeukiMRLtmHuZWxIiQVTOSMnpLncP1zTJOg2h6ZMf/PdiLSORClMpP9AZF
	 fCsfEehmdNqW/02lyfvpAKOVOAEH2+kwCYUlq7uK9CWUePIduifG8uia6Crqx9Q37L
	 z/pKJuYS6TM4g==
Date: Wed, 11 Jun 2025 10:36:33 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Peng Fan <peng.fan@nxp.com>
Cc: Hiago De Franco <hiagofranco@gmail.com>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Hiago De Franco <hiago.franco@toradex.com>, 
	"imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>, 
	"Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>, "Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 3/3] remoteproc: imx_rproc: detect and attach to
 pre-booted remote cores
Message-ID: <wlcbd6tgwptv25ms2xfpqo5xkfoczg3l5kr6jae6qamdevmvbt@3ikiy7i53qy2>
References: <20250602131906.25751-1-hiagofranco@gmail.com>
 <20250602131906.25751-4-hiagofranco@gmail.com>
 <PAXPR04MB84594F9ABDF0728D9A71FAFE886CA@PAXPR04MB8459.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB84594F9ABDF0728D9A71FAFE886CA@PAXPR04MB8459.eurprd04.prod.outlook.com>

On Wed, Jun 04, 2025 at 03:19:52AM +0000, Peng Fan wrote:
> > Subject: [PATCH v4 3/3] remoteproc: imx_rproc: detect and attach to
> > pre-booted remote cores
> > 
> > From: Hiago De Franco <hiago.franco@toradex.com>
> > 
> > When the remote core is started before Linux boots (e.g., by the
> > bootloader), the driver currently is not able to attach because it only
> > checks for cores running in different partitions. If the core was kicked
> > by the bootloader, it is in the same partition as Linux and it is already
> > up and running.
> > 
> > This adds power mode verification through dev_pm_genpd_is_on(),
> > enabling the driver to detect when the remote core is already running
> > and properly attach to it if all the power domain devices are on.
> > 
> > To accomplish this, we need to avoid passing any attach_data or flags
> > to dev_pm_domain_attach_list(), letting the platform device become a
> > consumer of the power domain provider. With that the current power
> > state of the genpds will not change, allowing the detection of the
> > remote core power state.
> > 
> > We enable and sync the device runtime PM during probe to make sure
> > the power domains are correctly managed when the core is controlled
> > by the kernel.
> > 
> > Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
> > ---
> > v4: Changed to use the new dev_pm_genpd_is_on() function instead,
> > as suggested by Ulf. This will now get the power status of the two
> > remote cores power domains to decided if imx_rpoc needs to attach or
> > not. In order to do that, pm_runtime_enable() and
> > pm_runtime_get_sync() were introduced and pd_data was removed.
> > v3: Unchanged.
> > v2: Dropped unecessary include. Removed the imx_rproc_is_on
> > function, as suggested.
> > v1:
> > ---
> >  drivers/remoteproc/imx_rproc.c | 29 ++++++++++++++++++++++++-----
> >  1 file changed, 24 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/remoteproc/imx_rproc.c
> > b/drivers/remoteproc/imx_rproc.c index
> > 627e57a88db2..6f9680142704 100644
> > --- a/drivers/remoteproc/imx_rproc.c
> > +++ b/drivers/remoteproc/imx_rproc.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/of_reserved_mem.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/pm_domain.h>
> > +#include <linux/pm_runtime.h>
> >  #include <linux/reboot.h>
> >  #include <linux/regmap.h>
> >  #include <linux/remoteproc.h>
> > @@ -890,10 +891,8 @@ static int imx_rproc_partition_notify(struct
> > notifier_block *nb,  static int imx_rproc_attach_pd(struct imx_rproc
> > *priv)  {
> >  	struct device *dev = priv->dev;
> > -	int ret;
> > -	struct dev_pm_domain_attach_data pd_data = {
> > -		.pd_flags = PD_FLAG_DEV_LINK_ON,
> > -	};
> > +	int ret, i;
> > +	bool detached = true;
> > 
> >  	/*
> >  	 * If there is only one power-domain entry, the platform driver
> > framework @@ -902,7 +901,22 @@ static int
> > imx_rproc_attach_pd(struct imx_rproc *priv)
> >  	if (dev->pm_domain)
> >  		return 0;
> > 
> > -	ret = dev_pm_domain_attach_list(dev, &pd_data, &priv-
> > >pd_list);
> > +	ret = dev_pm_domain_attach_list(dev, NULL, &priv->pd_list);
> > +	/*
> > +	 * If all the power domain devices are already turned on, the
> > remote
> > +	 * core is already up when the kernel booted (e.g. kicked by
> > the
> > +	 * bootloader). In this case attach to it.
> > +	 */
> > +	for (i = 0; i < ret; i++) {
> > +		if (!dev_pm_genpd_is_on(priv->pd_list->pd_devs[i])) {
> > +			detached = false;
> > +			break;
> > +		}
> > +	}
> > +
> > +	if (detached)
> > +		priv->rproc->state = RPROC_DETACHED;
> > +
> >  	return ret < 0 ? ret : 0;
> >  }
> > 
> > @@ -1146,6 +1160,11 @@ static int imx_rproc_probe(struct
> > platform_device *pdev)
> >  		}
> >  	}
> > 
> > +	if (dcfg->method == IMX_RPROC_SCU_API) {
> > +		pm_runtime_enable(dev);
> > +		pm_runtime_get_sync(dev);
> 
> Need put and disable in imx_rproc_remove.
> 

Note that you also need to pm_runtime_put() if pm_runtime_get_sync()
returns an error. So the suggestion is to use the convenience helper
pm_runtime_resume_and_get() to handle this for you.

Probably a good idea to check the return value regardless.

Regards,
Bjorn

> BTW: Has this patchset tested with M4 in a separate partition,
> saying M4 image packed in flash.bin?
> 
> Regards,
> Peng
> > +	}
> > +
> >  	ret = rproc_add(rproc);
> >  	if (ret) {
> >  		dev_err(dev, "rproc_add failed\n");
> > --
> > 2.39.5
> > 
> 

