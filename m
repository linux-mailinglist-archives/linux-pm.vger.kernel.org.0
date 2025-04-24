Return-Path: <linux-pm+bounces-26139-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3236CA9B4C5
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 18:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 523E67B6903
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 16:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C42728CF69;
	Thu, 24 Apr 2025 16:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lapOBA4T"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF8E2820D2
	for <linux-pm@vger.kernel.org>; Thu, 24 Apr 2025 16:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745513869; cv=none; b=fHuG3Xp3xGlF3TbfcA/WVJVB/R0Isw8aDGIkjFgQfNktyzIp9AJ6gb164z28E4RpwqWWLYUuv45NtgsCyYF5CBXAymhhpvBiQgs3ker/TKUUMvVBnUJTtveONNFHelVIoTKViPPM1N4YhHNyDYzNKyOzIAj9LnJAsXn++qAUO6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745513869; c=relaxed/simple;
	bh=ligPPdPCxLB7UTAeBo43KtRCRHrkTargE1GzztTMgy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YOfLSJGzGhf7YeXGKnOxJRoESswUH4IZLswxcmhnwwEFNzrnR7sjAwzpxJkIJXj7zpcTjBcL6/HvpVH7B88learNJg7Q/wNqzsceyTkmWD4Sd0sUKqimwWs2Ruhp85TQlJSENz2SY+4AYH7M2i6RkKYhsZ0arEeirY+Btd9Tkyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lapOBA4T; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-70565ccf3bcso14790197b3.0
        for <linux-pm@vger.kernel.org>; Thu, 24 Apr 2025 09:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745513866; x=1746118666; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cMFtwR0cjY9A1szP289YoQESj54wwE6Rq8FAwxVKpA4=;
        b=lapOBA4TaF02i9vHQjDke6OAfU+LdDD3YZws3xHzcJxzFrOYVx2ext+TscTNTVu22y
         zb2IUx8zkUDDvPWGDkXYqHbHITRhKF3IyHCHofMkknJCLREDoETxWFg0Da0hMyvQOWiN
         JrAxvbeI5/PmGbzWsoZkcHvGj2SnxQKX4kRTSp7KmS+9Kdob+M+aTdhi2IzPDJ+nMU2B
         EmUVdNOw7c3RCbCJg2tJfEWcfGSRNTVLxH1n8ZUV6OzYzfY83ZFfVaTVl0NtYpULrFN9
         02vUxEACSt+O5f+Wt2xnA9xep7yvZgL39ffiHRcfghdRSnPxfSq98udbsuWo/005sbwP
         wObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745513866; x=1746118666;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cMFtwR0cjY9A1szP289YoQESj54wwE6Rq8FAwxVKpA4=;
        b=MeoTHdRLs9pmQ9Ak5FNT1i2EhL0aX7L/Mc1UuG6ql5ae9oGNbfdqczC5+jgIAGsqgn
         qDiOGTZhQ1nGM/6N1Ju9ExOSrfXW3FTOPeShUMqDc5MiNfsq8eDMAZd/aQBe7BdwY+hG
         WMWv58i6TTvjTyK/KkNkDFwAnzbno2SZjehpDiSYkiBBk8jvEauaMrXFAdjx/9wYn9wW
         gGI981sV9cqoPTfhmWGw+G1fyXlHwujbr3pZa7tlcDjiuXlEYQBEpocVcgaA0+DZs73V
         yOLX5SF3Gn7IanWPsM55euksQ6cJuqNa+sTuau0a1e1ZtjeepCpu0ikb1U68uM3V7K5D
         WPEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcvb5i0zsS/QeA/egUOcWeLoWDLWGl5PGBrBdD79Gb1WjZpUwqpusqdn1aZil6sLe1n8URc2zQVw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4wf3WWjmGyEg19gdi9YlpxxCXmt2DpeZ7q6qwlZZ79db0OBuf
	wjKLUylwwZpDgceSGdVG980htZNmzjhQCPSPxN0gcDrWL5T4fnEo6Vncwm4QWhpXXrHFP3kKCKI
	HY9lCD0LIsd54RA/GqM0ggVIblEtHE6bbR3vUEw==
