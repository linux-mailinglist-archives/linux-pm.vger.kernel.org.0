Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E59F2EBCB4
	for <lists+linux-pm@lfdr.de>; Wed,  6 Jan 2021 11:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbhAFKuu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Jan 2021 05:50:50 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:58807 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726216AbhAFKut (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Jan 2021 05:50:49 -0500
X-UUID: 21d37c71cc3e4f47b6e60409881c5a7c-20210106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=L5jbNfbduFFY4GVpBpR4LES09K8qYrQx0j95YJ91PUo=;
        b=copkDjGzYWeZFdAS77qHxEf0/hkpKk6Dcf/seFmBsbCOc8ywqlJXRbeLe8cZF8hxnfu4ek61X4a6PWoSlrmvm4vAirUiv8VTNxA0TK7gOJKb2uxs//6zJgIhTkAWZmoQ11w6l47aKnf5b0wt5959R2pp+nh5ZU2HXdL7aX4MEaw=;
X-UUID: 21d37c71cc3e4f47b6e60409881c5a7c-20210106
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <henryc.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 739599793; Wed, 06 Jan 2021 18:44:54 +0800
Received: from MTKMBS02N1.mediatek.inc (172.21.101.77) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 6 Jan 2021 18:44:52 +0800
Received: from MTKMBS02N1.mediatek.inc ([fe80::387d:548a:5384:acb9]) by
 mtkmbs02n1.mediatek.inc ([fe80::387d:548a:5384:acb9%13]) with mapi id
 15.00.1497.000; Wed, 6 Jan 2021 18:44:52 +0800
From:   =?utf-8?B?SGVucnlDIENoZW4gKOmZs+W7uuixqik=?= 
        <HenryC.Chen@mediatek.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@google.com>,
        =?utf-8?B?RmFuIENoZW4gKOmZs+WHoSk=?= <fan.chen@mediatek.com>,
        =?utf-8?B?SmFtZXNKSiBMaWFvICjlu5blu7rmmbop?= 
        <jamesjj.liao@mediatek.com>,
        =?utf-8?B?QXJ2aW4gV2FuZyAo546L5b+X6YqYKQ==?= 
        <Arvin.Wang@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH V6 08/13] interconnect: mediatek: Add interconnect
 provider driver
Thread-Topic: [PATCH V6 08/13] interconnect: mediatek: Add interconnect
 provider driver
Thread-Index: AQHW2btE1mStvoHjDEWYdYBoJOjN6aoXV1cAgAJqtwCAAAxEAIAAr6Ng
Date:   Wed, 6 Jan 2021 10:44:52 +0000
Message-ID: <c9b360dcb17e452595f45adb51dd4c31@mtkmbs02n1.mediatek.inc>
References: <1608790134-27425-1-git-send-email-henryc.chen@mediatek.com>
 <1608790134-27425-9-git-send-email-henryc.chen@mediatek.com>
 <c8b951b0-6412-d905-99e1-6350283b57c1@linaro.org>
 <1609918232.23066.5.camel@mtksdaap41>
 <a416a55c-0a7e-6505-ef53-b03f5dbc6cdc@linaro.org>
