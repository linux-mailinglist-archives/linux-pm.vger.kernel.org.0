Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7815317E240
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2020 15:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgCIOJI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Mar 2020 10:09:08 -0400
Received: from mail-eopbgr40080.outbound.protection.outlook.com ([40.107.4.80]:44964
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726233AbgCIOJI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 9 Mar 2020 10:09:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3PUDEG2WiEMCi7ZI+a5r61NOg2JgiQrB1MIFlSCXYh8xaPfP409rJs+PkQrwPcpmJNUMl469fNo/FtAhfc/0M+bZ1t8WmqvA1wV3DqXkZEHW63fCmXtn70ipVzj2PJahAAom0dZu7mFg9c3NNqxxlShHJwjl8EB2RddDiI+b2D/6yHctpbd/MmfPqacG/8KuYJRphf6vs9sh6CvEmghisTg4c16bVjIyeW/F204gF7eAerTupjyfF2hAGL24SiG7GHQw+y4e0RrPF2W/8ji8JgEi+JokZDKTZyYjJHqiAV9oeQbPWH+Q6okvONHhbzOnmT69Tj0jbLoSRi8anbRPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6QW/wY1tp0T4HdD1BZX5dsHxITHlG1M6PLh4Uc95PE=;
 b=bX5EMUEMxRkWFrLmQXbX/ObpB7oW14+Msq7OeQ7GEvvah/xnViR/mZcdnBodPhZvh8DGFV8QF/lwhids7jpXcznkdmRhDRezRLT5CrLDAB4Lf97fQsbcZdRyGX7kcoEtfiEY+Lqq2hPtM+D5axWY9i9CrULrIgVFLiLOz/XFqlYv/HmtvjszcnY1QIyY/iKb8Y9r+xNAQJev4bfcQUS6wCLGN4IG1CLpOFnRhgd7GpV1El/3bpGIiDnbtaa3YnmsjkNp0FZsU38Czr1NJTw5xYJzRzQ5YQG5DiFUwdsRPsEq/XOScbdCDIMKtkFvSkkO1KcwetHLARwFruwsrPojGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6QW/wY1tp0T4HdD1BZX5dsHxITHlG1M6PLh4Uc95PE=;
 b=UZ+32TGpYRh6up+cYJ9NTusaYSlB43bqT22xV+WiVvs5P6PbBMDJARCteOsadufnSizhcnTRDztUOOvy7Qe2VycFggf3iPnAfovhQX2u8M/HgCqhrdcM7FkID4/Lhy4BS73UBmK2gEhGWnNGuWkkjtsbjwAqx7H/mVj8Gb9X6To=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3914.eurprd04.prod.outlook.com (52.134.71.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Mon, 9 Mar 2020 14:09:00 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e44d:fa34:a0af:d96]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e44d:fa34:a0af:d96%5]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 14:09:00 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux@rempel-privat.de" <linux@rempel-privat.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "m.felsch@pengutronix.de" <m.felsch@pengutronix.de>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "ronald@innovation.ch" <ronald@innovation.ch>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V3 1/7] firmware: imx: Add stubs for !CONFIG_IMX_SCU case
Thread-Topic: [PATCH V3 1/7] firmware: imx: Add stubs for !CONFIG_IMX_SCU case
Thread-Index: AQHV9av62LAReQhoZkKZ9LnT5dFdbahARTIAgAAHnnA=
Date:   Mon, 9 Mar 2020 14:09:00 +0000
Message-ID: <DB3PR0402MB39160749F06C0CD4C752AF88F5FE0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1583714300-19085-1-git-send-email-Anson.Huang@nxp.com>
 <AM0PR04MB4481F087AC3CDA691300710288FE0@AM0PR04MB4481.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB4481F087AC3CDA691300710288FE0@AM0PR04MB4481.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ec31ce58-33e0-4fab-a460-08d7c4336abe
