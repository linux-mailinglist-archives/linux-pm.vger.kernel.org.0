Return-Path: <linux-pm+bounces-38831-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C465C8F707
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 17:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22A663A8015
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 16:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB8D338597;
	Thu, 27 Nov 2025 16:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.b="P4qFtpZc"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08956283FDD;
	Thu, 27 Nov 2025 16:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764259458; cv=pass; b=mgDuseY9y2Ylgs6G5TzUiEgLkwMnpiYB3L23odN+8Vob4B+QB3u3BZIT0aZXEHyGhkpBQYdy7faw+eaMHPJAXRpTbvtvEGnAuzkONr5mcYJD7nxyafwwHhyysQ9uMjaAYN3E680GJKU/de3tkwIXwl+z/+JFBWL4a7U1KnGlq/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764259458; c=relaxed/simple;
	bh=CK8C7zbAAIZw0tVSkk1o/s386NXmWpm4fxyQAkTU/OU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zu4JyjA7U8h7BRZCthfnBIp950MOYaIcPSNtxrGwyTer+aSuK2IWdXJN4w9QngbjGl2LWhGU5ZXjwXbKIB8fFm4wLn6xQ+V+0gbYLfn88VXtyM3cKAmR/umTnB9b2huhdx1DFF+t1a+7zq3t1e6pm4Wafct3t0T0AGCZ4wMQvtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.b=P4qFtpZc; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1764259438; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=e7IBtn7RBicEXXc4/NbAE5nfbr5yjyJj8X3r9sRPc8Nz/c9Z/5vViRaNVpvJR1o+iTAnuxZ0RHncZgkKv706WxhSZ0V8eDoEHnw+oM/dvjXGaR8yz3aOA/R3gVmujLccxGzrulnfmcs1/qh28D8yvIFJvrP+TfvZWZmBJ4a1Lgs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1764259438; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=NXBljqOkQmibVxUiEXvau0LbJcfUfLUNvajJz09nIfk=; 
	b=YCv3fV0lMt5wJVkhsf146+Pgp1KFaCf8TWKePeuSbBSH+uRBvQ9oPgZjA1yu0P2PVviY7Yqx2gKyLiYyCKi7WWTL/LxLDbGsV6QrG2xg27dQjo+fsVxkhlxEaMYRwE6zrfmg+UGZgMetoTbc1gHhrwACfbf+wCshK/RQzXSzd0M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=louisalexis.eyraud@collabora.com;
	dmarc=pass header.from=<louisalexis.eyraud@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764259438;
	s=zohomail; d=collabora.com; i=louisalexis.eyraud@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=NXBljqOkQmibVxUiEXvau0LbJcfUfLUNvajJz09nIfk=;
	b=P4qFtpZc7r0L+q7YqKsrk4bUNxySEMHJ4zmv5rBnLrKIH+IuRJIyXRoTUVjIBSRr
	BLWQ04F7klPmLIrIpORdfWkZhMVPBUghF7UvaRPd2vjm5tiksXgFXPYcyzShDCEBML0
	m8HK0VwWwD25VzOEfxZlCRuepN/5ISMaWnKPVYy4=
Received: by mx.zohomail.com with SMTPS id 1764259436750778.7782934792868;
	Thu, 27 Nov 2025 08:03:56 -0800 (PST)
