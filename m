Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3C4B50433
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2019 10:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfFXIFH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Jun 2019 04:05:07 -0400
Received: from mail-eopbgr20089.outbound.protection.outlook.com ([40.107.2.89]:56324
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726351AbfFXIFH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 24 Jun 2019 04:05:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBOYBXzozbCtfIO5X4wDYJcGRtkAIQ0gxvXtpKDMoNQ=;
 b=dKww+5G8mb1Wb54v83DgQ1p+/37MTBAFIPCISNJissxHrGCoCCWAgJRfKZsxoO/T1fcx/j+v2E/4TD3JkRUgCK8gVkXvsfGiK94PoxZ66G3Amc+h9g0ima/k6z0Mk/Kld14Q362fXrK2l53ozeTqCpuIds4RS9d/CCM0zBYU2aU=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3946.eurprd04.prod.outlook.com (52.134.72.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Mon, 24 Jun 2019 08:04:23 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191%4]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 08:04:23 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
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
Thread-Index: AQHVJXvnLQPj9qjL2U2LZTWuyBDONqaqeq9g
Date:   Mon, 24 Jun 2019 08:04:22 +0000
Message-ID: <DB3PR0402MB39162C5B5AF828B127DD871EF5E00@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190618021820.14885-1-Anson.Huang@nxp.com>
In-Reply-To: <20190618021820.14885-1-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 49b87960-1f61-4e28-99d3-08d6f87a918b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3946;
x-ms-traffictypediagnostic: DB3PR0402MB3946:
x-microsoft-antispam-prvs: <DB3PR0402MB3946FDB3407C7C806D9766F9F5E00@DB3PR0402MB3946.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(396003)(366004)(346002)(199004)(189003)(9686003)(71190400001)(74316002)(7736002)(81156014)(8676002)(8936002)(81166006)(68736007)(25786009)(478600001)(7416002)(33656002)(110136005)(4326008)(316002)(305945005)(3846002)(6116002)(2501003)(55016002)(14454004)(53936002)(44832011)(66066001)(229853002)(76176011)(7696005)(26005)(99286004)(186003)(6436002)(102836004)(6506007)(2201001)(256004)(476003)(5660300002)(446003)(486006)(52536014)(6246003)(71200400001)(76116006)(73956011)(11346002)(66946007)(66446008)(64756008)(66556008)(66476007)(86362001)(2906002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3946;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pTN/hE4UnGZ5M3DnEeJbwIhVdk8pXzNpc9l1I8sxTDkzxCwu2h4JzeRBNzQWnYJnfDHt0NoSIrqWkLvbiafQUGgZjkvK7jDnqD4zDU5HIOOeyf6h0Fi5zMOb/DglCZmQbRqiCXYSnPFXUDgxGmzs5n3VrD7FVxAjMzpGr/gLHzgm/tguGkCWQ633Zw5fJmYhGbHI/gNZWuzLMgNi+/w+N/M4rLEoTOhzKulHVJqm5veGeTGoH2onAwg8/OUH/Qf5UpseVMrBqFVEM3sM19910R4Zx6HyTJJmqNrtfzKWNUPlJ/OZMdVE73rUn7FHdEYosVf4LU6weyD/vCWNDybFPQJ34XOkyWIFCCugDic99bmK1C7oR7Kav3TRHQEBUcn/CKFQ52yjLvJiCfbNZIgxh859FcLODmBDfviui/QQ3Cg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b87960-1f61-4e28-99d3-08d6f87a918b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 08:04:22.8858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3946
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIERhbmllbC9SdWkvRWR1YXJkbw0KCUNvdWxkIHlvdSBwbGVhc2UgdGFrZSBhIGxvb2sgYXQg
dGhpcyBwYXRjaCBzZXJpZXM/IA0KDQpBbnNvbg0KDQo+IEZyb206IEFuc29uIEh1YW5nIDxBbnNv
bi5IdWFuZ0BueHAuY29tPg0KPiANCj4gTlhQIGkuTVg4UVhQIGlzIGFuIEFSTXY4IFNvQyB3aXRo
IGEgQ29ydGV4LU00IGNvcmUgaW5zaWRlIGFzIHN5c3RlbQ0KPiBjb250cm9sbGVyLCB0aGUgc3lz
dGVtIGNvbnRyb2xsZXIgaXMgaW4gY2hhcmdlIG9mIHN5c3RlbSBwb3dlciwgY2xvY2sgYW5kDQo+
IHRoZXJtYWwgc2Vuc29ycyBldGMuIG1hbmFnZW1lbnQsIExpbnV4IGtlcm5lbCBoYXMgdG8gY29t
bXVuaWNhdGUgd2l0aA0KPiBzeXN0ZW0gY29udHJvbGxlciB2aWEgTVUgKG1lc3NhZ2UgdW5pdCkg
SVBDIHRvIGdldCB0ZW1wZXJhdHVyZSBmcm9tIHRoZXJtYWwNCj4gc2Vuc29ycywgdGhpcyBwYXRj
aCBhZGRzIGJpbmRpbmcgZG9jIGZvciBpLk1YIHN5c3RlbSBjb250cm9sbGVyIHRoZXJtYWwNCj4g
ZHJpdmVyLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54
cC5jb20+DQo+IFJldmlld2VkLWJ5OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPg0KPiBS
ZXZpZXdlZC1ieTogRG9uZyBBaXNoZW5nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4NCj4gLS0tDQo+
IE5vIGNoYW5nZS4NCj4gLS0tDQo+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnJlZXNj
YWxlL2ZzbCxzY3UudHh0ICAgICAgICB8IDE2ICsrKysrKysrKysrKysrKysNCj4gIDEgZmlsZSBj
aGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mcmVlc2NhbGUvZnNsLHNjdS50eHQNCj4gYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZyZWVzY2FsZS9mc2wsc2N1LnR4dA0K
PiBpbmRleCBhNTc1ZTQyLi5mYzM4NDRlIDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvYXJtL2ZyZWVzY2FsZS9mc2wsc2N1LnR4dA0KPiArKysgYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZyZWVzY2FsZS9mc2wsc2N1LnR4dA0K
PiBAQCAtMTU1LDYgKzE1NSwxNyBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiAgT3B0aW9uYWwg
cHJvcGVydGllczoNCj4gIC0gdGltZW91dC1zZWM6IGNvbnRhaW5zIHRoZSB3YXRjaGRvZyB0aW1l
b3V0IGluIHNlY29uZHMuDQo+IA0KPiArVGhlcm1hbCBiaW5kaW5ncyBiYXNlZCBvbiBTQ1UgTWVz
c2FnZSBQcm90b2NvbA0KPiArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICsNCj4gK1JlcXVpcmVkIHByb3BlcnRpZXM6DQo+ICst
IGNvbXBhdGlibGU6CQkJU2hvdWxkIGJlIDoNCj4gKwkJCQkgICJmc2wsaW14OHF4cC1zYy10aGVy
bWFsIg0KPiArCQkJCWZvbGxvd2VkIGJ5ICJmc2wsaW14LXNjLXRoZXJtYWwiOw0KPiArDQo+ICst
ICN0aGVybWFsLXNlbnNvci1jZWxsczoJU2VlDQo+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy90aGVybWFsL3RoZXJtYWwudHh0DQo+ICsJCQkJZm9yIGEgZGVzY3JpcHRpb24uDQo+
ICsNCj4gIEV4YW1wbGUgKGlteDhxeHApOg0KPiAgLS0tLS0tLS0tLS0tLQ0KPiAgYWxpYXNlcyB7
DQo+IEBAIC0yMjIsNiArMjMzLDExIEBAIGZpcm13YXJlIHsNCj4gIAkJCWNvbXBhdGlibGUgPSAi
ZnNsLGlteDhxeHAtc2Mtd2R0IiwgImZzbCxpbXgtc2Mtd2R0IjsNCj4gIAkJCXRpbWVvdXQtc2Vj
ID0gPDYwPjsNCj4gIAkJfTsNCj4gKw0KPiArCQl0c2VuczogdGhlcm1hbC1zZW5zb3Igew0KPiAr
CQkJY29tcGF0aWJsZSA9ICJmc2wsaW14OHF4cC1zYy10aGVybWFsIiwgImZzbCxpbXgtc2MtDQo+
IHRoZXJtYWwiOw0KPiArCQkJI3RoZXJtYWwtc2Vuc29yLWNlbGxzID0gPDE+Ow0KPiArCQl9Ow0K
PiAgCX07DQo+ICB9Ow0KPiANCj4gLS0NCj4gMi43LjQNCg0K
