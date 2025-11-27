Return-Path: <linux-pm+bounces-38796-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 413FBC8E2DB
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 13:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E44033AD6A1
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 12:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D3432B987;
	Thu, 27 Nov 2025 12:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.b="Z2RVFK4g"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26646264FB5;
	Thu, 27 Nov 2025 12:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764245110; cv=pass; b=LTI/11ITFaDzrEhoZMNJY00BYq2r7wqBZSQ58PALmiWMEqYy69WvddiqNsRIHBxjvDfBEIjCrhfzFfGG2WvS0JtSmMtsz2PvruamDAb5+DyqhNLfStGoD7DTRCF5Mg7mTHzV5nc94ARzI/pWton9IaHb+0XL9GE1ljKHCsqtYtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764245110; c=relaxed/simple;
	bh=Gk4RL3QXwW8PedMbLQTOtF+hMHkQcU+L5iXXuvtnA/I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=abOI9uZecIbepYUIOfUK0o5/ujvGlvtUMeDJOXxJ+MS3nARpTihRLwjvpT7MroSuCmjWIKqi3f38WrDtnP9MT06TDPzOg79fJ+bhMUPOow9Y7uCjnP3+HeSQ1xuX+slmi68hRWfKI2GXY67FH+LFG9OeGpU5/JhSMLR2Q9aUT8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.b=Z2RVFK4g; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1764245091; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=X4YWcMiHbCLL/4diT4rVYUhW/Bxl/H3tbk7dn+Li8x5MOJde9xS7KHrcZzFh6IwQh8SU15H0GleWAdf9RatURmv5ktIf1ifZuNE1T0dm5ijch7TFeiFfefujsqhXbv6nMaC3VLEUpY1PtC+hcf49uAGXOo7LzXAxEaj381Cn2kE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1764245091; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=CFLfGKSVFGD1/pcFLg7BhC+bfbUp1bOktlRYor4O/2g=; 
	b=eMBU7/96dViNDewnN9xuszKhKoTMlZeYl1vhn6WYhn74K9QDPWVSL2BMrCWl2sYEAuZclfK5wz8iVXsJS7NDVZQLMLRqWtyNyKivqUGzxPd/5TBeVQRDH77xA2LdgNeJjWQdUSbHUK94leEj2hkUAFPrHgUgF2k4SchV0FptjCQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=louisalexis.eyraud@collabora.com;
	dmarc=pass header.from=<louisalexis.eyraud@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764245091;
	s=zohomail; d=collabora.com; i=louisalexis.eyraud@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=CFLfGKSVFGD1/pcFLg7BhC+bfbUp1bOktlRYor4O/2g=;
	b=Z2RVFK4gTybvgI/Afj/eZTauAFVtk1cloP+iL0lnBrYKl2HllFL1GSBmOTl/A9Tv
	li8P70z1yljNfw5m4BjSB5jY4OPRxhQ/O63KYPD5ABlwJBiqxI9ROA5KN1xouIHRAO7
	81MdQzJJYePTDLJTnIZjYpA/o7ZkClgLj0IBcyiU=
Received: by mx.zohomail.com with SMTPS id 1764245089596783.6943561930424;
	Thu, 27 Nov 2025 04:04:49 -0800 (PST)
Message-ID: <54125e573504ad78649512f71cf7bd30c8cfd8a9.camel@collabora.com>
Subject: Re: [PATCH v3 04/21] clk: mediatek: Add MT8189 apmixedsys clock
 support
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
To: "irving.ch.lin" <irving-ch.lin@mediatek.com>, Michael Turquette	
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring	
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Ulf
 Hansson <ulf.hansson@linaro.org>, Richard Cochran	
 <richardcochran@gmail.com>
Cc: Qiqi Wang <qiqi.wang@mediatek.com>, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-pm@vger.kernel.org, netdev@vger.kernel.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com,
 sirius.wang@mediatek.com, 	vince-wl.liu@mediatek.com, jh.hsu@mediatek.com
Date: Thu, 27 Nov 2025 13:04:44 +0100
In-Reply-To: <20251106124330.1145600-5-irving-ch.lin@mediatek.com>
References: <20251106124330.1145600-1-irving-ch.lin@mediatek.com>
	 <20251106124330.1145600-5-irving-ch.lin@mediatek.com>
Organization: Collabora Ltd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

Hi Irving-CH,

