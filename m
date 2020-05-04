Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3802D1C3563
	for <lists+linux-pm@lfdr.de>; Mon,  4 May 2020 11:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgEDJSH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 May 2020 05:18:07 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:28466 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726625AbgEDJSH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 May 2020 05:18:07 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 044978Ts004044;
        Mon, 4 May 2020 11:17:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=t8yE9JoGl4flloHQYJEWfkrlpSIqoEFqyExGxmwsMx8=;
 b=SKVrCXff3h/xL4m3odmOVBOJUf2qGJNoKtavF7W6Rz0kENh4xvZMCpxwYDsfw58rWIxe
 uHRuHlXRWPeptG3pU39cL8A4BE1d0BtwMYevfaQHB/x2JNqzO9+rv8pP8e/Bm++04prk
 NdRdpi514nAwSf9qy1Vh0haZNOCXBmidZqBMY04DfYc6MFpEo1X2u3FXlifIRn7rEtbt
 SHgnlyxsUf/vuXjEWSG7CZZ98MkRvZu5Ey0Me0w2BRr4wkDbaVHNUqljBSysarYiAjBl
 atBmEB2Osx42GsTLk8y13PzfkW51ioujPXV2+37zvew1lZHY8NySEcot5hhcDaqikLV2 xg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30rx089j7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 May 2020 11:17:45 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1E65710002A;
        Mon,  4 May 2020 11:17:41 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D3AA22BBAA5;
        Mon,  4 May 2020 11:17:41 +0200 (CEST)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 4 May
 2020 11:17:41 +0200
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Mon, 4 May 2020 11:17:41 +0200
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
Thread-Index: AQHWGi06wBgeAQBseECYOK/U7Qvw76iQJdAAgAACCYCAAAQ3AIABBseAgAAT0wCAAE7QgIAADU2AgAARzICAAAO9AIAF2zaA
Date:   Mon, 4 May 2020 09:17:41 +0000
Message-ID: <b8757472-c973-a32d-d5c9-a584d7d703f8@st.com>
References: <20200424114058.21199-1-benjamin.gaignard@st.com>
 <7657495.QyJl4BcWH5@kreacher> <30cdecf9-703a-eb2b-7c2b-f1e21c805add@st.com>
 <70e743cf-b88e-346a-5114-939b8724c83d@arm.com>
 <6b5cde14-58b3-045d-9413-223e66b87bf0@st.com>
 <CAJZ5v0h6t6perZiibCWhEh1_V0pSXqFe-z22TFqH7KTFXYmqpQ@mail.gmail.com>
 <a234e123-6c15-8e58-8921-614b58ca24ca@st.com> <jhjtv11cabk.mognet@arm.com>
 <a20c5214-211b-1f70-1162-57b32e60549b@st.com> <jhjmu6tc6rz.mognet@arm.com>
