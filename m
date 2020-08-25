Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB0AF25155D
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 11:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbgHYJ3m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 05:29:42 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:12754 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726149AbgHYJ3m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Aug 2020 05:29:42 -0400
X-UUID: 4ab557a0b8c348b6879857d307f40f92-20200825
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=pzm6RISn/tNeKbUICcBC7qg5/+/y+MTOUCaljQkJv5I=;
        b=WjBc9ONPbH2xD4WxLXUJLuFNUrmcxAywnOvIJ56DGvSswJiwg0LamrKhcxY5oqiO5LdTTv9IfQqfxnRx8yvmDo8BgWleofTk4jQACBZTpakTIO4qfIW9ISIz0PPvCaGnfIJnQclKIh9g2UwPm+2XSDs36z68lNqveiE2RCurNwU=;
X-UUID: 4ab557a0b8c348b6879857d307f40f92-20200825
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <michael.kao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1131286243; Tue, 25 Aug 2020 17:29:37 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 25 Aug 2020 17:29:34 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 25 Aug 2020 17:29:34 +0800
Message-ID: <1598347775.16267.0.camel@mtksdccf07>
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
Date:   Tue, 25 Aug 2020 17:29:35 +0800
In-Reply-To: <03286571-c110-7f5e-a911-24f8c3e4fd42@arm.com>
References: <20200424071601.2636-1-michael.kao@mediatek.com>
         <accb83e0-ffbe-b6e3-6bf9-e7cc8b9fe19c@arm.com>
         <1588156776.3573.1.camel@mtksdccf07>
         <03286571-c110-7f5e-a911-24f8c3e4fd42@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gV2VkLCAyMDIwLTA0LTI5IGF0IDIxOjI0ICswMTAwLCBMdWthc3ogTHViYSB3cm90ZToNCj4g
