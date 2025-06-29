Return-Path: <linux-pm+bounces-29799-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5A8AECE9E
	for <lists+linux-pm@lfdr.de>; Sun, 29 Jun 2025 18:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AD7B18920B3
	for <lists+linux-pm@lfdr.de>; Sun, 29 Jun 2025 16:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CE823183B;
	Sun, 29 Jun 2025 16:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdLYxxxO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127C05227;
	Sun, 29 Jun 2025 16:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751214225; cv=none; b=GETEYm7Fi225gvWecWgn1uGidXu6VvrnodO6Mjp6Sx0wFKiU0kGtNfNgXzDrOxBvgfW/nlZwdl0efJbASYrWKONE19fUyq3GPq13VQOsAwYE8Cq8Rr95SJdkvCVUEB+2WSPHUQdc9JxzvdLhtnI9KKqvBarD3noqIKv4b28zr8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751214225; c=relaxed/simple;
	bh=JqfaalQqRJu0oypmymEvV6QArJyNK8a8hndEAk5F8Ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2JEDuSiE3vOFIKKMd6oUb+U0hAAiSZXacaP5wZ0RAyn6VBwke62gWG5HVedeZF1nOdOCO7eM9tmkbL/9/SLhQyuQcDQlYcvpSNrckea/xsujqwskK7rjKEWzs94QKc6IOhxh2tV4D7R6IMrTp0ApsfjDfTfscrjaiXrvUdu9CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PdLYxxxO; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6facba680a1so17535076d6.3;
        Sun, 29 Jun 2025 09:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751214223; x=1751819023; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NfieMz5m9Z2E/riszCvxx0vxjw0boZDSxhpy/iJ0gcc=;
        b=PdLYxxxOeogJutLjxDqIWozi+YhodzHf+0iLAvyi9rtXHcotG8KdOCVnnJm6dXYtNa
         +Ebd27O+SgAVWA5BNOv4JlySPsszqu/NMrSR2FBs/nh0CZbpNDaQXRUszy5zd4AMlEJN
         1MHcMiFfhKpXlouxaoRyNRTydamm0E2EvbIy1T6MeXa3HfhU0X2/eltmTwvlbdo6SF6l
         AZjZG/HV6AuHZvSQ2kuRj0mppPqR08sJT0Yufd4+7V9W+yN0KXFRe2BRP0p+fA14sVwU
         v8lALNBBdThwBvyQ3U5xuAY/ms9RztT+Nm3hxeYN0/8btZvza9fG9QxnN1YH5eUP1dHX
         cw9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751214223; x=1751819023;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NfieMz5m9Z2E/riszCvxx0vxjw0boZDSxhpy/iJ0gcc=;
        b=TONwjVbQ+S8BqgC4tRUzmJqIxQMLDT59Rg0D/bZAsZzT5Im7RAGlVtVGat6Qf2NGPi
         l41kNcVXOdoIuA9YhyOi1g+9YFWiDYQBFbci8w1WuC+5boMCthuva5WUSC2L+WVUtCzn
         lr9zICagVD87BNzHItZki3RMRF/CyxlLcsO8pwwOwVOfu+Ncf054KUre+0GIzsY0eiKe
         YCfnLCJ4KlGo8jSui6AIyOm9ot13l6sh1AzyFi6F+Gw8ljqTLvf9ieDdqz73Zt9BQogI
         eCJSjd8Bnp+H1WloQYtpNA5AKUfomUziZ745EKUxAo4eJOBcvSPvf66baJ19hKSZPF0N
         AZbA==
X-Forwarded-Encrypted: i=1; AJvYcCUCbBfTEAxRhmtsB0qsf49e3CJen4UX6BM37VKgOlcm2WgGRWCTlcII1kD7Llknip41tQmnm7+X8/GHTno+c7eD8Q==@vger.kernel.org, AJvYcCUuXrlIyPfUgkilGKnCeUUHeFizCcM4wpKOyZKUkCouvN2BOXVlzmpaluP0+vFxAxeJZMF9sswMVjw=@vger.kernel.org, AJvYcCWmwmlWfXzTvlu9j46buUg+4wWTxuKKE4hOs4Kip8YpprdFshL1nIC4YV0qgTI/oyY1frT/F8ziVGDBOTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YytRqbjvyvHc94YWlTGpB1p5A1Gh/9pcw6GzHDPYs9wwvi9mSSO
	CgDZCw1idqJZMwIefOlLnUVPDUWjYldcIwVbzY8qzLimcyopLt0mEy4B
X-Gm-Gg: ASbGncs3xbR7TGt1lvT77MNCVbEfckKzD80pnMO61slYqw2DE08pwWoKxpJQ9SFxgxY
	SS9H9hf4QPbWlYqzfVmUPO6o6p32vM4h4D93PoGpZM7wlvttiQJGlsVFAFgU6MO49qVhmoDY/G4
	kZCkIqkiV/XTspbLJpUm+qYQ8rmdjv6LcU6gkkNQ8pz0/SSlytFzMvKOGi2f1BoAjzUkUCIaWOF
	ok8ZdGUjXHWAbktYdG4lR7Vcp7ehFgCDHP3gNmAgeYc2sTZ/6MQTdbKwMgMhvD6os9rm9rvKsUo
	KQg4Ara/VkrOdv/pZ9xP1T1EJc6Ps+ToRzsh8w+F2n2QNd7bI8qvV7vH67+B
