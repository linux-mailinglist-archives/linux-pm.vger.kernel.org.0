Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74F9E50388
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2019 09:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfFXHcs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Jun 2019 03:32:48 -0400
Received: from mail-eopbgr20059.outbound.protection.outlook.com ([40.107.2.59]:5358
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727944AbfFXHcs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 24 Jun 2019 03:32:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DC0Cr2T89RyTND5XSvLRrPIVeLNDWHZaeizVXM83ESQ=;
 b=G6ssv1GORvdPrS8vlN9ve3g0qJoikhcJhe/VDVN+7zcj3fW+o2F/NnLlkAVPrc7n/n1G4pq0GS9IkpDoq7kr3DPvWFdZnmsbCuHPBG0qmaOeerPpheX4J/QJMuMBY/Dd5l9Y46JMYG7YtIcs8x55+ApJ8mhAAM7+h1pkPFH4d7Q=
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com (52.134.122.155) by
 VI1PR04MB4208.eurprd04.prod.outlook.com (52.134.30.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Mon, 24 Jun 2019 07:32:43 +0000
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::850e:70e:608:83ba]) by VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::850e:70e:608:83ba%7]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 07:32:43 +0000
From:   Andy Tang <andy.tang@nxp.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH] dt-bindings: thermal: Make cooling-maps
 property optional
Thread-Topic: [EXT] Re: [PATCH] dt-bindings: thermal: Make cooling-maps
 property optional
Thread-Index: AQHVCwLUH4zad13tsE2wQPY/IOtNWqaLHhGggAAClwCAH4aFoA==
Date:   Mon, 24 Jun 2019 07:32:43 +0000
Message-ID: <VI1PR04MB4333E170CF4044924AB8E50FF3E00@VI1PR04MB4333.eurprd04.prod.outlook.com>
References: <20190515093647.47656-1-andy.tang@nxp.com>
 <VI1PR04MB43335AE882F7898F4DDD1A23F3150@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <f4675fc5-a7d1-1a6c-51ed-b6b6b599f5fe@linaro.org>
