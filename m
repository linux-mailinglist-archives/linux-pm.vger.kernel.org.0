Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 019761A670
	for <lists+linux-pm@lfdr.de>; Sat, 11 May 2019 06:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725888AbfEKEEx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 11 May 2019 00:04:53 -0400
Received: from mail-eopbgr50042.outbound.protection.outlook.com ([40.107.5.42]:51085
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725882AbfEKEEx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 11 May 2019 00:04:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPN5++gogOJxwCHah6Jmh/Kr0SGGwqKeanq2XriIMj4=;
 b=ZIRar0lktYrWpSRCRlpQ4sEflJ+pYfPd5b4wf2MOKjQT/LtQTGE3ZxUrhO2zssph6aZa6FJ3DTWVadfo22DGxNLA53nL0tAvfDH16Kw4WcUyfoUX/T9MDlpApn2uB/Pbf5S4O8N+mW0T05zuaYU53BN+T1LHgMo0fp/MdRQYDhI=
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com (52.134.122.155) by
 VI1PR04MB5999.eurprd04.prod.outlook.com (20.178.123.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Sat, 11 May 2019 04:04:48 +0000
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::3ca0:86a9:eb1:a8c2]) by VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::3ca0:86a9:eb1:a8c2%4]) with mapi id 15.20.1878.022; Sat, 11 May 2019
 04:04:48 +0000
From:   Andy Tang <andy.tang@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>
Subject: RE: [EXT] Re: [PATCH v6] arm64: dts: ls1088a: add one more thermal
 zone node
Thread-Topic: [EXT] Re: [PATCH v6] arm64: dts: ls1088a: add one more thermal
 zone node
Thread-Index: AQHU+XzmCgrzkjA8mUWSxshg4ZOzYKZjybwAgAADYUCAAEB/AIAAD+oggAAhM4CAASpssA==
Date:   Sat, 11 May 2019 04:04:48 +0000
Message-ID: <VI1PR04MB43330D9FC454AEF3F96E7CEAF30D0@VI1PR04MB4333.eurprd04.prod.outlook.com>
References: <20190423022507.34969-1-andy.tang@nxp.com>
 <20190510031335.GD15856@dragon>
 <VI1PR04MB4333D24227603D1497BA3CB9F30C0@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <9fb2e306-38c7-2af7-5470-ff5bc4e23370@linaro.org>
 <VI1PR04MB4333372C1DABD0E4C9DD7FE8F30C0@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20190510101219.oruzvzlk7mm6iahw@vireshk-i7>
In-Reply-To: <20190510101219.oruzvzlk7mm6iahw@vireshk-i7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andy.tang@nxp.com; 
x-originating-ip: [92.121.68.134]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd61186c-3b0a-4f87-49a7-08d6d5c5cf8a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5999;
x-ms-traffictypediagnostic: VI1PR04MB5999:
x-microsoft-antispam-prvs: <VI1PR04MB599991FD5A11608491FDA1A0F30D0@VI1PR04MB5999.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 00342DD5BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(1496009)(136003)(346002)(376002)(366004)(396003)(39860400002)(199004)(189003)(13464003)(7736002)(6916009)(3846002)(305945005)(71200400001)(71190400001)(8936002)(53546011)(446003)(11346002)(99286004)(76176011)(7696005)(6506007)(256004)(66556008)(44832011)(81156014)(66476007)(102836004)(8676002)(7416002)(486006)(76116006)(73956011)(64756008)(66946007)(476003)(81166006)(66446008)(9686003)(54906003)(186003)(229853002)(6116002)(5660300002)(26005)(74316002)(6436002)(55016002)(33656002)(68736007)(66066001)(53936002)(6246003)(2906002)(478600001)(316002)(4326008)(86362001)(52536014)(14454004)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5999;H:VI1PR04MB4333.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: U2B2iT/FHYJgCLKocKMshLHVY98jj/ZUyK25g8fhrzzPuxEi3VNUCcphtf5tDmJwU4GUWXZ+CN5/G1zxnggrzRM5J3PaDNHB+0fJ5964h4IW//bgMe4Iep1IxFxFqF9BWgQc3VChCVrRJDab5WbbTKFVVD6U8oCHGFiN/EN3jH4NZPRzbbNoPfTXWgOv0rPwQapjGogIao8hRlH/fhmMzRq7qaEDw3Wh+o+f9Gz7LPbH0JmTKnFJDQ6TFtNUmp/BCCq62Zd8+0sE2Ak7TmzqAQ0VTup8m6wdf7FT6qwC5W2uHnaTBG7NYLTChOBEG4JNNOONT/UUIUFCFaoPafIXjPOoDVgcqxmHjqHiI0yTM/YAbcSg802H8IvLEa1GMpKacMgCwPAgFBIMUGWNpOd3/42N+I72hTFoEZFcB+CIPMU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd61186c-3b0a-4f87-49a7-08d6d5c5cf8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2019 04:04:48.5743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5999
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

