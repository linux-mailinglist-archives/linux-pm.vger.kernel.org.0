Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67F3D77734
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2019 08:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbfG0GTQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 27 Jul 2019 02:19:16 -0400
Received: from mail-eopbgr70053.outbound.protection.outlook.com ([40.107.7.53]:35298
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725905AbfG0GTQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 27 Jul 2019 02:19:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EASu/aFQ/yhpiH8W8C2W5y63U3BK0TN5WDbsdO0rZpblyyKOeeuyToM3IhdwleIsexhNMVCVGUFPTLzGwyfJUGGfydmg0+Fy55BaBi6XYX2+HdildE8Brn+HPf/S/y8HQvh75qs7PezNpFTyvSZguMo/SlNK4Co9S5zVOnoE1zWs4EreVODB/7IjdbyM/SEaZoyNJJ0DiW6h4i5bsVoIXxNMKaDpD1auuFoBjDjKw5YDX9Jvt8OvRt4Mk0OS5ULgCcbbfd1DazcLpqPbT7pZM8OXm8HG4i5Sx5FpdqLyTvWwSL1H8e6JWTC/W9tdx388cibnmQiWSuKk8Po9pZznEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZenlU5Mgg3iJLhndZGd7G00H4J/8pKUEeuI/1r0xT5E=;
 b=dDIxS42Xuco4YlPYh+cerUvDx5SeJgz4dGM2wTwzzuiw/mvV3CzhTUTDKem87ag5n6JudX1Dk/iXECg/F04rrpePbB5zUCtzmBcIIm3bGg0GoHrjAMt179J2fjhMQcK8dKvHNE5Qju3GSlFgCf5jLE3UmfB3JzcPx2cc1bkjzHHFVO/Ca44T5dlXqR+W2RWxVeuwELyq2gdhF/8Z1kMytvgAhbK2YT+0SRelB7PwlnTZWUbFVC6UxSADzxFCKuphFD/U3iYrgSOk0oZTyohPyDqe2R2ElZPH7b6lksLmw3D7zuZhLs7laFpmocpj950z3de3u9LFUachREdl+Y2EaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZenlU5Mgg3iJLhndZGd7G00H4J/8pKUEeuI/1r0xT5E=;
 b=ZoSlHlFeMjkVWkfXZHK3Y+xf+ABDFMDm+mkpIAttSXyh23ZwM+PhghdOSOwFOitoh3kY7U4kCkXAKyDcrMWEyjZ7oKyx9TUxL59lXsdKBNDopEhudnGpi6m+D3dO37ctqijEgayZse673mkO5LXjqWixlUWUtRqTkUAPVbm9pjs=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3899.eurprd04.prod.outlook.com (52.134.71.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Sat, 27 Jul 2019 06:19:07 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::7cdf:bddc:212c:f77e]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::7cdf:bddc:212c:f77e%4]) with mapi id 15.20.2094.017; Sat, 27 Jul 2019
 06:19:07 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Daniel Baluta <daniel.baluta@gmail.com>
CC:     "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Carlo Caione <ccaione@baylibre.com>,
        =?utf-8?B?R3VpZG8gR8O8bnRoZXI=?= <agx@sigxcpu.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 5/6] clk: imx8mq: Remove CLK_IS_CRITICAL flag for
 IMX8MQ_CLK_TMU_ROOT
Thread-Topic: [PATCH 5/6] clk: imx8mq: Remove CLK_IS_CRITICAL flag for
 IMX8MQ_CLK_TMU_ROOT
Thread-Index: AQHVMu9Qagn4ZAj9sUKncGzfKuws0abdnJEAgAB74HA=
Date:   Sat, 27 Jul 2019 06:19:07 +0000
Message-ID: <DB3PR0402MB3916233A56CF5DF778115716F5C30@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190705045612.27665-1-Anson.Huang@nxp.com>
 <20190705045612.27665-5-Anson.Huang@nxp.com>
 <CAEnQRZAZNMBx3ApVmRP8hYPw0XY_QgR-saE6WLcT8oZmHPCxSA@mail.gmail.com>
