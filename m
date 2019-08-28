Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13F629FE54
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2019 11:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfH1JVn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Aug 2019 05:21:43 -0400
Received: from mail-eopbgr150058.outbound.protection.outlook.com ([40.107.15.58]:43590
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726370AbfH1JVm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 28 Aug 2019 05:21:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HpgXS7uP0ghnmwTpy80fa1m9mXzW8qi80M7jw4tmMcFqUj3pj2dqNA8IY+P6EDsniyl752X/+A70fUz30ok06y/LLIZZ8a2f1VLKWwxpzGYMx6lFin2H7sKC7xlgoc2e8svPdhuZXnc+9dUHVvR3Fkj+1NbB3XhW+X8yW0fjg7fJCHoxBd4ZmcDMAmG0Y6GvJY9Ri4PNoXIhByqBictj6du+eVLX6NT+ipQkcSsQUE87xXFVEGyV7WY79YElT0y1Y3JvZpqZbsmcp3lbi4NSuGYgJJCiJ71ruhkERviIqUV7z9irI+H1nR+n5iCyJPEa8F64OWIO0SO1sSG+CzB8gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKL2IsxJZOdhH7Q0shhslGeeIbmY3oWF+h7HeDZwG1U=;
 b=d8OaJWWrXmasbeaAyxM609zsQ1kBpxZs+scDnMRrK9Pwj8hjSty2aaj5sTTiVLcZGctMdPf+b4tC/hqEHAM0yUi8H4uUMDPTj/D/Oje4H74ijP23bozljoJqF88sBCGCYd4916dvRslaU5/Tx9vXxtAORIYJSIW5O+F/+y6Rb/eQG6LABjvJL36nM7C1RlcpnsD/aTFzU52j+hDjGwu80akrrBRTbTQi42ZdliyRv5ZO8bkL8fCEbDe1XXpoVt6oZ8cn+9Tua5lDGmyg26vG7PX1zdc4MFw2+U7enGeql/IZmq1ExbBQrRPZ7vAqhFLvvWeILbsKj8+bDsFUuIw4Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKL2IsxJZOdhH7Q0shhslGeeIbmY3oWF+h7HeDZwG1U=;
 b=WRrAvkH53Qk/fBvXka1c1dRKONpYZdaWaf83mH+TARAdcCZpbNkHeMVKo/InqYR/scu+VGu/5L8j5ml61caOADky/Bh/ZyhUtI5KPy0+OgK4GTuEahq/zCS4KyXwwGvZBkbGUkJDAcVCL5uXC2LrcuCHtfSwDgeFyQo0wACftuA=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3947.eurprd04.prod.outlook.com (52.134.67.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.19; Wed, 28 Aug 2019 09:20:58 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::8958:299c:bc54:2a38]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::8958:299c:bc54:2a38%7]) with mapi id 15.20.2199.021; Wed, 28 Aug 2019
 09:20:58 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Peng Fan <peng.fan@nxp.com>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "olof@lixom.net" <olof@lixom.net>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V15 1/5] dt-bindings: fsl: scu: add thermal binding
Thread-Topic: [PATCH V15 1/5] dt-bindings: fsl: scu: add thermal binding
Thread-Index: AQHVJXvnLQPj9qjL2U2LZTWuyBDONqaqeq9ggC7WvJCAN2WDgIAAARuQ
Date:   Wed, 28 Aug 2019 09:20:58 +0000
Message-ID: <DB3PR0402MB3916DF85E27F417C0A0BD93CF5A30@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190618021820.14885-1-Anson.Huang@nxp.com>
         <DB3PR0402MB39162C5B5AF828B127DD871EF5E00@DB3PR0402MB3916.eurprd04.prod.outlook.com>
         <DB3PR0402MB39162EB555CD7AE75D58C582F5C60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <ff3fd0ab2ba659e98070760be8e7c0f223e921f9.camel@intel.com>