On Thu, 2025-11-06 at 20:41 +0800, irving.ch.lin wrote:
> From: Irving-CH Lin <irving-ch.lin@mediatek.com>
>=20
> Add support for the MT8189 apmixedsys clock controller, which
> provides
> PLLs generated from SoC 26m.
>=20
> Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
> ---
> =C2=A0drivers/clk/mediatek/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 13 ++
> =C2=A0drivers/clk/mediatek/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/clk/mediatek/clk-mt8189-apmixedsys.c | 135
> +++++++++++++++++++
> =C2=A03 files changed, 149 insertions(+)
> =C2=A0create mode 100644 drivers/clk/mediatek/clk-mt8189-apmixedsys.c
>=20
> diff --git a/drivers/clk/mediatek/Kconfig
> b/drivers/clk/mediatek/Kconfig
> index 0e8dd82aa84e..2c898fd8a34c 100644
> --- a/drivers/clk/mediatek/Kconfig
> +++ b/drivers/clk/mediatek/Kconfig
> @@ -815,6 +815,19 @@ config COMMON_CLK_MT8188_WPESYS
> =C2=A0	help
> =C2=A0	=C2=A0 This driver supports MediaTek MT8188 Warp Engine clocks.
> =C2=A0
> +config COMMON_CLK_MT8189
> +	bool "Clock driver for MediaTek MT8189"
It should be a tristate so the whole MT8189 clock drivers could be
compiled as module like many other MTK SoC (MT8188, MT8192, MT8196...).

