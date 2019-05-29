Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDE3E2D44A
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2019 05:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbfE2Dgu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 May 2019 23:36:50 -0400
Received: from mail-eopbgr50061.outbound.protection.outlook.com ([40.107.5.61]:6704
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725828AbfE2Dgu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 28 May 2019 23:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LAXxFt9W1FFyEge1An0kLLJhyQITNqYJP24u5hZ0gfM=;
 b=VFvEGUxg2U+qSwyzYb2naw6Xv5gdCkOSX7/ArVjGcVKiesMy2i+sdfjDmwzHHPx4RO6sempvrGtrq+YrAGsqssFDDG1kJuz7yapn9OrL9E1yCw8uCIP9aoryUZkj2zP2A2V5e6Tpudb2gtKAHwXBFEg01bOU4tZLulgldZqSkxU=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3898.eurprd04.prod.outlook.com (52.134.65.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.15; Wed, 29 May 2019 03:36:37 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec%5]) with mapi id 15.20.1922.021; Wed, 29 May 2019
 03:36:37 +0000
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
Thread-Index: AQHVFRtF1HyUf82e5E+mJmD7zHGxLKaBa66AgAAIvwA=
Date:   Wed, 29 May 2019 03:36:37 +0000
Message-ID: <DB3PR0402MB3916A099D7DE4F89D3F50CB3F51F0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190528060621.47342-1-Anson.Huang@nxp.com>
 <20190528060621.47342-2-Anson.Huang@nxp.com>
 <20190529030225.GA2662@localhost.localdomain>
