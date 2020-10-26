Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB74F2989E7
	for <lists+linux-pm@lfdr.de>; Mon, 26 Oct 2020 10:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1768657AbgJZJ46 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Oct 2020 05:56:58 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:43093 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1768776AbgJZJzb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Oct 2020 05:55:31 -0400
X-UUID: ffea3dbb561242eb947ed65158a5ab0a-20201026
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=20g0W1OHC8ECWUuvX8bYtkQwtQjsCCtxJSPzMi5pZ3Y=;
        b=hnLHNoZt83lzo3EIi+h9NFGmBN9lxqgSR3A4N+lQmDENvgqZkaUzhWL5ZLkWdFUJgwitHtkAezv0DvsbiD9hebpU2iDLC1GzBLjck1mrkdukeV+IQDbI/p3KXjJYWeaEPLXgy7Qg0Yvkq+/i/3Lmce3BcbC/xoOta0XfX0cvaus=;
X-UUID: ffea3dbb561242eb947ed65158a5ab0a-20201026
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <claude.yen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1559540824; Mon, 26 Oct 2020 17:55:20 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 26 Oct 2020 17:55:18 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 26 Oct 2020 17:55:18 +0800
Message-ID: <1603706118.2127.2.camel@mtkswgap22>
Subject: Re: [PATCH] PM / s2idle: Export s2idle_set_ops
From:   claude yen <claude.yen@mediatek.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Date:   Mon, 26 Oct 2020 17:55:18 +0800
In-Reply-To: <CAJZ5v0jJHBBrxANa-+mHFE47TZfE4NKNpgp0-rq2BD=Yw7qMXg@mail.gmail.com>
References: <20201022061748.13730-1-claude.yen@mediatek.com>
         <20201022061748.13730-2-claude.yen@mediatek.com>
         <20201022070154.hqvksoj4nss3er2e@bogus>
         <1603427300.7573.6.camel@mtkswgap22>
         <20201023144842.zos4pvpwv4r3rv4j@bogus>
         <CAJZ5v0jJHBBrxANa-+mHFE47TZfE4NKNpgp0-rq2BD=Yw7qMXg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gRnJpLCAyMDIwLTEwLTIzIGF0IDE2OjU4ICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gT24gRnJpLCBPY3QgMjMsIDIwMjAgYXQgNDo0OCBQTSBTdWRlZXAgSG9sbGEgPHN1ZGVl
