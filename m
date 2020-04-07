Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5825C1A0573
	for <lists+linux-pm@lfdr.de>; Tue,  7 Apr 2020 06:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725817AbgDGEBQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Apr 2020 00:01:16 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:31731 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725802AbgDGEBQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Apr 2020 00:01:16 -0400
X-UUID: 01ecef53abd240e3b45fe3e134db50d8-20200407
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=tDfNg15w+Ek3LL7rOou7wOOIqGnTslzbpPXl9hJyd+0=;
        b=Q6VjkvOnS8xSsd7Yb90johBvvQVleE/Z7yyQ8y8gZn9YdLTQkCDvFvaW9TECp6w0c9oO5Yte8zsKWfe8eesrqFoV5TKKfdDGYDzmvgHPJAOAc6r/zVpxEhqv20hiPrPTw5Qs9Cze1rdXNCArf/j/zL2fy4A9nXS66LzKay177gs=;
X-UUID: 01ecef53abd240e3b45fe3e134db50d8-20200407
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <yingjoe.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1589193616; Tue, 07 Apr 2020 12:01:08 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 7 Apr 2020 12:01:02 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 7 Apr 2020 12:01:03 +0800
Message-ID: <1586232063.17821.2.camel@mtksdaap41>
Subject: Re: [PATCH v11 4/5] rtc: mt6397: Add support for the MediaTek
 MT6358 RTC
From:   Yingjoe Chen <yingjoe.chen@mediatek.com>
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
CC:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Josef Friedl <josef.friedl@speed.at>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <srv_heupstream@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Ran Bi <ran.bi@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-rtc@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Richard Fontana <rfontana@redhat.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 7 Apr 2020 12:01:03 +0800
In-Reply-To: <1585627657-3265-5-git-send-email-hsin-hsiung.wang@mediatek.com>
References: <1585627657-3265-1-git-send-email-hsin-hsiung.wang@mediatek.com>
         <1585627657-3265-5-git-send-email-hsin-hsiung.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gVHVlLCAyMDIwLTAzLTMxIGF0IDEyOjA3ICswODAwLCBIc2luLUhzaXVuZyBXYW5nIHdyb3Rl
