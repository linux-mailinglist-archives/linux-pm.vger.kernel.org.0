Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0DF3CF3F4
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jul 2021 07:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343687AbhGTEqc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Jul 2021 00:46:32 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:48691 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1343532AbhGTEq3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Jul 2021 00:46:29 -0400
X-UUID: 3ce759d290a240e18e0ae8f18e8c371c-20210720
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=zIpik6hQDWaGC/2nFu39BaoEG37VtqOoY4AV0DzRV20=;
        b=n5qZoeAq8L7eij4UPytgSrfXNsEHMT6B00QfFvqVl2RXkKaMOFWbWN3mNJEKkcLC2GwqY9D6nPQHz1Ptkw3QfUpgvHJTjGdVAbrBbvNBfZqlx6N5hgY8Z0h9PCdlAyc6e2yItVHMOpRC1XjYtAVutXenQA9P1sF5ZEt7RCX05qE=;
X-UUID: 3ce759d290a240e18e0ae8f18e8c371c-20210720
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 967978126; Tue, 20 Jul 2021 13:27:05 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32N2.mediatek.inc
 (172.27.4.72) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 20 Jul
 2021 13:26:58 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 20 Jul 2021 13:26:58 +0800
Message-ID: <1626758818.4247.0.camel@mhfsdcap03>
Subject: Re: [PATCH v2] PM: runtime: enable wake irq after runtime_suspend
 hook called
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ikjoon Jang <ikjn@chromium.org>,
        "Tony Lindgren" <tony@atomide.com>
Date:   Tue, 20 Jul 2021 13:26:58 +0800
In-Reply-To: <CAJZ5v0iH7D=D70ea7Q0LqP0iUdRYPf4GH2g7dC7J2_54WW1C8A@mail.gmail.com>
References: <1626427381-30131-1-git-send-email-chunfeng.yun@mediatek.com>
         <CAJZ5v0iH7D=D70ea7Q0LqP0iUdRYPf4GH2g7dC7J2_54WW1C8A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: B75593554F78E799DF0F2B58C24AF4BD7A55A65701F1E2F16AF9C5BA25CC284B2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gRnJpLCAyMDIxLTA3LTE2IGF0IDE0OjUyICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gT24gRnJpLCBKdWwgMTYsIDIwMjEgYXQgMTE6MjMgQU0gQ2h1bmZlbmcgWXVuIDxjaHVu
