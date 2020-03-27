Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85FC0195FE4
	for <lists+linux-pm@lfdr.de>; Fri, 27 Mar 2020 21:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbgC0UhN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Mar 2020 16:37:13 -0400
Received: from mga05.intel.com ([192.55.52.43]:1799 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727423AbgC0UhN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 27 Mar 2020 16:37:13 -0400
IronPort-SDR: A41lbcVxfeWD8xa+MgP5ZmaCqJZmz+FkEAullsUYjOFGzUMRgMtpTTMgh7tlZZhj1a0RecSgJD
 9l8TNz7yso9w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 13:37:12 -0700
IronPort-SDR: YxIpey+DBp4UTDmDYdiReuwbPZV59ny+m2CyRDIK0AcZh45b1qtR6JRrbhzDcUZGc0squcl5pl
 fQAchXrspTnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,313,1580803200"; 
   d="scan'208";a="271698085"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by fmsmga004.fm.intel.com with ESMTP; 27 Mar 2020 13:37:12 -0700
Received: from orsmsx126.amr.corp.intel.com (10.22.240.126) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 27 Mar 2020 13:37:11 -0700
Received: from orsmsx110.amr.corp.intel.com ([169.254.10.144]) by
 ORSMSX126.amr.corp.intel.com ([169.254.4.246]) with mapi id 14.03.0439.000;
 Fri, 27 Mar 2020 13:37:12 -0700
From:   "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Kammela, Gayatri" <gayatri.kammela@intel.com>
CC:     "dvhart@infradead.org" <dvhart@infradead.org>,
        "alex.hung@canonical.com" <alex.hung@canonical.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "Westerberg, Mika" <mika.westerberg@intel.com>,
        "Prestopine, Charles D" <charles.d.prestopine@intel.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v1 1/3] ACPI: fix: Update Tiger Lake ACPI device IDs
Thread-Topic: [PATCH v1 1/3] ACPI: fix: Update Tiger Lake ACPI device IDs
Thread-Index: AQHWBHaJjFjdjl4rsECHciLO+1WiMKhdW2UA
Date:   Fri, 27 Mar 2020 20:37:11 +0000
Message-ID: <7e9c5faa9c4c873b6f5b5a8a526134cd92ef6a2a.camel@intel.com>
References: <cover.1585335927.git.gayatri.kammela@intel.com>
         <f2b887a74103500ab59c42e6082f9c52f2063e4a.1585335927.git.gayatri.kammela@intel.com>
