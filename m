Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63F3B9FE13
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2019 11:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfH1JMj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Aug 2019 05:12:39 -0400
Received: from mail-eopbgr30053.outbound.protection.outlook.com ([40.107.3.53]:26176
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726983AbfH1JMi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 28 Aug 2019 05:12:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZXEQiDCPM5eRjIN4jPdalfIrHuIBlQ9LFxjR6QX8Z5PPrZYSFsFHJOEIcOaJ+Ttg+Dqdi5v6lDx5ZfOFtzXJ1yMD65kAU52x2Ief2JjyWPU/RhH32j32B4E6mBh+2mLgzPx4Sb18pYD2kCplDU5X6pSPO5AwBZJTFuJ5+QGSWzO8x5Zfyc17vCl3ssYLcZyLGb7xT/fLvc42r5i2vrpUkLcYtXlZA2B5qFCVWlQx3lovZ3wouieqLhoWeZYtIw25/cK3oSKxN9PE803g+w3WBz1l4dw0ex8aKqvvMCIgMbWYczyaP6ur3aBbxz+106OYSihspgRphdHol4WH1q8dFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8nfwSFdl5bo7Lgolsj/3mJaPQbspqMCWU1wo3aT+YY=;
 b=cfNyGOavtIVq2Aes4e2vgJCxXcWuG0kuOjmGzo97WKb1RJRprY4XJ84owlm2vO6EeM6OeaNFlWz52AA5IsXczm1FCHHdaE+A74powAEowK3ogPM7vrtMx+ZUuydxkwVV1GeX4+91AYKrZ7hOS32pbKTgn/SHUv9rKIJ9XD5tItV12snsMDixZc0DD1+lLFVX1dDLeFCxSWmwgzbWV57LQpkfEVZeE2F3aGbrtyZs7xH5vCdnZT0iZ6Gu3muTONULD/y3aMtxOGNHF2UD3ITC/B7SwOwJoEO9bJge0KMPAjyy7XTvj9XfxbUjE4Nuq2LkUQx8SqYSfhoB2wQyPvTPqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8nfwSFdl5bo7Lgolsj/3mJaPQbspqMCWU1wo3aT+YY=;
 b=DhWZXgsSUVVNV+WI3sEsxBQdBzeYJq8Le8J7q/N1+utanCL8JMrM5q68CKJo42c+StW9it03pwa2NUNwXNp3kG310D6dRMgU+OHX20xkAU9pr8+22yHwgyLN6hDX38rjrZXLDg3GtSY+NIqb65N2sqN9XrM0DPRT5Oj4Rop7Vy4=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3817.eurprd04.prod.outlook.com (52.134.73.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Wed, 28 Aug 2019 09:12:33 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::8958:299c:bc54:2a38]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::8958:299c:bc54:2a38%7]) with mapi id 15.20.2199.021; Wed, 28 Aug 2019
 09:12:33 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
CC:     Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: RE: [PATCH V3 1/5] thermal: qoriq: Add clock operations
Thread-Topic: [PATCH V3 1/5] thermal: qoriq: Add clock operations
Thread-Index: AQHVRn7U0xGc5nAWcEuPNmwDSS0IiacQaSEAgAAA+YCAAAF2wIAABb+AgAACp/A=
Date:   Wed, 28 Aug 2019 09:12:33 +0000
Message-ID: <DB3PR0402MB3916C79F8FB5002ED76BB82FF5A30@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190730022126.17883-1-Anson.Huang@nxp.com>
         <VI1PR04MB7023F219CA7B4187F86EAA42EEA10@VI1PR04MB7023.eurprd04.prod.outlook.com>
         <AM6PR0402MB3911D45B3B148588A582F6C4F5A00@AM6PR0402MB3911.eurprd04.prod.outlook.com>
         <VI1PR04MB7023773DD477FF89E2D2181CEEA00@VI1PR04MB7023.eurprd04.prod.outlook.com>
         <d9b428825654181fbdbfb4d613a6a3fd52330787.camel@intel.com>
         <afb235bf7390fb6fbd723c34b08feddd771d1f6c.camel@intel.com>
         <DB3PR0402MB3916045AFDDF4EFA9AD50842F5A30@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <48e367965797001409b66f1f65d7bc4df2e927a5.camel@intel.com>
