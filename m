Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0D0B537F
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2019 18:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbfIQQ7M (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Sep 2019 12:59:12 -0400
Received: from mail-eopbgr140040.outbound.protection.outlook.com ([40.107.14.40]:64736
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727936AbfIQQ7L (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 17 Sep 2019 12:59:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nKHZ5UH1tBvAKqgB1Z4+zaduJ3Noguc3Rs81RJBQj9JUiWVGSSDYY+jhGDeScDHEyVOz0O0LPRGlh0jvppgA+vZ7jas8QRC4xlP8FtR5sypWlOEoln4sPkCJ8JH3dwn+GbihIyWOxV1EOZ+FvZ6Z8sCvGAhr2c6r2Gr/2wo5vatv03bV8P88FB0OL+Hoc+JujQXX32oMFgLm8K+ipUE384riOcTGTP82y1Tl7aWSBau3rzg8mDsZVVKQYrh+ADjUicjcQyKQs/tD3toI9bKsZItAKkVBoBpR2pu7yX+I/p+Wsne3nFic2FjEDlOEYwbnJ/jBqqnRT52K6vnLshJGBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbU2rrspCG+0d2fYwQro1U279BxV8/zFN4LUC00lCUg=;
 b=liBXsTDFUcYs9fUM4LKNjHXpiELDI7tgylBoeuPO1pZvg/ugMc5WJYTspcnLJENHtnHqczC7r1VNT8Upkf0wX+c/qHUgGFEQ/Xn4BMKSHfATxC9M0awXA/tnb1+YkgSjBYxQ+vLvrmgmSBpbrMjeQF4YN+nRzCcnhuqeRf8asBSoQifzRIgarmQqJQ/hiOfc2W9BXtt6/QAtmNXAvJtcvXt8qdaxgGJvOW8VLM0IPwQBK9//Dx2fsUV0xRm3P7Sn9r7eam88HHRozNQ8nLEgyhQ2h8DTCWXgshPlh03tWfdBmQaHvDjs9jVdBZgVYRcCk1via6LP7w3qVRDHlXrxwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbU2rrspCG+0d2fYwQro1U279BxV8/zFN4LUC00lCUg=;
 b=V78rxD2Ze8nUiJRCQFiPKsgLdA67ZIHoKxLHL2B/fRlOydimcqJeY/8+mrpoygFpNbBkze8h44gYsn00Hs7vHDT0H07Me++sFzR4yTtL4aSHQwLEfiaKFRw7runBkP0qklR0Zj5iM/oHlwogObQXKHV/7871nr+WHVRYl0CExrw=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB4013.eurprd04.prod.outlook.com (10.171.182.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.18; Tue, 17 Sep 2019 16:59:07 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::c5e8:90f8:da97:947e]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::c5e8:90f8:da97:947e%3]) with mapi id 15.20.2263.023; Tue, 17 Sep 2019
 16:59:07 +0000
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
Date:   Tue, 17 Sep 2019 16:59:07 +0000
Message-ID: <VI1PR04MB7023D4F1F3D02E1C7773A3D1EE8F0@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1566315740.git.leonard.crestez@nxp.com>
 <90bfeebcb76e76d286ed7f022ea9e0d9a569ebe2.1566315740.git.leonard.crestez@nxp.com>
 <20190916203312.CF8D02067B@mail.kernel.org>
 <VI1PR04MB70239F26BE42AD5E6FC3639DEE8C0@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <20190917163215.A838020665@mail.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [82.144.34.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3adbe2bc-6b73-40a5-1fe9-08d73b905a65
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4013;
x-ms-traffictypediagnostic: VI1PR04MB4013:|VI1PR04MB4013:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB401379666716168E961C67D3EE8F0@VI1PR04MB4013.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01630974C0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(136003)(346002)(396003)(39860400002)(189003)(199004)(7416002)(5660300002)(446003)(44832011)(14454004)(66946007)(74316002)(14444005)(6116002)(66066001)(3846002)(53546011)(316002)(476003)(6506007)(71200400001)(33656002)(52536014)(4326008)(66476007)(66556008)(26005)(486006)(71190400001)(966005)(76116006)(91956017)(66446008)(54906003)(64756008)(6306002)(2906002)(55016002)(7736002)(9686003)(110136005)(86362001)(25786009)(6246003)(186003)(8936002)(8676002)(99286004)(81156014)(305945005)(81166006)(6436002)(256004)(7696005)(102836004)(76176011)(229853002)(478600001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4013;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fw1mYWuhLAAw+sCtAca1nIJPwUNaLCzrvaXSDligXTvTHoEDDBZ1GSuoiAxBiXFePEYWxMBdOMgjvqqWpBpjthTmwqmPJ9eCd+iTz8RPpiAa+5i8X3DyIzsdtFrtq7U+Pf5ndKpuWNkP1SMn/uvKaF8PpTUhgXAzHhy0FlpckpXvGiwwED+yGEXNzAAdvLi6T/v1JH8wc+MjLpFVOSDPbrd5PrkR/Zvd5XTdcRHCqZRk97aAHv7txexRaS6iknaqls0VGTLyzjmLDgDw3SFYWIjb3kzrh9fRR79SpSVSn9Wh9mFhiY8MJKw6wh/jKZuFCZBfT55MKX24ofei6Fk8/gP+2pi5Bpfomh9KZV0jxkPrMjrMINhRkS9ZwhUpa8u4ROgfHoijCmMsCM/xVdO5a1kcxu3ie0FdeQQFk8fgQQM=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3adbe2bc-6b73-40a5-1fe9-08d73b905a65
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2019 16:59:07.2209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5/WRbKoO1zVb5QdrMAk52KJBf95MXw9v2rz0Wgwh4Y/Cdo+wxtTYADyFxkyolpBD0eFCnD/b0pwdI9y9OkmnJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4013
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2019-09-17 7:32 PM, Stephen Boyd wrote:=0A=
> Quoting Leonard Crestez (2019-09-16 16:03:53)=0A=
>> On 2019-09-16 11:33 PM, Stephen Boyd wrote:=0A=
>>> Quoting Leonard Crestez (2019-08-20 08:45:06)=0A=
>>>> Dram frequency changes required modifying these clocks outside the=0A=
>>>> control of clk framework. Mark them as CLK_GET_RATE_NOCACHE so that=0A=
>>>> rates are always read back from registers.=0A=
>>>=0A=
>>> Why can't we control the clks from the clk framework? Please add that=
=0A=
>>> information in the commit text here.=0A=
>>=0A=
>> OK, I will update commit message and comments=0A=
>>=0A=
>> These clocks are only modified for DRAM frequency switches during which=
=0A=
>> DRAM is briefly inaccessible. The switch is performed with a SMC call to=
=0A=
>> by TF-A which runs from a SRAM area. Upon returning to linux several=0A=
>> clocks bits are modified and we need to update them.=0A=
>>=0A=
>> For rate bits an easy solution is to just mark with=0A=
>> CLK_GET_RATE_NOCACHE, muxes are handled explicitly.=0A=
> =0A=
> Is there any reason to expose or control these clks from Linux then? It=
=0A=
> might be easier to just make any children clks of the DRAM frequency clk=
=0A=
> "root" clks and then ignore any frequency that they might have.=0A=
> Similarly, because the SMC call is used to change the frequency, it may=
=0A=
> be simpler to handle that completely outside of the clk framework (it=0A=
> may already be this way in this patch series but I haven't read=0A=
> everything here).=0A=
=0A=
The dram alt/apb clocks are real imx8m composite clocks with the same HW =
=0A=
implementation as used for peripherals. They also have mux parents which =
=0A=
are under the control of the clock framework so the freq switching code =0A=
takes care to properly enable the new parents before calling SMC.=0A=
=0A=
See imx_ddrc_set_freq: https://patchwork.kernel.org/patch/11104145/=0A=
=0A=
Removing dram alt/apb clocks from the tree would still require keeping =0A=
possible parents enabled somehow. It wouldn't be simpler but a lot uglier.=
=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