Message-ID: <70c8fb8c07d2101a66f7ea897aa193a428cd9e03.camel@collabora.com>
Subject: Re: [PATCH v3 07/21] clk: mediatek: Add MT8189 vlpcfg clock support
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
Date: Thu, 27 Nov 2025 17:03:52 +0100
In-Reply-To: <20251106124330.1145600-8-irving-ch.lin@mediatek.com>
References: <20251106124330.1145600-1-irving-ch.lin@mediatek.com>
	 <20251106124330.1145600-8-irving-ch.lin@mediatek.com>
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
> Add support for the MT8189 vlpcfg clock controller,
> which provides clock gate control for vlp domain IPs.
>=20
> Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
> ---
> =C2=A0drivers/clk/mediatek/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
> =C2=A0drivers/clk/mediatek/clk-mt8189-vlpcfg.c | 121
> +++++++++++++++++++++++
> =C2=A02 files changed, 122 insertions(+), 1 deletion(-)
> =C2=A0create mode 100644 drivers/clk/mediatek/clk-mt8189-vlpcfg.c
>=20
> diff --git a/drivers/clk/mediatek/Makefile
> b/drivers/clk/mediatek/Makefile
> index 3b25df9e7b50..d9279b237b7b 100644
> --- a/drivers/clk/mediatek/Makefile
> +++ b/drivers/clk/mediatek/Makefile
> @@ -124,7 +124,7 @@ obj-$(CONFIG_COMMON_CLK_MT8188_VENCSYS) +=3D clk-
> mt8188-venc.o
> =C2=A0obj-$(CONFIG_COMMON_CLK_MT8188_VPPSYS) +=3D clk-mt8188-vpp0.o clk-
> mt8188-vpp1.o
> =C2=A0obj-$(CONFIG_COMMON_CLK_MT8188_WPESYS) +=3D clk-mt8188-wpe.o
> =C2=A0obj-$(CONFIG_COMMON_CLK_MT8189) +=3D clk-mt8189-apmixedsys.o clk-
> mt8189-topckgen.o \
> -				=C2=A0=C2=A0 clk-mt8189-vlpckgen.o
> +				=C2=A0=C2=A0 clk-mt8189-vlpckgen.o clk-mt8189-
> vlpcfg.o
> =C2=A0obj-$(CONFIG_COMMON_CLK_MT8192) +=3D clk-mt8192-apmixedsys.o clk-
> mt8192.o
> =C2=A0obj-$(CONFIG_COMMON_CLK_MT8192_AUDSYS) +=3D clk-mt8192-aud.o
> =C2=A0obj-$(CONFIG_COMMON_CLK_MT8192_CAMSYS) +=3D clk-mt8192-cam.o
> diff --git a/drivers/clk/mediatek/clk-mt8189-vlpcfg.c
> b/drivers/clk/mediatek/clk-mt8189-vlpcfg.c
> new file mode 100644
> index 000000000000..0508237a2b41
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8189-vlpcfg.c
> @@ -0,0 +1,121 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2025 MediaTek Inc.
> + * Author: Qiqi Wang <qiqi.wang@mediatek.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +
> +#include "clk-mtk.h"
> +#include "clk-gate.h"
> +
> +#include <dt-bindings/clock/mediatek,mt8189-clk.h>
> +
> +static const struct mtk_gate_regs vlpcfg_ao_reg_cg_regs =3D {
> +	.set_ofs =3D 0x0,
> +	.clr_ofs =3D 0x0,
> +	.sta_ofs =3D 0x0,
> +};
> +
> +#define GATE_VLPCFG_AO_REG(_id, _name, _parent, _shift) {	\
> +		.id =3D _id,				\
> +		.name =3D _name,				\
> +		.parent_name =3D _parent,			\
> +		.regs =3D &vlpcfg_ao_reg_cg_regs,		\
> +		.shift =3D _shift,			\
> +		.ops =3D &mtk_clk_gate_ops_no_setclr,	\
> +	}
You can use the GATE_MTK() macro from clk-gate.h to simplify this macro
code. It would give something like: =20
```
#define GATE_VLPCFG_AO_REG(_id, _name, _parent, _shift)	\
	GATE_MTK(_id, _name, _parent, &vlpcfg_ao_reg_cg_regs, _shift,
&mtk_clk_gate_ops_no_setclr)
```

There are other macros in your patch series that can be simplified with
GATE_MTK use as well.

> +
> +static const struct mtk_gate vlpcfg_ao_reg_clks[] =3D {
> +	GATE_VLPCFG_AO_REG(CLK_VLPCFG_AO_APEINT_RX,
> "vlpcfg_ao_apeint_rx", "clk26m", 8),
> +};
> +
> +static const struct mtk_clk_desc vlpcfg_ao_reg_mcd =3D {

> +	.clks =3D vlpcfg_ao_reg_clks,
> +	.num_clks =3D ARRAY_SIZE(vlpcfg_ao_reg_clks),
> +};
> +
> +static const struct mtk_gate_regs vlpcfg_reg_cg_regs =3D {
> +	.set_ofs =3D 0x4,
> +	.clr_ofs =3D 0x4,
> +	.sta_ofs =3D 0x4,
> +};
> +
> +#define GATE_VLPCFG_REG_FLAGS(_id, _name, _parent, _shift, _flags)
> {	\
> +		.id =3D _id,				\
> +		.name =3D _name,				\
> +		.parent_name =3D _parent,			\
> +		.regs =3D &vlpcfg_reg_cg_regs,		\
> +		.shift =3D _shift,			\
> +		.flags =3D _flags,			\
> +		.ops =3D &mtk_clk_gate_ops_no_setclr_inv,	\
> +	}
Similarly, the GATE_MTK_FLAGS() macro can be used to simplify this one
and other macros from your patch series.

Regards,
Louis-Alexis

