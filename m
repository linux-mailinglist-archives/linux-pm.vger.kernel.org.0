Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 382B73AD0C
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2019 04:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730355AbfFJCed (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 9 Jun 2019 22:34:33 -0400
Received: from mail-eopbgr80073.outbound.protection.outlook.com ([40.107.8.73]:59534
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730055AbfFJCed (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 9 Jun 2019 22:34:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CqEkc/GTUjQTv41AHDXW4vuHITr9eDsDRH+qtzcy0pY=;
 b=HK6vsIdMEAPIzBjHdyfT/jFOPMM/P/6U/mC8V16HBC0kOnZ+Totz/ktSddUB0cbKSsE70QErL5QnrhqwPHklKYj1P3wLNqAr3/y7mY+xlQSjyvYsa6HGozZJSBj0cskWB82sCMcCERZMED6df5I3A6G04/0F3pfnrvZSYsj6WTI=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3929.eurprd04.prod.outlook.com (52.134.70.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Mon, 10 Jun 2019 02:34:21 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec%5]) with mapi id 15.20.1965.017; Mon, 10 Jun 2019
 02:34:21 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Eduardo Valentin <edubezval@gmail.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Peng Fan <peng.fan@nxp.com>,
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
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH RESEND V13 2/5] thermal: of-thermal: add API for getting
 sensor ID from DT
Thread-Topic: [PATCH RESEND V13 2/5] thermal: of-thermal: add API for getting
 sensor ID from DT
Thread-Index: AQHVFRtF1HyUf82e5E+mJmD7zHGxLKaBa66AgAAIvwCAEsmvQA==
Date:   Mon, 10 Jun 2019 02:34:21 +0000
Message-ID: <DB3PR0402MB3916BA73B800FB63B797007CF5130@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190528060621.47342-1-Anson.Huang@nxp.com>
 <20190528060621.47342-2-Anson.Huang@nxp.com>
 <20190529030225.GA2662@localhost.localdomain>
 <DB3PR0402MB3916A099D7DE4F89D3F50CB3F51F0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916A099D7DE4F89D3F50CB3F51F0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c6c4f78-c96e-47ba-49ad-08d6ed4c2551
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3929;
x-ms-traffictypediagnostic: DB3PR0402MB3929:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB3PR0402MB3929F4A39050D16858B40C26F5130@DB3PR0402MB3929.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0064B3273C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(366004)(136003)(13464003)(199004)(189003)(6116002)(74316002)(66946007)(76116006)(99286004)(7416002)(229853002)(66066001)(73956011)(2906002)(25786009)(66446008)(64756008)(66556008)(66476007)(9686003)(8676002)(8936002)(68736007)(7736002)(6246003)(478600001)(966005)(6306002)(316002)(1411001)(86362001)(81156014)(81166006)(53936002)(54906003)(305945005)(6916009)(11346002)(33656002)(7696005)(102836004)(76176011)(6506007)(53546011)(4326008)(14454004)(5660300002)(55016002)(6436002)(52536014)(256004)(71190400001)(26005)(44832011)(446003)(486006)(186003)(3846002)(71200400001)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3929;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3aqBr/qwBqlTMgzNivZpd0zoZVO8+Y8BCXiuBBBJ+7L00+5v72zGa2kg4y8cUo+N+SRvVWOeDroUhlSBldG+xkVgliuoVUAutMBig3EsLQlKgZR3NgggP3UZ/bZ9q6vUVLP+Bpje2yfhM+lI/f3E8d2Q8PXHb2+wkRJ5gZWhXx08v7lAfLpfRvn3Dh+YvTPQWN68HbG7lDx138mIVfAvjmtRaLr+1psrcxpzrsNEm5UkU8ii2IQPbUM4dQ3WNbEmAbZupDYiuKn/XMI50uNqNRKYXvkGoTMkWse9e3OB13ccf/YHsL6nGPlfS0xmzrmfbEJtOv3Lb5EY0Mbyarr9O9OCASftEPWxafiIk7/BuEmf3E4oHaTmYngCI48CyDj3rH1dGoOGUURyaVeACRQ6aHxfQOvAUkHuf1aUPdZyDI4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c6c4f78-c96e-47ba-49ad-08d6ed4c2551
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2019 02:34:21.6426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3929
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIEVkdWFyZG8NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbnNv
biBIdWFuZw0KPiBTZW50OiBXZWRuZXNkYXksIE1heSAyOSwgMjAxOSAxMTozNyBBTQ0KPiBUbzog
RWR1YXJkbyBWYWxlbnRpbiA8ZWR1YmV6dmFsQGdtYWlsLmNvbT4NCj4gQ2M6IHJvYmgrZHRAa2Vy
bmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207IHNoYXduZ3VvQGtlcm5lbC5vcmc7DQo+IHMu
aGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21h
aWwuY29tOw0KPiBjYXRhbGluLm1hcmluYXNAYXJtLmNvbTsgd2lsbC5kZWFjb25AYXJtLmNvbTsg
cnVpLnpoYW5nQGludGVsLmNvbTsNCj4gZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZzsgQWlzaGVu
ZyBEb25nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT47DQo+IHVsZi5oYW5zc29uQGxpbmFyby5vcmc7
IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPjsgRGFuaWVsIEJhbHV0YQ0KPiA8ZGFuaWVsLmJh
bHV0YUBueHAuY29tPjsgbWF4aW1lLnJpcGFyZEBib290bGluLmNvbTsgb2xvZkBsaXhvbS5uZXQ7
DQo+IGphZ2FuQGFtYXJ1bGFzb2x1dGlvbnMuY29tOyBob3JtcytyZW5lc2FzQHZlcmdlLm5ldC5h
dTsgTGVvbmFyZA0KPiBDcmVzdGV6IDxsZW9uYXJkLmNyZXN0ZXpAbnhwLmNvbT47IGJqb3JuLmFu
ZGVyc3NvbkBsaW5hcm8ub3JnOw0KPiBkaW5ndXllbkBrZXJuZWwub3JnOyBlbnJpYy5iYWxsZXRi
b0Bjb2xsYWJvcmEuY29tOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLQ0KPiBrZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZzsgbGludXgtcG1Admdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXggPGxpbnV4LQ0KPiBp
bXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUkU6IFtQQVRDSCBSRVNFTkQgVjEzIDIvNV0gdGhlcm1h
bDogb2YtdGhlcm1hbDogYWRkIEFQSSBmb3IgZ2V0dGluZw0KPiBzZW5zb3IgSUQgZnJvbSBEVA0K
PiANCj4gSGksIEVkdWFyZG8NCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
PiBGcm9tOiBFZHVhcmRvIFZhbGVudGluIDxlZHViZXp2YWxAZ21haWwuY29tPg0KPiA+IFNlbnQ6
IFdlZG5lc2RheSwgTWF5IDI5LCAyMDE5IDExOjAyIEFNDQo+ID4gVG86IEFuc29uIEh1YW5nIDxh
bnNvbi5odWFuZ0BueHAuY29tPg0KPiA+IENjOiByb2JoK2R0QGtlcm5lbC5vcmc7IG1hcmsucnV0
bGFuZEBhcm0uY29tOyBzaGF3bmd1b0BrZXJuZWwub3JnOw0KPiA+IHMuaGF1ZXJAcGVuZ3V0cm9u
aXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOw0KPiA+IGNh
dGFsaW4ubWFyaW5hc0Bhcm0uY29tOyB3aWxsLmRlYWNvbkBhcm0uY29tOyBydWkuemhhbmdAaW50
ZWwuY29tOw0KPiA+IGRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmc7IEFpc2hlbmcgRG9uZyA8YWlz
aGVuZy5kb25nQG54cC5jb20+Ow0KPiA+IHVsZi5oYW5zc29uQGxpbmFyby5vcmc7IFBlbmcgRmFu
IDxwZW5nLmZhbkBueHAuY29tPjsgRGFuaWVsIEJhbHV0YQ0KPiA+IDxkYW5pZWwuYmFsdXRhQG54
cC5jb20+OyBtYXhpbWUucmlwYXJkQGJvb3RsaW4uY29tOyBvbG9mQGxpeG9tLm5ldDsNCj4gPiBq
YWdhbkBhbWFydWxhc29sdXRpb25zLmNvbTsgaG9ybXMrcmVuZXNhc0B2ZXJnZS5uZXQuYXU7IExl
b25hcmQNCj4gPiBDcmVzdGV6IDxsZW9uYXJkLmNyZXN0ZXpAbnhwLmNvbT47IGJqb3JuLmFuZGVy
c3NvbkBsaW5hcm8ub3JnOw0KPiA+IGRpbmd1eWVuQGtlcm5lbC5vcmc7IGVucmljLmJhbGxldGJv
QGNvbGxhYm9yYS5jb207DQo+ID4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS0NCj4gPiBrZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsgbGludXgtcG1Admdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXgNCj4gPiA8bGlu
dXgtIGlteEBueHAuY29tPg0KPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggUkVTRU5EIFYxMyAyLzVd
IHRoZXJtYWw6IG9mLXRoZXJtYWw6IGFkZCBBUEkgZm9yDQo+ID4gZ2V0dGluZyBzZW5zb3IgSUQg
ZnJvbSBEVA0KPiA+DQo+ID4gT24gVHVlLCBNYXkgMjgsIDIwMTkgYXQgMDI6MDY6MThQTSArMDgw
MCwgQW5zb24uSHVhbmdAbnhwLmNvbSB3cm90ZToNCj4gPiA+IEZyb206IEFuc29uIEh1YW5nIDxB
bnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+ID4NCj4gPiA+IE9uIHNvbWUgcGxhdGZvcm1zIGxpa2Ug
aS5NWDhRWFAsIHRoZSB0aGVybWFsIGRyaXZlciBuZWVkcyBhIHJlYWwgSFcNCj4gPiA+IHNlbnNv
ciBJRCBmcm9tIERUIHRoZXJtYWwgem9uZSwgdGhlIEhXIHNlbnNvciBJRCBpcyB1c2VkIHRvIGdl
dA0KPiA+ID4gdGVtcGVyYXR1cmUgZnJvbSBTQ1UgZmlybXdhcmUsIGFuZCB0aGUgdmlydHVhbCBz
ZW5zb3IgSUQgc3RhcnRpbmcNCj4gPiA+IGZyb20NCj4gPiA+IDAgdG8gTiBpcyBOT1QgdXNlZCBh
dCBhbGwsIHRoaXMgcGF0Y2ggYWRkcyBuZXcgQVBJDQo+ID4gPiB0aGVybWFsX3pvbmVfb2ZfZ2V0
X3NlbnNvcl9pZCgpIHRvIHByb3ZpZGUgdGhlIGZlYXR1cmUgb2YgZ2V0dGluZw0KPiA+ID4gc2Vu
c29yIElEIGZyb20gRFQgdGhlcm1hbCB6b25lJ3Mgbm9kZS4NCj4gPiA+DQo+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gPiA+IC0tLQ0KPiA+
ID4gQ2hhbmdlcyBzaW5jZSBWMTI6DQo+ID4gPiAJLSBhZGp1c3QgdGhlIHNlY29uZCBwYXJhbWV0
ZXIgb2YgdGhlcm1hbF96b25lX29mX2dldF9zZW5zb3JfaWQoKQ0KPiA+ID4gQVBJLA0KPiA+IHRo
ZW4gY2FsbGVyIG5vIG5lZWQNCj4gPiA+IAkgIHRvIHBhc3MgdGhlIG9mX3BoYW5kbGVfYXJncyBz
dHJ1Y3R1cmUgYW5kIHB1dCB0aGUgc2Vuc29yX3NwZWNzLm5wDQo+ID4gbWFudWFsbHksIGFsc28g
cHV0dGluZw0KPiA+ID4gCSAgdGhlIHNlbnNvciBub2RlIGRldmljZSBjaGVjayBpbnNpZGUgdGhp
cyBBUEkgdG8gbWFrZSBpdCBlYXN5IGZvcg0KPiA+ID4gdXNhZ2U7DQo+ID4NCj4gPiBXaGF0IGhh
cHBlbmVkIHRvIHVzaW5nIG54cCxyZXNvdXJjZS1pZCBwcm9wZXJ0eSBpbiB5b3VyIGRyaXZlcj8N
Cj4gPiBXaHkgZG8gd2UgbmVlZCB0aGlzIGFzIGFuIEFQSSBpbiBvZi10aGVybWFsPyBXaGF0IG90
aGVyIGRyaXZlcnMgbWF5DQo+ID4gYmVuZWZpdCBvZiB0aGlzPw0KPiA+DQo+ID4gUmVnYXJkbGVz
cywgdGhpcyBwYXRjaCBuZWVkcyB0byBkb2N1bWVudCB0aGUgbmV3IEFQSSB1bmRlcg0KPiA+IERv
Y3VtZW50YXRpb24vDQo+IA0KPiBBcyBSb2IgaGFzIGRpZmZlcmVudCBvcGluaW9uIGFib3V0IHRo
aXMgcHJvcGVydHksIGhlIHRob3VnaHQgaXQgaXMNCj4gdW5uZWNlc3NhcnksIHNlZSBiZWxvdyBk
aXNjdXNzaW9uIG1haWwsIHRoYXQgaXMgd2h5IEkgbmVlZCB0byBhZGQgQVBJIHRvIGdldA0KPiB0
aGUgcmVzb3VyY2UgSUQgZnJvbSBwaGFuZGxlIGFyZ3VtZW50Lg0KPiBJIGFtIHRvdGFsbHkgY29u
ZnVzZWQgbm93LCB3aGljaCBhcHByb2FjaCBzaG91bGQgd2UgYWRvcHQ/DQo+IA0KPiBodHRwczov
L3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzEwODMxMzk3Lw0KDQpJIHdpbGwgYWRkIHRoZSBu
ZXcgQVBJIGRvY3VtZW50IGluIFYxNCwgSSByZW1lbWJlcmVkIHRoYXQgdGhlcmUgaXMgYWxzbyBv
dGhlciB2ZW5kb3JzDQpoYXZlIHNpbWlsYXIgc2Vuc29yIEhXIElEIGFzIGkuTVg4UVhQLCBpbnN0
ZWFkIG9mIGFkZGluZyBwcml2YXRlIHByb3BlcnRpZXMgZm9yIGVhY2ggdmVuZG9yLA0KYWRkaW5n
IGFuIEFQSSB0byByZWFkIG91dCB0aGUgc2Vuc29yIElEIGNhbiBiZW5lZml0IHVzIGEgbG90IEkg
dGhpbmsuDQoNClRoYW5rcywNCkFuc29uDQoNCj4gDQo+IFRoYW5rcywNCj4gQW5zb24NCj4gDQo+
ID4NCj4gPiA+IC0tLQ0KPiA+ID4gIGRyaXZlcnMvdGhlcm1hbC9vZi10aGVybWFsLmMgfCA2Ng0K
PiA+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tDQo+ID4gLS0tLS0tLS0N
Cj4gPiA+ICBpbmNsdWRlL2xpbnV4L3RoZXJtYWwuaCAgICAgIHwgMTAgKysrKysrKw0KPiA+ID4g
IDIgZmlsZXMgY2hhbmdlZCwgNjAgaW5zZXJ0aW9ucygrKSwgMTYgZGVsZXRpb25zKC0pDQo+ID4g
Pg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdGhlcm1hbC9vZi10aGVybWFsLmMNCj4gPiA+
IGIvZHJpdmVycy90aGVybWFsL29mLXRoZXJtYWwuYyBpbmRleCBkYzUwOTNiLi5hNTM3OTJiIDEw
MDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy90aGVybWFsL29mLXRoZXJtYWwuYw0KPiA+ID4gKysr
IGIvZHJpdmVycy90aGVybWFsL29mLXRoZXJtYWwuYw0KPiA+ID4gQEAgLTQ0OSw2ICs0NDksNTQg
QEAgdGhlcm1hbF96b25lX29mX2FkZF9zZW5zb3Ioc3RydWN0DQo+IGRldmljZV9ub2RlDQo+ID4g
PiAqem9uZSwgIH0NCj4gPiA+DQo+ID4gPiAgLyoqDQo+ID4gPiArICogdGhlcm1hbF96b25lX29m
X2dldF9zZW5zb3JfaWQgLSBnZXQgc2Vuc29yIElEIGZyb20gYSBEVCB0aGVybWFsDQo+ID4gPiAr
IHpvbmUNCj4gPiA+ICsgKiBAdHpfbnA6IGEgdmFsaWQgdGhlcm1hbCB6b25lIGRldmljZSBub2Rl
Lg0KPiA+ID4gKyAqIEBzZW5zb3JfbnA6IGEgc2Vuc29yIG5vZGUgb2YgYSB2YWxpZCBzZW5zb3Ig
ZGV2aWNlLg0KPiA+ID4gKyAqIEBpZDogYSBzZW5zb3IgSUQgcG9pbnRlciB3aWxsIGJlIHBhc3Nl
ZCBiYWNrLg0KPiA+ID4gKyAqDQo+ID4gPiArICogVGhpcyBmdW5jdGlvbiB3aWxsIGdldCBzZW5z
b3IgSUQgZnJvbSBhIGdpdmVuIHRoZXJtYWwgem9uZSBub2RlLA0KPiA+ID4gKyB1c2UNCj4gPiA+
ICsgKiAidGhlcm1hbC1zZW5zb3JzIiBhcyBsaXN0IG5hbWUsIGFuZCBnZXQgc2Vuc29yIElEIGZy
b20gZmlyc3QNCj4gPiA+ICsgcGhhbmRsZSdzDQo+ID4gPiArICogYXJndW1lbnQuDQo+ID4gPiAr
ICoNCj4gPiA+ICsgKiBSZXR1cm46IDAgb24gc3VjY2VzcywgcHJvcGVyIGVycm9yIGNvZGUgb3Ro
ZXJ3aXNlLg0KPiA+ID4gKyAqLw0KPiA+ID4gKw0KPiA+ID4gK2ludCB0aGVybWFsX3pvbmVfb2Zf
Z2V0X3NlbnNvcl9pZChzdHJ1Y3QgZGV2aWNlX25vZGUgKnR6X25wLA0KPiA+ID4gKwkJCQkgIHN0
cnVjdCBkZXZpY2Vfbm9kZSAqc2Vuc29yX25wLA0KPiA+ID4gKwkJCQkgIHUzMiAqaWQpDQo+ID4g
PiArew0KPiA+ID4gKwlzdHJ1Y3Qgb2ZfcGhhbmRsZV9hcmdzIHNlbnNvcl9zcGVjczsNCj4gPiA+
ICsJaW50IHJldDsNCj4gPiA+ICsNCj4gPiA+ICsJcmV0ID0gb2ZfcGFyc2VfcGhhbmRsZV93aXRo
X2FyZ3ModHpfbnAsDQo+ID4gPiArCQkJCQkgInRoZXJtYWwtc2Vuc29ycyIsDQo+ID4gPiArCQkJ
CQkgIiN0aGVybWFsLXNlbnNvci1jZWxscyIsDQo+ID4gPiArCQkJCQkgMCwNCj4gPiA+ICsJCQkJ
CSAmc2Vuc29yX3NwZWNzKTsNCj4gPiA+ICsJaWYgKHJldCkNCj4gPiA+ICsJCXJldHVybiByZXQ7
DQo+ID4gPiArDQo+ID4gPiArCWlmIChzZW5zb3Jfc3BlY3MubnAgIT0gc2Vuc29yX25wKSB7DQo+
ID4gPiArCQlvZl9ub2RlX3B1dChzZW5zb3Jfc3BlY3MubnApOw0KPiA+ID4gKwkJcmV0dXJuIC1F
Tk9ERVY7DQo+ID4gPiArCX0NCj4gPiA+ICsNCj4gPiA+ICsJaWYgKHNlbnNvcl9zcGVjcy5hcmdz
X2NvdW50ID49IDEpIHsNCj4gPiA+ICsJCSppZCA9IHNlbnNvcl9zcGVjcy5hcmdzWzBdOw0KPiA+
ID4gKwkJV0FSTihzZW5zb3Jfc3BlY3MuYXJnc19jb3VudCA+IDEsDQo+ID4gPiArCQkgICAgICIl
cE9GbjogdG9vIG1hbnkgY2VsbHMgaW4gc2Vuc29yIHNwZWNpZmllciAlZFxuIiwNCj4gPiA+ICsJ
CSAgICAgc2Vuc29yX3NwZWNzLm5wLCBzZW5zb3Jfc3BlY3MuYXJnc19jb3VudCk7DQo+ID4gPiAr
CX0gZWxzZSB7DQo+ID4gPiArCQkqaWQgPSAwOw0KPiA+ID4gKwl9DQo+ID4gPiArDQo+ID4gPiAr
CW9mX25vZGVfcHV0KHNlbnNvcl9zcGVjcy5ucCk7DQo+ID4gPiArDQo+ID4gPiArCXJldHVybiAw
Ow0KPiA+ID4gK30NCj4gPiA+ICtFWFBPUlRfU1lNQk9MX0dQTCh0aGVybWFsX3pvbmVfb2ZfZ2V0
X3NlbnNvcl9pZCk7DQo+ID4gPiArDQo+ID4gPiArLyoqDQo+ID4gPiAgICogdGhlcm1hbF96b25l
X29mX3NlbnNvcl9yZWdpc3RlciAtIHJlZ2lzdGVycyBhIHNlbnNvciB0byBhIERUIHRoZXJtYWwN
Cj4gem9uZQ0KPiA+ID4gICAqIEBkZXY6IGEgdmFsaWQgc3RydWN0IGRldmljZSBwb2ludGVyIG9m
IGEgc2Vuc29yIGRldmljZS4gTXVzdCBjb250YWluDQo+ID4gPiAgICogICAgICAgYSB2YWxpZCAu
b2Zfbm9kZSwgZm9yIHRoZSBzZW5zb3Igbm9kZS4NCj4gPiA+IEBAIC00OTksMzYgKzU0NywyMiBA
QCB0aGVybWFsX3pvbmVfb2Zfc2Vuc29yX3JlZ2lzdGVyKHN0cnVjdCBkZXZpY2UNCj4gPiAqZGV2
LCBpbnQgc2Vuc29yX2lkLCB2b2lkICpkYXRhLA0KPiA+ID4gIAlzZW5zb3JfbnAgPSBvZl9ub2Rl
X2dldChkZXYtPm9mX25vZGUpOw0KPiA+ID4NCj4gPiA+ICAJZm9yX2VhY2hfYXZhaWxhYmxlX2No
aWxkX29mX25vZGUobnAsIGNoaWxkKSB7DQo+ID4gPiAtCQlzdHJ1Y3Qgb2ZfcGhhbmRsZV9hcmdz
IHNlbnNvcl9zcGVjczsNCj4gPiA+ICAJCWludCByZXQsIGlkOw0KPiA+ID4NCj4gPiA+ICAJCS8q
IEZvciBub3csIHRoZXJtYWwgZnJhbWV3b3JrIHN1cHBvcnRzIG9ubHkgMSBzZW5zb3IgcGVyDQo+
ID4gem9uZSAqLw0KPiA+ID4gLQkJcmV0ID0gb2ZfcGFyc2VfcGhhbmRsZV93aXRoX2FyZ3MoY2hp
bGQsICJ0aGVybWFsLXNlbnNvcnMiLA0KPiA+ID4gLQkJCQkJCSAiI3RoZXJtYWwtc2Vuc29yLWNl
bGxzIiwNCj4gPiA+IC0JCQkJCQkgMCwgJnNlbnNvcl9zcGVjcyk7DQo+ID4gPiArCQlyZXQgPSB0
aGVybWFsX3pvbmVfb2ZfZ2V0X3NlbnNvcl9pZChjaGlsZCwgc2Vuc29yX25wLCAmaWQpOw0KPiA+
ID4gIAkJaWYgKHJldCkNCj4gPiA+ICAJCQljb250aW51ZTsNCj4gPiA+DQo+ID4gPiAtCQlpZiAo
c2Vuc29yX3NwZWNzLmFyZ3NfY291bnQgPj0gMSkgew0KPiA+ID4gLQkJCWlkID0gc2Vuc29yX3Nw
ZWNzLmFyZ3NbMF07DQo+ID4gPiAtCQkJV0FSTihzZW5zb3Jfc3BlY3MuYXJnc19jb3VudCA+IDEs
DQo+ID4gPiAtCQkJICAgICAiJXBPRm46IHRvbyBtYW55IGNlbGxzIGluIHNlbnNvciBzcGVjaWZp
ZXIgJWRcbiIsDQo+ID4gPiAtCQkJICAgICBzZW5zb3Jfc3BlY3MubnAsIHNlbnNvcl9zcGVjcy5h
cmdzX2NvdW50KTsNCj4gPiA+IC0JCX0gZWxzZSB7DQo+ID4gPiAtCQkJaWQgPSAwOw0KPiA+ID4g
LQkJfQ0KPiA+ID4gLQ0KPiA+ID4gLQkJaWYgKHNlbnNvcl9zcGVjcy5ucCA9PSBzZW5zb3JfbnAg
JiYgaWQgPT0gc2Vuc29yX2lkKSB7DQo+ID4gPiArCQlpZiAoaWQgPT0gc2Vuc29yX2lkKSB7DQo+
ID4gPiAgCQkJdHpkID0gdGhlcm1hbF96b25lX29mX2FkZF9zZW5zb3IoY2hpbGQsIHNlbnNvcl9u
cCwNCj4gPiA+ICAJCQkJCQkJIGRhdGEsIG9wcyk7DQo+ID4gPiAgCQkJaWYgKCFJU19FUlIodHpk
KSkNCj4gPiA+ICAJCQkJdHpkLT5vcHMtPnNldF9tb2RlKHR6ZCwNCj4gPiBUSEVSTUFMX0RFVklD
RV9FTkFCTEVEKTsNCj4gPiA+DQo+ID4gPiAtCQkJb2Zfbm9kZV9wdXQoc2Vuc29yX3NwZWNzLm5w
KTsNCj4gPiA+ICAJCQlvZl9ub2RlX3B1dChjaGlsZCk7DQo+ID4gPiAgCQkJZ290byBleGl0Ow0K
PiA+ID4gIAkJfQ0KPiA+ID4gLQkJb2Zfbm9kZV9wdXQoc2Vuc29yX3NwZWNzLm5wKTsNCj4gPiA+
ICAJfQ0KPiA+ID4gIGV4aXQ6DQo+ID4gPiAgCW9mX25vZGVfcHV0KHNlbnNvcl9ucCk7DQo+ID4g
PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC90aGVybWFsLmggYi9pbmNsdWRlL2xpbnV4L3Ro
ZXJtYWwuaCBpbmRleA0KPiA+ID4gMTVhNGNhNS4uNWVkZmZlNiAxMDA2NDQNCj4gPiA+IC0tLSBh
L2luY2x1ZGUvbGludXgvdGhlcm1hbC5oDQo+ID4gPiArKysgYi9pbmNsdWRlL2xpbnV4L3RoZXJt
YWwuaA0KPiA+ID4gQEAgLTM3NSw2ICszNzUsOSBAQCBzdHJ1Y3QgdGhlcm1hbF90cmlwIHsNCj4g
PiA+DQo+ID4gPiAgLyogRnVuY3Rpb24gZGVjbGFyYXRpb25zICovDQo+ID4gPiAgI2lmZGVmIENP
TkZJR19USEVSTUFMX09GDQo+ID4gPiAraW50IHRoZXJtYWxfem9uZV9vZl9nZXRfc2Vuc29yX2lk
KHN0cnVjdCBkZXZpY2Vfbm9kZSAqdHpfbnAsDQo+ID4gPiArCQkJCSAgc3RydWN0IGRldmljZV9u
b2RlICpzZW5zb3JfbnAsDQo+ID4gPiArCQkJCSAgdTMyICppZCk7DQo+ID4gPiAgc3RydWN0IHRo
ZXJtYWxfem9uZV9kZXZpY2UgKg0KPiA+ID4gIHRoZXJtYWxfem9uZV9vZl9zZW5zb3JfcmVnaXN0
ZXIoc3RydWN0IGRldmljZSAqZGV2LCBpbnQgaWQsIHZvaWQgKmRhdGEsDQo+ID4gPiAgCQkJCWNv
bnN0IHN0cnVjdCB0aGVybWFsX3pvbmVfb2ZfZGV2aWNlX29wcw0KPiA+ICpvcHMpOyBAQCAtMzg2
LDYgKzM4OSwxMw0KPiA+ID4gQEAgc3RydWN0IHRoZXJtYWxfem9uZV9kZXZpY2UNCj4gKmRldm1f
dGhlcm1hbF96b25lX29mX3NlbnNvcl9yZWdpc3RlcigNCj4gPiA+ICB2b2lkIGRldm1fdGhlcm1h
bF96b25lX29mX3NlbnNvcl91bnJlZ2lzdGVyKHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gPiA+ICAJ
CQkJCSAgICBzdHJ1Y3QgdGhlcm1hbF96b25lX2RldmljZSAqdHopOw0KPiA+ICNlbHNlDQo+ID4g
PiArDQo+ID4gPiArc3RhdGljIGludCB0aGVybWFsX3pvbmVfb2ZfZ2V0X3NlbnNvcl9pZChzdHJ1
Y3QgZGV2aWNlX25vZGUgKnR6X25wLA0KPiA+ID4gKwkJCQkJIHN0cnVjdCBkZXZpY2Vfbm9kZSAq
c2Vuc29yX25wLA0KPiA+ID4gKwkJCQkJIHUzMiAqaWQpDQo+ID4gPiArew0KPiA+ID4gKwlyZXR1
cm4gLUVOT0VOVDsNCj4gPiA+ICt9DQo+ID4gPiAgc3RhdGljIGlubGluZSBzdHJ1Y3QgdGhlcm1h
bF96b25lX2RldmljZSAqDQo+ID4gPiB0aGVybWFsX3pvbmVfb2Zfc2Vuc29yX3JlZ2lzdGVyKHN0
cnVjdCBkZXZpY2UgKmRldiwgaW50IGlkLCB2b2lkICpkYXRhLA0KPiA+ID4gIAkJCQljb25zdCBz
dHJ1Y3QgdGhlcm1hbF96b25lX29mX2RldmljZV9vcHMNCj4gPiAqb3BzKQ0K
