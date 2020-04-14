Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBA81A71D1
	for <lists+linux-pm@lfdr.de>; Tue, 14 Apr 2020 05:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404769AbgDNDdj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Apr 2020 23:33:39 -0400
Received: from mga01.intel.com ([192.55.52.88]:29972 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404756AbgDNDdi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 Apr 2020 23:33:38 -0400
IronPort-SDR: tFayGoUoXMsK1VifLp1qr7vmv7rvKvnDDUBEFRd7Ps+1K79PxzcaegK8/HQ/LoO0cFm642OR0x
 +KHttYndfhJw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 20:33:37 -0700
IronPort-SDR: AWunC/5rlJzD8PZJgrZ6SOvu45mvjrZC9LBxYhC1/z4T9Kdi9PHGPKSRD26n33Tk7XkZcuC5CU
 7mWS1Sk2IGPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,381,1580803200"; 
   d="scan'208";a="399821413"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by orsmga004.jf.intel.com with ESMTP; 13 Apr 2020 20:33:36 -0700
Received: from orsmsx114.amr.corp.intel.com (10.22.240.10) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 13 Apr 2020 20:33:36 -0700
Received: from orsmsx109.amr.corp.intel.com ([169.254.11.20]) by
 ORSMSX114.amr.corp.intel.com ([169.254.8.205]) with mapi id 14.03.0439.000;
 Mon, 13 Apr 2020 20:33:36 -0700
From:   "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To:     "matthewgarrett@google.com" <matthewgarrett@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Zhang, Rui" <rui.zhang@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Aram, Nisha" <nisha.aram@intel.com>,
        "mjg59@google.com" <mjg59@google.com>
Subject: Re: [PATCH V2 1/3] thermal/int340x_thermal: Export GDDV
Thread-Topic: [PATCH V2 1/3] thermal/int340x_thermal: Export GDDV
Thread-Index: AQHWEg16NMV5m6DKX0a90M6geYk4vA==
Date:   Tue, 14 Apr 2020 03:33:36 +0000
Message-ID: <1ba40c555115e5a2770e95b974096016fbfc3606.camel@intel.com>
References: <20200414020953.255364-1-matthewgarrett@google.com>
In-Reply-To: <20200414020953.255364-1-matthewgarrett@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.2 (3.34.2-1.fc31) 
x-originating-ip: [10.255.229.162]
Content-Type: text/plain; charset="utf-8"
Content-ID: <00B18B4DA2AD92409D0E73C90DB432ED@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gTW9uLCAyMDIwLTA0LTEzIGF0IDE5OjA5IC0wNzAwLCBNYXR0aGV3IEdhcnJldHQgd3JvdGU6
DQo+IEZyb206IE1hdHRoZXcgR2FycmV0dCA8bWpnNTlAZ29vZ2xlLmNvbT4NCj4gDQo+IEltcGxl
bWVudGluZyBEUFRGIHByb3Blcmx5IHJlcXVpcmVzIG1ha2luZyB1c2Ugb2YgZmlybXdhcmUtcHJv
dmlkZWQNCj4gaW5mb3JtYXRpb24gYXNzb2NpYXRlZCB3aXRoIHRoZSBJTlQzNDAwIGRldmljZS4g
Q2FsbGluZyBHRERWIHByb3ZpZGVzDQo+IGENCj4gYnVmZmVyIG9mIGluZm9ybWF0aW9uIHdoaWNo
IHVzZXJsYW5kIGNhbiB0aGVuIGludGVycHJldCB0byBkZXRlcm1pbmUNCj4gYXBwcm9wcmlhdGUg
RFBURiBwb2xpY3kuDQo+IA0KDQpBbnl0aGluZyBjaGFuZ2VkIGluIHYyIHNlcmllcz8NCg0KVGhh
bmtzLA0KU3Jpbml2YXMNCg0KPiBTaWduZWQtb2ZmLWJ5OiBNYXR0aGV3IEdhcnJldHQgPG1qZzU5
QGdvb2dsZS5jb20+DQo+IC0tLQ0KPiAgLi4uL2ludGVsL2ludDM0MHhfdGhlcm1hbC9pbnQzNDAw
X3RoZXJtYWwuYyAgIHwgNjANCj4gKysrKysrKysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDYwIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3RoZXJtYWwv
aW50ZWwvaW50MzQweF90aGVybWFsL2ludDM0MDBfdGhlcm1hbC5jDQo+IGIvZHJpdmVycy90aGVy
bWFsL2ludGVsL2ludDM0MHhfdGhlcm1hbC9pbnQzNDAwX3RoZXJtYWwuYw0KPiBpbmRleCBjZWVm
ODljOTU2YmQ0Li4wMGE3NzMyNzI0Y2QwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3RoZXJtYWwv
aW50ZWwvaW50MzQweF90aGVybWFsL2ludDM0MDBfdGhlcm1hbC5jDQo+ICsrKyBiL2RyaXZlcnMv
dGhlcm1hbC9pbnRlbC9pbnQzNDB4X3RoZXJtYWwvaW50MzQwMF90aGVybWFsLmMNCj4gQEAgLTUy
LDYgKzUyLDI1IEBAIHN0cnVjdCBpbnQzNDAwX3RoZXJtYWxfcHJpdiB7DQo+ICAJdTggdXVpZF9i
aXRtYXA7DQo+ICAJaW50IHJlbF9taXNjX2Rldl9yZXM7DQo+ICAJaW50IGN1cnJlbnRfdXVpZF9p
bmRleDsNCj4gKwljaGFyICpkYXRhX3ZhdWx0Ow0KPiArfTsNCj4gKw0KPiArc3RhdGljIHNzaXpl
X3QgZGF0YV92YXVsdF9yZWFkKHN0cnVjdCBmaWxlICpmaWxlLCBzdHJ1Y3Qga29iamVjdA0KPiAq
a29iaiwNCj4gKwkgICAgIHN0cnVjdCBiaW5fYXR0cmlidXRlICphdHRyLCBjaGFyICpidWYsIGxv
ZmZfdCBvZmYsIHNpemVfdA0KPiBjb3VudCkNCj4gK3sNCj4gKwltZW1jcHkoYnVmLCBhdHRyLT5w
cml2YXRlICsgb2ZmLCBjb3VudCk7DQo+ICsJcmV0dXJuIGNvdW50Ow0KPiArfQ0KPiArDQo+ICtz
dGF0aWMgQklOX0FUVFJfUk8oZGF0YV92YXVsdCwgMCk7DQo+ICsNCj4gK3N0YXRpYyBzdHJ1Y3Qg
YmluX2F0dHJpYnV0ZSAqZGF0YV9hdHRyaWJ1dGVzW10gPSB7DQo+ICsJJmJpbl9hdHRyX2RhdGFf
dmF1bHQsDQo+ICsJTlVMTCwNCj4gK307DQo+ICsNCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgYXR0
cmlidXRlX2dyb3VwIGRhdGFfYXR0cmlidXRlX2dyb3VwID0gew0KPiArCS5iaW5fYXR0cnMgPSBk
YXRhX2F0dHJpYnV0ZXMsDQo+ICB9Ow0KPiAgDQo+ICBzdGF0aWMgc3NpemVfdCBhdmFpbGFibGVf
dXVpZHNfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+IEBAIC0yNzgsNiArMjk3LDMyIEBAIHN0
YXRpYyBzdHJ1Y3QgdGhlcm1hbF96b25lX3BhcmFtcw0KPiBpbnQzNDAwX3RoZXJtYWxfcGFyYW1z
ID0gew0KPiAgCS5ub19od21vbiA9IHRydWUsDQo+ICB9Ow0KPiAgDQo+ICtzdGF0aWMgdm9pZCBp
bnQzNDAwX3NldHVwX2dkZHYoc3RydWN0IGludDM0MDBfdGhlcm1hbF9wcml2ICpwcml2KQ0KPiAr
ew0KPiArCXN0cnVjdCBhY3BpX2J1ZmZlciBidWZmZXIgPSB7IEFDUElfQUxMT0NBVEVfQlVGRkVS
LCBOVUxMIH07DQo+ICsJdW5pb24gYWNwaV9vYmplY3QgKm9iajsNCj4gKwlhY3BpX3N0YXR1cyBz
dGF0dXM7DQo+ICsNCj4gKwlzdGF0dXMgPSBhY3BpX2V2YWx1YXRlX29iamVjdChwcml2LT5hZGV2
LT5oYW5kbGUsICJHRERWIiwgTlVMTCwNCj4gKwkJCQkgICAgICAmYnVmZmVyKTsNCj4gKwlpZiAo
QUNQSV9GQUlMVVJFKHN0YXR1cykgfHwgIWJ1ZmZlci5sZW5ndGgpDQo+ICsJCXJldHVybjsNCj4g
Kw0KPiArCW9iaiA9IGJ1ZmZlci5wb2ludGVyOw0KPiArCWlmIChvYmotPnR5cGUgIT0gQUNQSV9U
WVBFX1BBQ0tBR0UgfHwgb2JqLT5wYWNrYWdlLmNvdW50ICE9IDENCj4gKwkgICAgfHwgb2JqLT5w
YWNrYWdlLmVsZW1lbnRzWzBdLnR5cGUgIT0gQUNQSV9UWVBFX0JVRkZFUikgew0KPiArCQlrZnJl
ZShidWZmZXIucG9pbnRlcik7DQo+ICsJCXJldHVybjsNCj4gKwl9DQo+ICsNCj4gKwlwcml2LT5k
YXRhX3ZhdWx0ID0ga21lbWR1cChvYmotDQo+ID5wYWNrYWdlLmVsZW1lbnRzWzBdLmJ1ZmZlci5w
b2ludGVyLA0KPiArCQkJCSAgIG9iai0NCj4gPnBhY2thZ2UuZWxlbWVudHNbMF0uYnVmZmVyLmxl
bmd0aCwNCj4gKwkJCQkgICBHRlBfS0VSTkVMKTsNCj4gKwliaW5fYXR0cl9kYXRhX3ZhdWx0LnBy
aXZhdGUgPSBwcml2LT5kYXRhX3ZhdWx0Ow0KPiArCWJpbl9hdHRyX2RhdGFfdmF1bHQuc2l6ZSA9
IG9iai0NCj4gPnBhY2thZ2UuZWxlbWVudHNbMF0uYnVmZmVyLmxlbmd0aDsNCj4gKwlrZnJlZShi
dWZmZXIucG9pbnRlcik7DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyBpbnQgaW50MzQwMF90aGVybWFs
X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICB7DQo+ICAJc3RydWN0IGFj
cGlfZGV2aWNlICphZGV2ID0gQUNQSV9DT01QQU5JT04oJnBkZXYtPmRldik7DQo+IEBAIC0zMDks
NiArMzU0LDggQEAgc3RhdGljIGludCBpbnQzNDAwX3RoZXJtYWxfcHJvYmUoc3RydWN0DQo+IHBs
YXRmb3JtX2RldmljZSAqcGRldikNCj4gIA0KPiAgCXBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYs
IHByaXYpOw0KPiAgDQo+ICsJaW50MzQwMF9zZXR1cF9nZGR2KHByaXYpOw0KPiArDQo+ICAJaW50
MzQwMF90aGVybWFsX29wcy5nZXRfbW9kZSA9IGludDM0MDBfdGhlcm1hbF9nZXRfbW9kZTsNCj4g
IAlpbnQzNDAwX3RoZXJtYWxfb3BzLnNldF9tb2RlID0gaW50MzQwMF90aGVybWFsX3NldF9tb2Rl
Ow0KPiAgDQo+IEBAIC0zMjcsNiArMzc0LDEzIEBAIHN0YXRpYyBpbnQgaW50MzQwMF90aGVybWFs
X3Byb2JlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJaWYgKHJlc3VsdCkN
Cj4gIAkJZ290byBmcmVlX3JlbF9taXNjOw0KPiAgDQo+ICsJaWYgKHByaXYtPmRhdGFfdmF1bHQp
IHsNCj4gKwkJcmVzdWx0ID0gc3lzZnNfY3JlYXRlX2dyb3VwKCZwZGV2LT5kZXYua29iaiwNCj4g
KwkJCQkJICAgICZkYXRhX2F0dHJpYnV0ZV9ncm91cCk7DQo+ICsJCWlmIChyZXN1bHQpDQo+ICsJ
CQlnb3RvIGZyZWVfdXVpZDsNCj4gKwl9DQo+ICsNCj4gIAlyZXN1bHQgPSBhY3BpX2luc3RhbGxf
bm90aWZ5X2hhbmRsZXIoDQo+ICAJCQlwcml2LT5hZGV2LT5oYW5kbGUsIEFDUElfREVWSUNFX05P
VElGWSwNCj4gaW50MzQwMF9ub3RpZnksDQo+ICAJCQkodm9pZCAqKXByaXYpOw0KPiBAQCAtMzM2
LDYgKzM5MCw5IEBAIHN0YXRpYyBpbnQgaW50MzQwMF90aGVybWFsX3Byb2JlKHN0cnVjdA0KPiBw
bGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJcmV0dXJuIDA7DQo+ICANCj4gIGZyZWVfc3lzZnM6
DQo+ICsJaWYgKHByaXYtPmRhdGFfdmF1bHQpDQo+ICsJCXN5c2ZzX3JlbW92ZV9ncm91cCgmcGRl
di0+ZGV2LmtvYmosDQo+ICZkYXRhX2F0dHJpYnV0ZV9ncm91cCk7DQo+ICtmcmVlX3V1aWQ6DQo+
ICAJc3lzZnNfcmVtb3ZlX2dyb3VwKCZwZGV2LT5kZXYua29iaiwgJnV1aWRfYXR0cmlidXRlX2dy
b3VwKTsNCj4gIGZyZWVfcmVsX21pc2M6DQo+ICAJaWYgKCFwcml2LT5yZWxfbWlzY19kZXZfcmVz
KQ0KPiBAQCAtMzYwLDggKzQxNywxMSBAQCBzdGF0aWMgaW50IGludDM0MDBfdGhlcm1hbF9yZW1v
dmUoc3RydWN0DQo+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAlpZiAoIXByaXYtPnJlbF9t
aXNjX2Rldl9yZXMpDQo+ICAJCWFjcGlfdGhlcm1hbF9yZWxfbWlzY19kZXZpY2VfcmVtb3ZlKHBy
aXYtPmFkZXYtDQo+ID5oYW5kbGUpOw0KPiAgDQo+ICsJaWYgKHByaXYtPmRhdGFfdmF1bHQpDQo+
ICsJCXN5c2ZzX3JlbW92ZV9ncm91cCgmcGRldi0+ZGV2LmtvYmosDQo+ICZkYXRhX2F0dHJpYnV0
ZV9ncm91cCk7DQo+ICAJc3lzZnNfcmVtb3ZlX2dyb3VwKCZwZGV2LT5kZXYua29iaiwgJnV1aWRf
YXR0cmlidXRlX2dyb3VwKTsNCj4gIAl0aGVybWFsX3pvbmVfZGV2aWNlX3VucmVnaXN0ZXIocHJp
di0+dGhlcm1hbCk7DQo+ICsJa2ZyZWUocHJpdi0+ZGF0YV92YXVsdCk7DQo+ICAJa2ZyZWUocHJp
di0+dHJ0cyk7DQo+ICAJa2ZyZWUocHJpdi0+YXJ0cyk7DQo+ICAJa2ZyZWUocHJpdik7DQo=
