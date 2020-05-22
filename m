Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1EDA1DDE87
	for <lists+linux-pm@lfdr.de>; Fri, 22 May 2020 06:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbgEVEJg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 May 2020 00:09:36 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:19013 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725859AbgEVEJg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 May 2020 00:09:36 -0400
X-UUID: 7e1934e4550544c9bae55ec3f79a7dc8-20200522
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=X47htdhmQH4NMD8VYo9Wr+NebWgg/Igukck/NyzLjDY=;
        b=FVd2BM88NwlDWXM+H49UDz6JLO63itSZEJExahDZlDYS0b8yVRQI8pi9r/iJ/JlkIUNluCjiqRYEgh3f5dRNnnLu6210C/X35dGCHp5jzAjlixfjpjucvBHg9j6i5gSgIxGewVpQ41Dj0QAQHDh/Q8m9e8wiedFjo8LEbk9lEO0=;
X-UUID: 7e1934e4550544c9bae55ec3f79a7dc8-20200522
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <michael.kao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2103569283; Fri, 22 May 2020 12:09:33 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 May 2020 12:09:30 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 22 May 2020 12:09:30 +0800
Message-ID: <1590120571.22249.25.camel@mtksdccf07>
Subject: Re: [v4,0/7] Add Mediatek thermal dirver and dtsi
From:   Michael Kao <michael.kao@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, <hsinyi@chromium.org>,
        <linux-pm@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Fri, 22 May 2020 12:09:31 +0800
In-Reply-To: <7e205390-c7a7-b8c9-3ba2-344a04dc6696@gmail.com>
References: <20200323121537.22697-1-michael.kao@mediatek.com>
         <7e205390-c7a7-b8c9-3ba2-344a04dc6696@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gVGh1LCAyMDIwLTA1LTIxIGF0IDE0OjUxICswMjAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KPiBIaSBNaWNoYWVsLA0KPiANCj4gT24gMjMvMDMvMjAyMCAxMzoxNSwgTWljaGFlbCBLYW8g
