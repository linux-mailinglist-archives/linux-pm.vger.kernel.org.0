Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918441BF9D4
	for <lists+linux-pm@lfdr.de>; Thu, 30 Apr 2020 15:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgD3NqW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Apr 2020 09:46:22 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:51992 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726577AbgD3NqW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Apr 2020 09:46:22 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03UDgb6x018733;
        Thu, 30 Apr 2020 15:46:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=fqQBAfMnO2lszgF11VpgCCeuOYHg07iN80HWwvGyUiI=;
 b=AAgVx/8N6+9h0DGAXg1VfxblEF/vRCoBVHD+M8e1fUbD5J0QEZAAs4nw465j19GecmTH
 DEhm5m4OYsQ5Vy3+pbHTe8rR3TFxLg+/mNidL6i1snK7kxmfIysg9R0Q1F4VLF783Ida
 nUUQwMlDfqy98NJHnr/dyWuJIPupIpUPM0F/gQ/EcDYW1TLEqcdee+9Q3t89qO+TX9h7
 kWIXMsOXiyoCgZZtpj6nULmLkuF2NtHLjpsYKKlCnyKLCi1mkTaNCEO0uuizjXSIpw8G
 0MG5xwkT2JPi89AO9LfTii5BKRYmmuIy94XlsM2ohuMOsjfipPShLy8TPFcBF0IU4YFV FA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30mhjx4rgu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 15:46:01 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 08470100034;
        Thu, 30 Apr 2020 15:46:01 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D418120E6E6;
        Thu, 30 Apr 2020 15:46:00 +0200 (CEST)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 30 Apr
 2020 15:46:00 +0200
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Thu, 30 Apr 2020 15:46:00 +0200
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Valentin Schneider <valentin.schneider@arm.com>,
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
Thread-Index: AQHWGi06wBgeAQBseECYOK/U7Qvw76iQJdAAgAACCYCAAAQ3AIABBseAgAAT0wCAAE7QgA==
Date:   Thu, 30 Apr 2020 13:46:00 +0000
Message-ID: <a234e123-6c15-8e58-8921-614b58ca24ca@st.com>
References: <20200424114058.21199-1-benjamin.gaignard@st.com>
 <7657495.QyJl4BcWH5@kreacher> <30cdecf9-703a-eb2b-7c2b-f1e21c805add@st.com>
 <70e743cf-b88e-346a-5114-939b8724c83d@arm.com>
 <6b5cde14-58b3-045d-9413-223e66b87bf0@st.com>
 <CAJZ5v0h6t6perZiibCWhEh1_V0pSXqFe-z22TFqH7KTFXYmqpQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0h6t6perZiibCWhEh1_V0pSXqFe-z22TFqH7KTFXYmqpQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="utf-8"
