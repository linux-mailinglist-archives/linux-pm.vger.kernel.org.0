Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3A610889C
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2019 07:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725497AbfKYGF5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Nov 2019 01:05:57 -0500
Received: from mail-eopbgr70072.outbound.protection.outlook.com ([40.107.7.72]:64080
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725468AbfKYGF5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 25 Nov 2019 01:05:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTIGFDjqV4DwgfGrd3mt5C0P2P2EkTc2M8npEefVymJCcV4Lq4beUzJN29s0yBCIausqTbkO61+5bpgDWZuTQ1TYzO78PsvbzZ9cKf/yGEsbGqkW3ej/qRMAis+SmOCRjhanad7KSK2WBmD4j3AUSpTL5Vs22DKS62KqDpTHQ+Y1Ggq6Cy4aSuFKWbROXwt7/nBFwAwQRUYy0zKT3YwHB4y5c7K6xI/Q0gfUSGRQpXzWyxNMCbZoTSBMevhSkJ1XY5k+w1LrOBBEAT+4Vpq+F9Hh3OjUJi/aNpXl0CQ21c3u2zwBp5/aXoVNSG6spc7N9BHgc9Lpix9xboAj4ZDu0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VqIq/jOBzkySpwSnC1CSz7zLowzJNM5lyioMbTNBZY=;
 b=lFIpSslNAGHgdY5ERFC0xcWGThZJfRYiAQQj0vl+aXkI7wFY8pEp+yljn7FIkx26JtHBq8fSnBThqxdY4iMHMw9fLXGEhZJsJYQ6o0OClYDle7M3zVEKpZSslOUykmLEW5D5pZ1NJhLcfBxSx8w8+V6RNG2COC66iQs3imVbMAkMALdtE51slrLVkbkFg0bbB5HIYTjnukA7G7jy0ZSwz1v2TNVz2TaP7E0U1FnDfAq+TjUa+NQjEV1OKhQq1D8uVrPqNhsIGmBNnMkNIYrztyxj6t0CMglhQxcTZcgOK64AaUK8KEPDgMamx1QhP23R7rYuiWn+iKUCJlZedUPs3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VqIq/jOBzkySpwSnC1CSz7zLowzJNM5lyioMbTNBZY=;
 b=OPSLTgFYS/osyPoBgqfsYYWiDMIgshpl7dpPlXiMPWL9ijzA6uR/dVrPYxTNYXpMfafoIOfZkoTeLzRH1I/I1dKUFxlCYBuBPYf5BBi41JBqWVXQh7jseyz7MPvid07sbfZS7rctHfKHU+4vW6rJbfgIz0yA1eFHnMq4kNqBFbw=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3676.eurprd04.prod.outlook.com (52.134.70.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Mon, 25 Nov 2019 06:05:50 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::b8dd:75d4:49ea:6360]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::b8dd:75d4:49ea:6360%5]) with mapi id 15.20.2474.023; Mon, 25 Nov 2019
 06:05:50 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Viresh Kumar <viresh.kumar@linaro.org>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: About CPU hot-plug stress test failed in cpufreq driver
Thread-Topic: About CPU hot-plug stress test failed in cpufreq driver
Thread-Index: AdWgM3EuFQeyF1SHRka5sBhDxaFShQAG6J6AAAAKxPAAAq52AAAAFLaAACYwDoAACh8qAAAASXeA
Date:   Mon, 25 Nov 2019 06:05:49 +0000
Message-ID: <DB3PR0402MB39165E40800E42C2E5635C7CF54A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <DB3PR0402MB391626A8ECFDC182C6EDCF8DF54E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20191121093557.bycvdo4xyinbc5cb@vireshk-i7>
 <DB3PR0402MB39165544EDD0317095A1B72DF54E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAJZ5v0geykeebX-67+h4twj+t7oTVBf7X7_UsXw0LAc+0Ap75Q@mail.gmail.com>
 <CAJZ5v0j4z9tEDCGKRc7dHqTiJ1Fq3So=ELfvR6H25UkRmKeBvg@mail.gmail.com>
 <DB3PR0402MB3916BDC24BDA1053B7ADBDCFF5490@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAJZ5v0g5EGWVAm4A8ynoWAPc1wJRpR6wgZqwhvbmeT4eT49EUA@mail.gmail.com>
