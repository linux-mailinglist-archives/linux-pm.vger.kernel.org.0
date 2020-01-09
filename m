Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 998F8135151
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2020 03:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgAIC2K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jan 2020 21:28:10 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:17409 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726758AbgAIC2K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jan 2020 21:28:10 -0500
X-UUID: 8efac21a52b6424690e94ac0a754df04-20200109
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=838Cc8+KqcxYDVnAL0XU6OJBKM3nfNiVLnoFblbQyZw=;
        b=ljvBMHd1pKAcKBG1lWVx336Jjl2GJ+HSNn4bHAqZjzvEAtBA8fS687I9MTAn/dOT3eo5UttZinpAJXlWMHKeiEGLmf8JNvTt8bO5FYb6UX/MFiyEsx5vLgswg2xwG7s6J+DxVvqY/6dk5NfiQ2dZ4EtHa6iSOenNMAp19GJ2/Wk=;
X-UUID: 8efac21a52b6424690e94ac0a754df04-20200109
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1912375700; Thu, 09 Jan 2020 10:27:57 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 9 Jan
 2020 10:24:17 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 9 Jan 2020 10:28:13 +0800
Message-ID: <1578536872.21256.25.camel@mhfsdcap03>
Subject: Re: [PATCH] usb: common: usb-conn-gpio: Register charger
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Paul Cercueil <paul@crapouillou.net>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, <od@zcrc.me>,
        <linux-usb@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Date:   Thu, 9 Jan 2020 10:27:52 +0800
In-Reply-To: <1578504370.3.1@crapouillou.net>
References: <20200107002901.940297-1-paul@crapouillou.net>
         <20200108165323.GA2506374@kroah.com> <1578504370.3.1@crapouillou.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 40D221BFADE0B52CB83D97C4692C5266B11D679C287C449086D5AC23C5A64CFC2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgUGF1bCwNCg0KT24gV2VkLCAyMDIwLTAxLTA4IGF0IDE0OjI2IC0wMzAwLCBQYXVsIENlcmN1
ZWlsIHdyb3RlOg0KPiBIaSBHcmVnLA0KPiANCj4gDQo+IExlIG1lci4sIGphbnYuIDgsIDIwMjAg
YXQgMTc6NTMsIEdyZWcgS3JvYWgtSGFydG1hbiANCj4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24u
b3JnPiBhIMOpY3JpdCA6DQo+ID4gT24gVHVlLCBKYW4gMDcsIDIwMjAgYXQgMDE6Mjk6MDFBTSAr
MDEwMCwgUGF1bCBDZXJjdWVpbCB3cm90ZToNCj4gPj4gIFJlZ2lzdGVyIGEgcG93ZXIgc3VwcGx5
IGNoYXJnZXIsIHdob3NlIG9ubGluZSBzdGF0ZSBkZXBlbmRzIG9uIA0KPiA+PiB3aGV0aGVyDQo+
ID4+ICB0aGUgVVNCIHJvbGUgaXMgc2V0IHRvIGRldmljZSBvciBub3QuDQo+ID4gDQo+ID4gVGhh
dCBzYXlzIF93aGF0XyB5b3UgYXJlIGRvaW5nLCBidXQgSSBoYXZlIG5vIGlkZWEgX3doeV8geW91
IHdhbnQgdG8gDQo+ID4gZG8NCj4gPiB0aGlzLg0KPiA+IA0KPiA+IFdoYXQgaXMgdGhpcyBnb2lu
ZyB0byBjYXVzZSB0byBoYXZlIGhhcHBlbj8gIFdoYXQgbmV3IHVzZXJzcGFjZSBhcGkgaXMNCj4g
PiBnb2luZyB0byByZXN1bHQ/ICBXaGF0IHdpbGwgYSB1c2VyIGRvIHdpdGggdGhpcz8NCj4gDQo+
IFRoaXMgaXMgdXNlZnVsIHdoZW4gdGhlIFVTQiByb2xlIGlzIHRoZSBvbmx5IHdheSB0byBrbm93
IGlmIHRoZSBkZXZpY2UgDQo+IGlzIGNoYXJnaW5nIGZyb20gVVNCLg0KVGhlcmUgaXMgbm8gY2hh
cmdlciBJQyBvbiB5b3VyIHBsYXRmb3JtPw0KDQo+IA0KPiBUaGUgQVBJIGlzIHRoZSBzdGFuZGFy
ZCBwb3dlciBzdXBwbHkgY2hhcmdlciBBUEksIHlvdSBnZXQgYSANCj4gL3N5cy9jbGFzcy9wb3dl
cl9zdXBwbHkveHh4L29ubGluZSBub2RlIHdoaWNoIHRlbGxzIHlvdSB0aGUgc3RhdGUgb2YgDQo+
IHRoZSBjaGFyZ2VyLg0KPiANCj4gVGhlIHNvbGUgcHVycG9zZSBvZiB0aGlzIGlzIHRvIGdpdmUg
dXNlcnNwYWNlIGFwcGxpY2F0aW9ucyBhIHdheSB0byANCj4ga25vdyB3aGV0aGVyIG9yIG5vdCB0
aGUgY2hhcmdlciBpcyBwbHVnZ2VkLg0KPiANCj4gPiBJcyB0aGlzIGdvaW5nIHRvIGFsd2F5cyBz
aG93IHVwLCBubyBtYXR0ZXIgaWYgdGhlIHJvbGUgaXMgbm90IGV2ZW4NCj4gPiByZWxldmFudCBm
b3IgYSBwb3dlciBzdXBwbHk/DQo+IA0KPiBJIGd1ZXNzIGl0J2QgYWx3YXlzIHNob3cgdXAsIHll
cy4gSW4gd2hpY2ggY2FzZSB3b3VsZCB0aGUgcm9sZSBub3QgYmUgDQo+IHJlbGV2YW50IGZvciBh
IHBvd2VyIHN1cHBseT8gDQpEbyB5b3UgYWxzbyBuZWVkIGl0IGlmIHRoZSBwbGF0Zm9ybSBkb24n
dCBoYXZlIGJhdHRlcnk/DQoNCg0KPiBJcyBncGlvLWItY29ubmVjdG9yIG5vdCBhbHdheXMgdXNl
ZCBmb3IgDQo+IE9URyBjb25uZWN0b3JzPw0KSXQgYWxzbyBzdXBwb3J0cyBkZXZpY2Ugb25seSBt
b2RlLCB1c3VhbGx5IHVzZXMgdkJ1cyBwaW4gdG8NCmVuYWJsZS9kaXNhYmxlIGNvbnRyb2xsZXIN
Cg0KPiANCj4gQ2hlZXJzLA0KPiAtUGF1bA0KPiANCj4gDQo+ID4gWW91IG5lZWQgYSBsb3QgbW9y
ZSB0ZXh0IGhlcmUgdG8gbWFrZSB0aGlzIG1lcmdhYmxlLg0KPiA+IA0KPiA+IHRoYW5rcywNCj4g
PiANCj4gPiBncmVnIGstaA0KPiANCj4gDQoNCg==

