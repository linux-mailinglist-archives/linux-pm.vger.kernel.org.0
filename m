Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D012A41AB2
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2019 05:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406800AbfFLDYi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jun 2019 23:24:38 -0400
Received: from mail-eopbgr80057.outbound.protection.outlook.com ([40.107.8.57]:14718
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388693AbfFLDYi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 11 Jun 2019 23:24:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Caa3M+/uF1dl0Usl7UriQHP+kB7I/sio9ovB+ZBdpr0=;
 b=re7vPdymKw3hMCyv5esum7eYs+jtpNtRgkx+Xj8nv3C0wzHhPV1djEeYwLrwv2cdCWyN5YPvWjFkc72vKtVSaaLLReXDo4lwrH7xQOGrapAm/ng4diCNJr6Rx4gpeKm0xVYnnD6+XOXKdLw1P1CMP3dXldeAuzkhLw1HX/k0ur0=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB4146.eurprd04.prod.outlook.com (52.134.93.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Wed, 12 Jun 2019 03:24:31 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::11e1:3bb9:156b:a3e4]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::11e1:3bb9:156b:a3e4%3]) with mapi id 15.20.1965.017; Wed, 12 Jun 2019
 03:24:31 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     "edubezval@gmail.com" <edubezval@gmail.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
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
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Peng Fan <peng.fan@nxp.com>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH V14 2/5] thermal: of-thermal: add API for getting sensor
 ID from DT
Thread-Topic: [PATCH V14 2/5] thermal: of-thermal: add API for getting sensor
 ID from DT
Thread-Index: AQHVHzduVJLnDucTi0KXitmpZJYpcaaWS8pggAAaiACAAPYSUA==
Date:   Wed, 12 Jun 2019 03:24:30 +0000
Message-ID: <AM0PR04MB421147B34C711FA1AB9F399080EC0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190610025254.23940-1-Anson.Huang@nxp.com>
 <20190610025254.23940-2-Anson.Huang@nxp.com>
 <AM0PR04MB42118F3F8E87A72758D4A7B780ED0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <DB3PR0402MB39169A1897B33DC6C3522E08F5ED0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB39169A1897B33DC6C3522E08F5ED0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0fa226b-f3c5-49c3-8944-08d6eee57bd1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4146;