d3JvdGU6DQo+ID4gVGhpcyBwYXRjaHNldCBzdXBwb3J0cyBmb3IgTVQ4MTgzIGNoaXAgdG8gbXRr
X3RoZXJtYWwuYy4NCj4gPiBBZGQgdGhlcm1hbCB6b25lIG9mIGFsbCB0aGUgdGhlcm1hbCBzZW5z
b3IgaW4gU29DIGZvcg0KPiA+IGFub3RoZXIgZ2V0IHRlbXBlcmF0cnVlLiBUaGV5IGRvbid0IG5l
ZWQgdG8gdGhlcm1hbCB0aHJvdHRsZS4NCj4gPiBBbmQgd2UgYmluZCBjb29sZXJzIGZvciB0aGVy
bWFsIHpvbmUgbm9kZXMgb2YgY3B1X3RoZXJtYWwuDQo+ID4gDQo+ID4gUmViYXNlIHRvIGtlcm5l
bC01LjYtcmMxLg0KPiA+IA0KPiA+IFVwZGF0ZSBjb250ZW50Og0KPiA+IA0KPiA+IFsxLzddDQo+
ID4gICAgIC0gU3F1YXNoIHRoZXJtYWwgem9uZSBzZXR0aW5ncyBpbiB0aGUgZHRzaSBmcm9tIFt2
Myw1LzhdDQo+ID4gICAgICAgYXJtNjQ6IGR0czogbXQ4MTgzOiBJbmNyZWFzZSBwb2xsaW5nIGZy
ZXF1ZW5jeSBmb3IgQ1BVIHRoZXJtYWwgem9uZQ0KPiA+IA0KPiA+ICAgICAtIFJlbW92ZSB0aGUg
cHJvcGVydHkgb2YgaW50ZXJydXB0cyBhbmQgbWVkaWF0ZWssaHctcmVzZXQtdGVtcA0KPiA+IA0K
PiA+IFsyLzddDQo+ID4gICAgIC0gQ29ycmVjdCBjb21taXQgbWVzc2FnZQ0KPiA+IA0KPiA+IFs0
LzddDQo+ID4gICAgIC0gQ2hhbmdlIHRoZSB0YXJnZXQgdGVtcGVyYXR1cmUgdG8gdGhlIDgwQyBh
bmQgY2hhbmdlIHRoZSBjb21taXQgbWVzc2FnZQ0KPiA+IA0KPiA+IFs2LzddDQo+ID4gICAgIC0g
QWRqdXN0IG5ld2xpbmUgYWxpZ25tZW50DQo+ID4gDQo+ID4gICAgIC0gRml4IHRoZSBqdWRnZW1l
bnQgb24gdGhlIHJldHVybiB2YWx1ZSBvZiByZWdpc3RlcmluZyB0aGVybWFsIHpvbmUNCj4gPiAN
Cj4gPiBUaGlzIHBhdGNoIHNlcmllcyBiYXNlIG9uIHRoZXNlIHBhdGNoZXMgWzFdLg0KPiA+IA0K
PiA+IFt2NywzLzNdIFBNIC8gQVZTOiBTVlM6IEludHJvZHVjZSBTVlMgZW5naW5lIChodHRwczov
L3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzExNDM5ODI5LykNCj4gPiANCj4gPiBNYXR0aGlh
cyBLYWVobGNrZSAoMSk6DQo+ID4gICBhcm02NDogZHRzOiBtdDgxODM6IENvbmZpZ3VyZSBDUFUg
Y29vbGluZw0KPiA+IA0KPiA+IE1pY2hhZWwgS2FvICg2KToNCj4gPiAgIGFybTY0OiBkdHM6IG10
ODE4MzogYWRkIHRoZXJtYWwgem9uZSBub2RlDQo+ID4gICBhcm02NDogZHRzOiBtdDgxODM6IGFk
ZCBkeW5hbWljIHBvd2VyIGNvZWZmaWNpZW50cw0KPiA+ICAgYXJtNjQ6IGR0czogbXQ4MTgzOiBB
ZGQgI2Nvb2xpbmctY2VsbHMgdG8gQ1BVIG5vZGVzDQo+ID4gICB0aGVybWFsOiBtZWRpYXRlazog
bXQ4MTgzOiBmaXggYmFuayBudW1iZXIgc2V0dGluZ3MNCj4gDQo+IERvIEkgdW5kZXJzdGFuZCBj
b3JyZWN0bHkgdGhhdCB3ZSBuZWVkIHRvIGZpeCB0aGUgYmFuayBudW1iZXIgYmVmb3JlIHdlIGNh
biBhZGQNCj4gdGhlIGRldmljZSB0cmVlIGNoYW5nZXMuIEFuZCB0aGF0IHRoZSBsYXN0IHR3byBw
YXRjaGVzIGFyZSBlbmhhbmNlbWVudHMgZm9yIHRoZQ0KPiBkcml2ZXIgYnV0IG5lZWRlZCB0byBn
ZXQgYSB3b3JraW5nIHZlcnNpb24/DQo+IA0KPiBSZWdhcmRzLA0KPiBNYXR0aGlhcw0KPiANCkhp
IE1hdHRoaWFzLA0KDQpUaGVyZSBpcyBvbmUgYmFuayBzZXR0aW5nIG9mIG10ODE4MyBjb25maWcu
DQpJZiB0aGUgZGV2aWNlIHRyZWUgbWVyZ2VkIGZpcnN0LiBJIHdvcnJ5IHRoYXQgaXQgd2lsbCBj
cmFzaCB3aGVuIHRoZQ0KdGhlcm1hbCB6b25lIHJlYWQgdGVtcGVyYXR1cmUuDQpJdCB3aWxsIGFj
Y2VzcyB0aGUgaW52YWxpZCBpbmRleCBvZiBiYW5rLg0KU28gcGxlYXNlIHdhaXQgdGhlIHBhdGNo
ICJmaXggYmFuayBudW1iZXIgc2V0dGluZ3MgIiBtZXJnZWQgZmlyc3QuDQpUaGFua3MhDQoNCi8q
IE1UODE4MyB0aGVybWFsIHNlbnNvciBkYXRhICovDQpzdGF0aWMgY29uc3QgaW50IG10ODE4M19i
YW5rX2RhdGFbTVQ4MTgzX05VTV9TRU5TT1JTXSA9IHsNCglNVDgxODNfVFMxLCBNVDgxODNfVFMy
LCBNVDgxODNfVFMzLCBNVDgxODNfVFM0LCBNVDgxODNfVFM1LA0KTVQ4MTgzX1RTQUJCDQp9OyAN
Cg0KQmVzdCBSZWdhcmRzLA0KTWljaGFlbA0KDQoNCj4gPiAgIHRoZXJtYWw6IG1lZGlhdGVrOiBh
ZGQgYW5vdGhlciBnZXRfdGVtcCBvcHMgZm9yIHRoZXJtYWwgc2Vuc29ycw0KPiA+ICAgdGhlcm1h
bDogbWVkaWF0ZWs6IHVzZSBzcGlubG9jayB0byBwcm90ZWN0IFBUUENPUkVTRUwNCj4gPiANCj4g
PiAgYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODMuZHRzaSB8IDE1NiArKysrKysr
KysrKysrKysrKysrKysrKw0KPiA+ICBkcml2ZXJzL3RoZXJtYWwvbXRrX3RoZXJtYWwuYyAgICAg
ICAgICAgIHwgIDg4ICsrKysrKysrKysrLS0NCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAyMzEgaW5z
ZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pDQo+ID4gDQoNCg==

