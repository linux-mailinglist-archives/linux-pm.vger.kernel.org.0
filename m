Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 571C0213CA
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2019 08:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfEQGhX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 May 2019 02:37:23 -0400
Received: from mail-eopbgr30053.outbound.protection.outlook.com ([40.107.3.53]:61953
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727145AbfEQGhW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 17 May 2019 02:37:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUccQsBUjRxK4ygUH5eCieEDkHct8Z6TgaBZ99cFDPk=;
 b=bxL1vJtOv47E5TsBuDypM+4V0Ri4s9pYaFAuRGKf5KYcmPrGVNcRNwP8PnNE496wKVS0HHmfypvfjUN8EE3tQzNUF241jBCrc9pYPvqMRK24FJCcC7jD2aSe0zAELY44NhwY7v/hxiUbOIKuY9EhrpMd18uI6h2CQjVfLkKAIVY=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3706.eurprd04.prod.outlook.com (52.134.66.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Fri, 17 May 2019 06:37:11 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d%2]) with mapi id 15.20.1900.010; Fri, 17 May 2019
 06:37:11 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
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
Subject: RE: [PATCH V12 2/5] thermal: of-thermal: add API for getting sensor
 ID from DT
Thread-Topic: [PATCH V12 2/5] thermal: of-thermal: add API for getting sensor
 ID from DT
Thread-Index: AQHU9AOYmR6BJ3silEqzBa3crqYckaZtrlcAgAFe9pA=
Date:   Fri, 17 May 2019 06:37:10 +0000
Message-ID: <DB3PR0402MB39160D163B1EE70182FE4EBEF50B0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1555384609-7030-1-git-send-email-Anson.Huang@nxp.com>
 <1555384609-7030-2-git-send-email-Anson.Huang@nxp.com>
 <d9c719c4-b5d1-580f-218e-0421126310e1@linaro.org>
