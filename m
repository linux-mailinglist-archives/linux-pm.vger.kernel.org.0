Return-Path: <linux-pm+bounces-9222-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B8A909654
	for <lists+linux-pm@lfdr.de>; Sat, 15 Jun 2024 08:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6382B284B76
	for <lists+linux-pm@lfdr.de>; Sat, 15 Jun 2024 06:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA42915AC4;
	Sat, 15 Jun 2024 06:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZqRx9WEW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F1A3D60;
	Sat, 15 Jun 2024 06:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718433489; cv=none; b=TIm32EBYSwS4i7xNjk7zcUuB4csIIXOL2vPoOtR5ILmqEDrUAjnNA0n3JgneaTf0OIGUMVLyGszkjXyQqictNrTeYl+Mm/vLwjXZnIrdEwfq2cIXW1gtL46h7ELSYVCvAgVs6na7MH3lqhJ+J8PpI3httV4gPvHDgbM3YhsuxrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718433489; c=relaxed/simple;
	bh=3KCfEoLSbRk49SE6hTMUSazt4vE30jZwifvmCko0MxI=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=J+HkJrq66N69ray4HfiFjLl1eJtCjoNJtPwN3JOZ7SP+LNH6RBI6OqCLY+Ink1JZHffHoKDStDSqDK/rIUyAm+ixGx3P0lxE/llgdAOHnhTRAU5BvjmC+OG+EXvfaXPfNavOiUPh/QCO3H+xbqsxK+/OMGuDDyjHOqA638Q4ZIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ZqRx9WEW; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240615063802epoutp03937665879767c7bb38a494fd9922b629~ZGiW7zCER1672516725epoutp03U;
	Sat, 15 Jun 2024 06:38:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240615063802epoutp03937665879767c7bb38a494fd9922b629~ZGiW7zCER1672516725epoutp03U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1718433482;
	bh=vIwSYtTFXPS3sO38FNNQ6oJ71Y0bLvlrMHrlSuad46E=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=ZqRx9WEWTrFB0xPY+AKKfrl5bDsclQ3TWzUHUdAxvTY441omquggL+KXasoOMm0vb
	 TT+Pz6KIgcBpV+kxr0393uI0VDMBX9ZwbarTNJXaWh2vxCh9xsvWvGFQaMHx8xlyGI
	 iz4oghNbkk5GDaB2b8OoCpIX7Wn+XVPM7Cal+B2Q=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240615063801epcas5p14a1910659716b444f56195a7b2ec983b~ZGiWWyQ_Y0633306333epcas5p1F;
	Sat, 15 Jun 2024 06:38:01 +0000 (GMT)
