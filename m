Return-Path: <linux-pm+bounces-26740-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C31F5AAC95A
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 17:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91B741C2749D
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 15:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C8C2857FC;
	Tue,  6 May 2025 15:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UJ8pQsTh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EB6284696
	for <linux-pm@vger.kernel.org>; Tue,  6 May 2025 15:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746544900; cv=none; b=hbxWB4ckUIRG1RIxYO5brvcooesW8RcKmZ26aSeHX/TaQMNI7o91YiQp3xHjkMTPSumGJ1bHOStm8+PbRcKEJ3ZYq9+i2XfmkgvRmzeLulbZ32Ui4t/bWvkLAk1Np5VetHBrFLlMHhD6HWf6tU3pRd+W5DjNuKziHpHPKLhVWDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746544900; c=relaxed/simple;
	bh=RrFCrLCDb2vVGDp7qDTtvDgB7VhO8TX1bChwTPYRekQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f34C4pX4oxM/n7jsybnZVJzhzeicfvMR9KEVSg0oow7cReUZ13gq/8+n7iezinV4+PsaUzpAGfYEtFLOM+oOz7Rrue6Ko2n0eIWUDzv4ae9+EYMsU3VRhtoSMjIBEm6KSBU6rLZ+zbExA37XDduta3jUYCVMpRz2NYxjEcN2HrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UJ8pQsTh; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22438c356c8so58127735ad.1
        for <linux-pm@vger.kernel.org>; Tue, 06 May 2025 08:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746544897; x=1747149697; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LUMMAqzLfeU2BhLtLW4k1zZhIkqrr7YldwnF+3gqRqE=;
        b=UJ8pQsThEqTqAkNZ7+wvythibhM6QLHad1B5K0qbZotRMUU9Er+gvGohjeMEZN6iq2
         y/+Pno2UB+mNvg70PK5nSJuN4Dayhcn5eQCoeO7iLIr2PLudktmaY1EF9VTKBJqjmv2H
         Egh65+L0t2Lomwbu2fJ3S8qqvoB338zUaCGsx/O9eS1kAsC2IYbcn30TQST+A8/jgKrU
         xkE5WVEYRmGUKDp0VVdciWsANguEYGzqrVnstf3+DXAnt0+tfo9g1lodhWgR4TcstmvV
         KFGObojl0fiMczJHycmx3HFOzJEQfcZ0QtQHWStSIcO75UFLu/+rUxV86gL1G6YkIFpM
         v/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746544897; x=1747149697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUMMAqzLfeU2BhLtLW4k1zZhIkqrr7YldwnF+3gqRqE=;
        b=hmPQ9cSOdQ7IOctEJWd6aYDXL0y/95f/8q8i84AS/F9yHQN/ag5FOUP8o3RDqf09tn
         +qMpm7kvQbv0mdct8//3Mtw3qt3a6box/8/xwWjRFaUHWJVNCO4N2BdaRgrlxvXNzHSz
         dvpCn/8Nf6tyj2yGjlOyajHp5tqs93fZLCsbxaLLr7hE3plOuHqIhOqISNw8wv2FSV3q
         kJ/VJXuCvbbM/y44m1uhzZLTUzJgTsoSqVJs6nraf1u74bmgEVyNQ1pko5Aty6X5hXuO
         2JGLlRLg9XSuMFVy7kmHCaGDSueJMzpkM2pG7Hk1JdZlMMkxaq5P8jzg5zl4zw2ltCv8
         wtCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKXz/qwb4Pg2K9s/haorhCgszI0qwJt4fDTEz4qAQo8z5yUD7jKBKMU53DO01kve0X2RFwxK2uEg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFtGVQq/bVN1Sgkco2Brjs+esJviIclfAa0vR+lVMXkHM7guTZ
	0xLqx59V2rHBbDftnH+xIedUAe5CfCa/OTwRYSbI/7pUMptaGSM+LTfmu5N5ahKrglXTeg9NUxG
	Z
X-Gm-Gg: ASbGncsr/obPARU9CYPLjZPZBNOU7qV3uCZc5YRP83J1fLO3ionFqU8SfUkPsMfALO6
	h4nLVmgqXFDV1d1cFb86pu8BNqMtN38vydqT4OpYus0XS3otAN3DFiLdl88t5jRxX8AEQuSgXRs
	8QENqmsTy4lv3pMIb0O7ACrK85fjn8NCa6rAQxV/sVm9VLsYcTRg93tXQYBzUiw2ccGCyiHgr11
	wuhYTL1F1gwdPbT5gdQGJ42Kpgh93Lnzrc3sk2Um8iRzvfwNcFYNk6qTsYjPiXniDsf3Pf0rbCE
	zVS0wuUFA2M1jasg1LZ+NGrOS3Jv8axAC9M5QBCq6Q==
