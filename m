Return-Path: <linux-pm+bounces-12047-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C7794D19B
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 15:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDB521C20B4B
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 13:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D168196C7C;
	Fri,  9 Aug 2024 13:52:00 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E81A195FEF;
	Fri,  9 Aug 2024 13:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723211520; cv=none; b=IN0SUKvgc9K5mkKFwXxPzW9Ap/Eq0kfm6YwuoOz+LWwt/0JX9mf+9jJpO7AoCsZmXvfaKV8aAFIjkY9vI2o7EFQoYIvLVnD3fxjVzi9yzM4JdxqAt9RqB1pcn69de2e7sWYStRuB9TQagNqXT7FDEW9oyHGGrNyUZVdbLXgCMTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723211520; c=relaxed/simple;
	bh=xbzXXQI9WdWkT7VudqN0N02wIsHlxFoU+fj7JeD1peQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xth5Nu/JtcZqG5u78qQ6fwMa12dwYaw19pbWyW8mlDQVWK01Uql6ndD0mYIPD0SJNmlWzjpxnhsjyxmRWehWNzgo8fPz2/39s7z+nJq5G36h91ZrNZpueEULwTSYa5S9R2jatqXEVBaZ/SIeuOjqFjIfQWYu/krxOmeJOpo2IOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b02.versanet.de ([83.135.91.2] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1scQ1w-0007PZ-Ef; Fri, 09 Aug 2024 15:51:44 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-kernel@vger.kernel.org,
 Detlev Casanova <detlev.casanova@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Detlev Casanova <detlev.casanova@collabora.com>,
 Finley Xiao <finley.xiao@rock-chips.com>, Arnd Bergmann <arnd@arndb.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Jagan Teki <jagan@edgeble.ai>,
 Elaine Zhang <zhangqing@rock-chips.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-pm@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v3 2/2] pmdomain: rockchip: Add support for rk3576 SoC
Date: Fri, 09 Aug 2024 15:51:43 +0200
Message-ID: <2741902.muMEfcBPU2@diego>
In-Reply-To: <20240809125925.4295-3-detlev.casanova@collabora.com>
References:
 <20240809125925.4295-1-detlev.casanova@collabora.com>
 <20240809125925.4295-3-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Detlev,

