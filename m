Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 492CA28815E
	for <lists+linux-pm@lfdr.de>; Fri,  9 Oct 2020 06:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730726AbgJIEbj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Oct 2020 00:31:39 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:59602 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730733AbgJIEbj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Oct 2020 00:31:39 -0400
X-UUID: 805c08d72c12478394b7a414d1468da5-20201009
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=YP+nDNjrZMZWHXp2PpX7EfCVxiPYWns32R0xLk03Kyw=;
        b=sqx+Iw/ijllUffeErGZwKK0JKx8rSJKwuVMUh5tN3pIQl4t8VyaT9YJbPD1icNOaR2qiKxGALsu5tfBYEQaj1ZjSttFp26Vwq7r+Fzwq7I6i95DuuV+zCHnbQzN1y86Mm4Vq7mOGsQ39r2vverEeEn9ojkhosMB4EJ0DnJJQsPs=;
X-UUID: 805c08d72c12478394b7a414d1468da5-20201009
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1268273005; Fri, 09 Oct 2020 12:31:33 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 9 Oct 2020 12:31:26 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 9 Oct 2020 12:31:25 +0800
Message-ID: <1602217886.21446.48.camel@mtkswgap22>
Subject: Re: [PATCH v1 1/1] cpufreq: mediatek-hw: Register EM power table
From:   Hector Yuan <hector.yuan@mediatek.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
CC:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>
Date:   Fri, 9 Oct 2020 12:31:26 +0800
In-Reply-To: <7e58516f-a6bf-eac4-9dfb-9a4d7efa7498@arm.com>
References: <1602159204-13756-1-git-send-email-hector.yuan@mediatek.com>
         <1602159204-13756-2-git-send-email-hector.yuan@mediatek.com>
         <7e58516f-a6bf-eac4-9dfb-9a4d7efa7498@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gVGh1LCAyMDIwLTEwLTA4IGF0IDEzOjU1ICswMTAwLCBMdWthc3ogTHViYSB3cm90ZToNCj4g
