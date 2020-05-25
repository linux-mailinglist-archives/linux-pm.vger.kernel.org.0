Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51AC01E04CF
	for <lists+linux-pm@lfdr.de>; Mon, 25 May 2020 04:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388398AbgEYCq0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 24 May 2020 22:46:26 -0400
Received: from mail-am6eur05on2081.outbound.protection.outlook.com ([40.107.22.81]:6059
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388158AbgEYCqZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 24 May 2020 22:46:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZxQNwv/FitUtbldlCJe726dSCzA3oVy1p5dyr7BTUGDshhWF0CQJJ51YnFw9H6Ov2oenvua2Nyaln207CcpYIyd+m8Xmq9OgNLxkE6BkG1L+I5+KyuR1f1bxX2onqDwLgwZORnXVrJZTJSnVYY1cFmh96+/T7TkDRUn1YkT0BQPxIFaihwi8xFkzO1LAngu3Z+yLp1UPdBcMJaInoA8//fe70B30e9IavA8ekSn1HtsA4b7A/KK5hCizJwjjSXhcJdUWXthmfyhFh9lsOvilQliW9f0RauncjxMltV3daRTxXMPP/gB6bZcvOUtilPSprDLlyU9A8nhn2XHsA/r+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYm7CIvomteqMtcpNlOG+TQbYo1aLT86RrilCIKq7Ys=;
 b=hasGO9eEJKMRvmm5UWyrCJS7+xyV+1hsiLvxeVwZSNxI+ijgOr1q6nm+KVRSKYhGkORosqyulH2o53mboyWmWiNIdOYb2ot0nHPNOIsIH4prRRYXtwdWqpYEAMxFsF3NO3fAapLswwKeCJRw2/4FrR1J+bXQpJvFb46/cMYzJVz7pbD5RfErPQH4ItMTudy/QapbWD4l01I7xuKMQhkwKttYV0dKyu6mfdSxLmxFTb4T7MPUAXqAi578Xn+zkkX2D0Wup3ROIu4H172xo5iZV/EIDHXqc0zH2WQgHLuNGi54BAC/2wnSYXR/u5VkvpVPqW81hh12sba/pgwQzBPwTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYm7CIvomteqMtcpNlOG+TQbYo1aLT86RrilCIKq7Ys=;
 b=KDBhnJ62oehvqM0K7vhAutbAGLGqQBqcyrM7hzEy4LQ/BztUCXDwVJTRP6421UZ0t2/n797ZPQSwJE2nw11oAj1fEnx2Oamg//ixqw3bznlmZfCGjrtFjAacarLCyTGVh6+uWkHmwq7jakZs4k1E9EPqXxpIy1QGGcw/SDcPyxA=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB3PR0402MB3690.eurprd04.prod.outlook.com (2603:10a6:8:c::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Mon, 25 May
 2020 02:46:19 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3%6]) with mapi id 15.20.3021.029; Mon, 25 May 2020
 02:46:19 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] thermal: imx8mm: Add get_trend ops
Thread-Topic: [PATCH] thermal: imx8mm: Add get_trend ops
Thread-Index: AQHWKNOp8EPkl0qqRkG+GoQWiQOYA6i0bHgAgABvx3CAAM7gAIAAy+LwgAGwT5A=
Date:   Mon, 25 May 2020 02:46:19 +0000
Message-ID: <DB3PR0402MB39162E6A876BA54A80B0DCE2F5B30@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1589338689-15700-1-git-send-email-Anson.Huang@nxp.com>
 <fccf4197-d0ca-f313-8f70-000ef4731033@linaro.org>
 <DB3PR0402MB3916B6D11328A036BD479D39F5B50@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <6a4d31e4-8a24-2e9f-aa49-bec8258ead4c@linaro.org>
 <DB3PR0402MB39167D71ED6979FC33D3747DF5B20@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB39167D71ED6979FC33D3747DF5B20@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 90d8048b-5da9-477b-053c-08d80055cd78
