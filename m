Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 951EA5969A
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2019 10:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfF1I4j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Jun 2019 04:56:39 -0400
Received: from mail-eopbgr30083.outbound.protection.outlook.com ([40.107.3.83]:29508
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725873AbfF1I4j (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 28 Jun 2019 04:56:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yh6ZDgkmlXiASlzlGNuzTF2gRBpcrNdE7OKbE2xNDMQ=;
 b=pPij8F0zhyZ0XooiAfXqlNmNvDxDtuLuP5Sh8OKZo3/iVAkY9sZcsNumHMJd0RluFjBw48pcbNvhIpV9vPyHY56U+66xpyqZcsxJNHJY482D02vNsqiiNXwZQdbhvnv/WdWcmJU81YGOCS48xGGE/VCtsufx9KIpc4VssRqb3H0=
Received: from VI1PR04MB5055.eurprd04.prod.outlook.com (20.177.50.140) by
 VI1PR04MB5904.eurprd04.prod.outlook.com (20.178.205.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.18; Fri, 28 Jun 2019 08:56:36 +0000
Received: from VI1PR04MB5055.eurprd04.prod.outlook.com
 ([fe80::d83:14c4:dedb:213b]) by VI1PR04MB5055.eurprd04.prod.outlook.com
 ([fe80::d83:14c4:dedb:213b%5]) with mapi id 15.20.2008.014; Fri, 28 Jun 2019
 08:56:36 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>
CC:     Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFCv2 2/8] clk: imx8m-composite: Switch to determine_rate
Thread-Topic: [RFCv2 2/8] clk: imx8m-composite: Switch to determine_rate
Thread-Index: AQHVLYSz7P3EKbmmJkGmgseyFA+2Lg==
Date:   Fri, 28 Jun 2019 08:56:35 +0000
Message-ID: <VI1PR04MB50552AC6EAB0C145D638E618EEFC0@VI1PR04MB5055.eurprd04.prod.outlook.com>
References: <cover.1561707104.git.leonard.crestez@nxp.com>
 <5d62b31309e6402bd9fa608730518b39af823fb3.1561707104.git.leonard.crestez@nxp.com>
 <20190628084521.d64d5g54zvxlsxsl@fsr-ub1664-175>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fba8cb19-8627-479b-a388-08d6fba6868f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5904;
x-ms-traffictypediagnostic: VI1PR04MB5904:
x-microsoft-antispam-prvs: <VI1PR04MB590424E23F540734F4D98106EEFC0@VI1PR04MB5904.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 00826B6158
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(199004)(189003)(316002)(5660300002)(6246003)(66946007)(73956011)(54906003)(66446008)(76116006)(66476007)(66556008)(64756008)(74316002)(6636002)(3846002)(6116002)(8936002)(52536014)(305945005)(8676002)(81166006)(81156014)(7736002)(86362001)(2906002)(25786009)(4326008)(71200400001)(71190400001)(6862004)(256004)(14444005)(446003)(7416002)(476003)(486006)(44832011)(26005)(14454004)(33656002)(478600001)(66066001)(68736007)(76176011)(7696005)(229853002)(6506007)(53546011)(6436002)(55016002)(102836004)(186003)(99286004)(4744005)(9686003)(53936002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5904;H:VI1PR04MB5055.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BYjYEax1jrqNb1U9U2ga45r1I7Ccj/wZ6TWsIqKDptIrLLr4UTV6d+E0trW4fh2HWCEj5XUITfhYAa12HiDTYj6beNNLwd3WsojUggUmZJnToWZ/iRDe01slEgnFMkYM1mCzcqAOU5v8EokzJDf/v6bZiCZj/a8WKEX/U3kgI8wuscxqVbgdMVGrpWMixelxEMP1uEWLzqcPFckS7yObracp3bRffWWJWASsigh8fQJRMyh3rrdH3CBo/xrFZf724u9NdewpRU4eDaAk0TkqcjO4AVW+W55BcXeqAaX0paorapmJ4QLbCQ61biqf/4VKHolXrzCkuRcKFQfh8IdmLnQU+JWhkO4dqxI1sFuTBvOMtcPaP4Y8O5tV7ZdxsCes7NGqbFw9LpEDdo8hbu7oopXcYB/Eht8ZUI1ti1WhzGo=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fba8cb19-8627-479b-a388-08d6fba6868f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2019 08:56:35.8798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leonard.crestez@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5904
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28.06.2019 11:45, Abel Vesa wrote:=0A=
> On 19-06-28 10:39:50, Leonard Crestez wrote:=0A=
=0A=
>> This allows consumers to use min_rate max_rate.=0A=
>>=0A=
>> @@ -45,10 +45,12 @@ static unsigned long imx8m_clk_composite_divider_rec=
alc_rate(struct clk_hw *hw,=0A=
>>   				   divider->flags, PCG_DIV_WIDTH);=0A=
>>   }=0A=
>>   =0A=
>>   static int imx8m_clk_composite_compute_dividers(unsigned long rate,=0A=
>>   						unsigned long parent_rate,=0A=
>> +						unsigned long min_rate,=0A=
>> +						unsigned long max_rate,=0A=
> =0A=
> You should pass on the req instead of min_rate and max_rate here.=0A=
=0A=
Then I'd have to switch imx8m_clk_composite_divider_set_rate to allocate =
=0A=
a dummy struct clk_rate_request on the stack. It's clearer if I just =0A=
pass the minimum parameters required.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
