Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3B4C118001
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2019 06:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfLJFxc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Dec 2019 00:53:32 -0500
Received: from mail-eopbgr60053.outbound.protection.outlook.com ([40.107.6.53]:50407
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726824AbfLJFxc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Dec 2019 00:53:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izktrcLwG+N/Svs1d0M7jiita0k30bIsDmPAs8gXaO6seZFLZarsQ7zvaud1oG253V8wbQhqTLCsci3MtEoBsDHxZN2URD/eZg4mJzQOZ+1Q5aDPmNG5WgN8RR1C4usMjEYgttLFgRd3DC0PZ8RLHCs7HNY5rSdI0xj99viz2rSFAQ4rSttKrueAC08Uwc42I0s0E77tx+9oz6frej/YnLW0FEIhBdUET3a6Fdas6cZtSX3s1IGcyDuKdztSVRjv3VWzKY/0oJo2hHrIfCzCPpq9lIaOFD4AKuMfDpAk/E6jR1LPzNGwgPdGYE13tf/9JERT97OI/dAQfZ39SwcHDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3IigeEI7yV1WN4+4krEaHswbpAY4KbxFN6XgVzQ2nw=;
 b=W/816yTKpBzkw5b/QbT4kXyMvUUcBrNXKiSAuIjumNVA/JZefY/LyOCM+FIuyBR8qjWS7WT+GnN63N6oSkkKIT5O1TdpMT4DhfAxS7J0VOpy8ziB9THMWs7Pcqhqgy0OoPCrUren1m4nGqtElg7v+sGNCSgqgNrdKS78yO89Ckt91CcDycEaaK4vmD6j98MF475rXSQcefD1iCn+X8WL4XkdBhUb16asnOYDAJyczwnbRQb10k45+H/wwvQcDhzI5LTVou0OKpABI1bPOlXtH7taXlcFH5XeH94KRUZmFzwA6M9Gp4cq+pxLyEV9yz8UNADjbhs2jzVN9QjHDSH4PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3IigeEI7yV1WN4+4krEaHswbpAY4KbxFN6XgVzQ2nw=;
 b=OvNfJLgWGQUEyv1GYE3lcKMk8wTEyFIu8M3kKh4+fOzuLEbl65bXl7BGmC7rN0IUH/ONrD1myDBZP9X8q/5CdTbPTsVHNNU0mjx4NSEyqAVNcXHZP8sdRbuXoGRJpThYc2WFq1X95Zpo9FFtvudo2ol0dB0ohPNFinAgsEYOgJA=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4660.eurprd04.prod.outlook.com (52.135.148.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Tue, 10 Dec 2019 05:53:26 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::505:87e7:6b49:3d29]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::505:87e7:6b49:3d29%7]) with mapi id 15.20.2516.018; Tue, 10 Dec 2019
 05:53:26 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Anson Huang <anson.huang@nxp.com>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: About CPU hot-plug stress test failed in cpufreq driver
Thread-Topic: About CPU hot-plug stress test failed in cpufreq driver
Thread-Index: AdWgM3EuFQeyF1SHRka5sBhDxaFShQAG6J6AAAAKxPAAAq52AAAAFLaAACYwDoAACh8qAAAASXeAAJxYEgAAxubCAAAEUtUgASMyDZAABHGSAAAFLgggAAVyLYAAvd+WYAAA3omQAAEGDYAAAmWbRgAAcGGAACPMEXA=
Date:   Tue, 10 Dec 2019 05:53:26 +0000
Message-ID: <AM0PR04MB4481518A4F89540B3ABA56A1885B0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <DB3PR0402MB391626A8ECFDC182C6EDCF8DF54E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916C8F16045625489E776F4F5460@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB39165E1B832597ADBAB241AAF55C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <4087016.QifdzW7851@kreacher>
 <DB3PR0402MB39163BEC18FF81B06D1093BBF55C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAJZ5v0j_op4vELkEQzJEuXij71p8SGSFSbo0m813W5Gq1ZdYoQ@mail.gmail.com>
 <DB3PR0402MB3916D581AFCA8D05BBED3B68F5580@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916EF749069E53CB1C03475F5580@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAJZ5v0j+L_w7G=Z4K5tuWEp11uk3ggS-1c8RqQ-Px6mk1V98Pw@mail.gmail.com>
 <0EF688DF-FD00-456C-8CE1-C4F825651275@nxp.com>
 <CAJZ5v0iKpJBs71EKL42nL4F0EFaxvbZziwUz73WS45uDYKEpdA@mail.gmail.com>
