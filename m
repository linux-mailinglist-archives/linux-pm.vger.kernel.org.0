Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5F6356753
	for <lists+linux-pm@lfdr.de>; Wed,  7 Apr 2021 10:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243751AbhDGI53 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Apr 2021 04:57:29 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:46942 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232509AbhDGI52 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Apr 2021 04:57:28 -0400
X-UUID: cecec5c2925846dd8b9eb650043c563f-20210407
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=zplQN6NoPcssa1o1o1+M/kM9dwPi858NTpFtVnCbbak=;
        b=Wdgq6hrnGMtH+WeYkjfzn+S0K5jm2zh0FX1byLz7I+qtgW794le7JLOIBHkqnA8fNifjBvGHtl5lexNA3McVT1Wxr3a3BcZrZlWN75rEICA1/9FClYUC90tQBckjE6affb9sTRtmGaN4oz14qbX2kZjSJ0x1xy8SaQCBKpkyzQE=;
X-UUID: cecec5c2925846dd8b9eb650043c563f-20210407
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <michael.kao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2063600223; Wed, 07 Apr 2021 16:49:15 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 7 Apr 2021 16:49:13 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 7 Apr 2021 16:49:14 +0800
Message-ID: <1617785354.12846.0.camel@mtksdccf07>
Subject: Re: [v7, 3/3] thermal: mediatek: add another get_temp ops for
 thermal sensors
From:   Michael Kao <michael.kao@mediatek.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     Zhang Rui <rui.zhang@intel.com>, <linux-pm@vger.kernel.org>,
        <srv_heupstream@mediatek.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>, <hsinyi@chromium.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Wed, 7 Apr 2021 16:49:14 +0800
In-Reply-To: <20210316070144.28440-4-michael.kao@mediatek.com>
References: <20210316070144.28440-1-michael.kao@mediatek.com>
         <20210316070144.28440-4-michael.kao@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgTWFpbnRhaW5lcnMsDQoNCkdlbnRsZSBwaW4gZm9yIHRoaXMgcGF0Y2guDQoNClRoYW5rcw0K