DQo+IE9uIDQvMjkvMjAgMTE6MzkgQU0sIE1pY2hhZWwgS2FvIHdyb3RlOg0KPiA+IE9uIEZyaSwg
MjAyMC0wNC0yNCBhdCAxMDoyMiArMDEwMCwgTHVrYXN6IEx1YmEgd3JvdGU6DQo+ID4+IEhpIE1p
Y2hhZWwsDQo+ID4+DQo+ID4+IE9uIDQvMjQvMjAgODoxNiBBTSwgTWljaGFlbCBLYW8gd3JvdGU6
DQo+ID4+PiBUaGUgdXBwZXIgYW5kIGxvd2VyIGxpbWl0cyBvZiB0aGVybWFsIHRocm90dGxlIHN0
YXRlIGluIHRoZQ0KPiA+Pj4gZGV2aWNlIHRyZWUgZG8gbm90IGFwcGx5IHRvIHRoZSBwb3dlcl9h
bGxvY2F0ZSBnb3Zlcm5vci4NCj4gPj4+IEFkZCB0aGUgdXBwZXIgYW5kIGxvd2VyIGxpbWl0cyB0
byB0aGUgcG93ZXJfYWxsb2NhdGUgZ292ZXJub3IuDQo+ID4+Pg0KPiA+Pj4gU2lnbmVkLW9mZi1i
eTogTWljaGFlbCBLYW8gPG1pY2hhZWwua2FvQG1lZGlhdGVrLmNvbT4NCj4gPj4+IC0tLQ0KPiA+
Pj4gICAgZHJpdmVycy90aGVybWFsL3RoZXJtYWxfY29yZS5jIHwgMiArLQ0KPiA+Pj4gICAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4+Pg0KPiA+Pj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdGhlcm1hbC90aGVybWFsX2NvcmUuYyBiL2RyaXZlcnMvdGhl
cm1hbC90aGVybWFsX2NvcmUuYw0KPiA+Pj4gaW5kZXggOWEzMjFkYzU0OGM4Li5mNmZlZWQyMjY1
YmQgMTAwNjQ0DQo+ID4+PiAtLS0gYS9kcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3JlLmMNCj4g
Pj4+ICsrKyBiL2RyaXZlcnMvdGhlcm1hbC90aGVybWFsX2NvcmUuYw0KPiA+Pj4gQEAgLTU5OCw3
ICs1OTgsNyBAQCBpbnQgcG93ZXJfYWN0b3Jfc2V0X3Bvd2VyKHN0cnVjdCB0aGVybWFsX2Nvb2xp
bmdfZGV2aWNlICpjZGV2LA0KPiA+Pj4gICAgCWlmIChyZXQpDQo+ID4+PiAgICAJCXJldHVybiBy
ZXQ7DQo+ID4+PiAgICANCj4gPj4+IC0JaW5zdGFuY2UtPnRhcmdldCA9IHN0YXRlOw0KPiA+Pj4g
KwlpbnN0YW5jZS0+dGFyZ2V0ID0gY2xhbXBfdmFsKHN0YXRlLCBpbnN0YW5jZS0+bG93ZXIsIGlu
c3RhbmNlLT51cHBlcik7DQo+ID4+PiAgICAJbXV0ZXhfbG9jaygmY2Rldi0+bG9jayk7DQo+ID4+
PiAgICAJY2Rldi0+dXBkYXRlZCA9IGZhbHNlOw0KPiA+Pj4gICAgCW11dGV4X3VubG9jaygmY2Rl
di0+bG9jayk7DQo+ID4+Pg0KPiA+Pg0KPiA+PiBUaGFuayB5b3UgZm9yIHRoZSBwYXRjaCBhbmQg
aGF2aW5nIHRvIGxvb2sgYXQgaXQuIEkgaGF2ZSBzb21lIGNvbmNlcm5zDQo+ID4+IHdpdGggdGhp
cyBhcHByb2FjaC4gTGV0J3MgYW5hbHl6ZSBpdCBmdXJ0aGVyLg0KPiA+Pg0KPiA+PiBJbiBkZWZh
dWx0IHRoZSBjb29saW5nIGRldmljZXMgaW4gdGhlIHRoZXJtYWwgem9uZSB3aGljaCBpcyB1c2Vk
IGJ5IElQQQ0KPiA+PiBkbyBub3QgaGF2ZSB0aGlzICdsb3dlcicgYW5kICd1cHBlcicgbGltaXRz
LiBUaGV5IGFyZSBzZXQgdG8NCj4gPj4gVEhFUk1BTF9OT19MSU1JVCBpbiBEVCB0byBnaXZlIGZ1
bGwgY29udHJvbCB0byBJUEEgb3ZlciB0aGUgc3RhdGVzLg0KPiA+Pg0KPiA+PiBUaGlzIHRoZSBm
dW5jdGlvbiAncG93ZXJfYWN0b3Jfc2V0X3Bvd2VyJyBhY3R1YWxseSB0cmFuc2xhdGVzIGdyYW50
ZWQNCj4gPj4gcG93ZXIgdG8gdGhlIHN0YXRlIHRoYXQgZGV2aWNlIHdpbGwgcnVuIGZvciB0aGUg
bmV4dCBwZXJpb2QuDQo+ID4+IFRoZSBJUEEgYWxnb3JpdGhtIGhhcyBhbHJlYWR5IHNwbGl0IHRo
ZSBwb3dlciBidWRnZXQuDQo+ID4+IE5vdyB3aGF0IGhhcHBlbiB3aGVuIHRoZSAnbG93ZXInIHZh
bHVlIHdpbGwgY2hhbmdlIHRoZSBzdGF0ZSB0byBhIHN0YXRlDQo+ID4+IHdoaWNoIGNvbnN1bWVz
IG1vcmUgcG93ZXIgdGhhbiB3YXMgY2FsY3VsYXRlZCBpbiB0aGUgSVBBIGFsZy4uLiBJdCB3aWxs
DQo+ID4+IGJlY2FtZSB1bnN0YWJsZS4NCj4gPj4NCj4gPj4gSSB3b3VsZCByYXRoZXIgc2VlIGEg
Y2hhbmdlIHdoaWNoIHVzZXMgdGhlc2UgJ2xvd2VyJyBhbmQgJ3VwcGVyJyBsaW1pdHMNCj4gPj4g
YmVmb3JlIHRoZSBJUEEgZG8gdGhlIGNhbGN1bGF0aW9uIG9mIHRoZSBwb3dlciBidWRnZXQuIEJ1
dCB0aGlzIHdhc24ndA0KPiA+PiBhIHJlcXVpcmVtZW50IGFuZCB3ZSBhc3N1bWVkIHRoYXQgSVBB
IGhhcyBmdWxsIGNvbnRyb2wgb3ZlciB0aGUgY29vbGluZw0KPiA+PiBkZXZpY2UgKHdoaWNoIEkg
ZGVzY3JpYmVkIGFib3ZlIHdpdGggdGhpcyBEVCBUSEVSTUFMX05PX0xJTUlUKS4NCj4gPj4NCj4g
Pj4gSXMgdGhlcmUgYSBwcm9ibGVtIHdpdGggeW91ciBwbGF0Zm9ybSB0aGF0IGl0IGhhcyB0byBw
cm92aWRlIHNvbWUNCj4gPj4gbWluaW1hbCBwZXJmb3JtYW5jZSwgc28geW91IHRyaWVkIHRvIGlu
dHJvZHVjZSB0aGlzIGNsYW1waW5nPw0KPiA+Pg0KPiA+PiBSZWdhcmRzLA0KPiA+PiBMdWthc3oN
Cj4gPiANCj4gPiANCj4gPiBIaSBMdWthc3osDQo+ID4gDQo+ID4gSSByZWZlciB0byB0aGUgZG9j
dW1lbnRhdGlvbiBzZXR0aW5ncyBvZiB0aGUgdGhlcm1hbCBkZXZpY2UgdHJlZQ0KPiA+IChEb2N1
bWVudGF0aW9uIC8gZGV2aWNldHJlZSAvIGJpbmRpbmdzIC8gdGhlcm1hbCAvIHRoZXJtYWwudHh0
KS4NCj4gPiANCj4gPiBJdCBzaG93cyB0aGF0IGNvb2xpbmctZGV2aWNlIGlzIGEgbWFuZGF0b3J5
IHByb3BlcnR5LCBzbyBtYXgvbWluIGNvb2xpbmcNCj4gPiBzdGF0ZSBzaG91bGQgYmUgYWJsZSB0
byBzdXBwb3J0IGluIGZyYW1ld29yayBwb2ludCBvZiB2aWV3Lg0KPiA+IE90aGVyd2lzZSwgdGhl
IGxpbWl0YXRpb24gc2hvdWxkIGJlIGFkZGVkIGluIGJpbmRpbmcgZG9jdW1lbnQuDQo+ID4gDQo+
ID4gRGlmZmVyZW50IGhhcmR3YXJlIG1lY2hhbmlzbXMgaGF2ZSBkaWZmZXJlbnQgaGVhdCBkaXNz
aXBhdGlvbg0KPiA+IGNhcGFiaWxpdGllcy4NCj4gPiBMaW1pdGluZyB0aGUgaW5wdXQgaGVhdCBz
b3VyY2UgY2FuIHNsb3cgZG93biB0aGUgaGVhdCBhY2N1bXVsYXRpb24gYW5kDQo+ID4gdGVtcGVy
YXR1cmUgYnVyc3QuDQo+ID4gV2Ugd2FudCB0byByZWR1Y2UgdGhlIGFjY3VtdWxhdGlvbiBvZiBo
ZWF0IGF0IGhpZ2ggdGVtcGVyYXR1cmUgYnkNCj4gPiBsaW1pdGluZyB0aGUgbWluaW11bSBnZWFy
IG9mIHRoZXJtYWwgdGhyb3R0bGUuDQo+IA0KPiBJIGFncmVlIHRoYXQgdGhlc2UgJ2xvd2VyJyBh
bmQgJ3VwcGVyJyBsaW1pdHMgc2hvdWxkbid0IGJlIGp1c3QNCj4gaWdub3JlZCBhcyBpcyBjdXJy
ZW50bHkuIFRoaXMgcGF0Y2ggY2xhbXBzIHRoZSB2YWx1ZSBhdCBsYXRlIHN0YWdlLA0KPiB0aG91
Z2guDQo+IA0KPiBMZXQgbWUgaGF2ZSBhIGxvb2sgaG93IGl0IGNvdWxkIGJlIHRha2VuIGludG8g
YWNjb3VudCBpbiB0aGUgZWFybHkNCj4gc3RhZ2UsIGJlZm9yZSB0aGUgcG93ZXIgY2FsY3VsYXRp
b24gYW5kIHNwbGl0IGFyZSBkb25lLiBNYXliZSB0aGVyZQ0KPiBpcyBhIGNsZWFuIHdheSB0byBp
bmplY3QgdGhpcy4NCj4gDQo+IFJlZ2FyZHMsDQo+IEx1a2Fzeg0KSGkgTHVrYXN6LA0KDQpBZnRl
ciB0aGUgcmVzZWFyY2gsIGRvIHlvdSBoYXZlIGFueSBpZGVhcyBvciBzdWdnZXN0aW9ucz8NCg0K
QmVzdCBSZWdhcmRzLA0KTWljaGFlbA0KDQo=

