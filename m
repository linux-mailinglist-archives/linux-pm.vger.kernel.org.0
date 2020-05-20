Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7CE51DAC21
	for <lists+linux-pm@lfdr.de>; Wed, 20 May 2020 09:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgETHaA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 May 2020 03:30:00 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:33834 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726309AbgETHaA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 May 2020 03:30:00 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04K7R4l3030676;
        Wed, 20 May 2020 09:29:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=IMRVBLQ0AEUt0XOltEpT6Zor4zCeIp6mr6TUQS8qvRQ=;
 b=cdQjBZ/mX2n0JEfCgWFNEi0Ys1CBifFs7JeGaa4gCl4dwiy0eMdj61dfvmS9fcLraH5s
 edE75o7FWmIQ5Nud6pY5li2Ot+AbIMDDEEXgtkoe4dBXc7L8o8kebSKedmoJ1j1DWgAY
 TIcLaw/wCBOqpBI/CmtPmWoeEQDPrV4xDBkGVrp0vZKAWZZJGMUVchO/yBpG6BewyJQ9
 vqywWLgov7kYS5k/A4PYVSb80GSQk9F2g/rN+6m2760UJUVDjyPOgxs6U4b15a+oU34i
 OsGmCexT3UhxVJQJvOEvKDWVkEdosH3J696tHqcclxExOITXVvVzd7npEsQ17WEcUBzr uQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3125n3pn8g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 May 2020 09:29:38 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CC92A10002A;
        Wed, 20 May 2020 09:29:37 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AAB032A5671;
        Wed, 20 May 2020 09:29:37 +0200 (CEST)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 20 May
 2020 09:29:37 +0200
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Wed, 20 May 2020 09:29:37 +0200
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
CC:     "len.brown@intel.com" <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Patrick Bellasi" <patrick.bellasi@arm.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
Subject: Re: [Linux-stm32] [RFC 0/3] Introduce cpufreq minimum load QoS
Thread-Topic: [Linux-stm32] [RFC 0/3] Introduce cpufreq minimum load QoS
Thread-Index: AQHWGi06wBgeAQBseECYOK/U7Qvw76iQJdAAgAACCYCAAAQ3AIABBseAgAAT0wCAAE7QgIAADU2AgAARzICAAAO9AIAF2zaAgBkHbAA=
Date:   Wed, 20 May 2020 07:29:37 +0000
Message-ID: <d854844e-e651-5210-3e85-1be9f52d44d3@st.com>
References: <20200424114058.21199-1-benjamin.gaignard@st.com>
 <7657495.QyJl4BcWH5@kreacher> <30cdecf9-703a-eb2b-7c2b-f1e21c805add@st.com>
 <70e743cf-b88e-346a-5114-939b8724c83d@arm.com>
 <6b5cde14-58b3-045d-9413-223e66b87bf0@st.com>
 <CAJZ5v0h6t6perZiibCWhEh1_V0pSXqFe-z22TFqH7KTFXYmqpQ@mail.gmail.com>
 <a234e123-6c15-8e58-8921-614b58ca24ca@st.com> <jhjtv11cabk.mognet@arm.com>
 <a20c5214-211b-1f70-1162-57b32e60549b@st.com> <jhjmu6tc6rz.mognet@arm.com>
 <b8757472-c973-a32d-d5c9-a584d7d703f8@st.com>