X-Google-Smtp-Source: AGHT+IG9qR+Bw2uygv8xQSXKT77iYKR8E4JwPxPN+b6XzkhfQ8z4EFuMOu2q9YdcGCpJtb1y5nY+aw==
X-Received: by 2002:a17:902:d40b:b0:22e:4a2e:8ae7 with SMTP id d9443c01a7336-22e4a2e9073mr19297995ad.22.1746544897093;
        Tue, 06 May 2025 08:21:37 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:fc7c:b927:d229:c0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e15232224sm75295875ad.253.2025.05.06.08.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 08:21:36 -0700 (PDT)
Date: Tue, 6 May 2025 09:21:34 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Hiago De Franco <hiagofranco@gmail.com>
Cc: Peng Fan <peng.fan@oss.nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Hiago De Franco <hiago.franco@toradex.com>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	daniel.baluta@nxp.com, iuliana.prodan@oss.nxp.com,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH 1/3] remoteproc: imx_rproc: skip clock enable when M-core
 is managed by the SCU
Message-ID: <aBoo_p1KlmOieJ50@p14s>
References: <20250505154849.64889-1-hiagofranco@gmail.com>
 <20250505154849.64889-2-hiagofranco@gmail.com>
 <20250506043835.GB24259@nxa18884-linux>
 <20250506123619.egobussm6b74imso@hiago-nb>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506123619.egobussm6b74imso@hiago-nb>

On Tue, May 06, 2025 at 09:36:19AM -0300, Hiago De Franco wrote:
> Hi Peng,
> 
> On Tue, May 06, 2025 at 12:38:35PM +0800, Peng Fan wrote:
> > On Mon, May 05, 2025 at 12:48:47PM -0300, Hiago De Franco wrote:
> > >From: Hiago De Franco <hiago.franco@toradex.com>
> > >
> > >For the i.MX8X and i.MX8 family SoCs, when the M-core is powered up
> > >before Linux starts (e.g., by the bootloader) and it is being managed by
> > >the SCU, the SCFW will not allow the kernel to enable the clock again.
> > >This currently causes an SCU fault reset when the M-core is up and
> > >running and the kernel boots, resetting the system.
> > >
> > >Therefore, add a check in the clock enable function to not execute it if
> > >the M-core is being managed by the SCU.
> > >
> > >This change affects only the i.MX8X and i.MX8 family SoCs, as this is
> > >under the IMX_RPROC_SCU_API method.
> > 
> > I would rewrite as below: "
> > 
> > For the i.MX8X and i.MX8 family SoCs, when the M-core is powered up
> > by the bootloader, M-core and Linux are in same SCFW(System Controller
> > Firmware) partition, so linux has permission to control M-core.
> > 
> > But when M-core is started, the SCFW will automatically enable the clock
> > and configure the rate, and any users that wanna to enable the clock
> > will get error 'LOCKED' from SCFW. So current imx_rproc.c probe function
> > gets failure because clk_prepare_enable returns failure. Then
> > the power domain of M-core is powered off when M-core is still running,
> > SCU(System Controller Unit) will get a fault reset, and system restarts.
> > 
> > To address the issue, ignore handling the clk for i.MX8X and i.MX8 M-core,
> > because SCFW automatically enables and configures the clock.
> > "
> > 
> > You may update if you wanna.
> > 
> > >
> > >Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
> > >Suggested-by: Peng Fan <peng.fan@oss.nxp.com>
> > 
> > -> peng.fan@nxp.com
> 
> Thanks for the review, I will update the suggestions on a v2. Meanwhile,
> I will wait a little bit for other feedbacks.
>

I suggest you go ahead with a v2 - I have a fair amount of patches to review and
my time to do so is currently very limited.

> > 
> > Thanks,
> > Peng
> > 
> > >---
> > > drivers/remoteproc/imx_rproc.c | 4 ++--
> > > 1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > >diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> > >index 74299af1d7f1..627e57a88db2 100644
> > >--- a/drivers/remoteproc/imx_rproc.c
> > >+++ b/drivers/remoteproc/imx_rproc.c
> > >@@ -1029,8 +1029,8 @@ static int imx_rproc_clk_enable(struct imx_rproc *priv)
> > > 	struct device *dev = priv->dev;
> > > 	int ret;
> > > 
> > >-	/* Remote core is not under control of Linux */
> > >-	if (dcfg->method == IMX_RPROC_NONE)
> > >+	/* Remote core is not under control of Linux or it is managed by SCU API */
> > >+	if (dcfg->method == IMX_RPROC_NONE || dcfg->method == IMX_RPROC_SCU_API)
> > > 		return 0;
> > > 
> > > 	priv->clk = devm_clk_get(dev, NULL);
> > >-- 
> > >2.39.5
> > >
> 
> Cheers,
> Hiago.