In-Reply-To: <CAJZ5v0iKpJBs71EKL42nL4F0EFaxvbZziwUz73WS45uDYKEpdA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5492f656-deb0-4784-d2a7-08d77d354671
x-ms-traffictypediagnostic: AM0PR04MB4660:|AM0PR04MB4660:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4660FEC63CAB6E6D44B72B83885B0@AM0PR04MB4660.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02475B2A01
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(189003)(199004)(52536014)(66446008)(6636002)(66556008)(64756008)(76116006)(305945005)(8936002)(44832011)(71200400001)(478600001)(81156014)(71190400001)(81166006)(8676002)(66476007)(966005)(5660300002)(33656002)(2906002)(55016002)(26005)(316002)(110136005)(7696005)(53546011)(229853002)(6506007)(4326008)(186003)(66946007)(54906003)(9686003)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4660;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sfE4433E9GWM7YNWsjc3z6O378a9ckhmH/iRLTs1yQm+vDixHwOnYc5Lq9OgTNnq6bAf1keJTnjj0wmlc+sKleGM+m2+jLG2CMiEbVbD055ZnS20E0KQ1Euh3Zr3sRI3+8WZVTRDH13K2OKmBspsVvaqBZERfczHGi6EfjkQt8O50GCtX7wdrzzxNnRnPLb0EalCItexRliWO4RQu+dDWVXL/o6UzMubvY5M9g+DAqLxt+yvx47olDWjSF8ki0v7cS+UR+uxNiPuMeUx7LJ9YsQy6OkcFr6gxrfVTGXNZDlycxuK7OfFzKZ/P4G8MWpJsg1xidwGGYkjwaEc4QV3ea7tg+fCJF7Nj/CSMdaXktpvfgS/3jKkD1d3lh4bjWORIjxdZ2o6DV4jGRaXVFYvv699Q3R0FdDPCxTAz0Oxh62Q4LqhmEaE8dIsb/O0+Qpy06n39aCTJ/xGTw2f1RPH5hSF/YoB9CJVtSiaKA8zZl0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5492f656-deb0-4784-d2a7-08d77d354671
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2019 05:53:26.4018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kQv/eZMn/XHv5W8i5x6F/2SsXCl9ufe2ttGUHOy/zqKjR9RY1atsj9RMiHCKEp8MTc/G6CdtNmIVKbIakAU7vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4660
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

