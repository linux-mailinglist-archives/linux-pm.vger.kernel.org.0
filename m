Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9F6044A791
	for <lists+linux-pm@lfdr.de>; Tue,  9 Nov 2021 08:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243636AbhKIH1H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Nov 2021 02:27:07 -0500
Received: from 113.196.136.162.ll.static.sparqnet.net ([113.196.136.162]:55390
        "EHLO mg.sunplus.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S243606AbhKIH1H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Nov 2021 02:27:07 -0500
X-Greylist: delayed 1553 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Nov 2021 02:27:05 EST
X-MailGates: (compute_score:DELIVER,40,3)
Received: from 172.17.9.202
        by mg01.sunplus.com with MailGates ESMTP Server V5.0(25032:0:AUTH_RELAY)
        (envelope-from <edwin.chiu@sunplus.com>); Tue, 09 Nov 2021 14:58:29 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx01.sunplus.com.tw (172.17.9.202) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Tue, 9 Nov 2021 14:58:24 +0800
Received: from sphcmbx02.sunplus.com.tw ([::1]) by sphcmbx02.sunplus.com.tw
 ([fe80::f8bb:bd77:a854:5b9e%14]) with mapi id 15.00.1497.023; Tue, 9 Nov 2021
 14:58:24 +0800
From:   =?big5?B?RWR3aW4gQ2hpdSCq9KurrnA=?= <edwin.chiu@sunplus.com>
To:     Rob Herring <robh@kernel.org>,
        Edwin chiu <edwinchiu0505tw@gmail.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH 1/2] dt-bingings:arm:sunplus:add sp7021 compatible string
 to sunplus,idle-state.yaml
Thread-Topic: [PATCH 1/2] dt-bingings:arm:sunplus:add sp7021 compatible string
 to sunplus,idle-state.yaml
Thread-Index: AQHX1HPZglWXpubb1Eu7jaA7xfrmEqv5EugAgAGt1mA=
Date:   Tue, 9 Nov 2021 06:58:24 +0000
Message-ID: <d2e1fc4e7913459fbc96d845eb73b87b@sphcmbx02.sunplus.com.tw>
References: <cover.1636356928.git.edwin.chiu@sunplus.com>
 <5d2231d33d647d24d2b95c9f652687f7f1dccd2d.1636356928.git.edwin.chiu@sunplus.com>
 <1636376582.101053.3181499.nullmailer@robh.at.kernel.org>
