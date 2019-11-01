Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF0AEC4CF
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2019 15:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfKAOgP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Nov 2019 10:36:15 -0400
Received: from mail-eopbgr70057.outbound.protection.outlook.com ([40.107.7.57]:1379
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726658AbfKAOgP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 1 Nov 2019 10:36:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZXaWyW2ljjUqv+1HO+0xvLVffTVDm/UnjklfIlhTaCspKtUvbPS+1jtAT4Mp0PdCfWTWS2/aWZSNouffVK8PKpRF4ekHtGpfjF/c00OG9nNS2O0JVTB4eHE+IbtbyknjdcaLs/gtnrwfKQBHK6n7NTGyZKGGC763Zef+Nqx66KH/vFmUmlNHDtwkPveGiNoYRUoEw89yn97nDtH9Ql3FZznV77a4zY4JmtR02Oe8Agggm9q+DUhSD2yX4Ju/klRRFFqaQhGApJBR6XZdbZeUBvZGfqjZQePz84lUIN0UZ1wEVdxVyWQf0GTAoGjPwUIBsqow9NlJRjdTZewJYwYUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwTKyapF/nM0Yknof5kXhtyJzyrfQSKCNAgf4Ql7GbI=;
 b=oS7GUXQV/h6nUbstRsQqSsEFD/uaW5bw2xb4hrY8QrBIIBh7XXsCNITmP7aPm6XdQa77ACsqtl/meolO3X8ekgtFJbjMnrKN/XZNgjEEXDrGPlvtlUjNFHFLYpUMUUHRPb++Btys0oZkk6ChIOoZjuJPvgLHVQYT50JJrAdPPR0It7dDB9zwz1ujUULtBgj9BKUnpWhTU79cZDy1ZDetsQ8BMDWuH8hfgx64t98pJLvqrd/nSvGFlfX6c5wzgQkp7lhi9tiGcoWjqCuKRHv7luM8PkqjH4/m/t0lTu/gvjw5RvM/PAlcBmFqJAtzNPvA7nGTlG/pItBbF+v5oHFXpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwTKyapF/nM0Yknof5kXhtyJzyrfQSKCNAgf4Ql7GbI=;
 b=RtSkyhhvDuUFpErXZW3l6SJ7pOLsV+GsbfpCWgr21ACbwzAmFDHGS0UCL3TUAWAbgTYZ0gCYPfX+wo2/2BG4zRkOYcRNFHbvU+CEihhv6SC3RGqK0AkkZw8MyTyYGA5ZRKYiMbakwYu0Gso+h0jpI9WJcGyjshkbosl2iJWssgk=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB4624.eurprd04.prod.outlook.com (20.177.56.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.23; Fri, 1 Nov 2019 14:36:08 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3%5]) with mapi id 15.20.2387.028; Fri, 1 Nov 2019
 14:36:08 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>
CC:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        =?utf-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v9 4/8] PM / devfreq: Move more initialization before
 registration
Thread-Topic: [PATCH v9 4/8] PM / devfreq: Move more initialization before
 registration
Thread-Index: AQHVeVcj1XSohkLMhkijGZw3IGc8Ug==
Date:   Fri, 1 Nov 2019 14:36:08 +0000
Message-ID: <VI1PR04MB70231670A8CF3CD8BDCA28EBEE620@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1570044052.git.leonard.crestez@nxp.com>
 <CGME20191002192527epcas3p3ba24247bd1b8ce8ac33f7e4431c25241@epcas3p3.samsung.com>
 <25f46d76dc95d5509edd7bf9d1a2e0532faef4cc.1570044052.git.leonard.crestez@nxp.com>
 <0cadb00d-d34e-4028-93c4-b4902a50f5e2@samsung.com>
 <VI1PR04MB70234DF1004231D1BB02A41DEE630@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <6f9334b3-01f9-a7c5-a87b-7e8a77c8d6e0@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0b4f7ff6-f16e-4785-ec9a-08d75ed8d581
