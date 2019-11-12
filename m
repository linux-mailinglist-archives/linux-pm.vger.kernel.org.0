Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F67BF90E0
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2019 14:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfKLNnk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Nov 2019 08:43:40 -0500
Received: from mail-eopbgr20071.outbound.protection.outlook.com ([40.107.2.71]:39414
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726962AbfKLNnk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 12 Nov 2019 08:43:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0cxoxdhJleLm2AD0g1BF4srK3fZ2m5UR8AFb5D7mhLuXkBteWZSXU7aK2oNRyCsohJ+BVXLVmEiEnyLCTVS7tdwf+Fa7TsZ5dybckpa7JurNoURRyCC0omLR4CBckR2qWKYtqJ9kxQkEhcB1GdpyFqNAYj2O7bY4cla9ZwxCaCTyvPaF/OUj12O8QZ7S6hAuFFOJahrsYb2Ees4h7/VNFtQjtxayGfpHzZpwbiRpz/mXnygJ+9b2SSMJpC7Y4Ht7c7uztY6fIxcbddjp68LAPFJh6YsujAgsuFJozUX447yleI7b4LWPBfpHvZeiv/mqa3JizCI+V3lidxoRw3zhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvMS3MnR+OVag5l/7OjETDYlKEje4ZsT7YnEeaFqzLI=;
 b=Y9bhA/9efF+hMOh3oC+bNiiuT5g/oMD7jt13j0yi5PleL2TJkFZRUN4cDHnr6YDoYeBu+Z9oJO1s98lXXzZ7JxowEvM4s7woq7TpRsc5ISyi3K64BzCqZbvyu4f5KYppnX+OI3/jYxiOS4un7YKczGX3BATNuiI1U7KJZR4WSPa0AZCLXxmjhFmQdImCheJ0Miy/BIBNr4oGSv1YlcjRdBMtkmILA6bvs6gB1qWeEXgptf0lW1TknpkqUT2fAeGAqyTVJqOCbFSNDjHmCtXcgI/lOyw6wlv31QnECp82mH0hfaK1pFWxBJ6AShP658Nsmp3Gw/t/BuO/L2KV9iNJBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvMS3MnR+OVag5l/7OjETDYlKEje4ZsT7YnEeaFqzLI=;
 b=Y7/Pgg6OHpNKFoSQRMqWaw2WKtFkgWacd3Lp4TvFQM8OYxKMRkgv39GLqQsoR3RRgSsgcZnf1373a7J8Xw0/ByGOQNDry4niw/91ltEwpMqabRfbxGNZSgs9+iO6iZ8CfwIRgkr60HCgc79eodPGegR2ynFVslvsjChuSz3v/VQ=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB3277.eurprd04.prod.outlook.com (10.170.231.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.22; Tue, 12 Nov 2019 13:43:35 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3%5]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 13:43:35 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>, Stephen Boyd <sboyd@kernel.org>
CC:     MyungJoo Ham <myungjoo.ham@samsung.com>,
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
Thread-Index: AQHVloV8DX9ZS8xtzEe77doMKYgOwQ==
Date:   Tue, 12 Nov 2019 13:43:35 +0000
Message-ID: <VI1PR04MB702387DCA9DB5A0A3F6288EDEE770@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1573252696.git.leonard.crestez@nxp.com>
 <0e0eeeee546a3bb664935184d66866f1c66458ce.1573252696.git.leonard.crestez@nxp.com>
 <20191112111803.c5624in2masqipqf@fsr-ub1664-175>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 490628d5-dcda-4fd8-2c60-08d7677650b6
x-ms-traffictypediagnostic: VI1PR04MB3277:|VI1PR04MB3277:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB327775FC29CE0703F6AA72A8EE770@VI1PR04MB3277.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(396003)(346002)(136003)(39860400002)(189003)(199004)(76176011)(6246003)(54906003)(110136005)(316002)(256004)(14444005)(55016002)(9686003)(305945005)(7416002)(5660300002)(74316002)(66066001)(44832011)(33656002)(478600001)(3846002)(2906002)(14454004)(6116002)(7736002)(86362001)(81156014)(26005)(486006)(446003)(186003)(476003)(229853002)(53546011)(52536014)(102836004)(25786009)(6436002)(6506007)(71190400001)(71200400001)(7696005)(99286004)(66476007)(64756008)(8676002)(81166006)(66556008)(66446008)(8936002)(76116006)(66946007)(91956017)(4326008)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3277;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vrCzU2araRXbTyDe9NwWjmIVHmRqqQjIiQhYkZ8qkvF09+3wrPJ83HR5YQRWTWxORvBUxvSIJqh8xLQTy+C1lplLe8O4jOoD6xrsAoI1c3nMvh7bLKPqZqWKqPZFUEojecEIp4TNabFcw8/q2ngb1jO48raee4If6PdKSTpYiwPRCI8BmPViKcB6lr45IPdUmB8Ybz6H/fWAXvnpdXJEYkedtaYS7KPa3gxW11TS/OjxJu1zNh/JYiNDz1Vzib056Bv0RzslTXXwoIFgx14YoQuF6NvOVGmbsIejJepco7Bo2065hh9yDTXViZWNTEW0PxoMGT/ob8rR7SrcuZEwGkcSr/qOxVXaQWE7dLDZyRdYz91Cw9jAEGWNkqhGfBzMtKMq6Lu5y6hFWq/8fliYqU8oOPKBSu2AGS7DooJ98tlWqCTmi9hX903lpIazC/FR
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 490628d5-dcda-4fd8-2c60-08d7677650b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 13:43:35.1653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lm6TD9vyh/KawvPhUvQ4r0exUEKLbjZj5PT7I/wwSH5qQsScvl5kfmnuu9RWcYVdP9Pq0fhGkjhqtJCQ9a3Mug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3277
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12.11.2019 13:18, Abel Vesa wrote:=0A=
> On 19-11-09 00:39:51, Leonard Crestez wrote:=0A=
>> These clocks are only modified as part of DRAM frequency switches during=
=0A=
>> which DRAM itself is briefly inaccessible. The switch is performed with=
=0A=
>> a SMC call to by TF-A which runs from a SRAM area; upon returning to=0A=
>> linux several clocks bits are modified and we need to update them.=0A=
>>=0A=
>> For rate bits an easy solution is to just mark with=0A=
>> CLK_GET_RATE_NOCACHE so that new rates are always read back from=0A=
>> registers.=0A=
>>=0A=
>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
>> ---=0A=
>>   drivers/clk/imx/clk-imx8mm.c | 11 +++++++++--=0A=
>>   drivers/clk/imx/clk-imx8mn.c | 12 ++++++++++--=0A=
>>   drivers/clk/imx/clk-imx8mq.c | 15 +++++++++++----=0A=
>>   3 files changed, 30 insertions(+), 8 deletions(-)=0A=
=0A=
>> --- a/drivers/clk/imx/clk-imx8mn.c=0A=
>> +++ b/drivers/clk/imx/clk-imx8mn.c=0A=
>> @@ -428,12 +428,20 @@ static int imx8mn_clocks_probe(struct platform_dev=
ice *pdev)=0A=
>>   	clks[IMX8MN_CLK_AHB] =3D imx8m_clk_composite_critical("ahb", imx8mn_a=
hb_sels, base + 0x9000);=0A=
>>   	clks[IMX8MN_CLK_AUDIO_AHB] =3D imx8m_clk_composite("audio_ahb", imx8m=
n_audio_ahb_sels, base + 0x9100);=0A=
>>   	clks[IMX8MN_CLK_IPG_ROOT] =3D imx_clk_divider2("ipg_root", "ahb", bas=
e + 0x9080, 0, 1);=0A=
>>   	clks[IMX8MN_CLK_IPG_AUDIO_ROOT] =3D imx_clk_divider2("ipg_audio_root"=
, "audio_ahb", base + 0x9180, 0, 1);=0A=
>>   	clks[IMX8MN_CLK_DRAM_CORE] =3D imx_clk_mux2_flags("dram_core_clk", ba=
se + 0x9800, 24, 1, imx8mn_dram_core_sels, ARRAY_SIZE(imx8mn_dram_core_sels=
), CLK_IS_CRITICAL);=0A=
>> -	clks[IMX8MN_CLK_DRAM_ALT] =3D imx8m_clk_composite("dram_alt", imx8mn_d=
ram_alt_sels, base + 0xa000);=0A=
>> -	clks[IMX8MN_CLK_DRAM_APB] =3D imx8m_clk_composite_critical("dram_apb",=
 imx8mn_dram_apb_sels, base + 0xa080);=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * DRAM clocks are manipulated from TF-A outside clock framework.=0A=
>> +	 * Mark with GET_RATE_NOCACHE to always read div value from hardware=
=0A=
>> +	 */=0A=
>> +	clks[IMX8MN_CLK_DRAM_ALT] =3D __imx8m_clk_composite("dram_alt", imx8mn=
_dram_alt_sels, base + 0xa000,=0A=
>> +			CLK_GET_RATE_NOCACHE);=0A=
>> +	clks[IMX8MN_CLK_DRAM_APB] =3D __imx8m_clk_composite("dram_apb", imx8mn=
_dram_apb_sels, base + 0xa080,=0A=
>> +			CLK_IS_CRITICAL | CLK_GET_RATE_NOCACHE);=0A=
> =0A=
> nitpick: I think it looks better if we stick to one line each clock.=0A=
> I know it's against the 80 chars rule, but at least is consistent.=0A=
=0A=
Yes, there are longer lines in the imx8m* files anyway.=0A=
=0A=
If I fix this (in all instances) can I also add a "reviewed-by"?=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
