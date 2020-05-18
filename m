Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36401D8B8D
	for <lists+linux-pm@lfdr.de>; Tue, 19 May 2020 01:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgERXSp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 May 2020 19:18:45 -0400
Received: from mga02.intel.com ([134.134.136.20]:63511 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbgERXSp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 18 May 2020 19:18:45 -0400
IronPort-SDR: egJM9zmtnthl3ATufuJeAwNQySEUMIaKy/oEijCgoBqw0lIcjJihwn5FSP/A2+ZMfKV1tPEAV9
 QFwdcypBUFog==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 16:18:44 -0700
IronPort-SDR: Xjg526Miz+IIQyVggFQWQ9ClqlyRDxF/pLSut31uKcMhl63GMsraga93H8R8UO1t5iZTbOkUAa
 NpUDdeDloM9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,408,1583222400"; 
   d="scan'208";a="253196985"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by fmsmga007.fm.intel.com with ESMTP; 18 May 2020 16:18:44 -0700
Received: from orsmsx151.amr.corp.intel.com (10.22.226.38) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 18 May 2020 16:18:43 -0700
Received: from orsmsx109.amr.corp.intel.com ([169.254.11.125]) by
 ORSMSX151.amr.corp.intel.com ([169.254.7.2]) with mapi id 14.03.0439.000;
 Mon, 18 May 2020 16:18:43 -0700
From:   "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To:     "matthewgarrett@google.com" <matthewgarrett@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Zhang, Rui" <rui.zhang@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Aram, Nisha" <nisha.aram@intel.com>,
        "mjg59@google.com" <mjg59@google.com>
Subject: Re: [PATCH V2 3/3] thermal/int340x_thermal: Don't require IDSP to
 exist
Thread-Topic: [PATCH V2 3/3] thermal/int340x_thermal: Don't require IDSP to
 exist
Thread-Index: AQHWLWqri/jtlcLBNkKZtLREsqDGsw==
Date:   Mon, 18 May 2020 23:18:42 +0000
Message-ID: <78cacff7bd332f472cd8ac2d3c658512f81a5cbe.camel@intel.com>
References: <20200414020953.255364-1-matthewgarrett@google.com>
         <20200414020953.255364-3-matthewgarrett@google.com>
In-Reply-To: <20200414020953.255364-3-matthewgarrett@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
x-originating-ip: [10.251.227.7]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4870AE899796404D9210485ACAD1679A@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gTW9uLCAyMDIwLTA0LTEzIGF0IDE5OjA5IC0wNzAwLCBNYXR0aGV3IEdhcnJldHQgd3JvdGU6
DQo+IEZyb206IE1hdHRoZXcgR2FycmV0dCA8bWpnNTlAZ29vZ2xlLmNvbT4NCj4gDQo+IFRoZSBJ
RFNQIG1ldGhvZCBkb2Vzbid0IGFwcGVhciB0byBleGlzdCBvbiB0aGUgbW9zdCByZWNlbnQgSW50
ZWwNCj4gcGxhdGZvcm1zOg0KPiBpbnN0ZWFkLCB0aGUgSURTUCBkYXRhIGlzIGluY2x1ZGVkIGlu
IHRoZSBHRERWIGJsb2IuIFNpbmNlIHdlDQo+IHByb2JhYmx5IGRvbid0DQo+IHdhbnQgdG8gZGVj
b21wcmVzcyBhbmQgcGFyc2UgdGhhdCBpbi1rZXJuZWwsIGp1c3QgYWxsb3cgYW55IFVVSUQgdG8N
Cj4gYmUNCj4gd3JpdHRlbiBpZiBJRFNQIGlzIG1pc3NpbmcuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBNYXR0aGV3IEdhcnJldHQgPG1qZzU5QGdvb2dsZS5jb20+DQpUZXN0ZWQtYnk6IFBhbmRydXZh
ZGEsIFNyaW5pdmFzIDxzcmluaXZhcy5wYW5kcnV2YWRhQGxpbnV4LmludGVsLmNvbT4NCg0KPiAt
LS0NCj4gIC4uLi9pbnRlbC9pbnQzNDB4X3RoZXJtYWwvaW50MzQwMF90aGVybWFsLmMgICB8IDMw
ICsrKysrKysrKysrKysrLS0tDQo+IC0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMjIgaW5zZXJ0aW9u
cygrKSwgOCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3RoZXJtYWwv
aW50ZWwvaW50MzQweF90aGVybWFsL2ludDM0MDBfdGhlcm1hbC5jDQo+IGIvZHJpdmVycy90aGVy
bWFsL2ludGVsL2ludDM0MHhfdGhlcm1hbC9pbnQzNDAwX3RoZXJtYWwuYw0KPiBpbmRleCAzOTE5
MDk4YTczYjQ3Li4xOTkzNjcwOWMyYWQwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3RoZXJtYWwv
aW50ZWwvaW50MzQweF90aGVybWFsL2ludDM0MDBfdGhlcm1hbC5jDQo+ICsrKyBiL2RyaXZlcnMv
dGhlcm1hbC9pbnRlbC9pbnQzNDB4X3RoZXJtYWwvaW50MzQwMF90aGVybWFsLmMNCj4gQEAgLTk2
LDYgKzk2LDkgQEAgc3RhdGljIHNzaXplX3QgYXZhaWxhYmxlX3V1aWRzX3Nob3coc3RydWN0IGRl
dmljZQ0KPiAqZGV2LA0KPiAgCWludCBpOw0KPiAgCWludCBsZW5ndGggPSAwOw0KPiAgDQo+ICsJ
aWYgKCFwcml2LT51dWlkX2JpdG1hcCkNCj4gKwkJcmV0dXJuIHNwcmludGYoYnVmLCAiVU5LTk9X
TlxuIik7DQo+ICsNCj4gIAlmb3IgKGkgPSAwOyBpIDwgSU5UMzQwMF9USEVSTUFMX01BWElNVU1f
VVVJRDsgaSsrKSB7DQo+ICAJCWlmIChwcml2LT51dWlkX2JpdG1hcCAmICgxIDw8IGkpKQ0KPiAg
CQkJaWYgKFBBR0VfU0laRSAtIGxlbmd0aCA+IDApDQo+IEBAIC0xMTMsMTEgKzExNiwxMSBAQCBz
dGF0aWMgc3NpemVfdCBjdXJyZW50X3V1aWRfc2hvdyhzdHJ1Y3QgZGV2aWNlDQo+ICpkZXYsDQo+
ICB7DQo+ICAJc3RydWN0IGludDM0MDBfdGhlcm1hbF9wcml2ICpwcml2ID0gZGV2X2dldF9kcnZk
YXRhKGRldik7DQo+ICANCj4gLQlpZiAocHJpdi0+dXVpZF9iaXRtYXAgJiAoMSA8PCBwcml2LT5j
dXJyZW50X3V1aWRfaW5kZXgpKQ0KPiAtCQlyZXR1cm4gc3ByaW50ZihidWYsICIlc1xuIiwNCj4g
LQkJCSAgICAgICBpbnQzNDAwX3RoZXJtYWxfdXVpZHNbcHJpdi0NCj4gPmN1cnJlbnRfdXVpZF9p
bmRleF0pOw0KPiAtCWVsc2UNCj4gKwlpZiAocHJpdi0+Y3VycmVudF91dWlkX2luZGV4ID09IC0x
KQ0KPiAgCQlyZXR1cm4gc3ByaW50ZihidWYsICJJTlZBTElEXG4iKTsNCj4gKw0KPiArCXJldHVy
biBzcHJpbnRmKGJ1ZiwgIiVzXG4iLA0KPiArCQkgICAgICAgaW50MzQwMF90aGVybWFsX3V1aWRz
W3ByaXYtDQo+ID5jdXJyZW50X3V1aWRfaW5kZXhdKTsNCj4gIH0NCj4gIA0KPiAgc3RhdGljIHNz
aXplX3QgY3VycmVudF91dWlkX3N0b3JlKHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gQEAgLTEyOCw5
ICsxMzEsMTYgQEAgc3RhdGljIHNzaXplX3QgY3VycmVudF91dWlkX3N0b3JlKHN0cnVjdCBkZXZp
Y2UNCj4gKmRldiwNCj4gIAlpbnQgaTsNCj4gIA0KPiAgCWZvciAoaSA9IDA7IGkgPCBJTlQzNDAw
X1RIRVJNQUxfTUFYSU1VTV9VVUlEOyArK2kpIHsNCj4gLQkJaWYgKChwcml2LT51dWlkX2JpdG1h
cCAmICgxIDw8IGkpKSAmJg0KPiAtCQkgICAgIShzdHJuY21wKGJ1ZiwgaW50MzQwMF90aGVybWFs
X3V1aWRzW2ldLA0KPiAtCQkJICAgICAgc2l6ZW9mKGludDM0MDBfdGhlcm1hbF91dWlkc1tpXSkg
LSAxKSkpIHsNCj4gKwkJaWYgKCFzdHJuY21wKGJ1ZiwgaW50MzQwMF90aGVybWFsX3V1aWRzW2ld
LA0KPiArCQkJICAgICBzaXplb2YoaW50MzQwMF90aGVybWFsX3V1aWRzW2ldKSAtIDEpKSB7DQo+
ICsJCQkvKg0KPiArCQkJICogSWYgd2UgaGF2ZSBhIGxpc3Qgb2Ygc3VwcG9ydGVkIFVVSURzLCBt
YWtlDQo+IHN1cmUNCj4gKwkJCSAqIHRoaXMgb25lIGlzIHN1cHBvcnRlZC4NCj4gKwkJCSAqLw0K
PiArCQkJaWYgKHByaXYtPnV1aWRfYml0bWFwICYmDQo+ICsJCQkgICAgIShwcml2LT51dWlkX2Jp
dG1hcCAmICgxIDw8IGkpKSkNCj4gKwkJCQlyZXR1cm4gLUVJTlZBTDsNCj4gKw0KPiAgCQkJcHJp
di0+Y3VycmVudF91dWlkX2luZGV4ID0gaTsNCj4gIAkJCXJldHVybiBjb3VudDsNCj4gIAkJfQ0K
PiBAQCAtNDYyLDkgKzQ3MiwxMyBAQCBzdGF0aWMgaW50IGludDM0MDBfdGhlcm1hbF9wcm9iZShz
dHJ1Y3QNCj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCXByaXYtPmFkZXYgPSBhZGV2Ow0K
PiAgDQo+ICAJcmVzdWx0ID0gaW50MzQwMF90aGVybWFsX2dldF91dWlkcyhwcml2KTsNCj4gLQlp
ZiAocmVzdWx0KQ0KPiArDQo+ICsJLyogTWlzc2luZyBJRFNQIGlzbid0IGZhdGFsICovDQo+ICsJ
aWYgKHJlc3VsdCAmJiByZXN1bHQgIT0gLUVOT0RFVikNCj4gIAkJZ290byBmcmVlX3ByaXY7DQo+
ICANCj4gKwlwcml2LT5jdXJyZW50X3V1aWRfaW5kZXggPSAtMTsNCj4gKw0KPiAgCXJlc3VsdCA9
IGFjcGlfcGFyc2VfYXJ0KHByaXYtPmFkZXYtPmhhbmRsZSwgJnByaXYtPmFydF9jb3VudCwNCj4g
IAkJCQkmcHJpdi0+YXJ0cywgdHJ1ZSk7DQo+ICAJaWYgKHJlc3VsdCkNCg==
