Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29EC01C0080
	for <lists+linux-pm@lfdr.de>; Thu, 30 Apr 2020 17:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgD3Php (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Apr 2020 11:37:45 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:57199 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727898AbgD3Php (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Apr 2020 11:37:45 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03UFaai5008132;
        Thu, 30 Apr 2020 17:37:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=G2VY0D/ADCqWFsSs/1lED9meTOOFUKOIa2o5lzoA/nk=;
 b=kPPieGvWN9J3RQDgY/ilmSbtM8HvbM9xVO/fffcXB8sOqV+dtm3MNaBiAtRDjoVHgejm
 USEKX80/jfYQvpRG6cAjYh2nBJlcOIUxWxEgnxvslezzEPP3h7Vu0QIoK6QXxdjEYfvl
 U4ZtsRBP5rt+tsPRDPEaz27sM8ceg9s9fAruGc2y75sHObTKeKt1JWzO20x/ZYxPgdEM
 U0vENDiN29A+iTv08QzprbW8RPc0p8gZg2pRHMF+WTFVVz6UQxRAIDQzlpq6Rh4KR66I
 JC6kM6RQhecXuQSRgi6uBKHr1WhZOIovxW7vgrLu1xMU9VtKxZvasLpgJ29p4luEBCdp JQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30qst0av5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 17:37:19 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 999AF10002A;
        Thu, 30 Apr 2020 17:37:18 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5BBDB209ABC;
        Thu, 30 Apr 2020 17:37:18 +0200 (CEST)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 30 Apr
 2020 17:37:17 +0200
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Thu, 30 Apr 2020 17:37:17 +0200
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
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
Thread-Index: AQHWGi06wBgeAQBseECYOK/U7Qvw76iQJdAAgAACCYCAAAQ3AIABBseAgAAT0wCAAE7QgIAADU2AgAARzIA=
Date:   Thu, 30 Apr 2020 15:37:17 +0000
Message-ID: <a20c5214-211b-1f70-1162-57b32e60549b@st.com>
References: <20200424114058.21199-1-benjamin.gaignard@st.com>
 <7657495.QyJl4BcWH5@kreacher> <30cdecf9-703a-eb2b-7c2b-f1e21c805add@st.com>
 <70e743cf-b88e-346a-5114-939b8724c83d@arm.com>
 <6b5cde14-58b3-045d-9413-223e66b87bf0@st.com>
 <CAJZ5v0h6t6perZiibCWhEh1_V0pSXqFe-z22TFqH7KTFXYmqpQ@mail.gmail.com>
 <a234e123-6c15-8e58-8921-614b58ca24ca@st.com> <jhjtv11cabk.mognet@arm.com>
In-Reply-To: <jhjtv11cabk.mognet@arm.com>
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
Content-ID: <B39838E7E962D44DBB59FACAB98F5DDD@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-30_10:2020-04-30,2020-04-30 signatures=0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQoNCk9uIDQvMzAvMjAgNDozMyBQTSwgVmFsZW50aW4gU2NobmVpZGVyIHdyb3RlOg0KPiBPbiAz
MC8wNC8yMCAxNDo0NiwgQmVuamFtaW4gR0FJR05BUkQgd3JvdGU6DQo+Pj4gVGhhdCdzIG5vdCB3
aGF0IEkgbWVhbnQuDQo+Pj4NCj4+PiBJIHN1cHBvc2UgdGhhdCB0aGUgaW50ZXJydXB0IHByb2Nl
c3NpbmcgaW4gcXVlc3Rpb24gdGFrZXMgcGxhY2UgaW4NCj4+PiBwcm9jZXNzIGNvbnRleHQgYW5k
IHNvIHlvdSBtYXkgc2V0IHRoZSBsb3dlciBjbGFtcCBvbiB0aGUgdXRpbGl6YXRpb24NCj4+PiBv
ZiB0aGUgdGFzayBjYXJyeWluZyB0aGF0IG91dC4NCj4+IEkgaGF2ZSB0cnkgdG8gYWRkIHRoaXMg
Y29kZSB3aGVuIHN0YXJ0aW5nIHN0cmVhbWluZyAoYmVmb3JlIHRoZSBmaXJzdA0KPj4gaW50ZXJy
dXB0KSB0aGUgZnJhbWVzIGZyb20gdGhlIHNlbnNvcjoNCj4+IGNvbnN0IHN0cnVjdCBzY2hlZF9h
dHRyIHNjaGVkX2F0dHIgPSB7DQo+PiAgICAgLnNjaGVkX3V0aWxfbWluID0gMTAwMDAsIC8qIDEw
MCUgb2YgdXNhZ2UgKi8NCj4gVW5sZXNzIHlvdSBwbGF5IHdpdGggU0NIRURfQ0FQQUNJVFlfU0hJ
RlQsIHRoZSBtYXggc2hvdWxkIGJlIDEwMjQgLQ0KPiBpLmUuIFNDSEVEX0NBUEFDSVRZX1NDQUxF
LiBUaGF0J3MgYSByZWFsbHkgYmlnIGJvb3N0LCBidXQgdGhhdCdzIGZvciB5b3UgdG8NCj4gYmVu
Y2htYXJrLg0KPg0KPj4gICAgIC5zY2hlZF9mbGFncyA9IFNDSEVEX0ZMQUdfVVRJTF9DTEFNUF9N
SU4sDQo+PiAgICB9Ow0KPj4NCj4+IHNjaGVkX3NldGF0dHIoY3VycmVudCwgJnNjaGVkX2F0dHIp
Ow0KPj4NCj4+IEkgZG9uJ3Qgc2VlIGFueSBiZW5lZmljZXMgbWF5YmUgdGhlcmUgaXMgc29tZSBj
b25maWd1cmF0aW9uIGZsYWdzIHRvIHNldC4NCj4+DQo+PiBIb3cgY2hhbmdpbmcgc2NoZWRfdXRp
bF9taW4gY291bGQgaW1wYWN0IGNwdWZyZXEgb25kZW1hbmQgZ292ZXJub3IgPw0KPj4gRG9lcyBp
dCBjaGFuZ2UgdGhlIHZhbHVlIHJldHVybmVkIHdoZW4gdGhlIGdvdmVybm9yIGNoZWNrIHRoZSBp
ZGxlIHRpbWUgPw0KPj4NCj4gWW91J2xsIGhhdmUgdG8gdXNlIHRoZSBzY2hlZHV0aWwgZ292ZXJu
b3IgZm9yIHVjbGFtcCB0byBoYXZlIGFuIGVmZmVjdC4gQW5kDQo+IGFyZ3VhYmx5IHRoYXQncyB3
aGF0IHlvdSBzaG91bGQgYmUgdXNpbmcsIHVubGVzcyBzb21ldGhpbmcgZXhwbGljaXRseQ0KPiBw
cmV2ZW50cyB5b3UgZnJvbSBkb2luZyB0aGF0Lg0KRXZlbiB3aXRoIHNjaGVkdXRpbCBhbmQgU0NI
RURfQ0FQQUNJVFlfU0NBTEUgdGhhdCBpdCBkb2Vzbid0IHdvcmsuDQpjcHVmcmVxL2NwdWluZm9f
Y3VyX2ZyZXEgdmFsdWVzIGFyZSBhbHdheXMgb24gdGhlIG1heCB2YWx1ZSBldmVuIGlmIHRoZSAN
CnN0YXRzIHNob3cgdHJhbnNpdGlvbnMgYmV0d2VlbiB0aGUgYXZhaWxhYmxlIGZyZXF1ZW5jaWVz
Lg0KDQpJIHNlZSB0d28gcG9zc2libGVzIHJlYXNvbnMgdG8gZXhwbGFpbiB0aGF0Og0KLSBzY2hl
ZF9zZXRhdHRyKCkgaXMgY2FsbGVkIGluIHVzZXJsYW5kIHByb2Nlc3MgY29udGV4dCwgYnV0IHRo
ZSANCnRocmVhZGVkIGlycSBoYW5kbGVyIGlzIHJ1bm5pbmcgaW4gYW5vdGhlciBwcm9jZXNzLg0K
LSBiZWNhdXNlIHRoaXMgdXNlIGNhc2UgaXMgYWxtb3N0IHJ1bm5pbmcgYWxsIGluIGhhcmR3YXJl
IHRoZSBwcm9jZXNzIA0KaXNuJ3QgZG9pbmcgYW55dGhpbmcgc28gdGhlIHNjaGVkdWxlciBkb2Vz
bid0IHRha2UgY2FyZSBvZiBpdC4NCg0KPg0KPj4+IEFsdGVybmF0aXZlbHksIHRoYXQgdGFzayBt
YXkgYmUgYSBkZWFkbGluZSBvbmUuDQo=
