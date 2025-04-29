Return-Path: <linux-pm+bounces-26364-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0075AA080C
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 12:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 306844617E8
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 10:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFC32BE7D7;
	Tue, 29 Apr 2025 10:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ob2whYRQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509E52BE7C5
	for <linux-pm@vger.kernel.org>; Tue, 29 Apr 2025 10:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745921215; cv=none; b=hWqejJEl5LNTM3Y6PCLAmSDbsYk6XXsk6HkWl2ilflIN7Ckp/OpgJHNRA65PDqdmvomWkHYh6pmMnEdp3PNvKDjLo7g98c+5fMK1RBsRfdiigx8vLo0frEeB6hfQDcJd4bgm1NSH8r2vqFdsi9M8ZlzzqjNJ7fWBHAcUxS63TH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745921215; c=relaxed/simple;
	bh=U1IL5hommBa2Wv+FExNOtEc9rkh+55OUse5MfWOqQog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FRvmrcFPNOPQMgwOVXn87inLpgGhLhJMQ/AB1nNOdRPyJcdAjM201cAEJSFhDWGPclsZKyyFett9+o2LL/OJUfDk1+BUJI/0KJlEkuuVt4NVKZxxrcPyO+bAlJvewS9WHTDqyNk3K1irs1uhE5NM/B4CH3PpSkI4qhAvMxLgyCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ob2whYRQ; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7082ce1e47cso48523197b3.2
        for <linux-pm@vger.kernel.org>; Tue, 29 Apr 2025 03:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745921212; x=1746526012; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jjQQ1gbntdrSbZtDquO40Eje9JxI9rUu3v+V9iiuKlU=;
        b=Ob2whYRQtHGuz040o1Ucs8I8eAspDDPbj4vLhNA0FLx/Y/oiYV96VC0mttv0FjUNPZ
         3Ipo6SFq0eqtLtXCgioDx+cMcqYGw/tu56WRVC73K/Wl2HOl2ODxQyht1qSB//AQFYUi
         N1T9lShMlKig3y7P43jcySKN/6Dzrkk1R8NRwN1FzcW72ixhZrn0QFVkdbofN0ssNW51
         FpEOivK/XytpwPNQnSReEtYDC0eZ/nPM7AVeG+A1qHNiKgUyOSjeuSv+O5bl8M1lr/Kw
         Bi70atzAWO3lV9svYeWGT7KOwJgEXF5VPX70n2faYnA2Th9wF9/KXUjhhlaj4SW4Nb+G
         kQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745921212; x=1746526012;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jjQQ1gbntdrSbZtDquO40Eje9JxI9rUu3v+V9iiuKlU=;
        b=vGD+KqCS4rxViQNcwaDxv4mNcZUZGMHNE74z6efWg1ZkYONpslk8NTjHbIJ2YbxsQd
         P1qC37BkYaXf1ium8oQPikOPVwVYRrVqOeAx5qTMGJfX6kl3goXOTPbdRgpe9N8eZptt
         y4rUgGve4fF9n8h8pcFu7xcNyE8O3jyC+crRnAJ4PMriF9u4dY6ixeAMVN82t/f3fvO7
         XxIM0Fmm28PDHkBQfJC4McfqFy3U93M8jIE4+LbGaylWTolwpSHoW9LwpA3utI0ixkKv
         4peU/M3TspLaTsMK6oAp+3s3BZeTpHSeaE4O1TaTJMbMboTgm1v6HeVWQJWGIUpDpNE6
         5FqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJlmxX70ioM7KkFCBmpcGF+7v0y8u2s1AdfJ+ax7dffqhxzNZXmJYShiAwQwVF0dlHT2GnnJvbyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTzYxQ/7KqIa0a9h+AySvoXpLN6saCCGLkgoZHqY1REVs52HaV
	prrgpcKp1HXJthaAl/JY3N/ZOl+uIaUrIRur6L3XpCV5hWDEWgh85TuTIeN6Q6wyuAD+vDBb3Pd
	6R1VNkUxoX8yNJgqwAKLYcYzCyfXSPUpRCt8eng==
X-Gm-Gg: ASbGnctFOOTSMHxePmvK56/lOmV0S5Vrq2zfhebplEY2ZGKbsFckfpRB49oQruW5wyV
	iaO2MRU7Zq/N51t63pFvZRIiZzxu47NRC5l/ixA5ibEn2PL0h2+RyZsMCcdb5PDmLhtjYwYXm3m
	1ShvYFxH0NipY0vY7zMsorkrk=
X-Google-Smtp-Source: AGHT+IG6WmWyhSGVmxVC3f3XCypyrDEpbVGX6ioUnUsJtVsCpx9/EXtlcANtXZwlnV6IGsG9Jd4CkmBcfsgDrtEzaaQ=
X-Received: by 2002:a05:690c:3506:b0:703:b8f4:5b0e with SMTP id
 00721157ae682-7085f236277mr162475347b3.28.1745921212260; Tue, 29 Apr 2025
 03:06:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423-rk3576-emmc-fix-v3-1-0bf80e29967f@collabora.com>
