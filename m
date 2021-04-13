Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8B535D5FE
	for <lists+linux-pm@lfdr.de>; Tue, 13 Apr 2021 05:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240959AbhDMDgY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Apr 2021 23:36:24 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:50610 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S238980AbhDMDgX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Apr 2021 23:36:23 -0400
X-UUID: 7f31d8aaacd04ee98be674d7466c8656-20210413
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=IG3yM/hhJgI4HS5wGt30gHoTh2N5TgYAPQd9CFSLGVU=;
        b=i8XHIhZmfMskkSFm9k2AgslQZBZgOa32QS5qXZZbIvfe6lVKw7IyZ5f9zk8gV5sdQjI3iLdB1xpQICa8w7D1pcQn233o2PRZvRwvCqd5peRnPK6yWQ9k2C0rE1jnvZDTbWClSjZ8IGJFQXB2nHqodVBVPDaIeqa6eEHkev1ue7Q=;
X-UUID: 7f31d8aaacd04ee98be674d7466c8656-20210413
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 652302494; Tue, 13 Apr 2021 11:36:00 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 13 Apr
 2021 11:35:56 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 13 Apr 2021 11:35:55 +0800
Message-ID: <1618284955.25729.6.camel@mhfsdcap03>
Subject: Re: [PATCH 4/6] usb: xhci-mtk: add support runtime PM
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Ikjoon Jang <ikjn@chromium.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        <linux-usb@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, Tony Lindgren <tony@atomide.com>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 13 Apr 2021 11:35:55 +0800
In-Reply-To: <CAATdQgCjNbUKsJYZjr5wHbXV5y-7ZZrN=URKccCv1d+S4zFiDA@mail.gmail.com>
References: <1617874514-12282-1-git-send-email-chunfeng.yun@mediatek.com>
         <1617874514-12282-4-git-send-email-chunfeng.yun@mediatek.com>
         <CAATdQgArnkdmbZefF4h7xp6=j-wHLgdQs1K0cDv06sP4eVdHmw@mail.gmail.com>
         <1617958441.12105.39.camel@mhfsdcap03>
         <CAATdQgCjNbUKsJYZjr5wHbXV5y-7ZZrN=URKccCv1d+S4zFiDA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 0F74016DEA0EBF8425D7EB065E277E06D9AF29BCA93A4312D24DDEB9D2D3B32A2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gTW9uLCAyMDIxLTA0LTEyIGF0IDEzOjE0ICswODAwLCBJa2pvb24gSmFuZyB3cm90ZToNCj4g
