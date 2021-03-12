Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A9A338C17
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 12:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbhCLL6d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 06:58:33 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:35008 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229568AbhCLL6C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 06:58:02 -0500
X-UUID: 946932364f3f4f3a8a01a900e4541ec0-20210312
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=m18qKLN2eIVN7m92F2V4LCu7cdJzsE5sgxfQGieING0=;
        b=S9LUjU8PqjaK1ex3e0xZ3tZJLCyTgDv/g54TWXASg0Fqnt8nTYLCGhz1TnKzewR0JnIQTSZ36ROCh7ZGgXhBZEAC+g1NXIre+55kULuGh4pEXBS1fB5JIHTIhbqtgCpQZnrSwxWKdtVFgBTjwdEHby+drkUx/jwHX0Nrxu54dp8=;
X-UUID: 946932364f3f4f3a8a01a900e4541ec0-20210312
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 476015359; Fri, 12 Mar 2021 19:57:54 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 12 Mar 2021 19:57:52 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 12 Mar 2021 19:57:52 +0800
Message-ID: <1615550272.25310.2.camel@mtkswgap22>
Subject: Re: [PATCH v10] cpufreq: mediatek-hw: Add support for Mediatek
 cpufreq HW driver
From:   Hector Yuan <hector.yuan@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>
Date:   Fri, 12 Mar 2021 19:57:52 +0800
In-Reply-To: <49f4400f-c803-f044-4974-f4e8703876e7@gmail.com>
References: <1609222629-2979-1-git-send-email-hector.yuan@mediatek.com>
         <49f4400f-c803-f044-4974-f4e8703876e7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 40CEC1518245D1AF1D1701B429592852A3B6BD905C97EAC10220746F7E7A5FFB2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gU3VuLCAyMDIxLTAxLTMxIGF0IDExOjM0ICswMTAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KPiANCj4gT24gMjkvMTIvMjAyMCAwNzoxNywgSGVjdG9yIFl1YW4gd3JvdGU6DQo+ID4gVGhl
