Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66EB6855E2
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2019 00:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389264AbfHGWfM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Aug 2019 18:35:12 -0400
Received: from mail-eopbgr30078.outbound.protection.outlook.com ([40.107.3.78]:42981
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729982AbfHGWfM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 7 Aug 2019 18:35:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ljqJhrJy5kbEti6IeIS/OaafaQqJ1cECotnJbaCy8TKUDs2JSKoXDzYu34nWqxOzzmexjqPwRGr5U7NJQNWZ3IiuaD6QDB6RHYp4Z91UFw3MMu8axZJKIfh/nE85/PYXwyIrpzqBpAstJQmLmvTLwVh2VrNGPjSK8a3UmvDYA3so8dsiSFme4h0pTxK9bqATRRnurcFExlx+esRyers+rzmI1wECDXNkUAUXunDS2lyVvHmpyZFFdEQ2BHuHHTnDuvU/0ncdOQa9Wwqhk/+3v5Dc37+z8MhdJhVbdDS509OR96JMaE9fg0E5HQhwBv71dJSiTCHiDW29elAUJ61zgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3sdQrCTDbR99WPf4oi0MONBwyfOaxGZN9xGd7NUP8U=;
 b=IHSn7nt90/s6431iNxl3JN3VPzpPD7xNM4xlVVUq/q9w3AxTrNN3JIZF1qDCqLYiX4g9AuofjHKqslWaJEJgu9yX+3Z64D4plOqKF9rKFzmrQ+gETul/MkvFu4onp9DrzcDHtlkK3dG3+/WFJZe81jAUPAcwuQ0WmkwuLNB0UpCy7/P9RkTibtJUjuzoCmL2/axcC4iUuHVgGWMwxQEapa+LZr+RcU/vKN10tcl5RyU69HpKzF/gBsAvzEiQ1R8BXI/LYGncyjp3dQ05hRs+jAIpvzXAA+wRHaYAGOM1ch2YiKn+mR/IDxyPJSv89/8IOeSzXsXEcL4NjeUD1sRydw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3sdQrCTDbR99WPf4oi0MONBwyfOaxGZN9xGd7NUP8U=;
 b=f4u7rVOKAmBtJ7cbPddr+KCKkvmW/7iRzNCYtOSt+mAFS9GmpbWeecwjYlenXwuhtGS7Wc8kNgFHF+TzKF4gVDf6cogo7xwa2DkjD94j7KAOZzsIY8sf83VMmHo/39dZxpGDhv8yDy31s+3BFCNL3UPb1XxaVCv1FcG/Ao94ZLU=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB4734.eurprd04.prod.outlook.com (20.177.48.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.17; Wed, 7 Aug 2019 22:35:07 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::e53d:e6a9:79bd:f970]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::e53d:e6a9:79bd:f970%2]) with mapi id 15.20.2157.015; Wed, 7 Aug 2019
 22:35:07 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     =?iso-8859-2?Q?Artur_=A6wigo=F1?= <a.swigon@partner.samsung.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFCv3 1/3] dt-bindings: interconnect: Add bindings for imx
Thread-Topic: [RFCv3 1/3] dt-bindings: interconnect: Add bindings for imx
Thread-Index: AQHVTEWJFkETi1lxO0+Qq1H7+p43Zg==
Date:   Wed, 7 Aug 2019 22:35:07 +0000
Message-ID: <VI1PR04MB7023CE6687A6D31D8BCB3E4EEED40@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1565088423.git.leonard.crestez@nxp.com>
 <90561b14af66655ca859d387b3808a84641eea4e.1565088423.git.leonard.crestez@nxp.com>
 <123536fc-c3ce-5bfe-fbd6-20cde0c13cc0@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [82.144.34.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 63a863aa-3f04-41fb-b0e6-08d71b877fc6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4734;
x-ms-traffictypediagnostic: VI1PR04MB4734:
x-microsoft-antispam-prvs: <VI1PR04MB473448761D986D76FC72B879EED40@VI1PR04MB4734.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1201;
x-forefront-prvs: 01221E3973
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(136003)(346002)(366004)(39860400002)(199004)(189003)(110136005)(33656002)(99286004)(4744005)(2906002)(6436002)(5660300002)(478600001)(25786009)(486006)(66066001)(76176011)(91956017)(14454004)(54906003)(4326008)(52536014)(476003)(66946007)(66476007)(7416002)(66556008)(76116006)(7696005)(66446008)(64756008)(53936002)(26005)(9686003)(86362001)(316002)(186003)(71200400001)(446003)(3846002)(102836004)(6116002)(6246003)(305945005)(55016002)(8936002)(6506007)(8676002)(81166006)(256004)(81156014)(7736002)(71190400001)(229853002)(53546011)(44832011)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4734;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gJLUqjlAov1UGeqohN49IYK1CqZrN51sJdEoTEkIAQ+38edsTKhuZM4HRCAOYtIfTj1SdOVxFXzV1jEhiGXu6vQe9qYBEXkuoW1VS5+obwmGdPmYT8Rvr/TyMZRJIIJlqqX8miJBNqiP3SnoK1P47mKI5v30xEOK4eNHxXVthnoZtFpxT0vaTbpii0u2FZN0/hdKf6ayrUUIKbh4jPg9C19h0Yw7Aey7BKPk8qYiRTjVv+hBNEK+vgTdLScAKDoKflQJ9ljerJ6m9hT3yRkWKkm82Mvhihx1AmYBQMeXKtrvMG1Cp24MsFgZbMYNmXK4TvRPlwlAvVQlfOejvMqEzDFmPKfxr9Z0nUvIFonlFwLeVG9hiQvUOGNdaRxDQTflE6oWcQYtVl9dngxqbL/B2OghtIxxthk5xrHC9sIWFP8=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a863aa-3f04-41fb-b0e6-08d71b877fc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2019 22:35:07.3026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LPWUbfBbU6cPr/8cHu7ec8YeR2f+h+/dfQfW2C8bPC+El0EF5eW0lJstb8vH0n/YvIa9tZnW058tJX4poXcsYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4734
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 8/7/2019 6:16 PM, Georgi Djakov wrote:=0A=
=0A=
> Please put some commit text.=0A=
=0A=
Will fix=0A=
=0A=
>> +properties:=0A=
>> +  compatible:=0A=
>> +    contains:=0A=
>> +      enum:=0A=
>> +        - fsl,imx8mm-interconnect=0A=
> =0A=
> Maybe fsl,imx8mm-busfreq? I thought it's called busfreq in downstream, bu=
t it's=0A=
> up to you.=0A=
=0A=
In the vendor tree busfreq is effectively its own subsystem with its own =
=0A=
API calls used by imx drivers. As part of replacing this with standard =0A=
devfreq + interconnect in upstream the old name should go away.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
