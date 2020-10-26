Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0473D2986D3
	for <lists+linux-pm@lfdr.de>; Mon, 26 Oct 2020 07:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1770335AbgJZGUx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Oct 2020 02:20:53 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:36573 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1421050AbgJZGUw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Oct 2020 02:20:52 -0400
X-UUID: 5beb7359ae7b45ef8a6a455afdece6c2-20201026
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=XLrInF8GgdwjAwEAE1PEiTWBLKaCKIMlSZI9fSZKKDU=;
        b=JLaCcSPTI6bU0Xv6wD/N8h+7AI3tWiCShN6PzmPhSD8dbeBV89RZaGh8esDhjfMz1tHtj6j17bl0hqwGhCv40nfoenzySttM+7r/hQd0U93OcjKOWqPOQAjx2ESyDJ4iIxBaoulmDNAGpfEPIkC8Mgh0P1txBKI31dldJwORsVA=;
X-UUID: 5beb7359ae7b45ef8a6a455afdece6c2-20201026
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 142169136; Mon, 26 Oct 2020 14:20:43 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 26 Oct 2020 14:20:34 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 26 Oct 2020 14:20:33 +0800
Message-ID: <1603693234.20535.9.camel@mtkswgap22>
Subject: Re: [PATCH v1] cpufreq: mediatek-hw: Add support for Mediatek
 cpufreq HW driver
From:   Hector Yuan <hector.yuan@mediatek.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Maxime Ripard <mripard@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        "Stephen Boyd" <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dave Gerlach <d-gerlach@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wsd_upstream@mediatek.com>
Date:   Mon, 26 Oct 2020 14:20:34 +0800
In-Reply-To: <20201023092720.qpws5wivqb4u6fwl@vireshk-i7>
References: <1603441493-18554-1-git-send-email-hector.yuan@mediatek.com>
         <20201023082817.5vp4cvi2lmpaozcn@vireshk-i7>
         <1603444138.20224.19.camel@mtkswgap22>
         <20201023092720.qpws5wivqb4u6fwl@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gRnJpLCAyMDIwLTEwLTIzIGF0IDE0OjU3ICswNTMwLCBWaXJlc2ggS3VtYXIgd3JvdGU6DQo+
