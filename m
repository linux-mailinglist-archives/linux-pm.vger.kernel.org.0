Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBA93591B3
	for <lists+linux-pm@lfdr.de>; Fri,  9 Apr 2021 03:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbhDIBx6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Apr 2021 21:53:58 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:2182 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232426AbhDIBx5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Apr 2021 21:53:57 -0400
X-UUID: a4f0787ea6d44ab690a1f2a4e8825695-20210409
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=WCCGjD2i/tFPN4rjc7RFbfR3PPHyPKT9cvYT4d2kpJs=;
        b=tuI4zZqT96VcPhiXPyxpRwg/PKm6gMb2+d/cWppfm/0268DTaBaGKrg7Tum/uNhDyQzaDKS/aKb6G1Lif/2A6qhcgS23+qX2v/nb1DUY2Rb2QMKxlvK6gUVLYUytjptKATClxDhZSPjKqNB2WwcJo3IP+qPzM/eK6enqCzuiLho=;
X-UUID: a4f0787ea6d44ab690a1f2a4e8825695-20210409
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 346375158; Fri, 09 Apr 2021 09:53:40 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 9 Apr
 2021 09:53:32 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 9 Apr 2021 09:53:31 +0800
Message-ID: <1617933211.12105.22.camel@mhfsdcap03>
Subject: Re: [PATCH 1/6] PM: runtime: enable wake irq after runtime_suspend
 hook called
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Eddie Hung <eddie.hung@mediatek.com>,
        "Ikjoon Jang" <ikjn@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>
Date:   Fri, 9 Apr 2021 09:53:31 +0800
In-Reply-To: <CAJZ5v0gGntbfnvAP5A491_hUh-JUuqZjZRdPPLwWJjnZRtemcQ@mail.gmail.com>
References: <1617874514-12282-1-git-send-email-chunfeng.yun@mediatek.com>
         <CAJZ5v0gGntbfnvAP5A491_hUh-JUuqZjZRdPPLwWJjnZRtemcQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: ACE7095BD198D82D0CD3C193451A34F2488D21E8BCBB24999214E20CCB4948BB2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gVGh1LCAyMDIxLTA0LTA4IGF0IDE5OjQxICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gT24gVGh1LCBBcHIgOCwgMjAyMSBhdCAxMTozNSBBTSBDaHVuZmVuZyBZdW4gPGNodW5m