In-Reply-To: <1636376582.101053.3181499.nullmailer@robh.at.kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.25.108.40]
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgUm9iOg0KDQpMb29rIGludG8gdGhlIGZ1bGwgbG9nLCBpdCBzaG93IHlvdSBjaGVjayAzIHBy
b2dyYW1zDQp+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQpDb250ZXh0CUNoZWNrCURl
c2NyaXB0aW9uDQpyb2JoL2NoZWNrcGF0Y2gJd2FybmluZwl0b3RhbDogMCBlcnJvcnMsIDEgd2Fy
bmluZ3MsIDY3IGxpbmVzIGNoZWNrZWQNCnJvYmgvZHQtbWV0YS1zY2hlbWEJc3VjY2VzcwkNCnJv
YmgvZHRicy1jaGVjawlmYWlsCWJ1aWxkIGxvZw0Kfn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn4NCg0KMSkgVGhlIGNoZWNrcGF0Y2ggd2FybmluZyBpcyBXQVJOSU5HOiBGcm9tOi9TaWdu
ZWQtb2ZmLWJ5OiBlbWFpbCBhZGRyZXNzIG1pc21hdGNoOiAnRnJvbTogRWR3aW4gY2hpdSA8ZWR3
aW5jaGl1MDUwNXR3QGdtYWlsLmNvbT4nICE9ICdTaWduZWQtb2ZmLWJ5OiBFZHdpbiBjaGl1IDxl
ZHdpbi5jaGl1QHN1bnBsdXMuY29tPicNCj09PiBJIHdhbnQgZXhwbGFpbiB0byB5b3UgdGhhdCA8
ZWR3aW4uY2hpdUBzdW5wbHVzLmNvbT4gaXMgbXkgZW1haWwgaW4gdGhlIGNvbXBhbnksIGJ1dCBp
dCBkaXNhZ3JlZSBvcGVyYXRlIGJ5ICJnaXQgc2VuZC1lbWFpbCIuDQogICAgU28gSSB1c2VkIDxl
ZHdpbmNoaXUwNTA1dHdAZ21haWwuY29tPiBpbiBteSBsaW51eCBzeXN0ZW0gdG8gb3BlcmF0ZSB3
aXRoICJnaXQgc2VuZC1lbWFpbCIuDQogICBBY3R1YWxseSBJIGNoZWNrcGF0Y2ggaW4gbXkgc2lk
ZSB3YXMgMCBlcnJvciAwIHdhcm5pbmcuDQoNCjIpIFJlZ2FyZGluZyB0byBkdGJzLWNoZWNrIGlz
c3VlLCB5b3VyIGxpc3Qgd2FybmluZ3MgcmVsYXRlZCB0byBvdGhlcnMgY29tcGFueSdzIHlhbWwg
ZmlsZSwgaXQgbm90IG15IHlhbWwgZmlsZSBjYXNlLiANCiAgIFdoYXQgaXMgdGhlIHB1cnBvc2Ug
eW91IHdhbnQ/IE9yIHdoYXQgc2hvdWxkIEkgZG8/DQoNCjMpIEV4ZWN1dGU9Pm1ha2UgZHRic19j
aGVjayBEVF9TQ0hFTUFfRklMRVM9RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Fy
bS9zdW5wbHVzL3N1bnBsdXMsaWRsZS1zdGF0ZS55YW1sDQpUaGVyZSBhcmUgbWFueSBjb25maWcg
c2VsZWN0IGl0ZW1zoUsuLkkgZG9uJ3Qga25vdyBob3cgdG8gc2VsZWN0IHRoZW0uDQooSSBleGVj
dXRlICJtYWtlIGNvbmZpZyAiIGFuZCAibWFrZSBhbGwiIHdlcmUgcGFzcykNCkNhbiB5b3UgdGVh
Y2ggbWUgaG93IHRvIGRvICJtYWtlIGR0YnNfY2hlY2siPw0KDQqq9KurrnAgRWR3aW5DaGl1DQq0
vK/guUK64rFNrtcNClQ6ICs4ODYtMy01Nzg2MDA1IGV4dC4yNTkwDQplZHdpbi5jaGl1QHN1bnBs
dXMuY29tDQozMDAgt3Omy6zsvse26bDPs9C3c6RAuPQxObi5DQoNCi0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQpGcm9tOiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPiANClNlbnQ6IE1v
bmRheSwgTm92ZW1iZXIgOCwgMjAyMSA5OjAzIFBNDQpUbzogRWR3aW4gY2hpdSA8ZWR3aW5jaGl1
MDUwNXR3QGdtYWlsLmNvbT4NCkNjOiByb2JoK2R0QGtlcm5lbC5vcmc7IGRhbmllbC5sZXpjYW5v
QGxpbmFyby5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyByYWZhZWxAa2VybmVsLm9yZzsgbGludXgtcG1Admdlci5rZXJuZWwub3Jn
OyBFZHdpbiBDaGl1IKr0q6uucCA8ZWR3aW4uY2hpdUBzdW5wbHVzLmNvbT4NClN1YmplY3Q6IFJl
OiBbUEFUQ0ggMS8yXSBkdC1iaW5naW5nczphcm06c3VucGx1czphZGQgc3A3MDIxIGNvbXBhdGli
bGUgc3RyaW5nIHRvIHN1bnBsdXMsaWRsZS1zdGF0ZS55YW1sDQoNCk9uIE1vbiwgMDggTm92IDIw
MjEgMTU6NTU6MDkgKzA4MDAsIEVkd2luIGNoaXUgd3JvdGU6DQo+IEFkZCB0aGUgY29tcGF0aWJs
ZSBzdHJpbmcgZm9yIGNwdWlkbGUgc3RhdGUgb24gc3A3MDIxDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBFZHdpbiBjaGl1IDxlZHdpbi5jaGl1QHN1bnBsdXMuY29tPg0KPiAtLS0NCj4gIC4uLi9iaW5k
aW5ncy9hcm0vc3VucGx1cy9zdW5wbHVzLGlkbGUtc3RhdGUueWFtbCAgIHwgNTUgKysrKysrKysr
KysrKysrKysrKysrKw0KPiAgTUFJTlRBSU5FUlMgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfCAgNiArKysNCj4gIDIgZmlsZXMgY2hhbmdlZCwgNjEgaW5zZXJ0aW9ucygr
KQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IA0KPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvYXJtL3N1bnBsdXMvc3VucGx1cyxpZGxlLXN0YXRlLnlhbWwNCj4gDQoNClJ1bm5pbmcg
J21ha2UgZHRic19jaGVjaycgd2l0aCB0aGUgc2NoZW1hIGluIHRoaXMgcGF0Y2ggZ2l2ZXMgdGhl
IGZvbGxvd2luZyB3YXJuaW5ncy4gQ29uc2lkZXIgaWYgdGhleSBhcmUgZXhwZWN0ZWQgb3IgdGhl
IHNjaGVtYSBpcyBpbmNvcnJlY3QuIFRoZXNlIG1heSBub3QgYmUgbmV3IHdhcm5pbmdzLg0KDQpO
b3RlIHRoYXQgaXQgaXMgbm90IHlldCBhIHJlcXVpcmVtZW50IHRvIGhhdmUgMCB3YXJuaW5ncyBm
b3IgZHRic19jaGVjay4NClRoaXMgd2lsbCBjaGFuZ2UgaW4gdGhlIGZ1dHVyZS4NCg0KRnVsbCBs
b2cgaXMgYXZhaWxhYmxlIGhlcmU6IGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcGF0Y2gv
MTU1MjIyOA0KDQoNCnNwYzogY29tcGF0aWJsZTowOiAnYXJtLGlkbGUtc3RhdGUnIHdhcyBleHBl
Y3RlZA0KCWFyY2gvYXJtL2Jvb3QvZHRzL3Fjb20tYXBxODA2NC1hc3VzLW5leHVzNy1mbG8uZHQu
eWFtbA0KCWFyY2gvYXJtL2Jvb3QvZHRzL3Fjb20tYXBxODA2NC1jbS1xczYwMC5kdC55YW1sDQoJ
YXJjaC9hcm0vYm9vdC9kdHMvcWNvbS1hcHE4MDY0LWlmYzY0MTAuZHQueWFtbA0KCWFyY2gvYXJt
L2Jvb3QvZHRzL3Fjb20tYXBxODA2NC1zb255LXhwZXJpYS15dWdhLmR0LnlhbWwNCglhcmNoL2Fy
bS9ib290L2R0cy9xY29tLWFwcTgwNzQtZHJhZ29uYm9hcmQuZHQueWFtbA0KCWFyY2gvYXJtL2Jv
b3QvZHRzL3Fjb20tYXBxODA4NC1pZmM2NTQwLmR0LnlhbWwNCglhcmNoL2FybS9ib290L2R0cy9x
Y29tLWFwcTgwODQtbXRwLmR0LnlhbWwNCglhcmNoL2FybS9ib290L2R0cy9xY29tLW1zbTg5NzQt
ZmFpcnBob25lLWZwMi5kdC55YW1sDQoJYXJjaC9hcm0vYm9vdC9kdHMvcWNvbS1tc204OTc0LWxn
ZS1uZXh1czUtaGFtbWVyaGVhZC5kdC55YW1sDQoJYXJjaC9hcm0vYm9vdC9kdHMvcWNvbS1tc204
OTc0LXNhbXN1bmcta2x0ZS5kdC55YW1sDQoJYXJjaC9hcm0vYm9vdC9kdHMvcWNvbS1tc204OTc0
LXNvbnkteHBlcmlhLWFtYW1pLmR0LnlhbWwNCglhcmNoL2FybS9ib290L2R0cy9xY29tLW1zbTg5
NzQtc29ueS14cGVyaWEtY2FzdG9yLmR0LnlhbWwNCglhcmNoL2FybS9ib290L2R0cy9xY29tLW1z
bTg5NzQtc29ueS14cGVyaWEtaG9uYW1pLmR0LnlhbWwNCg0Kc3BjOiBjb21wYXRpYmxlOiBBZGRp
dGlvbmFsIGl0ZW1zIGFyZSBub3QgYWxsb3dlZCAoJ2FybSxpZGxlLXN0YXRlJyB3YXMgdW5leHBl
Y3RlZCkNCglhcmNoL2FybS9ib290L2R0cy9xY29tLWFwcTgwNjQtYXN1cy1uZXh1czctZmxvLmR0
LnlhbWwNCglhcmNoL2FybS9ib290L2R0cy9xY29tLWFwcTgwNjQtY20tcXM2MDAuZHQueWFtbA0K
CWFyY2gvYXJtL2Jvb3QvZHRzL3Fjb20tYXBxODA2NC1pZmM2NDEwLmR0LnlhbWwNCglhcmNoL2Fy
bS9ib290L2R0cy9xY29tLWFwcTgwNjQtc29ueS14cGVyaWEteXVnYS5kdC55YW1sDQoJYXJjaC9h
cm0vYm9vdC9kdHMvcWNvbS1hcHE4MDc0LWRyYWdvbmJvYXJkLmR0LnlhbWwNCglhcmNoL2FybS9i
b290L2R0cy9xY29tLWFwcTgwODQtaWZjNjU0MC5kdC55YW1sDQoJYXJjaC9hcm0vYm9vdC9kdHMv
cWNvbS1hcHE4MDg0LW10cC5kdC55YW1sDQoJYXJjaC9hcm0vYm9vdC9kdHMvcWNvbS1tc204OTc0
LWZhaXJwaG9uZS1mcDIuZHQueWFtbA0KCWFyY2gvYXJtL2Jvb3QvZHRzL3Fjb20tbXNtODk3NC1s
Z2UtbmV4dXM1LWhhbW1lcmhlYWQuZHQueWFtbA0KCWFyY2gvYXJtL2Jvb3QvZHRzL3Fjb20tbXNt
ODk3NC1zYW1zdW5nLWtsdGUuZHQueWFtbA0KCWFyY2gvYXJtL2Jvb3QvZHRzL3Fjb20tbXNtODk3
NC1zb255LXhwZXJpYS1hbWFtaS5kdC55YW1sDQoJYXJjaC9hcm0vYm9vdC9kdHMvcWNvbS1tc204
OTc0LXNvbnkteHBlcmlhLWNhc3Rvci5kdC55YW1sDQoJYXJjaC9hcm0vYm9vdC9kdHMvcWNvbS1t
c204OTc0LXNvbnkteHBlcmlhLWhvbmFtaS5kdC55YW1sDQoNCnNwYzogY29tcGF0aWJsZTogWydx
Y29tLGlkbGUtc3RhdGUtc3BjJywgJ2FybSxpZGxlLXN0YXRlJ10gaXMgdG9vIGxvbmcNCglhcmNo
L2FybS9ib290L2R0cy9xY29tLWFwcTgwNjQtYXN1cy1uZXh1czctZmxvLmR0LnlhbWwNCglhcmNo
L2FybS9ib290L2R0cy9xY29tLWFwcTgwNjQtY20tcXM2MDAuZHQueWFtbA0KCWFyY2gvYXJtL2Jv
b3QvZHRzL3Fjb20tYXBxODA2NC1pZmM2NDEwLmR0LnlhbWwNCglhcmNoL2FybS9ib290L2R0cy9x
Y29tLWFwcTgwNjQtc29ueS14cGVyaWEteXVnYS5kdC55YW1sDQoJYXJjaC9hcm0vYm9vdC9kdHMv
cWNvbS1hcHE4MDc0LWRyYWdvbmJvYXJkLmR0LnlhbWwNCglhcmNoL2FybS9ib290L2R0cy9xY29t
LWFwcTgwODQtaWZjNjU0MC5kdC55YW1sDQoJYXJjaC9hcm0vYm9vdC9kdHMvcWNvbS1hcHE4MDg0
LW10cC5kdC55YW1sDQoJYXJjaC9hcm0vYm9vdC9kdHMvcWNvbS1tc204OTc0LWZhaXJwaG9uZS1m
cDIuZHQueWFtbA0KCWFyY2gvYXJtL2Jvb3QvZHRzL3Fjb20tbXNtODk3NC1sZ2UtbmV4dXM1LWhh
bW1lcmhlYWQuZHQueWFtbA0KCWFyY2gvYXJtL2Jvb3QvZHRzL3Fjb20tbXNtODk3NC1zYW1zdW5n
LWtsdGUuZHQueWFtbA0KCWFyY2gvYXJtL2Jvb3QvZHRzL3Fjb20tbXNtODk3NC1zb255LXhwZXJp
YS1hbWFtaS5kdC55YW1sDQoJYXJjaC9hcm0vYm9vdC9kdHMvcWNvbS1tc204OTc0LXNvbnkteHBl
cmlhLWNhc3Rvci5kdC55YW1sDQoJYXJjaC9hcm0vYm9vdC9kdHMvcWNvbS1tc204OTc0LXNvbnkt
eHBlcmlhLWhvbmFtaS5kdC55YW1sDQoNCg==
