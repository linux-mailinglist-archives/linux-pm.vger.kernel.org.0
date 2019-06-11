Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6BCC3CA4F
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2019 13:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389899AbfFKLqx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jun 2019 07:46:53 -0400
Received: from mail-eopbgr30077.outbound.protection.outlook.com ([40.107.3.77]:30368
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389282AbfFKLqx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 11 Jun 2019 07:46:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qgBxrwLXijhAvAjzyP/WmGwlatGQaFNY0cvfnPEqt7U=;
 b=awWU8edqmHwyz47Q3/3wHa0PxZuaZti0dq9AOLte6FQ7FpRpRdWHMheHgQcB7lYUvHPmaJ9ScCY3gKoaDE5ES3FuvFBBTAqR00aucJBHhN1TdG//yfhLfvqEZAeG8aTwvb/4A5vPEh97b7ejLkoDWvc1JKQk0Mqg7V8pk86Z55c=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.15; Tue, 11 Jun 2019 11:46:43 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::11e1:3bb9:156b:a3e4]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::11e1:3bb9:156b:a3e4%3]) with mapi id 15.20.1965.017; Tue, 11 Jun 2019
 11:46:43 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
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
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V14 2/5] thermal: of-thermal: add API for getting sensor
 ID from DT
Thread-Topic: [PATCH V14 2/5] thermal: of-thermal: add API for getting sensor
 ID from DT
Thread-Index: AQHVHzduVJLnDucTi0KXitmpZJYpcaaWS8pg
Date:   Tue, 11 Jun 2019 11:46:43 +0000
Message-ID: <AM0PR04MB42118F3F8E87A72758D4A7B780ED0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190610025254.23940-1-Anson.Huang@nxp.com>
 <20190610025254.23940-2-Anson.Huang@nxp.com>