X-Gm-Gg: ASbGncvoX0pCPZRKr2uR6M1dzYnI70mn/I8Hq08orTEKLhbeKTLzmmJ2d2AGdJ4EWTp
	WrkD3A6tAHEMS2lbwloL1tFJSGqa5kMsJ0R9ugcM9Ql96vRDbYb5ssd1SlPUC5OGAXi0pj0juoa
	2XhO4P+wnG9mmyU2W13Lu3Zec=
X-Google-Smtp-Source: AGHT+IH5p9xZ9JTlIabjNlX7tQHJrcaoNt4NdS4YrEPTAAfSSCwMBfEDdWwaxwxD2TzmAUDKr0gH0wiBCRrqHBSYDNU=
X-Received: by 2002:a05:690c:385:b0:6fd:2feb:eb6e with SMTP id
 00721157ae682-7084f129df8mr7111907b3.28.1745513866588; Thu, 24 Apr 2025
 09:57:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415032314.44997-1-kever.yang@rock-chips.com> <20250415032314.44997-2-kever.yang@rock-chips.com>
In-Reply-To: <20250415032314.44997-2-kever.yang@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 24 Apr 2025 18:57:10 +0200
X-Gm-Features: ATxdqUHaEq5VBCeeWj8VtNYyErWM1Dmw22DJsOkuoLiPj5dVBYs62HJ1VPg7Ulw
Message-ID: <CAPDyKFqLQsG-rNeYgHT4g2mCWjPzkF2nkktUXxAL95tM7g+Smg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] soc: rockchip: power-domain: add power domain
 support for rk3562
To: Kever Yang <kever.yang@rock-chips.com>
Cc: heiko@sntech.de, linux-rockchip@lists.infradead.org, 
	Finley Xiao <finley.xiao@rock-chips.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, linux-pm@vger.kernel.org, 
	Detlev Casanova <detlev.casanova@collabora.com>, linux-kernel@vger.kernel.org, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, Peter Geis <pgwipeout@gmail.com>, 
	Shawn Lin <shawn.lin@rock-chips.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Apr 2025 at 05:23, Kever Yang <kever.yang@rock-chips.com> wrote:
>
> From: Finley Xiao <finley.xiao@rock-chips.com>
>
> This driver is modified to support RK3562 SoC.
> Add support to ungate clk.
> Add support to shut down memory for rk3562.
>
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>

Applied for next and by amending the commit message header, thanks!

Kind regards
Uffe


