Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8118AF8E02
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2019 12:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfKLLSu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Nov 2019 06:18:50 -0500
Received: from mail-eopbgr20063.outbound.protection.outlook.com ([40.107.2.63]:42335
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727661AbfKLLSp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 12 Nov 2019 06:18:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHwNlqFbnCqp9/RyW5BZwMkuUVEbpnEpGN+eW6sn+3l3qWwrO6NRlbZOD63YTwVJo2TCc7u6yItPP4zBj28zCRK/DLF1IHiTNY8fQ/FkFhtCtTPGg1wVcN95ans+YkJg4L4ds6II5JziUUsNKab5oZa+j0R+kDA8O2J4idwj2nuUMldXyen4KBQQgcxKjqHviMoG8WMhV1vla7ftke+8VAKDPVGQw51Ez5RnDOpAgM5SNXFMgrVQzDziD1P3aAwiZDSm6o1uGxrRCoKHKimRvIQoOHPQozQjw+G7y3afBpBZ3EtAfQbdzKBlaD7ZxyFgwSXixIs5rGVxtBETK8xgcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WT6j0VAgO9guqVEcCYsSLa/Vn+AN7lcTN5uVzEmKe4U=;
 b=Cl/MNZ0zkMP4auwyAkXAi7HpGF0LAML/ljeL4bUifT7fpoRR5ArOVhkZWA1mLQyDyOod7ps3p9DtJbm9fxM6pIV7+dZbeh1ZkTJe7ZS53YSGfPm2soCFyXf8XYclcpUVst1Pvk+nRLlEeKMV1T06DUr+T6Aw0iP6LYCeVpb9Ntukbb34sPF2y3fSGO5F5yQ6Gzqgi6ODm7+dub9LvyiuZpCfTVUYj6ik9HmOn1gyOUKN1ePprrwnJu0EmAP5YNsa1O4cHf348aCfSIGTQlf9KmcPe6T9RF736wfsupg7uSjBG+/4eNnpEQVPTU1u7mQYTweDHs4JEpP5NBwG3UFOXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WT6j0VAgO9guqVEcCYsSLa/Vn+AN7lcTN5uVzEmKe4U=;
 b=S6/8OSeOnbAM0skUuxyLIl3iPwqQR/7FOOoH3rPqnTdzeG7u1aPb88TqwS+sIvlWVUmIjBPkOs5WSRDEiQfK9tVQqZwxtUvgPyNl0fjAMG7fFMnIFS9hXq8q+8yfT1L0CBOwGTUG5YYRqJT4oXNRvYHNTNRjUCsWwfK7qdNzKS4=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB4051.eurprd04.prod.outlook.com (52.134.125.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Tue, 12 Nov 2019 11:18:41 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde%7]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 11:18:41 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>
CC:     Stephen Boyd <sboyd@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        =?iso-8859-2?Q?Artur_=A6wigo=F1?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Angus Ainslie <angus@akkea.ca>,
        Martin Kepplinger <martink@posteo.de>,
        Matthias Kaehlcke <mka@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 2/6] clk: imx: Mark dram pll on 8mm and 8mn with
 CLK_GET_RATE_NOCACHE
Thread-Topic: [PATCH v4 2/6] clk: imx: Mark dram pll on 8mm and 8mn with
 CLK_GET_RATE_NOCACHE
Thread-Index: AQHVloV7TZnkkId7Yky0Y9av5sUpE6eHaNKA
Date:   Tue, 12 Nov 2019 11:18:41 +0000
Message-ID: <20191112111839.jlshj6w567hzh6e7@fsr-ub1664-175>
References: <cover.1573252696.git.leonard.crestez@nxp.com>
 <e6230f49275e10e0cea625a8d806f3850ac2a29c.1573252696.git.leonard.crestez@nxp.com>
In-Reply-To: <e6230f49275e10e0cea625a8d806f3850ac2a29c.1573252696.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR02CA0032.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::45) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [89.37.124.34]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2deb979e-6c56-4ff8-468a-08d76762125a
x-ms-traffictypediagnostic: AM0PR04MB4051:|AM0PR04MB4051:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4051DEDDC2EBDBDAB132571FF6770@AM0PR04MB4051.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(366004)(199004)(189003)(66946007)(6436002)(9686003)(71200400001)(71190400001)(6512007)(1076003)(229853002)(14454004)(256004)(66476007)(64756008)(66446008)(6862004)(66066001)(4326008)(66556008)(6246003)(5660300002)(33716001)(6486002)(44832011)(6636002)(52116002)(7736002)(486006)(76176011)(476003)(446003)(25786009)(11346002)(54906003)(498600001)(86362001)(6116002)(3846002)(2906002)(7416002)(8936002)(6506007)(386003)(99286004)(53546011)(81166006)(81156014)(305945005)(26005)(186003)(8676002)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4051;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wTGoxY4cLG2SahgiiDBcg7IvS5VBTMsWd5XDpq92iZD/+/UDJettZS7V230Ktsw10UQ444S5NCLYb76W5PyElWBBkQ19agNtO1505YxCJ3q+1b0JtwAZjoa3ub+tzypaSD6+qP04iG7muDYIFmefnjLOznaB+hy2h4y6Jhthibk9+29FL++kmFSh7crW1PSKo7UCPDsCB5//AHPSGR76V3nKBN+lsZrkDyq/LUBbgcq7oLB5t5uf0AVwKu11puLEsrsX9B4syAzF49tjJooS0Yr/gxfdb3b1ji3v4PqL8Bw31SxjG5MvEhtLHcvPOLp3nZIG9vEgzdnVqvCZdcrUKoe3Arak4huXO9qzX3zcYKZj8nEemmhkmaoo0ww5tr2trToUD50S/NFow+Z2yCOQdgmLGJjXX5YZDOtv21VPDhQlft3/MLpy/b86ZtFSYghr
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <5C8B47F4FE43BA4E867456A48B2087B8@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2deb979e-6c56-4ff8-468a-08d76762125a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 11:18:41.0295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QquLOKwYWRWLxk4rwA1kzQp/NQSqJEp+wxBn12/TboXQhLRvG9T7gIyq17C3B5yJo1hMpFBGNtrhUTHtvugJBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4051
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19-11-09 00:39:52, Leonard Crestez wrote:
> DRAM frequency switches are executed in firmware and can change the
> configuration of the DRAM PLL outside linux. Mark these CLKs with
> CLK_GET_RATE_NOCACHE so we always read back the PLL config registers and
> recalculate rates.
>=20
> In current DRAM frequency tables on 8mm/8mn only the maximum frequency
> uses the PLL so it's always configured in the same way. However reading
> back the PLL configuration is the correct behavior and allows additional
> setpoints in the future.
>=20
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

This one looks fine.

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>