In-Reply-To: <d9c719c4-b5d1-580f-218e-0421126310e1@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78325f48-e1d1-4b6d-bdfc-08d6da921760
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3706;
x-ms-traffictypediagnostic: DB3PR0402MB3706:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <DB3PR0402MB370655FEA8EB2883A12C9B9AF50B0@DB3PR0402MB3706.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0040126723
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(366004)(396003)(39860400002)(199004)(189003)(13464003)(3846002)(6116002)(110136005)(25786009)(316002)(102836004)(446003)(11346002)(8676002)(186003)(33656002)(81166006)(81156014)(8936002)(486006)(99286004)(7696005)(7736002)(305945005)(476003)(53546011)(6506007)(44832011)(76176011)(5660300002)(2906002)(66066001)(26005)(66556008)(2501003)(64756008)(66476007)(6246003)(53936002)(71190400001)(71200400001)(9686003)(66446008)(6306002)(74316002)(55016002)(4326008)(6436002)(76116006)(73956011)(66946007)(229853002)(68736007)(256004)(7416002)(86362001)(2201001)(478600001)(52536014)(14454004)(921003)(15866825006)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3706;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pymYk9XwOJzeu3ov5eqQAKk/FQXC0y2fn+WUXTDFY0v3ICuQJ/R4ikz2Y/UsA22259d1e63QEe7j0c8dA5zj4BHd9eKu/SHzskyvmexBJRSO/3gm2Lx+LquCoc4yHeOTmQau/GlXmtjMww7Ez256aVUC0BP8vJzsHGuck0oX9VmzJfK8Lb/dgZlkucAUhWP9Www+tftgtTP4M8Wm/DCFC8AUFFO8/ZYPODmEX35qdwrgsOerK5km1tPtgC4B17HDIw5r0RgJZOvTD5VYp80qyibTqL65njYq0ee9V+Lmnzy5DCL5wzDB2Ki0UqIN1ubBCSoQV+L4sNp4hUX9Z3n8uk+FY7Za2cTgOCmdocOGlwXdBx6/bV4LUcST31Y5GasHcc7fUqojboIjm65VL1wEPE00SG7SYXuRxZXKVCk8u9A=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78325f48-e1d1-4b6d-bdfc-08d6da921760
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2019 06:37:10.9678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3706
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFuaWVsIExlemNhbm8g
W21haWx0bzpkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnXQ0KPiBTZW50OiBUaHVyc2RheSwgTWF5
IDE2LCAyMDE5IDU6MzkgUE0NCj4gVG86IEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29t
Pjsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPiBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgc2hhd25ndW9A
a2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsNCj4ga2VybmVsQHBlbmd1dHJvbml4
LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tOw0KPiB3aWxs
LmRlYWNvbkBhcm0uY29tOyBydWkuemhhbmdAaW50ZWwuY29tOyBlZHViZXp2YWxAZ21haWwuY29t
Ow0KPiBBaXNoZW5nIERvbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPjsgdWxmLmhhbnNzb25AbGlu
YXJvLm9yZzsgRGFuaWVsDQo+IEJhbHV0YSA8ZGFuaWVsLmJhbHV0YUBueHAuY29tPjsgUGVuZyBG
YW4gPHBlbmcuZmFuQG54cC5jb20+Ow0KPiBoZWlrb0BzbnRlY2guZGU7IGhvcm1zK3JlbmVzYXNA
dmVyZ2UubmV0LmF1OyBhZ3Jvc3NAa2VybmVsLm9yZzsNCj4gb2xvZkBsaXhvbS5uZXQ7IGJqb3Ju
LmFuZGVyc3NvbkBsaW5hcm8ub3JnOyBqYWdhbkBhbWFydWxhc29sdXRpb25zLmNvbTsNCj4gZW5y
aWMuYmFsbGV0Ym9AY29sbGFib3JhLmNvbTsgbWFyYy53LmdvbnphbGV6QGZyZWUuZnI7DQo+IGRl
dmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1hcm0tDQo+IGtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1wbUB2Z2VyLmtl
cm5lbC5vcmcNCj4gQ2M6IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggVjEyIDIvNV0gdGhlcm1hbDogb2YtdGhlcm1hbDogYWRkIEFQSSBmb3Ig
Z2V0dGluZyBzZW5zb3INCj4gSUQgZnJvbSBEVA0KPiANCj4gT24gMTYvMDQvMjAxOSAwNToyMiwg
QW5zb24gSHVhbmcgd3JvdGU6DQo+ID4gT24gc29tZSBwbGF0Zm9ybXMgbGlrZSBpLk1YOFFYUCwg
dGhlIHRoZXJtYWwgZHJpdmVyIG5lZWRzIGEgcmVhbCBIVw0KPiA+IHNlbnNvciBJRCBmcm9tIERU
IHRoZXJtYWwgem9uZSwgdGhlIEhXIHNlbnNvciBJRCBpcyB1c2VkIHRvIGdldA0KPiA+IHRlbXBl
cmF0dXJlIGZyb20gU0NVIGZpcm13YXJlLCBhbmQgdGhlIHZpcnR1YWwgc2Vuc29yIElEIHN0YXJ0
aW5nIGZyb20NCj4gPiAwIHRvIE4gaXMgTk9UIHVzZWQgYXQgYWxsLCB0aGlzIHBhdGNoIGFkZHMg
bmV3IEFQSQ0KPiA+IHRoZXJtYWxfem9uZV9vZl9nZXRfc2Vuc29yX2lkKCkgdG8gcHJvdmlkZSB0
aGUgZmVhdHVyZSBvZiBnZXR0aW5nDQo+ID4gc2Vuc29yIElEIGZyb20gRFQgdGhlcm1hbCB6b25l
J3Mgbm9kZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFu
Z0BueHAuY29tPg0KPiANCj4gRWR1YXJkbz8NCj4gDQo+IFdoYXQgZG8geW91IHRoaW5rIGFib3V0
IHRoaXMgcGF0Y2g/DQoNCkkgd291bGQgbGlrZSB0byBoZWFyIEVkdWFyZG8ncyBvcGluaW9uIGFi
b3V0IHRoaXMgcGF0Y2ggYmVmb3JlIHNlbmRpbmcgb3V0IGEgbmV3IHZlcnNpb24NCmZvciByZXZp
ZXcsIHRoYW5rcy4NCg0KQW5zb24uDQoNCj4gDQo+ID4gLS0tDQo+ID4gTmV3IHBhdGNoLg0KPiA+
IC0tLQ0KPiA+ICBkcml2ZXJzL3RoZXJtYWwvb2YtdGhlcm1hbC5jIHwgNTMNCj4gKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0NCj4gPiAgaW5jbHVkZS9saW51eC90
aGVybWFsLmggICAgICB8IDEwICsrKysrKysrKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDUxIGlu
c2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdGhlcm1hbC9vZi10aGVybWFsLmMNCj4gPiBiL2RyaXZlcnMvdGhlcm1hbC9vZi10aGVybWFs
LmMgaW5kZXggMmRmMDU5Yy4uMmU0MzIwYyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3RoZXJt
YWwvb2YtdGhlcm1hbC5jDQo+ID4gKysrIGIvZHJpdmVycy90aGVybWFsL29mLXRoZXJtYWwuYw0K
PiA+IEBAIC00NDYsNiArNDQ2LDQ2IEBAIHRoZXJtYWxfem9uZV9vZl9hZGRfc2Vuc29yKHN0cnVj
dCBkZXZpY2Vfbm9kZQ0KPiA+ICp6b25lLCAgfQ0KPiA+DQo+ID4gIC8qKg0KPiA+ICsgKiB0aGVy
bWFsX3pvbmVfb2ZfZ2V0X3NlbnNvcl9pZCAtIGdldCBzZW5zb3IgSUQgZnJvbSBhIERUIHRoZXJt
YWwNCj4gPiArIHpvbmUNCj4gPiArICogQHR6X25wOiBhIHZhbGlkIHRoZXJtYWwgem9uZSBkZXZp
Y2Ugbm9kZS4NCj4gPiArICogQHNlbnNvcl9zcGVjczogcG9pbnRlciB0byBvdXRwdXQgYXJndW1l
bnRzIHN0cnVjdHVyZSB3aWxsIGJlIHBhc3NlZA0KPiBiYWNrLg0KPiA+ICsgKiBAaWQ6IGEgc2Vu
c29yIElEIHBvaW50ZXIgd2lsbCBiZSBwYXNzZWQgYmFjay4NCj4gPiArICoNCj4gPiArICogVGhp
cyBmdW5jdGlvbiB3aWxsIGdldCBzZW5zb3IgSUQgZnJvbSBhIGdpdmVuIHRoZXJtYWwgem9uZSBu
b2RlLA0KPiA+ICsgdXNlDQo+ID4gKyAqICJ0aGVybWFsLXNlbnNvcnMiIGFzIGxpc3QgbmFtZSwg
YW5kIGdldCBzZW5zb3IgSUQgZnJvbSBmaXJzdA0KPiA+ICsgcGhhbmRsZSdzDQo+ID4gKyAqIGFy
Z3VtZW50Lg0KPiA+ICsgKg0KPiA+ICsgKiBSZXR1cm46IDAgb24gc3VjY2VzcywgcHJvcGVyIGVy
cm9yIGNvZGUgb3RoZXJ3aXNlLg0KPiA+ICsgKi8NCj4gPiArDQo+ID4gK2ludCB0aGVybWFsX3pv
bmVfb2ZfZ2V0X3NlbnNvcl9pZChzdHJ1Y3QgZGV2aWNlX25vZGUgKnR6X25wLA0KPiA+ICsJCQkJ
ICBzdHJ1Y3Qgb2ZfcGhhbmRsZV9hcmdzICpzZW5zb3Jfc3BlY3MsDQo+ID4gKwkJCQkgIHUzMiAq
aWQpDQo+ID4gK3sNCj4gPiArCWludCByZXQ7DQo+ID4gKw0KPiA+ICsJcmV0ID0gb2ZfcGFyc2Vf
cGhhbmRsZV93aXRoX2FyZ3ModHpfbnAsDQo+ID4gKwkJCQkJICJ0aGVybWFsLXNlbnNvcnMiLA0K
PiA+ICsJCQkJCSAiI3RoZXJtYWwtc2Vuc29yLWNlbGxzIiwNCj4gPiArCQkJCQkgMCwNCj4gPiAr
CQkJCQkgc2Vuc29yX3NwZWNzKTsNCj4gPiArCWlmIChyZXQpDQo+ID4gKwkJcmV0dXJuIHJldDsN
Cj4gPiArDQo+ID4gKwlpZiAoc2Vuc29yX3NwZWNzLT5hcmdzX2NvdW50ID49IDEpIHsNCj4gPiAr
CQkqaWQgPSBzZW5zb3Jfc3BlY3MtPmFyZ3NbMF07DQo+ID4gKwkJV0FSTihzZW5zb3Jfc3BlY3Mt
PmFyZ3NfY291bnQgPiAxLA0KPiA+ICsJCSAgICAgIiVwT0ZuOiB0b28gbWFueSBjZWxscyBpbiBz
ZW5zb3Igc3BlY2lmaWVyICVkXG4iLA0KPiA+ICsJCSAgICAgc2Vuc29yX3NwZWNzLT5ucCwgc2Vu
c29yX3NwZWNzLT5hcmdzX2NvdW50KTsNCj4gPiArCX0gZWxzZSB7DQo+ID4gKwkJKmlkID0gMDsN
Cj4gPiArCX0NCj4gPiArDQo+ID4gKwlyZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICtFWFBPUlRfU1lN
Qk9MX0dQTCh0aGVybWFsX3pvbmVfb2ZfZ2V0X3NlbnNvcl9pZCk7DQo+ID4gKw0KPiA+ICsvKioN
Cj4gPiAgICogdGhlcm1hbF96b25lX29mX3NlbnNvcl9yZWdpc3RlciAtIHJlZ2lzdGVycyBhIHNl
bnNvciB0byBhIERUIHRoZXJtYWwNCj4gem9uZQ0KPiA+ICAgKiBAZGV2OiBhIHZhbGlkIHN0cnVj
dCBkZXZpY2UgcG9pbnRlciBvZiBhIHNlbnNvciBkZXZpY2UuIE11c3QgY29udGFpbg0KPiA+ICAg
KiAgICAgICBhIHZhbGlkIC5vZl9ub2RlLCBmb3IgdGhlIHNlbnNvciBub2RlLg0KPiA+IEBAIC01
MDAsMjEgKzU0MCwxMCBAQCB0aGVybWFsX3pvbmVfb2Zfc2Vuc29yX3JlZ2lzdGVyKHN0cnVjdCBk
ZXZpY2UNCj4gKmRldiwgaW50IHNlbnNvcl9pZCwgdm9pZCAqZGF0YSwNCj4gPiAgCQlpbnQgcmV0
LCBpZDsNCj4gPg0KPiA+ICAJCS8qIEZvciBub3csIHRoZXJtYWwgZnJhbWV3b3JrIHN1cHBvcnRz
IG9ubHkgMSBzZW5zb3IgcGVyDQo+IHpvbmUgKi8NCj4gPiAtCQlyZXQgPSBvZl9wYXJzZV9waGFu
ZGxlX3dpdGhfYXJncyhjaGlsZCwgInRoZXJtYWwtc2Vuc29ycyIsDQo+ID4gLQkJCQkJCSAiI3Ro
ZXJtYWwtc2Vuc29yLWNlbGxzIiwNCj4gPiAtCQkJCQkJIDAsICZzZW5zb3Jfc3BlY3MpOw0KPiA+
ICsJCXJldCA9IHRoZXJtYWxfem9uZV9vZl9nZXRfc2Vuc29yX2lkKGNoaWxkLCAmc2Vuc29yX3Nw
ZWNzLA0KPiAmaWQpOw0KPiA+ICAJCWlmIChyZXQpDQo+ID4gIAkJCWNvbnRpbnVlOw0KPiA+DQo+
ID4gLQkJaWYgKHNlbnNvcl9zcGVjcy5hcmdzX2NvdW50ID49IDEpIHsNCj4gPiAtCQkJaWQgPSBz
ZW5zb3Jfc3BlY3MuYXJnc1swXTsNCj4gPiAtCQkJV0FSTihzZW5zb3Jfc3BlY3MuYXJnc19jb3Vu
dCA+IDEsDQo+ID4gLQkJCSAgICAgIiVwT0ZuOiB0b28gbWFueSBjZWxscyBpbiBzZW5zb3Igc3Bl
Y2lmaWVyICVkXG4iLA0KPiA+IC0JCQkgICAgIHNlbnNvcl9zcGVjcy5ucCwgc2Vuc29yX3NwZWNz
LmFyZ3NfY291bnQpOw0KPiA+IC0JCX0gZWxzZSB7DQo+ID4gLQkJCWlkID0gMDsNCj4gPiAtCQl9
DQo+ID4gLQ0KPiA+ICAJCWlmIChzZW5zb3Jfc3BlY3MubnAgPT0gc2Vuc29yX25wICYmIGlkID09
IHNlbnNvcl9pZCkgew0KPiA+ICAJCQl0emQgPSB0aGVybWFsX3pvbmVfb2ZfYWRkX3NlbnNvcihj
aGlsZCwgc2Vuc29yX25wLA0KPiA+ICAJCQkJCQkJIGRhdGEsIG9wcyk7DQo+ID4gZGlmZiAtLWdp
dCBhL2luY2x1ZGUvbGludXgvdGhlcm1hbC5oIGIvaW5jbHVkZS9saW51eC90aGVybWFsLmggaW5k
ZXgNCj4gPiA1ZjQ3MDVmLi45NzBmYjM3IDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvbGludXgv
dGhlcm1hbC5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC90aGVybWFsLmgNCj4gPiBAQCAtMzc1
LDYgKzM3NSw5IEBAIHN0cnVjdCB0aGVybWFsX3RyaXAgew0KPiA+DQo+ID4gIC8qIEZ1bmN0aW9u
IGRlY2xhcmF0aW9ucyAqLw0KPiA+ICAjaWZkZWYgQ09ORklHX1RIRVJNQUxfT0YNCj4gPiAraW50
IHRoZXJtYWxfem9uZV9vZl9nZXRfc2Vuc29yX2lkKHN0cnVjdCBkZXZpY2Vfbm9kZSAqdHpfbnAs
DQo+ID4gKwkJCQkgIHN0cnVjdCBvZl9waGFuZGxlX2FyZ3MgKnNlbnNvcl9zcGVjcywNCj4gPiAr
CQkJCSAgdTMyICppZCk7DQo+ID4gIHN0cnVjdCB0aGVybWFsX3pvbmVfZGV2aWNlICoNCj4gPiAg
dGhlcm1hbF96b25lX29mX3NlbnNvcl9yZWdpc3RlcihzdHJ1Y3QgZGV2aWNlICpkZXYsIGludCBp
ZCwgdm9pZCAqZGF0YSwNCj4gPiAgCQkJCWNvbnN0IHN0cnVjdCB0aGVybWFsX3pvbmVfb2ZfZGV2
aWNlX29wcw0KPiAqb3BzKTsgQEAgLTM4Niw2ICszODksMTMNCj4gPiBAQCBzdHJ1Y3QgdGhlcm1h
bF96b25lX2RldmljZQ0KPiAqZGV2bV90aGVybWFsX3pvbmVfb2Zfc2Vuc29yX3JlZ2lzdGVyKA0K
PiA+ICB2b2lkIGRldm1fdGhlcm1hbF96b25lX29mX3NlbnNvcl91bnJlZ2lzdGVyKHN0cnVjdCBk
ZXZpY2UgKmRldiwNCj4gPiAgCQkJCQkgICAgc3RydWN0IHRoZXJtYWxfem9uZV9kZXZpY2UgKnR6
KTsNCj4gI2Vsc2UNCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgdGhlcm1hbF96b25lX29mX2dldF9z
ZW5zb3JfaWQoc3RydWN0IGRldmljZV9ub2RlICp0el9ucCwNCj4gPiArCQkJCQkgc3RydWN0IG9m
X3BoYW5kbGVfYXJncw0KPiAqc2Vuc29yX3NwZWNzLA0KPiA+ICsJCQkJCSB1MzIgKmlkKQ0KPiA+
ICt7DQo+ID4gKwlyZXR1cm4gLUVOT0VOVDsNCj4gPiArfQ0KPiA+ICBzdGF0aWMgaW5saW5lIHN0
cnVjdCB0aGVybWFsX3pvbmVfZGV2aWNlICoNCj4gPiB0aGVybWFsX3pvbmVfb2Zfc2Vuc29yX3Jl
Z2lzdGVyKHN0cnVjdCBkZXZpY2UgKmRldiwgaW50IGlkLCB2b2lkICpkYXRhLA0KPiA+ICAJCQkJ
Y29uc3Qgc3RydWN0IHRoZXJtYWxfem9uZV9vZl9kZXZpY2Vfb3BzDQo+ICpvcHMpDQo+ID4NCj4g
DQo+IA0KPiAtLQ0KPiANCj4gPGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0
bG9vay5jb20vP3VybD1odHRwJTNBJTJGJTJGd3d3Lg0KPiBsaW5hcm8ub3JnJTJGJmFtcDtkYXRh
PTAyJTdDMDElN0NhbnNvbi5odWFuZyU0MG54cC5jb20lN0NhODliMzENCj4gZTg2OTBkNGZiYTNl
OGIwOGQ2ZDllMjU0ODglN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3DQo+IEMw
JTdDMCU3QzYzNjkzNTk2MzQzOTk0ODEzOCZhbXA7c2RhdGE9Z0FZVTVwaTFJc2olMkJoZlJFTjhu
NnYwMw0KPiBMYiUyRjllUnpEekMyb2NEZGZlJTJCa2MlM0QmYW1wO3Jlc2VydmVkPTA+IExpbmFy
by5vcmcg4pSCIE9wZW4NCj4gc291cmNlIHNvZnR3YXJlIGZvciBBUk0gU29Dcw0KPiANCj4gRm9s
bG93IExpbmFybzoNCj4gPGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9v
ay5jb20vP3VybD1odHRwJTNBJTJGJTJGd3d3Lg0KPiBmYWNlYm9vay5jb20lMkZwYWdlcyUyRkxp
bmFybyZhbXA7ZGF0YT0wMiU3QzAxJTdDYW5zb24uaHVhbmclNA0KPiAwbnhwLmNvbSU3Q2E4OWIz
MWU4NjkwZDRmYmEzZThiMDhkNmQ5ZTI1NDg4JTdDNjg2ZWExZDNiYzJiNGM2ZmENCj4gOTJjZDk5
YzVjMzAxNjM1JTdDMCU3QzAlN0M2MzY5MzU5NjM0Mzk5NDgxMzgmYW1wO3NkYXRhPWolMkZvJTIN
Cj4gQkZOOG1BTEdCVmhWUWZLb1loaWpEdzUxRmhjR2phY2tDYVVsJTJCWSUyRlElM0QmYW1wO3Jl
c2VydmVkPQ0KPiAwPiBGYWNlYm9vayB8DQo+IDxodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90
ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUyRnR3aXR0ZQ0KPiByLmNvbSUyRiUy
MyElMkZsaW5hcm9vcmcmYW1wO2RhdGE9MDIlN0MwMSU3Q2Fuc29uLmh1YW5nJTQwbnhwLmMNCj4g
b20lN0NhODliMzFlODY5MGQ0ZmJhM2U4YjA4ZDZkOWUyNTQ4OCU3QzY4NmVhMWQzYmMyYjRjNmZh
OTJjZDkNCj4gOWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM2OTM1OTYzNDM5OTQ4MTM4JmFtcDtzZGF0
YT1PJTJCcnklMkZkaw0KPiBVR3VPMjJicllUTWF6JTJGQ3ZHT1VOdDE1V0pGOHVBTExWZ2l3ayUz
RCZhbXA7cmVzZXJ2ZWQ9MD4NCj4gVHdpdHRlciB8DQo+IDxodHRwczovL2V1cjAxLnNhZmVsaW5r
cy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUyRnd3dy4NCj4gbGluYXJv
Lm9yZyUyRmxpbmFyby0NCj4gYmxvZyUyRiZhbXA7ZGF0YT0wMiU3QzAxJTdDYW5zb24uaHVhbmcl
NDBueHAuY29tJTdDYTg5YjMxZTg2OQ0KPiAwZDRmYmEzZThiMDhkNmQ5ZTI1NDg4JTdDNjg2ZWEx
ZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTcNCj4gQzAlN0M2MzY5MzU5NjM0Mzk5NDgx
MzgmYW1wO3NkYXRhPVdMSGFoeCUyQnJ5dkJwcmRvTlVFdlE0a0NuWQ0KPiBGbVV1cWdBMTR4cUhq
UzdXSFUlM0QmYW1wO3Jlc2VydmVkPTA+IEJsb2cNCg0K
