Return-Path: <linux-pm+bounces-3334-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF26D848C6B
	for <lists+linux-pm@lfdr.de>; Sun,  4 Feb 2024 10:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 499E2B22572
	for <lists+linux-pm@lfdr.de>; Sun,  4 Feb 2024 09:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFED14298;
	Sun,  4 Feb 2024 09:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PPwH+86c"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD66E18AF9
	for <linux-pm@vger.kernel.org>; Sun,  4 Feb 2024 09:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707038596; cv=none; b=SR2BZAsbPidThUIpsXXe3znINFng96Cp2VpMbG8Sx/RWwzIe5TKUH9pv+vt/6Qt3tysNdXOMu1//wQVA9inb+vBSPIrnpSbBep1KVkPV+0WUaPOR+TxWBCCezEE7bvGcv3Jdijr6Hvy/gNEH9cOCfHCw8peuFF3pA6q8bfA3GL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707038596; c=relaxed/simple;
	bh=hdkBNpC196nac8HRBSJaDgng6Wzm9V60GZHBu5bhZIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SRO7sFCxSXx9LW+I9SpS5KUBPMdRIBuafDYmJLPICyNpyH3Eukmjv0QGEtBL3QBYzK6EmxmQbIz38KE5eR1nzausHRHTXBIRz0BggXQ4HrVuBYx9MI+ofBXqfptC/sgwswpaKQXKrbX2qkBwJLRhCXUITj/ijElAIb8daq4ChDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PPwH+86c; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc6e0fe3195so2718491276.0
        for <linux-pm@vger.kernel.org>; Sun, 04 Feb 2024 01:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707038593; x=1707643393; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/jpuYG+EdQLizy4QqBGZn07wougvdBXcN1e2Mr1rzhc=;
        b=PPwH+86crE1DWSWWa5l+HMrZyFVXFi2L4Fo5nxjKeMzI4VzgSo1bzdY+VYoqEbG5Uj
         2g9Hl6fEwCoGQcP7/frW9CNT/2kmlVUpuyrJcG8v21y8iV0y94MSVjuF+kvdHcj/fCYi
         FYH97i9Pohvt7qKOJpTtXope9UEn8U+Omf/L4rrPsAPefjLdCB5EhK9fno1zAS55kIkA
         HvgC65pAjGgbHm/TNbUV+ayWKHGZ91h4QKp+zzdZSFjSuBop0FreN5BeNrK4JdeVWvaN
         lxYA43H8secdIfah0/Mvheg33HAGUIgQBO5YqRHG4YXF7xKdZ+f9d0BiKW0ZoZYWZxb9
         WKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707038593; x=1707643393;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/jpuYG+EdQLizy4QqBGZn07wougvdBXcN1e2Mr1rzhc=;
        b=skTvYq6SgaDR0q5JVME5MW2NbSrAEKiqEBD4365ZEaE1vIDCDRh1vugmB7Q/lfkhkT
         dyWTA0bLTlf7F1160xEleF4O0sTZLvnpm5JJDq/Ox/6NTtDOdCIk0JTAI2HDa3fPzXav
         qjslCZL2u6YXml2qYDK4SF9wlXHE7MeIzV2HICCCRvJWqeET4bcoavo8KEMbQ6ChjXcF
         xVGWc6b9BcVGETtaM3LhOl344Y2TyGg+pv0PjBb7wupsnTVvWFqMyGhH9kc+s9W1GKYZ
         7EB5WMUp0oCdBVcacYam7UmEmuXccNX5rt8ftPIGuQ4jomQenY70QrQhurTuWaNXs0FA
         ms9g==
X-Gm-Message-State: AOJu0YzgTblXNDPhWYmqLhb6Dm1awCLPzBi/AyLlkc6o4BFAQJyjWaQE
	tlC00wfD3N3+kmlmMVCH40zmS2cK3oa74f+m6zVH3/yfo54A9+5f/gneVJmSoKAxDlmsvurl+64
	20y0rJ9Zhs+s+mbmZjF/jNq0L0ICGipDv9jaSYQ==
X-Google-Smtp-Source: AGHT+IH+6aIPxyRh3mvo8zj6LoCTEA2WezKPM1eVxvYBfHARq8vhSf+rEtZZT+MgFJeC0Ki4LzPESO32enuMKM5VVA0=
X-Received: by 2002:a25:210:0:b0:dc2:48af:bf0c with SMTP id
 16-20020a250210000000b00dc248afbf0cmr10544490ybc.63.1707038593547; Sun, 04
 Feb 2024 01:23:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240203165307.7806-1-aford173@gmail.com> <20240203165307.7806-3-aford173@gmail.com>
In-Reply-To: <20240203165307.7806-3-aford173@gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 4 Feb 2024 10:23:02 +0100
Message-ID: <CAA8EJpo4omXogg48urEMzxQ+CA7DNTSf66pA6hoO8wpmtn_-MQ@mail.gmail.com>
Subject: Re: [PATCH V8 02/12] phy: freescale: add Samsung HDMI PHY
To: Adam Ford <aford173@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, marex@denx.de, 
	alexander.stein@ew.tq-group.com, frieder.schrempf@kontron.de, 
	Lucas Stach <l.stach@pengutronix.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	NXP Linux Team <linux-imx@nxp.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Liu Ying <victor.liu@nxp.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 3 Feb 2024 at 17:53, Adam Ford <aford173@gmail.com> wrote:
>
> From: Lucas Stach <l.stach@pengutronix.de>
>
> This adds the driver for the Samsung HDMI PHY found on the
> i.MX8MP SoC.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
> V4:  Make lookup table hex values lower case.
>
> V3:  Re-order the Makefile to keep it alphabetical
>      Remove unused defines
>
> V2:  Fixed some whitespace found from checkpatch
>      Change error handling when enabling apbclk to use dev_err_probe
>      Rebase on Linux-Next
>
>      I (Adam) tried to help move this along, so I took Lucas' patch and
>      attempted to apply fixes based on feedback.  I don't have
>      all the history, so apologies for that.
> ---
>  drivers/phy/freescale/Kconfig                |    6 +
>  drivers/phy/freescale/Makefile               |    1 +
>  drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 1075 ++++++++++++++++++
>  3 files changed, 1082 insertions(+)
>  create mode 100644 drivers/phy/freescale/phy-fsl-samsung-hdmi.c
>
> diff --git a/drivers/phy/freescale/Kconfig b/drivers/phy/freescale/Kconfig
> index 853958fb2c06..5c2b73042dfc 100644
> --- a/drivers/phy/freescale/Kconfig
> +++ b/drivers/phy/freescale/Kconfig
> @@ -35,6 +35,12 @@ config PHY_FSL_IMX8M_PCIE
>           Enable this to add support for the PCIE PHY as found on
>           i.MX8M family of SOCs.
>
> +config PHY_FSL_SAMSUNG_HDMI_PHY
> +       tristate "Samsung HDMI PHY support"
> +       depends on OF && HAS_IOMEM
> +       help
> +         Enable this to add support for the Samsung HDMI PHY in i.MX8MP.
> +
>  endif
>
>  config PHY_FSL_LYNX_28G
> diff --git a/drivers/phy/freescale/Makefile b/drivers/phy/freescale/Makefile
> index cedb328bc4d2..79e5f16d3ce8 100644
> --- a/drivers/phy/freescale/Makefile
> +++ b/drivers/phy/freescale/Makefile
> @@ -4,3 +4,4 @@ obj-$(CONFIG_PHY_MIXEL_LVDS_PHY)        += phy-fsl-imx8qm-lvds-phy.o
>  obj-$(CONFIG_PHY_MIXEL_MIPI_DPHY)      += phy-fsl-imx8-mipi-dphy.o
>  obj-$(CONFIG_PHY_FSL_IMX8M_PCIE)       += phy-fsl-imx8m-pcie.o
>  obj-$(CONFIG_PHY_FSL_LYNX_28G)         += phy-fsl-lynx-28g.o
> +obj-$(CONFIG_PHY_FSL_SAMSUNG_HDMI_PHY)  += phy-fsl-samsung-hdmi.o
> diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> new file mode 100644
> index 000000000000..bf0e2299d00f
> --- /dev/null
> +++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> @@ -0,0 +1,1075 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2020 NXP
> + * Copyright 2022 Pengutronix, Lucas Stach <kernel@pengutronix.de>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +
> +#define PHY_REG_33             0x84
> +#define  REG33_MODE_SET_DONE   BIT(7)
> +#define  REG33_FIX_DA          BIT(1)
> +
> +#define PHY_REG_34             0x88
> +#define  REG34_PHY_READY       BIT(7)
> +#define  REG34_PLL_LOCK                BIT(6)
> +#define  REG34_PHY_CLK_READY   BIT(5)
> +
> +
> +#define PHY_PLL_REGS_NUM 48
> +
> +struct phy_config {
> +       u32     clk_rate;
> +       u8 regs[PHY_PLL_REGS_NUM];
> +};
> +
> +const struct phy_config phy_pll_cfg[] = {
> +       {       22250000, {
> +                       0x00, 0xd1, 0x4b, 0xf1, 0x89, 0x88, 0x80, 0x40,
> +                       0x4f, 0x30, 0x33, 0x65, 0x00, 0x15, 0x25, 0x80,
> +                       0x6c, 0xf2, 0x67, 0x00, 0x10, 0x8f, 0x30, 0x32,
> +                       0x60, 0x8f, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00,
> +                       0x00, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +                       0x00, 0xe0, 0x83, 0x0f, 0x3e, 0xf8, 0x00, 0x00,
> +               },
> +       }, {
> +               23750000, {
> +                       0x00, 0xd1, 0x50, 0xf1, 0x86, 0x85, 0x80, 0x40,
> +                       0x4f, 0x30, 0x33, 0x65, 0x00, 0x03, 0x25, 0x80,
> +                       0x6c, 0xf2, 0x67, 0x00, 0x10, 0x8f, 0x30, 0x32,
> +                       0x60, 0x8f, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00,
> +                       0x00, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +                       0x00, 0xe0, 0x83, 0x0f, 0x3e, 0xf8, 0x00, 0x00,
> +               },

Generally I see that these entries contain a high level of duplication.
Could you please extract the common part and a rate-dependent part.
Next, it would be best if instead of writing the register values via
the rate LUT, the driver could calculate those values.
This allows us to support other HDMI modes if the need arises at some point.

> +       }, {
> +               24000000, {
> +                       0x00, 0xd1, 0x50, 0xf0, 0x00, 0x00, 0x80, 0x00,
> +                       0x4f, 0x30, 0x33, 0x65, 0x00, 0x01, 0x25, 0x80,
> +                       0x6c, 0xf2, 0x67, 0x00, 0x10, 0x8f, 0x30, 0x32,
> +                       0x60, 0x8f, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00,
> +                       0x00, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +                       0x00, 0xe0, 0x83, 0x0f, 0x3e, 0xf8, 0x00, 0x00,
> +               },


-- 
With best wishes
Dmitry