In-Reply-To: <CAJZ5v0g5EGWVAm4A8ynoWAPc1wJRpR6wgZqwhvbmeT4eT49EUA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b2b25ae0-c1c2-44cc-5937-08d7716d8586
x-ms-traffictypediagnostic: DB3PR0402MB3676:|DB3PR0402MB3676:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3676AC921301D3F7BF1E17A2F54A0@DB3PR0402MB3676.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0232B30BBC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(199004)(189003)(3846002)(6116002)(14454004)(6916009)(25786009)(478600001)(55016002)(9686003)(6436002)(11346002)(7696005)(186003)(76176011)(66946007)(66556008)(44832011)(66446008)(66476007)(64756008)(76116006)(102836004)(5660300002)(446003)(66066001)(53546011)(26005)(52536014)(6506007)(2906002)(71190400001)(71200400001)(14444005)(256004)(316002)(99286004)(8936002)(33656002)(74316002)(305945005)(7736002)(86362001)(4326008)(229853002)(6246003)(54906003)(81166006)(81156014)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3676;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IUSHVznogsAlFmRhiRM6mr39XREA47HcExQCJtbdc897zF/dagnR4hPbbJ7Yt9FZhwfBLKNWYeKIn6yxpo9OhE27YzAvepIHgbtf+EiAfWhJH6pdEbfmCfxkH/2upBJAb6p8ltMejHwhCyDBdktk0DD0YvOHmy6bCYNEAtYEBYlvXAEgRkOWtPLWLDZMccLG2098P7s53Of9vSDfn8V1LDPncmSU3itCKGJ1CcK10k2D1rvK3ZxKguUS3qJaK9lBeeqswzu3g3aeyJyClFVAay3v+A7pn6IMKxSFi8EHDsKysQSaIMRZ+S7K9p/HUgRVjlsbEdQF7P9fPX6U0aIRRmagd8d+67VV4KF1YFlGhex1vkxQpy0WSci1cyfWA+DaggX+jB32nbrM9skjuGFNdJh5antN9pUT0Qg14dcheihw+8rbxZ4i1eh2WIo1Fesz
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b25ae0-c1c2-44cc-5937-08d7716d8586
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2019 06:05:50.0373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nU3OEOD2i+3oYeJMPSIzsSeOUTmYXA0OZaHvoY4jY8I+4Qt7H6WTe6CqzbgsuWvICDiXaaPfRJAJgzVElRxWiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3676
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIFJhZmFlbA0KCUxvb2tzIGxpa2UgYWRkaW5nIHByX2luZm8oKSBpbiBpcnFfd29ya19zeW5j
KCkgbWFrZXMgaXNzdWUgY2FuIE5PVCBiZSByZXByb2R1Y2VkLCBhbnkgcG9zc2liaWxpdHkgb2Yg
cmFjZSBoYXBwZW4gdGhlcmUgYW5kIHRoZSBwcl9pbmZvIGVsaW1pbmF0ZSB0aGUgcmFjZSBjb25k
aXRpb24/IEkgd2lsbCBjb250aW51ZSBydW4gdGhlIHRlc3Qgd2l0aCB0aGUgcHJfaW5mbyB0byBz
ZWUgaWYgYW55IGx1Y2sgdG8gcmVwcm9kdWNlIGl0Lg0KDQpBbnNvbg0KDQo+IE9uIEZyaSwgTm92
IDIyLCAyMDE5IGF0IDY6MTUgQU0gQW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+DQo+
IHdyb3RlOg0KPiA+DQo+ID4gSGksIFJhZmFlbA0KPiA+ICAgICAgICAgVGhlb3JldGljYWxseSwg
eWVzLCB0aGUgQ1BVIGJlaW5nIG9mZmxpbmUgd2lsbCBydW4gdGhlIGlycQ0KPiA+IHdvcmsgbGlz
dCB0byBtYWtlIHN1cmUgdGhlIGlycSB3b3JrIHBlbmRpbmcgb24gaXQgd2lsbCBiZSBjbGVhciwg
YnV0DQo+ID4gdGhlIGZhY3QgaXMgTk9ULA0KPiANCj4gU28gdGhpcyBsb29rcyBsaWtlIGEgcHJv
YmxlbSB3aXRoIGlycV93b3JrX3N5bmMoKSB3b3JraW5nIG5vdCBhcyBleHBlY3RlZC4NCj4gDQo+
ID4gICAgICAgICBib3RoIG9uZGVtYW5kIGFuZCBzY2hlZHV0aWwgZ292ZXJub3IgY2FuIHJlcHJv
ZHVjZSB0aGlzIGlzc3VlIGlmDQo+IHJ1bm5pbmcgc3RyZXNzIENQVSBob3RwbHVnIHRlc3QuDQo+
ID4gICAgICAgICBJIHRyaWVkIGFkZCBhICJpbnQgY3B1IiBpbiBpcnEgd29yayBzdHJ1Y3R1cmUg
dG8gcmVjb3JkIENQVSBudW1iZXINCj4gd2hpY2ggaGFzIGlycSB3b3JrIHBlbmRpbmcsIHdoZW4g
aXNzdWUgaGFwcGVuLCBJIGNhbiBzZWUgdGhlIGlycSB3b3JrIGlzDQo+IHBlbmRpbmcgYXQgQ1BV
ICMzIHdoaWNoIGlzIGFscmVhZHkgb2ZmbGluZSwgdGhpcyBpcyB3aHkgaXNzdWUgaGFwcGVuLCBi
dXQgSQ0KPiBkb24ndCBrbm93IGhvdyBpdCBoYXBwZW5zLi4uDQo+ID4NCj4gPiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9saW51eC9pcnFfd29yay5oIGIvaW5jbHVkZS9saW51eC9pcnFfd29yay5oIGlu
ZGV4DQo+ID4gYjExZmNkZi4uZjhkYTA2ZjkgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51
eC9pcnFfd29yay5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9pcnFfd29yay5oDQo+ID4gQEAg
LTI1LDYgKzI1LDcgQEAgc3RydWN0IGlycV93b3JrIHsNCj4gPiAgICAgICAgIHVuc2lnbmVkIGxv
bmcgZmxhZ3M7DQo+ID4gICAgICAgICBzdHJ1Y3QgbGxpc3Rfbm9kZSBsbG5vZGU7DQo+ID4gICAg
ICAgICB2b2lkICgqZnVuYykoc3RydWN0IGlycV93b3JrICopOw0KPiA+ICsgICAgICAgaW50IGNw
dTsNCj4gPiAgfTsNCj4gPg0KPiA+ICBzdGF0aWMgaW5saW5lDQo+ID4gZGlmZiAtLWdpdCBhL2tl
cm5lbC9pcnFfd29yay5jIGIva2VybmVsL2lycV93b3JrLmMgaW5kZXgNCj4gPiBkNDJhY2FmLi4y
ZTg5M2Q1IDEwMDY0NA0KPiA+IC0tLSBhL2tlcm5lbC9pcnFfd29yay5jDQo+ID4gKysrIGIva2Vy
bmVsL2lycV93b3JrLmMNCj4gPiBAQCAtMTAsNiArMTAsNyBAQA0KPiA+ICAjaW5jbHVkZSA8bGlu
dXgva2VybmVsLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9leHBvcnQuaD4NCj4gPiAgI2luY2x1
ZGUgPGxpbnV4L2lycV93b3JrLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9qaWZmaWVzLmg+DQo+
ID4gICNpbmNsdWRlIDxsaW51eC9wZXJjcHUuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L2hhcmRp
cnEuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L2lycWZsYWdzLmg+DQo+ID4gQEAgLTc4LDYgKzc5
LDcgQEAgYm9vbCBpcnFfd29ya19xdWV1ZShzdHJ1Y3QgaXJxX3dvcmsgKndvcmspDQo+ID4gICAg
ICAgICBpZiAoIWlycV93b3JrX2NsYWltKHdvcmspKQ0KPiA+ICAgICAgICAgICAgICAgICByZXR1
cm4gZmFsc2U7DQo+ID4NCj4gPiArICAgICAgIHdvcmstPmNwdSA9IHNtcF9wcm9jZXNzb3JfaWQo
KTsNCj4gPiAgICAgICAgIC8qIFF1ZXVlIHRoZSBlbnRyeSBhbmQgcmFpc2UgdGhlIElQSSBpZiBu
ZWVkZWQuICovDQo+ID4gICAgICAgICBwcmVlbXB0X2Rpc2FibGUoKTsNCj4gPiAgICAgICAgIF9f
aXJxX3dvcmtfcXVldWVfbG9jYWwod29yayk7DQo+ID4gQEAgLTEwNSw2ICsxMDcsNyBAQCBib29s
IGlycV93b3JrX3F1ZXVlX29uKHN0cnVjdCBpcnFfd29yayAqd29yaywNCj4gaW50IGNwdSkNCj4g
PiAgICAgICAgIC8qIE9ubHkgcXVldWUgaWYgbm90IGFscmVhZHkgcGVuZGluZyAqLw0KPiA+ICAg
ICAgICAgaWYgKCFpcnFfd29ya19jbGFpbSh3b3JrKSkNCj4gPiAgICAgICAgICAgICAgICAgcmV0
dXJuIGZhbHNlOw0KPiA+ICsgICAgICAgd29yay0+Y3B1ID0gY3B1Ow0KPiA+DQo+ID4gICAgICAg
ICBwcmVlbXB0X2Rpc2FibGUoKTsNCj4gPiAgICAgICAgIGlmIChjcHUgIT0gc21wX3Byb2Nlc3Nv
cl9pZCgpKSB7IEBAIC0xNjEsNiArMTY0LDcgQEAgc3RhdGljDQo+ID4gdm9pZCBpcnFfd29ya19y
dW5fbGlzdChzdHJ1Y3QgbGxpc3RfaGVhZCAqbGlzdCkNCj4gPiAgICAgICAgICAgICAgICAgICov
DQo+ID4gICAgICAgICAgICAgICAgIGZsYWdzID0gd29yay0+ZmxhZ3MgJiB+SVJRX1dPUktfUEVO
RElORzsNCj4gPiAgICAgICAgICAgICAgICAgeGNoZygmd29yay0+ZmxhZ3MsIGZsYWdzKTsNCj4g
PiArICAgICAgICAgICAgICAgd29yay0+Y3B1ID0gLTE7DQo+ID4NCj4gPiAgICAgICAgICAgICAg
ICAgd29yay0+ZnVuYyh3b3JrKTsNCj4gPiAgICAgICAgICAgICAgICAgLyoNCj4gPiBAQCAtMTk3
LDkgKzIwMSwxMyBAQCB2b2lkIGlycV93b3JrX3RpY2sodm9pZCkNCj4gPiAgICovDQo+ID4gIHZv
aWQgaXJxX3dvcmtfc3luYyhzdHJ1Y3QgaXJxX3dvcmsgKndvcmspICB7DQo+ID4gKyAgICAgICB1
bnNpZ25lZCBsb25nIHRpbWVvdXQgPSBqaWZmaWVzICsgbXNlY3NfdG9famlmZmllcyg1MDApOw0K
PiA+ICAgICAgICAgbG9ja2RlcF9hc3NlcnRfaXJxc19lbmFibGVkKCk7DQo+IA0KPiBDYW4geW91
IHBsZWFzZSBhZGQgc29tZXRoaW5nIGxpa2UNCj4gDQo+IHByX2luZm8oIiVzOiBDUFUgJWRcbiIs
IF9fZnVuY19fLCB3b3JrLT5jcHUpOw0KPiANCj4gaGVyZSByZS1ydW4gdGhlIHRlc3QgYW5kIGNv
bGxlY3QgYSBsb2cgYWdhaW4/DQo+IA0KPiBJIG5lZWQgdG8ga25vdyBpZiBpcnFfd29ya19zeW5j
KCkgcnVucyBkdXJpbmcgQ1BVIG9mZmxpbmUgYXMgZXhwZWN0ZWQuDQo+IA0KPiA+DQo+ID4gLSAg
ICAgICB3aGlsZSAod29yay0+ZmxhZ3MgJiBJUlFfV09SS19CVVNZKQ0KPiA+ICsgICAgICAgd2hp
bGUgKHdvcmstPmZsYWdzICYgSVJRX1dPUktfQlVTWSkgew0KPiA+ICsgICAgICAgICAgICAgICBp
ZiAodGltZV9hZnRlcihqaWZmaWVzLCB0aW1lb3V0KSkNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICBwcl93YXJuKCJpcnFfd29ya19zeW5jIDUwMG1zIHRpbWVvdXQsIHdvcmsgY3B1DQo+ID4g
KyAlZFxuIiwgd29yay0+Y3B1KTsNCj4gPiAgICAgICAgICAgICAgICAgY3B1X3JlbGF4KCk7DQo+
ID4gKyAgICAgICB9DQo+ID4gIH0NCj4gPiAgRVhQT1JUX1NZTUJPTF9HUEwoaXJxX3dvcmtfc3lu
Yyk7DQo=
