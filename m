Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04E9419BA78
	for <lists+linux-pm@lfdr.de>; Thu,  2 Apr 2020 04:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbgDBCsT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Apr 2020 22:48:19 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:50438 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1733269AbgDBCsR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Apr 2020 22:48:17 -0400
X-UUID: cdb839e7a0d847b8bb10df858863fb3e-20200402
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=P6AXl14409aeLCBpPKkU44gdGTRy5JIxj8i/NJ61DK8=;
        b=R+WAuqV4NaHAeSkH/LdPNNeyxXO4mFtZdsgFWw+33GfWqKr6oGHK1BXgS0T7ZiQ2sE4vVc7ECyNKzLk4BRq+pB48Ns89S9Biphhbhlqf/sM7+gEUdqaO9f4bVhxF23YnL95JMZWXh1tLDcqCK0chwT1VGWyVxzPfWyiNdYxDsyQ=;
X-UUID: cdb839e7a0d847b8bb10df858863fb3e-20200402
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <henryc.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 393331207; Thu, 02 Apr 2020 10:48:13 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 2 Apr 2020 10:48:11 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 2 Apr 2020 10:48:10 +0800
Message-ID: <1585795691.27527.14.camel@mtksdaap41>
Subject: Re: [PATCH V4 06/13] soc: mediatek: add MT8183 dvfsrc support
From:   Henry Chen <henryc.chen@mediatek.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@google.com>,
        Fan Chen <fan.chen@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Arvin Wang <arvin.wang@mediatek.com>,
        "Mike Turquette" <mturquette@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <srv_heupstream@mediatek.com>
Date:   Thu, 2 Apr 2020 10:48:11 +0800
In-Reply-To: <4220e681-80b6-f9af-ddd1-b28aabe513cf@linaro.org>
References: <1584092066-24425-1-git-send-email-henryc.chen@mediatek.com>
         <1584092066-24425-7-git-send-email-henryc.chen@mediatek.com>
         <4220e681-80b6-f9af-ddd1-b28aabe513cf@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgR2VvcmdpLA0KDQpPbiBXZWQsIDIwMjAtMDQtMDEgYXQgMTc6NDEgKzAzMDAsIEdlb3JnaSBE