Content-ID: <38939A4E8611F444B3EC426000050A86@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-30_08:2020-04-30,2020-04-30 signatures=0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQoNCk9uIDQvMzAvMjAgMTE6MDMgQU0sIFJhZmFlbCBKLiBXeXNvY2tpIHdyb3RlOg0KPiBPbiBU
aHUsIEFwciAzMCwgMjAyMCBhdCA5OjUzIEFNIEJlbmphbWluIEdBSUdOQVJEDQo+IDxiZW5qYW1p
bi5nYWlnbmFyZEBzdC5jb20+IHdyb3RlOg0KPj4NCj4+DQo+PiBPbiA0LzI5LzIwIDY6MTIgUE0s
IFZhbGVudGluIFNjaG5laWRlciB3cm90ZToNCj4+PiBPbiAyOS8wNC8yMDIwIDE2OjU3LCBCZW5q
YW1pbiBHQUlHTkFSRCB3cm90ZToNCj4+Pj4gT24gNC8yOS8yMCA1OjUwIFBNLCBSYWZhZWwgSi4g
V3lzb2NraSB3cm90ZToNCj4+Pj4+IE9uIEZyaWRheSwgQXByaWwgMjQsIDIwMjAgMTo0MDo1NSBQ
TSBDRVNUIEJlbmphbWluIEdhaWduYXJkIHdyb3RlOg0KPj4+Pj4+IFdoZW4gc3RhcnQgc3RyZWFt
aW5nIGZyb20gdGhlIHNlbnNvciB0aGUgQ1BVIGxvYWQgY291bGQgcmVtYWluIHZlcnkgbG93DQo+
Pj4+Pj4gYmVjYXVzZSBhbG1vc3QgYWxsIHRoZSBjYXB0dXJlIHBpcGVsaW5lIGlzIGRvbmUgaW4g
aGFyZHdhcmUgKGkuZS4gd2l0aG91dA0KPj4+Pj4+IHVzaW5nIHRoZSBDUFUpIGFuZCBsZXQgYmVs
aWV2ZSB0byBjcHVmcmVxIGdvdmVybm9yIHRoYXQgaXQgY291bGQgdXNlIGxvd2VyDQo+Pj4+Pj4g
ZnJlcXVlbmNpZXMuIElmIHRoZSBnb3Zlcm5vciBkZWNpZGVzIHRvIHVzZSBhIHRvbyBsb3cgZnJl
cXVlbmN5IHRoYXQNCj4+Pj4+PiBiZWNvbWVzIGEgcHJvYmxlbSB3aGVuIHdlIG5lZWQgdG8gYWNr
bm93bGVkZ2UgdGhlIGludGVycnVwdCBkdXJpbmcgdGhlDQo+Pj4+Pj4gYmxhbmtpbmcgdGltZS4N
Cj4+Pj4+PiBUaGUgZGVsYXkgdG8gYWNrIHRoZSBpbnRlcnJ1cHQgYW5kIHBlcmZvcm0gYWxsIHRo
ZSBvdGhlciBhY3Rpb25zIGJlZm9yZQ0KPj4+Pj4+IHRoZSBuZXh0IGZyYW1lIGlzIHZlcnkgc2hv
cnQgYW5kIGRvZXNuJ3QgYWxsb3cgdG8gdGhlIGNwdWZyZXEgZ292ZXJub3IgdG8NCj4+Pj4+PiBw
cm92aWRlIHRoZSByZXF1aXJlZCBidXJzdCBvZiBwb3dlci4gVGhhdCBsZWQgdG8gZHJvcCB0aGUg
aGFsZiBvZiB0aGUgZnJhbWVzLg0KPj4+Pj4+DQo+Pj4+Pj4gVG8gYXZvaWQgdGhpcyBwcm9ibGVt
LCBEQ01JIGRyaXZlciBpbmZvcm1zIHRoZSBjcHVmcmVxIGdvdmVybm9ycyBieSBhZGRpbmcNCj4+
Pj4+PiBhIGNwdWZyZXEgbWluaW11bSBsb2FkIFFvUyByZXNxdWVzdC4NCj4+Pj4+IFRoaXMgc2Vl
bXMgdG8gYmUgYWRkcmVzc2luZyBhIHVzZSBjYXNlIHRoYXQgY2FuIGJlIGFkZHJlc3NlZCB3aXRo
IHRoZSBoZWxwIG9mDQo+Pj4+PiB1dGlsaXphdGlvbiBjbGFtcHMgd2l0aCBsZXNzIHBvd2VyIG92
ZXJoZWFkLg0KPj4+PiBEbyBtZWFuIGNsYW1waW5nIHRoZSBwb2xpY3kgZnJlcXVlbmNpZXMgPyBJ
IG1heSBoYXZlIG1pc3MgdGhlIEFQSSB0byBkbw0KPj4+PiB0aGF0Li4uDQo+Pj4gSUlVQyBSYWZh
ZWwgaXMgcmVmZXJyaW5nIHRvIHVjbGFtcCwgaS5lLiBzY2hlZHVsZXIgdXRpbGl6YXRpb24gY2xh
bXBpbmcsIHNlZToNCj4+Pg0KPj4+ICAgICBodHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1s
L2xhdGVzdC9hZG1pbi1ndWlkZS9jZ3JvdXAtdjIuaHRtbCNjcHUNCj4+Pg0KPj4+IFRoZSBhYm92
ZSBkZXNjcmliZXMgdGhlIGNncm91cCBpbnRlcmZhY2UsIG5vdGUgdGhhdCB5b3UgY2FuIGFsc28g
c2V0IGNsYW1wcw0KPj4+IHBlciB0YXNrICh2aWEgc2NoZWRfc2V0YXR0cigpKS4NCj4+Pg0KPj4+
IE9uZSB0aGluZyB0aGF0IGNvbWVzIHRvIG1pbmQgaG93ZXZlciBpcyB0aGF0IHNjaGVkdXRpbCBv
bmx5ICJzZWVzIiB0aGUgY2xhbXBzDQo+Pj4gb2YgcnVubmFibGUgdGFza3MsIGFuZCBmcm9tIHJl
YWRpbmcgeW91ciBjaGFuZ2Vsb2cgeW91IG1heSBub3QgaGF2ZSBtb21lbnRzDQo+Pj4gd2l0aG91
dCBhbnkgKGkuZS4gZ2VhcnMgYXJlIGdyaW5kaW5nIGluIEhXKS4gWW91J2QgaGF2ZSB0byB0cnkg
Ym9vc3RpbmcNCj4+PiAoc2V0dGluZyBhIGhpZ2ggdWNsYW1wLm1pbikgd2hhdGV2ZXIgdGFza3Mg
eW91IGhhdmUgb24gdGhlIHNvZnR3YXJlIHNpZGUgYW5kDQo+Pj4gc2VlIGhvdyBpdCBhbGwgYmVo
YXZlcy4NCj4+IFJlbHlpbmcgb24gdXNlcmxhbmQgc2lkZSBtZWFucyB0aGF0IHZhcmlvdXMgYXBw
bGljYXRpb25zIG5lZWQgdG8gYmUgYXdhcmUNCj4+IG9mIHRoaXMgc3BlY2lmaWMgaGFyZHdhcmUg
Y2FzZSBhbmQgZml4IGl0LiBJIHdhcyBob3BpbmcgdG8gZmluZCBhDQo+PiBzb2x1dGlvbiBpbiBz
aWRlIHRoZSBrZXJuZWwNCj4+IHRvIG5vdCBpbXBhY3QgdGhlIHNvZnR3YXJlIHNpZGUuDQo+IFRo
YXQncyBub3Qgd2hhdCBJIG1lYW50Lg0KPg0KPiBJIHN1cHBvc2UgdGhhdCB0aGUgaW50ZXJydXB0
IHByb2Nlc3NpbmcgaW4gcXVlc3Rpb24gdGFrZXMgcGxhY2UgaW4NCj4gcHJvY2VzcyBjb250ZXh0
IGFuZCBzbyB5b3UgbWF5IHNldCB0aGUgbG93ZXIgY2xhbXAgb24gdGhlIHV0aWxpemF0aW9uDQo+
IG9mIHRoZSB0YXNrIGNhcnJ5aW5nIHRoYXQgb3V0Lg0KSSBoYXZlIHRyeSB0byBhZGQgdGhpcyBj
b2RlIHdoZW4gc3RhcnRpbmcgc3RyZWFtaW5nIChiZWZvcmUgdGhlIGZpcnN0IA0KaW50ZXJydXB0
KSB0aGUgZnJhbWVzIGZyb20gdGhlIHNlbnNvcjoNCmNvbnN0IHN0cnVjdCBzY2hlZF9hdHRyIHNj
aGVkX2F0dHIgPSB7DQogwqDCoMKgIMKgwqDCoCAuc2NoZWRfdXRpbF9taW4gPSAxMDAwMCwgLyog
MTAwJSBvZiB1c2FnZSAqLw0KIMKgwqDCoCDCoMKgwqAgLnNjaGVkX2ZsYWdzID0gU0NIRURfRkxB
R19VVElMX0NMQU1QX01JTiwNCiDCoMKgwqAgfTsNCg0Kc2NoZWRfc2V0YXR0cihjdXJyZW50LCAm
c2NoZWRfYXR0cik7DQoNCkkgZG9uJ3Qgc2VlIGFueSBiZW5lZmljZXMgbWF5YmUgdGhlcmUgaXMg
c29tZSBjb25maWd1cmF0aW9uIGZsYWdzIHRvIHNldC4NCg0KSG93IGNoYW5naW5nIHNjaGVkX3V0
aWxfbWluIGNvdWxkIGltcGFjdCBjcHVmcmVxIG9uZGVtYW5kIGdvdmVybm9yID8NCkRvZXMgaXQg
Y2hhbmdlIHRoZSB2YWx1ZSByZXR1cm5lZCB3aGVuIHRoZSBnb3Zlcm5vciBjaGVjayB0aGUgaWRs
ZSB0aW1lID8NCg0KPg0KPiBBbHRlcm5hdGl2ZWx5LCB0aGF0IHRhc2sgbWF5IGJlIGEgZGVhZGxp
bmUgb25lLg0K
