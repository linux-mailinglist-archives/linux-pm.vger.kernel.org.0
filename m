Return-Path: <linux-pm+bounces-30867-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 430E6B05F5B
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 16:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7FB63A8DA2
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 13:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354062E9ED4;
	Tue, 15 Jul 2025 13:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="s6gpeonU"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BC22E9EA5;
	Tue, 15 Jul 2025 13:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587303; cv=none; b=PgoMLfYwF4oUzkYnNM+BorhJlbs6d4+oCnPq0In6SmSuOLEJ18j8/BIn5ShGNLS+/upGtXoh4ukEEB8I0kDwleiE06MLVSGFNCVC8qyJAlmXbXpglxhZdF09QVnvSsS4evMzN5C/faib/24/AlU2aizMQ2hz1Bw1bNu8PSV5f5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587303; c=relaxed/simple;
	bh=66qWXLtTKrU8UluP8yQF4eFP3g7cZ6AfCLSukMx3+NU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thrOVqREHxsK4+reNalaASxC7i/dthHtAReQbbbZZDdnGWyUJWy0yNOGvvpUoyeSLSTGCRw0qa5ksHdMYzm1l7QjNDmZkPU0rtCgpEakjRP0iX070eBCBRSIbjI7dkBy0Sz0/QUFd7KRt9PSdVtTEGoPnbHqcE8JeJlkUJ0iofY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=s6gpeonU; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56FDmFxb023050;
	Tue, 15 Jul 2025 08:48:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752587295;
	bh=AHQMxBaMGwP6e15hpXbm6AdXnEqDI+bUGqu+P24NYGE=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=s6gpeonUSgZBNgMMC5a/C4guMfHoEH5rfsOKRNu2MSSL2NPqRw7/Zu175knlcbdIU
	 BRSKrdyfkCCKnSA560+1GJJOul4hf+oZGHny6cKiLMBusAB3gyCJYNA/9cgL9Rujn5
	 iQJFjLO1M9UD9tsRI/ZBhcfS8jefJrP4nvKugPgw=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56FDmFT3110832
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 15 Jul 2025 08:48:15 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 15
 Jul 2025 08:48:14 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 15 Jul 2025 08:48:14 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56FDmEAD2988095;
	Tue, 15 Jul 2025 08:48:14 -0500
Date: Tue, 15 Jul 2025 08:48:14 -0500
From: Nishanth Menon <nm@ti.com>
To: Guillaume La Roque <glaroque@baylibre.com>
CC: <vigneshr@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vishalm@ti.com>, <matthias.schiffer@ew.tq-group.com>
Subject: Re: [PATCH v2] pmdomain: ti: Select PM_GENERIC_DOMAINS
Message-ID: <20250715134814.zrensaf3o6yxjrgz@bogged>
References: <20250715-depspmdomain-v2-1-6f0eda3ce824@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250715-depspmdomain-v2-1-6f0eda3ce824@baylibre.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 10:50-20250715, Guillaume La Roque wrote:
> Select PM_GENERIC_DOMAINS instead of depending on it to ensure
> it is always enabled when TI_SCI_PM_DOMAINS is selected.
> Since PM_GENERIC_DOMAINS is an implicit symbol, it can only be enabled
> through 'select' and cannot be explicitly enabled in configuration.
> This simplifies the dependency chain and prevents build issues
> 
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
> Changes in v2:
> - update commit message
> - fix select rules
> - Link to v1: https://lore.kernel.org/r/20250704-depspmdomain-v1-1-ef2710556e62@baylibre.com
> ---
>  drivers/pmdomain/ti/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pmdomain/ti/Kconfig b/drivers/pmdomain/ti/Kconfig
> index 67c608bf7ed0..5386b362a7ab 100644
> --- a/drivers/pmdomain/ti/Kconfig
> +++ b/drivers/pmdomain/ti/Kconfig
> @@ -10,7 +10,7 @@ if SOC_TI
>  config TI_SCI_PM_DOMAINS
>  	tristate "TI SCI PM Domains Driver"
>  	depends on TI_SCI_PROTOCOL
> -	depends on PM_GENERIC_DOMAINS
> +	select PM_GENERIC_DOMAINS if PM
>  	help
>  	  Generic power domain implementation for TI device implementing
>  	  the TI SCI protocol.
> 
> ---
> base-commit: 8d6c58332c7a8ba025fcfa76888b6c37dbce9633
> change-id: 20250704-depspmdomain-2c584745dca8
> 
> Best regards,
> -- 
> Guillaume La Roque <glaroque@baylibre.com>
> 


Reviewed-by: Nishanth Menon <nm@ti.com>

Ulf, I am hoping we can queue this up for 6.17, I know it has been a bit
late :(

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource

