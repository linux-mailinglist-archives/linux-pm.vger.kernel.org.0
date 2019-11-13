Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B959FAAF6
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2019 08:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfKMH32 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Nov 2019 02:29:28 -0500
Received: from mail-eopbgr70080.outbound.protection.outlook.com ([40.107.7.80]:61413
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725966AbfKMH31 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 13 Nov 2019 02:29:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bu3CmO/aiZrW619NsAcjPRVzzM5x/aYmu8Zc/qjST/PjUHybBGGAxpn+NHrpFk44bD1dVh9WOIS/QY4mXc/VyFt4UzwY/v3xlUvAVvhKVenUcKKhqVg5gPlhbQENU/vSQ4WoImyyNLr9cbK5B1jSDs9uT6Wbl9E8LEYFurDW8o944L6H4SP753OFLf5IpCukmH1f/fQzKVYJXQm3npkjZzrl5gv4b4phhp78dTihx3QsXf0o9D+/bJz8dBBW1sVCjM84Rw6Il7ktJ1tCEV+LP3ngKf2Q7DoeznPj/nPomLgi42W/80j0pN431WWZ0AEt4fIUzzlewUgjOmyoCM8Gag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9LdoxyajUVBdtWGcWtuZ2nCdtfZslONSipPx8DwjDs=;
 b=TmWOweXLIWgKnemJSg7HA6/4fESf6sF9wIJJatspGymKC9ZSGONGAY2Szh7r70p6PjKYtx4FyUyvKi26cI/iGRAQ1qaTsQxdNJJcR/FotPCqRZilUqdC/9AGfDNOUtaGDkY0lhNUwkMeVTF3xdZoYmF7Kl2VwXCpzEWQKBIdd0F9zDJbhyFRQaeGnemFtb+mp9FxywEMjc5B4vQjXZvUjyjKwjV4VdZAQpzOCjHvCmYVQBzRen0/V07LjqG1aSahmerAsv4U+//O7AGRcSdHe3yrHM6w5NfOjZXF9UV6jcg9OtQa2DvAx6KXnrNX9Dwp5K5Hjo1jm/3NeC3TGB9L7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9LdoxyajUVBdtWGcWtuZ2nCdtfZslONSipPx8DwjDs=;
 b=O4WJSbIT/VBTakAdfVnh0m15HKi+uLS/tDLndhDLQ1UuP32TFMJ+ttm7OnnoMT7UlLBcagzzEzAl/Rs0acNXePW6u7dZOX0uHxsrE2WtLvrJQcnkLsoHxv+pDVg9XALJKjsQosQvXcgoFYUeXoJo8l4i+uPlasfvTYbA4JYUq2E=
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com (52.135.138.150) by
 DB7PR04MB5260.eurprd04.prod.outlook.com (20.176.237.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.22; Wed, 13 Nov 2019 07:29:17 +0000
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::115f:1e4f:9ceb:2a2c]) by DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::115f:1e4f:9ceb:2a2c%7]) with mapi id 15.20.2430.028; Wed, 13 Nov 2019
 07:29:17 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Shawn Guo <shawnguo@kernel.org>,
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
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
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
Subject: RE: [PATCH v5 2/5] clk: imx: Mark dram pll on 8mm and 8mn with
 CLK_GET_RATE_NOCACHE
Thread-Topic: [PATCH v5 2/5] clk: imx: Mark dram pll on 8mm and 8mn with
 CLK_GET_RATE_NOCACHE
Thread-Index: AQHVmaNNQleGyf6L90SmwJ7UhRbhVKeItGPQ
Date:   Wed, 13 Nov 2019 07:29:17 +0000
Message-ID: <DB7PR04MB4490A934AC170E4BA1CD261788760@DB7PR04MB4490.eurprd04.prod.outlook.com>
References: <cover.1573595318.git.leonard.crestez@nxp.com>
 <65d08f34741f1ffa94a53bc128433e6c958091d2.1573595319.git.leonard.crestez@nxp.com>