DQpPbiBUdWUsIDIwMjEtMDMtMTYgYXQgMTU6MDEgKzA4MDAsIE1pY2hhZWwgS2FvIHdyb3RlOg0K
PiBQcm92aWRlIHRoZXJtYWwgem9uZSB0byByZWFkIHRoZXJtYWwgc2Vuc29yDQo+IGluIHRoZSBT
b0MuIFdlIGNhbiByZWFkIGFsbCB0aGUgdGhlcm1hbCBzZW5zb3JzDQo+IHZhbHVlIGluIHRoZSBT
b0MgYnkgdGhlIG5vZGUgL3N5cy9jbGFzcy90aGVybWFsLw0KPiANCj4gSW4gbXRrX3RoZXJtYWxf
YmFua190ZW1wZXJhdHVyZSwgcmV0dXJuIC1FQUdBSU4gaW5zdGVhZCBvZiAtRUFDQ0VTUw0KPiBv
biB0aGUgZmlyc3QgcmVhZCBvZiBzZW5zb3IgdGhhdCBvZnRlbiBhcmUgYm9ndXMgdmFsdWVzLg0K
PiBUaGlzIGNhbiBhdm9pZCBmb2xsb3dpbmcgd2FybmluZyBvbiBib290Og0KPiANCj4gICB0aGVy
bWFsIHRoZXJtYWxfem9uZTY6IGZhaWxlZCB0byByZWFkIG91dCB0aGVybWFsIHpvbmUgKC0xMykN
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgS2FvIDxtaWNoYWVsLmthb0BtZWRpYXRlay5j
b20+DQo+IFNpZ25lZC1vZmYtYnk6IEhzaW4tWWkgV2FuZyA8aHNpbnlpQGNocm9taXVtLm9yZz4N
Cj4gLS0tDQo+ICBkcml2ZXJzL3RoZXJtYWwvbXRrX3RoZXJtYWwuYyB8IDEwMCArKysrKysrKysr
KysrKysrKysrKysrKysrLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNzUgaW5zZXJ0aW9u
cygrKSwgMjUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90aGVybWFs
L210a190aGVybWFsLmMgYi9kcml2ZXJzL3RoZXJtYWwvbXRrX3RoZXJtYWwuYw0KPiBpbmRleCAx
NDljNmQ3ZmQ1YTAuLjU3ZTRmMDhhOTQ3ZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy90aGVybWFs
L210a190aGVybWFsLmMNCj4gKysrIGIvZHJpdmVycy90aGVybWFsL210a190aGVybWFsLmMNCj4g
QEAgLTI0NSw2ICsyNDUsMTEgQEAgZW51bSBtdGtfdGhlcm1hbF92ZXJzaW9uIHsNCj4gIA0KPiAg
c3RydWN0IG10a190aGVybWFsOw0KPiAgDQo+ICtzdHJ1Y3QgbXRrX3RoZXJtYWxfem9uZSB7DQo+
ICsJc3RydWN0IG10a190aGVybWFsICptdDsNCj4gKwlpbnQgaWQ7DQo+ICt9Ow0KPiArDQo+ICBz
dHJ1Y3QgdGhlcm1hbF9iYW5rX2NmZyB7DQo+ICAJdW5zaWduZWQgaW50IG51bV9zZW5zb3JzOw0K
PiAgCWNvbnN0IGludCAqc2Vuc29yczsNCj4gQEAgLTYzNyw2ICs2NDIsMzAgQEAgc3RhdGljIHZv
aWQgbXRrX3RoZXJtYWxfcHV0X2Jhbmsoc3RydWN0IG10a190aGVybWFsX2JhbmsgKmJhbmspDQo+
ICAJCW11dGV4X3VubG9jaygmbXQtPmxvY2spOw0KPiAgfQ0KPiAgDQo+ICtzdGF0aWMgdTMyIF9n
ZXRfc2Vuc29yX3RlbXAoc3RydWN0IG10a190aGVybWFsICptdCwgaW50IGlkKQ0KPiArew0KPiAr
CXUzMiByYXc7DQo+ICsJaW50IHRlbXA7DQo+ICsNCj4gKwlyYXcgPSByZWFkbChtdC0+dGhlcm1h
bF9iYXNlICsgbXQtPmNvbmYtPm1zcltpZF0pOw0KPiArDQo+ICsJaWYgKG10LT5jb25mLT52ZXJz
aW9uID09IE1US19USEVSTUFMX1YxKQ0KPiArCQl0ZW1wID0gcmF3X3RvX21jZWxzaXVzX3YxKG10
LCBpZCwgcmF3KTsNCj4gKwllbHNlDQo+ICsJCXRlbXAgPSByYXdfdG9fbWNlbHNpdXNfdjIobXQs
IGlkLCByYXcpOw0KPiArDQo+ICsJLyoNCj4gKwkgKiBUaGUgZmlyc3QgcmVhZCBvZiBhIHNlbnNv
ciBvZnRlbiBjb250YWlucyB2ZXJ5IGhpZ2ggYm9ndXMNCj4gKwkgKiB0ZW1wZXJhdHVyZSB2YWx1
ZS4gRmlsdGVyIHRoZXNlIG91dCBzbyB0aGF0IHRoZSBzeXN0ZW0gZG9lcw0KPiArCSAqIG5vdCBp
bW1lZGlhdGVseSBzaHV0IGRvd24uDQo+ICsJICovDQo+ICsNCj4gKwlpZiAodGVtcCA+IDIwMDAw
MCkNCj4gKwkJcmV0dXJuIC1FQUdBSU47DQo+ICsJZWxzZQ0KPiArCQlyZXR1cm4gdGVtcDsNCj4g
K30NCj4gKw0KPiAgLyoqDQo+ICAgKiBtdGtfdGhlcm1hbF9iYW5rX3RlbXBlcmF0dXJlIC0gZ2V0
IHRoZSB0ZW1wZXJhdHVyZSBvZiBhIGJhbmsNCj4gICAqIEBiYW5rOglUaGUgYmFuaw0KPiBAQCAt
NjQ3LDI4ICs2NzYsMTEgQEAgc3RhdGljIHZvaWQgbXRrX3RoZXJtYWxfcHV0X2Jhbmsoc3RydWN0
IG10a190aGVybWFsX2JhbmsgKmJhbmspDQo+ICBzdGF0aWMgaW50IG10a190aGVybWFsX2Jhbmtf
dGVtcGVyYXR1cmUoc3RydWN0IG10a190aGVybWFsX2JhbmsgKmJhbmspDQo+ICB7DQo+ICAJc3Ry
dWN0IG10a190aGVybWFsICptdCA9IGJhbmstPm10Ow0KPiAtCWNvbnN0IHN0cnVjdCBtdGtfdGhl
cm1hbF9kYXRhICpjb25mID0gbXQtPmNvbmY7DQo+ICAJaW50IGksIHRlbXAgPSBJTlRfTUlOLCBt
YXggPSBJTlRfTUlOOw0KPiAtCXUzMiByYXc7DQo+IC0NCj4gLQlmb3IgKGkgPSAwOyBpIDwgY29u
Zi0+YmFua19kYXRhW2JhbmstPmlkXS5udW1fc2Vuc29yczsgaSsrKSB7DQo+IC0JCXJhdyA9IHJl
YWRsKG10LT50aGVybWFsX2Jhc2UgKyBjb25mLT5tc3JbaV0pOw0KPiAgDQo+IC0JCWlmIChtdC0+
Y29uZi0+dmVyc2lvbiA9PSBNVEtfVEhFUk1BTF9WMSkgew0KPiAtCQkJdGVtcCA9IHJhd190b19t
Y2Vsc2l1c192MSgNCj4gLQkJCQltdCwgY29uZi0+YmFua19kYXRhW2JhbmstPmlkXS5zZW5zb3Jz
W2ldLCByYXcpOw0KPiAtCQl9IGVsc2Ugew0KPiAtCQkJdGVtcCA9IHJhd190b19tY2Vsc2l1c192
MigNCj4gLQkJCQltdCwgY29uZi0+YmFua19kYXRhW2JhbmstPmlkXS5zZW5zb3JzW2ldLCByYXcp
Ow0KPiAtCQl9DQo+ICsJZm9yIChpID0gMDsgaSA8IG10LT5jb25mLT5iYW5rX2RhdGFbYmFuay0+
aWRdLm51bV9zZW5zb3JzOyBpKyspIHsNCj4gIA0KPiAtCQkvKg0KPiAtCQkgKiBUaGUgZmlyc3Qg
cmVhZCBvZiBhIHNlbnNvciBvZnRlbiBjb250YWlucyB2ZXJ5IGhpZ2ggYm9ndXMNCj4gLQkJICog
dGVtcGVyYXR1cmUgdmFsdWUuIEZpbHRlciB0aGVzZSBvdXQgc28gdGhhdCB0aGUgc3lzdGVtIGRv
ZXMNCj4gLQkJICogbm90IGltbWVkaWF0ZWx5IHNodXQgZG93bi4NCj4gLQkJICovDQo+IC0JCWlm
ICh0ZW1wID4gMjAwMDAwKQ0KPiAtCQkJdGVtcCA9IDA7DQo+ICsJCXRlbXAgPSBfZ2V0X3NlbnNv
cl90ZW1wKG10LCBpKTsNCj4gIA0KPiAgCQlpZiAodGVtcCA+IG1heCkNCj4gIAkJCW1heCA9IHRl
bXA7DQo+IEBAIC02NzksNyArNjkxLDggQEAgc3RhdGljIGludCBtdGtfdGhlcm1hbF9iYW5rX3Rl
bXBlcmF0dXJlKHN0cnVjdCBtdGtfdGhlcm1hbF9iYW5rICpiYW5rKQ0KPiAgDQo+ICBzdGF0aWMg
aW50IG10a19yZWFkX3RlbXAodm9pZCAqZGF0YSwgaW50ICp0ZW1wZXJhdHVyZSkNCj4gIHsNCj4g
LQlzdHJ1Y3QgbXRrX3RoZXJtYWwgKm10ID0gZGF0YTsNCj4gKwlzdHJ1Y3QgbXRrX3RoZXJtYWxf
em9uZSAqdHogPSBkYXRhOw0KPiArCXN0cnVjdCBtdGtfdGhlcm1hbCAqbXQgPSB0ei0+bXQ7DQo+
ICAJaW50IGk7DQo+ICAJaW50IHRlbXBtYXggPSBJTlRfTUlOOw0KPiAgDQo+IEBAIC02OTgsMTAg
KzcxMSwyOCBAQCBzdGF0aWMgaW50IG10a19yZWFkX3RlbXAodm9pZCAqZGF0YSwgaW50ICp0ZW1w
ZXJhdHVyZSkNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gIA0KPiArc3RhdGljIGludCBtdGtfcmVh
ZF9zZW5zb3JfdGVtcCh2b2lkICpkYXRhLCBpbnQgKnRlbXBlcmF0dXJlKQ0KPiArew0KPiArCXN0
cnVjdCBtdGtfdGhlcm1hbF96b25lICp0eiA9IGRhdGE7DQo+ICsJc3RydWN0IG10a190aGVybWFs
ICptdCA9IHR6LT5tdDsNCj4gKwlpbnQgaWQgPSB0ei0+aWQgLSAxOw0KPiArDQo+ICsJaWYgKGlk
IDwgMCkNCj4gKwkJcmV0dXJuIC1FQUNDRVM7DQo+ICsNCj4gKwkqdGVtcGVyYXR1cmUgPSBfZ2V0
X3NlbnNvcl90ZW1wKG10LCBpZCk7DQo+ICsNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gKw0KPiAg
c3RhdGljIGNvbnN0IHN0cnVjdCB0aGVybWFsX3pvbmVfb2ZfZGV2aWNlX29wcyBtdGtfdGhlcm1h
bF9vcHMgPSB7DQo+ICAJLmdldF90ZW1wID0gbXRrX3JlYWRfdGVtcCwNCj4gIH07DQo+ICANCj4g
K3N0YXRpYyBjb25zdCBzdHJ1Y3QgdGhlcm1hbF96b25lX29mX2RldmljZV9vcHMgbXRrX3RoZXJt
YWxfc2Vuc29yX29wcyA9IHsNCj4gKwkuZ2V0X3RlbXAgPSBtdGtfcmVhZF9zZW5zb3JfdGVtcCwN
Cj4gK307DQo+ICsNCj4gIHN0YXRpYyB2b2lkIG10a190aGVybWFsX2luaXRfYmFuayhzdHJ1Y3Qg
bXRrX3RoZXJtYWwgKm10LCBpbnQgbnVtLA0KPiAgCQkJCSAgdTMyIGFwbWl4ZWRfcGh5c19iYXNl
LCB1MzIgYXV4YWRjX3BoeXNfYmFzZSwNCj4gIAkJCQkgIGludCBjdHJsX2lkKQ0KPiBAQCAtOTky
LDYgKzEwMjMsNyBAQCBzdGF0aWMgaW50IG10a190aGVybWFsX3Byb2JlKHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYpDQo+ICAJdTY0IGF1eGFkY19waHlzX2Jhc2UsIGFwbWl4ZWRfcGh5c19i
YXNlOw0KPiAgCXN0cnVjdCB0aGVybWFsX3pvbmVfZGV2aWNlICp0emRldjsNCj4gIAl2b2lkIF9f
aW9tZW0gKmFwbWl4ZWRfYmFzZSwgKmF1eGFkY19iYXNlOw0KPiArCXN0cnVjdCBtdGtfdGhlcm1h
bF96b25lICp0ejsNCj4gIA0KPiAgCW10ID0gZGV2bV9remFsbG9jKCZwZGV2LT5kZXYsIHNpemVv
ZigqbXQpLCBHRlBfS0VSTkVMKTsNCj4gIAlpZiAoIW10KQ0KPiBAQCAtMTA4MCwxMSArMTExMiwy
OSBAQCBzdGF0aWMgaW50IG10a190aGVybWFsX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpDQo+ICANCj4gIAlwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2LCBtdCk7DQo+ICANCj4g
LQl0emRldiA9IGRldm1fdGhlcm1hbF96b25lX29mX3NlbnNvcl9yZWdpc3RlcigmcGRldi0+ZGV2
LCAwLCBtdCwNCj4gLQkJCQkJCSAgICAgJm10a190aGVybWFsX29wcyk7DQo+IC0JaWYgKElTX0VS
Uih0emRldikpIHsNCj4gLQkJcmV0ID0gUFRSX0VSUih0emRldik7DQo+IC0JCWdvdG8gZXJyX2Rp
c2FibGVfY2xrX3BlcmlfdGhlcm07DQo+ICsJZm9yIChpID0gMDsgaSA8IG10LT5jb25mLT5udW1f
c2Vuc29ycyArIDE7IGkrKykgew0KPiArCQl0eiA9IGRldm1fa21hbGxvYygmcGRldi0+ZGV2LCBz
aXplb2YoKnR6KSwgR0ZQX0tFUk5FTCk7DQo+ICsJCWlmICghdHopDQo+ICsJCQlyZXR1cm4gLUVO
T01FTTsNCj4gKw0KPiArCQl0ei0+bXQgPSBtdDsNCj4gKwkJdHotPmlkID0gaTsNCj4gKw0KPiAr
CQl0emRldiA9IGRldm1fdGhlcm1hbF96b25lX29mX3NlbnNvcl9yZWdpc3RlcigmcGRldi0+ZGV2
LCBpLCB0eiwgKGkgPT0gMCkgPw0KPiArCQkJCQkJCSAgICAgJm10a190aGVybWFsX29wcyA6DQo+
ICsJCQkJCQkJICAgICAmbXRrX3RoZXJtYWxfc2Vuc29yX29wcyk7DQo+ICsNCj4gKwkJaWYgKElT
X0VSUih0emRldikpIHsNCj4gKwkJCWlmIChQVFJfRVJSKHR6ZGV2KSA9PSAtRU5PREVWKSB7DQo+
ICsJCQkJZGV2X3dhcm4oJnBkZXYtPmRldiwNCj4gKwkJCQkJICJzZW5zb3IgJWQgbm90IHJlZ2lz
dGVyZWQgaW4gdGhlcm1hbCB6b25lIGluIGR0XG4iLCBpKTsNCj4gKwkJCQljb250aW51ZTsNCj4g
KwkJCX0NCj4gKwkJCWlmIChQVFJfRVJSKHR6ZGV2KSA9PSAtRUFDQ0VTKSB7DQo+ICsJCQkJcmV0
ID0gUFRSX0VSUih0emRldik7DQo+ICsJCQkJZ290byBlcnJfZGlzYWJsZV9jbGtfcGVyaV90aGVy
bTsNCj4gKwkJCX0NCj4gKwkJfQ0KPiAgCX0NCj4gIA0KPiAgCXJldHVybiAwOw0KDQo=

