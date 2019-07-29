Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0FF7787A1
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2019 10:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfG2Ikr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jul 2019 04:40:47 -0400
Received: from mail-eopbgr20067.outbound.protection.outlook.com ([40.107.2.67]:63558
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726305AbfG2Ikr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 29 Jul 2019 04:40:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQh229xktp3HrRseLePvP2sWXdBSgK5h7+sUHifLCF4+cPEf0mKktWSoYBwHoeBjqIZTO+hP1/1Fqvab3uj3KKlJAhhrIxxFOvmo3QGQ4Ci90bHtgyVFfpMjUjyPbLvKKaCJq1wt89dS8hxtzWjmxqvHmu2sQUCx3boh/sLa+kpxg+4i5Vbv3cFpcEwQL1LYfp4nMNJ9aV9d66U/odZIfzjmzpnaTZiGKfys+H+7hIK3neEFx5glsVGZC0/+2dun5NVSSJfmB+JCSLkBFQ7csWxoQmJZzS5CqowakqRyuY0IcKINOfDGKO86s9F3LiYKFPXzGFq4C/9GEB3zoOyO2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NQyQFT0Vc4sAFGL7iH/6CU9hHQJF3qzFIkr/7Hp2Oc=;
 b=gHhWzOR4yc4QEfG9JavM7QFXnIhUXK6ols++aMYg08g4BVGBeyDxteyxXdmIFvsLhWJgobr/cp9vgJIo44et0Oh+LMxY3TSk2Xgcp1g/C3XTX64G4kP6AMhk5UcWeDFDmbZJOcwxyK9F0KOscy0dqBvA4CDl5U3J/CWAMy/p6i8CjoDSZ2/D2TDl11beYTzJFSk9n/M31uueP0r6QjiIDnorxZlLxIoOLQCZq12uAMBCQrTsfulzaMb8uhJDHRMmLedGz/3mQc5yYOzLVzr64Z23wZF+f02cIj38tJ6dlyrl4Jr2UdMTj2EYekNII/01FPiRldgEZ7ktVKJa2Fg12g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NQyQFT0Vc4sAFGL7iH/6CU9hHQJF3qzFIkr/7Hp2Oc=;
 b=bWHHE7p4IzQGZO8YZmlh2t6QvC2LyzsjVsT17IBqlLhybkWuyJQBUZ0uXkP5ndDvgltAgX/bw4EIxr8vdzDCCiN+OnHjcxudU1qZrMQ4TzihUCl7/iPHJLaSJVpkvkInUWSRmLyB4vLo9qF1hiSNw2J7+XutWU2dOtKKwa3TWI8=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3819.eurprd04.prod.outlook.com (52.134.71.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.17; Mon, 29 Jul 2019 08:40:39 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::7cdf:bddc:212c:f77e]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::7cdf:bddc:212c:f77e%4]) with mapi id 15.20.2115.005; Mon, 29 Jul 2019
 08:40:39 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     =?utf-8?B?R3VpZG8gR8O8bnRoZXI=?= <agx@sigxcpu.org>
CC:     "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 4/6] thermal: qoriq: Add clock operations
Thread-Topic: [PATCH 4/6] thermal: qoriq: Add clock operations
Thread-Index: AQHVMu9L9eabQCV1yEK0bvOqH0zIxKbhZNKAgAACpdA=
Date:   Mon, 29 Jul 2019 08:40:39 +0000
Message-ID: <DB3PR0402MB391682A6263D084198E12DB6F5DD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190705045612.27665-1-Anson.Huang@nxp.com>
 <20190705045612.27665-4-Anson.Huang@nxp.com>
 <20190729081221.GA2523@bogon.m.sigxcpu.org>