In-Reply-To: <b8757472-c973-a32d-d5c9-a584d7d703f8@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.49]
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB271001AA377743824DE815E4C2B3FB@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-20_03:2020-05-19,2020-05-20 signatures=0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQoNCk9uIDUvNC8yMCAxMToxNyBBTSwgQmVuamFtaW4gR0FJR05BUkQgd3JvdGU6DQo+DQo+IE9u
IDQvMzAvMjAgNTo1MCBQTSwgVmFsZW50aW4gU2NobmVpZGVyIHdyb3RlOg0KPj4gT24gMzAvMDQv
MjAgMTY6MzcsIEJlbmphbWluIEdBSUdOQVJEIHdyb3RlOg0KPj4+IE9uIDQvMzAvMjAgNDozMyBQ
TSwgVmFsZW50aW4gU2NobmVpZGVyIHdyb3RlOg0KPj4+PiBPbiAzMC8wNC8yMCAxNDo0NiwgQmVu
amFtaW4gR0FJR05BUkQgd3JvdGU6DQo+Pj4+Pj4gVGhhdCdzIG5vdCB3aGF0IEkgbWVhbnQuDQo+
Pj4+Pj4NCj4+Pj4+PiBJIHN1cHBvc2UgdGhhdCB0aGUgaW50ZXJydXB0IHByb2Nlc3NpbmcgaW4g
cXVlc3Rpb24gdGFrZXMgcGxhY2UgaW4NCj4+Pj4+PiBwcm9jZXNzIGNvbnRleHQgYW5kIHNvIHlv
dSBtYXkgc2V0IHRoZSBsb3dlciBjbGFtcCBvbiB0aGUgdXRpbGl6YXRpb24NCj4+Pj4+PiBvZiB0
aGUgdGFzayBjYXJyeWluZyB0aGF0IG91dC4NCj4+Pj4+IEkgaGF2ZSB0cnkgdG8gYWRkIHRoaXMg
Y29kZSB3aGVuIHN0YXJ0aW5nIHN0cmVhbWluZyAoYmVmb3JlIHRoZSBmaXJzdA0KPj4+Pj4gaW50
ZXJydXB0KSB0aGUgZnJhbWVzIGZyb20gdGhlIHNlbnNvcjoNCj4+Pj4+IGNvbnN0IHN0cnVjdCBz
Y2hlZF9hdHRyIHNjaGVkX2F0dHIgPSB7DQo+Pj4+PiAgICAgICAuc2NoZWRfdXRpbF9taW4gPSAx
MDAwMCwgLyogMTAwJSBvZiB1c2FnZSAqLw0KPj4+PiBVbmxlc3MgeW91IHBsYXkgd2l0aCBTQ0hF
RF9DQVBBQ0lUWV9TSElGVCwgdGhlIG1heCBzaG91bGQgYmUgMTAyNCAtDQo+Pj4+IGkuZS4gU0NI
RURfQ0FQQUNJVFlfU0NBTEUuIFRoYXQncyBhIHJlYWxseSBiaWcgYm9vc3QsIGJ1dCB0aGF0J3Mg
Zm9yIHlvdSB0bw0KPj4+PiBiZW5jaG1hcmsuDQo+Pj4+DQo+Pj4+PiAgICAgICAuc2NoZWRfZmxh
Z3MgPSBTQ0hFRF9GTEFHX1VUSUxfQ0xBTVBfTUlOLA0KPj4+Pj4gICAgICB9Ow0KPj4+Pj4NCj4+
Pj4+IHNjaGVkX3NldGF0dHIoY3VycmVudCwgJnNjaGVkX2F0dHIpOw0KPj4+Pj4NCj4+Pj4+IEkg
ZG9uJ3Qgc2VlIGFueSBiZW5lZmljZXMgbWF5YmUgdGhlcmUgaXMgc29tZSBjb25maWd1cmF0aW9u
IGZsYWdzIHRvIHNldC4NCj4+Pj4+DQo+Pj4+PiBIb3cgY2hhbmdpbmcgc2NoZWRfdXRpbF9taW4g
Y291bGQgaW1wYWN0IGNwdWZyZXEgb25kZW1hbmQgZ292ZXJub3IgPw0KPj4+Pj4gRG9lcyBpdCBj
aGFuZ2UgdGhlIHZhbHVlIHJldHVybmVkIHdoZW4gdGhlIGdvdmVybm9yIGNoZWNrIHRoZSBpZGxl
IHRpbWUgPw0KPj4+Pj4NCj4+Pj4gWW91J2xsIGhhdmUgdG8gdXNlIHRoZSBzY2hlZHV0aWwgZ292
ZXJub3IgZm9yIHVjbGFtcCB0byBoYXZlIGFuIGVmZmVjdC4gQW5kDQo+Pj4+IGFyZ3VhYmx5IHRo
YXQncyB3aGF0IHlvdSBzaG91bGQgYmUgdXNpbmcsIHVubGVzcyBzb21ldGhpbmcgZXhwbGljaXRs
eQ0KPj4+PiBwcmV2ZW50cyB5b3UgZnJvbSBkb2luZyB0aGF0Lg0KPj4+IEV2ZW4gd2l0aCBzY2hl
ZHV0aWwgYW5kIFNDSEVEX0NBUEFDSVRZX1NDQUxFIHRoYXQgaXQgZG9lc24ndCB3b3JrLg0KPj4+
IGNwdWZyZXEvY3B1aW5mb19jdXJfZnJlcSB2YWx1ZXMgYXJlIGFsd2F5cyBvbiB0aGUgbWF4IHZh
bHVlIGV2ZW4gaWYgdGhlDQo+Pj4gc3RhdHMgc2hvdyB0cmFuc2l0aW9ucyBiZXR3ZWVuIHRoZSBh
dmFpbGFibGUgZnJlcXVlbmNpZXMuDQo+Pj4NCj4+PiBJIHNlZSB0d28gcG9zc2libGVzIHJlYXNv
bnMgdG8gZXhwbGFpbiB0aGF0Og0KPj4+IC0gc2NoZWRfc2V0YXR0cigpIGlzIGNhbGxlZCBpbiB1
c2VybGFuZCBwcm9jZXNzIGNvbnRleHQsIGJ1dCB0aGUNCj4+PiB0aHJlYWRlZCBpcnEgaGFuZGxl
ciBpcyBydW5uaW5nIGluIGFub3RoZXIgcHJvY2Vzcy4NCj4+IEFoIHllcywgdGhpcyBvbmx5IHdv
cmtzIGlmIHRoZSB0YXNrIHlvdSBib29zdCBpcyB0aGUgb25lIHRoYXQgd2lsbCBoYW5kbGUNCj4+
IHdoYXRldmVyIHdvcmsgeW91IGNhcmUgYWJvdXQgKGluIHRoaXMgY2FzZSBoYW5kbGluZyB0aGUg
aXJxKS4gVGhhdCBzYWlkLCBpZg0KPj4geW91IGRvIHVzZSB0aHJlYWRlZCBJUlFzLCB0aGF0IHNo
b3VsZCBnaXZlIHlvdSBhIFNDSEVEX0ZJRk8gdGhyZWFkLCB3aGljaA0KPj4gc2hvdWxkIGRyaXZl
IHRoZSBmcmVxdWVuY3kgdG8gaXRzIG1heCB3aGVuIHVzaW5nIHNjaGVkdXRpbCAodW5yZWxhdGVk
IHRvDQo+PiB1Y2xhbXApLg0KPiBDYW4gSSBjb25jbHVkZSB0aGF0IHNjaGVkX3NldGF0dHIoKSBp
c24ndCB0aGUgZ29vZCB3YXkgdG8gc29sdmUgdGhpcw0KPiBwcm9ibGVtID8NCj4gRG9lcyBteSBw
YXRjaGVzIG1ha2Ugc2Vuc2UgaW4gdGhpcyBjYXNlID8NCkdlbnRsZSB1cCBvbiB0aGlzIHNlcmll
cyBiZWFjYXVzZSBJIGhhdmVuJ3QgZm91bmQgYW55IG90aGVyIHdheSB0byBzb2x2ZQ0KdGhpcyBw
cm9ibGVtLg0KDQpUaGFua3MsDQpCZW5qYW1pbg0KPg0KPj4+IC0gYmVjYXVzZSB0aGlzIHVzZSBj
YXNlIGlzIGFsbW9zdCBydW5uaW5nIGFsbCBpbiBoYXJkd2FyZSB0aGUgcHJvY2Vzcw0KPj4+IGlz
bid0IGRvaW5nIGFueXRoaW5nIHNvIHRoZSBzY2hlZHVsZXIgZG9lc24ndCB0YWtlIGNhcmUgb2Yg
aXQuDQo+Pj4NCj4+Pj4+PiBBbHRlcm5hdGl2ZWx5LCB0aGF0IHRhc2sgbWF5IGJlIGEgZGVhZGxp
bmUgb25lLg0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xw0KPiBMaW51eC1zdG0zMiBtYWlsaW5nIGxpc3QNCj4gTGludXgtc3RtMzJAc3QtbWQtbWFpbG1h
bi5zdG9ybXJlcGx5LmNvbQ0KPiBodHRwczovL3N0LW1kLW1haWxtYW4uc3Rvcm1yZXBseS5jb20v
bWFpbG1hbi9saXN0aW5mby9saW51eC1zdG0zMg0K
