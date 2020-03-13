Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25E7B1842A2
	for <lists+linux-pm@lfdr.de>; Fri, 13 Mar 2020 09:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgCMIbR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Mar 2020 04:31:17 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:22807 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726230AbgCMIbR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2020 04:31:17 -0400
X-UUID: 2120b3acc30d47e49fd3bd8032cb54b2-20200313
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=uadq0m8B7fzPLQ9yivfxpszXKt2Y0MnLJJvhYfcT86c=;
        b=es0oC2DCWpi85tLVMMHXqJvn/N1ZThUznfcSkUMgTN8ELZGSUIDP8XHC33nRQ2Yr0NV1AOSOxyCSNCgVZJfBB4t659oeI7GO7AmU4p1HRnLY51XK5VGhJmrDipIobldNRjZ5lYzgQNzxyikbUdEAKA1xEU8Wp12eULFVaCRs1kM=;
X-UUID: 2120b3acc30d47e49fd3bd8032cb54b2-20200313
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <ran.bi@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2122994655; Fri, 13 Mar 2020 16:31:11 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs05n2.mediatek.inc
 (172.21.101.140) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 13 Mar
 2020 16:30:04 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 13 Mar 2020 16:31:01 +0800
Message-ID: <1584088256.16960.9.camel@mhfsdcap03>
Subject: Re: [PATCH v10 4/5] rtc: mt6397: Add support for the MediaTek
 MT6358 RTC
From:   Ran Bi <ran.bi@mediatek.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Sean Wang <sean.wang@mediatek.com>,
        "Sebastian Reichel" <sre@kernel.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Frank Wunderlich <frank-w@public-files.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Richard Fontana" <rfontana@redhat.com>,
        Josef Friedl <josef.friedl@speed.at>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <srv_heupstream@mediatek.com>
Date:   Fri, 13 Mar 2020 16:30:56 +0800
In-Reply-To: <20200313072230.GC3142@dell>
References: <1583918223-22506-1-git-send-email-hsin-hsiung.wang@mediatek.com>
         <1583918223-22506-5-git-send-email-hsin-hsiung.wang@mediatek.com>
         <20200312074407.GA3142@dell> <1584003477.6269.8.camel@mhfsdcap03>
         <20200313072230.GC3142@dell>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gRnJpLCAyMDIwLTAzLTEzIGF0IDA3OjIyICswMDAwLCBMZWUgSm9uZXMgd3JvdGU6DQo+IE9u