In-Reply-To: <f2b887a74103500ab59c42e6082f9c52f2063e4a.1585335927.git.gayatri.kammela@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.2 (3.34.2-1.fc31) 
x-originating-ip: [10.212.248.143]
Content-Type: text/plain; charset="utf-8"
Content-ID: <59BC38F5A06D9A4A8B1D4EC1B9340384@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gRnJpLCAyMDIwLTAzLTI3IGF0IDEzOjI0IC0wNzAwLCBHYXlhdHJpIEthbW1lbGEgd3JvdGU6
DQo+IFRpZ2VyIExha2UncyBuZXcgdW5pcXVlIEFDUEkgZGV2aWNlIElEcyBmb3IgRFBURiBhbmQg
ZmFuIGRyaXZlcnMgYXJlDQo+IG5vdA0KPiB2YWxpZCBhcyB0aGUgSURzIGFyZSBtaXNzaW5nICdD
Jy4gRml4IHRoZSBJRHMgYnkgdXBkYXRpbmcgdGhlbS4NCj4gDQo+IEFmdGVyIHRoZSB1cGRhdGUs
IHRoZSBuZXcgSURzIHNob3VsZCBub3cgbG9vayBsaWtlDQo+IElOVDEwNDcgLS0+IElOVEMxMDQ3
DQo+IElOVDEwNDAgLS0+IElOVEMxMDQwDQo+IElOVDEwNDMgLS0+IElOVEMxMDQzDQo+IElOVDEw
NDQgLS0+IElOVEMxMDQ0DQo+IA0KV2UgbmVlZCBGaXhlcyB0YWcuDQoNCkZvciBleGFtcGxlDQoN
CkZpeGVzOiA1NWNmZTZhNWM1ODIgKCJBQ1BJOiBEUFRGOiBBZGQgVGlnZXIgTGFrZSBBQ1BJIGRl
dmljZSBJRHMiKQ0KQ2M6IDUuNisgPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+ICMgNS42Kw0KDQpC
eSB0aGUgdGltZSB0aGlzIHBhdGNoIGlzIG1lcmdlZCBJIGd1ZXNzIHRoZSA1LjYgd2lsbCBiZSBv
dXQuDQoNCj4gQ2M6IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50
ZWwuY29tPg0KPiBDYzogU3Jpbml2YXMgUGFuZHJ1dmFkYSA8c3Jpbml2YXMucGFuZHJ1dmFkYUBp
bnRlbC5jb20+DQo+IENjOiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsLmoud3lzb2NraUBpbnRl
bC5jb20+DQo+IFN1Z2dlc3RlZC1ieTogU3Jpbml2YXMgUGFuZHJ1dmFkYSA8c3Jpbml2YXMucGFu
ZHJ1dmFkYUBpbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEdheWF0cmkgS2FtbWVsYSA8Z2F5
YXRyaS5rYW1tZWxhQGludGVsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2FjcGkvZGV2aWNlX3Bt
LmMgICAgICAgICAgICB8IDIgKy0NCj4gIGRyaXZlcnMvYWNwaS9kcHRmL2RwdGZfcG93ZXIuYyAg
ICAgIHwgMiArLQ0KPiAgZHJpdmVycy9hY3BpL2RwdGYvaW50MzQweF90aGVybWFsLmMgfCA4ICsr
KystLS0tDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMo
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvZGV2aWNlX3BtLmMgYi9kcml2ZXJz
L2FjcGkvZGV2aWNlX3BtLmMNCj4gaW5kZXggYjY0YzYyYmZjZWE1Li44MGRhZTNiM2MzNmEgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvYWNwaS9kZXZpY2VfcG0uYw0KPiArKysgYi9kcml2ZXJzL2Fj
cGkvZGV2aWNlX3BtLmMNCj4gQEAgLTEzMjEsNyArMTMyMSw3IEBAIGludCBhY3BpX2Rldl9wbV9h
dHRhY2goc3RydWN0IGRldmljZSAqZGV2LCBib29sDQo+IHBvd2VyX29uKQ0KPiAgCSAqLw0KPiAg
CXN0YXRpYyBjb25zdCBzdHJ1Y3QgYWNwaV9kZXZpY2VfaWQgc3BlY2lhbF9wbV9pZHNbXSA9IHsN
Cj4gIAkJeyJQTlAwQzBCIiwgfSwgLyogR2VuZXJpYyBBQ1BJIGZhbiAqLw0KPiAtCQl7IklOVDEw
NDQiLCB9LCAvKiBGYW4gZm9yIFRpZ2VyIExha2UgZ2VuZXJhdGlvbiAqLw0KPiArCQl7IklOVEMx
MDQ0IiwgfSwgLyogRmFuIGZvciBUaWdlciBMYWtlIGdlbmVyYXRpb24gKi8NCj4gIAkJeyJJTlQz
NDA0IiwgfSwgLyogRmFuICovDQo+ICAJCXt9DQo+ICAJfTsNCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvYWNwaS9kcHRmL2RwdGZfcG93ZXIuYw0KPiBiL2RyaXZlcnMvYWNwaS9kcHRmL2RwdGZfcG93
ZXIuYw0KPiBpbmRleCAzODdmMjdlZjMzNjguLmU1ZmIzNGJmYTUyYyAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9hY3BpL2RwdGYvZHB0Zl9wb3dlci5jDQo+ICsrKyBiL2RyaXZlcnMvYWNwaS9kcHRm
L2RwdGZfcG93ZXIuYw0KPiBAQCAtOTcsNyArOTcsNyBAQCBzdGF0aWMgaW50IGRwdGZfcG93ZXJf
cmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYpDQo+ICB9DQo+ICANCj4gIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgYWNwaV9kZXZpY2VfaWQgaW50MzQwN19kZXZpY2VfaWRzW10gPSB7
DQo+IC0JeyJJTlQxMDQ3IiwgMH0sDQo+ICsJeyJJTlRDMTA0NyIsIDB9LA0KPiAgCXsiSU5UMzQw
NyIsIDB9LA0KPiAgCXsiIiwgMH0sDQo+ICB9Ow0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3Bp
L2RwdGYvaW50MzQweF90aGVybWFsLmMNCj4gYi9kcml2ZXJzL2FjcGkvZHB0Zi9pbnQzNDB4X3Ro
ZXJtYWwuYw0KPiBpbmRleCAxZWM3YjY5MDA2NjIuLjI5YjVjNzcyNTZkZCAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9hY3BpL2RwdGYvaW50MzQweF90aGVybWFsLmMNCj4gKysrIGIvZHJpdmVycy9h
Y3BpL2RwdGYvaW50MzQweF90aGVybWFsLmMNCj4gQEAgLTEzLDEwICsxMywxMCBAQA0KPiAgDQo+
ICAjZGVmaW5lIElOVDM0MDFfREVWSUNFIDBYMDENCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYWNw
aV9kZXZpY2VfaWQgaW50MzQweF90aGVybWFsX2RldmljZV9pZHNbXSA9IHsNCj4gLQl7IklOVDEw
NDAifSwNCj4gLQl7IklOVDEwNDMifSwNCj4gLQl7IklOVDEwNDQifSwNCj4gLQl7IklOVDEwNDci
fSwNCj4gKwl7IklOVEMxMDQwIn0sDQo+ICsJeyJJTlRDMTA0MyJ9LA0KPiArCXsiSU5UQzEwNDQi
fSwNCj4gKwl7IklOVEMxMDQ3In0sDQo+ICAJeyJJTlQzNDAwIn0sDQo+ICAJeyJJTlQzNDAxIiwg
SU5UMzQwMV9ERVZJQ0V9LA0KPiAgCXsiSU5UMzQwMiJ9LA0K
