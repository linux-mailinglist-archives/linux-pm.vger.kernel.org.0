Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 884CFB4461
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2019 01:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732541AbfIPXD6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Sep 2019 19:03:58 -0400
Received: from mail-eopbgr50087.outbound.protection.outlook.com ([40.107.5.87]:22754
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728381AbfIPXD6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 16 Sep 2019 19:03:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+1Kt7i1HlIyL9df0r4YHppcvh9z2YHWUECi5T6Ph8/GD89WPIr78vKBUl7nssHElarMXlSc5Brrhc0Rl3TvsMUu91+UI480iT4zXQejqRuC+8lftYwb03ZPxv99mKsa3+eQI1gDlkiy4n2ri7AJXGpZC8BY3REpP1lGUbLipUHs5bS4uEVaw56Bu6/hLd3ReWuInoD14nNwAEaz1/weT22bU4O5Xd7Qj1GpJnRzfWvRM9YA5xKdunyf7bvBuEzY6lqi2f17v3eyEOATwgMACKnnc64gmI80gMBxKG/qi2ReRzPunOClGuvlVJ3pM4LWoBUzNEzukYWsXkFPB85dyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBf3wHqW1vXsJYhbIiH35hFmmqrHOe4vlbYm0Nvz6Dw=;
 b=TUiUPDOy4RwGoXScwun5mOMJ+otDAhlSB2mWSHvRhKFZCik2sAuJNVwk5Zhp8vbYRLNMAEklBM6ztoYGhCW7+FMwy/KC3E+28yF+ZwDkYF7c6W6pcMJVOP90P+q8bNBSl7fo74s3Y7SmV1XMuBw8Mt9iTDeUfTMe0UJMoSx2kCSp5Sk8i1qx/cBMXVcVo5vI7jFPEtdUV7a6JN2QkdZUUWT2MHbYrM1RRcZoDuLPvPg6tIPaLruVEJDUs8c3kTRrfzbOaj9lRm6c6t1bLvmCB7n7eBtOceeOlmJY3lCVml0Z1RXSvX8MYzGVdMKV+Y2GzqMq7tMoyK2YrNA8iK8bcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBf3wHqW1vXsJYhbIiH35hFmmqrHOe4vlbYm0Nvz6Dw=;
 b=gm30Zi+9Fa+YCAt2lye1KcBKPPRxWMMaEfFYNOtM+KK/0h9Tk58fABSGiD35jl5w3D+5SvFes5NQB3nWRe5sWh7Vaju+HrIKt/BS7HtsUhSYXof52mx6B5Ov4dqask7sXEkyWxCQ3U7enO76sM9ledZ6ofvBGx95cVSUIzCl9cY=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB5806.eurprd04.prod.outlook.com (20.178.204.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Mon, 16 Sep 2019 23:03:53 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::c5e8:90f8:da97:947e]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::c5e8:90f8:da97:947e%3]) with mapi id 15.20.2263.023; Mon, 16 Sep 2019
 23:03:53 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>
CC:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        =?iso-8859-2?Q?Artur_=A6wigo=F1?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
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
Subject: Re: [PATCH v2 1/7] clk: imx8m: Set CLK_GET_RATE_NOCACHE on
 dram_alt/apb
Thread-Topic: [PATCH v2 1/7] clk: imx8m: Set CLK_GET_RATE_NOCACHE on
 dram_alt/apb
