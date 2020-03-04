Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F4117178FF0
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2020 12:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387762AbgCDL5h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Mar 2020 06:57:37 -0500
Received: from mga06.intel.com ([134.134.136.31]:45980 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387488AbgCDL5h (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 4 Mar 2020 06:57:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2020 03:57:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,514,1574150400"; 
   d="scan'208";a="243928110"
Received: from pgsmsx107.gar.corp.intel.com ([10.221.44.105])
  by orsmga006.jf.intel.com with ESMTP; 04 Mar 2020 03:57:34 -0800
Received: from pgsmsx102.gar.corp.intel.com ([169.254.6.223]) by
 PGSMSX107.gar.corp.intel.com ([169.254.7.43]) with mapi id 14.03.0439.000;
 Wed, 4 Mar 2020 19:57:33 +0800
From:   "Pan, Harry" <harry.pan@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>, Harry Pan <gs0622@gmail.com>,
        "Jacob Pan" <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3] intel_idle: Add Comet Lake support
Thread-Topic: [PATCH v3] intel_idle: Add Comet Lake support
Thread-Index: AQHV8TuIsnm0plXkJ0qxTNV1fBgP1Kg3rPoAgACovO0=
Date:   Wed, 4 Mar 2020 11:57:33 +0000
Message-ID: <F8C6368A-1537-482B-8FE5-350A18D936A8@intel.com>
References: <20200227013411.1.Ica3bb9fa898499d94e0b0a2bfa08ec46c89d84fa@changeid>
 <20200303170948.1.I108734f38ade020c3e5da825839dca11d2a2ff87@changeid>,<CAJZ5v0j+bx5fh1wv738MNoui_SaZ-c21rDnZkWOqi_GCVg5stQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0j+bx5fh1wv738MNoui_SaZ-c21rDnZkWOqi_GCVg5stQ@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgUmFmYWVsLA0KDQpZZXMsIEkgc2tpcHBlZCBpdCBjb25zaWRlcmluZyB0byBhbGlnbiBDTUwt
VSBWMCBhbmQgQTAgc3RlcHBpbmcgdy8gdGhlIHNhbWUgdGFibGU7IEkgc2VudCB2NCBmb3IgeW91
ciByZXZpZXcuDQoNCkluIHRoZSBvdGhlciBoYW5kLCBJIGFtIHByb3Bvc2luZyB1c2luZyBfQ1NU
IGFzIGxvbmcgdGVybSBwbGFuIGluIENyT1MgZGV2IHRlYW1zLg0KDQoNClNpbmNlcmVseSwNCkhh
cnJ5DQoNCj4gT24gTWFyIDQsIDIwMjAsIGF0IDE3OjUzLCBSYWZhZWwgSi4gV3lzb2NraSA8cmFm
YWVsQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4g77u/T24gVHVlLCBNYXIgMywgMjAyMCBhdCAx
MDoxMCBBTSBIYXJyeSBQYW4gPGhhcnJ5LnBhbkBpbnRlbC5jb20+IHdyb3RlOg0KPj4gDQo+PiBB
ZGQgYSBnZW5lcmFsIEMtc3RhdGUgdGFibGUgaW4gb3JkZXIgdG8gc3VwcG9ydCBDb21ldCBMYWtl
Lg0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBIYXJyeSBQYW4gPGhhcnJ5LnBhbkBpbnRlbC5jb20+
DQo+PiANCj4+IC0tLQ0KPj4gDQo+PiBkcml2ZXJzL2lkbGUvaW50ZWxfaWRsZS5jIHwgNyArKysr
KysrDQo+PiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspDQo+PiANCj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2lkbGUvaW50ZWxfaWRsZS5jIGIvZHJpdmVycy9pZGxlL2ludGVsX2lkbGUu
Yw0KPj4gaW5kZXggZDU1NjA2NjA4YWM4Li4wNWJjZTU5NWZhZmUgMTAwNjQ0DQo+PiAtLS0gYS9k
cml2ZXJzL2lkbGUvaW50ZWxfaWRsZS5jDQo+PiArKysgYi9kcml2ZXJzL2lkbGUvaW50ZWxfaWRs
ZS5jDQo+PiBAQCAtMTA2Nyw2ICsxMDY3LDExIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaWRsZV9j
cHUgaWRsZV9jcHVfZG52ID0gew0KPj4gICAgICAgIC51c2VfYWNwaSA9IHRydWUsDQo+PiB9Ow0K
Pj4gDQo+PiArc3RhdGljIGNvbnN0IHN0cnVjdCBpZGxlX2NwdSBpZGxlX2NwdV9jbWwgPSB7DQo+
PiArICAgICAgIC5zdGF0ZV90YWJsZSA9IHNrbF9jc3RhdGVzLA0KPj4gKyAgICAgICAuZGlzYWJs
ZV9wcm9tb3Rpb25fdG9fYzFlID0gdHJ1ZSwNCj4gDQo+IC51c2VfYWNwaSA9IHRydWUsDQo+IA0K
PiBtaXNzaW5nPyAgT3RoZXJ3aXNlIHlvdSBjYW4ganVzdCB1c2UgaWRsZV9jcHVfc2tsIGFzIGlz
LCBjYW4ndCB5b3U/DQo+IA0KPj4gK307DQo+PiArDQo+PiBzdGF0aWMgY29uc3Qgc3RydWN0IHg4
Nl9jcHVfaWQgaW50ZWxfaWRsZV9pZHNbXSBfX2luaXRjb25zdCA9IHsNCj4+ICAgICAgICBJTlRF
TF9DUFVfRkFNNihORUhBTEVNX0VQLCAgICAgICAgICAgICAgaWRsZV9jcHVfbmh4KSwNCj4+ICAg
ICAgICBJTlRFTF9DUFVfRkFNNihORUhBTEVNLCAgICAgICAgICAgICAgICAgaWRsZV9jcHVfbmVo
YWxlbSksDQo+PiBAQCAtMTEwNSw2ICsxMTEwLDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB4ODZf
Y3B1X2lkIGludGVsX2lkbGVfaWRzW10gX19pbml0Y29uc3QgPSB7DQo+PiAgICAgICAgSU5URUxf
Q1BVX0ZBTTYoQVRPTV9HT0xETU9OVF9QTFVTLCAgICAgIGlkbGVfY3B1X2J4dCksDQo+PiAgICAg
ICAgSU5URUxfQ1BVX0ZBTTYoQVRPTV9HT0xETU9OVF9ELCAgICAgICAgIGlkbGVfY3B1X2Rudiks
DQo+PiAgICAgICAgSU5URUxfQ1BVX0ZBTTYoQVRPTV9UUkVNT05UX0QsICAgICAgICAgIGlkbGVf
Y3B1X2RudiksDQo+PiArICAgICAgIElOVEVMX0NQVV9GQU02KENPTUVUTEFLRV9MLCAgICAgICAg
ICAgICBpZGxlX2NwdV9jbWwpLA0KPj4gKyAgICAgICBJTlRFTF9DUFVfRkFNNihDT01FVExBS0Us
ICAgICAgICAgICAgICAgaWRsZV9jcHVfY21sKSwNCj4+ICAgICAgICB7fQ0KPj4gfTsNCj4+IA0K
Pj4gLS0NCj4+IDIuMjQuMQ0KPj4gDQo=
