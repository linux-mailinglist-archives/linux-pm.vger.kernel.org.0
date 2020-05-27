Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66BE61E4679
	for <lists+linux-pm@lfdr.de>; Wed, 27 May 2020 16:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388931AbgE0Oye (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 May 2020 10:54:34 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:32914 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388738AbgE0Oye (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 May 2020 10:54:34 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04REm9eF021938;
        Wed, 27 May 2020 16:54:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=+pa5HDE8S2P7eZEDEvB589bMp1LTGjav2rvU/0Z9yls=;
 b=akG+HuPdK3aWbp3HVqB15fhzua5+NP3RKh7gWn0ovyl5pqiUlJjukwlPhihcGzZ1KqNm
 7Ie7ykioB4VC3kcL/fKQGHa4/UR6wujp2xx0XkBf+MDKsuhAMWaoTU+wLnP9fzmtgsxd
 5XtwiYrBmBYx53W43KW/i6HsaQbdtX5lT40TsCl3fcfk6rt9w8fnlkuVKfYaojFR9EMM
 7LL2kHLP7k7X5b4elsFYfnc2iR3cMy7dOYz7NcoOYRgnuCHNJ2CDTRVkQ+66+4UCqlAN
 qEED7QCFyO8Ix5xV1hABikfNoF55yOeVS6Cqp+FZFBdoAUMRF44T+cFjMRHMh9u+IVwE sQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 316sa26b2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 May 2020 16:54:11 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1231410002A;
        Wed, 27 May 2020 16:54:11 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E8C012BF9AF;
        Wed, 27 May 2020 16:54:10 +0200 (CEST)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 May
 2020 16:54:10 +0200
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Wed, 27 May 2020 16:54:10 +0200
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
CC:     Valentin Schneider <valentin.schneider@arm.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
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
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC RESEND 0/3] Introduce cpufreq minimum load QoS
Thread-Topic: [RFC RESEND 0/3] Introduce cpufreq minimum load QoS
Thread-Index: AQHWM3CeA6bTrCFpTUymlrJxXTw8j6i7lUyAgAATBICAABI/gIAAB1gAgAAjCoA=
Date:   Wed, 27 May 2020 14:54:10 +0000
Message-ID: <fe69390f-ea8c-b6e3-7610-d6bd73e8500d@st.com>
References: <20200526151619.8779-1-benjamin.gaignard@st.com>
 <jhjk10xu1tq.mognet@arm.com> <ab4340c0-bda3-e752-9073-e162e6325bb1@st.com>
 <CAKfTPtBt6Ju-CnETnn6_FkgR0CAJ+jYnySz9OHP9X2hmxWHM7w@mail.gmail.com>
 <51917583-f8ff-3933-7783-2eedc91484a4@st.com>
In-Reply-To: <51917583-f8ff-3933-7783-2eedc91484a4@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B4421090511CA045BA0A372BCCB072C0@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-27_03:2020-05-27,2020-05-27 signatures=0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQoNCk9uIDUvMjcvMjAgMjo0OCBQTSwgQmVuamFtaW4gR0FJR05BUkQgd3JvdGU6DQo+DQo+DQo+
IE9uIDUvMjcvMjAgMjoyMiBQTSwgVmluY2VudCBHdWl0dG90IHdyb3RlOg0KPj4gT24gV2VkLCAy
NyBNYXkgMjAyMCBhdCAxMzoxNywgQmVuamFtaW4gR0FJR05BUkQNCj4+IDxiZW5qYW1pbi5nYWln
bmFyZEBzdC5jb20+IHdyb3RlOg0KPj4+DQo+Pj4NCj4+PiBPbiA1LzI3LzIwIDEyOjA5IFBNLCBW
YWxlbnRpbiBTY2huZWlkZXIgd3JvdGU6DQo+Pj4+IEhpIEJlbmphbWluLA0KPj4+Pg0KPj4+PiBP
biAyNi8wNS8yMCAxNjoxNiwgQmVuamFtaW4gR2FpZ25hcmQgd3JvdGU6DQo+Pj4+PiBBIGZpcnN0
IHJvdW5kIFsxXSBvZiBkaXNjdXNzaW9ucyBhbmQgc3VnZ2VzdGlvbnMgaGF2ZSBhbHJlYWR5IGJl
IA0KPj4+Pj4gZG9uZSBvbg0KPj4+Pj4gdGhpcyBzZXJpZXMgYnV0IHdpdGhvdXQgZm91bmQgYSBz
b2x1dGlvbiB0byB0aGUgcHJvYmxlbS4gSSByZXNlbmQgDQo+Pj4+PiBpdCB0bw0KPj4+Pj4gcHJv
Z3Jlc3Mgb24gdGhpcyB0b3BpYy4NCj4+Pj4+DQo+Pj4+IEFwb2xvZ2llcyBmb3Igc2xlZXBpbmcg
b24gdGhhdCBwcmV2aW91cyB0aHJlYWQuDQo+Pj4+DQo+Pj4+IFNvIHdoYXQgaGFkIGJlZW4gc3Vn
Z2VzdGVkIG92ZXIgdGhlcmUgd2FzIHRvIHVzZSB1Y2xhbXAgdG8gYm9vc3QgdGhlDQo+Pj4+IGZy
ZXF1ZW5jeSBvZiB0aGUgaGFuZGxpbmcgdGhyZWFkOyBob3dldmVyIGlmIHlvdSB1c2UgdGhyZWFk
ZWQgSVJRcyB5b3UNCj4+Pj4gZ2V0IFJUIHRocmVhZHMsIHdoaWNoIGFscmVhZHkgZ2V0IHRoZSBt
YXggZnJlcXVlbmN5IGJ5IGRlZmF1bHQgKGF0IA0KPj4+PiBsZWFzdA0KPj4+PiB3aXRoIHNjaGVk
dXRpbCkuDQo+Pj4+DQo+Pj4+IERvZXMgdGhhdCBub3Qgd29yayBmb3IgeW91LCBhbmQgaWYgc28s
IHdoeT8NCj4+PiBUaGF0IGRvZXNuJ3Qgd29yayBiZWNhdXNlIGFsbW9zdCBldmVyeXRoaW5nIGlz
IGRvbmUgYnkgdGhlIGhhcmR3YXJlIA0KPj4+IGJsb2Nrcw0KPj4+IHdpdGhvdXQgY2hhcmdlIHRo
ZSBDUFUgc28gdGhlIHRocmVhZCBpc24ndCBydW5uaW5nLiBJIGhhdmUgZG9uZSB0aGUNCj4+PiB0
ZXN0cyB3aXRoIHNjaGVkdXRpbA0KPj4+IGFuZCBvbmRlbWFuZCBzY2hlZHVsZXIgKHdoaWNoIGlz
IHRoZSBvbmUgSSdtIHRhcmdldGluZykuIEkgaGF2ZSBubw0KPj4+IGlzc3VlcyB3aGVuIHVzaW5n
DQo+Pj4gcGVyZm9ybWFuY2Ugc2NoZWR1bGVyIGJlY2F1c2UgaXQgYWx3YXlzIGtlZXAgdGhlIGhp
Z2hlc3QgZnJlcXVlbmNpZXMuDQo+PiBJTUhPLCB0aGUgb25seSB3YXkgdG8gZW5zdXJlIGEgbWlu
IGZyZXF1ZW5jeSBmb3IgYW55dGhpbmcgZWxzZSB0aGFuIGENCj4+IHRocmVhZCBpcyB0byB1c2Ug
ZnJlcV9xb3NfYWRkX3JlcXVlc3QoKSBqdXN0IGxpa2UgY3B1ZnJlcSBjb29saW5nDQo+PiBkZXZp
Y2UgYnV0IGZvciB0aGUgb3Bwb3NpdGUgUW9TLiBUaGlzIGNhbiBiZSBhcHBsaWVkIG9ubHkgb24g
dGhlDQo+PiBmcmVxdWVuY3kgZG9tYWluIG9mIHRoZSBDUFUgd2hpY2ggaGFuZGxlcyB0aGUgaW50
ZXJydXB0Lg0KPiBJIHdpbGwgZ2l2ZSBhIHRyeSB3aXRoIHRoaXMgaWRlYS4NCj4gVGhhbmtzLg0K
DQpBZGRpbmcgZnJlcV9xb3NfYWRkX3JlcXVlc3QoRlJFUV9RT1NfTUlOKSB3aGVuIHN0YXJ0aW5n
IHN0cmVhbWluZyBmcmFtZXMNCnNvbHZlIG15IHByb2JsZW0uIEkgcmVtb3ZlIHRoZSByZXF1ZXN0
IGF0IHRoZSBlbmQgb2YgdGhlIHN0cmVhbWluZyB0byANCnJlc3RvcmUNCnRoZSBkZWZhdWx0IHZh
bHVlLg0KDQpCZW5qYW1pbg0KDQoNCj4+IEhhdmUgeW91IGFsc28gY2hlY2tlZCB0aGUgd2FrZXVw
IGxhdGVuY3kgb2YgeW91ciBpZGxlIHN0YXRlID8NCj4gSXQganVzdCBjb3VsZCBnbyBpbiBXRkkg
c28gbGF0ZW5jeSBzaG91bGQgYmUgbWluaW1hbC4NCj4+DQo+Pj4NCj4+Pj4+IFdoZW4gc3RhcnQg
c3RyZWFtaW5nIGZyb20gdGhlIHNlbnNvciB0aGUgQ1BVIGxvYWQgY291bGQgcmVtYWluIA0KPj4+
Pj4gdmVyeSBsb3cNCj4+Pj4+IGJlY2F1c2UgYWxtb3N0IGFsbCB0aGUgY2FwdHVyZSBwaXBlbGlu
ZSBpcyBkb25lIGluIGhhcmR3YXJlIChpLmUuIA0KPj4+Pj4gd2l0aG91dA0KPj4+Pj4gdXNpbmcg
dGhlIENQVSkgYW5kIGxldCBiZWxpZXZlIHRvIGNwdWZyZXEgZ292ZXJub3IgdGhhdCBpdCBjb3Vs
ZCANCj4+Pj4+IHVzZSBsb3dlcg0KPj4+Pj4gZnJlcXVlbmNpZXMuIElmIHRoZSBnb3Zlcm5vciBk
ZWNpZGVzIHRvIHVzZSBhIHRvbyBsb3cgZnJlcXVlbmN5IHRoYXQNCj4+Pj4+IGJlY29tZXMgYSBw
cm9ibGVtIHdoZW4gd2UgbmVlZCB0byBhY2tub3dsZWRnZSB0aGUgaW50ZXJydXB0IGR1cmluZyAN
Cj4+Pj4+IHRoZQ0KPj4+Pj4gYmxhbmtpbmcgdGltZS4NCj4+Pj4+IFRoZSBkZWxheSB0byBhY2sg
dGhlIGludGVycnVwdCBhbmQgcGVyZm9ybSBhbGwgdGhlIG90aGVyIGFjdGlvbnMgDQo+Pj4+PiBi
ZWZvcmUNCj4+Pj4+IHRoZSBuZXh0IGZyYW1lIGlzIHZlcnkgc2hvcnQgYW5kIGRvZXNuJ3QgYWxs
b3cgdG8gdGhlIGNwdWZyZXEgDQo+Pj4+PiBnb3Zlcm5vciB0bw0KPj4+Pj4gcHJvdmlkZSB0aGUg
cmVxdWlyZWQgYnVyc3Qgb2YgcG93ZXIuIFRoYXQgbGVkIHRvIGRyb3AgdGhlIGhhbGYgb2YgDQo+
Pj4+PiB0aGUgZnJhbWVzLg0KPj4+Pj4NCj4+Pj4+IFRvIGF2b2lkIHRoaXMgcHJvYmxlbSwgRENN
SSBkcml2ZXIgaW5mb3JtcyB0aGUgY3B1ZnJlcSBnb3Zlcm5vcnMgDQo+Pj4+PiBieSBhZGRpbmcN
Cj4+Pj4+IGEgY3B1ZnJlcSBtaW5pbXVtIGxvYWQgUW9TIHJlc3F1ZXN0Lg0KPj4+Pj4NCj4+Pj4+
IEJlbmphbWluDQo+Pj4+Pg0KPj4+Pj4gWzFdIGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDIwLzQv
MjQvMzYwDQo+Pj4+Pg0KPj4+Pj4gQmVuamFtaW4gR2FpZ25hcmQgKDMpOg0KPj4+Pj4gwqDCoMKg
IFBNOiBRb1M6IEludHJvZHVjZSBjcHVmcmVxIG1pbmltdW0gbG9hZCBRb1MNCj4+Pj4+IMKgwqDC
oCBjcHVmcmVxOiBnb3Zlcm5vcjogVXNlIG1pbmltdW0gbG9hZCBRb1MNCj4+Pj4+IMKgwqDCoCBt
ZWRpYTogc3RtMzItZGNtaTogSW5mb3JtIGNwdWZyZXEgZ292ZXJub3JzIGFib3V0IGNwdSBsb2Fk
IG5lZWRzDQo+Pj4+Pg0KPj4+Pj4gwqDCoCBkcml2ZXJzL2NwdWZyZXEvY3B1ZnJlcV9nb3Zlcm5v
ci5jwqDCoMKgwqDCoMKgwqAgfMKgwqAgNSArDQo+Pj4+PiDCoMKgIGRyaXZlcnMvbWVkaWEvcGxh
dGZvcm0vc3RtMzIvc3RtMzItZGNtaS5jIHzCoMKgIDggKysNCj4+Pj4+IMKgwqAgaW5jbHVkZS9s
aW51eC9wbV9xb3MuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAx
MiArKw0KPj4+Pj4gwqDCoCBrZXJuZWwvcG93ZXIvcW9zLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMjEzIA0KPj4+Pj4gKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrDQo+Pj4+PiDCoMKgIDQgZmlsZXMgY2hhbmdlZCwgMjM4IGluc2VydGlvbnMo
KykNCj4NCg==
