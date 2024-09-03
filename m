Return-Path: <linux-pm+bounces-13468-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 092F096A9A5
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 23:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CAA91F22460
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 21:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE711D88DC;
	Tue,  3 Sep 2024 20:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=viasat.com header.i=@viasat.com header.b="hoctprcB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0e-0085b301.gpphosted.com (mx0e-0085b301.gpphosted.com [67.231.147.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC831D9D60;
	Tue,  3 Sep 2024 20:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.147.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396791; cv=none; b=orhebkJkwWTLE80cqear6T3v0t91HdqeLQup5/RBA9ID+jkAhwvFARBn1F6z6hvG7A/n3iDMZQ9TmcXRgtFxgVZjGRxNs2ppUc1rTsU0fjrb3s6sPgek1+0ntHtH3NTrmk4H+Qpegqaor62q3dW/SB98mSm1s7gZ0K84COtKpVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396791; c=relaxed/simple;
	bh=ZuKjEGlhLVi/TWDHW3zGyrHRHSr2NQNsgMASUJ+AFV0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AUHI1v6meEO21xVGygNS9FMu/dNTrzlqEbRlq6+VeKghs61suJqgEabD4owP54N9LbPh8cACl4ebJC79otzzx2rXpuSQC8fsjTjBX4WUbuh+eCBhhdZjr0BoHYtoI462m1sJNpt3ZBWvhzfaIJSUoEwGOwnKidcXWuTMd3b11WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=viasat.com; spf=pass smtp.mailfrom=viasat.com; dkim=pass (2048-bit key) header.d=viasat.com header.i=@viasat.com header.b=hoctprcB; arc=none smtp.client-ip=67.231.147.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=viasat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=viasat.com
Received: from pps.filterd (m0351329.ppops.net [127.0.0.1])
	by mx0e-0085b301.gpphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483Htt10018968;
	Tue, 3 Sep 2024 20:53:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=viasat.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ZuKjEGlhLVi/TWDHW3zGyrHRHSr2NQNsgMASUJ+AFV0=;
 b=hoctprcBV4HrrX+VfdpXyarseMdEkX0cv0AYgoSUsQqBp8xFtTECk7ZIcUrR3vnasS/1
 j9dkeGRv7nfurhE6vIUBl968YxdtmgaIwHRazf/Qs+vJRGwwBm/Sikp5x4fJl/4Yf8eH
 5pNpNj95hxnTKt6Y9FTbdM5iXgdtxUIIiIz1ydxnG5VWIzAzLOjssFfo1GC7sCY7q7rF
 4YP4Oayvc47Eh+8l0XLFdF9U2A/S+LPHHUP859vW1O0G+rCoLA53k4WW0Mx2cgJX0xg6
 hWaKRixr1YDHK6fhPMAgRd9BSkAydCXsU4ObIReDp53/0kxLCiOT3TxZGZjiymMRMiv0 FQ== 
Received: from wdc1exchp06.hq.corp.viasat.com ([8.37.104.42])
	by mx0e-0085b301.gpphosted.com (PPS) with ESMTPS id 41e21wu0xx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 03 Sep 2024 20:53:01 +0000