In-Reply-To: <65d08f34741f1ffa94a53bc128433e6c958091d2.1573595319.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f15df55d-4adb-4bd5-a5cb-08d7680b3157
x-ms-traffictypediagnostic: DB7PR04MB5260:|DB7PR04MB5260:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB5260C6D53F061F3001C4E05C88760@DB7PR04MB5260.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(366004)(396003)(376002)(39860400002)(199004)(189003)(102836004)(55016002)(74316002)(86362001)(6116002)(7736002)(305945005)(3846002)(486006)(81156014)(81166006)(476003)(66476007)(8676002)(52536014)(7696005)(66946007)(7416002)(66446008)(66556008)(6506007)(44832011)(5660300002)(64756008)(76176011)(2906002)(6306002)(26005)(99286004)(9686003)(33656002)(6246003)(6436002)(478600001)(446003)(66066001)(4326008)(8936002)(966005)(14454004)(71190400001)(229853002)(256004)(76116006)(316002)(25786009)(54906003)(11346002)(110136005)(186003)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5260;H:DB7PR04MB4490.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4S80MecITYh2PixKWZmbdqg7EvDmpcvLq6nN708O1gNss8XI1rM3Q/fGBRYBpWl/rDWi7I5B2LnjBpE1FRXXdxaeAIs/UojN/kQs58s3Ni2a4VzTbS+z2eRUvFyp2E/9KuYBAn4KqO9DvGbedVJptJcC2plkHPjLHGoZAw0Neo0XheKr+bPHeMhdwK5BNc2IC30Ze+eDeh03eZUy7q6ENeWxozjOyV0chKnAFyI1FKIwhvDfdgTNzb8Fzd37TVC7skq4pmlsayIcwlqDXbIDRMZkZFOuR8C8p9hWj8KYIBDQlxnAeQabfPb5y79xsvVeSg+hon/f6GfiWOFdH4ZgKIwUMCI25QnrZ/ieyPszzi5EjApBzjj/lDfpONUTWlL/UInbSOMZR+KhBuvIgTCLNypUcCRNKftVcEBnHfK42ERi04c0n2vICZ5VyBBgxQGe
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f15df55d-4adb-4bd5-a5cb-08d7680b3157
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 07:29:17.6512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VBVzNuRc3894/rZAGMIFqTq115OQ//3WNT2QhPu+BQS+LqY6Vkl9S2hxgYRVR9i4/wx9wdEZ2g3iwjVjLwFXhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5260
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Leonard,

> Subject: [PATCH v5 2/5] clk: imx: Mark dram pll on 8mm and 8mn with
> CLK_GET_RATE_NOCACHE

This patch will conflict with https://patchwork.kernel.org/cover/11224933/
And I just post a new patch https://patchwork.kernel.org/patch/11241231/
=20
Then no need add imx_1443x_dram_pll

Regards,
Peng.

