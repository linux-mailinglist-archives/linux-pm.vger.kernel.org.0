Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDB431877C0
	for <lists+linux-pm@lfdr.de>; Tue, 17 Mar 2020 03:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgCQCSP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Mar 2020 22:18:15 -0400
Received: from mail-db8eur05on2062.outbound.protection.outlook.com ([40.107.20.62]:43968
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726250AbgCQCSP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 16 Mar 2020 22:18:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MkAMG0feb/BmKLoE78JMVJcbVyWN7psqt064J9R7nBVmTOO4rF1ttd+BlCGzwhWJiCwgA8uegSFC+DLMWYFv26CAowJcHIioc7j9au1MS/pZgfbN/qG6bwc0v/Le3+Fzw0GdPpA/w0dJCsj6XInXOlzxAXvcVraxBGWVI9nX92shcT0EgOwlbh0KMZS1760ymuaOo8NHX4KvwpeaCiDI4sgvfhXSc7AXQez/tyn5ySUGtslBZjtBT9U5OqKPjpVoQfQ6NVml5XRR4mHDUbgK0JxlOsmuGM1oNX995bFOjSDqNgu3sIpREtXzI/rg0mZXXC6n43AOXtXtcrIpcG06Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7K14LEJ6sd10QVJzaWfYp9Yj8Dk7ko9sl+emhNLGwIU=;
 b=e8egMXqW7KMGCa5jxufohTJcBdXj31A/J2Y5DL4y65GGvXHPhlTkdUfBPCQUW4h3pytNbGJKKnGV7NammU04hCeME0bBxl1r1JLKGOUVuf2dMTaKRG43yYvZ7h4zCAffJGmchL39L4iSeVDVOI/9BfmeEZ6dwSgrlQErarbdbyTAEgXgfTsE2vZFyX0jv/0D5Hj9DSyF3KmzD4Jn433wIOrEmet+AB7V/FRIxxLdoRc5DiI8I9LTIbShXAMu/ewHjT5/oPZPipwkP9EoHa0FbZWenv4o+AcFUQaieFJVwwwsnwLEHJRdRJmt5XwJ1maqyg6NlhPRb46XZzuq/iU/Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7K14LEJ6sd10QVJzaWfYp9Yj8Dk7ko9sl+emhNLGwIU=;
 b=hBipPsTgsB30NtJxC6tsxW9cBpiVUpmtiofMH/WOAZyTglyhhnT2l+qHP8cxRTuWlMQA00rYxkXgfN4dDU3yX7ce6bwsdv/8klvwy+KyNoTq9z5DOBuNKJ6UBhRaHPzq+ZPRZbzy4wRhHktS2mEWGf9+ptAiz7gVR/wR+8HyiTg=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4145.eurprd04.prod.outlook.com (52.134.90.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.16; Tue, 17 Mar 2020 02:18:07 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc%7]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 02:18:07 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Shawn Guo <shawnguo@kernel.org>,
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
Thread-Index: AQHV9av6lP0y7UryDUCSkdoJ2q6AXKhARRTAgAop3wCAACC+IIAABReAgAACi8CAAAUEAIAAS0uAgAAKPgCAAADnAIAABKyAgAACPICAAAHmgIAABwkAgAEV3aA=
Date:   Tue, 17 Mar 2020 02:18:07 +0000
Message-ID: <AM0PR04MB4481A54C639FD1D45098302088F60@AM0PR04MB4481.eurprd04.prod.outlook.com>
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
 <DB3PR0402MB39169528B3FF39E23C7A90FCF5F90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB39169528B3FF39E23C7A90FCF5F90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f90fa381-0cf1-4ba6-c8b0-08d7ca196ea2
x-ms-traffictypediagnostic: AM0PR04MB4145:|AM0PR04MB4145:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB41452060FEBA42D7B81D5A7088F60@AM0PR04MB4145.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0345CFD558
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(136003)(346002)(366004)(376002)(199004)(71200400001)(9686003)(4326008)(186003)(53546011)(316002)(7416002)(54906003)(2906002)(52536014)(110136005)(33656002)(55016002)(8936002)(26005)(64756008)(86362001)(7696005)(81156014)(478600001)(66446008)(76116006)(66476007)(6506007)(66946007)(5660300002)(8676002)(44832011)(81166006)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4145;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QZ1xC6g20MSfhMOzyShfMophmcDi6cdnHqyw9x4BbScXs+uip/HYdIVsdq5BYBlWHqCHro9uT/okZvn2KPZ1fbRK3JCao0XrW2CqYa08bUKdoiB+2MP+EbYxGop0lPKAOja31hAqjacmmcH5oqveFFsPQXVnL+Dqf1U/xc1lXfdpHFInL3YWC86QW5Xo9ZD1KBooSd160z2xylj6weCO2MCF+Qc2DKAZjttwMEyHKjCXDbDF2Kq4s2+PThS+xR3u62otN60+k7JF+Uh6WwhRhHLacFxbBsGMra2/9W35TN/llZgt38EAGEb/1iFWXAhRa9NL7RAfjB2lOsrHdUuNtxPFOucCxwLcHnluzPgYE29oEP82vOVqwrWxG2ZUHJya3ZNhM1AKcBzRbE/2+gqwbQN74izHJ/7dawUdSGbOVCHCIX0x0qtEk+Qw3JwCDngX
x-ms-exchange-antispam-messagedata: 2FmPbQCGFsO2PfoE21lXKsoi2HUZNuT+0RnkmcKmRu2Bs+4CgLeiMUnij/JyTSfmsxcxZFNjKev4wV41ena9UVotI2B4IcTKIXowbMiFhqeSE+jLDImueKjVGE8lKx3IhH30F48HiB0WDfMJQBpyQA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f90fa381-0cf1-4ba6-c8b0-08d7ca196ea2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2020 02:18:07.4290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Wsz9E0LiKuSMWQ9kT2QfbJpBuzhE2FVy9BktSTTs83Syi/QEmcO3QyDGNV/cjc2RYYvX8oBryrEt8/pk3dHtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4145
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

PiBTdWJqZWN0OiBSRTogW1BBVENIIFYzIDEvN10gZmlybXdhcmU6IGlteDogQWRkIHN0dWJzIGZv
ciAhQ09ORklHX0lNWF9TQ1UNCj4gY2FzZQ0KPiANCj4gSGksIEFsZXhhbmRyZQ0KPiANCj4gPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IEFsZXhhbmRyZSBCZWxsb25pIDxh
bGV4YW5kcmUuYmVsbG9uaUBib290bGluLmNvbT4NCj4gPiBTZW50OiBNb25kYXksIE1hcmNoIDE2
LCAyMDIwIDU6MTYgUE0NCj4gPiBUbzogQW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+
DQo+ID4gQ2M6IFNoYXduIEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz47IFBlbmcgRmFuIDxwZW5n
LmZhbkBueHAuY29tPjsNCj4gPiBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0
cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsNCj4gPiBkbWl0cnkudG9yb2tob3ZAZ21haWwu
Y29tOyBhLnp1bW1vQHRvd2VydGVjaC5pdDsNCj4gcnVpLnpoYW5nQGludGVsLmNvbTsNCj4gPiBk
YW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnOyBhbWl0Lmt1Y2hlcmlhQHZlcmR1cmVudC5jb207IHdp
bUBsaW51eC0NCj4gPiB3YXRjaGRvZy5vcmc7IGxpbnV4QHJvZWNrLXVzLm5ldDsgRGFuaWVsIEJh
bHV0YQ0KPiA+IDxkYW5pZWwuYmFsdXRhQG54cC5jb20+OyBncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZzsNCj4gPiBsaW51eEByZW1wZWwtcHJpdmF0LmRlOyB0Z2x4QGxpbnV0cm9uaXguZGU7IG0u
ZmVsc2NoQHBlbmd1dHJvbml4LmRlOw0KPiA+IGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVs
LmNvbTsNCj4gPiBhcm5kQGFybmRiLmRlOyByb25hbGRAaW5ub3ZhdGlvbi5jaDsga3J6a0BrZXJu
ZWwub3JnOyByb2JoQGtlcm5lbC5vcmc7DQo+ID4gTGVvbmFyZCBDcmVzdGV6IDxsZW9uYXJkLmNy
ZXN0ZXpAbnhwLmNvbT47IEFpc2hlbmcgRG9uZw0KPiA+IDxhaXNoZW5nLmRvbmdAbnhwLmNvbT47
IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtDQo+ID4ga2VybmVs
QHZnZXIua2VybmVsLm9yZzsgbGludXgtaW5wdXRAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4g
PiBydGNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0K
PiA+IHdhdGNoZG9nQHZnZXIua2VybmVsLm9yZzsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhw
LmNvbT4NCj4gPiBTdWJqZWN0OiBSZTogW1BBVENIIFYzIDEvN10gZmlybXdhcmU6IGlteDogQWRk
IHN0dWJzIGZvcg0KPiA+ICFDT05GSUdfSU1YX1NDVSBjYXNlDQo+ID4NCj4gPiBPbiAxNi8wMy8y
MDIwIDA5OjA4OjUzKzAwMDAsIEFuc29uIEh1YW5nIHdyb3RlOg0KPiA+ID4gPiBXaHkgZG8geW91
IGFic29sdXRlbHkgbmVlZCB0byBjb21waWxlIHRoZW0gaW5kZXBlbmRlbnRseT8gRnJvbSBhDQo+
ID4gPiA+IGNvZGUgY292ZXJhZ2UgcG9pbnQgb2YgdmlldywgaGF2aW5nOg0KPiA+ID4gPg0KPiA+
ID4gPiBDT01QSUxFX1RFU1Q9eQ0KPiA+ID4gPiBDT05GSUdfSU1YX1NDVT15DQo+ID4gPiA+DQo+
ID4gPiA+IGlzIGVub3VnaCB0byBzZWxlY3QgYW5kIGNvbXBpbGUgdGhlIHJlbWFpbmluZyBkcml2
ZXJzLg0KPiA+ID4NCj4gPiA+IFdoYXQgSSBtZWFudCBpcyBmb3IgYmVsb3cgY2FzZSwgbGlrZSB1
c2luZyBvdGhlciBhcmNoIGNvbmZpZyB3aGljaA0KPiA+ID4gZG9lcyBOT1QgaGF2ZSBDT05GSUdf
SU1YX1NDVSBzZWxlY3RlZCwgT05MWSB3aXRoIENPTVBJTEVfVEVTVA0KPiA+ID4gc2VsZWN0ZWQs
IGFkZGluZyBzdHVicyBmb3IgSU1YX1NDVSBBUElzIGNhbiBmaXggc3VjaCBzY2VuYXJpby4NCj4g
PiA+DQo+ID4gPiBDT01QSUxFX1RFU1Q9eQ0KPiA+ID4gQ09ORklHX0lNWF9TQ1U9bg0KPiA+ID4N
Cj4gPg0KPiA+IFdoeSBpcyB0aGF0IGFuIGlzc3VlPyBJZiB0aGV5IGRvbid0IGhhdmUgSU1YX1ND
VSBzZWxlY3RlZCwgdGhlbiB0aGUNCj4gPiBvdGhlciBTQ1UgZHJpdmVyIGFyZSBub3Qgc2VsZWN0
ZWQgZWl0aGVyLCBoYXZpbmcgc3R1YnMgZG9lc24ndCBjaGFuZ2UNCj4gPiB0aGF0IHlvdSB3aWxs
IGhhdmUgdG8gc2VsZWN0IGF0IGxlYXN0IG9uZSBvcHRpb24uIFBsZWFzZSBleHBsYWluIHdoYXQN
Cj4gPiBpcyB0aGUgaXNzdWUgdGhhdCBpcyBub3Qgc29sdmVkIGhlcmUuDQo+IA0KPiBPSywgd2hh
dCBJIHRob3VnaHQgaXMgZXZlbiB3aXRob3V0IElNWF9TQ1Ugc2VsZWN0ZWQsIG90aGVyIFNDVSBk
cml2ZXJzIHN0aWxsDQo+IGNhbiBiZSBzZWxlY3RlZCBmb3IgYnVpbGQgdGVzdCBhZnRlciBhZGRp
bmcgIkNPTVBJTEVfVEVTVCIgdG8gdGhlIGtjb25maWcsDQo+IGxpa2UgYmVsb3csIGlmIHdpdGhv
dXQgSU1YX1NDVSBBUEkgc3R1YnMsIHRoZSAiQ09NUElMRV9URVNUIiBjYW4gTk9UIGJlDQo+IGFk
ZGVkIHRvIFNDVSBkcml2ZXJzIHRvIGVuYWJsZSBidWlsZCB0ZXN0LCBzbyBJIHRoaW5rIHRoZSBJ
TVhfU0NVIEFQSSBzdHVicw0KPiBzaG91bGQgYmUgYWRkZWQ/DQoNCkZvcmdvdCB0byBtZW50aW9u
LCB3aXRob3V0IHN0dWIgYXBpLCBmb3IgZHJpdmVycyB3aXRoDQoiICNpbmNsdWRlIDxsaW51eC9m
aXJtd2FyZS9pbXgvc2NpLmg+ICIgd2lsbCBtZXQgY29tcGlsZSBlcnJvciB3aXRob3V0DQorI2lm
ZGVmIENPTkZJR19JTVhfU0NVDQorI2VuZGlmDQoNClNvIHdlIGhhdmUgdG8gdXNlIGlmZGVmIENP
TkZJR19JTVhfU0NVIHRvIGd1YXJkIHRoZSBpbmNsdWRlLg0KDQpSZWdhcmRzLA0KUGVuZy4NCg0K
PiANCj4gY29uZmlnIEtFWUJPQVJEX0lNWF9TQ19LRVkNCj4gICAgIHRyaXN0YXRlICJJTVggU0NV
IEtleSBEcml2ZXIiDQo+ICAgICBkZXBlbmRzIG9uIElNWF9TQ1UgfHwgQ09NUElMRV9URVNUDQo+
IA0KPiB0aGFua3MsDQo+IEFuc29uDQo=