In-Reply-To: <20190729081221.GA2523@bogon.m.sigxcpu.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7313234e-adaa-462c-60bd-08d714006f2e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3819;
x-ms-traffictypediagnostic: DB3PR0402MB3819:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB3PR0402MB38194A36B113D65244148CE9F5DD0@DB3PR0402MB3819.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 01136D2D90
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(199004)(189003)(53936002)(6116002)(3846002)(99286004)(55016002)(66446008)(25786009)(66476007)(6246003)(66556008)(8936002)(76116006)(6306002)(9686003)(33656002)(966005)(7736002)(74316002)(81166006)(305945005)(2906002)(54906003)(64756008)(316002)(86362001)(66574012)(66946007)(8676002)(256004)(6436002)(14454004)(14444005)(45080400002)(68736007)(102836004)(26005)(66066001)(76176011)(476003)(71200400001)(52536014)(7416002)(7696005)(11346002)(446003)(44832011)(4326008)(186003)(229853002)(6506007)(478600001)(6916009)(81156014)(71190400001)(5660300002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3819;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sguznUNbse9euGSeC60eXSACJKpLuWJugqDBWzz8ZlaFUZ7MfUX4AuXAekFHXwrPNHXLqzSx2xHqQD6JFXj77G7ixn6mg6G0Z2w3wPFCE3/Rwdupy7Y4LprEixYo0iWg+3re/VyM2/2ySCrzTGuA9SBhOihEfvxX8UbHDxBIdVSD1QVtKyoo6IgE9Ej0dtdIheiDpxabIIXag4BZVG4vuLS+GDO7DmZeUfBMdmlygPt2YXl/HMc952gfodcCVtuMdULn20CkACqvvQl332KCQDyfP6uL0IIaWVBAkFATZoMa7SHCaqpXMBSo1fA4URxEMAkW9YGd3c40YtKi5UrAXKGm++BJLezdgeHqoA6xBuZbL8m8UPl4sy1Z2mkwZoJW9TwLBb8szlX3rxjk0f6VUk8XaZI8UF4j3LKqrzhRMyo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7313234e-adaa-462c-60bd-08d714006f2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2019 08:40:39.3730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3819
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIEd1aWRvDQoNCj4gT24gRnJpLCBKdWwgMDUsIDIwMTkgYXQgMTI6NTY6MTBQTSArMDgwMCwg
QW5zb24uSHVhbmdAbnhwLmNvbSB3cm90ZToNCj4gPiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24u
SHVhbmdAbnhwLmNvbT4NCj4gPg0KPiA+IFNvbWUgcGxhdGZvcm1zIGxpa2UgaS5NWDhNUSBoYXMg
Y2xvY2sgY29udHJvbCBmb3IgdGhpcyBtb2R1bGUsIG5lZWQgdG8NCj4gPiBhZGQgY2xvY2sgb3Bl
cmF0aW9ucyB0byBtYWtlIHN1cmUgdGhlIGRyaXZlciBpcyB3b3JraW5nIHByb3Blcmx5Lg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+
ID4gLS0tDQo+ID4gIGRyaXZlcnMvdGhlcm1hbC9xb3JpcV90aGVybWFsLmMgfCAyNCArKysrKysr
KysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKykN
Cj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3RoZXJtYWwvcW9yaXFfdGhlcm1hbC5jDQo+
ID4gYi9kcml2ZXJzL3RoZXJtYWwvcW9yaXFfdGhlcm1hbC5jIGluZGV4IDJiMmY3OWIuLjA4MTNj
MWIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy90aGVybWFsL3FvcmlxX3RoZXJtYWwuYw0KPiA+
ICsrKyBiL2RyaXZlcnMvdGhlcm1hbC9xb3JpcV90aGVybWFsLmMNCj4gPiBAQCAtMiw2ICsyLDcg
QEANCj4gPiAgLy8NCj4gPiAgLy8gQ29weXJpZ2h0IDIwMTYgRnJlZXNjYWxlIFNlbWljb25kdWN0
b3IsIEluYy4NCj4gPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvY2xrLmg+DQo+ID4gICNpbmNsdWRl
IDxsaW51eC9tb2R1bGUuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5o
Pg0KPiA+ICAjaW5jbHVkZSA8bGludXgvZXJyLmg+DQo+ID4gQEAgLTcyLDYgKzczLDcgQEAgc3Ry
dWN0IHFvcmlxX3NlbnNvciB7DQo+ID4NCj4gPiAgc3RydWN0IHFvcmlxX3RtdV9kYXRhIHsNCj4g
PiAgCXN0cnVjdCBxb3JpcV90bXVfcmVncyBfX2lvbWVtICpyZWdzOw0KPiA+ICsJc3RydWN0IGNs
ayAqY2xrOw0KPiA+ICAJYm9vbCBsaXR0bGVfZW5kaWFuOw0KPiA+ICAJc3RydWN0IHFvcmlxX3Nl
bnNvcgkqc2Vuc29yW1NJVEVTX01BWF07DQo+ID4gIH07DQo+ID4gQEAgLTIwOCw2ICsyMTAsMTkg
QEAgc3RhdGljIGludCBxb3JpcV90bXVfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAq
cGRldikNCj4gPiAgCQlyZXR1cm4gUFRSX0VSUihkYXRhLT5yZWdzKTsNCj4gPiAgCX0NCj4gPg0K
PiA+ICsJZGF0YS0+Y2xrID0gZGV2bV9jbGtfZ2V0KCZwZGV2LT5kZXYsIE5VTEwpOw0KPiA+ICsJ
aWYgKElTX0VSUihkYXRhLT5jbGspKSB7DQo+ID4gKwkJaWYgKFBUUl9FUlIoZGF0YS0+Y2xrKSA9
PSAtRVBST0JFX0RFRkVSKQ0KPiA+ICsJCQlyZXR1cm4gLUVQUk9CRV9ERUZFUjsNCj4gPiArCQlk
YXRhLT5jbGsgPSBOVUxMOw0KPiA+ICsJfQ0KPiANCj4gV291bGRuJ3QgZGV2bV9jbGtfZ2V0X29w
dGlvbmFsIG1ha2UgbW9yZSBzZW5zZT8NCg0KWWVzLCBsb29rcyBsaWtlIGl0IGlzIGJldHRlciwg
d2lsbCBmaXggaXQgaW4gVjIuDQoNCj4gDQo+ID4gKw0KPiA+ICsJcmV0ID0gY2xrX3ByZXBhcmVf
ZW5hYmxlKGRhdGEtPmNsayk7DQo+ID4gKwlpZiAocmV0KSB7DQo+ID4gKwkJZGV2X2VycigmcGRl
di0+ZGV2LCAiRmFpbGVkIHRvIGVuYWJsZSBjbG9ja1xuIik7DQo+ID4gKwkJcmV0dXJuIHJldDsN
Cj4gPiArCX0NCj4gPiArDQo+ID4gIAlxb3JpcV90bXVfaW5pdF9kZXZpY2UoZGF0YSk7CS8qIFRN
VSBpbml0aWFsaXphdGlvbiAqLw0KPiA+DQo+ID4gIAlyZXQgPSBxb3JpcV90bXVfY2FsaWJyYXRp
b24ocGRldik7CS8qIFRNVSBjYWxpYnJhdGlvbiAqLw0KPiA+IEBAIC0yMzUsNiArMjUwLDggQEAg
c3RhdGljIGludCBxb3JpcV90bXVfcmVtb3ZlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBk
ZXYpDQo+ID4gIAkvKiBEaXNhYmxlIG1vbml0b3JpbmcgKi8NCj4gPiAgCXRtdV93cml0ZShkYXRh
LCBUTVJfRElTQUJMRSwgJmRhdGEtPnJlZ3MtPnRtcik7DQo+ID4NCj4gPiArCWNsa19kaXNhYmxl
X3VucHJlcGFyZShkYXRhLT5jbGspOw0KPiA+ICsNCj4gPiAgCXBsYXRmb3JtX3NldF9kcnZkYXRh
KHBkZXYsIE5VTEwpOw0KPiA+DQo+ID4gIAlyZXR1cm4gMDsNCj4gPiBAQCAtMjUwLDE0ICsyNjcs
MjEgQEAgc3RhdGljIGludCBfX21heWJlX3VudXNlZA0KPiBxb3JpcV90bXVfc3VzcGVuZChzdHJ1
Y3QgZGV2aWNlICpkZXYpDQo+ID4gIAl0bXIgJj0gflRNUl9NRTsNCj4gPiAgCXRtdV93cml0ZShk
YXRhLCB0bXIsICZkYXRhLT5yZWdzLT50bXIpOw0KPiA+DQo+ID4gKwljbGtfZGlzYWJsZV91bnBy
ZXBhcmUoZGF0YS0+Y2xrKTsNCj4gPiArDQo+ID4gIAlyZXR1cm4gMDsNCj4gPiAgfQ0KPiA+DQo+
ID4gIHN0YXRpYyBpbnQgX19tYXliZV91bnVzZWQgcW9yaXFfdG11X3Jlc3VtZShzdHJ1Y3QgZGV2
aWNlICpkZXYpICB7DQo+ID4gIAl1MzIgdG1yOw0KPiA+ICsJaW50IHJldDsNCj4gPiAgCXN0cnVj
dCBxb3JpcV90bXVfZGF0YSAqZGF0YSA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiA+DQo+ID4g
KwlyZXQgPSBjbGtfcHJlcGFyZV9lbmFibGUoZGF0YS0+Y2xrKTsNCj4gPiArCWlmIChyZXQpDQo+
ID4gKwkJcmV0dXJuIHJldDsNCj4gPiArDQo+ID4gIAkvKiBFbmFibGUgbW9uaXRvcmluZyAqLw0K
PiA+ICAJdG1yID0gdG11X3JlYWQoZGF0YSwgJmRhdGEtPnJlZ3MtPnRtcik7DQo+ID4gIAl0bXIg
fD0gVE1SX01FOw0KPiANCj4gQXBhcnQgZnJvbSB0aGF0IGl0IGxvb2tzIGxpa2Ugd2hhdCBGYWJp
byBzZW50IGFuZCB3aGF0IGkgdGVzdGVkIHNvDQo+IA0KPiBSZXZpZXdlZC1ieTogR3VpZG8gR8O8
bnRoZXIgPGFneEBzaWd4Y3B1Lm9yZz4NCg0KVGhhbmtzLA0KQW5zb24NCg0KPiANCj4gQ2hlZXJz
LA0KPiAgLS0gR3VpZG8NCj4gDQo+ID4gLS0NCj4gPiAyLjcuNA0KPiA+DQo+ID4NCj4gPiBfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiA+IGxpbnV4LWFy
bS1rZXJuZWwgbWFpbGluZyBsaXN0DQo+ID4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnDQo+ID4gaHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNv
bS8/dXJsPWh0dHAlM0ElMkYlMkZsaXN0cw0KPiA+IC5pbmZyYWRlYWQub3JnJTJGbWFpbG1hbiUy
Rmxpc3RpbmZvJTJGbGludXgtYXJtLQ0KPiBrZXJuZWwmYW1wO2RhdGE9MDIlN0MwDQo+ID4NCj4g
MSU3Q2Fuc29uLmh1YW5nJTQwbnhwLmNvbSU3QzkyNjNjMjQwZGE4MjQ4MmFmNTc5MDhkNzEzZmM3
ZDBiJTcNCj4gQzY4NmVhMWQNCj4gPg0KPiAzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3
QzAlN0M2MzY5OTk4NDc0NzI4OTQ2MjQmYW1wO3NkYXQNCj4gYT0wWUFsSw0KPiA+IFY4WlMzN3ZI
RnozMTFuT2RCUDhxQmJxaXN2akZCdGFTUzFQVjlrJTNEJmFtcDtyZXNlcnZlZD0wDQo+ID4NCg==
