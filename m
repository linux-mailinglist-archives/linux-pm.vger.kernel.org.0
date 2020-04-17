Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 813CD1AD8B1
	for <lists+linux-pm@lfdr.de>; Fri, 17 Apr 2020 10:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbgDQIfO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Apr 2020 04:35:14 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:45343 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729747AbgDQIfN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Apr 2020 04:35:13 -0400
X-UUID: d8d986a5e78941bebdc08bacc8008b68-20200417
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=I69XZhCGCT6PHGSQl+2FE2AZcxuaF8LTOGfpLh230qU=;
        b=jqxe+4/bHncovWXXVhvU0o0AsCAmL08SKhpRxzft9v+YWGHN/hqpG3sa/ED5QB1DEXD8Fa0Ohs2H8CN1vFBRvAsDyLaVWgjTsP9ICb8I4SgTDZ79Id48q79qrOsA7x7tXpdY4KXhg1Oa+5xAkUI8ugCyReHEstiSE66a9v2a/7k=;
X-UUID: d8d986a5e78941bebdc08bacc8008b68-20200417
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <ran.bi@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1581973651; Fri, 17 Apr 2020 16:29:59 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs01n1.mediatek.inc
 (172.21.101.68) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 17 Apr
 2020 16:29:57 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 17 Apr 2020 16:29:54 +0800
Message-ID: <1587112169.12875.2.camel@mhfsdcap03>
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
Date:   Fri, 17 Apr 2020 16:29:29 +0800
In-Reply-To: <20200416091438.GA2167633@dell>
References: <1586333531-21641-1-git-send-email-hsin-hsiung.wang@mediatek.com>
         <1586333531-21641-6-git-send-email-hsin-hsiung.wang@mediatek.com>
         <20200416091438.GA2167633@dell>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gVGh1LCAyMDIwLTA0LTE2IGF0IDEwOjE0ICswMTAwLCBMZWUgSm9uZXMgd3JvdGU6DQo+IE9u
