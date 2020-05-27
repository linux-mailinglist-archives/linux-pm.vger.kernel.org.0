Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 527031E42A4
	for <lists+linux-pm@lfdr.de>; Wed, 27 May 2020 14:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbgE0MtW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 May 2020 08:49:22 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:14046 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728964AbgE0MtW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 May 2020 08:49:22 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04RCm1ie006236;
        Wed, 27 May 2020 14:48:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=26IMlLvf/Y93jh9yA1Ns2+y1tGX2JVHjVd/Qs0j7tx0=;
 b=Y19tcPxK/czXOsbRcP6sSkKPo3NkL5FNgJBrp8S/XYQ+NFurz30lZ4/GvLPUjWolo1rj
 DfAOay8gU8SyqtKDzI1ZNDgmcmwYJWQBjmJc5SfnIr6bDJfgiLWC+DZ+xcKxDM2KXBea
 uDPeOcvmgPLZti7JGTtcgRo6bk/qHvc5jB0ZlnIeaAKE6M2eCH/MxxeuCAJm2cbhNSSr
 YCQ8JGYhdvmNRMe/8Bgwj46XYzOBX7DBOSbpcdTqa3uXKFE4ByeXqQhGbOiPzjWptEGK
 hRNUip9zAnIGxdb3a/VMG1UYj6tsPqtFfnP5Qd9/ma5UGLllAkmC9BXmV9ILKwaHvf8p zQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 316sa25rd5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 May 2020 14:48:46 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5768910002A;
        Wed, 27 May 2020 14:48:45 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1C95D2B7620;
        Wed, 27 May 2020 14:48:45 +0200 (CEST)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 27 May
 2020 14:48:44 +0200
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Wed, 27 May 2020 14:48:44 +0200
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
Thread-Index: AQHWM3CeA6bTrCFpTUymlrJxXTw8j6i7lUyAgAATBICAABI/gIAAB1gA
Date:   Wed, 27 May 2020 12:48:44 +0000
Message-ID: <51917583-f8ff-3933-7783-2eedc91484a4@st.com>
References: <20200526151619.8779-1-benjamin.gaignard@st.com>
 <jhjk10xu1tq.mognet@arm.com> <ab4340c0-bda3-e752-9073-e162e6325bb1@st.com>
 <CAKfTPtBt6Ju-CnETnn6_FkgR0CAJ+jYnySz9OHP9X2hmxWHM7w@mail.gmail.com>