x-ms-traffictypediagnostic: VI1PR04MB4624:|VI1PR04MB4624:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4624CB24D122E5ED3C188798EE620@VI1PR04MB4624.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(51444003)(199004)(189003)(52536014)(229853002)(446003)(316002)(486006)(33656002)(99286004)(476003)(14454004)(64756008)(8676002)(81166006)(66476007)(81156014)(8936002)(76116006)(44832011)(66556008)(91956017)(66446008)(66946007)(7416002)(26005)(7736002)(71190400001)(86362001)(25786009)(305945005)(74316002)(66066001)(5660300002)(186003)(71200400001)(6916009)(3846002)(14444005)(6116002)(256004)(966005)(2906002)(478600001)(54906003)(6436002)(4326008)(6306002)(9686003)(76176011)(6246003)(55016002)(53546011)(102836004)(7696005)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4624;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DOhxYWY4LQFLL2MzmcHSUolShqqKc8NkPOFUldN7QELbH7w8waA1E7zasTTGuVOatGeuBSJh9am82wvxWn+Qur3nKIhs5+QU9KhVIKwhm+WcuJYSQv40DxGhnamuhn86OX052YlM6TGB54EekxwvuCVKIG9GK56mgQkFQ1zXBc5Zk+Ci0f/frzsFKS77VycDGyb/vgIfJTY4kGFyg+VHtOguED1wSmRc0Kc3fMGK4y5i+0yiZ55R3wtJH7lDvjbWnKzT4y7KSiStUjTppWUZe9OHHW8aPJayILIjQ/aHlkQYC4W/L5VBliA3W8akOZZC0GwpjCzj2rTBzXDLSm62pDPY6LhY/TuKVeAKVxd4G8zvaYs7Udz97VGuMdpfZkILiqnV6Vn9YjN1WTgeDnAnOWBbT+r3g0bgOe+U5T2jzQhMdVA1oBZM7dhyinhnCJ/siu0i+utxOteG+TYXmw2UiMv9W4mY2f1J/h86eOLZNdE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b4f7ff6-f16e-4785-ec9a-08d75ed8d581
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 14:36:08.2022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ARq1mDyDtx+9dkzwJctHplU9i8KQiXoe3JPdX8E4jBGOLIl06Co2PfzeWAXOxfi/4/xtGceA5If1s5QsxqUOEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4624
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gMDEuMTEuMjAxOSAxMDoyNSwgQ2hhbndvbyBDaG9pIHdyb3RlOgo+IE9uIDE5LiAxMC4gMzEu
IOyYpO2bhCAxMDozMSwgTGVvbmFyZCBDcmVzdGV6IHdyb3RlOgo+PiBPbiAzMS4xMC4yMDE5IDA1
OjEwLCBDaGFud29vIENob2kgd3JvdGU6Cj4+PiBIaSBMZW9uYXJkLAo+Pj4KPj4+IFRoaXMgcGF0
Y2ggZGlkbid0IGdldCB0aGUgYWNrZWQtYnkgZnJvbSBkZXZmcmVxIG1haW50YWluZXIuCj4+PiBJ
IHRoaW5rIHRoYXQgd2UgbmVlZCB0byBkaXNjdXNzIHRoaXMgcGF0Y2ggd2l0aCBtb3JlIHRpbWUu
Cj4+PiBBbHNvLCBpdCBpcyBwb3NzaWJsZSB0byBtYWtlIGl0IGFzIHRoZSBzZXBhcmF0ZSBwYXRj
aAo+Pj4gZnJvbSB0aGlzIHNlcmllcy4KPj4+Cj4+PiBJTUhPLCBpZiB5b3UgbWFrZSB0aGUgc2Vw
YXJhdGUgcGF0Y2ggZm9yIHRoaXMgYW5kCj4+PiByZXNlbmQgdGhlIHNlcGFyYXRlIHBhdGNoIG9u
IGxhdGVyLCBJIHRoaW5rIHRoYXQKPj4+IHdlIGNhbiBtZXJnZSB0aGUgcmVtYWluZWQgcGF0Y2gg
cmVsYXRlZCB0byBQTV9RT1MuCj4+Cj4+IFRoZSBkZXZmcmVxIGluaXRpYWxpemF0aW9uIGNsZWFu
dXBzIGFyZSByZXF1aXJlZCBmb3IgZGV2X3BtX3FvcyBzdXBwb3J0LAo+PiBvdGhlcndpc2UgbG9j
a2RlcCB3YXJuaW5ncyBhcmUgdHJpZ2dlcmVkLiBJIGNhbiBwb3N0IHRoZSBjbGVhbnVwcyBhcyBh
Cj4+IHNlcGFyYXRlIHNlcmllcyBidXQgdGhlIFBNIFFvUyBvbmUgd291bGQgZGVwZW5kIG9uIHRo
ZSBjbGVhbnVwcy4KPj4KPj4gRG8geW91IHByZWZlciBtdWx0aXBsZSBzbWFsbGVyIHNlcmllcz8K
PiAKPiBBZnRlciByZWFkIHRoZSB2MTAsIEkgdGhpbmsgdjkgaXMgYmV0dGVyIHRoYW4gdjEwCj4g
Zm9yIHRoaXMgaXNzdWUuID4+Cj4+IEkgdHJ5IHRvIG9yZGVyIG15IHBhdGNoZXMgd2l0aCB1bmNv
bnRyb3ZlcnNpYWwgZml4ZXMgYW5kIGNsZWFudXBzIGZpcnN0Cj4+IHNvIGluIHRoZW9yeSB0aGUg
ZWFybGllciBwYXJ0cyBjb3VsZCBiZSBhcHBsaWVkIHNlcGFyYXRlbHkuIEl0J3MgdmVyeQo+PiBy
YXJlIHRvIHNlZSBzZXJpZXMgcGFydGlhbGx5IGFwcGxpZWQgdGhvdWdoLgo+Pgo+PiBFYXJsaWVy
IG9iamVjdGlvbiB3YXMgdGhhdCBkZXZtIHNob3VsZCBiZSBrZXB0LCBJIHRoaW5rIHRoaXMgY2Fu
IGJlCj4+IGFjY29tcGxpc2hlZCBieSBzcGxpdHRpbmcgZGV2aWNlX3JlZ2lzdGVyIGludG8gZGV2
aWNlX2luaXRpYWxpemUgYW5kCj4+IGRldmljZV9hZGQuCj4+Cj4+PiBPbiAxOS4gMTAuIDMuIOyY
pOyghCA0OjI1LCBMZW9uYXJkIENyZXN0ZXogd3JvdGU6Cj4+Pj4gSW4gZ2VuZXJhbCBpdCBpcyBh
IGJldHRlciB0byBpbml0aWFsaXplIGFuIG9iamVjdCBiZWZvcmUgbWFraW5nIGl0Cj4+Pj4gYWNj
ZXNzaWJsZSBleHRlcm5hbGx5ICh0aHJvdWdoIGRldmljZV9yZWdpc3RlcikuCj4+Pj4KPj4+PiBU
aGlzIG1ha2VzIGl0IHBvc3NpYmxlIHRvIGF2b2lkIHJlbW92ZSBsb2NraW5nIHRoZSBwYXJ0aWFs
bHkgaW5pdGlhbGl6ZWQKPj4+PiBvYmplY3QgYW5kIHNpbXBsaWZpZXMgdGhlIGNvZGUuIEhvd2V2
ZXIgZGV2bSBpcyBub3QgYXZhaWxhYmxlIGJlZm9yZQo+Pj4+IGRldmljZV9yZWdpc3RlciAob25s
eSBhZnRlciB0aGUgZGV2aWNlX2luaXRpYWxpemUgc3RlcCkgc28gdGhlIHR3bwo+Pj4+IGFsbG9j
YXRpb25zIG5lZWQgdG8gYmUgbWFuYWdlZCBtYW51YWxseS4KPj4+Pgo+Pj4+IFNpZ25lZC1vZmYt
Ynk6IExlb25hcmQgQ3Jlc3RleiA8bGVvbmFyZC5jcmVzdGV6QG54cC5jb20+Cj4+Pj4gUmV2aWV3
ZWQtYnk6IE1hdHRoaWFzIEthZWhsY2tlIDxta2FAY2hyb21pdW0ub3JnPgo+Pj4+IC0tLQo+Pj4+
ICAgIGRyaXZlcnMvZGV2ZnJlcS9kZXZmcmVxLmMgfCA0MyArKysrKysrKysrKysrKysrKysrKysr
Ky0tLS0tLS0tLS0tLS0tLS0KPj4+PiAgICAxIGZpbGUgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygr
KSwgMTggZGVsZXRpb25zKC0pCj4+Pj4KPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9kZXZmcmVx
L2RldmZyZXEuYyBiL2RyaXZlcnMvZGV2ZnJlcS9kZXZmcmVxLmMKPj4+PiBpbmRleCAzZTBlOTM2
MTg1YTMuLjBiNDBmNDBlZTdhYSAxMDA2NDQKPj4+PiAtLS0gYS9kcml2ZXJzL2RldmZyZXEvZGV2
ZnJlcS5jCj4+Pj4gKysrIGIvZHJpdmVycy9kZXZmcmVxL2RldmZyZXEuYwo+Pj4+IEBAIC01OTEs
MTAgKzU5MSwxMiBAQCBzdGF0aWMgdm9pZCBkZXZmcmVxX2Rldl9yZWxlYXNlKHN0cnVjdCBkZXZp
Y2UgKmRldikKPj4+PiAgICAJbXV0ZXhfdW5sb2NrKCZkZXZmcmVxX2xpc3RfbG9jayk7Cj4+Pj4g
ICAgCj4+Pj4gICAgCWlmIChkZXZmcmVxLT5wcm9maWxlLT5leGl0KQo+Pj4+ICAgIAkJZGV2ZnJl
cS0+cHJvZmlsZS0+ZXhpdChkZXZmcmVxLT5kZXYucGFyZW50KTsKPj4+PiAgICAKPj4+PiArCWtm
cmVlKGRldmZyZXEtPnRpbWVfaW5fc3RhdGUpOwo+Pj4+ICsJa2ZyZWUoZGV2ZnJlcS0+dHJhbnNf
dGFibGUpOwo+Pj4+ICAgIAltdXRleF9kZXN0cm95KCZkZXZmcmVxLT5sb2NrKTsKPj4+PiAgICAJ
a2ZyZWUoZGV2ZnJlcSk7Cj4+Pj4gICAgfQo+Pj4+ICAgIAo+Pj4+ICAgIC8qKgo+Pj4+IEBAIC02
NzQsNDQgKzY3Niw0MyBAQCBzdHJ1Y3QgZGV2ZnJlcSAqZGV2ZnJlcV9hZGRfZGV2aWNlKHN0cnVj
dCBkZXZpY2UgKmRldiwKPj4+PiAgICAJZGV2ZnJlcS0+bWF4X2ZyZXEgPSBkZXZmcmVxLT5zY2Fs
aW5nX21heF9mcmVxOwo+Pj4+ICAgIAo+Pj4+ICAgIAlkZXZmcmVxLT5zdXNwZW5kX2ZyZXEgPSBk
ZXZfcG1fb3BwX2dldF9zdXNwZW5kX29wcF9mcmVxKGRldik7Cj4+Pj4gICAgCWF0b21pY19zZXQo
JmRldmZyZXEtPnN1c3BlbmRfY291bnQsIDApOwo+Pj4+ICAgIAo+Pj4+IC0JZGV2X3NldF9uYW1l
KCZkZXZmcmVxLT5kZXYsICJkZXZmcmVxJWQiLAo+Pj4+IC0JCQkJYXRvbWljX2luY19yZXR1cm4o
JmRldmZyZXFfbm8pKTsKPj4+PiAtCWVyciA9IGRldmljZV9yZWdpc3RlcigmZGV2ZnJlcS0+ZGV2
KTsKPj4+PiAtCWlmIChlcnIpIHsKPj4+PiAtCQltdXRleF91bmxvY2soJmRldmZyZXEtPmxvY2sp
Owo+Pj4+IC0JCXB1dF9kZXZpY2UoJmRldmZyZXEtPmRldik7Cj4+Pj4gLQkJZ290byBlcnJfb3V0
Owo+Pj4+IC0JfQo+Pj4+IC0KPj4+PiAtCWRldmZyZXEtPnRyYW5zX3RhYmxlID0gZGV2bV9remFs
bG9jKCZkZXZmcmVxLT5kZXYsCj4+Pj4gKwlkZXZmcmVxLT50cmFuc190YWJsZSA9IGt6YWxsb2Mo
Cj4+Pj4gICAgCQkJYXJyYXkzX3NpemUoc2l6ZW9mKHVuc2lnbmVkIGludCksCj4+Pj4gICAgCQkJ
CSAgICBkZXZmcmVxLT5wcm9maWxlLT5tYXhfc3RhdGUsCj4+Pj4gICAgCQkJCSAgICBkZXZmcmVx
LT5wcm9maWxlLT5tYXhfc3RhdGUpLAo+Pj4+ICAgIAkJCUdGUF9LRVJORUwpOwo+Pj4+ICAgIAlp
ZiAoIWRldmZyZXEtPnRyYW5zX3RhYmxlKSB7Cj4+Pj4gICAgCQltdXRleF91bmxvY2soJmRldmZy
ZXEtPmxvY2spOwo+Pj4+ICAgIAkJZXJyID0gLUVOT01FTTsKPj4+PiAtCQlnb3RvIGVycl9kZXZm
cmVxOwo+Pj4+ICsJCWdvdG8gZXJyX2RldjsKPj4+PiAgICAJfQo+Pj4+ICAgIAo+Pj4+IC0JZGV2
ZnJlcS0+dGltZV9pbl9zdGF0ZSA9IGRldm1fa2NhbGxvYygmZGV2ZnJlcS0+ZGV2LAo+Pj4+IC0J
CQlkZXZmcmVxLT5wcm9maWxlLT5tYXhfc3RhdGUsCj4+Pj4gLQkJCXNpemVvZih1bnNpZ25lZCBs
b25nKSwKPj4+PiAtCQkJR0ZQX0tFUk5FTCk7Cj4+Pj4gKwlkZXZmcmVxLT50aW1lX2luX3N0YXRl
ID0ga2NhbGxvYyhkZXZmcmVxLT5wcm9maWxlLT5tYXhfc3RhdGUsCj4+Pj4gKwkJCQkJIHNpemVv
Zih1bnNpZ25lZCBsb25nKSwKPj4+PiArCQkJCQkgR0ZQX0tFUk5FTCk7Cj4+Pj4gICAgCWlmICgh
ZGV2ZnJlcS0+dGltZV9pbl9zdGF0ZSkgewo+Pj4+ICAgIAkJbXV0ZXhfdW5sb2NrKCZkZXZmcmVx
LT5sb2NrKTsKPj4+PiAgICAJCWVyciA9IC1FTk9NRU07Cj4+Pj4gLQkJZ290byBlcnJfZGV2ZnJl
cTsKPj4+PiArCQlnb3RvIGVycl9kZXY7Cj4+Pj4gICAgCX0KPj4+PiAgICAKPj4+PiAgICAJZGV2
ZnJlcS0+bGFzdF9zdGF0X3VwZGF0ZWQgPSBqaWZmaWVzOwo+Pj4+ICAgIAo+Pj4+ICAgIAlzcmN1
X2luaXRfbm90aWZpZXJfaGVhZCgmZGV2ZnJlcS0+dHJhbnNpdGlvbl9ub3RpZmllcl9saXN0KTsK
Pj4+PiAgICAKPj4+PiArCWRldl9zZXRfbmFtZSgmZGV2ZnJlcS0+ZGV2LCAiZGV2ZnJlcSVkIiwK
Pj4+PiArCQkJCWF0b21pY19pbmNfcmV0dXJuKCZkZXZmcmVxX25vKSk7Cj4+Pj4gKwllcnIgPSBk
ZXZpY2VfcmVnaXN0ZXIoJmRldmZyZXEtPmRldik7Cj4+Pj4gKwlpZiAoZXJyKSB7Cj4+Pj4gKwkJ
bXV0ZXhfdW5sb2NrKCZkZXZmcmVxLT5sb2NrKTsKPj4+PiArCQlwdXRfZGV2aWNlKCZkZXZmcmVx
LT5kZXYpOwo+Pj4+ICsJCWdvdG8gZXJyX291dDsKPiAKPiBlcnJfb3V0IC0+IGVycl9kZXYKPiBX
aGVuIGZhaWxlZCB0byByZWdpc3RlciwgaGF2ZSB0byBmcmVlIHJlc291cmNlLgoKQWNjb3JkaW5n
IGRvY3VtZW50YXRpb24gb24gZGV2aWNlX3JlZ2lzdGVyIHJlc291cmNlcyBuZWVkIHRvIGJlIGZy
ZWVkIAp2aWEgcHV0X2RldmljZSAod2hpY2ggY2FsbHMgZGV2LnJlbGVhc2UgPSBkZXZmcmVxX2Rl
dl9yZWxlYXNlKS4KClRoaXMgY2h1bmsgaXNuJ3QgbmV3OyBpdCBqdXN0IGFwcGVhcnMgc28gYmVj
YXVzZSBvdGhlciBjb2RlIHdhcyBtb3ZlZCAKYXJvdW5kIGl0LgoKPiAKPj4+PiArCX0KPj4+PiAr
Cj4+Pj4gICAgCW11dGV4X3VubG9jaygmZGV2ZnJlcS0+bG9jayk7Cj4+Pj4gICAgCj4+Pj4gICAg
CW11dGV4X2xvY2soJmRldmZyZXFfbGlzdF9sb2NrKTsKPj4+PiAgICAKPj4+PiAgICAJZ292ZXJu
b3IgPSB0cnlfdGhlbl9yZXF1ZXN0X2dvdmVybm9yKGRldmZyZXEtPmdvdmVybm9yX25hbWUpOwo+
Pj4+IEBAIC03MzcsMTQgKzczOCwyMCBAQCBzdHJ1Y3QgZGV2ZnJlcSAqZGV2ZnJlcV9hZGRfZGV2
aWNlKHN0cnVjdCBkZXZpY2UgKmRldiwKPj4+PiAgICAKPj4+PiAgICAJcmV0dXJuIGRldmZyZXE7
Cj4+Pj4gICAgCj4+Pj4gICAgZXJyX2luaXQ6Cj4+Pj4gICAgCW11dGV4X3VubG9jaygmZGV2ZnJl
cV9saXN0X2xvY2spOwo+Pj4+IC1lcnJfZGV2ZnJlcToKPj4+PiAgICAJZGV2ZnJlcV9yZW1vdmVf
ZGV2aWNlKGRldmZyZXEpOwo+Pj4+IC0JZGV2ZnJlcSA9IE5VTEw7Cj4+Pj4gKwlyZXR1cm4gRVJS
X1BUUihlcnIpOwo+IAo+IAo+IEl0IGlzIG5vdCBwcm9wZXIgdG8gcmV0dXJuIG9uIHRoZSBtaWRk
bGUKPiBvZiB0aGUgZXhjZXB0aW9uIGhhbmRsaW5nLiBOZWVkIHRvIGNvbnNpZGVyIG1vcmUgY2xl
YW4gbWV0aG9kLgoKQ3VycmVudCBjb2RlIGFscmVhZHkgZG9lcyAiZGV2ZnJlcSA9IE5VTEwiIGlu
IG9yZGVyIHRvIHNraXAgdGhlIGtmcmVlIApiZWxvdy4gVGhlcmUgYXJlIGFscmVhZHkgbWFueSBj
bGVhbnVwL2V4aXQgcGF0aHMsIGl0J3MganVzdCBub3QgdmVyeSAKb2J2aW91cy4KCkNsZWFudXAg
Zm9yIGVycm9ycyBiZWZvcmUgYW5kIGFmdGVyICJkZXZpY2VfcmVnaXN0ZXIiIGlzIGRpZmZlcmVu
dCBhbmQgCnRoaXMgaXMgcmVxdWlyZWQgYnkgZGV2aWNlIGNvcmUuCgpUaGlzIGNhbiBiZSBpbXBy
b3ZlZCBieSBzcGxpdHRpbmcgZGV2aWNlX3JlZ2lzdGVyIGludG8gZGV2aWNlX2luaXRpYWxpemUg
CmFuZCBkZXZpY2VfYWRkOiB0aGlzIG1lYW5zIHRoYXQgYWxsIGVhcmx5IGVycm9yIHBhdGhzIGRv
IHB1dF9kZXZpY2UgYW5kIAp0aGVyZSBpcyBubyBsb25nZXIgYW55IG5lZWQgdG8gbWFudWFsbHkg
a2ZyZWUoZGV2ZnJlcSkgYmVjYXVzZSAKZGV2ZnJlcV9kZXZfcmVsZWFzZSBpcyBjYWxsZWQgb24g
YWxsIGNsZWFudXAgcGF0aHMuIEl0IGFsc28gcHJlc2VydmVzIGRldm06CgpodHRwczovL3BhdGNo
d29yay5rZXJuZWwub3JnL3BhdGNoLzExMjIxODczLwoKSG93ZXZlciB0aGVyZSBpcyBzdGlsbCBh
IGRpZmZlcmVuY2UgYmV0d2VlbiBjbGVhbnVwIGJlZm9yZS9hZnRlciAKZGV2aWNlX2FkZDogaWYg
c29tZXRoaW5nIGZhaWxzIGFmdGVyIGRldmljZV9hZGQgeW91IG5lZWQgdG8gY2FsbCAKZGV2ZnJl
cV9yZW1vdmVfZGV2aWNlICh3aGljaCBkb2VzIGRldmljZV91bnJlZ2lzdGVyKSBhbmQgb3RoZXJ3
aXNlIApkZXZpY2VfcHV0Lgo+Pj4+ICsKPj4+PiAgICBlcnJfZGV2Ogo+Pj4+ICsJLyoKPj4+PiAr
CSAqIENsZWFudXAgcGF0aCBmb3IgZXJyb3JzIHRoYXQgaGFwcGVuIGJlZm9yZSByZWdpc3RyYXRp
b24uCj4+Pj4gKwkgKiBPdGhlcndpc2Ugd2UgcmVseSBvbiBkZXZmcmVxX2Rldl9yZWxlYXNlLgo+
Pj4+ICsJICovCj4+Pj4gKwlrZnJlZShkZXZmcmVxLT50aW1lX2luX3N0YXRlKTsKPj4+PiArCWtm
cmVlKGRldmZyZXEtPnRyYW5zX3RhYmxlKTsKPj4+PiAgICAJa2ZyZWUoZGV2ZnJlcSk7Cj4+Pj4g
ICAgZXJyX291dDoKPj4+PiAgICAJcmV0dXJuIEVSUl9QVFIoZXJyKTsKPj4+PiAgICB9Cj4+Pj4g
ICAgRVhQT1JUX1NZTUJPTChkZXZmcmVxX2FkZF9kZXZpY2UpOwo=
