Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A6B438220
	for <lists+linux-pm@lfdr.de>; Sat, 23 Oct 2021 09:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbhJWHJs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 23 Oct 2021 03:09:48 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:41796 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229446AbhJWHJr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 23 Oct 2021 03:09:47 -0400
X-UUID: 4844edf552944d72a0486fbd59903cee-20211023
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=PmZWJ9UWN+c3zsZcmYLjxNzeeNw+AKsJe5gbnHhBlIk=;
        b=cYUMhTHjv7gFy24lwOS8aGGfq1pffBVHRray+G41xsmt62/xSLhyI6gomPwDNs02TFp7GGsmVSgmMk25ouybsGzhaHSVrxdHvxqGR2pdevPjxHlWyo0dBT2YvtVd5jPxE4UAN8wvtz8QQ8VQcWC50YOJ2VcvU73djB5RVMrFYLw=;
X-UUID: 4844edf552944d72a0486fbd59903cee-20211023
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1273308793; Sat, 23 Oct 2021 15:07:15 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 23 Oct
 2021 15:07:13 +0800
Received: from mhfsdcap04 (10.17.3.154) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 23 Oct 2021 15:07:12 +0800
Message-ID: <ab177213e7aa808b3803cac46146d96a02724425.camel@mediatek.com>
Subject: Re: [PATCH v3 1/2] PM / wakeirq: support enabling wake-up irq after
 runtime_suspend called
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Ikjoon Jang <ikjn@chromium.org>
Date:   Sat, 23 Oct 2021 15:07:12 +0800
In-Reply-To: <df145215a21b67b440405736d9628199ccce2a1b.camel@mediatek.com>
References: <1628651069-22162-1-git-send-email-chunfeng.yun@mediatek.com>
         <CAJZ5v0hTR2mZk7FuUVciX766qq0AwWXFBZoBsV3Sd9ToYuErdQ@mail.gmail.com>
         <df145215a21b67b440405736d9628199ccce2a1b.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 69F60639D0B2889D7551EF1742E782FD3C13CD9681A813A705DCFB5C80DDD6F22000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gU2F0LCAyMDIxLTEwLTIzIGF0IDE0OjM1ICswODAwLCBDaHVuZmVuZyBZdW4gd3JvdGU6DQo+
