Return-Path: <linux-pm+bounces-28151-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79455ACF065
	for <lists+linux-pm@lfdr.de>; Thu,  5 Jun 2025 15:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D89303AE2AD
	for <lists+linux-pm@lfdr.de>; Thu,  5 Jun 2025 13:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF3A238151;
	Thu,  5 Jun 2025 13:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqfZibq2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7F8237164;
	Thu,  5 Jun 2025 13:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749129915; cv=none; b=Jhzkzkob+bplhVRj1liEGicq6FwSJ/nV9Pu2++VShfB5P3VFIXqjIEKRlu2BuNW1IG3DB6/NQy1pQjZnJzr5ATaWtpBS8AEJSWzQcwHD72vOwd0HZLIqNdgcljZsx1wJMD7ITqZStnRTmBoyg4AqkJqNEA2BMBDHG0wtfsAqctg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749129915; c=relaxed/simple;
	bh=XCqCr87fMiryN8wBVJwOIxfP6gD+dhX1Z/cb7SASagk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udeuAyWMwkOf3zCX0ZIztSwbJlGRt52/m3mNT6JXIkBDI4vy48c/OxGItPw9JM/wyqWT0v9E8J0g6AobbkTGyuNvoZgOHufvwvCAswUbyVOEqBwYfBM2WHXnFnbjRS55Rt1m3ztlmGhzbUdsTFXot0gtBFXtuW8IM0vJYUCjTIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YqfZibq2; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-74801bc6dc5so850833b3a.1;
        Thu, 05 Jun 2025 06:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749129913; x=1749734713; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FfxhwSOG/RM0gPvUyXeyOo3ZKbVYGqvyCyXESojdWoQ=;
        b=YqfZibq2LHHdvtdoeA7JVN+oxvnJ2hRJR6lK5VflOZOiSdNpZRwUyJ1foqOfoEBGR/
         VShMb6A7k5rz31zVlIzSRsmzIDmiF2OwUzwfV1HGdu74tn9OdpGNAhV5+a1Li/mc5mqn
         z+DEoZJ31U74Bs5rAcXYQiyYpxfD5ikvurw1282fdF8SGKIB4VrJx+rX9qPnq9EC27kj
         gRPVkVFPo9NS19f+tdG79xSSvMCGpQa+XFgvyUAEQJDyEj+v72bjlw3lwFJr6x/jDrLu
         uLkbt1zaEvOg7jCH4SwTMkQsoz3HX5AC1B0w+nGhRiqV3Eqz4EwpNsWiPzeZlxmQR1WQ
         KmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749129913; x=1749734713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FfxhwSOG/RM0gPvUyXeyOo3ZKbVYGqvyCyXESojdWoQ=;
        b=cvocYWCivDMmPwKVwsO+Xup+wZZoIf/+5Yizf2PLYm0LkZlA4FHRBeLU3GOY0VqLzv
         4Ha3ffk46AzDicWBR6rn2aXSLmnhsNK3BLPpBD9d+fe7gp0B8rjWRhkREldycsRVXOQf
         stR7GtxImyQgbj36PHoZeAm9js0ksOBEZ7OHw9KoaYKdyiqFcUmKUX32NMSC+pgIPbKV
         fUE7nBnAGmxJKHoMPFGou0jfqyqgBVDxGdffyGbKZR0amZ2zXtERRg/BwBlSmoq8TrG9
         eAmhE00jEm1gJ9ipzqR/RGXplaQvqDQS8Y7hqXC8lChJdeoWmqU2CjhE+Ih/wJnq7Ow9
         VVMg==
X-Forwarded-Encrypted: i=1; AJvYcCVfuiBMkRsUysY1vMneCVXGFv2eGUtRwfUUjmzMH557Cnzq77B7aAD4JA8JVjmiYpfsG6lxCvuwtsddzK9znTKrHA==@vger.kernel.org, AJvYcCXC0l9UeXN0gWaT4lxfcMbIdFGEfxtCE27gzI//Qbx0uWvMltDGTeWsfpEC8rpqxfnu8P5Qe0Q6NLw=@vger.kernel.org, AJvYcCXjnOQTBRkU/T9HQGD0V4I3+9bxbTxJY1eXUNr1cxZmBQeqMlwtw5ahmR9tz8QB5JCXL2NLM9I+YZ3j+co=@vger.kernel.org
X-Gm-Message-State: AOJu0YypJApCEOc6ezpRPHzWfuqC6Egd3/bHFKezBSMUb9S11kYFTWYk
	E3zbNyzS1QkdaddRlQhSPylIhLyL0kkhk3cdOWPETPkAsfVBjTt2mF7PBpHBKmnA
X-Gm-Gg: ASbGncsOM5ozZlVc+K8Kh0dTBlsGtNeku0VqG8mcXpS0zxsJqvYVAhyO8jcG94o0uNs
	zQKcdKdrZvd42HLPmYgXr3UEmrQkrayVi3bHKVoyPgq7qqtMdHSp/X7FG00QOVnEI0AYOJoOVEw
	EJLhn0wR1+xf2anLUYf8XNuFeihZX59YLcuI4p9/ilAvd+uucPzhjc6sZKeD2/bFgpyQubd+fVN
	0nGeKamlZtOrMJACVejhG9lwRqUZEzUtYRrkrCMzmjcdI4hByt0QdEEsg+lV03wAfDRDn3buHAK
	jtU1Z43BoP9U+AYOHLbx4H4+ekdQNRQZ1rcYZQvEXyg+MpZt1g==
X-Google-Smtp-Source: AGHT+IHQGzKHWpB4RSPbdx58AntCVZ2keB8gOeLail6WPggKiKp/eXtko5QLgS4IoilLjWPFK9AAoA==
X-Received: by 2002:a05:6a00:c83:b0:746:2ae9:fc49 with SMTP id d2e1a72fcca58-748184ab829mr4203417b3a.9.1749129913242;
        Thu, 05 Jun 2025 06:25:13 -0700 (PDT)
Received: from hiago-nb ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afeab79bsm13234842b3a.50.2025.06.05.06.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 06:25:12 -0700 (PDT)
Date: Thu, 5 Jun 2025 10:25:07 -0300
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
Message-ID: <20250605132507.2td5zlnlapraoggn@hiago-nb>
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

Hi Peng,

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

I will add it in a v5, thanks.

> 
> BTW: Has this patchset tested with M4 in a separate partition,
> saying M4 image packed in flash.bin?

Not yet, I will prepare this test today and let you know.

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

