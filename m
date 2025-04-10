Return-Path: <linux-pm+bounces-25104-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC76FA842A8
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 14:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F03FB1897388
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 12:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326332836A7;
	Thu, 10 Apr 2025 12:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dhz5lPXh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AE12836A0
	for <linux-pm@vger.kernel.org>; Thu, 10 Apr 2025 12:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744287097; cv=none; b=ZG4ucHw6DXq6QeezydTvws+3H2JsGDjUH7u8vMU3UhRCz/ElkCt92Mp6itmudDt895H7LBpPJ6NPmYpmP8EkHRm6zTHtP6GH6LMP0lyB4+KnYHlDZ7GTZrVfE/AJxxah5taGeQiFVEoBvzdpwvmEmvRu/wVnaX+KqohN3PWSNbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744287097; c=relaxed/simple;
	bh=yqHGAHYGSA9DA08+ES2TCWnbkPRDw3qjuTTYC9G/z/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U8xJnJLsIy7QgrHrHFAewSRuctMfZiW/d5EHibPXvhBQ6l4aZA4DSUIMwn+E7+MGtLKRqWZH5/xCxWDum2bPGzd48WuSmlulBdKSM9/ap5gpY4NwN5HHNoEA0VGbius7iazfvsmrhXK78fiFmVDxZsmGVxJQnGTDq52MiqAIwFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dhz5lPXh; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6f47ed1f40dso6005287b3.1
        for <linux-pm@vger.kernel.org>; Thu, 10 Apr 2025 05:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744287094; x=1744891894; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GODg1sr3TqhQ4Fv9FuUuLx/OAO/e6m30LtMeN+DvF4U=;
        b=dhz5lPXh/+nUKhI9c8nwxjOs5MisQDvH+iWEWJUbMD3V2JgO+pD+c5SNOgg6sdwl2Q
         wh2tItbqeaZSv1p8CyGCd16nx5K9uo7uTA/XEyToOkYqShgk9JKgIPqB0BzOXcI6d6jF
         qnBkuRZROCxtdfgiCLv5tSVzzW7MKF1WNfx60fA96zgFc7HS6sw0huKN2QIg9u6gHFLs
         zLGyrCw1sz98nF0mjgo77BgznG8zbrDUvTeQbzGF0FKQJYOCJ1rGhJMlo6cD26zafG86
         3eWznrPU/b+2k6LJX1GjjGWM4Vxmken+SH6KclVqW7CCiPL7TycyDow8uL/dvPW5SVHt
         eFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744287094; x=1744891894;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GODg1sr3TqhQ4Fv9FuUuLx/OAO/e6m30LtMeN+DvF4U=;
        b=aAuUr4g4GKw60k3EAxDNLp5hhFdDN0okH2Vealhc2Fe5Dv4R47fXiu0dbxxCfxHTmI
         JO68jmPmq/wBmAZyiWR3FNeZRApdonGLlpu3cS+3ntBo2bSwAt+gTj/8q6SCCWlFSM46
         +V1Ur6zvGNZbYt/acpiMJbPVzTJe9wr4q2IKbhZp59SHmBYALE+xZDP3nZN9DnRsR021
         fg3RN4pXsz1tK2z0TVYyleKrGRgvNnDc7fO2tJUjnkwMZtwtFli0/7L07HioHCWFGFP0
         XPbhgN9UgxgNmQYKhcbFW5u8XiUe0luJUB9zsRBojTs9DQEHL2xeDPoW58QOjEzfQrxF
         DKQA==
X-Forwarded-Encrypted: i=1; AJvYcCUy/ZeXzI4WKtY2Zi7oe9hqP8Mljk6v2MLkJDV9JJocoBq9/ZL2sI2298bWpB/JiVC9WGVHi1DyTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4pAz6uFOWxeW0UpZQKR+CPEehuGqQKZ6FvgGP+O21hyNloMCg
	gE/zfSGqZMU+xOs5oFyQQILMa0b3copmSxt9HpA/kufy1nTbGPMT8wZvAv915i/snr2C3XmD0Qu
	+KeeoOzPxLXJQ3vkb33jZqAunwxfOGCqXhWFwDEBs7JXo0DQv8EQ=
X-Gm-Gg: ASbGncsLgUYswZql4fZ0noSCzcaDhz0wGp1pRhUuAPEgGoNwNO0K/auMUk4AW40Ut/g
	LVUAH7JGtXHkIJczm4rc+O2oF+f4ouwXv9KaUQ5mszGEP20GXtuSWkCAB5tXrpD3B2luEyMLxGG
	iwKPdH4KmJjAlBx+ZkFZQFMlg=