In-Reply-To: <jhjmu6tc6rz.mognet@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.44]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F04BFBC11629A34FAC8C983CAC60E3EF@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-04_05:2020-05-01,2020-05-04 signatures=0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQoNCk9uIDQvMzAvMjAgNTo1MCBQTSwgVmFsZW50aW4gU2NobmVpZGVyIHdyb3RlOg0KPiBPbiAz
MC8wNC8yMCAxNjozNywgQmVuamFtaW4gR0FJR05BUkQgd3JvdGU6DQo+PiBPbiA0LzMwLzIwIDQ6
MzMgUE0sIFZhbGVudGluIFNjaG5laWRlciB3cm90ZToNCj4+PiBPbiAzMC8wNC8yMCAxNDo0Niwg
QmVuamFtaW4gR0FJR05BUkQgd3JvdGU6DQo+Pj4+PiBUaGF0J3Mgbm90IHdoYXQgSSBtZWFudC4N
Cj4+Pj4+DQo+Pj4+PiBJIHN1cHBvc2UgdGhhdCB0aGUgaW50ZXJydXB0IHByb2Nlc3NpbmcgaW4g
cXVlc3Rpb24gdGFrZXMgcGxhY2UgaW4NCj4+Pj4+IHByb2Nlc3MgY29udGV4dCBhbmQgc28geW91
IG1heSBzZXQgdGhlIGxvd2VyIGNsYW1wIG9uIHRoZSB1dGlsaXphdGlvbg0KPj4+Pj4gb2YgdGhl
IHRhc2sgY2FycnlpbmcgdGhhdCBvdXQuDQo+Pj4+IEkgaGF2ZSB0cnkgdG8gYWRkIHRoaXMgY29k
ZSB3aGVuIHN0YXJ0aW5nIHN0cmVhbWluZyAoYmVmb3JlIHRoZSBmaXJzdA0KPj4+PiBpbnRlcnJ1
cHQpIHRoZSBmcmFtZXMgZnJvbSB0aGUgc2Vuc29yOg0KPj4+PiBjb25zdCBzdHJ1Y3Qgc2NoZWRf
YXR0ciBzY2hlZF9hdHRyID0gew0KPj4+PiAgICAgIC5zY2hlZF91dGlsX21pbiA9IDEwMDAwLCAv
KiAxMDAlIG9mIHVzYWdlICovDQo+Pj4gVW5sZXNzIHlvdSBwbGF5IHdpdGggU0NIRURfQ0FQQUNJ
VFlfU0hJRlQsIHRoZSBtYXggc2hvdWxkIGJlIDEwMjQgLQ0KPj4+IGkuZS4gU0NIRURfQ0FQQUNJ
VFlfU0NBTEUuIFRoYXQncyBhIHJlYWxseSBiaWcgYm9vc3QsIGJ1dCB0aGF0J3MgZm9yIHlvdSB0
bw0KPj4+IGJlbmNobWFyay4NCj4+Pg0KPj4+PiAgICAgIC5zY2hlZF9mbGFncyA9IFNDSEVEX0ZM
QUdfVVRJTF9DTEFNUF9NSU4sDQo+Pj4+ICAgICB9Ow0KPj4+Pg0KPj4+PiBzY2hlZF9zZXRhdHRy
KGN1cnJlbnQsICZzY2hlZF9hdHRyKTsNCj4+Pj4NCj4+Pj4gSSBkb24ndCBzZWUgYW55IGJlbmVm
aWNlcyBtYXliZSB0aGVyZSBpcyBzb21lIGNvbmZpZ3VyYXRpb24gZmxhZ3MgdG8gc2V0Lg0KPj4+
Pg0KPj4+PiBIb3cgY2hhbmdpbmcgc2NoZWRfdXRpbF9taW4gY291bGQgaW1wYWN0IGNwdWZyZXEg
b25kZW1hbmQgZ292ZXJub3IgPw0KPj4+PiBEb2VzIGl0IGNoYW5nZSB0aGUgdmFsdWUgcmV0dXJu
ZWQgd2hlbiB0aGUgZ292ZXJub3IgY2hlY2sgdGhlIGlkbGUgdGltZSA/DQo+Pj4+DQo+Pj4gWW91
J2xsIGhhdmUgdG8gdXNlIHRoZSBzY2hlZHV0aWwgZ292ZXJub3IgZm9yIHVjbGFtcCB0byBoYXZl
IGFuIGVmZmVjdC4gQW5kDQo+Pj4gYXJndWFibHkgdGhhdCdzIHdoYXQgeW91IHNob3VsZCBiZSB1
c2luZywgdW5sZXNzIHNvbWV0aGluZyBleHBsaWNpdGx5DQo+Pj4gcHJldmVudHMgeW91IGZyb20g
ZG9pbmcgdGhhdC4NCj4+IEV2ZW4gd2l0aCBzY2hlZHV0aWwgYW5kIFNDSEVEX0NBUEFDSVRZX1ND
QUxFIHRoYXQgaXQgZG9lc24ndCB3b3JrLg0KPj4gY3B1ZnJlcS9jcHVpbmZvX2N1cl9mcmVxIHZh
bHVlcyBhcmUgYWx3YXlzIG9uIHRoZSBtYXggdmFsdWUgZXZlbiBpZiB0aGUNCj4+IHN0YXRzIHNo
b3cgdHJhbnNpdGlvbnMgYmV0d2VlbiB0aGUgYXZhaWxhYmxlIGZyZXF1ZW5jaWVzLg0KPj4NCj4+
IEkgc2VlIHR3byBwb3NzaWJsZXMgcmVhc29ucyB0byBleHBsYWluIHRoYXQ6DQo+PiAtIHNjaGVk
X3NldGF0dHIoKSBpcyBjYWxsZWQgaW4gdXNlcmxhbmQgcHJvY2VzcyBjb250ZXh0LCBidXQgdGhl
DQo+PiB0aHJlYWRlZCBpcnEgaGFuZGxlciBpcyBydW5uaW5nIGluIGFub3RoZXIgcHJvY2Vzcy4N
Cj4gQWggeWVzLCB0aGlzIG9ubHkgd29ya3MgaWYgdGhlIHRhc2sgeW91IGJvb3N0IGlzIHRoZSBv
bmUgdGhhdCB3aWxsIGhhbmRsZQ0KPiB3aGF0ZXZlciB3b3JrIHlvdSBjYXJlIGFib3V0IChpbiB0
aGlzIGNhc2UgaGFuZGxpbmcgdGhlIGlycSkuIFRoYXQgc2FpZCwgaWYNCj4geW91IGRvIHVzZSB0
aHJlYWRlZCBJUlFzLCB0aGF0IHNob3VsZCBnaXZlIHlvdSBhIFNDSEVEX0ZJRk8gdGhyZWFkLCB3
aGljaA0KPiBzaG91bGQgZHJpdmUgdGhlIGZyZXF1ZW5jeSB0byBpdHMgbWF4IHdoZW4gdXNpbmcg
c2NoZWR1dGlsICh1bnJlbGF0ZWQgdG8NCj4gdWNsYW1wKS4NCkNhbiBJIGNvbmNsdWRlIHRoYXQg
c2NoZWRfc2V0YXR0cigpIGlzbid0IHRoZSBnb29kIHdheSB0byBzb2x2ZSB0aGlzIA0KcHJvYmxl
bSA/DQpEb2VzIG15IHBhdGNoZXMgbWFrZSBzZW5zZSBpbiB0aGlzIGNhc2UgPw0KDQo+PiAtIGJl
Y2F1c2UgdGhpcyB1c2UgY2FzZSBpcyBhbG1vc3QgcnVubmluZyBhbGwgaW4gaGFyZHdhcmUgdGhl
IHByb2Nlc3MNCj4+IGlzbid0IGRvaW5nIGFueXRoaW5nIHNvIHRoZSBzY2hlZHVsZXIgZG9lc24n
dCB0YWtlIGNhcmUgb2YgaXQuDQo+Pg0KPj4+Pj4gQWx0ZXJuYXRpdmVseSwgdGhhdCB0YXNrIG1h
eSBiZSBhIGRlYWRsaW5lIG9uZS4NCg==
