Return-Path: <linux-pm+bounces-12000-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A9994C2E7
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 18:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EDD21C24EBA
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 16:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35254190055;
	Thu,  8 Aug 2024 16:41:36 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D52818E74F;
	Thu,  8 Aug 2024 16:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723135296; cv=none; b=iNF7OE0mqAcqxwr+Nmqr3yxVq4ATmVauBh3aGRoKqxjGkCkwLc1zfpD9U22tbA1mB8feHm1g78Qgq5wc3goqwk8HfSW0FOegB1XMGxbafHxKHU/lNfb7qLC2zec9SG7hV7gPGV0TP4HNDoeJJ99mg7k4HjRWcr6j+1sIgCF9hX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723135296; c=relaxed/simple;
	bh=NkELFhSYAIOi832lH3EA9b0ZxW9kbOFCrcloPkJbX6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rWaufq46CcKTjOdIXx2cm2rBJH/3x9VU8vJGsdX9LeeVtFoscNLlRnoh9wsLFpVtBEgerIpmtpAI6dU5Juzz1x+zRKeqkim0cy0Uw+2NJaqT4wNud4POXiHTTBP7s4WUm9BYonq/7q1I4gwvNoBfAkdbx1OZhGX1Qbm0ZBKDJDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875a9f.versanet.de ([83.135.90.159] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sc6CN-0004h9-Q6; Thu, 08 Aug 2024 18:41:11 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-kernel@vger.kernel.org,
 Detlev Casanova <detlev.casanova@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Detlev Casanova <detlev.casanova@collabora.com>,
 Finley Xiao <finley.xiao@rock-chips.com>, Jagan Teki <jagan@edgeble.ai>,
 Arnd Bergmann <arnd@arndb.de>, Elaine Zhang <zhangqing@rock-chips.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org,
 kernel@collabora.com
Subject: Re: [PATCH v2 2/2] pmdomain: rockchip: Add support for rk3576 SoC
Date: Thu, 08 Aug 2024 18:41:05 +0200
Message-ID: <17766579.lhrHg4fidi@diego>
In-Reply-To: <20240808163451.80750-3-detlev.casanova@collabora.com>
References:
 <20240808163451.80750-1-detlev.casanova@collabora.com>
 <20240808163451.80750-3-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Detlev,

Am Donnerstag, 8. August 2024, 18:31:05 CEST schrieb Detlev Casanova:
> From: Finley Xiao <finley.xiao@rock-chips.com>
> 
> Add configuration for RK3576 SoC and list the power domains.
> 
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> [rebase, reword, squash]
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> ---
>  drivers/pmdomain/rockchip/pm-domains.c | 73 ++++++++++++++++++++++++--
>  1 file changed, 70 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
> index 9b76b62869d0d..863f1ad6b9e11 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c

[...]

> @@ -175,6 +195,9 @@ struct rockchip_pmu {
>  #define DOMAIN_RK3568(name, pwr, req, wakeup)		\
>  	DOMAIN_M(name, pwr, pwr, req, req, req, wakeup)
>  
> +#define DOMAIN_RK3576(name, p_offset, pwr, status, r_status, r_offset, req, idle, g_mask, delay, wakeup)	\
> +	DOMAIN_M_O_R_G(name, p_offset, pwr, status, r_status, r_offset, req, idle, idle, g_mask, delay, wakeup)
> +
>  /*
>   * Dynamic Memory Controller may need to coordinate with us -- see
>   * rockchip_pmu_block().
> @@ -552,7 +575,10 @@ static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
>  			/* if powering up, leave idle mode */
>  			rockchip_pmu_set_idle_request(pd, false);
>  
> -			rockchip_pmu_restore_qos(pd);
> +			if (pd->info->delay_us)
> +				udelay(pd->info->delay_us);
> +			else
> +				rockchip_pmu_restore_qos(pd);

I still want this behaviour change in a separate patch with adequate
commit message please.

Going from always handling qos to allowing to just wait a specific time
needs explanation and is not part of "just" adding rk3576 support.


Heiko



