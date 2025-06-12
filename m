Return-Path: <linux-pm+bounces-28562-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00572AD78A2
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 19:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A93101785C3
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 17:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7994298CD2;
	Thu, 12 Jun 2025 17:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6zDjqAF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C9A3596B;
	Thu, 12 Jun 2025 17:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749747948; cv=none; b=OyX91NC63KTai/Z7e8pWMCRaKcYBKG+3YI+QgBe5FdC9w2aH0I2lcBICB05/VT8/ccD1qaXsDWuAeSRjeZU8hw3/SWQm+FCj16CLOrobd9ndmD7zjhrypYggjBxw9oa/KYRM9CFZGbwqJ59NKuhn9MgZvx9rQjRrMHrDSEDu0Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749747948; c=relaxed/simple;
	bh=kp7aEMPbUMSH2lMITFiFi7o0hezza70a/vEZP//T9Nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+YadMxzfOvo9oXMAhgjyz9f9o2f09TXA/q0566SK5Ucbh1CQzpuKqrN82w7lXTsUpMwu3SmssLKZYD5nEL0t8uXSZyQWj6JP/rzQ9VwmQaPvf1w78l9mQzad6aVcP1s3SBt1X5nj3C2XMZAoVm4KuA3JnIrw9R7SkPlOT6swG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6zDjqAF; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3138e64b42aso1347266a91.0;
        Thu, 12 Jun 2025 10:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749747946; x=1750352746; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cNxFg8PxKyiuoizCWNy+6ACkP8PYHeNOWM+dAdRlSGg=;
        b=D6zDjqAFqD+qKGBs6sk0RGDcv78QHYPY4fdReXvhQaO5feXqbw5NAATvIkyqIEVFfU
         5obaTZYUGtx54cDUI4wzsgpOb1Xh4xTzw9mSHsZMWQ1oELJN6y4rdtWtsV2YUQ2UgpjS
         +JV64FQJKldKVO8oXSMxOz5sAi6ccgXSt1bVWD5Zjx3FSwMboCOMs+F7AqSCZfmOTMGZ
         U65KJ9vggMkOl3KdYdC1/ncCB5CAOUPmePfq8Pcr14Tz6tKe+WiHptRd8EvVSwGoAjFs
         Q+vETk6di0jLpaKi/HYvQXRl9XtdVTAfqAk3G72ZtiHPb3IB/JhQDQMgevo1OfA89azE
         MBQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749747946; x=1750352746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cNxFg8PxKyiuoizCWNy+6ACkP8PYHeNOWM+dAdRlSGg=;
        b=aKtMImyBod2rznB7xBc5doWNzyGakqmYE6pgPhqtrutbcd6Fd6oB53T0dYyOngOqIk
         VX8qLfKd5iwnimaTJ5/YY0c37z2TvX4OI4BlYt0LWDX+8yKv1ByAGc/CyKLfQnkauXbx
         xhBTXHYeQddJzwys4pzy1SQeNTzU9K+HNWq77JKI7bUtk2tno5iReYFF7D6LHjYrCDKl
         Kx4iFfUb1ETcKVwrl+E6RgXUEJbLoq3d8Odtq2Q/0sOyPjYQkU2pwRNp7qfIWiR9T71K
         LCNYplDP/aAyZhEPhn8pY3hV+CHB4ns/Fs3MFB1jrhsklmSJk52q1aerqy7JyKx9xNJv
         ge4Q==
X-Forwarded-Encrypted: i=1; AJvYcCU5pIWOJUmvOZXpkLgoTbpG4IlZUTxzILd87/Z2Ckwb3x+szkiTtxLpX5RAYQZDIYkutssEN7RW7hY5blI=@vger.kernel.org, AJvYcCVWHc6nvfrn0uypkJWSDla6D+qpY8pGJHzJDudoDtqCA8MD2z9SQCLlCq+Ws2yebqvuYNYQTFbYqmc=@vger.kernel.org, AJvYcCXBGMb2OBqWeu4NRbmuRsbn7s8+PxfpIl8XMTCOlXCxAxLsE2uqtTbTusFcZ7TgUvdBUoOGMdSoYptcK59MW3+ElQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQg3nXwXxl7cZz+txRrDuR94yV3HNZ07QOMeS8LZKSIt921hxA
	QAa5PgVGwrxDdw0Kmpda2lmOmd0lkzt8oCieLhhaQyBmZpIUA8BgAdPc
X-Gm-Gg: ASbGnct7hQXK3+osjQQOtdDNEADkiGfyOJWW8jaMQyXL7C6Gw4altrDRTsxZsdqq6gH
	f4J8nEFY2AimQwT527CVaSMVUp/tf2A/NpuWE/LrcSmDdFp8lhYpJiH1duktmrndyAsosQOmnkP
	2H24X5QMtE9Q6NWTTnDPtnIcHe+3zz9BSnjed6c3Ch01AzmAfrCPHb1ldYy1pHo/H5WX4jg3MpP
	T5rTLKNrQdEUtmhm/RaTGwfrOXvOMpIRE7G8PTleLxousPEdkZACtfInkjC8AaTbj9way4gA8xG
	bcjgZKq5jU2KanrRoQTZijRp5YZfgn5+jMTjr4L2vGJeY9M9V3yEE8VZdo14
X-Google-Smtp-Source: AGHT+IHhknZBtS5YbF0CJppl2HUlNUSeEzsngrk+Z0OR6pwaGzvadi+iraIcZLg169ex6XW9Mg09aQ==
X-Received: by 2002:a17:90b:2704:b0:313:1e60:584d with SMTP id 98e67ed59e1d1-313af12a2bcmr13383532a91.11.1749747946385;
        Thu, 12 Jun 2025 10:05:46 -0700 (PDT)
Received: from hiago-nb ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c19d2dd0sm1760004a91.17.2025.06.12.10.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 10:05:45 -0700 (PDT)
Date: Thu, 12 Jun 2025 14:05:40 -0300
From: Hiago De Franco <hiagofranco@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Peng Fan <peng.fan@nxp.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
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
Message-ID: <20250612170540.ulflkvws4nty5vz5@hiago-nb>
References: <20250602131906.25751-1-hiagofranco@gmail.com>
 <20250602131906.25751-4-hiagofranco@gmail.com>
 <PAXPR04MB84594F9ABDF0728D9A71FAFE886CA@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <wlcbd6tgwptv25ms2xfpqo5xkfoczg3l5kr6jae6qamdevmvbt@3ikiy7i53qy2>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wlcbd6tgwptv25ms2xfpqo5xkfoczg3l5kr6jae6qamdevmvbt@3ikiy7i53qy2>

Hi Bjorn,