Og0KPiBGcm9tOiBSYW4gQmkgPHJhbi5iaUBtZWRpYXRlay5jb20+DQo+IA0KPiBUaGlzIGFkZCBz
dXBwb3J0IGZvciB0aGUgTWVkaWFUZWsgTVQ2MzU4IFJUQy4gRHJpdmVyIHVzaW5nDQo+IGNvbXBh
dGlibGUgZGF0YSB0byBzdG9yZSBkaWZmZXJlbnQgUlRDX1dSVEdSIGFkZHJlc3Mgb2Zmc2V0Lg0K
PiBUaGlzIHJlcGxhY2UgUlRDX1dSVEdSIHRvIFJUQ19XUlRHUl9NVDYzMjMgaW4gbXQ2MzIzLXBv
d2Vyb2ZmDQo+IGRyaXZlciB3aGljaCBvbmx5IG5lZWRlZCBieSBhcm12NyBDUFUgd2l0aG91dCBB
VEYuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSYW4gQmkgPHJhbi5iaUBtZWRpYXRlay5jb20+DQo+
IFNpZ25lZC1vZmYtYnk6IEhzaW4tSHNpdW5nIFdhbmcgPGhzaW4taHNpdW5nLndhbmdAbWVkaWF0
ZWsuY29tPg0KDQoNCkxvb2tzIGdvb2QgdG8gbWUsIHRoYW5rcy4NCg0KUmV2aWV3ZWQtYnk6IFlp
bmdqb2UgQ2hlbiA8eWluZ2pvZS5jaGVuQG1lZGlhdGVrLmNvbT4NCg0KDQpKb2UuQw0KDQo+IC0t
LQ0KPiAgZHJpdmVycy9wb3dlci9yZXNldC9tdDYzMjMtcG93ZXJvZmYuYyB8ICAyICstDQo+ICBk
cml2ZXJzL3J0Yy9ydGMtbXQ2Mzk3LmMgICAgICAgICAgICAgIHwgMjMgKysrKysrKysrKysrKysr
KysrKy0tLS0NCj4gIGluY2x1ZGUvbGludXgvbWZkL210NjM5Ny9ydGMuaCAgICAgICAgfCAgOSAr
KysrKysrKy0NCj4gIDMgZmlsZXMgY2hhbmdlZCwgMjggaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Bvd2VyL3Jlc2V0L210NjMyMy1wb3dl
cm9mZi5jIGIvZHJpdmVycy9wb3dlci9yZXNldC9tdDYzMjMtcG93ZXJvZmYuYw0KPiBpbmRleCAx
Y2FmNDNkLi4wNTMyODAzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3Bvd2VyL3Jlc2V0L210NjMy
My1wb3dlcm9mZi5jDQo+ICsrKyBiL2RyaXZlcnMvcG93ZXIvcmVzZXQvbXQ2MzIzLXBvd2Vyb2Zm
LmMNCj4gQEAgLTMwLDcgKzMwLDcgQEAgc3RhdGljIHZvaWQgbXQ2MzIzX2RvX3B3cm9mZih2b2lk
KQ0KPiAgCWludCByZXQ7DQo+ICANCj4gIAlyZWdtYXBfd3JpdGUocHdyYy0+cmVnbWFwLCBwd3Jj
LT5iYXNlICsgUlRDX0JCUFUsIFJUQ19CQlBVX0tFWSk7DQo+IC0JcmVnbWFwX3dyaXRlKHB3cmMt
PnJlZ21hcCwgcHdyYy0+YmFzZSArIFJUQ19XUlRHUiwgMSk7DQo+ICsJcmVnbWFwX3dyaXRlKHB3
cmMtPnJlZ21hcCwgcHdyYy0+YmFzZSArIFJUQ19XUlRHUl9NVDYzMjMsIDEpOw0KPiAgDQo+ICAJ
cmV0ID0gcmVnbWFwX3JlYWRfcG9sbF90aW1lb3V0KHB3cmMtPnJlZ21hcCwNCj4gIAkJCQkJcHdy
Yy0+YmFzZSArIFJUQ19CQlBVLCB2YWwsDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3J0Yy9ydGMt
bXQ2Mzk3LmMgYi9kcml2ZXJzL3J0Yy9ydGMtbXQ2Mzk3LmMNCj4gaW5kZXggY2RhMjM4ZC4uN2Yz
ZGZkMiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ydGMvcnRjLW10NjM5Ny5jDQo+ICsrKyBiL2Ry
aXZlcnMvcnRjL3J0Yy1tdDYzOTcuYw0KPiBAQCAtOSw2ICs5LDcgQEANCj4gICNpbmNsdWRlIDxs
aW51eC9tZmQvbXQ2Mzk3L2NvcmUuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4g
ICNpbmNsdWRlIDxsaW51eC9tdXRleC5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L29mX2RldmljZS5o
Pg0KPiAgI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KPiAgI2luY2x1ZGUgPGxp
bnV4L3JlZ21hcC5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3J0Yy5oPg0KPiBAQCAtMjAsNyArMjEs
NyBAQCBzdGF0aWMgaW50IG10a19ydGNfd3JpdGVfdHJpZ2dlcihzdHJ1Y3QgbXQ2Mzk3X3J0YyAq
cnRjKQ0KPiAgCWludCByZXQ7DQo+ICAJdTMyIGRhdGE7DQo+ICANCj4gLQlyZXQgPSByZWdtYXBf
d3JpdGUocnRjLT5yZWdtYXAsIHJ0Yy0+YWRkcl9iYXNlICsgUlRDX1dSVEdSLCAxKTsNCj4gKwly
ZXQgPSByZWdtYXBfd3JpdGUocnRjLT5yZWdtYXAsIHJ0Yy0+YWRkcl9iYXNlICsgcnRjLT5kYXRh
LT53cnRnciwgMSk7DQo+ICAJaWYgKHJldCA8IDApDQo+ICAJCXJldHVybiByZXQ7DQo+ICANCj4g
QEAgLTI2OSw2ICsyNzAsOCBAQCBzdGF0aWMgaW50IG10a19ydGNfcHJvYmUoc3RydWN0IHBsYXRm
b3JtX2RldmljZSAqcGRldikNCj4gIAlyZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UocGRldiwg
SU9SRVNPVVJDRV9NRU0sIDApOw0KPiAgCXJ0Yy0+YWRkcl9iYXNlID0gcmVzLT5zdGFydDsNCj4g
IA0KPiArCXJ0Yy0+ZGF0YSA9IG9mX2RldmljZV9nZXRfbWF0Y2hfZGF0YSgmcGRldi0+ZGV2KTsN
Cj4gKw0KPiAgCXJ0Yy0+aXJxID0gcGxhdGZvcm1fZ2V0X2lycShwZGV2LCAwKTsNCj4gIAlpZiAo
cnRjLT5pcnEgPCAwKQ0KPiAgCQlyZXR1cm4gcnRjLT5pcnE7DQo+IEBAIC0zMjUsMTAgKzMyOCwy
MiBAQCBzdGF0aWMgaW50IG10NjM5N19ydGNfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCj4g
IHN0YXRpYyBTSU1QTEVfREVWX1BNX09QUyhtdDYzOTdfcG1fb3BzLCBtdDYzOTdfcnRjX3N1c3Bl
bmQsDQo+ICAJCQltdDYzOTdfcnRjX3Jlc3VtZSk7DQo+ICANCj4gK3N0YXRpYyBjb25zdCBzdHJ1
Y3QgbXRrX3J0Y19kYXRhIG10NjM1OF9ydGNfZGF0YSA9IHsNCj4gKwkud3J0Z3IgPSBSVENfV1JU
R1JfTVQ2MzU4LA0KPiArfTsNCj4gKw0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfcnRjX2Rh
dGEgbXQ2Mzk3X3J0Y19kYXRhID0gew0KPiArCS53cnRnciA9IFJUQ19XUlRHUl9NVDYzOTcsDQo+
ICt9Ow0KPiArDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBtdDYzOTdfcnRj
X29mX21hdGNoW10gPSB7DQo+IC0JeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDYzMjMtcnRj
IiwgfSwNCj4gLQl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10NjM5Ny1ydGMiLCB9LA0KPiAt
CXsgfQ0KPiArCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ2MzIzLXJ0YyIsDQo+ICsJCS5k
YXRhID0gJm10NjM5N19ydGNfZGF0YSwgfSwNCj4gKwl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVr
LG10NjM1OC1ydGMiLA0KPiArCQkuZGF0YSA9ICZtdDYzNThfcnRjX2RhdGEsIH0sDQo+ICsJeyAu
Y29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDYzOTctcnRjIiwNCj4gKwkJLmRhdGEgPSAmbXQ2Mzk3
X3J0Y19kYXRhLCB9LA0KPiArCXt9DQo+ICB9Ow0KPiAgTU9EVUxFX0RFVklDRV9UQUJMRShvZiwg
bXQ2Mzk3X3J0Y19vZl9tYXRjaCk7DQo+ICANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgv
bWZkL210NjM5Ny9ydGMuaCBiL2luY2x1ZGUvbGludXgvbWZkL210NjM5Ny9ydGMuaA0KPiBpbmRl
eCA3ZGZiNjNiLi42MjAwZjNiIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L21mZC9tdDYz
OTcvcnRjLmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9tZmQvbXQ2Mzk3L3J0Yy5oDQo+IEBAIC0x
OCw3ICsxOCw5IEBADQo+ICAjZGVmaW5lIFJUQ19CQlBVX0NCVVNZICAgICAgICAgQklUKDYpDQo+
ICAjZGVmaW5lIFJUQ19CQlBVX0tFWSAgICAgICAgICAgICgweDQzIDw8IDgpDQo+ICANCj4gLSNk
ZWZpbmUgUlRDX1dSVEdSICAgICAgICAgICAgICAweDAwM2MNCj4gKyNkZWZpbmUgUlRDX1dSVEdS
X01UNjM1OCAgICAgICAweDNhDQo+ICsjZGVmaW5lIFJUQ19XUlRHUl9NVDYzOTcgICAgICAgMHgz
Yw0KPiArI2RlZmluZSBSVENfV1JUR1JfTVQ2MzIzICAgICAgIFJUQ19XUlRHUl9NVDYzOTcNCj4g
IA0KPiAgI2RlZmluZSBSVENfSVJRX1NUQSAgICAgICAgICAgIDB4MDAwMg0KPiAgI2RlZmluZSBS
VENfSVJRX1NUQV9BTCAgICAgICAgIEJJVCgwKQ0KPiBAQCAtNjUsNiArNjcsMTAgQEANCj4gICNk
ZWZpbmUgTVRLX1JUQ19QT0xMX0RFTEFZX1VTICAxMA0KPiAgI2RlZmluZSBNVEtfUlRDX1BPTExf
VElNRU9VVCAgIChqaWZmaWVzX3RvX3VzZWNzKEhaKSkNCj4gIA0KPiArc3RydWN0IG10a19ydGNf
ZGF0YSB7DQo+ICsJdTMyICAgICAgICAgICAgICAgICAgICAgd3J0Z3I7DQo+ICt9Ow0KPiArDQo+
ICBzdHJ1Y3QgbXQ2Mzk3X3J0YyB7DQo+ICAJc3RydWN0IGRldmljZSAgICAgICAgICAgKmRldjsN
Cj4gIAlzdHJ1Y3QgcnRjX2RldmljZSAgICAgICAqcnRjX2RldjsNCj4gQEAgLTc0LDYgKzgwLDcg
QEAgc3RydWN0IG10NjM5N19ydGMgew0KPiAgCXN0cnVjdCByZWdtYXAgICAgICAgICAgICpyZWdt
YXA7DQo+ICAJaW50ICAgICAgICAgICAgICAgICAgICAgaXJxOw0KPiAgCXUzMiAgICAgICAgICAg
ICAgICAgICAgIGFkZHJfYmFzZTsNCj4gKwljb25zdCBzdHJ1Y3QgbXRrX3J0Y19kYXRhICpkYXRh
Ow0KPiAgfTsNCj4gIA0KPiAgI2VuZGlmIC8qIF9MSU5VWF9NRkRfTVQ2Mzk3X1JUQ19IXyAqLw0K
DQo=