X-Google-Smtp-Source: AGHT+IESfg0oyaXsV4gGFWt99icXqEwyys8YI4taj0L64tG5xEmVRuFGmG2zMdbH9gxzpEcZWddl/Q==
X-Received: by 2002:ad4:5aaf:0:b0:6fa:d8bb:294c with SMTP id 6a1803df08f44-70002deaefamr184709886d6.14.1751214222731;
        Sun, 29 Jun 2025 09:23:42 -0700 (PDT)
Received: from hiagonb ([2804:1b3:a7c3:c88d:6da3:af6d:a237:3289])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd772e7301sm53047806d6.62.2025.06.29.09.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 09:23:42 -0700 (PDT)
Date: Sun, 29 Jun 2025 13:23:36 -0300
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
	"Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v6 0/3] remoteproc: imx_rproc: allow attaching to running
 core kicked by the bootloader
Message-ID: <20250629162336.tazeqojyhtgnecmw@hiagonb>
References: <20250626215911.5992-1-hiagofranco@gmail.com>
 <CANLsYkzo32BHkxRzSLY1U_PcidMPOaz7xZjDs8HKtTCQ0ZpF=g@mail.gmail.com>
 <20250627144955.tbmk6ako3rgv3djo@hiagonb>
 <CANLsYkz3SD1PPnVwoBnnKhyCUig67o+=NgoDucq5m+4sQ=xMYQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYkz3SD1PPnVwoBnnKhyCUig67o+=NgoDucq5m+4sQ=xMYQ@mail.gmail.com>

On Fri, Jun 27, 2025 at 09:40:27AM -0600, Mathieu Poirier wrote:
> On Fri, 27 Jun 2025 at 08:50, Hiago De Franco <hiagofranco@gmail.com> wrote:
> >
> > On Fri, Jun 27, 2025 at 08:31:20AM -0600, Mathieu Poirier wrote:
> > > On Thu, 26 Jun 2025 at 15:59, Hiago De Franco <hiagofranco@gmail.com> wrote:
> > > >
> > > > From: Hiago De Franco <hiago.franco@toradex.com>
> > > >
> > > > This patch series depends on Ulf's patches that are currently under
> > > > review, "pmdomain: Add generic ->sync_state() support to genpd" [1].
> > > > Without them, this series is not going to work.
> > > >
> > >
> > > I thought we agreed to repost when the feature referred to above and
> > > the work in drivers/pmdomain/core.c will be merge.  I'm not sure what
> > > to do with this patchset.
> >
> > Sorry Mathieu, my goal was to update the whole patch series with your
> > reviews from v5 so you could take a look and then I would resend
> > everything again once the others have been merged.
> >
> 
> Ok, I'll take a look next week.

Thanks, I will be sending v7 with the missing reviewed-by then.

Best regards,
Hiago.

> 
> > If you prefer I can wait for the other patches to be merged and then
> > send the next v7 corrected.
> >
> > Best regards,
> > Hiago.
> >
> > >
> > > > For the i.MX8X and i.MX8 family SoCs, currently when the remotecore is
> > > > started by the bootloader and the M core and A core are in the same
> > > > partition, the driver is not capable to detect the remote core and
> > > > report the correct state of it.
> > > >
> > > > This patch series implement a new function, dev_pm_genpd_is_on(), which
> > > > returns the power status of a given power domain (M core power domains
> > > > IMX_SC_R_M4_0_PID0 and IMX_SC_R_M4_0_MU_1A in this case). If it is
> > > > already powered on, the driver will attach to it.
> > > >
> > > > Finally, the imx_rproc_clk_enable() function was also changed to make it
> > > > return before dev_clk_get() is called, as it currently generates an SCU
> > > > fault reset if the remote core is already running and the kernel tries
> > > > to enable the clock again. These changes are a follow up from a v1 sent
> > > > to imx_rproc [2] and from a reported regression [3].
> > > >
> > > > [1] https://lore.kernel.org/all/20250523134025.75130-1-ulf.hansson@linaro.org/
> > > > [2] https://lore.kernel.org/lkml/20250423155131.101473-1-hiagofranco@gmail.com/
> > > > [3] https://lore.kernel.org/lkml/20250404141713.ac2ntcsjsf7epdfa@hiago-nb/
> > > >
> > > > v6:
> > > > - Added "reviewed by" from Ulf and Bjorn.
> > > > - Fixed and improved commit descriptions of patches 2 and 3.
> > > > - Improved the comment inside imx_rproc.c file.
> > > > v5:
> > > > - https://lore.kernel.org/all/20250617193450.183889-1-hiagofranco@gmail.com/
> > > > v4:
> > > > - https://lore.kernel.org/lkml/20250602131906.25751-1-hiagofranco@gmail.com/
> > > > v3:
> > > > - https://lore.kernel.org/all/20250519171514.61974-1-hiagofranco@gmail.com/
> > > > v2:
> > > > - https://lore.kernel.org/lkml/20250507160056.11876-1-hiagofranco@gmail.com/
> > > > v1:
> > > > - https://lore.kernel.org/lkml/20250505154849.64889-1-hiagofranco@gmail.com/
> > > >
> > > > Hiago De Franco (3):
> > > >   pmdomain: core: introduce dev_pm_genpd_is_on()
> > > >   remoteproc: imx_rproc: skip clock enable when M-core is managed by the
> > > >     SCU
> > > >   remoteproc: imx_rproc: detect and attach to pre-booted remote cores
> > > >
> > > >  drivers/pmdomain/core.c        | 33 +++++++++++++++++++++++++++
> > > >  drivers/remoteproc/imx_rproc.c | 41 ++++++++++++++++++++++++++++------
> > > >  include/linux/pm_domain.h      |  6 +++++
> > > >  3 files changed, 73 insertions(+), 7 deletions(-)
> > > >
> > > > --
> > > > 2.39.5
> > > >

