Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECCA367CD4
	for <lists+linux-pm@lfdr.de>; Thu, 22 Apr 2021 10:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235599AbhDVIsI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Apr 2021 04:48:08 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:53178 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235514AbhDVIsH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Apr 2021 04:48:07 -0400
X-UUID: 4e1c1a1297ef4dbab9f550b9931bb8b4-20210422
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=lgjhrko7voA+5hsxOvNsIZmAxBpH3ReDLI988ioHR74=;
        b=NNpNuFmEI7BfsJbAS8ut/8um0gXfOx9LHIxK3l0Oru+J2hX+0/Z6cbz28QMZZu6rOY4RhRiFJLek8l5OFktMWHBFXFtlW2ajE+YZKzYjSDqmF6quPnqXJv2B60ikG4KZvMVZG3DXFK4c3kNht/L57zNpe2kB+cmdlbduBNJOxSk=;
X-UUID: 4e1c1a1297ef4dbab9f550b9931bb8b4-20210422
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <michael.kao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 321861852; Thu, 22 Apr 2021 16:47:29 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 22 Apr 2021 16:47:28 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 22 Apr 2021 16:47:27 +0800
Message-ID: <6db776994f939cd5403addeffdc78fc82bc98e7a.camel@mediatek.com>
Subject: Re: [v3,1/3] thermal: mediatek: Relocate driver to mediatek folder
From:   Michael Kao <michael.kao@mediatek.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, <linux-pm@vger.kernel.org>,
        <srv_heupstream@mediatek.com>
CC:     Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>, <hsinyi@chromium.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Thu, 22 Apr 2021 16:47:28 +0800
In-Reply-To: <836581c1-0738-8e42-b168-b54d0bd078a5@linaro.org>
References: <20210312034018.17437-1-michael.kao@mediatek.com>
         <20210312034018.17437-2-michael.kao@mediatek.com>
         <836581c1-0738-8e42-b168-b54d0bd078a5@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gVHVlLCAyMDIxLTA0LTIwIGF0IDIzOjIyICswMjAwLCBEYW5pZWwgTGV6Y2FubyB3cm90ZToN
