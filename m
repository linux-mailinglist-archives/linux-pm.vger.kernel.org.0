Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0602E216468
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jul 2020 05:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgGGDHl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jul 2020 23:07:41 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:17982 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726434AbgGGDHk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jul 2020 23:07:40 -0400
X-UUID: f822552349a74e6e92034b424d467864-20200707
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=T+ZuskSCtDAA8wvmKSdUy+6kIp3oOV+tNxuPtAN8RIA=;
        b=LkwLLfSif7S916Snxc0RHUvNY3tZB1YmzBpmcdLZnU0ScfDngkYuOWMxUEZBT/q2SbNzfXbDw8VJYqzo04rqkheH4/Eao9xUTVn8aG8ydIx1dRRsSRRFlgFFQFbAprNvNPlrP7294gxLTa9fYGCakv32lx2HlPOi9O9bEqm/2ls=;
X-UUID: f822552349a74e6e92034b424d467864-20200707
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <michael.kao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1077106017; Tue, 07 Jul 2020 11:07:33 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 7 Jul 2020 11:07:30 +0800
Received: from [172.21.84.99] (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 7 Jul 2020 11:07:25 +0800
Message-ID: <1594091245.20216.3.camel@mtksdccf07>
Subject: Re: [v4, 6/7] thermal: mediatek: add another get_temp ops for
 thermal sensors
From:   Michael Kao <michael.kao@mediatek.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, <hsinyi@chromium.org>,
        <linux-pm@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 7 Jul 2020 11:07:25 +0800
In-Reply-To: <fa43c55b-96c2-30c8-eb7e-983177dad13d@linaro.org>
References: <20200323121537.22697-1-michael.kao@mediatek.com>
         <20200323121537.22697-7-michael.kao@mediatek.com>
         <fa43c55b-96c2-30c8-eb7e-983177dad13d@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gRnJpLCAyMDIwLTA1LTIyIGF0IDE3OjMyICswMjAwLCBEYW5pZWwgTGV6Y2FubyB3cm90ZToN
Cj4gT24gMjMvMDMvMjAyMCAxMzoxNSwgTWljaGFlbCBLYW8gd3JvdGU6DQo+ID4gUHJvdmlkZSB0
aGVybWFsIHpvbmUgdG8gcmVhZCB0aGVybWFsIHNlbnNvcg0KPiA+IGluIHRoZSBTb0MuIFdlIGNh
biByZWFkIGFsbCB0aGUgdGhlcm1hbCBzZW5zb3JzDQo+ID4gdmFsdWUgaW4gdGhlIFNvQyBieSB0
aGUgbm9kZSAvc3lzL2NsYXNzL3RoZXJtYWwvDQo+ID4gDQo+ID4gSW4gbXRrX3RoZXJtYWxfYmFu
a190ZW1wZXJhdHVyZSwgcmV0dXJuIC1FQUdBSU4gaW5zdGVhZCBvZiAtRUFDQ0VTUw0KPiA+IG9u
IHRoZSBmaXJzdCByZWFkIG9mIHNlbnNvciB0aGF0IG9mdGVuIGFyZSBib2d1cyB2YWx1ZXMuDQo+
ID4gVGhpcyBjYW4gYXZvaWQgZm9sbG93aW5nIHdhcm5pbmcgb24gYm9vdDoNCj4gPiANCj4gPiAg
IHRoZXJtYWwgdGhlcm1hbF96b25lNjogZmFpbGVkIHRvIHJlYWQgb3V0IHRoZXJtYWwgem9uZSAo
LTEzKQ0KPiANCj4gV2hhdCB0aGUgc291cmNlIHByb2JsZW0gb2YgdGhlIHNlbnNvciByZXR1cm5p
bmcgYm9ndXMgdmFsdWVzPw0KDQo+IFRoZSB0aGVybWFsIGNvbnRyb2xsZXIgd2lsbCBkZXBlbmQg
b24gdGhlIEFVWEFEQyBtb2R1bGUgdG8gcmVhZCByYXcgZGF0YSBmcm9tIHNlbnNvci4NClNvbWV0
aW1lcyBpdCB3aWxsIHJlcG9ydCB3cm9uZyB2YWx1ZSBiZWNhdXNlIHRoZSBBVVhBREMgbm90IHJl
YWR5IG9yDQpvdGhlciBpc3N1ZS4NClRoZSB0aGVybWFsIGRyaXZlciBzaG91bGQgYWRkIHRoZSBq
dWRnZW1lbnQgdG8gcHJldmVudCB3cm9uZyB0ZW1wZXJhdHVyZQ0KdmFsdWUgdG8gY2F1c2UNCnN5
c3RlbSBpbW1lZGlhdGVseSBzaHV0IGRvd24uDQo+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IE1pY2hh
ZWwgS2FvIDxtaWNoYWVsLmthb0BtZWRpYXRlay5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogSHNp
bi1ZaSBXYW5nIDxoc2lueWlAY2hyb21pdW0ub3JnPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3Ro
ZXJtYWwvbXRrX3RoZXJtYWwuYyB8IDc0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKyst
LS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA2NyBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygt
KQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3RoZXJtYWwvbXRrX3RoZXJtYWwuYyBi
L2RyaXZlcnMvdGhlcm1hbC9tdGtfdGhlcm1hbC5jDQo+ID4gaW5kZXggNmI3ZWYxOTkzZDdlLi45
ZWFjYTQzMjkyMGUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy90aGVybWFsL210a190aGVybWFs
LmMNCj4gPiArKysgYi9kcml2ZXJzL3RoZXJtYWwvbXRrX3RoZXJtYWwuYw0KPiA+IEBAIC0yMjUs
NiArMjI1LDExIEBAIGVudW0gew0KPiA+ICANCj4gPiAgc3RydWN0IG10a190aGVybWFsOw0KPiA+
ICANCj4gPiArc3RydWN0IG10a190aGVybWFsX3pvbmUgew0KPiA+ICsJc3RydWN0IG10a190aGVy
bWFsICptdDsNCj4gPiArCWludCBpZDsNCj4gPiArfTsNCj4gPiArDQo+ID4gIHN0cnVjdCB0aGVy
bWFsX2JhbmtfY2ZnIHsNCj4gPiAgCXVuc2lnbmVkIGludCBudW1fc2Vuc29yczsNCj4gPiAgCWNv
bnN0IGludCAqc2Vuc29yczsNCj4gPiBAQCAtNjA3LDcgKzYxMiw3IEBAIHN0YXRpYyBpbnQgbXRr
X3RoZXJtYWxfYmFua190ZW1wZXJhdHVyZShzdHJ1Y3QgbXRrX3RoZXJtYWxfYmFuayAqYmFuaykN
Cj4gPiAgCQkgKiBub3QgaW1tZWRpYXRlbHkgc2h1dCBkb3duLg0KPiA+ICAJCSAqLw0KPiA+ICAJ
CWlmICh0ZW1wID4gMjAwMDAwKQ0KPiA+IC0JCQl0ZW1wID0gMDsNCj4gPiArCQkJdGVtcCA9IC1F
QUdBSU47DQo+ID4gIA0KPiA+ICAJCWlmICh0ZW1wID4gbWF4KQ0KPiA+ICAJCQltYXggPSB0ZW1w
Ow0KPiA+IEBAIC02MTgsNyArNjIzLDggQEAgc3RhdGljIGludCBtdGtfdGhlcm1hbF9iYW5rX3Rl
bXBlcmF0dXJlKHN0cnVjdCBtdGtfdGhlcm1hbF9iYW5rICpiYW5rKQ0KPiA+ICANCj4gPiAgc3Rh
dGljIGludCBtdGtfcmVhZF90ZW1wKHZvaWQgKmRhdGEsIGludCAqdGVtcGVyYXR1cmUpDQo+ID4g
IHsNCj4gPiAtCXN0cnVjdCBtdGtfdGhlcm1hbCAqbXQgPSBkYXRhOw0KPiA+ICsJc3RydWN0IG10
a190aGVybWFsX3pvbmUgKnR6ID0gZGF0YTsNCj4gPiArCXN0cnVjdCBtdGtfdGhlcm1hbCAqbXQg
PSB0ei0+bXQ7DQo+ID4gIAlpbnQgaTsNCj4gPiAgCWludCB0ZW1wbWF4ID0gSU5UX01JTjsNCj4g
PiAgDQo+ID4gQEAgLTYzNywxMCArNjQzLDQ0IEBAIHN0YXRpYyBpbnQgbXRrX3JlYWRfdGVtcCh2
b2lkICpkYXRhLCBpbnQgKnRlbXBlcmF0dXJlKQ0KPiA+ICAJcmV0dXJuIDA7DQo+ID4gIH0NCj4g
PiAgDQo+ID4gK3N0YXRpYyBpbnQgbXRrX3JlYWRfc2Vuc29yX3RlbXAodm9pZCAqZGF0YSwgaW50
ICp0ZW1wZXJhdHVyZSkNCj4gPiArew0KPiA+ICsJc3RydWN0IG10a190aGVybWFsX3pvbmUgKnR6
ID0gZGF0YTsNCj4gPiArCXN0cnVjdCBtdGtfdGhlcm1hbCAqbXQgPSB0ei0+bXQ7DQo+ID4gKwlj
b25zdCBzdHJ1Y3QgbXRrX3RoZXJtYWxfZGF0YSAqY29uZiA9IG10LT5jb25mOw0KPiA+ICsJaW50
IGlkID0gdHotPmlkIC0gMTsNCj4gPiArCWludCB0ZW1wID0gSU5UX01JTjsNCj4gPiArCXUzMiBy
YXc7DQo+ID4gKw0KPiA+ICsJaWYgKGlkIDwgMCkNCj4gPiArCQlyZXR1cm4gIC1FQUNDRVM7DQo+
ID4gKw0KPiA+ICsJcmF3ID0gcmVhZGwobXQtPnRoZXJtYWxfYmFzZSArIGNvbmYtPm1zcltpZF0p
Ow0KPiA+ICsNCj4gPiArCXRlbXAgPSByYXdfdG9fbWNlbHNpdXMobXQsIGlkLCByYXcpOw0KPiA+
ICsNCj4gPiArCS8qDQo+ID4gKwkgKiBUaGUgZmlyc3QgcmVhZCBvZiBhIHNlbnNvciBvZnRlbiBj
b250YWlucyB2ZXJ5IGhpZ2ggYm9ndXMNCj4gPiArCSAqIHRlbXBlcmF0dXJlIHZhbHVlLiBGaWx0
ZXIgdGhlc2Ugb3V0IHNvIHRoYXQgdGhlIHN5c3RlbSBkb2VzDQo+ID4gKwkgKiBub3QgaW1tZWRp
YXRlbHkgc2h1dCBkb3duLg0KPiA+ICsJICovDQo+ID4gKw0KPiA+ICsJaWYgKHRlbXAgPiAyMDAw
MDApDQo+ID4gKwkJcmV0dXJuICAtRUFHQUlOOw0KPiA+ICsNCj4gPiArCSp0ZW1wZXJhdHVyZSA9
IHRlbXA7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+ID4gIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgdGhlcm1hbF96b25lX29mX2RldmljZV9vcHMgbXRrX3RoZXJtYWxfb3Bz
ID0gew0KPiA+ICAJLmdldF90ZW1wID0gbXRrX3JlYWRfdGVtcCwNCj4gPiAgfTsNCj4gPiAgDQo+
ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgdGhlcm1hbF96b25lX29mX2RldmljZV9vcHMgbXRrX3Ro
ZXJtYWxfc2Vuc29yX29wcyA9IHsNCj4gPiArCS5nZXRfdGVtcCA9IG10a19yZWFkX3NlbnNvcl90
ZW1wLA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiAgc3RhdGljIHZvaWQgbXRrX3RoZXJtYWxfaW5pdF9i
YW5rKHN0cnVjdCBtdGtfdGhlcm1hbCAqbXQsIGludCBudW0sDQo+ID4gIAkJCQkgIHUzMiBhcG1p
eGVkX3BoeXNfYmFzZSwgdTMyIGF1eGFkY19waHlzX2Jhc2UsDQo+ID4gIAkJCQkgIGludCBjdHJs
X2lkKQ0KPiA+IEBAIC04NzMsNiArOTEzLDcgQEAgc3RhdGljIGludCBtdGtfdGhlcm1hbF9wcm9i
ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAJc3RydWN0IHJlc291cmNlICpy
ZXM7DQo+ID4gIAl1NjQgYXV4YWRjX3BoeXNfYmFzZSwgYXBtaXhlZF9waHlzX2Jhc2U7DQo+ID4g
IAlzdHJ1Y3QgdGhlcm1hbF96b25lX2RldmljZSAqdHpkZXY7DQo+ID4gKwlzdHJ1Y3QgbXRrX3Ro
ZXJtYWxfem9uZSAqdHo7DQo+ID4gIA0KPiA+ICAJbXQgPSBkZXZtX2t6YWxsb2MoJnBkZXYtPmRl
diwgc2l6ZW9mKCptdCksIEdGUF9LRVJORUwpOw0KPiA+ICAJaWYgKCFtdCkNCj4gPiBAQCAtOTU0
LDExICs5OTUsMzAgQEAgc3RhdGljIGludCBtdGtfdGhlcm1hbF9wcm9iZShzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlICpwZGV2KQ0KPiA+ICANCj4gPiAgCXBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYs
IG10KTsNCj4gPiAgDQo+ID4gLQl0emRldiA9IGRldm1fdGhlcm1hbF96b25lX29mX3NlbnNvcl9y
ZWdpc3RlcigmcGRldi0+ZGV2LCAwLCBtdCwNCj4gPiAtCQkJCQkJICAgICAmbXRrX3RoZXJtYWxf
b3BzKTsNCj4gPiAtCWlmIChJU19FUlIodHpkZXYpKSB7DQo+ID4gLQkJcmV0ID0gUFRSX0VSUih0
emRldik7DQo+ID4gLQkJZ290byBlcnJfZGlzYWJsZV9jbGtfcGVyaV90aGVybTsNCj4gPiArCWZv
ciAoaSA9IDA7IGkgPCBtdC0+Y29uZi0+bnVtX3NlbnNvcnMgKyAxOyBpKyspIHsNCj4gPiArCQl0
eiA9IGttYWxsb2Moc2l6ZW9mKCp0eiksIEdGUF9LRVJORUwpOw0KPiA+ICsJCWlmICghdHopDQo+
ID4gKwkJCXJldHVybiAtRU5PTUVNOw0KPiA+ICsNCj4gPiArCQl0ei0+bXQgPSBtdDsNCj4gPiAr
CQl0ei0+aWQgPSBpOw0KPiA+ICsNCj4gPiArCQl0emRldiA9IGRldm1fdGhlcm1hbF96b25lX29m
X3NlbnNvcl9yZWdpc3RlcigmcGRldi0+ZGV2LCBpLA0KPiA+ICsJCQkJCQkJICAgICB0eiwgKGkg
PT0gMCkgPw0KPiA+ICsJCQkJJm10a190aGVybWFsX29wcyA6ICZtdGtfdGhlcm1hbF9zZW5zb3Jf
b3BzKTsNCj4gPiArDQo+ID4gKwkJaWYgKElTX0VSUih0emRldikpIHsNCj4gPiArCQkJaWYgKFBU
Ul9FUlIodHpkZXYpID09IC1FTk9ERVYpIHsNCj4gPiArCQkJCWRldl93YXJuKCZwZGV2LT5kZXYs
DQo+ID4gKwkJCQkJICJzZW5zb3IgJWQgbm90IHJlZ2lzdGVyZWQgaW4gdGhlcm1hbCB6b25lIGlu
IGR0XG4iLA0KPiA+ICsJCQkJCSBpKTsNCj4gPiArCQkJCWNvbnRpbnVlOw0KPiA+ICsJCQl9DQo+
ID4gKwkJCWlmIChQVFJfRVJSKHR6ZGV2KSA9PSAtRUFDQ0VTKSB7DQo+ID4gKwkJCQlyZXQgPSBQ
VFJfRVJSKHR6ZGV2KTsNCj4gPiArCQkJCWdvdG8gZXJyX2Rpc2FibGVfY2xrX3BlcmlfdGhlcm07
DQo+ID4gKwkJCX0NCj4gPiArCQl9DQo+ID4gIAl9DQo+ID4gIA0KPiA+ICAJcmV0dXJuIDA7DQo+
ID4gDQo+IA0KPiANCg0K

