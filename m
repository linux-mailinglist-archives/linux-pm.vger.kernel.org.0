Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E92310E50B
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2019 05:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfLBEUo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Dec 2019 23:20:44 -0500
Received: from mail-eopbgr20066.outbound.protection.outlook.com ([40.107.2.66]:42926
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727298AbfLBEUo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 1 Dec 2019 23:20:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qq1/NNyQt+Q8mBqBpI07+ciKkGrr0dVQOhA2FqgsbMzZysbVZ5cEXVIaqFUvKVvofRmTEKxNcK32YOqCJs3To7J7ftwjZUedNlEfvWkv9wTTVAYmFOfWzTsHQEA6H3fL1oubQsx4WBRHNv/j9SkCq+MelOrU2iqUEHpatxtVurWsE0cIGk2J2pythyunItK4EsAudiV6MK3M5RkRI+B36TuHMBb5AyUrijiBpzD9X7UBBFD80AQyIhprsOjbSh9WdCXshJStZBQtswvKPiksW4w6lmjYkqBhYQ+NZDma2iVp5ctznozYv3EzfxLGCn/NgbZNCj8mUS7F63k883NhBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJLJh+O1y2EsARSc1iGGNQqeZqHfC/GJU/o6UDF5mlk=;
 b=SKG+MZrYqXfHShwosIo/1AKCFCyXaN7CIBDllx/iVKFlfQxLNLpv9z9XiPvIkV505mgTVcvhAhEd1LgRVhPQKyrancxKy9lJA9cifuu6ol8Bgal5B2Yt6cst6Kdw3SRwzYI3566PM6mfyWnn0hOWPvheMXgax5oLwYP1e5l6Z4Gz3OD1Dv0bH54KaW8tfoSXSJ1KJEuj7uG9qWnqSNnRD7OdxFbzWlifmoQX2BaODMq0AkhFF+vWpzPxFlQ6vpRFkWHrc+/TIvstOxqC4dYjMj0mLnJGeIk6HxWb1DaSt+AihSOVgEKtE4eaKjeEEqzz/yRHoNJ/DS3iqOwPZxZbQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJLJh+O1y2EsARSc1iGGNQqeZqHfC/GJU/o6UDF5mlk=;
 b=S4LWJnizI6F1D7T5f/54HxxjXtCw/Ch+uuhNStE0Aw/nsTui5F2YBgQdJ8syx0ijm5ZWHHY27K41jpVlCwPmfEKQMqACXMdhYpQTealaZUeb+S8P/SsAsM2VYLdQhB1XMMyqttRxwja7YWNke1mlGemZ0/yQoqptXKcdTFS35Vs=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB3200.eurprd04.prod.outlook.com (10.170.230.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Mon, 2 Dec 2019 04:20:00 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3%5]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 04:20:00 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Abel Vesa <abel.vesa@nxp.com>
CC:     Stephen Boyd <sboyd@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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
Subject: Re: [PATCH v3 1/6] clk: imx8m: Set CLK_GET_RATE_NOCACHE on dram
 clocks
Thread-Topic: [PATCH v3 1/6] clk: imx8m: Set CLK_GET_RATE_NOCACHE on dram
 clocks
Thread-Index: AQHVkDU5CAT+mGhag0irKrwA1oglYA==
Date:   Mon, 2 Dec 2019 04:19:59 +0000
Message-ID: <VI1PR04MB7023B15ED837A3C4BF940C47EE430@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1572558427.git.leonard.crestez@nxp.com>
 <94c478c1209704a3da4577ae79ea28888759e8a7.1572558427.git.leonard.crestez@nxp.com>
 <20191202031203.GB9767@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1dbbabbb-932d-4f98-0a8f-08d776dee588
x-ms-traffictypediagnostic: VI1PR04MB3200:|VI1PR04MB3200:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB3200BD139DEC27933E1A3C13EE430@VI1PR04MB3200.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 0239D46DB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(39860400002)(346002)(396003)(366004)(199004)(189003)(6246003)(25786009)(14454004)(966005)(26005)(6506007)(66476007)(53546011)(66066001)(5660300002)(55016002)(64756008)(66556008)(7416002)(14444005)(256004)(6636002)(305945005)(229853002)(9686003)(91956017)(76116006)(7736002)(102836004)(6436002)(66446008)(66946007)(6306002)(76176011)(99286004)(52536014)(8936002)(478600001)(186003)(74316002)(110136005)(7696005)(54906003)(33656002)(446003)(6116002)(4326008)(3846002)(44832011)(8676002)(81156014)(81166006)(2906002)(86362001)(316002)(71190400001)(71200400001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3200;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Acr53TpRvXOkJCPfjSQNSn8NM4DYpFI/S05Vd24OqkzcF2adimKolOwkqTy/y8hPacGTPr9AM+e40RH0JG3fM8yNO0gg7DBFy8sumVd9vH/OVFlpJAlv/V9y3YAmubq9tkRFQbnB/1xt7L6e+PhxCN+a4WRINV9w7RgX0utj8ZkAA1yYWGdAT1TdOCZx7/b64j0/lC95+LSGrwoMCdJk/FcMyt6Roz934f8lr0nzMOA2edWfhFz9uIaI5VVGVgvcySP/aQJHTSQW9C+2YtTLaNb6TjnzqSAFydE7cDybK1CkRdPH4oRbtEtcBJfCm7VgsWO3Ztbm46S+m/d+ZOkS2KLWu5NLuzbqam25U3M3E49QhFbjiMJmdqVie0JxIXyjmTe7l+PlmZLoRf11Z+kSemoT38990RhpeS+vV818iOcnwIWStwY65dmhIVdD1nIxkUYF7U63PIPYbg+UYUgbAmQs+JDNHw7OpBrUXumo+Rs=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dbbabbb-932d-4f98-0a8f-08d776dee588
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2019 04:19:59.9251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cYmgN8rJx8CJByjLVkXFrI+MWeAw4BojHwvsyL9l3i6TN0ApM70aIoaEW63GNIrjRfxURP8BIGBWYJuH9cAGHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3200
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2019-12-02 5:12 AM, Shawn Guo wrote:=0A=
> On Thu, Oct 31, 2019 at 11:50:22PM +0200, Leonard Crestez wrote:=0A=
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
>>=0A=
>> diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c=
=0A=
>> index 030b15d7c0ce..c58f988191a5 100644=0A=
>> --- a/drivers/clk/imx/clk-imx8mm.c=0A=
>> +++ b/drivers/clk/imx/clk-imx8mm.c=0A=
>> @@ -440,13 +440,20 @@ static int imx8mm_clocks_probe(struct platform_dev=
ice *pdev)=0A=
>>   =0A=
>>   	/* IPG */=0A=
>>   	clks[IMX8MM_CLK_IPG_ROOT] =3D imx_clk_divider2("ipg_root", "ahb", bas=
e + 0x9080, 0, 1);=0A=
>>   	clks[IMX8MM_CLK_IPG_AUDIO_ROOT] =3D imx_clk_divider2("ipg_audio_root"=
, "audio_ahb", base + 0x9180, 0, 1);=0A=
>>   =0A=
>> +	/*=0A=
>> +	 * DRAM clocks are manipulated from TF-A outside clock framework.=0A=
>> +	 * Mark with GET_RATE_NOCACHE to always read div value from hardware=
=0A=
>> +	 */=0A=
>> +	clks[IMX8MM_CLK_DRAM_ALT] =3D __imx8m_clk_composite("dram_alt", imx8mm=
_dram_alt_sels, base + 0xa000,=0A=
>> +			CLK_GET_RATE_NOCACHE);=0A=
>> +	clks[IMX8MM_CLK_DRAM_APB] =3D __imx8m_clk_composite("dram_apb", imx8mm=
_dram_apb_sels, base + 0xa080,=0A=
>> +			CLK_IS_CRITICAL | CLK_GET_RATE_NOCACHE);=0A=
>> +=0A=
> =0A=
> I think we prefer to ignore over-80-column warnings for i.MX clock=0A=
> drivers, because doing that improve the readability of code.=0A=
=0A=
You're replying to an old version, v7 doesn't have this issue:=0A=
=0A=
* https://patchwork.kernel.org/patch/11258501/=0A=
* https://patchwork.kernel.org/patch/11258505/=0A=
=0A=
It also has additional acks from Abel and Stephen and the devfreq parts =0A=
of this series have already been accepted.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
