Return-Path: <linux-pm+bounces-21526-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEE1A2C00E
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 10:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1E5C188C3CF
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 09:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3331DE3B6;
	Fri,  7 Feb 2025 09:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TMFEZIZg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93DB1A23A9
	for <linux-pm@vger.kernel.org>; Fri,  7 Feb 2025 09:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738922356; cv=none; b=cAwd/yGsOXonPzkLqmpoG4WvzXahpCbPJNHq6whBGyIz2+f1Esf6xfXjcQpP11FWod7JWCTnhi+R+AQE8MJ2ttMfUN0P25VFyQyuvlw8wy5OTvzvTsP5pTA3lazT4+oXZUP8cnKEgqYqDagfASrEHgkEhfSijqIDcx4xUa1Ew/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738922356; c=relaxed/simple;
	bh=qSQOwDfvyyXkiyXC1rQhrd0jAPw0n+sW4OfWHKIBOEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NHNzbLVczXAx0mIBXyniDX4SbAbfo73seAOTsa9ovqEry0DWNAb35llpk8dMoNOlNi2pPv65NEW8lJYVgX2EuwIFntb+Ozo0mkl3Y/9EZHcAQuVyVTkLHp2BxhZG6xfe9VXQH3BO/vHYetE6B0LWhI8eIB2PrwoNfp/YQ1T5Ri8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TMFEZIZg; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e53a91756e5so1733287276.1
        for <linux-pm@vger.kernel.org>; Fri, 07 Feb 2025 01:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738922353; x=1739527153; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Gf0LrvYcosKWDvDGgr597DQ1T7Qoy8G5hPn243hyGLY=;
        b=TMFEZIZgNDiri9RhEHMzodCW6BN0IrnQK4uovPk2Kx9/Ggw3+j/XGVW3qTh4dmae+h
         WvQ4Nz3w5knOV6q/UyGuJlHY6vrwYBHs3YOZoW6FNMbU7U0iS8brUqxQtoe38cyPcrsz
         Kb+zftcZFoUFBeibC5k/X54zI2vQULWEWIt+DQZyRuJZYd3NugeAqx4DmljMX3kVPjWW
         Ueq8fblQ3QKQDHZgKic5m8SFm75n53oeaXPIbXj6FNHX/LWpdh39MhOQQtcO2R9ZuoQm
         5+tjlUGJksDLr/W8l/8jdi2KLsE7LBAbVicPPKCADVAunbRtc2py7nb6KB29tX+J5gPP
         tgqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738922353; x=1739527153;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gf0LrvYcosKWDvDGgr597DQ1T7Qoy8G5hPn243hyGLY=;
        b=OlBXKaxJtacBR28L3bpT83btQRseur0hTLITZmNL1kWW03lPHi74xyh7FplFv6wOEG
         RJ1VACUOujnRIXg+fOmY83Nh7LQKmOQ6j5KhZP3rceiw9y6JrpUdDIEqlNwu2M1JRdku
         FcXnpAuo0oChhPRQAqPDMIITwopV14VYjQRKNJF5E8mE2x/Am3+4CA/qUU8yr8BqWdu4
         gKgkZzyycZScgm16PPylJAoJnxLFeeoHGemmJbIgKc8t5pLghAFOdG0Vx+ADfInw0iG4
         p2+mS8eM9W1S/khZzV8btBzEn3ty9qSZo82U6vOyJ27XeQQaWc+rzhZXQT1DeMTyU9B0
         505Q==
X-Forwarded-Encrypted: i=1; AJvYcCUx1aHKT+8EL2MK5PDtOyOWlGCEB6cOhs10r53D8xAwe4Eg6DvWpx5u1BuXP8UF+waHPHsjxE/d3w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6IatU1HLeiLxdBAi4uo328NF4a+0nQYUG4+0gnOlQd8zY7IAB
	C4wxyvOFoAeK8WGmjMAyFwMlBI+M0quDd7Tt5q+FWDznTj6lQe9e0qKT6znZkLjjQxJm1P7HpQC
	FXZ9mdyrhQJgBQ/FJhBs2qiZlwFrvL5JSjUOngg==
