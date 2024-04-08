Return-Path: <linux-pm+bounces-6052-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B50CB89BFA8
	for <lists+linux-pm@lfdr.de>; Mon,  8 Apr 2024 14:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBBA9B26018
	for <lists+linux-pm@lfdr.de>; Mon,  8 Apr 2024 12:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B320F762F7;
	Mon,  8 Apr 2024 12:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CvKsbuug"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCA77BB19
	for <linux-pm@vger.kernel.org>; Mon,  8 Apr 2024 12:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712580943; cv=none; b=Wq1Hi/rd5D5VQDDwP/WqGnKevUWs2bWRVEM3DHTaNcIINYgKGhxBFqYNcLnSEzJtU5LJENUikHrs/PabxKOR1MoUpnEBTZeBZiTi3OFrukR4n6WP4Gqd3QHvP9AbXepvO1sOIzsr9Y2pOw2kSNzqmfUdRXqAVVKkaIV2bs94ylY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712580943; c=relaxed/simple;
	bh=Z6eY4OmdwiwJCbiw49+rH+D8EMnFBgzPxGoyRKPf5kA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B1OMYvpTJgmjU8biFgzLa8u0MkfreOHfRwL4+zXfud9E2XcKggYO+Q0Pa/hgwRIV8htvnsgum9DA9z8lD+WS9uxU17rNv89lNq0vAhRts3ssS96nQtUsWhR0Z/u4AkYYTAW0Y4QxKZ22evuliGffhvoRnwqs7HUJm1xghTUbL6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CvKsbuug; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-617cd7bd929so34819927b3.3
        for <linux-pm@vger.kernel.org>; Mon, 08 Apr 2024 05:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712580940; x=1713185740; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VTyuvoKLXrF4zBNNDfLsJ1Gr6aBm90B+IQjTLLH6CxY=;
        b=CvKsbuugU/AwUJGBh5GTG9XBrwio6tNFfwAo+cNtelIfifg39ly/PovI31ayXN4iEI
         0b3Ytbz8Kf3xTI5hAj9Ec4I7la5wsSVSH0sA3YZakmN9KlM3npR2GffOX+/1FjDKF97w
         zHo6xNrldTSbCWCRYdQjvFDMxoXyfOzp25Sc9lozokszpdscHqeZ49aLB35v6GtZJVE2
         i07MSnO3xHwim64TCFd8oSdG3mkf9Uvuhd22N7g8nBnyxltJTQzZfKzg8hbWectqn++9
         LmswlCkJtJNBlMafIjFghYe0MdKwWAEf5qNU1jgQu0fuB5dCoMkowVnJIslG4/YCa4S8
         Bxww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712580940; x=1713185740;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VTyuvoKLXrF4zBNNDfLsJ1Gr6aBm90B+IQjTLLH6CxY=;
        b=U1fOThnJLPumib/u1NDUl4rNPCRHHVjVjhDPhSWVny6T6hHXQK6RAC484LAiPFQYp4
         dUk73W8y5yB8uFKP63in9r4el0Yu3F10r7edfw/72YooTxdJvY1oRlveU8gqCnm+bI/L
         35Enxzt5NcYur/joA2zSMI9LqYL94XtrK4tNYcHuCVDlwqQts9oje+q9hqTmIt9ip2iU
         bC6/W0CYnSUhX8Usgw7mEjOG+JlaLDS08Ksc7fRVv3UyTLLPbcHCRMpSkG8DKXHFkrEG
         OGDZg5T7sC5yCnL7WsldoTQhdYI6NzToH4sisScu0j+SJPQKV9MZtiml42wRgb/YioCB
         zlFA==
X-Forwarded-Encrypted: i=1; AJvYcCVB+l1hAB2R6aTHe0Av3Q/Y9B7MawNzFlHCPAx86EwVFatlsNLkzPUNy9KWBvEOhpZyahljcxGHCVcKQY00npoqdNNETVH+jo0=
X-Gm-Message-State: AOJu0Yx0I3snA/JgTaVvtlj7LqmlnQheRZk30DVCacUIYb9GhTWUJ4la
	r/jbkQMuy4ElE3tMmOCcQKD8knFNhKQwm648+ZrlVPDR8j4XY7L9VNh4FLcLYgWEneg8bQQhINm
	7+o7e8xtA+FWqSpQyjgMYLzKfRlKPzvEOEcCFaQ==
X-Google-Smtp-Source: AGHT+IFvXwpI9VHcLbTB0ZP1QIBFQuCv1eOj+aSbS4lA2YwxT+jKCNkyVBhCAqZTbT/YMU4v5nPjK2zQ2gh1fkKRvpw=
X-Received: by 2002:a25:83c9:0:b0:dc6:c2b2:c039 with SMTP id
 v9-20020a2583c9000000b00dc6c2b2c039mr6207448ybm.41.1712580939881; Mon, 08 Apr
 2024 05:55:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240225160616.15001-1-andre.przywara@arm.com> <20240225160616.15001-2-andre.przywara@arm.com>
In-Reply-To: <20240225160616.15001-2-andre.przywara@arm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 8 Apr 2024 14:55:04 +0200
Message-ID: <CAPDyKFptmNcbOTEs052yLGLxObWy7975fgpM3Kfg1TjMPVmeyA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] clk: sunxi-ng: h6-r: add GPU power domain
To: Andre Przywara <andre.przywara@arm.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>, Chen-Yu Tsai <wens@csie.org>, 
	Samuel Holland <samuel@sholland.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Sun, 25 Feb 2024 at 17:08, Andre Przywara <andre.przywara@arm.com> wrote:
