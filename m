Return-Path: <linux-pm+bounces-11985-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAFB94B68E
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 08:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE5AC1C23780
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 06:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E681186E51;
	Thu,  8 Aug 2024 06:14:20 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9138780C13
	for <linux-pm@vger.kernel.org>; Thu,  8 Aug 2024 06:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723097660; cv=none; b=LLHwHPPZgGkeKDptqaXYvxK8++EM+rcjDjKKJxD4aVdTqfLnt++IC0PXu4pb/tjZnISDEJg2ckld9kB8mLHEa/Dzt1akbAO78xlBkAMrR+BjJdaATqcvVI3UPumt5qt/pRPSMcob/M2bdrsMDfopoCU2y9/Z/UDWV6Qq6XdXMR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723097660; c=relaxed/simple;
	bh=dyLsuPqyeZzNUJbhqvbGSbaM4TIzEGc6CNQB3Rd3Ps4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWlKubcSzDD+3lt374Z4yQ9DMWgNPozCTtitBDEeyYYl2zQIjPTciD5QkdXwYY6XJUnNyC3UkLIfhtIgdXHbJ41iA6ZmZiV4Hi6ek3HTzGg6mPqzLeTiYPal6SrzHd5blmWgCSQdHbbAXla+0w07BDekpOXyJGw1nvv078EGeBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1sbwPT-0001mE-IF; Thu, 08 Aug 2024 08:14:03 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1sbwPR-005MVO-Of; Thu, 08 Aug 2024 08:14:01 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1sbwPR-008kur-24;
	Thu, 08 Aug 2024 08:14:01 +0200
Date: Thu, 8 Aug 2024 08:14:01 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Ma Ke <make24@iscas.ac.cn>
Cc: ulf.hansson@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, geert+renesas@glider.be,
	arnd@arndb.de, peng.fan@nxp.com, u.kleine-koenig@pengutronix.de,
	marex@denx.de, benjamin.gaignard@collabora.com, imx@lists.linux.dev,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] soc: imx: imx8m-blk-ctrl: Fix NULL pointer dereference
Message-ID: <20240808061401.eanpuelc4evnll5m@pengutronix.de>
References: <20240808042858.2768309-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808042858.2768309-1-make24@iscas.ac.cn>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

Hi Ma,

On 24-08-08, Ma Ke wrote:
> Check bc->bus_power_dev = dev_pm_domain_attach_by_name() return value using
> IS_ERR_OR_NULL() instead of plain IS_ERR(), and fail if bc->bus_power_dev 
> is either error or NULL.
> 
> In case a power domain attached by dev_pm_domain_attach_by_name() is not
> described in DT, dev_pm_domain_attach_by_name() returns NULL, which is
> then used, which leads to NULL pointer dereference.

the same comment I wrote previously applies to this patch.

Regards,
  Marco

> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: 1a1da28544fd ("soc: imx: imx8m-blk-ctrl: Defer probe if 'bus' genpd is not yet ready")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>  drivers/pmdomain/imx/imx8m-blk-ctrl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> index ca942d7929c2..d46fb5387148 100644
> --- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> +++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> @@ -212,7 +212,7 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	bc->bus_power_dev = dev_pm_domain_attach_by_name(dev, "bus");
> -	if (IS_ERR(bc->bus_power_dev)) {
> +	if (IS_ERR_OR_NULL(bc->bus_power_dev)) {
>  		if (PTR_ERR(bc->bus_power_dev) == -ENODEV)
>  			return dev_err_probe(dev, -EPROBE_DEFER,
>  					     "failed to attach power domain \"bus\"\n");
> -- 
> 2.25.1
> 
> 
> 