>=20
> DRAM frequency switches are executed in firmware and can change the
> configuration of the DRAM PLL outside linux. Mark these CLKs with
> CLK_GET_RATE_NOCACHE so we always read back the PLL config registers
> and recalculate rates.
>=20
> In current DRAM frequency tables on 8mm/8mn only the maximum frequency
> uses the PLL so it's always configured in the same way. However reading b=
ack
> the PLL configuration is the correct behavior and allows additional setpo=
ints in
> the future.
>=20
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  drivers/clk/imx/clk-imx8mm.c  | 2 +-
>  drivers/clk/imx/clk-imx8mn.c  | 2 +-
>  drivers/clk/imx/clk-pll14xx.c | 7 +++++++
>  drivers/clk/imx/clk.h         | 1 +
>  4 files changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
> index e2bc3c90d93c..9246e89bb5fd 100644
> --- a/drivers/clk/imx/clk-imx8mm.c
> +++ b/drivers/clk/imx/clk-imx8mm.c
> @@ -326,11 +326,11 @@ static int imx8mm_clocks_probe(struct
> platform_device *pdev)
>  	clks[IMX8MM_SYS_PLL3_REF_SEL] =3D imx_clk_mux("sys_pll3_ref_sel",
> base + 0x114, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
>=20
>  	clks[IMX8MM_AUDIO_PLL1] =3D imx_clk_pll14xx("audio_pll1",
> "audio_pll1_ref_sel", base, &imx_1443x_pll);
>  	clks[IMX8MM_AUDIO_PLL2] =3D imx_clk_pll14xx("audio_pll2",
> "audio_pll2_ref_sel", base + 0x14, &imx_1443x_pll);
>  	clks[IMX8MM_VIDEO_PLL1] =3D imx_clk_pll14xx("video_pll1",
> "video_pll1_ref_sel", base + 0x28, &imx_1443x_pll);
> -	clks[IMX8MM_DRAM_PLL] =3D imx_clk_pll14xx("dram_pll",
> "dram_pll_ref_sel", base + 0x50, &imx_1443x_pll);
> +	clks[IMX8MM_DRAM_PLL] =3D imx_clk_pll14xx("dram_pll",
> +"dram_pll_ref_sel", base + 0x50, &imx_1443x_dram_pll);
>  	clks[IMX8MM_GPU_PLL] =3D imx_clk_pll14xx("gpu_pll", "gpu_pll_ref_sel",
> base + 0x64, &imx_1416x_pll);
>  	clks[IMX8MM_VPU_PLL] =3D imx_clk_pll14xx("vpu_pll", "vpu_pll_ref_sel",
> base + 0x74, &imx_1416x_pll);
>  	clks[IMX8MM_ARM_PLL] =3D imx_clk_pll14xx("arm_pll", "arm_pll_ref_sel",
> base + 0x84, &imx_1416x_pll);
>  	clks[IMX8MM_SYS_PLL1] =3D imx_clk_fixed("sys_pll1", 800000000);
>  	clks[IMX8MM_SYS_PLL2] =3D imx_clk_fixed("sys_pll2", 1000000000); diff
> --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c index
> de905e278b80..4749beab9fc8 100644
> --- a/drivers/clk/imx/clk-imx8mn.c
> +++ b/drivers/clk/imx/clk-imx8mn.c
> @@ -323,11 +323,11 @@ static int imx8mn_clocks_probe(struct
> platform_device *pdev)
>  	clks[IMX8MN_SYS_PLL3_REF_SEL] =3D imx_clk_mux("sys_pll3_ref_sel",
> base + 0x114, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
>=20
>  	clks[IMX8MN_AUDIO_PLL1] =3D imx_clk_pll14xx("audio_pll1",
> "audio_pll1_ref_sel", base, &imx_1443x_pll);
>  	clks[IMX8MN_AUDIO_PLL2] =3D imx_clk_pll14xx("audio_pll2",
> "audio_pll2_ref_sel", base + 0x14, &imx_1443x_pll);
>  	clks[IMX8MN_VIDEO_PLL1] =3D imx_clk_pll14xx("video_pll1",
> "video_pll1_ref_sel", base + 0x28, &imx_1443x_pll);
> -	clks[IMX8MN_DRAM_PLL] =3D imx_clk_pll14xx("dram_pll",
> "dram_pll_ref_sel", base + 0x50, &imx_1443x_pll);
> +	clks[IMX8MN_DRAM_PLL] =3D imx_clk_pll14xx("dram_pll",
> +"dram_pll_ref_sel", base + 0x50, &imx_1443x_dram_pll);
>  	clks[IMX8MN_GPU_PLL] =3D imx_clk_pll14xx("gpu_pll", "gpu_pll_ref_sel",
> base + 0x64, &imx_1416x_pll);
>  	clks[IMX8MN_VPU_PLL] =3D imx_clk_pll14xx("vpu_pll", "vpu_pll_ref_sel",
> base + 0x74, &imx_1416x_pll);
>  	clks[IMX8MN_ARM_PLL] =3D imx_clk_pll14xx("arm_pll", "arm_pll_ref_sel",
> base + 0x84, &imx_1416x_pll);
>  	clks[IMX8MN_SYS_PLL1] =3D imx_clk_fixed("sys_pll1", 800000000);
>  	clks[IMX8MN_SYS_PLL2] =3D imx_clk_fixed("sys_pll2", 1000000000); diff
> --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.c ind=
ex
> 5c458199060a..a6d31a7262ef 100644
> --- a/drivers/clk/imx/clk-pll14xx.c
> +++ b/drivers/clk/imx/clk-pll14xx.c
> @@ -65,10 +65,17 @@ struct imx_pll14xx_clk imx_1443x_pll =3D {
>  	.type =3D PLL_1443X,
>  	.rate_table =3D imx_pll1443x_tbl,
>  	.rate_count =3D ARRAY_SIZE(imx_pll1443x_tbl),  };
>=20
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
>  	.rate_count =3D ARRAY_SIZE(imx_pll1416x_tbl),  }; diff --git
> a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h index
> bc5bb6ac8636..81122c9ab842 100644
> --- a/drivers/clk/imx/clk.h
> +++ b/drivers/clk/imx/clk.h
> @@ -50,10 +50,11 @@ struct imx_pll14xx_clk {
>  	int flags;
>  };
>=20
>  extern struct imx_pll14xx_clk imx_1416x_pll;  extern struct
> imx_pll14xx_clk imx_1443x_pll;
> +extern struct imx_pll14xx_clk imx_1443x_dram_pll;
>=20
>  #define imx_clk_cpu(name, parent_name, div, mux, pll, step) \
>  	imx_clk_hw_cpu(name, parent_name, div, mux, pll, step)->clk
>=20
>  #define clk_register_gate2(dev, name, parent_name, flags, reg, bit_idx, =
\
> --
> 2.17.1