> ---
>  drivers/clk/imx/clk-imx8mm.c  | 2 +-
>  drivers/clk/imx/clk-imx8mn.c  | 2 +-
>  drivers/clk/imx/clk-pll14xx.c | 7 +++++++
>  drivers/clk/imx/clk.h         | 1 +
>  4 files changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
> index c58f988191a5..d500bac3afa1 100644
> --- a/drivers/clk/imx/clk-imx8mm.c
> +++ b/drivers/clk/imx/clk-imx8mm.c
> @@ -326,11 +326,11 @@ static int imx8mm_clocks_probe(struct platform_devi=
ce *pdev)
>  	clks[IMX8MM_SYS_PLL3_REF_SEL] =3D imx_clk_mux("sys_pll3_ref_sel", base =
+ 0x114, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> =20
>  	clks[IMX8MM_AUDIO_PLL1] =3D imx_clk_pll14xx("audio_pll1", "audio_pll1_r=
ef_sel", base, &imx_1443x_pll);
>  	clks[IMX8MM_AUDIO_PLL2] =3D imx_clk_pll14xx("audio_pll2", "audio_pll2_r=
ef_sel", base + 0x14, &imx_1443x_pll);
>  	clks[IMX8MM_VIDEO_PLL1] =3D imx_clk_pll14xx("video_pll1", "video_pll1_r=
ef_sel", base + 0x28, &imx_1443x_pll);
> -	clks[IMX8MM_DRAM_PLL] =3D imx_clk_pll14xx("dram_pll", "dram_pll_ref_sel=
", base + 0x50, &imx_1443x_pll);
> +	clks[IMX8MM_DRAM_PLL] =3D imx_clk_pll14xx("dram_pll", "dram_pll_ref_sel=
", base + 0x50, &imx_1443x_dram_pll);
>  	clks[IMX8MM_GPU_PLL] =3D imx_clk_pll14xx("gpu_pll", "gpu_pll_ref_sel", =
base + 0x64, &imx_1416x_pll);
>  	clks[IMX8MM_VPU_PLL] =3D imx_clk_pll14xx("vpu_pll", "vpu_pll_ref_sel", =
base + 0x74, &imx_1416x_pll);
>  	clks[IMX8MM_ARM_PLL] =3D imx_clk_pll14xx("arm_pll", "arm_pll_ref_sel", =
base + 0x84, &imx_1416x_pll);
>  	clks[IMX8MM_SYS_PLL1] =3D imx_clk_fixed("sys_pll1", 800000000);
>  	clks[IMX8MM_SYS_PLL2] =3D imx_clk_fixed("sys_pll2", 1000000000);
> diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
> index ca78cb1249a7..9c605ca1b631 100644
> --- a/drivers/clk/imx/clk-imx8mn.c
> +++ b/drivers/clk/imx/clk-imx8mn.c
> @@ -323,11 +323,11 @@ static int imx8mn_clocks_probe(struct platform_devi=
ce *pdev)
>  	clks[IMX8MN_SYS_PLL3_REF_SEL] =3D imx_clk_mux("sys_pll3_ref_sel", base =
+ 0x114, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> =20
>  	clks[IMX8MN_AUDIO_PLL1] =3D imx_clk_pll14xx("audio_pll1", "audio_pll1_r=
ef_sel", base, &imx_1443x_pll);
>  	clks[IMX8MN_AUDIO_PLL2] =3D imx_clk_pll14xx("audio_pll2", "audio_pll2_r=
ef_sel", base + 0x14, &imx_1443x_pll);
>  	clks[IMX8MN_VIDEO_PLL1] =3D imx_clk_pll14xx("video_pll1", "video_pll1_r=
ef_sel", base + 0x28, &imx_1443x_pll);
> -	clks[IMX8MN_DRAM_PLL] =3D imx_clk_pll14xx("dram_pll", "dram_pll_ref_sel=
", base + 0x50, &imx_1443x_pll);
> +	clks[IMX8MN_DRAM_PLL] =3D imx_clk_pll14xx("dram_pll", "dram_pll_ref_sel=
", base + 0x50, &imx_1443x_dram_pll);
>  	clks[IMX8MN_GPU_PLL] =3D imx_clk_pll14xx("gpu_pll", "gpu_pll_ref_sel", =
base + 0x64, &imx_1416x_pll);
>  	clks[IMX8MN_VPU_PLL] =3D imx_clk_pll14xx("vpu_pll", "vpu_pll_ref_sel", =
base + 0x74, &imx_1416x_pll);
>  	clks[IMX8MN_ARM_PLL] =3D imx_clk_pll14xx("arm_pll", "arm_pll_ref_sel", =
base + 0x84, &imx_1416x_pll);
>  	clks[IMX8MN_SYS_PLL1] =3D imx_clk_fixed("sys_pll1", 800000000);
>  	clks[IMX8MN_SYS_PLL2] =3D imx_clk_fixed("sys_pll2", 1000000000);
> diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.=
c
> index 5c458199060a..a6d31a7262ef 100644
> --- a/drivers/clk/imx/clk-pll14xx.c
> +++ b/drivers/clk/imx/clk-pll14xx.c
> @@ -65,10 +65,17 @@ struct imx_pll14xx_clk imx_1443x_pll =3D {
>  	.type =3D PLL_1443X,
>  	.rate_table =3D imx_pll1443x_tbl,
>  	.rate_count =3D ARRAY_SIZE(imx_pll1443x_tbl),
>  };
> =20
> +struct imx_pll14xx_clk imx_1443x_dram_pll =3D {
> +	.type =3D PLL_1443X,
> +	.rate_table =3D imx_pll1443x_tbl,
> +	.rate_count =3D ARRAY_SIZE(imx_pll1443x_tbl),
> +	.flags =3D CLK_GET_RATE_NOCACHE,
> +};
> +
>  struct imx_pll14xx_clk imx_1416x_pll =3D {
>  	.type =3D PLL_1416X,
>  	.rate_table =3D imx_pll1416x_tbl,
>  	.rate_count =3D ARRAY_SIZE(imx_pll1416x_tbl),
>  };
> diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
> index bc5bb6ac8636..81122c9ab842 100644
> --- a/drivers/clk/imx/clk.h
> +++ b/drivers/clk/imx/clk.h
> @@ -50,10 +50,11 @@ struct imx_pll14xx_clk {
>  	int flags;
>  };
> =20
>  extern struct imx_pll14xx_clk imx_1416x_pll;
>  extern struct imx_pll14xx_clk imx_1443x_pll;
> +extern struct imx_pll14xx_clk imx_1443x_dram_pll;
> =20
>  #define imx_clk_cpu(name, parent_name, div, mux, pll, step) \
>  	imx_clk_hw_cpu(name, parent_name, div, mux, pll, step)->clk
> =20
>  #define clk_register_gate2(dev, name, parent_name, flags, reg, bit_idx, =
\
> --=20
> 2.17.1
>=20
