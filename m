Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1913919D002
	for <lists+linux-pm@lfdr.de>; Fri,  3 Apr 2020 08:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732205AbgDCGEd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Apr 2020 02:04:33 -0400
Received: from mail-vi1eur05on2055.outbound.protection.outlook.com ([40.107.21.55]:34681
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729349AbgDCGEc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 3 Apr 2020 02:04:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGk1S7tmKARpMBEfEUUZaIKKwilLVKwzLSGGr4CXAXT2FujaSuv397AKcccPsV4wZAc0iXpVAxrocR0AlvTgJ2OZnYEmvkkbUXfPyHmV+PhTu8Z4FinyARUnFwIybLodW/6LkSwd9lObR+TG8lYlQXMXDS2e33o9hd3doxzvyjWCDaMun8LinaFifRze9w1F3leIIfrjPyW0w8Qz/dOxwsNX0zbpV6ne/ekdIVhNvLBz7CNn7TTBasQKQtFGSbgs/NVd0jUMGpATKPfHlV8rohiX9iunjA0+ZOJ4kVJ4ZYnTbJLvuzPc6EtApsj7HU0S9A6ldGAJgCBACrGu5JiS4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIN5dNIlvs69Rn4pahqWgK0da1Wui7pgdYrlq1liUGc=;
 b=R7w55taEmbK4bsaBg27xqKuZ0ffiYSZCemhK+Fy1Ifmi+CPeIsEO7qMLoHOpxgb4/c/iFXa2bbxTBFJsv2ZH9wszGa6+9uD93/qFGddfGeV1X2IhMbdpxKOx4W6IBmBxjcYXp0bDd4srCpvSGxjm4DmY+0yzy2aV5/eHwEC23LsurTh9Sko+GejLRa/xqqflhyFUYjVV76W0Z7JER9kN8/uCPCT64l0VZnd3MUK7aUhE3olIW7rOKrjfwqhUjxkVizrqsu6iC7+d7H3lZVKj1F8WMuKgo+SnHkH1PEMtm0aecv8oEzHDg3r/bb80G+Neft6CmTNPXKO6mYB8mBZcUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIN5dNIlvs69Rn4pahqWgK0da1Wui7pgdYrlq1liUGc=;
 b=nB5lwJTrkKWttP5Fu+ALI2BRith7v1zypWc3BrmCcWauOzhikgY2geWmeQQT5ccutX5h47oL775xAugEAGOchYW9kuqXLY2POMPypGdnnqnV0WWrwDQKF5V31U5hrdrlaa9aRXSr4kvMBlIDnNMqVzC3hQn8z23C+Uxc3wIKSrA=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB3PR0402MB3739.eurprd04.prod.outlook.com (2603:10a6:8:6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16; Fri, 3 Apr
 2020 06:04:28 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b%7]) with mapi id 15.20.2878.017; Fri, 3 Apr 2020
 06:04:28 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Amit Kucheria <amit.kucheria@verdurent.com>
CC:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V3 3/3] arm64: dts: imx8mp: Add thermal zones support
Thread-Topic: [PATCH V3 3/3] arm64: dts: imx8mp: Add thermal zones support
Thread-Index: AQHWAQ+QtAia75yS0Eqy8vkWi4oyW6hltAKAgAEav0CAACVmgIAABLNA
Date:   Fri, 3 Apr 2020 06:04:28 +0000
Message-ID: <DB3PR0402MB391651B42ABEBCF29F8AB4E3F5C70@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1584966504-21719-1-git-send-email-Anson.Huang@nxp.com>
 <1584966504-21719-3-git-send-email-Anson.Huang@nxp.com>
 <CAHLCerNG3ZBbWrTwXxCbd1BOfyHxuvpAuo5tW_bNKgWcO5zESA@mail.gmail.com>
 <DB3PR0402MB3916AF241DE20AB9CCE1A4C2F5C70@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAHLCerMEn7g3a-MG9xiiLKMUCLXjKRiuZ_wMjRjPJCXvDMzDdA@mail.gmail.com>
