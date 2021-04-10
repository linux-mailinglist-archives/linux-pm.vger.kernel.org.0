Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C49D35A9FC
	for <lists+linux-pm@lfdr.de>; Sat, 10 Apr 2021 03:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbhDJBom (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Apr 2021 21:44:42 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:39579 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232855AbhDJBom (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Apr 2021 21:44:42 -0400
X-UUID: fc5077f8912647309ac18c5ba4c1d425-20210410
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=f+eHY1cO25QfYDw7qlA9DNcwvvrIIv/cae1oflaNgrU=;
        b=IsSwYmxPmfQ41pHOH1pIzZ7N5A2/f9bvVswfYyhhvwJVZzs2OguEBVfkH8OxVq9YFzdR3e7UHTFGET7KTsnq0Z/k4Wr2e5xVh7To2ktnSkLx5P49ARyjDeG2Ni7guNdS3uE6EtwFgnJdPZXl5/hP5rV9XwsuQQNShiIY7h/Ak0U=;
X-UUID: fc5077f8912647309ac18c5ba4c1d425-20210410
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 496504886; Sat, 10 Apr 2021 09:44:23 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 10 Apr
 2021 09:44:22 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 10 Apr 2021 09:44:21 +0800
Message-ID: <1618019061.12105.48.camel@mhfsdcap03>
Subject: Re: [PATCH 1/6] PM: runtime: enable wake irq after runtime_suspend
 hook called
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>,
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
        Tianping Fang <tianping.fang@mediatek.com>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>
Date:   Sat, 10 Apr 2021 09:44:21 +0800
In-Reply-To: <CAJZ5v0ioobLt5aEm8TAcPKgJiL13OJ7KqTeJmcQCuVp8ALxBmw@mail.gmail.com>
References: <1617874514-12282-1-git-send-email-chunfeng.yun@mediatek.com>
         <CAJZ5v0gGntbfnvAP5A491_hUh-JUuqZjZRdPPLwWJjnZRtemcQ@mail.gmail.com>
         <1617933211.12105.22.camel@mhfsdcap03> <YG/ohhh3Tyet6InQ@atomide.com>
         <1617957362.12105.27.camel@mhfsdcap03>
         <CAJZ5v0ioobLt5aEm8TAcPKgJiL13OJ7KqTeJmcQCuVp8ALxBmw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 7AC3D9FEF60E5C1132401E888149897F7B3B859953E6EA0B57D85E51DFAC66AD2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gRnJpLCAyMDIxLTA0LTA5IGF0IDEzOjE0ICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gT24gRnJpLCBBcHIgOSwgMjAyMSBhdCAxMDozNiBBTSBDaHVuZmVuZyBZdW4gPGNodW5m
ZW5nLnl1bkBtZWRpYXRlay5jb20+IHdyb3RlOg0KPiA+DQo+ID4gT24gRnJpLCAyMDIxLTA0LTA5
IGF0IDA4OjM5ICswMzAwLCBUb255IExpbmRncmVuIHdyb3RlOg0KPiA+ID4gKiBDaHVuZmVuZyBZ
dW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+IFsyMTA0MDkgMDE6NTRdOg0KPiA+ID4gPiBP
biBUaHUsIDIwMjEtMDQtMDggYXQgMTk6NDEgKzAyMDAsIFJhZmFlbCBKLiBXeXNvY2tpIHdyb3Rl
Og0KPiA+ID4gPiA+IE9uIFRodSwgQXByIDgsIDIwMjEgYXQgMTE6MzUgQU0gQ2h1bmZlbmcgWXVu
IDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPiB3cm90ZToNCj4gPiA+ID4gPiA+DQo+ID4gPiA+
ID4gPiBXaGVuIHRoZSBkZWRpY2F0ZWQgd2FrZSBpcnEgaXMgbGV2ZWwgdHJpZ2dlciwgZW5hYmxl
IGl0IGJlZm9yZQ0KPiA+ID4gPiA+ID4gY2FsbGluZyBydW50aW1lX3N1c3BlbmQsIHdpbGwgdHJp
Z2dlciBhbiBpbnRlcnJ1cHQuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gZS5nLg0KPiA+ID4g
PiA+ID4gZm9yIGEgbG93IGxldmVsIHRyaWdnZXIgdHlwZSwgaXQncyBsb3cgbGV2ZWwgYXQgcnVu
bmluZyB0aW1lICgwKSwNCj4gPiA+ID4gPiA+IGFuZCBiZWNvbWVzIGhpZ2ggbGV2ZWwgd2hlbiBl
bnRlcnMgc3VzcGVuZCAocnVudGltZV9zdXNwZW5kICgxKSBpcw0KPiA+ID4gPiA+ID4gY2FsbGVk
KSwgYSB3YWtldXAgc2lnbmFsIGF0ICgyKSBtYWtlIGl0IGJlY29tZSBsb3cgbGV2ZWwsIHdha2Ug
aXJxDQo+ID4gPiA+ID4gPiB3aWxsIGJlIHRyaWdnZXJlZC4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+
ID4gPiAgICAgICAgICAgICAgICAgLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gPiA+ID4gPiAgICAg
ICAgICAgICAgICB8ICAgICAgICAgICBeICAgICBefA0KPiA+ID4gPiA+ID4gLS0tLS0tLS0tLS0t
LS0tLSAgICAgICAgICAgfCAgICAgfCAtLS0tLS0tLS0tLS0tLQ0KPiA+ID4gPiA+ID4gIHw8LS0t
KDApLS0tPnw8LS0oMSktLXwgICAoMykgICAoMikgICAgKDQpDQo+ID4gPiA+ID4gPg0KPiA+ID4g
PiA+ID4gaWYgd2UgZW5hYmxlIHRoZSB3YWtlIGlycSBiZWZvcmUgY2FsbGluZyBydW50aW1lX3N1
c3BlbmQgZHVyaW5nICgwKSwNCj4gPiA+ID4gPiA+IGFuIGludGVycnVwdCB3aWxsIGFyaXNlLCBp
dCBjYXVzZXMgcmVzdW1lIGltbWVkaWF0ZWx5Ow0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gQnV0IHRo
YXQncyBuZWNlc3NhcnkgdG8gYXZvaWQgbWlzc2luZyBhIHdha2V1cCBpbnRlcnJ1cHQsIGlzbid0
IGl0Pw0KPiA+ID4gPiBUaGF0J3MgYWxzbyB3aGF0IEkgd29ycnkgYWJvdXQuDQo+ID4gPg0KPiA+
ID4gWWVhaCBzb3VuZHMgbGlrZSB0aGlzIHBhdGNoIHdpbGwgbGVhZCBpbnRvIG1pc3NlZCB3YWtl
aXJxcy4NCj4gPiBJZiBtaXNzIGxldmVsIHRyaWdnZXIgd2FrZWlycXMsIHRoYXQgbWVhbnMgSFcg
ZG9lc24ndCBsYXRjaCBpdD8gaXMgaXQgSFcNCj4gPiBsaW1pdGF0aW9uPw0KPiANCj4gSWYgaXQn
cyBsZXZlbC10cmlnZ2VyZWQsIGl0IHdvbid0IGJlIG1pc3NlZCwgYnV0IHRoZW4gaXQgaXMganVz
dA0KPiBwb2ludGxlc3MgdG8gc3VzcGVuZCB0aGUgZGV2aWNlIHdoZW4gd2FrZXVwIGlzIGJlaW5n
IHNpZ25hbGVkIGluIHRoZQ0KPiBmaXJzdCBwbGFjZS4NCkdvdCBpdA0KPiANCj4gSSdtIG5vdCBz
dXJlIGlmIEkgdW5kZXJzdGFuZCB0aGUgdW5kZXJseWluZyBwcm9ibGVtIGNvcnJlY3RseS4gIElz
IGl0DQo+IGFib3V0IGFkZHJlc3Npbmcgc3B1cmlvdXMgd2FrZXVwcz8NCkluIGZhY3QsIGl0J3Mg
ZGVmYXVsdCB2YWx1ZSBpcyB0aGUgc2FtZSBhcyB0aGUgd2FrZXVwIHNpZ25hbCwgbWF5YmUgdGhl
DQphYm92ZSBjYXNlLCB1c2luZyBsZXZlbCB0cmlnZ2VyLCBzaG91bGQgYmUgYXZvaWRlZCwgaXQg
aXMgbm90IGNsZWFyIGFuZA0KY2F1c2VzIGNvbmZ1c2lvbiwgYXMgSWtqb29uIGFuZCBUb255IHN1
Z2dlc3RlZCwgdXNpbmcgZmFsbGluZyBlZGdlIHR5cGUNCmlzIGJldHRlci4NCg0KVGhhbmtzIGEg
bG90DQoNCg0KDQo=

