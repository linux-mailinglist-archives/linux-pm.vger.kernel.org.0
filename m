Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 929CB186809
	for <lists+linux-pm@lfdr.de>; Mon, 16 Mar 2020 10:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730442AbgCPJk5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Mar 2020 05:40:57 -0400
Received: from mail-eopbgr150053.outbound.protection.outlook.com ([40.107.15.53]:17315
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730231AbgCPJk5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 16 Mar 2020 05:40:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D9bBb7WQ2itYItnjSBm4jKcgmiLe3UdyNN1EfGwPsIQQr4VlFtQ4LGMYQKNpVeBIi7zuZJqGzGzlvyKYLx2hflOoEh63QJXlN9yyza4UlEiUKwxOrlh0yZTAmIiUE4fHTcnfMg89tSMOkxsk93E+AO1v1Jkri0jiikJpdn84iOHU5Kcy8x2l6whekN+D3wdLT5UTuvTyyz1S7fQSQjpLYR4ZOMatdWFOfjjuyqfBetfq7BLdAhvARWfe5g6NWOYxoMHysR20WFc3HA+lMzhqm9S+EakJZP9sD0qfqhTT9l/95uKjH+6IsPKGo/eM5W5wWjH/UtmnKyBPsLRmjkmT+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYcH6Ek+eSPa2IDUbUCvfzONDGKGmIk0fko9FvfEc/8=;
 b=CYja+UwfMyqzzVp3WljN+BPLA3OLk2p5xZ+3PXFk/hC4tDqPiss1SeRWaxPtdw7b6gHwjTCT1ylUVTx9HZmVyD6U8rqGRs0yjbZiRq3+69s5lBvZW/KhXoztWFcDVu0RCm2usKd5a4Igoy9D2176DhAbpSxI2mJ1tN2guq3WEFibY4I1KJUuDgV6nYOvNAYVs/Q3uv5B+RlMsSuicDsZ+sBY9Gngv966Ek/jSjSHquYBlUJl1VSAZpsh71sNrKV3bFH28wOVH4/8bzGU5x1MCTcwqg0By9yXkMFtRGp+/QZahWoKBBAM+YdVRK5eOLYp7Xl8i4pbhuQcM3x/Vg9HzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYcH6Ek+eSPa2IDUbUCvfzONDGKGmIk0fko9FvfEc/8=;
 b=sVPE5uD8t3b3RT2nR3dBnp9P91WIqiztikvVCUdnBgERPmxZaf4BgI/uUtSmRl4Adg6Kt13du2b/+x0yvoUHOPoTDVdZFYzJC6JsU95ll6tuYpAvq1XREVfU5JJ5jlJxRQi2aFMXYpCxqANtBPCKK9ghinroYYFxw1uGedfe+oc=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3900.eurprd04.prod.outlook.com (52.134.71.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.13; Mon, 16 Mar 2020 09:40:52 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b%7]) with mapi id 15.20.2814.021; Mon, 16 Mar 2020
 09:40:52 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Shawn Guo <shawnguo@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
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
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V3 1/7] firmware: imx: Add stubs for !CONFIG_IMX_SCU case
Thread-Topic: [PATCH V3 1/7] firmware: imx: Add stubs for !CONFIG_IMX_SCU case
Thread-Index: AQHV9av62LAReQhoZkKZ9LnT5dFdbahARTIAgAopwQCAACFfgIAABHaAgAADEYCAAAR+AIAASuWQgAAKpACAAABIoIAABUuAgAABn+CAAAKDgIAABdZw
Date:   Mon, 16 Mar 2020 09:40:52 +0000
Message-ID: <DB3PR0402MB39169528B3FF39E23C7A90FCF5F90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20200316005219.GD17221@dragon>
 <AM0PR04MB44819E4A9E027F1555C33D0B88F90@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <20200316030744.GC17221@dragon>
 <AM0PR04MB44817A48746601EADA4E06BC88F90@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <20200316033447.GE17221@dragon>
 <DB3PR0402MB3916DA9F0F175B9D2E9E684FF5F90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20200316084056.GG4518@piout.net>
 <DB3PR0402MB391663DB37A8D241092AD708F5F90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20200316090053.GH4518@piout.net>
 <DB3PR0402MB391683A05820920158DFDA77F5F90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20200316091541.GI4518@piout.net>