X-Gm-Gg: ASbGncvhvIEoO+9SNliRr+kL8U95rEQ8pMn2CON/DaoN+MP8N6ESEB9RRBl4F8Vflcb
	rDs4kSDryIckWXKqLmKJqdzJLaH7AmV9OfHFF89+JRuF6AEw+JjaqMFmvTLRUD+b7g9rmJMX8lA
	==
X-Google-Smtp-Source: AGHT+IH5KSvolicRfu4qOrJsdB4fniYks3xqRvcTzEfp0JhqQeemLBX3Vf8Ymk/fgFqeo0ozvHmgtS8YxYLWOpq57BU=
X-Received: by 2002:a05:6902:2843:b0:e57:442a:befd with SMTP id
 3f1490d57ef6-e5b4626d7b2mr1976472276.32.1738922353648; Fri, 07 Feb 2025
 01:59:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1738736156-119203-1-git-send-email-shawn.lin@rock-chips.com> <1738736156-119203-5-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1738736156-119203-5-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 7 Feb 2025 10:58:37 +0100
X-Gm-Features: AWEUYZl9lFG-fTMV-hDb24r-jQPgTOeukyKtawA9RdKYwhSFpnLRSC7wetD3j4A
Message-ID: <CAPDyKFrHtB=986QicwCLbRYRmwZg9fT+cYxCYgwRN37w=D4nPw@mail.gmail.com>
Subject: Re: [PATCH v7 4/7] pmdomain: rockchip: Add smc call to inform firmware
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>, 
	YiFeng Zhao <zyf@rock-chips.com>, Liang Chen <cl@rock-chips.com>, linux-scsi@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Feb 2025 at 07:18, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> Inform firmware to keep the power domain on or off.
>
> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>
> Changes in v7: None
> Changes in v6: None
> Changes in v5:
> - fix a compile warning
>
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
>
>  drivers/pmdomain/rockchip/pm-domains.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
> index cb0f938..49842f1 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -5,6 +5,7 @@
>   * Copyright (c) 2015 ROCKCHIP, Co. Ltd.
>   */
>
> +#include <linux/arm-smccc.h>
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
>  #include <linux/err.h>
> @@ -20,6 +21,7 @@
>  #include <linux/regmap.h>
>  #include <linux/mfd/syscon.h>
>  #include <soc/rockchip/pm_domains.h>
> +#include <soc/rockchip/rockchip_sip.h>
>  #include <dt-bindings/power/px30-power.h>
>  #include <dt-bindings/power/rockchip,rv1126-power.h>
>  #include <dt-bindings/power/rk3036-power.h>
> @@ -540,6 +542,7 @@ static void rockchip_do_pmu_set_power_domain(struct rockchip_pm_domain *pd,
>         struct generic_pm_domain *genpd = &pd->genpd;
>         u32 pd_pwr_offset = pd->info->pwr_offset;
>         bool is_on, is_mem_on = false;
> +       struct arm_smccc_res res;
>
>         if (pd->info->pwr_mask == 0)
>                 return;
> @@ -567,6 +570,11 @@ static void rockchip_do_pmu_set_power_domain(struct rockchip_pm_domain *pd,
>                         genpd->name, is_on);
>                 return;
>         }
> +
> +       /* Inform firmware to keep this pd on or off */
> +       arm_smccc_smc(ROCKCHIP_SIP_SUSPEND_MODE, ROCKCHIP_SLEEP_PD_CONFIG,
> +                       pmu->info->pwr_offset + pd_pwr_offset,
> +                       pd->info->pwr_mask, on, 0, 0, 0, &res);
>  }
>
>  static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
> --
> 2.7.4
>

