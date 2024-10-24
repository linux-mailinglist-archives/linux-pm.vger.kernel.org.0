Return-Path: <linux-pm+bounces-16371-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 495A79AE337
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 13:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78DF11C225D9
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 11:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F2B1CACD9;
	Thu, 24 Oct 2024 11:01:31 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722401C879E
	for <linux-pm@vger.kernel.org>; Thu, 24 Oct 2024 11:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729767691; cv=none; b=jlPXuJax7Kq3Wsf3V+MwDJYxgDPeK1+lQ2TJce5bJRK+qe2pifAM5Q9QuB+KmbNJr5KLKcrH6INhDN7KZNs/LQgO7Qsw51ipFpXHWjQQa2PSLaeXnAVPdaqf3oIiLyt1wPLKJFP10VU1Zn1WLb4tKAJ1JELuPeR0R27Zq/zrX2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729767691; c=relaxed/simple;
	bh=GcsY4DwdXEo2baKa3bEnLz1/qW8Bmj1ZyGI6hMV6xmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLFHSbNGfOTJLZVw8JYo39aGWH/G2l0bCA4wTeHWmje8vxTAfa5NYjJDPl+0vlW5nAha2hSwTNWW9Z+5zz5bvu5rT3y985RnJVAQAjdJ58Gva7r9YAG2+xN1H5GDy/2cFYyv8hVhwHOCmaW6/WI0//0OyYrNQm041OsrITQm//E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1t3val-0007iV-Rm; Thu, 24 Oct 2024 13:01:23 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1t3val-000BRi-1m;
	Thu, 24 Oct 2024 13:01:23 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1t3val-00B9fo-1P;
	Thu, 24 Oct 2024 13:01:23 +0200
Date: Thu, 24 Oct 2024 13:01:23 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Michael Trimarchi <michael@amarulasolutions.com>,
	linux-pm@vger.kernel.org, linux-amarula@amarulasolutions.com,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pmdomain: imx: gpcv2: replace dev_err() with
 dev_err_probe()
Message-ID: <20241024110123.wix35njjbh3nx7kn@pengutronix.de>
References: <20241024103540.3482216-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024103540.3482216-1-dario.binacchi@amarulasolutions.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

Hi Dario,

thanks for the patch.

On 24-10-24, Dario Binacchi wrote:
> The patch standardizes the probe() code by replacing the two occurrences
> of dev_err() with dev_err_probe(). Indeed, dev_err_probe() was used in all
> other error paths of the probe() function.

I assume that this paths aren't using dev_err_probe because these paths
can't return EPROBE_DEFER and therefore dev_err_probe() would use
dev_err() anyway.

Regards,
  Marco

> Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> 
> ---
> 
>  drivers/pmdomain/imx/gpcv2.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pmdomain/imx/gpcv2.c b/drivers/pmdomain/imx/gpcv2.c
> index 963d61c5af6d..6e6ecbf2e152 100644
> --- a/drivers/pmdomain/imx/gpcv2.c
> +++ b/drivers/pmdomain/imx/gpcv2.c
> @@ -1356,7 +1356,7 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
>  
>  	ret = pm_genpd_init(&domain->genpd, NULL, true);
>  	if (ret) {
> -		dev_err(domain->dev, "Failed to init power domain\n");
> +		dev_err_probe(domain->dev, ret, "Failed to init power domain\n");
>  		goto out_domain_unmap;
>  	}
>  
> @@ -1367,7 +1367,7 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
>  	ret = of_genpd_add_provider_simple(domain->dev->of_node,
>  					   &domain->genpd);
>  	if (ret) {
> -		dev_err(domain->dev, "Failed to add genpd provider\n");
> +		dev_err_probe(domain->dev, ret, "Failed to add genpd provider\n");
>  		goto out_genpd_remove;
>  	}
>  
> -- 
> 2.43.0
> 
> 
> 

