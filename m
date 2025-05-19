Return-Path: <linux-pm+bounces-27363-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E38ABC4E9
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 18:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 720F77AC477
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 16:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E718A28641D;
	Mon, 19 May 2025 16:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="V63S+DKi"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D4928313B;
	Mon, 19 May 2025 16:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747673543; cv=none; b=WcRppHCiAlRa5pi+A4NTnm9lQrDGaPkUSKuHPA+L3XxabQkEZqSX9HqipGTXdpxqUCoU5aaMzRHeVD4Byh8ovcbK5kQXgtuQm7HkudT5gkiFrIh0QL/w2R1rpu5I7ZAZ+2iR1oa/Yt1aVXjHQu1GzKB09+urrqp5leZCorHu9d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747673543; c=relaxed/simple;
	bh=U9x2vCHwSzL90x0YSqb3lSIFOLdNatA4ryM/Wrtr0Mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ptNYQFs3zewt8yD7o15MnrKga/quw7foZNM+XgCnWzK7VPgEGV6ssKCTLHvUiHqW3x72CzcbnC38kjN8YZmXQhXdUv/x9laQID44ZTdC0JqW6HxyS1+UjvlM72OPjS+8F54k3MqN2kcbSkVeP+Pe1W/pEeVZbf5cExw46rfOvXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=V63S+DKi; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 79D1525A49;
	Mon, 19 May 2025 18:52:20 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HHDEt46mHG2L; Mon, 19 May 2025 18:52:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1747673539; bh=U9x2vCHwSzL90x0YSqb3lSIFOLdNatA4ryM/Wrtr0Mw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V63S+DKiXH03Rzuz9caUPXeIvfVuut9gQuvpswWqDgO9HhFjDrqGkM5+KVju/FZl2
	 GMMfizcMFEJLYbZzhXyiHLggXd4MTY1ELM4zabtHP5Y/dUGdEncQyDtXPd81HeSNg+
	 2NhJCrS+34I1S+D8kwUmsQOgzjyvlc92v6SS4JZtukbBTm8toU8UlvtckQ4s8HAZj9
	 QtO3HZ1dk+WBIuxjV4ToKEega2HSPPJfElrXgB8Hm/MtUHEno/w1sZ8F3WTnO+nG4U
	 +xcrNnwIvVZHsdyhbui/rlG/yOAKzqrU5fPW4/luHVFKRzqVVTQ2YwRNxQEglOSsYQ
	 J+fmXkY42S7ZQ==
Date: Mon, 19 May 2025 16:52:04 +0000
From: Yao Zi <ziyao@disroot.org>
To: Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chukun Pan <amadeus@jmu.edu.cn>,
	linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/9] pmdomain: rockchip: Add support for RK3528
Message-ID: <aCthtDxm25RU_fd3@pie.lan>
References: <20250518220707.669515-1-jonas@kwiboo.se>
 <20250518220707.669515-3-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250518220707.669515-3-jonas@kwiboo.se>

On Sun, May 18, 2025 at 10:06:49PM +0000, Jonas Karlman wrote:
> Add configuration and power domains for RK3528 SoC.
> 
> Only PD_GPU can fully be powered down. PD_RKVDEC, PD_RKVENC, PD_VO and
> PD_VPU are used by miscellaneous devices in RK3528.

Thanks for your work!

> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  drivers/pmdomain/rockchip/pm-domains.c | 27 ++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
> index 4cce407bb1eb..242570c505fb 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -35,6 +35,7 @@
>  #include <dt-bindings/power/rk3366-power.h>
>  #include <dt-bindings/power/rk3368-power.h>
>  #include <dt-bindings/power/rk3399-power.h>
> +#include <dt-bindings/power/rockchip,rk3528-power.h>
>  #include <dt-bindings/power/rockchip,rk3562-power.h>

But I had some trouble applying this patch on either Rockchip SoC tree
or linux-pm. Looking through the context, seems the patch depends on
some RK3562 PMU driver changes, which I couldn't find with some brief
searching among the list.

Which branch is the series based on?

>  #include <dt-bindings/power/rk3568-power.h>
>  #include <dt-bindings/power/rockchip,rk3576-power.h>
> @@ -216,6 +217,9 @@ struct rockchip_pmu {
>  #define DOMAIN_RK3399(name, pwr, status, req, wakeup)		\
>  	DOMAIN(name, pwr, status, req, req, req, wakeup)
>  
> +#define DOMAIN_RK3528(name, pwr, req)		\
> +	DOMAIN_M(name, pwr, pwr, req, req, req, false)
> +
>  #define DOMAIN_RK3562(name, pwr, req, g_mask, mem, wakeup)		\
>  	DOMAIN_M_G_SD(name, pwr, pwr, req, req, req, g_mask, mem, wakeup, false)
>  
> @@ -1215,6 +1219,14 @@ static const struct rockchip_domain_info rk3399_pm_domains[] = {
>  	[RK3399_PD_SDIOAUDIO]	= DOMAIN_RK3399("sdioaudio", BIT(31), BIT(31), BIT(29), true),
>  };
>  
> +static const struct rockchip_domain_info rk3528_pm_domains[] = {
> +	[RK3528_PD_GPU]		= DOMAIN_RK3528("gpu",  BIT(0), BIT(4)),
> +	[RK3528_PD_RKVDEC]	= DOMAIN_RK3528("vdec",      0, BIT(5)),
> +	[RK3528_PD_RKVENC]	= DOMAIN_RK3528("venc",      0, BIT(6)),
> +	[RK3528_PD_VO]		= DOMAIN_RK3528("vo",        0, BIT(7)),
> +	[RK3528_PD_VPU]		= DOMAIN_RK3528("vpu",       0, BIT(8)),
> +};
> +
>  static const struct rockchip_domain_info rk3562_pm_domains[] = {
>  					     /* name           pwr     req     g_mask  mem wakeup */
>  	[RK3562_PD_GPU]		= DOMAIN_RK3562("gpu",         BIT(0), BIT(1), BIT(1), 0, false),
> @@ -1428,6 +1440,17 @@ static const struct rockchip_pmu_info rk3399_pmu = {
>  	.domain_info = rk3399_pm_domains,
>  };
>  
> +static const struct rockchip_pmu_info rk3528_pmu = {
> +	.pwr_offset = 0x1210,
> +	.status_offset = 0x1230,
> +	.req_offset = 0x1110,
> +	.idle_offset = 0x1128,
> +	.ack_offset = 0x1120,
> +
> +	.num_domains = ARRAY_SIZE(rk3528_pm_domains),
> +	.domain_info = rk3528_pm_domains,
> +};
> +
>  static const struct rockchip_pmu_info rk3562_pmu = {
>  	.pwr_offset = 0x210,
>  	.status_offset = 0x230,
> @@ -1538,6 +1561,10 @@ static const struct of_device_id rockchip_pm_domain_dt_match[] = {
>  		.compatible = "rockchip,rk3399-power-controller",
>  		.data = (void *)&rk3399_pmu,
>  	},
> +	{
> +		.compatible = "rockchip,rk3528-power-controller",
> +		.data = (void *)&rk3528_pmu,
> +	},
>  	{
>  		.compatible = "rockchip,rk3562-power-controller",
>  		.data = (void *)&rk3562_pmu,
> -- 
> 2.49.0
> 

Thanks for your effort,
Yao Zi