x-ms-traffictypediagnostic: DB3PR0402MB3690:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3690CC9CA84CBD2D52B122F8F5B30@DB3PR0402MB3690.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0414DF926F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vO+6HgBpSflHpxN6DAh1ISAjBxqms82raF6IuAROjX8xxGdZG4DQ0KGVKouhZnewMYOlw8IhDAyu0YaLMvBNTsbiHDjvjmbuHZsYg3ZkoSvWXsjc70iP/z81cwLeSVgGSL5qs9Gq0T00jlpgGTQt5qI+KnjsEzxtX7TWQqwPzULDFbgHHQ0+Mv8NlkNiZt1gymolg5rt6XRTeghd2TiQuCc4TKf4nlsLJF3fp1g6Skp6bTFDWoohKDOcHEoEiWBeWqmfv6MKE7QhH+BRAV+Y6chvUkHC/lruqhG/EjEf6pkrQ8yMqtXUBgGnWjh1B4r9Qhe0vTSdgBamjrBsbmm0TFZMLzL6cvXfW1HF8b+FkGlvXDQ1MDw05qe3E7h6eAxBcTZQpyaZGdp4YaBqd1Yj5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(396003)(39860400002)(136003)(366004)(376002)(9686003)(55016002)(4326008)(110136005)(316002)(71200400001)(5660300002)(86362001)(2906002)(6506007)(7696005)(26005)(186003)(53546011)(8936002)(76116006)(66476007)(66946007)(52536014)(44832011)(478600001)(7416002)(8676002)(33656002)(66446008)(64756008)(66556008)(32563001)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ilhPCSOBs3txcVm/GcOncPsvI0/XtQHv9QZGT1CUeiNDInARSXg715IGTbXM71VwE5cs8QTKdS+QQswGGsIt6NFUCTwJJUKDRRzbT5Vyi1dSidY4UveivkTuUgld0sZ1RiBYxLk/0CnQPX3C/7GYGAdB+/ryYHm2jH3Gv8zK2dfl3agmNRrVF8IRlNpyAiXLJUC1W/hEduy8IVJbFsNVCkBmGf/xOJMnZzLS+yHPrCI7vJXB/+LkkII9bGebxt5nS9pI6ss5Xy6jxHC/LMgBnUdE3wkr8H9KESJZhq5Gjp5H8GWnI3947LuUWdce6vmXz6kqqjiAf+rWCwpc681vGVsQJurDII4QO1seRkSPRdgZLGRs3jP//yweoovEhm0YslYdEYRyphuwnSLhN67tPXKVeMSS6DLVbQh7xGhZbcKqxLvFYuo/ryhq3S7KUiKQER9rmAcBCZY0p7xzQtdWCqq41T9YxGLpIApO7FbWKY8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d8048b-5da9-477b-053c-08d80055cd78
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2020 02:46:19.1550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fbH5oysJP1lxGOWRLf3x8MwfJHApd8hf6Q50hP0yQZ72QQwXEqtmHsQd5mLrgM2GovNlc97vmM00OEzNYWepZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3690
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIERhbmllbA0KDQoNCj4gU3ViamVjdDogUkU6IFtQQVRDSF0gdGhlcm1hbDogaW14OG1tOiBB
ZGQgZ2V0X3RyZW5kIG9wcw0KPiANCj4gSGksIERhbmllbA0KPiANCj4gPiBTdWJqZWN0OiBSZTog
W1BBVENIXSB0aGVybWFsOiBpbXg4bW06IEFkZCBnZXRfdHJlbmQgb3BzDQo+ID4NCj4gPiBPbiAy
My8wNS8yMDIwIDAyOjM1LCBBbnNvbiBIdWFuZyB3cm90ZToNCj4gPiA+IEhpLCBEYW5pZWwNCj4g
PiA+DQo+ID4gPg0KPiA+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHRoZXJtYWw6IGlteDhtbTog
QWRkIGdldF90cmVuZCBvcHMNCj4gPiA+Pg0KPiA+ID4+IE9uIDEzLzA1LzIwMjAgMDQ6NTgsIEFu
c29uIEh1YW5nIHdyb3RlOg0KPiA+ID4+PiBBZGQgZ2V0X3RyZW5kIG9wcyBmb3IgaS5NWDhNTSB0
aGVybWFsIHRvIGFwcGx5IGZhc3QgY29vbGluZw0KPiA+ID4+PiBtZWNoYW5pc20sIHdoZW4gdGVt
cGVyYXR1cmUgZXhjZWVkcyBwYXNzaXZlIHRyaXAgcG9pbnQsIHRoZQ0KPiA+ID4+PiBoaWdoZXN0
IGNvb2xpbmcgYWN0aW9uIHdpbGwgYmUgYXBwbGllZCwgYW5kIHdoZW4gdGVtcGVyYXR1cmUgZHJv
cHMNCj4gPiA+Pj4gdG8gbG93ZXIgdGhhbiB0aGUgbWFyZ2luIGJlbG93IHBhc3NpdmUgdHJpcCBw
b2ludCwgdGhlIGxvd2VzdA0KPiA+ID4+PiBjb29saW5nIGFjdGlvbiB3aWxsIGJlIGFwcGxpZWQu
DQo+ID4gPj4NCj4gPiA+PiBZb3UgYXJlIG5vdCBkZXNjcmliaW5nIHdoYXQgaXMgdGhlIGdvYWwg
b2YgdGhpcyBjaGFuZ2UuDQo+ID4gPg0KPiA+ID4gVGhlIGdvYWwgb2YgdGhpcyBjaGFuZ2UgaXMg
dG8gbWFrZSBzdXJlIHdoZW5ldmVyIHRlbXBlcmF0dXJlIGV4Y2VlZHMNCj4gPiA+IHBhc3NpdmUg
dHJpcCBwb2ludCwgdGhlIGhpZ2hlc3QgY29vbGluZyBhY3Rpb24gd2lsbCBiZSBhcHBsaWVkDQo+
ID4gPiBpbW1lZGlhdGVseSwgZS5nLiwgaWYgdGhlcmUgYXJlIG1hbnkgY3B1ZnJlcSBPUFAsIHRo
ZSBkZWZhdWx0DQo+ID4gPiBjb29saW5nIHdpbGwgYmUgc3RlcCBieSBzdGVwLCBpdCB3aWxsIHRh
a2Ugc29tZSBtb3JlIHJvdW5kcyB0byBtYWtlDQo+ID4gPiBjcHVmcmVxIGRyb3AgdG8NCj4gPiBs
b3dlc3QgT1BQLCB3aGlsZSBvbiBpLk1YLCB3ZSBleHBlY3QgdGhlIGNwdWZyZXEgZHJvcCB0byBs
b3dlc3QgT1BQDQo+ID4gaW1tZWRpYXRlbHkuDQo+ID4NCj4gPiBXaGF0ZXZlciB0aGUgc2xvcGUg
b2YgdGhlIHRlbXBlcmF0dXJlIGluY3JlYXNlPw0KPiANCj4gWWVzLg0KPiANCj4gPg0KPiA+ID4+
IElJVUMsIHRoZSByZXN1bHRpbmcgY2hhbmdlIHdpbGwgYmUgYW4gb24vb2ZmIGFjdGlvbi4gVGhl
IHRoZXJtYWwNCj4gPiA+PiB6b25lIGlzIG1pdGlnYXRlZCB3aXRoIHRoZSBoaWdoZXN0IGNvb2xp
bmcgZWZmZWN0LCBzbyB0aGUgbG93ZXN0DQo+ID4gPj4gT1BQLCB0aGVuIHRoZSB0ZW1wZXJhdHVy
ZSB0cmVuZCBpcyBzdGFibGUgdW50aWwgaXQgZ29lcyBiZWxvdyB0aGUNCj4gPiA+PiB0cmlwIC0g
bWFyZ2luIHdoZXJlIHRoZSBtaXRpZ2F0aW9uIGlzIHN0b3BwZWQuDQo+ID4gPg0KPiA+ID4gWWVz
LCB5b3VyIHVuZGVyc3RhbmRpbmcgaXMgY29ycmVjdGx5LCBvbmNlIHRoZSB0ZW1wZXJhdHVyZSBl
eGNlZWRzDQo+ID4gPiBwYXNzaXZlIHRyaXAgcG9pbnQsIHRoZSBoaWdoZXN0IGNvb2xpbmcgYWN0
aW9uIHdpbGwgYmUgYXBwbGllZA0KPiA+ID4gaW1tZWRpYXRlbHkgYW5kIHRoZW4gaXQgd2lsbCBi
ZSBzdGFibGUgdGhlcmUgdW50aWwgdGVtcGVyYXR1cmUgZHJvcA0KPiA+ID4gdG8gdHJpcCAtIG1h
cmdpbiwgdGhlbiB0aGUgY29vbGluZyBhY3Rpb24gd2lsbCBiZSBjYW5jZWxsZWQsIHRoZQ0KPiA+
ID4gbWFyZ2luIGlzIHRvIGF2b2lkDQo+ID4gdGhlIGJhY2sgYW5kIGZvcnRoIG5lYXIgdGhlIHBh
c3NpdmUgdHJpcCBwb2ludC4NCj4gPiA+DQo+ID4gPj4NCj4gPiA+PiBFeGNlcHQsIEknbSBtaXNz
aW5nIHNvbWV0aGluZywgc2V0dGluZyBhIHRyaXAgcG9pbnQgd2l0aCBhIDEwMDAwDQo+ID4gPj4g
aHlzdGVyZXNpcyBhbmQgYSBjb29saW5nIG1hcCBtaW4vbWF4IHNldCB0byB0aGUgaGlnaGVzdCBv
cHAgd2lsbA0KPiA+ID4+IHJlc3VsdCBvbg0KPiA+IHRoZSBzYW1lLg0KPiA+ID4NCj4gPiA+IFll
cyBzZXR0aW5nIGNvb2xpbmcgbWFwIG1pbi9tYXggY29vbGluZyBzdGF0ZSB0byBoaWdoZXN0IE9Q
UCB3aWxsDQo+ID4gPiBtYWtlIHRoZSBoaWdoZXN0IGNvb2xpbmcgYWN0aW9uIGFwcGxpZWQgaW1t
ZWRpYXRlbHksIGFuZCB0byBoYXZlIHRoZQ0KPiA+ID4gZnVuY3Rpb24gb2YgY29vbGluZyBhY3Rp
b24gYmVpbmcgY2FuY2VsbGVkIHdoZW4gdGVtcGVyYXR1cmUgZHJvcHMgdG8NCj4gPiA+IHRyaXAg
LSBtYXJnaW4sIEkgaGF2ZSB0byBkZWZpbmUgYW5vdGhlciB0cmlwIHBvaW50LCBzYXkgcGFzc2l2
ZSB0cmlwDQo+ID4gPiBwb2ludCBpcyA4NTAwMCwgYW5kIGNvb2xpbmcgbWFwIG1pbi9tYXggc2V0
IHRvIGhpZ2hlc3QgT1BQIGluDQo+ID4gPiBwYXNzaXZlIHRyaXAgcG9pbnQgdGhlbiBhZGQgYW5v
dGhlciB0cmlwIHBvaW50IG5hbWVkICJhY3RpdmUiIHdpdGgNCj4gPiA+IDc1MDAwLCBhbmQNCj4g
PiB3aXRob3V0IGFueSBjb29saW5nIG1hcCBpbiBpdCwgcmlnaHQ/DQo+ID4NCj4gPiBNYXkgYmUg
SSBtaXN1bmRlcnN0b29kIGJ1dCBvbmx5IHRoZSBjaGFuZ2UgYXMgYmVsb3cgaXMgbmVlZGVkLiBO
byBuZWVkDQo+ID4gdG8gYWRkIGEgdHJpcCBwb2ludCwgZXNwZWNpYWxseSBhbiAnYWN0aXZlJyB0
cmlwIHdoaWNoIGlzIGEgZm9yIGFuDQo+ID4gYWN0aXZlIGNvb2xpbmcgZGV2aWNlIGxpa2UgYSBm
YW4uDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUv
aW14OG1tLmR0c2kNCj4gPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS5k
dHNpDQo+ID4gaW5kZXggY2M3MTUyZWNlZGQ5Li5iZWEyNjNiZDA2YjQgMTAwNjQ0DQo+ID4gLS0t
IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLmR0c2kNCj4gPiArKysgYi9h
cmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0uZHRzaQ0KPiA+IEBAIC0yMzEsMTAg
KzIzMSwxMCBAQCBjb29saW5nLW1hcHMgew0KPiA+ICAJCQkJbWFwMCB7DQo+ID4gIAkJCQkJdHJp
cCA9IDwmY3B1X2FsZXJ0MD47DQo+ID4gIAkJCQkJY29vbGluZy1kZXZpY2UgPQ0KPiA+IC0JCQkJ
CQk8JkE1M18wIFRIRVJNQUxfTk9fTElNSVQNCj4gPiBUSEVSTUFMX05PX0xJTUlUPiwNCj4gPiAt
CQkJCQkJPCZBNTNfMSBUSEVSTUFMX05PX0xJTUlUDQo+ID4gVEhFUk1BTF9OT19MSU1JVD4sDQo+
ID4gLQkJCQkJCTwmQTUzXzIgVEhFUk1BTF9OT19MSU1JVA0KPiA+IFRIRVJNQUxfTk9fTElNSVQ+
LA0KPiA+IC0JCQkJCQk8JkE1M18zIFRIRVJNQUxfTk9fTElNSVQNCj4gPiBUSEVSTUFMX05PX0xJ
TUlUPjsNCj4gPiArCQkJCQkJPCZBNTNfMCAyIDI+LA0KPiA+ICsJCQkJCQk8JkE1M18xIDIgMj4s
DQo+ID4gKwkJCQkJCTwmQTUzXzIgMiAyPiwNCj4gPiArCQkJCQkJPCZBNTNfMyAyIDI+DQo+ID4g
IAkJCQl9Ow0KPiA+ICAJCQl9Ow0KPiA+ICAJCX07DQo+ID4NCj4gPg0KPiANCj4gVGhhbmtzLCBJ
IHdpbGwgaGF2ZSBhIHRyeSB0byBzZWUgaWYgaXQgbWVldHMgb3VyIGV4cGVjdGF0aW9uLg0KDQpJ
IHRyaWVkIG1vZGlmeWluZyB0aGUgbWluL21heCB0byAnMicgaW4gY29vbGluZyBtYXAsIGl0IHdv
cmtzIHRoYXQgd2hlbmV2ZXIgY29vbGluZw0KYWN0aW9uIGlzIG5lZWRlZCwgdGhlIG1heCBjb29s
aW5nIGFjdGlvbiB3aWxsIGJlIGFwcGxpZWQuIEJ1dCBJIGFsc28gbm90aWNlZCBzb21lIGJlaGF2
aW9ycw0Kd2hpY2ggTk9UIGFzIGV4cGVjdGVkOg0KDQoxLiB0byBlYXN5IHRoZSB0ZXN0LCBJIGVu
YWJsZSB0aGUgIiBDT05GSUdfVEhFUk1BTF9XUklUQUJMRV9UUklQUyIsIGFuZCBqdXN0IG1vZGlm
eSB0aGUNCnBhc3NpdmUgdHJpcCB0aHJlc2hvbGQgdG8gdHJpZ2dlciB0aGUgY29vbGluZyBhY3Rp
b24sIHRoaXMgaXMgbXVjaCBtb3JlIGVhc3kgdGhlbiBwdXR0aW5nIHRoZSBib2FyZA0KaW50byBh
biBvdmVuIHRvIGluY3JlYXNlIHRoZSBTb0MgdGVtcGVyYXR1cmUgb3IgcnVubmluZyBtYW55IGhp
Z2ggbG9hZGluZyB0ZXN0IHRvIGluY3JlYXNlIHRoZSB0ZW1wZXJhdHVyZSwNCmJ1dCB3aGVuIEkg
bW9kaWZ5IHRoZSBwYXNzaXZlIHRyaXAgdGhyZXNob2xkIHRvIGJlIGxvd2VyIHRoYW4gY3VycmVu
dCB0ZW1wZXJhdHVyZSwgdGhlIGNvb2xpbmcgYWN0aW9uIGlzIE5PVA0KdHJpZ2dlcmVkIGltbWVk
aWF0ZWx5LCBpdCBpcyBiZWNhdXNlIHRoZSBkZWZhdWx0IHN0ZXBfd2lzZSBnb3Zlcm5vciB3aWxs
IE5PVCB0cmlnZ2VyIHRoZSBjb29saW5nIGFjdGlvbiB3aGVuDQp0aGUgdHJlbmQgaXMgVEhFUk1B
TF9UUkVORF9TVEFCTEUuDQpCdXQgd2hhdCBleHBlY3RlZCBpcywgd2hlbiB0aGUgdGVtcGVyYXR1
cmUgaXMgZXhjZWVkIHRoZSBwYXNzaXZlIHRyaXAgdGhyZXNob2xkLCB0aGUgY29vbGluZyBhY3Rp
b24gY2FuIGJlDQp0cmlnZ2VyZWQgaW1tZWRpYXRlbHkgbm8gbWF0dGVyIHRoZSB0cmVuZCBpcyBz
dGFibGUgb3IgcmFpc2luZy4gVGhhdCBtZWFucyB3ZSBoYXZlIHRvIGltcGxlbWVudCBvdXIgb3du
DQouZ2V0X3RyZW5kIGNhbGxiYWNrPw0KDQoyLiBObyBtYXJnaW4gZm9yIHJlbGVhc2luZyB0aGUg
Y29vbGluZyBhY3Rpb24sIGZvciBleGFtcGxlLCBpZiBjb29saW5nIGFjdGlvbiBpcyB0cmlnZ2Vy
ZWQsIHdoZW4gdGhlIHRlbXBlcmF0dXJlDQpkcm9wcyBiZWxvdyB0aGUgcGFzc2l2ZSB0cmlwIHRo
cmVzaG9sZCwgdGhlIGNvb2xpbmcgYWN0aW9uIHdpbGwgYmUgY2FuY2VsbGVkIGltbWVkaWF0ZWx5
LCBpZiBTb0Mga2VlcHMgcnVubmluZw0KYXQgZnVsbCBwZXJmb3JtYW5jZSwgdGhlIHRlbXBlcmF0
dXJlIHdpbGwgaW5jcmVhc2UgdmVyeSBzb29uLCB3aGljaCBtYXkgY2F1c2UgdGhlIFNvQyBrZWVw
IHRyaWdnZXJpbmcvY2FuY2VsbGluZw0KdGhlIGNvb2xpbmcgYWN0aW9uIGFyb3VuZCB0aGUgcGFz
c2l2ZSB0cmlwIHRocmVzaG9sZC4gSWYgdGhlcmUgaXMgYSBtYXJnaW4sIHRoZSBzaXR1YXRpb24g
d2lsbCBiZSBtdWNoIGJldHRlci4NCg0KRG8geW91IGhhdmUgYW55IGlkZWEvY29tbWVudCBhYm91
dCB0aGVtPw0KDQpUaGFua3MsDQpBbnNvbg0K
