Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 319F918BBDB
	for <lists+linux-pm@lfdr.de>; Thu, 19 Mar 2020 17:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgCSQFj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Mar 2020 12:05:39 -0400
Received: from mga14.intel.com ([192.55.52.115]:40198 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727064AbgCSQFj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 19 Mar 2020 12:05:39 -0400
IronPort-SDR: 8Hb7Gq5+oNEkc2vPf2EEZ/tG3gAW/6DYzkoHss3KfQhQ47S42z1EuSC5Saa6iRmvlE/torvLGi
 +ZFKcKacDSrw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2020 09:05:38 -0700
IronPort-SDR: MoWESmmDIXZvjXZADrKibhRZguiebDcaVDAUk8iXZd82/U7AfVrct6aK+xsjixtmhF0iIbZR5i
 5bY61w+DO0tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,572,1574150400"; 
   d="scan'208";a="238524514"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by fmsmga008.fm.intel.com with ESMTP; 19 Mar 2020 09:05:36 -0700
Received: from orsmsx157.amr.corp.intel.com (10.22.240.23) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 19 Mar 2020 09:05:35 -0700
Received: from orsmsx109.amr.corp.intel.com ([169.254.11.100]) by
 ORSMSX157.amr.corp.intel.com ([169.254.9.107]) with mapi id 14.03.0439.000;
 Thu, 19 Mar 2020 09:05:35 -0700
From:   "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tiwai@suse.de" <tiwai@suse.de>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] thermal: int340x_thermal: Use scnprintf() for avoiding
 potential buffer overflow
Thread-Topic: [PATCH] thermal: int340x_thermal: Use scnprintf() for avoiding
 potential buffer overflow
Thread-Index: AQHV/gg5v+dwf+2hGkaxl09cvG/2sQ==
Date:   Thu, 19 Mar 2020 16:05:34 +0000
Message-ID: <d35022db86c4abd69bb1a2c3a0c8a25e35b69258.camel@intel.com>
References: <20200311092718.24052-1-tiwai@suse.de>
         <s5hfte4uyx1.wl-tiwai@suse.de>
In-Reply-To: <s5hfte4uyx1.wl-tiwai@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.2 (3.34.2-1.fc31) 
x-originating-ip: [10.212.144.114]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5DA5F0473334540BEC4EF1FB45C1BF8@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gVGh1LCAyMDIwLTAzLTE5IGF0IDE2OjUwICswMTAwLCBUYWthc2hpIEl3YWkgd3JvdGU6DQo+
IE9uIFdlZCwgMTEgTWFyIDIwMjAgMTA6Mjc6MTggKzAxMDAsDQo+IFRha2FzaGkgSXdhaSB3cm90
ZToNCj4gPiBTaW5jZSBzbnByaW50ZigpIHJldHVybnMgdGhlIHdvdWxkLWJlLW91dHB1dCBzaXpl
IGluc3RlYWQgb2YgdGhlDQo+ID4gYWN0dWFsIG91dHB1dCBzaXplLCB0aGUgc3VjY2VlZGluZyBj
YWxscyBtYXkgZ28gYmV5b25kIHRoZSBnaXZlbg0KPiA+IGJ1ZmZlciBsaW1pdC4gIEZpeCBpdCBi
eSByZXBsYWNpbmcgd2l0aCBzY25wcmludGYoKS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBU
YWthc2hpIEl3YWkgPHRpd2FpQHN1c2UuZGU+DQo+IA0KUmV2aWV3ZWQtYnk6IFBhbmRydXZhZGEs
IFNyaW5pdmFzIDxzcmluaXZhcy5wYW5kcnV2YWRhQGxpbnV4LmludGVsLmNvbT4NCg0KPiBBIGdl
bnRsZSByZW1pbmRlciBmb3IgdGhpcyBmb3Jnb3R0ZW4gcGF0Y2guDQo+IExldCBtZSBrbm93IGlm
IGFueSBmdXJ0aGVyIGNoYW5nZSBpcyBuZWVkZWQuDQo+IA0KPiANCj4gdGhhbmtzLA0KPiANCj4g
VGFrYXNoaQ0KPiANCj4gPiAtLS0NCj4gPiAgZHJpdmVycy90aGVybWFsL2ludGVsL2ludDM0MHhf
dGhlcm1hbC9pbnQzNDAwX3RoZXJtYWwuYyB8IDIgKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEv
ZHJpdmVycy90aGVybWFsL2ludGVsL2ludDM0MHhfdGhlcm1hbC9pbnQzNDAwX3RoZXJtYWwuYw0K
PiA+IGIvZHJpdmVycy90aGVybWFsL2ludGVsL2ludDM0MHhfdGhlcm1hbC9pbnQzNDAwX3RoZXJt
YWwuYw0KPiA+IGluZGV4IGVmYWUwYzAyZDg5OC4uNTI5ZGY3MTc0MjM5IDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvdGhlcm1hbC9pbnRlbC9pbnQzNDB4X3RoZXJtYWwvaW50MzQwMF90aGVybWFs
LmMNCj4gPiArKysgYi9kcml2ZXJzL3RoZXJtYWwvaW50ZWwvaW50MzQweF90aGVybWFsL2ludDM0
MDBfdGhlcm1hbC5jDQo+ID4gQEAgLTY1LDcgKzY1LDcgQEAgc3RhdGljIHNzaXplX3QgYXZhaWxh
YmxlX3V1aWRzX3Nob3coc3RydWN0IGRldmljZQ0KPiA+ICpkZXYsDQo+ID4gIAlmb3IgKGkgPSAw
OyBpIDwgSU5UMzQwMF9USEVSTUFMX01BWElNVU1fVVVJRDsgaSsrKSB7DQo+ID4gIAkJaWYgKHBy
aXYtPnV1aWRfYml0bWFwICYgKDEgPDwgaSkpDQo+ID4gIAkJCWlmIChQQUdFX1NJWkUgLSBsZW5n
dGggPiAwKQ0KPiA+IC0JCQkJbGVuZ3RoICs9IHNucHJpbnRmKCZidWZbbGVuZ3RoXSwNCj4gPiAr
CQkJCWxlbmd0aCArPSBzY25wcmludGYoJmJ1ZltsZW5ndGhdLA0KPiA+ICAJCQkJCQkgICBQQUdF
X1NJWkUgLSBsZW5ndGgsDQo+ID4gIAkJCQkJCSAgICIlc1xuIiwNCj4gPiAgCQkJCQkJICAgaW50
MzQwMF90aGVybWFsX3V1aWQNCj4gPiBzW2ldKTsNCj4gPiAtLSANCj4gPiAyLjE2LjQNCj4gPiAN
Cg==