IENQVWZyZXEgSFcgcHJlc2VudCBpbiBzb21lIE1lZGlhdGVrIGNoaXBzZXRzIG9mZmxvYWRzIHRo
ZSBzdGVwcyBuZWNlc3NhcnkgZm9yIGNoYW5naW5nIHRoZSBmcmVxdWVuY3kgb2YgQ1BVcy4gDQo+
ID4gVGhlIGRyaXZlciBpbXBsZW1lbnRzIHRoZSBjcHVmcmVxIGRyaXZlciBpbnRlcmZhY2UgZm9y
IHRoaXMgaGFyZHdhcmUgZW5naW5lLiANCj4gPiBUaGlzIHBhdGNoIGRlcGVuZHMgb24gTVQ2Nzc5
IERUUyBwYXRjaHNldFsxXSBzdWJtaXR0ZWQgYnkgSGFua3MgQ2hlbi4NCj4gDQo+IFRoaXMgZGVw
ZW5kZW5jeSBnb3QgcmVzb2x2ZWQsIHRoZSBwYXRjaCBpcyBtYWlubGluZSBzaW5jZSB2NS4xMS4g
UGxlYXNlIGRlbGV0ZQ0KPiBpdCBpbiBmdXJ0aGVyIHJldmlzaW9ucyBvZiB0aGUgcGF0Y2ggc2V0
IHRvIG1pbmltaXplIGNvbmZ1c2lvbi4NCj4gDQo+IFRoYW5rcyENCj4gDQpUaGFua3MsIEkgd2ls
bCByZW1vdmUgdGhpcyBkZXBlbmRlbmN5IGluIHRoZSBuZXh0IHZlcnNpb24uIA0KPiA+IA0KPiA+
IEZyb20gdjggdG8gdjksIHRoZXJlIGFyZSB0aHJlZSBtb3JlIG1vZGlmaWNhdGlvbnMuDQo+ID4g
MS4gQmFzZWQgb24gcGF0Y2hzZXRbMl0sIGFsaWduIGJpbmRpbmcgd2l0aCBzY21pIGZvciBwZXJm
b3JtYW5jZSBkb21haW4uDQo+ID4gMi4gQWRkIHRoZSBDUFVGUkVRIGZhc3Qgc3dpdGNoIGZ1bmN0
aW9uIHN1cHBvcnQgYW5kIGRlZmluZSBEVkZTIGxhdGVuY3kuDQo+ID4gMy4gQmFzZWQgb24gcGF0
Y2hzZXJbM10sIGFkZCBlbmVyZ3kgbW9kZWwgQVBJIHBhcmFtZXRlciBmb3IgbVcuDQo+ID4gDQo+
ID4gRnJvbSB2NyB0byB2OCwgdGhlcmUgYXJlIHRocmVlIG1vcmUgcGF0Y2hlcyBiYXNlZCBvbiBw
YXRjaHNldCB2OFs0XS4NCj4gPiBUaGlzIHBhdGNoc2V0IGlzIGFib3V0IHRvIHJlZ2lzdGVyIHBv
d2VyIHRhYmxlIHRvIEVuZXJneSBtb2RlbCBmb3IgRUFTIGFuZCB0aGVybWFsIHVzYWdlLg0KPiA+
IDEuIEVNIENQVSBwb3dlciB0YWJsZQ0KPiA+IC0gUmVnaXN0ZXIgZW5lcmd5IG1vZGVsIHRhYmxl
IGZvciBFQVMgYW5kIHRoZXJtYWwgY29vbGluZyBkZXZpY2UgdXNhZ2UuDQo+ID4gLSBSZWFkIHRo
ZSBjb3Jlc3BvbmRpbmcgTFVUIGZvciBwb3dlciB0YWJsZS4NCj4gPiAyLiBTVlMgaW5pdGlhbGl6
YXRpb24NCj4gPiAtIFRoZSBTVlMoU21hcnQgVm9sdGFnZSBTY2FsaW5nKSBlbmdpbmUgaXMgYSBo
YXJkd2FyZSB3aGljaCBpcw0KPiA+ICAgdXNlZCB0byBjYWxjdWxhdGUgb3B0aW1pemVkIHZvbHRh
Z2UgdmFsdWVzIGZvciBDUFUgcG93ZXIgZG9tYWluLg0KPiA+ICAgRFZGUyBkcml2ZXIgY291bGQg
YXBwbHkgdGhvc2Ugb3B0aW1pemVkIHZvbHRhZ2UgdmFsdWVzIHRvIHJlZHVjZSBwb3dlciBjb25z
dW1wdGlvbi4NCj4gPiAtIERyaXZlciB3aWxsIHBvbGxpbmcgaWYgSFcgZW5naW5lIGlzIGRvbmUg
Zm9yIFNWUyBpbml0aWFsaXphdGlvbi4NCj4gPiAgIEFmdGVyIHRoYXQsIGRyaXZlciB3aWxsIHJl
YWQgcG93ZXIgdGFibGUgYW5kIHJlZ2lzdGVyIGl0IHRvIEVBUy4NCj4gPiAtIENQVXMgbXVzdCBi
ZSBpbiBwb3dlciBvbiBzdGF0ZSB3aGVuIGRvaW5nIFNWUy4gVXNlIHBtX3FvcyB0byBibG9jayBj
cHUtaWRsZSBzdGF0ZSBmb3IgU1ZTIGluaXRpYWxpemluZy4NCj4gPiAzLiBDb29saW5nIGRldmlj
ZSBmbGFnDQo+ID4gLSBBZGQgY29vbGluZyBkZXZpY2UgZmxhZyBmb3IgdGhlcm1hbA0KPiA+IA0K
PiA+IFsxXSAgaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMjAvOC80LzEwOTQNCj4gPiBbMl0gIGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMDExMTYxODEzNTYuODA0NTkwLTEtc3VkZWVw
LmhvbGxhQGFybS5jb20vDQo+ID4gWzNdICBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20v
bGludXgva2VybmVsL2dpdC9yYWZhZWwvbGludXgtcG0uZ2l0L2NvbW1pdC8/aD1saW51eC1uZXh0
JmlkPWMyNTBkNTBmZTJjZTYyN2NhOTgwNWQ5YzhhYzExY2JiZjkyMmE0YTYNCj4gPiBbNF0gIGh0
dHBzOi8vbGttbC5vcmcvbGttbC8yMDIwLzkvMjMvMzg0DQo+ID4gDQo+ID4gDQo+ID4gSGVjdG9y
Lll1YW4gKDIpOg0KPiA+ICAgY3B1ZnJlcTogbWVkaWF0ZWstaHc6IEFkZCBzdXBwb3J0IGZvciBD
UFVGUkVRIEhXDQo+ID4gICBkdC1iaW5kaW5nczogY3B1ZnJlcTogYWRkIGJpbmRpbmdzIGZvciBN
ZWRpYVRlayBjcHVmcmVxIEhXDQo+ID4gDQo+ID4gIC4uLi9iaW5kaW5ncy9jcHVmcmVxL2NwdWZy
ZXEtbWVkaWF0ZWstaHcueWFtbCAgICAgIHwgIDExNiArKysrKysNCj4gPiAgZHJpdmVycy9jcHVm
cmVxL0tjb25maWcuYXJtICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEyICsNCj4gPiAgZHJp
dmVycy9jcHVmcmVxL01ha2VmaWxlICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAxICsN
Cj4gPiAgZHJpdmVycy9jcHVmcmVxL21lZGlhdGVrLWNwdWZyZXEtaHcuYyAgICAgICAgICAgICAg
fCAgMzcwICsrKysrKysrKysrKysrKysrKysrDQo+ID4gIDQgZmlsZXMgY2hhbmdlZCwgNDk5IGlu
c2VydGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9jcHVmcmVxL2NwdWZyZXEtbWVkaWF0ZWstaHcueWFtbA0KPiA+ICBjcmVh
dGUgbW9kZSAxMDA2NDQgZHJpdmVycy9jcHVmcmVxL21lZGlhdGVrLWNwdWZyZXEtaHcuYw0KPiA+
IA0KDQo=

