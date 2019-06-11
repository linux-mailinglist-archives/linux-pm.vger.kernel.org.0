Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 990C13CBDA
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2019 14:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387527AbfFKMhP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jun 2019 08:37:15 -0400
Received: from mail-eopbgr140084.outbound.protection.outlook.com ([40.107.14.84]:44195
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726713AbfFKMhP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 11 Jun 2019 08:37:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H23z4g/U0EsTzeTd6dLkP7piLsBF2/NZ0/RjmsrY5T0=;
 b=O1ROo3YVUhxa6Q+Vdm/L25MntIYE1+1ybL9XMUvXcjVGzjQ4UZ51q5KP8p2EblI0nvK0fIzlFgveQ+gTWvYmZxlgDPSJC73mYhJnhkTjDMoyxEvHGSKnzlAX4f+SOyfM1Ib/KvgZ+VR1EHCQtfHRUO0pU+Hoso5b97Sgr9PbpTE=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3835.eurprd04.prod.outlook.com (52.134.65.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.14; Tue, 11 Jun 2019 12:37:07 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec%5]) with mapi id 15.20.1965.017; Tue, 11 Jun 2019
 12:37:07 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
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
Thread-Index: AQHVHzdukfa79SJ0YU+EW6tI7WFhPKaWWD6AgAANPiA=
Date:   Tue, 11 Jun 2019 12:37:06 +0000
Message-ID: <DB3PR0402MB39169A1897B33DC6C3522E08F5ED0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190610025254.23940-1-Anson.Huang@nxp.com>
 <20190610025254.23940-2-Anson.Huang@nxp.com>
 <AM0PR04MB42118F3F8E87A72758D4A7B780ED0@AM0PR04MB4211.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB42118F3F8E87A72758D4A7B780ED0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dba9489d-bb22-4d65-59d3-08d6ee6983e9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3835;
