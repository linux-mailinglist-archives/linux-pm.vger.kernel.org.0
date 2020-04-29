Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D71D1BE338
	for <lists+linux-pm@lfdr.de>; Wed, 29 Apr 2020 17:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbgD2P5r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Apr 2020 11:57:47 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:7758 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726423AbgD2P5r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Apr 2020 11:57:47 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03TFuuIM025268;
        Wed, 29 Apr 2020 17:57:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=eCkbsHOC25FPIY1TTTZpD48jm9gXnoWIY4Y9Jr6sfic=;
 b=e53jiOwYKO+LkzbBqboM45RGmMiiNkfaPP7dB0FnECk37XNxJDKYXKJMGbOfKFUYwjSE
 8dP5SR4YDXAyTNwQ4NxhiLrUCZAJF+Zafkjf+cRlDYacMCuo4H+eonM8wdy2r+K550a2
 3nFsUM0ABpsrSC4gLE9tnea1Xbm7+7dUF43as0cNgn5S7Xi728/+i69xr9UFwX2suOkI
 WPeluJ/H57/IfWNpu8ApMehPvf06gWc96+I9LdK3rupRqwMHzisCxjgqIJXAyKIkLWgo
 hWxeqVIMJtMv8osZYnjXx5lT84OGwDv95LYkAsV05mYwPN18/i2JqFczglp3t7YKtgLm rA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30mhq67a5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Apr 2020 17:57:23 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 579AF100034;
        Wed, 29 Apr 2020 17:57:22 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1E9D52AD2DB;
        Wed, 29 Apr 2020 17:57:22 +0200 (CEST)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 29 Apr
 2020 17:57:21 +0200
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Wed, 29 Apr 2020 17:57:21 +0200
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        Hugues FRUCHET <hugues.fruchet@st.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [RFC 0/3] Introduce cpufreq minimum load QoS
Thread-Topic: [RFC 0/3] Introduce cpufreq minimum load QoS
Thread-Index: AQHWGi06wBgeAQBseECYOK/U7Qvw76iQJdAAgAACCYA=
Date:   Wed, 29 Apr 2020 15:57:21 +0000
Message-ID: <30cdecf9-703a-eb2b-7c2b-f1e21c805add@st.com>
References: <20200424114058.21199-1-benjamin.gaignard@st.com>
 <7657495.QyJl4BcWH5@kreacher>
In-Reply-To: <7657495.QyJl4BcWH5@kreacher>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.51]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C0367D8B3A5F0840A331F12D91CA5561@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-29_08:2020-04-29,2020-04-29 signatures=0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQoNCk9uIDQvMjkvMjAgNTo1MCBQTSwgUmFmYWVsIEouIFd5c29ja2kgd3JvdGU6DQo+IE9uIEZy
aWRheSwgQXByaWwgMjQsIDIwMjAgMTo0MDo1NSBQTSBDRVNUIEJlbmphbWluIEdhaWduYXJkIHdy
b3RlOg0KPj4gV2hlbiBzdGFydCBzdHJlYW1pbmcgZnJvbSB0aGUgc2Vuc29yIHRoZSBDUFUgbG9h
ZCBjb3VsZCByZW1haW4gdmVyeSBsb3cNCj4+IGJlY2F1c2UgYWxtb3N0IGFsbCB0aGUgY2FwdHVy
ZSBwaXBlbGluZSBpcyBkb25lIGluIGhhcmR3YXJlIChpLmUuIHdpdGhvdXQNCj4+IHVzaW5nIHRo
ZSBDUFUpIGFuZCBsZXQgYmVsaWV2ZSB0byBjcHVmcmVxIGdvdmVybm9yIHRoYXQgaXQgY291bGQg
dXNlIGxvd2VyDQo+PiBmcmVxdWVuY2llcy4gSWYgdGhlIGdvdmVybm9yIGRlY2lkZXMgdG8gdXNl
IGEgdG9vIGxvdyBmcmVxdWVuY3kgdGhhdA0KPj4gYmVjb21lcyBhIHByb2JsZW0gd2hlbiB3ZSBu
ZWVkIHRvIGFja25vd2xlZGdlIHRoZSBpbnRlcnJ1cHQgZHVyaW5nIHRoZQ0KPj4gYmxhbmtpbmcg
dGltZS4NCj4+IFRoZSBkZWxheSB0byBhY2sgdGhlIGludGVycnVwdCBhbmQgcGVyZm9ybSBhbGwg
dGhlIG90aGVyIGFjdGlvbnMgYmVmb3JlDQo+PiB0aGUgbmV4dCBmcmFtZSBpcyB2ZXJ5IHNob3J0
IGFuZCBkb2Vzbid0IGFsbG93IHRvIHRoZSBjcHVmcmVxIGdvdmVybm9yIHRvDQo+PiBwcm92aWRl
IHRoZSByZXF1aXJlZCBidXJzdCBvZiBwb3dlci4gVGhhdCBsZWQgdG8gZHJvcCB0aGUgaGFsZiBv
ZiB0aGUgZnJhbWVzLg0KPj4NCj4+IFRvIGF2b2lkIHRoaXMgcHJvYmxlbSwgRENNSSBkcml2ZXIg
aW5mb3JtcyB0aGUgY3B1ZnJlcSBnb3Zlcm5vcnMgYnkgYWRkaW5nDQo+PiBhIGNwdWZyZXEgbWlu
aW11bSBsb2FkIFFvUyByZXNxdWVzdC4NCj4gVGhpcyBzZWVtcyB0byBiZSBhZGRyZXNzaW5nIGEg
dXNlIGNhc2UgdGhhdCBjYW4gYmUgYWRkcmVzc2VkIHdpdGggdGhlIGhlbHAgb2YNCj4gdXRpbGl6
YXRpb24gY2xhbXBzIHdpdGggbGVzcyBwb3dlciBvdmVyaGVhZC4NCkRvIG1lYW4gY2xhbXBpbmcg
dGhlIHBvbGljeSBmcmVxdWVuY2llcyA/IEkgbWF5IGhhdmUgbWlzcyB0aGUgQVBJIHRvIGRvIA0K
dGhhdC4uLg0KPg0KPiBUaGFua3MhDQo+DQo+DQo+DQo=
