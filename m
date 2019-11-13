Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3457FB01F
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2019 13:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfKMMCo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Nov 2019 07:02:44 -0500
Received: from mail-eopbgr60042.outbound.protection.outlook.com ([40.107.6.42]:4582
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726066AbfKMMCo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 13 Nov 2019 07:02:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eiOPfKAxorpWLnPJqAsiZcs9OdIZb0FS7WnNzRrvF4M+xCJEglspV1GzFOHRj7v3BcSNuo73Yaaq09Ye+H3XxNb3URsR+Doc1foGOzb7bbnAIIp428cPUBcPCiRtpm8NHGu85K5SaNI17dHy53pvoWvQbA//DLtUG94ZuS8QNn12XaLNTYdPKLlxr4WzWsS8U7+I1Nc5dMHWyPqTJTy+4h/UKM2ldQlWBVVCXK0k7+9aYsVjNR1Qv1+RnUpDgIngftCxEuFA5Ku4l9NWfbtzG+sa9S/IssoN5z1tI1mpNqQJispIDWcecZO/mDrdYycLEv7AQ14IQlIt06I+Bi4z6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+XoCI8aUNz6ojj3eL4cXhzCLJ9qQSe2RbE5ktTW49k=;
 b=dQs/4h2IQpGM+maaufBicjTDRihb9PVegFCu0EwfSz6ROxMzlpq2jkTFmOLTfMQmL5/rGLSVtuRiLcetpPMapCn3DgXmYZS8RUHHzFQ/gTSCvGTJ9CV63huETdm8pKV88jolY/58nACMpg26i0VmRIiFXoe1HJRBN22xj2TM51JhlSQz3vu3PYWrl/xphp3tU/xw571EVGMFXWlzZl34zvGJCnk6+FWw3YA8B2VOJaUeiNc1atw5z4pVFkUtVvIhxtPnNvkAOLPBAZuMkh3N4+/ODSINEvR6bJ6imGshAUBKPfp1p/RMtR1ETtrg0iXC+KsODcBTjYLtBznxwBU9wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+XoCI8aUNz6ojj3eL4cXhzCLJ9qQSe2RbE5ktTW49k=;
 b=iu8sZ2WZ4GxM27/uV54JgdePkcV2iY2x9MrWsXEkHPLJB3sHnp8shwYRwXDR/DyyuNoxDQoOP+2tcwC7+ex+pkksw7ZTl5BJDcdB6e5UKOedQAI2Oo2OmmhKaERiH+4Pqgxnl8Qmw/sOqjGmUVuWkD6IiOHsIVpD/TXdjhmYZCM=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB6126.eurprd04.prod.outlook.com (20.179.28.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 13 Nov 2019 12:02:38 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3%5]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 12:02:38 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>, Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
CC:     Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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
Subject: Re: [PATCH v5 2/5] clk: imx: Mark dram pll on 8mm and 8mn with
 CLK_GET_RATE_NOCACHE
Thread-Topic: [PATCH v5 2/5] clk: imx: Mark dram pll on 8mm and 8mn with
 CLK_GET_RATE_NOCACHE
Thread-Index: AQHVmaNNmWotUE8nUUaGcx+s/r6w0A==
Date:   Wed, 13 Nov 2019 12:02:38 +0000
Message-ID: <VI1PR04MB7023EFCBE2730F60D46D3CACEE760@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1573595318.git.leonard.crestez@nxp.com>
 <65d08f34741f1ffa94a53bc128433e6c958091d2.1573595319.git.leonard.crestez@nxp.com>
 <DB7PR04MB4490A934AC170E4BA1CD261788760@DB7PR04MB4490.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c91e25cd-9dda-43e4-f301-08d7683160d8
x-ms-traffictypediagnostic: VI1PR04MB6126:|VI1PR04MB6126:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB61266D25CDE58E7850CF8EEAEE760@VI1PR04MB6126.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(189003)(199004)(478600001)(7416002)(6306002)(966005)(55016002)(5660300002)(54906003)(14454004)(110136005)(256004)(9686003)(316002)(229853002)(74316002)(33656002)(7736002)(305945005)(6436002)(99286004)(8936002)(4326008)(81166006)(81156014)(76176011)(6246003)(7696005)(8676002)(6116002)(2906002)(52536014)(3846002)(6506007)(186003)(44832011)(486006)(86362001)(446003)(66066001)(53546011)(66946007)(476003)(26005)(66446008)(64756008)(102836004)(76116006)(91956017)(71200400001)(71190400001)(66476007)(66556008)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6126;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VkSyeDgsMIvmt+ByV6/x6+NI1nb/wpmhu8umyctCKZjl/YCkk+M/3h0724CxQ7+QtTFs6rhtpsK9xqapMIPDXHbf+9KSNTIw1VElr4NCsjPO62H7AiVTXm0P2L83QC/dGTZo3Q3yunWnKFKLODpO6oIS+cw9e5i24HJzVZzkxBhReJielHnSS/3EMV9rEnnZIBFsJSGDWhXzAntFyFTwBPjud4o8wFOoTtP6b5RUjapwmHShHnZUTz2MJ5nlciFNnnhm4ug3EMcX7Yr7+C9kv1ka0sPe4z1hmPf71BpzXU4ykLQGq0DvJUEM84KdetrtilD0M1W/l1BimXx53ZJNWVeLkjfBhMSo7kgtQv7mnZ0U24K0L7KTgK8K7LfNUX4c26rTH+B4zaImtFjKBNwv4/q2lsVkyu8QKzimgmXPm8p8ng2InLOWvioX5QGWH9LHrnweAsJnBtUOT1sOzE7e/0ud88khvPKs7R+6WNFqrug=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c91e25cd-9dda-43e4-f301-08d7683160d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 12:02:38.2476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E5KkS17GD5PKuUIWzEGlqG/ud6PBhGG3PLbiamNNE7rk/s4HRrytdVpKP6SExNdY09QBGTlzqeQ1lMOys2XbEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6126
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13.11.2019 09:29, Peng Fan wrote:=0A=
> Hi Leonard,=0A=
> =0A=
>> Subject: [PATCH v5 2/5] clk: imx: Mark dram pll on 8mm and 8mn with=0A=
>> CLK_GET_RATE_NOCACHE=0A=
> =0A=
> This patch will conflict with https://patchwork.kernel.org/cover/11224933=
/=0A=
> And I just post a new patch https://patchwork.kernel.org/patch/11241231/=
=0A=
>   =0A=
> Then no need add imx_1443x_dram_pll=0A=
=0A=
I saw those patches and the conflicts are minor (API cleanups, no =0A=
functionality changes).=0A=
=0A=
I usually send patches against latest linux-next/master and this usually =
=0A=
includes all accepted patches. If after the clk_hw refactorings are =0A=
accepted I will rebase and resend.=0A=
=0A=
> Regards,=0A=
> Peng.=0A=
> =0A=
>>=0A=
>> DRAM frequency switches are executed in firmware and can change the=0A=
>> configuration of the DRAM PLL outside linux. Mark these CLKs with=0A=
>> CLK_GET_RATE_NOCACHE so we always read back the PLL config registers=0A=
>> and recalculate rates.=0A=
>>=0A=
>> In current DRAM frequency tables on 8mm/8mn only the maximum frequency=
=0A=
>> uses the PLL so it's always configured in the same way. However reading =
back=0A=
>> the PLL configuration is the correct behavior and allows additional setp=
oints in=0A=
>> the future.=0A=
>>=0A=
>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
>> Reviewed-by: Abel Vesa <abel.vesa@nxp.com>=0A=
>> ---=0A=
>>   drivers/clk/imx/clk-imx8mm.c  | 2 +-=0A=
>>   drivers/clk/imx/clk-imx8mn.c  | 2 +-=0A=
>>   drivers/clk/imx/clk-pll14xx.c | 7 +++++++=0A=
>>   drivers/clk/imx/clk.h         | 1 +=0A=
>>   4 files changed, 10 insertions(+), 2 deletions(-)=0A=
>>=0A=
>> diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c=
=0A=
>> index e2bc3c90d93c..9246e89bb5fd 100644=0A=
>> --- a/drivers/clk/imx/clk-imx8mm.c=0A=
>> +++ b/drivers/clk/imx/clk-imx8mm.c=0A=
>> @@ -326,11 +326,11 @@ static int imx8mm_clocks_probe(struct=0A=
>> platform_device *pdev)=0A=
>>   	clks[IMX8MM_SYS_PLL3_REF_SEL] =3D imx_clk_mux("sys_pll3_ref_sel",=0A=
>> base + 0x114, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));=0A=
>>=0A=
>>   	clks[IMX8MM_AUDIO_PLL1] =3D imx_clk_pll14xx("audio_pll1",=0A=
>> "audio_pll1_ref_sel", base, &imx_1443x_pll);=0A=
>>   	clks[IMX8MM_AUDIO_PLL2] =3D imx_clk_pll14xx("audio_pll2",=0A=
>> "audio_pll2_ref_sel", base + 0x14, &imx_1443x_pll);=0A=
>>   	clks[IMX8MM_VIDEO_PLL1] =3D imx_clk_pll14xx("video_pll1",=0A=
>> "video_pll1_ref_sel", base + 0x28, &imx_1443x_pll);=0A=
>> -	clks[IMX8MM_DRAM_PLL] =3D imx_clk_pll14xx("dram_pll",=0A=
>> "dram_pll_ref_sel", base + 0x50, &imx_1443x_pll);=0A=
>> +	clks[IMX8MM_DRAM_PLL] =3D imx_clk_pll14xx("dram_pll",=0A=
>> +"dram_pll_ref_sel", base + 0x50, &imx_1443x_dram_pll);=0A=
>>   	clks[IMX8MM_GPU_PLL] =3D imx_clk_pll14xx("gpu_pll", "gpu_pll_ref_sel"=
,=0A=
>> base + 0x64, &imx_1416x_pll);=0A=
>>   	clks[IMX8MM_VPU_PLL] =3D imx_clk_pll14xx("vpu_pll", "vpu_pll_ref_sel"=
,=0A=
>> base + 0x74, &imx_1416x_pll);=0A=
>>   	clks[IMX8MM_ARM_PLL] =3D imx_clk_pll14xx("arm_pll", "arm_pll_ref_sel"=
,=0A=
>> base + 0x84, &imx_1416x_pll);=0A=
>>   	clks[IMX8MM_SYS_PLL1] =3D imx_clk_fixed("sys_pll1", 800000000);=0A=
>>   	clks[IMX8MM_SYS_PLL2] =3D imx_clk_fixed("sys_pll2", 1000000000); diff=
=0A=
>> --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c inde=
x=0A=
>> de905e278b80..4749beab9fc8 100644=0A=
>> --- a/drivers/clk/imx/clk-imx8mn.c=0A=
>> +++ b/drivers/clk/imx/clk-imx8mn.c=0A=
>> @@ -323,11 +323,11 @@ static int imx8mn_clocks_probe(struct=0A=
>> platform_device *pdev)=0A=
>>   	clks[IMX8MN_SYS_PLL3_REF_SEL] =3D imx_clk_mux("sys_pll3_ref_sel",=0A=
>> base + 0x114, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));=0A=
>>=0A=
>>   	clks[IMX8MN_AUDIO_PLL1] =3D imx_clk_pll14xx("audio_pll1",=0A=
>> "audio_pll1_ref_sel", base, &imx_1443x_pll);=0A=
>>   	clks[IMX8MN_AUDIO_PLL2] =3D imx_clk_pll14xx("audio_pll2",=0A=
>> "audio_pll2_ref_sel", base + 0x14, &imx_1443x_pll);=0A=
>>   	clks[IMX8MN_VIDEO_PLL1] =3D imx_clk_pll14xx("video_pll1",=0A=
>> "video_pll1_ref_sel", base + 0x28, &imx_1443x_pll);=0A=
>> -	clks[IMX8MN_DRAM_PLL] =3D imx_clk_pll14xx("dram_pll",=0A=
>> "dram_pll_ref_sel", base + 0x50, &imx_1443x_pll);=0A=
>> +	clks[IMX8MN_DRAM_PLL] =3D imx_clk_pll14xx("dram_pll",=0A=
>> +"dram_pll_ref_sel", base + 0x50, &imx_1443x_dram_pll);=0A=
>>   	clks[IMX8MN_GPU_PLL] =3D imx_clk_pll14xx("gpu_pll", "gpu_pll_ref_sel"=
,=0A=
>> base + 0x64, &imx_1416x_pll);=0A=
>>   	clks[IMX8MN_VPU_PLL] =3D imx_clk_pll14xx("vpu_pll", "vpu_pll_ref_sel"=
,=0A=
>> base + 0x74, &imx_1416x_pll);=0A=
>>   	clks[IMX8MN_ARM_PLL] =3D imx_clk_pll14xx("arm_pll", "arm_pll_ref_sel"=
,=0A=
>> base + 0x84, &imx_1416x_pll);=0A=
>>   	clks[IMX8MN_SYS_PLL1] =3D imx_clk_fixed("sys_pll1", 800000000);=0A=
>>   	clks[IMX8MN_SYS_PLL2] =3D imx_clk_fixed("sys_pll2", 1000000000); diff=
=0A=
>> --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.c in=
dex=0A=
>> 5c458199060a..a6d31a7262ef 100644=0A=
>> --- a/drivers/clk/imx/clk-pll14xx.c=0A=
>> +++ b/drivers/clk/imx/clk-pll14xx.c=0A=
>> @@ -65,10 +65,17 @@ struct imx_pll14xx_clk imx_1443x_pll =3D {=0A=
>>   	.type =3D PLL_1443X,=0A=
>>   	.rate_table =3D imx_pll1443x_tbl,=0A=
>>   	.rate_count =3D ARRAY_SIZE(imx_pll1443x_tbl),  };=0A=
>>=0A=
>> +struct imx_pll14xx_clk imx_1443x_dram_pll =3D {=0A=
>> +	.type =3D PLL_1443X,=0A=
>> +	.rate_table =3D imx_pll1443x_tbl,=0A=
>> +	.rate_count =3D ARRAY_SIZE(imx_pll1443x_tbl),=0A=
>> +	.flags =3D CLK_GET_RATE_NOCACHE,=0A=
>> +};=0A=
>> +=0A=
>>   struct imx_pll14xx_clk imx_1416x_pll =3D {=0A=
>>   	.type =3D PLL_1416X,=0A=
>>   	.rate_table =3D imx_pll1416x_tbl,=0A=
>>   	.rate_count =3D ARRAY_SIZE(imx_pll1416x_tbl),  }; diff --git=0A=
>> a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h index=0A=
>> bc5bb6ac8636..81122c9ab842 100644=0A=
>> --- a/drivers/clk/imx/clk.h=0A=
>> +++ b/drivers/clk/imx/clk.h=0A=
>> @@ -50,10 +50,11 @@ struct imx_pll14xx_clk {=0A=
>>   	int flags;=0A=
>>   };=0A=
>>=0A=
>>   extern struct imx_pll14xx_clk imx_1416x_pll;  extern struct=0A=
>> imx_pll14xx_clk imx_1443x_pll;=0A=
>> +extern struct imx_pll14xx_clk imx_1443x_dram_pll;=0A=
>>=0A=
>>   #define imx_clk_cpu(name, parent_name, div, mux, pll, step) \=0A=
>>   	imx_clk_hw_cpu(name, parent_name, div, mux, pll, step)->clk=0A=
>>=0A=
>>   #define clk_register_gate2(dev, name, parent_name, flags, reg, bit_idx=
, \=0A=
>> --=0A=
>> 2.17.1=0A=
> =0A=
> =0A=
=0A=
