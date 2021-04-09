Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E42535982B
	for <lists+linux-pm@lfdr.de>; Fri,  9 Apr 2021 10:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbhDIIni (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Apr 2021 04:43:38 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:14290 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232026AbhDIInh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Apr 2021 04:43:37 -0400
X-UUID: faead521e2584fada37d7afbfb6406cf-20210409
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=LWR0YYJF62R73X/2PazKkQVUbwMvHOS/MQ9V7awNAws=;
        b=B/IYe5BxeZB+RaN6vk7LP2paPDef9IxtAnnv/pGluFjyxDFjXjhwTu6ffQkZQ7k8XlcJYRQpTaoxn0OgmYYKiubmVARzjz70nq1FNxTl7Feww7ZmK1MyZyQ1q3J5aZ4AI8jR1p8xLG/OPSGSA5dBDF5E8ic4D9dJvuepBZbyd/M=;
X-UUID: faead521e2584fada37d7afbfb6406cf-20210409
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 328637584; Fri, 09 Apr 2021 16:43:21 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 9 Apr
 2021 16:43:19 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 9 Apr 2021 16:43:19 +0800
Message-ID: <1617957799.12105.31.camel@mhfsdcap03>
Subject: Re: [PATCH 1/6] PM: runtime: enable wake irq after runtime_suspend
 hook called
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Ikjoon Jang <ikjn@chromium.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        <linux-usb@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, Tony Lindgren <tony@atomide.com>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>
Date:   Fri, 9 Apr 2021 16:43:19 +0800
In-Reply-To: <CAATdQgCQ5Gm1CNEbVgLFiFcgDX0yP5G=48Fa29WYbpSuz25WXg@mail.gmail.com>
References: <1617874514-12282-1-git-send-email-chunfeng.yun@mediatek.com>
         <CAATdQgCQ5Gm1CNEbVgLFiFcgDX0yP5G=48Fa29WYbpSuz25WXg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 7CFDA8CB831F2DE86455E79C381B3FB824379DAED8D4FA5615EB49D1A8F27F8D2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gRnJpLCAyMDIxLTA0LTA5IGF0IDEzOjMyICswODAwLCBJa2pvb24gSmFuZyB3cm90ZToNCj4g
SGkgQ2h1bmZlbmcsDQo+IA0KPiBPbiBUaHUsIEFwciA4LCAyMDIxIGF0IDU6MzUgUE0gQ2h1bmZl
bmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPiB3cm90ZToNCj4gPg0KPiA+IFdoZW4g
dGhlIGRlZGljYXRlZCB3YWtlIGlycSBpcyBsZXZlbCB0cmlnZ2VyLCBlbmFibGUgaXQgYmVmb3Jl
DQo+ID4gY2FsbGluZyBydW50aW1lX3N1c3BlbmQsIHdpbGwgdHJpZ2dlciBhbiBpbnRlcnJ1cHQu
DQo+ID4NCj4gPiBlLmcuDQo+ID4gZm9yIGEgbG93IGxldmVsIHRyaWdnZXIgdHlwZSwgaXQncyBs
b3cgbGV2ZWwgYXQgcnVubmluZyB0aW1lICgwKSwNCj4gPiBhbmQgYmVjb21lcyBoaWdoIGxldmVs
IHdoZW4gZW50ZXJzIHN1c3BlbmQgKHJ1bnRpbWVfc3VzcGVuZCAoMSkgaXMNCj4gPiBjYWxsZWQp
LCBhIHdha2V1cCBzaWduYWwgYXQgKDIpIG1ha2UgaXQgYmVjb21lIGxvdyBsZXZlbCwgd2FrZSBp
cnENCj4gPiB3aWxsIGJlIHRyaWdnZXJlZC4NCj4gPg0KPiA+ICAgICAgICAgICAgICAgICAtLS0t
LS0tLS0tLS0tLS0tLS0NCj4gPiAgICAgICAgICAgICAgICB8ICAgICAgICAgICBeICAgICBefA0K
PiA+IC0tLS0tLS0tLS0tLS0tLS0gICAgICAgICAgIHwgICAgIHwgLS0tLS0tLS0tLS0tLS0NCj4g
PiAgfDwtLS0oMCktLS0+fDwtLSgxKS0tfCAgICgzKSAgICgyKSAgICAoNCkNCj4gPg0KPiANCj4g
Q2FuJ3Qgd2UganVzdCB1c2UgYSBmYWxsaW5nIGVkZ2UgdHlwZSBmb3IgdGhpcyBpcnEgbGluZT8N
CkknbGwgdHJ5IGl0LCBidXQgdGhlIG9yaWdpbmFsIGNvZGUgc3RpbGwgZG9lc24ndCBwcm9jZXNz
IGFib3ZlIG1lbnRpb25lZA0KY2FzZS4NCg0KPiANCj4gPiBpZiB3ZSBlbmFibGUgdGhlIHdha2Ug
aXJxIGJlZm9yZSBjYWxsaW5nIHJ1bnRpbWVfc3VzcGVuZCBkdXJpbmcgKDApLA0KPiA+IGFuIGlu
dGVycnVwdCB3aWxsIGFyaXNlLCBpdCBjYXVzZXMgcmVzdW1lIGltbWVkaWF0ZWx5Ow0KPiA+IGVu
YWJsZSB3YWtlIGlycSBhZnRlciBjYWxsaW5nIHJ1bnRpbWVfc3VzcGVuZCwgZS5nLiBhdCAoMykg
b3IgKDQpLA0KPiA+IHdpbGwgd29ya3MuDQo+ID4NCj4gPiBUaGlzIHBhdGNoIHNlZW1zIG5vIHNp
ZGUgZWZmZWN0IG9uIGVkZ2UgdHJpZ2dlciB3YWtlIGlycS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4g
PiAgZHJpdmVycy9iYXNlL3Bvd2VyL3J1bnRpbWUuYyB8IDUgKystLS0NCj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2Jhc2UvcG93ZXIvcnVudGltZS5jIGIvZHJpdmVycy9iYXNlL3Bvd2VyL3J1
bnRpbWUuYw0KPiA+IGluZGV4IGE0NmE3ZTMwODgxYi4uNzk2NzM5YTAxNWE1IDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvYmFzZS9wb3dlci9ydW50aW1lLmMNCj4gPiArKysgYi9kcml2ZXJzL2Jh
c2UvcG93ZXIvcnVudGltZS5jDQo+ID4gQEAgLTYxOSwxMiArNjE5LDEyIEBAIHN0YXRpYyBpbnQg
cnBtX3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2LCBpbnQgcnBtZmxhZ3MpDQo+ID4gICAgICAg
ICBfX3VwZGF0ZV9ydW50aW1lX3N0YXR1cyhkZXYsIFJQTV9TVVNQRU5ESU5HKTsNCj4gPg0KPiA+
ICAgICAgICAgY2FsbGJhY2sgPSBSUE1fR0VUX0NBTExCQUNLKGRldiwgcnVudGltZV9zdXNwZW5k
KTsNCj4gPiAtDQo+ID4gLSAgICAgICBkZXZfcG1fZW5hYmxlX3dha2VfaXJxX2NoZWNrKGRldiwg
dHJ1ZSk7DQo+ID4gICAgICAgICByZXR2YWwgPSBycG1fY2FsbGJhY2soY2FsbGJhY2ssIGRldik7
DQo+ID4gICAgICAgICBpZiAocmV0dmFsKQ0KPiA+ICAgICAgICAgICAgICAgICBnb3RvIGZhaWw7
DQo+ID4NCj4gPiArICAgICAgIGRldl9wbV9lbmFibGVfd2FrZV9pcnFfY2hlY2soZGV2LCB0cnVl
KTsNCj4gPiArDQo+ID4gICBub19jYWxsYmFjazoNCj4gPiAgICAgICAgIF9fdXBkYXRlX3J1bnRp
bWVfc3RhdHVzKGRldiwgUlBNX1NVU1BFTkRFRCk7DQo+ID4gICAgICAgICBwbV9ydW50aW1lX2Rl
YWN0aXZhdGVfdGltZXIoZGV2KTsNCj4gPiBAQCAtNjU5LDcgKzY1OSw2IEBAIHN0YXRpYyBpbnQg
cnBtX3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2LCBpbnQgcnBtZmxhZ3MpDQo+ID4gICAgICAg
ICByZXR1cm4gcmV0dmFsOw0KPiA+DQo+ID4gICBmYWlsOg0KPiA+IC0gICAgICAgZGV2X3BtX2Rp
c2FibGVfd2FrZV9pcnFfY2hlY2soZGV2KTsNCj4gPiAgICAgICAgIF9fdXBkYXRlX3J1bnRpbWVf
c3RhdHVzKGRldiwgUlBNX0FDVElWRSk7DQo+ID4gICAgICAgICBkZXYtPnBvd2VyLmRlZmVycmVk
X3Jlc3VtZSA9IGZhbHNlOw0KPiA+ICAgICAgICAgd2FrZV91cF9hbGwoJmRldi0+cG93ZXIud2Fp
dF9xdWV1ZSk7DQo+ID4gLS0NCj4gPiAyLjE4LjANCj4gPg0KDQo=