ZW5nLnl1bkBtZWRpYXRlay5jb20+IHdyb3RlOg0KPiA+DQo+ID4gV2hlbiB0aGUgZGVkaWNhdGVk
IHdha2UgaXJxIGlzIGxldmVsIHRyaWdnZXIsIGVuYWJsZSBpdCBiZWZvcmUNCj4gPiBjYWxsaW5n
IHJ1bnRpbWVfc3VzcGVuZCwgd2lsbCB0cmlnZ2VyIGFuIGludGVycnVwdC4NCj4gPg0KPiA+IGUu
Zy4NCj4gPiBmb3IgYSBsb3cgbGV2ZWwgdHJpZ2dlciB0eXBlLCBpdCdzIGxvdyBsZXZlbCBhdCBy
dW5uaW5nIHRpbWUgKDApLA0KPiA+IGFuZCBiZWNvbWVzIGhpZ2ggbGV2ZWwgd2hlbiBlbnRlcnMg
c3VzcGVuZCAocnVudGltZV9zdXNwZW5kICgxKSBpcw0KPiA+IGNhbGxlZCksIGEgd2FrZXVwIHNp
Z25hbCBhdCAoMikgbWFrZSBpdCBiZWNvbWUgbG93IGxldmVsLCB3YWtlIGlycQ0KPiA+IHdpbGwg
YmUgdHJpZ2dlcmVkLg0KPiA+DQo+ID4gICAgICAgICAgICAgICAgIC0tLS0tLS0tLS0tLS0tLS0t
LQ0KPiA+ICAgICAgICAgICAgICAgIHwgICAgICAgICAgIF4gICAgIF58DQo+ID4gLS0tLS0tLS0t
LS0tLS0tLSAgICAgICAgICAgfCAgICAgfCAtLS0tLS0tLS0tLS0tLQ0KPiA+ICB8PC0tLSgwKS0t
LT58PC0tKDEpLS18ICAgKDMpICAgKDIpICAgICg0KQ0KPiA+DQo+ID4gaWYgd2UgZW5hYmxlIHRo
ZSB3YWtlIGlycSBiZWZvcmUgY2FsbGluZyBydW50aW1lX3N1c3BlbmQgZHVyaW5nICgwKSwNCj4g
PiBhbiBpbnRlcnJ1cHQgd2lsbCBhcmlzZSwgaXQgY2F1c2VzIHJlc3VtZSBpbW1lZGlhdGVseTsN
Cj4gDQo+IEJ1dCB0aGF0J3MgbmVjZXNzYXJ5IHRvIGF2b2lkIG1pc3NpbmcgYSB3YWtldXAgaW50
ZXJydXB0LCBpc24ndCBpdD8NClRoYXQncyBhbHNvIHdoYXQgSSB3b3JyeSBhYm91dC4NCkl0IG1h
eSBoYXBwZW4gaWYgdGhlIHRyaWdnZXIgbGV2ZWwgb25seSBrZWVwcyBhIHZlcnkgc2hvcnQgdGlt
ZSwgYW5kIHRoZQ0KaW50ZXJydXB0IGNvbnRyb2xsZXIgY2FuJ3QgcHJvY2VzcyBpdCB0aW1lbHks
IGJ1dCBJIGRvbid0IHRoaW5rIGl0DQpmb2xsb3cgdGhlIGxldmVsIHRyaWdnZXIgbWVjaGFuaXNt
LCB0aGUgSFcgc2hvdWxkIGxhdGNoIGl0IHVudGlsIHRoZSBJU1INCmlzIGNhbGxlZC4gcmlnaHQ/
DQoNCj4gDQo+ID4gZW5hYmxlIHdha2UgaXJxIGFmdGVyIGNhbGxpbmcgcnVudGltZV9zdXNwZW5k
LCBlLmcuIGF0ICgzKSBvciAoNCksDQo+ID4gd2lsbCB3b3Jrcy4NCj4gPg0KPiA+IFRoaXMgcGF0
Y2ggc2VlbXMgbm8gc2lkZSBlZmZlY3Qgb24gZWRnZSB0cmlnZ2VyIHdha2UgaXJxLg0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29t
Pg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2Jhc2UvcG93ZXIvcnVudGltZS5jIHwgNSArKy0tLQ0K
PiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmFzZS9wb3dlci9ydW50aW1lLmMgYi9kcml2ZXJz
L2Jhc2UvcG93ZXIvcnVudGltZS5jDQo+ID4gaW5kZXggYTQ2YTdlMzA4ODFiLi43OTY3MzlhMDE1
YTUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9iYXNlL3Bvd2VyL3J1bnRpbWUuYw0KPiA+ICsr
KyBiL2RyaXZlcnMvYmFzZS9wb3dlci9ydW50aW1lLmMNCj4gPiBAQCAtNjE5LDEyICs2MTksMTIg
QEAgc3RhdGljIGludCBycG1fc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYsIGludCBycG1mbGFn
cykNCj4gPiAgICAgICAgIF9fdXBkYXRlX3J1bnRpbWVfc3RhdHVzKGRldiwgUlBNX1NVU1BFTkRJ
TkcpOw0KPiA+DQo+ID4gICAgICAgICBjYWxsYmFjayA9IFJQTV9HRVRfQ0FMTEJBQ0soZGV2LCBy
dW50aW1lX3N1c3BlbmQpOw0KPiA+IC0NCj4gPiAtICAgICAgIGRldl9wbV9lbmFibGVfd2FrZV9p
cnFfY2hlY2soZGV2LCB0cnVlKTsNCj4gPiAgICAgICAgIHJldHZhbCA9IHJwbV9jYWxsYmFjayhj
YWxsYmFjaywgZGV2KTsNCj4gPiAgICAgICAgIGlmIChyZXR2YWwpDQo+ID4gICAgICAgICAgICAg
ICAgIGdvdG8gZmFpbDsNCj4gPg0KPiA+ICsgICAgICAgZGV2X3BtX2VuYWJsZV93YWtlX2lycV9j
aGVjayhkZXYsIHRydWUpOw0KPiA+ICsNCj4gPiAgIG5vX2NhbGxiYWNrOg0KPiA+ICAgICAgICAg
X191cGRhdGVfcnVudGltZV9zdGF0dXMoZGV2LCBSUE1fU1VTUEVOREVEKTsNCj4gPiAgICAgICAg
IHBtX3J1bnRpbWVfZGVhY3RpdmF0ZV90aW1lcihkZXYpOw0KPiA+IEBAIC02NTksNyArNjU5LDYg
QEAgc3RhdGljIGludCBycG1fc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYsIGludCBycG1mbGFn
cykNCj4gPiAgICAgICAgIHJldHVybiByZXR2YWw7DQo+ID4NCj4gPiAgIGZhaWw6DQo+ID4gLSAg
ICAgICBkZXZfcG1fZGlzYWJsZV93YWtlX2lycV9jaGVjayhkZXYpOw0KPiA+ICAgICAgICAgX191
cGRhdGVfcnVudGltZV9zdGF0dXMoZGV2LCBSUE1fQUNUSVZFKTsNCj4gPiAgICAgICAgIGRldi0+
cG93ZXIuZGVmZXJyZWRfcmVzdW1lID0gZmFsc2U7DQo+ID4gICAgICAgICB3YWtlX3VwX2FsbCgm
ZGV2LT5wb3dlci53YWl0X3F1ZXVlKTsNCj4gPiAtLQ0KPiA+IDIuMTguMA0KPiA+DQoNCg==