VGhhbmtzIFZpcmVzaCBmb3IgeW91ciBleHBsYW5hdGlvbi4NCg0KQlIsDQpBbmR5DQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFZpcmVzaCBLdW1hciA8dmlyZXNoLmt1bWFy
QGxpbmFyby5vcmc+DQo+IFNlbnQ6IDIwMTnlubQ15pyIMTDml6UgMTg6MTINCj4gVG86IEFuZHkg
VGFuZyA8YW5keS50YW5nQG54cC5jb20+DQo+IENjOiBEYW5pZWwgTGV6Y2FubyA8ZGFuaWVsLmxl
emNhbm9AbGluYXJvLm9yZz47IFNoYXduIEd1bw0KPiA8c2hhd25ndW9Aa2VybmVsLm9yZz47IExl
byBMaSA8bGVveWFuZy5saUBueHAuY29tPjsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPiBtYXJrLnJ1
dGxhbmRAYXJtLmNvbTsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBk
ZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsN
Cj4gbGludXgtcG1Admdlci5rZXJuZWwub3JnOyBydWkuemhhbmdAaW50ZWwuY29tOyBlZHViZXp2
YWxAZ21haWwuY29tDQo+IFN1YmplY3Q6IFJlOiBbRVhUXSBSZTogW1BBVENIIHY2XSBhcm02NDog
ZHRzOiBsczEwODhhOiBhZGQgb25lIG1vcmUgdGhlcm1hbA0KPiB6b25lIG5vZGUNCj4gDQo+IENh
dXRpb246IEVYVCBFbWFpbA0KPiANCj4gT24gMTAtMDUtMTksIDA4OjQ3LCBBbmR5IFRhbmcgd3Jv
dGU6DQo+ID4gKyBWaXJlc2ggZm9yIGhlbHAuDQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBEYW5pZWwgTGV6Y2FubyA8ZGFuaWVsLmxlemNhbm9AbGlu
YXJvLm9yZz4NCj4gPiA+IFNlbnQ6IDIwMTnlubQ15pyIMTDml6UgMTU6MTcNCj4gPiA+IFRvOiBB
bmR5IFRhbmcgPGFuZHkudGFuZ0BueHAuY29tPjsgU2hhd24gR3VvDQo+IDxzaGF3bmd1b0BrZXJu
ZWwub3JnPg0KPiA+ID4gQ2M6IExlbyBMaSA8bGVveWFuZy5saUBueHAuY29tPjsgcm9iaCtkdEBr
ZXJuZWwub3JnOw0KPiA+ID4gbWFyay5ydXRsYW5kQGFybS5jb207IGxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gPiA+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiA+ID4gbGludXgtcG1Admdlci5rZXJuZWwu
b3JnOyBydWkuemhhbmdAaW50ZWwuY29tOyBlZHViZXp2YWxAZ21haWwuY29tDQo+ID4gPiBTdWJq
ZWN0OiBSZTogW0VYVF0gUmU6IFtQQVRDSCB2Nl0gYXJtNjQ6IGR0czogbHMxMDg4YTogYWRkIG9u
ZSBtb3JlDQo+ID4gPiB0aGVybWFsIHpvbmUgbm9kZQ0KPiA+ID4NCj4gPiA+IENhdXRpb246IEVY
VCBFbWFpbA0KPiA+ID4NCj4gPiA+IE9uIDEwLzA1LzIwMTkgMDU6NDAsIEFuZHkgVGFuZyB3cm90
ZToNCj4gPiA+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiA+PiBGcm9tOiBT
aGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+DQo+ID4gPiA+PiBTZW50OiAyMDE55bm0Neac
iDEw5pelIDExOjE0DQo+ID4gPiA+PiBUbzogQW5keSBUYW5nIDxhbmR5LnRhbmdAbnhwLmNvbT4N
Cj4gPiA+ID4+IENjOiBMZW8gTGkgPGxlb3lhbmcubGlAbnhwLmNvbT47IHJvYmgrZHRAa2VybmVs
Lm9yZzsNCj4gPiA+ID4+IG1hcmsucnV0bGFuZEBhcm0uY29tOyBsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmc7DQo+ID4gPiA+PiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gPiA+ID4+IGxpbnV4LXBtQHZnZXIua2Vy
bmVsLm9yZzsgZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZzsNCj4gPiA+ID4+IHJ1aS56aGFuZ0Bp
bnRlbC5jb207IGVkdWJlenZhbEBnbWFpbC5jb20NCj4gPiA+ID4+IFN1YmplY3Q6IFtFWFRdIFJl
OiBbUEFUQ0ggdjZdIGFybTY0OiBkdHM6IGxzMTA4OGE6IGFkZCBvbmUgbW9yZQ0KPiA+ID4gPj4g
dGhlcm1hbCB6b25lIG5vZGUNCj4gPiA+ID4+DQo+ID4gPiA+PiBDYXV0aW9uOiBFWFQgRW1haWwN
Cj4gPiA+ID4+DQo+ID4gPiA+PiBPbiBUdWUsIEFwciAyMywgMjAxOSBhdCAxMDoyNTowN0FNICsw
ODAwLCBZdWFudGlhbiBUYW5nIHdyb3RlOg0KPiA+ID4gPj4+IExzMTA4OGEgaGFzIDIgdGhlcm1h
bCBzZW5zb3JzLCBjb3JlIGNsdXN0ZXIgYW5kIFNvQyBwbGF0Zm9ybS4NCj4gPiA+ID4+PiBDb3Jl
IGNsdXN0ZXIgc2Vuc29yIGlzIHVzZWQgdG8gbW9uaXRvciB0aGUgdGVtcGVyYXR1cmUgb2YgY29y
ZQ0KPiA+ID4gPj4+IGFuZCBTb0MgcGxhdGZvcm0gaXMgZm9yIHBsYXRmb3JtLiBUaGUgY3VycmVu
dCBkdHMgb25seSBzdXBwb3J0IHRoZSBmaXJzdA0KPiBzZW5zb3IuDQo+ID4gPiA+Pj4gVGhpcyBw
YXRjaCBhZGRzIHRoZSBzZWNvbmQgc2Vuc29yIG5vZGUgdG8gZHRzIHRvIGVuYWJsZSBpdC4NCj4g
PiA+ID4+Pg0KPiA+ID4gPj4+IFNpZ25lZC1vZmYtYnk6IFl1YW50aWFuIFRhbmcgPGFuZHkudGFu
Z0BueHAuY29tPg0KPiA+ID4gPj4+IC0tLQ0KPiA+ID4gPj4+IHY2Og0KPiA+ID4gPj4+ICAgICAg
ICAgLSBhZGQgY29vbGluZyBkZXZpY2UgbWFwIHRvIGNwdTAtNyBpbiBwbGF0Zm9ybSBub2RlLg0K
PiA+ID4gPiBJIGxpa2UgdG8gZXhwbGFpbiBhIGxpdHRsZS4gSSB0aGluayBpdCBtYWtlcyBzZW5z
ZSB0aGF0IG11bHRpcGxlDQo+ID4gPiA+IHRoZXJtYWwgem9uZQ0KPiA+ID4gbWFwIHRvIHNhbWUg
Y29vbGluZyBkZXZpY2UuDQo+ID4gPiA+IEluIHRoaXMgd2F5LCBubyBtYXR0ZXIgd2hpY2ggdGhl
cm1hbCB6b25lIHJhaXNlcyBhIHRlbXAgYWxhcm0sIGl0DQo+ID4gPiA+IGNhbiBjYWxsDQo+ID4g
PiBjb29saW5nIGRldmljZSB0byBjaGlsbCBvdXQuDQo+ID4gPiA+IEkgYWxzbyBhc2tlZCBjcHVm
cmVxIG1haW50YWluZXIgYWJvdXQgdGhlIGNvb2xpbmcgbWFwIGlzc3VlLCBoZQ0KPiA+ID4gPiB0
aGluayBpdA0KPiA+ID4gd291bGQgYmUgZmluZS4NCj4gDQo+IFllcywgeW91IGFza2VkIG1lIGFu
ZCBJIHNhaWQgaXQgc2hvdWxkIGJlIG9rYXkuDQo+IA0KPiA+ID4gPiBJIGhhdmUgdGVzdGVkIGFu
ZCBubyBpc3N1ZSBmb3VuZC4NCj4gPiA+ID4NCj4gPiA+ID4gRGFuaWVsLCB3aGF0J3MgeW91ciB0
aG91Z2h0Pw0KPiA+ID4NCj4gPiA+IElmIHRoZXJlIGFyZSBtdWx0aXBsZSB0aGVybWFsIHpvbmVz
LCB0aGV5IHdpbGwgYmUgbWFuYWdlZCBieQ0KPiA+ID4gZGlmZmVyZW50IGluc3RhbmNlcyBvZiBh
IHRoZXJtYWwgZ292ZXJub3IuIEVhY2ggaW5zdGFuY2VzIHdpbGwgYWN0DQo+ID4gPiBvbiB0aGUg
c2hhcmVkIGNvb2xpbmcgZGV2aWNlIGFuZCB3aWxsIGNvbGxpZGUgaW4gdGhlaXIgZGVjaXNpb25z
Og0KPiA+ID4NCj4gPiA+ICAtIElmIHRoZSBzZW5zb3JzIGFyZSBjbG9zZWQsIHRoZWlyIGJlaGF2
aW9yIHdpbGwgYmUgc2ltaWxhcg0KPiA+ID4gcmVnYXJkaW5nIHRoZSB0ZW1wZXJhdHVyZS4gVGhl
IGdvdmVybm9ycyBtYXkgdGFrZSB0aGUgc2FtZSBkZWNpc2lvbg0KPiA+ID4gZm9yIHRoZSBjb29s
aW5nIGRldmljZS4gQnV0IGluIHN1Y2ggY2FzZSBoYXZpbmcganVzdCBvbmUgdGhlcm1hbCB6b25l
DQo+IG1hbmFnZWQgaXMgZW5vdWdoLg0KPiA+ID4NCj4gPiA+ICAtIElmIHRoZSBzZW5zb3JzIGFy
ZSBub3QgY2xvc2VkLCB0aGVpciBiZWhhdmlvciB3aWxsIGJlIGRpZmZlcmVudA0KPiA+ID4gcmVn
YXJkaW5nIHRoZSB0ZW1wZXJhdHVyZS4gVGhlIGdvdmVybm9ycyB3aWxsIHRha2UgZGlmZmVyZW50
DQo+ID4gPiBkZWNpc2lvbiByZWdhcmRpbmcgdGhlIGNvb2xpbmcgZGV2aWNlIChvbmUgd2lsbCBk
ZWNyZWFzZSB0aGUgZnJlcSwgb3RoZXINCj4gd2lsbCBpbmNyZWFzZSB0aGUgZnJlcSkuDQo+ID4g
Pg0KPiA+ID4gQXMgdGhlIHRoZXJtYWwgZ292ZXJub3JzIGFyZSBub3QgYWJsZSB0byBtYW5hZ2Ug
c2V2ZXJhbCB0aGVybWFsDQo+ID4gPiB6b25lcyBhbmQgdGhlcmUgaXMgb25lIGNvb2xpbmcgZGV2
aWNlICh0aGUgY3B1IGNvb2xpbmcgZGV2aWNlKSwgdGhpcw0KPiA+ID4gc2V0dXAgd29uJ3Qgd29y
ayBhcyBleHBlY3RlZCBJTU8uDQo+ID4gPg0KPiA+ID4gVGhlIHNldHVwIG1ha2luZyBzZW5zZSBp
cyBoYXZpbmcgYSB0aGVybWFsIHpvbmUgcGVyICdjbHVzdGVyJyBhbmQgYQ0KPiA+ID4gY29vbGlu
ZyBkZXZpY2UgcGVyICdjbHVzdGVyJy4gVGhhdCBtZWFucyB0aGUgcGxhdGZvcm0gaGFzIG9uZSBj
bG9jayBsaW5lDQo+IHBlciAnY2x1c3RlcicuDQo+ID4gPiBUaGUgdGhlcm1hbCBtYW5hZ2VtZW50
IGhhcHBlbnMgaW4gYSBzZWxmLWNvbnRhaW5lZCB0aGVybWFsIHpvbmUgKG9uZQ0KPiA+ID4gY29v
bGluZyBkZXZpY2UgLSBvbmUgZ292ZXJub3IgLSBvbmUgdGhlcm1hbCB6b25lKS4NCj4gPiA+DQo+
ID4gPiBJbiB0aGUgY2FzZSBvZiBITVAsIG90aGVyIGNvbWJpbmF0aW9ucyBhcmUgcG9zc2libGUg
dG8gYmUgb3B0aW1hbC4NCj4gDQo+IEJ1dCBub3Qgc3VyZSBob3cgSSBtaXNzZWQgdGhlIG9idmlv
dXMsIHRob3VnaCBJIGRvIHJlbWVtYmVyIHRoaW5raW5nIGFib3V0DQo+IHRoaXMuDQo+IA0KPiBT
byB0aGUgcHJvYmxlbSBpcyB0aGF0IHRoZSBjcHVfY29vbGluZyBkcml2ZXIgd2lsbCBnZXQgcmVx
dWVzdHMgaW4gcGFyYWxsZWwgdG8NCj4gc2V0IGRpZmZlcmVudCBtYXggZnJlcXVlbmNpZXMgYW5k
IHRoZSBsYXN0IGNhbGwgd2lsbCBhbHdheXMgd2luIGFuZCBtYXkgcmVzdWx0DQo+IGluIHVuZGVz
aXJlZCBvdXRjb21lLg0KPiANCj4gU29ycnkgYWJvdXQgY3JlYXRpbmcgdGhlIGNvbmZ1c2lvbi4N
Cj4gDQo+IC0tDQo+IHZpcmVzaA0K
