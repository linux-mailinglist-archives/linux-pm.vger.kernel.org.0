Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB19A1AD903
	for <lists+linux-pm@lfdr.de>; Fri, 17 Apr 2020 10:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729953AbgDQIu2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Apr 2020 04:50:28 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:50554 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729930AbgDQIu1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Apr 2020 04:50:27 -0400
X-UUID: 19c67206a4314b779958374de9d17d4c-20200417
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=CvLwXNbZt4YLZj84U8Z1qWNABI7ku9CPPMrN1RBYWo4=;
        b=dWjdb0Qq2FqWB9CgJutYv88Jk3cuRB6e7sGPsY1SmMa/L7HZ0B096+OwuUx1o+YirKE6alxIjAWXolVuUSYA3ZQ9EbzTXX5cjHVKXRwehlTq4cIHZTnxIyKBvdN2KghdETXHmmleq3bjuMUY6iPMfYLnbYUrZxvW2pQGWhyNoOU=;
X-UUID: 19c67206a4314b779958374de9d17d4c-20200417
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <ran.bi@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1460347295; Fri, 17 Apr 2020 16:50:21 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs05n1.mediatek.inc
 (172.21.101.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 17 Apr
 2020 16:50:19 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 17 Apr 2020 16:50:16 +0800
Message-ID: <1587113392.13323.3.camel@mhfsdcap03>
Subject: Re: [PATCH v12 5/6] rtc: mt6397: Add support for the MediaTek
 MT6358 RTC
From:   Ran Bi <ran.bi@mediatek.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Sebastian Reichel <sre@kernel.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        "Kate Stewart" <kstewart@linuxfoundation.org>,
        Richard Fontana <rfontana@redhat.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        "Josef Friedl" <josef.friedl@speed.at>,
        Thomas Gleixner <tglx@linutronix.de>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>, <srv_heupstream@mediatek.com>
Date:   Fri, 17 Apr 2020 16:49:52 +0800
In-Reply-To: <1587112169.12875.2.camel@mhfsdcap03>
References: <1586333531-21641-1-git-send-email-hsin-hsiung.wang@mediatek.com>
         <1586333531-21641-6-git-send-email-hsin-hsiung.wang@mediatek.com>
         <20200416091438.GA2167633@dell> <1587112169.12875.2.camel@mhfsdcap03>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gRnJpLCAyMDIwLTA0LTE3IGF0IDE2OjI5ICswODAwLCBSYW4gQmkgd3JvdGU6DQo+IE9uIFRo
dSwgMjAyMC0wNC0xNiBhdCAxMDoxNCArMDEwMCwgTGVlIEpvbmVzIHdyb3RlOg0KPiA+IE9uIFdl
ZCwgMDggQXByIDIwMjAsIEhzaW4tSHNpdW5nIFdhbmcgd3JvdGU6DQo+ID4gDQo+ID4gPiBGcm9t
OiBSYW4gQmkgPHJhbi5iaUBtZWRpYXRlay5jb20+DQo+ID4gPiANCj4gPiA+IFRoaXMgYWRkIHN1
cHBvcnQgZm9yIHRoZSBNZWRpYVRlayBNVDYzNTggUlRDLiBEcml2ZXIgdXNpbmcNCj4gPiA+IGNv
bXBhdGlibGUgZGF0YSB0byBzdG9yZSBkaWZmZXJlbnQgUlRDX1dSVEdSIGFkZHJlc3Mgb2Zmc2V0
Lg0KPiA+ID4gVGhpcyByZXBsYWNlIFJUQ19XUlRHUiB0byBSVENfV1JUR1JfTVQ2MzIzIGluIG10
NjMyMy1wb3dlcm9mZg0KPiA+ID4gZHJpdmVyIHdoaWNoIG9ubHkgbmVlZGVkIGJ5IGFybXY3IENQ
VSB3aXRob3V0IEFURi4NCj4gPiA+IA0KPiA+ID4gUmV2aWV3ZWQtYnk6IE5pY29sYXMgQm9pY2hh
dCA8ZHJpbmtjYXRAY2hyb21pdW0ub3JnPg0KPiA+ID4gUmV2aWV3ZWQtYnk6IFlpbmdqb2UgQ2hl
biA8eWluZ2pvZS5jaGVuQG1lZGlhdGVrLmNvbT4NCj4gPiA+IEFja2VkLWJ5OiBBbGV4YW5kcmUg
QmVsbG9uaSA8YWxleGFuZHJlLmJlbGxvbmlAYm9vdGxpbi5jb20+DQo+ID4gPiBBY2tlZC1ieTog
U2ViYXN0aWFuIFJlaWNoZWwgPHNyZUBrZXJuZWwub3JnPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTog
UmFuIEJpIDxyYW4uYmlAbWVkaWF0ZWsuY29tPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogSHNpbi1I
c2l1bmcgV2FuZyA8aHNpbi1oc2l1bmcud2FuZ0BtZWRpYXRlay5jb20+DQo+ID4gDQo+ID4gUGxl
YXNlIHBsYWNlIHRoZXNlIGluIGNocm9ub2xvZ2ljYWwgb3JkZXIuICBUaGV5IHNob3VsZCBwcm92
aWRlIHNvbWUNCj4gPiBoaXN0b3J5LCByYXRoZXIgdGhhbiBhIHVub3JkZXJlZCBzbGFiIGxpc3Qg
b2YgcmFuZG9tIHNpZ24tb2Zmcy4NCj4gPiANCj4gDQo+IEkgc3VwcG9zZSB0aGF0IHlvdSBtZWFu
IHRoZSBvcmRlciBzaG91bGQgYmUgbGlrZSBiZWxvdywgcmlnaHQ/DQo+IFJldmlld2VkLWJ5OiBZ
aW5nam9lIENoZW4gPHlpbmdqb2UuY2hlbkBtZWRpYXRlay5jb20+DQo+IEFja2VkLWJ5OiBTZWJh
c3RpYW4gUmVpY2hlbCA8c3JlQGtlcm5lbC5vcmc+DQo+IEFja2VkLWJ5OiBBbGV4YW5kcmUgQmVs
bG9uaSA8YWxleGFuZHJlLmJlbGxvbmlAYm9vdGxpbi5jb20+DQo+IFJldmlld2VkLWJ5OiBOaWNv
bGFzIEJvaWNoYXQgPGRyaW5rY2F0QGNocm9taXVtLm9yZz4NCj4gU2lnbmVkLW9mZi1ieTogSHNp
bi1Ic2l1bmcgV2FuZyA8aHNpbi1oc2l1bmcud2FuZ0BtZWRpYXRlay5jb20+DQo+IFNpZ25lZC1v
ZmYtYnk6IFJhbiBCaSA8cmFuLmJpQG1lZGlhdGVrLmNvbT4NCj4gDQoNCkNvcnJlY3Rpb24sIEkg
dGhpbmsgZm9sbG93aW5nIGlzIHRoZSBjb3JyZWN0IGNocm9ub2xvZ2ljYWwgb3JkZXI6DQpTaWdu
ZWQtb2ZmLWJ5OiBSYW4gQmkgPHJhbi5iaUBtZWRpYXRlay5jb20+DQpTaWduZWQtb2ZmLWJ5OiBI
c2luLUhzaXVuZyBXYW5nIDxoc2luLWhzaXVuZy53YW5nQG1lZGlhdGVrLmNvbT4NClJldmlld2Vk
LWJ5OiBOaWNvbGFzIEJvaWNoYXQgPGRyaW5rY2F0QGNocm9taXVtLm9yZz4NCkFja2VkLWJ5OiBB
bGV4YW5kcmUgQmVsbG9uaSA8YWxleGFuZHJlLmJlbGxvbmlAYm9vdGxpbi5jb20+DQpBY2tlZC1i
eTogU2ViYXN0aWFuIFJlaWNoZWwgPHNyZUBrZXJuZWwub3JnPg0KUmV2aWV3ZWQtYnk6IFlpbmdq
b2UgQ2hlbiA8eWluZ2pvZS5jaGVuQG1lZGlhdGVrLmNvbT4NCg0KPiA+ID4gLS0tDQo+ID4gPiAg
ZHJpdmVycy9wb3dlci9yZXNldC9tdDYzMjMtcG93ZXJvZmYuYyB8ICAyICstDQo+ID4gPiAgZHJp
dmVycy9ydGMvcnRjLW10NjM5Ny5jICAgICAgICAgICAgICB8IDE4ICsrKysrKysrKysrKysrKy0t
LQ0KPiA+ID4gIGluY2x1ZGUvbGludXgvbWZkL210NjM5Ny9ydGMuaCAgICAgICAgfCAgOSArKysr
KysrKy0NCj4gPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKyksIDUgZGVsZXRp
b25zKC0pDQo+ID4gDQo+ID4gWy4uLl0NCj4gPiANCj4gPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L2xpbnV4L21mZC9tdDYzOTcvcnRjLmggYi9pbmNsdWRlL2xpbnV4L21mZC9tdDYzOTcvcnRjLmgN
Cj4gPiA+IGluZGV4IDdkZmI2M2IuLjYyMDBmM2IgMTAwNjQ0DQo+ID4gPiAtLS0gYS9pbmNsdWRl
L2xpbnV4L21mZC9tdDYzOTcvcnRjLmgNCj4gPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvbWZkL210
NjM5Ny9ydGMuaA0KPiA+ID4gQEAgLTE4LDcgKzE4LDkgQEANCj4gPiA+ICAjZGVmaW5lIFJUQ19C
QlBVX0NCVVNZICAgICAgICAgQklUKDYpDQo+ID4gPiAgI2RlZmluZSBSVENfQkJQVV9LRVkgICAg
ICAgICAgICAoMHg0MyA8PCA4KQ0KPiA+ID4gIA0KPiA+ID4gLSNkZWZpbmUgUlRDX1dSVEdSICAg
ICAgICAgICAgICAweDAwM2MNCj4gPiA+ICsjZGVmaW5lIFJUQ19XUlRHUl9NVDYzNTggICAgICAg
MHgzYQ0KPiA+ID4gKyNkZWZpbmUgUlRDX1dSVEdSX01UNjM5NyAgICAgICAweDNjDQo+ID4gDQo+
ID4gV2h5IHJlbW92ZSB0aGUgbGVhZGluZyAwMCdzPw0KPiA+IA0KPiA+IFRoZXNlIGFyZSBub3cg
ZGlmZmVyZW50IHRvIHRoZSBvdGhlciByZWdzIGRlZmluZWQgaW4gdGhpcyBoZWFkZXIuDQo+ID4g
DQo+IA0KPiBJIHdpbGwgZml4IHRoaXMgYXQgbmV4dCBwYXRjaC4NCj4gDQo+ID4gPiArI2RlZmlu
ZSBSVENfV1JUR1JfTVQ2MzIzICAgICAgIFJUQ19XUlRHUl9NVDYzOTcNCj4gPiA+ICANCj4gPiA+
ICAjZGVmaW5lIFJUQ19JUlFfU1RBICAgICAgICAgICAgMHgwMDAyDQo+ID4gDQo+ID4gTGlrZSBo
ZXJlIGZvciBpbnN0YW5jZSAgLS1eDQo+ID4gDQo+ID4gPiAgI2RlZmluZSBSVENfSVJRX1NUQV9B
TCAgICAgICAgIEJJVCgwKQ0KPiA+ID4gQEAgLTY1LDYgKzY3LDEwIEBADQo+ID4gPiAgI2RlZmlu
ZSBNVEtfUlRDX1BPTExfREVMQVlfVVMgIDEwDQo+ID4gPiAgI2RlZmluZSBNVEtfUlRDX1BPTExf
VElNRU9VVCAgIChqaWZmaWVzX3RvX3VzZWNzKEhaKSkNCj4gPiA+ICANCj4gPiA+ICtzdHJ1Y3Qg
bXRrX3J0Y19kYXRhIHsNCj4gPiA+ICsJdTMyICAgICAgICAgICAgICAgICAgICAgd3J0Z3I7DQo+
ID4gPiArfTsNCj4gPiA+ICsNCj4gPiA+ICBzdHJ1Y3QgbXQ2Mzk3X3J0YyB7DQo+ID4gPiAgCXN0
cnVjdCBkZXZpY2UgICAgICAgICAgICpkZXY7DQo+ID4gPiAgCXN0cnVjdCBydGNfZGV2aWNlICAg
ICAgICpydGNfZGV2Ow0KPiA+ID4gQEAgLTc0LDYgKzgwLDcgQEAgc3RydWN0IG10NjM5N19ydGMg
ew0KPiA+ID4gIAlzdHJ1Y3QgcmVnbWFwICAgICAgICAgICAqcmVnbWFwOw0KPiA+ID4gIAlpbnQg
ICAgICAgICAgICAgICAgICAgICBpcnE7DQo+ID4gPiAgCXUzMiAgICAgICAgICAgICAgICAgICAg
IGFkZHJfYmFzZTsNCj4gPiA+ICsJY29uc3Qgc3RydWN0IG10a19ydGNfZGF0YSAqZGF0YTsNCj4g
PiA+ICB9Ow0KPiA+ID4gIA0KPiA+ID4gICNlbmRpZiAvKiBfTElOVVhfTUZEX01UNjM5N19SVENf
SF8gKi8NCj4gPiANCj4gDQoNCg==