In-Reply-To: <CAHLCerMEn7g3a-MG9xiiLKMUCLXjKRiuZ_wMjRjPJCXvDMzDdA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [183.192.13.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 28dad147-79b2-4fe6-c4e7-08d7d794de97
x-ms-traffictypediagnostic: DB3PR0402MB3739:|DB3PR0402MB3739:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB37394ADA379FFE5832254055F5C70@DB3PR0402MB3739.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 0362BF9FDB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(366004)(396003)(39860400002)(136003)(376002)(6916009)(6506007)(33656002)(81166006)(2906002)(8936002)(71200400001)(86362001)(5660300002)(316002)(8676002)(53546011)(4326008)(54906003)(44832011)(64756008)(76116006)(26005)(7696005)(66446008)(66556008)(66476007)(9686003)(81156014)(7416002)(478600001)(55016002)(186003)(52536014)(66946007)(32563001);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S4JN3Tni2GBOpXp/ZsFVkX21FtOHGwRW9EEGLB2JJtPOLtibHmHhvMe79LsOeABKK8mHnJVmB5nLHXP0SKPavvLu4OSB07eNvKkmBSVH2E/OgeIXcSYFQep0b1RkP1aAL4rbhAXZ+jQu3gisAFvFy7Dqz7gLxGy8oPGki92FQ65l2snJKUDQE5NFHtjn1aHnyHLsCYKqY6/Wn/DGks+v6QEcsV6CgPPgRREhz8pnALkjHdKbF0LPEjw9ZMLsqwd+uWXGGwe8HOhW4TjSf67EtWgjQnlVsSonMHk+ty5Wf0JF/430QIbNCREsWR5kpNGvmzS5/aLJn9ReIHK+l0Tkh9kQ4nj/8Jbj50xUXl3/xJvl0IxSdPq99gP1OJQGhOFfgCEvt34KRXGEPjtKoLV91f9azeaK3s/PuLJe9QG3cOML8bskjE+ceKtQLjD+BfFBds6807jyyqQ8wmgj2btR3mBehPCkFfvJKpK7ryTUhzzNSbM2ZclGfdZWRxW0Tlsp
x-ms-exchange-antispam-messagedata: CkDzBa6NA7Y3fIW3i3asETPWFqcxhppjedHR0frSt9cyeDOMxFS+02ZtQB14eQtKWEVOzYUkm5uPMBmg3JDQjbhET0PkuS2mQ0s8tetz8tiHmoihbCWNTH8yUobSYFNZcDA0pF42pMHF4xZ9023H6A==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28dad147-79b2-4fe6-c4e7-08d7d794de97
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2020 06:04:28.4125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kn5ABukaC/UZh5yRXPouxzdzbfIJk/XCl9Tb8ZImB3Y0wGe9LC4dw5IeyzA1W4/qzoYe7CQfICmMW/fD7OpBgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3739
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIEFtaXQNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFYzIDMvM10gYXJtNjQ6IGR0czogaW14
OG1wOiBBZGQgdGhlcm1hbCB6b25lcyBzdXBwb3J0DQo+IA0KPiBPbiBGcmksIEFwciAzLCAyMDIw
IGF0IDk6MDQgQU0gQW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+IHdyb3RlOg0KPiA+
DQo+ID4gSGksIEFtaXQNCj4gPg0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCBWMyAzLzNdIGFy
bTY0OiBkdHM6IGlteDhtcDogQWRkIHRoZXJtYWwgem9uZXMNCj4gPiA+IHN1cHBvcnQNCj4gPiA+
DQo+ID4gPiBPbiBNb24sIE1hciAyMywgMjAyMCBhdCA2OjA1IFBNIEFuc29uIEh1YW5nDQo+IDxB
bnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+ID4gd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+IGkuTVg4
TVAgaGFzIGEgVE1VIGluc2lkZSB3aGljaCBzdXBwb3J0cyB0d28gdGhlcm1hbCB6b25lcywgYWRk
DQo+ID4gPiA+IHN1cHBvcnQgZm9yIHRoZW0uDQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYt
Ynk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+ID4NCj4gPiA+DQo+ID4g
PiBbc25pcF0NCj4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+ICsgICAgICAgdGhlcm1hbC16b25lcyB7
DQo+ID4gPiA+ICsgICAgICAgICAgICAgICBjcHUtdGhlcm1hbCB7DQo+ID4gPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgIHBvbGxpbmctZGVsYXktcGFzc2l2ZSA9IDwyNTA+Ow0KPiA+ID4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICBwb2xsaW5nLWRlbGF5ID0gPDIwMDA+Ow0KPiA+ID4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICB0aGVybWFsLXNlbnNvcnMgPSA8JnRtdSAweDA+Ow0KPiA+
ID4NCj4gPiA+IE5vIG5lZWQgZm9yIDB4MCwganVzdCB1c2UgMA0KPiA+DQo+ID4gT0suDQo+ID4N
Cj4gPiA+DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHRyaXBzIHsNCj4gPiA+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjcHVfYWxlcnQwOiB0cmlwMCB7DQo+ID4g
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0ZW1wZXJhdHVyZSA9
IDw4NTAwMD47DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBoeXN0ZXJlc2lzID0gPDIwMDA+Ow0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgdHlwZSA9ICJwYXNzaXZlIjsNCj4gPiA+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB9Ow0KPiA+ID4gPiArDQo+ID4gPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgY3B1X2NyaXQwOiB0cmlwMSB7DQo+ID4gPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB0ZW1wZXJhdHVyZSA9IDw5NTAwMD47DQo+ID4gPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBoeXN0ZXJlc2lzID0gPDIw
MDA+Ow0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdHlw
ZSA9ICJjcml0aWNhbCI7DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
fTsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgfTsNCj4gPiA+ID4gKw0KPiA+ID4g
PiArICAgICAgICAgICAgICAgICAgICAgICBjb29saW5nLW1hcHMgew0KPiA+ID4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIG1hcDAgew0KPiA+ID4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgdHJpcCA9IDwmY3B1X2FsZXJ0MD47DQo+ID4gPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb29saW5nLWRldmljZSA9DQo+
ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwm
QTUzXzANCj4gPiA+IFRIRVJNQUxfTk9fTElNSVQgVEhFUk1BTF9OT19MSU1JVD4sDQo+ID4gPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwmQTUzXzEN
Cj4gPiA+IFRIRVJNQUxfTk9fTElNSVQgVEhFUk1BTF9OT19MSU1JVD4sDQo+ID4gPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwmQTUzXzINCj4gPiA+
IFRIRVJNQUxfTk9fTElNSVQgVEhFUk1BTF9OT19MSU1JVD4sDQo+ID4gPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwmQTUzXzMNCj4gPiA+IFRIRVJN
QUxfTk9fTElNSVQgVEhFUk1BTF9OT19MSU1JVD47DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfTsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgfTsNCj4g
PiA+ID4gKyAgICAgICAgICAgICAgIH07DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAgICAgICAg
ICAgIHNvYy10aGVybWFsIHsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcG9sbGlu
Zy1kZWxheS1wYXNzaXZlID0gPDI1MD47DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
IHBvbGxpbmctZGVsYXkgPSA8MjAwMD47DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
IHRoZXJtYWwtc2Vuc29ycyA9IDwmdG11IDB4MT47DQo+ID4gPg0KPiA+ID4gTm8gbmVlZCBmb3Ig
MHgxLCBqdXN0IHVzZSAxDQo+ID4NCj4gPiBPSy4NCj4gPg0KPiA+ID4NCj4gPiA+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgdHJpcHMgew0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHNvY19hbGVydDA6IHRyaXAwIHsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHRlbXBlcmF0dXJlID0gPDg1MDAwPjsNCj4gPiA+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGh5c3RlcmVzaXMgPSA8MjAwMD47
DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0eXBlID0g
InBhc3NpdmUiOw0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH07DQo+
ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzb2NfY3Jp
dDA6IHRyaXAxIHsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHRlbXBlcmF0dXJlID0gPDk1MDAwPjsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGh5c3RlcmVzaXMgPSA8MjAwMD47DQo+ID4gPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0eXBlID0gImNyaXRpY2FsIjsNCj4gPiA+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB9Ow0KPiA+ID4gPiArICAgICAgICAg
ICAgICAgICAgICAgICB9Ow0KPiA+ID4NCj4gPiA+IFlvdSBuZWVkIGEgY29vbGluZy1tYXAgaGVy
ZSBzaW5jZSB5b3UgaGF2ZSBhIHBhc3NpdmUgdHJpcCBwb2ludC4NCj4gPg0KPiA+IEN1cnJlbnRs
eSwgdGhlcmUgaXMgbm8gY29vbGluZyBtYXAgZGVmaW5lZCBmb3Igc29jIHRoZXJtYWwgem9uZSwg
dGhlDQo+ID4gY3B1ZnJlcSBjb29saW5nIGlzIG1hcHBlZCB0byBjcHUgdGhlcm1hbCB6b25lIGFs
cmVhZHksIHNvIGRvIHlvdSB0aGluaw0KPiA+IGl0IGlzIE9LIHRvIGxlYXZlIGl0IGFzIG5vIGNv
b2xpbmcgbWFwLCBvciBpdCBpcyBiZXR0ZXIgdG8gcHV0IGNwdWZyZXEgY29vbGluZyBmb3INCj4g
c29jIHRoZXJtYWwgem9uZSBhcyB3ZWxsPw0KPiA+DQo+IA0KPiBJZiB0aGVyZSBpcyBubyBjb29s
aW5nLCB3aHkgZG8geW91IG5lZWQgYSBwYXNzaXZlIHRyaXAgcG9pbnQ/IEp1c3QgbWFrZSBpdCBh
IGhvdA0KPiB0cmlwIHRoYXQgd2lsbCBzZW5kIHlvdSBhIG5vZmljYXRpb24gKGlmIC5ub3RpZnkg
Y2FsbGJhY2sgcmVnaXN0ZXJlZCkuDQoNCk9LLCB1bmRlcnN0b29kLCBJIHByZWZlciB0byBrZWVw
IHRoZSBwYXNzaXZlIHRyaXAgcG9pbnQgc2FtZSBhcyBjcHUgdGhlcm1hbCB6b25lLA0Kc28gSSB3
aWxsIGFsc28gcHV0IHRoZSBjcHVmcmVxIGNvb2xpbmcgbWFwIGZvciBzb2MgdGhlcm1hbCB6b25l
Lg0KDQpUaGFua3MsDQpBbnNvbg0K