> +	depends on ARM64 || COMPILE_TEST
> +	select COMMON_CLK_MEDIATEK
> +	select COMMON_CLK_MEDIATEK_FHCTL
> +	default ARCH_MEDIATEK
> +	help
> +	=C2=A0 Enable this option to support the clock management for
> MediaTek MT8189 SoC. This
> +	=C2=A0 includes handling of all primary clock functions and
> features specific to the MT8189
> +	=C2=A0 platform. Enabling this driver ensures that the system's
> clock functionality aligns
> +	=C2=A0 with the MediaTek MT8189 hardware capabilities, providing
> efficient management of
> +	=C2=A0 clock speeds and power consumption.
> +
> =C2=A0config COMMON_CLK_MT8192
> =C2=A0	tristate "Clock driver for MediaTek MT8192"
> =C2=A0	depends on ARM64 || COMPILE_TEST
> diff --git a/drivers/clk/mediatek/Makefile
> b/drivers/clk/mediatek/Makefile
> index d8736a060dbd..66577ccb9b93 100644
> --- a/drivers/clk/mediatek/Makefile
> +++ b/drivers/clk/mediatek/Makefile
> @@ -123,6 +123,7 @@ obj-$(CONFIG_COMMON_CLK_MT8188_VDOSYS) +=3D clk-
> mt8188-vdo0.o clk-mt8188-vdo1.o
> =C2=A0obj-$(CONFIG_COMMON_CLK_MT8188_VENCSYS) +=3D clk-mt8188-venc.o
> =C2=A0obj-$(CONFIG_COMMON_CLK_MT8188_VPPSYS) +=3D clk-mt8188-vpp0.o clk-
> mt8188-vpp1.o
> =C2=A0obj-$(CONFIG_COMMON_CLK_MT8188_WPESYS) +=3D clk-mt8188-wpe.o
> +obj-$(CONFIG_COMMON_CLK_MT8189) +=3D clk-mt8189-apmixedsys.o
> =C2=A0obj-$(CONFIG_COMMON_CLK_MT8192) +=3D clk-mt8192-apmixedsys.o clk-
> mt8192.o
> =C2=A0obj-$(CONFIG_COMMON_CLK_MT8192_AUDSYS) +=3D clk-mt8192-aud.o
> =C2=A0obj-$(CONFIG_COMMON_CLK_MT8192_CAMSYS) +=3D clk-mt8192-cam.o
> diff --git a/drivers/clk/mediatek/clk-mt8189-apmixedsys.c
> b/drivers/clk/mediatek/clk-mt8189-apmixedsys.c
> new file mode 100644
> index 000000000000..8d67888737a2
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8189-apmixedsys.c
> @@ -0,0 +1,135 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2025 MediaTek Inc.
> + * Author: Qiqi Wang <qiqi.wang@mediatek.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#include "clk-mtk.h"
> +#include "clk-pll.h"
> +
> +#include <dt-bindings/clock/mediatek,mt8189-clk.h>
> +
> +#define MT8189_PLL_FMAX		(3800UL * MHZ)
> +#define MT8189_PLL_FMIN		(1500UL * MHZ)
> +#define MT8189_PLLEN_OFS	0x70
> +#define MT8189_INTEGER_BITS	8
> +
> +#define PLL_SETCLR(_id, _name, _reg, _en_setclr_bit,		\
> +			_rstb_setclr_bit, _flags, _pd_reg,	\
> +			_pd_shift, _tuner_reg, _tuner_en_reg,	\
> +			_tuner_en_bit, _pcw_reg, _pcw_shift,	\
> +			_pcwbits) {				\
> +		.id =3D _id,					\
> +		.name =3D _name,					\
> +		.en_reg =3D MT8189_PLLEN_OFS,			\
> +		.reg =3D _reg,					\
> +		.pll_en_bit =3D _en_setclr_bit,			\
> +		.rst_bar_mask =3D BIT(_rstb_setclr_bit),		\
> +		.flags =3D _flags,				\
> +		.fmax =3D MT8189_PLL_FMAX,			\
> +		.fmin =3D MT8189_PLL_FMIN,			\
> +		.pd_reg =3D _pd_reg,				\
> +		.pd_shift =3D _pd_shift,				\
> +		.tuner_reg =3D _tuner_reg,			\
> +		.tuner_en_reg =3D _tuner_en_reg,			\
> +		.tuner_en_bit =3D _tuner_en_bit,			\
> +		.pcw_reg =3D _pcw_reg,				\
> +		.pcw_shift =3D _pcw_shift,			\
> +		.pcwbits =3D _pcwbits,				\
> +		.pcwibits =3D MT8189_INTEGER_BITS,		\
> +	}
> +
> +static const struct mtk_pll_data apmixed_plls[] =3D {
> +	PLL_SETCLR(CLK_APMIXED_ARMPLL_LL, "armpll-ll", 0x204, 18,
> +		=C2=A0=C2=A0 0, PLL_AO, 0x208, 24, 0, 0, 0, 0x208, 0, 22),
> +	PLL_SETCLR(CLK_APMIXED_ARMPLL_BL, "armpll-bl", 0x214, 17,
> +		=C2=A0=C2=A0 0, PLL_AO, 0x218, 24, 0, 0, 0, 0x218, 0, 22),
> +	PLL_SETCLR(CLK_APMIXED_CCIPLL, "ccipll", 0x224, 16,
> +		=C2=A0=C2=A0 0, PLL_AO, 0x228, 24, 0, 0, 0, 0x228, 0, 22),
> +	PLL_SETCLR(CLK_APMIXED_MAINPLL, "mainpll", 0x304, 15,
> +		=C2=A0=C2=A0 23, HAVE_RST_BAR | PLL_AO,
> +		=C2=A0=C2=A0 0x308, 24, 0, 0, 0, 0x308, 0, 22),
> +	PLL_SETCLR(CLK_APMIXED_UNIVPLL, "univpll", 0x314, 14,
> +		=C2=A0=C2=A0 23, HAVE_RST_BAR, 0x318, 24, 0, 0, 0, 0x318, 0,
> 22),
> +	PLL_SETCLR(CLK_APMIXED_MMPLL, "mmpll", 0x324, 13,
> +		=C2=A0=C2=A0 23, HAVE_RST_BAR, 0x328, 24, 0, 0, 0, 0x328, 0,
> 22),
> +	PLL_SETCLR(CLK_APMIXED_MFGPLL, "mfgpll", 0x504, 7,
> +		=C2=A0=C2=A0 0, 0, 0x508, 24, 0, 0, 0, 0x508, 0, 22),
> +	PLL_SETCLR(CLK_APMIXED_APLL1, "apll1", 0x404, 11,
> +		=C2=A0=C2=A0 0, 0, 0x408, 24, 0x040, 0x00c, 0, 0x40c, 0, 32),
> +	PLL_SETCLR(CLK_APMIXED_APLL2, "apll2", 0x418, 10,
> +		=C2=A0=C2=A0 0, 0, 0x41c, 24, 0x044, 0x00c, 1, 0x420, 0, 32),
> +	PLL_SETCLR(CLK_APMIXED_EMIPLL, "emipll", 0x334, 12,
> +		=C2=A0=C2=A0 0, PLL_AO, 0x338, 24, 0, 0, 0, 0x338, 0, 22),
> +	PLL_SETCLR(CLK_APMIXED_APUPLL2, "apupll2", 0x614, 2,
> +		=C2=A0=C2=A0 0, 0, 0x618, 24, 0, 0, 0, 0x618, 0, 22),
> +	PLL_SETCLR(CLK_APMIXED_APUPLL, "apupll", 0x604, 3,
> +		=C2=A0=C2=A0 0, 0, 0x608, 24, 0, 0, 0, 0x608, 0, 22),
> +	PLL_SETCLR(CLK_APMIXED_TVDPLL1, "tvdpll1", 0x42c, 9,
> +		=C2=A0=C2=A0 0, 0, 0x430, 24, 0, 0, 0, 0x430, 0, 22),
> +	PLL_SETCLR(CLK_APMIXED_TVDPLL2, "tvdpll2", 0x43c, 8,
> +		=C2=A0=C2=A0 0, 0, 0x440, 24, 0, 0, 0, 0x440, 0, 22),
> +	PLL_SETCLR(CLK_APMIXED_ETHPLL, "ethpll", 0x514, 6,
> +		=C2=A0=C2=A0 0, 0, 0x518, 24, 0, 0, 0, 0x518, 0, 22),
> +	PLL_SETCLR(CLK_APMIXED_MSDCPLL, "msdcpll", 0x524, 5,
> +		=C2=A0=C2=A0 0, 0, 0x528, 24, 0, 0, 0, 0x528, 0, 22),
> +	PLL_SETCLR(CLK_APMIXED_UFSPLL, "ufspll", 0x534, 4,
> +		=C2=A0=C2=A0 0, 0, 0x538, 24, 0, 0, 0, 0x538, 0, 22),
> +};
> +
> +static const struct of_device_id of_match_clk_mt8189_apmixed[] =3D {
> +	{ .compatible =3D "mediatek,mt8189-apmixedsys" },
> +	{ /* sentinel */ }
> +};
This driver does not use the MODULE_DEVICE_TABLE() macro, needed for a
proper module support. It looks that it is also missing in all other
clock drivers of this patch series, so please add it in this driver and
others as well.

