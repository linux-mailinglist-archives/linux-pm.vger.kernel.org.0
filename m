Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62B9C203B3
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2019 12:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfEPKji (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 May 2019 06:39:38 -0400
Received: from mail-eopbgr60062.outbound.protection.outlook.com ([40.107.6.62]:53889
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726838AbfEPKji (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 May 2019 06:39:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CV6RuB+PSlq3VuwHgi7C1mY0G262F4Ntq+bgI3GdTk=;
 b=lsJWSzMPWoq7QUlhyWveH9kyK7SX/BeHl7f6bLUrrQYavOLOQEIkMXf32dO+BG/Fr/mYE65ECNqkBWG2VNSTSUoj7C08DMOeXXv+1zyJi8ptTRRSuHCq/wi9w4aPNIlI4Mmgv+yq+RtgOoxo1CtZSMKvuPKyua2AXvFM0LXiGU0=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB4724.eurprd04.prod.outlook.com (20.177.40.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Thu, 16 May 2019 10:39:34 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c415:3cab:a042:2e13]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c415:3cab:a042:2e13%6]) with mapi id 15.20.1900.010; Thu, 16 May 2019
 10:39:34 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "agross@kernel.org" <agross@kernel.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V12 3/5] thermal: imx_sc: add i.MX system controller
 thermal support
Thread-Topic: [PATCH V12 3/5] thermal: imx_sc: add i.MX system controller
 thermal support
Thread-Index: AQHU9AOd0xCeMx9rMkStRq/hkjSd7aY/tDYQgACqbwCALV8xkA==
Date:   Thu, 16 May 2019 10:39:34 +0000
Message-ID: <AM0PR04MB4211EF0D257E502C3BF917D0800A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1555384609-7030-1-git-send-email-Anson.Huang@nxp.com>
 <1555384609-7030-3-git-send-email-Anson.Huang@nxp.com>
 <AM0PR04MB421105BBF1B9A90B255D1F7A80250@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <DB3PR0402MB39163877C25E5BE7E10C96B7F5250@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB39163877C25E5BE7E10C96B7F5250@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff2019a3-454b-4915-39d9-08d6d9eac974
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4724;
x-ms-traffictypediagnostic: AM0PR04MB4724:
x-microsoft-antispam-prvs: <AM0PR04MB47249975D6F9579D6AA2DBA9800A0@AM0PR04MB4724.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(396003)(346002)(376002)(199004)(189003)(74316002)(9686003)(486006)(86362001)(14454004)(66066001)(6506007)(2201001)(53936002)(11346002)(446003)(478600001)(81156014)(81166006)(476003)(8676002)(26005)(2906002)(8936002)(102836004)(110136005)(256004)(7416002)(186003)(68736007)(316002)(33656002)(3846002)(6116002)(4744005)(71200400001)(71190400001)(73956011)(64756008)(66556008)(76116006)(66946007)(66446008)(6436002)(25786009)(66476007)(229853002)(52536014)(4326008)(2501003)(7736002)(305945005)(99286004)(76176011)(5660300002)(7696005)(55016002)(6246003)(44832011)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4724;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lDKSL8ZhrPAQ2eXI+S1OtJFA5M43UBAZJ6dWMfTIgit15XHN1K3A9TRxVU6A7rvnd4NwmaLnUY8fqRjuM2tcJULM43yyBdGdpGUUC6bhmNukWF/Hjrl8HW5UQ94IdexQEdOehFRV9Vn/Q/jFT8GzVGNmDXjT/FcvTXFcR0vMkTo1t6zajGzxjJYz5p7+WAA98Yek0wTOWOybrLlGJkiwVTwLQlSCrtOycJbMzZx+3mR4xGd2Gkgp3lB96/gO1PQnRjeRH4OuVg+6OwfTndreOQGRywvgD4THkGXznwN77rx6Y4lICpJSuiwJiI/H7QBtpLLdkKAzEsb6luX77v8jcocZmTZjU6AxqTm1nEl9LM6j2J15bIInZ6vwvv6iTZ1/wGpQCs3EzelMi1LxId0lCfev/2nfvLeQp0T1ltnLyUE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff2019a3-454b-4915-39d9-08d6d9eac974
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 10:39:34.2617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4724
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Wy4uLl0NCg0KPiA+ID4gKwkJaWYgKCFzZW5zb3IpDQo+ID4gPiArCQkJcmV0dXJuIC1FTk9NRU07
DQo+ID4gPiArDQo+ID4gPiArCQlyZXQgPSB0aGVybWFsX3pvbmVfb2ZfZ2V0X3NlbnNvcl9pZChj
aGlsZCwNCj4gPiA+ICsJCQkJCQkgICAgJnNlbnNvcl9zcGVjcywNCj4gPg0KPiA+IEl0IGxvb2tz
IGEgYml0IHN0cmFuZ2Ugd2h5IG5lZWQgc2Vuc29yX3NwZWNzIGFzIHlvdSBldmVuIGRpZCBub3Qg
dXNlIGl0Lg0KPiANCj4gSXQgaXMgYmVjYXVzZSBwYXJzaW5nIHRoZSBwaGFuZGxlIGFyZ3VtZW50
cyBuZWVkcyBpdCwgc3VjaCBhcyB0aGUNCj4gdGhlcm1hbF96b25lX29mX3NlbnNvcl9yZWdpc3Rl
cigpIGZ1bmN0aW9uIG5lZWRzIHRoaXMgcG9pbnRlciB0byBiZSBwYXNzZWQNCj4gYmFjayB0byBj
aGVjayB0aGUgZWxlbWVudHMgYXJlIHZhbGlkIG9yIE5PVCwgc28gdGhlIEFQSSBkb2VzIE5PVCBk
ZWZpbmUgaXQgYXMNCj4gbG9jYWwgc3RydWN0dXJlLiBUaGUgQVBJIE5PVCBqdXN0IHJldHVybiB0
aGUgc2Vuc29yIGlkLCBidXQgYWxzbyB0aGUNCj4gb2ZfcGhhbmRsZV9hcmdzIGFkZHJlc3MsIGFs
dGhvdWdoIHdlIGRvIE5PVCBuZWVkIGl0IGF0IGFsbCBoZXJlLg0KDQpUaGUgbWFpbiBwcm9ibGVt
IGlzIHRoaXMgb25lIGludHJvZHVjZWQgaW4gMi81IHdoaWNoIG5lZWRzIGdldCBhY2sgZnJvbSBt
YWludGFpbmVyLg0KRm9yIG1lLCBJIHdvdWxkIHN1Z2dlc3QgdG8gbWFrZSBzZW5zb3Jfc3BlY3Mg
dHJhbnNwYXJlbnQgdG8gdXNlciBpZg0KaXQncyByZWFsbHkgbm90IG5lZWRlZCBieSB1c2Vycy4N
Cg0KUGxlYXNlIHRyeSB0byBtYWtlIGl0IGVpdGhlciBvcHRpb25hbCBvciBoaWRlIHRvIGNvcmUg
dXNlcnMgYXMgd2VsbC4NCkFuZCBJIGd1ZXNzIHRoZSBsYXRlciBvbmUgaXMgZG9hYmxlIGFmdGVy
IGEgZ2xhbmNlIGF0IHRoZSBjb3JlIGNvZGUuDQoNClJlZ2FyZHMNCkRvbmcgQWlzaGVuZw0K
