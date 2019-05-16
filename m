Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C52F1FDCE
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2019 04:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbfEPCxs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 May 2019 22:53:48 -0400
Received: from mail-eopbgr10056.outbound.protection.outlook.com ([40.107.1.56]:46817
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725977AbfEPCxr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 May 2019 22:53:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlPfcP3xxoAFUtRUr0Tr0OT5ZE78iqZsfm+nCqkUqvg=;
 b=MfRQXwX51LlbmlthiRlz4fT+D42N3nD9gcnEtxGUKcl31ZDzVgPxNpaQmux7DbfX52rEQfsqeZZCdFm7Bbb7OIyd27kVDhb1FTtn/BzhIptNI1zO9lUB1OVwWFleQkkPrEnVCTTuLeTcf05F2C2RaVZbSXxYbQA0WCKID/cIqQQ=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3721.eurprd04.prod.outlook.com (52.134.67.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Thu, 16 May 2019 02:53:40 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d%2]) with mapi id 15.20.1900.010; Thu, 16 May 2019
 02:53:39 +0000
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
Thread-Index: AQHU9AOc8iXKmYQeMUm4+FbUnbYclKZiKWGAgAsTpJA=
Date:   Thu, 16 May 2019 02:53:39 +0000
Message-ID: <DB3PR0402MB3916BDD870608F0CAC76DB3FF50A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1555384609-7030-1-git-send-email-Anson.Huang@nxp.com>
 <1555384609-7030-3-git-send-email-Anson.Huang@nxp.com>
 <DB3PR0402MB3916791537B7C3C85B13A22BF5330@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916791537B7C3C85B13A22BF5330@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 49b57cad-27a5-437f-0b5f-08d6d9a9b344
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3721;
x-ms-traffictypediagnostic: DB3PR0402MB3721:
x-microsoft-antispam-prvs: <DB3PR0402MB37211E6CF7503E978CA8E0B2F50A0@DB3PR0402MB3721.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:316;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(396003)(136003)(39860400002)(13464003)(199004)(189003)(76116006)(68736007)(64756008)(66446008)(66556008)(52536014)(66946007)(7736002)(66476007)(305945005)(81156014)(8676002)(81166006)(11346002)(66066001)(476003)(102836004)(6116002)(44832011)(446003)(3846002)(4326008)(25786009)(53546011)(6506007)(256004)(186003)(486006)(26005)(76176011)(71200400001)(71190400001)(7696005)(2501003)(110136005)(14454004)(99286004)(7416002)(316002)(2906002)(53936002)(6436002)(2201001)(5660300002)(33656002)(86362001)(478600001)(8936002)(55016002)(6246003)(229853002)(73956011)(74316002)(9686003)(921003)(1121003)(15866825006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3721;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NIFKxbj/b+JHvNoAp5sq1WzfqROrGyjrf29YTrYXWYVOZ5s25t7jTYdoGxhPECRcxYnloZiVvCOrXTA07GoC9OqXDCMeXaF5RW8qbibZ59dLkY2r5dLO9g1COkHb6APOkVYQQArUWH9xh1DBTMJZlvU1YhGqVcZ6Xh4Z2CnZy1xy5t4jet1TbSoWCy1dw7qM/SVT+4N7vrBmQx8bwTkNWrufvyqdsoLZEFdssEKkCtF0LuryYzVHZXluotlxp+bGHlRvtpha+NJ2ZpukPV6UqBnn08qCmwpUoTVwdxYFcL0hg3aoCR9BsW7eHXL+P4dV6YqQShdWx9f3Dn7CqnTAWusnMJGnJWmaIHfzPviMzaKsKqHOd3J1IM+DPiKUESg8yzamQCqGd9BHGOVYzGKI0Numvu4gkwuxnYo2+EshDZQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b57cad-27a5-437f-0b5f-08d6d9a9b344
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 02:53:39.8934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3721
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

UGluZy4uLg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFuc29uIEh1
YW5nDQo+IFNlbnQ6IFRodXJzZGF5LCBNYXkgOSwgMjAxOSA5OjQ0IEFNDQo+IFRvOiAnQW5zb24g
SHVhbmcnIDxBbnNvbi5IdWFuZ0BueHAuY29tPjsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPiBtYXJr
LnJ1dGxhbmRAYXJtLmNvbTsgc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25p
eC5kZTsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207IGNhdGFs
aW4ubWFyaW5hc0Bhcm0uY29tOw0KPiB3aWxsLmRlYWNvbkBhcm0uY29tOyBydWkuemhhbmdAaW50
ZWwuY29tOyBlZHViZXp2YWxAZ21haWwuY29tOw0KPiBkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3Jn
OyBBaXNoZW5nIERvbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPjsNCj4gdWxmLmhhbnNzb25AbGlu
YXJvLm9yZzsgRGFuaWVsIEJhbHV0YSA8ZGFuaWVsLmJhbHV0YUBueHAuY29tPjsgUGVuZyBGYW4N
Cj4gPHBlbmcuZmFuQG54cC5jb20+OyBoZWlrb0BzbnRlY2guZGU7IGhvcm1zK3JlbmVzYXNAdmVy
Z2UubmV0LmF1Ow0KPiBhZ3Jvc3NAa2VybmVsLm9yZzsgb2xvZkBsaXhvbS5uZXQ7IGJqb3JuLmFu
ZGVyc3NvbkBsaW5hcm8ub3JnOw0KPiBqYWdhbkBhbWFydWxhc29sdXRpb25zLmNvbTsgZW5yaWMu
YmFsbGV0Ym9AY29sbGFib3JhLmNvbTsNCj4gbWFyYy53LmdvbnphbGV6QGZyZWUuZnI7IGRldmlj
ZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsg
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC0NCj4gcG1Admdlci5r
ZXJuZWwub3JnDQo+IENjOiBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJq
ZWN0OiBSRTogW1BBVENIIFYxMiAzLzVdIHRoZXJtYWw6IGlteF9zYzogYWRkIGkuTVggc3lzdGVt
IGNvbnRyb2xsZXINCj4gdGhlcm1hbCBzdXBwb3J0DQo+IA0KPiBQaW5nLi4uDQo+IA0KPiA+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogQW5zb24gSHVhbmcgW21haWx0bzpB
bnNvbi5IdWFuZ0BueHAuY29tXQ0KPiA+IFNlbnQ6IFR1ZXNkYXksIEFwcmlsIDE2LCAyMDE5IDEx
OjIyIEFNDQo+ID4gVG86IHJvYmgrZHRAa2VybmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207
IHNoYXduZ3VvQGtlcm5lbC5vcmc7DQo+ID4gcy5oYXVlckBwZW5ndXRyb25peC5kZTsga2VybmVs
QHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207DQo+ID4gY2F0YWxpbi5tYXJpbmFz
QGFybS5jb207IHdpbGwuZGVhY29uQGFybS5jb207IHJ1aS56aGFuZ0BpbnRlbC5jb207DQo+ID4g
ZWR1YmV6dmFsQGdtYWlsLmNvbTsgZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZzsgQWlzaGVuZyBE
b25nDQo+ID4gPGFpc2hlbmcuZG9uZ0BueHAuY29tPjsgdWxmLmhhbnNzb25AbGluYXJvLm9yZzsg
RGFuaWVsIEJhbHV0YQ0KPiA+IDxkYW5pZWwuYmFsdXRhQG54cC5jb20+OyBQZW5nIEZhbiA8cGVu
Zy5mYW5AbnhwLmNvbT47DQo+IGhlaWtvQHNudGVjaC5kZTsNCj4gPiBob3JtcytyZW5lc2FzQHZl
cmdlLm5ldC5hdTsgYWdyb3NzQGtlcm5lbC5vcmc7IG9sb2ZAbGl4b20ubmV0Ow0KPiA+IGJqb3Ju
LmFuZGVyc3NvbkBsaW5hcm8ub3JnOyBqYWdhbkBhbWFydWxhc29sdXRpb25zLmNvbTsNCj4gPiBl
bnJpYy5iYWxsZXRib0Bjb2xsYWJvcmEuY29tOyBtYXJjLncuZ29uemFsZXpAZnJlZS5mcjsNCj4g
PiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsgbGludXgtYXJtLQ0KPiA+IGtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1wbUB2
Z2VyLmtlcm5lbC5vcmcNCj4gPiBDYzogZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4N
Cj4gPiBTdWJqZWN0OiBbUEFUQ0ggVjEyIDMvNV0gdGhlcm1hbDogaW14X3NjOiBhZGQgaS5NWCBz
eXN0ZW0gY29udHJvbGxlcg0KPiA+IHRoZXJtYWwgc3VwcG9ydA0KPiA+DQo+ID4gaS5NWDhRWFAg
aXMgYW4gQVJNdjggU29DIHdoaWNoIGhhcyBhIENvcnRleC1NNCBzeXN0ZW0gY29udHJvbGxlcg0K
PiA+IGluc2lkZSwgdGhlIHN5c3RlbSBjb250cm9sbGVyIGlzIGluIGNoYXJnZSBvZiBjb250cm9s
bGluZyBwb3dlciwgY2xvY2sNCj4gPiBhbmQgdGhlcm1hbCBzZW5zb3JzIGV0Yy4uDQo+ID4NCj4g
PiBUaGlzIHBhdGNoIGFkZHMgaS5NWCBzeXN0ZW0gY29udHJvbGxlciB0aGVybWFsIGRyaXZlciBz
dXBwb3J0LCBMaW51eA0KPiA+IGtlcm5lbCBoYXMgdG8gY29tbXVuaWNhdGUgd2l0aCBzeXN0ZW0g
Y29udHJvbGxlciB2aWEgTVUgKG1lc3NhZ2UgdW5pdCkNCj4gPiBJUEMgdG8gZ2V0IGVhY2ggdGhl
cm1hbCBzZW5zb3IncyB0ZW1wZXJhdHVyZSwgaXQgc3VwcG9ydHMgbXVsdGlwbGUNCj4gPiBzZW5z
b3JzIHdoaWNoIGFyZSBwYXNzZWQgZnJvbSBkZXZpY2UgdHJlZSwgcGxlYXNlIHNlZSB0aGUgYmlu
ZGluZyBkb2MgZm9yDQo+IGRldGFpbHMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBI
dWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiBDaGFuZ2VzIHNpbmNlIFYx
MToNCj4gPiAJLSBtb3ZlIHRoZSBBUEkgb2YgZ2V0dGluZyB0aGVybWFsIHpvbmUgc2Vuc29yIElE
IHRvIG9mLXRoZXJtYWwuYyBhcw0KPiA+IGdlbmVyaWMgQVBJOw0KPiA+IAktIHJlbW92ZSB1bm5l
Y2Vzc2FyeSBfX3BhY2tlZC4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy90aGVybWFsL0tjb25maWcg
ICAgICAgICAgfCAgMTEgKysrKw0KPiA+ICBkcml2ZXJzL3RoZXJtYWwvTWFrZWZpbGUgICAgICAg
ICB8ICAgMSArDQo+ID4gIGRyaXZlcnMvdGhlcm1hbC9pbXhfc2NfdGhlcm1hbC5jIHwgMTM3DQo+
ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDMgZmlsZXMg
Y2hhbmdlZCwgMTQ5IGluc2VydGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZl
cnMvdGhlcm1hbC9pbXhfc2NfdGhlcm1hbC5jDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy90aGVybWFsL0tjb25maWcgYi9kcml2ZXJzL3RoZXJtYWwvS2NvbmZpZyBpbmRleA0KPiA+IDY1
M2FhMjcuLjRlNGZhN2UgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy90aGVybWFsL0tjb25maWcN
Cj4gPiArKysgYi9kcml2ZXJzL3RoZXJtYWwvS2NvbmZpZw0KPiA+IEBAIC0yMjMsNiArMjIzLDE3
IEBAIGNvbmZpZyBJTVhfVEhFUk1BTA0KPiA+ICAJICBjcHVmcmVxIGlzIHVzZWQgYXMgdGhlIGNv
b2xpbmcgZGV2aWNlIHRvIHRocm90dGxlIENQVXMgd2hlbiB0aGUNCj4gPiAgCSAgcGFzc2l2ZSB0
cmlwIGlzIGNyb3NzZWQuDQo+ID4NCj4gPiArY29uZmlnIElNWF9TQ19USEVSTUFMDQo+ID4gKwl0
cmlzdGF0ZSAiVGVtcGVyYXR1cmUgc2Vuc29yIGRyaXZlciBmb3IgTlhQIGkuTVggU29DcyB3aXRo
IFN5c3RlbQ0KPiA+IENvbnRyb2xsZXIiDQo+ID4gKwlkZXBlbmRzIG9uIChBUkNIX01YQyAmJiBJ
TVhfU0NVKSB8fCBDT01QSUxFX1RFU1QNCj4gPiArCWRlcGVuZHMgb24gT0YNCj4gPiArCWhlbHAN
Cj4gPiArCSAgU3VwcG9ydCBmb3IgVGVtcGVyYXR1cmUgTW9uaXRvciAoVEVNUE1PTikgZm91bmQg
b24gTlhQIGkuTVgNCj4gPiBTb0NzIHdpdGgNCj4gPiArCSAgc3lzdGVtIGNvbnRyb2xsZXIgaW5z
aWRlLCBMaW51eCBrZXJuZWwgaGFzIHRvIGNvbW11bmljYXRlIHdpdGgNCj4gPiBzeXN0ZW0NCj4g
PiArCSAgY29udHJvbGxlciB2aWEgTVUgKG1lc3NhZ2UgdW5pdCkgSVBDIHRvIGdldCB0ZW1wZXJh
dHVyZSBmcm9tDQo+ID4gdGhlcm1hbA0KPiA+ICsJICBzZW5zb3IuIEl0IHN1cHBvcnRzIG9uZSBj
cml0aWNhbCB0cmlwIHBvaW50IGFuZCBvbmUNCj4gPiArCSAgcGFzc2l2ZSB0cmlwIHBvaW50IGZv
ciBlYWNoIHRoZXJtYWwgc2Vuc29yLg0KPiA+ICsNCj4gPiAgY29uZmlnIE1BWDc3NjIwX1RIRVJN
QUwNCj4gPiAgCXRyaXN0YXRlICJUZW1wZXJhdHVyZSBzZW5zb3IgZHJpdmVyIGZvciBNYXhpbSBN
QVg3NzYyMCBQTUlDIg0KPiA+ICAJZGVwZW5kcyBvbiBNRkRfTUFYNzc2MjANCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy90aGVybWFsL01ha2VmaWxlIGIvZHJpdmVycy90aGVybWFsL01ha2VmaWxl
IGluZGV4DQo+ID4gNDg2ZDY4Mi4uNDA2MjYyNyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3Ro
ZXJtYWwvTWFrZWZpbGUNCj4gPiArKysgYi9kcml2ZXJzL3RoZXJtYWwvTWFrZWZpbGUNCj4gPiBA
QCAtNDAsNiArNDAsNyBAQCBvYmotJChDT05GSUdfREI4NTAwX1RIRVJNQUwpCSs9DQo+ID4gZGI4
NTAwX3RoZXJtYWwubw0KPiA+ICBvYmotJChDT05GSUdfQVJNQURBX1RIRVJNQUwpCSs9IGFybWFk
YV90aGVybWFsLm8NCj4gPiAgb2JqLSQoQ09ORklHX1RBTkdPX1RIRVJNQUwpCSs9IHRhbmdvX3Ro
ZXJtYWwubw0KPiA+ICBvYmotJChDT05GSUdfSU1YX1RIRVJNQUwpCSs9IGlteF90aGVybWFsLm8N
Cj4gPiArb2JqLSQoQ09ORklHX0lNWF9TQ19USEVSTUFMKQkrPSBpbXhfc2NfdGhlcm1hbC5vDQo+
ID4gIG9iai0kKENPTkZJR19NQVg3NzYyMF9USEVSTUFMKQkrPSBtYXg3NzYyMF90aGVybWFsLm8N
Cj4gPiAgb2JqLSQoQ09ORklHX1FPUklRX1RIRVJNQUwpCSs9IHFvcmlxX3RoZXJtYWwubw0KPiA+
ICBvYmotJChDT05GSUdfREE5MDYyX1RIRVJNQUwpCSs9IGRhOTA2Mi10aGVybWFsLm8NCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy90aGVybWFsL2lteF9zY190aGVybWFsLmMNCj4gPiBiL2RyaXZl
cnMvdGhlcm1hbC9pbXhfc2NfdGhlcm1hbC5jDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4g
PiBpbmRleCAwMDAwMDAwLi5kY2YxNmZjDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL2Ry
aXZlcnMvdGhlcm1hbC9pbXhfc2NfdGhlcm1hbC5jDQo+ID4gQEAgLTAsMCArMSwxMzcgQEANCj4g
PiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjArDQo+ID4gKy8qDQo+ID4gKyAq
IENvcHlyaWdodCAyMDE4LTIwMTkgTlhQLg0KPiA+ICsgKi8NCj4gPiArDQo+ID4gKyNpbmNsdWRl
IDxsaW51eC9lcnIuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L2Zpcm13YXJlL2lteC9zY2kuaD4N
Cj4gPiArI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvb2Yu
aD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L29mX2RldmljZS5oPg0KPiA+ICsjaW5jbHVkZSA8bGlu
dXgvcGxhdGZvcm1fZGV2aWNlLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9zbGFiLmg+DQo+ID4g
KyNpbmNsdWRlIDxsaW51eC90aGVybWFsLmg+DQo+ID4gKw0KPiA+ICsjaW5jbHVkZSAidGhlcm1h
bF9jb3JlLmgiDQo+ID4gKw0KPiA+ICsjZGVmaW5lIElNWF9TQ19NSVNDX0ZVTkNfR0VUX1RFTVAJ
MTMNCj4gPiArI2RlZmluZSBJTVhfU0NfQ19URU1QCQkJMA0KPiA+ICsNCj4gPiArc3RhdGljIHN0
cnVjdCBpbXhfc2NfaXBjICp0aGVybWFsX2lwY19oYW5kbGU7DQo+ID4gKw0KPiA+ICtzdHJ1Y3Qg
aW14X3NjX3NlbnNvciB7DQo+ID4gKwlzdHJ1Y3QgdGhlcm1hbF96b25lX2RldmljZSAqdHpkOw0K
PiA+ICsJdTMyIHJlc291cmNlX2lkOw0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArc3RydWN0IHJlcV9n
ZXRfdGVtcCB7DQo+ID4gKwl1MTYgcmVzb3VyY2VfaWQ7DQo+ID4gKwl1OCB0eXBlOw0KPiA+ICt9
IF9fcGFja2VkOw0KPiA+ICsNCj4gPiArc3RydWN0IHJlc3BfZ2V0X3RlbXAgew0KPiA+ICsJdTE2
IGNlbHNpdXM7DQo+ID4gKwl1OCB0ZW50aHM7DQo+ID4gK30gX19wYWNrZWQ7DQo+ID4gKw0KPiA+
ICtzdHJ1Y3QgaW14X3NjX21zZ19taXNjX2dldF90ZW1wIHsNCj4gPiArCXN0cnVjdCBpbXhfc2Nf
cnBjX21zZyBoZHI7DQo+ID4gKwl1bmlvbiB7DQo+ID4gKwkJc3RydWN0IHJlcV9nZXRfdGVtcCBy
ZXE7DQo+ID4gKwkJc3RydWN0IHJlc3BfZ2V0X3RlbXAgcmVzcDsNCj4gPiArCX0gZGF0YTsNCj4g
PiArfTsNCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgaW14X3NjX3RoZXJtYWxfZ2V0X3RlbXAodm9p
ZCAqZGF0YSwgaW50ICp0ZW1wKSB7DQo+ID4gKwlzdHJ1Y3QgaW14X3NjX21zZ19taXNjX2dldF90
ZW1wIG1zZzsNCj4gPiArCXN0cnVjdCBpbXhfc2NfcnBjX21zZyAqaGRyID0gJm1zZy5oZHI7DQo+
ID4gKwlzdHJ1Y3QgaW14X3NjX3NlbnNvciAqc2Vuc29yID0gZGF0YTsNCj4gPiArCWludCByZXQ7
DQo+ID4gKw0KPiA+ICsJbXNnLmRhdGEucmVxLnJlc291cmNlX2lkID0gc2Vuc29yLT5yZXNvdXJj
ZV9pZDsNCj4gPiArCW1zZy5kYXRhLnJlcS50eXBlID0gSU1YX1NDX0NfVEVNUDsNCj4gPiArDQo+
ID4gKwloZHItPnZlciA9IElNWF9TQ19SUENfVkVSU0lPTjsNCj4gPiArCWhkci0+c3ZjID0gSU1Y
X1NDX1JQQ19TVkNfTUlTQzsNCj4gPiArCWhkci0+ZnVuYyA9IElNWF9TQ19NSVNDX0ZVTkNfR0VU
X1RFTVA7DQo+ID4gKwloZHItPnNpemUgPSAyOw0KPiA+ICsNCj4gPiArCXJldCA9IGlteF9zY3Vf
Y2FsbF9ycGModGhlcm1hbF9pcGNfaGFuZGxlLCAmbXNnLCB0cnVlKTsNCj4gPiArCWlmIChyZXQp
IHsNCj4gPiArCQlwcl9lcnIoInJlYWQgdGVtcCBzZW5zb3IgJWQgZmFpbGVkLCByZXQgJWRcbiIs
DQo+ID4gKwkJCXNlbnNvci0+cmVzb3VyY2VfaWQsIHJldCk7DQo+ID4gKwkJcmV0dXJuIHJldDsN
Cj4gPiArCX0NCj4gPiArDQo+ID4gKwkqdGVtcCA9IG1zZy5kYXRhLnJlc3AuY2Vsc2l1cyAqIDEw
MDAgKyBtc2cuZGF0YS5yZXNwLnRlbnRocyAqIDEwMDsNCj4gPiArDQo+ID4gKwlyZXR1cm4gMDsN
Cj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCB0aGVybWFsX3pvbmVfb2Zf
ZGV2aWNlX29wcyBpbXhfc2NfdGhlcm1hbF9vcHMgPSB7DQo+ID4gKwkuZ2V0X3RlbXAgPSBpbXhf
c2NfdGhlcm1hbF9nZXRfdGVtcCwgfTsNCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgaW14X3NjX3Ro
ZXJtYWxfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikgew0KPiA+ICsJc3RydWN0
IGRldmljZV9ub2RlICpucCwgKmNoaWxkOw0KPiA+ICsJaW50IHJldDsNCj4gPiArDQo+ID4gKwly
ZXQgPSBpbXhfc2N1X2dldF9oYW5kbGUoJnRoZXJtYWxfaXBjX2hhbmRsZSk7DQo+ID4gKwlpZiAo
cmV0KQ0KPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gKw0KPiA+ICsJbnAgPSBvZl9maW5kX25vZGVf
YnlfbmFtZShOVUxMLCAidGhlcm1hbC16b25lcyIpOw0KPiA+ICsJaWYgKCFucCkNCj4gPiArCQly
ZXR1cm4gLUVOT0RFVjsNCj4gPiArDQo+ID4gKwlmb3JfZWFjaF9hdmFpbGFibGVfY2hpbGRfb2Zf
bm9kZShucCwgY2hpbGQpIHsNCj4gPiArCQlzdHJ1Y3Qgb2ZfcGhhbmRsZV9hcmdzIHNlbnNvcl9z
cGVjczsNCj4gPiArCQlzdHJ1Y3QgaW14X3NjX3NlbnNvciAqc2Vuc29yID0NCj4gPiArCQkJZGV2
bV9remFsbG9jKCZwZGV2LT5kZXYsIHNpemVvZigqc2Vuc29yKSwNCj4gPiBHRlBfS0VSTkVMKTsN
Cj4gPiArCQlpZiAoIXNlbnNvcikNCj4gPiArCQkJcmV0dXJuIC1FTk9NRU07DQo+ID4gKw0KPiA+
ICsJCXJldCA9IHRoZXJtYWxfem9uZV9vZl9nZXRfc2Vuc29yX2lkKGNoaWxkLA0KPiA+ICsJCQkJ
CQkgICAgJnNlbnNvcl9zcGVjcywNCj4gPiArCQkJCQkJICAgICZzZW5zb3ItPnJlc291cmNlX2lk
KTsNCj4gPiArCQlpZiAocmV0IDwgMCkgew0KPiA+ICsJCQlkZXZfZXJyKCZwZGV2LT5kZXYsDQo+
ID4gKwkJCQkiZmFpbGVkIHRvIGdldCB2YWxpZCBzZW5zb3IgcmVzb3VyY2UgaWQ6ICVkXG4iLA0K
PiA+ICsJCQkJcmV0KTsNCj4gPiArCQkJYnJlYWs7DQo+ID4gKwkJfQ0KPiA+ICsNCj4gPiArCQlz
ZW5zb3ItPnR6ZCA9DQo+ID4gZGV2bV90aGVybWFsX3pvbmVfb2Zfc2Vuc29yX3JlZ2lzdGVyKCZw
ZGV2LT5kZXYsDQo+ID4gKwkJCQkJCQkJICAgc2Vuc29yLQ0KPiA+ID5yZXNvdXJjZV9pZCwNCj4g
PiArCQkJCQkJCQkgICBzZW5zb3IsDQo+ID4gKw0KPiA+ICZpbXhfc2NfdGhlcm1hbF9vcHMpOw0K
PiA+ICsJCWlmIChJU19FUlIoc2Vuc29yLT50emQpKSB7DQo+ID4gKwkJCWRldl9lcnIoJnBkZXYt
PmRldiwgImZhaWxlZCB0byByZWdpc3RlciB0aGVybWFsDQo+ID4gem9uZVxuIik7DQo+ID4gKwkJ
CXJldCA9IFBUUl9FUlIoc2Vuc29yLT50emQpOw0KPiA+ICsJCQlicmVhazsNCj4gPiArCQl9DQo+
ID4gKwl9DQo+ID4gKw0KPiA+ICsJcmV0dXJuIHJldDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3Rh
dGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgaW14X3NjX3RoZXJtYWxfdGFibGVbXSA9IHsN
Cj4gPiArCXsgLmNvbXBhdGlibGUgPSAiZnNsLGlteC1zYy10aGVybWFsIiwgfSwNCj4gPiArCXt9
DQo+ID4gK307DQo+ID4gK01PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIGlteF9zY190aGVybWFsX3Rh
YmxlKTsNCj4gPiArDQo+ID4gK3N0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIGlteF9zY190
aGVybWFsX2RyaXZlciA9IHsNCj4gPiArCQkucHJvYmUgPSBpbXhfc2NfdGhlcm1hbF9wcm9iZSwN
Cj4gPiArCQkuZHJpdmVyID0gew0KPiA+ICsJCQkubmFtZSA9ICJpbXgtc2MtdGhlcm1hbCIsDQo+
ID4gKwkJCS5vZl9tYXRjaF90YWJsZSA9IGlteF9zY190aGVybWFsX3RhYmxlLA0KPiA+ICsJCX0s
DQo+ID4gK307DQo+ID4gK21vZHVsZV9wbGF0Zm9ybV9kcml2ZXIoaW14X3NjX3RoZXJtYWxfZHJp
dmVyKTsNCj4gPiArDQo+ID4gK01PRFVMRV9BVVRIT1IoIkFuc29uIEh1YW5nIDxBbnNvbi5IdWFu
Z0BueHAuY29tPiIpOw0KPiA+ICtNT0RVTEVfREVTQ1JJUFRJT04oIlRoZXJtYWwgZHJpdmVyIGZv
ciBOWFAgaS5NWCBTb0NzIHdpdGggc3lzdGVtDQo+ID4gK2NvbnRyb2xsZXIiKTsgTU9EVUxFX0xJ
Q0VOU0UoIkdQTCB2MiIpOw0KPiA+IC0tDQo+ID4gMi43LjQNCg0K
