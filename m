Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B26A438208
	for <lists+linux-pm@lfdr.de>; Sat, 23 Oct 2021 08:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbhJWGiG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 23 Oct 2021 02:38:06 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:5862 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229446AbhJWGiF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 23 Oct 2021 02:38:05 -0400
X-UUID: febd30177cd84bcdaad3c28cdb4ba5ec-20211023
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=R3aTcF7O0aGUzIL4osqUpcRxNDRTCJBgz3G98SJr1EU=;
        b=rEtm0Z2Pu9Fng9hUoswoWbxzVRygpGUAAhnxPD2JGJVfQBdlWLBIQhK/kwg9mt2AtsO1FiOVsU4S8xXv7qoTvlY3p4d2U7FgAR7FfqfEbYRLzswde9ODidXtm+z/rBVMBHSXs0pq2WZhTmWGtQVmKBjGbVM2z9PiaBhdfP//7pU=;
X-UUID: febd30177cd84bcdaad3c28cdb4ba5ec-20211023
Received: from mtkcas34.mediatek.inc [(172.27.7.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1514210481; Sat, 23 Oct 2021 14:15:37 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 23 Oct
 2021 14:35:37 +0800
Received: from mhfsdcap04 (10.17.3.154) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 23 Oct 2021 14:35:37 +0800
Message-ID: <df145215a21b67b440405736d9628199ccce2a1b.camel@mediatek.com>
Subject: Re: [PATCH v3 1/2] PM / wakeirq: support enabling wake-up irq after
 runtime_suspend called
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Ikjoon Jang <ikjn@chromium.org>
Date:   Sat, 23 Oct 2021 14:35:37 +0800
In-Reply-To: <CAJZ5v0hTR2mZk7FuUVciX766qq0AwWXFBZoBsV3Sd9ToYuErdQ@mail.gmail.com>
References: <1628651069-22162-1-git-send-email-chunfeng.yun@mediatek.com>
         <CAJZ5v0hTR2mZk7FuUVciX766qq0AwWXFBZoBsV3Sd9ToYuErdQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: F81D45C16EBD5ADB83FF540E1F395C74EFC9FCDEBE5272D370F7D6D128F92EB02000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gVHVlLCAyMDIxLTEwLTE5IGF0IDE3OjI4ICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gT24gV2VkLCBBdWcgMTEsIDIwMjEgYXQgNTowNSBBTSBDaHVuZmVuZyBZdW4gPA0KPiBj
aHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPiB3cm90ZToNCj4gPiANCj4gPiBXaGVuIHRoZSBkZWRp
Y2F0ZWQgd2FrZS1pcnEgaXMgbGV2ZWwgdHJpZ2dlciwgYW5kIGl0IHVzZXMgdGhlDQo+ID4gY29u
c3VtZXIncyBzbGVlcCBzdGF0dXMgYXMgdGhlIHdha2V1cCBzb3VyY2UsIHRoYXQgbWVhbnMgaWYg
dGhlDQo+ID4gY29uc3VtZXIgaXMgbm90IGluIHNsZWVwIHN0YXRlLCB0aGUgd2FrZS1pcnEgd2ls
bCBiZSB0cmlnZ2VyZWQNCj4gPiB3aGVuIGVuYWJsZSBpdDsgRm9yIHRoaXMgY2FzZSwgbmVlZCBl
bmFibGUgdGhlIHdha2UtaXJxIGFmdGVyDQo+ID4gaW52b2tpbmcgdGhlIGNvbnN1bWVyJ3MgcnVu
dGltZV9zdXNwZW5kKCkgd2hpY2ggbWFrZSB0aGUgY29uc3VtZXINCj4gPiBlbnRlciBzbGVlcCBz
dGF0ZS4NCj4gDQo+IFRoZSB0ZXJtaW5vbG9neSBhYm92ZSBpcyBjb25mdXNpbmcuDQo+IA0KPiBB
cyBhIHJ1bGUsIHRoZSB0ZXJtICJzbGVlcCBzdGF0ZSIgYXBwbGllcyB0byB0aGUgd2hvbGUgc3lz
dGVtLCBub3QgdG8NCj4gYW4gaW5kaXZpZHVhbCBjb21wb25lbnQuICBJdCBpcyBiZXR0ZXIgdG8g
dXNlIHRoZSB0ZXJtICJsb3ctcG93ZXINCj4gc3RhdGUiIGluc3RlYWQuICBBbHNvLCB0aGVyZSBt
YXkgYmUgbXVsdGlwbGUgbG93LXBvd2VyIHN0YXRlcyBwZXINCj4gZGV2aWNlIGFuZCBpdCBpcyBu
b3QgY2xlYXIgd2hpY2ggb2YgdGhlbSBpcyByZWxldmFudCBoZXJlLiANCkZvciBVU0IzIGNvbnRy
b2xsZXIsIGhlcmUgbWVhbnMgZW50ZXIgVTMgc3RhdGUgKG9yIFBDSSBwbSBzdGF0ZSwNCkQzaG90
L0QzY29sZCkNCg0KPiAgTXkgZ3Vlc3MNCj4gaXMgdGhhdCB0aGUgSVJRIHdpbGwgdHJpZ2dlciB1
bmxlc3MgcG93ZXIgaXMgcmVtb3ZlZCBmcm9tIHRoZSBkZXZpY2UNCj4gYW5kIHlvdSB3YW50IHRv
IHJlbW92ZSBwb3dlciBmcm9tIHRoZSBkZXZpY2UgaW4gLT5ydW50aW1lX3N1c3BlbmQoKS4NClRo
ZSBwb3dlciBpcyBvZmYgb3Igb24gZGVwZW5kZW50cyBvbiB0aGlzIGRldmljZXMgaGFzIGluZGVw
ZW5kZW50DQptdGNtb3MsIG5vIG1hdHRlciB3aGljaCBjYXNlLCB3YWtlIElSUSBuZWVkIGJlIGVu
YWJsZWQgYWZ0ZXINCi0+cnVudGltZV9zdXNwZW5kKCkuDQo+IA0KPiBNb3Jlb3ZlciwgSSdtIGFz
c3VtaW5nIHRoYXQgInRoZSBjb25zdW1lciIgbWVhbnMgInRoZSBkZXZpY2UgdXNpbmcNCj4gdGhl
DQo+IHdha2UgSVJRIiwgDQpZZXMsIGl0J3MuDQo+IGJ1dCB0aGlzIGlzIG5vdCBwYXJ0aWN1bGFy
bHkgY2xlYXIgZWl0aGVyLg0KPiANCj4gTm93LCB0aGUgcHJvYmxlbSBpcyB0aGF0IHlvdSBuZWVk
IHRoZSBkZXZpY2UgdXNpbmcgdGhlIHdha2UgSVJRIHRvIGJlDQo+IGluIGEgbG93LXBvd2VyIHN0
YXRlIGluIHdoaWNoIHRoZSBJUlEgZG9lc24ndCB0cmlnZ2VyIGF1dG9tYXRpY2FsbHkNCj4gYmVm
b3JlIGVuYWJsaW5nIHRoZSBJUlEsIGFuZCBzbyB5b3UgbmVlZCB0byBlbmFibGUgdGhlIElSUSBh
ZnRlcg0KPiBydW5uaW5nIC0+cnVudGltZV9zdXNwZW5kKCkgZm9yIHRoYXQgZGV2aWNlDQpZZXMN
Cj4gIGFuZCBJTU8gdGhpcyBpcyBob3cgaXQNCj4gbmVlZHMgdG8gYmUgZGVzY3JpYmVkLg0KT2ss
IEknbGwgbW9kaWZ5IGNvbW1pdCBtZXNzYWdlLg0KDQo+IA0KPiA+IGUuZy4NCj4gPiBBc3N1bWUg
dGhlIHdha2UtaXJxIGlzIGEgbG93IGxldmVsIHRyaWdnZXIgdHlwZSwgYW5kIHRoZSB3YWtldXAN
Cj4gPiBzaWduYWwgY29tZXMgZnJvbSB0aGUgc2xlZXAgc3RhdHVzIG9mIGNvbnN1bWVyLg0KPiA+
IFRoZSB3YWtldXAgc2lnbmFsIGlzIGxvdyBsZXZlbCBhdCBydW5uaW5nIHRpbWUgKDApLCBhbmQg
YmVjb21lcw0KPiA+IGhpZ2ggbGV2ZWwgd2hlbiB0aGUgY29uc3VtZXIgZW50ZXJzIHNsZWVwIHN0
YXRlIChydW50aW1lX3N1c3BlbmQNCj4gPiAoMSkgaXMgY2FsbGVkKSwgYSB3YWtldXAgZXZlbnQg
YXQgKDIpIG1ha2UgdGhlIGNvbnN1bWVyIGV4aXQgc2xlZXANCj4gPiBzdGF0ZSwgdGhlbiB0aGUg
d2FrZXVwIHNpZ25hbCBhbHNvIGJlY29tZXMgbG93IGxldmVsLg0KPiA+IA0KPiA+ICAgICAgICAg
ICAgICAgICAtLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAgICAgICAgICAgICAgICB8ICAgICAgICAg
ICBeICAgICBefA0KPiA+IC0tLS0tLS0tLS0tLS0tLS0gICAgICAgICAgIHwgICAgIHwgLS0tLS0t
LS0tLS0tLS0NCj4gPiAgfDwtLS0oMCktLS0+fDwtLSgxKS0tfCAgICgzKSAgICgyKSAgICAoNCkN
Cj4gPiANCj4gPiBpZiBlbmFibGUgdGhlIHdha2UtaXJxIGJlZm9yZSBjYWxsaW5nIHJ1bnRpbWVf
c3VzcGVuZCBkdXJpbmcgKDApLA0KPiA+IGFuIGludGVycnVwdCB3aWxsIGFyaXNlLCBpdCBjYXVz
ZXMgcmVzdW1lIGltbWVkaWF0ZWx5Ow0KPiA+IGl0IHdvcmtzIGlmIGVuYWJsZSB3YWtlLWlycSAo
IGUuZy4gYXQgKDMpIG9yICg0KSkgYWZ0ZXIgY2FsbGluZw0KPiA+IHJ1bnRpbWVfc3VzcGVuZC4N
Cj4gPiANCj4gPiBUaGlzIHBhdGNoIGludHJvZHVjZXMgYSBuZXcgc3RhdHVzIFdBS0VfSVJRX0RF
RElDQVRFRF9MQVRFX0VOQUJMRUQNCj4gPiB0byBvcHRpb25hbGx5IHN1cHBvcnQgZW5hYmxpbmcg
d2FrZS1pcnEgYWZ0ZXIgY2FsbGluZw0KPiA+IHJ1bnRpbWVfc3VzcGVuZCgpLg0KPiA+IA0KPiA+
IFN1Z2dlc3RlZC1ieTogUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwu
Y29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlh
dGVrLmNvbT4NCj4gPiAtLS0NCj4gPiB2MzogYWRkIG5ldyBzdGF0dXMgc3VnZ2VzdGVkIGJ5IFJh
ZmFlbA0KPiA+IA0KPiA+IHYyOiBhZGQgbW9yZSBjb21taXQgbWVzc2FnZQ0KPiA+IA0KPiA+ICAg
VXNlIHRoZSBmYWxsaW5nIGVkZ2UgdHJpZ2dlciBpbnRlcnJ1cHQgc3VnZ2VzdGVkIGJ5IElram9v
biBbMV0sDQo+ID4gaXQNCj4gPiB3b3JrcyB3ZWxsIGF0IGZpcnN0bHkgd2hlbiBvbmx5IHVzZSB0
aGlzIHJlbGF0ZWQgd2FrZXVwIHNvdXJjZSwgYnV0DQo+ID4gZW5jb3VudGVyIGlzc3VlcyBpZiB1
c2Ugb3RoZXIgd2FrZXVwIHNvdXJjZXMgdG8gd2FrZXVwIHBsYXRmb3JtIGFzDQo+ID4gYmVsb3cg
c3RlcHM6DQo+ID4gMS4gdXNlIGFub3RoZXIgd2FrZXVwIHNvdXJjZSB0byB3YWtlIHVwIHRoZSBz
dXNwZW5kZWQgc3lzdGVtOw0KPiA+IDIuIHRoZSBjb25zdW1lcidzIHJlc3VtZSgpIHdpbGwgYmUg
Y2FsbGVkLCBhbmQgZXhpdHMgc2xlZXAgc3RhdGU7DQo+ID4gMy4gdGhlIGNvbnN1bWVyJ3Mgd2Fr
ZXVwIHNpZ25hbCB3aWxsIGZhbGwgaW50byBsb3cgbGV2ZWwsIGR1ZSB0bw0KPiA+ICAgIGN1cnJl
bnRseSB0aGUgd2FrZXVwIGlycSBpcyBkaXNhYmxlZCwgdGhlIHdha2UtaXJxIGlzIHBlbmRpbmc7
DQo+ID4gNC4gdGhlIGNvbnN1bWVyIHRyaWVzIHRvIGVudGVyIHJ1bnRpbWUgc3VzcGVuZCwgYnV0
IHRoZXJlIGlzIGENCj4gPiAgICBwZW5kaW5nIHdha2V1cCBpcnEsIHNvIHdpbGwgcmVzdW1lIGFn
YWluLCB0aGlzIHdpbGwgcmVwZWF0DQo+ID4gICAgZW5kbGVzc2x5Lg0KPiA+IA0KPiA+ICAgU2Vu
ZCBvdXQgdGhlIHBhdGNoIGFnYWluIGZvciBmdXJ0aGVyIGRpc2N1c3Npb24uDQo+ID4gDQo+ID4g
WzFdOiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzEyMTkwNDA3DQo+ID4gDQo+
ID4gLS0tDQo+ID4gIGRyaXZlcnMvYmFzZS9wb3dlci9wb3dlci5oICAgfCAgNyArKysrLS0NCj4g
PiAgZHJpdmVycy9iYXNlL3Bvd2VyL3J1bnRpbWUuYyB8ICA2ICsrKy0tDQo+ID4gIGRyaXZlcnMv
YmFzZS9wb3dlci93YWtlaXJxLmMgfCA0OQ0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKy0tLQ0KPiA+ICBpbmNsdWRlL2xpbnV4L3BtX3dha2VpcnEuaCAgIHwgIDUgKysrKw0K
PiA+ICA0IGZpbGVzIGNoYW5nZWQsIDYwIGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+
ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmFzZS9wb3dlci9wb3dlci5oDQo+ID4gYi9k
cml2ZXJzL2Jhc2UvcG93ZXIvcG93ZXIuaA0KPiA+IGluZGV4IDU0MjkyY2RkNzgwOC4uMmQ1ZGZj
ODg2ZjBiIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvYmFzZS9wb3dlci9wb3dlci5oDQo+ID4g
KysrIGIvZHJpdmVycy9iYXNlL3Bvd2VyL3Bvd2VyLmgNCj4gPiBAQCAtMjUsOCArMjUsMTAgQEAg
ZXh0ZXJuIHU2NCBwbV9ydW50aW1lX2FjdGl2ZV90aW1lKHN0cnVjdCBkZXZpY2UNCj4gPiAqZGV2
KTsNCj4gPiANCj4gPiAgI2RlZmluZSBXQUtFX0lSUV9ERURJQ0FURURfQUxMT0NBVEVEICAgQklU
KDApDQo+ID4gICNkZWZpbmUgV0FLRV9JUlFfREVESUNBVEVEX01BTkFHRUQgICAgIEJJVCgxKQ0K
PiA+ICsjZGVmaW5lIFdBS0VfSVJRX0RFRElDQVRFRF9MQVRFX0VOQUJMRUQgICAgICAgIEJJVCgy
KQ0KPiANCj4gVGhpcyBuYW1lIGlzIGEgYml0IGxvbmcgYW5kIGl0IGRvZXNuJ3QgcmVmbGVjdCB0
aGUgbmF1dHJlIG9mIHRoZQ0KPiBwcm9ibGVtLCB3aGljaCBpcyB0aGF0IHlvdSBuZWVkIGNvZGUg
b3JkZXJpbmcgdGhhdCBpcyBhIHJldmVyc2Ugb2YNCj4gdGhlDQo+IHVzdWFsIGZsb3cuDQo+IA0K
PiBXQUtFX0lSUV9ERURJQ0FURURfUkVWRVJTRSBtYXkgYmUgYSBiZXR0ZXIgbmFtZS4NCk9LDQoN
Cj4gDQo+ID4gICNkZWZpbmUNCj4gPiBXQUtFX0lSUV9ERURJQ0FURURfTUFTSyAgICAgICAgICAg
ICAgICAoV0FLRV9JUlFfREVESUNBVEVEX0FMTE9DQVRFDQo+ID4gRCB8IFwNCj4gPiAtICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFdBS0VfSVJRX0RFRElDQVRFRF9NQU5B
R0VEDQo+ID4gKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
V0FLRV9JUlFfREVESUNBVEVEX01BTkFHRUQNCj4gPiB8IFwNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIFdBS0VfSVJRX0RFRElDQVRFRF9MQVRFX0VODQo+ID4g
QUJMRUQpDQo+ID4gDQo+ID4gIHN0cnVjdCB3YWtlX2lycSB7DQo+ID4gICAgICAgICBzdHJ1Y3Qg
ZGV2aWNlICpkZXY7DQo+ID4gQEAgLTM5LDcgKzQxLDggQEAgZXh0ZXJuIHZvaWQgZGV2X3BtX2Fy
bV93YWtlX2lycShzdHJ1Y3Qgd2FrZV9pcnENCj4gPiAqd2lycSk7DQo+ID4gIGV4dGVybiB2b2lk
IGRldl9wbV9kaXNhcm1fd2FrZV9pcnEoc3RydWN0IHdha2VfaXJxICp3aXJxKTsNCj4gPiAgZXh0
ZXJuIHZvaWQgZGV2X3BtX2VuYWJsZV93YWtlX2lycV9jaGVjayhzdHJ1Y3QgZGV2aWNlICpkZXYs
DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29sIGNhbl9j
aGFuZ2Vfc3RhdHVzKTsNCj4gPiAtZXh0ZXJuIHZvaWQgZGV2X3BtX2Rpc2FibGVfd2FrZV9pcnFf
Y2hlY2soc3RydWN0IGRldmljZSAqZGV2KTsNCj4gPiArZXh0ZXJuIHZvaWQgZGV2X3BtX2Rpc2Fi
bGVfd2FrZV9pcnFfY2hlY2soc3RydWN0IGRldmljZSAqZGV2LCBib29sDQo+ID4gc2tpcF9lbmFi
bGVfbGF0ZSk7DQo+ID4gK2V4dGVybiB2b2lkIGRldl9wbV9lbmFibGVfd2FrZV9pcnFfY29tcGxl
dGUoc3RydWN0IGRldmljZSAqZGV2KTsNCj4gPiANCj4gPiAgI2lmZGVmIENPTkZJR19QTV9TTEVF
UA0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Jhc2UvcG93ZXIvcnVudGltZS5jDQo+
ID4gYi9kcml2ZXJzL2Jhc2UvcG93ZXIvcnVudGltZS5jDQo+ID4gaW5kZXggOGE2NmVhZjczMWU0
Li45NzY0NmFhMTEzNzYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9iYXNlL3Bvd2VyL3J1bnRp
bWUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvYmFzZS9wb3dlci9ydW50aW1lLmMNCj4gPiBAQCAtNjQ1
LDYgKzY0NSw4IEBAIHN0YXRpYyBpbnQgcnBtX3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2LCBp
bnQNCj4gPiBycG1mbGFncykNCj4gPiAgICAgICAgIGlmIChyZXR2YWwpDQo+ID4gICAgICAgICAg
ICAgICAgIGdvdG8gZmFpbDsNCj4gPiANCj4gPiArICAgICAgIGRldl9wbV9lbmFibGVfd2FrZV9p
cnFfY29tcGxldGUoZGV2KTsNCj4gPiArDQo+ID4gICBub19jYWxsYmFjazoNCj4gPiAgICAgICAg
IF9fdXBkYXRlX3J1bnRpbWVfc3RhdHVzKGRldiwgUlBNX1NVU1BFTkRFRCk7DQo+ID4gICAgICAg
ICBwbV9ydW50aW1lX2RlYWN0aXZhdGVfdGltZXIoZGV2KTsNCj4gPiBAQCAtNjkwLDcgKzY5Miw3
IEBAIHN0YXRpYyBpbnQgcnBtX3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2LCBpbnQNCj4gPiBy
cG1mbGFncykNCj4gPiAgICAgICAgIHJldHVybiByZXR2YWw7DQo+ID4gDQo+ID4gICBmYWlsOg0K
PiA+IC0gICAgICAgZGV2X3BtX2Rpc2FibGVfd2FrZV9pcnFfY2hlY2soZGV2KTsNCj4gPiArICAg
ICAgIGRldl9wbV9kaXNhYmxlX3dha2VfaXJxX2NoZWNrKGRldiwgZmFsc2UpOw0KPiA+ICAgICAg
ICAgX191cGRhdGVfcnVudGltZV9zdGF0dXMoZGV2LCBSUE1fQUNUSVZFKTsNCj4gPiAgICAgICAg
IGRldi0+cG93ZXIuZGVmZXJyZWRfcmVzdW1lID0gZmFsc2U7DQo+ID4gICAgICAgICB3YWtlX3Vw
X2FsbCgmZGV2LT5wb3dlci53YWl0X3F1ZXVlKTsNCj4gPiBAQCAtODczLDcgKzg3NSw3IEBAIHN0
YXRpYyBpbnQgcnBtX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYsIGludA0KPiA+IHJwbWZsYWdz
KQ0KPiA+IA0KPiA+ICAgICAgICAgY2FsbGJhY2sgPSBSUE1fR0VUX0NBTExCQUNLKGRldiwgcnVu
dGltZV9yZXN1bWUpOw0KPiA+IA0KPiA+IC0gICAgICAgZGV2X3BtX2Rpc2FibGVfd2FrZV9pcnFf
Y2hlY2soZGV2KTsNCj4gPiArICAgICAgIGRldl9wbV9kaXNhYmxlX3dha2VfaXJxX2NoZWNrKGRl
diwgdHJ1ZSk7DQo+ID4gICAgICAgICByZXR2YWwgPSBycG1fY2FsbGJhY2soY2FsbGJhY2ssIGRl
dik7DQo+ID4gICAgICAgICBpZiAocmV0dmFsKSB7DQo+ID4gICAgICAgICAgICAgICAgIF9fdXBk
YXRlX3J1bnRpbWVfc3RhdHVzKGRldiwgUlBNX1NVU1BFTkRFRCk7DQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvYmFzZS9wb3dlci93YWtlaXJxLmMNCj4gPiBiL2RyaXZlcnMvYmFzZS9wb3dlci93
YWtlaXJxLmMNCj4gPiBpbmRleCAzYmFkMzI2NmEyYWQuLmE2MTJmNWMyNmM2YyAxMDA2NDQNCj4g
PiAtLS0gYS9kcml2ZXJzL2Jhc2UvcG93ZXIvd2FrZWlycS5jDQo+ID4gKysrIGIvZHJpdmVycy9i
YXNlL3Bvd2VyL3dha2VpcnEuYw0KPiA+IEBAIC0yMTUsNiArMjE1LDI0IEBAIGludCBkZXZfcG1f
c2V0X2RlZGljYXRlZF93YWtlX2lycShzdHJ1Y3QNCj4gPiBkZXZpY2UgKmRldiwgaW50IGlycSkN
Cj4gPiAgfQ0KPiA+ICBFWFBPUlRfU1lNQk9MX0dQTChkZXZfcG1fc2V0X2RlZGljYXRlZF93YWtl
X2lycSk7DQo+ID4gDQo+ID4gKy8qKg0KPiA+ICsgKiBkZXZfcG1fd2FrZV9pcnFfc2V0X2xhdGVf
ZW5hYmxlZF9zdGF0dXMgLSBzZXQgc3RhdHVzDQo+ID4gV0FLRV9JUlFfREVESUNBVEVEX0xBVEVf
RU5BQkxFRA0KPiA+ICsgKiBAZGV2OiBEZXZpY2UNCj4gPiArICoNCj4gPiArICogU2V0IHRoZSBz
dGF0dXMgb2YgV0FLRV9JUlFfREVESUNBVEVEX0xBVEVfRU5BQkxFRCB0byB0ZWxsDQo+ID4gcnBt
X3N1c3BlbmQoKQ0KPiA+ICsgKiB0byBlbmFibGUgZGVkaWNhdGVkIHdha2UtdXAgaW50ZXJydXB0
IGFmdGVyIGludm9raW5nIHRoZQ0KPiA+IHJ1bnRpbWVfc3VzcGVuZCgpLA0KPiA+ICsgKg0KPiA+
ICsgKiBTaG91bGQgYmUgY2FsbGVkIGFmdGVyIHNldHRpbmcgZGVkaWNhdGVkIHdha2UtdXAgaW50
ZXJydXB0Lg0KPiA+ICsgKi8NCj4gPiArdm9pZCBkZXZfcG1fd2FrZV9pcnFfc2V0X2xhdGVfZW5h
YmxlZF9zdGF0dXMoc3RydWN0IGRldmljZSAqZGV2KQ0KPiA+ICt7DQo+ID4gKyAgICAgICBzdHJ1
Y3Qgd2FrZV9pcnEgKndpcnEgPSBkZXYtPnBvd2VyLndha2VpcnE7DQo+ID4gKw0KPiA+ICsgICAg
ICAgaWYgKHdpcnEgJiYgKHdpcnEtPnN0YXR1cyAmIFdBS0VfSVJRX0RFRElDQVRFRF9BTExPQ0FU
RUQpKQ0KPiA+ICsgICAgICAgICAgICAgICB3aXJxLT5zdGF0dXMgfD0gV0FLRV9JUlFfREVESUNB
VEVEX0xBVEVfRU5BQkxFRDsNCj4gPiArfQ0KPiA+ICtFWFBPUlRfU1lNQk9MX0dQTChkZXZfcG1f
d2FrZV9pcnFfc2V0X2xhdGVfZW5hYmxlZF9zdGF0dXMpOw0KPiANCj4gSW5zdGVhZCBvZiBkb2lu
ZyB0aGlzLCBJIHdvdWxkIHByb3ZpZGUgYSBzcGVjaWFsIHZlcnNpb24gb2YNCj4gZGV2X3BtX3Nl
dF9kZWRpY2F0ZWRfd2FrZV9pcnEoKSBmb3IgdGhpcyBzcGVjaWFsIHVzZSBjYXNlIHN1Y2ggdGhh
dA0KPiBpdA0KPiB3aWxsIHNldCBXQUtFX0lSUV9ERURJQ0FURURfTEFURV9FTkFCTEVEIChvciB3
aGF0ZXZlciB5b3UgY2FsbCBpdCkgYXQNCj4gdGhlIGFsbG9jYXRpb24gdGltZSAoYmVjYXVzZSB0
aGlzIGlzIGEgcHJvcGVydHkgb2YgdGhlIElSUSBhbmQgbm90DQo+IHNvbWV0aGluZyB0aGF0IGNh
biBjaGFuZ2UpLg0KPiANCj4gTWF5YmUgY2FsbCBpdCBkZXZfcG1fc2V0X2RlZGljYXRlZF93YWtl
X2lycV9yZXZlcnNlKCkgYW5kIGltcGxlbWV0DQo+IGJvdGggaXQgYW5kIGRldl9wbV9zZXRfZGVk
aWNhdGVkX3dha2VfaXJxKCkgYXMgd3JhcHBlcnMgYXJvdW5kDQo+IHNvbWV0aGluZyBsaWtlIF9f
ZGV2X3BtX3NldF9kZWRpY2F0ZWRfd2FrZV9pcnEoKSB0YWtpbmcgYW4gZXh0cmENCj4gYXJndW1l
bnQgdGhhdCB3aWxsIGluZGljYXRlIHdoZXRoZXIgb3Igbm90IHRvIHNldCB0aGUgbmV3IGZsYWcg
Zm9yDQo+IHRoaXMgSVJRLg0KT0ssIGl0J3MgYSBiZXR0ZXIgd2F5Lg0KDQo+IA0KPiA+ICsNCj4g
PiAgLyoqDQo+ID4gICAqIGRldl9wbV9lbmFibGVfd2FrZV9pcnEgLSBFbmFibGUgZGV2aWNlIHdh
a2UtdXAgaW50ZXJydXB0DQo+ID4gICAqIEBkZXY6IERldmljZQ0KPiA+IEBAIC0yODUsMjcgKzMw
Myw1MiBAQCB2b2lkIGRldl9wbV9lbmFibGVfd2FrZV9pcnFfY2hlY2soc3RydWN0DQo+ID4gZGV2
aWNlICpkZXYsDQo+ID4gICAgICAgICByZXR1cm47DQo+ID4gDQo+ID4gIGVuYWJsZToNCj4gPiAt
ICAgICAgIGVuYWJsZV9pcnEod2lycS0+aXJxKTsNCj4gPiArICAgICAgIGlmICghY2FuX2NoYW5n
ZV9zdGF0dXMgfHwgISh3aXJxLT5zdGF0dXMgJg0KPiA+IFdBS0VfSVJRX0RFRElDQVRFRF9MQVRF
X0VOQUJMRUQpKQ0KPiA+ICsgICAgICAgICAgICAgICBlbmFibGVfaXJxKHdpcnEtPmlycSk7DQo+
ID4gIH0NCj4gPiANCj4gPiAgLyoqDQo+ID4gICAqIGRldl9wbV9kaXNhYmxlX3dha2VfaXJxX2No
ZWNrIC0gQ2hlY2tzIGFuZCBkaXNhYmxlcyB3YWtlLXVwDQo+ID4gaW50ZXJydXB0DQo+ID4gICAq
IEBkZXY6IERldmljZQ0KPiA+ICsgKiBAc2tpcF9sYXRlX2VuYWJsZWRfc3RhdHVzOiBza2lwIGNo
ZWNraW5nDQo+ID4gV0FLRV9JUlFfREVESUNBVEVEX0xBVEVfRU5BQkxFRA0KPiANCj4gSSB3b3Vs
ZCBjYWxsIHRoaXMgYXJndW1lbnQgImNvbmRfZGlzYWJsZSIgb3Igc2ltaWxhcmx5IHRvIG1lYW4g
dGhhdA0KPiB0aGUgSVJRIHNob3VsZCBiZSBkaXNhYmxlZCBjb25kaXRpb25hbGx5IGRlcGVuZGlu
ZyBvbiB0aGUgbmV3IGZsYWcuDQo+IA0KPiBBbmQgdGhlIGRlc2NyaXB0aW9uIG9mIGl0IHdvdWxk
IGJlICJJZiBzZXQsIGFsc28gY2hlY2sNCj4gV0FLRV9JUlFfREVESUNBVEVEX0xBVEVfRU5BQkxF
RCIuDQpPSw0KPiANCj4gPiAgICoNCj4gPiAgICogRGlzYWJsZXMgd2FrZS11cCBpbnRlcnJ1cHQg
Y29uZGl0aW9uYWxseSBiYXNlZCBvbiBzdGF0dXMuDQo+ID4gICAqIFNob3VsZCBiZSBvbmx5IGNh
bGxlZCBmcm9tIHJwbV9zdXNwZW5kKCkgYW5kIHJwbV9yZXN1bWUoKSBwYXRoLg0KPiA+ICAgKi8N
Cj4gPiAtdm9pZCBkZXZfcG1fZGlzYWJsZV93YWtlX2lycV9jaGVjayhzdHJ1Y3QgZGV2aWNlICpk
ZXYpDQo+ID4gK3ZvaWQgZGV2X3BtX2Rpc2FibGVfd2FrZV9pcnFfY2hlY2soc3RydWN0IGRldmlj
ZSAqZGV2LCBib29sDQo+ID4gc2tpcF9sYXRlX2VuYWJsZWRfc3RhdHVzKQ0KPiANCj4gQ2FuJ3Qg
dGhpcyBmdW5jdGlvbiBiZSBzdGF0aWM/DQpJZiB3YW50IHRvIG1ha2UgaXQgc3RhdGljLCBzaG91
bGQgbW92ZSBpdCBmcm9tIHdha2VpcnEuYyBpbnRvIHJ1bnRpbWUuYw0KDQo+IA0KPiA+ICB7DQo+
ID4gICAgICAgICBzdHJ1Y3Qgd2FrZV9pcnEgKndpcnEgPSBkZXYtPnBvd2VyLndha2VpcnE7DQo+
ID4gDQo+ID4gICAgICAgICBpZiAoIXdpcnEgfHwgISh3aXJxLT5zdGF0dXMgJiBXQUtFX0lSUV9E
RURJQ0FURURfTUFTSykpDQo+ID4gICAgICAgICAgICAgICAgIHJldHVybjsNCj4gDQo+IEFuZCBJ
IHdvdWxkIGp1c3QgYWRkIHRoZSBmb2xsb3dpbmcgbGluZSBoZXJlOg0KPiANCj4gaWYgKGNvbmRf
ZGlzYWJsZSAmJiAod2lycS0+c3RhdHVzICYgV0FLRV9JUlFfREVESUNBVEVEX0xBVEVfRU5BQkxF
RCkpDQo+ICAgICAgICAgcmV0dXJuOw0KVGhpcyBjaGFuZ2UgZG9lc24ndCBjb3ZlciB0aGUgY2Fz
ZSAoV0FLRV9JUlFfREVESUNBVEVEX0xBVEVfRU5BQkxFRCBhbmQNCiBXQUtFX0lSUV9ERURJQ0FU
RURfTUFOQUdFRCBhcmUgYm90aCBzZXQgMSk6DQoNCi0tPnJwbV9zdXNwZW5kKCk6IHdpcnEtPmly
cSBpcyBlbmFibGVkDQotLT5ycG1fcmVzdW1lKCk6IGRpc2FibGUgd2lycS0+aXJxOyAoaWYgY2hh
bmdlIGl0LCBkb2Vzbid0IGRpc2FibGUNCndpcnEtPmlycSkNCg0KPiANCj4gPiANCj4gPiAtICAg
ICAgIGlmICh3aXJxLT5zdGF0dXMgJiBXQUtFX0lSUV9ERURJQ0FURURfTUFOQUdFRCkNCj4gPiAr
ICAgICAgIGlmICh3aXJxLT5zdGF0dXMgJiBXQUtFX0lSUV9ERURJQ0FURURfTUFOQUdFRCAmJg0K
PiA+ICsgICAgICAgICAgIChza2lwX2xhdGVfZW5hYmxlZF9zdGF0dXMgfHwNCj4gPiArICAgICAg
ICAgICAgISh3aXJxLT5zdGF0dXMgJiBXQUtFX0lSUV9ERURJQ0FURURfTEFURV9FTkFCTEVEKSkp
DQo+ID4gICAgICAgICAgICAgICAgIGRpc2FibGVfaXJxX25vc3luYyh3aXJxLT5pcnEpOw0KPiA+
ICB9DQo+ID4gDQo+ID4gKy8qKg0KPiA+ICsgKiBkZXZfcG1fZW5hYmxlX3dha2VfaXJxX2NvbXBs
ZXRlIC0gZW5hYmxlIHdha2UgaXJxIGJhc2VkIG9uDQo+ID4gc3RhdHVzDQo+IA0KPiAiRW5hYmxl
IHdha2UgSVJRIG5vdCBlbmFibGVkIGJlZm9yZSINCj4gDQo+ID4gKyAqIEBkZXY6IERldmljZQ0K
PiANCj4gIkRldmljZSB1c2luZyB0aGUgd2FrZSBJUlEiDQo+IA0KPiA+ICsgKg0KPiA+ICsgKiBF
bmFibGUgd2FrZS11cCBpbnRlcnJ1cHQgY29uZGl0aW9uYWxseSBiYXNlZCBvbiBzdGF0dXMsIG1h
aW5seQ0KPiA+IGZvcg0KPiA+ICsgKiBlbmFibGluZyB3YWtlLXVwIGludGVycnVwdCBhZnRlciBy
dW50aW1lX3N1c3BlbmQoKSBpcyBjYWxsZWQuDQo+ID4gKyAqDQo+ID4gKyAqIFNob3VsZCBiZSBv
bmx5IGNhbGxlZCBmcm9tIHJwbV9zdXNwZW5kKCkgcGF0aC4NCj4gDQo+IFRoaXMgcGFydCBvZiB0
aGUga2VybmVsZG9jIGNvbW1lbnQgbmVlZHMgdG8gYmUgcmV3cml0dGVuIHRvbywNCk9LDQo+ICBi
dXQgaXQNCj4gbG9va3MgbGlrZSB0aGUgZnVuY3Rpb24gY2FuIGJlIHN0YXRpYywgaW4gd2hpY2gg
Y2FzZSBpdCB3b24ndCBuZWVkDQo+IHRoZQ0KPiBrZXJuZWxkb2MgY29tbWVudCBhdCBhbGwuDQpX
aWxsIGFsc28gbmVlZCB0byBtb3ZlIGl0IGludG8gcnVudGltZS5jIGlmIG1ha2UgaXQgc3RhdGlj
DQoNClRoYW5rcyBhIGxvdA0KPiANCj4gPiArICovDQo+ID4gK3ZvaWQgZGV2X3BtX2VuYWJsZV93
YWtlX2lycV9jb21wbGV0ZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4gK3sNCj4gPiArICAgICAg
IHN0cnVjdCB3YWtlX2lycSAqd2lycSA9IGRldi0+cG93ZXIud2FrZWlycTsNCj4gPiArDQo+ID4g
KyAgICAgICBpZiAoIXdpcnEgfHwgISh3aXJxLT5zdGF0dXMgJiBXQUtFX0lSUV9ERURJQ0FURURf
TUFTSykpDQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybjsNCj4gPiArDQo+ID4gKyAgICAgICBp
ZiAod2lycS0+c3RhdHVzICYgV0FLRV9JUlFfREVESUNBVEVEX01BTkFHRUQgJiYNCj4gPiArICAg
ICAgICAgICB3aXJxLT5zdGF0dXMgJiBXQUtFX0lSUV9ERURJQ0FURURfTEFURV9FTkFCTEVEKQ0K
PiA+ICsgICAgICAgICAgICAgICBlbmFibGVfaXJxKHdpcnEtPmlycSk7DQo+ID4gK30NCj4gPiAr
DQo+ID4gIC8qKg0KPiA+ICAgKiBkZXZfcG1fYXJtX3dha2VfaXJxIC0gQXJtIGRldmljZSB3YWtl
LXVwDQo+ID4gICAqIEB3aXJxOiBEZXZpY2Ugd2FrZS11cCBpbnRlcnJ1cHQNCj4gPiBkaWZmIC0t
Z2l0IGEvaW5jbHVkZS9saW51eC9wbV93YWtlaXJxLmgNCj4gPiBiL2luY2x1ZGUvbGludXgvcG1f
d2FrZWlycS5oDQo+ID4gaW5kZXggY2Q1YjYyZGI5MDg0Li45MmY4MTRkNTgzZjggMTAwNjQ0DQo+
ID4gLS0tIGEvaW5jbHVkZS9saW51eC9wbV93YWtlaXJxLmgNCj4gPiArKysgYi9pbmNsdWRlL2xp
bnV4L3BtX3dha2VpcnEuaA0KPiA+IEBAIC0yMiw2ICsyMiw3IEBAIGV4dGVybiBpbnQgZGV2X3Bt
X3NldF9kZWRpY2F0ZWRfd2FrZV9pcnEoc3RydWN0DQo+ID4gZGV2aWNlICpkZXYsDQo+ID4gIGV4
dGVybiB2b2lkIGRldl9wbV9jbGVhcl93YWtlX2lycShzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiA+
ICBleHRlcm4gdm9pZCBkZXZfcG1fZW5hYmxlX3dha2VfaXJxKHN0cnVjdCBkZXZpY2UgKmRldik7
DQo+ID4gIGV4dGVybiB2b2lkIGRldl9wbV9kaXNhYmxlX3dha2VfaXJxKHN0cnVjdCBkZXZpY2Ug
KmRldik7DQo+ID4gK2V4dGVybiB2b2lkIGRldl9wbV93YWtlX2lycV9zZXRfbGF0ZV9lbmFibGVk
X3N0YXR1cyhzdHJ1Y3QgZGV2aWNlDQo+ID4gKmRldik7DQo+ID4gDQo+ID4gICNlbHNlICAvKiAh
Q09ORklHX1BNICovDQo+ID4gDQo+ID4gQEAgLTQ3LDUgKzQ4LDkgQEAgc3RhdGljIGlubGluZSB2
b2lkIGRldl9wbV9kaXNhYmxlX3dha2VfaXJxKHN0cnVjdA0KPiA+IGRldmljZSAqZGV2KQ0KPiA+
ICB7DQo+ID4gIH0NCj4gPiANCj4gPiArc3RhdGljIGlubGluZSB2b2lkIGRldl9wbV93YWtlX2ly
cV9zZXRfbGF0ZV9lbmFibGVkX3N0YXR1cyhzdHJ1Y3QNCj4gPiBkZXZpY2UgKmRldikNCj4gPiAr
ew0KPiA+ICt9DQo+ID4gKw0KPiA+ICAjZW5kaWYgLyogQ09ORklHX1BNICovDQo+ID4gICNlbmRp
ZiAvKiBfTElOVVhfUE1fV0FLRUlSUV9IICovDQo+ID4gLS0NCg==

