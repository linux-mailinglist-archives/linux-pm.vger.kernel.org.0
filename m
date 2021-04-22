Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38BDC3680B3
	for <lists+linux-pm@lfdr.de>; Thu, 22 Apr 2021 14:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236360AbhDVMkf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Apr 2021 08:40:35 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3951 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237269AbhDVMkK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Apr 2021 08:40:10 -0400
Received: from DGGEML403-HUB.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FQxkn6sj5z5t5K;
        Thu, 22 Apr 2021 20:37:05 +0800 (CST)
Received: from dggemi705-chm.china.huawei.com (10.3.20.104) by
 DGGEML403-HUB.china.huawei.com (10.3.17.33) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Thu, 22 Apr 2021 20:39:29 +0800
Received: from dggemi757-chm.china.huawei.com (10.1.198.143) by
 dggemi705-chm.china.huawei.com (10.3.20.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 22 Apr 2021 20:39:29 +0800
Received: from dggemi757-chm.china.huawei.com ([10.9.49.199]) by
 dggemi757-chm.china.huawei.com ([10.9.49.199]) with mapi id 15.01.2176.012;
 Thu, 22 Apr 2021 20:39:29 +0800
From:   linruizhe <linruizhe@huawei.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Tony Lindgren <tony@atomide.com>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "j-keerthy@ti.com" <j-keerthy@ti.com>,
        "amitk@kernel.org" <amitk@kernel.org>,
        "eballetbo@gmail.com" <eballetbo@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjNdIHRoZXJtYWw6IHRpLXNvYy10aGVybWFsOiBS?=
 =?utf-8?Q?emove_unused_variable_'val'?=
Thread-Topic: [PATCH v3] thermal: ti-soc-thermal: Remove unused variable 'val'
Thread-Index: AQHXNopQkdph70A1h02cCOdJ6yn6yaq+I1+AgAAEiYCAAAiwgIAAIVsAgAIolBA=
Date:   Thu, 22 Apr 2021 12:39:29 +0000
Message-ID: <7871516e6f824f35929c4ed87cbc08c4@huawei.com>
References: <20210421084256.57591-1-linruizhe@huawei.com>
 <YH/nK6xshH+lW7e0@kroah.com>
 <8e66040e-4330-d4f0-afbb-8cae62a5082e@linaro.org>
 <YH/yQ5Hd+30DH4p/@atomide.com>
 <3116672d-4ff3-a065-f76c-1ae820e1ff95@linaro.org>
In-Reply-To: <3116672d-4ff3-a065-f76c-1ae820e1ff95@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.110.254]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgRGFuaWVsLA0KDQpEbyBJIG5lZWQgdG8gbWFrZSBtb3JlIGNoYW5nZXMgdG8gdGhpcyBwYXRj
aD8NCg0KVGhhbmtzDQogDQogIC1MaW4gUnVpemhlDQoNCi0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0N
CuWPkeS7tuS6ujogRGFuaWVsIExlemNhbm8gW21haWx0bzpkYW5pZWwubGV6Y2Fub0BsaW5hcm8u
b3JnXSANCuWPkemAgeaXtumXtDogMjAyMeW5tDTmnIgyMeaXpSAxOTozNw0K5pS25Lu25Lq6OiBU
b255IExpbmRncmVuIDx0b255QGF0b21pZGUuY29tPg0K5oqE6YCBOiBHcmVnIEtIIDxncmVna2hA
bGludXhmb3VuZGF0aW9uLm9yZz47IGxpbnJ1aXpoZSA8bGlucnVpemhlQGh1YXdlaS5jb20+OyBy
dWkuemhhbmdAaW50ZWwuY29tOyBlZHViZXp2YWxAZ21haWwuY29tOyBqLWtlZXJ0aHlAdGkuY29t
OyBhbWl0a0BrZXJuZWwub3JnOyBlYmFsbGV0Ym9AZ21haWwuY29tOyBsaW51eC1wbUB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LW9tYXBAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnDQrkuLvpopg6IFJlOiBbUEFUQ0ggdjNdIHRoZXJtYWw6IHRpLXNvYy10aGVybWFs
OiBSZW1vdmUgdW51c2VkIHZhcmlhYmxlICd2YWwnDQoNCg0KSGkgVG9ueSwNCg0KdGhhbmtzIGZv
ciB0ZXN0aW5nDQoNCiAgLS0gRGFuaWVsDQoNCk9uIDIxLzA0LzIwMjEgMTE6MzcsIFRvbnkgTGlu
ZGdyZW4gd3JvdGU6DQo+ICogRGFuaWVsIExlemNhbm8gPGRhbmllbC5sZXpjYW5vQGxpbmFyby5v
cmc+IFsyMTA0MjEgMDk6MDddOg0KPj4gT24gMjEvMDQvMjAyMSAxMDo0OSwgR3JlZyBLSCB3cm90
ZToNCj4+PiBPbiBXZWQsIEFwciAyMSwgMjAyMSBhdCAwNDo0Mjo1NlBNICswODAwLCBMaW4gUnVp
emhlIHdyb3RlOg0KPj4+PiBUaGUgdmFyaWFibGUgJ3ZhbCdpbiBmdW5jdGlvbiB0aV9iYW5kZ2Fw
X3Jlc3RvcmVfY3R4dCBpcyB0aGUgDQo+Pj4+IHJlZ2lzdGVyIHZhbHVlIG9mIHJlYWQgYmFuZGdh
cCByZWdpc3RlcnMuIFRoaXMgZnVuY3Rpb24gaXMgdG8gDQo+Pj4+IHJlc3RvcmUgdGhlIGNvbnRl
eHQuIEJ1dCB0aGVyZSBpcyBubyBvcGVyYXRpb24gb24gdGhlIHJldHVybiB2YWx1ZSANCj4+Pj4g
b2YgdGhpcyByZWdpc3Rlciwgc28gdGhpcyBibG9jayBpcyByZWR1bmRhbnQuIEh1bGsgcm9ib3Qg
c2NhbnMgdGhpcyANCj4+Pj4gd2FybmluZy5UaGlzIGNvbW1pdCByZW1vdmUgdGhlIGRlYWQgY29k
ZS4NCj4+Pj4NCj4+Pj4gUmVwb3J0ZWQtYnk6IEh1bGsgUm9ib3QgPGh1bGtjaUBodWF3ZWkuY29t
Pg0KPj4+PiBGaXhlczogYjg3ZWE3NTlhNGNjICgic3RhZ2luZzogb21hcC10aGVybWFsOiBmaXgg
Y29udGV4dCByZXN0b3JlIA0KPj4+PiBmdW5jdGlvbiIpDQo+Pj4+IFNpZ25lZC1vZmYtYnk6IExp
biBSdWl6aGUgPGxpbnJ1aXpoZUBodWF3ZWkuY29tPg0KPj4+PiAtLS0NCj4+Pj4gdjM6DQo+Pj4+
IC1BZGQgRml4ZXMgdGFnIGFuZCBtb3JlIGFjY3VyYXRlIGNvbW1pdCBtZXNzYWdlIGluIHRoaXMg
cGF0Y2guDQo+Pj4+IHYyOg0KPj4+PiAtQXMgc3VnZ2VzdCByZW1vdmUgdGhlIHdob2xlIHVudWVz
ZWQgYmxvY2sgaW4gZnVjdGlvbiAgDQo+Pj4+IHRpX2JhbmRnYXBfcmVzdG9yZV9jdHh0DQo+Pj4+
DQo+Pj4+ICBkcml2ZXJzL3RoZXJtYWwvdGktc29jLXRoZXJtYWwvdGktYmFuZGdhcC5jIHwgNCAt
LS0tDQo+Pj4+ICAxIGZpbGUgY2hhbmdlZCwgNCBkZWxldGlvbnMoLSkNCj4+Pj4NCj4+Pj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdGhlcm1hbC90aS1zb2MtdGhlcm1hbC90aS1iYW5kZ2FwLmMgDQo+
Pj4+IGIvZHJpdmVycy90aGVybWFsL3RpLXNvYy10aGVybWFsL3RpLWJhbmRnYXAuYw0KPj4+PiBp
bmRleCBkODFhZjg5MTY2ZDIuLjY4NGZmYjY0NWFhOSAxMDA2NDQNCj4+Pj4gLS0tIGEvZHJpdmVy
cy90aGVybWFsL3RpLXNvYy10aGVybWFsL3RpLWJhbmRnYXAuYw0KPj4+PiArKysgYi9kcml2ZXJz
L3RoZXJtYWwvdGktc29jLXRoZXJtYWwvdGktYmFuZGdhcC5jDQo+Pj4+IEBAIC0xMTQyLDE0ICsx
MTQyLDEwIEBAIHN0YXRpYyBpbnQgdGlfYmFuZGdhcF9yZXN0b3JlX2N0eHQoc3RydWN0IHRpX2Jh
bmRnYXAgKmJncCkNCj4+Pj4gIAlmb3IgKGkgPSAwOyBpIDwgYmdwLT5jb25mLT5zZW5zb3JfY291
bnQ7IGkrKykgew0KPj4+PiAgCQlzdHJ1Y3QgdGVtcF9zZW5zb3JfcmVnaXN0ZXJzICp0c3I7DQo+
Pj4+ICAJCXN0cnVjdCB0ZW1wX3NlbnNvcl9yZWd2YWwgKnJ2YWw7DQo+Pj4+IC0JCXUzMiB2YWwg
PSAwOw0KPj4+PiAgDQo+Pj4+ICAJCXJ2YWwgPSAmYmdwLT5yZWd2YWxbaV07DQo+Pj4+ICAJCXRz
ciA9IGJncC0+Y29uZi0+c2Vuc29yc1tpXS5yZWdpc3RlcnM7DQo+Pj4+ICANCj4+Pj4gLQkJaWYg
KFRJX0JBTkRHQVBfSEFTKGJncCwgQ09VTlRFUikpDQo+Pj4+IC0JCQl2YWwgPSB0aV9iYW5kZ2Fw
X3JlYWRsKGJncCwgdHNyLT5iZ2FwX2NvdW50ZXIpOw0KPj4+DQo+Pj4gQXJlIHlvdSBzdXJlIHRo
YXQgdGhpcyBoYXJkd2FyZSBkb2VzIG5vdCByZXF1aXJlIHRoaXMgcmVhZCB0byBoYXBwZW4gDQo+
Pj4gaW4gb3JkZXIgZm9yIGl0IHRvIHdvcmsgcHJvcGVybHk/DQo+Pg0KPj4gWWVzLCBpbml0aWFs
bHkgd2UgaGFkIHRoZSBzYW1lIGNvbmNlcm4gYnV0IHdlIHdlcmUgdW5hYmxlIHRvIGZpbmQgDQo+
PiBhbnl0aGluZyBzcGVjaWZpYyBpbiB0aGUgaGlzdG9yeS4gVGhlIGNvbW1pdCBtZW50aW9uZWQg
YWJvdmUgcmVtb3ZlZCANCj4+IHRoZSB1c2VyIG9mIHRoZSAndmFsJyBjb2RlIGJ1dCB3aXRob3V0
IHJlbW92aW5nIHRoaXMgYmxvY2sgb2YgY29kZS4NCj4+DQo+PiBXaGVuIGxvb2tpbmcgYXQgdGhl
IGN1cnJlbnQgY29kZSwgaXQgcmVhbGx5IGxvb2tzIGxpa2UgYW4gb3ZlcnNpZ2h0Lg0KPiANCj4g
WWVzIHNvIGl0IHNlZW1zLg0KPiANCj4+IFRoZXJlIGlzIG5vdGhpbmcgaW4gdGhlIGNvbW1pdCdz
IGNoYW5nZWxvZyByZWZlcnJpbmcgdG8gYSBuZWVkIG9mIA0KPj4gcmVhZGluZyB0aGUgY291bnRl
ciByZWdpc3RlciBidXQgcGVyaGFwcyBJJ20gd3JvbmcgYmVjYXVzZSBJJ20gbm90IA0KPj4gc3Vy
ZSB0byB1bmRlcnN0YW5kIGNvcnJlY3RseSB0aGUgY2hhbmdlbG9nLg0KPj4NCj4+PiBMb3RzIG9m
IGhhcmR3YXJlIGRvZXMgbmVlZCB0aGlzLCBoYXZlIHlvdSB0ZXN0ZWQgdGhpcz8NCj4gDQo+IEkg
anVzdCB0ZXN0ZWQgdGhpcyBvbiBvbWFwMyBsb2dpY3BkIHRvcnBlZG8gZGV2a2l0IHRoYXQgY2Fu
IGRvIG9mZiANCj4gZHVyaW5nIGlkbGUgYW5kIHJlYWRpbmcgL3N5cy9jbGFzcy90aGVybWFsL3Ro
ZXJtYWxfem9uZTAvdGVtcCB3b3Jrcy4gDQo+IFNvIGZlZWwgZnJlZSB0byBhZGQ6DQo+IA0KPiBS
ZXZpZXdlZC1ieTogVG9ueSBMaW5kZ3JlbiA8dG9ueUBhdG9taWRlLmNvbT4NCj4gVGVzdGVkLWJ5
OiBUb255IExpbmRncmVuIDx0b255QGF0b21pZGUuY29tPg0KDQpUaGFua3MgZm9yIHRlc3RpbmcN
Cg0KDQotLQ0KPGh0dHA6Ly93d3cubGluYXJvLm9yZy8+IExpbmFyby5vcmcg4pSCIE9wZW4gc291
cmNlIHNvZnR3YXJlIGZvciBBUk0gU29Dcw0KDQpGb2xsb3cgTGluYXJvOiAgPGh0dHA6Ly93d3cu
ZmFjZWJvb2suY29tL3BhZ2VzL0xpbmFybz4gRmFjZWJvb2sgfCA8aHR0cDovL3R3aXR0ZXIuY29t
LyMhL2xpbmFyb29yZz4gVHdpdHRlciB8IDxodHRwOi8vd3d3LmxpbmFyby5vcmcvbGluYXJvLWJs
b2cvPiBCbG9nDQo=
