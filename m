Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71EC126D143
	for <lists+linux-pm@lfdr.de>; Thu, 17 Sep 2020 04:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbgIQChI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Sep 2020 22:37:08 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:31574 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725886AbgIQChH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Sep 2020 22:37:07 -0400
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Sep 2020 22:37:06 EDT
X-UUID: b5f35bf3bcf240a48189df19bb23c453-20200917
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=55vZkGLvgoeApgdN8nM2vlO2w+ACfA3EPA25BOlXP70=;
        b=bZSqCHxHRCTfgbe5XYPyHlPB48YAIS7XGniDa3QYe7igJJ5UHfaK9BSvttbbJGntPtI0pGBBgymqBvM2ego2yTc7UfPEPm7odDLc9RIg7pyxNnlLWOvvg2TiTw+y/rhfqfccY9WbvXyTsS0oG/U7zh3HvhKjxwsXWVOf9QJTwzM=;
X-UUID: b5f35bf3bcf240a48189df19bb23c453-20200917
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 240590259; Thu, 17 Sep 2020 10:31:59 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 17 Sep 2020 10:31:45 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Sep 2020 10:31:50 +0800
Message-ID: <1600309910.7042.15.camel@mtkswgap22>
Subject: Re: [PATCH v7] cpufreq: mediatek-hw: Add support for Mediatek
 cpufreq HW driver
From:   Hector Yuan <hector.yuan@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Viresh Kumar <viresh.kumar@linaro.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>
Date:   Thu, 17 Sep 2020 10:31:50 +0800
In-Reply-To: <1600256353.7042.13.camel@mtkswgap22>
References: <1599712262-8819-1-git-send-email-hector.yuan@mediatek.com>
         <20200910050341.pgyieq3q7ijitosn@vireshk-i7>
         <1599715851.7042.9.camel@mtkswgap22>
         <20200910053406.t37rgioykzvk3oem@vireshk-i7>
         <1600256353.7042.13.camel@mtkswgap22>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 7B895C27C73AF267B15AA01BCC80074C1740AE0C6671D6C49EB69B78158A5A792000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIFJvYiBzaXI6DQoNClNvcnJ5IHRvIGJvdGhlciB5b3UsIG1heSBJIGhhdmUgeW91ciByZXZp
ZXcgY29tbWVudCBmb3IgdGhlIGJpbmRpbmcNCnBhcnQ/DQpBcHByZWNpYXRlZC4NCg0KT24gV2Vk
LCAyMDIwLTA5LTE2IGF0IDE5OjM5ICswODAwLCBIZWN0b3IgWXVhbiB3cm90ZToNCj4gSGksIFJv
YiBzaXI6DQo+IA0KPiBTb3JyeSB0byBib3RoZXIgeW91LCBtYXkgSSBoYXZlIHlvdXIgcmV2aWV3
IGNvbW1lbnQgZm9yIHRoZSBiaW5kaW5nDQo+IHBhcnQ/DQo+IEFwcHJlY2lhdGVkLg0KPiANCj4g
T24gVGh1LCAyMDIwLTA5LTEwIGF0IDExOjA0ICswNTMwLCBWaXJlc2ggS3VtYXIgd3JvdGU6DQo+
ID4gT24gMTAtMDktMjAsIDEzOjMwLCBIZWN0b3IgWXVhbiB3cm90ZToNCj4gPiA+IE9uIFRodSwg
MjAyMC0wOS0xMCBhdCAxMDozMyArMDUzMCwgVmlyZXNoIEt1bWFyIHdyb3RlOg0KPiA+ID4gPiBP
biAxMC0wOS0yMCwgMTI6MzEsIEhlY3RvciBZdWFuIHdyb3RlOg0KPiA+ID4gPiA+IFRoZSBDUFVm
cmVxIEhXIHByZXNlbnQgaW4gc29tZSBNZWRpYXRlayBjaGlwc2V0cyBvZmZsb2FkcyB0aGUgc3Rl
cHMgbmVjZXNzYXJ5IGZvciBjaGFuZ2luZyB0aGUgZnJlcXVlbmN5IG9mIENQVXMuIA0KPiA+ID4g
PiA+IFRoZSBkcml2ZXIgaW1wbGVtZW50cyB0aGUgY3B1ZnJlcSBkcml2ZXIgaW50ZXJmYWNlIGZv
ciB0aGlzIGhhcmR3YXJlIGVuZ2luZS4gDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gVGhpcyBwYXRj
aCBkZXBlbmRzIG9uIHRoZSBNVDY3NzkgRFRTIHBhdGNoIHN1Ym1pdHRlZCBieSBIYW5rcyBDaGVu
DQo+ID4gPiA+ID4gIGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDIwLzgvNC8xMDk0DQo+ID4gPiA+
IA0KPiA+ID4gPiBUaGFua3MgZm9yIGhhbmdpbmcgdGhlcmUuIExvb2tzIGdvb2QgdG8gbWUuIEkg
d2lsbCBhcHBseSBpdCBvbmNlIFJvYg0KPiA+ID4gPiBBY2sncyB0aGUgYmluZGluZyBwYXRjaC4N
Cj4gPiA+ID4gDQo+ID4gPiANCj4gPiA+IE1hbnkgdGhhbmtzIGZvciB5b3VyIGhlbHAuIE1heSBJ
IGtub3cgaWYgeW91IGNhbiBhZGQgUmV2aWV3ZWQtYnkgdGFnIHRvDQo+ID4gPiB0aGlzIHBhdGNo
IHNldC4NCj4gPiANCj4gPiBTaW5jZSB0aGlzIHBhdGNoc2V0IGlzIGdvaW5nIHRvIGdldCBtZXJn
ZWQgdmlhIG15IHRyZWUgKEFSTSBjcHVmcmVxDQo+ID4gdHJlZSksIGEgcmV2aWV3ZWQtYnkgaXNu
J3QgcmVxdWlyZWQgaGVyZS4gSSB3aWxsIHF1ZXVlIGl0IHVwIGZvcg0KPiA+IDUuMTAtcmMxIGFm
dGVyIEkgcmVjZWl2ZSBhbiBBY2sgZnJvbSBSb2IuDQo+ID4gDQo+ID4gPiBJIHdvdWxkIGxpa2Ug
dG8gcHJlcGFyZSBzb21lIHBhdGNoZXMgZm9yIG1vcmUgZmVhdHVyZXMNCj4gPiA+IGJhc2VkIG9u
IHRoaXMuIElzIHRoYXQgb2theSB0byB5b3U/IFRoYW5rcyBhZ2Fpbi4NCj4gPiANCj4gPiBUaGF0
IHNob3VsZCBiZSBmaW5lLg0KPiA+IA0KPiANCj4gDQoNCg==