x-ms-traffictypediagnostic: DB3PR0402MB3835:
x-microsoft-antispam-prvs: <DB3PR0402MB38358F5C13BB91A5B49D9A82F5ED0@DB3PR0402MB3835.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 006546F32A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(136003)(396003)(376002)(366004)(13464003)(189003)(199004)(305945005)(26005)(2201001)(33656002)(186003)(110136005)(7736002)(76116006)(73956011)(8936002)(81166006)(8676002)(66946007)(25786009)(81156014)(11346002)(2501003)(64756008)(66556008)(478600001)(446003)(68736007)(66446008)(476003)(14454004)(66476007)(52536014)(6506007)(71190400001)(256004)(102836004)(2906002)(14444005)(71200400001)(316002)(76176011)(4326008)(86362001)(53546011)(66066001)(9686003)(3846002)(6246003)(44832011)(99286004)(53936002)(5660300002)(486006)(55016002)(7416002)(6116002)(229853002)(7696005)(74316002)(6436002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3835;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gY8iD16PGcS7UKVEDBRlSGDpeuP0mdr/A9044scw9qhuREsXl2l3FcqTv52SEIx+UV1TzpnnoCcxRjMQhtba/y9SDTq5LSJ/PLcyUj9jg1Ih3GiE440K9Gxf/t/vsxwxm6SvLvGd2+0KFM0SJzoXcc45sYq/OsgyDTmi4D9c9+NCI4fC3ACYwK+x5C0HSqjZPmKD1xMZW3SFgxLPgcSscQNpsPFRi7DtK24M0cnuwzgK9SQ4bGa7QwR5gLdyQGTzhp2iP99Z1RPMY9iX6uFsTiWtUAN4p6snsGtFtPjrwWHyS22ylLn2YLFOl1Gl6RiAPi9QxO+W+2REC+czWwi7i7Gt+AGNM8w1dq0WYhDlBeiRK6fI/cMxWfBlafZQ+h73GsIDwrMBm/VzXn4urXVy6jRe+oMaQHOyCdK5zlehpxw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dba9489d-bb22-4d65-59d3-08d6ee6983e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2019 12:37:06.8810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3835
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIEFpc2hlbmcNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBaXNo
ZW5nIERvbmcNCj4gU2VudDogVHVlc2RheSwgSnVuZSAxMSwgMjAxOSA3OjQ3IFBNDQo+IFRvOiBB
bnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT47IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4g
bWFyay5ydXRsYW5kQGFybS5jb207IGNvcmJldEBsd24ubmV0OyBzaGF3bmd1b0BrZXJuZWwub3Jn
Ow0KPiBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3Rl
dmFtQGdtYWlsLmNvbTsNCj4gY2F0YWxpbi5tYXJpbmFzQGFybS5jb207IHdpbGwuZGVhY29uQGFy
bS5jb207IHJ1aS56aGFuZ0BpbnRlbC5jb207DQo+IGVkdWJlenZhbEBnbWFpbC5jb207IGRhbmll
bC5sZXpjYW5vQGxpbmFyby5vcmc7IHVsZi5oYW5zc29uQGxpbmFyby5vcmc7DQo+IFBlbmcgRmFu
IDxwZW5nLmZhbkBueHAuY29tPjsgbWNoZWhhYitzYW1zdW5nQGtlcm5lbC5vcmc7DQo+IGxpbnV4
QHJvZWNrLXVzLm5ldDsgRGFuaWVsIEJhbHV0YSA8ZGFuaWVsLmJhbHV0YUBueHAuY29tPjsNCj4g
bWF4aW1lLnJpcGFyZEBib290bGluLmNvbTsgb2xvZkBsaXhvbS5uZXQ7IGphZ2FuQGFtYXJ1bGFz
b2x1dGlvbnMuY29tOw0KPiBob3JtcytyZW5lc2FzQHZlcmdlLm5ldC5hdTsgTGVvbmFyZCBDcmVz
dGV6IDxsZW9uYXJkLmNyZXN0ZXpAbnhwLmNvbT47DQo+IGJqb3JuLmFuZGVyc3NvbkBsaW5hcm8u
b3JnOyBkaW5ndXllbkBrZXJuZWwub3JnOw0KPiBlbnJpYy5iYWxsZXRib0Bjb2xsYWJvcmEuY29t
OyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LWRvY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS0NCj4ga2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZw0KPiBDYzogZGwtbGlu
dXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUkU6IFtQQVRDSCBWMTQgMi81
XSB0aGVybWFsOiBvZi10aGVybWFsOiBhZGQgQVBJIGZvciBnZXR0aW5nIHNlbnNvcg0KPiBJRCBm
cm9tIERUDQo+IA0KPiBIaSBBbnNvbiwNCj4gDQo+IFRoZSBpbXBsZW1lbnRhdGlvbiBsb29rcyBn
b29kIHRvIG1lLg0KPiBBIGZldyBtaW5vciBjb21tZW50cyBvbiB0aGUgZG9jOg0KDQpUaGlzIHBh
dGNoIGlzIHBlbmRpbmcgZm9yIHNvIGxvbmcgYW5kIGV2ZW4gdGlsbCBub3cgSSBhbSBOT1Qgc3Vy
ZSBpZiBldmVyeW9uZSBpcyBPSyBmb3INCnRoaXMgY2hhbmdlLCBzbyBJIHdpbGwgd2FpdCBmb3Ig
c29tZSBjb21tZW50cyBpZiB0aGVyZSBpcyBhbnksIGFuZCB3aWxsIGltcHJvdmUgdGhlIGRvYw0K
dG9nZXRoZXIgaW4gbmV4dCB2ZXJzaW9uLg0KDQpUaGFua3MsDQpBbnNvbg0KDQo+IA0KPiA+IEZy
b206IEFuc29uLkh1YW5nQG54cC5jb20gW21haWx0bzpBbnNvbi5IdWFuZ0BueHAuY29tXQ0KPiA+
IFNlbnQ6IE1vbmRheSwgSnVuZSAxMCwgMjAxOSAxMDo1MyBBTQ0KPiA+DQo+ID4gT24gc29tZSBw
bGF0Zm9ybXMgbGlrZSBpLk1YOFFYUCwgdGhlIHRoZXJtYWwgZHJpdmVyIG5lZWRzIGEgcmVhbCBI
Vw0KPiA+IHNlbnNvciBJRCBmcm9tIERUIHRoZXJtYWwgem9uZSwgdGhlIEhXIHNlbnNvciBJRCBp
cyB1c2VkIHRvIGdldA0KPiA+IHRlbXBlcmF0dXJlIGZyb20gU0NVIGZpcm13YXJlLCBhbmQgdGhl
IHZpcnR1YWwgc2Vuc29yIElEIHN0YXJ0aW5nIGZyb20NCj4gPiAwIHRvIE4gaXMgTk9UIHVzZWQg
YXQgYWxsLA0KPiANCj4gVGhpcyBBUEkgaXMgdW53YXJlIG9mIEhXIElEIG9yIFZpcnR1YWwgSUQu
IFNvIHdlIHByb2JhYmx5IG5vIG5lZWQgdG8NCj4gbWVudGlvbiBJdCBoZXJlLg0KPiANCj4gPiB0
aGlzIHBhdGNoIGFkZHMgbmV3IEFQSSB0aGVybWFsX3pvbmVfb2ZfZ2V0X3NlbnNvcl9pZCgpIHRv
IHByb3ZpZGUgdGhlDQo+ID4gZmVhdHVyZSBvZiBnZXR0aW5nIHNlbnNvciBJRCBmcm9tIERUIHRo
ZXJtYWwgem9uZSdzIG5vZGUuDQo+ID4NCj4gDQo+ICJJdCdzIHVzZWZ1bCBmb3IgdGhlcm1hbCBk
cml2ZXIgdG8gcmVnaXN0ZXIgdGhlIHNwZWNpZmljIHRoZXJtYWwgem9uZSBkZXZpY2VzDQo+IGZy
b20gRFQgaW4gYSBjb21tb24gd2F5LiINCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVh
bmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gQ2hhbmdlcyBzaW5jZSBWMTM6
DQo+ID4gCS0gYWRkIG5ldyBBUEkgaW50byB0aGUgdGhlcm1hbCBBUEkgZG9jLg0KPiA+IC0tLQ0K
PiA+ICBEb2N1bWVudGF0aW9uL3RoZXJtYWwvc3lzZnMtYXBpLnR4dCB8ICA4ICsrKysrDQo+ID4g
IGRyaXZlcnMvdGhlcm1hbC9vZi10aGVybWFsLmMgICAgICAgIHwgNjYNCj4gPiArKysrKysrKysr
KysrKysrKysrKysrKysrKysrLS0tLS0tLS0tDQo+ID4gIGluY2x1ZGUvbGludXgvdGhlcm1hbC5o
ICAgICAgICAgICAgIHwgMTAgKysrKysrDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgNjggaW5zZXJ0
aW9ucygrKSwgMTYgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRh
dGlvbi90aGVybWFsL3N5c2ZzLWFwaS50eHQNCj4gPiBiL0RvY3VtZW50YXRpb24vdGhlcm1hbC9z
eXNmcy1hcGkudHh0DQo+ID4gaW5kZXggYzNmYTUwMC4uOGQ3ZjFiMSAxMDA2NDQNCj4gPiAtLS0g
YS9Eb2N1bWVudGF0aW9uL3RoZXJtYWwvc3lzZnMtYXBpLnR4dA0KPiA+ICsrKyBiL0RvY3VtZW50
YXRpb24vdGhlcm1hbC9zeXNmcy1hcGkudHh0DQo+ID4gQEAgLTE1OSw2ICsxNTksMTQgQEAgdGVt
cGVyYXR1cmUpIGFuZCB0aHJvdHRsZSBhcHByb3ByaWF0ZSBkZXZpY2VzLg0KPiA+ICAJZm9yIHRo
ZSB0aGVybWFsIHpvbmUgZGV2aWNlLCB3aGljaCBtaWdodCBiZSB1c2VmdWwgZm9yIHBsYXRmb3Jt
DQo+ID4gIAlkcml2ZXJzIGZvciB0ZW1wZXJhdHVyZSBjYWxjdWxhdGlvbnMuDQo+ID4NCj4gPiAr
MS4xLjkgaW50IHRoZXJtYWxfem9uZV9vZl9nZXRfc2Vuc29yX2lkKHN0cnVjdCBkZXZpY2Vfbm9k
ZSAqdHpfbnAsDQo+ID4gKwkJc3RydWN0IGRldmljZV9ub2RlICpzZW5zb3JfbnAsDQo+ID4gKwkJ
dTMyICppZCkNCj4gPiArDQo+ID4gKwlUaGlzIGludGVyZmFjZSBpcyB1c2VkIHRvIGdldCB0aGUg
c2Vuc29yIGlkIGZyb20gdGhlcm1hbCBzZW5zb3Incw0KPiA+ICsJcGhhbmRsZSBhcmd1bWVudCwg
aXQgbWlnaHQgYmUgbmVjZXNzYXJ5IGZvciBzb21lIHBsYXRmb3JtcyB3aGljaA0KPiA+ICsJaGF2
ZSBzcGVjaWZpYyBzZW5zb3IgSUQgcmF0aGVyIHRoYW4gdmlydHVhbCBJRCBmcm9tIDAgLSBOLg0K
PiANCj4gRG9lcyBiZWxvdyBvbmUgbG9vayBiZXR0ZXI/DQo+IA0KPiAiVGhpcyBpbnRlcmZhY2Ug
aXMgdXNlZCB0byBnZXQgdGhlIHNlbnNvciBpZCBmcm9tIHRoZSBnaXZlbiB0aGVybWFsIHpvbmUg
aW4gRFQsDQo+IHdoaWNoIG1pZ2h0IGJlIHVzZWZ1bCBmb3IgdGhlcm1hbCBkcml2ZXJzIHRvIHJl
Z2lzdGVyIHNwZWNpZmljIHRoZXJtYWwgem9uZQ0KPiBkZXZpY2UgaW4gYSBjb21tb24gd2F5LiIN
Cj4gDQo+ID4gKw0KPiA+ICAxLjIgdGhlcm1hbCBjb29saW5nIGRldmljZSBpbnRlcmZhY2UNCj4g
PiAgMS4yLjEgc3RydWN0IHRoZXJtYWxfY29vbGluZ19kZXZpY2UNCj4gPiAqdGhlcm1hbF9jb29s
aW5nX2RldmljZV9yZWdpc3RlcihjaGFyDQo+ID4gKm5hbWUsDQo+ID4gIAkJdm9pZCAqZGV2ZGF0
YSwgc3RydWN0IHRoZXJtYWxfY29vbGluZ19kZXZpY2Vfb3BzICopIGRpZmYgLS1naXQNCj4gPiBh
L2RyaXZlcnMvdGhlcm1hbC9vZi10aGVybWFsLmMgYi9kcml2ZXJzL3RoZXJtYWwvb2YtdGhlcm1h
bC5jIGluZGV4DQo+ID4gZGM1MDkzYi4uYTUzNzkyYiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L3RoZXJtYWwvb2YtdGhlcm1hbC5jDQo+ID4gKysrIGIvZHJpdmVycy90aGVybWFsL29mLXRoZXJt
YWwuYw0KPiA+IEBAIC00NDksNiArNDQ5LDU0IEBAIHRoZXJtYWxfem9uZV9vZl9hZGRfc2Vuc29y
KHN0cnVjdCBkZXZpY2Vfbm9kZQ0KPiA+ICp6b25lLCAgfQ0KPiA+DQo+ID4gIC8qKg0KPiA+ICsg
KiB0aGVybWFsX3pvbmVfb2ZfZ2V0X3NlbnNvcl9pZCAtIGdldCBzZW5zb3IgSUQgZnJvbSBhIERU
IHRoZXJtYWwNCj4gPiArIHpvbmUNCj4gPiArICogQHR6X25wOiBhIHZhbGlkIHRoZXJtYWwgem9u
ZSBkZXZpY2Ugbm9kZS4NCj4gPiArICogQHNlbnNvcl9ucDogYSBzZW5zb3Igbm9kZSBvZiBhIHZh
bGlkIHNlbnNvciBkZXZpY2UuDQo+ID4gKyAqIEBpZDogYSBzZW5zb3IgSUQgcG9pbnRlciB3aWxs
IGJlIHBhc3NlZCBiYWNrLg0KPiANCj4gdGhlIHNlbnNvciBJRCByZXR1cm5lZCBpZiBzdWNjZXNz
DQo+IA0KPiA+ICsgKg0KPiA+ICsgKiBUaGlzIGZ1bmN0aW9uIHdpbGwgZ2V0IHNlbnNvciBJRCBm
cm9tIGEgZ2l2ZW4gdGhlcm1hbCB6b25lIG5vZGUsDQo+ID4gKyB1c2UNCj4gPiArICogInRoZXJt
YWwtc2Vuc29ycyIgYXMgbGlzdCBuYW1lLCBhbmQgZ2V0IHNlbnNvciBJRCBmcm9tIGZpcnN0DQo+
ID4gKyBwaGFuZGxlJ3MNCj4gPiArICogYXJndW1lbnQuDQo+IA0KPiAiVGhpcyBmdW5jdGlvbiB3
aWxsIGdldCBzZW5zb3IgSUQgZnJvbSBhIGdpdmVuIHRoZXJtYWwgem9uZSBub2RlIGFuZCB0aGUN
Cj4gc2Vuc29yIGdldCBtdXN0IG1hdGNoIHRoZSB0ZW1wZXJhdHVyZSBwcm92aWRlcnMgQHNlbnNv
cl9ucC4iDQo+IA0KPiBSZWdhcmRzDQo+IERvbmcgQWlzaGVuZw0KPiANCj4gPiArICoNCj4gPiAr
ICogUmV0dXJuOiAwIG9uIHN1Y2Nlc3MsIHByb3BlciBlcnJvciBjb2RlIG90aGVyd2lzZS4NCj4g
PiArICovDQo+ID4gKw0KPiA+ICtpbnQgdGhlcm1hbF96b25lX29mX2dldF9zZW5zb3JfaWQoc3Ry
dWN0IGRldmljZV9ub2RlICp0el9ucCwNCj4gPiArCQkJCSAgc3RydWN0IGRldmljZV9ub2RlICpz
ZW5zb3JfbnAsDQo+ID4gKwkJCQkgIHUzMiAqaWQpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBvZl9w
aGFuZGxlX2FyZ3Mgc2Vuc29yX3NwZWNzOw0KPiA+ICsJaW50IHJldDsNCj4gPiArDQo+ID4gKwly
ZXQgPSBvZl9wYXJzZV9waGFuZGxlX3dpdGhfYXJncyh0el9ucCwNCj4gPiArCQkJCQkgInRoZXJt
YWwtc2Vuc29ycyIsDQo+ID4gKwkJCQkJICIjdGhlcm1hbC1zZW5zb3ItY2VsbHMiLA0KPiA+ICsJ
CQkJCSAwLA0KPiA+ICsJCQkJCSAmc2Vuc29yX3NwZWNzKTsNCj4gPiArCWlmIChyZXQpDQo+ID4g
KwkJcmV0dXJuIHJldDsNCj4gPiArDQo+ID4gKwlpZiAoc2Vuc29yX3NwZWNzLm5wICE9IHNlbnNv
cl9ucCkgew0KPiA+ICsJCW9mX25vZGVfcHV0KHNlbnNvcl9zcGVjcy5ucCk7DQo+ID4gKwkJcmV0
dXJuIC1FTk9ERVY7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJaWYgKHNlbnNvcl9zcGVjcy5hcmdz
X2NvdW50ID49IDEpIHsNCj4gPiArCQkqaWQgPSBzZW5zb3Jfc3BlY3MuYXJnc1swXTsNCj4gPiAr
CQlXQVJOKHNlbnNvcl9zcGVjcy5hcmdzX2NvdW50ID4gMSwNCj4gPiArCQkgICAgICIlcE9Gbjog
dG9vIG1hbnkgY2VsbHMgaW4gc2Vuc29yIHNwZWNpZmllciAlZFxuIiwNCj4gPiArCQkgICAgIHNl
bnNvcl9zcGVjcy5ucCwgc2Vuc29yX3NwZWNzLmFyZ3NfY291bnQpOw0KPiA+ICsJfSBlbHNlIHsN
Cj4gPiArCQkqaWQgPSAwOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCW9mX25vZGVfcHV0KHNlbnNv
cl9zcGVjcy5ucCk7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArRVhQT1JU
X1NZTUJPTF9HUEwodGhlcm1hbF96b25lX29mX2dldF9zZW5zb3JfaWQpOw0KPiA+ICsNCj4gPiAr
LyoqDQo+ID4gICAqIHRoZXJtYWxfem9uZV9vZl9zZW5zb3JfcmVnaXN0ZXIgLSByZWdpc3RlcnMg
YSBzZW5zb3IgdG8gYSBEVCB0aGVybWFsDQo+IHpvbmUNCj4gPiAgICogQGRldjogYSB2YWxpZCBz
dHJ1Y3QgZGV2aWNlIHBvaW50ZXIgb2YgYSBzZW5zb3IgZGV2aWNlLiBNdXN0IGNvbnRhaW4NCj4g
PiAgICogICAgICAgYSB2YWxpZCAub2Zfbm9kZSwgZm9yIHRoZSBzZW5zb3Igbm9kZS4NCj4gPiBA
QCAtNDk5LDM2ICs1NDcsMjIgQEAgdGhlcm1hbF96b25lX29mX3NlbnNvcl9yZWdpc3RlcihzdHJ1
Y3QgZGV2aWNlDQo+ID4gKmRldiwgaW50IHNlbnNvcl9pZCwgdm9pZCAqZGF0YSwNCj4gPiAgCXNl
bnNvcl9ucCA9IG9mX25vZGVfZ2V0KGRldi0+b2Zfbm9kZSk7DQo+ID4NCj4gPiAgCWZvcl9lYWNo
X2F2YWlsYWJsZV9jaGlsZF9vZl9ub2RlKG5wLCBjaGlsZCkgew0KPiA+IC0JCXN0cnVjdCBvZl9w
aGFuZGxlX2FyZ3Mgc2Vuc29yX3NwZWNzOw0KPiA+ICAJCWludCByZXQsIGlkOw0KPiA+DQo+ID4g
IAkJLyogRm9yIG5vdywgdGhlcm1hbCBmcmFtZXdvcmsgc3VwcG9ydHMgb25seSAxIHNlbnNvciBw
ZXINCj4gem9uZSAqLw0KPiA+IC0JCXJldCA9IG9mX3BhcnNlX3BoYW5kbGVfd2l0aF9hcmdzKGNo
aWxkLCAidGhlcm1hbC1zZW5zb3JzIiwNCj4gPiAtCQkJCQkJICIjdGhlcm1hbC1zZW5zb3ItY2Vs
bHMiLA0KPiA+IC0JCQkJCQkgMCwgJnNlbnNvcl9zcGVjcyk7DQo+ID4gKwkJcmV0ID0gdGhlcm1h
bF96b25lX29mX2dldF9zZW5zb3JfaWQoY2hpbGQsIHNlbnNvcl9ucCwgJmlkKTsNCj4gPiAgCQlp
ZiAocmV0KQ0KPiA+ICAJCQljb250aW51ZTsNCj4gPg0KPiA+IC0JCWlmIChzZW5zb3Jfc3BlY3Mu
YXJnc19jb3VudCA+PSAxKSB7DQo+ID4gLQkJCWlkID0gc2Vuc29yX3NwZWNzLmFyZ3NbMF07DQo+
ID4gLQkJCVdBUk4oc2Vuc29yX3NwZWNzLmFyZ3NfY291bnQgPiAxLA0KPiA+IC0JCQkgICAgICIl
cE9GbjogdG9vIG1hbnkgY2VsbHMgaW4gc2Vuc29yIHNwZWNpZmllciAlZFxuIiwNCj4gPiAtCQkJ
ICAgICBzZW5zb3Jfc3BlY3MubnAsIHNlbnNvcl9zcGVjcy5hcmdzX2NvdW50KTsNCj4gPiAtCQl9
IGVsc2Ugew0KPiA+IC0JCQlpZCA9IDA7DQo+ID4gLQkJfQ0KPiA+IC0NCj4gPiAtCQlpZiAoc2Vu
c29yX3NwZWNzLm5wID09IHNlbnNvcl9ucCAmJiBpZCA9PSBzZW5zb3JfaWQpIHsNCj4gPiArCQlp
ZiAoaWQgPT0gc2Vuc29yX2lkKSB7DQo+ID4gIAkJCXR6ZCA9IHRoZXJtYWxfem9uZV9vZl9hZGRf
c2Vuc29yKGNoaWxkLCBzZW5zb3JfbnAsDQo+ID4gIAkJCQkJCQkgZGF0YSwgb3BzKTsNCj4gPiAg
CQkJaWYgKCFJU19FUlIodHpkKSkNCj4gPiAgCQkJCXR6ZC0+b3BzLT5zZXRfbW9kZSh0emQsDQo+
IFRIRVJNQUxfREVWSUNFX0VOQUJMRUQpOw0KPiA+DQo+ID4gLQkJCW9mX25vZGVfcHV0KHNlbnNv
cl9zcGVjcy5ucCk7DQo+ID4gIAkJCW9mX25vZGVfcHV0KGNoaWxkKTsNCj4gPiAgCQkJZ290byBl
eGl0Ow0KPiA+ICAJCX0NCj4gPiAtCQlvZl9ub2RlX3B1dChzZW5zb3Jfc3BlY3MubnApOw0KPiA+
ICAJfQ0KPiA+ICBleGl0Og0KPiA+ICAJb2Zfbm9kZV9wdXQoc2Vuc29yX25wKTsNCj4gPiBkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9saW51eC90aGVybWFsLmggYi9pbmNsdWRlL2xpbnV4L3RoZXJtYWwu
aCBpbmRleA0KPiA+IDE1YTRjYTUuLjVlZGZmZTYgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9s
aW51eC90aGVybWFsLmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L3RoZXJtYWwuaA0KPiA+IEBA
IC0zNzUsNiArMzc1LDkgQEAgc3RydWN0IHRoZXJtYWxfdHJpcCB7DQo+ID4NCj4gPiAgLyogRnVu
Y3Rpb24gZGVjbGFyYXRpb25zICovDQo+ID4gICNpZmRlZiBDT05GSUdfVEhFUk1BTF9PRg0KPiA+
ICtpbnQgdGhlcm1hbF96b25lX29mX2dldF9zZW5zb3JfaWQoc3RydWN0IGRldmljZV9ub2RlICp0
el9ucCwNCj4gPiArCQkJCSAgc3RydWN0IGRldmljZV9ub2RlICpzZW5zb3JfbnAsDQo+ID4gKwkJ
CQkgIHUzMiAqaWQpOw0KPiA+ICBzdHJ1Y3QgdGhlcm1hbF96b25lX2RldmljZSAqDQo+ID4gIHRo
ZXJtYWxfem9uZV9vZl9zZW5zb3JfcmVnaXN0ZXIoc3RydWN0IGRldmljZSAqZGV2LCBpbnQgaWQs
IHZvaWQgKmRhdGEsDQo+ID4gIAkJCQljb25zdCBzdHJ1Y3QgdGhlcm1hbF96b25lX29mX2Rldmlj
ZV9vcHMNCj4gKm9wcyk7IEBADQo+ID4gLTM4Niw2ICszODksMTMgQEAgc3RydWN0IHRoZXJtYWxf
em9uZV9kZXZpY2UNCj4gPiAqZGV2bV90aGVybWFsX3pvbmVfb2Zfc2Vuc29yX3JlZ2lzdGVyKA0K
PiA+ICB2b2lkIGRldm1fdGhlcm1hbF96b25lX29mX3NlbnNvcl91bnJlZ2lzdGVyKHN0cnVjdCBk
ZXZpY2UgKmRldiwNCj4gPiAgCQkJCQkgICAgc3RydWN0IHRoZXJtYWxfem9uZV9kZXZpY2UgKnR6
KTsNCj4gI2Vsc2UNCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgdGhlcm1hbF96b25lX29mX2dldF9z
ZW5zb3JfaWQoc3RydWN0IGRldmljZV9ub2RlICp0el9ucCwNCj4gPiArCQkJCQkgc3RydWN0IGRl
dmljZV9ub2RlICpzZW5zb3JfbnAsDQo+ID4gKwkJCQkJIHUzMiAqaWQpDQo+ID4gK3sNCj4gPiAr
CXJldHVybiAtRU5PRU5UOw0KPiA+ICt9DQo+ID4gIHN0YXRpYyBpbmxpbmUgc3RydWN0IHRoZXJt
YWxfem9uZV9kZXZpY2UgKg0KPiA+IHRoZXJtYWxfem9uZV9vZl9zZW5zb3JfcmVnaXN0ZXIoc3Ry
dWN0IGRldmljZSAqZGV2LCBpbnQgaWQsIHZvaWQgKmRhdGEsDQo+ID4gIAkJCQljb25zdCBzdHJ1
Y3QgdGhlcm1hbF96b25lX29mX2RldmljZV9vcHMNCj4gKm9wcykNCj4gPiAtLQ0KPiA+IDIuNy40
DQoNCg==