x-ms-traffictypediagnostic: AM0PR04MB4146:
x-microsoft-antispam-prvs: <AM0PR04MB4146C6BFBDDC28A01AB9B3EF80EC0@AM0PR04MB4146.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0066D63CE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(376002)(366004)(346002)(199004)(189003)(6246003)(446003)(102836004)(76116006)(9686003)(486006)(44832011)(66476007)(476003)(66066001)(14454004)(11346002)(316002)(54906003)(99286004)(81156014)(305945005)(66556008)(26005)(64756008)(229853002)(53936002)(8676002)(14444005)(66946007)(52536014)(74316002)(256004)(68736007)(25786009)(2906002)(2501003)(66446008)(110136005)(81166006)(76176011)(186003)(86362001)(7696005)(8936002)(5660300002)(7736002)(71190400001)(71200400001)(3846002)(6506007)(73956011)(55016002)(33656002)(4326008)(7416002)(6116002)(478600001)(2201001)(6436002)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4146;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3ElaX+dd5gW8k1x3/x1Ia6WDhTZpdHSpu7iQ5VghmOr7rumDQ5KHcC/Qoql7eftKHpDE7nyQaYWcgPFLDSxGu8OmmWrKim5RHVNBqqC5D7wOBczEPXAdTAI6XN550HDljWG2aQWJkCIoQzTYavPc2BlHOqGXWGyl8VjvCx0iNLtlZRzP8y1PecHURLj0ZcvewwNSpowFSanUK4mS5F7rYbg9kHZvsbrSKuz1WgVCFQvBv4iuJnavZcHid7nod0mV25PQOygYsNKfQbhue11T75QhJVSXqpKkbwC3eN8L8MCC5TpFCUEQ1+qX5W0zHOo/YxGQ/ZfiVyBAJO31WOY3sJ1ZtjHtJ6dHtxnKLp3G7i8usIA8trKsgE3kEw0bIcBDdcAv/b30/eq0WnOHzC7QYmWhgiK0QmBDPYo7BKpNfzY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0fa226b-f3c5-49c3-8944-08d6eee57bd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2019 03:24:30.9596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aisheng.dong@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4146
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgRWR1YXJkbyAmIFJ1aSwNCg0KPiBGcm9tOiBBbnNvbiBIdWFuZw0KPiBTZW50OiBUdWVzZGF5
LCBKdW5lIDExLCAyMDE5IDg6MzcgUE0NCj4NCj4gPiBGcm9tOiBBaXNoZW5nIERvbmcNCj4gPiBT
ZW50OiBUdWVzZGF5LCBKdW5lIDExLCAyMDE5IDc6NDcgUE0NCj4gPiBTdWJqZWN0OiBSRTogW1BB
VENIIFYxNCAyLzVdIHRoZXJtYWw6IG9mLXRoZXJtYWw6IGFkZCBBUEkgZm9yIGdldHRpbmcNCj4g
PiBzZW5zb3IgSUQgZnJvbSBEVA0KPiA+DQo+ID4gSGkgQW5zb24sDQo+ID4NCj4gPiBUaGUgaW1w
bGVtZW50YXRpb24gbG9va3MgZ29vZCB0byBtZS4NCj4gPiBBIGZldyBtaW5vciBjb21tZW50cyBv
biB0aGUgZG9jOg0KPiANCj4gVGhpcyBwYXRjaCBpcyBwZW5kaW5nIGZvciBzbyBsb25nIGFuZCBl
dmVuIHRpbGwgbm93IEkgYW0gTk9UIHN1cmUgaWYgZXZlcnlvbmUgaXMNCj4gT0sgZm9yIHRoaXMg
Y2hhbmdlLCBzbyBJIHdpbGwgd2FpdCBmb3Igc29tZSBjb21tZW50cyBpZiB0aGVyZSBpcyBhbnks
IGFuZCB3aWxsDQo+IGltcHJvdmUgdGhlIGRvYyB0b2dldGhlciBpbiBuZXh0IHZlcnNpb24uDQo+
IA0KDQpUaGUgQVBJIGNoYW5nZSBzZWVtcyBnb29kIHRvIG1lLiANCkJ1dCBzaW5jZSB0aGlzIGlz
IGEgY29yZSBjaGFuZ2VzLCB3ZSBuZWVkIHlvdXIgaW5wdXRzIHRvIGNvbmZpcm0gd2hldGhlciB0
aGlzIGFwcHJvYWNoDQppcyBvayB0byB5b3UuDQoNClNvIHBsZWFzZSB0ZWxsIHVzIHdoZXRoZXIg
eW91J3JlIGZpbmUgd2l0aCB0aGlzIGFwcHJvYWNoLg0KDQpSZWdhcmRzDQpEb25nIEFpc2hlbmcN
Cg0KPiBUaGFua3MsDQo+IEFuc29uDQo+IA0KPiA+DQo+ID4gPiBGcm9tOiBBbnNvbi5IdWFuZ0Bu
eHAuY29tIFttYWlsdG86QW5zb24uSHVhbmdAbnhwLmNvbV0NCj4gPiA+IFNlbnQ6IE1vbmRheSwg
SnVuZSAxMCwgMjAxOSAxMDo1MyBBTQ0KPiA+ID4NCj4gPiA+IE9uIHNvbWUgcGxhdGZvcm1zIGxp
a2UgaS5NWDhRWFAsIHRoZSB0aGVybWFsIGRyaXZlciBuZWVkcyBhIHJlYWwgSFcNCj4gPiA+IHNl
bnNvciBJRCBmcm9tIERUIHRoZXJtYWwgem9uZSwgdGhlIEhXIHNlbnNvciBJRCBpcyB1c2VkIHRv
IGdldA0KPiA+ID4gdGVtcGVyYXR1cmUgZnJvbSBTQ1UgZmlybXdhcmUsIGFuZCB0aGUgdmlydHVh
bCBzZW5zb3IgSUQgc3RhcnRpbmcNCj4gPiA+IGZyb20NCj4gPiA+IDAgdG8gTiBpcyBOT1QgdXNl
ZCBhdCBhbGwsDQo+ID4NCj4gPiBUaGlzIEFQSSBpcyB1bndhcmUgb2YgSFcgSUQgb3IgVmlydHVh
bCBJRC4gU28gd2UgcHJvYmFibHkgbm8gbmVlZCB0bw0KPiA+IG1lbnRpb24gSXQgaGVyZS4NCj4g
Pg0KPiA+ID4gdGhpcyBwYXRjaCBhZGRzIG5ldyBBUEkgdGhlcm1hbF96b25lX29mX2dldF9zZW5z
b3JfaWQoKSB0byBwcm92aWRlDQo+ID4gPiB0aGUgZmVhdHVyZSBvZiBnZXR0aW5nIHNlbnNvciBJ
RCBmcm9tIERUIHRoZXJtYWwgem9uZSdzIG5vZGUuDQo+ID4gPg0KPiA+DQo+ID4gIkl0J3MgdXNl
ZnVsIGZvciB0aGVybWFsIGRyaXZlciB0byByZWdpc3RlciB0aGUgc3BlY2lmaWMgdGhlcm1hbCB6
b25lDQo+ID4gZGV2aWNlcyBmcm9tIERUIGluIGEgY29tbW9uIHdheS4iDQo+ID4NCj4gPiA+IFNp
Z25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+ID4gLS0t
DQo+ID4gPiBDaGFuZ2VzIHNpbmNlIFYxMzoNCj4gPiA+IAktIGFkZCBuZXcgQVBJIGludG8gdGhl
IHRoZXJtYWwgQVBJIGRvYy4NCj4gPiA+IC0tLQ0KPiA+ID4gIERvY3VtZW50YXRpb24vdGhlcm1h
bC9zeXNmcy1hcGkudHh0IHwgIDggKysrKysNCj4gPiA+ICBkcml2ZXJzL3RoZXJtYWwvb2YtdGhl
cm1hbC5jICAgICAgICB8IDY2DQo+ID4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0t
LS0tLS0tDQo+ID4gPiAgaW5jbHVkZS9saW51eC90aGVybWFsLmggICAgICAgICAgICAgfCAxMCAr
KysrKysNCj4gPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDY4IGluc2VydGlvbnMoKyksIDE2IGRlbGV0
aW9ucygtKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL3RoZXJtYWwv
c3lzZnMtYXBpLnR4dA0KPiA+ID4gYi9Eb2N1bWVudGF0aW9uL3RoZXJtYWwvc3lzZnMtYXBpLnR4
dA0KPiA+ID4gaW5kZXggYzNmYTUwMC4uOGQ3ZjFiMSAxMDA2NDQNCj4gPiA+IC0tLSBhL0RvY3Vt
ZW50YXRpb24vdGhlcm1hbC9zeXNmcy1hcGkudHh0DQo+ID4gPiArKysgYi9Eb2N1bWVudGF0aW9u
L3RoZXJtYWwvc3lzZnMtYXBpLnR4dA0KPiA+ID4gQEAgLTE1OSw2ICsxNTksMTQgQEAgdGVtcGVy
YXR1cmUpIGFuZCB0aHJvdHRsZSBhcHByb3ByaWF0ZSBkZXZpY2VzLg0KPiA+ID4gIAlmb3IgdGhl
IHRoZXJtYWwgem9uZSBkZXZpY2UsIHdoaWNoIG1pZ2h0IGJlIHVzZWZ1bCBmb3IgcGxhdGZvcm0N
Cj4gPiA+ICAJZHJpdmVycyBmb3IgdGVtcGVyYXR1cmUgY2FsY3VsYXRpb25zLg0KPiA+ID4NCj4g
PiA+ICsxLjEuOSBpbnQgdGhlcm1hbF96b25lX29mX2dldF9zZW5zb3JfaWQoc3RydWN0IGRldmlj
ZV9ub2RlICp0el9ucCwNCj4gPiA+ICsJCXN0cnVjdCBkZXZpY2Vfbm9kZSAqc2Vuc29yX25wLA0K
PiA+ID4gKwkJdTMyICppZCkNCj4gPiA+ICsNCj4gPiA+ICsJVGhpcyBpbnRlcmZhY2UgaXMgdXNl
ZCB0byBnZXQgdGhlIHNlbnNvciBpZCBmcm9tIHRoZXJtYWwgc2Vuc29yJ3MNCj4gPiA+ICsJcGhh
bmRsZSBhcmd1bWVudCwgaXQgbWlnaHQgYmUgbmVjZXNzYXJ5IGZvciBzb21lIHBsYXRmb3JtcyB3
aGljaA0KPiA+ID4gKwloYXZlIHNwZWNpZmljIHNlbnNvciBJRCByYXRoZXIgdGhhbiB2aXJ0dWFs
IElEIGZyb20gMCAtIE4uDQo+ID4NCj4gPiBEb2VzIGJlbG93IG9uZSBsb29rIGJldHRlcj8NCj4g
Pg0KPiA+ICJUaGlzIGludGVyZmFjZSBpcyB1c2VkIHRvIGdldCB0aGUgc2Vuc29yIGlkIGZyb20g
dGhlIGdpdmVuIHRoZXJtYWwNCj4gPiB6b25lIGluIERULCB3aGljaCBtaWdodCBiZSB1c2VmdWwg
Zm9yIHRoZXJtYWwgZHJpdmVycyB0byByZWdpc3Rlcg0KPiA+IHNwZWNpZmljIHRoZXJtYWwgem9u
ZSBkZXZpY2UgaW4gYSBjb21tb24gd2F5LiINCj4gPg0KPiA+ID4gKw0KPiA+ID4gIDEuMiB0aGVy
bWFsIGNvb2xpbmcgZGV2aWNlIGludGVyZmFjZQ0KPiA+ID4gIDEuMi4xIHN0cnVjdCB0aGVybWFs
X2Nvb2xpbmdfZGV2aWNlDQo+ID4gPiAqdGhlcm1hbF9jb29saW5nX2RldmljZV9yZWdpc3Rlcihj
aGFyDQo+ID4gPiAqbmFtZSwNCj4gPiA+ICAJCXZvaWQgKmRldmRhdGEsIHN0cnVjdCB0aGVybWFs
X2Nvb2xpbmdfZGV2aWNlX29wcyAqKSBkaWZmIC0tZ2l0DQo+ID4gPiBhL2RyaXZlcnMvdGhlcm1h
bC9vZi10aGVybWFsLmMgYi9kcml2ZXJzL3RoZXJtYWwvb2YtdGhlcm1hbC5jIGluZGV4DQo+ID4g
PiBkYzUwOTNiLi5hNTM3OTJiIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy90aGVybWFsL29m
LXRoZXJtYWwuYw0KPiA+ID4gKysrIGIvZHJpdmVycy90aGVybWFsL29mLXRoZXJtYWwuYw0KPiA+
ID4gQEAgLTQ0OSw2ICs0NDksNTQgQEAgdGhlcm1hbF96b25lX29mX2FkZF9zZW5zb3Ioc3RydWN0
IGRldmljZV9ub2RlDQo+ID4gPiAqem9uZSwgIH0NCj4gPiA+DQo+ID4gPiAgLyoqDQo+ID4gPiAr
ICogdGhlcm1hbF96b25lX29mX2dldF9zZW5zb3JfaWQgLSBnZXQgc2Vuc29yIElEIGZyb20gYSBE
VCB0aGVybWFsDQo+ID4gPiArIHpvbmUNCj4gPiA+ICsgKiBAdHpfbnA6IGEgdmFsaWQgdGhlcm1h
bCB6b25lIGRldmljZSBub2RlLg0KPiA+ID4gKyAqIEBzZW5zb3JfbnA6IGEgc2Vuc29yIG5vZGUg
b2YgYSB2YWxpZCBzZW5zb3IgZGV2aWNlLg0KPiA+ID4gKyAqIEBpZDogYSBzZW5zb3IgSUQgcG9p
bnRlciB3aWxsIGJlIHBhc3NlZCBiYWNrLg0KPiA+DQo+ID4gdGhlIHNlbnNvciBJRCByZXR1cm5l
ZCBpZiBzdWNjZXNzDQo+ID4NCj4gPiA+ICsgKg0KPiA+ID4gKyAqIFRoaXMgZnVuY3Rpb24gd2ls
bCBnZXQgc2Vuc29yIElEIGZyb20gYSBnaXZlbiB0aGVybWFsIHpvbmUgbm9kZSwNCj4gPiA+ICsg
dXNlDQo+ID4gPiArICogInRoZXJtYWwtc2Vuc29ycyIgYXMgbGlzdCBuYW1lLCBhbmQgZ2V0IHNl
bnNvciBJRCBmcm9tIGZpcnN0DQo+ID4gPiArIHBoYW5kbGUncw0KPiA+ID4gKyAqIGFyZ3VtZW50
Lg0KPiA+DQo+ID4gIlRoaXMgZnVuY3Rpb24gd2lsbCBnZXQgc2Vuc29yIElEIGZyb20gYSBnaXZl
biB0aGVybWFsIHpvbmUgbm9kZSBhbmQNCj4gPiB0aGUgc2Vuc29yIGdldCBtdXN0IG1hdGNoIHRo
ZSB0ZW1wZXJhdHVyZSBwcm92aWRlcnMgQHNlbnNvcl9ucC4iDQo+ID4NCj4gPiBSZWdhcmRzDQo+
ID4gRG9uZyBBaXNoZW5nDQo+ID4NCj4gPiA+ICsgKg0KPiA+ID4gKyAqIFJldHVybjogMCBvbiBz
dWNjZXNzLCBwcm9wZXIgZXJyb3IgY29kZSBvdGhlcndpc2UuDQo+ID4gPiArICovDQo+ID4gPiAr
DQo+ID4gPiAraW50IHRoZXJtYWxfem9uZV9vZl9nZXRfc2Vuc29yX2lkKHN0cnVjdCBkZXZpY2Vf
bm9kZSAqdHpfbnAsDQo+ID4gPiArCQkJCSAgc3RydWN0IGRldmljZV9ub2RlICpzZW5zb3JfbnAs
DQo+ID4gPiArCQkJCSAgdTMyICppZCkNCj4gPiA+ICt7DQo+ID4gPiArCXN0cnVjdCBvZl9waGFu
ZGxlX2FyZ3Mgc2Vuc29yX3NwZWNzOw0KPiA+ID4gKwlpbnQgcmV0Ow0KPiA+ID4gKw0KPiA+ID4g
KwlyZXQgPSBvZl9wYXJzZV9waGFuZGxlX3dpdGhfYXJncyh0el9ucCwNCj4gPiA+ICsJCQkJCSAi
dGhlcm1hbC1zZW5zb3JzIiwNCj4gPiA+ICsJCQkJCSAiI3RoZXJtYWwtc2Vuc29yLWNlbGxzIiwN
Cj4gPiA+ICsJCQkJCSAwLA0KPiA+ID4gKwkJCQkJICZzZW5zb3Jfc3BlY3MpOw0KPiA+ID4gKwlp
ZiAocmV0KQ0KPiA+ID4gKwkJcmV0dXJuIHJldDsNCj4gPiA+ICsNCj4gPiA+ICsJaWYgKHNlbnNv
cl9zcGVjcy5ucCAhPSBzZW5zb3JfbnApIHsNCj4gPiA+ICsJCW9mX25vZGVfcHV0KHNlbnNvcl9z
cGVjcy5ucCk7DQo+ID4gPiArCQlyZXR1cm4gLUVOT0RFVjsNCj4gPiA+ICsJfQ0KPiA+ID4gKw0K
PiA+ID4gKwlpZiAoc2Vuc29yX3NwZWNzLmFyZ3NfY291bnQgPj0gMSkgew0KPiA+ID4gKwkJKmlk
ID0gc2Vuc29yX3NwZWNzLmFyZ3NbMF07DQo+ID4gPiArCQlXQVJOKHNlbnNvcl9zcGVjcy5hcmdz
X2NvdW50ID4gMSwNCj4gPiA+ICsJCSAgICAgIiVwT0ZuOiB0b28gbWFueSBjZWxscyBpbiBzZW5z
b3Igc3BlY2lmaWVyICVkXG4iLA0KPiA+ID4gKwkJICAgICBzZW5zb3Jfc3BlY3MubnAsIHNlbnNv
cl9zcGVjcy5hcmdzX2NvdW50KTsNCj4gPiA+ICsJfSBlbHNlIHsNCj4gPiA+ICsJCSppZCA9IDA7
DQo+ID4gPiArCX0NCj4gPiA+ICsNCj4gPiA+ICsJb2Zfbm9kZV9wdXQoc2Vuc29yX3NwZWNzLm5w
KTsNCj4gPiA+ICsNCj4gPiA+ICsJcmV0dXJuIDA7DQo+ID4gPiArfQ0KPiA+ID4gK0VYUE9SVF9T
WU1CT0xfR1BMKHRoZXJtYWxfem9uZV9vZl9nZXRfc2Vuc29yX2lkKTsNCj4gPiA+ICsNCj4gPiA+
ICsvKioNCj4gPiA+ICAgKiB0aGVybWFsX3pvbmVfb2Zfc2Vuc29yX3JlZ2lzdGVyIC0gcmVnaXN0
ZXJzIGEgc2Vuc29yIHRvIGEgRFQNCj4gPiA+IHRoZXJtYWwNCj4gPiB6b25lDQo+ID4gPiAgICog
QGRldjogYSB2YWxpZCBzdHJ1Y3QgZGV2aWNlIHBvaW50ZXIgb2YgYSBzZW5zb3IgZGV2aWNlLiBN
dXN0IGNvbnRhaW4NCj4gPiA+ICAgKiAgICAgICBhIHZhbGlkIC5vZl9ub2RlLCBmb3IgdGhlIHNl
bnNvciBub2RlLg0KPiA+ID4gQEAgLTQ5OSwzNiArNTQ3LDIyIEBAIHRoZXJtYWxfem9uZV9vZl9z
ZW5zb3JfcmVnaXN0ZXIoc3RydWN0IGRldmljZQ0KPiA+ID4gKmRldiwgaW50IHNlbnNvcl9pZCwg
dm9pZCAqZGF0YSwNCj4gPiA+ICAJc2Vuc29yX25wID0gb2Zfbm9kZV9nZXQoZGV2LT5vZl9ub2Rl
KTsNCj4gPiA+DQo+ID4gPiAgCWZvcl9lYWNoX2F2YWlsYWJsZV9jaGlsZF9vZl9ub2RlKG5wLCBj
aGlsZCkgew0KPiA+ID4gLQkJc3RydWN0IG9mX3BoYW5kbGVfYXJncyBzZW5zb3Jfc3BlY3M7DQo+
ID4gPiAgCQlpbnQgcmV0LCBpZDsNCj4gPiA+DQo+ID4gPiAgCQkvKiBGb3Igbm93LCB0aGVybWFs
IGZyYW1ld29yayBzdXBwb3J0cyBvbmx5IDEgc2Vuc29yIHBlcg0KPiA+IHpvbmUgKi8NCj4gPiA+
IC0JCXJldCA9IG9mX3BhcnNlX3BoYW5kbGVfd2l0aF9hcmdzKGNoaWxkLCAidGhlcm1hbC1zZW5z
b3JzIiwNCj4gPiA+IC0JCQkJCQkgIiN0aGVybWFsLXNlbnNvci1jZWxscyIsDQo+ID4gPiAtCQkJ
CQkJIDAsICZzZW5zb3Jfc3BlY3MpOw0KPiA+ID4gKwkJcmV0ID0gdGhlcm1hbF96b25lX29mX2dl
dF9zZW5zb3JfaWQoY2hpbGQsIHNlbnNvcl9ucCwgJmlkKTsNCj4gPiA+ICAJCWlmIChyZXQpDQo+
ID4gPiAgCQkJY29udGludWU7DQo+ID4gPg0KPiA+ID4gLQkJaWYgKHNlbnNvcl9zcGVjcy5hcmdz
X2NvdW50ID49IDEpIHsNCj4gPiA+IC0JCQlpZCA9IHNlbnNvcl9zcGVjcy5hcmdzWzBdOw0KPiA+
ID4gLQkJCVdBUk4oc2Vuc29yX3NwZWNzLmFyZ3NfY291bnQgPiAxLA0KPiA+ID4gLQkJCSAgICAg
IiVwT0ZuOiB0b28gbWFueSBjZWxscyBpbiBzZW5zb3Igc3BlY2lmaWVyICVkXG4iLA0KPiA+ID4g
LQkJCSAgICAgc2Vuc29yX3NwZWNzLm5wLCBzZW5zb3Jfc3BlY3MuYXJnc19jb3VudCk7DQo+ID4g
PiAtCQl9IGVsc2Ugew0KPiA+ID4gLQkJCWlkID0gMDsNCj4gPiA+IC0JCX0NCj4gPiA+IC0NCj4g
PiA+IC0JCWlmIChzZW5zb3Jfc3BlY3MubnAgPT0gc2Vuc29yX25wICYmIGlkID09IHNlbnNvcl9p
ZCkgew0KPiA+ID4gKwkJaWYgKGlkID09IHNlbnNvcl9pZCkgew0KPiA+ID4gIAkJCXR6ZCA9IHRo
ZXJtYWxfem9uZV9vZl9hZGRfc2Vuc29yKGNoaWxkLCBzZW5zb3JfbnAsDQo+ID4gPiAgCQkJCQkJ
CSBkYXRhLCBvcHMpOw0KPiA+ID4gIAkJCWlmICghSVNfRVJSKHR6ZCkpDQo+ID4gPiAgCQkJCXR6
ZC0+b3BzLT5zZXRfbW9kZSh0emQsDQo+ID4gVEhFUk1BTF9ERVZJQ0VfRU5BQkxFRCk7DQo+ID4g
Pg0KPiA+ID4gLQkJCW9mX25vZGVfcHV0KHNlbnNvcl9zcGVjcy5ucCk7DQo+ID4gPiAgCQkJb2Zf
bm9kZV9wdXQoY2hpbGQpOw0KPiA+ID4gIAkJCWdvdG8gZXhpdDsNCj4gPiA+ICAJCX0NCj4gPiA+
IC0JCW9mX25vZGVfcHV0KHNlbnNvcl9zcGVjcy5ucCk7DQo+ID4gPiAgCX0NCj4gPiA+ICBleGl0
Og0KPiA+ID4gIAlvZl9ub2RlX3B1dChzZW5zb3JfbnApOw0KPiA+ID4gZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvbGludXgvdGhlcm1hbC5oIGIvaW5jbHVkZS9saW51eC90aGVybWFsLmggaW5kZXgNCj4g
PiA+IDE1YTRjYTUuLjVlZGZmZTYgMTAwNjQ0DQo+ID4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3Ro
ZXJtYWwuaA0KPiA+ID4gKysrIGIvaW5jbHVkZS9saW51eC90aGVybWFsLmgNCj4gPiA+IEBAIC0z
NzUsNiArMzc1LDkgQEAgc3RydWN0IHRoZXJtYWxfdHJpcCB7DQo+ID4gPg0KPiA+ID4gIC8qIEZ1
bmN0aW9uIGRlY2xhcmF0aW9ucyAqLw0KPiA+ID4gICNpZmRlZiBDT05GSUdfVEhFUk1BTF9PRg0K
PiA+ID4gK2ludCB0aGVybWFsX3pvbmVfb2ZfZ2V0X3NlbnNvcl9pZChzdHJ1Y3QgZGV2aWNlX25v
ZGUgKnR6X25wLA0KPiA+ID4gKwkJCQkgIHN0cnVjdCBkZXZpY2Vfbm9kZSAqc2Vuc29yX25wLA0K
PiA+ID4gKwkJCQkgIHUzMiAqaWQpOw0KPiA+ID4gIHN0cnVjdCB0aGVybWFsX3pvbmVfZGV2aWNl
ICoNCj4gPiA+ICB0aGVybWFsX3pvbmVfb2Zfc2Vuc29yX3JlZ2lzdGVyKHN0cnVjdCBkZXZpY2Ug
KmRldiwgaW50IGlkLCB2b2lkICpkYXRhLA0KPiA+ID4gIAkJCQljb25zdCBzdHJ1Y3QgdGhlcm1h
bF96b25lX29mX2RldmljZV9vcHMNCj4gPiAqb3BzKTsgQEANCj4gPiA+IC0zODYsNiArMzg5LDEz
IEBAIHN0cnVjdCB0aGVybWFsX3pvbmVfZGV2aWNlDQo+ID4gPiAqZGV2bV90aGVybWFsX3pvbmVf
b2Zfc2Vuc29yX3JlZ2lzdGVyKA0KPiA+ID4gIHZvaWQgZGV2bV90aGVybWFsX3pvbmVfb2Zfc2Vu
c29yX3VucmVnaXN0ZXIoc3RydWN0IGRldmljZSAqZGV2LA0KPiA+ID4gIAkJCQkJICAgIHN0cnVj
dCB0aGVybWFsX3pvbmVfZGV2aWNlICp0eik7DQo+ID4gI2Vsc2UNCj4gPiA+ICsNCj4gPiA+ICtz
dGF0aWMgaW50IHRoZXJtYWxfem9uZV9vZl9nZXRfc2Vuc29yX2lkKHN0cnVjdCBkZXZpY2Vfbm9k
ZSAqdHpfbnAsDQo+ID4gPiArCQkJCQkgc3RydWN0IGRldmljZV9ub2RlICpzZW5zb3JfbnAsDQo+
ID4gPiArCQkJCQkgdTMyICppZCkNCj4gPiA+ICt7DQo+ID4gPiArCXJldHVybiAtRU5PRU5UOw0K
PiA+ID4gK30NCj4gPiA+ICBzdGF0aWMgaW5saW5lIHN0cnVjdCB0aGVybWFsX3pvbmVfZGV2aWNl
ICoNCj4gPiA+IHRoZXJtYWxfem9uZV9vZl9zZW5zb3JfcmVnaXN0ZXIoc3RydWN0IGRldmljZSAq
ZGV2LCBpbnQgaWQsIHZvaWQgKmRhdGEsDQo+ID4gPiAgCQkJCWNvbnN0IHN0cnVjdCB0aGVybWFs
X3pvbmVfb2ZfZGV2aWNlX29wcw0KPiA+ICpvcHMpDQo+ID4gPiAtLQ0KPiA+ID4gMi43LjQNCg0K
