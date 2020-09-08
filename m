Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E622611F3
	for <lists+linux-pm@lfdr.de>; Tue,  8 Sep 2020 15:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729935AbgIHLPh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Sep 2020 07:15:37 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:39747 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729721AbgIHLOh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2020 07:14:37 -0400
X-UUID: 4e42e08c115d41d2874bf3c108eb1143-20200908
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=ztKPvKAMVkhiTfL7QF2uQAL3r+CYGYFg1GUnCHV48sk=;
        b=fLsNaXltmAtUNqAVwUHk+txboogcoMPuZyCSqzDoIhfw458cFfN9C6L0YvbGTNIprLFugOLcU7skLMQjqazX3/ZB7d1IAJlNQ4aWfeC5bpWoBZqhAgfmLOiU09MhRVl451DgtVanSU2YizJOaY4XZVxf2RCgr27Tap5EzOKfyo0=;
X-UUID: 4e42e08c115d41d2874bf3c108eb1143-20200908
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1187452921; Tue, 08 Sep 2020 19:12:53 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 8 Sep 2020 19:12:51 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 8 Sep 2020 19:12:52 +0800
Message-ID: <1599563572.2621.7.camel@mtkswgap22>
Subject: Re: [PATCH v4 2/2] dt-bindings: cpufreq: add bindings for MediaTek
 cpufreq HW
From:   Hector Yuan <hector.yuan@mediatek.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rob Herring" <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <wsd_upstream@mediatek.com>
Date:   Tue, 8 Sep 2020 19:12:52 +0800
In-Reply-To: <20200908100733.pbizjorq3lmn7bew@vireshk-i7>
References: <1599550547-27767-1-git-send-email-hector.yuan@mediatek.com>
         <1599550547-27767-3-git-send-email-hector.yuan@mediatek.com>
         <20200908100733.pbizjorq3lmn7bew@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gVHVlLCAyMDIwLTA5LTA4IGF0IDE1OjM3ICswNTMwLCBWaXJlc2ggS3VtYXIgd3JvdGU6DQo+