PiBTdWJqZWN0OiBSZTogQWJvdXQgQ1BVIGhvdC1wbHVnIHN0cmVzcyB0ZXN0IGZhaWxlZCBpbiBj
cHVmcmVxIGRyaXZlcg0KPiANCj4gT24gTW9uLCBEZWMgOSwgMjAxOSBhdCAxOjMyIFBNIEFuc29u
IEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+DQo+ID4NCj4g
PiBGcm9tIEFuc29uJ3MgaVBob25lIDYNCj4gPg0KPiA+DQo+ID4gPiDlnKggMjAxOeW5tDEy5pyI
OeaXpe+8jDE5OjIz77yMUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbEBrZXJuZWwub3JnPiDlhpkN
Cj4g6YGT77yaDQo+ID4gPg0KPiA+ID4+IE9uIE1vbiwgRGVjIDksIDIwMTkgYXQgMTE6NTcgQU0g
QW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+DQo+IHdyb3RlOg0KPiA+ID4+DQo+ID4g
Pj4gRm9yZ290IHRvIG1lbnRpb25lZCB0aGF0IGJlbG93IHBhdGNoIG9uIHY1LjQgY2FuIGVhc2ls
eSByZXByb2R1Y2UgdGhlDQo+IHBhbmljKCkgb24gb3VyIHBsYXRmb3JtcyB3aGljaCBJIHRoaW5r
IGlzIHVuZXhwZWN0ZWQsIGFzIHRoZSBwb2xpY3ktPmNwdXMNCj4gYWxyZWFkeSBiZSB1cGRhdGVk
IGFmdGVyIGdvdmVybm9yIHN0b3AsIGJ1dCBzdGlsbCB0cnkgdG8gaGF2ZSBpcnEgd29yayBxdWV1
ZWQNCj4gb24gaXQuDQo+ID4gPj4NCj4gPiA+PiBzdGF0aWMgdm9pZCBkYnNfdXBkYXRlX3V0aWxf
aGFuZGxlcihzdHJ1Y3QgdXBkYXRlX3V0aWxfZGF0YSAqZGF0YSwNCj4gPiA+PiB1NjQgdGltZSwg
dW5zaWduZWQgaW50IGZsYWdzKQ0KPiA+ID4+ICsgICAgICAgaWYgKCFjcHVtYXNrX3Rlc3RfY3B1
KHNtcF9wcm9jZXNzb3JfaWQoKSwNCj4gcG9saWN5X2Ricy0+cG9saWN5LT5jcHVzKSkNCj4gPiA+
PiArICAgICAgICAgICAgICAgcGFuaWMoIi4uLmlycSB3b3JrIG9uIG9mZmxpbmUgY3B1ICVkXG4i
LA0KPiA+ID4+ICsgc21wX3Byb2Nlc3Nvcl9pZCgpKTsNCj4gPiA+PiAgICAgICAgaXJxX3dvcmtf
cXVldWUoJnBvbGljeV9kYnMtPmlycV93b3JrKTsNCj4gPiA+DQo+ID4gPiBZZXMsIHRoYXQgaXMg
dW5leHBlY3RlZC4NCj4gPiA+DQo+ID4gPiBJbiBjcHVmcmVxX29mZmxpbmUoKSwgd2UgaGF2ZToN
Cj4gPiA+DQo+ID4gPiAgICBkb3duX3dyaXRlKCZwb2xpY3ktPnJ3c2VtKTsNCj4gPiA+ICAgIGlm
IChoYXNfdGFyZ2V0KCkpDQo+ID4gPiAgICAgICAgY3B1ZnJlcV9zdG9wX2dvdmVybm9yKHBvbGlj
eSk7DQo+ID4gPg0KPiA+ID4gICAgY3B1bWFza19jbGVhcl9jcHUoY3B1LCBwb2xpY3ktPmNwdXMp
Ow0KPiA+ID4NCj4gPiA+IGFuZCBjcHVmcmVxX3N0b3BfZ292ZXJub3IoKSBjYWxscyBwb2xpY3kt
PmdvdmVybm9yLT5zdG9wKHBvbGljeSkNCj4gPiA+IHdoaWNoIGlzIGNwdWZyZXFfZGJzX2dvdmVy
bm9yX3N0b3AoKS4NCj4gPiA+DQo+ID4gPiBUaGF0IGNhbGxzIGdvdl9jbGVhcl91cGRhdGVfdXRp
bChwb2xpY3lfZGJzLT5wb2xpY3kpIGZpcnN0LCB3aGljaA0KPiA+ID4gaW52b2tlcyBjcHVmcmVx
X3JlbW92ZV91cGRhdGVfdXRpbF9ob29rKCkgZm9yIGVhY2ggQ1BVIGluDQo+ID4gPiBwb2xpY3kt
PmNwdXMgYW5kIHN5bmNocm9uaXplcyBSQ1UsIHNvIGFmdGVyIHRoYXQgcG9pbnQgbm9uZSBvZiB0
aGUNCj4gPiA+IHBvbGljeS0+Y3B1cyBpcyBleHBlY3RlZCB0byBydW4gZGJzX3VwZGF0ZV91dGls
X2hhbmRsZXIoKS4NCj4gPiA+DQo+ID4gPiBwb2xpY3ktPmNwdXMgaXMgdXBkYXRlZCBuZXh0IGFu
ZCB0aGUgZ292ZXJub3IgaXMgc3RhcnRlZCBhZ2FpbiB3aXRoDQo+ID4gPiB0aGUgbmV3IHBvbGlj
eS0+Y3B1cy4gIEJlY2F1c2UgdGhlIG9mZmxpbmUgQ1BVIGlzIG5vdCB0aGVyZSwgaXQgaXMNCj4g
PiA+IG5vdCBleHBlY3RlZCB0byBydW4gZGJzX3VwZGF0ZV91dGlsX2hhbmRsZXIoKSBhZ2Fpbi4N
Cj4gPiA+DQo+ID4gPiBEbyB5b3Ugb25seSBnZXQgdGhlIG9yaWdpbmFsIGVycm9yIHdoZW4gb25l
IG9mIHRoZSBDUFVzIGdvZXMgYmFjayBvbmxpbmU/DQo+ID4NCj4gPiBObywgc29tZXRpbWVzIEkg
YWxzbyBnb3QgdGhpcyBlcnJvciBkdXJpbmcgYSBDUFUgaXMgYmVpbmcgb2ZmbGluZS4NCj4gPg0K
PiA+IEJ1dCB0aGUgcG9pbnQgaXMgTk9UIHRoYXQgZGJzX3VwZGF0ZV91dGlsX2hhbmRsZXIoKSBj
YWxsZWQgZHVyaW5nDQo+ID4gZ292ZXJub3Igc3RvcCwgaXQgaXMgdGhhdCB0aGlzIGZ1bmN0aW9u
IGlzIHJ1bm5pbmcgb24gYSBDUFUgd2hpY2gNCj4gPiBhbHJlYWR5IGZpbmlzaCB0aGUgZ292ZXJu
b3Igc3RvcCBmdW5jdGlvbiwNCj4gDQo+IFllcywgaXQgaXMsIGFuZCB3aGljaCBzaG91bGQgbm90
IGJlIHBvc3NpYmxlIGFzIHBlciB0aGUgYWJvdmUuDQo+IA0KPiBUaGUgb2ZmbGluZSBDUFUgaXMg
bm90IHRoZXJlIGluIHByb2xpY3ktPmNwdXMgd2hlbg0KPiBjcHVmcmVxX2Ric19nb3Zlcm5vcl9z
dGFydCgpIGlzIGNhbGxlZCBmb3IgdGhlIHBvbGljeSwgc28gaXRzDQo+IGNwdWZyZXFfdXBkYXRl
X3V0aWxfZGF0YSBwb2ludGVyIGlzIG5vdCBzZXQgKGl0IGlzIE5VTEwgYXQgdGhhdCB0aW1lKS4N
Cj4gVGhlcmVmb3JlIGl0IGlzIG5vdCBleHBlY3RlZCB0byBydW4gZGJzX3VwZGF0ZV91dGlsX2hh
bmRsZXIoKSB1bnRpbCBpdCBpcyB0dXJuDQo+IGJhY2sgb25saW5lLg0KPiANCj4gPiBJIHRob3Vn
aHQgdGhlIG9yaWdpbmFsIGV4cGVjdGF0aW9uIGlzIHRoYXQgdGhpcyBmdW5jdGlvbiBPTkxZIGJl
IGV4ZWN1dGVkIG9uDQo+IHRoZSBDUFUgd2hpY2ggbmVlZHMgc2NhbGluZyBmcmVxdWVuY3k/DQo+
ID4gSXMgdGhpcyBjb3JyZWN0Pw0KPiANCj4gWWVzLCBpdCBpcy4NCj4gDQo+ID4gdjQuMTkgZm9s
bG93cyB0aGlzIGV4cGVjdGF0aW9uIHdoaWxlIHY1LjQgaXMgTk9ULg0KPiANCj4gQXMgcGVyIHRo
ZSBrZXJuZWwgY29kZSwgdGhleSBib3RoIGRvLg0KDQpCdXQgcGVyIGh0dHBzOi8vZWxpeGlyLmJv
b3RsaW4uY29tL2xpbnV4L3Y1LjUtcmMxL3NvdXJjZS9rZXJuZWwvc2NoZWQvc2NoZWQuaCNMMjI5
Mw0KY3B1X29mKHJxKSBhbmQgc21wX3Byb2Nlc3Nvcl9pZCgpIGlzIHBvc3NpYmxlIHRvIG5vdCB0
aGUgc2FtZSwNCg0KV2hlbiBjcHVfb2YocnEpIGlzIG5vdCBlcXVhbCB0byBzbXBfcHJvY2Vzc29y
X2lkKCksIGRic191cGRhdGVfdXRpbF9oYW5kbGVyDQp3aWxsIHVzZSBpcnFfd29ya19xdWV1ZSB0
byBzbXBfcHJvY2Vzc29yX2lkKCksIG5vdCBjcHVfb2YocnEpLiBJcyB0aGlzDQpleHBlY3RlZD8N
Ck9yIHNob3VsZCB0aGUgaXJxX3dvcmsgYmUgcXVldWVkIHRvIGNwdV9vZihycSk/DQoNClRoYW5r
cywNClBlbmcuDQoNCj4gDQo+ID4gVGhlIG9ubHkgdGhpbmcgSSBjYW4gaW1hZ2UgaXMgdGhlIGNo
YW5nZXMgaW4ga2VybmVsL3NjaGVkLyBmb2xkZXIgY2F1c2UgdGhpcw0KPiBkaWZmZXJlbmNlLCBi
dXQgSSBzdGlsbCBuZWVkIG1vcmUgdGltZSB0byBmaWd1cmUgb3V0IHdoYXQgY2hhbmdlcyBjYXVz
ZSBpdCwgaWYNCj4geW91IGhhdmUgYW55IHN1Z2dlc3Rpb24sIHBsZWFzZSBhZHZpc2UsIHRoYW5r
cyENCj4gDQo+IFRoZSBDUFUgb2ZmbGluZS9vbmxpbmUgKGhvdHBsdWcpIHJld29yayB3YXMgZG9u
ZSBhZnRlciA0LjE5IElJUkMgYW5kIHRoYXQNCj4gY2hhbmdlZCB0aGUgd2F5IG9ubGluZSB3b3Jr
cy4gIE5vdywgaXQgcnVucyBvbiB0aGUgQ1BVIGdvaW5nIG9ubGluZSBhbmQNCj4gcHJldmlvdXNs
eSBpdCByYW4gb24gdGhlIENQVSAiYXNraW5nIiB0aGUgb3RoZXIgb25lIHRvIGdvIG9ubGluZS4g
IFRoYXQgbWF5DQo+IGJlIHdoYXQgbWFrZXMgdGhlIGRpZmZlcmVuY2UgKGlmIG15IHJlY29sbGVj
dGlvbiBvZiB0aGUgdGltZSBmcmFtZSBpcyBjb3JyZWN0KS4NCg==