In-Reply-To: <CAEnQRZAZNMBx3ApVmRP8hYPw0XY_QgR-saE6WLcT8oZmHPCxSA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0947a3a-e0ae-4909-b22b-08d7125a54f7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3899;
x-ms-traffictypediagnostic: DB3PR0402MB3899:
x-microsoft-antispam-prvs: <DB3PR0402MB3899FC94EFEE7FE9B3695BD6F5C30@DB3PR0402MB3899.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:195;
x-forefront-prvs: 01110342A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(396003)(376002)(39860400002)(366004)(53754006)(189003)(199004)(76116006)(33656002)(478600001)(64756008)(66556008)(66946007)(53936002)(8676002)(81156014)(81166006)(9686003)(55016002)(66476007)(66446008)(3846002)(25786009)(4326008)(6246003)(316002)(186003)(26005)(229853002)(102836004)(11346002)(486006)(476003)(8936002)(44832011)(6916009)(86362001)(446003)(54906003)(6116002)(14454004)(6506007)(2906002)(6436002)(7416002)(5660300002)(74316002)(71200400001)(76176011)(68736007)(7736002)(66066001)(256004)(305945005)(99286004)(52536014)(71190400001)(7696005)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3899;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: p+9LiqLAK1OSsmN8pPuQRmWorlVr1ZnBEli46a9MViy98Q5nPDirqQgDKRSA3teryeEuQG2sktGVPMuUYEfLEXapAyBq9ffOu0N21fYs9uczVxc8xDogoo3XpQcCP9bl/s1rdd3IdKW25AeB4YrAAkLwHcnHFQwiAjdIicCPwnfXd4nqfD4pTxC2YUv4XLnfmaXnMREsZqF5ohAO8xME3lm+46XnXWQzmVQ7qkFlcciESEhMwmFkQXUg2hZtGEY8WOQFOjWwOCkDFSgi/UeQCeeCekP9Qjejxl2ORYabAWz6ZAAZesOc0htzLchQI9Xr99vNR22+TweGt1I8WPa+X4KZQVM1b5YUZic+KcqoKZCeUrHyAnaBnVLWI/v2zn2weuKQcLWkuP1WmYIWIhsQM0yBokZGrkx+Idb7XHoIqa8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0947a3a-e0ae-4909-b22b-08d7125a54f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2019 06:19:07.6381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3899
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIERhbmllbA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggNS82XSBjbGs6IGlteDhtcTogUmVt
b3ZlIENMS19JU19DUklUSUNBTCBmbGFnIGZvcg0KPiBJTVg4TVFfQ0xLX1RNVV9ST09UDQo+IA0K
PiBIaSBhbGwsDQo+IA0KPiBsYXRlc3QgbGludXgtbmV4dCBoYW5ncyBhdCBib290Lg0KPiANCj4g
Y29tbWl0IGZkZTUwYjk2YmU4MjFhYzk2NzNhN2UwMDg0N2NjNDYwNWJkODhmMzQgKEhFQUQgLT4g
bWFzdGVyLCB0YWc6DQo+IG5leHQtMjAxOTA3MjYsIG9yaWdpbi9tYXN0ZXIsIG9yaWdpbi9IRUFE
KQ0KPiBBdXRob3I6IFN0ZXBoZW4gUm90aHdlbGwgPHNmckBjYW5iLmF1dWcub3JnLmF1Pg0KPiBE
YXRlOiAgIEZyaSBKdWwgMjYgMTU6MTg6MDIgMjAxOSArMTAwMA0KPiANCj4gICAgIEFkZCBsaW51
eC1uZXh0IHNwZWNpZmljIGZpbGVzIGZvciAyMDE5MDcyNg0KPiANCj4gICAgIFNpZ25lZC1vZmYt
Ynk6IFN0ZXBoZW4gUm90aHdlbGwgPHNmckBjYW5iLmF1dWcub3JnLmF1Pg0KPiANCj4gDQo+IEkg
a25vdyB0aGlzIGlzIGNyYXp5IGJ1dCByZXZlcnRpbmcgY29tbWl0Og0KPiANCj4gY29tbWl0IDQz
MWJkZDFkZjQ4ZWUyODk2ZWE5OTgwZDkxNTNlM2FlYWYwYzgxZWYgKHJlZnMvYmlzZWN0L2JhZCkN
Cj4gQXV0aG9yOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gRGF0ZTogICBG
cmkgSnVsIDUgMTI6NTY6MTEgMjAxOSArMDgwMA0KPiANCj4gICAgIGNsazogaW14OG1xOiBSZW1v
dmUgQ0xLX0lTX0NSSVRJQ0FMIGZsYWcgZm9yIElNWDhNUV9DTEtfVE1VX1JPT1QNCj4gDQo+ICAg
ICBJTVg4TVFfQ0xLX1RNVV9ST09UIGlzIE9OTFkgdXNlZCBmb3IgdGhlcm1hbCBtb2R1bGUsIHRo
ZSBkcml2ZXINCj4gICAgIHNob3VsZCBtYW5hZ2UgdGhpcyBjbG9jaywgc28gbm8gbmVlZCB0byBo
YXZlIENMS19JU19DUklUSUNBTCBmbGFnDQo+ICAgICBzZXQuDQo+IA0KPiANCj4gDQo+IG1ha2Vz
IHRoZSBib290IHdvcmsgYWdhaW4uDQo+IA0KPiBBbnkgaWRlYT8NCg0KSSBqdXN0IGZvdW5kIGlm
IGRpc2FibGluZyBTRE1BMSwgdGhlbiBrZXJuZWwgY2FuIGJvb3QgdXAsIGl0IGRvZXMgTk9UIG1h
a2Ugc2Vuc2UNClRNVSBjbG9jayBpcyByZWxhdGVkIHRvIFNETUExLCBJIHdpbGwgY2hlY2sgd2l0
aCBkZXNpZ24gYW5kIGdldCBiYWNrIHRvIHlvdSBzb29uLg0KDQpBbnNvbg0KDQo=