In-Reply-To: <ff3fd0ab2ba659e98070760be8e7c0f223e921f9.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a2f4b00-a6c0-4126-97ed-08d72b990989
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3947;
x-ms-traffictypediagnostic: DB3PR0402MB3947:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3947D6264273B572F855CA76F5A30@DB3PR0402MB3947.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(189003)(199004)(476003)(2906002)(66446008)(64756008)(9686003)(74316002)(2501003)(486006)(6246003)(44832011)(66556008)(55016002)(5660300002)(66476007)(11346002)(66946007)(478600001)(53936002)(316002)(71190400001)(71200400001)(102836004)(305945005)(7736002)(186003)(26005)(76116006)(446003)(7696005)(2201001)(81166006)(81156014)(14444005)(256004)(8676002)(66066001)(110136005)(6436002)(25786009)(52536014)(33656002)(7416002)(4326008)(86362001)(4744005)(3846002)(6506007)(229853002)(8936002)(6116002)(14454004)(99286004)(76176011)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3947;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MXQzO9/Z9glsvEFDq0wUK3RvqHgIDcxt9tAn+zmWV0ewXQTVm5IoryLxlf72KGBeemctx8rEOdTmKalVc61JgItnwW6JxPo0ZT1NZAZoBLvBnuM4HMDUYVop8w1+O8xIToAaFVWd85agJMdK3cuDCZjgSbuVzqgqPxYjxZOnjfmXvoXZc9dn2OKNnVvCkTaYLY64gKBGxf2Mi7hZjyYwqSCNHJ09eZ+QpI7VsIOw8AiX+E9Y1y1LOsKiEDCjm+ihXD/QeX3CowHph2qXyUlQkIhZHyJeu1RexozYuvl7dShiVWfGFbRzIfC3QXz0P8LA7QXtdFrAhXqfTtHCW7FOUwFa7a8i2nos9TYsfDJ83d6nIVC9YKeT4B/pUhOHuA9Ht7tesMcJh+GD/Yl0HNkTKnd9gqTQrh275tRM7Ssfolg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a2f4b00-a6c0-4126-97ed-08d72b990989
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 09:20:58.5188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KavFyoMBK0926nykUjpW50qdbm5X/xiArMNLBsTzpiN2+05y/+Muk25/Z30UmuKQMlyo7NoSZlk6rMyOE2nHyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3947
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIFJ1aQ0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjE1IDEvNV0gZHQtYmluZGluZ3M6IGZz
bDogc2N1OiBhZGQgdGhlcm1hbCBiaW5kaW5nDQo+IA0KPiBIaSwgQW5zb24sDQo+IA0KPiBXZSdy
ZSBtaXNzaW5nIEFDSyBmcm9tIHRoZSBtYWludGFpbmVycyBmb3IgcGF0Y2ggNC81IGFuZCA1LzUs
IGlmIHdlIHdhbnQgdG8NCj4gc2hpcHBlZCB0aGUgcGF0Y2ggdmlhIHRoZXJtYWwgdHJlZS4NCg0K
SSB0aGluayA0LzUgYW5kIDUvNSBjYW4gYmUgdGFrZW4gYnkgU2hhd24gR3VvIG9uY2UgdGhlIGRy
aXZlciBwYXJ0IGlzIHRha2VuLCBoZQ0Kbm9ybWFsbHkgZG8gaXQgaW4gdGhpcyB3YXksIG9uY2Ug
ZHJpdmVyIGFuZCBkdC1iaW5kaW5nIGFyZSB0YWtlbiwgSSB3aWxsIG5vdGlmeSBoaW0uDQoNCj4g
DQo+IEZvciBwYXRjaCAyLzUsIGFzIGl0IGludHJvZHVjZXMgYSBuZXcgQVBJIGZvciBPRl9USEVS
TUFMLCBJJ2QgbGlrZSB0byBnZXQNCj4gRWR1YXJkbycgZmVlZGJhY2sgYmVmb3JlIHRha2luZyB0
aGVtLg0KDQpPSywgTk9UIHN1cmUgd2hlbiBoZSBjYW4gdGFrZSBhIGxvb2sgYXQgaXQsIHdlIGFy
ZSBraW5kIG9mIHBlbmRpbmcgb24gdGhpcyBmb3Igc29tZQ0KdGltZSwgbGV0J3Mgd2FpdC4gSWYg
eW91IGhhdmUgY2hhbmNlIHRvIHRhbGsgdG8gaGltLCBwbGVhc2UgaGVscCBhc2sgZm9yIGhlbHAg
ZnJvbSBoaW0gYWJvdXQNCnRoaXMgcGF0Y2ggc2VyaWVzLCB0aGFua3MgYSBsb3QhDQoNCnRoYW5r
cywNCkFuc29uDQoNCg0K