Am Freitag, 9. August 2024, 14:58:05 CEST schrieb Detlev Casanova:
> From: Finley Xiao <finley.xiao@rock-chips.com>
> 
> Add configuration for RK3576 SoC and list the power domains.
> 
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> [rebase, reword, squash]
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> ---
>  drivers/pmdomain/rockchip/pm-domains.c | 66 +++++++++++++++++++++++++-
>  1 file changed, 64 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
> index 9b76b62869d0d..466c0aab72060 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -33,6 +33,7 @@
>  #include <dt-bindings/power/rk3368-power.h>
>  #include <dt-bindings/power/rk3399-power.h>
>  #include <dt-bindings/power/rk3568-power.h>
> +#include <dt-bindings/power/rockchip,rk3576-power.h>
>  #include <dt-bindings/power/rk3588-power.h>
>  
>  struct rockchip_domain_info {
> @@ -144,9 +145,26 @@ struct rockchip_pmu {
>  	.active_wakeup = wakeup,			\
>  }
>  
> -#define DOMAIN_RK3036(_name, req, ack, idle, wakeup)		\
> +#define DOMAIN_M_O_R_G(_name, p_offset, pwr, status, r_status, r_offset, req, idle, ack, g_mask, wakeup)	\
>  {							\
> -	.name = _name,				\
> +	.name = _name,					\
> +	.pwr_offset = p_offset,				\
> +	.pwr_w_mask = (pwr) << 16,			\
> +	.pwr_mask = (pwr),				\
> +	.status_mask = (status),			\
> +	.mem_status_mask = (r_status),			\
> +	.repair_status_mask = (r_status),		\
> +	.req_offset = r_offset,				\
> +	.req_w_mask = (req) << 16,			\
> +	.req_mask = (req),				\
> +	.idle_mask = (idle),				\
> +	.ack_mask = (ack),				\
> +	.active_wakeup = wakeup,			\
> +}
> +
> +#define DOMAIN_RK3036(_name, req, ack, idle, wakeup)	\

unrelated change, the patch should not modify  an unrelated part of the code.
But _at this time_ we generally should not need this part anyway.

In the define above the g_mask field is not used nor described at all.
Aka right now the values for g_mask in the domain definitions below are
just pretty random unexplained hex values that do not seem needed.


> +{							\
> +	.name = _name,					\
>  	.req_mask = (req),				\
>  	.req_w_mask = (req) << 16,			\
>  	.ack_mask = (ack),				\
> @@ -175,6 +193,9 @@ struct rockchip_pmu {
>  #define DOMAIN_RK3568(name, pwr, req, wakeup)		\
>  	DOMAIN_M(name, pwr, pwr, req, req, req, wakeup)
>  
> +#define DOMAIN_RK3576(name, p_offset, pwr, status, r_status, r_offset, req, idle, g_mask, wakeup)	\
> +	DOMAIN_M_O_R_G(name, p_offset, pwr, status, r_status, r_offset, req, idle, idle, g_mask, wakeup)
> +

Without that g_mask value you can also just use the existing DOMAIN_M_O_R
macro here and that whole g_mask think can be introduced later, when we
actually need it and it is known what that thing does.


>  /*
>   * Dynamic Memory Controller may need to coordinate with us -- see
>   * rockchip_pmu_block().
> @@ -1106,6 +1127,28 @@ static const struct rockchip_domain_info rk3568_pm_domains[] = {
>  	[RK3568_PD_PIPE]	= DOMAIN_RK3568("pipe", BIT(8), BIT(11), false),
>  };
>  
> +static const struct rockchip_domain_info rk3576_pm_domains[] = {
> +	[RK3576_PD_NPU]		= DOMAIN_RK3576("npu",    0x0, BIT(0),  BIT(0), 0,       0x0, 0,       0,       0,       false),
> +	[RK3576_PD_NVM]		= DOMAIN_RK3576("nvm",    0x0, BIT(6),  0,      BIT(6),  0x4, BIT(2),  BIT(18), BIT(2),  false),
> +	[RK3576_PD_SDGMAC]	= DOMAIN_RK3576("sdgmac", 0x0, BIT(7),  0,      BIT(7),  0x4, BIT(1),  BIT(17), 0x6,     false),
> +	[RK3576_PD_AUDIO]	= DOMAIN_RK3576("audio",  0x0, BIT(8),  0,      BIT(8),  0x4, BIT(0),  BIT(16), BIT(0),  false),
> +	[RK3576_PD_PHP]		= DOMAIN_RK3576("php",    0x0, BIT(9),  0,      BIT(9),  0x0, BIT(15), BIT(15), BIT(15), false),
> +	[RK3576_PD_SUBPHP]	= DOMAIN_RK3576("subphp", 0x0, BIT(10), 0,      BIT(10), 0x0, 0,       0,       0,       false),
> +	[RK3576_PD_VOP]		= DOMAIN_RK3576("vop",    0x0, BIT(11), 0,      BIT(11), 0x0, 0x6000,  0x6000,  0x6000,  false),
> +	[RK3576_PD_VO1]		= DOMAIN_RK3576("vo1",    0x0, BIT(14), 0,      BIT(14), 0x0, BIT(12), BIT(12), 0x7000,  false),
> +	[RK3576_PD_VO0]		= DOMAIN_RK3576("vo0",    0x0, BIT(15), 0,      BIT(15), 0x0, BIT(11), BIT(11), 0x6800,  false),
> +	[RK3576_PD_USB]		= DOMAIN_RK3576("usb",    0x4, BIT(0),  0,      BIT(16), 0x0, BIT(10), BIT(10), 0x6400,  true),
> +	[RK3576_PD_VI]		= DOMAIN_RK3576("vi",     0x4, BIT(1),  0,      BIT(17), 0x0, BIT(9),  BIT(9),  BIT(9),  false),
> +	[RK3576_PD_VEPU0]	= DOMAIN_RK3576("vepu0",  0x4, BIT(2),  0,      BIT(18), 0x0, BIT(7),  BIT(7),  0x280,   false),
> +	[RK3576_PD_VEPU1]	= DOMAIN_RK3576("vepu1",  0x4, BIT(3),  0,      BIT(19), 0x0, BIT(8),  BIT(8),  BIT(8),  false),
> +	[RK3576_PD_VDEC]	= DOMAIN_RK3576("vdec",   0x4, BIT(4),  0,      BIT(20), 0x0, BIT(6),  BIT(6),  BIT(6),  false),
> +	[RK3576_PD_VPU]		= DOMAIN_RK3576("vpu",    0x4, BIT(5),  0,      BIT(21), 0x0, BIT(5),  BIT(5),  BIT(5),  false),
> +	[RK3576_PD_NPUTOP]	= DOMAIN_RK3576("nputop", 0x4, BIT(6),  0,      BIT(22), 0x0, 0x18,    0x18,    0x18,    false),
> +	[RK3576_PD_NPU0]	= DOMAIN_RK3576("npu0",   0x4, BIT(7),  0,      BIT(23), 0x0, BIT(1),  BIT(1),  0x1a,    false),
> +	[RK3576_PD_NPU1]	= DOMAIN_RK3576("npu1",   0x4, BIT(8),  0,      BIT(24), 0x0, BIT(2),  BIT(2),  0x1c,    false),
> +	[RK3576_PD_GPU]		= DOMAIN_RK3576("gpu",    0x4, BIT(9),  0,      BIT(25), 0x0, BIT(0),  BIT(0),  BIT(0),  false),
> +};
> +
>  static const struct rockchip_domain_info rk3588_pm_domains[] = {
>  	[RK3588_PD_GPU]		= DOMAIN_RK3588("gpu",     0x0, BIT(0),  0,       0x0, 0,       BIT(1),  0x0, BIT(0),  BIT(0),  false),
>  	[RK3588_PD_NPU]		= DOMAIN_RK3588("npu",     0x0, BIT(1),  BIT(1),  0x0, 0,       0,       0x0, 0,       0,       false),
> @@ -1284,6 +1327,21 @@ static const struct rockchip_pmu_info rk3568_pmu = {
>  	.domain_info = rk3568_pm_domains,
>  };
>  
> +static const struct rockchip_pmu_info rk3576_pmu = {
> +	.pwr_offset = 0x210,
> +	.status_offset = 0x230,
> +	.chain_status_offset = 0x248,
> +	.mem_status_offset = 0x250,
> +	.mem_pwr_offset = 0x300,
> +	.req_offset = 0x110,
> +	.idle_offset = 0x128,
> +	.ack_offset = 0x120,
> +	.repair_status_offset = 0x570,
> +
> +	.num_domains = ARRAY_SIZE(rk3576_pm_domains),
> +	.domain_info = rk3576_pm_domains,
> +};

domain list and registers look good according to the TRM


Heiko





