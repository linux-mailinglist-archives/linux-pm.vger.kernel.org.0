Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA6B71E4300
	for <lists+linux-pm@lfdr.de>; Wed, 27 May 2020 15:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730259AbgE0NMa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 May 2020 09:12:30 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:55041 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730223AbgE0NMa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 May 2020 09:12:30 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04RD8AFR008753;
        Wed, 27 May 2020 15:11:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=msqWAAt3W24QRgICYNWFWTZaQ/yQljeulY2121WBxwQ=;
 b=SD6qx4d3rijF6tZWnCcsYWW7jfmei4vLK6Z5aocb2/DoMgk19LbBCfF6kjgcCfGLiEvP
 wlM9t4PQePAVb/4x4hvxpvcVd8ir2/Fshu6uBUv8ga1NR3PG9OxktXqlrGFUNoBeDes0
 lksiyR29y/5FOCyN1llf0v7/4gAzHr3qVv4NTimBjFNNMwNxMbZ4PAeMGNcKJrwrnMjG
 jSJcF0bITSMQwLOdrx2xRe3zvSWU1MP5MXyV8W5rFd5uND4T29dQigUCDGhGuRojlkoo
 obhFVrsVydHxQ+sPQ6WYngGeTbSL1UndsdleKKRZy/0DJa94vpeJAYN5ZTCV83waGoyq lQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 316skwe06k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 May 2020 15:11:43 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 80D2710002A;
        Wed, 27 May 2020 15:11:43 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 668F82AC7CD;
        Wed, 27 May 2020 15:11:43 +0200 (CEST)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 27 May
 2020 15:11:42 +0200
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Wed, 27 May 2020 15:11:42 +0200
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
CC:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        Hugues FRUCHET <hugues.fruchet@st.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC RESEND 0/3] Introduce cpufreq minimum load QoS
Thread-Topic: [RFC RESEND 0/3] Introduce cpufreq minimum load QoS
Thread-Index: AQHWM3CeA6bTrCFpTUymlrJxXTw8j6i7lUyAgAATBICAAA//AIAAEAGA
Date:   Wed, 27 May 2020 13:11:42 +0000
Message-ID: <099f5b6c-aa81-be4a-19bf-52a2fff7b3db@st.com>
References: <20200526151619.8779-1-benjamin.gaignard@st.com>
 <jhjk10xu1tq.mognet@arm.com> <ab4340c0-bda3-e752-9073-e162e6325bb1@st.com>
 <jhjwo4xinhb.mognet@arm.com>