In-Reply-To: <48e367965797001409b66f1f65d7bc4df2e927a5.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 817d7f4f-76e0-4e84-a87b-08d72b97dc36
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3817;
x-ms-traffictypediagnostic: DB3PR0402MB3817:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3817326839B57B5C72639B0CF5A30@DB3PR0402MB3817.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(189003)(199004)(14444005)(7696005)(966005)(256004)(99286004)(53546011)(66946007)(66066001)(66446008)(71200400001)(66476007)(9686003)(64756008)(6246003)(71190400001)(7736002)(478600001)(6306002)(55016002)(66556008)(102836004)(25786009)(186003)(4326008)(26005)(305945005)(6436002)(81166006)(5660300002)(3846002)(81156014)(44832011)(110136005)(316002)(8676002)(76176011)(8936002)(53936002)(2906002)(74316002)(33656002)(6506007)(7416002)(14454004)(76116006)(11346002)(52536014)(6116002)(446003)(86362001)(229853002)(476003)(486006)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3817;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Dfj5go3ebxcU/A4V3VeIU6X/s0hG7UCM92v385Vmv2Lb/6l2r/X5530K4d5824N1ShhADCZZ6tP5AXo786BSTufOqjudoUBBB3N7yIfMWR5yl5S4KF2NxpzlFq1BRbcA0uYfMhzcrdXo/0bGDYtB5umX5Z/gUoUwC5fBBZZYQytp7K/88AqTflLyi6rE1ng81wwyPkRANwy7yfdsS5DWeRBLHzrU0QJI2CDtZu8GVPxc94Z4P2B4UkuYqPQRLi/FG5Su+oWUnHVwEOrjv3EPXi0fC8XofngFE17w78KDUhELSnBHPt6eImAhCwYPFFn8fjDL9QHBUX3tybpXywLaNIFCsiL3U+/8WAJmtm+jTcfOfmI3OvYDYpifo9GEwUIlltMvDzTiAs/N6nD7REZEVF0GJqPmZW2s/eqzsTnoiH0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 817d7f4f-76e0-4e84-a87b-08d72b97dc36
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 09:12:33.0570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ecvQq1MFtZnLOyIGCy1L8hJ8urqhUKEQWJ3FoWvBh66ULy6icNzHvM/KGzQHEc02171ShtVTDMeI2h0vZkVoHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3817
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIFJ1aQ0KDQo+IE9uIFdlZCwgMjAxOS0wOC0yOCBhdCAwODo0OSArMDAwMCwgQW5zb24gSHVh
bmcgd3JvdGU6DQo+ID4gSGksIFJ1aQ0KPiA+DQo+ID4gPiBPbiBXZWQsIDIwMTktMDgtMjggYXQg
MTY6MzIgKzA4MDAsIFpoYW5nIFJ1aSB3cm90ZToNCj4gPiA+ID4gT24gVHVlLCAyMDE5LTA4LTI3
IGF0IDEyOjQxICswMDAwLCBMZW9uYXJkIENyZXN0ZXogd3JvdGU6DQo+ID4gPiA+ID4gT24gMjcu
MDguMjAxOSAwNDo1MSwgQW5zb24gSHVhbmcgd3JvdGU6DQo+ID4gPiA+ID4gPiA+IEluIGFuIGVh
cmxpZXIgc2VyaWVzIHRoZSBDTEtfSVNfQ1JJVElDQUwgZmxhZ3Mgd2FzIHJlbW92ZWQNCj4gPiA+
ID4gPiA+ID4gZnJvbSB0aGUgVE1VIGNsb2NrIHNvIGlmIHRoZSB0aGVybWFsIGRyaXZlciBkb2Vz
bid0DQo+ID4gPiA+ID4gPiA+IGV4cGxpY2l0bHkgZW5hYmxlIGl0IHRoZSBzeXN0ZW0gd2lsbCBo
YW5nIG9uIHByb2JlLiBUaGlzIGlzDQo+ID4gPiA+ID4gPiA+IHdoYXQgaGFwcGVucyBpbiBsaW51
eC1uZXh0IHJpZ2h0IG5vdyENCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBUaGUgdGhlcm1hbCBk
cml2ZXIgc2hvdWxkIGJlIGJ1aWx0IHdpdGggbW9kdWxlLCBzbyBkZWZhdWx0DQo+ID4gPiA+ID4g
PiBrZXJuZWwgc2hvdWxkIGNhbiBib290IHVwLCBkbyB5b3UgbW9kaWZ5IHRoZSB0aGVybWFsIGRy
aXZlciBhcw0KPiA+ID4gPiA+ID4gYnVpbHQtaW4/DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4g
PiBVbmxlc3MgdGhpcyBwYXRjaGVzIGlzIG1lcmdlZCBzb29uIHdlJ2xsIGVuZCB1cCB3aXRoIGEg
NS40LQ0KPiA+ID4gPiA+ID4gPiByYzENCj4gPiA+ID4gPiA+ID4gdGhhdCBkb2Vzbid0IGJvb3Qg
b24gaW14OG1xLiBBbiBlYXN5IGZpeCB3b3VsZCBiZSB0bw0KPiA+ID4gPiA+ID4gPiBkcm9wL3Jl
dmVydCBjb21taXQNCj4gPiA+ID4gPiA+ID4gOTUxYzFhZWY5NjkxICgiY2xrOiBpbXg4bXE6IFJl
bW92ZSBDTEtfSVNfQ1JJVElDQUwgZmxhZyBmb3INCj4gPiA+ID4gPiA+ID4gSU1YOE1RX0NMS19U
TVVfUk9PVCIpIHVudGlsIHRoZSB0aGVybWFsIHBhdGNoZXMgYXJlDQo+ID4gPiA+ID4gPiA+IGFj
Y2VwdGVkLg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IElmIHRoZSB0aGVybWFsIGRyaXZlciBp
cyBidWlsdCBhcyBtb2R1bGUsIEkgdGhpbmsgbm8gbmVlZCB0bw0KPiA+ID4gPiA+ID4gcmV2ZXJ0
IHRoZSBjb21taXQsIGJ1dCBpZiBieSBkZWZhdWx0IHRoZXJtYWwgZHJpdmVyIGlzIGJ1aWx0LQ0K
PiA+ID4gPiA+ID4gaW4gb3IgbW9kIHByb2JlZCwgdGhlbiB5ZXMsIGl0IHNob3VsZCBOT1QgYnJl
YWsga2VybmVsIGJvb3QNCj4gPiA+ID4gPiA+IHVwLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gVGhl
IHFvcmlxX3RoZXJtYWwgZHJpdmVyIGlzIGJ1aWx0IGFzIGEgbW9kdWxlIGluIGRlZmNvbmZpZyBh
bmQNCj4gPiA+ID4gPiB3aGVuIG1vZHVsZXMgYXJlIHByb3Blcmx5IGluc3RhbGxlZCBpbiByb290
ZnMgdGhleSB3aWxsIGJlDQo+ID4gPiA+ID4gYXV0b21hdGljYWxseSBiZSBwcm9iZWQgb24gYm9v
dCBhbmQgY2F1c2UgYSBoYW5nLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gSSB1c3VhbGx5IHJ1biBu
ZnNyb290IHdpdGggbW9kdWxlczoNCj4gPiA+ID4gPg0KPiA+ID4gPiA+ICAgICAgbWFrZSBtb2R1
bGVzX2luc3RhbGwgSU5TVEFMTF9NT0RfUEFUSD0vc3J2L25mcy9pbXg4LXJvb3QNCj4gPiA+ID4N
Cj4gPiA+ID4gc28gd2UgbmVlZCB0aGlzIHBhdGNoIHNoaXBwZWQgaW4gdGhlIGJlZ2lubmluZyBv
ZiB0aGUgbWVyZ2UNCj4gPiA+ID4gd2luZG93LCByaWdodD8NCj4gPiA+ID4gaWYgdGhlcmUgaXMg
aGFyZCBkZXBlbmRlbmN5IGJldHdlZW4gcGF0Y2hlcywgaXQncyBiZXR0ZXIgdG8gc2VuZA0KPiA+
ID4gPiB0aGVtIGluIG9uZSBzZXJpZXMsIGFuZCBnZXQgc2hpcHBlZCB2aWEgZWl0aGVyIHRyZWUu
DQo+ID4gPiA+DQo+ID4gPiA+IEJUVywgd2hvIGlzIG1haW50YWluaW5nIHFvcmlxIGRyaXZlciBm
cm9tIE5YUD8gSWYgQW5zb24gaXMNCj4gPiA+ID4gbWFpbnRhaW5pbmcgYW5kIGRldmVsb3Bpbmcg
dGhpcyBkcml2ZXIsIGl0J3MgYmV0dGVyIHRvIHVwZGF0ZSB0aGlzDQo+ID4gPiA+IGluIHRoZSBk
cml2ZXIgb3IgdGhlIE1BSU5UQUlORVIgZmlsZSwgSSB3aWxsIHRha2UgdGhlIGRyaXZlcg0KPiA+
ID4gPiBzcGVjaWZpYyBwYXRjaGVzIGFzIGxvbmcgYXMgd2UgaGF2ZSBBQ0svUmV2aWV3ZWQtQnkg
ZnJvbSB0aGUNCj4gPiA+ID4gZHJpdmVyIG1haW50YWluZXIuDQo+ID4NCj4gPiBJIGFtIE5PVCBz
dXJlIHdobyBpcyB0aGUgcW9yaXEgZHJpdmVyIGZyb20gTlhQLCBzb21lIG9mIG91ciBpLk1YIFNv
Q3MNCj4gPiB1c2UgcW9yaXEgdGhlcm1hbCBJUCwgc28gSSBoYXZlIHRvIGFkZCBzdXBwb3J0IGZv
ciB0aGVtLiAgVGhlIGZpcnN0DQo+ID4gbWFpbnRhaW5lciBmb3IgdGhpcyBkcml2ZXIgaXMgaG9u
Z3Rhby5qaWFAbnhwLmNvbSwgYnV0IEkgY2FuIE5PVCBmaW5kDQo+ID4gaXQgZnJvbSBOWFAncyBt
YWlsIHN5c3RlbSwgTk9UIHN1cmUgaWYgaGUgaXMgc3RpbGwgaW4gTlhQLiBUaGUNCj4gPiBNQUlO
VEFJTkVSIGZpbGUgZG9lcyBOT1QgaGF2ZSBpbmZvIGZvciB0aGlzIERyaXZlcidzIG1haW50YWlu
ZXIsIHNvDQo+ID4gaG93IHRvIHVwZGF0ZSBpdD8gSnVzdCBjaGFuZ2UgdGhlIG5hbWUgaW4gZHJp
dmVyPyBPciBsZWF2ZSBpdCBhcyB3aGF0DQo+ID4gaXQgaXM/DQo+ID4NCj4gPiAgTU9EVUxFX0FV
VEhPUigiSmlhIEhvbmd0YW8gPGhvbmd0YW8uamlhQG54cC5jb20+Iik7DQo+ID4gTU9EVUxFX0RF
U0NSSVBUSU9OKCJRb3JJUSBUaGVybWFsIE1vbml0b3JpbmcgVW5pdCBkcml2ZXIiKTsNCj4gPiBN
T0RVTEVfTElDRU5TRSgiR1BMIHYyIik7DQo+ID4NCj4gSSBzZWUgc2V2ZXJhbCBwZW9wbGUgYXJl
IGFjdGl2ZWx5IHdvcmtpbmcgb24gdGhpcyBkcml2ZXIgZnJvbSBOWFAuDQo+IElmIHlvdSdyZSBv
a2F5LCBJJ2QgbGlrZSB0byBnZXQgeW91ciBjb21tZW50cyBvbiBhbGwgdGhlIHBhdGNoZXMgZm9y
IHRoaXMgZHJpdmVyDQo+IGJlZm9yZSBJIHRha2UgdGhlbSwgYW5kIEkgY2FuIHVwZGF0ZSB0aGUg
TUFJTlRBSU5FUiBmaWxlIGxhdGVyIHNvIHRoYXQgeW91J3JlDQo+IENDZWQgZm9yIGFsbCB0aGUg
cW9yaXEgdGhlcm1hbCBkcml2ZXIgY2hhbmdlcy4NCg0KSSBhbSBPSywgYnV0IGl0IG1heSB0YWtl
IG1lIHNvbWUgZGF5cyB0byBkbyBpdCwgSSB3aWxsIG1ha2UgaXQgQVNBUCwgdGhhbmtzLg0KDQpB
bnNvbg0KDQo+IA0KPiA+ID4NCj4gPiA+IEFuZCBhbHNvLCBjYW4geW91IHByb3ZpZGUgeW91ciBm
ZWVkYmFjayBmb3IgdGhpcyBvbmU/DQo+ID4gPg0KPiBodHRwczovL3BhdGNoDQo+ID4gPg0KPiB3
b3JrLmtlcm5lbC5vcmclMkZwYXRjaCUyRjEwOTc0MTQ3JTJGJmFtcDtkYXRhPTAyJTdDMDElN0Nh
bnNvbi5oDQo+ID4gPg0KPiB1YW5nJTQwbnhwLmNvbSU3Qzg4N2U3YzkwZjdjOTQzZmYwZDliMDhk
NzJiOTJhZWExJTdDNjg2ZWExZDNiYzINCj4gPiA+DQo+IGI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3
QzAlN0MwJTdDNjM3MDI1NzgxMzI1MjAzMzg0JmFtcDtzZGF0YT1YZw0KPiA+ID4NCj4gdFg2bVBk
QTUwTmJiJTJGbW5TMm9tMmJKTmVwVGQxdGg2SG1md0d1VTlIdyUzRCZhbXA7cmVzZXJ2ZQ0KPiA+
ID4gZD0wDQo+ID4NCj4gPiBJIGNhbiB0YWtlIGEgbG9vayBhdCBpdCBsYXRlci4NCj4gPg0KPiB0
aGFua3MhDQo+IA0KPiAtcnVpDQo+ID4gVGhhbmtzLA0KPiA+IEFuc29uDQoNCg==
