Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 474B21BD9D1
	for <lists+linux-pm@lfdr.de>; Wed, 29 Apr 2020 12:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgD2Kjn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Apr 2020 06:39:43 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:39951 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726355AbgD2Kjn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Apr 2020 06:39:43 -0400
X-UUID: 653c9dc151524c91b10580ef3b03cc5d-20200429
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=GttMsEeHxSRQEiWkFwaLHZKTBEqyMow0zfNFhprWC1Y=;
        b=CmfCYSMo9Co6NOO7EqlVw5NZWDuDSk4MSEvRc9ZiZqMbH8En8VWFQHfzvRKxlarc4IBi2/tLy0JfjKeHBX8+Ny87PW1quQuQjKyjgm4jAvctNW3308aKiB/qiieaTEyKF/v5hDLxhNkKdSftg/N4ttO2jwVu48kGhsHXcaYe2Y4=;
X-UUID: 653c9dc151524c91b10580ef3b03cc5d-20200429
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <michael.kao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1213859366; Wed, 29 Apr 2020 18:39:38 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 29 Apr 2020 18:39:34 +0800
Received: from [172.21.84.99] (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 29 Apr 2020 18:39:34 +0800
Message-ID: <1588156776.3573.1.camel@mtksdccf07>
Subject: Re: [PATCH] thermal: power_allocate: add upper and lower limits
From:   Michael Kao <michael.kao@mediatek.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
CC:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>, <hsinyi@chromium.org>,
        <linux-pm@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Wed, 29 Apr 2020 18:39:36 +0800
In-Reply-To: <accb83e0-ffbe-b6e3-6bf9-e7cc8b9fe19c@arm.com>
References: <20200424071601.2636-1-michael.kao@mediatek.com>
         <accb83e0-ffbe-b6e3-6bf9-e7cc8b9fe19c@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gRnJpLCAyMDIwLTA0LTI0IGF0IDEwOjIyICswMTAwLCBMdWthc3ogTHViYSB3cm90ZToNCj4g
SGkgTWljaGFlbCwNCj4gDQo+IE9uIDQvMjQvMjAgODoxNiBBTSwgTWljaGFlbCBLYW8gd3JvdGU6
DQo+ID4gVGhlIHVwcGVyIGFuZCBsb3dlciBsaW1pdHMgb2YgdGhlcm1hbCB0aHJvdHRsZSBzdGF0
ZSBpbiB0aGUNCj4gPiBkZXZpY2UgdHJlZSBkbyBub3QgYXBwbHkgdG8gdGhlIHBvd2VyX2FsbG9j
YXRlIGdvdmVybm9yLg0KPiA+IEFkZCB0aGUgdXBwZXIgYW5kIGxvd2VyIGxpbWl0cyB0byB0aGUg
cG93ZXJfYWxsb2NhdGUgZ292ZXJub3IuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTWljaGFl
bCBLYW8gPG1pY2hhZWwua2FvQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMv
dGhlcm1hbC90aGVybWFsX2NvcmUuYyB8IDIgKy0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3RoZXJtYWwvdGhlcm1hbF9jb3JlLmMgYi9kcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3JlLmMN
Cj4gPiBpbmRleCA5YTMyMWRjNTQ4YzguLmY2ZmVlZDIyNjViZCAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3JlLmMNCj4gPiArKysgYi9kcml2ZXJzL3RoZXJtYWwv
dGhlcm1hbF9jb3JlLmMNCj4gPiBAQCAtNTk4LDcgKzU5OCw3IEBAIGludCBwb3dlcl9hY3Rvcl9z
ZXRfcG93ZXIoc3RydWN0IHRoZXJtYWxfY29vbGluZ19kZXZpY2UgKmNkZXYsDQo+ID4gICAJaWYg
KHJldCkNCj4gPiAgIAkJcmV0dXJuIHJldDsNCj4gPiAgIA0KPiA+IC0JaW5zdGFuY2UtPnRhcmdl
dCA9IHN0YXRlOw0KPiA+ICsJaW5zdGFuY2UtPnRhcmdldCA9IGNsYW1wX3ZhbChzdGF0ZSwgaW5z
dGFuY2UtPmxvd2VyLCBpbnN0YW5jZS0+dXBwZXIpOw0KPiA+ICAgCW11dGV4X2xvY2soJmNkZXYt
PmxvY2spOw0KPiA+ICAgCWNkZXYtPnVwZGF0ZWQgPSBmYWxzZTsNCj4gPiAgIAltdXRleF91bmxv
Y2soJmNkZXYtPmxvY2spOw0KPiA+IA0KPiANCj4gVGhhbmsgeW91IGZvciB0aGUgcGF0Y2ggYW5k
IGhhdmluZyB0byBsb29rIGF0IGl0LiBJIGhhdmUgc29tZSBjb25jZXJucw0KPiB3aXRoIHRoaXMg
YXBwcm9hY2guIExldCdzIGFuYWx5emUgaXQgZnVydGhlci4NCj4gDQo+IEluIGRlZmF1bHQgdGhl
IGNvb2xpbmcgZGV2aWNlcyBpbiB0aGUgdGhlcm1hbCB6b25lIHdoaWNoIGlzIHVzZWQgYnkgSVBB
DQo+IGRvIG5vdCBoYXZlIHRoaXMgJ2xvd2VyJyBhbmQgJ3VwcGVyJyBsaW1pdHMuIFRoZXkgYXJl
IHNldCB0bw0KPiBUSEVSTUFMX05PX0xJTUlUIGluIERUIHRvIGdpdmUgZnVsbCBjb250cm9sIHRv
IElQQSBvdmVyIHRoZSBzdGF0ZXMuDQo+IA0KPiBUaGlzIHRoZSBmdW5jdGlvbiAncG93ZXJfYWN0
b3Jfc2V0X3Bvd2VyJyBhY3R1YWxseSB0cmFuc2xhdGVzIGdyYW50ZWQNCj4gcG93ZXIgdG8gdGhl
IHN0YXRlIHRoYXQgZGV2aWNlIHdpbGwgcnVuIGZvciB0aGUgbmV4dCBwZXJpb2QuDQo+IFRoZSBJ
UEEgYWxnb3JpdGhtIGhhcyBhbHJlYWR5IHNwbGl0IHRoZSBwb3dlciBidWRnZXQuDQo+IE5vdyB3
aGF0IGhhcHBlbiB3aGVuIHRoZSAnbG93ZXInIHZhbHVlIHdpbGwgY2hhbmdlIHRoZSBzdGF0ZSB0
byBhIHN0YXRlDQo+IHdoaWNoIGNvbnN1bWVzIG1vcmUgcG93ZXIgdGhhbiB3YXMgY2FsY3VsYXRl
ZCBpbiB0aGUgSVBBIGFsZy4uLiBJdCB3aWxsDQo+IGJlY2FtZSB1bnN0YWJsZS4NCj4gDQo+IEkg
d291bGQgcmF0aGVyIHNlZSBhIGNoYW5nZSB3aGljaCB1c2VzIHRoZXNlICdsb3dlcicgYW5kICd1
cHBlcicgbGltaXRzDQo+IGJlZm9yZSB0aGUgSVBBIGRvIHRoZSBjYWxjdWxhdGlvbiBvZiB0aGUg
cG93ZXIgYnVkZ2V0LiBCdXQgdGhpcyB3YXNuJ3QNCj4gYSByZXF1aXJlbWVudCBhbmQgd2UgYXNz
dW1lZCB0aGF0IElQQSBoYXMgZnVsbCBjb250cm9sIG92ZXIgdGhlIGNvb2xpbmcNCj4gZGV2aWNl
ICh3aGljaCBJIGRlc2NyaWJlZCBhYm92ZSB3aXRoIHRoaXMgRFQgVEhFUk1BTF9OT19MSU1JVCku
DQo+IA0KPiBJcyB0aGVyZSBhIHByb2JsZW0gd2l0aCB5b3VyIHBsYXRmb3JtIHRoYXQgaXQgaGFz
IHRvIHByb3ZpZGUgc29tZQ0KPiBtaW5pbWFsIHBlcmZvcm1hbmNlLCBzbyB5b3UgdHJpZWQgdG8g
aW50cm9kdWNlIHRoaXMgY2xhbXBpbmc/DQo+IA0KPiBSZWdhcmRzLA0KPiBMdWthc3oNCg0KDQpI
aSBMdWthc3osDQoNCkkgcmVmZXIgdG8gdGhlIGRvY3VtZW50YXRpb24gc2V0dGluZ3Mgb2YgdGhl
IHRoZXJtYWwgZGV2aWNlIHRyZWUNCihEb2N1bWVudGF0aW9uIC8gZGV2aWNldHJlZSAvIGJpbmRp
bmdzIC8gdGhlcm1hbCAvIHRoZXJtYWwudHh0KS4NCg0KSXQgc2hvd3MgdGhhdCBjb29saW5nLWRl
dmljZSBpcyBhIG1hbmRhdG9yeSBwcm9wZXJ0eSwgc28gbWF4L21pbiBjb29saW5nDQpzdGF0ZSBz
aG91bGQgYmUgYWJsZSB0byBzdXBwb3J0IGluIGZyYW1ld29yayBwb2ludCBvZiB2aWV3Lg0KT3Ro
ZXJ3aXNlLCB0aGUgbGltaXRhdGlvbiBzaG91bGQgYmUgYWRkZWQgaW4gYmluZGluZyBkb2N1bWVu
dC4NCg0KRGlmZmVyZW50IGhhcmR3YXJlIG1lY2hhbmlzbXMgaGF2ZSBkaWZmZXJlbnQgaGVhdCBk
aXNzaXBhdGlvbg0KY2FwYWJpbGl0aWVzLg0KTGltaXRpbmcgdGhlIGlucHV0IGhlYXQgc291cmNl
IGNhbiBzbG93IGRvd24gdGhlIGhlYXQgYWNjdW11bGF0aW9uIGFuZA0KdGVtcGVyYXR1cmUgYnVy
c3QuDQpXZSB3YW50IHRvIHJlZHVjZSB0aGUgYWNjdW11bGF0aW9uIG9mIGhlYXQgYXQgaGlnaCB0
ZW1wZXJhdHVyZSBieQ0KbGltaXRpbmcgdGhlIG1pbmltdW0gZ2VhciBvZiB0aGVybWFsIHRocm90
dGxlLg0KDQpCZXN0IFJlZ2FyZHMsDQpNaWNoYWVsDQo=