> ---
>
> Changes in v4:
> - rebase to v6.15-rc1
> - update patch author and Collect review tag
>
> Changes in v3: None
> Changes in v2:
> - update the header after rename
>
>  drivers/pmdomain/rockchip/pm-domains.c | 48 +++++++++++++++++++++++++-
>  1 file changed, 47 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
> index 03bcf79a461f..4cce407bb1eb 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -2,7 +2,7 @@
>  /*
>   * Rockchip Generic power domain support.
>   *
> - * Copyright (c) 2015 ROCKCHIP, Co. Ltd.
> + * Copyright (c) 2015 Rockchip Electronics Co., Ltd.
>   */
>
>  #include <linux/arm-smccc.h>
> @@ -35,6 +35,7 @@
>  #include <dt-bindings/power/rk3366-power.h>
>  #include <dt-bindings/power/rk3368-power.h>
>  #include <dt-bindings/power/rk3399-power.h>
> +#include <dt-bindings/power/rockchip,rk3562-power.h>
>  #include <dt-bindings/power/rk3568-power.h>
>  #include <dt-bindings/power/rockchip,rk3576-power.h>
>  #include <dt-bindings/power/rk3588-power.h>
> @@ -135,6 +136,20 @@ struct rockchip_pmu {
>         .active_wakeup = wakeup,                        \
>  }
>
> +#define DOMAIN_M_G_SD(_name, pwr, status, req, idle, ack, g_mask, mem, wakeup, keepon) \
> +{                                                      \
> +       .name = _name,                                  \
> +       .pwr_w_mask = (pwr) << 16,                      \
> +       .pwr_mask = (pwr),                              \
> +       .status_mask = (status),                        \
> +       .req_w_mask = (req) << 16,                      \
> +       .req_mask = (req),                              \
> +       .idle_mask = (idle),                            \
> +       .ack_mask = (ack),                              \
> +       .clk_ungate_mask = (g_mask),                    \
> +       .active_wakeup = wakeup,                        \
> +}
> +
>  #define DOMAIN_M_O_R(_name, p_offset, pwr, status, m_offset, m_status, r_status, r_offset, req, idle, ack, wakeup, regulator)  \
>  {                                                      \
>         .name = _name,                                  \
> @@ -201,6 +216,9 @@ struct rockchip_pmu {
>  #define DOMAIN_RK3399(name, pwr, status, req, wakeup)          \
>         DOMAIN(name, pwr, status, req, req, req, wakeup)
>
> +#define DOMAIN_RK3562(name, pwr, req, g_mask, mem, wakeup)             \
> +       DOMAIN_M_G_SD(name, pwr, pwr, req, req, req, g_mask, mem, wakeup, false)
> +
>  #define DOMAIN_RK3568(name, pwr, req, wakeup)          \
>         DOMAIN_M(name, pwr, pwr, req, req, req, wakeup)
>
> @@ -1197,6 +1215,18 @@ static const struct rockchip_domain_info rk3399_pm_domains[] = {
>         [RK3399_PD_SDIOAUDIO]   = DOMAIN_RK3399("sdioaudio", BIT(31), BIT(31), BIT(29), true),
>  };
>
> +static const struct rockchip_domain_info rk3562_pm_domains[] = {
> +                                            /* name           pwr     req     g_mask  mem wakeup */
> +       [RK3562_PD_GPU]         = DOMAIN_RK3562("gpu",         BIT(0), BIT(1), BIT(1), 0, false),
> +       [RK3562_PD_NPU]         = DOMAIN_RK3562("npu",         BIT(1), BIT(2), BIT(2), 0, false),
> +       [RK3562_PD_VDPU]        = DOMAIN_RK3562("vdpu",        BIT(2), BIT(6), BIT(6), 0, false),
> +       [RK3562_PD_VEPU]        = DOMAIN_RK3562("vepu",        BIT(3), BIT(7), BIT(7) | BIT(3), 0, false),
> +       [RK3562_PD_RGA]         = DOMAIN_RK3562("rga",         BIT(4), BIT(5), BIT(5) | BIT(4), 0, false),
> +       [RK3562_PD_VI]          = DOMAIN_RK3562("vi",          BIT(5), BIT(3), BIT(3), 0, false),
> +       [RK3562_PD_VO]          = DOMAIN_RK3562("vo",  BIT(6), BIT(4), BIT(4), 16, false),
> +       [RK3562_PD_PHP]         = DOMAIN_RK3562("php",         BIT(7), BIT(8), BIT(8), 0, false),
> +};
> +
>  static const struct rockchip_domain_info rk3568_pm_domains[] = {
>         [RK3568_PD_NPU]         = DOMAIN_RK3568("npu",  BIT(1), BIT(2),  false),
>         [RK3568_PD_GPU]         = DOMAIN_RK3568("gpu",  BIT(0), BIT(1),  false),
> @@ -1398,6 +1428,18 @@ static const struct rockchip_pmu_info rk3399_pmu = {
>         .domain_info = rk3399_pm_domains,
>  };
>
> +static const struct rockchip_pmu_info rk3562_pmu = {
> +       .pwr_offset = 0x210,
> +       .status_offset = 0x230,
> +       .req_offset = 0x110,
> +       .idle_offset = 0x128,
> +       .ack_offset = 0x120,
> +       .clk_ungate_offset = 0x140,
> +
> +       .num_domains = ARRAY_SIZE(rk3562_pm_domains),
> +       .domain_info = rk3562_pm_domains,
> +};
> +
>  static const struct rockchip_pmu_info rk3568_pmu = {
>         .pwr_offset = 0xa0,
>         .status_offset = 0x98,
> @@ -1496,6 +1538,10 @@ static const struct of_device_id rockchip_pm_domain_dt_match[] = {
>                 .compatible = "rockchip,rk3399-power-controller",
>                 .data = (void *)&rk3399_pmu,
>         },
> +       {
> +               .compatible = "rockchip,rk3562-power-controller",
> +               .data = (void *)&rk3562_pmu,
> +       },
>         {
>                 .compatible = "rockchip,rk3568-power-controller",
>                 .data = (void *)&rk3568_pmu,
> --
> 2.25.1
>