amFrb3Ygd3JvdGU6DQo+IEhpIEhlbnJ5LA0KPiANCj4gT24gMy8xMy8yMCAxMTozNCwgSGVucnkg
Q2hlbiB3cm90ZToNCj4gPiBBZGQgZHZmc3JjIGRyaXZlciBmb3IgTVQ4MTgzDQo+ID4gDQo+ID4g
U2lnbmVkLW9mZi1ieTogSGVucnkgQ2hlbiA8aGVucnljLmNoZW5AbWVkaWF0ZWsuY29tPg0KPiA+
IC0tLQ0KPiA+ICBkcml2ZXJzL3NvYy9tZWRpYXRlay9LY29uZmlnICAgICAgfCAgMTUgKysNCj4g
PiAgZHJpdmVycy9zb2MvbWVkaWF0ZWsvTWFrZWZpbGUgICAgIHwgICAxICsNCj4gPiAgZHJpdmVy
cy9zb2MvbWVkaWF0ZWsvbXRrLWR2ZnNyYy5jIHwgNDM0ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrDQo+ID4gIGluY2x1ZGUvc29jL21lZGlhdGVrL210a19kdmZzcmMuaCB8
ICAzMCArKysNCj4gPiAgNCBmaWxlcyBjaGFuZ2VkLCA0ODAgaW5zZXJ0aW9ucygrKQ0KPiA+ICBj
cmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWR2ZnNyYy5jDQo+ID4g
IGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL3NvYy9tZWRpYXRlay9tdGtfZHZmc3JjLmgNCj4g
PiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvS2NvbmZpZyBiL2RyaXZl
cnMvc29jL21lZGlhdGVrL0tjb25maWcNCj4gPiBpbmRleCBmODM3YjNjLi40NDgwOGY0IDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvc29jL21lZGlhdGVrL0tjb25maWcNCj4gPiArKysgYi9kcml2
ZXJzL3NvYy9tZWRpYXRlay9LY29uZmlnDQo+ID4gQEAgLTE2LDYgKzE2LDIxIEBAIGNvbmZpZyBN
VEtfQ01EUQ0KPiA+ICAJICB0aW1lIGxpbWl0YXRpb24sIHN1Y2ggYXMgdXBkYXRpbmcgZGlzcGxh
eSBjb25maWd1cmF0aW9uIGR1cmluZyB0aGUNCj4gPiAgCSAgdmJsYW5rLg0KPiA+ICANCj4gPiAr
Y29uZmlnIE1US19EVkZTUkMNCj4gPiArCWJvb2wgIk1lZGlhVGVrIERWRlNSQyBTdXBwb3J0Ig0K
PiA+ICsJZGVwZW5kcyBvbiBBUkNIX01FRElBVEVLDQo+ID4gKwlkZWZhdWx0IEFSQ0hfTUVESUFU
RUsNCj4gPiArCXNlbGVjdCBNVEtfSU5GUkFDRkcNCj4gPiArCXNlbGVjdCBQTV9HRU5FUklDX0RP
TUFJTlMgaWYgUE0NCj4gPiArCWRlcGVuZHMgb24gTVRLX1NDUFNZUw0KPiA+ICsJaGVscA0KPiA+
ICsJICBTYXkgeWVzIGhlcmUgdG8gYWRkIHN1cHBvcnQgZm9yIHRoZSBNZWRpYVRlayBEVkZTUkMg
KGR5bmFtaWMgdm9sdGFnZQ0KPiA+ICsJICBhbmQgZnJlcXVlbmN5IHNjYWxpbmcgcmVzb3VyY2Ug
Y29sbGVjdG9yKSBmb3VuZA0KPiA+ICsJICBvbiBkaWZmZXJlbnQgTWVkaWFUZWsgU29Dcy4gVGhl
IERWRlNSQyBpcyBhIHByb3ByaWV0YXJ5DQo+ID4gKwkgIGhhcmR3YXJlIHdoaWNoIGlzIHVzZWQg
dG8gY29sbGVjdCBhbGwgdGhlIHJlcXVlc3RzIGZyb20NCj4gPiArCSAgc3lzdGVtIGFuZCB0dXJu
IGludG8gdGhlIGRlY2lzaW9uIG9mIG1pbmltdW0gVmNvcmUgdm9sdGFnZQ0KPiA+ICsJICBhbmQg
bWluaW11bSBEUkFNIGZyZXF1ZW5jeSB0byBmdWxmaWxsIHRob3NlIHJlcXVlc3RzLg0KPiA+ICsN
Cj4gPiAgY29uZmlnIE1US19QTUlDX1dSQVANCj4gPiAgCXRyaXN0YXRlICJNZWRpYVRlayBQTUlD
IFdyYXBwZXIgU3VwcG9ydCINCj4gPiAgCWRlcGVuZHMgb24gUkVTRVRfQ09OVFJPTExFUg0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9NYWtlZmlsZSBiL2RyaXZlcnMvc29j
L21lZGlhdGVrL01ha2VmaWxlDQo+ID4gaW5kZXggMmIyYzI1MzcuLjg0MTgyZjAgMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvTWFrZWZpbGUNCj4gPiArKysgYi9kcml2ZXJz
L3NvYy9tZWRpYXRlay9NYWtlZmlsZQ0KPiA+IEBAIC0xLDQgKzEsNSBAQA0KPiA+ICAjIFNQRFgt
TGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkNCj4gPiAgb2JqLSQoQ09ORklHX01US19D
TURRKSArPSBtdGstY21kcS1oZWxwZXIubw0KPiA+ICtvYmotJChDT05GSUdfTVRLX0RWRlNSQykg
Kz0gbXRrLWR2ZnNyYy5vDQo+ID4gIG9iai0kKENPTkZJR19NVEtfUE1JQ19XUkFQKSArPSBtdGst
cG1pYy13cmFwLm8NCj4gPiAgb2JqLSQoQ09ORklHX01US19TQ1BTWVMpICs9IG10ay1zY3BzeXMu
bw0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstZHZmc3JjLmMgYi9k
cml2ZXJzL3NvYy9tZWRpYXRlay9tdGstZHZmc3JjLmMNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0
NA0KPiA+IGluZGV4IDAwMDAwMDAuLjg1YjM1NzINCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysr
IGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWR2ZnNyYy5jDQo+ID4gQEAgLTAsMCArMSw0MzQg
QEANCj4gPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4gPiArLyoNCj4g
PiArICogQ29weXJpZ2h0IChDKSAyMDE4IE1lZGlhVGVrIEluYy4NCj4gPiArICovDQo+ID4gKyNp
bmNsdWRlIDxsaW51eC9hcm0tc21jY2MuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L2Nsay5oPg0K
PiA+ICsjaW5jbHVkZSA8bGludXgvaW8uaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L2lvcG9sbC5o
Pg0KPiA+ICsjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9u
b3RpZmllci5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvb2ZfZGV2aWNlLmg+DQo+ID4gKyNpbmNs
dWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCj4gPiArI2luY2x1ZGUgPHNvYy9tZWRpYXRl
ay9tdGtfZHZmc3JjLmg+DQo+ID4gKyNpbmNsdWRlIDxzb2MvbWVkaWF0ZWsvbXRrX3NpcC5oPg0K
PiA+ICsjaW5jbHVkZSA8ZHQtYmluZGluZ3MvcG93ZXIvbXQ4MTgzLXBvd2VyLmg+DQo+IA0KPiBM
b29rcyBsaWtlIHRoaXMgZGVwZW5kcyBvbiBhIGhlYWRlciB3aGljaCBpcyBub3QgcGFydCBvZiB0
aGlzIHBhdGNoLXNldC4NCj4gSXQgd291bGQgYmUgbmljZSB0byBsaXN0IGFueSBkZXBlbmRlbmNp
ZXMgaW4gdGhlIGNvdmVyIGxldHRlci4NCj4gDQo+IFRoYW5rcywNCj4gR2VvcmdpDQoNCkkgZGlz
cmVnYXJkZWQgdG8gbGlzdCBoZXJlLiBUaGFua3MgZm9yIHlvdXIgZnJpZW5kbHkgcmVtaW5kZXIu
DQo=