IE9uIDA4LTA5LTIwLCAxNTozNSwgSGVjdG9yIFl1YW4gd3JvdGU6DQo+ID4gRnJvbTogIkhlY3Rv
ci5ZdWFuIiA8aGVjdG9yLnl1YW5AbWVkaWF0ZWsuY29tPg0KPiA+IA0KPiA+IEFkZCBkZXZpY2V0
cmVlIGJpbmRpbmdzIGZvciBNZWRpYVRlayBIVyBkcml2ZXIuDQo+ID4gDQo+ID4gU2lnbmVkLW9m
Zi1ieTogSGVjdG9yLll1YW4gPGhlY3Rvci55dWFuQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4g
PiAgLi4uL2JpbmRpbmdzL2NwdWZyZXEvY3B1ZnJlcS1tZWRpYXRlay1ody55YW1sICAgICAgfCAg
MTQxICsrKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxNDEgaW5zZXJ0
aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2NwdWZyZXEvY3B1ZnJlcS1tZWRpYXRlay1ody55YW1sDQo+ID4gDQo+ID4gZGlm
ZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jcHVmcmVxL2NwdWZy
ZXEtbWVkaWF0ZWstaHcueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9j
cHVmcmVxL2NwdWZyZXEtbWVkaWF0ZWstaHcueWFtbA0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0
DQo+ID4gaW5kZXggMDAwMDAwMC4uNWJlNTg2Nw0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysg
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY3B1ZnJlcS9jcHVmcmVxLW1lZGlh
dGVrLWh3LnlhbWwNCj4gPiBAQCAtMCwwICsxLDE0MSBAQA0KPiA+ICsjIFNQRFgtTGljZW5zZS1J
ZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkNCj4gPiArJVlBTUwgMS4y
DQo+ID4gKy0tLQ0KPiA+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL2NwdWZy
ZXEvY3B1ZnJlcS1tZWRpYXRlay1ody55YW1sIw0KPiA+ICskc2NoZW1hOiBodHRwOi8vZGV2aWNl
dHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMNCj4gPiArDQo+ID4gK3RpdGxlOiBNZWRp
YVRlaydzIENQVUZSRVEgQmluZGluZ3MNCj4gPiArDQo+ID4gK21haW50YWluZXJzOg0KPiA+ICsg
IC0gSGVjdG9yIFl1YW4gPGhlY3Rvci55dWFuQG1lZGlhdGVrLmNvbT4NCj4gPiArDQo+ID4gK2Rl
c2NyaXB0aW9uOg0KPiA+ICsgIENQVUZSRVEgSFcgaXMgYSBoYXJkd2FyZSBlbmdpbmUgdXNlZCBi
eSBNZWRpYVRlaw0KPiA+ICsgIFNvQ3MgdG8gbWFuYWdlIGZyZXF1ZW5jeSBpbiBoYXJkd2FyZS4g
SXQgaXMgY2FwYWJsZSBvZiBjb250cm9sbGluZyBmcmVxdWVuY3kNCj4gPiArICBmb3IgbXVsdGlw
bGUgY2x1c3RlcnMuDQo+ID4gKw0KPiA+ICtwcm9wZXJ0aWVzOg0KPiA+ICsgIGNvbXBhdGlibGU6
DQo+ID4gKyAgICBjb25zdDogbWVkaWF0ZWssY3B1ZnJlcS1odw0KPiANCj4gTWlzc2luZyAiIiBo
ZXJlID8NCj4gDQpPSywgd2lsbCBhZGQgaXQgaW4gdjUuDQo+ID4gKw0KPiA+ICsgIHJlZzoNCj4g
PiArICAgIG1pbkl0ZW1zOiAxDQo+ID4gKyAgICBtYXhJdGVtczogMg0KPiA+ICsgICAgZGVzY3Jp
cHRpb246IHwNCj4gPiArICAgICAgQWRkcmVzc2VzIGFuZCBzaXplcyBmb3IgdGhlIG1lbW9yeSBv
ZiB0aGUgSFcgYmFzZXMgaW4gZWFjaCBmcmVxdWVuY3kgZG9tYWluLg0KPiA+ICsNCj4gPiArICBy
ZWctbmFtZXM6DQo+ID4gKyAgICBpdGVtczoNCj4gPiArICAgICAgLSBjb25zdDogImZyZXEtZG9t
YWluMCINCj4gPiArICAgICAgLSBjb25zdDogImZyZXEtZG9tYWluMSINCj4gPiArICAgIGRlc2Ny
aXB0aW9uOiB8DQo+ID4gKyAgICAgIEZyZXF1ZW5jeSBkb21haW4gbmFtZS4gaS5lLg0KPiA+ICsg
ICAgICAiZnJlcS1kb21haW4wIiwgImZyZXEtZG9tYWluMSIuDQo+ID4gKw0KPiA+ICsgICIjZnJl
cS1kb21haW4tY2VsbHMiOg0KPiA+ICsgICAgY29uc3Q6IDENCj4gPiArICAgIGRlc2NyaXB0aW9u
OiB8DQo+ID4gKyAgICAgIE51bWJlciBvZiBjZWxscyBpbiBhIGZyZXFlbmN5IGRvbWFpbiBzcGVj
aWZpZXIuDQo+ID4gKw0KPiA+ICsgIG10ay1mcmVxLWRvbWFpbjoNCj4gPiArICAgIG1heEl0ZW1z
OiAxDQo+ID4gKyAgICBkZXNjcmlwdGlvbjogfA0KPiA+ICsgICAgICBEZWZpbmUgdGhpcyBjcHUg
YmVsb25ncyB0byB3aGljaCBmcmVxdWVuY3kgZG9tYWluLiBpLmUuDQo+ID4gKyAgICAgIGNwdTAt
MyBiZWxvbmcgdG8gZnJlcXVlbmN5IGRvbWFpbjAsDQo+ID4gKyAgICAgIGNwdTQtNiBiZWxvbmcg
dG8gZnJlcXVlbmN5IGRvbWFpbjEuDQo+ID4gKw0KPiA+ICtyZXF1aXJlZDoNCj4gPiArICAtIGNv
bXBhdGlibGUNCj4gPiArICAtIHJlZw0KPiA+ICsgIC0gcmVnLW5hbWVzDQo+ID4gKyAgLSAiI2Zy
ZXEtZG9tYWluLWNlbGxzIg0KPiA+ICsNCj4gPiArZXhhbXBsZXM6DQo+ID4gKyAgLSB8DQo+ID4g
KyAgICBjcHVzIHsNCj4gPiArICAgICAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ID4g
KyAgICAgICAgICAgICNzaXplLWNlbGxzID0gPDA+Ow0KPiA+ICsNCj4gPiArICAgICAgICAgICAg
Y3B1MDogY3B1QDAgew0KPiA+ICsgICAgICAgICAgICAgICAgZGV2aWNlX3R5cGUgPSAiY3B1IjsN
Cj4gPiArICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiYXJtLGNvcnRleC1hNTUiOw0KPiA+
ICsgICAgICAgICAgICAgICAgZW5hYmxlLW1ldGhvZCA9ICJwc2NpIjsNCj4gPiArICAgICAgICAg
ICAgICAgIG10ay1mcmVxLWRvbWFpbiA9IDwmY3B1ZnJlcV9odyAwPjsNCj4gPiArICAgICAgICAg
ICAgICAgIHJlZyA9IDwweDAwMD47DQo+ID4gKyAgICAgICAgICAgIH07DQo+ID4gKw0KPiA+ICsg
ICAgICAgICAgICBjcHUxOiBjcHVAMSB7DQo+ID4gKyAgICAgICAgICAgICAgICBkZXZpY2VfdHlw
ZSA9ICJjcHUiOw0KPiA+ICsgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJhcm0sY29ydGV4
LWE1NSI7DQo+ID4gKyAgICAgICAgICAgICAgICBlbmFibGUtbWV0aG9kID0gInBzY2kiOw0KPiA+
ICsgICAgICAgICAgICAgICAgbXRrLWZyZXEtZG9tYWluID0gPCZjcHVmcmVxX2h3IDA+Ow0KPiA+
ICsgICAgICAgICAgICAgICAgcmVnID0gPDB4MTAwPjsNCj4gPiArICAgICAgICAgICAgfTsNCj4g
PiArDQo+ID4gKyAgICAgICAgICAgIGNwdTI6IGNwdUAyIHsNCj4gPiArICAgICAgICAgICAgICAg
IGRldmljZV90eXBlID0gImNwdSI7DQo+ID4gKyAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0g
ImFybSxjb3J0ZXgtYTU1IjsNCj4gPiArICAgICAgICAgICAgICAgIGVuYWJsZS1tZXRob2QgPSAi
cHNjaSI7DQo+ID4gKyAgICAgICAgICAgICAgICBtdGstZnJlcS1kb21haW4gPSA8JmNwdWZyZXFf
aHcgMD47DQo+ID4gKyAgICAgICAgICAgICAgICByZWcgPSA8MHgyMDA+Ow0KPiA+ICsgICAgICAg
ICAgICB9Ow0KPiA+ICsNCj4gPiArICAgICAgICAgICAgY3B1MzogY3B1QDMgew0KPiA+ICsgICAg
ICAgICAgICAgICAgZGV2aWNlX3R5cGUgPSAiY3B1IjsNCj4gPiArICAgICAgICAgICAgICAgIGNv
bXBhdGlibGUgPSAiYXJtLGNvcnRleC1hNTUiOw0KPiA+ICsgICAgICAgICAgICAgICAgZW5hYmxl
LW1ldGhvZCA9ICJwc2NpIjsNCj4gPiArICAgICAgICAgICAgICAgIG10ay1mcmVxLWRvbWFpbiA9
IDwmY3B1ZnJlcV9odyAwPjsNCj4gPiArICAgICAgICAgICAgICAgIHJlZyA9IDwweDMwMD47DQo+
ID4gKyAgICAgICAgICAgIH07DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICBjcHU0OiBjcHVANCB7
DQo+ID4gKyAgICAgICAgICAgICAgICBkZXZpY2VfdHlwZSA9ICJjcHUiOw0KPiA+ICsgICAgICAg
ICAgICAgICAgY29tcGF0aWJsZSA9ICJhcm0sY29ydGV4LWE1NSI7DQo+ID4gKyAgICAgICAgICAg
ICAgICBlbmFibGUtbWV0aG9kID0gInBzY2kiOw0KPiA+ICsgICAgICAgICAgICAgICAgbXRrLWZy
ZXEtZG9tYWluID0gPCZjcHVmcmVxX2h3IDE+Ow0KPiA+ICsgICAgICAgICAgICAgICAgcmVnID0g
PDB4NDAwPjsNCj4gPiArICAgICAgICAgICAgfTsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgIGNw
dTU6IGNwdUA1IHsNCj4gPiArICAgICAgICAgICAgICAgIGRldmljZV90eXBlID0gImNwdSI7DQo+
ID4gKyAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gImFybSxjb3J0ZXgtYTU1IjsNCj4gPiAr
ICAgICAgICAgICAgICAgIGVuYWJsZS1tZXRob2QgPSAicHNjaSI7DQo+ID4gKyAgICAgICAgICAg
ICAgICBtdGstZnJlcS1kb21haW4gPSA8JmNwdWZyZXFfaHcgMT47DQo+ID4gKyAgICAgICAgICAg
ICAgICByZWcgPSA8MHg1MDA+Ow0KPiA+ICsgICAgICAgICAgICB9Ow0KPiA+ICsNCj4gPiArICAg
ICAgICAgICAgY3B1NjogY3B1QDYgew0KPiA+ICsgICAgICAgICAgICAgICAgZGV2aWNlX3R5cGUg
PSAiY3B1IjsNCj4gPiArICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiYXJtLGNvcnRleC1h
NzUiOw0KPiA+ICsgICAgICAgICAgICAgICAgZW5hYmxlLW1ldGhvZCA9ICJwc2NpIjsNCj4gPiAr
ICAgICAgICAgICAgICAgIG10ay1mcmVxLWRvbWFpbiA9IDwmY3B1ZnJlcV9odyAxPjsNCj4gPiAr
ICAgICAgICAgICAgICAgIHJlZyA9IDwweDYwMD47DQo+ID4gKyAgICAgICAgICAgIH07DQo+ID4g
Kw0KPiA+ICsgICAgICAgICAgICBjcHU3OiBjcHVANyB7DQo+ID4gKyAgICAgICAgICAgICAgICBk
ZXZpY2VfdHlwZSA9ICJjcHUiOw0KPiA+ICsgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJh
cm0sY29ydGV4LWE3NSI7DQo+ID4gKyAgICAgICAgICAgICAgICBlbmFibGUtbWV0aG9kID0gInBz
Y2kiOw0KPiA+ICsgICAgICAgICAgICAgICAgbXRrLWZyZXEtZG9tYWluID0gPCZjcHVmcmVxX2h3
IDE+Ow0KPiA+ICsgICAgICAgICAgICAgICAgcmVnID0gPDB4NzAwPjsNCj4gPiArICAgICAgICAg
ICAgfTsNCj4gPiArICAgIH07DQo+ID4gKw0KPiA+ICsgICAgLyogLi4uICovDQo+ID4gKw0KPiA+
ICsgICAgc29jIHsNCj4gPiArICAgICAgICAjYWRkcmVzcy1jZWxscyA9IDwyPjsNCj4gPiArICAg
ICAgICAjc2l6ZS1jZWxscyA9IDwyPjsNCj4gPiArDQo+ID4gKyAgICAgICAgY3B1ZnJlcV9odzog
Y3B1ZnJlcUAxMWJjMDAgew0KPiA+ICsgICAgICAgICAgICBjb21wYXRpYmxlID0gIm1lZGlhdGVr
LGNwdWZyZXEtaHciOw0KPiA+ICsgICAgICAgICAgICByZWcgPSA8MCAweDExYmMxMCAwIDB4OGM+
LA0KPiA+ICsgICAgICAgICAgICAgICA8MCAweDExYmNhMCAwIDB4OGM+Ow0KPiA+ICsgICAgICAg
ICAgICByZWctbmFtZXMgPSAiZnJlcS1kb21haW4wIiwgImZyZXEtZG9tYWluMSI7DQo+ID4gKyAg
ICAgICAgICAgICNmcmVxLWRvbWFpbi1jZWxscyA9IDwxPjsNCj4gPiArICAgICAgICB9Ow0KPiA+
ICsgICAgfTsNCj4gPiArDQo+ID4gKw0KPiA+ICsNCj4gPiArDQo+IA0KPiBJIHdvdWxkIG5lZWQg
QWNrIGZyb20gUm9iIGZvciB0aGlzLg0KPiANCk9LLCB0aGFua3MuDQoNCg==

