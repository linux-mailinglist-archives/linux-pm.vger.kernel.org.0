Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 692E6F765C
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2019 15:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfKKO3Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 09:29:25 -0500
Received: from mail-eopbgr130048.outbound.protection.outlook.com ([40.107.13.48]:15685
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726811AbfKKO3Z (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 11 Nov 2019 09:29:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HnL9E+Gf1GgmBhS7Kz8Gp8JSrvHnNgTMZmj1CUzt7C2l8G9fdmoQzKoWt6Qs2jKFOWmfGsOeHVTSrUbHGCdACEqckLCKrG4XO9wqaEoVdK8/4Mqwqeeqcru4I25vV5zuxWOwjTfJp4M54BQ5T4OdQUGlIYMlxQmoRr+2kfH0sbtwOTw5DDY2Rrf5zmlNYBjiXalKzh+0V+MYc/dmZWtxEqplxPGk3ixfU2s8vZg+kmdgXr4sRLa3l8kp2HmI8uKjM91TbkEnWiHcij5ukR3V1BXu44sOoTicJR5HtP82JzxK9/S0uTVu5lw7OBjzJ9F0ZhG/8dBdku6YIR14/r+vMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/sBT7KIgUWmV+buIZsHXFxbuSk67XZnBmVARVkd4R0=;
 b=GcDZSJxDEoAnso9eZDzZfS/8DutAq4ref9V1GVn965gg6MxZELCl839iELGvFDf1D+rmWWoetBFpT61z4q7iTZVPbATwKgFVmt8K+tTaOgrD4TTARstyhaoCBssDAUzWO/8E+L0TQHh+3ROPhbuMFzoPBBNAeWi9PJrAMmYWO8PxRs4sOJkMzIVqOS3gRg1+a0IZtC5LU14cx7+uUgI7mwmrvbCOdEmVLmbP/wiy6Q0flfvVNrzPZB/6/9XOKF38wakBzFrKyF6H0dymgX4bREvOAqYaGKYm4kQqWptc+fz5OsaQyTaHnmdnjR6vs9ByjaYVPzdaFmlM0WFmwL2UAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/sBT7KIgUWmV+buIZsHXFxbuSk67XZnBmVARVkd4R0=;
 b=GTopNkCF6vI2IKLrZvRoO8HHtteSxNB8PjByMUzq91zeuSclp1Jg/sHvIU2Ol77+elDoPmtt6NZ6yNOWe6AYCYRkxOO3Sw43voc0ok/a4y/k513qzO0T6L5zJd6az6Ke5RXJSPgIBUMxc+U+VLLXGUrk735Fgny/r1Zo2bH52LQ=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB2975.eurprd04.prod.outlook.com (10.170.228.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.26; Mon, 11 Nov 2019 14:29:15 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3%5]) with mapi id 15.20.2430.027; Mon, 11 Nov 2019
 14:29:15 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "robh@kernel.org" <robh@kernel.org>
CC:     Aisheng Dong <aisheng.dong@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "mka@chromium.org" <mka@chromium.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "martink@posteo.de" <martink@posteo.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "cw00.choi@samsung.com" <cw00.choi@samsung.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "saravanak@google.com" <saravanak@google.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Anson Huang <anson.huang@nxp.com>,
        "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
        "a.swigon@partner.samsung.com" <a.swigon@partner.samsung.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "abailon@baylibre.com" <abailon@baylibre.com>,
        "georgi.djakov@linaro.org" <georgi.djakov@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3 6/6] arm64: dts: imx8m: Add ddr controller nodes
Thread-Topic: [PATCH v3 6/6] arm64: dts: imx8m: Add ddr controller nodes
Thread-Index: AQHVkDU8koftI2DJ20m2SpBhGeGQAqd7lnkAgAqB44A=
Date:   Mon, 11 Nov 2019 14:29:15 +0000
Message-ID: <feb66325049ac098ef178abd1de14ddd1c840a13.camel@nxp.com>
References: <cover.1572558427.git.leonard.crestez@nxp.com>
         <44dcab5a136f5b046092e6ed456d8e206413059f.1572558427.git.leonard.crestez@nxp.com>
         <20191104220144.GA5218@bogus>
