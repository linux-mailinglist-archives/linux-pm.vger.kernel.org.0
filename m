Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 483FC7449C
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2019 07:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390278AbfGYFBL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jul 2019 01:01:11 -0400
Received: from mail-eopbgr150072.outbound.protection.outlook.com ([40.107.15.72]:1720
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390276AbfGYFBL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 25 Jul 2019 01:01:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1uqln14pPNXeBBG06PljrKrep6/JF8Zv+uDRZVA6NLDUrPa/5OeXpVgi26bI8SQaq2Lhu4ODuWxpE5lKSTJCW24Qiuwa6W0XRsjaxFYNL4FENiI/8HRFctz2FZMsekClEVJyD76tJLn8jxw7zSoU9IUVCkuhD74aBrKe32zNEjX0+KMgJyJ9rlhD+JLbX8IYNqa8F6HPznqCtErrZM/z3AzCWSnQqG8MFhW+avwP2s51FLZSlyQgsvBm7VleAQQHtFK41dJRf7hX1zMlM1Y+6IGOMcCMBnQitAGlE2bjlFj1RW/P0RHdT93cceTcBexEJqqmNNsM7I4CVCOUd1ssA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0QMxqmWkFDkSsvkTqEc8WQd+7/KxSQSAZ5sD/pnr6I=;
 b=f76Okh12szXQ+vOt55C2A+RovguDrS/MyNOsmxNFDeNvxV9C67+KJj7ppp/zmlflxkFavk8L1ihBxy4/QvCbJl21++R1GY3qW5E8H/FD3KVy4A5sz3P2mQ8oLgV3uDx2tBQOgPrWan0yZ7MubmCwlb4UFFngo95WPgyfTz2yAbhD2NpzfYzO7e0ZuC0ZIz96KtAt3tLiTsltEY6A12j6wqNc1+gNrfzBHpclFe0eoChftcC35x/W/GbpnE+BuKAXZjdie1nkcYgWJ55WBvTG2+XxbMK6eTVpegpbm7B14bU/8UwZ/ZKzgZEVtiNt5m4rJqr/jd7p4mZA6GHFkqFT0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0QMxqmWkFDkSsvkTqEc8WQd+7/KxSQSAZ5sD/pnr6I=;
 b=SYoHO8XWFUC+1wG1qZzC0HDU7shXenrck2t8SClzXb2hFHvKdBPEEdAiL+9NI2nR0xupyKnnizQAwbSJZoAcIJBkjc2d/cyaXduxMxUzgTFI7My5rTG3SoV7gWEKRw5P66oq1BQICUxMxJY1tjoQLovaGtZJXrVLvhY46JSKpq4=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3754.eurprd04.prod.outlook.com (52.134.67.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Thu, 25 Jul 2019 05:01:07 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::7cdf:bddc:212c:f77e]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::7cdf:bddc:212c:f77e%4]) with mapi id 15.20.2094.017; Thu, 25 Jul 2019
 05:01:07 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>
CC:     "vireshk@kernel.org" <vireshk@kernel.org>, "nm@ti.com" <nm@ti.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        Jacky Bai <ping.bai@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2 1/4] dt-bindings: opp: Support multiple opp-suspend
 properties
Thread-Topic: [PATCH V2 1/4] dt-bindings: opp: Support multiple opp-suspend
 properties
Thread-Index: AQHVNi2qV9keysXgFk2WQTpmSP5dxqbatEqAgAAq9PA=
Date:   Thu, 25 Jul 2019 05:01:06 +0000
Message-ID: <DB3PR0402MB3916B85B1CEAADF83DA04C68F5C10@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190709080015.43442-1-Anson.Huang@nxp.com>
 <20190725022611.f6dirdstu3yndcwy@vireshk-i7>
In-Reply-To: <20190725022611.f6dirdstu3yndcwy@vireshk-i7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43b77ee7-6127-4938-de61-08d710bd1a4a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3754;
x-ms-traffictypediagnostic: DB3PR0402MB3754:
x-microsoft-antispam-prvs: <DB3PR0402MB3754E440152CEFCA1BC7275EF5C10@DB3PR0402MB3754.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0109D382B0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(199004)(189003)(25786009)(14444005)(8936002)(5660300002)(6116002)(110136005)(54906003)(6246003)(81156014)(8676002)(74316002)(4326008)(3846002)(15650500001)(2906002)(316002)(14454004)(53936002)(305945005)(446003)(81166006)(256004)(186003)(53546011)(476003)(7736002)(52536014)(66066001)(478600001)(66476007)(68736007)(64756008)(66556008)(76176011)(44832011)(7696005)(66446008)(33656002)(76116006)(4744005)(486006)(71190400001)(9686003)(6506007)(71200400001)(26005)(229853002)(55016002)(86362001)(11346002)(99286004)(102836004)(6436002)(66946007)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3754;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cr308nxpIAAhlvWK3El329hoZGhvE12f2oXKylq76FoESYD0LgKcTMJtKD43CCpw2Z52jjd9hnjAxmC3uFxK5ZWXEZswborGpDzhSLTv9QlG4F42A6QipW1wZDl/TEakOkws+ThlGeNYqsie1/dXZxX2wd6VOm8lkyM4JWsP+7iSbflDYi+C2ihOQcq90i6j3Ok1sW82nsrZSur3JkJst6MB1+RehhqUZI9usfGwjqQpi1wpLHi5tYB3ZkefIuLY0IYC852vU+Au+4lxiYA+TSPK2viBgwoYFSj7sxZLJvtAPVmmvoJwMCM3x6rpxvLb/siCJ+V3f9yRadKebbkotKqYYEvtgJqdWl50ry0c2DhVLftNwLpMCcCI0fgavS5UgdLzshoQJGwo2QPJ1PAHV+RWSLIuQhgA/F4C9nks+4M=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43b77ee7-6127-4938-de61-08d710bd1a4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2019 05:01:06.8554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3754
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIFNoYXduDQoNCj4gT24gMDktMDctMTksIDE2OjAwLCBBbnNvbi5IdWFuZ0BueHAuY29tIHdy
b3RlOg0KPiA+IEZyb206IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+DQo+
ID4gVXBkYXRlIG9wcC1zdXNwZW5kIHByb3BlcnR5J3MgZGVzY3JpcHRpb24gdG8gc3VwcG9ydCBt
dWx0aXBsZQ0KPiA+IG9wcC1zdXNwZW5kIHByb3BlcnRpZXMgZGVmaW5lZCBpbiBEVCwgdGhlIE9Q
UCB3aXRoIGhpZ2hlc3Qgb3BwLWh6IGFuZA0KPiA+IHdpdGggb3BwLXN1c3BlbmQgcHJvcGVydHkg
cHJlc2VudCB3aWxsIGJlIHVzZWQgYXMgc3VzcGVuZCBvcHAuDQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiBOZXcg
cGF0Y2guDQo+ID4gLS0tDQo+ID4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9v
cHAvb3BwLnR4dCB8IDQgKystLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gQXBwbGllZC4gVGhhbmtzLg0KDQpXb3VsZCB5b3UgcGlj
ayB1cCB0aGUgRFQgcGF0Y2hlcyBpbiB0aGlzIHNlcmllcz8gVGhhbmtzLg0KDQpBbnNvbg0K
