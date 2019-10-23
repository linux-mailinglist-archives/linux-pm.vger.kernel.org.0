Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A773E2277
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2019 20:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388300AbfJWS0R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Oct 2019 14:26:17 -0400
Received: from mga03.intel.com ([134.134.136.65]:15020 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732810AbfJWS0Q (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 23 Oct 2019 14:26:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 11:26:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,221,1569308400"; 
   d="scan'208";a="210121302"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga002.jf.intel.com with ESMTP; 23 Oct 2019 11:26:15 -0700
Received: from fmsmsx114.amr.corp.intel.com (10.18.116.8) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 23 Oct 2019 11:26:15 -0700
Received: from crsmsx102.amr.corp.intel.com (172.18.63.137) by
 FMSMSX114.amr.corp.intel.com (10.18.116.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 23 Oct 2019 11:26:15 -0700
Received: from crsmsx104.amr.corp.intel.com ([169.254.6.181]) by
 CRSMSX102.amr.corp.intel.com ([169.254.2.18]) with mapi id 14.03.0439.000;
 Wed, 23 Oct 2019 12:26:13 -0600
From:   "Hernandez Lopez, Fabiola" <fabiola.hernandez.lopez@intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: Frequency not returning to fixed value after AVX workload
Thread-Topic: Frequency not returning to fixed value after AVX workload
Thread-Index: AdWAW7g0RYwhbvwkQrq2viRm3SLyeQCSpKyAAAtq94AADPq1gAGx0Kww
Date:   Wed, 23 Oct 2019 18:26:12 +0000
Message-ID: <67737C20FC7E4D44B44817ABFA5B1DCE6EC0331D@CRSMSX104.amr.corp.intel.com>
References: <67737C20FC7E4D44B44817ABFA5B1DCE6EC01C77@CRSMSX104.amr.corp.intel.com>
         <3340378.NBreQbsDsf@kreacher>
         <67737C20FC7E4D44B44817ABFA5B1DCE6EC020E9@CRSMSX104.amr.corp.intel.com>
 <e7e89cd85fb5d367338491651b36cc912967edab.camel@linux.intel.com>
In-Reply-To: <e7e89cd85fb5d367338491651b36cc912967edab.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYzk2Zjc3NzEtZDcxMC00MDY3LTkyMGQtZTY2OWRmNWYxMzEwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiSkhuZXh5M045dEdZeVB5M2dQRUM0XC9yeDNFQTE0eUg0XC9zeG9qblA4VDdLc3QwNytkNkNBc3JlcmRKaXZPVUdGIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [172.18.205.10]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

VGhhbmtzLCBvdXIgZW5naW5lZXIgaXMgdHJ5aW5nIHRvIGNvbGxlY3QgdGhlIGluZm8uDQpJJ2xs
IHdyaXRlIGJhY2sgd2l0aCB0aGUgZGF0YS4gDQoNCkZhYmlvbGENCi0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQpGcm9tOiBTcmluaXZhcyBQYW5kcnV2YWRhIFttYWlsdG86c3Jpbml2YXMucGFu
ZHJ1dmFkYUBsaW51eC5pbnRlbC5jb21dIA0KU2VudDogTW9uZGF5LCBPY3RvYmVyIDE0LCAyMDE5
IDQ6MjMgUE0NClRvOiBIZXJuYW5kZXogTG9wZXosIEZhYmlvbGEgPGZhYmlvbGEuaGVybmFuZGV6
LmxvcGV6QGludGVsLmNvbT47IFJhZmFlbCBKLiBXeXNvY2tpIDxyandAcmp3eXNvY2tpLm5ldD4N
CkNjOiBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFJlOiBGcmVxdWVuY3kgbm90
IHJldHVybmluZyB0byBmaXhlZCB2YWx1ZSBhZnRlciBBVlggd29ya2xvYWQNCg0KT24gTW9uLCAy
MDE5LTEwLTE0IGF0IDIxOjExICswMDAwLCBIZXJuYW5kZXogTG9wZXosIEZhYmlvbGEgd3JvdGU6
DQo+IEhvdyBkbyB5b3UgbWVhc3VyZSB0aGUgZnJlcXVlbmN5Pw0KRG8gd2hhdGV2ZXIgeW91IGFy
ZSBkb2luZyB0byBnZXQgdG8geW91ciBwcm9ibGVtIHN0YXRlIGFuZCB3aGlsZSBkb2luZyB0aGUg
dGVzdCBydW4gaW4gYW5vdGhlciB3aW5kb3c6DQoNCiN0dXJib3N0YXQNCg0KQXR0YWNoIHRoZSBv
dXRwdXQuDQoNClRoYW5rcywNClNyaW5pdmFzDQoNCj4gV2l0aCBsc2NwdS4NCj4gDQo+IFdoYXQg
ZXhhY3RseSBkbyB5b3UgZG8gdG8gZ2V0IHRoZSBleHBlY3RlZCBmcmVxdWVuY3kgYmFjaz8NCj4g
QSBzY3JpcHQgaXMgdXNlZCB0aGF0IHNldHMgdGhlIGZyZXF1ZW5jeSB3aXRoIA0KPiAvc3lzL2Rl
dmljZXMvc3lzdGVtL2NwdS9jcHUqL2NwdWZyZXEvc2NhbGluZ19zZXRzcGVlZA0KPiANCj4gSXMg
dGhlIHRhcmdldCBmcmVxdWVuY3kgaW4gdGhlIHR1cmJvIHJhbmdlPw0KPiBObywgdGhlIHRhcmdl
dCBmcmVxdWVuY3kgaXMgdGhlIHNhbWUgYXMgdGhlIGJhc2UgcHJvY2Vzc29yIGZyZXF1ZW5jeToN
Cj4gMi40R0h6LiBUaGUgbWF4IHR1cmJvIGZyZXF1ZW5jeSBmb3IgdGhpcyBDUFUgc2kgMy45IEdI
ei4NCj4gVGhpcyBoYXMgYmVlbiB0ZXN0ZWQgd2l0aCB0dXJibyBib29zdCBlbmFibGVkIGFuZCBk
aXNhYmxlZC4gDQo+IA0KPiBUaGlzIGJlaGF2aW9yIGlzIHZlcnkgc3BvcmFkaWM6IDwgMTAlDQo+
IA0KPiBUaGFua3MsDQo+IEZhYmlvbGENCj4gDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IFJhZmFlbCBKLiBXeXNvY2tpIFttYWlsdG86cmp3QHJqd3lzb2NraS5uZXRdDQo+
IFNlbnQ6IE1vbmRheSwgT2N0b2JlciAxNCwgMjAxOSA0OjQ1IEFNDQo+IFRvOiBIZXJuYW5kZXog
TG9wZXosIEZhYmlvbGEgPGZhYmlvbGEuaGVybmFuZGV6LmxvcGV6QGludGVsLmNvbT4NCj4gQ2M6
IGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZzsgU3Jpbml2YXMgUGFuZHJ1dmFkYSA8IA0KPiBzcmlu
aXZhcy5wYW5kcnV2YWRhQGxpbnV4LmludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IEZyZXF1ZW5j
eSBub3QgcmV0dXJuaW5nIHRvIGZpeGVkIHZhbHVlIGFmdGVyIEFWWCB3b3JrbG9hZA0KPiANCj4g
T24gRnJpZGF5LCBPY3RvYmVyIDExLCAyMDE5IDc6NDU6NTUgUE0gQ0VTVCBIZXJuYW5kZXogTG9w
ZXosIEZhYmlvbGENCj4gd3JvdGU6DQo+ID4gSGksDQo+ID4gDQo+ID4gV2UgYXJlIHNlZWluZyBh
biB1bmV4cGVjdGVkIGJlaGF2aW9yIGFmdGVyIGFwcGx5aW5nIEFWWCB3b3JrbG9hZHMuIA0KPiA+
IEFmdGVyIHNldHRpbmcgdGhlIENQVSBmcmVxdWVuY3kgdG8gYSBmaXhlZCB2YWx1ZSB3aXRoIENQ
VSBGcmVxIC0gDQo+ID4gdXNlcnNwYWNlIGdvdmVybm9yIGFuZCBhcHBseWluZyBoZWF2eSBBVlgg
d29ya2xvYWRzLCB0aGUgQ1BVIA0KPiA+IGZyZXF1ZW5jeSBpcyBkZWNyZWFzZWQgKGFzIGV4cGVj
dGVkKSBidXQgaXQgbmV2ZXIgcmV0dXJucyB0byB0aGUgDQo+ID4gcHJldmlvdXNseSBlc3RhYmxp
c2hlZCB2YWx1ZS4NCj4gDQo+IEhvdyBkbyB5b3UgbWVhc3VyZSB0aGUgZnJlcXVlbmN5Pw0KPiAN
Cj4gPiBUaGlzIGRvZXMgbm90IGhhcHBlbiBvbiBhbGwgY29yZXMsIG9ubHkgb24gYSBzaW5nbGUg
Y29yZS4gVGhlIG9ubHkgDQo+ID4gd2F5IHRvIHJldHVybiB0byB0aGUgZGVzaXJlZCBmcmVxdWVu
Y3kgaXMgYnkgc2V0dGluZyBpdCB0aHJvdWdoIHRoZSANCj4gPiBjb21tYW5kIGxpbmUgYWdhaW4u
DQo+IA0KPiBXaGF0IGV4YWN0bHkgZG8geW91IGRvIHRvIGdldCB0aGUgZXhwZWN0ZWQgZnJlcXVl
bmN5IGJhY2s/DQo+IA0KPiA+IFdlIGFyZSB3b25kZXJpbmcgaG93IGNhbiB0aGlzIGNoYW5nZSBp
biBmcmVxdWVuY3kgaGFwcGVuLg0KPiANCj4gSXMgdGhlIHRhcmdldCBmcmVxdWVuY3kgaW4gdGhl
IHR1cmJvIHJhbmdlPw0KPiANCj4gDQo+IA0KDQo=