>
> The Allwinner H616 features register 0x7010254 in the PRCM MMIO frame,
> where bit 0 needs to be cleared to enable operation of the Mali GPU.
> With this bit set (the reset default), any access to the Mali registers
> hangs the bus and thus the whole system. The BSP code clears this bit
> in U-Boot and their kernel never touches it again.

Is the bit representing a reset or power-rail? If it's a reset, it's
probably better to model it like that.

>
> Register a power-domain device to control this bit. Since we claim this
> MMIO region in the H6 R-CCU driver, add the code here, so that we don't
> need to artificially split the MMIO range in the DT.
> Since there seems to be at least one other register with similar behaviour
> nearby (0x7010260), make the power domain take one cell, even though we
> only support domain #0 for now.

Seems like we need some updated DT bindings too to cover this?

>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c | 84 ++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
>
> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
> index 02b28cfc5525e..363fb7a71e9f5 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
> @@ -4,9 +4,11 @@
>   */
>
>  #include <linux/clk-provider.h>
> +#include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
>
>  #include "ccu_common.h"
>  #include "ccu_reset.h"
> @@ -217,6 +219,86 @@ static const struct sunxi_ccu_desc sun50i_h616_r_ccu_desc = {
>         .num_resets     = ARRAY_SIZE(sun50i_h616_r_ccu_resets),
>  };
>
> +#define        PD_H616_GPU_REG                 0x254
> +
> +struct sun50i_h616_ppu_pd {
> +       struct generic_pm_domain        genpd;
> +       void __iomem                    *base;
> +};
> +
> +#define to_sun50i_h616_ppu_pd(_genpd) \
> +       container_of(_genpd, struct sun50i_h616_ppu_pd, genpd)
> +
> +static bool sun50i_h616_ppu_power_status(const struct sun50i_h616_ppu_pd *pd)
> +{
> +       return !readl(pd->base + PD_H616_GPU_REG);
> +}
> +
> +static int sun50i_h616_ppu_pd_set_power(const struct sun50i_h616_ppu_pd *pd,
> +                                       bool power_on)
> +{
> +       if (power_on)
> +               writel(0, pd->base + PD_H616_GPU_REG);
> +       else
> +               writel(1, pd->base + PD_H616_GPU_REG);
> +
> +       return 0;
> +}
> +
> +static int sun50i_h616_ppu_pd_power_on(struct generic_pm_domain *genpd)
> +{
> +       const struct sun50i_h616_ppu_pd *pd = to_sun50i_h616_ppu_pd(genpd);
> +
> +       return sun50i_h616_ppu_pd_set_power(pd, true);
> +}
> +
> +static int sun50i_h616_ppu_pd_power_off(struct generic_pm_domain *genpd)
> +{
> +       const struct sun50i_h616_ppu_pd *pd = to_sun50i_h616_ppu_pd(genpd);
> +
> +       return sun50i_h616_ppu_pd_set_power(pd, false);
> +}
> +
> +static int sun50i_h616_register_ppu(struct platform_device *pdev,
> +                                   void __iomem *base)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct genpd_onecell_data *ppu;
> +       struct sun50i_h616_ppu_pd *pd;
> +       int ret;
> +
> +       pd = devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
> +       if (!pd)
> +               return -ENOMEM;
> +
> +       ppu = devm_kzalloc(dev, sizeof(*ppu), GFP_KERNEL);
> +       if (!ppu)
> +               return -ENOMEM;
> +
> +       ppu->domains = devm_kzalloc(dev, sizeof(*ppu->domains), GFP_KERNEL);
> +       if (!ppu->domains)
> +               return -ENOMEM;
> +
> +       ppu->num_domains = 1;
> +       pd->genpd.name          = "GPU";
> +       pd->genpd.power_off     = sun50i_h616_ppu_pd_power_off;
> +       pd->genpd.power_on      = sun50i_h616_ppu_pd_power_on;
> +       pd->base                = base;
> +
> +       ret = pm_genpd_init(&pd->genpd, NULL, !sun50i_h616_ppu_power_status(pd));
> +       if (ret) {
> +               dev_warn(dev, "Failed to add GPU power domain: %d\n", ret);
> +               return ret;
> +       }
> +
> +       ppu->domains[0] = &pd->genpd;
> +       ret = of_genpd_add_provider_onecell(dev->of_node, ppu);
> +       if (ret)
> +               dev_warn(dev, "Failed to add provider: %d\n", ret);
> +
> +       return 0;
> +}
> +
>  static int sun50i_h6_r_ccu_probe(struct platform_device *pdev)
>  {
>         const struct sunxi_ccu_desc *desc;
> @@ -230,6 +312,8 @@ static int sun50i_h6_r_ccu_probe(struct platform_device *pdev)
>         if (IS_ERR(reg))
>                 return PTR_ERR(reg);
>
> +       sun50i_h616_register_ppu(pdev, reg);
> +
>         return devm_sunxi_ccu_probe(&pdev->dev, reg, desc);
>  }
>

In general (for maintenance reasons) it's a good idea to put genpd
providers under drivers/pmdomain/*. It looks like that should work
this case too, right?

Kind regards
Uffe