In-Reply-To: <20200316091541.GI4518@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 31c6ab02-483f-4042-91dd-08d7c98e1e2d
x-ms-traffictypediagnostic: DB3PR0402MB3900:|DB3PR0402MB3900:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3900703A9650AF7157C38935F5F90@DB3PR0402MB3900.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 03449D5DD1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(199004)(4326008)(2906002)(76116006)(71200400001)(52536014)(6916009)(64756008)(86362001)(66556008)(7416002)(66946007)(81166006)(66446008)(66476007)(33656002)(7696005)(186003)(54906003)(8676002)(478600001)(81156014)(55016002)(8936002)(9686003)(5660300002)(26005)(6506007)(316002)(53546011)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3900;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HpX8Rr3Z4W9BpQu19ufXyio0zmgQqaTWH6e2aVb9Wbt9bVRcZyMvDLshZlpucvZ7R+Zi3+DbSU1Mna1gQNzVGpNtWyzuxbSo4uZJWZ7u2WrwqMyuM9BeYhh+fgHL/L+UT5WNJqKyc2Zy05NAXJv585cbTNGMkkvU3tBHkghahZGiO0osm5yuuD2GUeZ9IgIbR1beomwKX81xj7W/syLK6m8eb2Dw2QNJjRU4CfQ7tFoWfogi5fzawhD5Dpr+KRlOPxn6ykyVUG93HVKrpXK0sEH6cirLK+vdBW7AivIHkzuQ1XjKdCxPxYj+vEx9w1u796nJgsYnvLYXGqj1P37z1eu+WAjYb72F9g/xJtSynmhMjSQylebQu5Za1YSAxvUxxYx31y3e+sXKbrf7ktpyKhPXPkXsQgCgau3MwG9EdFy1h89QkX/y3Nc5tRoj92PX
x-ms-exchange-antispam-messagedata: MQc7LacyhxUFQFNsHqgHfPnQiVCS8NKghVf+mpD+jgd2kOSFe9Ky+XBZD9SpBvhm85ktqguUjb1xCOwoT7TJDhUnX9IHmd2ShCX0Zv8x6L6GI31gKmtRs856VejAfJ5sc/0UD1pl8EC44QqbPs92GQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31c6ab02-483f-4042-91dd-08d7c98e1e2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2020 09:40:52.3347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i+kRr4h0DYdESxKo6DU0yBrBfeyVGy+Aws5hxcaRjdKWZZbzVsAb6CFAjxqncKpobWMGdCSy0E36Pal4Vc0X2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3900
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIEFsZXhhbmRyZQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFs
ZXhhbmRyZSBCZWxsb25pIDxhbGV4YW5kcmUuYmVsbG9uaUBib290bGluLmNvbT4NCj4gU2VudDog
TW9uZGF5LCBNYXJjaCAxNiwgMjAyMCA1OjE2IFBNDQo+IFRvOiBBbnNvbiBIdWFuZyA8YW5zb24u
aHVhbmdAbnhwLmNvbT4NCj4gQ2M6IFNoYXduIEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz47IFBl
bmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPjsNCj4gcy5oYXVlckBwZW5ndXRyb25peC5kZTsga2Vy
bmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207DQo+IGRtaXRyeS50b3Jva2hv
dkBnbWFpbC5jb207IGEuenVtbW9AdG93ZXJ0ZWNoLml0OyBydWkuemhhbmdAaW50ZWwuY29tOw0K
PiBkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnOyBhbWl0Lmt1Y2hlcmlhQHZlcmR1cmVudC5jb207
IHdpbUBsaW51eC0NCj4gd2F0Y2hkb2cub3JnOyBsaW51eEByb2Vjay11cy5uZXQ7IERhbmllbCBC
YWx1dGEgPGRhbmllbC5iYWx1dGFAbnhwLmNvbT47DQo+IGdyZWdraEBsaW51eGZvdW5kYXRpb24u
b3JnOyBsaW51eEByZW1wZWwtcHJpdmF0LmRlOyB0Z2x4QGxpbnV0cm9uaXguZGU7DQo+IG0uZmVs
c2NoQHBlbmd1dHJvbml4LmRlOyBhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb207DQo+
IGFybmRAYXJuZGIuZGU7IHJvbmFsZEBpbm5vdmF0aW9uLmNoOyBrcnprQGtlcm5lbC5vcmc7IHJv
YmhAa2VybmVsLm9yZzsNCj4gTGVvbmFyZCBDcmVzdGV6IDxsZW9uYXJkLmNyZXN0ZXpAbnhwLmNv
bT47IEFpc2hlbmcgRG9uZw0KPiA8YWlzaGVuZy5kb25nQG54cC5jb20+OyBsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1pbnB1dEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBydGNAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiB3YXRjaGRvZ0B2Z2VyLmtl
cm5lbC5vcmc7IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggVjMgMS83XSBmaXJtd2FyZTogaW14OiBBZGQgc3R1YnMgZm9yICFDT05GSUdfSU1Y
X1NDVQ0KPiBjYXNlDQo+IA0KPiBPbiAxNi8wMy8yMDIwIDA5OjA4OjUzKzAwMDAsIEFuc29uIEh1
YW5nIHdyb3RlOg0KPiA+ID4gV2h5IGRvIHlvdSBhYnNvbHV0ZWx5IG5lZWQgdG8gY29tcGlsZSB0
aGVtIGluZGVwZW5kZW50bHk/IEZyb20gYQ0KPiA+ID4gY29kZSBjb3ZlcmFnZSBwb2ludCBvZiB2
aWV3LCBoYXZpbmc6DQo+ID4gPg0KPiA+ID4gQ09NUElMRV9URVNUPXkNCj4gPiA+IENPTkZJR19J
TVhfU0NVPXkNCj4gPiA+DQo+ID4gPiBpcyBlbm91Z2ggdG8gc2VsZWN0IGFuZCBjb21waWxlIHRo
ZSByZW1haW5pbmcgZHJpdmVycy4NCj4gPg0KPiA+IFdoYXQgSSBtZWFudCBpcyBmb3IgYmVsb3cg
Y2FzZSwgbGlrZSB1c2luZyBvdGhlciBhcmNoIGNvbmZpZyB3aGljaA0KPiA+IGRvZXMgTk9UIGhh
dmUgQ09ORklHX0lNWF9TQ1Ugc2VsZWN0ZWQsIE9OTFkgd2l0aCBDT01QSUxFX1RFU1QNCj4gPiBz
ZWxlY3RlZCwgYWRkaW5nIHN0dWJzIGZvciBJTVhfU0NVIEFQSXMgY2FuIGZpeCBzdWNoIHNjZW5h
cmlvLg0KPiA+DQo+ID4gQ09NUElMRV9URVNUPXkNCj4gPiBDT05GSUdfSU1YX1NDVT1uDQo+ID4N
Cj4gDQo+IFdoeSBpcyB0aGF0IGFuIGlzc3VlPyBJZiB0aGV5IGRvbid0IGhhdmUgSU1YX1NDVSBz
ZWxlY3RlZCwgdGhlbiB0aGUgb3RoZXINCj4gU0NVIGRyaXZlciBhcmUgbm90IHNlbGVjdGVkIGVp
dGhlciwgaGF2aW5nIHN0dWJzIGRvZXNuJ3QgY2hhbmdlIHRoYXQgeW91IHdpbGwNCj4gaGF2ZSB0
byBzZWxlY3QgYXQgbGVhc3Qgb25lIG9wdGlvbi4gUGxlYXNlIGV4cGxhaW4gd2hhdCBpcyB0aGUg
aXNzdWUgdGhhdCBpcyBub3QNCj4gc29sdmVkIGhlcmUuDQoNCk9LLCB3aGF0IEkgdGhvdWdodCBp
cyBldmVuIHdpdGhvdXQgSU1YX1NDVSBzZWxlY3RlZCwgb3RoZXIgU0NVIGRyaXZlcnMgc3RpbGwg
Y2FuIGJlDQpzZWxlY3RlZCBmb3IgYnVpbGQgdGVzdCBhZnRlciBhZGRpbmcgIkNPTVBJTEVfVEVT
VCIgdG8gdGhlIGtjb25maWcsIGxpa2UgYmVsb3csIGlmDQp3aXRob3V0IElNWF9TQ1UgQVBJIHN0
dWJzLCB0aGUgIkNPTVBJTEVfVEVTVCIgY2FuIE5PVCBiZSBhZGRlZCB0byBTQ1UgZHJpdmVycw0K
dG8gZW5hYmxlIGJ1aWxkIHRlc3QsIHNvIEkgdGhpbmsgdGhlIElNWF9TQ1UgQVBJIHN0dWJzIHNo
b3VsZCBiZSBhZGRlZD8NCg0KY29uZmlnIEtFWUJPQVJEX0lNWF9TQ19LRVkNCiAgICB0cmlzdGF0
ZSAiSU1YIFNDVSBLZXkgRHJpdmVyIg0KICAgIGRlcGVuZHMgb24gSU1YX1NDVSB8fCBDT01QSUxF
X1RFU1QNCg0KdGhhbmtzLA0KQW5zb24NCg==