> +
> +#define GATE_VLPCFG_REG(_id, _name, _parent, _shift)		\
> +	GATE_VLPCFG_REG_FLAGS(_id, _name, _parent, _shift, 0)
> +
> +static const struct mtk_gate vlpcfg_reg_clks[] =3D {
> +	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_SCP, "vlpcfg_scp",
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "vlp_scp_sel", 28, CLK_IS_CRITICAL),
> +	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_RG_R_APXGPT_26M,
> "vlpcfg_r_apxgpt_26m",
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "clk26m", 24, CLK_IS_CRITICAL),
> +	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_DPMSRCK_TEST,
> "vlpcfg_dpmsrck_test",
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "clk26m", 23, CLK_IS_CRITICAL),
> +	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_RG_DPMSRRTC_TEST,
> "vlpcfg_dpmsrrtc_test",
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "clk32k", 22, CLK_IS_CRITICAL),
> +	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_DPMSRULP_TEST,
> "vlpcfg_dpmsrulp_test",
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "osc_d10", 21, CLK_IS_CRITICAL),
> +	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_SPMI_P_MST,
> "vlpcfg_spmi_p",
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "vlp_spmi_p_sel", 20,
> CLK_IS_CRITICAL),
> +	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_SPMI_P_MST_32K,
> "vlpcfg_spmi_p_32k",
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "clk32k", 18, CLK_IS_CRITICAL),
> +	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_PMIF_SPMI_P_SYS,
> "vlpcfg_pmif_spmi_p_sys",
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "vlp_pwrap_ulposc_sel", 13,
> CLK_IS_CRITICAL),
> +	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_PMIF_SPMI_P_TMR,
> "vlpcfg_pmif_spmi_p_tmr",
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "vlp_pwrap_ulposc_sel", 12,
> CLK_IS_CRITICAL),
> +	GATE_VLPCFG_REG(CLK_VLPCFG_REG_PMIF_SPMI_M_SYS,
> "vlpcfg_pmif_spmi_m_sys",
> +			"vlp_pwrap_ulposc_sel", 11),
> +	GATE_VLPCFG_REG(CLK_VLPCFG_REG_PMIF_SPMI_M_TMR,
> "vlpcfg_pmif_spmi_m_tmr",
> +			"vlp_pwrap_ulposc_sel", 10),
> +	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_DVFSRC,
> "vlpcfg_dvfsrc",
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "vlp_dvfsrc_sel", 9, CLK_IS_CRITICAL),
> +	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_PWM_VLP,
> "vlpcfg_pwm_vlp",
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "vlp_pwm_vlp_sel", 8,
> CLK_IS_CRITICAL),
> +	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_SRCK, "vlpcfg_srck",
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "vlp_srck_sel", 7, CLK_IS_CRITICAL),
> +	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_SSPM_F26M,
> "vlpcfg_sspm_f26m",
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "vlp_sspm_f26m_sel", 4,
> CLK_IS_CRITICAL),
> +	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_SSPM_F32K,
> "vlpcfg_sspm_f32k",
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "clk32k", 3, CLK_IS_CRITICAL),
> +	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_SSPM_ULPOSC,
> "vlpcfg_sspm_ulposc",
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "vlp_sspm_ulposc_sel", 2,
> CLK_IS_CRITICAL),
> +	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_VLP_32K_COM,
> "vlpcfg_vlp_32k_com",
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "clk32k", 1, CLK_IS_CRITICAL),
> +	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_VLP_26M_COM,
> "vlpcfg_vlp_26m_com",
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "clk26m", 0, CLK_IS_CRITICAL),
> +};
> +
> +static const struct mtk_clk_desc vlpcfg_reg_mcd =3D {
> +	.clks =3D vlpcfg_reg_clks,
> +	.num_clks =3D ARRAY_SIZE(vlpcfg_reg_clks),
> +};
> +
> +static const struct of_device_id of_match_clk_mt8189_vlpcfg[] =3D {
> +	{ .compatible =3D "mediatek,mt8189-vlp-ao", .data =3D
> &vlpcfg_ao_reg_mcd },
> +	{ .compatible =3D "mediatek,mt8189-vlpcfg-ao", .data =3D
> &vlpcfg_reg_mcd },
> +	{ /* sentinel */ }
> +};
> +
> +static struct platform_driver clk_mt8189_vlpcfg_drv =3D {
> +	.probe =3D mtk_clk_simple_probe,
> +	.driver =3D {
> +		.name =3D "clk-mt8189-vlpcfg",
> +		.of_match_table =3D of_match_clk_mt8189_vlpcfg,
> +	},
> +};
> +
> +module_platform_driver(clk_mt8189_vlpcfg_drv);
> +MODULE_LICENSE("GPL");