> +
> +static int clk_mt8189_apmixed_probe(struct platform_device *pdev)
> +{
> +	int r;
> +	struct clk_hw_onecell_data *clk_data;
> +	struct device_node *node =3D pdev->dev.of_node;
> +
> +	clk_data =3D mtk_alloc_clk_data(ARRAY_SIZE(apmixed_plls));
> +	if (!clk_data)
> +		return -ENOMEM;
> +
In the v1 patch review, Angelo raised a question about missing FHCTL
support in this driver. There was no reply about it and the driver
implementation did not change in the following patch revisions to add
its support.
Is there a reason that the FHCTL support is still not implemented?

> +	r =3D mtk_clk_register_plls(node, apmixed_plls,
> +				=C2=A0 ARRAY_SIZE(apmixed_plls),
> clk_data);
> +	if (r)
> +		goto free_apmixed_data;
> +
> +	r =3D of_clk_add_hw_provider(node, of_clk_hw_onecell_get,
> clk_data);
> +	if (r)
> +		goto unregister_plls;
> +
> +	platform_set_drvdata(pdev, clk_data);
> +
> +	return 0;
> +
> +unregister_plls:
> +	mtk_clk_unregister_plls(apmixed_plls,
> ARRAY_SIZE(apmixed_plls),
> +				clk_data);
> +free_apmixed_data:
> +	mtk_free_clk_data(clk_data);
> +	return r;
> +}
> +
> +static struct platform_driver clk_mt8189_apmixed_drv =3D {
> +	.probe =3D clk_mt8189_apmixed_probe,
It misses a remove callback implementation, so please add one.

> +	.driver =3D {
> +		.name =3D "clk-mt8189-apmixed",
> +		.of_match_table =3D of_match_clk_mt8189_apmixed,
> +	},
> +};
> +
> +module_platform_driver(clk_mt8189_apmixed_drv);
> +MODULE_LICENSE("GPL");
It would be better you also add a description with MODULE_DESCRIPTION()
macro and in the other new drivers of your patch series.

Regards,
Louis-Alexis

