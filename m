Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBC5180DFE
	for <lists+linux-pm@lfdr.de>; Wed, 11 Mar 2020 03:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbgCKCfU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Mar 2020 22:35:20 -0400
Received: from mga11.intel.com ([192.55.52.93]:55255 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727307AbgCKCfU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Mar 2020 22:35:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 19:35:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,539,1574150400"; 
   d="scan'208";a="415415067"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by orsmga005.jf.intel.com with ESMTP; 10 Mar 2020 19:35:19 -0700
Received: from orsmsx110.amr.corp.intel.com ([169.254.10.107]) by
 ORSMSX107.amr.corp.intel.com ([169.254.1.106]) with mapi id 14.03.0439.000;
 Tue, 10 Mar 2020 19:35:19 -0700
From:   "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "currojerez@riseup.net" <currojerez@riseup.net>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
CC:     "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Subject: Re: [RFC] GPU-bound energy efficiency improvements for the
 intel_pstate driver (v2).
Thread-Topic: [RFC] GPU-bound energy efficiency improvements for the
 intel_pstate driver (v2).
Thread-Index: AQHV9yVeF22XkZfUYkCaOD2IBrMsDqhDInMA
Date:   Wed, 11 Mar 2020 02:35:18 +0000
Message-ID: <b8a09ef0c52dd02954b43b441dc3d1612837138c.camel@intel.com>
References: <20200310214203.26459-1-currojerez@riseup.net>
In-Reply-To: <20200310214203.26459-1-currojerez@riseup.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.3 (3.34.3-1.fc31) 
x-originating-ip: [10.254.113.10]
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C1D5212DFBC1549AFB627D95300C7F3@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gVHVlLCAyMDIwLTAzLTEwIGF0IDE0OjQxIC0wNzAwLCBGcmFuY2lzY28gSmVyZXogd3JvdGU6
DQo+IA0KDQpbLi4uXQ0KDQo+IFRoYW5rcyBpbiBhZHZhbmNlIGZvciBhbnkgcmV2aWV3IGZlZWQt
YmFjayBhbmQgdGVzdCByZXBvcnRzLg0KPiANCj4gW1BBVENIIDAxLzEwXSBQTTogUW9TOiBBZGQg
Q1BVX1JFU1BPTlNFX0ZSRVFVRU5DWSBnbG9iYWwgUE0gUW9TDQo+IGxpbWl0Lg0KPiBbUEFUQ0gg
MDIvMTBdIGRybS9pOTE1OiBBZGp1c3QgUE0gUW9TIHJlc3BvbnNlIGZyZXF1ZW5jeSBiYXNlZCBv
biBHUFUNCj4gbG9hZC4NCj4gW1BBVENIIDAzLzEwXSBPUFRJT05BTDogZHJtL2k5MTU6IEV4cG9z
ZSBQTSBRb1MgY29udHJvbCBwYXJhbWV0ZXJzDQo+IHZpYSBkZWJ1Z2ZzLg0KPiBbUEFUQ0ggMDQv
MTBdIFJldmVydCAiY3B1ZnJlcTogaW50ZWxfcHN0YXRlOiBEcm9wIC0+dXBkYXRlX3V0aWwgZnJv
bQ0KPiBwc3RhdGVfZnVuY3MiDQo+IFtQQVRDSCAwNS8xMF0gY3B1ZnJlcTogaW50ZWxfcHN0YXRl
OiBJbXBsZW1lbnQgVkxQIGNvbnRyb2xsZXINCj4gc3RhdGlzdGljcyBhbmQgc3RhdHVzIGNhbGN1
bGF0aW9uLg0KPiBbUEFUQ0ggMDYvMTBdIGNwdWZyZXE6IGludGVsX3BzdGF0ZTogSW1wbGVtZW50
IFZMUCBjb250cm9sbGVyIHRhcmdldA0KPiBQLXN0YXRlIHJhbmdlIGVzdGltYXRpb24uDQo+IFtQ
QVRDSCAwNy8xMF0gY3B1ZnJlcTogaW50ZWxfcHN0YXRlOiBJbXBsZW1lbnQgVkxQIGNvbnRyb2xs
ZXIgZm9yIEhXUA0KPiBwYXJ0cy4NCj4gW1BBVENIIDA4LzEwXSBjcHVmcmVxOiBpbnRlbF9wc3Rh
dGU6IEVuYWJsZSBWTFAgY29udHJvbGxlciBiYXNlZCBvbg0KPiBBQ1BJIEZBRFQgcHJvZmlsZSBh
bmQgQ1BVSUQuDQo+IFtQQVRDSCAwOS8xMF0gT1BUSU9OQUw6IGNwdWZyZXE6IGludGVsX3BzdGF0
ZTogQWRkIHRyYWNpbmcgb2YgVkxQDQo+IGNvbnRyb2xsZXIgc3RhdHVzLg0KPiBbUEFUQ0ggMTAv
MTBdIE9QVElPTkFMOiBjcHVmcmVxOiBpbnRlbF9wc3RhdGU6IEV4cG9zZSBWTFAgY29udHJvbGxl
cg0KPiBwYXJhbWV0ZXJzIHZpYSBkZWJ1Z2ZzLg0KPiANCkRvIHlvdSBoYXZlIGRlYnVnIHBhdGNo
IChZb3UgZG9uJ3QgdG8gc3VibWl0IGFzIGEgcGF0Y2gpLCB3aGljaCB3aWxsDQphbGxvdyBtZSB0
byBkeW5hbWljYWxseSBkaXNhYmxlL2VuYWJsZSBhbGwgdGhlc2UgY2hhbmdlcz8gSSB3YW50IHRv
DQpjb21wYXJlIGFuZCBkbyBzb21lIG1lYXN1cmVtZW50cy4NCg0KVGhhbmtzLA0KU3Jpbml2YXMg
DQoNCj4gWzFdIGh0dHBzOi8vbWFyYy5pbmZvLz9sPWxpbnV4LXBtJm09MTUyMjIxOTQzMzIwOTA4
Jnc9Mg0KPiBbMl0gDQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9jdXJyby9saW51eC9jb21taXRzL2lu
dGVsX3BzdGF0ZS12bHAtdjItaHdwLW9ubHkNCj4gWzNdIGh0dHBzOi8vZ2l0aHViLmNvbS9jdXJy
by9saW51eC9jb21taXRzL2ludGVsX3BzdGF0ZS12bHAtdjINCj4gWzRdIA0KPiBodHRwOi8vcGVv
cGxlLmZyZWVkZXNrdG9wLm9yZy9+Y3Vycm9qZXJlei9pbnRlbF9wc3RhdGUtdmxwLXYyL2JlbmNo
bWFyay1jb21wYXJpc29uLUlDTC5sb2cNCj4gDQo=
