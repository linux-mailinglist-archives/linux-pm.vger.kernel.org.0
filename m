Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA0F41834E
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2019 03:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfEIBoa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 May 2019 21:44:30 -0400
Received: from mail-eopbgr50071.outbound.protection.outlook.com ([40.107.5.71]:35652
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725832AbfEIBo3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 May 2019 21:44:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9ELYKSBiXWdzpFWHHWDuQIQFqmUUCVacw447iKxdOU=;
 b=PGGS4Ypwt+s71aHzPuxrNLTmOr4Pdb1dI07ms2tKFWhCFX1NvDQWT9R6X6PANWHfZIPEW19nEeLUupwfgmsxZS0+ZIrQi9SBSEMWzdhp51IaYIZrrdzl32YocSXa+D0zQaNfwVa+/LIRsiqehLci6pTKIrwmkUwq8wIni2W6YzM=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3929.eurprd04.prod.outlook.com (52.134.70.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.20; Thu, 9 May 2019 01:44:22 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d%2]) with mapi id 15.20.1878.022; Thu, 9 May 2019
 01:44:22 +0000
From:   Anson Huang <anson.huang@nxp.com>
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
        Aisheng Dong <aisheng.dong@nxp.com>,
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
Thread-Index: AQHU9AOc8iXKmYQeMUm4+FbUnbYclKZiKWGA
Date:   Thu, 9 May 2019 01:44:22 +0000
Message-ID: <DB3PR0402MB3916791537B7C3C85B13A22BF5330@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1555384609-7030-1-git-send-email-Anson.Huang@nxp.com>
 <1555384609-7030-3-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1555384609-7030-3-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb208fb9-95d1-464a-079d-08d6d41fdc19
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3929;
x-ms-traffictypediagnostic: DB3PR0402MB3929:
x-microsoft-antispam-prvs: <DB3PR0402MB39292EE51B69545540F21EAFF5330@DB3PR0402MB3929.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 003245E729
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(376002)(346002)(396003)(189003)(199004)(13464003)(5660300002)(316002)(52536014)(7696005)(99286004)(229853002)(478600001)(76176011)(68736007)(8936002)(102836004)(11346002)(53546011)(476003)(446003)(9686003)(81156014)(44832011)(55016002)(81166006)(33656002)(53936002)(73956011)(8676002)(2501003)(486006)(26005)(6436002)(76116006)(66946007)(64756008)(66446008)(66476007)(66556008)(110136005)(14454004)(86362001)(4326008)(66066001)(6246003)(25786009)(186003)(2201001)(6506007)(2906002)(7736002)(305945005)(7416002)(256004)(71200400001)(71190400001)(3846002)(6116002)(74316002)(921003)(1121003)(15866825006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3929;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4J6dnRLo50SdI3GYGrlskzQ5kZnI3ARVO+AohaY9TvLUjG58H7tD1T9htMCzA8R30Px1J2W2w4Iqf7QmNiaqYyipvr16zio8H96MG+BYh0MxXH7MDozeD79b9NdAHhbTtXnjjjBsHaldk2iZK+iVbbVQP/34X/HQkROA+hCOFIxwZQLFfisgPbHNA0XJ+ZK2/dFBJE0D6Td0twhQdJaBlcsGpB5vExiEP+HSKR46FdIcrqy6FdPRy58sOkxWm2GnWomerxQIg+VY8aEGRyttwoghG6wzZjKnfqsliVrKw+Sa+Ia/VNYG6uYcO8/VzlbQyGi8J2OBzpIq3J47ArVqS7IjHMv+YW8NEF71Izk2NDyJWVLICvs1Owykh3WwUOvCaYY/sEx0MiXnRsx74gqyivVpfz1ccVZQzvT1aX+IAVA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb208fb9-95d1-464a-079d-08d6d41fdc19
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2019 01:44:22.0475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3929
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

UGluZy4uLg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFuc29uIEh1
YW5nIFttYWlsdG86QW5zb24uSHVhbmdAbnhwLmNvbV0NCj4gU2VudDogVHVlc2RheSwgQXByaWwg
MTYsIDIwMTkgMTE6MjIgQU0NCj4gVG86IHJvYmgrZHRAa2VybmVsLm9yZzsgbWFyay5ydXRsYW5k
QGFybS5jb207IHNoYXduZ3VvQGtlcm5lbC5vcmc7DQo+IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7
IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOw0KPiBjYXRhbGluLm1h
cmluYXNAYXJtLmNvbTsgd2lsbC5kZWFjb25AYXJtLmNvbTsgcnVpLnpoYW5nQGludGVsLmNvbTsN
Cj4gZWR1YmV6dmFsQGdtYWlsLmNvbTsgZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZzsgQWlzaGVu
ZyBEb25nDQo+IDxhaXNoZW5nLmRvbmdAbnhwLmNvbT47IHVsZi5oYW5zc29uQGxpbmFyby5vcmc7
IERhbmllbCBCYWx1dGENCj4gPGRhbmllbC5iYWx1dGFAbnhwLmNvbT47IFBlbmcgRmFuIDxwZW5n
LmZhbkBueHAuY29tPjsNCj4gaGVpa29Ac250ZWNoLmRlOyBob3JtcytyZW5lc2FzQHZlcmdlLm5l
dC5hdTsgYWdyb3NzQGtlcm5lbC5vcmc7DQo+IG9sb2ZAbGl4b20ubmV0OyBiam9ybi5hbmRlcnNz
b25AbGluYXJvLm9yZzsgamFnYW5AYW1hcnVsYXNvbHV0aW9ucy5jb207DQo+IGVucmljLmJhbGxl
dGJvQGNvbGxhYm9yYS5jb207IG1hcmMudy5nb256YWxlekBmcmVlLmZyOw0KPiBkZXZpY2V0cmVl
QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJt
LQ0KPiBrZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtcG1Admdlci5rZXJuZWwub3Jn
DQo+IENjOiBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBbUEFU
Q0ggVjEyIDMvNV0gdGhlcm1hbDogaW14X3NjOiBhZGQgaS5NWCBzeXN0ZW0gY29udHJvbGxlcg0K
PiB0aGVybWFsIHN1cHBvcnQNCj4gDQo+IGkuTVg4UVhQIGlzIGFuIEFSTXY4IFNvQyB3aGljaCBo
YXMgYSBDb3J0ZXgtTTQgc3lzdGVtIGNvbnRyb2xsZXIgaW5zaWRlLA0KPiB0aGUgc3lzdGVtIGNv
bnRyb2xsZXIgaXMgaW4gY2hhcmdlIG9mIGNvbnRyb2xsaW5nIHBvd2VyLCBjbG9jayBhbmQgdGhl
cm1hbA0KPiBzZW5zb3JzIGV0Yy4uDQo+IA0KPiBUaGlzIHBhdGNoIGFkZHMgaS5NWCBzeXN0ZW0g
Y29udHJvbGxlciB0aGVybWFsIGRyaXZlciBzdXBwb3J0LCBMaW51eCBrZXJuZWwNCj4gaGFzIHRv
IGNvbW11bmljYXRlIHdpdGggc3lzdGVtIGNvbnRyb2xsZXIgdmlhIE1VIChtZXNzYWdlIHVuaXQp
IElQQyB0byBnZXQNCj4gZWFjaCB0aGVybWFsIHNlbnNvcidzIHRlbXBlcmF0dXJlLCBpdCBzdXBw
b3J0cyBtdWx0aXBsZSBzZW5zb3JzIHdoaWNoIGFyZQ0KPiBwYXNzZWQgZnJvbSBkZXZpY2UgdHJl
ZSwgcGxlYXNlIHNlZSB0aGUgYmluZGluZyBkb2MgZm9yIGRldGFpbHMuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gLS0tDQo+IENoYW5n
ZXMgc2luY2UgVjExOg0KPiAJLSBtb3ZlIHRoZSBBUEkgb2YgZ2V0dGluZyB0aGVybWFsIHpvbmUg
c2Vuc29yIElEIHRvIG9mLXRoZXJtYWwuYyBhcw0KPiBnZW5lcmljIEFQSTsNCj4gCS0gcmVtb3Zl
IHVubmVjZXNzYXJ5IF9fcGFja2VkLg0KPiAtLS0NCj4gIGRyaXZlcnMvdGhlcm1hbC9LY29uZmln
ICAgICAgICAgIHwgIDExICsrKysNCj4gIGRyaXZlcnMvdGhlcm1hbC9NYWtlZmlsZSAgICAgICAg
IHwgICAxICsNCj4gIGRyaXZlcnMvdGhlcm1hbC9pbXhfc2NfdGhlcm1hbC5jIHwgMTM3DQo+ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgMyBmaWxlcyBjaGFuZ2Vk
LCAxNDkgaW5zZXJ0aW9ucygrKQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvdGhlcm1h
bC9pbXhfc2NfdGhlcm1hbC5jDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90aGVybWFsL0tj
b25maWcgYi9kcml2ZXJzL3RoZXJtYWwvS2NvbmZpZyBpbmRleA0KPiA2NTNhYTI3Li40ZTRmYTdl
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3RoZXJtYWwvS2NvbmZpZw0KPiArKysgYi9kcml2ZXJz
L3RoZXJtYWwvS2NvbmZpZw0KPiBAQCAtMjIzLDYgKzIyMywxNyBAQCBjb25maWcgSU1YX1RIRVJN
QUwNCj4gIAkgIGNwdWZyZXEgaXMgdXNlZCBhcyB0aGUgY29vbGluZyBkZXZpY2UgdG8gdGhyb3R0
bGUgQ1BVcyB3aGVuIHRoZQ0KPiAgCSAgcGFzc2l2ZSB0cmlwIGlzIGNyb3NzZWQuDQo+IA0KPiAr
Y29uZmlnIElNWF9TQ19USEVSTUFMDQo+ICsJdHJpc3RhdGUgIlRlbXBlcmF0dXJlIHNlbnNvciBk
cml2ZXIgZm9yIE5YUCBpLk1YIFNvQ3Mgd2l0aCBTeXN0ZW0NCj4gQ29udHJvbGxlciINCj4gKwlk
ZXBlbmRzIG9uIChBUkNIX01YQyAmJiBJTVhfU0NVKSB8fCBDT01QSUxFX1RFU1QNCj4gKwlkZXBl
bmRzIG9uIE9GDQo+ICsJaGVscA0KPiArCSAgU3VwcG9ydCBmb3IgVGVtcGVyYXR1cmUgTW9uaXRv
ciAoVEVNUE1PTikgZm91bmQgb24gTlhQIGkuTVgNCj4gU29DcyB3aXRoDQo+ICsJICBzeXN0ZW0g
Y29udHJvbGxlciBpbnNpZGUsIExpbnV4IGtlcm5lbCBoYXMgdG8gY29tbXVuaWNhdGUgd2l0aA0K
PiBzeXN0ZW0NCj4gKwkgIGNvbnRyb2xsZXIgdmlhIE1VIChtZXNzYWdlIHVuaXQpIElQQyB0byBn
ZXQgdGVtcGVyYXR1cmUgZnJvbQ0KPiB0aGVybWFsDQo+ICsJICBzZW5zb3IuIEl0IHN1cHBvcnRz
IG9uZSBjcml0aWNhbCB0cmlwIHBvaW50IGFuZCBvbmUNCj4gKwkgIHBhc3NpdmUgdHJpcCBwb2lu
dCBmb3IgZWFjaCB0aGVybWFsIHNlbnNvci4NCj4gKw0KPiAgY29uZmlnIE1BWDc3NjIwX1RIRVJN
QUwNCj4gIAl0cmlzdGF0ZSAiVGVtcGVyYXR1cmUgc2Vuc29yIGRyaXZlciBmb3IgTWF4aW0gTUFY
Nzc2MjAgUE1JQyINCj4gIAlkZXBlbmRzIG9uIE1GRF9NQVg3NzYyMA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy90aGVybWFsL01ha2VmaWxlIGIvZHJpdmVycy90aGVybWFsL01ha2VmaWxlIGluZGV4
DQo+IDQ4NmQ2ODIuLjQwNjI2MjcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdGhlcm1hbC9NYWtl
ZmlsZQ0KPiArKysgYi9kcml2ZXJzL3RoZXJtYWwvTWFrZWZpbGUNCj4gQEAgLTQwLDYgKzQwLDcg
QEAgb2JqLSQoQ09ORklHX0RCODUwMF9USEVSTUFMKQkrPQ0KPiBkYjg1MDBfdGhlcm1hbC5vDQo+
ICBvYmotJChDT05GSUdfQVJNQURBX1RIRVJNQUwpCSs9IGFybWFkYV90aGVybWFsLm8NCj4gIG9i
ai0kKENPTkZJR19UQU5HT19USEVSTUFMKQkrPSB0YW5nb190aGVybWFsLm8NCj4gIG9iai0kKENP
TkZJR19JTVhfVEhFUk1BTCkJKz0gaW14X3RoZXJtYWwubw0KPiArb2JqLSQoQ09ORklHX0lNWF9T
Q19USEVSTUFMKQkrPSBpbXhfc2NfdGhlcm1hbC5vDQo+ICBvYmotJChDT05GSUdfTUFYNzc2MjBf
VEhFUk1BTCkJKz0gbWF4Nzc2MjBfdGhlcm1hbC5vDQo+ICBvYmotJChDT05GSUdfUU9SSVFfVEhF
Uk1BTCkJKz0gcW9yaXFfdGhlcm1hbC5vDQo+ICBvYmotJChDT05GSUdfREE5MDYyX1RIRVJNQUwp
CSs9IGRhOTA2Mi10aGVybWFsLm8NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdGhlcm1hbC9pbXhf
c2NfdGhlcm1hbC5jDQo+IGIvZHJpdmVycy90aGVybWFsL2lteF9zY190aGVybWFsLmMNCj4gbmV3
IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMC4uZGNmMTZmYw0KPiAtLS0gL2Rldi9u
dWxsDQo+ICsrKyBiL2RyaXZlcnMvdGhlcm1hbC9pbXhfc2NfdGhlcm1hbC5jDQo+IEBAIC0wLDAg
KzEsMTM3IEBADQo+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCsNCj4gKy8q
DQo+ICsgKiBDb3B5cmlnaHQgMjAxOC0yMDE5IE5YUC4NCj4gKyAqLw0KPiArDQo+ICsjaW5jbHVk
ZSA8bGludXgvZXJyLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvZmlybXdhcmUvaW14L3NjaS5oPg0K
PiArI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L29mLmg+DQo+
ICsjaW5jbHVkZSA8bGludXgvb2ZfZGV2aWNlLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvcGxhdGZv
cm1fZGV2aWNlLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvc2xhYi5oPg0KPiArI2luY2x1ZGUgPGxp
bnV4L3RoZXJtYWwuaD4NCj4gKw0KPiArI2luY2x1ZGUgInRoZXJtYWxfY29yZS5oIg0KPiArDQo+
ICsjZGVmaW5lIElNWF9TQ19NSVNDX0ZVTkNfR0VUX1RFTVAJMTMNCj4gKyNkZWZpbmUgSU1YX1ND
X0NfVEVNUAkJCTANCj4gKw0KPiArc3RhdGljIHN0cnVjdCBpbXhfc2NfaXBjICp0aGVybWFsX2lw
Y19oYW5kbGU7DQo+ICsNCj4gK3N0cnVjdCBpbXhfc2Nfc2Vuc29yIHsNCj4gKwlzdHJ1Y3QgdGhl
cm1hbF96b25lX2RldmljZSAqdHpkOw0KPiArCXUzMiByZXNvdXJjZV9pZDsNCj4gK307DQo+ICsN
Cj4gK3N0cnVjdCByZXFfZ2V0X3RlbXAgew0KPiArCXUxNiByZXNvdXJjZV9pZDsNCj4gKwl1OCB0
eXBlOw0KPiArfSBfX3BhY2tlZDsNCj4gKw0KPiArc3RydWN0IHJlc3BfZ2V0X3RlbXAgew0KPiAr
CXUxNiBjZWxzaXVzOw0KPiArCXU4IHRlbnRoczsNCj4gK30gX19wYWNrZWQ7DQo+ICsNCj4gK3N0
cnVjdCBpbXhfc2NfbXNnX21pc2NfZ2V0X3RlbXAgew0KPiArCXN0cnVjdCBpbXhfc2NfcnBjX21z
ZyBoZHI7DQo+ICsJdW5pb24gew0KPiArCQlzdHJ1Y3QgcmVxX2dldF90ZW1wIHJlcTsNCj4gKwkJ
c3RydWN0IHJlc3BfZ2V0X3RlbXAgcmVzcDsNCj4gKwl9IGRhdGE7DQo+ICt9Ow0KPiArDQo+ICtz
dGF0aWMgaW50IGlteF9zY190aGVybWFsX2dldF90ZW1wKHZvaWQgKmRhdGEsIGludCAqdGVtcCkg
ew0KPiArCXN0cnVjdCBpbXhfc2NfbXNnX21pc2NfZ2V0X3RlbXAgbXNnOw0KPiArCXN0cnVjdCBp
bXhfc2NfcnBjX21zZyAqaGRyID0gJm1zZy5oZHI7DQo+ICsJc3RydWN0IGlteF9zY19zZW5zb3Ig
KnNlbnNvciA9IGRhdGE7DQo+ICsJaW50IHJldDsNCj4gKw0KPiArCW1zZy5kYXRhLnJlcS5yZXNv
dXJjZV9pZCA9IHNlbnNvci0+cmVzb3VyY2VfaWQ7DQo+ICsJbXNnLmRhdGEucmVxLnR5cGUgPSBJ
TVhfU0NfQ19URU1QOw0KPiArDQo+ICsJaGRyLT52ZXIgPSBJTVhfU0NfUlBDX1ZFUlNJT047DQo+
ICsJaGRyLT5zdmMgPSBJTVhfU0NfUlBDX1NWQ19NSVNDOw0KPiArCWhkci0+ZnVuYyA9IElNWF9T
Q19NSVNDX0ZVTkNfR0VUX1RFTVA7DQo+ICsJaGRyLT5zaXplID0gMjsNCj4gKw0KPiArCXJldCA9
IGlteF9zY3VfY2FsbF9ycGModGhlcm1hbF9pcGNfaGFuZGxlLCAmbXNnLCB0cnVlKTsNCj4gKwlp
ZiAocmV0KSB7DQo+ICsJCXByX2VycigicmVhZCB0ZW1wIHNlbnNvciAlZCBmYWlsZWQsIHJldCAl
ZFxuIiwNCj4gKwkJCXNlbnNvci0+cmVzb3VyY2VfaWQsIHJldCk7DQo+ICsJCXJldHVybiByZXQ7
DQo+ICsJfQ0KPiArDQo+ICsJKnRlbXAgPSBtc2cuZGF0YS5yZXNwLmNlbHNpdXMgKiAxMDAwICsg
bXNnLmRhdGEucmVzcC50ZW50aHMgKiAxMDA7DQo+ICsNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4g
Kw0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCB0aGVybWFsX3pvbmVfb2ZfZGV2aWNlX29wcyBpbXhf
c2NfdGhlcm1hbF9vcHMgPSB7DQo+ICsJLmdldF90ZW1wID0gaW14X3NjX3RoZXJtYWxfZ2V0X3Rl
bXAsDQo+ICt9Ow0KPiArDQo+ICtzdGF0aWMgaW50IGlteF9zY190aGVybWFsX3Byb2JlKHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpIHsNCj4gKwlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wLCAq
Y2hpbGQ7DQo+ICsJaW50IHJldDsNCj4gKw0KPiArCXJldCA9IGlteF9zY3VfZ2V0X2hhbmRsZSgm
dGhlcm1hbF9pcGNfaGFuZGxlKTsNCj4gKwlpZiAocmV0KQ0KPiArCQlyZXR1cm4gcmV0Ow0KPiAr
DQo+ICsJbnAgPSBvZl9maW5kX25vZGVfYnlfbmFtZShOVUxMLCAidGhlcm1hbC16b25lcyIpOw0K
PiArCWlmICghbnApDQo+ICsJCXJldHVybiAtRU5PREVWOw0KPiArDQo+ICsJZm9yX2VhY2hfYXZh
aWxhYmxlX2NoaWxkX29mX25vZGUobnAsIGNoaWxkKSB7DQo+ICsJCXN0cnVjdCBvZl9waGFuZGxl
X2FyZ3Mgc2Vuc29yX3NwZWNzOw0KPiArCQlzdHJ1Y3QgaW14X3NjX3NlbnNvciAqc2Vuc29yID0N
Cj4gKwkJCWRldm1fa3phbGxvYygmcGRldi0+ZGV2LCBzaXplb2YoKnNlbnNvciksDQo+IEdGUF9L
RVJORUwpOw0KPiArCQlpZiAoIXNlbnNvcikNCj4gKwkJCXJldHVybiAtRU5PTUVNOw0KPiArDQo+
ICsJCXJldCA9IHRoZXJtYWxfem9uZV9vZl9nZXRfc2Vuc29yX2lkKGNoaWxkLA0KPiArCQkJCQkJ
ICAgICZzZW5zb3Jfc3BlY3MsDQo+ICsJCQkJCQkgICAgJnNlbnNvci0+cmVzb3VyY2VfaWQpOw0K
PiArCQlpZiAocmV0IDwgMCkgew0KPiArCQkJZGV2X2VycigmcGRldi0+ZGV2LA0KPiArCQkJCSJm
YWlsZWQgdG8gZ2V0IHZhbGlkIHNlbnNvciByZXNvdXJjZSBpZDogJWRcbiIsDQo+ICsJCQkJcmV0
KTsNCj4gKwkJCWJyZWFrOw0KPiArCQl9DQo+ICsNCj4gKwkJc2Vuc29yLT50emQgPQ0KPiBkZXZt
X3RoZXJtYWxfem9uZV9vZl9zZW5zb3JfcmVnaXN0ZXIoJnBkZXYtPmRldiwNCj4gKwkJCQkJCQkJ
ICAgc2Vuc29yLQ0KPiA+cmVzb3VyY2VfaWQsDQo+ICsJCQkJCQkJCSAgIHNlbnNvciwNCj4gKw0K
PiAmaW14X3NjX3RoZXJtYWxfb3BzKTsNCj4gKwkJaWYgKElTX0VSUihzZW5zb3ItPnR6ZCkpIHsN
Cj4gKwkJCWRldl9lcnIoJnBkZXYtPmRldiwgImZhaWxlZCB0byByZWdpc3RlciB0aGVybWFsDQo+
IHpvbmVcbiIpOw0KPiArCQkJcmV0ID0gUFRSX0VSUihzZW5zb3ItPnR6ZCk7DQo+ICsJCQlicmVh
azsNCj4gKwkJfQ0KPiArCX0NCj4gKw0KPiArCXJldHVybiByZXQ7DQo+ICt9DQo+ICsNCj4gK3N0
YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGlteF9zY190aGVybWFsX3RhYmxlW10gPSB7
DQo+ICsJeyAuY29tcGF0aWJsZSA9ICJmc2wsaW14LXNjLXRoZXJtYWwiLCB9LA0KPiArCXt9DQo+
ICt9Ow0KPiArTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgaW14X3NjX3RoZXJtYWxfdGFibGUpOw0K
PiArDQo+ICtzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBpbXhfc2NfdGhlcm1hbF9kcml2
ZXIgPSB7DQo+ICsJCS5wcm9iZSA9IGlteF9zY190aGVybWFsX3Byb2JlLA0KPiArCQkuZHJpdmVy
ID0gew0KPiArCQkJLm5hbWUgPSAiaW14LXNjLXRoZXJtYWwiLA0KPiArCQkJLm9mX21hdGNoX3Rh
YmxlID0gaW14X3NjX3RoZXJtYWxfdGFibGUsDQo+ICsJCX0sDQo+ICt9Ow0KPiArbW9kdWxlX3Bs
YXRmb3JtX2RyaXZlcihpbXhfc2NfdGhlcm1hbF9kcml2ZXIpOw0KPiArDQo+ICtNT0RVTEVfQVVU
SE9SKCJBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4iKTsNCj4gK01PRFVMRV9ERVND
UklQVElPTigiVGhlcm1hbCBkcml2ZXIgZm9yIE5YUCBpLk1YIFNvQ3Mgd2l0aCBzeXN0ZW0NCj4g
K2NvbnRyb2xsZXIiKTsgTU9EVUxFX0xJQ0VOU0UoIkdQTCB2MiIpOw0KPiAtLQ0KPiAyLjcuNA0K
DQo=