Cj4gT24gMTIvMDMvMjAyMSAwNDo0MCwgTWljaGFlbCBLYW8gd3JvdGU6DQo+ID4gQWRkIE1lZGlh
dGVrIHByb3ByaWV0YXJ5IGZvbGRlciB0byB1cHN0cmVhbSBtb3JlIHRoZXJtYWwgem9uZSBhbmQN
Cj4gPiBjb29sZXINCj4gPiBkcml2ZXJzLiBSZWxvY2F0ZSB0aGUgb3JpZ2luYWwgdGhlcm1hbCBj
b250cm9sbGVyIGRyaXZlciB0byBpdCBhbmQNCj4gPiByZW5hbWUNCj4gPiBhcyBzb2NfdGVtcC5j
IHRvIHNob3cgaXRzIHB1cnBvc2UgbW9yZSBjbGVhcmx5Lg0KPiANCj4gV2UgYWxyZWFkeSBrbm93
IHRoZSBwdXJwb3NlIDopDQo+IA0KPiBzb2NfdGVtcCBnaXZlcyBubyBhZGRpdGlvbmFsIGluZm9y
bWF0aW9uLg0KPiANCj4gRWl0aGVyIGtlZXAgdGhlIG5hbWUgb3IgZ2l2ZSB0aGUgaGFyZHdhcmUg
c2Vuc29yIG5hbWUuIEl0IGlzIGEgZHJpdmVyDQo+IGRpcmVjdG9yeS4NCj4gDQoNCkRlYXIgRGFu
aWVsLA0KVGhlIG5ldyB0aGVybWFsIGhhcmR3YXJlIGRlc2lnbiBjYWxsZWQgbHZ0cyAoTG93IHZv
bHRhZ2UgdGhlcm1hbA0Kc2Vuc29yKS4NCkluc3RlYWQgb2Ygb3JpZ2luYWwgb25lIHVzaW5nIGF1
eGFkYywgdGhlIGx2dHMgdXNlIGx2dHMgZGV2aWNlIHRvDQphY2Nlc3MgdGhlcm1hbCBzZW5vc3Jz
Lg0KSXQgd2lsbCBzYXZlIHBvd2VyIGFuZCBiZSBtb3JlIGVmZmljaWVudC4NCldlIHVzZSB0aGUg
Y29uZmlnIENPTkZJR19NVEtfVEhFUk1BTCBhbmQgQ09ORklHX01US19TT0NfVEhFUk1BTF9MVlRT
WzFdDQp0byBzZWxlY3QgdGhlIGRpZmZlcmVudCBoYXJkd2FyZSBhcmNodGVjdHVyZS4NCg0KWzFd
IFt2MywyLzNdIHRoZXJtYWw6IG1lZGlhdGVrOiBBZGQgTFZUUyBkcml2ZXJzIGZvciBTb0MgdGhl
cmFtbCB6b25lcw0KDQpodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgt
bWVkaWF0ZWsvcGF0Y2gvMjAyMTAzMTIwMzQwMTguMTc0MzctMy1taWNoYWVsLmthb0BtZWRpYXRl
ay5jb20vDQoNCj4gPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIEthbyA8bWljaGFlbC5rYW9AbWVk
aWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3RoZXJtYWwvS2NvbmZpZyAgICAgICAg
ICAgICAgICAgICAgICAgfCAxNCArKysrLS0tLS0tLQ0KPiA+ICBkcml2ZXJzL3RoZXJtYWwvTWFr
ZWZpbGUgICAgICAgICAgICAgICAgICAgICAgfCAgMiArLQ0KPiA+ICBkcml2ZXJzL3RoZXJtYWwv
bWVkaWF0ZWsvS2NvbmZpZyAgICAgICAgICAgICAgfCAyMw0KPiA+ICsrKysrKysrKysrKysrKysr
KysNCj4gPiAgZHJpdmVycy90aGVybWFsL21lZGlhdGVrL01ha2VmaWxlICAgICAgICAgICAgIHwg
IDEgKw0KPiA+ICAuLi4ve210a190aGVybWFsLmMgPT4gbWVkaWF0ZWsvc29jX3RlbXAuY30gICAg
fCAgMA0KPiANCj4gWyAuLi4gXQ0KPiANCj4gdnZ2dnZ2dnZ2dnZ2dnZ2dnZ2dnZ2dnZ2dnZ2dnZ2
dnZ2dnZ2dnYNCj4gDQo+IA0KPiA+ICtjb25maWcgTVRLX1RIRVJNQUwNCj4gPiArCXRyaXN0YXRl
ICJNZWRpYXRlayB0aGVybWFsIGRyaXZlcnMiDQo+ID4gKwlkZXBlbmRzIG9uIFRIRVJNQUxfT0YN
Cj4gPiArCWhlbHANCj4gPiArCSAgVGhpcyBpcyB0aGUgb3B0aW9uIGZvciBNZWRpYXRlayB0aGVy
bWFsIHNvZnR3YXJlDQo+ID4gKwkgIHNvbHV0aW9ucy4gUGxlYXNlIGVuYWJsZSBjb3JyZXNwb25k
aW5nIG9wdGlvbnMgdG8NCj4gPiArCSAgZ2V0IHRlbXBlcmF0dXJlIGluZm9ybWF0aW9uIGZyb20g
dGhlcm1hbCBzZW5zb3JzIG9yDQo+ID4gKwkgIHR1cm4gb24gdGhyb3R0bGUgbWVjaGFpc21zIGZv
ciB0aGVybWFsIG1pdGlnYXRpb24uDQo+ID4gKw0KPiA+ICtpZiBNVEtfVEhFUk1BTA0KPiANCj4g
DQo+IF5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eDQo+IA0KPiBBbGwgdGhl
IGFib3ZlIG5vdCBuZWVkZWQuDQo+IA0KPiA+ICtjb25maWcgTVRLX1NPQ19USEVSTUFMDQo+ID4g
Kwl0cmlzdGF0ZSAiVGVtcGVyYXR1cmUgc2Vuc29yIGRyaXZlciBmb3IgbWVkaWF0ZWsgU29DcyIN
Cj4gPiArCWRlcGVuZHMgb24gSEFTX0lPTUVNDQo+ID4gKwlkZXBlbmRzIG9uIE5WTUVNDQo+ID4g
KwlkZXBlbmRzIG9uIFJFU0VUX0NPTlRST0xMRVINCj4gPiArCWhlbHANCj4gPiArCSAgRW5hYmxl
IHRoaXMgb3B0aW9uIGlmIHlvdSB3YW50IHRvIGdldCBTb0MgdGVtcGVyYXR1cmUNCj4gPiArCSAg
aW5mb3JtYXRpb24gZm9yIE1lZGlhdGVrIHBsYXRmb3Jtcy4gVGhpcyBkcml2ZXINCj4gPiArCSAg
Y29uZmlndXJlcyB0aGVybWFsIGNvbnRyb2xsZXJzIHRvIGNvbGxlY3QgdGVtcGVyYXR1cmUNCj4g
PiArCSAgdmlhIEFVWEFEQyBpbnRlcmZhY2UuDQo+ID4gKw0KPiA+ICtlbmRpZg0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3RoZXJtYWwvbWVkaWF0ZWsvTWFrZWZpbGUNCj4gPiBiL2RyaXZlcnMv
dGhlcm1hbC9tZWRpYXRlay9NYWtlZmlsZQ0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4g
aW5kZXggMDAwMDAwMDAwMDAwLi5mNzUzMTNkZGNlNWUNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4g
KysrIGIvZHJpdmVycy90aGVybWFsL21lZGlhdGVrL01ha2VmaWxlDQo+ID4gQEAgLTAsMCArMSBA
QA0KPiA+ICtvYmotJChDT05GSUdfTVRLX1NPQ19USEVSTUFMKQkrPSBzb2NfdGVtcC5vDQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdGhlcm1hbC9tdGtfdGhlcm1hbC5jDQo+ID4gYi9kcml2ZXJz
L3RoZXJtYWwvbWVkaWF0ZWsvc29jX3RlbXAuYw0KPiA+IHNpbWlsYXJpdHkgaW5kZXggMTAwJQ0K
PiA+IHJlbmFtZSBmcm9tIGRyaXZlcnMvdGhlcm1hbC9tdGtfdGhlcm1hbC5jDQo+ID4gcmVuYW1l
IHRvIGRyaXZlcnMvdGhlcm1hbC9tZWRpYXRlay9zb2NfdGVtcC5jDQo+IA0KPiANCj4gDQo=