IFdlZCwgMDggQXByIDIwMjAsIEhzaW4tSHNpdW5nIFdhbmcgd3JvdGU6DQo+IA0KPiA+IEZyb206
IFJhbiBCaSA8cmFuLmJpQG1lZGlhdGVrLmNvbT4NCj4gPiANCj4gPiBUaGlzIGFkZCBzdXBwb3J0
IGZvciB0aGUgTWVkaWFUZWsgTVQ2MzU4IFJUQy4gRHJpdmVyIHVzaW5nDQo+ID4gY29tcGF0aWJs
ZSBkYXRhIHRvIHN0b3JlIGRpZmZlcmVudCBSVENfV1JUR1IgYWRkcmVzcyBvZmZzZXQuDQo+ID4g
VGhpcyByZXBsYWNlIFJUQ19XUlRHUiB0byBSVENfV1JUR1JfTVQ2MzIzIGluIG10NjMyMy1wb3dl
cm9mZg0KPiA+IGRyaXZlciB3aGljaCBvbmx5IG5lZWRlZCBieSBhcm12NyBDUFUgd2l0aG91dCBB
VEYuDQo+ID4gDQo+ID4gUmV2aWV3ZWQtYnk6IE5pY29sYXMgQm9pY2hhdCA8ZHJpbmtjYXRAY2hy
b21pdW0ub3JnPg0KPiA+IFJldmlld2VkLWJ5OiBZaW5nam9lIENoZW4gPHlpbmdqb2UuY2hlbkBt
ZWRpYXRlay5jb20+DQo+ID4gQWNrZWQtYnk6IEFsZXhhbmRyZSBCZWxsb25pIDxhbGV4YW5kcmUu
YmVsbG9uaUBib290bGluLmNvbT4NCj4gPiBBY2tlZC1ieTogU2ViYXN0aWFuIFJlaWNoZWwgPHNy
ZUBrZXJuZWwub3JnPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJhbiBCaSA8cmFuLmJpQG1lZGlhdGVr
LmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBIc2luLUhzaXVuZyBXYW5nIDxoc2luLWhzaXVuZy53
YW5nQG1lZGlhdGVrLmNvbT4NCj4gDQo+IFBsZWFzZSBwbGFjZSB0aGVzZSBpbiBjaHJvbm9sb2dp
Y2FsIG9yZGVyLiAgVGhleSBzaG91bGQgcHJvdmlkZSBzb21lDQo+IGhpc3RvcnksIHJhdGhlciB0
aGFuIGEgdW5vcmRlcmVkIHNsYWIgbGlzdCBvZiByYW5kb20gc2lnbi1vZmZzLg0KPiANCg0KSSBz
dXBwb3NlIHRoYXQgeW91IG1lYW4gdGhlIG9yZGVyIHNob3VsZCBiZSBsaWtlIGJlbG93LCByaWdo
dD8NClJldmlld2VkLWJ5OiBZaW5nam9lIENoZW4gPHlpbmdqb2UuY2hlbkBtZWRpYXRlay5jb20+
DQpBY2tlZC1ieTogU2ViYXN0aWFuIFJlaWNoZWwgPHNyZUBrZXJuZWwub3JnPg0KQWNrZWQtYnk6
IEFsZXhhbmRyZSBCZWxsb25pIDxhbGV4YW5kcmUuYmVsbG9uaUBib290bGluLmNvbT4NClJldmll
d2VkLWJ5OiBOaWNvbGFzIEJvaWNoYXQgPGRyaW5rY2F0QGNocm9taXVtLm9yZz4NClNpZ25lZC1v
ZmYtYnk6IEhzaW4tSHNpdW5nIFdhbmcgPGhzaW4taHNpdW5nLndhbmdAbWVkaWF0ZWsuY29tPg0K
U2lnbmVkLW9mZi1ieTogUmFuIEJpIDxyYW4uYmlAbWVkaWF0ZWsuY29tPg0KDQo+ID4gLS0tDQo+
ID4gIGRyaXZlcnMvcG93ZXIvcmVzZXQvbXQ2MzIzLXBvd2Vyb2ZmLmMgfCAgMiArLQ0KPiA+ICBk
cml2ZXJzL3J0Yy9ydGMtbXQ2Mzk3LmMgICAgICAgICAgICAgIHwgMTggKysrKysrKysrKysrKysr
LS0tDQo+ID4gIGluY2x1ZGUvbGludXgvbWZkL210NjM5Ny9ydGMuaCAgICAgICAgfCAgOSArKysr
KysrKy0NCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9u
cygtKQ0KPiANCj4gWy4uLl0NCj4gDQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbWZk
L210NjM5Ny9ydGMuaCBiL2luY2x1ZGUvbGludXgvbWZkL210NjM5Ny9ydGMuaA0KPiA+IGluZGV4
IDdkZmI2M2IuLjYyMDBmM2IgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9tZmQvbXQ2
Mzk3L3J0Yy5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9tZmQvbXQ2Mzk3L3J0Yy5oDQo+ID4g
QEAgLTE4LDcgKzE4LDkgQEANCj4gPiAgI2RlZmluZSBSVENfQkJQVV9DQlVTWSAgICAgICAgIEJJ
VCg2KQ0KPiA+ICAjZGVmaW5lIFJUQ19CQlBVX0tFWSAgICAgICAgICAgICgweDQzIDw8IDgpDQo+
ID4gIA0KPiA+IC0jZGVmaW5lIFJUQ19XUlRHUiAgICAgICAgICAgICAgMHgwMDNjDQo+ID4gKyNk
ZWZpbmUgUlRDX1dSVEdSX01UNjM1OCAgICAgICAweDNhDQo+ID4gKyNkZWZpbmUgUlRDX1dSVEdS
X01UNjM5NyAgICAgICAweDNjDQo+IA0KPiBXaHkgcmVtb3ZlIHRoZSBsZWFkaW5nIDAwJ3M/DQo+
IA0KPiBUaGVzZSBhcmUgbm93IGRpZmZlcmVudCB0byB0aGUgb3RoZXIgcmVncyBkZWZpbmVkIGlu
IHRoaXMgaGVhZGVyLg0KPiANCg0KSSB3aWxsIGZpeCB0aGlzIGF0IG5leHQgcGF0Y2guDQoNCj4g
PiArI2RlZmluZSBSVENfV1JUR1JfTVQ2MzIzICAgICAgIFJUQ19XUlRHUl9NVDYzOTcNCj4gPiAg
DQo+ID4gICNkZWZpbmUgUlRDX0lSUV9TVEEgICAgICAgICAgICAweDAwMDINCj4gDQo+IExpa2Ug
aGVyZSBmb3IgaW5zdGFuY2UgIC0tXg0KPiANCj4gPiAgI2RlZmluZSBSVENfSVJRX1NUQV9BTCAg
ICAgICAgIEJJVCgwKQ0KPiA+IEBAIC02NSw2ICs2NywxMCBAQA0KPiA+ICAjZGVmaW5lIE1US19S
VENfUE9MTF9ERUxBWV9VUyAgMTANCj4gPiAgI2RlZmluZSBNVEtfUlRDX1BPTExfVElNRU9VVCAg
IChqaWZmaWVzX3RvX3VzZWNzKEhaKSkNCj4gPiAgDQo+ID4gK3N0cnVjdCBtdGtfcnRjX2RhdGEg
ew0KPiA+ICsJdTMyICAgICAgICAgICAgICAgICAgICAgd3J0Z3I7DQo+ID4gK307DQo+ID4gKw0K
PiA+ICBzdHJ1Y3QgbXQ2Mzk3X3J0YyB7DQo+ID4gIAlzdHJ1Y3QgZGV2aWNlICAgICAgICAgICAq
ZGV2Ow0KPiA+ICAJc3RydWN0IHJ0Y19kZXZpY2UgICAgICAgKnJ0Y19kZXY7DQo+ID4gQEAgLTc0
LDYgKzgwLDcgQEAgc3RydWN0IG10NjM5N19ydGMgew0KPiA+ICAJc3RydWN0IHJlZ21hcCAgICAg
ICAgICAgKnJlZ21hcDsNCj4gPiAgCWludCAgICAgICAgICAgICAgICAgICAgIGlycTsNCj4gPiAg
CXUzMiAgICAgICAgICAgICAgICAgICAgIGFkZHJfYmFzZTsNCj4gPiArCWNvbnN0IHN0cnVjdCBt
dGtfcnRjX2RhdGEgKmRhdGE7DQo+ID4gIH07DQo+ID4gIA0KPiA+ICAjZW5kaWYgLyogX0xJTlVY
X01GRF9NVDYzOTdfUlRDX0hfICovDQo+IA0KDQo=

