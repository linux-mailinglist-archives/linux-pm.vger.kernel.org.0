Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED2EA60137
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2019 09:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfGEHBN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Jul 2019 03:01:13 -0400
Received: from mail-eopbgr20078.outbound.protection.outlook.com ([40.107.2.78]:11654
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726012AbfGEHBN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 Jul 2019 03:01:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7Sb5iXnQeq6a4whQIZqloWLVF73UJr240vQ6vJkYPY=;
 b=F3EJXJly6N0kYOQvvHDl7H0nhoHJK0dMcCZMVg0jozw+OiLOonNPnxYqMTezEpJW70wtuMnGBDrCCUcxjreXrMcm1/3GdrpMYRnoHbfag4b/dpGkEz8ftZnn+RjClRXYAt28/54E40JRYzp2+1KYp/sAsNNfmnIIbfFgNQu3mNw=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB6467.eurprd04.prod.outlook.com (20.179.253.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Fri, 5 Jul 2019 07:01:08 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::a126:d121:200:367]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::a126:d121:200:367%7]) with mapi id 15.20.2032.019; Fri, 5 Jul 2019
 07:01:08 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>
CC:     "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 5/6] clk: imx8mq: Remove CLK_IS_CRITICAL flag for
 IMX8MQ_CLK_TMU_ROOT
Thread-Topic: [PATCH 5/6] clk: imx8mq: Remove CLK_IS_CRITICAL flag for
 IMX8MQ_CLK_TMU_ROOT
Thread-Index: AQHVMu9QFutD3B96ckCJ5EoT7khMLqa7mPeA
Date:   Fri, 5 Jul 2019 07:01:08 +0000
Message-ID: <20190705070107.xsxvnh7b36w4q4c6@fsr-ub1664-175>
References: <20190705045612.27665-1-Anson.Huang@nxp.com>
 <20190705045612.27665-5-Anson.Huang@nxp.com>
In-Reply-To: <20190705045612.27665-5-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7684758f-e8cb-482a-b8b0-08d701168e4d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6467;
x-ms-traffictypediagnostic: AM0PR04MB6467:
x-microsoft-antispam-prvs: <AM0PR04MB646733A05AF6FEDFEC7A1F12F6F50@AM0PR04MB6467.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-forefront-prvs: 008960E8EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(376002)(396003)(366004)(346002)(136003)(39860400002)(189003)(199004)(6116002)(99286004)(14444005)(102836004)(256004)(5660300002)(6506007)(64756008)(66446008)(66556008)(6486002)(3846002)(2906002)(229853002)(6862004)(76176011)(6436002)(26005)(4326008)(71200400001)(86362001)(14454004)(6512007)(25786009)(71190400001)(9686003)(53546011)(186003)(66066001)(44832011)(54906003)(305945005)(476003)(11346002)(8936002)(1076003)(7736002)(486006)(478600001)(8676002)(81166006)(33716001)(81156014)(6636002)(68736007)(66946007)(6246003)(66476007)(316002)(73956011)(446003)(7416002)(91956017)(76116006)(53936002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6467;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yRndkOOzP1IjQoa9e0O0lRa0djhHRhUDJq9EGcWsEGysrDhAt9g97LiiFDlaUTNV35w4x2m7hzeObgcG9fNNXRgKxEQmNTjGBja9Ep96602mspQ8bPCA7Xf+5pITd1YbQ4Ij6izQEFW1l3TpcJwCjYfMBZwLp134XRodxcXyQ9vpqFS52jqjcUF4+IahWizFAHvZrG4dTRxuybJtyyerT+Yl3AZUgTVengyOkMrVqprAv5Fm4O1RTEyGoVS6JpKyaaQHhals2BIO5e8skwACooRmsJPzENZ5fhM4n3TK1Vnjdib6EUxOiJmXlMxO6C00i70hIoD0c5SMXsdGc9ICgonlRc3/nopnYd+8ZU/VwthieYmp0REPkJEh5ciduW6EJwmMJUS4iiCTQcJ//TrpnZPYNygN0x0uDQAHjSCUNSk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F7A714F4FD2FF54F9AF66368F4FEFA79@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7684758f-e8cb-482a-b8b0-08d701168e4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2019 07:01:08.2502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: abel.vesa@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6467
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19-07-05 12:56:11, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
>=20
> IMX8MQ_CLK_TMU_ROOT is ONLY used for thermal module, the driver
> should manage this clock, so no need to have CLK_IS_CRITICAL flag
> set.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>

> ---
>  drivers/clk/imx/clk-imx8mq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
> index d407a07..91de69a 100644
> --- a/drivers/clk/imx/clk-imx8mq.c
> +++ b/drivers/clk/imx/clk-imx8mq.c
> @@ -539,7 +539,7 @@ static int imx8mq_clocks_probe(struct platform_device=
 *pdev)
>  	clks[IMX8MQ_CLK_DISP_AXI_ROOT]  =3D imx_clk_gate2_shared2("disp_axi_roo=
t_clk", "disp_axi", base + 0x45d0, 0, &share_count_dcss);
>  	clks[IMX8MQ_CLK_DISP_APB_ROOT]  =3D imx_clk_gate2_shared2("disp_apb_roo=
t_clk", "disp_apb", base + 0x45d0, 0, &share_count_dcss);
>  	clks[IMX8MQ_CLK_DISP_RTRM_ROOT] =3D imx_clk_gate2_shared2("disp_rtrm_ro=
ot_clk", "disp_rtrm", base + 0x45d0, 0, &share_count_dcss);
> -	clks[IMX8MQ_CLK_TMU_ROOT] =3D imx_clk_gate4_flags("tmu_root_clk", "ipg_=
root", base + 0x4620, 0, CLK_IS_CRITICAL);
> +	clks[IMX8MQ_CLK_TMU_ROOT] =3D imx_clk_gate4("tmu_root_clk", "ipg_root",=
 base + 0x4620, 0);
>  	clks[IMX8MQ_CLK_VPU_DEC_ROOT] =3D imx_clk_gate2_flags("vpu_dec_root_clk=
", "vpu_bus", base + 0x4630, 0, CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE=
);
>  	clks[IMX8MQ_CLK_CSI1_ROOT] =3D imx_clk_gate4("csi1_root_clk", "csi1_cor=
e", base + 0x4650, 0);
>  	clks[IMX8MQ_CLK_CSI2_ROOT] =3D imx_clk_gate4("csi2_root_clk", "csi2_cor=
e", base + 0x4660, 0);
> --=20
> 2.7.4
> =