IE9uIFR1ZSwgMjAyMS0xMC0xOSBhdCAxNzoyOCArMDIwMCwgUmFmYWVsIEouIFd5c29ja2kgd3Jv
dGU6DQo+ID4gT24gV2VkLCBBdWcgMTEsIDIwMjEgYXQgNTowNSBBTSBDaHVuZmVuZyBZdW4gPA0K
PiA+IGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+IHdyb3RlOg0KPiA+ID4gDQo+ID4gPiBXaGVu
IHRoZSBkZWRpY2F0ZWQgd2FrZS1pcnEgaXMgbGV2ZWwgdHJpZ2dlciwgYW5kIGl0IHVzZXMgdGhl
DQo+ID4gPiBjb25zdW1lcidzIHNsZWVwIHN0YXR1cyBhcyB0aGUgd2FrZXVwIHNvdXJjZSwgdGhh
dCBtZWFucyBpZiB0aGUNCj4gPiA+IGNvbnN1bWVyIGlzIG5vdCBpbiBzbGVlcCBzdGF0ZSwgdGhl
IHdha2UtaXJxIHdpbGwgYmUgdHJpZ2dlcmVkDQo+ID4gPiB3aGVuIGVuYWJsZSBpdDsgRm9yIHRo
aXMgY2FzZSwgbmVlZCBlbmFibGUgdGhlIHdha2UtaXJxIGFmdGVyDQo+ID4gPiBpbnZva2luZyB0
aGUgY29uc3VtZXIncyBydW50aW1lX3N1c3BlbmQoKSB3aGljaCBtYWtlIHRoZSBjb25zdW1lcg0K
PiA+ID4gZW50ZXIgc2xlZXAgc3RhdGUuDQo+ID4gWy4uLl0NCj4gDQo+IElmIHdhbnQgdG8gbWFr
ZSBpdCBzdGF0aWMsIHNob3VsZCBtb3ZlIGl0IGZyb20gd2FrZWlycS5jIGludG8NCj4gcnVudGlt
ZS5jDQo+IA0KPiA+IA0KPiA+ID4gIHsNCj4gPiA+ICAgICAgICAgc3RydWN0IHdha2VfaXJxICp3
aXJxID0gZGV2LT5wb3dlci53YWtlaXJxOw0KPiA+ID4gDQo+ID4gPiAgICAgICAgIGlmICghd2ly
cSB8fCAhKHdpcnEtPnN0YXR1cyAmIFdBS0VfSVJRX0RFRElDQVRFRF9NQVNLKSkNCj4gPiA+ICAg
ICAgICAgICAgICAgICByZXR1cm47DQo+ID4gDQo+ID4gQW5kIEkgd291bGQganVzdCBhZGQgdGhl
IGZvbGxvd2luZyBsaW5lIGhlcmU6DQo+ID4gDQo+ID4gaWYgKGNvbmRfZGlzYWJsZSAmJiAod2ly
cS0+c3RhdHVzICYNCj4gPiBXQUtFX0lSUV9ERURJQ0FURURfTEFURV9FTkFCTEVEKSkNCj4gPiAg
ICAgICAgIHJldHVybjsNCj4gDQo+IFRoaXMgY2hhbmdlIGRvZXNuJ3QgY292ZXIgdGhlIGNhc2Ug
KFdBS0VfSVJRX0RFRElDQVRFRF9MQVRFX0VOQUJMRUQNCj4gYW5kDQo+ICBXQUtFX0lSUV9ERURJ
Q0FURURfTUFOQUdFRCBhcmUgYm90aCBzZXQgMSk6DQo+IA0KPiAtLT5ycG1fc3VzcGVuZCgpOiB3
aXJxLT5pcnEgaXMgZW5hYmxlZA0KPiAtLT5ycG1fcmVzdW1lKCk6IGRpc2FibGUgd2lycS0+aXJx
OyAoaWYgY2hhbmdlIGl0LCBkb2Vzbid0IGRpc2FibGUNCj4gd2lycS0+aXJxKQ0KU2VlbXMgSSdt
IHdyb25nLCBjaGVjayBhZ2Fpbi4NCg0KPiANCj4gPiANCj4gPiA+IA0KPiA+ID4gLSAgICAgICBp
ZiAod2lycS0+c3RhdHVzICYgV0FLRV9JUlFfREVESUNBVEVEX01BTkFHRUQpDQo+ID4gPiArICAg
ICAgIGlmICh3aXJxLT5zdGF0dXMgJiBXQUtFX0lSUV9ERURJQ0FURURfTUFOQUdFRCAmJg0KPiA+
ID4gKyAgICAgICAgICAgKHNraXBfbGF0ZV9lbmFibGVkX3N0YXR1cyB8fA0KPiA+ID4gKyAgICAg
ICAgICAgICEod2lycS0+c3RhdHVzICYgV0FLRV9JUlFfREVESUNBVEVEX0xBVEVfRU5BQkxFRCkp
KQ0KPiA+ID4gICAgICAgICAgICAgICAgIGRpc2FibGVfaXJxX25vc3luYyh3aXJxLT5pcnEpOw0K
PiA+ID4gIH0NCj4gPiA+IA0KPiA+ID4gKy8qKg0KPiA+ID4gKyAqIGRldl9wbV9lbmFibGVfd2Fr
ZV9pcnFfY29tcGxldGUgLSBlbmFibGUgd2FrZSBpcnEgYmFzZWQgb24NCj4gPiA+IHN0YXR1cw0K
PiA+IA0K

