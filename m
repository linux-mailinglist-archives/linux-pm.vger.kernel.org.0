Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21C391E75B9
	for <lists+linux-pm@lfdr.de>; Fri, 29 May 2020 08:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbgE2GAS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 May 2020 02:00:18 -0400
Received: from mga09.intel.com ([134.134.136.24]:30340 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbgE2GAS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 29 May 2020 02:00:18 -0400
IronPort-SDR: jAuEh8MrRPJ7fyxtzPH6QtWJSIxiO7SkARmE6Jf1CUsj6qeYP2nO5gZPX8Vope/4j/qXMNga5y
 VXqpwzav/7Xw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 23:00:17 -0700
IronPort-SDR: AGmwFPPK+Saq09HhwAklPPF4LLF+Hz0RwJ9V84IxMKjGlriO1DzPZ77FV8Lnaw5jiyhYHHhITy
 wbJUvgrPYYUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,447,1583222400"; 
   d="scan'208";a="285423746"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by orsmga002.jf.intel.com with ESMTP; 28 May 2020 23:00:17 -0700
Received: from orsmsx113.amr.corp.intel.com (10.22.240.9) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 28 May 2020 23:00:16 -0700
Received: from orsmsx109.amr.corp.intel.com ([169.254.11.174]) by
 ORSMSX113.amr.corp.intel.com ([169.254.9.126]) with mapi id 14.03.0439.000;
 Thu, 28 May 2020 23:00:16 -0700
From:   "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To:     "matthewgarrett@google.com" <matthewgarrett@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Zhang, Rui" <rui.zhang@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Aram, Nisha" <nisha.aram@intel.com>,
        "mjg59@google.com" <mjg59@google.com>
Subject: Re: [PATCH V2 1/3] thermal/int340x_thermal: Export GDDV
Thread-Topic: [PATCH V2 1/3] thermal/int340x_thermal: Export GDDV
Thread-Index: AQHWLWqyLmaGM0UKiEamDjfu32esnKi/F1uA
Date:   Fri, 29 May 2020 06:00:16 +0000
Message-ID: <fe5119b46d975e4699ced2d9ed12a25f8ae5d1cd.camel@intel.com>
References: <20200414020953.255364-1-matthewgarrett@google.com>
         <4c00e15c8d5e34a723896f132989edd581c6995e.camel@intel.com>
In-Reply-To: <4c00e15c8d5e34a723896f132989edd581c6995e.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
x-originating-ip: [10.255.231.45]
Content-Type: text/plain; charset="utf-8"
Content-ID: <ABC6A4543327B443BCF3F72513677B6F@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gTW9uLCAyMDIwLTA1LTE4IGF0IDIzOjE4ICswMDAwLCBQYW5kcnV2YWRhLCBTcmluaXZhcyB3
cm90ZToNCj4gT24gTW9uLCAyMDIwLTA0LTEzIGF0IDE5OjA5IC0wNzAwLCBNYXR0aGV3IEdhcnJl
dHQgd3JvdGU6DQo+ID4gRnJvbTogTWF0dGhldyBHYXJyZXR0IDxtamc1OUBnb29nbGUuY29tPg0K
PiA+IA0KPiA+IEltcGxlbWVudGluZyBEUFRGIHByb3Blcmx5IHJlcXVpcmVzIG1ha2luZyB1c2Ug
b2YgZmlybXdhcmUtcHJvdmlkZWQNCj4gPiBpbmZvcm1hdGlvbiBhc3NvY2lhdGVkIHdpdGggdGhl
IElOVDM0MDAgZGV2aWNlLiBDYWxsaW5nIEdERFYNCj4gPiBwcm92aWRlcw0KPiA+IGENCj4gPiBi
dWZmZXIgb2YgaW5mb3JtYXRpb24gd2hpY2ggdXNlcmxhbmQgY2FuIHRoZW4gaW50ZXJwcmV0IHRv
DQo+ID4gZGV0ZXJtaW5lDQo+ID4gYXBwcm9wcmlhdGUgRFBURiBwb2xpY3kuDQo+ID4gDQo+ID4g
U2lnbmVkLW9mZi1ieTogTWF0dGhldyBHYXJyZXR0IDxtamc1OUBnb29nbGUuY29tPg0KPiBUZXN0
ZWQtYnk6IFBhbmRydXZhZGEsIFNyaW5pdmFzIDxzcmluaXZhcy5wYW5kcnV2YWRhQGxpbnV4Lmlu
dGVsLmNvbT4NCg0KQ2FuIHdlIHRha2UgdGhpcyBzZXJpZXMgZm9yIDUuOD8NCg0KVGhhbmtzLA0K
U3Jpbml2YXMNCg0KPiANCj4gPiAtLS0NCj4gPiAgLi4uL2ludGVsL2ludDM0MHhfdGhlcm1hbC9p
bnQzNDAwX3RoZXJtYWwuYyAgIHwgNjANCj4gPiArKysrKysrKysrKysrKysrKysrDQo+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCA2MCBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdA0KPiA+
IGEvZHJpdmVycy90aGVybWFsL2ludGVsL2ludDM0MHhfdGhlcm1hbC9pbnQzNDAwX3RoZXJtYWwu
Yw0KPiA+IGIvZHJpdmVycy90aGVybWFsL2ludGVsL2ludDM0MHhfdGhlcm1hbC9pbnQzNDAwX3Ro
ZXJtYWwuYw0KPiA+IGluZGV4IGNlZWY4OWM5NTZiZDQuLjAwYTc3MzI3MjRjZDAgMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy90aGVybWFsL2ludGVsL2ludDM0MHhfdGhlcm1hbC9pbnQzNDAwX3Ro
ZXJtYWwuYw0KPiA+ICsrKyBiL2RyaXZlcnMvdGhlcm1hbC9pbnRlbC9pbnQzNDB4X3RoZXJtYWwv
aW50MzQwMF90aGVybWFsLmMNCj4gPiBAQCAtNTIsNiArNTIsMjUgQEAgc3RydWN0IGludDM0MDBf
dGhlcm1hbF9wcml2IHsNCj4gPiAgCXU4IHV1aWRfYml0bWFwOw0KPiA+ICAJaW50IHJlbF9taXNj
X2Rldl9yZXM7DQo+ID4gIAlpbnQgY3VycmVudF91dWlkX2luZGV4Ow0KPiA+ICsJY2hhciAqZGF0
YV92YXVsdDsNCj4gPiArfTsNCj4gPiArDQo+ID4gK3N0YXRpYyBzc2l6ZV90IGRhdGFfdmF1bHRf
cmVhZChzdHJ1Y3QgZmlsZSAqZmlsZSwgc3RydWN0IGtvYmplY3QNCj4gPiAqa29iaiwNCj4gPiAr
CSAgICAgc3RydWN0IGJpbl9hdHRyaWJ1dGUgKmF0dHIsIGNoYXIgKmJ1ZiwgbG9mZl90IG9mZiwg
c2l6ZV90DQo+ID4gY291bnQpDQo+ID4gK3sNCj4gPiArCW1lbWNweShidWYsIGF0dHItPnByaXZh
dGUgKyBvZmYsIGNvdW50KTsNCj4gPiArCXJldHVybiBjb3VudDsNCj4gPiArfQ0KPiA+ICsNCj4g
PiArc3RhdGljIEJJTl9BVFRSX1JPKGRhdGFfdmF1bHQsIDApOw0KPiA+ICsNCj4gPiArc3RhdGlj
IHN0cnVjdCBiaW5fYXR0cmlidXRlICpkYXRhX2F0dHJpYnV0ZXNbXSA9IHsNCj4gPiArCSZiaW5f
YXR0cl9kYXRhX3ZhdWx0LA0KPiA+ICsJTlVMTCwNCj4gPiArfTsNCj4gPiArDQo+ID4gK3N0YXRp
YyBjb25zdCBzdHJ1Y3QgYXR0cmlidXRlX2dyb3VwIGRhdGFfYXR0cmlidXRlX2dyb3VwID0gew0K
PiA+ICsJLmJpbl9hdHRycyA9IGRhdGFfYXR0cmlidXRlcywNCj4gPiAgfTsNCj4gPiAgDQo+ID4g
IHN0YXRpYyBzc2l6ZV90IGF2YWlsYWJsZV91dWlkc19zaG93KHN0cnVjdCBkZXZpY2UgKmRldiwN
Cj4gPiBAQCAtMjc4LDYgKzI5NywzMiBAQCBzdGF0aWMgc3RydWN0IHRoZXJtYWxfem9uZV9wYXJh
bXMNCj4gPiBpbnQzNDAwX3RoZXJtYWxfcGFyYW1zID0gew0KPiA+ICAJLm5vX2h3bW9uID0gdHJ1
ZSwNCj4gPiAgfTsNCj4gPiAgDQo+ID4gK3N0YXRpYyB2b2lkIGludDM0MDBfc2V0dXBfZ2Rkdihz
dHJ1Y3QgaW50MzQwMF90aGVybWFsX3ByaXYgKnByaXYpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBh
Y3BpX2J1ZmZlciBidWZmZXIgPSB7IEFDUElfQUxMT0NBVEVfQlVGRkVSLCBOVUxMIH07DQo+ID4g
Kwl1bmlvbiBhY3BpX29iamVjdCAqb2JqOw0KPiA+ICsJYWNwaV9zdGF0dXMgc3RhdHVzOw0KPiA+
ICsNCj4gPiArCXN0YXR1cyA9IGFjcGlfZXZhbHVhdGVfb2JqZWN0KHByaXYtPmFkZXYtPmhhbmRs
ZSwgIkdERFYiLCBOVUxMLA0KPiA+ICsJCQkJICAgICAgJmJ1ZmZlcik7DQo+ID4gKwlpZiAoQUNQ
SV9GQUlMVVJFKHN0YXR1cykgfHwgIWJ1ZmZlci5sZW5ndGgpDQo+ID4gKwkJcmV0dXJuOw0KPiA+
ICsNCj4gPiArCW9iaiA9IGJ1ZmZlci5wb2ludGVyOw0KPiA+ICsJaWYgKG9iai0+dHlwZSAhPSBB
Q1BJX1RZUEVfUEFDS0FHRSB8fCBvYmotPnBhY2thZ2UuY291bnQgIT0gMQ0KPiA+ICsJICAgIHx8
IG9iai0+cGFja2FnZS5lbGVtZW50c1swXS50eXBlICE9IEFDUElfVFlQRV9CVUZGRVIpIHsNCj4g
PiArCQlrZnJlZShidWZmZXIucG9pbnRlcik7DQo+ID4gKwkJcmV0dXJuOw0KPiA+ICsJfQ0KPiA+
ICsNCj4gPiArCXByaXYtPmRhdGFfdmF1bHQgPSBrbWVtZHVwKG9iai0NCj4gPiA+IHBhY2thZ2Uu
ZWxlbWVudHNbMF0uYnVmZmVyLnBvaW50ZXIsDQo+ID4gKwkJCQkgICBvYmotDQo+ID4gPiBwYWNr
YWdlLmVsZW1lbnRzWzBdLmJ1ZmZlci5sZW5ndGgsDQo+ID4gKwkJCQkgICBHRlBfS0VSTkVMKTsN
Cj4gPiArCWJpbl9hdHRyX2RhdGFfdmF1bHQucHJpdmF0ZSA9IHByaXYtPmRhdGFfdmF1bHQ7DQo+
ID4gKwliaW5fYXR0cl9kYXRhX3ZhdWx0LnNpemUgPSBvYmotDQo+ID4gPiBwYWNrYWdlLmVsZW1l
bnRzWzBdLmJ1ZmZlci5sZW5ndGg7DQo+ID4gKwlrZnJlZShidWZmZXIucG9pbnRlcik7DQo+ID4g
K30NCj4gPiArDQo+ID4gIHN0YXRpYyBpbnQgaW50MzQwMF90aGVybWFsX3Byb2JlKHN0cnVjdCBw
bGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gIHsNCj4gPiAgCXN0cnVjdCBhY3BpX2RldmljZSAq
YWRldiA9IEFDUElfQ09NUEFOSU9OKCZwZGV2LT5kZXYpOw0KPiA+IEBAIC0zMDksNiArMzU0LDgg
QEAgc3RhdGljIGludCBpbnQzNDAwX3RoZXJtYWxfcHJvYmUoc3RydWN0DQo+ID4gcGxhdGZvcm1f
ZGV2aWNlICpwZGV2KQ0KPiA+ICANCj4gPiAgCXBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYsIHBy
aXYpOw0KPiA+ICANCj4gPiArCWludDM0MDBfc2V0dXBfZ2Rkdihwcml2KTsNCj4gPiArDQo+ID4g
IAlpbnQzNDAwX3RoZXJtYWxfb3BzLmdldF9tb2RlID0gaW50MzQwMF90aGVybWFsX2dldF9tb2Rl
Ow0KPiA+ICAJaW50MzQwMF90aGVybWFsX29wcy5zZXRfbW9kZSA9IGludDM0MDBfdGhlcm1hbF9z
ZXRfbW9kZTsNCj4gPiAgDQo+ID4gQEAgLTMyNyw2ICszNzQsMTMgQEAgc3RhdGljIGludCBpbnQz
NDAwX3RoZXJtYWxfcHJvYmUoc3RydWN0DQo+ID4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+
ICAJaWYgKHJlc3VsdCkNCj4gPiAgCQlnb3RvIGZyZWVfcmVsX21pc2M7DQo+ID4gIA0KPiA+ICsJ
aWYgKHByaXYtPmRhdGFfdmF1bHQpIHsNCj4gPiArCQlyZXN1bHQgPSBzeXNmc19jcmVhdGVfZ3Jv
dXAoJnBkZXYtPmRldi5rb2JqLA0KPiA+ICsJCQkJCSAgICAmZGF0YV9hdHRyaWJ1dGVfZ3JvdXAp
Ow0KPiA+ICsJCWlmIChyZXN1bHQpDQo+ID4gKwkJCWdvdG8gZnJlZV91dWlkOw0KPiA+ICsJfQ0K
PiA+ICsNCj4gPiAgCXJlc3VsdCA9IGFjcGlfaW5zdGFsbF9ub3RpZnlfaGFuZGxlcigNCj4gPiAg
CQkJcHJpdi0+YWRldi0+aGFuZGxlLCBBQ1BJX0RFVklDRV9OT1RJRlksDQo+ID4gaW50MzQwMF9u
b3RpZnksDQo+ID4gIAkJCSh2b2lkICopcHJpdik7DQo+ID4gQEAgLTMzNiw2ICszOTAsOSBAQCBz
dGF0aWMgaW50IGludDM0MDBfdGhlcm1hbF9wcm9iZShzdHJ1Y3QNCj4gPiBwbGF0Zm9ybV9kZXZp
Y2UgKnBkZXYpDQo+ID4gIAlyZXR1cm4gMDsNCj4gPiAgDQo+ID4gIGZyZWVfc3lzZnM6DQo+ID4g
KwlpZiAocHJpdi0+ZGF0YV92YXVsdCkNCj4gPiArCQlzeXNmc19yZW1vdmVfZ3JvdXAoJnBkZXYt
PmRldi5rb2JqLA0KPiA+ICZkYXRhX2F0dHJpYnV0ZV9ncm91cCk7DQo+ID4gK2ZyZWVfdXVpZDoN
Cj4gPiAgCXN5c2ZzX3JlbW92ZV9ncm91cCgmcGRldi0+ZGV2LmtvYmosICZ1dWlkX2F0dHJpYnV0
ZV9ncm91cCk7DQo+ID4gIGZyZWVfcmVsX21pc2M6DQo+ID4gIAlpZiAoIXByaXYtPnJlbF9taXNj
X2Rldl9yZXMpDQo+ID4gQEAgLTM2MCw4ICs0MTcsMTEgQEAgc3RhdGljIGludCBpbnQzNDAwX3Ro
ZXJtYWxfcmVtb3ZlKHN0cnVjdA0KPiA+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiAgCWlm
ICghcHJpdi0+cmVsX21pc2NfZGV2X3JlcykNCj4gPiAgCQlhY3BpX3RoZXJtYWxfcmVsX21pc2Nf
ZGV2aWNlX3JlbW92ZShwcml2LT5hZGV2LQ0KPiA+ID4gaGFuZGxlKTsNCj4gPiAgDQo+ID4gKwlp
ZiAocHJpdi0+ZGF0YV92YXVsdCkNCj4gPiArCQlzeXNmc19yZW1vdmVfZ3JvdXAoJnBkZXYtPmRl
di5rb2JqLA0KPiA+ICZkYXRhX2F0dHJpYnV0ZV9ncm91cCk7DQo+ID4gIAlzeXNmc19yZW1vdmVf
Z3JvdXAoJnBkZXYtPmRldi5rb2JqLCAmdXVpZF9hdHRyaWJ1dGVfZ3JvdXApOw0KPiA+ICAJdGhl
cm1hbF96b25lX2RldmljZV91bnJlZ2lzdGVyKHByaXYtPnRoZXJtYWwpOw0KPiA+ICsJa2ZyZWUo
cHJpdi0+ZGF0YV92YXVsdCk7DQo+ID4gIAlrZnJlZShwcml2LT50cnRzKTsNCj4gPiAgCWtmcmVl
KHByaXYtPmFydHMpOw0KPiA+ICAJa2ZyZWUocHJpdik7DQo=