In-Reply-To: <CAKfTPtBt6Ju-CnETnn6_FkgR0CAJ+jYnySz9OHP9X2hmxWHM7w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.48]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A1EFABD517AC9847AA7C19D754960F2E@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-27_03:2020-05-27,2020-05-27 signatures=0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQoNCk9uIDUvMjcvMjAgMjoyMiBQTSwgVmluY2VudCBHdWl0dG90IHdyb3RlOg0KPiBPbiBXZWQs
IDI3IE1heSAyMDIwIGF0IDEzOjE3LCBCZW5qYW1pbiBHQUlHTkFSRA0KPiA8YmVuamFtaW4uZ2Fp
Z25hcmRAc3QuY29tPiB3cm90ZToNCj4+DQo+Pg0KPj4gT24gNS8yNy8yMCAxMjowOSBQTSwgVmFs
ZW50aW4gU2NobmVpZGVyIHdyb3RlOg0KPj4+IEhpIEJlbmphbWluLA0KPj4+DQo+Pj4gT24gMjYv
MDUvMjAgMTY6MTYsIEJlbmphbWluIEdhaWduYXJkIHdyb3RlOg0KPj4+PiBBIGZpcnN0IHJvdW5k
IFsxXSBvZiBkaXNjdXNzaW9ucyBhbmQgc3VnZ2VzdGlvbnMgaGF2ZSBhbHJlYWR5IGJlIGRvbmUg
b24NCj4+Pj4gdGhpcyBzZXJpZXMgYnV0IHdpdGhvdXQgZm91bmQgYSBzb2x1dGlvbiB0byB0aGUg
cHJvYmxlbS4gSSByZXNlbmQgaXQgdG8NCj4+Pj4gcHJvZ3Jlc3Mgb24gdGhpcyB0b3BpYy4NCj4+
Pj4NCj4+PiBBcG9sb2dpZXMgZm9yIHNsZWVwaW5nIG9uIHRoYXQgcHJldmlvdXMgdGhyZWFkLg0K
Pj4+DQo+Pj4gU28gd2hhdCBoYWQgYmVlbiBzdWdnZXN0ZWQgb3ZlciB0aGVyZSB3YXMgdG8gdXNl
IHVjbGFtcCB0byBib29zdCB0aGUNCj4+PiBmcmVxdWVuY3kgb2YgdGhlIGhhbmRsaW5nIHRocmVh
ZDsgaG93ZXZlciBpZiB5b3UgdXNlIHRocmVhZGVkIElSUXMgeW91DQo+Pj4gZ2V0IFJUIHRocmVh
ZHMsIHdoaWNoIGFscmVhZHkgZ2V0IHRoZSBtYXggZnJlcXVlbmN5IGJ5IGRlZmF1bHQgKGF0IGxl
YXN0DQo+Pj4gd2l0aCBzY2hlZHV0aWwpLg0KPj4+DQo+Pj4gRG9lcyB0aGF0IG5vdCB3b3JrIGZv
ciB5b3UsIGFuZCBpZiBzbywgd2h5Pw0KPj4gVGhhdCBkb2Vzbid0IHdvcmsgYmVjYXVzZSBhbG1v
c3QgZXZlcnl0aGluZyBpcyBkb25lIGJ5IHRoZSBoYXJkd2FyZSBibG9ja3MNCj4+IHdpdGhvdXQg
Y2hhcmdlIHRoZSBDUFUgc28gdGhlIHRocmVhZCBpc24ndCBydW5uaW5nLiBJIGhhdmUgZG9uZSB0
aGUNCj4+IHRlc3RzIHdpdGggc2NoZWR1dGlsDQo+PiBhbmQgb25kZW1hbmQgc2NoZWR1bGVyICh3
aGljaCBpcyB0aGUgb25lIEknbSB0YXJnZXRpbmcpLiBJIGhhdmUgbm8NCj4+IGlzc3VlcyB3aGVu
IHVzaW5nDQo+PiBwZXJmb3JtYW5jZSBzY2hlZHVsZXIgYmVjYXVzZSBpdCBhbHdheXMga2VlcCB0
aGUgaGlnaGVzdCBmcmVxdWVuY2llcy4NCj4gSU1ITywgdGhlIG9ubHkgd2F5IHRvIGVuc3VyZSBh
IG1pbiBmcmVxdWVuY3kgZm9yIGFueXRoaW5nIGVsc2UgdGhhbiBhDQo+IHRocmVhZCBpcyB0byB1
c2UgZnJlcV9xb3NfYWRkX3JlcXVlc3QoKSBqdXN0IGxpa2UgY3B1ZnJlcSBjb29saW5nDQo+IGRl
dmljZSBidXQgZm9yIHRoZSBvcHBvc2l0ZSBRb1MuIFRoaXMgY2FuIGJlIGFwcGxpZWQgb25seSBv
biB0aGUNCj4gZnJlcXVlbmN5IGRvbWFpbiBvZiB0aGUgQ1BVIHdoaWNoIGhhbmRsZXMgdGhlIGlu
dGVycnVwdC4NCkkgd2lsbCBnaXZlIGEgdHJ5IHdpdGggdGhpcyBpZGVhLg0KVGhhbmtzLg0KPiBI
YXZlIHlvdSBhbHNvIGNoZWNrZWQgdGhlIHdha2V1cCBsYXRlbmN5IG9mIHlvdXIgaWRsZSBzdGF0
ZSA/DQpJdCBqdXN0IGNvdWxkIGdvIGluIFdGSSBzbyBsYXRlbmN5IHNob3VsZCBiZSBtaW5pbWFs
Lg0KPg0KPj4NCj4+Pj4gV2hlbiBzdGFydCBzdHJlYW1pbmcgZnJvbSB0aGUgc2Vuc29yIHRoZSBD
UFUgbG9hZCBjb3VsZCByZW1haW4gdmVyeSBsb3cNCj4+Pj4gYmVjYXVzZSBhbG1vc3QgYWxsIHRo
ZSBjYXB0dXJlIHBpcGVsaW5lIGlzIGRvbmUgaW4gaGFyZHdhcmUgKGkuZS4gd2l0aG91dA0KPj4+
PiB1c2luZyB0aGUgQ1BVKSBhbmQgbGV0IGJlbGlldmUgdG8gY3B1ZnJlcSBnb3Zlcm5vciB0aGF0
IGl0IGNvdWxkIHVzZSBsb3dlcg0KPj4+PiBmcmVxdWVuY2llcy4gSWYgdGhlIGdvdmVybm9yIGRl
Y2lkZXMgdG8gdXNlIGEgdG9vIGxvdyBmcmVxdWVuY3kgdGhhdA0KPj4+PiBiZWNvbWVzIGEgcHJv
YmxlbSB3aGVuIHdlIG5lZWQgdG8gYWNrbm93bGVkZ2UgdGhlIGludGVycnVwdCBkdXJpbmcgdGhl
DQo+Pj4+IGJsYW5raW5nIHRpbWUuDQo+Pj4+IFRoZSBkZWxheSB0byBhY2sgdGhlIGludGVycnVw
dCBhbmQgcGVyZm9ybSBhbGwgdGhlIG90aGVyIGFjdGlvbnMgYmVmb3JlDQo+Pj4+IHRoZSBuZXh0
IGZyYW1lIGlzIHZlcnkgc2hvcnQgYW5kIGRvZXNuJ3QgYWxsb3cgdG8gdGhlIGNwdWZyZXEgZ292
ZXJub3IgdG8NCj4+Pj4gcHJvdmlkZSB0aGUgcmVxdWlyZWQgYnVyc3Qgb2YgcG93ZXIuIFRoYXQg
bGVkIHRvIGRyb3AgdGhlIGhhbGYgb2YgdGhlIGZyYW1lcy4NCj4+Pj4NCj4+Pj4gVG8gYXZvaWQg
dGhpcyBwcm9ibGVtLCBEQ01JIGRyaXZlciBpbmZvcm1zIHRoZSBjcHVmcmVxIGdvdmVybm9ycyBi
eSBhZGRpbmcNCj4+Pj4gYSBjcHVmcmVxIG1pbmltdW0gbG9hZCBRb1MgcmVzcXVlc3QuDQo+Pj4+
DQo+Pj4+IEJlbmphbWluDQo+Pj4+DQo+Pj4+IFsxXSBodHRwczovL2xrbWwub3JnL2xrbWwvMjAy
MC80LzI0LzM2MA0KPj4+Pg0KPj4+PiBCZW5qYW1pbiBHYWlnbmFyZCAoMyk6DQo+Pj4+ICAgICBQ
TTogUW9TOiBJbnRyb2R1Y2UgY3B1ZnJlcSBtaW5pbXVtIGxvYWQgUW9TDQo+Pj4+ICAgICBjcHVm
cmVxOiBnb3Zlcm5vcjogVXNlIG1pbmltdW0gbG9hZCBRb1MNCj4+Pj4gICAgIG1lZGlhOiBzdG0z
Mi1kY21pOiBJbmZvcm0gY3B1ZnJlcSBnb3Zlcm5vcnMgYWJvdXQgY3B1IGxvYWQgbmVlZHMNCj4+
Pj4NCj4+Pj4gICAgZHJpdmVycy9jcHVmcmVxL2NwdWZyZXFfZ292ZXJub3IuYyAgICAgICAgfCAg
IDUgKw0KPj4+PiAgICBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL3N0bTMyL3N0bTMyLWRjbWkuYyB8
ICAgOCArKw0KPj4+PiAgICBpbmNsdWRlL2xpbnV4L3BtX3Fvcy5oICAgICAgICAgICAgICAgICAg
ICB8ICAxMiArKw0KPj4+PiAgICBrZXJuZWwvcG93ZXIvcW9zLmMgICAgICAgICAgICAgICAgICAg
ICAgICB8IDIxMyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+Pj4gICAgNCBmaWxl
cyBjaGFuZ2VkLCAyMzggaW5zZXJ0aW9ucygrKQ0K
