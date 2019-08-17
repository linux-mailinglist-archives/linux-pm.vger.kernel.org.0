Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22DBE91372
	for <lists+linux-pm@lfdr.de>; Sun, 18 Aug 2019 00:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfHQWWG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 17 Aug 2019 18:22:06 -0400
Received: from mail-eopbgr50051.outbound.protection.outlook.com ([40.107.5.51]:36810
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726208AbfHQWWG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 17 Aug 2019 18:22:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JHgQoNR6jvOO3CL7cDxmMH8V7BSZWsYMH4CWJXzgEF+NSxuiXjjoiBvgMXzKdVeDqmIjaZ15Y/Xj0MWRFJoc8QOIN9JFqo+4PReWmQ4sTYClny9txks0F/zQ7a/XxSxW076xaD0AEgUi1hsU8ZedPkIM83OE5a2ZxywmI0piUss/DLwoOSzxzR47oBujRAW8zlwDA36q+YpTmwtwZsbcUmRur6SVdGV7SGKhnVWKePDWzVTbOtUxz49UTa5IY5uZVSgQZKDn5hxPn7ZyW/ZvXBAUSOx7jAoLJRjv4Fgsz9noo4e5HP+DJDykzYGOpcDYwAMKAxiJoFl2LWq48sIE7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFWhBSdl0k4E5SqA5OwufSooxx30zIoHOYUawBpTwl0=;
 b=Nr6rH86voZ6pSOok5qCuVSuernC9dlf8TUz9jgO4JMaQJ1BZT+EIYIhtGCQS09csU6oywSW1iX4436CBnqxPd0yfqI6OK3fs4P2r9tuWAF4/GMWLYCYRGqNNLhqABC61EMuG75V/LzEfj9Hr8tgVqvBzLzBK3YvdjL0U+E0k79i6njd01YXOL02JiTYO0/oeTi5QMF6RdiCMMC9upE3fX6CWT1g1wFRYoIqkp/mp/4GTAsMHqxlAzUOpT81ufr80QeSH7EMWAPQABBhQhdGt8ZFrScH6YYLZ/ywR1p7j8JSkZaHC8OCTMlt+lOCrW0ov6z0FKbtWbo2XYm45nH1neA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFWhBSdl0k4E5SqA5OwufSooxx30zIoHOYUawBpTwl0=;
 b=s+4WXnz5UJ2xI41r46/DjqyjgXhblOzQJWwVfjDxJ5rMagltP+v+zZFoHXaKAt+3cCOEGv9ZO4oe2uwEznVw6a53oh01zH0uqMMtE9nD4niV+pQ8lIj+NcO+LTtpy/OOAaDDCR0VyeOEqL2wghQFLAuLuNGKca58xlI8+a5pujA=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3865.eurprd04.prod.outlook.com (52.134.73.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Sat, 17 Aug 2019 22:22:01 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::7cdf:bddc:212c:f77e]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::7cdf:bddc:212c:f77e%4]) with mapi id 15.20.2178.018; Sat, 17 Aug 2019
 22:22:01 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>, Abel Vesa <abel.vesa@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 5/6] clk: imx8mn: Add necessary frequency support for ARM
 PLL table
Thread-Topic: [PATCH 5/6] clk: imx8mn: Add necessary frequency support for ARM
 PLL table
Thread-Index: AQHVU1smspIlsoJa7UagSycBskV9A6b+t5+AgAE1uXA=
Date:   Sat, 17 Aug 2019 22:22:01 +0000
Message-ID: <DB3PR0402MB3916D320EB51B2D9E28D55E1F5AE0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1565866783-19672-1-git-send-email-Anson.Huang@nxp.com>
 <1565866783-19672-5-git-send-email-Anson.Huang@nxp.com>
 <20190817035220.268F32173B@mail.kernel.org>