On Wed, Jun 11, 2025 at 10:36:33AM -0500, Bjorn Andersson wrote:
> On Wed, Jun 04, 2025 at 03:19:52AM +0000, Peng Fan wrote:
> > > Subject: [PATCH v4 3/3] remoteproc: imx_rproc: detect and attach to
> > > pre-booted remote cores
> > > 
> > > From: Hiago De Franco <hiago.franco@toradex.com>
> > > 
> > > When the remote core is started before Linux boots (e.g., by the
> > > bootloader), the driver currently is not able to attach because it only
> > > checks for cores running in different partitions. If the core was kicked
> > > by the bootloader, it is in the same partition as Linux and it is already
> > > up and running.
> > > 
> > > This adds power mode verification through dev_pm_genpd_is_on(),
> > > enabling the driver to detect when the remote core is already running
> > > and properly attach to it if all the power domain devices are on.
> > > 
> > > To accomplish this, we need to avoid passing any attach_data or flags
> > > to dev_pm_domain_attach_list(), letting the platform device become a
> > > consumer of the power domain provider. With that the current power
> > > state of the genpds will not change, allowing the detection of the
> > > remote core power state.
> > > 
> > > We enable and sync the device runtime PM during probe to make sure
> > > the power domains are correctly managed when the core is controlled
> > > by the kernel.
> > > 
> > > Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
> > > ---
> > > v4: Changed to use the new dev_pm_genpd_is_on() function instead,
> > > as suggested by Ulf. This will now get the power status of the two
> > > remote cores power domains to decided if imx_rpoc needs to attach or
> > > not. In order to do that, pm_runtime_enable() and
> > > pm_runtime_get_sync() were introduced and pd_data was removed.
> > > v3: Unchanged.
> > > v2: Dropped unecessary include. Removed the imx_rproc_is_on
> > > function, as suggested.
> > > v1:
> > > ---
> > >  drivers/remoteproc/imx_rproc.c | 29 ++++++++++++++++++++++++-----
> > >  1 file changed, 24 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/remoteproc/imx_rproc.c
> > > b/drivers/remoteproc/imx_rproc.c index
> > > 627e57a88db2..6f9680142704 100644
> > > --- a/drivers/remoteproc/imx_rproc.c
> > > +++ b/drivers/remoteproc/imx_rproc.c
> > > @@ -18,6 +18,7 @@
> > >  #include <linux/of_reserved_mem.h>
> > >  #include <linux/platform_device.h>
> > >  #include <linux/pm_domain.h>
> > > +#include <linux/pm_runtime.h>
> > >  #include <linux/reboot.h>
> > >  #include <linux/regmap.h>
> > >  #include <linux/remoteproc.h>
> > > @@ -890,10 +891,8 @@ static int imx_rproc_partition_notify(struct
> > > notifier_block *nb,  static int imx_rproc_attach_pd(struct imx_rproc
> > > *priv)  {
> > >  	struct device *dev = priv->dev;
> > > -	int ret;
> > > -	struct dev_pm_domain_attach_data pd_data = {
> > > -		.pd_flags = PD_FLAG_DEV_LINK_ON,
> > > -	};
> > > +	int ret, i;
> > > +	bool detached = true;
> > > 
> > >  	/*
> > >  	 * If there is only one power-domain entry, the platform driver
> > > framework @@ -902,7 +901,22 @@ static int
> > > imx_rproc_attach_pd(struct imx_rproc *priv)
> > >  	if (dev->pm_domain)
> > >  		return 0;
> > > 
> > > -	ret = dev_pm_domain_attach_list(dev, &pd_data, &priv-
> > > >pd_list);
> > > +	ret = dev_pm_domain_attach_list(dev, NULL, &priv->pd_list);
> > > +	/*
> > > +	 * If all the power domain devices are already turned on, the
> > > remote
> > > +	 * core is already up when the kernel booted (e.g. kicked by
> > > the
> > > +	 * bootloader). In this case attach to it.
> > > +	 */
> > > +	for (i = 0; i < ret; i++) {
> > > +		if (!dev_pm_genpd_is_on(priv->pd_list->pd_devs[i])) {
> > > +			detached = false;
> > > +			break;
> > > +		}
> > > +	}
> > > +
> > > +	if (detached)
> > > +		priv->rproc->state = RPROC_DETACHED;
> > > +
> > >  	return ret < 0 ? ret : 0;
> > >  }
> > > 
> > > @@ -1146,6 +1160,11 @@ static int imx_rproc_probe(struct
> > > platform_device *pdev)
> > >  		}
> > >  	}
> > > 
> > > +	if (dcfg->method == IMX_RPROC_SCU_API) {
> > > +		pm_runtime_enable(dev);
> > > +		pm_runtime_get_sync(dev);
> > 
> > Need put and disable in imx_rproc_remove.
> > 
> 
> Note that you also need to pm_runtime_put() if pm_runtime_get_sync()
> returns an error. So the suggestion is to use the convenience helper
> pm_runtime_resume_and_get() to handle this for you.
> 
> Probably a good idea to check the return value regardless.

Thanks for the review, noted, I can include this in the next version.

> 
> Regards,
> Bjorn
> 
> > BTW: Has this patchset tested with M4 in a separate partition,
> > saying M4 image packed in flash.bin?
> > 
> > Regards,
> > Peng
> > > +	}
> > > +
> > >  	ret = rproc_add(rproc);
> > >  	if (ret) {
> > >  		dev_err(dev, "rproc_add failed\n");
> > > --
> > > 2.39.5
> > > 
> >

Best Regards,
Hiago.