cC5ob2xsYUBhcm0uY29tPiB3cm90ZToNCj4gPg0KPiA+IE9uIEZyaSwgT2N0IDIzLCAyMDIwIGF0
IDEyOjI4OjIwUE0gKzA4MDAsIGNsYXVkZSB5ZW4gd3JvdGU6DQo+ID4gPiBPbiBUaHUsIDIwMjAt
MTAtMjIgYXQgMDg6MDIgKzAxMDAsIFN1ZGVlcCBIb2xsYSB3cm90ZToNCj4gPiA+ID4gT24gVGh1
LCBPY3QgMjIsIDIwMjAgYXQgMDI6MTc6NDhQTSArMDgwMCwgQ2xhdWRlIFllbiB3cm90ZToNCj4g
PiA+ID4gPiBBcyBzdXNwZW5kX3NldF9vcHMgaXMgZXhwb3J0ZWQgaW4gY29tbWl0IGE1ZTRmZDg3
ODNhMg0KPiA+ID4gPiA+ICgiUE0gLyBTdXNwZW5kOiBFeHBvcnQgc3VzcGVuZF9zZXRfb3BzLCBz
dXNwZW5kX3ZhbGlkX29ubHlfbWVtIiksDQo+ID4gPiA+ID4gZXhwb3J0aW5nIHMyaWRsZV9zZXRf
b3BzIHRvIG1ha2Uga2VybmVsIG1vZHVsZSBzZXR1cCBzMmlkbGUgb3BzIHRvby4NCj4gPiA+ID4g
Pg0KPiA+ID4gPiA+IEluIHRoaXMgd2F5LCBrZXJuZWwgbW9kdWxlIGNhbiBob29rIHBsYXRmb3Jt
IHN1c3BlbmQNCj4gPiA+ID4gPiBmdW5jdGlvbnMgcmVnYXJkbGVzcyBvZiBTdXNwZW5kLXRvLVJh
bShTMlIpIG9yDQo+ID4gPiA+ID4gU3VzcGVuZC10by1JZGxlKFMySSkNCj4gPiA+ID4gPg0KPiA+
ID4gPg0KPiA+ID4gPiBJZiB0aGlzIGlzIGZvciBhcm02NCBwbGF0Zm9ybSwgdGhlbiBOQUNLLiBZ
b3UgbXVzdCB1c2UgUFNDSSBhbmQgaXQgd2lsbA0KPiA+ID4gPiBzZXQgdGhlIG9wcyBhbmQgaXQg
Y2FuJ3QgYmUgbW9kdWxlLg0KPiA+ID4gPg0KPiA+ID4NCj4gPiA+IFBTQ0kgdXNlcyBzdXNwZW5k
X3NldF9vcHMgaW5zdGVhZC4gQW5kIHN1c3BlbmRfc2V0X29wcyBoYXMgYmVlbg0KPiA+ID4gZXhw
b3J0ZWQgeWVhcnMgYWdvLg0KPiA+ID4NCj4gPiA+IFN1c3BlbmQtdG9fSWRsZShTMkkpIGlzIGFu
b3RoZXIgc3VzcGVuZCBtZXRob2Qgc3VwcG9ydGVkIGJ5IGxpbnV4DQo+ID4gPiBrZXJuZWwuIFRo
ZSBjb3JyZXNwb25kaW5nIHMyaWRsZV9vcHMgY2FuIGJlIGhvb2tlZCBieSBzMmlkbGVfc2V0X29w
cw0KPiA+ID4gYnkgdW5kZXJseWluZyBwbGF0Zm9ybXMuICBGb3IgZXhhbXBsZSwgUzJJIGlzIG5v
dyBpbnRyb2R1Y2VkIGludG8NCj4gPiA+IE1lZGlhdGVrIFNvQyBwbGF0Zm9ybXMuIEJlc2lkZXMs
IHBvd2VyIG1hbmFnZW1lbnQgZHJpdmVyIGlzIGJ1aWx0IGFzDQo+ID4gPiBrZXJuZWwgbW9kdWxl
Lg0KPiA+ID4NCj4gPiA+IE1vYmlsZSBwbGF0Zm9ybXMgYXJlIG5vdyBjYWxsIGZvciBrZXJuZWwg
ZHJpdmVycyB0byBiZSBrZXJuZWwgbW9kdWxlcy4NCj4gPiA+IFRoaXMgY291bGQgaGVscCBkcml2
ZXJzIGVhc2llciB0byBtaWdyYXRlIHRvIG5ld2VyIGxpbnV4IGtlcm5lbC4NCj4gPiA+IFJlZjog
aHR0cHM6Ly9saW51eHBsdW1iZXJzY29uZi5vcmcvZXZlbnQvNy9jb250cmlidXRpb25zLzc5MC8N
Cj4gPiA+DQo+ID4NCj4gPiBJIHVuZGVyc3RhbmQgdGhhdC4gQnV0IEkgYW0gaW50ZXJlc3RlZCBp
biBsb29raW5nIGF0IHRoZSBtb2R1bGUgeW91IHdhbnQNCj4gPiB0byB1c2UgdGhpcyBhbmQgaG93
IHRoYXQgaW50ZXJhY3RzIHdpdGggUFNDSS4gSWYgdGhpcyBpcyBhcm02NCwgeW91IG11c3QNCj4g
PiB1c2UgUFNDSSBmb3Igc3lzdGVtIHN1c3BlbmQgYW5kIGNwdSBzdXNwZW5kLiBXaGF0IGRvZXMg
dGhpcyBtb2R1bGUgZG8gb24NCj4gPiB0b3Agb2YgdGhvc2UgaXMgd2hhdCBJIHdhbnQgdG8ga25v
dy4gUGxlYXNlIHBvc3QgdGhhdCBtb2R1bGUgb3IgcG9pbnQNCj4gPiBtZSBpZiBpdCBpcyBhbHJl
YWR5IHByZXNlbnQgaW4gdGhlIHRyZWUuDQo+IA0KPiBSZWdhcmRsZXNzLCBnZW5lcmFsbHkgc3Bl
YWtpbmcsIHBhdGNoZXMgdGhhdCBleHBvcnQgc3R1ZmYgdG8gbW9kdWxlcw0KPiB3aXRob3V0IGFu
IGluLXRoZS10cmVlIHVzZXIgbmVlZGluZyB0aGlzIGFyZSBub3QgYXBwbGljYWJsZSB0byB0aGUN
Cj4gbWFpbmxpbmUga2VybmVsIHNvdXJjZSB0cmVlIElNVi4NCj4gDQo+IENoZWVycyENCg0KDQpU
aGFuayBmb3IgeW91ciBmZWVkYmFja3MhDQoNCkluZGVlZCwgdGhlcmUgaXMgbm8gYWN0dWFsIGtl
cm5lbCBtb2R1bGUgd2hpY2ggdXNlcyBzMmlkbGVfc2V0X29wcyBpbg0KTWFpbmxpbmUga2VybmVs
IHJpZ2h0IG5vdy4NCg0KSG93ZXZlciwgR29vZ2xlIHJlY2VudGx5IGFzayBTb0MgdmVuZG9ycyB0
byBidWlsZCBkcml2ZXJzIGFzIGtlcm5lbA0KbW9kdWxlcyBmb3IgcmVkdWNpbmcgbWlncmF0aW9u
IGVmZm9ydHMuIEZvciBleGFtcGxlLCBUaGUgcG93ZXINCm1hbmFnZW1lbnQgZHJpdmVyIG9uIE1l
ZGlhdGVrIHBsYXRmb3JtIGlzIG5vdyBidWlsdCBhcyB2ZW5kb3IgbW9kdWxlLA0Kd2hpY2ggaGFz
IG5vIHBsYW4gdG8gdXBzdHJlYW0gc28gZmFyLiANCg0KRnJvbSBNYWlubGluZSBrZXJuZWwncyBw
ZXJzcGVjdGl2ZSwgSSBhbSB3b25kZXJpbmcgd2hldGhlciBzdWNoIHZlbmRvcg0KbW9kdWxlcyBh
cmUgYXBwbGljYWJsZSB0byBleHBvcnQgQVBJcy4gRXhwb3J0aW5nIEFQSXMgb25seSBhdCBHb29n
bGUncw0KQW5kcm9pZCBDb21tb24gS2VybmVsIGlzIGFuIG9wdGlvbiwgYnV0IHRoaXMgd291bGQg
bWFrZSBBbmRyb2lkIEtlcm5lbA0KYW5kIE1haW5saW5lIGtlcm5lbCBtdWNoIG1vcmUgZGl2ZXJz
ZS4NCg0KUmVnYXJkcywNCkNsYXVkZQ0KDQo=

