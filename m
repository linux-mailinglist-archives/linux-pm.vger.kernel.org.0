Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B961B06E6
	for <lists+linux-pm@lfdr.de>; Mon, 20 Apr 2020 12:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725896AbgDTKws (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Apr 2020 06:52:48 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:18640 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725773AbgDTKws (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Apr 2020 06:52:48 -0400
X-UUID: 10f5262b28c749c5bcbed67e4ec0dd43-20200420
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=5ZSYvBnifQattuM6WwNJ4dWYpkcL8v4PWiqKlXsfHC4=;
        b=MQEGkVTEJjor7u4n/2Ncwn0pFev7mIhXwkIn1iFmGxsdVQ+XfMW8QCKOgE413wlgZlHJD9/E/qlViXeL/UqqZjk17Kkox+fjXjzgAag0IXZAp4E9l8Nfg32vOzXyfOM59XvtcW1rnQ5gLi4ACDc+8HCFnvUdoHQtSvgCG286y1k=;
X-UUID: 10f5262b28c749c5bcbed67e4ec0dd43-20200420
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2007460060; Mon, 20 Apr 2020 18:52:44 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 20 Apr 2020 18:52:38 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 20 Apr 2020 18:52:37 +0800
Message-ID: <1587379959.6297.2.camel@mtksdaap41>
Subject: Re: [PATCH v12 1/6] mfd: mt6397: Modify suspend/resume behavior
From:   Hsin-hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        "Richard Fontana" <rfontana@redhat.com>,
        <linux-rtc@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Frank Wunderlich <frank-w@public-files.de>,
        Ran Bi <ran.bi@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eddie Huang <eddie.huang@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Josef Friedl <josef.friedl@speed.at>,
        <srv_heupstream@mediatek.com>, Sebastian Reichel <sre@kernel.org>
Date:   Mon, 20 Apr 2020 18:52:39 +0800
In-Reply-To: <20200416084910.GX2167633@dell>
References: <1586333531-21641-1-git-send-email-hsin-hsiung.wang@mediatek.com>
         <1586333531-21641-2-git-send-email-hsin-hsiung.wang@mediatek.com>
         <20200416084910.GX2167633@dell>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 665BB53A9B209DF474DE368E25DAC4D6E7703353C21B189088EF792896EB3DFD2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksDQoNCk9uIFRodSwgMjAyMC0wNC0xNiBhdCAwOTo0OSArMDEwMCwgTGVlIEpvbmVzIHdyb3Rl
Og0KPiBPbiBXZWQsIDA4IEFwciAyMDIwLCBIc2luLUhzaXVuZyBXYW5nIHdyb3RlOg0KPiANCj4g
PiBTb21lIHBtaWNzIGRvbid0IG5lZWQgYmFja3VwIGludGVycnVwdCBzZXR0aW5ncywgc28gd2Ug
Y2hhbmdlIHRvIHVzZQ0KPiA+IHBtIG5vdGlmaWVyIGZvciB0aGUgcG1pY3Mgd2hpY2ggYXJlIG5l
Y2Vzc2FyeSB0byBzdG9yZSBzZXR0aW5ncy4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBIc2lu
LUhzaXVuZyBXYW5nIDxoc2luLWhzaXVuZy53YW5nQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4g
PiAgZHJpdmVycy9tZmQvbXQ2Mzk3LWNvcmUuYyAgICAgICB8IDMwIC0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KPiA+ICBkcml2ZXJzL21mZC9tdDYzOTctaXJxLmMgICAgICAgIHwgMzUg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4gPiAgaW5jbHVkZS9saW51eC9t
ZmQvbXQ2Mzk3L2NvcmUuaCB8ICAyICsrDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgMzYgaW5zZXJ0
aW9ucygrKSwgMzEgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bWZkL210NjM5Ny1jb3JlLmMgYi9kcml2ZXJzL21mZC9tdDYzOTctY29yZS5jDQo+ID4gaW5kZXgg
MDQzN2M4NS4uZDJlNzBkOCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21mZC9tdDYzOTctY29y
ZS5jDQo+ID4gKysrIGIvZHJpdmVycy9tZmQvbXQ2Mzk3LWNvcmUuYw0KPiA+IEBAIC0xMDAsMzUg
KzEwMCw2IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbWZkX2NlbGwgbXQ2Mzk3X2RldnNbXSA9IHsN
Cj4gPiAgCX0NCj4gPiAgfTsNCj4gPiAgDQo+ID4gLSNpZmRlZiBDT05GSUdfUE1fU0xFRVANCj4g
PiAtc3RhdGljIGludCBtdDYzOTdfaXJxX3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KQ0KPiA+
IC17DQo+ID4gLQlzdHJ1Y3QgbXQ2Mzk3X2NoaXAgKmNoaXAgPSBkZXZfZ2V0X2RydmRhdGEoZGV2
KTsNCj4gPiAtDQo+ID4gLQlyZWdtYXBfd3JpdGUoY2hpcC0+cmVnbWFwLCBjaGlwLT5pbnRfY29u
WzBdLCBjaGlwLT53YWtlX21hc2tbMF0pOw0KPiA+IC0JcmVnbWFwX3dyaXRlKGNoaXAtPnJlZ21h
cCwgY2hpcC0+aW50X2NvblsxXSwgY2hpcC0+d2FrZV9tYXNrWzFdKTsNCj4gPiAtDQo+ID4gLQll
bmFibGVfaXJxX3dha2UoY2hpcC0+aXJxKTsNCj4gPiAtDQo+ID4gLQlyZXR1cm4gMDsNCj4gPiAt
fQ0KPiA+IC0NCj4gPiAtc3RhdGljIGludCBtdDYzOTdfaXJxX3Jlc3VtZShzdHJ1Y3QgZGV2aWNl
ICpkZXYpDQo+ID4gLXsNCj4gPiAtCXN0cnVjdCBtdDYzOTdfY2hpcCAqY2hpcCA9IGRldl9nZXRf
ZHJ2ZGF0YShkZXYpOw0KPiA+IC0NCj4gPiAtCXJlZ21hcF93cml0ZShjaGlwLT5yZWdtYXAsIGNo
aXAtPmludF9jb25bMF0sIGNoaXAtPmlycV9tYXNrc19jdXJbMF0pOw0KPiA+IC0JcmVnbWFwX3dy
aXRlKGNoaXAtPnJlZ21hcCwgY2hpcC0+aW50X2NvblsxXSwgY2hpcC0+aXJxX21hc2tzX2N1clsx
XSk7DQo+ID4gLQ0KPiA+IC0JZGlzYWJsZV9pcnFfd2FrZShjaGlwLT5pcnEpOw0KPiA+IC0NCj4g
PiAtCXJldHVybiAwOw0KPiA+IC19DQo+ID4gLSNlbmRpZg0KPiA+IC0NCj4gPiAtc3RhdGljIFNJ
TVBMRV9ERVZfUE1fT1BTKG10NjM5N19wbV9vcHMsIG10NjM5N19pcnFfc3VzcGVuZCwNCj4gPiAt
CQkJbXQ2Mzk3X2lycV9yZXN1bWUpOw0KPiA+IC0NCj4gPiAgc3RydWN0IGNoaXBfZGF0YSB7DQo+
ID4gIAl1MzIgY2lkX2FkZHI7DQo+ID4gIAl1MzIgY2lkX3NoaWZ0Ow0KPiA+IEBAIC0yMzgsNyAr
MjA5LDYgQEAgc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgbXQ2Mzk3X2RyaXZlciA9IHsN
Cj4gPiAgCS5kcml2ZXIgPSB7DQo+ID4gIAkJLm5hbWUgPSAibXQ2Mzk3IiwNCj4gPiAgCQkub2Zf
bWF0Y2hfdGFibGUgPSBvZl9tYXRjaF9wdHIobXQ2Mzk3X29mX21hdGNoKSwNCj4gPiAtCQkucG0g
PSAmbXQ2Mzk3X3BtX29wcywNCj4gPiAgCX0sDQo+ID4gIAkuaWRfdGFibGUgPSBtdDYzOTdfaWQs
DQo+ID4gIH07DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWZkL210NjM5Ny1pcnEuYyBiL2Ry
aXZlcnMvbWZkL210NjM5Ny1pcnEuYw0KPiA+IGluZGV4IGIyZDNjZTEuLjI5MjQ5MTkgMTAwNjQ0
DQo+ID4gLS0tIGEvZHJpdmVycy9tZmQvbXQ2Mzk3LWlycS5jDQo+ID4gKysrIGIvZHJpdmVycy9t
ZmQvbXQ2Mzk3LWlycS5jDQo+ID4gQEAgLTksNiArOSw3IEBADQo+ID4gICNpbmNsdWRlIDxsaW51
eC9vZl9pcnEuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KPiA+
ICAjaW5jbHVkZSA8bGludXgvcmVnbWFwLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9zdXNwZW5k
Lmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9tZmQvbXQ2MzIzL2NvcmUuaD4NCj4gPiAgI2luY2x1
ZGUgPGxpbnV4L21mZC9tdDYzMjMvcmVnaXN0ZXJzLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9t
ZmQvbXQ2Mzk3L2NvcmUuaD4NCj4gPiBAQCAtODEsNyArODIsNyBAQCBzdGF0aWMgc3RydWN0IGly
cV9jaGlwIG10NjM5N19pcnFfY2hpcCA9IHsNCj4gPiAgc3RhdGljIHZvaWQgbXQ2Mzk3X2lycV9o
YW5kbGVfcmVnKHN0cnVjdCBtdDYzOTdfY2hpcCAqbXQ2Mzk3LCBpbnQgcmVnLA0KPiA+ICAJCQkJ
ICBpbnQgaXJxYmFzZSkNCj4gPiAgew0KPiA+IC0JdW5zaWduZWQgaW50IHN0YXR1czsNCj4gPiAr
CXVuc2lnbmVkIGludCBzdGF0dXMgPSAwOw0KPiANCj4gVGhpcyBsb29rcyBsaWtlIGFuIHVucmVs
YXRlZCBjaGFuZ2UsIG5vPw0KPiANCg0KSXQgaXMgdG8gZml4IHRoZSBjb3Zlcml0eSBkZWZlY3Qu
DQoNCj4gPiAgCWludCBpLCBpcnEsIHJldDsNCj4gPiAgDQo+ID4gIAlyZXQgPSByZWdtYXBfcmVh
ZChtdDYzOTctPnJlZ21hcCwgcmVnLCAmc3RhdHVzKTsNCj4gPiBAQCAtMTI4LDYgKzEyOSwzNiBA
QCBzdGF0aWMgY29uc3Qgc3RydWN0IGlycV9kb21haW5fb3BzIG10NjM5N19pcnFfZG9tYWluX29w
cyA9IHsNCj4gPiAgCS5tYXAgPSBtdDYzOTdfaXJxX2RvbWFpbl9tYXAsDQo+ID4gIH07DQo+IA0K
PiBPdGhlciB0aGFuIHRoYXQuDQo+IA0KPiBGb3IgbXkgb3duIHJlZmVyZW5jZToNCj4gICBBY2tl
ZC1mb3ItTUZELWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPg0KPiANClRoYW5r
cyBmb3IgeW91ciByZXZpZXcuIEkgd2lsbCBhZGQgaXQgaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0K