In-Reply-To: <20190817035220.268F32173B@mail.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [183.192.23.231]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea346ea0-08ab-4a90-2c92-08d723615346
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB3PR0402MB3865;
x-ms-traffictypediagnostic: DB3PR0402MB3865:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB38658A3ACC2FA6FA7A04B804F5AE0@DB3PR0402MB3865.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:758;
x-forefront-prvs: 0132C558ED
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(189003)(199004)(53936002)(76116006)(66066001)(6246003)(6436002)(66476007)(64756008)(7416002)(66446008)(102836004)(66556008)(66946007)(3846002)(6116002)(25786009)(4326008)(256004)(52536014)(2501003)(7736002)(478600001)(74316002)(86362001)(5660300002)(14454004)(446003)(11346002)(55016002)(486006)(33656002)(305945005)(2201001)(7696005)(76176011)(26005)(6506007)(186003)(99286004)(71190400001)(71200400001)(4744005)(110136005)(8936002)(44832011)(229853002)(9686003)(2906002)(316002)(8676002)(476003)(81166006)(81156014)(32563001)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3865;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1x9ESFekx8XTRA3HCxLENEooPkH4IzcZ7ekmqV8MRXNX5nsVHHbUaUvYZn/ieXmjcvoYXxsWU3GYXBGWWa/vR/qFf5OOLw5ReMB+hS1xKiySohRt12YNX3CWrYrfV08wdrZPnPx1+Io3huUf95OMYuf1BaZWFUFdaDhbxNXjLumfxG3orhpSlF+jR8HuOVeY1JKc4u2Qj1tUeDpxHPea5wvS0n/+xoqzneLppj4C7rTDBuYfNWslVdaaaI8rXNoezUxh/nMwqxqNobx6WKFlRETrPTTUWwzcnzWFD7XfDRk22cLX8iYGgZayb9OMYWuJC1BXBLaRjSLMDLtv5Co9QRb310OIgp9FX8wEkL431gLbHtMdPJvX7eZxmEsbBcTcahncqzajfq0LWtV48Af2ArAaAHe2AqoCWcOst5+dI5M=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea346ea0-08ab-4a90-2c92-08d723615346
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2019 22:22:01.1712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2ilHk5nN34KfNTGmrJCKlxtT1u9mdJPyBixcmm64KrNAJii0ofWvXl7t3cX3k18+LgubwGcUjer9no6MBunLgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3865
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIFN0ZXBoZW4NCg0KPiBRdW90aW5nIEFuc29uLkh1YW5nQG54cC5jb20gKDIwMTktMDgtMTUg
MDM6NTk6NDIpDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2lteC9jbGstaW14OG1uLmMN
Cj4gPiBiL2RyaXZlcnMvY2xrL2lteC9jbGstaW14OG1uLmMgaW5kZXggZWNkMTA2Mi4uM2YxMjM5
YSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2Nsay9pbXgvY2xrLWlteDhtbi5jDQo+ID4gKysr
IGIvZHJpdmVycy9jbGsvaW14L2Nsay1pbXg4bW4uYw0KPiA+IEBAIC04Miw2ICs4NCw3IEBAIHN0
YXRpYyBzdHJ1Y3QgaW14X3BsbDE0eHhfY2xrIGlteDhtbl9kcmFtX3BsbCA9IHsNCj4gPiBzdGF0
aWMgc3RydWN0IGlteF9wbGwxNHh4X2NsayBpbXg4bW5fYXJtX3BsbCA9IHsNCj4gPiAgICAgICAg
ICAgICAgICAgLnR5cGUgPSBQTExfMTQxNlgsDQo+ID4gICAgICAgICAgICAgICAgIC5yYXRlX3Rh
YmxlID0gaW14OG1uX3BsbDE0MTZ4X3RibCwNCj4gPiArICAgICAgICAgICAgICAgLnJhdGVfY291
bnQgPSBBUlJBWV9TSVpFKGlteDhtbl9wbGwxNDE2eF90YmwpLA0KPiANCj4gV2h5IGlzIHJhdGVf
Y291bnQgYWRkZWQ/IFRoYXQncyBub3QgZGVzY3JpYmVkIGluIHRoZSBjb21taXQgdGV4dC4NCg0K
cmF0ZV9jb3VudCBpcyBuZWNlc3NhcnkgZm9yIHRhYmxlIHNlYXJjaCBkdXJpbmcgc2V0X3JhdGUs
IGl0IHdhcyBtaXNzZWQgcHJldmlvdXNseSwNCkkgd2lsbCBhZGQgaXQgaW50byBjb21taXQgdGV4
dCBpbiBWMi4NCg0KVGhhbmtzLA0KQW5zb24uDQoNCg==