Received: from WDC1EXCHP05.hq.corp.viasat.com (10.228.7.145) by
 WDC1EXCHP06.hq.corp.viasat.com (10.228.7.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 3 Sep 2024 14:53:00 -0600
Received: from WDC1EXCHP05.hq.corp.viasat.com ([fe80::e59e:1518:91aa:55e9]) by
 WDC1EXCHP05.hq.corp.viasat.com ([fe80::e59e:1518:91aa:55e9%23]) with mapi id
 15.01.2507.039; Tue, 3 Sep 2024 14:53:00 -0600
From: "Jones, Morgan" <Morgan.Jones@viasat.com>
To: Mario Limonciello <mario.limonciello@amd.com>,
        Dhananjay Ugwekar
	<Dhananjay.Ugwekar@amd.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "gautham.shenoy@amd.com"
	<gautham.shenoy@amd.com>,
        "perry.yuan@amd.com" <perry.yuan@amd.com>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "li.meng@amd.com"
	<li.meng@amd.com>,
        "ray.huang@amd.com" <ray.huang@amd.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Arcari
	<darcari@redhat.com>
Subject: RE: [EXTERNAL] Re: [PATCH v2 2/2] cpufreq/amd-pstate: Fix the
 scaling_max_freq setting on shared memory CPPC systems
Thread-Topic: [EXTERNAL] Re: [PATCH v2 2/2] cpufreq/amd-pstate: Fix the
 scaling_max_freq setting on shared memory CPPC systems
Thread-Index: AQHTmcEn27fAHGT7pNe1jAQ3Ww8GHAMI4eQEAR3OYjGyM+kx8IAAZwsA//+b9MCAAInhgIAAC7yA//+bl0A=
Date: Tue, 3 Sep 2024 20:52:59 +0000
Message-ID: <4dd3798936a2488283e5520dc687aedd@viasat.com>
References: <20240702081413.5688-1-Dhananjay.Ugwekar@amd.com>
 <20240702081413.5688-3-Dhananjay.Ugwekar@amd.com>
 <bb09e7e8-5824-4bc1-9697-1929a4cf717e@amd.com>
 <d6392b1af4ab459195a1954e4e5ad87e@viasat.com>
 <bb49cd31-a02f-46f9-8757-554bd7783261@amd.com>
 <66f08ce529d246bd8315c87fe0f880e6@viasat.com>
 <645f2e77-336b-4a9c-b33e-06043010028b@amd.com>
 <2e36ee28-d3b8-4cdb-9d64-3d26ef0a9180@amd.com>
In-Reply-To: <2e36ee28-d3b8-4cdb-9d64-3d26ef0a9180@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-ORIG-GUID: MDOW14Ygjd0SGuduEtafK3hhD1X5SG1K
X-Proofpoint-GUID: MDOW14Ygjd0SGuduEtafK3hhD1X5SG1K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-03_08,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 clxscore=1015 suspectscore=0
 adultscore=0 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2409030167

T24gaXQuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBNYXJpbyBMaW1vbmNp
ZWxsbyA8bWFyaW8ubGltb25jaWVsbG9AYW1kLmNvbT4gDQpTZW50OiBUdWVzZGF5LCBTZXB0ZW1i
ZXIgMywgMjAyNCAxOjUyIFBNDQpUbzogSm9uZXMsIE1vcmdhbiA8TW9yZ2FuLkpvbmVzQHZpYXNh
dC5jb20+OyBEaGFuYW5qYXkgVWd3ZWthciA8RGhhbmFuamF5LlVnd2VrYXJAYW1kLmNvbT47IHJh
ZmFlbEBrZXJuZWwub3JnOyB2aXJlc2gua3VtYXJAbGluYXJvLm9yZzsgZ2F1dGhhbS5zaGVub3lA
YW1kLmNvbTsgcGVycnkueXVhbkBhbWQuY29tOyBza2hhbkBsaW51eGZvdW5kYXRpb24ub3JnOyBs
aS5tZW5nQGFtZC5jb207IHJheS5odWFuZ0BhbWQuY29tDQpDYzogbGludXgtcG1Admdlci5rZXJu
ZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBEYXZpZCBBcmNhcmkgPGRhcmNh
cmlAcmVkaGF0LmNvbT4NClN1YmplY3Q6IFJlOiBbRVhURVJOQUxdIFJlOiBbUEFUQ0ggdjIgMi8y
XSBjcHVmcmVxL2FtZC1wc3RhdGU6IEZpeCB0aGUgc2NhbGluZ19tYXhfZnJlcSBzZXR0aW5nIG9u
IHNoYXJlZCBtZW1vcnkgQ1BQQyBzeXN0ZW1zDQoNCk1vcmdhbiwNCg0KVGhpcyBkb2VzIHJlbWlu
ZCBtZSBvZiBhIGNsYW1waW5nIGlzc3VlIHRoYXQgdG91Y2hlcyBzb21lIG9mIHRoZSBzYW1lIHZh
cmlhYmxlcy4gIENhbiB5b3UgcGxlYXNlIHNlZSBpZiBiYWNrcG9ydGluZw0KDQpjb21taXQgODE2
NGY3NDMzMjY0ICgiY3B1ZnJlcTogYW1kLXBzdGF0ZTogYWRqdXN0IG1pbi9tYXggbGltaXQgcGVy
ZiIpDQoNCnRvIDYuNi55IGhlbHBzIGZvciB5b3U/DQoNClRoYW5rcywNCg0KT24gOS8zLzIwMjQg
MTU6MDksIE1hcmlvIExpbW9uY2llbGxvIHdyb3RlOg0KPiBNb3JnYW4sDQo+IA0KPiBPSyB0aGF0
J3MgZ3JlYXQgbmV3cyB0aGF0IGl0J3MganVzdCBhIGJhY2twb3J0IGVmZm9ydC7CoCBUaGF0IHNh
bWUgDQo+IGNvbW1pdCBhbHNvIGJhY2twb3J0ZWQgdG8gNi4xMC4zLsKgIENhbiB5b3Ugc2VlIGlm
IDYuMTAueSBpcyBhZmZlY3RlZD8NCj4gDQo+IFVnd2VrYXIsDQo+IA0KPiBBbnkgdGhvdWdodHMg
b24gd2hhdCBlbHNlIG5lZWRzIHRvIGNvbWUgYmFjayB0byA2LjYueSBvZmYgaGFuZD8NCj4gDQo+
IFRoYW5rcywNCj4gDQo+IE9uIDkvMy8yMDI0IDE1OjA3LCBKb25lcywgTW9yZ2FuIHdyb3RlOg0K
Pj4gSGV5IE1hcmlvLA0KPj4NCj4+IFNtb2tpbmcgZ3VuIGhlcmUsIHRoZSBtYXggZnJlcXVlbmN5
IGlzIGluY29ycmVjdCBvbiA2LjYuNDQrIGJ1dCBpcyANCj4+IGNvcnJlY3Qgb24gNi4xMS4wLXJj
Ni4NCj4+DQo+PiBMaW51eCByZWRhY3QgNi4xMS4wLXJjNiAjMS1OaXhPUyBTTVAgUFJFRU1QVF9E
WU5BTUlDIFR1ZSBKYW7CoCAxDQo+PiAwMDowMDowMCBVVEMgMTk4MCB4ODZfNjQgR05VL0xpbnV4
DQo+Pg0KPj4gYW5hbHl6aW5nIENQVSAxMjoNCj4+IMKgwqAgZHJpdmVyOiBhbWQtcHN0YXRlLWVw
cA0KPj4gwqDCoCBDUFVzIHdoaWNoIHJ1biBhdCB0aGUgc2FtZSBoYXJkd2FyZSBmcmVxdWVuY3k6
IDEyDQo+PiDCoMKgIENQVXMgd2hpY2ggbmVlZCB0byBoYXZlIHRoZWlyIGZyZXF1ZW5jeSBjb29y
ZGluYXRlZCBieSBzb2Z0d2FyZTogDQo+PiAxMg0KPj4gwqDCoCBtYXhpbXVtIHRyYW5zaXRpb24g
bGF0ZW5jeTrCoCBDYW5ub3QgZGV0ZXJtaW5lIG9yIGlzIG5vdCBzdXBwb3J0ZWQuDQo+PiDCoMKg
IGhhcmR3YXJlIGxpbWl0czogNDAwIE1IeiAtIDMuMzUgR0h6DQo+PiDCoMKgIGF2YWlsYWJsZSBj
cHVmcmVxIGdvdmVybm9yczogcGVyZm9ybWFuY2UgcG93ZXJzYXZlDQo+PiDCoMKgIGN1cnJlbnQg
cG9saWN5OiBmcmVxdWVuY3kgc2hvdWxkIGJlIHdpdGhpbiA0MDAgTUh6IGFuZCAzLjM1IEdIei4N
Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBUaGUgZ292ZXJub3IgInBl
cmZvcm1hbmNlIiBtYXkgZGVjaWRlIHdoaWNoIHNwZWVkIA0KPj4gdG8gdXNlDQo+PiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgd2l0aGluIHRoaXMgcmFuZ2UuDQo+PiDCoMKg
IGN1cnJlbnQgQ1BVIGZyZXF1ZW5jeTogVW5hYmxlIHRvIGNhbGwgaGFyZHdhcmUNCj4+IMKgwqAg
Y3VycmVudCBDUFUgZnJlcXVlbmN5OiAzLjM0IEdIeiAoYXNzZXJ0ZWQgYnkgY2FsbCB0byBrZXJu
ZWwpDQo+PiDCoMKgIGJvb3N0IHN0YXRlIHN1cHBvcnQ6DQo+PiDCoMKgwqDCoCBTdXBwb3J0ZWQ6
IHllcw0KPj4gwqDCoMKgwqAgQWN0aXZlOiB5ZXMNCj4+IMKgwqDCoMKgIEFNRCBQU1RBVEUgSGln
aGVzdCBQZXJmb3JtYW5jZTogMjU1LiBNYXhpbXVtIEZyZXF1ZW5jeTogMy4zNSBHSHouDQo+PiDC
oMKgwqDCoCBBTUQgUFNUQVRFIE5vbWluYWwgUGVyZm9ybWFuY2U6IDE1Mi4gTm9taW5hbCBGcmVx
dWVuY3k6IDIuMDAgR0h6Lg0KPj4gwqDCoMKgwqAgQU1EIFBTVEFURSBMb3dlc3QgTm9uLWxpbmVh
ciBQZXJmb3JtYW5jZTogMTE1LiBMb3dlc3QgTm9uLWxpbmVhcg0KPj4gRnJlcXVlbmN5OiAxLjUx
IEdIei4NCj4+IMKgwqDCoMKgIEFNRCBQU1RBVEUgTG93ZXN0IFBlcmZvcm1hbmNlOiAzMS4gTG93
ZXN0IEZyZXF1ZW5jeTogNDAwIE1Iei4NCj4+DQo+PiBXZSdyZSBydW5uaW5nIGFtZF9wc3RhdGU9
YWN0aXZlIGFuZCBhbWRfcHN0YXRlLnNoYXJlZF9tZW09MSwgYW5kIG91ciANCj4+IHdvcmtsb2Fk
cyBhcmUgYmFjayB0byBub3JtYWwgcGVyZm9ybWFuY2Ugb24gNi4xMS4wLXJjNi4NCj4+DQo+PiBN
b3JnYW4NCj4+DQo+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4gRnJvbTogTWFyaW8g
TGltb25jaWVsbG8gPG1hcmlvLmxpbW9uY2llbGxvQGFtZC5jb20+DQo+PiBTZW50OiBUdWVzZGF5
LCBTZXB0ZW1iZXIgMywgMjAyNCAxMDo1NSBBTQ0KPj4gVG86IEpvbmVzLCBNb3JnYW4gPE1vcmdh
bi5Kb25lc0B2aWFzYXQuY29tPjsgRGhhbmFuamF5IFVnd2VrYXIgDQo+PiA8RGhhbmFuamF5LlVn
d2VrYXJAYW1kLmNvbT47IHJhZmFlbEBrZXJuZWwub3JnOyANCj4+IHZpcmVzaC5rdW1hckBsaW5h
cm8ub3JnOyBnYXV0aGFtLnNoZW5veUBhbWQuY29tOyBwZXJyeS55dWFuQGFtZC5jb207IA0KPj4g
c2toYW5AbGludXhmb3VuZGF0aW9uLm9yZzsgbGkubWVuZ0BhbWQuY29tOyByYXkuaHVhbmdAYW1k
LmNvbQ0KPj4gQ2M6IGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgRGF2aWQgDQo+PiBBcmNhcmkgPGRhcmNhcmlAcmVkaGF0LmNvbT4NCj4+IFN1
YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtQQVRDSCB2MiAyLzJdIGNwdWZyZXEvYW1kLXBzdGF0ZTog
Rml4IHRoZSANCj4+IHNjYWxpbmdfbWF4X2ZyZXEgc2V0dGluZyBvbiBzaGFyZWQgbWVtb3J5IENQ
UEMgc3lzdGVtcw0KPj4NCj4+IEhpIE1vcmdhbiwNCj4+DQo+PiBDYW4geW91IHBsZWFzZSBjcm9z
cyByZWZlcmVuY2UgNi4xMS1yYzYgdG8gc2VlIGlmIHlvdSdyZSBzdGlsbCBoYXZpbmcgDQo+PiBh
IHByb2JsZW0/wqAgSSB3b3VsZCBsaWtlIHRvIHVuZGVyc3RhbmQgaWYgd2UncmUgbWlzc2luZyBh
IGJhY2twb3J0IHRvIA0KPj4gc3RhYmxlIG9yIHRoaXMgaXMgc3RpbGwgYW4gdXBzdHJlYW0gcHJv
YmxlbS4NCj4+DQo+PiBUaGFua3MsDQo+Pg0KPj4gT24gOS8zLzIwMjQgMTI6NTEsIEpvbmVzLCBN
b3JnYW4gd3JvdGU6DQo+Pj4gSGkgdGhlcmUsDQo+Pj4NCj4+PiBXZSBhcmUgZXhwZXJpZW5jaW5n
IGEgfjM1JSBwZXJmb3JtYW5jZSByZWdyZXNzaW9uIG9uIGFuIEFNRCBFUFlDIA0KPj4+IDc3MDIN
Cj4+PiA2NCBjb3JlIG1hY2hpbmUgYWZ0ZXIgYXBwbHlpbmcgdGhpcyBwYXRjaC4gV2Ugb2JzZXJ2
ZWQgTGludXggNi42LjQ0IA0KPj4+IHN0YXJ0aW5nIHRvIGNhdXNlIHRoZSBpc3N1ZSwgYW5kIHBl
cmZvcm1lZCBhIGJpc2VjdCBpbnZvbHZpbmcgDQo+Pj4gcmVib290aW5nIHRoZSBtYWNoaW5lIG92
ZXIgMTUgdGltZXMuIChOb3RlIHRoYXQga2V4ZWMgZGlkbid0IA0KPj4+IHN1Y2Nlc3NmdWxseSBp
ZGVudGlmeSB0aGUgcHJvYmxlbSwgc2luY2UgdGhlIFBNIG1lbW9yeSBtYWlsYm94IGlzIA0KPj4+
IG5ldmVyIHJlc2V0KS4NCj4+Pg0KPj4+IEl0IGFwcGVhcnMgdGhhdCB3ZSBhcmUgZ2V0dGluZyBh
IG1heCBvZiAyLjE4IEdIeiB3aGVuIHRoaXMgQ1BVIGNhbiANCj4+PiBib29zdCB0byAzLjM1IEdI
eiwgZXhwbGFpbmluZyB0aGUgc2xvd2Rvd24uIEJsYWNrbGlzdGluZyBhbWQtcHN0YXRlIA0KPj4+
IHNvbHZlcyB0aGUgaXNzdWUgYXQgdGhlIGV4cGVuc2Ugb2YgdGhlIHBlcmZvcm1hbmNlIGluY3Jl
YXNlIHdlIHVzZWQgDQo+Pj4gdG8gZ2V0IGJ5IHVzaW5nIGl0Lg0KPj4+DQo+Pj4gSXMgaXQgcG9z
c2libGUgdGhhdCB0aGUgdXBwZXIgbGltaXRzIHdlcmUgaW1wbGljaXRseSBhdCB0aGUgbWF4IENQ
VSANCj4+PiBwb3dlciBiZWZvcmUsIGFuZCBzZXR0aW5nIHRoZSB1cHBlciBsaW1pdCB0byBzb21l
dGhpbmcgb3RoZXIgdGhhbiANCj4+PiB0aGUgYm9vc3QgZnJlcXVlbmN5IGNhbiByZWR1Y2UgcGVy
Zm9ybWFuY2Ugbm93Pw0KPj4+DQo+Pj4gIyBiYWQ6IFs3MjEzOTEwNjAwNjY3YzUxYzk3OGU1Nzdi
ZjU0NTRkM2Y3YjMxM2I3XSBMaW51eCA2LjYuNDQgIyBnb29kOg0KPj4+IFs1OGIwNDI1ZmY1ZGY2
ODBkMGI2N2Y2NGFlMWYzZjFlYmRmMWM0ZGU5XSBMaW51eCA2LjYuNDMgZ2l0IGJpc2VjdCANCj4+
PiBzdGFydCAnNzIxMzkxMDYwMDY2N2M1MWM5NzhlNTc3YmY1NDU0ZDNmN2IzMTNiNycNCj4+PiAn
NThiMDQyNWZmNWRmNjgwZDBiNjdmNjRhZTFmM2YxZWJkZjFjNGRlOScNCj4+PiAjIGdvb2Q6IFs3
MmZmOWQyNjk2NGEzYTgwZjc2NTBkZjcxOWRmMTM5ZjVjMWY5NjVkXSBhcm02NDogZHRzOiBxY29t
Og0KPj4+IHNtNjM1MDogQWRkIG1pc3NpbmcgcWNvbSxub24tc2VjdXJlLWRvbWFpbiBwcm9wZXJ0
eSBnaXQgYmlzZWN0IGdvb2QgDQo+Pj4gNzJmZjlkMjY5NjRhM2E4MGY3NjUwZGY3MTlkZjEzOWY1
YzFmOTY1ZA0KPj4+ICMgZ29vZDogWzBmZmZjMmUxYmY0MGEyMjIwZWY1YTM4ZjgzNGVhMDYzZGJh
ODMyZDNdIEFSTTogZHRzOiBzdW54aToNCj4+PiByZW1vdmUgZHVwbGljYXRlZCBlbnRyaWVzIGlu
IG1ha2VmaWxlIGdpdCBiaXNlY3QgZ29vZA0KPj4+IDBmZmZjMmUxYmY0MGEyMjIwZWY1YTM4Zjgz
NGVhMDYzZGJhODMyZDMNCj4+PiAjIGJhZDogWzhjZGJlNmViZmQxNzYzYTVjNDFhMmEzMDU4NDk3
YzBhOTE2MzMxMWNdIHBpbmN0cmw6IHJlbmVzYXM6DQo+Pj4gcjhhNzc5ZzA6IEZpeCBDQU5GRDUg
c3VmZml4IGdpdCBiaXNlY3QgYmFkIA0KPj4+IDhjZGJlNmViZmQxNzYzYTVjNDFhMmEzMDU4NDk3
YzBhOTE2MzMxMWMNCj4+PiAjIGJhZDogWzVkYmI5OGU3ZmE0MmJlYmMxMzI1ODk5MTkzZDhmMTNm
MDcwNWExNDhdIGRybS9tZWRpYXRlazogVHVybiANCj4+PiBvZmYgdGhlIGxheWVycyB3aXRoIHpl
cm8gd2lkdGggb3IgaGVpZ2h0IGdpdCBiaXNlY3QgYmFkDQo+Pj4gNWRiYjk4ZTdmYTQyYmViYzEz
MjU4OTkxOTNkOGYxM2YwNzA1YTE0OA0KPj4+ICMgYmFkOiBbNjkxZWM3MDQzMTIyYzljOGM0NmQ4
NGY2ZTZjZDg1ZDEzZDUwY2Q5M10gc2VsZnRlc3RzL2JwZjogDQo+Pj4gTnVsbCBjaGVja3MgZm9y
IGxpbmtzIGluIGJwZl90Y3BfY2EgZ2l0IGJpc2VjdCBiYWQNCj4+PiA2OTFlYzcwNDMxMjJjOWM4
YzQ2ZDg0ZjZlNmNkODVkMTNkNTBjZDkzDQo+Pj4gIyBiYWQ6IFthMTM1OWUwODVkNzVkNzM5M2Ey
NTAwNTRlNjZjMGE3YmM2YzNkYmZhXSBwZXJmL3g4NjogDQo+Pj4gU2VyaWFsaXplDQo+Pj4gc2V0
X2F0dHJfcmRwbWMoKSBnaXQgYmlzZWN0IGJhZA0KPj4+IGExMzU5ZTA4NWQ3NWQ3MzkzYTI1MDA1
NGU2NmMwYTdiYzZjM2RiZmENCj4+PiAjIGJhZDogW2U5OWQ5YjE2ZmYxNTNkZTk1NDAwNzMyMzlk
MjRhZGMzYjBhM2E5OTddIHdpZmk6IGF0aDEyazogDQo+Pj4gY2hhbmdlIERNQSBkaXJlY3Rpb24g
d2hpbGUgbWFwcGluZyByZWluamVjdGVkIHBhY2tldHMgZ2l0IGJpc2VjdCBiYWQNCj4+PiBlOTlk
OWIxNmZmMTUzZGU5NTQwMDczMjM5ZDI0YWRjM2IwYTNhOTk3DQo+Pj4gIyBiYWQ6IFtkMDI3YWM0
YTA4NTQxYmViMmE4OTU2M2QzZTAzNGRhNzA4NTA1MGJhXSBmaXJtd2FyZToNCj4+PiB0dXJyaXMt
bW94LXJ3dG06IEluaXRpYWxpemUgY29tcGxldGlvbiBiZWZvcmUgbWFpbGJveCBnaXQgYmlzZWN0
IGJhZCANCj4+PiBkMDI3YWM0YTA4NTQxYmViMmE4OTU2M2QzZTAzNGRhNzA4NTA1MGJhDQo+Pj4g
IyBiYWQ6IFtlNmM5ZWNhMzI3ZTZhNDFhODFlN2ViYTBkMGRkYzEzZGEzN2Y4MmExXSBBUk06IHNw
aXR6OiBmaXggDQo+Pj4gR1BJTyBhc3NpZ25tZW50IGZvciBiYWNrbGlnaHQgZ2l0IGJpc2VjdCBi
YWQNCj4+PiBlNmM5ZWNhMzI3ZTZhNDFhODFlN2ViYTBkMGRkYzEzZGEzN2Y4MmExDQo+Pj4gIyBi
YWQ6IFtiOGNkZWZkYWE1NTViYmZjMjY5YzIxOTg4MDNmODc5MWE4OTIzOTYwXSBtNjhrOiBjbXB4
Y2hnOiBGaXggDQo+Pj4gcmV0dXJuIHZhbHVlIGZvciBkZWZhdWx0IGNhc2UgaW4gX19hcmNoX3hj
aGcoKSBnaXQgYmlzZWN0IGJhZA0KPj4+IGI4Y2RlZmRhYTU1NWJiZmMyNjljMjE5ODgwM2Y4Nzkx
YTg5MjM5NjANCj4+PiAjIGJhZDogWzEzYTcxMzg0YWU2YTg3NzlkYTgwOWIwMGM2ZjM3OGRjZWFk
MTA0MjddIGNwdWZyZXEvYW1kLXBzdGF0ZToNCj4+PiBGaXggdGhlIHNjYWxpbmdfbWF4X2ZyZXEg
c2V0dGluZyBvbiBzaGFyZWQgbWVtb3J5IENQUEMgc3lzdGVtcyBnaXQgDQo+Pj4gYmlzZWN0IGJh
ZCAxM2E3MTM4NGFlNmE4Nzc5ZGE4MDliMDBjNmYzNzhkY2VhZDEwNDI3DQo+Pj4gIyBmaXJzdCBi
YWQgY29tbWl0OiBbMTNhNzEzODRhZTZhODc3OWRhODA5YjAwYzZmMzc4ZGNlYWQxMDQyN10NCj4+
PiBjcHVmcmVxL2FtZC1wc3RhdGU6IEZpeCB0aGUgc2NhbGluZ19tYXhfZnJlcSBzZXR0aW5nIG9u
IHNoYXJlZCANCj4+PiBtZW1vcnkgQ1BQQyBzeXN0ZW1zDQo+Pj4NCj4+PiBjcHVwb3dlciBvdXRw
dXQ6DQo+Pj4NCj4+PiBhbmFseXppbmcgQ1BVIDQ3Og0KPj4+IMKgwqDCoCBkcml2ZXI6IGFtZC1w
c3RhdGUtZXBwDQo+Pj4gwqDCoMKgIENQVXMgd2hpY2ggcnVuIGF0IHRoZSBzYW1lIGhhcmR3YXJl
IGZyZXF1ZW5jeTogNDcNCj4+PiDCoMKgwqAgQ1BVcyB3aGljaCBuZWVkIHRvIGhhdmUgdGhlaXIg
ZnJlcXVlbmN5IGNvb3JkaW5hdGVkIGJ5IHNvZnR3YXJlOiANCj4+PiA0Nw0KPj4+IMKgwqDCoCBt
YXhpbXVtIHRyYW5zaXRpb24gbGF0ZW5jeTrCoCBDYW5ub3QgZGV0ZXJtaW5lIG9yIGlzIG5vdCBz
dXBwb3J0ZWQuDQo+Pj4gwqDCoMKgIGhhcmR3YXJlIGxpbWl0czogNDAwIE1IeiAtIDIuMTggR0h6
DQo+Pj4gwqDCoMKgIGF2YWlsYWJsZSBjcHVmcmVxIGdvdmVybm9yczogcGVyZm9ybWFuY2UgcG93
ZXJzYXZlDQo+Pj4gwqDCoMKgIGN1cnJlbnQgcG9saWN5OiBmcmVxdWVuY3kgc2hvdWxkIGJlIHdp
dGhpbiA0MDAgTUh6IGFuZCAyLjE4IEdIei4NCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBUaGUgZ292ZXJub3IgInBlcmZvcm1hbmNlIiBtYXkgZGVjaWRlIHdoaWNo
IA0KPj4+IHNwZWVkIHRvIHVzZQ0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHdpdGhpbiB0aGlzIHJhbmdlLg0KPj4+IMKgwqDCoCBjdXJyZW50IENQVSBmcmVxdWVu
Y3k6IFVuYWJsZSB0byBjYWxsIGhhcmR3YXJlDQo+Pj4gwqDCoMKgIGN1cnJlbnQgQ1BVIGZyZXF1
ZW5jeTogMi4xNyBHSHogKGFzc2VydGVkIGJ5IGNhbGwgdG8ga2VybmVsKQ0KPj4+IMKgwqDCoCBi
b29zdCBzdGF0ZSBzdXBwb3J0Og0KPj4+IMKgwqDCoMKgwqAgU3VwcG9ydGVkOiB5ZXMNCj4+PiDC
oMKgwqDCoMKgIEFjdGl2ZTogeWVzDQo+Pj4gwqDCoMKgwqDCoCBBTUQgUFNUQVRFIEhpZ2hlc3Qg
UGVyZm9ybWFuY2U6IDE2Ni4gTWF4aW11bSBGcmVxdWVuY3k6IDIuMTggR0h6Lg0KPj4+IMKgwqDC
oMKgwqAgQU1EIFBTVEFURSBOb21pbmFsIFBlcmZvcm1hbmNlOiAxNTIuIE5vbWluYWwgRnJlcXVl
bmN5OiAyLjAwIEdIei4NCj4+PiDCoMKgwqDCoMKgIEFNRCBQU1RBVEUgTG93ZXN0IE5vbi1saW5l
YXIgUGVyZm9ybWFuY2U6IDExNS4gTG93ZXN0IA0KPj4+IE5vbi1saW5lYXIgRnJlcXVlbmN5OiAx
LjUxIEdIei4NCj4+PiDCoMKgwqDCoMKgIEFNRCBQU1RBVEUgTG93ZXN0IFBlcmZvcm1hbmNlOiAz
MS4gTG93ZXN0IEZyZXF1ZW5jeTogNDAwIE1Iei4NCj4+Pg0KPj4+IFRoYW5rcywNCj4+PiBNb3Jn
YW4NCj4+Pg0KPj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4gRnJvbTogTWFyaW8g
TGltb25jaWVsbG8gPG1hcmlvLmxpbW9uY2llbGxvQGFtZC5jb20+DQo+Pj4gU2VudDogVHVlc2Rh
eSwgSnVseSAyLCAyMDI0IDEwOjQ5IEFNDQo+Pj4gVG86IERoYW5hbmpheSBVZ3dla2FyIDxEaGFu
YW5qYXkuVWd3ZWthckBhbWQuY29tPjsgDQo+Pj4gcmFmYWVsQGtlcm5lbC5vcmc7IHZpcmVzaC5r
dW1hckBsaW5hcm8ub3JnOyBnYXV0aGFtLnNoZW5veUBhbWQuY29tOyANCj4+PiBwZXJyeS55dWFu
QGFtZC5jb207IHNraGFuQGxpbnV4Zm91bmRhdGlvbi5vcmc7IGxpLm1lbmdAYW1kLmNvbTsgDQo+
Pj4gcmF5Lmh1YW5nQGFtZC5jb20NCj4+PiBDYzogbGludXgtcG1Admdlci5rZXJuZWwub3JnOyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBEYXZpZCANCj4+PiBBcmNhcmkgPGRhcmNhcmlA
cmVkaGF0LmNvbT4NCj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDIvMl0gY3B1ZnJlcS9hbWQt
cHN0YXRlOiBGaXggdGhlIA0KPj4+IHNjYWxpbmdfbWF4X2ZyZXEgc2V0dGluZyBvbiBzaGFyZWQg
bWVtb3J5IENQUEMgc3lzdGVtcw0KPj4+DQo+Pj4gT24gNy8yLzIwMjQgMzoxNCwgRGhhbmFuamF5
IFVnd2VrYXIgd3JvdGU6DQo+Pj4+IE9uIHNoYXJlZCBtZW1vcnkgQ1BQQyBzeXN0ZW1zLCB3aXRo
IGFtZF9wc3RhdGU9YWN0aXZlIG1vZGUsIHRoZSANCj4+Pj4gY2hhbmdlIGluIHNjYWxpbmdfbWF4
X2ZyZXEgZG9lc24ndCBnZXQgd3JpdHRlbiB0byB0aGUgc2hhcmVkIG1lbW9yeSANCj4+Pj4gcmVn
aW9uLg0KPj4+PiBEdWUgdG8gdGhpcywgdGhlIHdyaXRlcyB0byB0aGUgc2NhbGluZ19tYXhfZnJl
cSBzeXNmcyBmaWxlIGRvbid0IA0KPj4+PiB0YWtlIGVmZmVjdC4gRml4IHRoaXMgYnkgcHJvcGFn
YXRpbmcgdGhlIHNjYWxpbmdfbWF4X2ZyZXEgY2hhbmdlcyANCj4+Pj4gdG8gdGhlIHNoYXJlZCBt
ZW1vcnkgcmVnaW9uLg0KPj4+Pg0KPj4+PiBGaXhlczogZmZhNTA5NmE3YzMzICgiY3B1ZnJlcTog
YW1kLXBzdGF0ZTogaW1wbGVtZW50IFBzdGF0ZSBFUFAgDQo+Pj4+IHN1cHBvcnQgZm9yIHRoZSBB
TUQgcHJvY2Vzc29ycyIpDQo+Pj4+IFJlcG9ydGVkLWJ5OiBEYXZpZCBBcmNhcmkgPGRhcmNhcmlA
cmVkaGF0LmNvbT4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogRGhhbmFuamF5IFVnd2VrYXIgPERoYW5h
bmpheS5VZ3dla2FyQGFtZC5jb20+DQo+Pj4gUmV2aWV3ZWQtYnk6IE1hcmlvIExpbW9uY2llbGxv
IDxtYXJpby5saW1vbmNpZWxsb0BhbWQuY29tPg0KPj4+PiAtLS0NCj4+Pj4gwqDCoMKgIGRyaXZl
cnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMgfCA0Mw0KPj4+PiArKysrKysrKysrKysrKysrKysrLS0t
LS0tLS0tLS0tLS0tLS0NCj4+Pj4gwqDCoMKgIDEgZmlsZSBjaGFuZ2VkLCAyMyBpbnNlcnRpb25z
KCspLCAyMCBkZWxldGlvbnMoLSkNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3B1
ZnJlcS9hbWQtcHN0YXRlLmMgDQo+Pj4+IGIvZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYyBp
bmRleCA5YWQ2MmRiZThiZmIuLmEwOTJiMTNmZmJjMg0KPj4+PiAxMDA2NDQNCj4+Pj4gLS0tIGEv
ZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYw0KPj4+PiArKysgYi9kcml2ZXJzL2NwdWZyZXEv
YW1kLXBzdGF0ZS5jDQo+Pj4+IEBAIC0yNDcsNiArMjQ3LDI2IEBAIHN0YXRpYyBpbnQNCj4+Pj4g
YW1kX3BzdGF0ZV9nZXRfZW5lcmd5X3ByZWZfaW5kZXgoc3RydWN0IGFtZF9jcHVkYXRhICpjcHVk
YXRhKQ0KPj4+PiDCoMKgwqDCoMKgwqDCoCByZXR1cm4gaW5kZXg7DQo+Pj4+IMKgwqDCoCB9DQo+
Pj4+ICtzdGF0aWMgdm9pZCBwc3RhdGVfdXBkYXRlX3BlcmYoc3RydWN0IGFtZF9jcHVkYXRhICpj
cHVkYXRhLCB1MzINCj4+Pj4gbWluX3BlcmYsDQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgdTMyIGRlc19wZXJmLCB1MzIgbWF4X3BlcmYsIGJvb2wgZmFzdF9zd2l0
Y2gpIHsNCj4+Pj4gK8KgwqDCoCBpZiAoZmFzdF9zd2l0Y2gpDQo+Pj4+ICvCoMKgwqDCoMKgwqDC
oCB3cm1zcmwoTVNSX0FNRF9DUFBDX1JFUSwgDQo+Pj4+ICtSRUFEX09OQ0UoY3B1ZGF0YS0+Y3Bw
Y19yZXFfY2FjaGVkKSk7DQo+Pj4+ICvCoMKgwqAgZWxzZQ0KPj4+PiArwqDCoMKgwqDCoMKgwqAg
d3Jtc3JsX29uX2NwdShjcHVkYXRhLT5jcHUsIE1TUl9BTURfQ1BQQ19SRVEsDQo+Pj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFJFQURfT05DRShjcHVkYXRhLT5jcHBjX3Jl
cV9jYWNoZWQpKTsNCj4+Pj4gK30NCj4+Pj4gKw0KPj4+PiArREVGSU5FX1NUQVRJQ19DQUxMKGFt
ZF9wc3RhdGVfdXBkYXRlX3BlcmYsIHBzdGF0ZV91cGRhdGVfcGVyZik7DQo+Pj4+ICsNCj4+Pj4g
K3N0YXRpYyBpbmxpbmUgdm9pZCBhbWRfcHN0YXRlX3VwZGF0ZV9wZXJmKHN0cnVjdCBhbWRfY3B1
ZGF0YSANCj4+Pj4gKypjcHVkYXRhLA0KPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHUzMiBtaW5fcGVyZiwgdTMyIGRlc19wZXJmLA0KPj4+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHUzMiBtYXhfcGVyZiwgYm9vbCBm
YXN0X3N3aXRjaCkgew0KPj4+PiArwqDCoMKgIHN0YXRpY19jYWxsKGFtZF9wc3RhdGVfdXBkYXRl
X3BlcmYpKGNwdWRhdGEsIG1pbl9wZXJmLCANCj4+Pj4gK2Rlc19wZXJmLA0KPj4+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtYXhfcGVyZiwgZmFzdF9z
d2l0Y2gpOyB9DQo+Pj4+ICsNCj4+Pj4gwqDCoMKgIHN0YXRpYyBpbnQgYW1kX3BzdGF0ZV9zZXRf
ZXBwKHN0cnVjdCBhbWRfY3B1ZGF0YSAqY3B1ZGF0YSwgdTMyIA0KPj4+PiBlcHApDQo+Pj4+IMKg
wqDCoCB7DQo+Pj4+IMKgwqDCoMKgwqDCoMKgIGludCByZXQ7DQo+Pj4+IEBAIC0yNjMsNiArMjgz
LDkgQEAgc3RhdGljIGludCBhbWRfcHN0YXRlX3NldF9lcHAoc3RydWN0IA0KPj4+PiBhbWRfY3B1
ZGF0YSAqY3B1ZGF0YSwgdTMyIGVwcCkNCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAo
IXJldCkNCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNwdWRhdGEtPmVwcF9j
YWNoZWQgPSBlcHA7DQo+Pj4+IMKgwqDCoMKgwqDCoMKgIH0gZWxzZSB7DQo+Pj4+ICvCoMKgwqDC
oMKgwqDCoCBhbWRfcHN0YXRlX3VwZGF0ZV9wZXJmKGNwdWRhdGEsIGNwdWRhdGEtPm1pbl9saW1p
dF9wZXJmLCANCj4+Pj4gKzBVLA0KPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGNwdWRhdGEtPm1heF9saW1pdF9wZXJmLCBmYWxzZSk7DQo+Pj4+
ICsNCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwZXJmX2N0cmxzLmVuZXJneV9wZXJmID0g
ZXBwOw0KPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9IGNwcGNfc2V0X2VwcF9wZXJm
KGNwdWRhdGEtPmNwdSwgJnBlcmZfY3RybHMsIDEpOw0KPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGlmIChyZXQpIHsNCj4+Pj4gQEAgLTQ1MiwxNiArNDc1LDYgQEAgc3RhdGljIGlubGluZSBp
bnQgYW1kX3BzdGF0ZV9pbml0X3BlcmYoc3RydWN0IA0KPj4+PiBhbWRfY3B1ZGF0YSAqY3B1ZGF0
YSkNCj4+Pj4gwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHN0YXRpY19jYWxsKGFtZF9wc3RhdGVfaW5p
dF9wZXJmKShjcHVkYXRhKTsNCj4+Pj4gwqDCoMKgIH0NCj4+Pj4gLXN0YXRpYyB2b2lkIHBzdGF0
ZV91cGRhdGVfcGVyZihzdHJ1Y3QgYW1kX2NwdWRhdGEgKmNwdWRhdGEsIHUzMiANCj4+Pj4gbWlu
X3BlcmYsDQo+Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdTMyIGRl
c19wZXJmLCB1MzIgbWF4X3BlcmYsIGJvb2wgZmFzdF9zd2l0Y2gpIA0KPj4+PiAtew0KPj4+PiAt
wqDCoMKgIGlmIChmYXN0X3N3aXRjaCkNCj4+Pj4gLcKgwqDCoMKgwqDCoMKgIHdybXNybChNU1Jf
QU1EX0NQUENfUkVRLCANCj4+Pj4gUkVBRF9PTkNFKGNwdWRhdGEtPmNwcGNfcmVxX2NhY2hlZCkp
Ow0KPj4+PiAtwqDCoMKgIGVsc2UNCj4+Pj4gLcKgwqDCoMKgwqDCoMKgIHdybXNybF9vbl9jcHUo
Y3B1ZGF0YS0+Y3B1LCBNU1JfQU1EX0NQUENfUkVRLA0KPj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBSRUFEX09OQ0UoY3B1ZGF0YS0+Y3BwY19yZXFfY2FjaGVkKSk7DQo+
Pj4+IC19DQo+Pj4+IC0NCj4+Pj4gwqDCoMKgIHN0YXRpYyB2b2lkIGNwcGNfdXBkYXRlX3BlcmYo
c3RydWN0IGFtZF9jcHVkYXRhICpjcHVkYXRhLA0KPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHUzMiBtaW5fcGVyZiwgdTMyIGRlc19wZXJmLA0KPj4+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHUzMiBtYXhfcGVyZiwgYm9vbCBm
YXN0X3N3aXRjaCkgQEAgLTQ3NSwxNg0KPj4+PiArNDg4LDYgQEANCj4+Pj4gc3RhdGljIHZvaWQg
Y3BwY191cGRhdGVfcGVyZihzdHJ1Y3QgYW1kX2NwdWRhdGEgKmNwdWRhdGEsDQo+Pj4+IMKgwqDC
oMKgwqDCoMKgIGNwcGNfc2V0X3BlcmYoY3B1ZGF0YS0+Y3B1LCAmcGVyZl9jdHJscyk7DQo+Pj4+
IMKgwqDCoCB9DQo+Pj4+IC1ERUZJTkVfU1RBVElDX0NBTEwoYW1kX3BzdGF0ZV91cGRhdGVfcGVy
ZiwgcHN0YXRlX3VwZGF0ZV9wZXJmKTsNCj4+Pj4gLQ0KPj4+PiAtc3RhdGljIGlubGluZSB2b2lk
IGFtZF9wc3RhdGVfdXBkYXRlX3BlcmYoc3RydWN0IGFtZF9jcHVkYXRhIA0KPj4+PiAqY3B1ZGF0
YSwNCj4+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1MzIg
bWluX3BlcmYsIHUzMiBkZXNfcGVyZiwNCj4+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB1MzIgbWF4X3BlcmYsIGJvb2wgZmFzdF9zd2l0Y2gpIC17DQo+Pj4+
IC3CoMKgwqAgc3RhdGljX2NhbGwoYW1kX3BzdGF0ZV91cGRhdGVfcGVyZikoY3B1ZGF0YSwgbWlu
X3BlcmYsIA0KPj4+PiBkZXNfcGVyZiwNCj4+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgbWF4X3BlcmYsIGZhc3Rfc3dpdGNoKTsgLX0NCj4+Pj4gLQ0K
Pj4+PiDCoMKgwqAgc3RhdGljIGlubGluZSBib29sIGFtZF9wc3RhdGVfc2FtcGxlKHN0cnVjdCBh
bWRfY3B1ZGF0YSANCj4+Pj4gKmNwdWRhdGEpDQo+Pj4+IMKgwqDCoCB7DQo+Pj4+IMKgwqDCoMKg
wqDCoMKgIHU2NCBhcGVyZiwgbXBlcmYsIHRzYzsNCj4+Pg0KPj4+DQo+Pg0KPiANCg0K