Thread-Index: AQHVV25IgdEhNlz9IkikhFBZNpksww==
Date:   Mon, 16 Sep 2019 23:03:53 +0000
Message-ID: <VI1PR04MB70239F26BE42AD5E6FC3639DEE8C0@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1566315740.git.leonard.crestez@nxp.com>
 <90bfeebcb76e76d286ed7f022ea9e0d9a569ebe2.1566315740.git.leonard.crestez@nxp.com>
 <20190916203312.CF8D02067B@mail.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [78.96.82.152]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2aaeec75-efc9-4238-41ac-08d73afa2544
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR04MB5806;
x-ms-traffictypediagnostic: VI1PR04MB5806:|VI1PR04MB5806:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB5806B12383FA5FA61C8EA580EE8C0@VI1PR04MB5806.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:291;
x-forefront-prvs: 0162ACCC24
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(366004)(136003)(376002)(39860400002)(199004)(189003)(5660300002)(66066001)(81166006)(2906002)(8676002)(99286004)(66946007)(81156014)(86362001)(7416002)(256004)(14444005)(478600001)(26005)(102836004)(6506007)(25786009)(53546011)(305945005)(7736002)(52536014)(74316002)(316002)(66556008)(64756008)(76116006)(66476007)(66446008)(446003)(6246003)(229853002)(55016002)(33656002)(6306002)(76176011)(9686003)(476003)(6116002)(3846002)(14454004)(71200400001)(110136005)(8936002)(7696005)(4326008)(71190400001)(966005)(486006)(6436002)(186003)(54906003)(44832011)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5806;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +SXRN1JvUHZiv/4TbhIL4kCXLKFqGiNYO+pkixZfzQNjbIun3L0CRHQFmBjx1To5K6D65Vv+Qa5yfZvwos7o9qsMvb9Xh97lOdrNdqxDoAUdTYX53+cHa897xxCpSiI1iMtRgXncqhhJPyTdnaQxYWH9rSHjmN4i9GzTQrucHdYjH3PIVUIujGkXVS7nRsVTFFKFEJo2f0njgZ9KVWhKtrrOS9srDkIX376XKgCiZs86esQqV9+R5fpcG6UGZ8BLMYX8qmKM4N7TJm/fJjvLmmM0WkbghdpmaaoQuRh0RwPhp3P3fbojlQ7OAYaVXCmYJMED1pCiArlTnquch+JszYlU0JBQhfcOuNPKdQ+z/MmuFq6isrZDqypy8TFULsCttUbrZ6FLWWA+N+Q9rLhzxp12V9Uddn4mif89yI1m218=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aaeec75-efc9-4238-41ac-08d73afa2544
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2019 23:03:53.1505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0NYscR2kuTkMAyF6kSDq5MwS/ifrDhvNjz6LQjAv7GxCP/KHIDPpviVHvqwoHtlmIG0fKnI4AF7hGUC2A2F5XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5806
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2019-09-16 11:33 PM, Stephen Boyd wrote:=0A=
> Quoting Leonard Crestez (2019-08-20 08:45:06)=0A=
>> Dram frequency changes required modifying these clocks outside the=0A=
>> control of clk framework. Mark them as CLK_GET_RATE_NOCACHE so that=0A=
>> rates are always read back from registers.=0A=
> =0A=
> Why can't we control the clks from the clk framework? Please add that=0A=
> information in the commit text here.=0A=
=0A=
OK, I will update commit message and comments=0A=
=0A=
These clocks are only modified for DRAM frequency switches during which =0A=
DRAM is briefly inaccessible. The switch is performed with a SMC call to =
=0A=
by TF-A which runs from a SRAM area. Upon returning to linux several =0A=
clocks bits are modified and we need to update them.=0A=
=0A=
For rate bits an easy solution is to just mark with =0A=
CLK_GET_RATE_NOCACHE, muxes are handled explicitly.=0A=
=0A=
Linux code performing the SMC call is also part of this series:=0A=
=0A=
     https://patchwork.kernel.org/patch/11104145/=0A=
=0A=
>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
>> ---=0A=
>>   drivers/clk/imx/clk-imx8mm.c | 6 ++++--=0A=
>>   drivers/clk/imx/clk-imx8mn.c | 6 ++++--=0A=
>>   drivers/clk/imx/clk-imx8mq.c | 7 ++++---=0A=
>>   3 files changed, 12 insertions(+), 7 deletions(-)=0A=
>>=0A=
>> diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c=
=0A=
>> index 4ead3ea2713c..6cac80550f43 100644=0A=
>> --- a/drivers/clk/imx/clk-imx8mm.c=0A=
>> +++ b/drivers/clk/imx/clk-imx8mm.c=0A=
>> @@ -526,12 +526,14 @@ static int imx8mm_clocks_probe(struct platform_dev=
ice *pdev)=0A=
>>          /* IPG */=0A=
>>          clks[IMX8MM_CLK_IPG_ROOT] =3D imx_clk_divider2("ipg_root", "ahb=
", base + 0x9080, 0, 1);=0A=
>>          clks[IMX8MM_CLK_IPG_AUDIO_ROOT] =3D imx_clk_divider2("ipg_audio=
_root", "audio_ahb", base + 0x9180, 0, 1);=0A=
>>   =0A=
>>          /* IP */=0A=
>> -       clks[IMX8MM_CLK_DRAM_ALT] =3D imx8m_clk_composite("dram_alt", im=
x8mm_dram_alt_sels, base + 0xa000);=0A=
>> -       clks[IMX8MM_CLK_DRAM_APB] =3D imx8m_clk_composite_critical("dram=
_apb", imx8mm_dram_apb_sels, base + 0xa080);=0A=
>> +       clks[IMX8MM_CLK_DRAM_ALT] =3D __imx8m_clk_composite("dram_alt", =
imx8mm_dram_alt_sels, base + 0xa000,=0A=
>> +                       CLK_GET_RATE_NOCACHE);=0A=
>> +       clks[IMX8MM_CLK_DRAM_APB] =3D __imx8m_clk_composite("dram_apb", =
imx8mm_dram_apb_sels, base + 0xa080,=0A=
>> +                       CLK_IS_CRITICAL | CLK_GET_RATE_NOCACHE);=0A=
> =0A=
> Also, add a comment to this effect about why it can't be done from the=0A=
> clk framework wherever the CLK_GET_RATE_NOCACHE flag is set. Basically=0A=
> this flag is a hack and is an example of something that we need to fix.=
=0A=
=0A=
DRAM freq switch requires multiple clk changes to be performed =0A=
atomically while DRAM itself is not accessible so it's not something to =0A=
"fix".=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