X-Google-Smtp-Source: AGHT+IEaAeZFUU5jdkuXuZMt+wySNJzy/MbvrsIxEGoiN0HFj4u/P3fiO7lMq3uDeVM1C0fZkbV6FE5PdU8taEvK7Qs=
X-Received: by 2002:a05:690c:6f8d:b0:6fe:b88e:4d9b with SMTP id
 00721157ae682-7054a15b480mr44757647b3.27.1744287093826; Thu, 10 Apr 2025
 05:11:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408-rk3576-emmc-fix-v1-1-3009828b1b31@collabora.com>
In-Reply-To: <20250408-rk3576-emmc-fix-v1-1-3009828b1b31@collabora.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 10 Apr 2025 14:10:56 +0200
X-Gm-Features: ATxdqUEalVIVr_OHHu142XIyjmkdERRsYFQFdtoD5ul8ceb6Np50IJHki8j6pTQ
Message-ID: <CAPDyKFpw=qXT6Qh_Gyub7L3ELdODPkyEZVtALvnJZ3OZQeS76w@mail.gmail.com>
Subject: Re: [PATCH RESEND] pmdomain: rockchip: keep PD_NVM on RK3576 always on
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Elaine Zhang <zhangqing@rock-chips.com>, 
	Finley Xiao <finley.xiao@rock-chips.com>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, 
	Detlev Casanova <detlev.casanova@collabora.com>, kernel@collabora.com, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Shawn Lin <shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"

+ Shawn Lin

On Tue, 8 Apr 2025 at 17:28, Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
>
> Due to what seemingly is a hardware bug, PD_NVM never comes up quite the
> same after being turned off once. The result is that the sdhci
> controller will lock up the entire SoC when it's accessing its CQHCI
> registers.
>
> The downstream kernel hacks around this by setting
> GENPD_FLAG_RPM_ALWAYS_ON in the mmc host driver, which does not seem
> like the right place for this.
>
> Set GENPD_FLAG_ALWAYS_ON in the pmdomain driver for PD_NVM. I'm using
> the non-RPM version of the flag here because I have my doubts a
> suspend-resume cycle will fix it. Suspend-resume currently seems busted,
> so I couldn't test this.
>
> Fixes: cfee1b507758 ("pmdomain: rockchip: Add support for RK3576 SoC")
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Shawn Lin recently made some changes [1] to make UFS work for this
platform, as you probably know of. In particular the changes affected
how to handle the UFS controller from the power-domain point of view.
Could it be that something similar is missing for NVM too?

In any case, I am happy to apply this as a fix if you still think it
makes sense.

Kind regards
Uffe

[1]
https://lore.kernel.org/all/1738736156-119203-1-git-send-email-shawn.lin@rock-chips.com/