In-Reply-To: <20250423-rk3576-emmc-fix-v3-1-0bf80e29967f@collabora.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 29 Apr 2025 12:06:16 +0200
X-Gm-Features: ATxdqUGRQt2dS-dYXQNUSdM9bjw6NNZW_Ep_w3cK8lN-p_Z_PHKTCdtR2wWOe8s
Message-ID: <CAPDyKFp5N23KCZwOTba6vGyk9eaS1-SjSqY52FfPDng-bahn6g@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: sdhci-of-dwcmshc: add PD workaround on RK3576
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
	Elaine Zhang <zhangqing@rock-chips.com>, Finley Xiao <finley.xiao@rock-chips.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, 
	Detlev Casanova <detlev.casanova@collabora.com>, kernel@collabora.com, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Apr 2025 at 09:54, Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
>
> RK3576's power domains have a peculiar design where the PD_NVM power
> domain, of which the sdhci controller is a part, seemingly does not have
> idempotent runtime disable/enable. The end effect is that if PD_NVM gets
> turned off by the generic power domain logic because all the devices
> depending on it are suspended, then the next time the sdhci device is
> unsuspended, it'll hang the SoC as soon as it tries accessing the CQHCI
> registers.
>
> RK3576's UFS support needed a new dev_pm_genpd_rpm_always_on function
> added to the generic power domains API to handle what appears to be a
> similar hardware design.
>
> Use this new function to ask for the same treatment in the sdhci
> controller by giving rk3576 its own platform data with its own postinit
> function. The benefit of doing this instead of marking the power domains
> always on in the power domain core is that we only do this if we know
> the platform we're running on actually uses the sdhci controller. For
> others, keeping PD_NVM always on would be a waste, as they won't run
> into this specific issue. The only other IP in PD_NVM that could be
> affected is FSPI0. If it gets a mainline driver, it will probably want
> to do the same thing.
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Changes in v3:
> - Reword comment and commit message to correct that this is not a
>   silicon bug, but seemingly intentional design with regards to runtime
>   power management.
> - Link to v2: https://lore.kernel.org/r/20250412-rk3576-emmc-fix-v2-1-830e653ad4f0@collabora.com
>
> Changes in v2:
> - Rewrite patch to use dev_pm_genpd_rpm_always_on in sdhci driver
>   instead, after Ulf Hansson made me aware of its existence
> - Link to v1: https://lore.kernel.org/r/20250408-rk3576-emmc-fix-v1-1-3009828b1b31@collabora.com
> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 40 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 09b9ab15e4995f0bddf57dd309c010c849be40d9..a20d03fdd6a93ecc5229c71f825bade5ac730370 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -17,6 +17,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/reset.h>
>  #include <linux/sizes.h>
> @@ -745,6 +746,29 @@ static void dwcmshc_rk35xx_postinit(struct sdhci_host *host, struct dwcmshc_priv
>         }
>  }
>
> +static void dwcmshc_rk3576_postinit(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
> +{
> +       struct device *dev = mmc_dev(host->mmc);
> +       int ret;
> +
> +       /*
> +        * This works around the design of the RK3576's power domains, which
> +        * makes the PD_NVM power domain, which the sdhci controller on the
> +        * RK3576 is in, never come back the same way once it's run-time
> +        * suspended once. This can happen during early kernel boot if no driver
> +        * is using either PD_NVM or its child power domain PD_SDGMAC for a
> +        * short moment, leading to it being turned off to save power. By
> +        * keeping it on, sdhci suspending won't lead to PD_NVM becoming a
> +        * candidate for getting turned off.
> +        */
> +       ret = dev_pm_genpd_rpm_always_on(dev, true);
> +       if (ret && ret != -EOPNOTSUPP)
> +               dev_warn(dev, "failed to set PD rpm always on, SoC may hang later: %pe\n",
> +                        ERR_PTR(ret));
> +
> +       dwcmshc_rk35xx_postinit(host, dwc_priv);
> +}
> +
>  static int th1520_execute_tuning(struct sdhci_host *host, u32 opcode)
>  {
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -1176,6 +1200,18 @@ static const struct dwcmshc_pltfm_data sdhci_dwcmshc_rk35xx_pdata = {
>         .postinit = dwcmshc_rk35xx_postinit,
>  };
>
> +static const struct dwcmshc_pltfm_data sdhci_dwcmshc_rk3576_pdata = {
> +       .pdata = {
> +               .ops = &sdhci_dwcmshc_rk35xx_ops,
> +               .quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> +                         SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
> +               .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> +                          SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
> +       },
> +       .init = dwcmshc_rk35xx_init,
> +       .postinit = dwcmshc_rk3576_postinit,
> +};
> +
>  static const struct dwcmshc_pltfm_data sdhci_dwcmshc_th1520_pdata = {
>         .pdata = {
>                 .ops = &sdhci_dwcmshc_th1520_ops,
> @@ -1274,6 +1310,10 @@ static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
>                 .compatible = "rockchip,rk3588-dwcmshc",
>                 .data = &sdhci_dwcmshc_rk35xx_pdata,
>         },
> +       {
> +               .compatible = "rockchip,rk3576-dwcmshc",
> +               .data = &sdhci_dwcmshc_rk3576_pdata,
> +       },
>         {
>                 .compatible = "rockchip,rk3568-dwcmshc",
>                 .data = &sdhci_dwcmshc_rk35xx_pdata,
>
> ---
> base-commit: f34da179a4517854b2ffbe4bce8c3405bd9be04e
> change-id: 20250317-rk3576-emmc-fix-7dc81a627422
>
> Best regards,
> --
> Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
>