SGkgSGVjdG9yLA0KPiANCj4gT24gMTAvOC8yMCAxOjEzIFBNLCBIZWN0b3IgWXVhbiB3cm90ZToN
Cj4gPiBGcm9tOiAiSGVjdG9yLll1YW4iIDxoZWN0b3IueXVhbkBtZWRpYXRlay5jb20+DQo+ID4g
DQo+ID4gUmVnaXN0ZXIgQ1BVIHBvd2VyIHRhYmxlIHRvIGVuZXJneSBtb2RlbCBmcmFtZXdvcmsN
Cj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBIZWN0b3IuWXVhbiA8aGVjdG9yLnl1YW5AbWVkaWF0
ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9jcHVmcmVxL21lZGlhdGVrLWNwdWZyZXEt
aHcuYyB8ICAgNTAgKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tDQo+ID4gICAxIGZp
bGUgY2hhbmdlZCwgMzggaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3B1ZnJlcS9tZWRpYXRlay1jcHVmcmVxLWh3LmMgYi9kcml2
ZXJzL2NwdWZyZXEvbWVkaWF0ZWstY3B1ZnJlcS1ody5jDQo+ID4gaW5kZXggOGZhMTJlNS4uMzgw
OGVhMCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2NwdWZyZXEvbWVkaWF0ZWstY3B1ZnJlcS1o
dy5jDQo+ID4gKysrIGIvZHJpdmVycy9jcHVmcmVxL21lZGlhdGVrLWNwdWZyZXEtaHcuYw0KPiA+
IEBAIC01LDYgKzUsNyBAQA0KPiA+ICAgDQo+ID4gICAjaW5jbHVkZSA8bGludXgvYml0ZmllbGQu
aD4NCj4gPiAgICNpbmNsdWRlIDxsaW51eC9jcHVmcmVxLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51
eC9lbmVyZ3lfbW9kZWwuaD4NCj4gPiAgICNpbmNsdWRlIDxsaW51eC9pbml0Lmg+DQo+ID4gICAj
aW5jbHVkZSA8bGludXgva2VybmVsLmg+DQo+ID4gICAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+
DQo+ID4gQEAgLTE3LDkgKzE4LDEwIEBADQo+ID4gICAjZGVmaW5lIExVVF9ST1dfU0laRQkJCTB4
NA0KPiA+ICAgDQo+ID4gICBlbnVtIHsNCj4gPiAtCVJFR19MVVRfVEFCTEUsDQo+ID4gLQlSRUdf
RU5BQkxFLA0KPiA+IC0JUkVHX1BFUkZfU1RBVEUsDQo+ID4gKwlSRUdfRlJFUV9MVVRfVEFCTEUs
DQo+ID4gKwlSRUdfRlJFUV9FTkFCTEUsDQo+ID4gKwlSRUdfRlJFUV9QRVJGX1NUQVRFLA0KPiA+
ICsJUkVHX0VNX1BPV0VSX1RCTCwNCj4gPiAgIA0KPiA+ICAgCVJFR19BUlJBWV9TSVpFLA0KPiA+
ICAgfTsNCj4gPiBAQCAtMjcsMjMgKzI5LDQ0IEBAIGVudW0gew0KPiA+ICAgc3RydWN0IGNwdWZy
ZXFfbXRrIHsNCj4gPiAgIAlzdHJ1Y3QgY3B1ZnJlcV9mcmVxdWVuY3lfdGFibGUgKnRhYmxlOw0K
PiA+ICAgCXZvaWQgX19pb21lbSAqcmVnX2Jhc2VzW1JFR19BUlJBWV9TSVpFXTsNCj4gPiArCWlu
dCBucl9vcHA7DQo+ID4gICAJY3B1bWFza190IHJlbGF0ZWRfY3B1czsNCj4gPiAgIH07DQo+ID4g
ICANCj4gPiAgIHN0YXRpYyBjb25zdCB1MTYgY3B1ZnJlcV9tdGtfb2Zmc2V0c1tSRUdfQVJSQVlf
U0laRV0gPSB7DQo+ID4gLQlbUkVHX0xVVF9UQUJMRV0JCT0gMHgwLA0KPiA+IC0JW1JFR19FTkFC
TEVdCQk9IDB4ODQsDQo+ID4gLQlbUkVHX1BFUkZfU1RBVEVdCT0gMHg4OCwNCj4gPiArCVtSRUdf
RlJFUV9MVVRfVEFCTEVdCT0gMHgwLA0KPiA+ICsJW1JFR19GUkVRX0VOQUJMRV0JPSAweDg0LA0K
PiA+ICsJW1JFR19GUkVRX1BFUkZfU1RBVEVdCT0gMHg4OCwNCj4gPiArCVtSRUdfRU1fUE9XRVJf
VEJMXQk9IDB4M0QwLA0KPiA+ICAgfTsNCj4gPiAgIA0KPiA+ICAgc3RhdGljIHN0cnVjdCBjcHVm
cmVxX210ayAqbXRrX2ZyZXFfZG9tYWluX21hcFtOUl9DUFVTXTsNCj4gPiAgIA0KPiA+ICtzdGF0
aWMgaW50IG10a19jcHVmcmVxX2dldF9jcHVfcG93ZXIodW5zaWduZWQgbG9uZyAqbVcsDQo+ID4g
KwkJCQkgICAgIHVuc2lnbmVkIGxvbmcgKktIeiwgaW50IGNwdSkNCj4gPiArew0KPiA+ICsJc3Ry
dWN0IGNwdWZyZXFfbXRrICpjID0gbXRrX2ZyZXFfZG9tYWluX21hcFtjcHVdOw0KPiA+ICsJaW50
IGk7DQo+ID4gKw0KPiA+ICsJZm9yIChpID0gMDsgaSA8IGMtPm5yX29wcDsgaSsrKSB7DQo+ID4g
KwkJaWYgKGMtPnRhYmxlW2ldLmZyZXF1ZW5jeSA8ICpLSHopDQo+ID4gKwkJCWJyZWFrOw0KPiA+
ICsJfQ0KPiA+ICsJaS0tOw0KPiA+ICsNCj4gPiArCSpLSHogPSBjLT50YWJsZVtpXS5mcmVxdWVu
Y3k7DQo+ID4gKwkqbVcgPSByZWFkbF9yZWxheGVkKGMtPnJlZ19iYXNlc1tSRUdfRU1fUE9XRVJf
VEJMXSArDQo+ID4gKwkJCSAgICBpICogTFVUX1JPV19TSVpFKSAvIDEwMDA7DQo+ID4gKw0KPiA+
ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+ID4gICBzdGF0aWMgaW50IG10a19jcHVmcmVx
X2h3X3RhcmdldF9pbmRleChzdHJ1Y3QgY3B1ZnJlcV9wb2xpY3kgKnBvbGljeSwNCj4gPiAgIAkJ
CQkgICAgICAgdW5zaWduZWQgaW50IGluZGV4KQ0KPiA+ICAgew0KPiA+ICAgCXN0cnVjdCBjcHVm
cmVxX210ayAqYyA9IHBvbGljeS0+ZHJpdmVyX2RhdGE7DQo+ID4gICANCj4gPiAtCXdyaXRlbF9y
ZWxheGVkKGluZGV4LCBjLT5yZWdfYmFzZXNbUkVHX1BFUkZfU1RBVEVdKTsNCj4gPiArCXdyaXRl
bF9yZWxheGVkKGluZGV4LCBjLT5yZWdfYmFzZXNbUkVHX0ZSRVFfUEVSRl9TVEFURV0pOw0KPiA+
ICAgDQo+ID4gICAJcmV0dXJuIDA7DQo+ID4gICB9DQo+ID4gQEAgLTU1LDcgKzc4LDcgQEAgc3Rh
dGljIHVuc2lnbmVkIGludCBtdGtfY3B1ZnJlcV9od19nZXQodW5zaWduZWQgaW50IGNwdSkNCj4g
PiAgIA0KPiA+ICAgCWMgPSBtdGtfZnJlcV9kb21haW5fbWFwW2NwdV07DQo+ID4gICANCj4gPiAt
CWluZGV4ID0gcmVhZGxfcmVsYXhlZChjLT5yZWdfYmFzZXNbUkVHX1BFUkZfU1RBVEVdKTsNCj4g
PiArCWluZGV4ID0gcmVhZGxfcmVsYXhlZChjLT5yZWdfYmFzZXNbUkVHX0ZSRVFfUEVSRl9TVEFU
RV0pOw0KPiA+ICAgCWluZGV4ID0gbWluKGluZGV4LCBMVVRfTUFYX0VOVFJJRVMgLSAxKTsNCj4g
PiAgIA0KPiA+ICAgCXJldHVybiBjLT50YWJsZVtpbmRleF0uZnJlcXVlbmN5Ow0KPiA+IEBAIC02
NCw2ICs4Nyw3IEBAIHN0YXRpYyB1bnNpZ25lZCBpbnQgbXRrX2NwdWZyZXFfaHdfZ2V0KHVuc2ln
bmVkIGludCBjcHUpDQo+ID4gICBzdGF0aWMgaW50IG10a19jcHVmcmVxX2h3X2NwdV9pbml0KHN0
cnVjdCBjcHVmcmVxX3BvbGljeSAqcG9saWN5KQ0KPiA+ICAgew0KPiA+ICAgCXN0cnVjdCBjcHVm
cmVxX210ayAqYzsNCj4gPiArCXN0cnVjdCBlbV9kYXRhX2NhbGxiYWNrIGVtX2NiID0gRU1fREFU
QV9DQihtdGtfY3B1ZnJlcV9nZXRfY3B1X3Bvd2VyKTsNCj4gPiAgIA0KPiA+ICAgCWMgPSBtdGtf
ZnJlcV9kb21haW5fbWFwW3BvbGljeS0+Y3B1XTsNCj4gPiAgIAlpZiAoIWMpIHsNCj4gPiBAQCAt
NzcsNyArMTAxLDggQEAgc3RhdGljIGludCBtdGtfY3B1ZnJlcV9od19jcHVfaW5pdChzdHJ1Y3Qg
Y3B1ZnJlcV9wb2xpY3kgKnBvbGljeSkNCj4gPiAgIAlwb2xpY3ktPmRyaXZlcl9kYXRhID0gYzsN
Cj4gPiAgIA0KPiA+ICAgCS8qIEhXIHNob3VsZCBiZSBpbiBlbmFibGVkIHN0YXRlIHRvIHByb2Nl
ZWQgbm93ICovDQo+ID4gLQl3cml0ZWxfcmVsYXhlZCgweDEsIGMtPnJlZ19iYXNlc1tSRUdfRU5B
QkxFXSk7DQo+ID4gKwl3cml0ZWxfcmVsYXhlZCgweDEsIGMtPnJlZ19iYXNlc1tSRUdfRlJFUV9F
TkFCTEVdKTsNCj4gPiArCWVtX3JlZ2lzdGVyX3BlcmZfZG9tYWluKHBvbGljeS0+Y3B1cywgYy0+
bnJfb3BwLCAmZW1fY2IpOw0KPiANCj4gDQo+IFRoZSBmdW5jdGlvbiBuYW1lIGhhcyBjaGFuZ2Vk
IHJlY2VudGx5ICh2NS45LXJjMSkgdG86DQo+IGVtX2Rldl9yZWdpc3Rlcl9wZXJmX2RvbWFpbigp
DQo+IA0KPiBQbGVhc2UgY2hlY2sgeW91ciBiYXNlIGtlcm5lbCB0cmVlIGFuZCB1cGRhdGUuDQo+
IA0KPiBSZWdhcmRzLA0KPiBMdWthc3oNCj4gDQpPSywgd2lsbCBjaGVjayBteSBiYXNlIGtlcm5l
bCBhbmQgdXBkYXRlIHRoaXMuDQpUaGFuayB5b3UuDQoNCg==

