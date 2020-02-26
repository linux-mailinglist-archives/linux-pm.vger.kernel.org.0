Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9D1C16F563
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2020 02:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729790AbgBZB6T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Feb 2020 20:58:19 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:51662 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727809AbgBZB6S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Feb 2020 20:58:18 -0500
X-UUID: 64a18c130b76492e9f0cefd94c5d843b-20200226
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=vf8T9NPJWFBx7DbraFo8ckmrgUSJi9hCexuNn4KVT70=;
        b=Lc1aYqVxmjkvE/NuTc23T/B/hNlstQP00nsGSTODeMJj7NxIUrEad1qZ+NMG1tASggiTYGtQY4sEf5nFbOqhbShrF6Wpdy4b/YDu/mAVITfsjv3Jm8/P5rgV1MctUV6QMb/8Kj1G2TvFQb3RBzaYn8199qElzYw57qYTLiwuZew=;
X-UUID: 64a18c130b76492e9f0cefd94c5d843b-20200226
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <michael.kao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 881144794; Wed, 26 Feb 2020 09:58:11 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 26 Feb 2020 09:57:21 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 26 Feb 2020 09:58:19 +0800
Message-ID: <1582682289.27539.5.camel@mtksdccf07>
Subject: Re: [PATCH v3,1/8] arm64: dts: mt8183: add thermal zone node
From:   Michael Kao <michael.kao@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, <hsinyi@chromium.org>,
        <linux-pm@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 26 Feb 2020 09:58:09 +0800
In-Reply-To: <4fab7d40-d7d9-883e-1c50-0507ee1dd750@gmail.com>
References: <20200103064407.19861-1-michael.kao@mediatek.com>
         <20200103064407.19861-2-michael.kao@mediatek.com>
         <00c8be46-3ba1-571a-0230-7c722ce1901e@linaro.org>
         <1581391046.31005.12.camel@mtksdccf07>
         <270efbcf-51bb-629f-c64b-fa343b3d2988@linaro.org>
         <4fab7d40-d7d9-883e-1c50-0507ee1dd750@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gVGh1LCAyMDIwLTAyLTIwIGF0IDIxOjU3ICswMTAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KPiANCj4gT24gMjAvMDIvMjAyMCAxMjo1MiwgRGFuaWVsIExlemNhbm8gd3JvdGU6DQo+ID4g