> ---
>  drivers/pmdomain/rockchip/pm-domains.c | 48 ++++++++++++++++++----------------
>  1 file changed, 26 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
> index 03bcf79a461f5db14173b35c0d110541e6d3f760..2b220b7c77b3d292f49cbc60338d3925146fb211 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -48,6 +48,7 @@ struct rockchip_domain_info {
>         int ack_mask;
>         bool active_wakeup;
>         bool need_regulator;
> +       bool always_on;
>         int pwr_w_mask;
>         int req_w_mask;
>         int clk_ungate_mask;
> @@ -154,7 +155,7 @@ struct rockchip_pmu {
>         .need_regulator = regulator,                    \
>  }
>
> -#define DOMAIN_M_O_R_G(_name, p_offset, pwr, status, m_offset, m_status, r_status, r_offset, req, idle, ack, g_mask, wakeup)   \
> +#define DOMAIN_M_O_R_G(_name, p_offset, pwr, status, m_offset, m_status, r_status, r_offset, req, idle, ack, g_mask, wakeup, _always_on)       \
>  {                                                      \
>         .name = _name,                                  \
>         .pwr_offset = p_offset,                         \
> @@ -171,6 +172,7 @@ struct rockchip_pmu {
>         .clk_ungate_mask = (g_mask),                    \
>         .ack_mask = (ack),                              \
>         .active_wakeup = wakeup,                        \
> +       .always_on = _always_on,                        \
>  }
>
>  #define DOMAIN_RK3036(_name, req, ack, idle, wakeup)           \
> @@ -204,8 +206,8 @@ struct rockchip_pmu {
>  #define DOMAIN_RK3568(name, pwr, req, wakeup)          \
>         DOMAIN_M(name, pwr, pwr, req, req, req, wakeup)
>
> -#define DOMAIN_RK3576(name, p_offset, pwr, status, r_status, r_offset, req, idle, g_mask, wakeup)      \
> -       DOMAIN_M_O_R_G(name, p_offset, pwr, status, 0, r_status, r_status, r_offset, req, idle, idle, g_mask, wakeup)
> +#define DOMAIN_RK3576(name, p_offset, pwr, status, r_status, r_offset, req, idle, g_mask, wakeup, always_on)   \
> +       DOMAIN_M_O_R_G(name, p_offset, pwr, status, 0, r_status, r_status, r_offset, req, idle, idle, g_mask, wakeup, always_on)
>
>  /*
>   * Dynamic Memory Controller may need to coordinate with us -- see
> @@ -846,6 +848,8 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
>         pd->genpd.flags = GENPD_FLAG_PM_CLK;
>         if (pd_info->active_wakeup)
>                 pd->genpd.flags |= GENPD_FLAG_ACTIVE_WAKEUP;
> +       if (pd_info->always_on)
> +               pd->genpd.flags |= GENPD_FLAG_ALWAYS_ON;
>         pm_genpd_init(&pd->genpd, NULL,
>                       !rockchip_pmu_domain_is_on(pd) ||
>                       (pd->info->mem_status_mask && !rockchip_pmu_domain_is_mem_on(pd)));
> @@ -1210,25 +1214,25 @@ static const struct rockchip_domain_info rk3568_pm_domains[] = {
>  };
>
>  static const struct rockchip_domain_info rk3576_pm_domains[] = {
> -       [RK3576_PD_NPU]         = DOMAIN_RK3576("npu",    0x0, BIT(0),  BIT(0), 0,       0x0, 0,       0,       0,       false),
> -       [RK3576_PD_NVM]         = DOMAIN_RK3576("nvm",    0x0, BIT(6),  0,      BIT(6),  0x4, BIT(2),  BIT(18), BIT(2),  false),
> -       [RK3576_PD_SDGMAC]      = DOMAIN_RK3576("sdgmac", 0x0, BIT(7),  0,      BIT(7),  0x4, BIT(1),  BIT(17), 0x6,     false),
> -       [RK3576_PD_AUDIO]       = DOMAIN_RK3576("audio",  0x0, BIT(8),  0,      BIT(8),  0x4, BIT(0),  BIT(16), BIT(0),  false),
> -       [RK3576_PD_PHP]         = DOMAIN_RK3576("php",    0x0, BIT(9),  0,      BIT(9),  0x0, BIT(15), BIT(15), BIT(15), false),
> -       [RK3576_PD_SUBPHP]      = DOMAIN_RK3576("subphp", 0x0, BIT(10), 0,      BIT(10), 0x0, 0,       0,       0,       false),
> -       [RK3576_PD_VOP]         = DOMAIN_RK3576("vop",    0x0, BIT(11), 0,      BIT(11), 0x0, 0x6000,  0x6000,  0x6000,  false),
> -       [RK3576_PD_VO1]         = DOMAIN_RK3576("vo1",    0x0, BIT(14), 0,      BIT(14), 0x0, BIT(12), BIT(12), 0x7000,  false),
> -       [RK3576_PD_VO0]         = DOMAIN_RK3576("vo0",    0x0, BIT(15), 0,      BIT(15), 0x0, BIT(11), BIT(11), 0x6800,  false),
> -       [RK3576_PD_USB]         = DOMAIN_RK3576("usb",    0x4, BIT(0),  0,      BIT(16), 0x0, BIT(10), BIT(10), 0x6400,  true),
> -       [RK3576_PD_VI]          = DOMAIN_RK3576("vi",     0x4, BIT(1),  0,      BIT(17), 0x0, BIT(9),  BIT(9),  BIT(9),  false),
> -       [RK3576_PD_VEPU0]       = DOMAIN_RK3576("vepu0",  0x4, BIT(2),  0,      BIT(18), 0x0, BIT(7),  BIT(7),  0x280,   false),
> -       [RK3576_PD_VEPU1]       = DOMAIN_RK3576("vepu1",  0x4, BIT(3),  0,      BIT(19), 0x0, BIT(8),  BIT(8),  BIT(8),  false),
> -       [RK3576_PD_VDEC]        = DOMAIN_RK3576("vdec",   0x4, BIT(4),  0,      BIT(20), 0x0, BIT(6),  BIT(6),  BIT(6),  false),
> -       [RK3576_PD_VPU]         = DOMAIN_RK3576("vpu",    0x4, BIT(5),  0,      BIT(21), 0x0, BIT(5),  BIT(5),  BIT(5),  false),
> -       [RK3576_PD_NPUTOP]      = DOMAIN_RK3576("nputop", 0x4, BIT(6),  0,      BIT(22), 0x0, 0x18,    0x18,    0x18,    false),
> -       [RK3576_PD_NPU0]        = DOMAIN_RK3576("npu0",   0x4, BIT(7),  0,      BIT(23), 0x0, BIT(1),  BIT(1),  0x1a,    false),
> -       [RK3576_PD_NPU1]        = DOMAIN_RK3576("npu1",   0x4, BIT(8),  0,      BIT(24), 0x0, BIT(2),  BIT(2),  0x1c,    false),
> -       [RK3576_PD_GPU]         = DOMAIN_RK3576("gpu",    0x4, BIT(9),  0,      BIT(25), 0x0, BIT(0),  BIT(0),  BIT(0),  false),
> +       [RK3576_PD_NPU]         = DOMAIN_RK3576("npu",    0x0, BIT(0),  BIT(0), 0,       0x0, 0,       0,       0,       false, false),
> +       [RK3576_PD_NVM]         = DOMAIN_RK3576("nvm",    0x0, BIT(6),  0,      BIT(6),  0x4, BIT(2),  BIT(18), BIT(2),  false, true),
> +       [RK3576_PD_SDGMAC]      = DOMAIN_RK3576("sdgmac", 0x0, BIT(7),  0,      BIT(7),  0x4, BIT(1),  BIT(17), 0x6,     false, false),
> +       [RK3576_PD_AUDIO]       = DOMAIN_RK3576("audio",  0x0, BIT(8),  0,      BIT(8),  0x4, BIT(0),  BIT(16), BIT(0),  false, false),
> +       [RK3576_PD_PHP]         = DOMAIN_RK3576("php",    0x0, BIT(9),  0,      BIT(9),  0x0, BIT(15), BIT(15), BIT(15), false, false),
> +       [RK3576_PD_SUBPHP]      = DOMAIN_RK3576("subphp", 0x0, BIT(10), 0,      BIT(10), 0x0, 0,       0,       0,       false, false),
> +       [RK3576_PD_VOP]         = DOMAIN_RK3576("vop",    0x0, BIT(11), 0,      BIT(11), 0x0, 0x6000,  0x6000,  0x6000,  false, false),
> +       [RK3576_PD_VO1]         = DOMAIN_RK3576("vo1",    0x0, BIT(14), 0,      BIT(14), 0x0, BIT(12), BIT(12), 0x7000,  false, false),
> +       [RK3576_PD_VO0]         = DOMAIN_RK3576("vo0",    0x0, BIT(15), 0,      BIT(15), 0x0, BIT(11), BIT(11), 0x6800,  false, false),
> +       [RK3576_PD_USB]         = DOMAIN_RK3576("usb",    0x4, BIT(0),  0,      BIT(16), 0x0, BIT(10), BIT(10), 0x6400,  true,  false),
> +       [RK3576_PD_VI]          = DOMAIN_RK3576("vi",     0x4, BIT(1),  0,      BIT(17), 0x0, BIT(9),  BIT(9),  BIT(9),  false, false),
> +       [RK3576_PD_VEPU0]       = DOMAIN_RK3576("vepu0",  0x4, BIT(2),  0,      BIT(18), 0x0, BIT(7),  BIT(7),  0x280,   false, false),
> +       [RK3576_PD_VEPU1]       = DOMAIN_RK3576("vepu1",  0x4, BIT(3),  0,      BIT(19), 0x0, BIT(8),  BIT(8),  BIT(8),  false, false),
> +       [RK3576_PD_VDEC]        = DOMAIN_RK3576("vdec",   0x4, BIT(4),  0,      BIT(20), 0x0, BIT(6),  BIT(6),  BIT(6),  false, false),
> +       [RK3576_PD_VPU]         = DOMAIN_RK3576("vpu",    0x4, BIT(5),  0,      BIT(21), 0x0, BIT(5),  BIT(5),  BIT(5),  false, false),
> +       [RK3576_PD_NPUTOP]      = DOMAIN_RK3576("nputop", 0x4, BIT(6),  0,      BIT(22), 0x0, 0x18,    0x18,    0x18,    false, false),
> +       [RK3576_PD_NPU0]        = DOMAIN_RK3576("npu0",   0x4, BIT(7),  0,      BIT(23), 0x0, BIT(1),  BIT(1),  0x1a,    false, false),
> +       [RK3576_PD_NPU1]        = DOMAIN_RK3576("npu1",   0x4, BIT(8),  0,      BIT(24), 0x0, BIT(2),  BIT(2),  0x1c,    false, false),
> +       [RK3576_PD_GPU]         = DOMAIN_RK3576("gpu",    0x4, BIT(9),  0,      BIT(25), 0x0, BIT(0),  BIT(0),  BIT(0),  false, false),
>  };
>
>  static const struct rockchip_domain_info rk3588_pm_domains[] = {
>
> ---
> base-commit: 64e9fdfc89a76fed38d8ddeed72d42ec71957ed9
> change-id: 20250317-rk3576-emmc-fix-7dc81a627422
>
> Best regards,
> --
> Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
>