Received: from epcpadp4 (unknown [182.195.40.18]) by epsnrtp4.localdomain
	(Postfix) with ESMTP id 4W1RKj3gpKz4x9Px; Sat, 15 Jun 2024 06:38:01 +0000
	(GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240614142920epcas5p15f5887136072ebf6c2e23275dd872861~Y5Uk66YwW0344703447epcas5p15;
	Fri, 14 Jun 2024 14:29:20 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240614142920epsmtrp2e40951f54cedb283a63bd26a75890a5d~Y5Uk39wd62550925509epsmtrp2Y;
	Fri, 14 Jun 2024 14:29:20 +0000 (GMT)
X-AuditID: b6c32a2a-73fff70000004a71-de-666c53c04e95
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	FD.07.19057.0C35C666; Fri, 14 Jun 2024 23:29:20 +0900 (KST)
Received: from INBRO002756 (unknown [107.122.12.5]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240614142913epsmtip17b1c18bda36c53de5d30099c1e4afd13~Y5UeC7Xu-3016230162epsmtip1U;
	Fri, 14 Jun 2024 14:29:13 +0000 (GMT)
From: "Alim Akhtar" <alim.akhtar@samsung.com>
To: "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>, "'Daniel
 Lezcano'" <daniel.lezcano@linaro.org>, "'Zhang Rui'" <rui.zhang@intel.com>,
	"'Lukasz Luba'" <lukasz.luba@arm.com>, "'Rob Herring'" <robh@kernel.org>,
	"'Conor Dooley'" <conor+dt@kernel.org>, "'Guillaume La Roque'"
	<glaroque@baylibre.com>, "'Krzysztof Kozlowski'" <krzk+dt@kernel.org>,
	"'Vasily Khoruzhick'" <anarsoul@gmail.com>, "'Chen-Yu Tsai'"
	<wens@csie.org>, "'Jernej Skrabec'" <jernej.skrabec@gmail.com>, "'Samuel
 Holland'" <samuel@sholland.org>, "'Shawn Guo'" <shawnguo@kernel.org>,
	"'Sascha Hauer'" <s.hauer@pengutronix.de>, "'Pengutronix	Kernel Team'"
	<kernel@pengutronix.de>, "'Fabio Estevam'" <festevam@gmail.com>, "'Anson
 Huang'" <Anson.Huang@nxp.com>, "'Thierry Reding'"
	<thierry.reding@gmail.com>, "'Jonathan Hunter'" <jonathanh@nvidia.com>,
	"'Dmitry	Baryshkov'" <dmitry.baryshkov@linaro.org>, "'Amit Kucheria'"
	<amitk@kernel.org>, =?utf-8?Q?'Niklas_S=C3=B6derlund'?=
	<niklas.soderlund@ragnatech.se>, "'Heiko	Stuebner'" <heiko@sntech.de>,
	"'Biju Das'" <biju.das.jz@bp.renesas.com>, "'Orson	Zhai'"
	<orsonzhai@gmail.com>, "'Baolin Wang'" <baolin.wang@linux.alibaba.com>,
	"'Chunyan Zhang'" <zhang.lyra@gmail.com>, "'Alexandre Torgue'"
	<alexandre.torgue@foss.st.com>, "'Pascal Paillet'" <p.paillet@foss.st.com>,
	"'Keerthy'" <j-keerthy@ti.com>, "'Broadcom internal kernel review list'"
	<bcm-kernel-feedback-list@broadcom.com>, "'Florian Fainelli'"
	<florian.fainelli@broadcom.com>, "'Scott Branden'" <sbranden@broadcom.com>,
	"'zhanghongchen'" <zhanghongchen@loongson.cn>, "'Matthias Brugger'"
	<matthias.bgg@gmail.com>, "'AngeloGioacchino Del Regno'"
	<angelogioacchino.delregno@collabora.com>, "'Bjorn Andersson'"
	<andersson@kernel.org>, "'Geert Uytterhoeven'" <geert+renesas@glider.be>
Cc: <linux-pm@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <imx@lists.linux.dev>,
	<linux-tegra@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
	<linux-renesas-soc@vger.kernel.org>, <linux-rockchip@lists.infradead.org>,
	<linux-stm32@st-md-mailman.stormreply.com>, "'Florian Fainelli'"
	<f.fainelli@gmail.com>, <linux-rpi-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <cpgs@samsung.com>
In-Reply-To: <20240614-dt-bindings-thermal-allof-v1-1-30b25a6ae24e@linaro.org>
Subject: RE: [PATCH 01/22] dt-bindings: thermal: samsung,exynos: specify
 cells
Date: Fri, 14 Jun 2024 19:59:11 +0530
Message-ID: <1891546521.01718433481489.JavaMail.epsvc@epcpadp4>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGhCdcVAXQc0tvKk5x9QOKQ/J0WewGh/L0BAiWHCW6yHH4lsA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUxTdxTG97+9vbfQ1ZSXyQUFTaPZgJXBNtlxGLLgy+6mEYxzyUwUGriC
	jJbaikPjMuhaMmA4wAn2dhRQxgoUcDBoQd5Sist0QMTZzTgQkAJdE/BtaN2gA7otfPudc57n
	OefD4XF89UQQ77jsJKOQSTJEhDfe3i8KEfcdzDgWWdPnAy5HGYL+ymzQXJtG0P7FDhipo8Ck
	TQZ39zUEjUUDOOjNCxgYu4cwcFhCQf84GCqtQ1woGXYR8HzOSsLE7Xhoah/jQIWuFEH1+QoC
	3JNOLmjHNARcN6kwmKlsQqBmL+FQf6EDBwc7RkC3s42EKh0fWu7bltN6B0m41fkNAbc+v4ng
	cZEVQZtjDoNH424OlNy9QsLF4R4MCmxTXPi6p5OA/CcsAdUqNQkq9RvwY9k5LpQ/0CHos5/H
	wd1lJmFq4hwBi6YWHGYm8wmYa5hCMPtDALg69Ti4LMMYfDfeScKCzcR55y3aqDciev43DUnX
	zepImr03SNDm0RpEX5ls4NL2r9pIumRQTHewoyR9ucuB0S31+QT9u62LoDsmttOtNZ/Rs61a
	ROeqLmEJQYe9d6QwGcdPMYrXYpO80yomj8ivCrK1PY2cHKTmFyAvHiV8kypW9RMr7Cu8iqie
	waOe/gbq1++LSQ/7UXVLM8vsvayZRlRtccmqgRCKKfPlPGJl4C80rqOeOn9eLTjCP3Cqdc7A
	9VgmEPW3NhdfsXgJ91P6R2pshf1WuHBqtY8Lt1JLzabVfQLhdupGo/Zf9qF+0no0HGE4Zb9j
	/59rq50cz32bKZe9dnkZb/mMOCq3GfNIAijHgJUsRn7smiR2TRK7JoldY6lCeD0KZORKaapU
	GSV/XcZ8EqGUSJVZstSI5ExpC1p94bAwM+qqfxBhQRgPWRDF44j8BWx1+jFfQYrk9BlGkZmo
	yMpglBa0gYeLAgQLzqIUX2Gq5CTzMcPIGcV/U4znFZSDiQsTbvzlGnCM2y9aXnSx3dh6d7D6
	thR921tqijm4N6r29FhDsnSbIeTILxttWXuHN/Gt9HO+7NShkS7/P63vvvrpfLugPjXOp9v8
	5QvwbGuVMyx8PPSjs+u8AqufGD7Aoj8M7Y8/Ec8e2FnObrHmtRXMzHTwRfO2QEfMdHJ4+qH7
	0YbBhUneotEwlLfNELm060xp2tMmjbJVoyPfbiu7uSt9T8zRVyLxu2HiskJL9Nl7vUEJUnq9
	vfA6P1E8nXnBbizdnb14J5jYJHsWm4UnvfRQRJa35ry/f+dS/3ujMXHNcjIEP6yPzdVAxImR
	Lfucs/LNOvW+AxUPX87anZS4MUOEK9MkUWEchVLyD7bfoqExBAAA
X-CMS-MailID: 20240614142920epcas5p15f5887136072ebf6c2e23275dd872861
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20240614094638epcas5p115d52130f45e130652b6f1d946358d19
References: <20240614-dt-bindings-thermal-allof-v1-0-30b25a6ae24e@linaro.org>
	<CGME20240614094638epcas5p115d52130f45e130652b6f1d946358d19@epcas5p1.samsung.com>
	<20240614-dt-bindings-thermal-allof-v1-1-30b25a6ae24e@linaro.org>

Hi Krzysztof,

> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Friday, June 14, 2024 3:16 PM
> To: Daniel Lezcano <daniel.lezcano@linaro.org
.stormreply.com;
> Subject: [PATCH 01/22] dt-bindings: thermal: samsung,exynos: specify cell=
s
>=20
> All Samsung Exynos SoCs Thermal Management Units have only one sensor, so
> make '#thermal-sensor-cells' fixed at 0.
>=20
This is not entirely true, there are SoCs which have multiple temp sensors.
It is true that currently only one sensor support is added though.

So we can leave this as is or you suggest to make it to support only one se=
nsor
(to match the current DT support), and later (in near future) change it aga=
in to
match what HW actually support?

> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml | =
3
> ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/thermal/samsung,exynos-
> thermal.yaml b/Documentation/devicetree/bindings/thermal/samsung,exynos-
> thermal.yaml
> index 1344df708e2d..29a08b0729ee 100644
> --- a/Documentation/devicetree/bindings/thermal/samsung,exynos-
> thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.y
> +++ aml
> @@ -61,7 +61,8 @@ properties:
>            TRIMINFO at 0x10068000 contains data for TMU channel 2
>      minItems: 1
>=20
> -  '#thermal-sensor-cells': true
> +  '#thermal-sensor-cells':
> +    const: 0
>=20
>    vtmu-supply:
>      description: The regulator node supplying voltage to TMU.
>=20
> --
> 2.43.0