In-Reply-To: <20190610025254.23940-2-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 19429248-47ae-4ed6-806d-08d6ee6279b4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4481;
x-ms-traffictypediagnostic: AM0PR04MB4481:
x-microsoft-antispam-prvs: <AM0PR04MB44816DE2F7D93D072E393B4180ED0@AM0PR04MB4481.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 006546F32A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(366004)(39860400002)(199004)(189003)(68736007)(478600001)(2906002)(33656002)(66556008)(76116006)(14454004)(186003)(66476007)(6116002)(3846002)(66946007)(64756008)(66446008)(73956011)(81156014)(102836004)(81166006)(6506007)(26005)(8936002)(99286004)(256004)(8676002)(2501003)(76176011)(7696005)(25786009)(7416002)(66066001)(305945005)(74316002)(7736002)(4326008)(110136005)(6436002)(6246003)(44832011)(316002)(446003)(11346002)(53936002)(476003)(486006)(229853002)(71190400001)(71200400001)(5660300002)(86362001)(2201001)(52536014)(55016002)(9686003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4481;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MZuCB/LrNtNwldTtMQKcqYieSkf/d7NAIOtaLwkuDTRIsLdVpQS+TNTUA2nqrr4pFTJAkjKOW/LTB01jhGS+c+9A56gDtFJbMPMSJsHsimNCPA986scYd0Als76S/LHnj8NuNc0tYr7ny9tF93IqFnni3F3E3/qHHqyrSglHDsoUxmKapEA2aLo8vQmZc0Ux0HC3L17HHarQ7EaoYbVBrvg6PZ5xFZ8/wlGqj4RCvlDzYaCKeZQ0BKsNInuLIssuYiAbU1w8WbwEGSwZHPcCQTPybLAN9m4+AuUOvSWU61J9ISBtvr/MfODAa51mM3PPy5SFpbuv0b+bech/jqx2laD1AkJwCdVJhRugWeHMv7ZqfNXmuWZlleOQLVn/mTlP5Vj89no5vcIPiT8MA+ZBoVBLWqCsUmV3GARrgbKR9f4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19429248-47ae-4ed6-806d-08d6ee6279b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2019 11:46:43.3963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aisheng.dong@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4481
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgQW5zb24sDQoNClRoZSBpbXBsZW1lbnRhdGlvbiBsb29rcyBnb29kIHRvIG1lLg0KQSBmZXcg
bWlub3IgY29tbWVudHMgb24gdGhlIGRvYzoNCg0KPiBGcm9tOiBBbnNvbi5IdWFuZ0BueHAuY29t
IFttYWlsdG86QW5zb24uSHVhbmdAbnhwLmNvbV0NCj4gU2VudDogTW9uZGF5LCBKdW5lIDEwLCAy
MDE5IDEwOjUzIEFNDQo+IA0KPiBPbiBzb21lIHBsYXRmb3JtcyBsaWtlIGkuTVg4UVhQLCB0aGUg
dGhlcm1hbCBkcml2ZXIgbmVlZHMgYSByZWFsIEhXIHNlbnNvcg0KPiBJRCBmcm9tIERUIHRoZXJt
YWwgem9uZSwgdGhlIEhXIHNlbnNvciBJRCBpcyB1c2VkIHRvIGdldCB0ZW1wZXJhdHVyZSBmcm9t
DQo+IFNDVSBmaXJtd2FyZSwgYW5kIHRoZSB2aXJ0dWFsIHNlbnNvciBJRCBzdGFydGluZyBmcm9t
IDAgdG8gTiBpcyBOT1QgdXNlZCBhdCBhbGwsDQoNClRoaXMgQVBJIGlzIHVud2FyZSBvZiBIVyBJ
RCBvciBWaXJ0dWFsIElELiBTbyB3ZSBwcm9iYWJseSBubyBuZWVkIHRvIG1lbnRpb24NCkl0IGhl
cmUuDQoNCj4gdGhpcyBwYXRjaCBhZGRzIG5ldyBBUEkgdGhlcm1hbF96b25lX29mX2dldF9zZW5z
b3JfaWQoKSB0byBwcm92aWRlIHRoZQ0KPiBmZWF0dXJlIG9mIGdldHRpbmcgc2Vuc29yIElEIGZy
b20gRFQgdGhlcm1hbCB6b25lJ3Mgbm9kZS4NCj4gDQoNCiJJdCdzIHVzZWZ1bCBmb3IgdGhlcm1h
bCBkcml2ZXIgdG8gcmVnaXN0ZXIgdGhlIHNwZWNpZmljIHRoZXJtYWwgem9uZSBkZXZpY2VzDQpm
cm9tIERUIGluIGEgY29tbW9uIHdheS4iDQoNCj4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcg
PEFuc29uLkh1YW5nQG54cC5jb20+DQo+IC0tLQ0KPiBDaGFuZ2VzIHNpbmNlIFYxMzoNCj4gCS0g
YWRkIG5ldyBBUEkgaW50byB0aGUgdGhlcm1hbCBBUEkgZG9jLg0KPiAtLS0NCj4gIERvY3VtZW50
YXRpb24vdGhlcm1hbC9zeXNmcy1hcGkudHh0IHwgIDggKysrKysNCj4gIGRyaXZlcnMvdGhlcm1h
bC9vZi10aGVybWFsLmMgICAgICAgIHwgNjYNCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysr
Ky0tLS0tLS0tLQ0KPiAgaW5jbHVkZS9saW51eC90aGVybWFsLmggICAgICAgICAgICAgfCAxMCAr
KysrKysNCj4gIDMgZmlsZXMgY2hhbmdlZCwgNjggaW5zZXJ0aW9ucygrKSwgMTYgZGVsZXRpb25z
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi90aGVybWFsL3N5c2ZzLWFwaS50
eHQNCj4gYi9Eb2N1bWVudGF0aW9uL3RoZXJtYWwvc3lzZnMtYXBpLnR4dA0KPiBpbmRleCBjM2Zh
NTAwLi44ZDdmMWIxIDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL3RoZXJtYWwvc3lzZnMt
YXBpLnR4dA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL3RoZXJtYWwvc3lzZnMtYXBpLnR4dA0KPiBA
QCAtMTU5LDYgKzE1OSwxNCBAQCB0ZW1wZXJhdHVyZSkgYW5kIHRocm90dGxlIGFwcHJvcHJpYXRl
IGRldmljZXMuDQo+ICAJZm9yIHRoZSB0aGVybWFsIHpvbmUgZGV2aWNlLCB3aGljaCBtaWdodCBi
ZSB1c2VmdWwgZm9yIHBsYXRmb3JtDQo+ICAJZHJpdmVycyBmb3IgdGVtcGVyYXR1cmUgY2FsY3Vs
YXRpb25zLg0KPiANCj4gKzEuMS45IGludCB0aGVybWFsX3pvbmVfb2ZfZ2V0X3NlbnNvcl9pZChz
dHJ1Y3QgZGV2aWNlX25vZGUgKnR6X25wLA0KPiArCQlzdHJ1Y3QgZGV2aWNlX25vZGUgKnNlbnNv
cl9ucCwNCj4gKwkJdTMyICppZCkNCj4gKw0KPiArCVRoaXMgaW50ZXJmYWNlIGlzIHVzZWQgdG8g
Z2V0IHRoZSBzZW5zb3IgaWQgZnJvbSB0aGVybWFsIHNlbnNvcidzDQo+ICsJcGhhbmRsZSBhcmd1
bWVudCwgaXQgbWlnaHQgYmUgbmVjZXNzYXJ5IGZvciBzb21lIHBsYXRmb3JtcyB3aGljaA0KPiAr
CWhhdmUgc3BlY2lmaWMgc2Vuc29yIElEIHJhdGhlciB0aGFuIHZpcnR1YWwgSUQgZnJvbSAwIC0g
Ti4NCg0KRG9lcyBiZWxvdyBvbmUgbG9vayBiZXR0ZXI/DQoNCiJUaGlzIGludGVyZmFjZSBpcyB1
c2VkIHRvIGdldCB0aGUgc2Vuc29yIGlkIGZyb20gdGhlIGdpdmVuIHRoZXJtYWwgem9uZSBpbg0K
RFQsIHdoaWNoIG1pZ2h0IGJlIHVzZWZ1bCBmb3IgdGhlcm1hbCBkcml2ZXJzIHRvIHJlZ2lzdGVy
IHNwZWNpZmljIHRoZXJtYWwNCnpvbmUgZGV2aWNlIGluIGEgY29tbW9uIHdheS4iDQoNCj4gKw0K
PiAgMS4yIHRoZXJtYWwgY29vbGluZyBkZXZpY2UgaW50ZXJmYWNlDQo+ICAxLjIuMSBzdHJ1Y3Qg
dGhlcm1hbF9jb29saW5nX2RldmljZSAqdGhlcm1hbF9jb29saW5nX2RldmljZV9yZWdpc3Rlcihj
aGFyDQo+ICpuYW1lLA0KPiAgCQl2b2lkICpkZXZkYXRhLCBzdHJ1Y3QgdGhlcm1hbF9jb29saW5n
X2RldmljZV9vcHMgKikgZGlmZiAtLWdpdA0KPiBhL2RyaXZlcnMvdGhlcm1hbC9vZi10aGVybWFs
LmMgYi9kcml2ZXJzL3RoZXJtYWwvb2YtdGhlcm1hbC5jIGluZGV4DQo+IGRjNTA5M2IuLmE1Mzc5
MmIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdGhlcm1hbC9vZi10aGVybWFsLmMNCj4gKysrIGIv
ZHJpdmVycy90aGVybWFsL29mLXRoZXJtYWwuYw0KPiBAQCAtNDQ5LDYgKzQ0OSw1NCBAQCB0aGVy
bWFsX3pvbmVfb2ZfYWRkX3NlbnNvcihzdHJ1Y3QgZGV2aWNlX25vZGUNCj4gKnpvbmUsICB9DQo+
IA0KPiAgLyoqDQo+ICsgKiB0aGVybWFsX3pvbmVfb2ZfZ2V0X3NlbnNvcl9pZCAtIGdldCBzZW5z
b3IgSUQgZnJvbSBhIERUIHRoZXJtYWwgem9uZQ0KPiArICogQHR6X25wOiBhIHZhbGlkIHRoZXJt
YWwgem9uZSBkZXZpY2Ugbm9kZS4NCj4gKyAqIEBzZW5zb3JfbnA6IGEgc2Vuc29yIG5vZGUgb2Yg
YSB2YWxpZCBzZW5zb3IgZGV2aWNlLg0KPiArICogQGlkOiBhIHNlbnNvciBJRCBwb2ludGVyIHdp
bGwgYmUgcGFzc2VkIGJhY2suDQoNCnRoZSBzZW5zb3IgSUQgcmV0dXJuZWQgaWYgc3VjY2Vzcw0K
DQo+ICsgKg0KPiArICogVGhpcyBmdW5jdGlvbiB3aWxsIGdldCBzZW5zb3IgSUQgZnJvbSBhIGdp
dmVuIHRoZXJtYWwgem9uZSBub2RlLCB1c2UNCj4gKyAqICJ0aGVybWFsLXNlbnNvcnMiIGFzIGxp
c3QgbmFtZSwgYW5kIGdldCBzZW5zb3IgSUQgZnJvbSBmaXJzdA0KPiArIHBoYW5kbGUncw0KPiAr
ICogYXJndW1lbnQuDQoNCiJUaGlzIGZ1bmN0aW9uIHdpbGwgZ2V0IHNlbnNvciBJRCBmcm9tIGEg
Z2l2ZW4gdGhlcm1hbCB6b25lIG5vZGUgYW5kIHRoZSBzZW5zb3INCmdldCBtdXN0IG1hdGNoIHRo
ZSB0ZW1wZXJhdHVyZSBwcm92aWRlcnMgQHNlbnNvcl9ucC4iDQoNClJlZ2FyZHMNCkRvbmcgQWlz
aGVuZw0KDQo+ICsgKg0KPiArICogUmV0dXJuOiAwIG9uIHN1Y2Nlc3MsIHByb3BlciBlcnJvciBj
b2RlIG90aGVyd2lzZS4NCj4gKyAqLw0KPiArDQo+ICtpbnQgdGhlcm1hbF96b25lX29mX2dldF9z
ZW5zb3JfaWQoc3RydWN0IGRldmljZV9ub2RlICp0el9ucCwNCj4gKwkJCQkgIHN0cnVjdCBkZXZp
Y2Vfbm9kZSAqc2Vuc29yX25wLA0KPiArCQkJCSAgdTMyICppZCkNCj4gK3sNCj4gKwlzdHJ1Y3Qg
b2ZfcGhhbmRsZV9hcmdzIHNlbnNvcl9zcGVjczsNCj4gKwlpbnQgcmV0Ow0KPiArDQo+ICsJcmV0
ID0gb2ZfcGFyc2VfcGhhbmRsZV93aXRoX2FyZ3ModHpfbnAsDQo+ICsJCQkJCSAidGhlcm1hbC1z
ZW5zb3JzIiwNCj4gKwkJCQkJICIjdGhlcm1hbC1zZW5zb3ItY2VsbHMiLA0KPiArCQkJCQkgMCwN
Cj4gKwkJCQkJICZzZW5zb3Jfc3BlY3MpOw0KPiArCWlmIChyZXQpDQo+ICsJCXJldHVybiByZXQ7
DQo+ICsNCj4gKwlpZiAoc2Vuc29yX3NwZWNzLm5wICE9IHNlbnNvcl9ucCkgew0KPiArCQlvZl9u
b2RlX3B1dChzZW5zb3Jfc3BlY3MubnApOw0KPiArCQlyZXR1cm4gLUVOT0RFVjsNCj4gKwl9DQo+
ICsNCj4gKwlpZiAoc2Vuc29yX3NwZWNzLmFyZ3NfY291bnQgPj0gMSkgew0KPiArCQkqaWQgPSBz
ZW5zb3Jfc3BlY3MuYXJnc1swXTsNCj4gKwkJV0FSTihzZW5zb3Jfc3BlY3MuYXJnc19jb3VudCA+
IDEsDQo+ICsJCSAgICAgIiVwT0ZuOiB0b28gbWFueSBjZWxscyBpbiBzZW5zb3Igc3BlY2lmaWVy
ICVkXG4iLA0KPiArCQkgICAgIHNlbnNvcl9zcGVjcy5ucCwgc2Vuc29yX3NwZWNzLmFyZ3NfY291
bnQpOw0KPiArCX0gZWxzZSB7DQo+ICsJCSppZCA9IDA7DQo+ICsJfQ0KPiArDQo+ICsJb2Zfbm9k
ZV9wdXQoc2Vuc29yX3NwZWNzLm5wKTsNCj4gKw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArRVhQ
T1JUX1NZTUJPTF9HUEwodGhlcm1hbF96b25lX29mX2dldF9zZW5zb3JfaWQpOw0KPiArDQo+ICsv
KioNCj4gICAqIHRoZXJtYWxfem9uZV9vZl9zZW5zb3JfcmVnaXN0ZXIgLSByZWdpc3RlcnMgYSBz
ZW5zb3IgdG8gYSBEVCB0aGVybWFsIHpvbmUNCj4gICAqIEBkZXY6IGEgdmFsaWQgc3RydWN0IGRl
dmljZSBwb2ludGVyIG9mIGEgc2Vuc29yIGRldmljZS4gTXVzdCBjb250YWluDQo+ICAgKiAgICAg
ICBhIHZhbGlkIC5vZl9ub2RlLCBmb3IgdGhlIHNlbnNvciBub2RlLg0KPiBAQCAtNDk5LDM2ICs1
NDcsMjIgQEAgdGhlcm1hbF96b25lX29mX3NlbnNvcl9yZWdpc3RlcihzdHJ1Y3QgZGV2aWNlICpk
ZXYsDQo+IGludCBzZW5zb3JfaWQsIHZvaWQgKmRhdGEsDQo+ICAJc2Vuc29yX25wID0gb2Zfbm9k
ZV9nZXQoZGV2LT5vZl9ub2RlKTsNCj4gDQo+ICAJZm9yX2VhY2hfYXZhaWxhYmxlX2NoaWxkX29m
X25vZGUobnAsIGNoaWxkKSB7DQo+IC0JCXN0cnVjdCBvZl9waGFuZGxlX2FyZ3Mgc2Vuc29yX3Nw
ZWNzOw0KPiAgCQlpbnQgcmV0LCBpZDsNCj4gDQo+ICAJCS8qIEZvciBub3csIHRoZXJtYWwgZnJh
bWV3b3JrIHN1cHBvcnRzIG9ubHkgMSBzZW5zb3IgcGVyIHpvbmUgKi8NCj4gLQkJcmV0ID0gb2Zf
cGFyc2VfcGhhbmRsZV93aXRoX2FyZ3MoY2hpbGQsICJ0aGVybWFsLXNlbnNvcnMiLA0KPiAtCQkJ
CQkJICIjdGhlcm1hbC1zZW5zb3ItY2VsbHMiLA0KPiAtCQkJCQkJIDAsICZzZW5zb3Jfc3BlY3Mp
Ow0KPiArCQlyZXQgPSB0aGVybWFsX3pvbmVfb2ZfZ2V0X3NlbnNvcl9pZChjaGlsZCwgc2Vuc29y
X25wLCAmaWQpOw0KPiAgCQlpZiAocmV0KQ0KPiAgCQkJY29udGludWU7DQo+IA0KPiAtCQlpZiAo
c2Vuc29yX3NwZWNzLmFyZ3NfY291bnQgPj0gMSkgew0KPiAtCQkJaWQgPSBzZW5zb3Jfc3BlY3Mu
YXJnc1swXTsNCj4gLQkJCVdBUk4oc2Vuc29yX3NwZWNzLmFyZ3NfY291bnQgPiAxLA0KPiAtCQkJ
ICAgICAiJXBPRm46IHRvbyBtYW55IGNlbGxzIGluIHNlbnNvciBzcGVjaWZpZXIgJWRcbiIsDQo+
IC0JCQkgICAgIHNlbnNvcl9zcGVjcy5ucCwgc2Vuc29yX3NwZWNzLmFyZ3NfY291bnQpOw0KPiAt
CQl9IGVsc2Ugew0KPiAtCQkJaWQgPSAwOw0KPiAtCQl9DQo+IC0NCj4gLQkJaWYgKHNlbnNvcl9z
cGVjcy5ucCA9PSBzZW5zb3JfbnAgJiYgaWQgPT0gc2Vuc29yX2lkKSB7DQo+ICsJCWlmIChpZCA9
PSBzZW5zb3JfaWQpIHsNCj4gIAkJCXR6ZCA9IHRoZXJtYWxfem9uZV9vZl9hZGRfc2Vuc29yKGNo
aWxkLCBzZW5zb3JfbnAsDQo+ICAJCQkJCQkJIGRhdGEsIG9wcyk7DQo+ICAJCQlpZiAoIUlTX0VS
Uih0emQpKQ0KPiAgCQkJCXR6ZC0+b3BzLT5zZXRfbW9kZSh0emQsIFRIRVJNQUxfREVWSUNFX0VO
QUJMRUQpOw0KPiANCj4gLQkJCW9mX25vZGVfcHV0KHNlbnNvcl9zcGVjcy5ucCk7DQo+ICAJCQlv
Zl9ub2RlX3B1dChjaGlsZCk7DQo+ICAJCQlnb3RvIGV4aXQ7DQo+ICAJCX0NCj4gLQkJb2Zfbm9k
ZV9wdXQoc2Vuc29yX3NwZWNzLm5wKTsNCj4gIAl9DQo+ICBleGl0Og0KPiAgCW9mX25vZGVfcHV0
KHNlbnNvcl9ucCk7DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3RoZXJtYWwuaCBiL2lu
Y2x1ZGUvbGludXgvdGhlcm1hbC5oIGluZGV4DQo+IDE1YTRjYTUuLjVlZGZmZTYgMTAwNjQ0DQo+
IC0tLSBhL2luY2x1ZGUvbGludXgvdGhlcm1hbC5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvdGhl
cm1hbC5oDQo+IEBAIC0zNzUsNiArMzc1LDkgQEAgc3RydWN0IHRoZXJtYWxfdHJpcCB7DQo+IA0K
PiAgLyogRnVuY3Rpb24gZGVjbGFyYXRpb25zICovDQo+ICAjaWZkZWYgQ09ORklHX1RIRVJNQUxf
T0YNCj4gK2ludCB0aGVybWFsX3pvbmVfb2ZfZ2V0X3NlbnNvcl9pZChzdHJ1Y3QgZGV2aWNlX25v
ZGUgKnR6X25wLA0KPiArCQkJCSAgc3RydWN0IGRldmljZV9ub2RlICpzZW5zb3JfbnAsDQo+ICsJ
CQkJICB1MzIgKmlkKTsNCj4gIHN0cnVjdCB0aGVybWFsX3pvbmVfZGV2aWNlICoNCj4gIHRoZXJt
YWxfem9uZV9vZl9zZW5zb3JfcmVnaXN0ZXIoc3RydWN0IGRldmljZSAqZGV2LCBpbnQgaWQsIHZv
aWQgKmRhdGEsDQo+ICAJCQkJY29uc3Qgc3RydWN0IHRoZXJtYWxfem9uZV9vZl9kZXZpY2Vfb3Bz
ICpvcHMpOyBAQA0KPiAtMzg2LDYgKzM4OSwxMyBAQCBzdHJ1Y3QgdGhlcm1hbF96b25lX2Rldmlj
ZQ0KPiAqZGV2bV90aGVybWFsX3pvbmVfb2Zfc2Vuc29yX3JlZ2lzdGVyKA0KPiAgdm9pZCBkZXZt
X3RoZXJtYWxfem9uZV9vZl9zZW5zb3JfdW5yZWdpc3RlcihzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+
ICAJCQkJCSAgICBzdHJ1Y3QgdGhlcm1hbF96b25lX2RldmljZSAqdHopOyAgI2Vsc2UNCj4gKw0K
PiArc3RhdGljIGludCB0aGVybWFsX3pvbmVfb2ZfZ2V0X3NlbnNvcl9pZChzdHJ1Y3QgZGV2aWNl
X25vZGUgKnR6X25wLA0KPiArCQkJCQkgc3RydWN0IGRldmljZV9ub2RlICpzZW5zb3JfbnAsDQo+
ICsJCQkJCSB1MzIgKmlkKQ0KPiArew0KPiArCXJldHVybiAtRU5PRU5UOw0KPiArfQ0KPiAgc3Rh
dGljIGlubGluZSBzdHJ1Y3QgdGhlcm1hbF96b25lX2RldmljZSAqDQo+IHRoZXJtYWxfem9uZV9v
Zl9zZW5zb3JfcmVnaXN0ZXIoc3RydWN0IGRldmljZSAqZGV2LCBpbnQgaWQsIHZvaWQgKmRhdGEs
DQo+ICAJCQkJY29uc3Qgc3RydWN0IHRoZXJtYWxfem9uZV9vZl9kZXZpY2Vfb3BzICpvcHMpDQo+
IC0tDQo+IDIuNy40DQoNCg==
