Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF852F2990
	for <lists+linux-pm@lfdr.de>; Tue, 12 Jan 2021 08:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392196AbhALH6d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Jan 2021 02:58:33 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:36154 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387692AbhALH6c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2021 02:58:32 -0500
X-UUID: f297533def6b4cdda96ff3839445077d-20210112
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=MSCj26hBYC5yhFYlqz1zDqlpvUKDf/hx4JpIFhfQLI4=;
        b=W16oFPTeJaN1RA97Wu0YZIKaA88aXNvJ7EUm4Ixma6NxFTB2TVNI3KWFd8Wf/yQHBeJfTVVabbqcYS7tPLbn7ock6OCnIovZ4XFok0xgUI3ffeSMuP9ctEggoZiaVVVbswBz4FpQivOwyMYMNTxsy1DhsgWJLfus87XjjoWFB7M=;
X-UUID: f297533def6b4cdda96ff3839445077d-20210112
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <henryc.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 557589570; Tue, 12 Jan 2021 15:57:46 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 12 Jan 2021 15:57:44 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 12 Jan 2021 15:57:44 +0800
Message-ID: <1610438264.31838.1.camel@mtksdaap41>
Subject: Re: [PATCH V7 01/13] dt-bindings: soc: Add dvfsrc driver bindings
From:   Henry Chen <henryc.chen@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Fan Chen <fan.chen@mediatek.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        James Liao <jamesjj.liao@mediatek.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ryan Case <ryandcase@chromium.org>,
        Arvin Wang <arvin.wang@mediatek.com>,
        "Nicolas Boichat" <drinkcat@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        "Mark Brown" <broonie@kernel.org>, <devicetree@vger.kernel.org>
Date:   Tue, 12 Jan 2021 15:57:44 +0800
In-Reply-To: <CAL_Jsq+W3UL4-s6ezFJrhUYko2EBPsO9nMOGzGR1nQT3x_VtdQ@mail.gmail.com>
References: <1610092095-5113-1-git-send-email-henryc.chen@mediatek.com>
         <1610092095-5113-2-git-send-email-henryc.chen@mediatek.com>
         <1610163019.789930.3762037.nullmailer@robh.at.kernel.org>
         <1610333553.2992.7.camel@mtksdaap41>
         <CAL_Jsq+W3UL4-s6ezFJrhUYko2EBPsO9nMOGzGR1nQT3x_VtdQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: E12981678A47B5256F94D79B6C1A2E72C722F0897B9519C75472F6B9F7E0D2322000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gTW9uLCAyMDIxLTAxLTExIGF0IDA5OjQyIC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gU3VuLCBKYW4gMTAsIDIwMjEgYXQgODo1MiBQTSBIZW5yeSBDaGVuIDxoZW5yeWMuY2hlbkBt
ZWRpYXRlay5jb20+IHdyb3RlOg0KPiA+DQo+ID4gSGkgUm9iLA0KPiA+DQo+ID4gT24gRnJpLCAy
MDIxLTAxLTA4IGF0IDIwOjMwIC0wNzAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4gPiA+IE9uIEZy
aSwgMDggSmFuIDIwMjEgMTU6NDg6MDMgKzA4MDAsIEhlbnJ5IENoZW4gd3JvdGU6DQo+ID4gPiA+
IERvY3VtZW50IHRoZSBiaW5kaW5nIGZvciBlbmFibGluZyBkdmZzcmMgb24gTWVkaWFUZWsgU29D
Lg0KPiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBIZW5yeSBDaGVuIDxoZW5yeWMuY2hl
bkBtZWRpYXRlay5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgLi4uL2RldmljZXRyZWUvYmlu
ZGluZ3Mvc29jL21lZGlhdGVrL2R2ZnNyYy55YW1sICAgfCA2NyArKysrKysrKysrKysrKysrKysr
KysrDQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNjcgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPiAg
Y3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2Mv
bWVkaWF0ZWsvZHZmc3JjLnlhbWwNCj4gPiA+ID4NCj4gPiA+DQo+ID4gPiBNeSBib3QgZm91bmQg
ZXJyb3JzIHJ1bm5pbmcgJ21ha2UgZHRfYmluZGluZ19jaGVjaycgb24geW91ciBwYXRjaDoNCj4g
PiA+DQo+ID4gPiB5YW1sbGludCB3YXJuaW5ncy9lcnJvcnM6DQo+ID4gPg0KPiA+ID4gZHRzY2hl
bWEvZHRjIHdhcm5pbmdzL2Vycm9yczoNCj4gPiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9zb2MvbWVkaWF0ZWsvZHZmc3JjLmV4YW1wbGUuZHRzOjE5OjE4OiBmYXRhbCBlcnJv
cjogZHQtYmluZGluZ3MvaW50ZXJjb25uZWN0L210ayxtdDgxODMtZW1pLmg6IE5vIHN1Y2ggZmls
ZSBvciBkaXJlY3RvcnkNCj4gPiA+ICAgIDE5IHwgICAgICAgICAjaW5jbHVkZSA8ZHQtYmluZGlu
Z3MvaW50ZXJjb25uZWN0L210ayxtdDgxODMtZW1pLmg+DQo+ID4gPiAgICAgICB8ICAgICAgICAg
ICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KPiA+
IFNvcnJ5LCBiZWNhdXNlIHRoaXMgaGVhZGVyIGZpbGUgaXMgYWRkZWQgb24gIltWNywwNy8xM10g
ZHQtYmluZGluZ3M6DQo+ID4gaW50ZXJjb25uZWN0OiBhZGQgTVQ4MTgzIGludGVyY29ubmVjdCBk
dC1iaW5kaW5ncyIuDQo+ID4gU2hvdWxkIEkgY2hhbmdlIHRoZSBvcmRlciBvZiB0aGUgcGF0Y2hz
ZXQgKGxldCB0aGUgeWFtbCBwYXRoYyBiZWhpbmQgdGhlDQo+ID4gaGVhZGVyKSB0byBmaXhlZCB0
aGF0ID8NCj4gDQo+IERUIGhlYWRlcnMgc2hvdWxkIGJlIHBhcnQgb2YgdGhlIGJpbmRpbmcgc2No
ZW1hIHBhdGNoLiAoT3IgYXQgbGVhc3QgY29tZSBmaXJzdCkuDQpPSywgSSB3aWxsIG1lcmdlIERU
IGhlYWRlciBhbmQgYmluZGluZyBzY2hlbWEgcGF0Y2ggaW50byBhIHNpbmdsZSBwYXRjaC4NCg0K
SGVucnkNCj4gDQo+IFJvYg0KDQo=

