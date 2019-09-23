Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F20C6BBAA5
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2019 19:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407676AbfIWRmu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Sep 2019 13:42:50 -0400
Received: from mail-eopbgr60076.outbound.protection.outlook.com ([40.107.6.76]:35138
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2394159AbfIWRmu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 23 Sep 2019 13:42:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZ2kSS+BOvyHG93Zo9qPbTX+65iL2FwwR2Ee6EcMcdo93DlLQj7dHgMsyAOwLjukWQBdD6VA9+NrSoBl+sFA/aCa7ZzbGMsprJROadR4ePtbUUw0H91okYhjYFuRSYV/lrijBSzOEJQ5fWX7IaIjVzc6Ez9azLSlaN7WsMzpUiFfslRleVccN21R/ud7s3nk26hEci12LFTaUvYbwUrESTtlFLDVHhRct3EUXcl8MU/TprDakaeePDmIBEcp7LuyOTBNeLAH4z6TryErDBKQdZH1WVD4+CiV5blezobeAboIlH6+Opdp0TKoW+/998DkR/t1/VkeNpxTqHnWdIDg7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJOJKN+sgBaEcTrpzkZQWFwbu+adaMmk0WcYQfXqFF0=;
 b=FPndjIopvvYNJl10VNATxsm//AB7fwYBiimo3nuthjjRpPGfFdAZzbDf72kcOFM54tbO6Ker2UwUANKfqP5B0Y9dbqqjG+tR6W+pAsBcob1+AGZunRqgFDA41wqrbU3/fROXseSHQmjeMpNi84xwDVtkDTPcSriBvNBXf7XX9zWP+fvHmI/3OhPOBf8HKcl1uIT3UoE1Clcp0qksfuiuI+5i6rOidMSmWMMWHzI/VCxp4bEoMtWt33JW+qQr8sBdqxAC+v50HC36KXP6NQ7/9li3NkAv/NHSKGYglJHKWoUJ3QxIWR/2aUTuIHQGt9S6ultVNe/pGP4gGo5Lb0xCfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJOJKN+sgBaEcTrpzkZQWFwbu+adaMmk0WcYQfXqFF0=;
 b=FkE6XXS+6gk8Hl7V9MvID47Qj5B9Fw9ePTzpWCfJephtV38u+ONEspVXngr72wJ3Cd7XCTCQ/ekPAf9QBYKeyfJRIf9ekHk6gm8ub1JUbI/goXSQX+xpRT4/0AOjVB4ct4Qcro9cQxFkvl4enP07sHGT1N1MkCEsVspgIkZ7Huo=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB6782.eurprd04.prod.outlook.com (52.133.247.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Mon, 23 Sep 2019 17:42:46 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::15cd:b6e7:5016:ae8]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::15cd:b6e7:5016:ae8%2]) with mapi id 15.20.2284.023; Mon, 23 Sep 2019
 17:42:46 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>
CC:     =?iso-8859-2?Q?Artur_=A6wigo=F1?= <a.swigon@partner.samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFCv4 3/7] dt-bindings: devfreq: imx: Describe interconnect
 properties
Thread-Topic: [RFCv4 3/7] dt-bindings: devfreq: imx: Describe interconnect
 properties
Thread-Index: AQHVWcA+RMYwTA9YVU2r3Zx7nMHKVw==
Date:   Mon, 23 Sep 2019 17:42:46 +0000
Message-ID: <VI1PR04MB70237046A8DF88936C7A83F8EE850@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1566570260.git.leonard.crestez@nxp.com>
 <3f27038292c09c8bf07a086eac759132c100aedb.1566570260.git.leonard.crestez@nxp.com>
 <20190917201956.GA10780@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40eb87d4-953e-4189-061a-08d7404d720b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB6782;
x-ms-traffictypediagnostic: VI1PR04MB6782:|VI1PR04MB6782:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB6782F9B4EF420D96EA4C43A7EE850@VI1PR04MB6782.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0169092318
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(376002)(39860400002)(346002)(136003)(199004)(189003)(3846002)(81156014)(8936002)(81166006)(110136005)(54906003)(2906002)(66946007)(66556008)(66476007)(66446008)(64756008)(44832011)(486006)(446003)(86362001)(14444005)(256004)(966005)(8676002)(14454004)(76116006)(91956017)(476003)(66066001)(33656002)(102836004)(74316002)(305945005)(76176011)(7696005)(71190400001)(9686003)(71200400001)(229853002)(6306002)(6436002)(25786009)(55016002)(52536014)(316002)(5660300002)(53546011)(6506007)(4326008)(99286004)(7736002)(7416002)(478600001)(6116002)(186003)(26005)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6782;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6lIyBnFfI3J0zxy4jQGH7pkIzn+bMkMW5Q9GBuF7rajQYfq2tIbaoyijLUBW6fl//nehw9ixMMBZAEmz4FBnxsZqKiUib4GRPlNGc2KVTQKwTcr0oKfwhGEaw8ZQVwXQndgrjKahbRcxWhnUdwzTjswJ0TZn0a3e2Ze0gKIgcrz22Grdfaajnuxmryf55qMgqat/SZHKiO/C3PQXfiRIP5/hVzHCXRi2pZp5NoTEbj6jfSxfGCH/LCnvniK04/qVayoP7rd4UxBtZarh84wZRQVTSNQngMct/qHqZ/nr8sP38zDQjLIGan5+k7neJdnNjLAYNuGnKSTUvWBmEreGzHpUSj6HukGW/0ZsbO42f11PU/QjJGZ64fjJzl8XnTBKXy3otJht3/5jGEIWWRvtt4fsG8X5FM0SNpo61Ka7bSA=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40eb87d4-953e-4189-061a-08d7404d720b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2019 17:42:46.4337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kAp2IonbTaGyWFyLosPDlEw7i7W2lY9Ag9nVh38L40J6IjKUtMCWN6M2saeXUy0f3TtN94+/Rg6xj47Dp9jMPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6782
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17.09.2019 23:20, Rob Herring wrote:=0A=
> On Fri, Aug 23, 2019 at 05:36:56PM +0300, Leonard Crestez wrote:=0A=
>> The interconnect-node-id property is parsed by the imx interconnect=0A=
>> driver to find nodes on which frequencies can be adjusted.=0A=
>>=0A=
>> Add #interconnect-cells so that device drivers can request paths from=0A=
>> bus nodes instead of requiring a separate "virtual" node to represent=0A=
>> the interconnect itself.=0A=
>>=0A=
>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
>> ---=0A=
>>   Documentation/devicetree/bindings/devfreq/imx-ddrc.yaml | 5 +++++=0A=
>>   Documentation/devicetree/bindings/devfreq/imx.yaml      | 5 +++++=0A=
>>   2 files changed, 10 insertions(+)=0A=
> =0A=
> Please combine this with the other series for devfreq support.=0A=
=0A=
I understand that having two series which add to the same bindings file =0A=
is odd but the devfreq and interconnect parts are independent to a very =0A=
large degree and devfreq can be useful on it's own.=0A=
=0A=
The only reason devfreq bindings are updated is to avoid adding a =0A=
"virtual" node for interconnect. Since DT is a big source of confusion =0A=
here can you read https://patchwork.kernel.org/cover/11111865/#22883457 =0A=
and maybe offer some advice?=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