T24gRnJpLCBBcHIgOSwgMjAyMSBhdCA0OjU0IFBNIENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVu
QG1lZGlhdGVrLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBPbiBGcmksIDIwMjEtMDQtMDkgYXQgMTM6
NDUgKzA4MDAsIElram9vbiBKYW5nIHdyb3RlOg0KPiA+ID4gT24gVGh1LCBBcHIgOCwgMjAyMSBh
dCA1OjM1IFBNIENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4gd3JvdGU6
DQo+ID4gPiA+DQo+ID4gPiA+IEEgZGVkaWNhdGVkIHdha2V1cCBpcnEgd2lsbCBiZSB1c2VkIHRv
IGhhbmRsZSBydW50aW1lIHN1c3BlbmQvcmVzdW1lLA0KPiA+ID4gPiB3ZSB1c2UgZGV2X3BtX3Nl
dF9kZWRpY2F0ZWRfd2FrZV9pcnEgQVBJIHRvIHRha2UgY2FyZSBvZiByZXF1ZXN0aW5nDQo+ID4g
PiA+IGFuZCBhdHRhY2hpbmcgd2FrZXVwIGlycSwgdGhlbiB0aGUgc3VzcGVuZC9yZXN1bWUgZnJh
bWV3b3JrIHdpbGwgaGVscA0KPiA+ID4gPiB0byBlbmFibGUvZGlzYWJsZSB3YWtldXAgaXJxLg0K
PiA+ID4gPg0KPiA+ID4gPiBUaGUgcnVudGltZSBQTSBpcyBkZWZhdWx0IG9mZiBzaW5jZSBzb21l
IHBsYXRmb3JtcyBtYXkgbm90IHN1cHBvcnQgaXQuDQo+ID4gPiA+IHVzZXJzIGNhbiBlbmFibGUg
aXQgdmlhIHBvd2VyL2NvbnRyb2wgKHNldCAiYXV0byIpIGluIHN5c2ZzLg0KPiA+ID4gPg0KPiA+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5j
b20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay5jIHwg
MTQwICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLQ0KPiA+ID4gPiAgMSBmaWxl
IGNoYW5nZWQsIDEyNCBpbnNlcnRpb25zKCspLCAxNiBkZWxldGlvbnMoLSkNCj4gPiA+ID4NCj4g
PiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1tdGsuYyBiL2RyaXZlcnMv
dXNiL2hvc3QveGhjaS1tdGsuYw0KPiA+ID4gPiBpbmRleCBhNzQ3NjRhYjkxNGEuLjMwOTI3ZjQw
NjRkNCAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay5jDQo+
ID4gPiA+ICsrKyBiL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1tdGsuYw0KWy4uLl0NCj4gPiA+ID4N
Cj4gPiA+ID4gK3N0YXRpYyBpbnQgY2hlY2tfcmh1Yl9zdGF0dXMoc3RydWN0IHhoY2lfaGNkICp4
aGNpLCBzdHJ1Y3QgeGhjaV9odWIgKnJodWIpDQo+ID4gPiA+ICt7DQo+ID4gPiA+ICsgICAgICAg
dTMyIHN1c3BlbmRlZF9wb3J0czsNCj4gPiA+ID4gKyAgICAgICB1MzIgc3RhdHVzOw0KPiA+ID4g
PiArICAgICAgIGludCBudW1fcG9ydHM7DQo+ID4gPiA+ICsgICAgICAgaW50IGk7DQo+ID4gPiA+
ICsNCj4gPiA+ID4gKyAgICAgICBudW1fcG9ydHMgPSByaHViLT5udW1fcG9ydHM7DQo+ID4gPiA+
ICsgICAgICAgc3VzcGVuZGVkX3BvcnRzID0gcmh1Yi0+YnVzX3N0YXRlLnN1c3BlbmRlZF9wb3J0
czsNCj4gPiA+ID4gKyAgICAgICBmb3IgKGkgPSAwOyBpIDwgbnVtX3BvcnRzOyBpKyspIHsNCj4g
PiA+ID4gKyAgICAgICAgICAgICAgIGlmICghKHN1c3BlbmRlZF9wb3J0cyAmIEJJVChpKSkpIHsN
Cj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgc3RhdHVzID0gcmVhZGwocmh1Yi0+cG9y
dHNbaV0tPmFkZHIpOw0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICBpZiAoc3RhdHVz
ICYgUE9SVF9DT05ORUNUKQ0KPiA+ID4NCj4gPiA+IFNvIHRoaXMgcG1fcnVudGltZSBzdXBwb3J0
IGlzIGFjdGl2YXRlZCBvbmx5IHdoZW4gdGhlcmUncyBubyBkZXZpY2VzDQo+ID4gPiBjb25uZWN0
ZWQgYXQgYWxsPw0KPiA+IE5vLCBpZiB0aGUgY29ubmVjdGVkIGRldmljZXMgYWxzbyBzdXBwb3J0
IHJ1bnRpbWUgc3VzcGVuZCwgaXQgd2lsbCBlbnRlcg0KPiA+IHN1c3BlbmQgbW9kZSB3aGVuIG5v
IGRhdGEgdHJhbnNmZXIsIHRoZW4gdGhlIGNvbnRyb2xsZXIgY2FuIGVudGVyDQo+ID4gc3VzcGVu
ZCB0b28NCj4gPiA+IEkgdGhpbmsgdGhpcyB3aWxsIGFsd2F5cyByZXR1cm4gLUVCVVNZIHdpdGgg
bXkgYm9hcmQgaGF2aW5nIGFuIG9uLWJvYXJkIGh1Yg0KPiA+ID4gY29ubmVjdGVkIHRvIGJvdGgg
cmh1YnMuDQo+ID4gdGhlIG9uLWJvYXJkIGh1YiBzdXBwb3J0cyBydW50aW1lIHN1c3BlbmQgYnkg
ZGVmYXVsdCwgc28gaWYgbm8gZGV2aWNlcw0KPiA+IGNvbm5lY3RlZCwgaXQgd2lsbCBlbnRlciBz
dXNwZW5kDQo+IA0KPiBTb3JyeSwgeW91J3JlIGNvcnJlY3QuIEkgd2FzIGNvbmZ1c2VkIHRoYXQg
dGhlIGNvbmRpdGlvbiB3YXMNCj4gKHN1c3BlbmRlZCAmJiBjb25uZWN0KQ0KPiBNeSBvbi1ib2Fy
ZCBodWIgY29ubmVjdGVkIHRvIHJodWIgaXMgYWx3YXlzIGluIGEgc3VzcGVuZGVkIHN0YXRlDQo+
IHdoZW5ldmVyIGl0J3MgY2FsbGVkLg0KPiANCj4gSG93ZXZlciwgSSBkb24ndCB0aGluayB0aGlz
IGNvdWxkIHJldHVybiAtRUJVU1kNCj4gcnBtX3N1c3BlbmQoKSBvbmx5IGJlIGNhbGxlZCB3aGVu
IGFsbCB0aGUgZGVzY2VuZGFudHMgYXJlIGluIHNsZWVwIGFscmVhZHkuDQpZb3UgbWVhbiB3ZSBj
YW4gZHJvcCB0aGUgYnVzIGNoZWNrPyANCklmIFBNIGFscmVhZHkgdGFrZXMgY2FyZSBvZiBjaGls
ZHJlbiBjb3VudCwgSSB0aGluayBubyBuZWVkIGNoZWNrIGl0DQphbnltb3JlLg0KPiBEaWQgeW91
IHNlZSBhbnkgY2FzZXMgb2YgdGhpcyBmdW5jdGlvbiByZXR1cm5pbmcgLUVCVVNZIG9yIGFueSBj
b25jZXJucyBvbiBoZXJlPw0KTm8sIEkgZGlkbid0IHNlZSBpdCBiZWZvcmUuDQoNClRoYW5rcw0K
DQo+IA0KPiANCj4gPg0KPiA+ID4NCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICByZXR1cm4gLUVCVVNZOw0KPiA+ID4gPiArICAgICAgICAgICAgICAgfQ0KPiA+ID4gPiAr
ICAgICAgIH0NCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAgIHJldHVybiAwOw0KPiA+ID4gPiAr
fQ0KPiA+ID4gPiArDQo+ID4gPiA+ICsvKg0KPiA+ID4gPiArICogY2hlY2sgdGhlIGJ1cyB3aGV0
aGVyIGl0IGNvdWxkIHN1c3BlbmQgb3Igbm90DQo+ID4gPiA+ICsgKiB0aGUgYnVzIHdpbGwgc3Vz
cGVuZCBpZiB0aGUgZG93bnN0cmVhbSBwb3J0cyBhcmUgYWxyZWFkeSBzdXNwZW5kZWQsDQo+ID4g
PiA+ICsgKiBvciBubyBkZXZpY2VzIGNvbm5lY3RlZC4NCj4gPiA+ID4gKyAqLw0KPiA+ID4gPiAr
c3RhdGljIGludCBjaGVja19idXNfc3RhdHVzKHN0cnVjdCB4aGNpX2hjZCAqeGhjaSkNCj4gPiA+
ID4gK3sNCj4gPiA+ID4gKyAgICAgICBpbnQgcmV0Ow0KPiA+ID4gPiArDQo+ID4gPiA+ICsgICAg
ICAgcmV0ID0gY2hlY2tfcmh1Yl9zdGF0dXMoeGhjaSwgJnhoY2ktPnVzYjNfcmh1Yik7DQo+ID4g
PiA+ICsgICAgICAgaWYgKHJldCkNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIHJldHVybiByZXQ7
DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAgICByZXR1cm4gY2hlY2tfcmh1Yl9zdGF0dXMoeGhj
aSwgJnhoY2ktPnVzYjJfcmh1Yik7DQo+ID4gPiA+ICt9DQo+ID4gPiA+ICsNCj4gPiA+ID4gK3N0
YXRpYyBpbnQgX19tYXliZV91bnVzZWQgeGhjaV9tdGtfcnVudGltZV9zdXNwZW5kKHN0cnVjdCBk
ZXZpY2UgKmRldikNCj4gPiA+ID4gK3sNCj4gPiA+ID4gKyAgICAgICBzdHJ1Y3QgeGhjaV9oY2Rf
bXRrICAqbXRrID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ID4gPiA+ICsgICAgICAgc3RydWN0
IHhoY2lfaGNkICp4aGNpID0gaGNkX3RvX3hoY2kobXRrLT5oY2QpOw0KPiA+ID4gPiArICAgICAg
IGludCByZXQgPSAwOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsgICAgICAgaWYgKHhoY2ktPnhoY19z
dGF0ZSkNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIHJldHVybiAtRVNIVVRET1dOOw0KPiA+ID4g
PiArDQo+ID4gPiA+ICsgICAgICAgaWYgKGRldmljZV9tYXlfd2FrZXVwKGRldikpIHsNCj4gPiA+
ID4gKyAgICAgICAgICAgICAgIHJldCA9IGNoZWNrX2J1c19zdGF0dXMoeGhjaSk7DQo+ID4gPiA+
ICsgICAgICAgICAgICAgICBpZiAoIXJldCkNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgcmV0ID0geGhjaV9tdGtfc3VzcGVuZChkZXYpOw0KPiA+ID4gPiArICAgICAgIH0NCj4gPiA+
ID4gKw0KPiA+ID4gPiArICAgICAgIC8qIC1FQlVTWTogbGV0IFBNIGF1dG9tYXRpY2FsbHkgcmVz
Y2hlZHVsZSBhbm90aGVyIGF1dG9zdXNwZW5kICovDQo+ID4gPiA+ICsgICAgICAgcmV0dXJuIHJl
dCA/IC1FQlVTWSA6IDA7DQo+ID4gPiA+ICt9DQo+ID4gPiA+ICsNCj4gPiA+ID4gK3N0YXRpYyBp
bnQgX19tYXliZV91bnVzZWQgeGhjaV9tdGtfcnVudGltZV9yZXN1bWUoc3RydWN0IGRldmljZSAq
ZGV2KQ0KPiA+ID4gPiArew0KPiA+ID4gPiArICAgICAgIHN0cnVjdCB4aGNpX2hjZF9tdGsgICpt
dGsgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gPiA+ID4gKyAgICAgICBzdHJ1Y3QgeGhjaV9o
Y2QgKnhoY2kgPSBoY2RfdG9feGhjaShtdGstPmhjZCk7DQo+ID4gPiA+ICsgICAgICAgaW50IHJl
dCA9IDA7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAgICBpZiAoeGhjaS0+eGhjX3N0YXRlKQ0K
PiA+ID4gPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FU0hVVERPV047DQo+ID4gPiA+ICsNCj4g
PiA+ID4gKyAgICAgICBpZiAoZGV2aWNlX21heV93YWtldXAoZGV2KSkNCj4gPiA+ID4gKyAgICAg
ICAgICAgICAgIHJldCA9IHhoY2lfbXRrX3Jlc3VtZShkZXYpOw0KPiA+ID4gPiArDQo+ID4gPiA+
ICsgICAgICAgcmV0dXJuIHJldDsNCj4gPiA+ID4gK30NCj4gPiA+ID4gKw0KPiA+ID4gPiAgc3Rh
dGljIGNvbnN0IHN0cnVjdCBkZXZfcG1fb3BzIHhoY2lfbXRrX3BtX29wcyA9IHsNCj4gPiA+ID4g
ICAgICAgICBTRVRfU1lTVEVNX1NMRUVQX1BNX09QUyh4aGNpX210a19zdXNwZW5kLCB4aGNpX210
a19yZXN1bWUpDQo+ID4gPiA+ICsgICAgICAgU0VUX1JVTlRJTUVfUE1fT1BTKHhoY2lfbXRrX3J1
bnRpbWVfc3VzcGVuZCwNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgeGhjaV9t
dGtfcnVudGltZV9yZXN1bWUsIE5VTEwpDQo+ID4gPiA+ICB9Ow0KPiA+ID4gPiAtI2RlZmluZSBE
RVZfUE1fT1BTIElTX0VOQUJMRUQoQ09ORklHX1BNKSA/ICZ4aGNpX210a19wbV9vcHMgOiBOVUxM
DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyNkZWZpbmUgREVWX1BNX09QUyAoSVNfRU5BQkxFRChDT05G
SUdfUE0pID8gJnhoY2lfbXRrX3BtX29wcyA6IE5VTEwpDQo+ID4gPiA+DQo+ID4gPiA+ICBzdGF0
aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBtdGtfeGhjaV9vZl9tYXRjaFtdID0gew0KPiA+
ID4gPiAgICAgICAgIHsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTczLXhoY2kifSwNCj4g
PiA+ID4gLS0NCj4gPiA+ID4gMi4xOC4wDQo+ID4gPiA+DQo+ID4NCg0K