x-ms-traffictypediagnostic: DB3PR0402MB3914:|DB3PR0402MB3914:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB391412630D5EA7024E788352F5FE0@DB3PR0402MB3914.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 0337AFFE9A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(189003)(199004)(478600001)(4326008)(7416002)(8936002)(66946007)(76116006)(86362001)(186003)(33656002)(66476007)(44832011)(966005)(9686003)(26005)(55016002)(66556008)(6506007)(8676002)(316002)(64756008)(110136005)(81166006)(81156014)(5660300002)(52536014)(7696005)(71200400001)(66446008)(2906002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3914;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1anTmzqJGit4agYAh/pyy6cn+nxwm4hnondXlirTW2cbDoM7Ldp5/ekI9CQXCW25R55agpa/8+cAJOBvCzmAzjy0im3jc7yW2wme3cks9KPbo7Bx39IvDgVAyU7sm6/DSRRMqYY9ze8ZjCI21fcGWAmqijZEQBv+UCXenWOuaF39lAXcYOPjeuZWIf43/NN8li0kaGtmBKdROXMrkVV2jmbwcJnmrOzXDJvEAkLrb03N5AbZC/g1o5ZkdTEoVNe/BYmytgJRL9Sjy5b0Vgjf5IxXFTMj5M9XhfGe00w2NV8vaR5hE1Izq3/iR3sWi20yG0TcGLZhwTIKQkrb2IRitbBobaYtRwTSxynf9fiQevbD9u5rH3w/9GUFbZ1CHRTG38d8mpIJbgStxBMtApClCIUzg3yxoJzkVbHpdFCT24sUUZKTkFrpjLE1wlf/SlJYojOHmbz0pziDYc1uhyChl6D36kt1msyv/JhYXdDKcpESXwonsiW7EP81dBeYxatv6HG3fLr440Qjhmsm6ICtkPj50uBC6uZi2c52oAbNvaMbT0R4n1Kjq8afXydyIGC+34EwR1+2U0G3u92A1R3qcA==
x-ms-exchange-antispam-messagedata: YRBg7086ld7yyMINmDemmCMLVTwaCKcO1718my+ekBV9udKqxrYmtZCv+5HzkpGuSUgoNaINYW16fenbeqW7o3ASbozbcQzq/7kvNcSFlPQIrAWRr/NJyPaPnzY23w6Ivk+Jx1gZnOaocnQFZ7XuRw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec31ce58-33e0-4fab-a460-08d7c4336abe
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2020 14:09:00.8709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l5KPTdm4+SGbIFxyqv9Nujz6dhORiNgyOF7o9TISRwCg0SOObOgGWE4iFDNGXapXlL03zWGcCba8OgXIF1yU7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3914
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggVjMgMS83XSBmaXJtd2FyZTogaW14OiBBZGQgc3R1YnMg
Zm9yICFDT05GSUdfSU1YX1NDVQ0KPiBjYXNlDQo+IA0KPiA+IFN1YmplY3Q6IFtQQVRDSCBWMyAx
LzddIGZpcm13YXJlOiBpbXg6IEFkZCBzdHVicyBmb3IgIUNPTkZJR19JTVhfU0NVDQo+ID4gY2Fz
ZQ0KPiANCj4gSSBoYXZlIG9uZSBwYXRjaCBwZW5kaW5nIHJldmlld2luZy4NCj4gaHR0cHM6Ly9w
YXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMTM5NTI0Ny8NCg0KT0ssIGlmIHlvdXIgcGF0Y2gg
aXMgcGlja2VkIHVwLCB0aGVuIDEvNyBpcyB1bm5lY2Vzc2FyeSBmb3IgdGhpcyBwYXRjaCBzZXJp
ZXMsIGJ1dA0KdGhlIHJlc3QgYXJlIHN0aWxsIG5lZWRlZC4NCg0KQW5zb24NCg0KDQo+IA0KPiBU
aGFua3MsDQo+IFBlbmcuDQo+IA0KPiA+DQo+ID4gQWRkIHN0dWJzIGZvciB0aG9zZSBpLk1YIFND
VSBBUElzIHRvIG1ha2UgdGhvc2UgbW9kdWxlcyBkZXBlbmRpbmcgb24NCj4gPiBJTVhfU0NVIGNh
biBwYXNzIGJ1aWxkIHdoZW4gQ09NUElMRV9URVNUIGlzIGVuYWJsZWQuDQo+ID4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gPiAtLS0NCj4g
PiBDaGFuZ2VzIHNpbmNlIFYyOg0KPiA+IAktIHJldHVybiBlcnJvciBmb3Igc3R1YnMuDQo+ID4g
LS0tDQo+ID4gIGluY2x1ZGUvbGludXgvZmlybXdhcmUvaW14L2lwYy5oIHwgMTEgKysrKysrKysr
KysNCj4gPiBpbmNsdWRlL2xpbnV4L2Zpcm13YXJlL2lteC9zY2kuaCB8IDE5ICsrKysrKysrKysr
KysrKysrKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAzMCBpbnNlcnRpb25zKCspDQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9maXJtd2FyZS9pbXgvaXBjLmgNCj4gPiBiL2lu
Y2x1ZGUvbGludXgvZmlybXdhcmUvaW14L2lwYy5oDQo+ID4gaW5kZXggODkxMDU3NC4uOWUzZDgw
OCAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2Zpcm13YXJlL2lteC9pcGMuaA0KPiA+
ICsrKyBiL2luY2x1ZGUvbGludXgvZmlybXdhcmUvaW14L2lwYy5oDQo+ID4gQEAgLTM0LDYgKzM0
LDcgQEAgc3RydWN0IGlteF9zY19ycGNfbXNnIHsNCj4gPiAgCXVpbnQ4X3QgZnVuYzsNCj4gPiAg
fTsNCj4gPg0KPiA+ICsjaWZkZWYgQ09ORklHX0lNWF9TQ1UNCj4gPiAgLyoNCj4gPiAgICogVGhp
cyBpcyBhbiBmdW5jdGlvbiB0byBzZW5kIGFuIFJQQyBtZXNzYWdlIG92ZXIgYW4gSVBDIGNoYW5u
ZWwuDQo+ID4gICAqIEl0IGlzIGNhbGxlZCBieSBjbGllbnQtc2lkZSBTQ0ZXIEFQSSBmdW5jdGlv
biBzaGltcy4NCj4gPiBAQCAtNTUsNCArNTYsMTQgQEAgaW50IGlteF9zY3VfY2FsbF9ycGMoc3Ry
dWN0IGlteF9zY19pcGMgKmlwYywgdm9pZA0KPiA+ICptc2csIGJvb2wgaGF2ZV9yZXNwKTsNCj4g
PiAgICogQHJldHVybiBSZXR1cm5zIGFuIGVycm9yIGNvZGUgKDAgPSBzdWNjZXNzLCBmYWlsZWQg
aWYgPCAwKQ0KPiA+ICAgKi8NCj4gPiAgaW50IGlteF9zY3VfZ2V0X2hhbmRsZShzdHJ1Y3QgaW14
X3NjX2lwYyAqKmlwYyk7DQo+ID4gKyNlbHNlDQo+ID4gK3N0YXRpYyBpbmxpbmUgaW50IGlteF9z
Y3VfY2FsbF9ycGMoc3RydWN0IGlteF9zY19pcGMgKmlwYywgdm9pZCAqbXNnLA0KPiA+ICtib29s
IGhhdmVfcmVzcCkgew0KPiA+ICsJcmV0dXJuIC1FTk9FTlQ7DQo+ID4gK30NCj4gPiArc3RhdGlj
IGlubGluZSBpbnQgaW14X3NjdV9nZXRfaGFuZGxlKHN0cnVjdCBpbXhfc2NfaXBjICoqaXBjKSB7
DQo+ID4gKwlyZXR1cm4gLUVOT0VOVDsNCj4gPiArfQ0KPiA+ICsjZW5kaWYNCj4gPiAgI2VuZGlm
IC8qIF9TQ19JUENfSCAqLw0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2Zpcm13YXJl
L2lteC9zY2kuaA0KPiA+IGIvaW5jbHVkZS9saW51eC9maXJtd2FyZS9pbXgvc2NpLmgNCj4gPiBp
bmRleCAxN2JhNGU0Li4wMjIxMjliIDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvZmly
bXdhcmUvaW14L3NjaS5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9maXJtd2FyZS9pbXgvc2Np
LmgNCj4gPiBAQCAtMTYsOCArMTYsMjcgQEANCj4gPiAgI2luY2x1ZGUgPGxpbnV4L2Zpcm13YXJl
L2lteC9zdmMvbWlzYy5oPiAgI2luY2x1ZGUNCj4gPiA8bGludXgvZmlybXdhcmUvaW14L3N2Yy9w
bS5oPg0KPiA+DQo+ID4gKyNpZmRlZiBDT05GSUdfSU1YX1NDVQ0KPiA+ICBpbnQgaW14X3NjdV9l
bmFibGVfZ2VuZXJhbF9pcnFfY2hhbm5lbChzdHJ1Y3QgZGV2aWNlICpkZXYpOyAgaW50DQo+ID4g
aW14X3NjdV9pcnFfcmVnaXN0ZXJfbm90aWZpZXIoc3RydWN0IG5vdGlmaWVyX2Jsb2NrICpuYik7
ICBpbnQNCj4gPiBpbXhfc2N1X2lycV91bnJlZ2lzdGVyX25vdGlmaWVyKHN0cnVjdCBub3RpZmll
cl9ibG9jayAqbmIpOyAgaW50DQo+ID4gaW14X3NjdV9pcnFfZ3JvdXBfZW5hYmxlKHU4IGdyb3Vw
LCB1MzIgbWFzaywgdTggZW5hYmxlKTsNCj4gPiArI2Vsc2UNCj4gPiArc3RhdGljIGlubGluZSBp
bnQgaW14X3NjdV9lbmFibGVfZ2VuZXJhbF9pcnFfY2hhbm5lbChzdHJ1Y3QgZGV2aWNlDQo+ID4g
KypkZXYpIHsNCj4gPiArCXJldHVybiAtRU5PRU5UOw0KPiA+ICt9DQo+ID4gK3N0YXRpYyBpbmxp
bmUgaW50IGlteF9zY3VfaXJxX3JlZ2lzdGVyX25vdGlmaWVyKHN0cnVjdCBub3RpZmllcl9ibG9j
aw0KPiA+ICsqbmIpIHsNCj4gPiArCXJldHVybiAtRU5PRU5UOw0KPiA+ICt9DQo+ID4gK3N0YXRp
YyBpbmxpbmUgaW50IGlteF9zY3VfaXJxX3VucmVnaXN0ZXJfbm90aWZpZXIoc3RydWN0DQo+ID4g
K25vdGlmaWVyX2Jsb2NrDQo+ID4gKypuYikgew0KPiA+ICsJcmV0dXJuIC1FTk9FTlQ7DQo+ID4g
K30NCj4gPiArc3RhdGljIGlubGluZSBpbnQgaW14X3NjdV9pcnFfZ3JvdXBfZW5hYmxlKHU4IGdy
b3VwLCB1MzIgbWFzaywgdTgNCj4gPiArZW5hYmxlKSB7DQo+ID4gKwlyZXR1cm4gLUVOT0VOVDsN
Cj4gPiArfQ0KPiA+ICsjZW5kaWYNCj4gPiAgI2VuZGlmIC8qIF9TQ19TQ0lfSCAqLw0KPiA+IC0t
DQo+ID4gMi43LjQNCg0K
