Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7304611823A
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2019 09:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfLJI3i (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Dec 2019 03:29:38 -0500
Received: from mail-eopbgr70078.outbound.protection.outlook.com ([40.107.7.78]:62443
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726248AbfLJI3i (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Dec 2019 03:29:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dY60zwUWc6lybARMhTKzLn/Yl4xIheOZ25o/fAAcFJB/sVlA7cvrbWOcG95/o2HdykvkJacvmE1UlJRZrxgVE21WRl+XnC6aWUHlobKGT0Bh7VUIMHKHsLDWTX+Wg08bdUjBAayggy0O1tS0UmsJqO47ebnGkGywP1gXg9bkMhAetRn91yi9H1iI7/c2CQA+WiW0vst+md3KB0MpdcdO+LtvXvXFvdxyLgkJOEtHQmzFy/UNT29+dWFNa16ovbJBpy2TNJXyFfVW4c5MVQ0yreOGUqTrMyU0vVchdrsX1nlgxlD252qkPQleOFHh69WrhNihQ6J7YmAsoZBK7qCtbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAA94AnyTeCzwLr86OpsnTZBlP0gFhoW+AGJb0Ks3Do=;
 b=aZdMZR+5I7gLEutGK5mv6TKFDBjBvZSLwoWdra9YrbKmnoUw6MuWflLrkeV+aZBnActEEEnh1MS0ObV4zNp0RiBx3wXtidiRxmGRy2BTafXeMIKZaIl99rcr9uV+w99mASrYMpLmjwCaIW6suvqy+oQLsPD5q/JaEpiYRPQzgxTUyaUaljjjp2HL0oAS+ZZgjkIzPyRjYk5z9J8Ac4Bn7xGMIMY82KMR8vE0mQtcYoIpM97Dw6R3tXAbulfzUAMuBePx4mMRiOsYc1RrGbwEyV5vuPpwnPwP1oLnlQ8TPUbfwbkGcOVyPOwBEFOIgys5pWI8HlM4p0Wdosj9qznJcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAA94AnyTeCzwLr86OpsnTZBlP0gFhoW+AGJb0Ks3Do=;
 b=V/W6UHXcg78X1+prKZW3smjji35u3VprotjZbfCkgCW0QBR40aEEWZERegHO8N/OCYWUpG0UjKFaJHkB7BTBqMUB6GCnyBjoSiGXifDn9ucRFDAe80HKP8Go0qVo0vWfRc+woGWDeEnb+W81+YRYoaKkm7XFCU7QC6K9NbK9tQs=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3674.eurprd04.prod.outlook.com (52.134.66.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Tue, 10 Dec 2019 08:29:20 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::b5ce:fe6b:6c06:fdb1]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::b5ce:fe6b:6c06:fdb1%6]) with mapi id 15.20.2516.018; Tue, 10 Dec 2019
 08:29:20 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     Peng Fan <peng.fan@nxp.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Subject: RE: About CPU hot-plug stress test failed in cpufreq driver
Thread-Topic: About CPU hot-plug stress test failed in cpufreq driver
Thread-Index: AdWgM3EuFQeyF1SHRka5sBhDxaFShQAG6J6AAAAKxPAAAq52AAAAFLaAACYwDoAACh8qAAAASXeAAJxYEgAAxubCAAAEUtUgASMyDZAABHGSAAAFLgggAAVyLYAAvd+WYAAA3omQAAEGDYAAAmWbRgAAcGGAACPMEXAAAqbAgAACrQEAAAAfUXA=
Date:   Tue, 10 Dec 2019 08:29:20 +0000
Message-ID: <DB3PR0402MB39164E6ACFEAE98961EB70E4F55B0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <DB3PR0402MB39165E1B832597ADBAB241AAF55C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <4087016.QifdzW7851@kreacher>
 <DB3PR0402MB39163BEC18FF81B06D1093BBF55C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAJZ5v0j_op4vELkEQzJEuXij71p8SGSFSbo0m813W5Gq1ZdYoQ@mail.gmail.com>
 <DB3PR0402MB3916D581AFCA8D05BBED3B68F5580@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916EF749069E53CB1C03475F5580@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAJZ5v0j+L_w7G=Z4K5tuWEp11uk3ggS-1c8RqQ-Px6mk1V98Pw@mail.gmail.com>
 <0EF688DF-FD00-456C-8CE1-C4F825651275@nxp.com>
 <CAJZ5v0iKpJBs71EKL42nL4F0EFaxvbZziwUz73WS45uDYKEpdA@mail.gmail.com>
 <AM0PR04MB4481518A4F89540B3ABA56A1885B0@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <20191210070535.bvfzigolydhyz2ix@vireshk-i7>
 <CAJZ5v0hQeZDOiQC=UT+nEOc27E7Rn0O_7tLbeO1YMinCntDFCQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0hQeZDOiQC=UT+nEOc27E7Rn0O_7tLbeO1YMinCntDFCQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cda86f4a-37b9-45f9-82b0-08d77d4b0de0
x-ms-traffictypediagnostic: DB3PR0402MB3674:|DB3PR0402MB3674:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB367486EFA591DE6961FE155FF55B0@DB3PR0402MB3674.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02475B2A01
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(52314003)(13464003)(189003)(199004)(6506007)(81156014)(64756008)(7696005)(54906003)(76116006)(316002)(110136005)(66556008)(305945005)(66946007)(55016002)(478600001)(52536014)(45080400002)(966005)(44832011)(9686003)(4326008)(8676002)(26005)(8936002)(33656002)(86362001)(66476007)(2906002)(53546011)(186003)(5660300002)(229853002)(81166006)(71190400001)(66446008)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3674;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xM9uQk/wMgq0i1w3ppwyRHpdwtF8HkOcDSc48G0xZLDzFxm7k8fo3ncyHBgbJoMWiomGjvdiaaY5w+TloVyHLpeUwZMUrGtAgeOExiP8xeFdtFnZK5vil+TZhdLopwbIjeiAI6d6S6UBVPCI/jw3pRmGVvhiS/LCe7/u1RYb2YbXOanPepMOSX/a8CDNTxXWMjKEz9tudV33UnwaS8MC2Vu79H9RWkbD+PtccQbRjNOkcRYmp88GPlBm++qaoAwbP2V1NqjmY5+m7A4Sp3gOV2z6IvgNGUXubo4F/HjTaRYq4igXNHI22CfSrzd4FvnJCmWXAvQ0nscFg78PjLr4VUL/zga3RCtiHCkeWDXHtBi3727f4O4BRY6M+i1tjqmPjHT+aBEEfrv18IhJdFeSGUz3w9QUgJGZfFxoePkQDEKuv9C6yQgbG9W/w83mQCJSHCt70tnywE7SFJxqC9CDSSwmFJmMFW84lf8ge5XhAb1Vle18VBeBSF6kl5r8h8yGv8QW53IJGGAPRKLJxbNxUQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cda86f4a-37b9-45f9-82b0-08d77d4b0de0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2019 08:29:20.3751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QZRpBc/4M3A8uLZC/zYE7wsH1gim5JuWhVicvYktttYEPwORXXifvHltJ1/HN/+MIAMTsyKv5r8EiYI+H8C6nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3674
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFmYWVsIEouIFd5c29j
a2kgPHJhZmFlbEBrZXJuZWwub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBEZWNlbWJlciAxMCwgMjAx
OSA0OjIyIFBNDQo+IFRvOiBWaXJlc2ggS3VtYXIgPHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnPg0K
PiBDYzogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+OyBSYWZhZWwgSi4gV3lzb2NraSA8cmFm
YWVsQGtlcm5lbC5vcmc+Ow0KPiBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT47IFJh
ZmFlbCBKLiBXeXNvY2tpDQo+IDxyandAcmp3eXNvY2tpLm5ldD47IEphY2t5IEJhaSA8cGluZy5i
YWlAbnhwLmNvbT47IGxpbnV4LQ0KPiBwbUB2Z2VyLmtlcm5lbC5vcmc7IFZpbmNlbnQgR3VpdHRv
dCA8dmluY2VudC5ndWl0dG90QGxpbmFyby5vcmc+OyBQZXRlcg0KPiBaaWpsc3RyYSA8cGV0ZXJ6
QGluZnJhZGVhZC5vcmc+OyBQYXVsIE1jS2VubmV5DQo+IDxwYXVsbWNrQGxpbnV4LnZuZXQuaWJt
LmNvbT4NCj4gU3ViamVjdDogUmU6IEFib3V0IENQVSBob3QtcGx1ZyBzdHJlc3MgdGVzdCBmYWls
ZWQgaW4gY3B1ZnJlcSBkcml2ZXINCj4gDQo+IE9uIFR1ZSwgRGVjIDEwLCAyMDE5IGF0IDg6MDUg
QU0gVmlyZXNoIEt1bWFyIDx2aXJlc2gua3VtYXJAbGluYXJvLm9yZz4NCj4gd3JvdGU6DQo+ID4N
Cj4gPiArZmV3IG1vcmUgZ3V5cw0KPiA+DQo+ID4gT24gMTAtMTItMTksIDA1OjUzLCBQZW5nIEZh
biB3cm90ZToNCj4gPiA+IEJ1dCBwZXINCj4gPiA+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnBy
b3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmVsDQo+ID4gPiBpeGlyLmJv
b3RsaW4uY29tJTJGbGludXglMkZ2NS41LQ0KPiByYzElMkZzb3VyY2UlMkZrZXJuZWwlMkZzY2hl
ZCUyRnNjaGUNCj4gPiA+DQo+IGQuaCUyM0wyMjkzJmFtcDtkYXRhPTAyJTdDMDElN0NhbnNvbi5o
dWFuZyU0MG54cC5jb20lN0M2ZjQ0OTAwDQo+IGJlMzQwNA0KPiA+ID4NCj4gZTdkMzU1NzA4ZDc3
ZDRhMTZmYSU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAlDQo+IDdD
NjM3DQo+ID4gPg0KPiAxMTU2Mjk0NzU0NTYzMjkmYW1wO3NkYXRhPVhYaHd2dVRPQmIzVExtZXJ3
a3IxektiYVdOQTh4QSUyQmwNCj4gVyUyRmF3MzENCj4gPiA+IDBBWWNNJTNEJmFtcDtyZXNlcnZl
ZD0wDQo+ID4gPiBjcHVfb2YocnEpIGFuZCBzbXBfcHJvY2Vzc29yX2lkKCkgaXMgcG9zc2libGUg
dG8gbm90IHRoZSBzYW1lLA0KPiA+ID4NCj4gPiA+IFdoZW4gY3B1X29mKHJxKSBpcyBub3QgZXF1
YWwgdG8gc21wX3Byb2Nlc3Nvcl9pZCgpLA0KPiA+ID4gZGJzX3VwZGF0ZV91dGlsX2hhbmRsZXIg
d2lsbCB1c2UgaXJxX3dvcmtfcXVldWUgdG8NCj4gPiA+IHNtcF9wcm9jZXNzb3JfaWQoKSwgbm90
IGNwdV9vZihycSkuIElzIHRoaXMgZXhwZWN0ZWQ/DQo+ID4gPiBPciBzaG91bGQgdGhlIGlycV93
b3JrIGJlIHF1ZXVlZCB0byBjcHVfb2YocnEpPw0KPiA+DQo+ID4gT2theSwgc29ycnkgZm9yIHRo
ZSBsb25nIHdlZWtlbmQgd2hlcmUgSSBjb3VsZG4ndCBnZXQgdGltZSB0byByZXBseSBhdCBhbGwu
DQo+IA0KPiBObyB3b3JyaWVzLiA6LSkNCj4gDQo+ID4gRmlyc3Qgb2YgYWxsLCBsZXRzIHRyeSB0
byB1bmRlcnN0YW5kIGR2ZnNfcG9zc2libGVfZnJvbV9hbnlfY3B1Lg0KPiA+DQo+ID4gV2hvIGNh
biB1cGRhdGUgdGhlIGZyZXF1ZW5jeSBvZiBhIENQVSA/IEZvciBtYW55DQo+ID4gYXJjaGl0ZWN0
dXJlcy9wbGF0Zm9ybXMgdGhlIGV2ZW50dWFsIGNvZGUgdGhhdCB3cml0ZXMgdG8gc29tZSByZWdp
c3Rlcg0KPiA+IHRvIGNoYW5nZSB0aGUgZnJlcXVlbmN5IHNob3VsZCBvbmx5IHJ1biBvbiB0aGUg
bG9jYWwgQ1BVLCBhcyB0aGVzZQ0KPiA+IHJlZ2lzdGVycyBhcmUgcGVyLWNwdSByZWdpc3RlcnMg
YW5kIG5vdCBzb21ldGhpbmcgc2hhcmVkIGJldHdlZW4gQ1BVcy4NCj4gPg0KPiA+IEJ1dCBmb3Ig
dGhlIEFSTSBhcmNoaXRlY3R1cmUsIHdlIGhhdmUgYSBQTEwgYW5kIHRoZW4gc29tZSBtb3JlDQo+
ID4gcmVnaXN0ZXJzIHRvIHBsYXkgd2l0aCB0aGUgY2xrIHByb3ZpZGVkIHRvIHRoZSBDUFUgYmxv
Y2tzIGFuZCB0aGVzZQ0KPiA+IHJlZ2lzdGVycyAod2hpY2ggYXJlIHVwZGF0ZWQgYXMgYSByZXN1
bHQgb2YgY2xrX3NldF9yYXRlKCkpIGFyZSBwYXJ0IG9mIGENCj4gYmxvY2sgb3V0c2lkZSBvZiB0
aGUgQ1BVIGJsb2Nrcy4NCj4gPiBBbmQgc28gYW55IENQVSAoZXZlbiBpZiBpdCBpcyBub3QgcGFy
dCBvZiB0aGUgc2FtZSBjcHVmcmVxIHBvbGljeSkgY2FuDQo+ID4gdXBkYXRlIGl0LiBTZXR0aW5n
IHRoaXMgZmxhZyBhbGxvd3MgdGhhdCBhbmQgZXZlbnR1YWxseSB3ZSBtYXkgZW5kIHVwDQo+ID4g
dXBkYXRpbmcgdGhlIGZyZXF1ZW5jeSBzb29uZXIsIGluc3RlYWQgb2YgbGF0ZXIgKHdoaWNoIG1h
eSBiZSBsZXNzDQo+ID4gZWZmZWN0aXZlKS4gVGhhdCB3YXMgdGhlIGlkZWEgb2YgdGhlIHJlbW90
ZS13YWtldXAgc2VyaWVzLiBUaGlzIHN0dWZmDQo+ID4gaXMgYWJzb2x1dGVseSBjb3JyZWN0IGFu
ZCBzbyBjcHVmcmVxLWR0IGRvZXMgaXQgZm9yIGV2ZXJ5b25lLg0KPiA+DQo+ID4gVGhpcyBhbHNv
IG1lYW5zIHRoYXQgdGhlIG5vcm1hbCB3b3JrIGFuZCBpcnEtd29yayBib3RoIGNhbiBydW4gb24g
YW55DQo+ID4gQ1BVIGZvciB5b3VyIHBsYXRmb3JtIGFuZCBpdCBzaG91bGQgYmUgb2theSB0byBk
byB0aGF0Lg0KPiANCj4gQW5kIGl0IHRoZSBmYWlsaW5nIGNhc2UgYWxsIG9mIHRoZSBDUFVzIGlu
IHRoZSBzeXN0ZW0gYXJlIGluIHRoZSBzYW1lIHBvbGljeQ0KPiBhbnl3YXksIHNvIGR2ZnNfcG9z
c2libGVfZnJvbV9hbnlfY3B1IGlzIGEgcmVkIGhlcnJpbmcuDQo+IA0KPiA+IE5vdywgd2UgaGF2
ZSBuZWNlc3NhcnkgbWVhc3VyZXMgaW4gcGxhY2UgdG8gbWFrZSBzdXJlIHRoYXQgYWZ0ZXINCj4g
PiBzdG9wcGluZyBhbmQgYmVmb3JlIHN0YXJ0aW5nIGEgZ292ZXJub3IsIHRoZSBzY2hlZHVsZXIg
aG9va3MgdG8gc2F2ZQ0KPiA+IHRoZSBjcHVmcmVxIGdvdmVybm9yIHBvaW50ZXIgYW5kIHVwZGF0
ZXMgdG8gcG9saWN5LT5jcHVzIGFyZSBtYWRlDQo+ID4gcHJvcGVybHksIHRvIG1ha2Ugc3VyZSB0
aGF0IHdlIG5ldmVyIGV2ZXIgc2NoZWR1bGUgYSB3b3JrIG9yIGlycS13b3JrDQo+ID4gb24gYSBD
UFUgd2hpY2ggaXMgb2ZmbGluZS4gTm93IGl0IGxvb2tzIGxpa2UgdGhpcyBpc24ndCB3b3JraW5n
IGFzDQo+ID4gZXhwZWN0ZWQgYW5kIHdlIG5lZWQgdG8gZmluZCB3aGF0IGV4YWN0bHkgaXMgYnJv
a2VuIGhlcmUuDQo+ID4NCj4gPiBBbmQgeWVzLCBJIGRpZCB0aGUgdGVzdGluZyBvbiBIaWtleSA2
MjAsIGFuIG9jdGEtY29yZSBBUk0gcGxhdGZvcm0NCj4gPiB3aGljaCBoYXMgYSBzaW5nbGUgY3B1
ZnJlcSBwb2xpY3kgd2hpY2ggaGFzIGFsbCB0aGUgOCBDUFVzLiBBbmQgeWVzLCBJDQo+ID4gYW0g
dXNpbmcgY3B1ZnJlcS1kdCBvbmx5IGFuZCBJIHdhc24ndCBhYmxlIHRvIHJlcHJvZHVjZSB0aGUg
cHJvYmxlbQ0KPiA+IHdpdGggbWFpbmxpbmUga2VybmVsIGFzIEkgZXhwbGFpbmVkIGVhcmxpZXIu
DQo+ID4NCj4gPiBUaGUgcHJvYmxlbSBpcyBzb21ld2hlcmUgYmV0d2VlbiB0aGUgc2NoZWR1bGVy
J3MgZ292ZXJub3IgaG9vaw0KPiBydW5uaW5nDQo+ID4gb3IgcXVldWluZyB3b3JrIG9uIGEgQ1BV
IHdoaWNoIGlzIGluIHRoZSBtaWRkbGUgb2YgZ2V0dGluZw0KPiA+IG9mZmxpbmUvb25saW5lIGFu
ZCB0aGVyZSBpcyBzb21lIHJhY2UgYXJvdW5kIHRoYXQuIFRoZSBwcm9ibGVtIGhlbmNlDQo+ID4g
bWF5IG5vdCBiZSByZWxhdGVkIHRvIGp1c3QgY3B1ZnJlcSwgYnV0IGEgd2lkZXIgdmFyaWV0eSBv
ZiBjbGllbnRzLg0KPiANCj4gVGhlIHByb2JsZW0gaXMgdGhhdCBhIENQVSBpcyBydW5uaW5nIGEg
Z292ZXJub3IgaG9vayB3aGljaCBpdCBzaG91bGRuJ3QgYmUNCj4gcnVubmluZyBhdCBhbGwuDQo+
IA0KPiBUaGUgb2JzZXJ2YXRpb24gdGhhdCBkdmZzX3Bvc3NpYmxlX2Zyb21fYW55X2NwdSBtYWtl
cyBhIGRpZmZlcmVuY2Ugb25seQ0KPiBtZWFucyB0aGF0IHRoZSBnb3Zlcm5vciBob29rIGlzIHJ1
bm5pbmcgb24gYSBDUFUgdGhhdCBpcyBub3QgcHJlc2VudCBpbiB0aGUNCj4gcG9saWN5LT5jcHVz
IG1hc2suICBPbiB0aGUgcGxhdGZvcm0ocykgaW4gcXVlc3Rpb24gdGhpcyBjYW5ub3QgaGFwcGVu
IGFzDQo+IGxvbmcgYXMgUkNVIHdvcmtzIGFzIGV4cGVjdGVkLg0KDQpJZiBJIHVuZGVyc3RhbmQg
Y29ycmVjdGx5LCB0aGUgZ292ZXJub3IgaG9vayBPTkxZIGJlIGNsZWFyIG9uIHRoZSBDUFUgYmVp
bmcgb2ZmbGluZSBhbmQNCmFmdGVyIGdvdmVybm9yIHN0b3BwZWQsIGJ1dCB0aGUgQ1BVIGJlaW5n
IG9mZmxpbmUgY291bGQgc3RpbGwgcnVuIGludG8gYmVsb3cgZnVuY3Rpb24gdG8gaGVscA0Kb3Ro
ZXIgQ1BVIHVwZGF0ZSB0aGUgdXRpbCwgYW5kIGl0IE9OTFkgY2hlY2tzIHRoZSBjcHVfb2YocnEp
J3MgZ292ZXJub3IgaG9vayB3aGljaCBpcyB2YWxpZA0KYXMgdGhhdCBDUFUgaXMgb25saW5lLg0K
DQpTbyB0aGUgcXVlc3Rpb24gaXMgaG93IHRvIGF2b2lkIHRoZSBDUFUgYmVpbmcgb2ZmbGluZSBh
bmQgYWxyZWFkeSBmaW5pc2ggdGhlIGdvdmVybm9yIHN0b3ANCmZsb3cgYmUgc2NoZWR1bGVkIHRv
IGhlbHAgb3RoZXIgQ1BVIHVwZGF0ZSB0aGUgdXRpbC4NCg0KIHN0YXRpYyBpbmxpbmUgdm9pZCBj
cHVmcmVxX3VwZGF0ZV91dGlsKHN0cnVjdCBycSAqcnEsIHVuc2lnbmVkIGludCBmbGFncykNCiB7
DQogICAgICAgICBzdHJ1Y3QgdXBkYXRlX3V0aWxfZGF0YSAqZGF0YTsNCg0KICAgICAgICAgZGF0
YSA9IHJjdV9kZXJlZmVyZW5jZV9zY2hlZCgqcGVyX2NwdV9wdHIoJmNwdWZyZXFfdXBkYXRlX3V0
aWxfZGF0YSwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGNwdV9vZihycSkpKTsNCiAgICAgICAgIGlmIChkYXRhKQ0KICAgICAgICAgICAgICAgICBk
YXRhLT5mdW5jKGRhdGEsIHJxX2Nsb2NrKHJxKSwgZmxhZ3MpOw0KIH0NCg0KQW5zb24NCg==
