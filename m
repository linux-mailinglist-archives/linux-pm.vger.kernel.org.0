Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18FC23597FE
	for <lists+linux-pm@lfdr.de>; Fri,  9 Apr 2021 10:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbhDIIge (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Apr 2021 04:36:34 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:6443 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229673AbhDIIge (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Apr 2021 04:36:34 -0400
X-UUID: 0637c80731dc4c66a88fe7dd9d35e86b-20210409
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=yIa3uM6G22r1aP39OoNbC6ZO8rrtqiWMh2OKTwN3Djs=;
        b=cLHrM5Q0nakRb9YnqZeSc8cp0BLotEwENQ7wPYjlcS9mbRWJpp/MFyvcgz9necVVnlHA3HocutiS6n501uYAw2oRbr909n1xiSad0kOYOEN3O+0O1wHWAUSIYVEi6LQyqIWsU8qjWXMaqj/1TxDY3bH//7k9PipXcrUF7hVbeA4=;
X-UUID: 0637c80731dc4c66a88fe7dd9d35e86b-20210409
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1706824691; Fri, 09 Apr 2021 16:36:08 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 9 Apr
 2021 16:36:03 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 9 Apr 2021 16:36:02 +0800
Message-ID: <1617957362.12105.27.camel@mhfsdcap03>
Subject: Re: [PATCH 1/6] PM: runtime: enable wake irq after runtime_suspend
 hook called
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Tony Lindgren <tony@atomide.com>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Len Brown" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
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
Date:   Fri, 9 Apr 2021 16:36:02 +0800
In-Reply-To: <YG/ohhh3Tyet6InQ@atomide.com>
References: <1617874514-12282-1-git-send-email-chunfeng.yun@mediatek.com>
         <CAJZ5v0gGntbfnvAP5A491_hUh-JUuqZjZRdPPLwWJjnZRtemcQ@mail.gmail.com>
         <1617933211.12105.22.camel@mhfsdcap03> <YG/ohhh3Tyet6InQ@atomide.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: F1995856564853C53D5FE1D9127019BAA0A4EEA5D2AC64D5A3BD1FE537E9ECB92000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gRnJpLCAyMDIxLTA0LTA5IGF0IDA4OjM5ICswMzAwLCBUb255IExpbmRncmVuIHdyb3RlOg0K
PiAqIENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4gWzIxMDQwOSAwMTo1
NF06DQo+ID4gT24gVGh1LCAyMDIxLTA0LTA4IGF0IDE5OjQxICswMjAwLCBSYWZhZWwgSi4gV3lz
b2NraSB3cm90ZToNCj4gPiA+IE9uIFRodSwgQXByIDgsIDIwMjEgYXQgMTE6MzUgQU0gQ2h1bmZl
bmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+
ID4gV2hlbiB0aGUgZGVkaWNhdGVkIHdha2UgaXJxIGlzIGxldmVsIHRyaWdnZXIsIGVuYWJsZSBp
dCBiZWZvcmUNCj4gPiA+ID4gY2FsbGluZyBydW50aW1lX3N1c3BlbmQsIHdpbGwgdHJpZ2dlciBh
biBpbnRlcnJ1cHQuDQo+ID4gPiA+DQo+ID4gPiA+IGUuZy4NCj4gPiA+ID4gZm9yIGEgbG93IGxl
dmVsIHRyaWdnZXIgdHlwZSwgaXQncyBsb3cgbGV2ZWwgYXQgcnVubmluZyB0aW1lICgwKSwNCj4g
PiA+ID4gYW5kIGJlY29tZXMgaGlnaCBsZXZlbCB3aGVuIGVudGVycyBzdXNwZW5kIChydW50aW1l
X3N1c3BlbmQgKDEpIGlzDQo+ID4gPiA+IGNhbGxlZCksIGEgd2FrZXVwIHNpZ25hbCBhdCAoMikg
bWFrZSBpdCBiZWNvbWUgbG93IGxldmVsLCB3YWtlIGlycQ0KPiA+ID4gPiB3aWxsIGJlIHRyaWdn
ZXJlZC4NCj4gPiA+ID4NCj4gPiA+ID4gICAgICAgICAgICAgICAgIC0tLS0tLS0tLS0tLS0tLS0t
LQ0KPiA+ID4gPiAgICAgICAgICAgICAgICB8ICAgICAgICAgICBeICAgICBefA0KPiA+ID4gPiAt
LS0tLS0tLS0tLS0tLS0tICAgICAgICAgICB8ICAgICB8IC0tLS0tLS0tLS0tLS0tDQo+ID4gPiA+
ICB8PC0tLSgwKS0tLT58PC0tKDEpLS18ICAgKDMpICAgKDIpICAgICg0KQ0KPiA+ID4gPg0KPiA+
ID4gPiBpZiB3ZSBlbmFibGUgdGhlIHdha2UgaXJxIGJlZm9yZSBjYWxsaW5nIHJ1bnRpbWVfc3Vz
cGVuZCBkdXJpbmcgKDApLA0KPiA+ID4gPiBhbiBpbnRlcnJ1cHQgd2lsbCBhcmlzZSwgaXQgY2F1
c2VzIHJlc3VtZSBpbW1lZGlhdGVseTsNCj4gPiA+IA0KPiA+ID4gQnV0IHRoYXQncyBuZWNlc3Nh
cnkgdG8gYXZvaWQgbWlzc2luZyBhIHdha2V1cCBpbnRlcnJ1cHQsIGlzbid0IGl0Pw0KPiA+IFRo
YXQncyBhbHNvIHdoYXQgSSB3b3JyeSBhYm91dC4NCj4gDQo+IFllYWggc291bmRzIGxpa2UgdGhp
cyBwYXRjaCB3aWxsIGxlYWQgaW50byBtaXNzZWQgd2FrZWlycXMuDQpJZiBtaXNzIGxldmVsIHRy
aWdnZXIgd2FrZWlycXMsIHRoYXQgbWVhbnMgSFcgZG9lc24ndCBsYXRjaCBpdD8gaXMgaXQgSFcN
CmxpbWl0YXRpb24/DQo+IA0KPiBSZWdhcmRzLA0KPiANCj4gVG9ueQ0KDQo=