T24gMTEvMDIvMjAyMCAwNDoxNywgTWljaGFlbCBLYW8gd3JvdGU6DQo+ID4+IE9uIFRodSwgMjAy
MC0wMS0wOSBhdCAxMjozMSArMDEwMCwgRGFuaWVsIExlemNhbm8gd3JvdGU6DQo+ID4+PiBPbiAw
My8wMS8yMDIwIDA3OjQ0LCBNaWNoYWVsIEthbyB3cm90ZToNCj4gPj4+PiBGcm9tOiAibWljaGFl
bC5rYW8iIDxtaWNoYWVsLmthb0BtZWRpYXRlay5jb20+DQo+ID4+Pj4NCj4gPj4+PiBBZGQgdGhl
cm1hbCB6b25lIG5vZGUgdG8gTWVkaWF0ZWsgTVQ4MTgzIGR0cyBmaWxlLg0KPiA+Pj4+DQo+ID4+
Pj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBLYW8gPG1pY2hhZWwua2FvQG1lZGlhdGVrLmNvbT4N
Cj4gPj4+PiAtLS0NCj4gPj4+PiAgYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODMu
ZHRzaSB8IDg1ICsrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+Pj4+ICAxIGZpbGUgY2hhbmdl
ZCwgODUgaW5zZXJ0aW9ucygrKQ0KPiA+Pj4+DQo+ID4+Pj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJt
NjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTgzLmR0c2kgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21l
ZGlhdGVrL210ODE4My5kdHNpDQo+ID4+Pj4gaW5kZXggMTBiMzI0NzFiYzdiLi5hMjc5M2NmM2Q5
OTQgMTAwNjQ0DQo+ID4+Pj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgx
ODMuZHRzaQ0KPiA+Pj4+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTgz
LmR0c2kNCj4gPj4+PiBAQCAtNTcwLDYgKzU3MCw4OCBAQA0KPiA+Pj4+ICAJCQlzdGF0dXMgPSAi
ZGlzYWJsZWQiOw0KPiA+Pj4+ICAJCX07DQo+ID4+Pj4gIA0KPiA+Pj4+ICsJCXRoZXJtYWw6IHRo
ZXJtYWxAMTEwMGIwMDAgew0KPiA+Pj4+ICsJCQkjdGhlcm1hbC1zZW5zb3ItY2VsbHMgPSA8MT47
DQo+ID4+Pj4gKwkJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTgzLXRoZXJtYWwiOw0KPiA+
Pj4+ICsJCQlyZWcgPSA8MCAweDExMDBiMDAwIDAgMHgxMDAwPjsNCj4gPj4+PiArCQkJaW50ZXJy
dXB0cyA9IDwwIDc2IElSUV9UWVBFX0xFVkVMX0xPVz47DQo+ID4+Pg0KPiA+Pj4gV2hhdCBpcyB0
aGlzIGludGVycnVwdCBmb3I/DQo+ID4+DQo+ID4+IFRoZSBpbnRlcnJ1cHRzIHBpbiBpcyBkZXNp
Z25lZCBpbiBvdXIgU29DLiBCdXQgaXQgaXMgbm90IHVzZWQgaW4gb3VyDQo+ID4+IHVwc3RyZWFt
IHRoZXJtYWwgY29kZSBub3cuIFRoZXJlIGlzIGFsc28gYWRkIHRoZSBzZXR0aW5ncyBidXQgbm90
IHVzZQ0KPiA+PiBmb3IgbXQ4MTczLmR0c2kuIFRvIGFsaWduIHRoZSB0aGVybWFsIGR0c2kgZm9y
bWF0LCBJIGZvbGxvdyB0aGUgcGFzdA0KPiA+PiBleHBlcmllbmNlIHRvIGFkZCB0aGUgaW50ZXJy
dXB0IHNldHRpbmdzIG9mIHRoaXMgcHJvamVjdCBmaXJzdC4NCj4gPiANCj4gPiBBc3N1bWluZyB0
aGUgaW50ZXJydXB0IGNhbiBiZSBzZXQgYnkgdGhlIGRyaXZlciB0byBmaXJlIHdoZW4gYSBzcGVj
aWZpZWQNCj4gPiB0ZW1wZXJhdHVyZSBpcyBzZXQsIEkgc3VnZ2VzdCB0byBjaGFuZ2UgeW91ciBk
cml2ZXIgdG8gaGFuZGxlIGl0IHNvIHlvdQ0KPiA+IGNhbiBnZXQgcmlkIG9mIHRoZSBwb2xsaW5n
IHdha2luZyB1cCB0aGUgU29DIGV2ZXJ5IHNlY29uZC4NCj4gPiANCj4gDQo+IEZvciB0aGUgcmVj
b3JkIHRoZSBpbnRlcnJ1cHQgaXMgYSByZXF1aXJlZCBwcm9wZXJ0eSBieSB0aGUgYmluZGluZyBk
ZXNjcmlwdGlvbi4NCj4gDQo+IFJlZ2FyZHMsDQo+IE1hdHRoaWFzDQoNCkFmdGVyIGNoZWNraW5n
IHdpdGggaW50ZXJydXB0IG93bmVyLCBpdCBpcyBub3QgcmVxdWlyZWQgcHJvcGVydHkgZm9yDQp0
aGVybWFsLg0KSSB3aWxsIHJlbW92ZSB0aGUgcHJvcGVydHkgb2YgaHctcmVzZXQtdGVtcCBhbmQg
aW50ZXJydXB0Lg0KQW5kIGFsc28gSSB3aWxsIGFkZCBuZXcgbGluZSB0byBmaXggZm9ybWF0Lg0K
VGhlc2UgdGhyZWUgY2hhbmdlIHdpbGwgcmVzZW5kIHY0IHRvIGZpeCB0aGVtLg0K