In-Reply-To: <jhjwo4xinhb.mognet@arm.com>
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
Content-ID: <706816CEE5C22249B8804FAF19ABB7CF@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-27_03:2020-05-27,2020-05-27 signatures=0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQoNCk9uIDUvMjcvMjAgMjoxNCBQTSwgVmFsZW50aW4gU2NobmVpZGVyIHdyb3RlOg0KPiBPbiAy
Ny8wNS8yMCAxMjoxNywgQmVuamFtaW4gR0FJR05BUkQgd3JvdGU6DQo+PiBPbiA1LzI3LzIwIDEy
OjA5IFBNLCBWYWxlbnRpbiBTY2huZWlkZXIgd3JvdGU6DQo+Pj4gSGkgQmVuamFtaW4sDQo+Pj4N
Cj4+PiBPbiAyNi8wNS8yMCAxNjoxNiwgQmVuamFtaW4gR2FpZ25hcmQgd3JvdGU6DQo+Pj4+IEEg
Zmlyc3Qgcm91bmQgWzFdIG9mIGRpc2N1c3Npb25zIGFuZCBzdWdnZXN0aW9ucyBoYXZlIGFscmVh
ZHkgYmUgZG9uZSBvbg0KPj4+PiB0aGlzIHNlcmllcyBidXQgd2l0aG91dCBmb3VuZCBhIHNvbHV0
aW9uIHRvIHRoZSBwcm9ibGVtLiBJIHJlc2VuZCBpdCB0bw0KPj4+PiBwcm9ncmVzcyBvbiB0aGlz
IHRvcGljLg0KPj4+Pg0KPj4+IEFwb2xvZ2llcyBmb3Igc2xlZXBpbmcgb24gdGhhdCBwcmV2aW91
cyB0aHJlYWQuDQo+Pj4NCj4+PiBTbyB3aGF0IGhhZCBiZWVuIHN1Z2dlc3RlZCBvdmVyIHRoZXJl
IHdhcyB0byB1c2UgdWNsYW1wIHRvIGJvb3N0IHRoZQ0KPj4+IGZyZXF1ZW5jeSBvZiB0aGUgaGFu
ZGxpbmcgdGhyZWFkOyBob3dldmVyIGlmIHlvdSB1c2UgdGhyZWFkZWQgSVJRcyB5b3UNCj4+PiBn
ZXQgUlQgdGhyZWFkcywgd2hpY2ggYWxyZWFkeSBnZXQgdGhlIG1heCBmcmVxdWVuY3kgYnkgZGVm
YXVsdCAoYXQgbGVhc3QNCj4+PiB3aXRoIHNjaGVkdXRpbCkuDQo+Pj4NCj4+PiBEb2VzIHRoYXQg
bm90IHdvcmsgZm9yIHlvdSwgYW5kIGlmIHNvLCB3aHk/DQo+PiBUaGF0IGRvZXNuJ3Qgd29yayBi
ZWNhdXNlIGFsbW9zdCBldmVyeXRoaW5nIGlzIGRvbmUgYnkgdGhlIGhhcmR3YXJlIGJsb2Nrcw0K
Pj4gd2l0aG91dCBjaGFyZ2UgdGhlIENQVSBzbyB0aGUgdGhyZWFkIGlzbid0IHJ1bm5pbmcuDQo+
IEknbSBub3Qgc3VyZSBJIGZvbGxvdzsgdGhlIGZyZXF1ZW5jeSBvZiB0aGUgQ1BVIGRvZXNuJ3Qg
bWF0dGVyIHdoaWxlDQo+IHlvdXIgaGFyZHdhcmUgYmxvY2tzIGFyZSBzcGlubmluZywgcmlnaHQ/
IEFJVUkgd2hhdCBtYXR0ZXJzIGlzIHJ1bm5pbmcNCj4geW91ciBpbnRlcnJ1cHQgaGFuZGxlciAv
IGFjdGlvbiBhdCBtYXggZnJlcSwgd2hpY2ggeW91IGdldCBpZiB5b3UgdXNlDQo+IHRocmVhZGVk
IElSUXMgYW5kIHNjaGVkdXRpbC4NClllcyBidXQgbm90IGxpbWl0ZWQgdG8gc2NoZWR1dGlsLg0K
R2l2ZW4gdGhlIGxhdGVuY3kgbmVlZGVkIHRvIGNoYW5nZSBvZiBmcmVxdWVuY2llcyBJIHRoaW5r
IGl0IGNvdWxkIA0KYWxyZWFkeSB0b28gbGF0ZQ0KdG8gY2hhbmdlIHRoZSBDUFUgZnJlcXVlbmN5
IHdoZW4gaGFuZGxpbmcgdGhlIHRocmVhZGVkIGludGVycnVwdC4NCj4NCj4gSSB0aGluayBpdCB3
b3VsZCBoZWxwIGlmIHlvdSBjb3VsZCBjbGFyaWZ5IHdoaWNoIHRhc2tzIC8gcGFydHMgb2YgeW91
cg0KPiBwaXBlbGluZSB5b3UgbmVlZCBydW5uaW5nIGF0IGhpZ2ggZnJlcXVlbmNpZXMuIFRoZSBw
b2ludCBpcyB0aGF0IHNldHRpbmcNCj4gYSBRb1MgcmVxdWVzdCBhZmZlY3RzIGFsbCB0YXNrcywg
d2hlcmVhcyB3ZSBjb3VsZCBiZSBzbWFydGVyIGFuZCBvbmx5DQo+IGJvb3N0IHRoZSByZXF1aXJl
ZCB0YXNrcy4NCldoYXQgbWFrZSB1cyBkcm9wIGZyYW1lcyBpcyB0aGF0IHRoZSB0aHJlYWRlZCBJ
UlEgaXMgc2NoZWR1bGVkIHRvbyBsYXRlLg0KVGhlIG5vdCB0aHJlYWQgcGFydCBvZiB0aGUgaW50
ZXJydXB0IGhhbmRsZXIgd2hlcmUgd2UgY2xlYXIgdGhlIA0KaW50ZXJydXB0IGZsYWdzDQppcyBn
b2luZyBmaW5lIGJ1dCB0aGUgdGhyZWFkIHBhcnQgbm90Lg0KPg0KPj4gSSBoYXZlIGRvbmUgdGhl
DQo+PiB0ZXN0cyB3aXRoIHNjaGVkdXRpbA0KPj4gYW5kIG9uZGVtYW5kIHNjaGVkdWxlciAod2hp
Y2ggaXMgdGhlIG9uZSBJJ20gdGFyZ2V0aW5nKS4gSSBoYXZlIG5vDQo+PiBpc3N1ZXMgd2hlbiB1
c2luZw0KPj4gcGVyZm9ybWFuY2Ugc2NoZWR1bGVyIGJlY2F1c2UgaXQgYWx3YXlzIGtlZXAgdGhl
IGhpZ2hlc3QgZnJlcXVlbmNpZXMuDQo+Pg0KPj4NCj4+Pj4gV2hlbiBzdGFydCBzdHJlYW1pbmcg
ZnJvbSB0aGUgc2Vuc29yIHRoZSBDUFUgbG9hZCBjb3VsZCByZW1haW4gdmVyeSBsb3cNCj4+Pj4g
YmVjYXVzZSBhbG1vc3QgYWxsIHRoZSBjYXB0dXJlIHBpcGVsaW5lIGlzIGRvbmUgaW4gaGFyZHdh
cmUgKGkuZS4gd2l0aG91dA0KPj4+PiB1c2luZyB0aGUgQ1BVKSBhbmQgbGV0IGJlbGlldmUgdG8g
Y3B1ZnJlcSBnb3Zlcm5vciB0aGF0IGl0IGNvdWxkIHVzZSBsb3dlcg0KPj4+PiBmcmVxdWVuY2ll
cy4gSWYgdGhlIGdvdmVybm9yIGRlY2lkZXMgdG8gdXNlIGEgdG9vIGxvdyBmcmVxdWVuY3kgdGhh
dA0KPj4+PiBiZWNvbWVzIGEgcHJvYmxlbSB3aGVuIHdlIG5lZWQgdG8gYWNrbm93bGVkZ2UgdGhl
IGludGVycnVwdCBkdXJpbmcgdGhlDQo+Pj4+IGJsYW5raW5nIHRpbWUuDQo+Pj4+IFRoZSBkZWxh
eSB0byBhY2sgdGhlIGludGVycnVwdCBhbmQgcGVyZm9ybSBhbGwgdGhlIG90aGVyIGFjdGlvbnMg
YmVmb3JlDQo+Pj4+IHRoZSBuZXh0IGZyYW1lIGlzIHZlcnkgc2hvcnQgYW5kIGRvZXNuJ3QgYWxs
b3cgdG8gdGhlIGNwdWZyZXEgZ292ZXJub3IgdG8NCj4+Pj4gcHJvdmlkZSB0aGUgcmVxdWlyZWQg
YnVyc3Qgb2YgcG93ZXIuIFRoYXQgbGVkIHRvIGRyb3AgdGhlIGhhbGYgb2YgdGhlIGZyYW1lcy4N
Cj4+Pj4NCj4+Pj4gVG8gYXZvaWQgdGhpcyBwcm9ibGVtLCBEQ01JIGRyaXZlciBpbmZvcm1zIHRo
ZSBjcHVmcmVxIGdvdmVybm9ycyBieSBhZGRpbmcNCj4+Pj4gYSBjcHVmcmVxIG1pbmltdW0gbG9h
ZCBRb1MgcmVzcXVlc3QuDQo+Pj4+DQo+Pj4+IEJlbmphbWluDQo+Pj4+DQo+Pj4+IFsxXSBodHRw
czovL2xrbWwub3JnL2xrbWwvMjAyMC80LzI0LzM2MA0KPj4+Pg0KPj4+PiBCZW5qYW1pbiBHYWln
bmFyZCAoMyk6DQo+Pj4+ICAgICBQTTogUW9TOiBJbnRyb2R1Y2UgY3B1ZnJlcSBtaW5pbXVtIGxv
YWQgUW9TDQo+Pj4+ICAgICBjcHVmcmVxOiBnb3Zlcm5vcjogVXNlIG1pbmltdW0gbG9hZCBRb1MN
Cj4+Pj4gICAgIG1lZGlhOiBzdG0zMi1kY21pOiBJbmZvcm0gY3B1ZnJlcSBnb3Zlcm5vcnMgYWJv
dXQgY3B1IGxvYWQgbmVlZHMNCj4+Pj4NCj4+Pj4gICAgZHJpdmVycy9jcHVmcmVxL2NwdWZyZXFf
Z292ZXJub3IuYyAgICAgICAgfCAgIDUgKw0KPj4+PiAgICBkcml2ZXJzL21lZGlhL3BsYXRmb3Jt
L3N0bTMyL3N0bTMyLWRjbWkuYyB8ICAgOCArKw0KPj4+PiAgICBpbmNsdWRlL2xpbnV4L3BtX3Fv
cy5oICAgICAgICAgICAgICAgICAgICB8ICAxMiArKw0KPj4+PiAgICBrZXJuZWwvcG93ZXIvcW9z
LmMgICAgICAgICAgICAgICAgICAgICAgICB8IDIxMyArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysNCj4+Pj4gICAgNCBmaWxlcyBjaGFuZ2VkLCAyMzggaW5zZXJ0aW9ucygrKQ0K