In-Reply-To: <20190529030225.GA2662@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4bdb87fe-b2a3-4989-2a19-08d6e3e6dae6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB3PR0402MB3898;
x-ms-traffictypediagnostic: DB3PR0402MB3898:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB3PR0402MB3898965E01BE92272FA1063AF51F0@DB3PR0402MB3898.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(136003)(366004)(376002)(13464003)(189003)(199004)(3846002)(6116002)(6306002)(33656002)(54906003)(6506007)(14454004)(81166006)(81156014)(8676002)(99286004)(53936002)(256004)(966005)(71200400001)(2906002)(8936002)(1411001)(229853002)(86362001)(53546011)(44832011)(71190400001)(7696005)(7736002)(305945005)(6436002)(102836004)(66066001)(5660300002)(55016002)(478600001)(316002)(76176011)(76116006)(7416002)(486006)(4326008)(476003)(68736007)(6246003)(9686003)(446003)(186003)(73956011)(66446008)(66476007)(52536014)(66946007)(66556008)(64756008)(25786009)(26005)(74316002)(11346002)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3898;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EndQqB+65MZQuQ+lQ+Aizl5lKNzQYveUx+pZ6MPdIoTxNRu926xlmI5yAsjOSSSudnL07CdFH/QzCKiECmLZAw4bLfeIDoPO+wZhwvKc+qBfAKNHv6xD/JBt0W2nkJZP+ZYovtpMSKK7H5kZEV3Vmn7l48XeaFrIJCKvz2Ry8vf6t6wk9v7ck7DpzitFuQxz859WlIehUNNOxBecpLTcqYVuA3DGtTdDPFU0/P0Hbyl00zXjCkB+Tz+gTx2EQii7l4DLyPOh7y7eGKYO9V2itp1YVOJ35e2hiaZja1sa8kieIqNIc/mOpmOV5DjlwtGTJymOnG+4ckZG/MwtgjSqrocCBr6vKlN0jl1B12ka9xsxn0xS/zyVaJrESV0soPNnKzvam/ufyL5CbJEStkv4/3kBZ5BfEKqTs0rzniqOM1Q=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bdb87fe-b2a3-4989-2a19-08d6e3e6dae6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 03:36:37.2405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3898
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIEVkdWFyZG8NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFZHVh
cmRvIFZhbGVudGluIDxlZHViZXp2YWxAZ21haWwuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIE1h
eSAyOSwgMjAxOSAxMTowMiBBTQ0KPiBUbzogQW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5j
b20+DQo+IENjOiByb2JoK2R0QGtlcm5lbC5vcmc7IG1hcmsucnV0bGFuZEBhcm0uY29tOyBzaGF3
bmd1b0BrZXJuZWwub3JnOw0KPiBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0
cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsNCj4gY2F0YWxpbi5tYXJpbmFzQGFybS5jb207
IHdpbGwuZGVhY29uQGFybS5jb207IHJ1aS56aGFuZ0BpbnRlbC5jb207DQo+IGRhbmllbC5sZXpj
YW5vQGxpbmFyby5vcmc7IEFpc2hlbmcgRG9uZyA8YWlzaGVuZy5kb25nQG54cC5jb20+Ow0KPiB1
bGYuaGFuc3NvbkBsaW5hcm8ub3JnOyBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT47IERhbmll
bCBCYWx1dGENCj4gPGRhbmllbC5iYWx1dGFAbnhwLmNvbT47IG1heGltZS5yaXBhcmRAYm9vdGxp
bi5jb207IG9sb2ZAbGl4b20ubmV0Ow0KPiBqYWdhbkBhbWFydWxhc29sdXRpb25zLmNvbTsgaG9y
bXMrcmVuZXNhc0B2ZXJnZS5uZXQuYXU7IExlb25hcmQgQ3Jlc3Rleg0KPiA8bGVvbmFyZC5jcmVz
dGV6QG54cC5jb20+OyBiam9ybi5hbmRlcnNzb25AbGluYXJvLm9yZzsNCj4gZGluZ3V5ZW5Aa2Vy
bmVsLm9yZzsgZW5yaWMuYmFsbGV0Ym9AY29sbGFib3JhLmNvbTsNCj4gZGV2aWNldHJlZUB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS0NCj4g
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZzsgZGwt
bGludXgtaW14IDxsaW51eC0NCj4gaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
UkVTRU5EIFYxMyAyLzVdIHRoZXJtYWw6IG9mLXRoZXJtYWw6IGFkZCBBUEkgZm9yIGdldHRpbmcN
Cj4gc2Vuc29yIElEIGZyb20gRFQNCj4gDQo+IE9uIFR1ZSwgTWF5IDI4LCAyMDE5IGF0IDAyOjA2
OjE4UE0gKzA4MDAsIEFuc29uLkh1YW5nQG54cC5jb20gd3JvdGU6DQo+ID4gRnJvbTogQW5zb24g
SHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+ID4NCj4gPiBPbiBzb21lIHBsYXRmb3JtcyBs
aWtlIGkuTVg4UVhQLCB0aGUgdGhlcm1hbCBkcml2ZXIgbmVlZHMgYSByZWFsIEhXDQo+ID4gc2Vu
c29yIElEIGZyb20gRFQgdGhlcm1hbCB6b25lLCB0aGUgSFcgc2Vuc29yIElEIGlzIHVzZWQgdG8g
Z2V0DQo+ID4gdGVtcGVyYXR1cmUgZnJvbSBTQ1UgZmlybXdhcmUsIGFuZCB0aGUgdmlydHVhbCBz
ZW5zb3IgSUQgc3RhcnRpbmcgZnJvbQ0KPiA+IDAgdG8gTiBpcyBOT1QgdXNlZCBhdCBhbGwsIHRo
aXMgcGF0Y2ggYWRkcyBuZXcgQVBJDQo+ID4gdGhlcm1hbF96b25lX29mX2dldF9zZW5zb3JfaWQo
KSB0byBwcm92aWRlIHRoZSBmZWF0dXJlIG9mIGdldHRpbmcNCj4gPiBzZW5zb3IgSUQgZnJvbSBE
VCB0aGVybWFsIHpvbmUncyBub2RlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVh
bmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gQ2hhbmdlcyBzaW5jZSBWMTI6
DQo+ID4gCS0gYWRqdXN0IHRoZSBzZWNvbmQgcGFyYW1ldGVyIG9mIHRoZXJtYWxfem9uZV9vZl9n
ZXRfc2Vuc29yX2lkKCkgQVBJLA0KPiB0aGVuIGNhbGxlciBubyBuZWVkDQo+ID4gCSAgdG8gcGFz
cyB0aGUgb2ZfcGhhbmRsZV9hcmdzIHN0cnVjdHVyZSBhbmQgcHV0IHRoZSBzZW5zb3Jfc3BlY3Mu
bnANCj4gbWFudWFsbHksIGFsc28gcHV0dGluZw0KPiA+IAkgIHRoZSBzZW5zb3Igbm9kZSBkZXZp
Y2UgY2hlY2sgaW5zaWRlIHRoaXMgQVBJIHRvIG1ha2UgaXQgZWFzeSBmb3INCj4gPiB1c2FnZTsN
Cj4gDQo+IFdoYXQgaGFwcGVuZWQgdG8gdXNpbmcgbnhwLHJlc291cmNlLWlkIHByb3BlcnR5IGlu
IHlvdXIgZHJpdmVyPw0KPiBXaHkgZG8gd2UgbmVlZCB0aGlzIGFzIGFuIEFQSSBpbiBvZi10aGVy
bWFsPyBXaGF0IG90aGVyIGRyaXZlcnMgbWF5IGJlbmVmaXQNCj4gb2YgdGhpcz8NCj4gDQo+IFJl
Z2FyZGxlc3MsIHRoaXMgcGF0Y2ggbmVlZHMgdG8gZG9jdW1lbnQgdGhlIG5ldyBBUEkgdW5kZXIg
RG9jdW1lbnRhdGlvbi8NCg0KQXMgUm9iIGhhcyBkaWZmZXJlbnQgb3BpbmlvbiBhYm91dCB0aGlz
IHByb3BlcnR5LCBoZSB0aG91Z2h0IGl0IGlzIHVubmVjZXNzYXJ5LCBzZWUgYmVsb3cNCmRpc2N1
c3Npb24gbWFpbCwgdGhhdCBpcyB3aHkgSSBuZWVkIHRvIGFkZCBBUEkgdG8gZ2V0IHRoZSByZXNv
dXJjZSBJRCBmcm9tIHBoYW5kbGUgYXJndW1lbnQuDQpJIGFtIHRvdGFsbHkgY29uZnVzZWQgbm93
LCB3aGljaCBhcHByb2FjaCBzaG91bGQgd2UgYWRvcHQ/DQoNCmh0dHBzOi8vcGF0Y2h3b3JrLmtl
cm5lbC5vcmcvcGF0Y2gvMTA4MzEzOTcvDQoNClRoYW5rcywNCkFuc29uDQoNCj4gDQo+ID4gLS0t
DQo+ID4gIGRyaXZlcnMvdGhlcm1hbC9vZi10aGVybWFsLmMgfCA2NiArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKystLS0NCj4gLS0tLS0tLS0NCj4gPiAgaW5jbHVkZS9saW51eC90aGVy
bWFsLmggICAgICB8IDEwICsrKysrKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA2MCBpbnNlcnRp
b25zKCspLCAxNiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Ro
ZXJtYWwvb2YtdGhlcm1hbC5jDQo+ID4gYi9kcml2ZXJzL3RoZXJtYWwvb2YtdGhlcm1hbC5jIGlu
ZGV4IGRjNTA5M2IuLmE1Mzc5MmIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy90aGVybWFsL29m
LXRoZXJtYWwuYw0KPiA+ICsrKyBiL2RyaXZlcnMvdGhlcm1hbC9vZi10aGVybWFsLmMNCj4gPiBA
QCAtNDQ5LDYgKzQ0OSw1NCBAQCB0aGVybWFsX3pvbmVfb2ZfYWRkX3NlbnNvcihzdHJ1Y3QgZGV2
aWNlX25vZGUNCj4gPiAqem9uZSwgIH0NCj4gPg0KPiA+ICAvKioNCj4gPiArICogdGhlcm1hbF96
b25lX29mX2dldF9zZW5zb3JfaWQgLSBnZXQgc2Vuc29yIElEIGZyb20gYSBEVCB0aGVybWFsDQo+
ID4gKyB6b25lDQo+ID4gKyAqIEB0el9ucDogYSB2YWxpZCB0aGVybWFsIHpvbmUgZGV2aWNlIG5v
ZGUuDQo+ID4gKyAqIEBzZW5zb3JfbnA6IGEgc2Vuc29yIG5vZGUgb2YgYSB2YWxpZCBzZW5zb3Ig
ZGV2aWNlLg0KPiA+ICsgKiBAaWQ6IGEgc2Vuc29yIElEIHBvaW50ZXIgd2lsbCBiZSBwYXNzZWQg
YmFjay4NCj4gPiArICoNCj4gPiArICogVGhpcyBmdW5jdGlvbiB3aWxsIGdldCBzZW5zb3IgSUQg
ZnJvbSBhIGdpdmVuIHRoZXJtYWwgem9uZSBub2RlLA0KPiA+ICsgdXNlDQo+ID4gKyAqICJ0aGVy
bWFsLXNlbnNvcnMiIGFzIGxpc3QgbmFtZSwgYW5kIGdldCBzZW5zb3IgSUQgZnJvbSBmaXJzdA0K
PiA+ICsgcGhhbmRsZSdzDQo+ID4gKyAqIGFyZ3VtZW50Lg0KPiA+ICsgKg0KPiA+ICsgKiBSZXR1
cm46IDAgb24gc3VjY2VzcywgcHJvcGVyIGVycm9yIGNvZGUgb3RoZXJ3aXNlLg0KPiA+ICsgKi8N
Cj4gPiArDQo+ID4gK2ludCB0aGVybWFsX3pvbmVfb2ZfZ2V0X3NlbnNvcl9pZChzdHJ1Y3QgZGV2
aWNlX25vZGUgKnR6X25wLA0KPiA+ICsJCQkJICBzdHJ1Y3QgZGV2aWNlX25vZGUgKnNlbnNvcl9u
cCwNCj4gPiArCQkJCSAgdTMyICppZCkNCj4gPiArew0KPiA+ICsJc3RydWN0IG9mX3BoYW5kbGVf
YXJncyBzZW5zb3Jfc3BlY3M7DQo+ID4gKwlpbnQgcmV0Ow0KPiA+ICsNCj4gPiArCXJldCA9IG9m
X3BhcnNlX3BoYW5kbGVfd2l0aF9hcmdzKHR6X25wLA0KPiA+ICsJCQkJCSAidGhlcm1hbC1zZW5z
b3JzIiwNCj4gPiArCQkJCQkgIiN0aGVybWFsLXNlbnNvci1jZWxscyIsDQo+ID4gKwkJCQkJIDAs
DQo+ID4gKwkJCQkJICZzZW5zb3Jfc3BlY3MpOw0KPiA+ICsJaWYgKHJldCkNCj4gPiArCQlyZXR1
cm4gcmV0Ow0KPiA+ICsNCj4gPiArCWlmIChzZW5zb3Jfc3BlY3MubnAgIT0gc2Vuc29yX25wKSB7
DQo+ID4gKwkJb2Zfbm9kZV9wdXQoc2Vuc29yX3NwZWNzLm5wKTsNCj4gPiArCQlyZXR1cm4gLUVO
T0RFVjsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlpZiAoc2Vuc29yX3NwZWNzLmFyZ3NfY291bnQg
Pj0gMSkgew0KPiA+ICsJCSppZCA9IHNlbnNvcl9zcGVjcy5hcmdzWzBdOw0KPiA+ICsJCVdBUk4o
c2Vuc29yX3NwZWNzLmFyZ3NfY291bnQgPiAxLA0KPiA+ICsJCSAgICAgIiVwT0ZuOiB0b28gbWFu
eSBjZWxscyBpbiBzZW5zb3Igc3BlY2lmaWVyICVkXG4iLA0KPiA+ICsJCSAgICAgc2Vuc29yX3Nw
ZWNzLm5wLCBzZW5zb3Jfc3BlY3MuYXJnc19jb3VudCk7DQo+ID4gKwl9IGVsc2Ugew0KPiA+ICsJ
CSppZCA9IDA7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJb2Zfbm9kZV9wdXQoc2Vuc29yX3NwZWNz
Lm5wKTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICtFWFBPUlRfU1lNQk9M
X0dQTCh0aGVybWFsX3pvbmVfb2ZfZ2V0X3NlbnNvcl9pZCk7DQo+ID4gKw0KPiA+ICsvKioNCj4g
PiAgICogdGhlcm1hbF96b25lX29mX3NlbnNvcl9yZWdpc3RlciAtIHJlZ2lzdGVycyBhIHNlbnNv
ciB0byBhIERUIHRoZXJtYWwgem9uZQ0KPiA+ICAgKiBAZGV2OiBhIHZhbGlkIHN0cnVjdCBkZXZp
Y2UgcG9pbnRlciBvZiBhIHNlbnNvciBkZXZpY2UuIE11c3QgY29udGFpbg0KPiA+ICAgKiAgICAg
ICBhIHZhbGlkIC5vZl9ub2RlLCBmb3IgdGhlIHNlbnNvciBub2RlLg0KPiA+IEBAIC00OTksMzYg
KzU0NywyMiBAQCB0aGVybWFsX3pvbmVfb2Zfc2Vuc29yX3JlZ2lzdGVyKHN0cnVjdCBkZXZpY2UN
Cj4gKmRldiwgaW50IHNlbnNvcl9pZCwgdm9pZCAqZGF0YSwNCj4gPiAgCXNlbnNvcl9ucCA9IG9m
X25vZGVfZ2V0KGRldi0+b2Zfbm9kZSk7DQo+ID4NCj4gPiAgCWZvcl9lYWNoX2F2YWlsYWJsZV9j
aGlsZF9vZl9ub2RlKG5wLCBjaGlsZCkgew0KPiA+IC0JCXN0cnVjdCBvZl9waGFuZGxlX2FyZ3Mg
c2Vuc29yX3NwZWNzOw0KPiA+ICAJCWludCByZXQsIGlkOw0KPiA+DQo+ID4gIAkJLyogRm9yIG5v
dywgdGhlcm1hbCBmcmFtZXdvcmsgc3VwcG9ydHMgb25seSAxIHNlbnNvciBwZXINCj4gem9uZSAq
Lw0KPiA+IC0JCXJldCA9IG9mX3BhcnNlX3BoYW5kbGVfd2l0aF9hcmdzKGNoaWxkLCAidGhlcm1h
bC1zZW5zb3JzIiwNCj4gPiAtCQkJCQkJICIjdGhlcm1hbC1zZW5zb3ItY2VsbHMiLA0KPiA+IC0J
CQkJCQkgMCwgJnNlbnNvcl9zcGVjcyk7DQo+ID4gKwkJcmV0ID0gdGhlcm1hbF96b25lX29mX2dl
dF9zZW5zb3JfaWQoY2hpbGQsIHNlbnNvcl9ucCwgJmlkKTsNCj4gPiAgCQlpZiAocmV0KQ0KPiA+
ICAJCQljb250aW51ZTsNCj4gPg0KPiA+IC0JCWlmIChzZW5zb3Jfc3BlY3MuYXJnc19jb3VudCA+
PSAxKSB7DQo+ID4gLQkJCWlkID0gc2Vuc29yX3NwZWNzLmFyZ3NbMF07DQo+ID4gLQkJCVdBUk4o
c2Vuc29yX3NwZWNzLmFyZ3NfY291bnQgPiAxLA0KPiA+IC0JCQkgICAgICIlcE9GbjogdG9vIG1h
bnkgY2VsbHMgaW4gc2Vuc29yIHNwZWNpZmllciAlZFxuIiwNCj4gPiAtCQkJICAgICBzZW5zb3Jf
c3BlY3MubnAsIHNlbnNvcl9zcGVjcy5hcmdzX2NvdW50KTsNCj4gPiAtCQl9IGVsc2Ugew0KPiA+
IC0JCQlpZCA9IDA7DQo+ID4gLQkJfQ0KPiA+IC0NCj4gPiAtCQlpZiAoc2Vuc29yX3NwZWNzLm5w
ID09IHNlbnNvcl9ucCAmJiBpZCA9PSBzZW5zb3JfaWQpIHsNCj4gPiArCQlpZiAoaWQgPT0gc2Vu
c29yX2lkKSB7DQo+ID4gIAkJCXR6ZCA9IHRoZXJtYWxfem9uZV9vZl9hZGRfc2Vuc29yKGNoaWxk
LCBzZW5zb3JfbnAsDQo+ID4gIAkJCQkJCQkgZGF0YSwgb3BzKTsNCj4gPiAgCQkJaWYgKCFJU19F
UlIodHpkKSkNCj4gPiAgCQkJCXR6ZC0+b3BzLT5zZXRfbW9kZSh0emQsDQo+IFRIRVJNQUxfREVW
SUNFX0VOQUJMRUQpOw0KPiA+DQo+ID4gLQkJCW9mX25vZGVfcHV0KHNlbnNvcl9zcGVjcy5ucCk7
DQo+ID4gIAkJCW9mX25vZGVfcHV0KGNoaWxkKTsNCj4gPiAgCQkJZ290byBleGl0Ow0KPiA+ICAJ
CX0NCj4gPiAtCQlvZl9ub2RlX3B1dChzZW5zb3Jfc3BlY3MubnApOw0KPiA+ICAJfQ0KPiA+ICBl
eGl0Og0KPiA+ICAJb2Zfbm9kZV9wdXQoc2Vuc29yX25wKTsNCj4gPiBkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9saW51eC90aGVybWFsLmggYi9pbmNsdWRlL2xpbnV4L3RoZXJtYWwuaCBpbmRleA0KPiA+
IDE1YTRjYTUuLjVlZGZmZTYgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC90aGVybWFs
LmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L3RoZXJtYWwuaA0KPiA+IEBAIC0zNzUsNiArMzc1
LDkgQEAgc3RydWN0IHRoZXJtYWxfdHJpcCB7DQo+ID4NCj4gPiAgLyogRnVuY3Rpb24gZGVjbGFy
YXRpb25zICovDQo+ID4gICNpZmRlZiBDT05GSUdfVEhFUk1BTF9PRg0KPiA+ICtpbnQgdGhlcm1h
bF96b25lX29mX2dldF9zZW5zb3JfaWQoc3RydWN0IGRldmljZV9ub2RlICp0el9ucCwNCj4gPiAr
CQkJCSAgc3RydWN0IGRldmljZV9ub2RlICpzZW5zb3JfbnAsDQo+ID4gKwkJCQkgIHUzMiAqaWQp
Ow0KPiA+ICBzdHJ1Y3QgdGhlcm1hbF96b25lX2RldmljZSAqDQo+ID4gIHRoZXJtYWxfem9uZV9v
Zl9zZW5zb3JfcmVnaXN0ZXIoc3RydWN0IGRldmljZSAqZGV2LCBpbnQgaWQsIHZvaWQgKmRhdGEs
DQo+ID4gIAkJCQljb25zdCBzdHJ1Y3QgdGhlcm1hbF96b25lX29mX2RldmljZV9vcHMNCj4gKm9w
cyk7IEBAIC0zODYsNiArMzg5LDEzDQo+ID4gQEAgc3RydWN0IHRoZXJtYWxfem9uZV9kZXZpY2Ug
KmRldm1fdGhlcm1hbF96b25lX29mX3NlbnNvcl9yZWdpc3RlcigNCj4gPiAgdm9pZCBkZXZtX3Ro
ZXJtYWxfem9uZV9vZl9zZW5zb3JfdW5yZWdpc3RlcihzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+ID4g
IAkJCQkJICAgIHN0cnVjdCB0aGVybWFsX3pvbmVfZGV2aWNlICp0eik7DQo+ICNlbHNlDQo+ID4g
Kw0KPiA+ICtzdGF0aWMgaW50IHRoZXJtYWxfem9uZV9vZl9nZXRfc2Vuc29yX2lkKHN0cnVjdCBk
ZXZpY2Vfbm9kZSAqdHpfbnAsDQo+ID4gKwkJCQkJIHN0cnVjdCBkZXZpY2Vfbm9kZSAqc2Vuc29y
X25wLA0KPiA+ICsJCQkJCSB1MzIgKmlkKQ0KPiA+ICt7DQo+ID4gKwlyZXR1cm4gLUVOT0VOVDsN
Cj4gPiArfQ0KPiA+ICBzdGF0aWMgaW5saW5lIHN0cnVjdCB0aGVybWFsX3pvbmVfZGV2aWNlICoN
Cj4gPiB0aGVybWFsX3pvbmVfb2Zfc2Vuc29yX3JlZ2lzdGVyKHN0cnVjdCBkZXZpY2UgKmRldiwg
aW50IGlkLCB2b2lkICpkYXRhLA0KPiA+ICAJCQkJY29uc3Qgc3RydWN0IHRoZXJtYWxfem9uZV9v
Zl9kZXZpY2Vfb3BzDQo+ICpvcHMpDQo=
