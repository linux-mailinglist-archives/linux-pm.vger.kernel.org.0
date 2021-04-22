Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCB7367C97
	for <lists+linux-pm@lfdr.de>; Thu, 22 Apr 2021 10:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbhDVIdW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Apr 2021 04:33:22 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:52492 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230285AbhDVIdV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Apr 2021 04:33:21 -0400
X-UUID: 9438226266c84c38b3bebda3edc21c8b-20210422
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=8OCuYAoKRzyNIrFHDh0JFHLltn0XV5hbwr2yNVi0Wv0=;
        b=sQdBXljMP9zdCC0P4a0WXUbw2kbeoOhX9EMv02JhlR1tuT6azcM851P54tCUg9gC0N6vElQBqjCTOcHGHeLPScPM5615RajLGatWZjXlDOFTdRXF6HMnZgN1FP+TcBUeFTwWWsT1GEKX1m1PYexdg7ptVvmz11y+l7kkyY7Kibg=;
X-UUID: 9438226266c84c38b3bebda3edc21c8b-20210422
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <michael.kao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2096331822; Thu, 22 Apr 2021 16:32:39 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 22 Apr 2021 16:32:38 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 22 Apr 2021 16:32:38 +0800
Message-ID: <8532c21e518530d06a37c25bbcbc08d97147769a.camel@mediatek.com>
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
Date:   Thu, 22 Apr 2021 16:32:38 +0800
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
c2Vuc29yIG5hbWUuIEl0IGlzIGEgZHJpdmVyDQo+IGRpcmVjdG9yeS4NCj4gDQpEZWFyIERhbmll
bCwNCg0KV2UgaW50cm9kdWNlIHRoZSBuZXcgdGhlcm1hbCBoYXJkd2FyZSBkZXNpZ24gY2FsbGVk
IGx2dHMgaW4gdGhlIG5ldw0KcHJvamVjdC4gVGhlIG5ldyBwcm9qZWN0IHdpbGwgZGVzZ2luIHdp
dGggbHZ0cyB3aWxsIGVuYWJsZSB0aGUNCkNPTkZJR19NVEtfU09DX1RIRVJNQUxfTFZUUyB0byBi
dWlsZCBsdnRzIGRyaXZlclsxXS4NClRoZSBvbGQgcHJvamVjdCB3aWxsIHVzZSBDT05GSUdfTVRL
X1RIRVJNQUwgdG8gYnVpbGQgc29jX3RlbXAuYy4NCg0KVGhlIG5ldyBkZXNpZ24gdXNlIGx2dHMg
ZGV2aWNlIHRvIGFjY2VzcyB0aGVybWFsIHNlbnNvcnMgaW4gdGhlIHNvYy4NClRoZSBvcmlnaW5h
bCBkZXNpZ24gYWNjZXNzIHRoZXJtYWwgc2Vuc29ycyBieSBhdXhhZGMuDQoNClsxXSBbdjMsMi8z
XSB0aGVybWFsOiBtZWRpYXRlazogQWRkIExWVFMgZHJpdmVycyBmb3IgU29DIHRoZXJhbWwgem9u
ZXMNCg0KDQo+ID4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBLYW8gPG1pY2hhZWwua2FvQG1lZGlh
dGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy90aGVybWFsL0tjb25maWcgICAgICAgICAg
ICAgICAgICAgICAgIHwgMTQgKysrKy0tLS0tLS0NCj4gPiAgZHJpdmVycy90aGVybWFsL01ha2Vm
aWxlICAgICAgICAgICAgICAgICAgICAgIHwgIDIgKy0NCj4gPiAgZHJpdmVycy90aGVybWFsL21l
ZGlhdGVrL0tjb25maWcgICAgICAgICAgICAgIHwgMjMNCj4gPiArKysrKysrKysrKysrKysrKysr
DQo+ID4gIGRyaXZlcnMvdGhlcm1hbC9tZWRpYXRlay9NYWtlZmlsZSAgICAgICAgICAgICB8ICAx
ICsNCj4gPiAgLi4uL3ttdGtfdGhlcm1hbC5jID0+IG1lZGlhdGVrL3NvY190ZW1wLmN9ICAgIHwg
IDANCj4gDQo+IFsgLi4uIF0NCj4gDQo+IHZ2dnZ2dnZ2dnZ2dnZ2dnZ2dnZ2dnZ2dnZ2dnZ2dnZ2
dnZ2dnZ2DQo+IA0KPiANCj4gPiArY29uZmlnIE1US19USEVSTUFMDQo+ID4gKwl0cmlzdGF0ZSAi
TWVkaWF0ZWsgdGhlcm1hbCBkcml2ZXJzIg0KPiA+ICsJZGVwZW5kcyBvbiBUSEVSTUFMX09GDQo+
ID4gKwloZWxwDQo+ID4gKwkgIFRoaXMgaXMgdGhlIG9wdGlvbiBmb3IgTWVkaWF0ZWsgdGhlcm1h
bCBzb2Z0d2FyZQ0KPiA+ICsJICBzb2x1dGlvbnMuIFBsZWFzZSBlbmFibGUgY29ycmVzcG9uZGlu
ZyBvcHRpb25zIHRvDQo+ID4gKwkgIGdldCB0ZW1wZXJhdHVyZSBpbmZvcm1hdGlvbiBmcm9tIHRo
ZXJtYWwgc2Vuc29ycyBvcg0KPiA+ICsJICB0dXJuIG9uIHRocm90dGxlIG1lY2hhaXNtcyBmb3Ig
dGhlcm1hbCBtaXRpZ2F0aW9uLg0KPiA+ICsNCj4gPiAraWYgTVRLX1RIRVJNQUwNCj4gDQo+IA0K
PiBeXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXg0KPiANCj4gQWxsIHRoZSBh
Ym92ZSBub3QgbmVlZGVkLg0KPiANCj4gPiArY29uZmlnIE1US19TT0NfVEhFUk1BTA0KPiA+ICsJ
dHJpc3RhdGUgIlRlbXBlcmF0dXJlIHNlbnNvciBkcml2ZXIgZm9yIG1lZGlhdGVrIFNvQ3MiDQo+
ID4gKwlkZXBlbmRzIG9uIEhBU19JT01FTQ0KPiA+ICsJZGVwZW5kcyBvbiBOVk1FTQ0KPiA+ICsJ
ZGVwZW5kcyBvbiBSRVNFVF9DT05UUk9MTEVSDQo+ID4gKwloZWxwDQo+ID4gKwkgIEVuYWJsZSB0
aGlzIG9wdGlvbiBpZiB5b3Ugd2FudCB0byBnZXQgU29DIHRlbXBlcmF0dXJlDQo+ID4gKwkgIGlu
Zm9ybWF0aW9uIGZvciBNZWRpYXRlayBwbGF0Zm9ybXMuIFRoaXMgZHJpdmVyDQo+ID4gKwkgIGNv
bmZpZ3VyZXMgdGhlcm1hbCBjb250cm9sbGVycyB0byBjb2xsZWN0IHRlbXBlcmF0dXJlDQo+ID4g
KwkgIHZpYSBBVVhBREMgaW50ZXJmYWNlLg0KPiA+ICsNCj4gPiArZW5kaWYNCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy90aGVybWFsL21lZGlhdGVrL01ha2VmaWxlDQo+ID4gYi9kcml2ZXJzL3Ro
ZXJtYWwvbWVkaWF0ZWsvTWFrZWZpbGUNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGlu
ZGV4IDAwMDAwMDAwMDAwMC4uZjc1MzEzZGRjZTVlDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsr
KyBiL2RyaXZlcnMvdGhlcm1hbC9tZWRpYXRlay9NYWtlZmlsZQ0KPiA+IEBAIC0wLDAgKzEgQEAN
Cj4gPiArb2JqLSQoQ09ORklHX01US19TT0NfVEhFUk1BTCkJKz0gc29jX3RlbXAubw0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3RoZXJtYWwvbXRrX3RoZXJtYWwuYw0KPiA+IGIvZHJpdmVycy90
aGVybWFsL21lZGlhdGVrL3NvY190ZW1wLmMNCj4gPiBzaW1pbGFyaXR5IGluZGV4IDEwMCUNCj4g
PiByZW5hbWUgZnJvbSBkcml2ZXJzL3RoZXJtYWwvbXRrX3RoZXJtYWwuYw0KPiA+IHJlbmFtZSB0
byBkcml2ZXJzL3RoZXJtYWwvbWVkaWF0ZWsvc29jX3RlbXAuYw0KPiANCj4gDQo+IA0K

