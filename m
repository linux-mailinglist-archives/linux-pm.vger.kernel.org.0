Return-Path: <linux-pm+bounces-28312-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23288AD24F8
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 19:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE646189092E
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 17:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A5B21ADA3;
	Mon,  9 Jun 2025 17:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgvxpeAp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9500C3597B;
	Mon,  9 Jun 2025 17:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749490286; cv=none; b=dhcK/nqs8d21I6O5bI9mpK31IvDyUeVWraBuo0CuaugsVOlZ2tdF2gj5osk8w+tPMP3HHotMqiWtl6dV4n2OqsIhCIZrbkzFb30xFM+YkLzoxxtnKp+D9Z0jrB0bK3BylVkhodBb038d04olUYUIjMsCuDsuK45cvv0Qhzca9C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749490286; c=relaxed/simple;
	bh=8LBJLyj0kgr4c05PRceO/pKC3cvZqpYuU4UKLWl6TZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPkX9lp0PBDRv0isXnwsBibJ0WRw9ojgcDG4LbiGv9QcXE69hKmdgMK+HqaNjYnoKXvZhA1Atz3DnR/9YK38qJn9G0bgVXwUEq6X/q5XoV7PMerTSWpLt9WTjxZU+IEo23IG+9E8NstXHGUsoRO4FlEQCG0I220My1NqD+5VQY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PgvxpeAp; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-53082f1ac34so1348428e0c.3;
        Mon, 09 Jun 2025 10:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749490283; x=1750095083; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v0Qu66z7kDW3js03KQPZ0HZb8QpcE1+x1gXTQ8PQnaU=;
        b=PgvxpeApqp67C7bN8eeiv94rxHScde6hMQvz2XZYeFIacPXfNtOVFGCLuZ5XjebKUa
         M52u4JkMTyY9uRlZlJjmAac0RgYLxxF3JO4UxlGipguvcSlmucYLW/iE5zGthQVBz/bZ
         F6U/td8CXYbHW2bsBhEO1pHHEDngcJUMANKCrl8wjuCGoxfw0Q3Hirwcce09siI8wBHm
         WtEDxAQarK5Fg45wcQ5ARI6aYqULgQI72dN0hlAM2HaZ0Wkl1WLVAhmJezjj+4pzvoB6
         1KJ31ZoFxRSiklelF40rR6mFG0gyJSPUrysDy8b92CATCgNRFjxMHNHVyBOl5mAZQlEf
         z0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749490283; x=1750095083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0Qu66z7kDW3js03KQPZ0HZb8QpcE1+x1gXTQ8PQnaU=;
        b=SY9sPR206OFCQVeNhOA9ytiZhWNpgeCCf4hazBE97umfWYlIEZorSQVuibwY2/wy99
         GjlTKrUtQS0Qajhaa4K4aHqOC3EV1iu4J37dXCfaLBq6lfDmGN4Ih1gsmf1KDZNV2F0G
         I3xoNgOZzhyXcnNFZ3ZZW4sqQDhxsluzx514x/dJb4kULNS+0aH0cNHzdr7sz7APKkNJ
         e/izk8lbEJoyabCOTa6qQq7mkSNKoGrB91kbq7h0UuzP3lh5Qyc5c57rNElGLBKn7klN
         fxw+/o45KByx1j7oqpERItRhH7dSWaI31hPZQEaAw8f63vjyoPSSdJhFLaMC+osxHhux
         BM5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUPu0EeGPrgJ4b0Mc+BWLoJDvLiiDDtf7omj9CDJ4HwHxQbRuurVQ/6Ih0IVXrwd3AAd+urjEGq8JU=@vger.kernel.org, AJvYcCVlv+Se5w+1AQpyiqvsz2c91rEh9BqARbd1B6hJTyE9lyLZjKpaPV5ZTIDbLynmEFCv+sn3sXJTZjLLLZc=@vger.kernel.org, AJvYcCX/uTjYHuM91aegToey7JgsripJCJiqG14BZX/vi1la56ozMq9rKTrAQBSKKN6akxhAyhCPeoaEYw4Ea0Zkln4OGw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKD5ljoIQnrnHj0EeA7Bk5MSVI7h3cqX/VLZuyF5aRPkvl7Dge
	0X892W/ya8eQTu6DvdNwWlXaIZVlFFf+0TTQFzfIvJQ0D/sNYqTA+zan
X-Gm-Gg: ASbGncsuGDX+t8yLYGcngynCVa1GFiOOPahL7vXwDw/iBjQIoG6wp728JxgbvrpCliQ
	c8iTSaYTOuxR6RzeX0kL1F+FMOLW+FXdFrZ9VlseTmbjjxhW/hNDjNpusK1adaKCN3/dl5fbqr+
	5D+pwHwPu7M+BgtTSBpppNM1eJh7ak5bMwx1AFyY+Y6SEx1ZiVKQRUFh3dh5d4WSoC+c1N13mZL
	MXTbxzID7n40nT6sdIvOsjEQ+U1/BWZANX1bVwEkSE+tI294Xs95oea1LoEl/D7X/uRTkhQZ98c
	A2SD/v8cm7bOA9jZFx9lMRTyp4atHRQzlsvCVaKuGz/pvug8QQ==
X-Google-Smtp-Source: AGHT+IGzoebj1QMPet5l8I9qWvt9vrbw2pGLKm4WGcWKCZt5wa18t6jdZYC5Lc1lX0z+RxP/znejvw==
X-Received: by 2002:a05:6122:8d1:b0:52b:789:2d0 with SMTP id 71dfb90a1353d-530e47ed0a2mr11738050e0c.5.1749490282233;
        Mon, 09 Jun 2025 10:31:22 -0700 (PDT)
Received: from hiago-nb ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53113abd74bsm32564e0c.17.2025.06.09.10.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 10:31:21 -0700 (PDT)
Date: Mon, 9 Jun 2025 14:31:15 -0300
From: Hiago De Franco <hiagofranco@gmail.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Hiago De Franco <hiago.franco@toradex.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	"Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 3/3] remoteproc: imx_rproc: detect and attach to
 pre-booted remote cores
Message-ID: <20250609173115.qecc2noswkcgr3hm@hiago-nb>
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
> BTW: Has this patchset tested with M4 in a separate partition,
> saying M4 image packed in flash.bin?

Sorry for the delay.

I tested it now and there must be something missing on my U-Boot:

Disable imx8x-cm4 rsrc 278 not owned
Disable imx8x-cm4 rsrc 297 not owned

It removes my nodes from the DT before starting the kernel, so I cannot
attach. Do you know what should I do in this case?

But apart from that, at least the imx-rproc does not crash or anything.

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

Best Regards,
Hiago.

