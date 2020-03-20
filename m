Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C400E18C605
	for <lists+linux-pm@lfdr.de>; Fri, 20 Mar 2020 04:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgCTDmG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Mar 2020 23:42:06 -0400
Received: from mail-am6eur05on2049.outbound.protection.outlook.com ([40.107.22.49]:19201
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726596AbgCTDmG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 19 Mar 2020 23:42:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2/fUSzSin2kfzTtZZ3xAfhey3XAnn+VpR8WBkGjYjaBuxIwJuFjZ81hiRZmf3GLZ/NGffoaDM0aApVGm6biu8JxQ9W6Z7/0hrfvCLFj8emOfkDnMqFc59M1uBKyObsY9hDv6RCZrUaXld5bnWQQIDnLdd4aox2cZ8QjBBGpYaEAo9MvRab3O8s41Z4w8X2oEElgAyp0rpodwvtVKxuIKVLQdwdG1uCx7TNj5jhZ8i98AomCvW2g0wXgBZ8ZdMGKiXIoGrGCmY4mxO2HauKDS6ac8jln81Hyaov4iF/2ORKAMpQAuzp4OpVtLe5xy9BFeniMMs38Ch+axeDUFV9MJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isaRkMDTseHu15vSiCWq66zL/8VwXApq/HqJ98N0LxM=;
 b=EQEh+gVJfrKfcsNAzovWjCEektJZvU9detK/H48KWzNywmQi4u5XrXwWptdkfTz750z/KGT7ILykiUmGrAzlImTWHqCNdhAvFqDj4Hx7lCG8v83CYnaDMZkcEyCA1S26jUD1NvkgMbp/Iv7DBiFGL7uNusKJ1BZZmIvnqFlpGJK7jlFfR7WZzevmRpL4dOWY3Aqf4ekC/7RBdVPnC2E5ulQjRX06GuU3UN/4JB+I/ltOzzOftoq8PvlqVTQOyk6jVu8Kp+c5Go5DpV7SQa6Mb38976K9oqxg0Nudy3I4qlHdzCM8TDmux9GF4m6S1QrGdaYCby9M1uksPUtRfEzHGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isaRkMDTseHu15vSiCWq66zL/8VwXApq/HqJ98N0LxM=;
 b=CmJcJHVG9AJQMxXWrkPXKoYPgXJkP+VZIov9L09OOjrdRpfN3QVUn8ni1deeXSZBj6PxdsLIyrwM0t7YfILjcQpV3aLg9yZYWgeh/S2WOCFJ4qyDmBxJla6w/dzgPfu9hXMoZnRb+p+eB1fl9qHooy3K1vh6u3CqI8v1Kr/iLCE=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3658.eurprd04.prod.outlook.com (52.134.65.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18; Fri, 20 Mar 2020 03:37:25 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b%7]) with mapi id 15.20.2835.017; Fri, 20 Mar 2020
 03:37:25 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 2/3] thermal: imx8mm: Add i.MX8MP support
Thread-Topic: [PATCH 2/3] thermal: imx8mm: Add i.MX8MP support
Thread-Index: AQHV9V74kPvlCyYGZ0aw291WqUTD26hQTKgAgACZMtA=
Date:   Fri, 20 Mar 2020 03:37:24 +0000
Message-ID: <DB3PR0402MB3916B1B0EB74BAA875349AF4F5F50@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1583681240-14782-1-git-send-email-Anson.Huang@nxp.com>
 <1583681240-14782-2-git-send-email-Anson.Huang@nxp.com>
 <9ca81c42-6086-eb17-3eda-9bc2dab1101e@linaro.org>