In-Reply-To: <f4675fc5-a7d1-1a6c-51ed-b6b6b599f5fe@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andy.tang@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b211bb10-d758-4b54-a19a-08d6f876256a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4208;
x-ms-traffictypediagnostic: VI1PR04MB4208:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <VI1PR04MB4208299D3C3C58CA0253DA9EF3E00@VI1PR04MB4208.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(346002)(376002)(39860400002)(396003)(189003)(199004)(13464003)(6116002)(74316002)(66066001)(6246003)(316002)(6436002)(6306002)(102836004)(9686003)(76176011)(54906003)(25786009)(110136005)(55016002)(7696005)(14454004)(52536014)(26005)(305945005)(5660300002)(186003)(8936002)(4326008)(256004)(3846002)(86362001)(2906002)(229853002)(7736002)(81166006)(8676002)(53936002)(33656002)(6506007)(478600001)(53546011)(81156014)(44832011)(68736007)(71200400001)(71190400001)(73956011)(2501003)(11346002)(476003)(99286004)(2201001)(66946007)(64756008)(76116006)(66446008)(446003)(66556008)(66476007)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4208;H:VI1PR04MB4333.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7FwVy9+Bs77zTMETMm48DmIeXCydGFn9OIrF/W1mEFxVq+np8Xgc6gvBkf+LNmFwldYDeVyUzdxaNuSBPucdJe6XCpCGfuKX4bUGMfaYDCvGYOzJv1MWZeSj8fJgOHPxAPxZ6+bgTOtW8G4ZmM9kFdyzqW6deKwJlwMCwOh4J1e9Nv45D0RHk84YDzADgdw2aTUsBUmz/iy3zeiKHMRuSWDS4ZuVDhEqfBZGvK1ScW7YZzhiIVhTybUs5WzcGCfYlNWy3UxVNmQkM7plLdKGqMkjNOe9UXRz9Noi25++On7FO5cFf24zB4U1n5FRqG8uSfoKk3lA9GMeyeUelqGfaVfvvnIQ5GMB0PVHE0VuTT8/J/5XP1MsLyelVa37pQ8zpc3SisPSF582ODqe2YVc3VDCml1q7PHmjP0Ibtl0o74=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b211bb10-d758-4b54-a19a-08d6f876256a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 07:32:43.6088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: andy.tang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4208
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgRWR1YmV6dmFsLCBSdWksDQoNCkFyZSB5b3UgZ29pbmcgdG8gcGljayB1cCB0aGlzIHBhdGNo
Pw0KDQpCUiwNCkFuZHkNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBE
YW5pZWwgTGV6Y2FubyA8ZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZz4NCj4gU2VudDogMjAxOcTq
NtTCNMjVIDE0OjA0DQo+IFRvOiBBbmR5IFRhbmcgPGFuZHkudGFuZ0BueHAuY29tPjsgcnVpLnpo
YW5nQGludGVsLmNvbTsNCj4gZWR1YmV6dmFsQGdtYWlsLmNvbQ0KPiBDYzogcm9iaCtkdEBrZXJu
ZWwub3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgbGludXgtcG1Admdlci5rZXJuZWwub3JnOw0K
PiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
Zw0KPiBTdWJqZWN0OiBbRVhUXSBSZTogW1BBVENIXSBkdC1iaW5kaW5nczogdGhlcm1hbDogTWFr
ZSBjb29saW5nLW1hcHMgcHJvcGVydHkNCj4gb3B0aW9uYWwNCj4gDQo+IENhdXRpb246IEVYVCBF
bWFpbA0KPiANCj4gT24gMDQvMDYvMjAxOSAwNzo1NiwgQW5keSBUYW5nIHdyb3RlOg0KPiA+IEhp
IEVkdWJlenZhbCwgUnVpLA0KPiA+DQo+ID4gQW55IGZ1cnRoZXIgY29tbWVudHM/DQo+IA0KPiBG
cm9tIG15IFBPViwgdGhpcyBwYXRjaCBtYWtlcyBzZW5zZS4gV2UgbWF5IGJlIGludGVyZXN0ZWQg
dG8gc2hvdyB1cCB0aGUNCj4gdGhlcm1hbCB6b25lcyBpbiBzeXNmcyBhbmQgb3B0aW9uYWxseSBt
aXRpZ2F0ZSB0aGVtIHZpYSBhbiB1c2Vyc3BhY2UNCj4gZ292ZXJub3IuDQo+IA0KPiBBY2tlZC1i
eTogRGFuaWVsIExlemNhbm8gPGRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmc+DQo+IA0KPiA+PiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBZdWFudGlhbiBUYW5nIDxhbmR5
LnRhbmdAbnhwLmNvbT4NCj4gPj4gU2VudDogMjAxOcTqNdTCMTXI1SAxNzozNw0KPiA+PiBUbzog
cnVpLnpoYW5nQGludGVsLmNvbTsgZWR1YmV6dmFsQGdtYWlsLmNvbQ0KPiA+PiBDYzogcm9iaCtk
dEBrZXJuZWwub3JnOyBkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnOw0KPiA+PiBtYXJrLnJ1dGxh
bmRAYXJtLmNvbTsgbGludXgtcG1Admdlci5rZXJuZWwub3JnOw0KPiA+PiBkZXZpY2V0cmVlQHZn
ZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgQW5keSBUYW5nDQo+
ID4+IDxhbmR5LnRhbmdAbnhwLmNvbT4NCj4gPj4gU3ViamVjdDogW1BBVENIXSBkdC1iaW5kaW5n
czogdGhlcm1hbDogTWFrZSBjb29saW5nLW1hcHMgcHJvcGVydHkNCj4gPj4gb3B0aW9uYWwNCj4g
Pj4NCj4gPj4gVGhlcmUgbWF5IGJlIG5vIGNvb2xpbmcgZGV2aWNlIG9uIHN5c3RlbSwgb3IgdGhl
cmUgYXJlIG5vIGVub3VnaA0KPiA+PiBjb29saW5nIGRldmljZXMgZm9yIGVhY2ggdGhlcm1hbCB6
b25lIGluIG11bHRpcGxlIHRoZXJtYWwgem9uZSBjYXNlcw0KPiA+PiBzaW5jZSBjb29saW5nIGRl
dmljZXMgY2FuJ3QgYmUgc2hhcmVkLg0KPiA+PiBTbyBtYWtlIHRoaXMgcHJvcGVydHkgb3B0aW9u
YWwgdG8gcmVtb3ZlIHN1Y2ggbGltaXRhdGlvbnMuDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6
IFl1YW50aWFuIFRhbmcgPGFuZHkudGFuZ0BueHAuY29tPg0KPiA+PiAtLS0NCj4gPj4gIC4uLi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3RoZXJtYWwvdGhlcm1hbC50eHQgICAgICAgIHwgICAgNCArKy0t
DQo+ID4+ICAxIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkN
Cj4gPj4NCj4gPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy90aGVybWFsL3RoZXJtYWwudHh0DQo+ID4+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3RoZXJtYWwvdGhlcm1hbC50eHQNCj4gPj4gaW5kZXggY2ExNGJhOS4uNjk0ZTgzNCAx
MDA2NDQNCj4gPj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3RoZXJt
YWwvdGhlcm1hbC50eHQNCj4gPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3RoZXJtYWwvdGhlcm1hbC50eHQNCj4gPj4gQEAgLTE0MiwxMSArMTQyLDExIEBAIFJlcXVp
cmVkIHByb3BlcnRpZXM6DQo+ID4+ICAtIHRyaXBzOiAgICAgICAgICAgIEEgc3ViLW5vZGUgd2hp
Y2ggaXMgYSBjb250YWluZXIgb2Ygb25seSB0cmlwIHBvaW50DQo+IG5vZGVzDQo+ID4+ICAgIFR5
cGU6IHN1Yi1ub2RlICAgIHJlcXVpcmVkIHRvIGRlc2NyaWJlIHRoZSB0aGVybWFsIHpvbmUuDQo+
ID4+DQo+ID4+ICsNCj4gPj4gK09wdGlvbmFsIHByb3BlcnR5Og0KPiA+PiAgLSBjb29saW5nLW1h
cHM6ICAgICAgICAgICAgIEEgc3ViLW5vZGUgd2hpY2ggaXMgYSBjb250YWluZXIgb2Ygb25seQ0K
PiBjb29saW5nIGRldmljZQ0KPiA+PiAgICBUeXBlOiBzdWItbm9kZSAgICBtYXAgbm9kZXMsIHVz
ZWQgdG8gZGVzY3JpYmUgdGhlIHJlbGF0aW9uDQo+IGJldHdlZW4NCj4gPj4gdHJpcHMNCj4gPj4g
ICAgICAgICAgICAgICAgICAgICAgYW5kIGNvb2xpbmcgZGV2aWNlcy4NCj4gPj4gLQ0KPiA+PiAt
T3B0aW9uYWwgcHJvcGVydHk6DQo+ID4+ICAtIGNvZWZmaWNpZW50czogICAgICAgICAgICAgQW4g
YXJyYXkgb2YgaW50ZWdlcnMgKG9uZSBzaWduZWQgY2VsbCkNCj4gY29udGFpbmluZw0KPiA+PiAg
ICBUeXBlOiBhcnJheSAgICAgICAgICAgICAgIGNvZWZmaWNpZW50cyB0byBjb21wb3NlIGEgbGlu
ZWFyIHJlbGF0aW9uDQo+IGJldHdlZW4NCj4gPj4gICAgRWxlbSBzaXplOiBvbmUgY2VsbCAgICAg
ICB0aGUgc2Vuc29ycyBsaXN0ZWQgaW4gdGhlIHRoZXJtYWwtc2Vuc29ycw0KPiBwcm9wZXJ0eS4N
Cj4gPj4gLS0NCj4gPj4gMS43LjENCj4gPg0KPiANCj4gDQo+IC0tDQo+IA0KPiA8aHR0cHM6Ly9l
dXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHAlM0ElMkYlMkZ3
d3cuDQo+IGxpbmFyby5vcmclMkYmYW1wO2RhdGE9MDIlN0MwMSU3Q2FuZHkudGFuZyU0MG54cC5j
b20lN0MyMjg3YTk4Nw0KPiAxMTZjNDI0MGVkODQwOGQ2ZThiMjdiODElN0M2ODZlYTFkM2JjMmI0
YzZmYTkyY2Q5OWM1YzMwMTYzNSU3Qw0KPiAwJTdDMCU3QzYzNjk1MjI1MDYwNjM0NjU0MCZhbXA7
c2RhdGE9RDhYSDNjb3Jsa0VVOTF1N0ZndU50Q0Y4DQo+IGhrelI4dmlObnREUTROakY5T00lM0Qm
YW1wO3Jlc2VydmVkPTA+IExpbmFyby5vcmcgqaYgT3BlbiBzb3VyY2UNCj4gc29mdHdhcmUgZm9y
IEFSTSBTb0NzDQo+IA0KPiBGb2xsb3cgTGluYXJvOg0KPiA8aHR0cHM6Ly9ldXIwMS5zYWZlbGlu
a3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHAlM0ElMkYlMkZ3d3cuDQo+IGZhY2Vi
b29rLmNvbSUyRnBhZ2VzJTJGTGluYXJvJmFtcDtkYXRhPTAyJTdDMDElN0NhbmR5LnRhbmclNDBu
eA0KPiBwLmNvbSU3QzIyODdhOTg3MTE2YzQyNDBlZDg0MDhkNmU4YjI3YjgxJTdDNjg2ZWExZDNi
YzJiNGM2ZmE5Mg0KPiBjZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2MzY5NTIyNTA2MDYzNTY1Mjgm
YW1wO3NkYXRhPWhSdXZtVw0KPiAlMkJyUTYxdERFeTdYSUhLaFRhVHF4TCUyRkpDNmdSeTI5WWdz
RWF6ayUzRCZhbXA7cmVzZXJ2ZWQ9MD4NCj4gRmFjZWJvb2sgfA0KPiA8aHR0cHM6Ly9ldXIwMS5z
YWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHAlM0ElMkYlMkZ0d2l0dGUN
Cj4gci5jb20lMkYlMjMhJTJGbGluYXJvb3JnJmFtcDtkYXRhPTAyJTdDMDElN0NhbmR5LnRhbmcl
NDBueHAuY29tDQo+ICU3QzIyODdhOTg3MTE2YzQyNDBlZDg0MDhkNmU4YjI3YjgxJTdDNjg2ZWEx
ZDNiYzJiNGM2ZmE5MmNkOTljDQo+IDVjMzAxNjM1JTdDMCU3QzAlN0M2MzY5NTIyNTA2MDYzNTY1
MjgmYW1wO3NkYXRhPWo2eU84OHRrRzB1UXMNCj4gVmlTViUyRjlTQ09ZTGEzaUo2cFhzOG1xeHM2
cXQ0dUElM0QmYW1wO3Jlc2VydmVkPTA+IFR3aXR0ZXIgfA0KPiA8aHR0cHM6Ly9ldXIwMS5zYWZl
bGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHAlM0ElMkYlMkZ3d3cuDQo+IGxp
bmFyby5vcmclMkZsaW5hcm8tYmxvZyUyRiZhbXA7ZGF0YT0wMiU3QzAxJTdDYW5keS50YW5nJTQw
bnhwLmNvDQo+IG0lN0MyMjg3YTk4NzExNmM0MjQwZWQ4NDA4ZDZlOGIyN2I4MSU3QzY4NmVhMWQz
YmMyYjRjNmZhOTJjZDk5DQo+IGM1YzMwMTYzNSU3QzAlN0MwJTdDNjM2OTUyMjUwNjA2MzU2NTI4
JmFtcDtzZGF0YT1xOXRPRiUyRmlPTDYNCj4gR3BkdnBTaVQlMkZ5RklGTDMzRHgwJTJGdUJCYU94
Y21kRDFSbyUzRCZhbXA7cmVzZXJ2ZWQ9MD4gQmxvZw0KDQo=
