Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A21B254155
	for <lists+linux-pm@lfdr.de>; Thu, 27 Aug 2020 10:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgH0I6O (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Aug 2020 04:58:14 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:52835 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726882AbgH0I6N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Aug 2020 04:58:13 -0400
X-UUID: 002c42f5b3e746409b131c11eb235ba8-20200827
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=z4HtARY63qecmM+UTuwL38oHkQEk8xUNbn1/BUzTchw=;
        b=gnl17B6QIji7Vk8I0qsLqDwLBR+kzjndRD6X2fZvthnuA0e3y6d3sYZmQLv0O6HvAcFkZzjaLlbZP56WErBUbdZ4IjfNtGGyXKtYTFTUOgGlmWblo/uPsv+80K3u2DC2AGSQJRN+yjXMQ8ayDgYqRCe9SsoHJVRrQQjRaGXAU+A=;
X-UUID: 002c42f5b3e746409b131c11eb235ba8-20200827
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 765371042; Thu, 27 Aug 2020 16:58:08 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 27 Aug 2020 16:58:04 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 27 Aug 2020 16:58:05 +0800
Message-ID: <1598518685.4204.8.camel@mtkswgap22>
Subject: Re: [PATCH v2 1/2] cpufreq: mediatek-hw: Add support for Mediatek
 cpufreq HW driver
From:   Hector Yuan <hector.yuan@mediatek.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rob Herring" <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Vinod Koul <vkoul@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Anson Huang <Anson.Huang@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Olof Johansson" <olof@lixom.net>, <linux-kernel@vger.kernel.org>,
        <wsd_upstream@mediatek.com>
Date:   Thu, 27 Aug 2020 16:58:05 +0800
In-Reply-To: <20200827042653.5ttsxnjjhpslmrcv@vireshk-i7>
References: <1597302475-15484-1-git-send-email-hector.yuan@mediatek.com>
         <1597302475-15484-2-git-send-email-hector.yuan@mediatek.com>
         <20200824100619.o6uwnlsaxdgc3l7r@vireshk-i7>
         <1598446624.24220.10.camel@mtkswgap22>
         <20200827042653.5ttsxnjjhpslmrcv@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: BD4260F00D8F1BF7AF40A81B24370BFC97A30A7B409831315CBF6869CF9669432000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gVGh1LCAyMDIwLTA4LTI3IGF0IDA5OjU2ICswNTMwLCBWaXJlc2ggS3VtYXIgd3JvdGU6DQo+
IE9uIDI2LTA4LTIwLCAyMDo1NywgSGVjdG9yIFl1YW4gd3JvdGU6DQo+ID4gT24gTW9uLCAyMDIw
LTA4LTI0IGF0IDE1OjM2ICswNTMwLCBWaXJlc2ggS3VtYXIgd3JvdGU6DQo+ID4gPiBPbiAxMy0w
OC0yMCwgMTU6MDcsIEhlY3RvciBZdWFuIHdyb3RlOg0KPiA+ID4gPiAgQ09ORklHX0FSTV9BTExX
SU5ORVJfU1VONTBJX0NQVUZSRVFfTlZNRU09bQ0KPiA+ID4gPiAgQ09ORklHX0FSTV9BUk1BREFf
MzdYWF9DUFVGUkVRPXkNCj4gPiA+ID4gK0NPTkZJR19BUk1fTUVESUFURUtfQ1BVRlJFUV9IVz1t
DQo+ID4gPiANCj4gPiA+IFdoYXQgYWJvdXQgYSAnZGVmYXVsdCBtJyBpbiBLY29uZmlnIGl0c2Vs
ZiA/DQo+ID4gPiBPSywgd2lsbCB1cGRhdGUgaW4gVjMuDQo+IA0KPiBIZWN0b3IsIHlvdSBuZWVk
IHRvIHJlbW92ZSAob3Igbm90IGFkZCkgdGhlIHJpZ2h0IGJyYWNrZXQgKD4pIGJlZm9yZSB0aGUN
Cj4gYmVnaW5uaW5nIG9mIHlvdXIgbGluZXMuIFRoaXMgbWFrZXMgaXQgaW5jcmVkaWJseSBkaWZm
aWN1bHQgdG8gcmVhZC4NCg0KT0ssIEkgZ2V0IGl0LiBTb3JyeSBmb3IgdGhlIGluY29udmVuaWVu
Y2UuDQo+ID4gPiA+ICsJZm9yIChpID0gMDsgaSA8IExVVF9NQVhfRU5UUklFUzsgaSsrKSB7DQo+
ID4gPiA+ICsJCWRhdGEgPSByZWFkbF9yZWxheGVkKGJhc2UgKyAoaSAqIExVVF9ST1dfU0laRSkp
Ow0KPiA+ID4gPiArCQlmcmVxID0gRklFTERfR0VUKExVVF9GUkVRLCBkYXRhKSAqIDEwMDA7DQo+
ID4gPiA+ICsJCXZvbHQgPSBGSUVMRF9HRVQoTFVUX1ZPTFQsIGRhdGEpOw0KPiA+ID4gPiArCQlp
ZiAoZnJlcSAhPSBwcmV2X2ZyZXEpIHsNCj4gPiA+ID4gKwkJCXRhYmxlW2ldLmZyZXF1ZW5jeSA9
IGZyZXE7DQo+ID4gPiA+ICsJCQlkZXZfcG1fb3BwX2FkZChjcHVfZGV2LCBmcmVxICogMTAwMCwg
dm9sdCk7DQo+ID4gPiANCj4gPiA+IFdoeSBhcmUgeW91IGFkZGluZyBPUFBzIGhlcmUgYW5kIHJh
dGhlciB3aHkgdXNpbmcgT1BQIHNwZWNpZmljIHN0dWZmDQo+ID4gPiBhdCBhbGwgaW4gdGhlIGRy
aXZlciA/DQo+ID4gPiB5ZXMsIHRoZSBvcHAgaW5mb3JtYXRpb24gaXMgcmVhZCBmcm9tIENQVSBI
VyBlbmdpbmUuVGhlbiBhZGQgaXQgdG8gdGhlIENQVSBkZXYgT1BQIG9uZSBieSBvbmUuICANCj4g
DQo+IEkgYXNrZWQgYSBkaWZmZXJlbnQgcXVlc3Rpb24sIHdoeSBhcmUgeW91IGFkZGluZyBPUFBz
ID8gWW91IGRvbid0IG5lZWQgdGhlIE9QUHMNCj4gYXQgYWxsIGluIG15IG9waW5pb24uIFlvdSBj
YW4ganVzdCBjcmVhdGUgdGhlIGZyZXF1ZW5jeSB0YWJsZSBhbmQgdGhhdCdzIGl0Lg0KDQpJIGp1
c3QgYWRkIE9QUCBpbmZvIHRvIE9QUCBmcmFtZXdvcmsgc28gdGhhdCBvdGhlcnMgbW9kdWxlcyBj
YW4gZ2V0IGl0DQpmcm9tIE9QUCBmcmFtZXdvcmsuDQpCdXQgbGlrZSB5b3Ugc2FpZCwgSSBkb24n
dCBuZWVkIGl0IGluIHRoaXMgZHJpdmVyLiBJIHdpbGwgcmVtb3ZlIHRoaXMNCmNvZGUgc2VnbWVu
dCBpbiBWNC4NCkkgYWxyZWFkeSBzZW5kIFYzIHllc3RlcmRheSBidXQgbm90IGluY2x1ZGluZyB0
aGlzIG1vZGlmaWNhdGlvbi4NCg0KPiA+ID4gPiArCWZvcl9lYWNoX3Bvc3NpYmxlX2NwdShjcHUp
IHsNCj4gPiA+ID4gKwkJY3B1X25wID0gb2ZfY3B1X2RldmljZV9ub2RlX2dldChjcHUpOw0KPiA+
ID4gPiArCQlpZiAoIWNwdV9ucCkNCj4gPiA+ID4gKwkJCWNvbnRpbnVlOw0KPiA+ID4gPiArDQo+
ID4gPiA+ICsJCXJldCA9IG9mX3BhcnNlX3BoYW5kbGVfd2l0aF9hcmdzKGNwdV9ucCwgIm10ayxm
cmVxLWRvbWFpbiIsDQo+ID4gPiANCj4gPiA+IFdoZXJlIGFyZSBiaW5kaW5ncyBvZiB0aGlzIG5v
ZGUgYW5kIGhvdyBkb2VzIHRoaXMgbG9vayA/DQo+ID4gPiBDYW4gcmVmZXIgdG8gdGhlIHNhbWUg
cGF0Y2ggc2VyaWVzLCBJIHNwbGl0IGl0IHRvIGFub3RoZXIgcGF0Y2guRWFjaCBjcHUgd2lsbCBi
ZSBncm91cCBpbnRvIG9uZSBmcmVxdWVuY3kgZG9tYWluIGZvciB0aGUgQ1BVIERWRlMuIA0KPiAN
Cj4gVGhhdCBiaW5kaW5nIG9ubHkgZGVmaW5lcyAibWVkaWF0ZWssY3B1ZnJlcS1odyIgYW5kIG5v
dCAibXRrLGZyZXEtZG9tYWluIi4NCg0KUGxlYXNlIHJlZmVyIHRvIHRoZSBkdCBiaW5kaW5nIGlu
IFYzLCB0aGFuayB5b3UuICAobGttbCBub3Qgc2hvdyB1cCB5ZXQsDQpzbyBJIHBvc3QgdGhlIGJl
bG93IGxpbmsgaW5zdGVhZCkNCmh0dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3RzL2FybS1rZXJu
ZWwvbXNnODMyNTkyLmh0bWwNCj4gDQoNCg==

