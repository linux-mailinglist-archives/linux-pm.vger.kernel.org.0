Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4417B1A720F
	for <lists+linux-pm@lfdr.de>; Tue, 14 Apr 2020 05:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbgDND6d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Apr 2020 23:58:33 -0400
Received: from mga09.intel.com ([134.134.136.24]:28404 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728295AbgDND6d (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 Apr 2020 23:58:33 -0400
IronPort-SDR: mVizNHimP+AA0W3IDIwixoCC4+MzhRyTMhb/1oedvcxiLuCdZi73c1a2qfzsVb088Zz9UMWgKa
 KPmgkrewzdCQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 20:58:32 -0700
IronPort-SDR: JseA+t55qyGfgktfkjwhkxM3T7at/tzuRb3HlUAVR/pCbOrzGjjpgoCpsQS6571lHNNUkSbkLF
 TnIGNDBL8oxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,381,1580803200"; 
   d="scan'208";a="363260045"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by fmsmga001.fm.intel.com with ESMTP; 13 Apr 2020 20:58:32 -0700
Received: from orsmsx125.amr.corp.intel.com (10.22.240.125) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 13 Apr 2020 20:58:32 -0700
Received: from orsmsx109.amr.corp.intel.com ([169.254.11.20]) by
 ORSMSX125.amr.corp.intel.com ([169.254.3.103]) with mapi id 14.03.0439.000;
 Mon, 13 Apr 2020 20:58:32 -0700
From:   "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To:     "mjg59@google.com" <mjg59@google.com>
CC:     "Zhang, Rui" <rui.zhang@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Aram, Nisha" <nisha.aram@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 1/3] thermal/int340x_thermal: Export GDDV
Thread-Topic: [PATCH V2 1/3] thermal/int340x_thermal: Export GDDV
Thread-Index: AQHWEhD2NMV5m6DKX0a90M6geYk4vA==
Date:   Tue, 14 Apr 2020 03:58:31 +0000
Message-ID: <9f6bf5e6261f2a7dac6c4413ac54a1cf4315e3e7.camel@intel.com>
References: <20200414020953.255364-1-matthewgarrett@google.com>
         <1ba40c555115e5a2770e95b974096016fbfc3606.camel@intel.com>
         <CACdnJut0MkQerQbMeaqDz81iaeQRvdgqw2MpTvNOi_1ch06qGw@mail.gmail.com>
In-Reply-To: <CACdnJut0MkQerQbMeaqDz81iaeQRvdgqw2MpTvNOi_1ch06qGw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.3 (3.34.3-1.fc31) 
x-originating-ip: [10.251.1.193]
Content-Type: text/plain; charset="utf-8"
Content-ID: <922D928C5F27B348AD9EB342C3FE71F3@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gTW9uLCAyMDIwLTA0LTEzIGF0IDIwOjUzIC0wNzAwLCBNYXR0aGV3IEdhcnJldHQgd3JvdGU6
DQo+IE9uIE1vbiwgQXByIDEzLCAyMDIwIGF0IDg6MzMgUE0gUGFuZHJ1dmFkYSwgU3Jpbml2YXMN
Cj4gPHNyaW5pdmFzLnBhbmRydXZhZGFAaW50ZWwuY29tPiB3cm90ZToNCj4gPiBBbnl0aGluZyBj
aGFuZ2VkIGluIHYyIHNlcmllcz8NCj4gDQo+IFNvcnJ5LCBmb3Jnb3QgdG8gZXhwbGFpbiB0aGUg
ZGlmZnMuIFBhdGNoIDIgaW4gVjIgd2FzIHBhc3NpbmcgdGhlDQo+IHdyb25nIHZhbHVlIHRvIHN5
c2ZzX2F0dHJfaW5pdCgpLCBidXQgSSBkaWRuJ3Qgbm90aWNlIGR1cmluZyB0ZXN0aW5nDQo+IGJl
Y2F1c2UgdGhhdCdzIGEgbWFjcm8gdGhhdCBkb2VzIG5vdGhpbmcgdW5sZXNzIGEgc3BlY2lmaWMg
ZGVidWcgZmxhZw0KPiBpcyBzZXQuIFRoZSBrZXJuZWwgYnVpbGQgYm90IG5vdGljZWQuIE9ubHkg
ZGlmZmVyZW5jZSBpcyBwYXNzaW5nIHRoZQ0KPiBjb3JyZWN0IGFyZ3VtZW50IHRoZXJlLg0KVGhh
bmtzLg0KSSB3aWxsIGdpdmUgYSB0cnkgbmV4dCB3ZWVrLg0KDQotU3Jpbml2YXMNCg==