ZmVuZy55dW5AbWVkaWF0ZWsuY29tPiB3cm90ZToNCj4gPg0KPiA+IFdoZW4gdGhlIGRlZGljYXRl
ZCB3YWtlLWlycSBpcyBsZXZlbCB0cmlnZ2VyLCBhbmQgaXQgdXNlcyB0aGUNCj4gPiBjb25zdW1l
cidzIHNsZWVwIHN0YXR1cyBhcyB0aGUgd2FrZXVwIHNvdXJjZSwNCj4gDQo+IFRoaXMgaXMgbm90
IGEgdHlwaWNhbCBjYXNlLCB0aG91Z2gsIEFGQUlDUy4NCj4gDQo+IFNvIHlvdSBzZWVtIHRvIGhh
dmUgYSBzcGVjaWFsIHJlcXVpcmVtZW50IGFuZCB5b3Ugd2FudCB0byBjaGFuZ2UgYQ0KPiBnZW5l
cmljIGZyYW1ld29yayBpbiBhbiBpbmNvbXBhdGlibGUgd2F5IHRvIGFjY29tbW9kYXRlIGl0Lg0K
PiANCj4gPiB0aGF0IG1lYW5zIGlmIHRoZQ0KPiA+IGNvbnN1bWVyIGlzIG5vdCBpbiBzbGVlcCBz
dGF0ZSwgdGhlIHdha2UtaXJxIHdpbGwgYmUgdHJpZ2dlcmVkDQo+ID4gd2hlbiBlbmFibGUgaXQ7
IEZvciB0aGlzIGNhc2UsIG5lZWQgZW5hYmxlIHRoZSB3YWtlLWlycSBhZnRlcg0KPiA+IGludm9r
aW5nIHRoZSBjb25zdW1lcidzIHJ1bnRpbWVfc3VzcGVuZCgpIHdoaWNoIG1ha2UgdGhlIGNvbnN1
bWVyDQo+ID4gZW50ZXIgc2xlZXAgc3RhdGUuDQo+ID4NCj4gPiBlLmcuDQo+ID4gQXNzdW1lIHRo
ZSB3YWtlLWlycSBpcyBhIGxvdyBsZXZlbCB0cmlnZ2VyIHR5cGUsIGFuZCB0aGUgd2FrZXVwDQo+
ID4gc2lnbmFsIGNvbWVzIGZyb20gdGhlIHNsZWVwIHN0YXR1cyBvZiBjb25zdW1lci4NCj4gPiBU
aGUgd2FrZXVwIHNpZ25hbCBpcyBsb3cgbGV2ZWwgYXQgcnVubmluZyB0aW1lICgwKSwgYW5kIGJl
Y29tZXMNCj4gPiBoaWdoIGxldmVsIHdoZW4gdGhlIGNvbnN1bWVyIGVudGVycyBzbGVlcCBzdGF0
ZSAocnVudGltZV9zdXNwZW5kDQo+ID4gKDEpIGlzIGNhbGxlZCksIGEgd2FrZXVwIGV2ZW50IGF0
ICgyKSBtYWtlIHRoZSBjb25zdW1lciBleGl0IHNsZWVwDQo+ID4gc3RhdGUsIHRoZW4gdGhlIHdh
a2V1cCBzaWduYWwgYWxzbyBiZWNvbWVzIGxvdyBsZXZlbC4NCj4gPg0KPiA+ICAgICAgICAgICAg
ICAgICAtLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAgICAgICAgICAgICAgICB8ICAgICAgICAgICBe
ICAgICBefA0KPiA+IC0tLS0tLS0tLS0tLS0tLS0gICAgICAgICAgIHwgICAgIHwgLS0tLS0tLS0t
LS0tLS0NCj4gPiAgfDwtLS0oMCktLS0+fDwtLSgxKS0tfCAgICgzKSAgICgyKSAgICAoNCkNCj4g
Pg0KPiA+IGlmIGVuYWJsZSB0aGUgd2FrZS1pcnEgYmVmb3JlIGNhbGxpbmcgcnVudGltZV9zdXNw
ZW5kIGR1cmluZyAoMCksDQo+ID4gYW4gaW50ZXJydXB0IHdpbGwgYXJpc2UsIGl0IGNhdXNlcyBy
ZXN1bWUgaW1tZWRpYXRlbHk7DQo+ID4gaXQgd29ya3MgaWYgZW5hYmxlIHdha2UtaXJxICggZS5n
LiBhdCAoMykgb3IgKDQpKSBhZnRlciBjYWxsaW5nDQo+ID4gcnVudGltZV9zdXNwZW5kLg0KPiA+
DQo+ID4gSW4gdGhpcyBleGFtcGxlLCBjYW4ndCBmaXggaXQgYnkgdXNpbmcgZmFsbGluZyBlZGdl
IHRyaWdnZXIgd2l0aG91dA0KPiA+IHRoaXMgcGF0Y2gsIHRoZSBpc3N1ZSB3aWxsIGhhcHBlbiBh
cyBiZWxvdyBzdGVwczoNCj4gPiAxLiB1c2UgYW5vdGhlciB3YWtldXAgc291cmNlIHRvIHdha2Ug
dXAgdGhlIHN1c3BlbmRlZCBzeXN0ZW07DQo+ID4gMi4gdGhlIGNvbnN1bWVyJ3MgcmVzdW1lKCkg
d2lsbCBiZSBjYWxsZWQsIGFuZCBleGl0cyBzbGVlcCBzdGF0ZTsNCj4gPiAzLiB0aGUgY29uc3Vt
ZXIncyB3YWtldXAgc2lnbmFsIHdpbGwgZmFsbCBpbnRvIGxvdyBsZXZlbCwgZHVlIHRvDQo+ID4g
ICAgY3VycmVudGx5IHRoZSB3YWtldXAgaXJxIGlzIGRpc2FibGVkLCB0aGUgd2FrZS1pcnEgaXMg
cGVuZGluZzsNCj4gPiA0LiB0aGUgY29uc3VtZXIgdHJpZXMgdG8gZW50ZXIgcnVudGltZSBzdXNw
ZW5kLCBidXQgdGhlcmUgaXMgYQ0KPiA+ICAgIHBlbmRpbmcgd2FrZXVwIGlycSwgc28gd2lsbCBy
ZXN1bWUgYWdhaW4sIHRoaXMgd2lsbCByZXBlYXQNCj4gPiAgICBlbmRsZXNzbHkuDQo+ID4NCj4g
PiBUaGlzIHBhdGNoIHNlZW1zIG5vIHNpZGUgZWZmZWN0IG9uIGVkZ2UgdHJpZ2dlciB3YWtlLWly
cSB0aGF0IHdvcmtzDQo+ID4gYmVmb3JlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQ2h1bmZl
bmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+IHYyOiBhZGQg
bW9yZSBjb21taXQgbWVzc2FnZQ0KPiA+DQo+ID4gICBJIHVzZSB0aGUgZmFsbGluZyBlZGdlIHRy
aWdnZXIgaW50ZXJydXB0IHN1Z2dlc3RlZCBieSBJa2pvb24gWzFdLCBpdA0KPiA+IHdvcmtzIHdl
bGwgYXQgZmlyc3RseSB3aGVuIG9ubHkgdXNlIHRoaXMgcmVsYXRlZCB3YWtldXAgc291cmNlLCBi
dXQNCj4gPiBlbmNvdW50ZXIgaXNzdWVzIGlmIHVzZSBvdGhlciB3YWtldXAgc291cmNlcyB0byB3
YWtldXAgcGxhdGZvcm0gYXMNCj4gPiBkZXNjcmliZWQgaW4gY29tbWl0IG1lc3NhZ2UuDQo+ID4g
ICBTZW5kIG91dCB0aGUgcGF0Y2ggYWdhaW4gZm9yIGZ1cnRoZXIgZGlzY3Vzc2lvbi4NCj4gPg0K
PiA+IFsxXTogaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMjE5MDQwNw0KPiA+
DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvYmFzZS9wb3dlci9ydW50aW1lLmMgfCA1ICsrLS0tDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9iYXNlL3Bvd2VyL3J1bnRpbWUuYyBiL2RyaXZlcnMv
YmFzZS9wb3dlci9ydW50aW1lLmMNCj4gPiBpbmRleCA4YTY2ZWFmNzMxZTQuLjkwYTkxYjJiMTM2
NCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2Jhc2UvcG93ZXIvcnVudGltZS5jDQo+ID4gKysr
IGIvZHJpdmVycy9iYXNlL3Bvd2VyL3J1bnRpbWUuYw0KPiA+IEBAIC02MzksMTIgKzYzOSwxMiBA
QCBzdGF0aWMgaW50IHJwbV9zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldiwgaW50IHJwbWZsYWdz
KQ0KPiA+ICAgICAgICAgX191cGRhdGVfcnVudGltZV9zdGF0dXMoZGV2LCBSUE1fU1VTUEVORElO
Ryk7DQo+ID4NCj4gPiAgICAgICAgIGNhbGxiYWNrID0gUlBNX0dFVF9DQUxMQkFDSyhkZXYsIHJ1
bnRpbWVfc3VzcGVuZCk7DQo+ID4gLQ0KPiA+IC0gICAgICAgZGV2X3BtX2VuYWJsZV93YWtlX2ly
cV9jaGVjayhkZXYsIHRydWUpOw0KPiANCj4gSSB3b3VsZCBzdWdnZXN0IGFkZGluZyBhIHdha2Ug
SVJRIGZsYWcgdG8gaW5kaWNhdGUgdGhhdCBpdCBuZWVkcw0KPiBzcGVjaWFsIGhhbmRsaW5nIGFu
ZCBtb2RpZnlpbmcgdGhlIGFib3ZlIHRvIHRha2UgdGhhdCBuZXcgZmxhZyBpbnRvDQo+IGFjY291
bnQuDQo+IA0KPiA+ICAgICAgICAgcmV0dmFsID0gcnBtX2NhbGxiYWNrKGNhbGxiYWNrLCBkZXYp
Ow0KPiA+ICAgICAgICAgaWYgKHJldHZhbCkNCj4gPiAgICAgICAgICAgICAgICAgZ290byBmYWls
Ow0KPiA+DQo+ID4gKyAgICAgICBkZXZfcG1fZW5hYmxlX3dha2VfaXJxX2NoZWNrKGRldiwgdHJ1
ZSk7DQo+IA0KPiBUaGVuLCB5b3UgY2FuIGFkZCBhbiBlbnRpcmVseSBuZXcgY2FsbCBoZXJlLCBz
YXkNCj4gZGV2X3BtX2VuYWJsZV93YWtlX2lycV9jb21wbGV0ZShkZXYpLCB0aGF0IHdpbGwgZG8g
dGhlIGFjdHVhbCBlbmFibGUNCj4gZm9yIHRoZSB3YWtlIElSUXMgd2l0aCB0aGUgbmV3IGZsYWcg
c2V0IGFuZCBub3RoaW5nIGZvciB0aGUgb3RoZXJzLg0KPiANCj4gPiArDQo+ID4gICBub19jYWxs
YmFjazoNCj4gPiAgICAgICAgIF9fdXBkYXRlX3J1bnRpbWVfc3RhdHVzKGRldiwgUlBNX1NVU1BF
TkRFRCk7DQo+ID4gICAgICAgICBwbV9ydW50aW1lX2RlYWN0aXZhdGVfdGltZXIoZGV2KTsNCj4g
PiBAQCAtNjkwLDcgKzY5MCw2IEBAIHN0YXRpYyBpbnQgcnBtX3N1c3BlbmQoc3RydWN0IGRldmlj
ZSAqZGV2LCBpbnQgcnBtZmxhZ3MpDQo+ID4gICAgICAgICByZXR1cm4gcmV0dmFsOw0KPiA+DQo+
ID4gICBmYWlsOg0KPiA+IC0gICAgICAgZGV2X3BtX2Rpc2FibGVfd2FrZV9pcnFfY2hlY2soZGV2
KTsNCj4gDQo+IEFuZCBvYnZpb3VzbHkgdGhpcyB3aWxsIHJlYWxseSBkaXNhYmxlIHdha2UgSVJR
cyB3aXRoIHRoZSBuZXcgZmxhZyB1bnNldCBvbmx5Lg0KDQpPaywgSSdsbCB0cnkgaXQsIHRoYW5r
cyBhIGxvdA0KDQo+IA0KPiA+ICAgICAgICAgX191cGRhdGVfcnVudGltZV9zdGF0dXMoZGV2LCBS
UE1fQUNUSVZFKTsNCj4gPiAgICAgICAgIGRldi0+cG93ZXIuZGVmZXJyZWRfcmVzdW1lID0gZmFs
c2U7DQo+ID4gICAgICAgICB3YWtlX3VwX2FsbCgmZGV2LT5wb3dlci53YWl0X3F1ZXVlKTsNCj4g
PiAtLQ0KPiA+IDIuMTguMA0KPiA+DQoNCg==