In-Reply-To: <9ca81c42-6086-eb17-3eda-9bc2dab1101e@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bb8f79b6-bc28-4de6-1417-08d7cc8001a6
x-ms-traffictypediagnostic: DB3PR0402MB3658:|DB3PR0402MB3658:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3658CA6BE57A917971A22A57F5F50@DB3PR0402MB3658.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 03484C0ABF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(39860400002)(346002)(366004)(396003)(199004)(6506007)(53546011)(81166006)(66476007)(66446008)(2906002)(64756008)(9686003)(8936002)(66946007)(86362001)(66556008)(55016002)(110136005)(316002)(478600001)(76116006)(4326008)(81156014)(5660300002)(71200400001)(33656002)(7416002)(52536014)(44832011)(26005)(7696005)(186003)(8676002)(32563001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3658;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lqEo/TSQ3UsPoLAm2DvcBZXySnoQQVHtIo7krFmgtNvSL+NW8+af9dE+PFIaF/I+uZPiiM+teIyH3W3souQJmTZbDqOc6aKaNow/FgV5ZEyHpS8SZz0EdqGL4UZMfW4tIBdnblkInmjzss8Zb573fOJfylALmFtqMSJNpUMabyc87rUmZmCAREy5snxzom5ptEaMRKrMiXJr2/9WthBjigFdG1YvUzuNdAZgetSCYz/bcWnrHEww6mk0jpfhRGr81+Rvz0Ew5S1SW7vxh9GzJ5s64A6Xj8xp5CJEVTUIcX5ygZYMDLNg9iZUPUFXTRsetkrvd9CFuxCLXtDFSvGh3J312udr27+bV5G/6vtwVqe/xTiTg86g6DhTe+Zs7jSdArmZ5UHd7WXAvhGlnRRY7crWXzZB10WoEzTOUTzJlmsYmT+zaLuj+RjKv3IOvM1mpV4f+4uWnzy5sq2wRSj+Ku10sgJp/5tkPaVu+/+1CTXoV+eaqCX+0m7a/I55NVeuCkPck5tBm9/2K9S6DEdDOg==
x-ms-exchange-antispam-messagedata: Vu6R81wUFo56kAXMnCkIsyOvGrWXKQn1ns9cD+Za7OPI5F5ZHkopuZ4PJsH7Kn+uu8vGwYJQZnPwA2A6LnDy/YwwKPh4P4UBmhJVHWvIvD5lnyFg8Bimieil34ocO9o01f6OyGhuJAMSXtdgSwRcOQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb8f79b6-bc28-4de6-1417-08d7cc8001a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2020 03:37:25.0626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BF5f3iWVwcBpQk5Zq6t/tMT8dJXfiC+uD0BFz8vSwDqx5ma/lwWlhW88BGUlfLCiRL760LnTYKzK1RHeqW/smg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3658
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIERhbmllbA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8zXSB0aGVybWFsOiBpbXg4bW06
IEFkZCBpLk1YOE1QIHN1cHBvcnQNCj4gDQo+IE9uIDA4LzAzLzIwMjAgMTY6MjcsIEFuc29uIEh1
YW5nIHdyb3RlOg0KPiA+IGkuTVg4TVAgc2hhcmVzIHNhbWUgVE1VIHdpdGggaS5NWDhNTSwgdGhl
IG9ubHkgZGlmZmVyZW5jZSBpcyBpLk1YOE1QDQo+ID4gaGFzIHR3byB0aGVybWFsIHNlbnNvcnMg
d2hpbGUgaS5NWDhNTSBPTkxZIGhhcyBvbmUsIGFkZCBtdWx0aXBsZQ0KPiA+IHNlbnNvcnMgc3Vw
cG9ydCBmb3IgaS5NWDhNTSBUTVUgZHJpdmVyLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5z
b24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvdGhl
cm1hbC9pbXg4bW1fdGhlcm1hbC5jIHwgMTA4DQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA5MyBpbnNlcnRpb25zKCspLCAx
NSBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3RoZXJtYWwvaW14
OG1tX3RoZXJtYWwuYw0KPiA+IGIvZHJpdmVycy90aGVybWFsL2lteDhtbV90aGVybWFsLmMNCj4g
PiBpbmRleCBkNTk3Y2ViLi44YTg3ZWQwIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdGhlcm1h
bC9pbXg4bW1fdGhlcm1hbC5jDQo+ID4gKysrIGIvZHJpdmVycy90aGVybWFsL2lteDhtbV90aGVy
bWFsLmMNCj4gPiBAQCAtMTAsMzQgKzEwLDc1IEBADQo+ID4gICNpbmNsdWRlIDxsaW51eC9pby5o
Pg0KPiA+ICAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9v
Zi5oPg0KPiA+IC0jaW5jbHVkZSA8bGludXgvb2ZfYWRkcmVzcy5oPg0KPiA+ICsjaW5jbHVkZSA8
bGludXgvb2ZfZGV2aWNlLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2Uu
aD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3RoZXJtYWwuaD4NCj4gPg0KPiA+ICAjaW5jbHVkZSAi
dGhlcm1hbF9jb3JlLmgiDQo+ID4NCj4gPiAgI2RlZmluZSBURVIJCQkweDAJLyogVE1VIGVuYWJs
ZSAqLw0KPiA+ICsjZGVmaW5lIFRQUwkJCTB4NA0KPiA+ICAjZGVmaW5lIFRSSVRTUgkJCTB4MjAJ
LyogVE1VIGltbWVkaWF0ZSB0ZW1wICovDQo+ID4NCj4gPiAgI2RlZmluZSBURVJfRU4JCQlCSVQo
MzEpDQo+ID4gICNkZWZpbmUgVFJJVFNSX1ZBTF9NQVNLCQkweGZmDQo+ID4NCj4gPiAtI2RlZmlu
ZSBURU1QX0xPV19MSU1JVAkJMTANCj4gPiArI2RlZmluZSBQUk9CRV9TRUxfQUxMCQlHRU5NQVNL
KDMxLCAzMCkNCj4gPg0KPiA+IC1zdHJ1Y3QgaW14OG1tX3RtdSB7DQo+ID4gKyNkZWZpbmUgUFJP
QkUwX1NUQVRVU19PRkZTRVQJMzANCj4gPiArI2RlZmluZSBQUk9CRTBfVkFMX09GRlNFVAkxNg0K
PiA+ICsjZGVmaW5lIFNJR05fQklUCQlCSVQoNykNCj4gPiArI2RlZmluZSBURU1QX1ZBTF9NQVNL
CQlHRU5NQVNLKDYsIDApDQo+ID4gKw0KPiA+ICsjZGVmaW5lIFZFUjFfVEVNUF9MT1dfTElNSVQJ
MTANCj4gPiArI2RlZmluZSBWRVIyX1RFTVBfTE9XX0xJTUlUCS00MA0KPiA+ICsjZGVmaW5lIFZF
UjJfVEVNUF9ISUdIX0xJTUlUCTEyNQ0KPiA+ICsNCj4gPiArI2RlZmluZSBUTVVfVkVSMQkJMHgx
DQo+ID4gKyNkZWZpbmUgVE1VX1ZFUjIJCTB4Mg0KPiA+ICsNCj4gPiArc3RydWN0IHRoZXJtYWxf
c29jX2RhdGEgew0KPiA+ICsJdTMyIG51bV9zZW5zb3JzOw0KPiA+ICsJdTMyIHZlcnNpb247DQo+
ID4gK307DQo+ID4gKw0KPiA+ICtzdHJ1Y3QgdG11X3NlbnNvciB7DQo+ID4gKwlzdHJ1Y3QgaW14
OG1tX3RtdSAqcHJpdjsNCj4gPiArCXUzMiBod19pZDsNCj4gPiAgCXN0cnVjdCB0aGVybWFsX3pv
bmVfZGV2aWNlICp0emQ7DQo+ID4gK307DQo+ID4gKw0KPiA+ICtzdHJ1Y3QgaW14OG1tX3RtdSB7
DQo+ID4gIAl2b2lkIF9faW9tZW0gKmJhc2U7DQo+ID4gIAlzdHJ1Y3QgY2xrICpjbGs7DQo+ID4g
Kwljb25zdCBzdHJ1Y3QgdGhlcm1hbF9zb2NfZGF0YSAqc29jZGF0YTsNCj4gPiArCXN0cnVjdCB0
bXVfc2Vuc29yIHNlbnNvcnNbMF07DQo+ID4gIH07DQo+ID4NCj4gPiAgc3RhdGljIGludCB0bXVf
Z2V0X3RlbXAodm9pZCAqZGF0YSwgaW50ICp0ZW1wKSAgew0KPiA+IC0Jc3RydWN0IGlteDhtbV90
bXUgKnRtdSA9IGRhdGE7DQo+ID4gKwlzdHJ1Y3QgdG11X3NlbnNvciAqc2Vuc29yID0gZGF0YTsN
Cj4gPiArCXN0cnVjdCBpbXg4bW1fdG11ICp0bXUgPSBzZW5zb3ItPnByaXY7DQo+ID4gKwlib29s
IHJlYWR5Ow0KPiA+ICAJdTMyIHZhbDsNCj4gPg0KPiA+IC0JdmFsID0gcmVhZGxfcmVsYXhlZCh0
bXUtPmJhc2UgKyBUUklUU1IpICYgVFJJVFNSX1ZBTF9NQVNLOw0KPiA+IC0JaWYgKHZhbCA8IFRF
TVBfTE9XX0xJTUlUKQ0KPiA+IC0JCXJldHVybiAtRUFHQUlOOw0KPiA+ICsJaWYgKHRtdS0+c29j
ZGF0YS0+dmVyc2lvbiA9PSBUTVVfVkVSMSkgew0KPiANCj4gRG9uJ3QgZG8gdGhpcyBoZXJlLCBp
bXBsZW1lbnQgYSBjYWxsYmFjayB0byByZWFkIHRoZSB0ZW1wLCBzdG9yZSBpdCBpbiB0aGUNCj4g
c29jZGF0YSBhbmQgY2FsbCBpdCBkaXJlY3RseSBmcm9tIGhlcmUuDQo+IA0KPiBTbyB5b3UgZW5k
IHVwIHdpdGggc29tZXRoaW5nIHNpbXBsZSBsaWtlOg0KPiANCj4gCSp0ZW1wID0gdG11LT5zb2Nk
YXRhLT5nZXRfdGVtcCguLi4pOw0KPiANCg0KTWFrZSBzZW5zZSwgZG8gaXQgaW4gVjIuDQoNCg0K
PiA+ICsJCXZhbCA9IHJlYWRsX3JlbGF4ZWQodG11LT5iYXNlICsgVFJJVFNSKSAmDQo+IFRSSVRT
Ul9WQUxfTUFTSzsNCj4gPiArCQlpZiAodmFsIDwgVkVSMV9URU1QX0xPV19MSU1JVCkNCj4gPiAr
CQkJcmV0dXJuIC1FQUdBSU47PiArCX0gZWxzZSB7DQo+ID4gKwkJdmFsID0gcmVhZGxfcmVsYXhl
ZCh0bXUtPmJhc2UgKyBUUklUU1IpOw0KPiA+ICsJCXJlYWR5ID0gdmFsICYgKDEgPDwgKHNlbnNv
ci0+aHdfaWQgKw0KPiBQUk9CRTBfU1RBVFVTX09GRlNFVCkpOw0KPiANCj4gCXRlc3RfYml0KCk/
DQoNCk9LLg0KDQo+IA0KPiA+ICsJCXZhbCA9ICh2YWwgPj4gKHNlbnNvci0+aHdfaWQgKiBQUk9C
RTBfVkFMX09GRlNFVCkpDQo+ID4gKwkJICAgICAgJiBUUklUU1JfVkFMX01BU0s7DQo+ID4gKwkJ
aWYgKHZhbCAmIFNJR05fQklUKSAvKiBuZWdhdGl2ZSAqLw0KPiA+ICsJCQl2YWwgPSAofih2YWwg
JiBURU1QX1ZBTF9NQVNLKSArIDEpOw0KPiANCj4gUGxlYXNlIGhhdmUgYSBsb29rIGF0IHRoZSBk
aWZmZXJlbnQgYml0b3BzIGF2YWlsYWJsZSB0byBzaW1wbGlmeSB0aGlzIGRlY29kaW5nLg0KDQpJ
IGNhbiBPTkxZIGZpbmQgdGhlIEZJRUxEX0dFVCBmb3IgZ2V0dGluZyB0aGUgdGVtcGVyYXR1cmUg
dmFsdWUgZmllbGQsIGZvciB0aGUgcG9zaXRpdmUNCmFuZCBuZWdhdGl2ZSB2YWx1ZSBjaGVjaywg
SSBjYW4ndCBmaW5kIGFueSBBUEkgZm9yIGl0Lg0KDQoNCj4gDQo+ID4gKwkJKnRlbXAgPSB2YWw7
DQo+ID4gKwkJaWYgKCFyZWFkeSB8fCAqdGVtcCA8IFZFUjJfVEVNUF9MT1dfTElNSVQgfHwNCj4g
PiArCQkgICAgKnRlbXAgPiBWRVIyX1RFTVBfSElHSF9MSU1JVCkNCj4gPiArCQkJcmV0dXJuIC1F
QUdBSU47DQo+ID4gKwl9DQo+ID4NCj4gPiAgCSp0ZW1wID0gdmFsICogMTAwMDsNCj4gPg0KPiA+
IEBAIC01MCwxNCArOTEsMjEgQEAgc3RhdGljIHN0cnVjdCB0aGVybWFsX3pvbmVfb2ZfZGV2aWNl
X29wcw0KPiA+IHRtdV90el9vcHMgPSB7DQo+ID4NCj4gPiAgc3RhdGljIGludCBpbXg4bW1fdG11
X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpICB7DQo+ID4gKwljb25zdCBzdHJ1
Y3QgdGhlcm1hbF9zb2NfZGF0YSAqZGF0YTsNCj4gPiAgCXN0cnVjdCBpbXg4bW1fdG11ICp0bXU7
DQo+ID4gIAl1MzIgdmFsOw0KPiA+ICAJaW50IHJldDsNCj4gPiArCWludCBpOw0KPiA+ICsNCj4g
PiArCWRhdGEgPSBvZl9kZXZpY2VfZ2V0X21hdGNoX2RhdGEoJnBkZXYtPmRldik7DQo+ID4NCj4g
PiAtCXRtdSA9IGRldm1fa3phbGxvYygmcGRldi0+ZGV2LCBzaXplb2Yoc3RydWN0IGlteDhtbV90
bXUpLA0KPiBHRlBfS0VSTkVMKTsNCj4gPiArCXRtdSA9IGRldm1fa3phbGxvYygmcGRldi0+ZGV2
LCBzdHJ1Y3Rfc2l6ZSh0bXUsIHNlbnNvcnMsDQo+ID4gKwkJCSAgIGRhdGEtPm51bV9zZW5zb3Jz
KSwgR0ZQX0tFUk5FTCk7DQo+ID4gIAlpZiAoIXRtdSkNCj4gPiAgCQlyZXR1cm4gLUVOT01FTTsN
Cj4gPg0KPiA+ICsJdG11LT5zb2NkYXRhID0gZGF0YTsNCj4gPiArDQo+ID4gIAl0bXUtPmJhc2Ug
PSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2UocGRldiwgMCk7DQo+ID4gIAlpZiAoSVNf
RVJSKHRtdS0+YmFzZSkpDQo+ID4gIAkJcmV0dXJuIFBUUl9FUlIodG11LT5iYXNlKTsNCj4gPiBA
QCAtNzcsMTYgKzEyNSwzNSBAQCBzdGF0aWMgaW50IGlteDhtbV90bXVfcHJvYmUoc3RydWN0DQo+
IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiAgCQlyZXR1cm4gcmV0Ow0KPiA+ICAJfQ0KPiA+
DQo+ID4gLQl0bXUtPnR6ZCA9IGRldm1fdGhlcm1hbF96b25lX29mX3NlbnNvcl9yZWdpc3Rlcigm
cGRldi0+ZGV2LCAwLA0KPiA+IC0JCQkJCQkJdG11LCAmdG11X3R6X29wcyk7DQo+ID4gLQlpZiAo
SVNfRVJSKHRtdS0+dHpkKSkgew0KPiA+IC0JCWRldl9lcnIoJnBkZXYtPmRldiwNCj4gPiAtCQkJ
ImZhaWxlZCB0byByZWdpc3RlciB0aGVybWFsIHpvbmUgc2Vuc29yOiAlZFxuIiwgcmV0KTsNCj4g
PiAtCQlyZXR1cm4gUFRSX0VSUih0bXUtPnR6ZCk7DQo+ID4gKwkvKiBkaXNhYmxlIHRoZSBtb25p
dG9yIGR1cmluZyBpbml0aWFsaXphdGlvbiAqLw0KPiA+ICsJdmFsID0gcmVhZGxfcmVsYXhlZCh0
bXUtPmJhc2UgKyBURVIpOw0KPiA+ICsJdmFsICY9IH5URVJfRU47DQo+ID4gKwl3cml0ZWxfcmVs
YXhlZCh2YWwsIHRtdS0+YmFzZSArIFRFUik7DQo+IA0KPiBDb3VsZCB5b3Ugd3JhcCB0aG9zZSBj
YWxscyBpbnNpZGUgYSBzbWFsbCBoZWxwZXIgZnVuY3Rpb24gd2l0aCBhIHNlbGYNCj4gZGVzY3Jp
YmVkIG5hbWU/DQoNCk9LLg0KDQo+IA0KPiA+ICsNCj4gPiArCWZvciAoaSA9IDA7IGkgPCBkYXRh
LT5udW1fc2Vuc29yczsgaSsrKSB7DQo+ID4gKwkJdG11LT5zZW5zb3JzW2ldLnByaXYgPSB0bXU7
DQo+ID4gKwkJdG11LT5zZW5zb3JzW2ldLnR6ZCA9DQo+ID4gKwkJCWRldm1fdGhlcm1hbF96b25l
X29mX3NlbnNvcl9yZWdpc3RlcigmcGRldi0+ZGV2LA0KPiBpLA0KPiA+ICsJCQkJCQkJICAgICAm
dG11LT5zZW5zb3JzW2ldLA0KPiA+ICsJCQkJCQkJICAgICAmdG11X3R6X29wcyk7DQo+ID4gKwkJ
aWYgKElTX0VSUih0bXUtPnNlbnNvcnNbaV0udHpkKSkgew0KPiA+ICsJCQlkZXZfZXJyKCZwZGV2
LT5kZXYsDQo+ID4gKwkJCQkiZmFpbGVkIHRvIHJlZ2lzdGVyIHRoZXJtYWwgem9uZQ0KPiBzZW5z
b3JbJWRdOiAlZFxuIiwNCj4gPiArCQkJCWksIHJldCk7DQo+ID4gKwkJCXJldHVybiBQVFJfRVJS
KHRtdS0+c2Vuc29yc1tpXS50emQpOw0KPiA+ICsJCX0NCj4gPiArCQl0bXUtPnNlbnNvcnNbaV0u
aHdfaWQgPSBpOw0KPiANCj4gTWF5IGJlIHlvdSBjYW4gc3RvcmUgdGhlIG9mZnNldCBkaXJlY3Rs
eSwgc28gaXQgaXMgbm90IGNvbXB1dGVkIGV2ZXJ5IHRpbWUgdGhlDQo+IHRlbXBlcmF0dXJlIGlz
IHJlYWQ/DQoNClRoZXJlIGFyZSAyIHBsYWNlIG5lZWQgdG8gaWRlbnRpZnkgdGhlIHNlbnNvciBJ
RCwgdGhlIHJlYWR5IGJpdCBhbmQgdGhlIHRlbXBlcmF0dXJlDQp2YWx1ZSBmaWVsZCwgc28gSSB0
aGluayB0aGUgaHdfaWQgaXMgbmVjZXNzYXJ5LCBhbmQgaXQgYWxzbyBtYWtlIHRoZSBsb2dpYyBl
YXN5IHRvIHJlYWQuDQoNCg0KPiANCj4gPiAgCX0NCj4gPg0KPiA+ICAJcGxhdGZvcm1fc2V0X2Ry
dmRhdGEocGRldiwgdG11KTsNCj4gPg0KPiA+ICsJLyogZW5hYmxlIGFsbCB0aGUgcHJvYmVzIGZv
ciBWMiBUTVUgKi8NCj4gPiArCWlmICh0bXUtPnNvY2RhdGEtPnZlcnNpb24gPT0gVE1VX1ZFUjIp
IHsNCj4gPiArCQl2YWwgPSByZWFkbF9yZWxheGVkKHRtdS0+YmFzZSArIFRQUyk7DQo+ID4gKwkJ
dmFsIHw9IFBST0JFX1NFTF9BTEw7DQo+ID4gKwkJd3JpdGVsX3JlbGF4ZWQodmFsLCB0bXUtPmJh
c2UgKyBUUFMpOw0KPiA+ICsJfQ0KPiANCj4gU2FtZSBjb21tZW50IGFzIGJlZm9yZSBhYm91dCBw
dXR0aW5nIHRoZXNlIGluIGEgaGVscGVyDQoNCk9LDQoNClBsZWFzZSBoZWxwIHJldmlldyBWMiBw
YXRjaC4NCg0KVGhhbmtzLA0KQW5zb24NCg0K
