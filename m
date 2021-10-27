Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0486A43C680
	for <lists+linux-pm@lfdr.de>; Wed, 27 Oct 2021 11:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241071AbhJ0Jg1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Oct 2021 05:36:27 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:41360 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232422AbhJ0Jg0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Oct 2021 05:36:26 -0400
X-UUID: 7142935703c04a87bb2589d37135c67a-20211027
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=f5bv2fIAVTo8g215AUeOscF0bRtQ+IqfCg8Dqh6s7F8=;
        b=Ht1rMwasipyBtLD0pZr6lCVxdUvE5Cch+kRHS12jmppqDQ4At/W0Nn003/yqKSZyae49QLWmFXLZb6vCYIIEC2eRHe8EdkGmfcEVE0TJ9OfhVY5Uu8mQ/qdehkW9UM/OUa3m092Eu1DvEFxYhWLgN/k8ypS7FZ/tsxhI7SOmoh8=;
X-UUID: 7142935703c04a87bb2589d37135c67a-20211027
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1806796620; Wed, 27 Oct 2021 17:34:00 +0800
Received: from MTKMBS34N1.mediatek.inc (172.27.4.172) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 27 Oct 2021 17:33:58 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS34N1.mediatek.inc
 (172.27.4.172) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 27 Oct
 2021 17:33:41 +0800
Received: from mhfsdcap04 (10.17.3.154) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 27 Oct 2021 17:33:40 +0800
Message-ID: <fba3246fbc600f06eb40e90283c1cd51bc259804.camel@mediatek.com>
Subject: Re: [PATCH v4 1/3] PM / wakeirq: support enabling wake-up irq after
 runtime_suspend called
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Linux PM" <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Date:   Wed, 27 Oct 2021 17:33:39 +0800
In-Reply-To: <CAJZ5v0gb6vN9kHeQbgjRQXvOCNaFK8ur7bLDeAVjDqdT2=a+-g@mail.gmail.com>
References: <20211025070155.2995-1-chunfeng.yun@mediatek.com>
         <CAJZ5v0gb6vN9kHeQbgjRQXvOCNaFK8ur7bLDeAVjDqdT2=a+-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gVHVlLCAyMDIxLTEwLTI2IGF0IDE3OjM5ICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gT24gTW9uLCBPY3QgMjUsIDIwMjEgYXQgOTowMiBBTSBDaHVuZmVuZyBZdW4gPA0KPiBj
aHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPiB3cm90ZToNCj4gPiANCj4gPiBXaGVuIHRoZSBkZWRp
Y2F0ZWQgd2FrZSBJUlEgaXMgbGV2ZWwgdHJpZ2dlciwgYW5kIGl0IHVzZXMgdGhlDQo+ID4gZGV2
aWNlJ3MgbG93LXBvd2VyIHN0YXR1cyBhcyB0aGUgd2FrZXVwIHNvdXJjZSwgdGhhdCBtZWFucyBp
ZiB0aGUNCj4gPiBkZXZpY2UgaXMgbm90IGluIGxvdy1wb3dlciBzdGF0ZSwgdGhlIHdha2UgSVJR
IHdpbGwgYmUgdHJpZ2dlcmVkDQo+ID4gaWYgZW5hYmxlZDsgRm9yIHRoaXMgY2FzZSwgbmVlZCBl
bmFibGUgdGhlIHdha2UgSVJRIGFmdGVyIHJ1bm5pbmcNCj4gPiB0aGUgZGV2aWNlJ3MgLT5ydW50
aW1lX3N1c3BlbmQoKSB3aGljaCBtYWtlIGl0IGVudGVyIGxvdy1wb3dlcg0KPiA+IHN0YXRlLg0K
PiA+IA0KPiA+IGUuZy4NCj4gPiBBc3N1bWUgdGhlIHdha2UgSVJRIGlzIGEgbG93IGxldmVsIHRy
aWdnZXIgdHlwZSwgYW5kIHRoZSB3YWtldXANCj4gPiBzaWduYWwgY29tZXMgZnJvbSB0aGUgbG93
LXBvd2VyIHN0YXR1cyBvZiB0aGUgZGV2aWNlLg0KPiA+IFRoZSB3YWtldXAgc2lnbmFsIGlzIGxv
dyBsZXZlbCBhdCBydW5uaW5nIHRpbWUgKDApLCBhbmQgYmVjb21lcw0KPiA+IGhpZ2ggbGV2ZWwg
d2hlbiB0aGUgZGV2aWNlIGVudGVycyBsb3ctcG93ZXIgc3RhdGUgKHJ1bnRpbWVfc3VzcGVuZA0K
PiA+ICgxKSBpcyBjYWxsZWQpLCBhIHdha2V1cCBldmVudCBhdCAoMikgbWFrZSB0aGUgZGV2aWNl
IGV4aXQgbG93LQ0KPiA+IHBvd2VyDQo+ID4gc3RhdGUsIHRoZW4gdGhlIHdha2V1cCBzaWduYWwg
YWxzbyBiZWNvbWVzIGxvdyBsZXZlbC4NCj4gPiANCj4gPiAgICAgICAgICAgICAgICAgLS0tLS0t
LS0tLS0tLS0tLS0tDQo+ID4gICAgICAgICAgICAgICAgfCAgICAgICAgICAgXiAgICAgXnwNCj4g
PiAtLS0tLS0tLS0tLS0tLS0tICAgICAgICAgICB8ICAgICB8IC0tLS0tLS0tLS0tLS0tDQo+ID4g
IHw8LS0tKDApLS0tPnw8LS0oMSktLXwgICAoMykgICAoMikgICAgKDQpDQo+ID4gDQo+ID4gaWYg
ZW5hYmxlIHRoZSB3YWtlIElSUSBiZWZvcmUgcnVubmluZyBydW50aW1lX3N1c3BlbmQgZHVyaW5n
ICgwKSwNCj4gPiBhIHdha2UgSVJRIHdpbGwgYXJpc2UsIGl0IGNhdXNlcyByZXN1bWUgaW1tZWRp
YXRlbHk7DQo+ID4gaXQgd29ya3MgaWYgZW5hYmxlIHdha2UgSVJRICggZS5nLiBhdCAoMykgb3Ig
KDQpKSBhZnRlciBydW5uaW5nDQo+ID4gLT5ydW50aW1lX3N1c3BlbmQoKS4NCj4gPiANCj4gPiBU
aGlzIHBhdGNoIGludHJvZHVjZXMgYSBuZXcgc3RhdHVzIFdBS0VfSVJRX0RFRElDQVRFRF9SRVZF
UlNFIHRvDQo+ID4gb3B0aW9uYWxseSBzdXBwb3J0IGVuYWJsaW5nIHdha2UgSVJRIGFmdGVyIHJ1
bm5pbmcNCj4gPiAtPnJ1bnRpbWVfc3VzcGVuZCgpLg0KPiA+IA0KPiA+IFN1Z2dlc3RlZC1ieTog
UmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCj4gDQo+
IEkgZG9uJ3QgcmVhbGx5IGhhdmUgYW55dGhpbmcgdG8gYWRkIHJlZ2FyZGluZyB0aGUgY29kZS4N
Cj4gDQo+IFRoZSBrZXJuZWxkb2MgY29tbWVudHMgY291bGQgYmUgaW1wcm92ZWQsIGJ1dCBJIGNh
biB0YWtlIGNhcmUgb2YgdGhpcw0KPiB3aGVuIGFwcGx5aW5nIHRoZSBwYXRjaC4NCk9rLCB0aGFu
a3MNCj4gDQo+IFBsZWFzZSBjb2xsZWN0IEFDS3MgZm9yIHRoZSByZW1haW5pbmcgMiBwYXRjaGVz
IGluIHRoZSBzZXJpZXMgYW5kIEkNCj4gd2lsbCBwaWNrIHVwIGFsbCB0aHJlZS4NClRoZSBmaWxl
cyAobXR1M19wbGF0LmMsIHhoY2ktbXRrLmMpIG1vZGlmaWVkIGJ5IG90aGVyIDIgcGF0Y2hlcyBh
cmUNCm1haW50YWluZWQgYnkgbXlzZWxmLCBwbGVhc2UgcGljayB1cCB0aGVtLCB0aGFua3MgYSBs
b3QuDQoNCj4gDQo+IFRoYW5rcyENCj4gDQo+ID4gLS0tDQo+ID4gdjQ6IGNoYW5nZXMgYWNjb3Jk
aW5nIHRvIFJhZmFlbCdzIHN1Z2dlc3Rpb25zDQo+ID4gICAgIDEuIHJlbmFtZSBuZXcgZmxhZyBh
cyBXQUtFX0lSUV9ERURJQ0FURURfUkVWRVJTRTsNCj4gPiAgICAgMi4gYWRkIF9fZGV2X3BtX3Nl
dF9kZWRpY2F0ZWRfd2FrZV9pcnEoKSB3aXRoIGZsYWcgcGFyYW1ldGVyLA0KPiA+IHRoZW4NCj4g
PiAgICAgICAgcmVidWlsZCBkZXZfcG1fc2V0X2RlZGljYXRlZF93YWtlX2lycSgpIGFuZCBhZGQg
bmV3IGFwaQ0KPiA+ICAgICAgICBkZXZfcG1fc2V0X2RlZGljYXRlZF93YWtlX2lycV9yZXZlcnNl
KCk7DQo+ID4gICAgIDMuIHJlbmFtZSB0aGUgbmV3IGFkZGVkIHBhcmFtZXRlciBhcyBjb25kX2Rp
c2FibGUgaW4NCj4gPiAgICAgICAgZGV2X3BtX2Rpc2FibGVfd2FrZV9pcnFfY2hlY2soKSwgYW5k
IGFsc28gc2ltcGxpZnkgaXRzIGZsb3c7DQo+ID4gICAgIDQuIG1vZGlmeSBzb21lIGNvbW1lbnRz
DQo+ID4gDQo+ID4gdjM6IGFkZCBuZXcgc3RhdHVzIHN1Z2dlc3RlZCBieSBSYWZhZWwNCj4gPiAN
Cj4gPiB2MjogYWRkIG1vcmUgY29tbWl0IG1lc3NhZ2UNCj4gPiANCj4gPiAgIFVzZSB0aGUgZmFs
bGluZyBlZGdlIHRyaWdnZXIgaW50ZXJydXB0IHN1Z2dlc3RlZCBieSBJa2pvb24gWzFdLA0KPiA+
IGl0DQo+ID4gd29ya3Mgd2VsbCBhdCBmaXJzdGx5IHdoZW4gb25seSB1c2UgdGhpcyByZWxhdGVk
IHdha2V1cCBzb3VyY2UsIGJ1dA0KPiA+IGVuY291bnRlciBpc3N1ZXMgaWYgdXNlIG90aGVyIHdh
a2V1cCBzb3VyY2VzIHRvIHdha2V1cCBwbGF0Zm9ybSBhcw0KPiA+IGJlbG93IHN0ZXBzOg0KPiA+
IDEuIHVzZSBhbm90aGVyIHdha2V1cCBzb3VyY2UgdG8gd2FrZSB1cCB0aGUgc3VzcGVuZGVkIHN5
c3RlbTsNCj4gPiAyLiB0aGUgY29uc3VtZXIncyByZXN1bWUoKSB3aWxsIGJlIGNhbGxlZCwgYW5k
IGV4aXRzIHNsZWVwIHN0YXRlOw0KPiA+IDMuIHRoZSBjb25zdW1lcidzIHdha2V1cCBzaWduYWwg
d2lsbCBmYWxsIGludG8gbG93IGxldmVsLCBkdWUgdG8NCj4gPiAgICBjdXJyZW50bHkgdGhlIHdh
a2V1cCBpcnEgaXMgZGlzYWJsZWQsIHRoZSB3YWtlLWlycSBpcyBwZW5kaW5nOw0KPiA+IDQuIHRo
ZSBjb25zdW1lciB0cmllcyB0byBlbnRlciBydW50aW1lIHN1c3BlbmQsIGJ1dCB0aGVyZSBpcyBh
DQo+ID4gICAgcGVuZGluZyB3YWtldXAgaXJxLCBzbyB3aWxsIHJlc3VtZSBhZ2FpbiwgdGhpcyB3
aWxsIHJlcGVhdA0KPiA+ICAgIGVuZGxlc3NseS4NCj4gPiANCj4gPiAgIFNlbmQgb3V0IHRoZSBw
YXRjaCBhZ2FpbiBmb3IgZnVydGhlciBkaXNjdXNzaW9uLg0KPiA+IA0KPiA+IFsxXTogaHR0cHM6
Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMjE5MDQwNw0KPiA+IA0KPiA+IC0tLQ0KPiA+
ICBkcml2ZXJzL2Jhc2UvcG93ZXIvcG93ZXIuaCAgIHwgICA3ICsrLQ0KPiA+ICBkcml2ZXJzL2Jh
c2UvcG93ZXIvcnVudGltZS5jIHwgICA2ICsrLQ0KPiA+ICBkcml2ZXJzL2Jhc2UvcG93ZXIvd2Fr
ZWlycS5jIHwgMTAxICsrKysrKysrKysrKysrKysrKysrKysrKysrKy0tDQo+ID4gLS0tLS0tDQo+
ID4gIGluY2x1ZGUvbGludXgvcG1fd2FrZWlycS5oICAgfCAgIDkgKysrLQ0KPiA+ICA0IGZpbGVz
IGNoYW5nZWQsIDk2IGluc2VydGlvbnMoKyksIDI3IGRlbGV0aW9ucygtKQ0KWy4uLl0NCj4gPiAN
Cg==

