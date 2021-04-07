Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E663567B0
	for <lists+linux-pm@lfdr.de>; Wed,  7 Apr 2021 11:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbhDGJIi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Apr 2021 05:08:38 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:55771 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229869AbhDGJIi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Apr 2021 05:08:38 -0400
X-UUID: 73e9fbacbc64406c906f671f3952a853-20210407
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=CehQ1sk8BCXcCJ53lKdFrH9flH/8762tp79jx+0lkaY=;
        b=gINJdjiqfJyOpTfSQQv3xH9U3vOcja7ZcHQEodyDvhtDHbdXdfRjdzDO2JgwMQgGkGJpU7y5LL8CKJGfXHWjTC1+44HBzdgOjVXBXUL4AvQ8HQ9lfht7KlI7PQd86u6T91xgmfIB3YmRJjVnlF+CsiJ5PXIXtpE8+lCBxyuaQwc=;
X-UUID: 73e9fbacbc64406c906f671f3952a853-20210407
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <michael.kao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1483465017; Wed, 07 Apr 2021 17:08:26 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 7 Apr 2021 17:08:25 +0800
Received: from [172.21.84.99] (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 7 Apr 2021 17:08:25 +0800
Message-ID: <1617786505.12846.1.camel@mtksdccf07>
Subject: Re: [v3,1/3] thermal: mediatek: Relocate driver to mediatek folder
From:   Michael Kao <michael.kao@mediatek.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <hsinyi@chromium.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Wed, 7 Apr 2021 17:08:25 +0800
In-Reply-To: <20210312034018.17437-2-michael.kao@mediatek.com>
References: <20210312034018.17437-1-michael.kao@mediatek.com>
         <20210312034018.17437-2-michael.kao@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgTWFpbnRhaW5lcnMsDQogDQpHZW50bGUgcGluIGZvciB0aGlzIHBhdGNoLg0KIA0KVGhhbmtz
DQoNCg0KT24gRnJpLCAyMDIxLTAzLTEyIGF0IDExOjQwICswODAwLCBNaWNoYWVsIEthbyB3cm90
ZToNCj4gQWRkIE1lZGlhdGVrIHByb3ByaWV0YXJ5IGZvbGRlciB0byB1cHN0cmVhbSBtb3JlIHRo
ZXJtYWwgem9uZSBhbmQgY29vbGVyDQo+IGRyaXZlcnMuIFJlbG9jYXRlIHRoZSBvcmlnaW5hbCB0
aGVybWFsIGNvbnRyb2xsZXIgZHJpdmVyIHRvIGl0IGFuZCByZW5hbWUNCj4gYXMgc29jX3RlbXAu
YyB0byBzaG93IGl0cyBwdXJwb3NlIG1vcmUgY2xlYXJseS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IE1pY2hhZWwgS2FvIDxtaWNoYWVsLmthb0BtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiAgZHJpdmVy
cy90aGVybWFsL0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgIHwgMTQgKysrKy0tLS0tLS0N
Cj4gIGRyaXZlcnMvdGhlcm1hbC9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgICB8ICAyICst
DQo+ICBkcml2ZXJzL3RoZXJtYWwvbWVkaWF0ZWsvS2NvbmZpZyAgICAgICAgICAgICAgfCAyMyAr
KysrKysrKysrKysrKysrKysrDQo+ICBkcml2ZXJzL3RoZXJtYWwvbWVkaWF0ZWsvTWFrZWZpbGUg
ICAgICAgICAgICAgfCAgMSArDQo+ICAuLi4ve210a190aGVybWFsLmMgPT4gbWVkaWF0ZWsvc29j
X3RlbXAuY30gICAgfCAgMA0KPiAgNSBmaWxlcyBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspLCAx
MSBkZWxldGlvbnMoLSkNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3RoZXJtYWwvbWVk
aWF0ZWsvS2NvbmZpZw0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvdGhlcm1hbC9tZWRp
YXRlay9NYWtlZmlsZQ0KPiAgcmVuYW1lIGRyaXZlcnMvdGhlcm1hbC97bXRrX3RoZXJtYWwuYyA9
PiBtZWRpYXRlay9zb2NfdGVtcC5jfSAoMTAwJSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3RoZXJtYWwvS2NvbmZpZyBiL2RyaXZlcnMvdGhlcm1hbC9LY29uZmlnDQo+IGluZGV4IDdlZGM4
ZGM2YmJhYi4uYjJkYTBhMWJkYTM0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3RoZXJtYWwvS2Nv
bmZpZw0KPiArKysgYi9kcml2ZXJzL3RoZXJtYWwvS2NvbmZpZw0KPiBAQCAtNDAxLDE2ICs0MDEs
MTAgQEAgY29uZmlnIERBOTA2Ml9USEVSTUFMDQo+ICAJICB6b25lLg0KPiAgCSAgQ29tcGF0aWJs
ZSB3aXRoIHRoZSBEQTkwNjIgYW5kIERBOTA2MSBQTUlDcy4NCj4gIA0KPiAtY29uZmlnIE1US19U
SEVSTUFMDQo+IC0JdHJpc3RhdGUgIlRlbXBlcmF0dXJlIHNlbnNvciBkcml2ZXIgZm9yIG1lZGlh
dGVrIFNvQ3MiDQo+IC0JZGVwZW5kcyBvbiBBUkNIX01FRElBVEVLIHx8IENPTVBJTEVfVEVTVA0K
PiAtCWRlcGVuZHMgb24gSEFTX0lPTUVNDQo+IC0JZGVwZW5kcyBvbiBOVk1FTSB8fCBOVk1FTT1u
DQo+IC0JZGVwZW5kcyBvbiBSRVNFVF9DT05UUk9MTEVSDQo+IC0JZGVmYXVsdCB5DQo+IC0JaGVs
cA0KPiAtCSAgRW5hYmxlIHRoaXMgb3B0aW9uIGlmIHlvdSB3YW50IHRvIGhhdmUgc3VwcG9ydCBm
b3IgdGhlcm1hbCBtYW5hZ2VtZW50DQo+IC0JICBjb250cm9sbGVyIHByZXNlbnQgaW4gTWVkaWF0
ZWsgU29Dcw0KPiArbWVudSAiTWVkaWF0ZWsgdGhlcm1hbCBkcml2ZXJzIg0KPiArZGVwZW5kcyBv
biBBUkNIX01FRElBVEVLIHx8IENPTVBJTEVfVEVTVA0KPiArc291cmNlICJkcml2ZXJzL3RoZXJt
YWwvbWVkaWF0ZWsvS2NvbmZpZyINCj4gK2VuZG1lbnUNCj4gIA0KPiAgY29uZmlnIEFNTE9HSUNf
VEhFUk1BTA0KPiAgCXRyaXN0YXRlICJBbWxvZ2ljIFRoZXJtYWwgU3VwcG9ydCINCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdGhlcm1hbC9NYWtlZmlsZSBiL2RyaXZlcnMvdGhlcm1hbC9NYWtlZmls
ZQ0KPiBpbmRleCBiNjRkZDUwYTY2MjkuLmY5ZTA3YzNmNTI5ZSAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy90aGVybWFsL01ha2VmaWxlDQo+ICsrKyBiL2RyaXZlcnMvdGhlcm1hbC9NYWtlZmlsZQ0K
PiBAQCAtNTUsNyArNTUsNyBAQCBvYmoteQkJCQkrPSBzdC8NCj4gIG9iai0kKENPTkZJR19RQ09N
X1RTRU5TKQkrPSBxY29tLw0KPiAgb2JqLXkJCQkJKz0gdGVncmEvDQo+ICBvYmotJChDT05GSUdf
SElTSV9USEVSTUFMKSAgICAgKz0gaGlzaV90aGVybWFsLm8NCj4gLW9iai0kKENPTkZJR19NVEtf
VEhFUk1BTCkJKz0gbXRrX3RoZXJtYWwubw0KPiArb2JqLSQoQ09ORklHX01US19USEVSTUFMKQkr
PSBtZWRpYXRlay8NCj4gIG9iai0kKENPTkZJR19HRU5FUklDX0FEQ19USEVSTUFMKQkrPSB0aGVy
bWFsLWdlbmVyaWMtYWRjLm8NCj4gIG9iai0kKENPTkZJR19aWDI5NjdfVEhFUk1BTCkJKz0gengy
OTY3X3RoZXJtYWwubw0KPiAgb2JqLSQoQ09ORklHX1VOSVBISUVSX1RIRVJNQUwpCSs9IHVuaXBo
aWVyX3RoZXJtYWwubw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90aGVybWFsL21lZGlhdGVrL0tj
b25maWcgYi9kcml2ZXJzL3RoZXJtYWwvbWVkaWF0ZWsvS2NvbmZpZw0KPiBuZXcgZmlsZSBtb2Rl
IDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwMDAuLjAzNTFlNzMxNzBiNw0KPiAtLS0gL2Rldi9u
dWxsDQo+ICsrKyBiL2RyaXZlcnMvdGhlcm1hbC9tZWRpYXRlay9LY29uZmlnDQo+IEBAIC0wLDAg
KzEsMjMgQEANCj4gK2NvbmZpZyBNVEtfVEhFUk1BTA0KPiArCXRyaXN0YXRlICJNZWRpYXRlayB0
aGVybWFsIGRyaXZlcnMiDQo+ICsJZGVwZW5kcyBvbiBUSEVSTUFMX09GDQo+ICsJaGVscA0KPiAr
CSAgVGhpcyBpcyB0aGUgb3B0aW9uIGZvciBNZWRpYXRlayB0aGVybWFsIHNvZnR3YXJlDQo+ICsJ
ICBzb2x1dGlvbnMuIFBsZWFzZSBlbmFibGUgY29ycmVzcG9uZGluZyBvcHRpb25zIHRvDQo+ICsJ
ICBnZXQgdGVtcGVyYXR1cmUgaW5mb3JtYXRpb24gZnJvbSB0aGVybWFsIHNlbnNvcnMgb3INCj4g
KwkgIHR1cm4gb24gdGhyb3R0bGUgbWVjaGFpc21zIGZvciB0aGVybWFsIG1pdGlnYXRpb24uDQo+
ICsNCj4gK2lmIE1US19USEVSTUFMDQo+ICsNCj4gK2NvbmZpZyBNVEtfU09DX1RIRVJNQUwNCj4g
Kwl0cmlzdGF0ZSAiVGVtcGVyYXR1cmUgc2Vuc29yIGRyaXZlciBmb3IgbWVkaWF0ZWsgU29DcyIN
Cj4gKwlkZXBlbmRzIG9uIEhBU19JT01FTQ0KPiArCWRlcGVuZHMgb24gTlZNRU0NCj4gKwlkZXBl
bmRzIG9uIFJFU0VUX0NPTlRST0xMRVINCj4gKwloZWxwDQo+ICsJICBFbmFibGUgdGhpcyBvcHRp
b24gaWYgeW91IHdhbnQgdG8gZ2V0IFNvQyB0ZW1wZXJhdHVyZQ0KPiArCSAgaW5mb3JtYXRpb24g
Zm9yIE1lZGlhdGVrIHBsYXRmb3Jtcy4gVGhpcyBkcml2ZXINCj4gKwkgIGNvbmZpZ3VyZXMgdGhl
cm1hbCBjb250cm9sbGVycyB0byBjb2xsZWN0IHRlbXBlcmF0dXJlDQo+ICsJICB2aWEgQVVYQURD
IGludGVyZmFjZS4NCj4gKw0KPiArZW5kaWYNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdGhlcm1h
bC9tZWRpYXRlay9NYWtlZmlsZSBiL2RyaXZlcnMvdGhlcm1hbC9tZWRpYXRlay9NYWtlZmlsZQ0K
PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwMDAuLmY3NTMxM2RkY2U1
ZQ0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL2RyaXZlcnMvdGhlcm1hbC9tZWRpYXRlay9NYWtl
ZmlsZQ0KPiBAQCAtMCwwICsxIEBADQo+ICtvYmotJChDT05GSUdfTVRLX1NPQ19USEVSTUFMKQkr
PSBzb2NfdGVtcC5vDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3RoZXJtYWwvbXRrX3RoZXJtYWwu
YyBiL2RyaXZlcnMvdGhlcm1hbC9tZWRpYXRlay9zb2NfdGVtcC5jDQo+IHNpbWlsYXJpdHkgaW5k
ZXggMTAwJQ0KPiByZW5hbWUgZnJvbSBkcml2ZXJzL3RoZXJtYWwvbXRrX3RoZXJtYWwuYw0KPiBy
ZW5hbWUgdG8gZHJpdmVycy90aGVybWFsL21lZGlhdGVrL3NvY190ZW1wLmMNCg0K