In-Reply-To: <20191104220144.GA5218@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5cf86961-a53b-47b0-7f1b-08d766b3878a
x-ms-traffictypediagnostic: VI1PR04MB2975:|VI1PR04MB2975:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB2975CA40ED2BA56E57814766EE740@VI1PR04MB2975.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0218A015FA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(189003)(199004)(6486002)(316002)(66946007)(6436002)(6246003)(91956017)(50226002)(6506007)(2616005)(76116006)(11346002)(2906002)(486006)(478600001)(446003)(5640700003)(6916009)(256004)(71190400001)(14444005)(186003)(71200400001)(7416002)(25786009)(5660300002)(2351001)(476003)(54906003)(99286004)(2501003)(86362001)(229853002)(118296001)(4326008)(305945005)(7736002)(66066001)(36756003)(64756008)(66556008)(66476007)(66446008)(8936002)(6512007)(44832011)(26005)(6116002)(3846002)(8676002)(1730700003)(14454004)(81166006)(81156014)(76176011)(102836004)(99106002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB2975;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lG0xg2EfkBhbqTNdwHIgE/UvPSvIpLRmpIdYPANPXEocEuzObkIkFJUW6yOqmlFqyEE1ryoo8JNoEqDypBR8lNwVn8FFysqKcTUtzwY7e/p/GGYeZHFOrOgvsb+loVgidW2GWYxyl3fcG0mr4hTVeXRotKm8rjSjN0YzgE/8hVR1bdU6RvxKpBFDc/GM/zWZboBFFOkCc43wtrOhuMOBBoQ6axcHmUwN3MUkqFxRWPyQwJ1KDJeGFQwi4iMEQiBZNuGZMD4KSMYzDrR/Lm/R8rZsQ02delyzFqpGSKcOC0ly69KDSKjWsQaxNBjqsMBDZqIYgl06rq/o+np6PdMX/C8Kx3rU9k12s5DNepqJ7HM7EVZFDBsHKl2JvN6Pwldx2JRwvnqt001EUTXIHeApsX9xo8iszFRbzgry5YjdnmEukvgPX4jFJCllsEoF45Dr
Content-Type: text/plain; charset="utf-8"
Content-ID: <393275E91C5EBB40A8C256DDC01C8F77@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf86961-a53b-47b0-7f1b-08d766b3878a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2019 14:29:15.3343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lxy38Ddk/G+ZjwGesRj3xCcaC5POg/PgpNxTihXuheqswFTnBAnrECRSA7ryV+X+EEesyWRrr4RDSUJ3n1BHIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB2975
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gTW9uLCAyMDE5LTExLTA0IGF0IDE2OjAxIC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gVGh1LCBPY3QgMzEsIDIwMTkgYXQgMTE6NTA6MjdQTSArMDIwMCwgTGVvbmFyZCBDcmVzdGV6
IHdyb3RlOg0KPiA+IFRoaXMgaXMgdXNlZCBieSB0aGUgaW14LWRkcmMgZGV2ZnJlcSBkcml2ZXIg
dG8gaW1wbGVtZW50IGR5bmFtaWMNCj4gPiBmcmVxdWVuY3kgc2NhbGluZyBvZiBEUkFNLg0KPiA+
IA0KPiA+IEFkZCBhIGRldmZyZXEtZXZlbnQgbGluayB0byB0aGUgZHJhbSBQTVUgaW4gb3JkZXIg
dG8gc3VwcG9ydCBvbi0NCj4gPiBkZW1hbmQgc2NhbGluZyBvZiBkZHJjIGJhc2VkIG9uIG1lYXN1
cmVkIGRyYW0gYmFuZHdpZHRoIHVzYWdlLg0KPiA+IA0KPiA+IFN1cHBvcnQgZm9yIHByb2FjdGl2
ZSBzY2FsaW5nIHZpYSBpbnRlcmNvbm5lY3Qgd2lsbCBjb21lIGxhdGVyLiBUaGUNCj4gPiBoaWdo
LXBlcmZvcm1hbmNlIGJ1cyBtYXN0ZXJzIHdoaWNoIG5lZWQgdGhhdCAoZGlzcGxheSwgdnB1LCBn
cHUpDQo+ID4gYXJlIG5vdCB5ZXQgZW5hYmxlZCBpbiB1cHN0cmVhbSBhbnl3YXkuDQo+ID4gDQo+
ID4gU2lnbmVkLW9mZi1ieTogTGVvbmFyZCBDcmVzdGV6IDxsZW9uYXJkLmNyZXN0ZXpAbnhwLmNv
bT4NCj4gPiAtLS0NCj4gPiAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLWV2
ay5kdHMgIHwgMTggKysrKysrKysrKysrKysNCj4gPiAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVl
c2NhbGUvaW14OG1tLmR0c2kgICAgIHwgMTcgKysrKysrKysrKysrLQ0KPiA+ICAuLi4vYm9vdC9k
dHMvZnJlZXNjYWxlL2lteDhtbi1kZHI0LWV2ay5kdHMgICAgfCAxOCArKysrKysrKysrKysrKw0K
PiA+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW4uZHRzaSAgICAgfCAxNiAr
KysrKysrKysrKystDQo+ID4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcS1l
dmsuZHRzICB8IDI0DQo+ID4gKysrKysrKysrKysrKysrKysrKw0KPiA+ICBhcmNoL2FybTY0L2Jv
b3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXEuZHRzaSAgICAgfCAxNiArKysrKysrKysrKystDQo+ID4g
IDYgZmlsZXMgY2hhbmdlZCwgMTA2IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4g
DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS1l
dmsuZHRzDQo+ID4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0tZXZrLmR0
cw0KPiA+IGluZGV4IDRmNWU0MDhkNmU2YS4uYmU5YWJkOGU0NDc4IDEwMDY0NA0KPiA+IC0tLSBh
L2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS1ldmsuZHRzDQo+ID4gKysrIGIv
YXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLWV2ay5kdHMNCj4gPiBAQCAtNjks
MTYgKzY5LDM0IEBADQo+ID4gIAkJc2ltcGxlLWF1ZGlvLWNhcmQsY29kZWMgew0KPiA+ICAJCQlz
b3VuZC1kYWkgPSA8JndtODUyND47DQo+ID4gIAkJCWNsb2NrcyA9IDwmY2xrIElNWDhNTV9DTEtf
U0FJM19ST09UPjsNCj4gPiAgCQl9Ow0KPiA+ICAJfTsNCj4gPiArDQo+ID4gKwlkZHJjX29wcF90
YWJsZTogZGRyYy1vcHAtdGFibGUgew0KPiA+ICsJCWNvbXBhdGlibGUgPSAib3BlcmF0aW5nLXBv
aW50cy12MiI7DQo+ID4gKw0KPiA+ICsJCW9wcC0yNU0gew0KPiA+ICsJCQlvcHAtaHogPSAvYml0
cy8gNjQgPDI1MDAwMDAwPjsNCj4gPiArCQl9Ow0KPiA+ICsJCW9wcC0xMDBNIHsNCj4gPiArCQkJ
b3BwLWh6ID0gL2JpdHMvIDY0IDwxMDAwMDAwMDA+Ow0KPiA+ICsJCX07DQo+ID4gKwkJb3BwLTc1
ME0gew0KPiA+ICsJCQlvcHAtaHogPSAvYml0cy8gNjQgPDc1MDAwMDAwMD47DQo+ID4gKwkJfTsN
Cj4gPiArCX07DQo+ID4gIH07DQo+ID4gIA0KPiA+ICAmQTUzXzAgew0KPiA+ICAJY3B1LXN1cHBs
eSA9IDwmYnVjazJfcmVnPjsNCj4gPiAgfTsNCj4gPiAgDQo+ID4gKyZkZHJjIHsNCj4gPiArCW9w
ZXJhdGluZy1wb2ludHMtdjIgPSA8JmRkcmNfb3BwX3RhYmxlPjsNCj4gPiArfTsNCj4gPiArDQo+
ID4gICZmZWMxIHsNCj4gPiAgCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+ID4gIAlwaW5j
dHJsLTAgPSA8JnBpbmN0cmxfZmVjMT47DQo+ID4gIAlwaHktbW9kZSA9ICJyZ21paS1pZCI7DQo+
ID4gIAlwaHktaGFuZGxlID0gPCZldGhwaHkwPjsNCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02
NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLmR0c2kNCj4gPiBiL2FyY2gvYXJtNjQvYm9vdC9k
dHMvZnJlZXNjYWxlL2lteDhtbS5kdHNpDQo+ID4gaW5kZXggNmVkYmRmZTJkMGQ3Li41NDA0ODcw
ZDgwZDUgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14
OG1tLmR0c2kNCj4gPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0u
ZHRzaQ0KPiA+IEBAIC04NTYsMTEgKzg1NiwyNiBAQA0KPiA+ICAJCQkjaW50ZXJydXB0LWNlbGxz
ID0gPDM+Ow0KPiA+ICAJCQlpbnRlcnJ1cHQtY29udHJvbGxlcjsNCj4gPiAgCQkJaW50ZXJydXB0
cyA9IDxHSUNfUFBJIDkgSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+ID4gIAkJfTsNCj4gPiAgDQo+
ID4gLQkJZGRyLXBtdUAzZDgwMDAwMCB7DQo+ID4gKwkJZGRyYzogZHJhbS1jb250cm9sbGVyQDNk
NDAwMDAwIHsNCj4gPiArCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14OG1tLWRkcmMiLCAiZnNsLGlt
eDhtLQ0KPiA+IGRkcmMiOw0KPiA+ICsJCQlyZWcgPSA8MHgzZDQwMDAwMCAweDQwMDAwMD47DQo+
IA0KPiBEbyB5b3UgcmVhbGx5IG5lZWQgdGhlIE9TIHRvIG1hcCA0TUIgb2YgcmVnaXN0ZXIgc3Bh
Y2U/IFZpcnR1YWwgDQo+IHNwYWNlIG9uIDY0LWJpdCBkb2Vzbid0IG1hdHRlciwgYnV0IGl0J3Mg
c3RpbGwgd2FzdGluZyAyS0Igb2YgbWVtb3J5IA0KPiBqdXN0IHRvIG1hcCBhbGwgdGhhdCBpZiBv
bmx5IGEgZmV3IHBhZ2VzIGFyZSBuZWVkZWQuIEFkZHMgdXAgaWYgdGhlIA0KPiB3aG9sZSBEVCBp
cyBkb25lIHRoaXMgd2F5Lg0KDQpUaGlzIGRyaXZlciBkb2Vzbid0IGFjdHVhbGx5IG1hcCByZWdp
c3RlcnMsIHRoZXkncmUgb25seSB0b3VjaGVkIGZyb20NCmZpcm13YXJlLg0KDQpJbmZvcm1hdGlv
biBpcyBmcm9tIG1lbW9yeSBtYXAuDQoNCj4gPiArCQkJY2xvY2stbmFtZXMgPSAiZHJhbV9jb3Jl
IiwNCj4gPiArCQkJCSAgICAgICJkcmFtX3BsbCIsDQo+ID4gKwkJCQkgICAgICAiZHJhbV9hbHQi
LA0KPiA+ICsJCQkJICAgICAgImRyYW1fYXBiIjsNCj4gPiArCQkJY2xvY2tzID0gPCZjbGsgSU1Y
OE1NX0NMS19EUkFNX0NPUkU+LA0KPiA+ICsJCQkJIDwmY2xrIElNWDhNTV9EUkFNX1BMTD4sDQo+
ID4gKwkJCQkgPCZjbGsgSU1YOE1NX0NMS19EUkFNX0FMVD4sDQo+ID4gKwkJCQkgPCZjbGsgSU1Y
OE1NX0NMS19EUkFNX0FQQj47DQo+ID4gKwkJCWRldmZyZXEtZXZlbnRzID0gPCZkZHJfcG11PjsN
Cj4gPiArCQkJb3BlcmF0aW5nLXBvaW50cy12MiA9IDwmZGRyY19vcHBfdGFibGU+Ow0KPiA+ICsJ
CX07DQo+ID4gKw0KPiA+ICsJCWRkcl9wbXU6IGRkci1wbXVAM2Q4MDAwMDAgew0KPiA+ICAJCQlj
b21wYXRpYmxlID0gImZzbCxpbXg4bW0tZGRyLXBtdSIsICJmc2wsaW14OG0tDQo+ID4gZGRyLXBt
dSI7DQo+ID4gIAkJCXJlZyA9IDwweDNkODAwMDAwIDB4NDAwMDAwPjsNCj4gPiAgCQkJaW50ZXJy
dXB0LXBhcmVudCA9IDwmZ2ljPjsNCj4gPiAgCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDk4IElS
UV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiA+ICAJCX07DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJt
NjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbi1kZHI0LWV2ay5kdHMNCj4gPiBiL2FyY2gvYXJt
NjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbi1kZHI0LWV2ay5kdHMNCj4gPiBpbmRleCAwNzE5
NDk0MTJjYWYuLmFiMjA2MDY2NzY3MSAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3Qv
ZHRzL2ZyZWVzY2FsZS9pbXg4bW4tZGRyNC1ldmsuZHRzDQo+ID4gKysrIGIvYXJjaC9hcm02NC9i
b290L2R0cy9mcmVlc2NhbGUvaW14OG1uLWRkcjQtZXZrLmR0cw0KPiA+IEBAIC05LDE2ICs5LDM0
IEBADQo+ID4gICNpbmNsdWRlICJpbXg4bW4tZXZrLmR0c2kiDQo+ID4gIA0KPiA+ICAvIHsNCj4g
PiAgCW1vZGVsID0gIk5YUCBpLk1YOE1OYW5vIEREUjQgRVZLIGJvYXJkIjsNCj4gPiAgCWNvbXBh
dGlibGUgPSAiZnNsLGlteDhtbi1kZHI0LWV2ayIsICJmc2wsaW14OG1uIjsNCj4gPiArDQo+ID4g
KwlkZHJjX29wcF90YWJsZTogZGRyYy1vcHAtdGFibGUgew0KPiANCj4gSSB0aGluayBpdCB3b3Vs
ZCBiZSBiZXR0ZXIgdG8gcHV0IHRoaXMgdW5kZXIgdGhlIGRkcmMgbm9kZSAoYW5kDQo+IG5hbWVk
ICdvcHAtdGFibGUnKS4gWWVzLCBpdCdzIGtpbmQgb2Ygc2lsbHkgdG8gaGF2ZSBhIHBoYW5kbGUg
dG8gYQ0KPiBjaGlsZCBub2RlLCBidXQgdGhhdCBzdGlsbCB3b3Jrcy4NCg0KVGhhdCBsb29rcyBt
dWNoIG5pY2VyLCBmaXhlZCBpbiB2NC4NCg0KSSBoYWQgdG8gYWxzbyB1cGRhdGUgeWFtbCB0byBl
eHBsaWNpdGx5IGFsbG93IGFuICJvcHAtdGFibGUiIGNoaWxkLg0KDQotLQ0KUmVnYXJkcywNCkxl
b25hcmQNCg==