IE9uIDIzLTEwLTIwLCAxNzowOCwgSGVjdG9yIFl1YW4gd3JvdGU6DQo+ID4gT24gRnJpLCAyMDIw
LTEwLTIzIGF0IDEzOjU4ICswNTMwLCBWaXJlc2ggS3VtYXIgd3JvdGU6DQo+ID4gPiBPbiAyMy0x
MC0yMCwgMTY6MjQsIEhlY3RvciBZdWFuIHdyb3RlOg0KPiA+ID4gPiBUaGlzIHBhdGNoc2V0IGlu
Y2x1ZGVzIDYgcGF0Y2hlcyBhbmQgZGVwZW5kcyBvbiB0aGUgTVQ2Nzc5IERUUyBwYXRjaFsxXSBz
dWJtaXR0ZWQgYnkgSGFua3MgQ2hlbi4NCj4gPiA+ID4gVGhlIGZpcnN0IDMgcGF0Y2hlcyBhcmUg
Zm9yIENQVUZSRVEgSFcgZHJpdmVyIGFuZCBkZXZpY2UgdHJlZSBiaW5kaW5nLCB3aGljaCBhcmUg
YWxyZWFkeSBzZW50IGJlZm9yZSBzZXBhcmF0ZWx5IFsyXVszXS4gRm9yIGJpbmRpbmcgcGFydCwg
SSBhZGQgYSBuZXcgcGF0Y2ggdG8gYWRkIHByb3BlcnR5IGluIGNwdSBzY2hlbWEuDQo+ID4gPiA+
IEJlc2lkZXMsIHdlIGFkZCB0aHJlZSBtb3JlIHBhdGNoZXMgaW5jbHVkaW5nIEVNIHBvd2VyIHRh
YmxlLCBTVlMgQ1BVIGluaXRpYWxpemUsIGFuZCBjb29saW5nIGRldmljZS4NCj4gPiA+IA0KPiA+
ID4gQW5kIGV2ZW4gYWZ0ZXIgc28gbWFueSB2ZXJzaW9ucyBvZiB0aGVzZSB5b3UgY2hvc2UgdG8g
bmFtZSB0aGlzIFYxLiBJdA0KPiA+ID4gaXMgdmVyeSBkaWZmaWN1bHQgZm9yIHJldmlld2VycyB0
byBmaW5kIHRpbWUgdG8gcmV2aWV3IHlvdXIgc3R1ZmYsIGFuZA0KPiA+ID4gdGhleSBleHBlY3Qg
c29tZSBzb3J0IG9mIHN1bW1hcnkgZnJvbSB5b3Ugb24gd2hhdCBleGFjdGx5IGNoYW5nZWQgZnJv
bQ0KPiA+ID4gbGFzdCB2ZXJzaW9uIGFuZCB5b3UgYWxzbyBuZWVkIHRvIG5hbWUgdGhlIGN1cnJl
bnQgdmVyc2lvbiBjdXJyZW50bHkuDQo+ID4gPiANCj4gPiA+IFRoaXMgc2hvdWxkIGhhdmUgYmVl
biBWOCBhbmQgeW91IHNob3VsZCBoYXZlIGFkZGVkIGEgIlY3LT5WOCBkaWZmOiINCj4gPiA+IHNl
Y3Rpb24gaGVyZSwgbmFtaW5nIGFsbCB0aGUgY2hhbmdlcyB5b3UgZGlkLiBQbGVhc2Ugc2VuZCB0
aGF0IGFzDQo+ID4gPiByZXBseSB0byB0aGlzIGVtYWlsLCBzbyBJIGNhbiBzZWUgd2hhdCByZWFs
bHkgY2hhbmdlZC4NCj4gPiA+IA0KPiA+IEhpLCBWaXJlc2gNCj4gPiANCj4gPiBTb3JyeSBmb3Ig
eW91ciBpbmNvbnZlbmllbmNlLg0KPiA+ICMxfiMzIGlzIGZvciBjcHVmcmVxIGRyaXZlciB3ZSBo
YXZlIHJldmlld2VkIGFuZCB0aGUgYmluZGluZ3Mgd2hpY2gNCj4gPiBzZXBhcmF0ZSBmcmVxIGRv
bWFpbiB0byBDUFUgc2NoZW1hLlRoZXJlIGlzIG5vIGNoYW5nZSBmb3IgdGhlIGRyaXZlcg0KPiA+
IGl0c2VsZi4NCj4gPiAgIDEuIGNwdWZyZXE6IG1lZGlhdGVrLWh3OiBBZGQgc3VwcG9ydCBmb3Ig
Q1BVRlJFUSBIVw0KPiA+ICAgMi4gZHQtYmluZGluZ3M6IGFybTogY3B1czogRG9jdW1lbnQgJ210
ayxmcmVxLWRvbWFpbicgcHJvcGVydHkNCj4gPiAgIDMuIGR0LWJpbmRpbmdzOiBjcHVmcmVxOiBh
ZGQgYmluZGluZ3MgZm9yIE1lZGlhVGVrIGNwdWZyZXEgSFcNCj4gPiANCj4gPiAjNH4jNiBpcyBm
b3Igb3RoZXIgQ1BVIGZlYXR1cmVzLCBpLmUuIFNWUyBbMV0NCj4gPiAgIDQuIGNwdWZyZXE6IG1l
ZGlhdGVrLWh3OiByZWdpc3RlciBFTSBwb3dlciB0YWJsZQ0KPiA+ICAgNS4gY3B1ZnJlcTogbWVk
aWF0ZWstaHc6IEFkZCBTVlMgQ1BVIGluaXRpYWxpemF0aW9uDQo+ID4gICA2LiBjcHVmcmVxOiBt
ZWRpYXRlay1odzogQWRkIGNvb2xpbmcgZGV2IGZsYWcNCj4gPiANCj4gPiBJIHN1cHBvc2VkIHRo
YXQgaXQgY291bGQgYmUgbW9yZSBjbGVhbiB0byBzZXBhcmF0ZSAjNH4jNiBpbiBhbm90aGVyDQo+
ID4gcGF0Y2hzZXQuTWF5IEkga25vdyBpcyBpdCBva2F5IHRvIHlvdT8gT3IgSSBzaG91bGQgbWVy
Z2UgYWxsIG9mIGNoYW5nZXMNCj4gPiBpbnRvIHY4IGxpa2UgeW91IG1lbnRpb25lZD8gVGhhbmsg
eW91Lg0KPiANCj4gTWVyZ2UgdGhlbSBhbGwgdG9nZXRoZXIgYW5kIGV4cGxhaW4gYW55IHNwZWNp
YWwgZmVhdHVyZXMgKGxpa2UgU1ZTKSBpbg0KPiB0aGUgY29tbWl0IGxvZy4gSXQgd2lsbCBhbHNv
IGhlbHAgaW4gZnV0dXJlIHdoZW4gcGVvcGxlIHdhbnQgdG8NCj4gdW5kZXJzdGFuZCB5b3VyIGRy
aXZlci4gRXhwbGFpbiB3aGF0ZXZlciBpcyB3b3J0aCBleHBsYWluaW5nIHRoZXJlIGFuZA0KPiBp
cyBub3Qgc3RyYWlnaHQgZm9yd2FyZC4NCj4gDQo+IFRoYW5rcyBmb3IgdGhlIGRldGFpbHMuDQo+
IA0KT0ssIEkgd2lsbCBtZXJnZSBhbGwgY2hhbmdlcyBpbiB2OC4gQW5kIGV4cGxhaW4gZGV0YWls
cyBpbiBjb3Zlci1sZXR0ZXIuDQpUaGFuayB5b3UuIA0KDQo=

