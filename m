Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C994BF8E67
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2019 12:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbfKLLV4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Nov 2019 06:21:56 -0500
Received: from mail-eopbgr20087.outbound.protection.outlook.com ([40.107.2.87]:64066
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727281AbfKLLSK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 12 Nov 2019 06:18:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=beY1kPs0ItmyEC9ara0M/79wNC3BYsu7lskAXzhE2V2lbSORlCn106vXdSspAk1M7wc8nibubK8IsBUMIlaPMtNyvzXhxChj7rtpqECV8AqLcI+qSzR0AJGQaOtq3+U7Q+kIqHW7cHXnLO53uE7aJGXxJ89KwOYImXndPR0/2bCJyvuZ+8YVa7ZmSFjaDk6Mt70JSSIOk79odwWyWAu/34KTIFPlsmDOxL4FFTT1WLLIAj7KgU8YGHMvlZiXjfQmskL3LUsdw2ilI80uyMbZPhHaDv23XaN0LY8LF8wOmeeWA1tE92g5q0Is/nrEjksdmfiJAUbD9p7swVzqSawRIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6gVKOTRJEEcvDhtPX8de3LGPo8grudqnmZUlbE1h5g=;
 b=FQp/LKuiGKwoCs1NVmrAvEFFzgpq1jhEE2x2m5ul2mZDQbJ0oITC8vNl27dzGkZbxHwY6lP4nP2kjA2DNaP+ASW8afFMXmOHgz2lRtEbMYPnIefr7YSWksD70idpaPJfawNY4Dbv0j/uYiLaqtZn/O83a7YyM3LJTQRvNMoAZUmsp2wjLx/QigAJAG1p1gHF9kZIDbRZNXmggA4LUeSJydoqxCH1yl0APyBZEfG2cGAj/YJ95cWPDyWDiwSq3uzY0BWU2w2kQlwq1BHci4cHq7eM99LrZy1VSj2Vsh+sGbC85RfeJcCZyxizwenUBrTuk6IEpBffN2ai/lW6GfXibA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6gVKOTRJEEcvDhtPX8de3LGPo8grudqnmZUlbE1h5g=;
 b=nV3+sqX8Ow3LajG1lF8D5tnigXE657i0fBMZZstXB44D2aSUoojjuHyTX9ICnruKUYBwjVmyQAu3rIF80Wi+px0r0hk0ZEgvoVNBbJqvtI0kNuzEvSq2eRXq4qY+hSFFIYKnGB6c1tjQqq0kw6pm/JWtPn6e5zLRqmmmCJbj45Y=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB6113.eurprd04.prod.outlook.com (20.179.33.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.22; Tue, 12 Nov 2019 11:18:04 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde%7]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 11:18:04 +0000
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
Subject: Re: [PATCH v4 1/6] clk: imx8m: Set CLK_GET_RATE_NOCACHE on dram
 clocks
Thread-Topic: [PATCH v4 1/6] clk: imx8m: Set CLK_GET_RATE_NOCACHE on dram
 clocks
Thread-Index: AQHVloV7VZOJz0hWAkeO+G3807P1dqeHaKeA
Date:   Tue, 12 Nov 2019 11:18:04 +0000
Message-ID: <20191112111803.c5624in2masqipqf@fsr-ub1664-175>
References: <cover.1573252696.git.leonard.crestez@nxp.com>
 <0e0eeeee546a3bb664935184d66866f1c66458ce.1573252696.git.leonard.crestez@nxp.com>
In-Reply-To: <0e0eeeee546a3bb664935184d66866f1c66458ce.1573252696.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR0202CA0035.eurprd02.prod.outlook.com
 (2603:10a6:208:1::48) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [89.37.124.34]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7ac35b0d-7eec-436f-9fa9-08d76761fcb4
x-ms-traffictypediagnostic: AM0PR04MB6113:|AM0PR04MB6113:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB6113D9C5381B288DE3617C3FF6770@AM0PR04MB6113.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:843;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(376002)(39860400002)(366004)(346002)(136003)(396003)(189003)(199004)(86362001)(3846002)(33716001)(4326008)(6116002)(66066001)(6486002)(5660300002)(64756008)(66946007)(66446008)(66476007)(66556008)(6246003)(1076003)(478600001)(7736002)(316002)(44832011)(305945005)(7416002)(25786009)(6862004)(52116002)(99286004)(102836004)(76176011)(2906002)(6636002)(486006)(26005)(53546011)(6506007)(6512007)(71200400001)(9686003)(386003)(14454004)(6436002)(14444005)(186003)(8676002)(81156014)(229853002)(256004)(446003)(8936002)(54906003)(476003)(11346002)(71190400001)(81166006)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6113;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QLOnpDQ50oy4YYD3vso7LoVB1Q9PRHPgxPlAPXF8Q9K4+EXYQ1X/tMiHq4+tm+rqxvEtBinIDaO6qc6/w7XWVFOsCWuwCfpu+2/a0zKw1hqhEn4vxKpOrsvQdageglqMYn6rpyzq6yF+PRk4ZXMr2Mt1O000EWN0z8Is557gNEI+vIUzcFqAKByKJUgPm2/zO99QZSaXSlBs2lWYSzAhdR5DudNJw/+gJ89LT3YN74OvVkjl70rLBBDtVLALIGny68USCZWIkcpWMLjZ4aczMKvEjQBYkwTfBYv11nU89iscR1x4/U9FTP6LS2yg7y8bf02Rv2RdIL2qsiq0Y0de3vAvYCGmXkQdCRJ7QRuwKn/0A02H1Ec8Bh1ZBzunqhIjBtADBFt8snaNqku0d/8tjEXxgBta1LbB0bA2lJzwZPnLT/rLTnThAsTr7Orwire2
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <38B37E1CA4CBAC4B94040C69C2ECE4D2@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ac35b0d-7eec-436f-9fa9-08d76761fcb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 11:18:04.7257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C3AMSYKqQxkBy2umZK8AeBdBt2u8oQRYgtqCj+neXpEPrHz99WgVeppWFlyu0Rv9wzqPoZmZUhoW+5+gMGKZ1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6113
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19-11-09 00:39:51, Leonard Crestez wrote:
> These clocks are only modified as part of DRAM frequency switches during
> which DRAM itself is briefly inaccessible. The switch is performed with
> a SMC call to by TF-A which runs from a SRAM area; upon returning to
> linux several clocks bits are modified and we need to update them.
>=20
> For rate bits an easy solution is to just mark with
> CLK_GET_RATE_NOCACHE so that new rates are always read back from
> registers.
>=20
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/clk/imx/clk-imx8mm.c | 11 +++++++++--
>  drivers/clk/imx/clk-imx8mn.c | 12 ++++++++++--
>  drivers/clk/imx/clk-imx8mq.c | 15 +++++++++++----
>  3 files changed, 30 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
> index 030b15d7c0ce..c58f988191a5 100644
> --- a/drivers/clk/imx/clk-imx8mm.c
> +++ b/drivers/clk/imx/clk-imx8mm.c
> @@ -440,13 +440,20 @@ static int imx8mm_clocks_probe(struct platform_devi=
ce *pdev)
> =20
>  	/* IPG */
>  	clks[IMX8MM_CLK_IPG_ROOT] =3D imx_clk_divider2("ipg_root", "ahb", base =
+ 0x9080, 0, 1);
>  	clks[IMX8MM_CLK_IPG_AUDIO_ROOT] =3D imx_clk_divider2("ipg_audio_root", =
"audio_ahb", base + 0x9180, 0, 1);
> =20
> +	/*
> +	 * DRAM clocks are manipulated from TF-A outside clock framework.
> +	 * Mark with GET_RATE_NOCACHE to always read div value from hardware
> +	 */
> +	clks[IMX8MM_CLK_DRAM_ALT] =3D __imx8m_clk_composite("dram_alt", imx8mm_=
dram_alt_sels, base + 0xa000,
> +			CLK_GET_RATE_NOCACHE);
> +	clks[IMX8MM_CLK_DRAM_APB] =3D __imx8m_clk_composite("dram_apb", imx8mm_=
dram_apb_sels, base + 0xa080,
> +			CLK_IS_CRITICAL | CLK_GET_RATE_NOCACHE);
> +
>  	/* IP */
> -	clks[IMX8MM_CLK_DRAM_ALT] =3D imx8m_clk_composite("dram_alt", imx8mm_dr=
am_alt_sels, base + 0xa000);
> -	clks[IMX8MM_CLK_DRAM_APB] =3D imx8m_clk_composite_critical("dram_apb", =
imx8mm_dram_apb_sels, base + 0xa080);
>  	clks[IMX8MM_CLK_VPU_G1] =3D imx8m_clk_composite("vpu_g1", imx8mm_vpu_g1=
_sels, base + 0xa100);
>  	clks[IMX8MM_CLK_VPU_G2] =3D imx8m_clk_composite("vpu_g2", imx8mm_vpu_g2=
_sels, base + 0xa180);
>  	clks[IMX8MM_CLK_DISP_DTRC] =3D imx8m_clk_composite("disp_dtrc", imx8mm_=
disp_dtrc_sels, base + 0xa200);
>  	clks[IMX8MM_CLK_DISP_DC8000] =3D imx8m_clk_composite("disp_dc8000", imx=
8mm_disp_dc8000_sels, base + 0xa280);
>  	clks[IMX8MM_CLK_PCIE1_CTRL] =3D imx8m_clk_composite("pcie1_ctrl", imx8m=
m_pcie1_ctrl_sels, base + 0xa300);
> diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
> index 9f5a5a56b45e..ca78cb1249a7 100644
> --- a/drivers/clk/imx/clk-imx8mn.c
> +++ b/drivers/clk/imx/clk-imx8mn.c
> @@ -428,12 +428,20 @@ static int imx8mn_clocks_probe(struct platform_devi=
ce *pdev)
>  	clks[IMX8MN_CLK_AHB] =3D imx8m_clk_composite_critical("ahb", imx8mn_ahb=
_sels, base + 0x9000);
>  	clks[IMX8MN_CLK_AUDIO_AHB] =3D imx8m_clk_composite("audio_ahb", imx8mn_=
audio_ahb_sels, base + 0x9100);
>  	clks[IMX8MN_CLK_IPG_ROOT] =3D imx_clk_divider2("ipg_root", "ahb", base =
+ 0x9080, 0, 1);
>  	clks[IMX8MN_CLK_IPG_AUDIO_ROOT] =3D imx_clk_divider2("ipg_audio_root", =
"audio_ahb", base + 0x9180, 0, 1);
>  	clks[IMX8MN_CLK_DRAM_CORE] =3D imx_clk_mux2_flags("dram_core_clk", base=
 + 0x9800, 24, 1, imx8mn_dram_core_sels, ARRAY_SIZE(imx8mn_dram_core_sels),=
 CLK_IS_CRITICAL);
> -	clks[IMX8MN_CLK_DRAM_ALT] =3D imx8m_clk_composite("dram_alt", imx8mn_dr=
am_alt_sels, base + 0xa000);
> -	clks[IMX8MN_CLK_DRAM_APB] =3D imx8m_clk_composite_critical("dram_apb", =
imx8mn_dram_apb_sels, base + 0xa080);
> +
> +	/*
> +	 * DRAM clocks are manipulated from TF-A outside clock framework.
> +	 * Mark with GET_RATE_NOCACHE to always read div value from hardware
> +	 */
> +	clks[IMX8MN_CLK_DRAM_ALT] =3D __imx8m_clk_composite("dram_alt", imx8mn_=
dram_alt_sels, base + 0xa000,
> +			CLK_GET_RATE_NOCACHE);
> +	clks[IMX8MN_CLK_DRAM_APB] =3D __imx8m_clk_composite("dram_apb", imx8mn_=
dram_apb_sels, base + 0xa080,
> +			CLK_IS_CRITICAL | CLK_GET_RATE_NOCACHE);

nitpick: I think it looks better if we stick to one line each clock.=20
I know it's against the 80 chars rule, but at least is consistent.

> +
>  	clks[IMX8MN_CLK_DISP_PIXEL] =3D imx8m_clk_composite("disp_pixel", imx8m=
n_disp_pixel_sels, base + 0xa500);
>  	clks[IMX8MN_CLK_SAI2] =3D imx8m_clk_composite("sai2", imx8mn_sai2_sels,=
 base + 0xa600);
>  	clks[IMX8MN_CLK_SAI3] =3D imx8m_clk_composite("sai3", imx8mn_sai3_sels,=
 base + 0xa680);
>  	clks[IMX8MN_CLK_SAI5] =3D imx8m_clk_composite("sai5", imx8mn_sai5_sels,=
 base + 0xa780);
>  	clks[IMX8MN_CLK_SAI6] =3D imx8m_clk_composite("sai6", imx8mn_sai6_sels,=
 base + 0xa800);
> diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
> index 5f10a606d836..3e2ccc17dc66 100644
> --- a/drivers/clk/imx/clk-imx8mq.c
> +++ b/drivers/clk/imx/clk-imx8mq.c
> @@ -341,11 +341,12 @@ static int imx8mq_clocks_probe(struct platform_devi=
ce *pdev)
>  	clks[IMX8MQ_VIDEO_PLL1_OUT] =3D imx_clk_gate("video_pll1_out", "video_p=
ll1_bypass", base + 0x10, 21);
> =20
>  	clks[IMX8MQ_SYS1_PLL_OUT] =3D imx_clk_fixed("sys1_pll_out", 800000000);
>  	clks[IMX8MQ_SYS2_PLL_OUT] =3D imx_clk_fixed("sys2_pll_out", 1000000000)=
;
>  	clks[IMX8MQ_SYS3_PLL_OUT] =3D imx_clk_sccg_pll("sys3_pll_out", sys3_pll=
_out_sels, ARRAY_SIZE(sys3_pll_out_sels), 0, 0, 0, base + 0x48, CLK_IS_CRIT=
ICAL);
> -	clks[IMX8MQ_DRAM_PLL_OUT] =3D imx_clk_sccg_pll("dram_pll_out", dram_pll=
_out_sels, ARRAY_SIZE(dram_pll_out_sels), 0, 0, 0, base + 0x60, CLK_IS_CRIT=
ICAL);
> +	clks[IMX8MQ_DRAM_PLL_OUT] =3D imx_clk_sccg_pll("dram_pll_out", dram_pll=
_out_sels, ARRAY_SIZE(dram_pll_out_sels), 0, 0, 0, base + 0x60,
> +			CLK_IS_CRITICAL | CLK_GET_RATE_NOCACHE);
>  	clks[IMX8MQ_VIDEO2_PLL_OUT] =3D imx_clk_sccg_pll("video2_pll_out", vide=
o2_pll_out_sels, ARRAY_SIZE(video2_pll_out_sels), 0, 0, 0, base + 0x54, 0);
> =20
>  	/* SYS PLL1 fixed output */
>  	clks[IMX8MQ_SYS1_PLL_40M_CG] =3D imx_clk_gate("sys1_pll_40m_cg", "sys1_=
pll_out", base + 0x30, 9);
>  	clks[IMX8MQ_SYS1_PLL_80M_CG] =3D imx_clk_gate("sys1_pll_80m_cg", "sys1_=
pll_out", base + 0x30, 11);
> @@ -433,15 +434,21 @@ static int imx8mq_clocks_probe(struct platform_devi=
ce *pdev)
> =20
>  	/* IPG */
>  	clks[IMX8MQ_CLK_IPG_ROOT] =3D imx_clk_divider2("ipg_root", "ahb", base =
+ 0x9080, 0, 1);
>  	clks[IMX8MQ_CLK_IPG_AUDIO_ROOT] =3D imx_clk_divider2("ipg_audio_root", =
"audio_ahb", base + 0x9180, 0, 1);
> =20
> -	/* IP */
> +	/*
> +	 * DRAM clocks are manipulated from TF-A outside clock framework.
> +	 * Mark with GET_RATE_NOCACHE to always read div value from hardware
> +	 */
>  	clks[IMX8MQ_CLK_DRAM_CORE] =3D imx_clk_mux2_flags("dram_core_clk", base=
 + 0x9800, 24, 1, imx8mq_dram_core_sels, ARRAY_SIZE(imx8mq_dram_core_sels),=
 CLK_IS_CRITICAL);
> +	clks[IMX8MQ_CLK_DRAM_ALT] =3D __imx8m_clk_composite("dram_alt", imx8mq_=
dram_alt_sels, base + 0xa000,
> +			CLK_GET_RATE_NOCACHE);
> +	clks[IMX8MQ_CLK_DRAM_APB] =3D __imx8m_clk_composite("dram_apb", imx8mq_=
dram_apb_sels, base + 0xa080,
> +			CLK_IS_CRITICAL | CLK_GET_RATE_NOCACHE);
> =20
> -	clks[IMX8MQ_CLK_DRAM_ALT] =3D imx8m_clk_composite("dram_alt", imx8mq_dr=
am_alt_sels, base + 0xa000);
> -	clks[IMX8MQ_CLK_DRAM_APB] =3D imx8m_clk_composite_critical("dram_apb", =
imx8mq_dram_apb_sels, base + 0xa080);
> +	/* IP */
>  	clks[IMX8MQ_CLK_VPU_G1] =3D imx8m_clk_composite("vpu_g1", imx8mq_vpu_g1=
_sels, base + 0xa100);
>  	clks[IMX8MQ_CLK_VPU_G2] =3D imx8m_clk_composite("vpu_g2", imx8mq_vpu_g2=
_sels, base + 0xa180);
>  	clks[IMX8MQ_CLK_DISP_DTRC] =3D imx8m_clk_composite("disp_dtrc", imx8mq_=
disp_dtrc_sels, base + 0xa200);
>  	clks[IMX8MQ_CLK_DISP_DC8000] =3D imx8m_clk_composite("disp_dc8000", imx=
8mq_disp_dc8000_sels, base + 0xa280);
>  	clks[IMX8MQ_CLK_PCIE1_CTRL] =3D imx8m_clk_composite("pcie1_ctrl", imx8m=
q_pcie1_ctrl_sels, base + 0xa300);
> --=20
> 2.17.1
>=20