In-Reply-To: <a416a55c-0a7e-6505-ef53-b03f5dbc6cdc@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.21.101.239]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBHZW9yZ2kgRGpha292IFttYWls
dG86Z2VvcmdpLmRqYWtvdkBsaW5hcm8ub3JnXQ0KPiBTZW50OiBXZWRuZXNkYXksIEphbnVhcnkg
MDYsIDIwMjEgNDoxNCBQTQ0KPiBUbzogSGVucnlDIENoZW4gKOmZs+W7uuixqikNCj4gQ2M6IFJv
YiBIZXJyaW5nOyBNYXR0aGlhcyBCcnVnZ2VyOyBTdGVwaGVuIEJveWQ7IFJ5YW4gQ2FzZTsgTWFy
ayBCcm93bjsgTWFyaw0KPiBSdXRsYW5kOyBOaWNvbGFzIEJvaWNoYXQ7IEZhbiBDaGVuICjpmbPl
h6EpOyBKYW1lc0pKIExpYW8gKOW7luW7uuaZuik7IEFydmluIFdhbmcNCj4gKOeOi+W/l+mKmCk7
IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmc7DQo+IGxpbnV4LW1lZGlhdGVrQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBwbUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCBWNiAwOC8xM10gaW50ZXJjb25uZWN0OiBtZWRpYXRlazogQWRkIGlu
dGVyY29ubmVjdA0KPiBwcm92aWRlciBkcml2ZXINCj4gDQo+IE9uIDEvNi8yMSAwOTozMCwgSGVu
cnkgQ2hlbiB3cm90ZToNCj4gPiBPbiBNb24sIDIwMjEtMDEtMDQgYXQgMjA6MzYgKzAyMDAsIEdl
b3JnaSBEamFrb3Ygd3JvdGU6DQo+ID4+IE9uIDEyLzI0LzIwIDA4OjA4LCBIZW5yeSBDaGVuIHdy
b3RlOg0KPiA+Pj4gSW50cm9kdWNlIE1lZGlhdGVrIE1UNjg3My9NVDgxODMvTVQ4MTkyIHNwZWNp
ZmljIHByb3ZpZGVyIGRyaXZlcg0KPiA+Pj4gdXNpbmcgdGhlIGludGVyY29ubmVjdCBmcmFtZXdv
cmsuDQo+ID4+Pg0KPiA+Pj4gICAgICAgICAgICAgICAgSUNDIHByb3ZpZGVyICAgICAgICAgSUND
IE5vZGVzDQo+ID4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0tLS0gICAgICAg
ICAgLS0tLQ0KPiA+Pj4gICAgICAgICAgICAgICAgLS0tLS0tLS0tICAgICAgIHxDUFUgfCAgIHwt
LS0gfFZQVSB8DQo+ID4+PiAgICAgICAtLS0tLSAgIHwgICAgICAgICB8LS0tLS0gIC0tLS0gICAg
fCAgICAgLS0tLQ0KPiA+Pj4gICAgICB8RFJBTSB8LS18RFJBTSAgICAgfCAgICAgICAtLS0tICAg
IHwgICAgIC0tLS0NCj4gPj4+ICAgICAgfCAgICAgfC0tfHNjaGVkdWxlcnwtLS0tLSB8R1BVIHwg
ICB8LS0tIHxESVNQfA0KPiA+Pj4gICAgICB8ICAgICB8LS18KEVNSSkgICAgfCAgICAgICAtLS0t
ICAgIHwgICAgIC0tLS0NCj4gPj4+ICAgICAgfCAgICAgfC0tfCAgICAgICAgIHwgICAgICAgLS0t
LS0gICB8ICAgICAtLS0tDQo+ID4+PiAgICAgICAtLS0tLSAgIHwgICAgICAgICB8LS0tLS0gfE1N
U1lTfC0tfC0tLSB8VkRFQ3wNCj4gPj4+ICAgICAgICAgICAgICAgIC0tLS0tLS0tLSAgICAgICAg
LS0tLS0gICB8ICAgICAtLS0tDQo+ID4+PiAgICAgICAgICAgICAgICAgIC98XCAgICAgICAgICAg
ICAgICAgICAgfCAgICAgLS0tLQ0KPiA+Pj4gICAgICAgICAgICAgICAgICAgfGNoYW5nZSBEUkFN
IGZyZXEgICAgIHwtLS0gfFZFTkN8DQo+ID4+PiAgICAgICAgICAgICAgICAtLS0tLS0tLS0tICAg
ICAgICAgICAgICAgfCAgICAgLS0tLQ0KPiA+Pj4gICAgICAgICAgICAgICB8ICBEVkZTUiAgIHwg
ICAgICAgICAgICAgIHwNCj4gPj4+ICAgICAgICAgICAgICAgfCAgICAgICAgICB8ICAgICAgICAg
ICAgICB8ICAgICAtLS0tDQo+ID4+PiAgICAgICAgICAgICAgICAtLS0tLS0tLS0tICAgICAgICAg
ICAgICAgfC0tLSB8SU1HIHwNCj4gPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAgICAtLS0tDQo+ID4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCAgICAgLS0tLQ0KPiA+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHwtLS0gfENBTSB8DQo+ID4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgLS0tLQ0KPiA+Pj4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IEhlbnJ5
IENoZW4gPGhlbnJ5Yy5jaGVuQG1lZGlhdGVrLmNvbT4NCj4gPj4+IC0tLQ0KPiA+Pj4gICAgZHJp
dmVycy9pbnRlcmNvbm5lY3QvS2NvbmZpZyAgICAgICAgICAgIHwgICAxICsNCj4gPj4+ICAgIGRy
aXZlcnMvaW50ZXJjb25uZWN0L01ha2VmaWxlICAgICAgICAgICB8ICAgMSArDQo+ID4+PiAgICBk
cml2ZXJzL2ludGVyY29ubmVjdC9tZWRpYXRlay9LY29uZmlnICAgfCAgMTMgKysNCj4gPj4+ICAg
IGRyaXZlcnMvaW50ZXJjb25uZWN0L21lZGlhdGVrL01ha2VmaWxlICB8ICAgMyArDQo+ID4+PiAg
ICBkcml2ZXJzL2ludGVyY29ubmVjdC9tZWRpYXRlay9tdGstZW1pLmMgfCAzMzANCj4gKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPj4+ICAgIDUgZmlsZXMgY2hhbmdlZCwgMzQ4
IGluc2VydGlvbnMoKykNCj4gPj4+ICAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2ludGVy
Y29ubmVjdC9tZWRpYXRlay9LY29uZmlnDQo+ID4+PiAgICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJp
dmVycy9pbnRlcmNvbm5lY3QvbWVkaWF0ZWsvTWFrZWZpbGUNCj4gPj4+ICAgIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBkcml2ZXJzL2ludGVyY29ubmVjdC9tZWRpYXRlay9tdGstZW1pLmMNCj4gPj4+DQo+
ID4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbnRlcmNvbm5lY3QvS2NvbmZpZw0KPiA+Pj4gYi9k
cml2ZXJzL2ludGVyY29ubmVjdC9LY29uZmlnIGluZGV4IDViNzIwNGUuLmU5MzlmNWEgMTAwNjQ0
DQo+ID4+PiAtLS0gYS9kcml2ZXJzL2ludGVyY29ubmVjdC9LY29uZmlnDQo+ID4+PiArKysgYi9k
cml2ZXJzL2ludGVyY29ubmVjdC9LY29uZmlnDQo+ID4+PiBAQCAtMTMsNSArMTMsNiBAQCBpZiBJ
TlRFUkNPTk5FQ1QNCj4gPj4+DQo+ID4+PiAgICBzb3VyY2UgImRyaXZlcnMvaW50ZXJjb25uZWN0
L2lteC9LY29uZmlnIg0KPiA+Pj4gICAgc291cmNlICJkcml2ZXJzL2ludGVyY29ubmVjdC9xY29t
L0tjb25maWciDQo+ID4+PiArc291cmNlICJkcml2ZXJzL2ludGVyY29ubmVjdC9tZWRpYXRlay9L
Y29uZmlnIg0KPiA+Pg0KPiA+PiBTb3J0IGFscGhhYmV0aWNhbGx5IHBsZWFzZS4NCj4gPiBPaw0K
PiA+Pg0KPiA+Pj4NCj4gPj4+ICAgIGVuZGlmDQo+ID4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9p
bnRlcmNvbm5lY3QvTWFrZWZpbGUNCj4gPj4+IGIvZHJpdmVycy9pbnRlcmNvbm5lY3QvTWFrZWZp
bGUgaW5kZXggZDIwMzUyMC4uMDY0M2EyNCAxMDA2NDQNCj4gPj4+IC0tLSBhL2RyaXZlcnMvaW50
ZXJjb25uZWN0L01ha2VmaWxlDQo+ID4+PiArKysgYi9kcml2ZXJzL2ludGVyY29ubmVjdC9NYWtl
ZmlsZQ0KPiA+Pj4gQEAgLTYsMyArNiw0IEBAIGljYy1jb3JlLW9ianMJCQkJOj0gY29yZS5vIGJ1
bGsubw0KPiA+Pj4gICAgb2JqLSQoQ09ORklHX0lOVEVSQ09OTkVDVCkJCSs9IGljYy1jb3JlLm8N
Cj4gPj4+ICAgIG9iai0kKENPTkZJR19JTlRFUkNPTk5FQ1RfSU1YKQkJKz0gaW14Lw0KPiA+Pj4g
ICAgb2JqLSQoQ09ORklHX0lOVEVSQ09OTkVDVF9RQ09NKQkJKz0gcWNvbS8NCj4gPj4+ICtvYmot
JChDT05GSUdfSU5URVJDT05ORUNUX01USykJCSs9IG1lZGlhdGVrLw0KPiA+Pg0KPiA+PiBEaXR0
by4NCj4gPiBPaw0KPiA+Pg0KPiA+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW50ZXJjb25uZWN0
L21lZGlhdGVrL0tjb25maWcNCj4gPj4+IGIvZHJpdmVycy9pbnRlcmNvbm5lY3QvbWVkaWF0ZWsv
S2NvbmZpZw0KPiA+Pj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPj4+IGluZGV4IDAwMDAwMDAu
Ljk3MmQzYmINCj4gPj4+IC0tLSAvZGV2L251bGwNCj4gPj4+ICsrKyBiL2RyaXZlcnMvaW50ZXJj
b25uZWN0L21lZGlhdGVrL0tjb25maWcNCj4gPj4+IEBAIC0wLDAgKzEsMTMgQEANCj4gPj4+ICtj
b25maWcgSU5URVJDT05ORUNUX01USw0KPiA+Pj4gKwlib29sICJNZWRpYXRlayBOZXR3b3JrLW9u
LUNoaXAgaW50ZXJjb25uZWN0IGRyaXZlcnMiDQo+ID4+PiArCWRlcGVuZHMgb24gQVJDSF9NRURJ
QVRFSw0KPiA+Pj4gKwloZWxwDQo+ID4+PiArCSAgU3VwcG9ydCBmb3IgTWVkaWF0ZWsncyBOZXR3
b3JrLW9uLUNoaXAgaW50ZXJjb25uZWN0IGhhcmR3YXJlLg0KPiA+Pj4gKw0KPiA+Pj4gK2NvbmZp
ZyBJTlRFUkNPTk5FQ1RfTVRLX0VNSQ0KPiA+Pj4gKwl0cmlzdGF0ZSAiTWVkaWF0ZWsgRU1JIGlu
dGVyY29ubmVjdCBkcml2ZXIiDQo+ID4+PiArCWRlcGVuZHMgb24gSU5URVJDT05ORUNUX01USw0K
PiA+Pj4gKwlkZXBlbmRzIG9uIChNVEtfRFZGU1JDICYmIE9GKQ0KPiA+Pg0KPiA+PiBXb3VsZCBp
dCBiZSBwb3NzaWJsZSB0byBlbmFibGUgQ09NUElMRV9URVNUPw0KPiA+IERvIHlvdSBtZWFucyBj
aGFuZ2UgdG8gImRlcGVuZHMgb24gKE1US19EVkZTUkMgJiYgT0YpIHx8IENPTVBJTEVfVEVTVCIg
Pw0KPiANCj4gWWVhaCwgdGhlcmUgaXMgYSBzdHViIGZvciBtdGtfZHZmc3JjX3NlbmRfcmVxdWVz
dCgpLiBNYXliZSB3ZSBjb3VsZCBldmVuDQo+IGNoYW5nZSBpdCBmb3IgSU5URVJDT05ORUNUX01U
SyB0byBzb21ldGhpbmcgbGlrZToNCj4gCWRlcGVuZHMgb24gQVJDSF9NRURJQVRFSyB8fCBDT01Q
SUxFX1RFU1QgV2lsbCB0aGlzIHdvcms/DQpIaSBHZW9yZ2ksDQoNClNvLi5vbmx5IGNoYW5nZSB0
byBhcyBmb2xsb3dpbmc/IA0KDQpjb25maWcgSU5URVJDT05ORUNUX01USw0KCWJvb2wgIk1lZGlh
dGVrIE5ldHdvcmstb24tQ2hpcCBpbnRlcmNvbm5lY3QgZHJpdmVycyINCglkZXBlbmRzIG9uIEFS
Q0hfTUVESUFURUsgfHwgQ09NUElMRV9URVNUDQoJaGVscA0KCSAgU3VwcG9ydCBmb3IgTWVkaWF0
ZWsncyBOZXR3b3JrLW9uLUNoaXAgaW50ZXJjb25uZWN0IGhhcmR3YXJlLg0KDQo+IA0KPiBUaGFu
a3MsDQo+IEdlb3JnaQ0K