IFRodSwgMTIgTWFyIDIwMjAsIFJhbiBCaSB3cm90ZToNCj4gDQo+ID4gT24gVGh1LCAyMDIwLTAz
LTEyIGF0IDA3OjQ0ICswMDAwLCBMZWUgSm9uZXMgd3JvdGU6DQo+ID4gPiBPbiBXZWQsIDExIE1h
ciAyMDIwLCBIc2luLUhzaXVuZyBXYW5nIHdyb3RlOg0KPiA+ID4gDQo+ID4gPiA+IEZyb206IFJh
biBCaSA8cmFuLmJpQG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4gDQo+ID4gPiA+IFRoaXMgYWRkIHN1
cHBvcnQgZm9yIHRoZSBNZWRpYVRlayBNVDYzNTggUlRDLiBEcml2ZXIgdXNpbmcNCj4gPiA+ID4g
Y29tcGF0aWJsZSBkYXRhIHRvIHN0b3JlIGRpZmZlcmVudCBSVENfV1JUR1IgYWRkcmVzcyBvZmZz
ZXQuDQo+ID4gPiA+IFRoaXMgcmVwbGFjZSBSVENfV1JUR1IgdG8gUlRDX1dSVEdSX01UNjMyMyBp
biBtdDYzMjMtcG93ZXJvZmYNCj4gPiA+ID4gZHJpdmVyIHdoaWNoIG9ubHkgbmVlZGVkIGJ5IGFy
bXY3IENQVSB3aXRob3V0IEFURi4NCj4gPiA+ID4gDQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFJh
biBCaSA8cmFuLmJpQG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogSHNpbi1I
c2l1bmcgV2FuZyA8aHNpbi1oc2l1bmcud2FuZ0BtZWRpYXRlay5jb20+DQo+ID4gPiA+IC0tLQ0K
PiA+ID4gPiAgZHJpdmVycy9wb3dlci9yZXNldC9tdDYzMjMtcG93ZXJvZmYuYyB8ICAyICstDQo+
ID4gPiA+ICBkcml2ZXJzL3J0Yy9ydGMtbXQ2Mzk3LmMgICAgICAgICAgICAgIHwgMzIgKysrKysr
KysrKysrKysrKysrKysrKysrLS0tLS0tLS0NCj4gPiA+ID4gIGluY2x1ZGUvbGludXgvbWZkL210
NjM5Ny9ydGMuaCAgICAgICAgfCAgOSArKysrKysrKy0NCj4gPiA+ID4gIDMgZmlsZXMgY2hhbmdl
ZCwgMzMgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQo+ID4gPiA+IA0KPiA+IA0KPiA+
IDwuLi4+DQo+ID4gDQo+ID4gPiA+ICANCj4gPiA+ID4gICNkZWZpbmUgUlRDX0lSUV9TVEEgICAg
ICAgICAgICAweDAwMDINCj4gPiA+ID4gICNkZWZpbmUgUlRDX0lSUV9TVEFfQUwgICAgICAgICBC
SVQoMCkNCj4gPiA+ID4gQEAgLTY1LDYgKzY3LDEwIEBADQo+ID4gPiA+ICAjZGVmaW5lIE1US19S
VENfUE9MTF9ERUxBWV9VUyAgMTANCj4gPiA+ID4gICNkZWZpbmUgTVRLX1JUQ19QT0xMX1RJTUVP
VVQgICAoamlmZmllc190b191c2VjcyhIWikpDQo+ID4gPiA+ICANCj4gPiA+ID4gK3N0cnVjdCBt
dGtfcnRjX2RhdGEgew0KPiA+ID4gPiArCXUzMgkJCXdydGdyOw0KPiA+ID4gPiArfTsNCj4gPiA+
IA0KPiA+ID4gRG8geW91IGV4cGVjdCB0byBhZGQgbW9yZSBwcm9wZXJ0aWVzIHRvIHRoaXMgc3Ry
dWN0Pw0KPiA+ID4gDQo+ID4gPiBJZiBub3QsIGl0IHNlZW1zIGEgYml0IG92ZXJraWxsLg0KPiA+
ID4gDQo+ID4gDQo+ID4gWWVzLCB3ZSB3b3VsZCBhZGQgbW9yZSBwcm9wZXJ0aWVzIGhlcmUgaW4g
ZnV0dXJlIHBhdGNoZXMuDQo+ID4gDQo+ID4gPiA+ICBzdHJ1Y3QgbXQ2Mzk3X3J0YyB7DQo+ID4g
PiA+ICAJc3RydWN0IGRldmljZSAgICAgICAgICAgKmRldjsNCj4gPiA+ID4gIAlzdHJ1Y3QgcnRj
X2RldmljZSAgICAgICAqcnRjX2RldjsNCj4gPiA+ID4gQEAgLTc0LDYgKzgwLDcgQEAgc3RydWN0
IG10NjM5N19ydGMgew0KPiA+ID4gPiAgCXN0cnVjdCByZWdtYXAgICAgICAgICAgICpyZWdtYXA7
DQo+ID4gPiA+ICAJaW50ICAgICAgICAgICAgICAgICAgICAgaXJxOw0KPiA+ID4gPiAgCXUzMiAg
ICAgICAgICAgICAgICAgICAgIGFkZHJfYmFzZTsNCj4gPiA+ID4gKwljb25zdCBzdHJ1Y3QgbXRr
X3J0Y19kYXRhICpkYXRhOw0KPiA+ID4gDQo+ID4gPiAnZGF0YScgaXMgYSB0ZXJyaWJsZSB2YXJp
YWJsZSBuYW1lLg0KPiA+ID4gDQo+ID4gPiBXaHkgZG8geW91IG5lZWQgdG8gc3RvcmUgdGhpcz8N
Cj4gPiA+IA0KPiA+ID4gSXQncyBvbmUgdmFyaWFibGUgd2hpY2ggaXMgdXNlZCBvbmNlIEFGQUlD
VC4NCj4gPiANCj4gPiBJIHdvdWxkIHJlbmFtZSAnZGF0YScgdG8gJ2NvbmZpZycuDQo+ID4gDQo+
ID4gVGhpcyBzdHJ1Y3Qgd2lsbCBiZSBleHRlbmRlZCBpbiBmdXR1cmUgcGF0Y2hlcyB0byBhY2hp
ZXZlIG1vcmUgUE1JQyBjaGlwDQo+ID4gY29tcGF0aWJpbGl0eS4NCj4gDQo+IE9uIGNsb3NlciBp
bnNwZWN0aW9uLCBpdCBsb29rcyBsaWtlIHdydGdyIChhbHNvIG5vdCBhIGdyZWF0IG5hbWUgZm9y
IGENCj4gdmFyaWFibGUgYnkgdGhlIHdheSkgaXMgYSByZWdpc3RlciBhZGRyZXNzLiAgSXMgdGhh
dCBjb3JyZWN0Pw0KPiBJbml0aWFsbHkgSSB0aG91Z2h0IGl0IHdhcyBhIG1vZGVsIG51bWJlciwg
d2hpY2ggd291bGQgaGF2ZSBiZWVuIGENCj4gc3VpdGFibGUgY2FuZGlkYXRlIGZvciBlbnRyeSBp
bnRvIE9GIC5kYXRhLg0KPiANCj4gSG93ZXZlciwgZGVzY3JpYmluZyByZWdpc3RlciBhZGRyZXNz
ZXMgaW4gT0YgLmRhdGEgZG9lcyBub3Qgc291bmQgbGlrZQ0KPiBnb29kIHByYWN0aWNlLiAgSXQg
aXMgdXN1YWxseSB1c2VkIHRvIGlkZW50aWZ5IGEgcGxhdGZvcm0gaW4gdGhlIGNhc2VzDQo+IHdo
ZXJlIHBsYXRmb3JtcyBjYW5ub3QgYmUgb3RoZXJ3aXNlIGR5bmFtaWNhbGx5IGludGVycm9nYXRl
ZCBmb3IgbW9kZWwNCj4gbnVtYmVyIHZpYSBhIHJlZ2lzdGVyIHJlYWQuDQo+IA0KPiBEZXNjcmli
aW5nIHJlZ2lzdGVyIG1hcHMgdmlhICdjb25maWcnIGRhdGEgaXMgYSBzbGlwcGVyeSBzbG9wZS4N
Cj4gDQoNCndydGdyIGlzIGEgc3BlY2lhbCByZWdpc3RlciBjYWxsZWQgIndyaXRlIHRyaWdnZXIi
IHdoaWNoIGNvdWxkIGFwcGx5IFJUQw0KcmVnaXN0ZXIgY2hhbmdlIGFmdGVyIHdyaXRlIDEgdG8g
dGhpcyByZWdpc3Rlci4gSSBzdXBwb3NlIEkgY291bGQgcmVuYW1lDQppdCB0byAidHJpZ2dlciIu
DQoNCk1vc3QgUlRDIHJlZ2lzdGVyIG9mZnNldCB3YXMgc2FtZSBiZXR3ZWVuIDYzOTcgYW5kIDYz
NTggUE1JQyBjaGlwIGV4Y2VwdA0KdGhpcyB0cmlnZ2VyIHJlZ2lzdGVyLiBTbyBJIHdvdWxkIGxp
a2UgdG8gc3RvcmUgdGhpcyBkaWZmZXJlbmNlIGludG8gT0YNCmRhdGEuIE90aGVyd2lzZSwgSSBu
ZWVkIGEgbG9uZyBpZi1lbHNlIGNvbmRpdGlvbiBiYXNlZCBvbiBtb2RlbCBudW1iZXINCm9yIHJl
Z2lzdGVyIHJlYWQuDQogDQo=

