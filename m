Return-Path: <linux-pm+bounces-13734-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D33896E4A7
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 23:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 077EC280217
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 21:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00EC190055;
	Thu,  5 Sep 2024 21:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=viasat.com header.i=@viasat.com header.b="k90h41/Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0f-0085b301.gpphosted.com (mx0f-0085b301.gpphosted.com [67.231.155.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF66A165F0E;
	Thu,  5 Sep 2024 21:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.155.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725570575; cv=none; b=OOREFdQmKq0exyM8RyLyTvFL8w8UXai1qp2OqONDXXPowEm3tcBZJVDYdGXDJcKguFmIOiLPKtMDzK/rke90ihiFyXcqO4yNovz5rl4R3Nr24EkYjluUgJUmnhwV2gpdfAeFHTj6HpQLuRaSLTBtlKBKlT0UgHA9tjMlLTjnF1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725570575; c=relaxed/simple;
	bh=YEo1o6Da+GwcHd+Zdww7y+YJnhNBcrYiF6y1nDv9Bzs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KOW2uRbvf+cIicwtZQuDbpUdW2FxXKG53ltblrxMEIHrFB3nl6ZPUW6zjb/pUAJ1+2N5BErMfofKJitjnmvLfEf1OjOLQDw8FLgXMlpY0/PLWTNtfIGANhY7pUJ5AH+wcSMrGYPmmwgz3duESTGomlK3bB8yMsacrLX/NAAf7sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=viasat.com; spf=pass smtp.mailfrom=viasat.com; dkim=pass (2048-bit key) header.d=viasat.com header.i=@viasat.com header.b=k90h41/Z; arc=none smtp.client-ip=67.231.155.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=viasat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=viasat.com
Received: from pps.filterd (m0351330.ppops.net [127.0.0.1])
	by mx0f-0085b301.gpphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 485IOUFY029865;
	Thu, 5 Sep 2024 21:09:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=viasat.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=YEo1o6Da+GwcHd+Zdww7y+YJnhNBcrYiF6y1nDv9Bzs=;
 b=k90h41/Z64npPDDE9RWfinCaYyoZ6hklZTU0ijPbKgK9yvr4oGO8YmllQqRkz8GI0w65
 1InWLIX/fpfDOl86k+UvJ3hSgNCJ9DmtU1CaQcgcvYlXUWbNeVaYEgK8wfTigjBuSuQh
 3GWAW1E+sGIe10+FLOZrg7JMhSkTF0w8bSEi8s7o19lDD0yf/0jyS9HVxDzD6Qy9b70D
 /Tzn25sB52uHf4YVPD6yPRpSMW5TK0xx2Y7jt2vaa9elM0rcv1b8NSFuqsNEBQMhJRtK
 2X+jHHeiYhA/HTTOyBK1G2YI8yIlYb1dSv5duXpjgEpRLCPTh/AuJeL0RqqM2FpuTTOB uA== 
Received: from wdc1exchp02.hq.corp.viasat.com ([8.37.104.42])
	by mx0f-0085b301.gpphosted.com (PPS) with ESMTPS id 41fhw6h0cr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 05 Sep 2024 21:09:12 +0000
Received: from WDC1EXCHP05.hq.corp.viasat.com (10.228.7.145) by
 WDC1EXCHP02.hq.corp.viasat.com (10.228.7.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Sep 2024 15:09:10 -0600
Received: from WDC1EXCHP05.hq.corp.viasat.com ([fe80::e59e:1518:91aa:55e9]) by
 WDC1EXCHP05.hq.corp.viasat.com ([fe80::e59e:1518:91aa:55e9%23]) with mapi id
 15.01.2507.039; Thu, 5 Sep 2024 15:09:10 -0600
From: "Jones, Morgan" <Morgan.Jones@viasat.com>
To: Mario Limonciello <mario.limonciello@amd.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Arcari
	<darcari@redhat.com>,
        Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "viresh.kumar@linaro.org"
	<viresh.kumar@linaro.org>,
        "gautham.shenoy@amd.com" <gautham.shenoy@amd.com>,
        "perry.yuan@amd.com" <perry.yuan@amd.com>,
        "skhan@linuxfoundation.org"
	<skhan@linuxfoundation.org>,
        "li.meng@amd.com" <li.meng@amd.com>,
        "ray.huang@amd.com" <ray.huang@amd.com>
Subject: RE: [EXTERNAL] Re: [PATCH v2 2/2] cpufreq/amd-pstate: Fix the
 scaling_max_freq setting on shared memory CPPC systems
Thread-Topic: [EXTERNAL] Re: [PATCH v2 2/2] cpufreq/amd-pstate: Fix the
 scaling_max_freq setting on shared memory CPPC systems
Thread-Index: AQHTmcEn27fAHGT7pNe1jAQ3Ww8GHAMI4eQEAR3OYjGyM+kx8IAAZwsA//+b9MCAAInhgIAAC7yA//+1HeCAAWldgIABpycA///+NiA=
Date: Thu, 5 Sep 2024 21:09:10 +0000
Message-ID: <f9085ef60f4b42c89b72c650a14db29c@viasat.com>
References: <20240702081413.5688-1-Dhananjay.Ugwekar@amd.com>
 <20240702081413.5688-3-Dhananjay.Ugwekar@amd.com>
 <bb09e7e8-5824-4bc1-9697-1929a4cf717e@amd.com>
 <d6392b1af4ab459195a1954e4e5ad87e@viasat.com>
 <bb49cd31-a02f-46f9-8757-554bd7783261@amd.com>
 <66f08ce529d246bd8315c87fe0f880e6@viasat.com>
 <645f2e77-336b-4a9c-b33e-06043010028b@amd.com>
 <2e36ee28-d3b8-4cdb-9d64-3d26ef0a9180@amd.com>
 <d6477bd059df414d85cd825ac8a5350d@viasat.com>
 <d6808d8e-acaf-46ac-812a-0a3e1df75b09@amd.com>
 <7f50abf9-e11a-4630-9970-f894c9caee52@amd.com>
In-Reply-To: <7f50abf9-e11a-4630-9970-f894c9caee52@amd.com>
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
X-Proofpoint-GUID: 02yJOrcwAQlNHhHv_3ai58yh1plLqyPr
X-Proofpoint-ORIG-GUID: 02yJOrcwAQlNHhHv_3ai58yh1plLqyPr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_16,2024-09-05_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 bulkscore=0
 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409050157

TWFyaW8sDQoNCkNvbmZpcm1lZC4gVGhhbmsgeW91IGZvciB0aGUgaGVscCEgU2xpZ2h0bHkgZGlm
ZmVyZW50IHJlZnMgb24gbXkgZW5kOg0KDQpSZW1vdGVzOg0KDQpuZXh0ICAgIGh0dHBzOi8vZ2l0
Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L25leHQvbGludXgtbmV4dC5naXQg
KGZldGNoKQ0KbmV4dCAgICBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2Vy
bmVsL2dpdC9uZXh0L2xpbnV4LW5leHQuZ2l0IChwdXNoKQ0Kb3JpZ2luICBnaXQ6Ly9naXQua2Vy
bmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvc3RhYmxlL2xpbnV4LmdpdCAoZmV0Y2gp
DQpvcmlnaW4gIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9z
dGFibGUvbGludXguZ2l0IChwdXNoKQ0Kc3VwZXJtMSBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1
Yi9zY20vbGludXgva2VybmVsL2dpdC9zdXBlcm0xL2xpbnV4LmdpdC8gKGZldGNoKQ0Kc3VwZXJt
MSBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9zdXBlcm0x
L2xpbnV4LmdpdC8gKHB1c2gpDQp0b3J2YWxkcyAgICAgICAgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcv
cHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdCAoZmV0Y2gpDQp0b3J2
YWxkcyAgICAgICAgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0
L3RvcnZhbGRzL2xpbnV4LmdpdCAocHVzaCkNCg0KUGF0Y2hlczoNCg0KZ2l0IGZvcm1hdC1wYXRj
aCAxMjc1M2Q3MWU4YzVeLi4xMjc1M2Q3MWU4YzUNCmdpdCBmb3JtYXQtcGF0Y2ggZjNhMDUyMzkx
ODIyYjc3MmI0ZTI3ZjI1OTQ1MjZjZjFlYjEwM2NhYl4uLmYzYTA1MjM5MTgyMmI3NzJiNGUyN2Yy
NTk0NTI2Y2YxZWIxMDNjYWINCmdpdCBmb3JtYXQtcGF0Y2ggYmYyMDJlNjU0YmZhNTdmYjhjZjlk
OTNkNGM2ODU1ODkwYjcwYjljNF4uLmJmMjAyZTY1NGJmYTU3ZmI4Y2Y5ZDkzZDRjNjg1NTg5MGI3
MGI5YzQNCg0KUmVzdWx0czoNCg0KTGludXggcmVkYWN0IDYuNi40OCAjMS1OaXhPUyBTTVAgUFJF
RU1QVF9EWU5BTUlDIFR1ZSBKYW4gIDEgMDA6MDA6MDAgVVRDIDE5ODAgeDg2XzY0IEdOVS9MaW51
eA0KDQphbmFseXppbmcgQ1BVIDU2Og0KICBkcml2ZXI6IGFtZC1wc3RhdGUtZXBwDQogIENQVXMg
d2hpY2ggcnVuIGF0IHRoZSBzYW1lIGhhcmR3YXJlIGZyZXF1ZW5jeTogNTYNCiAgQ1BVcyB3aGlj
aCBuZWVkIHRvIGhhdmUgdGhlaXIgZnJlcXVlbmN5IGNvb3JkaW5hdGVkIGJ5IHNvZnR3YXJlOiA1
Ng0KICBtYXhpbXVtIHRyYW5zaXRpb24gbGF0ZW5jeTogIENhbm5vdCBkZXRlcm1pbmUgb3IgaXMg
bm90IHN1cHBvcnRlZC4NCiAgaGFyZHdhcmUgbGltaXRzOiA0MDAgTUh6IC0gMy4zNSBHSHoNCiAg
YXZhaWxhYmxlIGNwdWZyZXEgZ292ZXJub3JzOiBwZXJmb3JtYW5jZSBwb3dlcnNhdmUNCiAgY3Vy
cmVudCBwb2xpY3k6IGZyZXF1ZW5jeSBzaG91bGQgYmUgd2l0aGluIDQwMCBNSHogYW5kIDMuMzUg
R0h6Lg0KICAgICAgICAgICAgICAgICAgVGhlIGdvdmVybm9yICJwZXJmb3JtYW5jZSIgbWF5IGRl
Y2lkZSB3aGljaCBzcGVlZCB0byB1c2UNCiAgICAgICAgICAgICAgICAgIHdpdGhpbiB0aGlzIHJh
bmdlLg0KICBjdXJyZW50IENQVSBmcmVxdWVuY3k6IFVuYWJsZSB0byBjYWxsIGhhcmR3YXJlDQog
IGN1cnJlbnQgQ1BVIGZyZXF1ZW5jeTogMi4wOSBHSHogKGFzc2VydGVkIGJ5IGNhbGwgdG8ga2Vy
bmVsKQ0KICBib29zdCBzdGF0ZSBzdXBwb3J0Og0KICAgIFN1cHBvcnRlZDogeWVzDQogICAgQWN0
aXZlOiB5ZXMNCiAgICBBTUQgUFNUQVRFIEhpZ2hlc3QgUGVyZm9ybWFuY2U6IDI1NS4gTWF4aW11
bSBGcmVxdWVuY3k6IDMuMzUgR0h6Lg0KICAgIEFNRCBQU1RBVEUgTm9taW5hbCBQZXJmb3JtYW5j
ZTogMTUyLiBOb21pbmFsIEZyZXF1ZW5jeTogMi4wMCBHSHouDQogICAgQU1EIFBTVEFURSBMb3dl
c3QgTm9uLWxpbmVhciBQZXJmb3JtYW5jZTogMTE1LiBMb3dlc3QgTm9uLWxpbmVhciBGcmVxdWVu
Y3k6IDEuNTEgR0h6Lg0KICAgIEFNRCBQU1RBVEUgTG93ZXN0IFBlcmZvcm1hbmNlOiAzMS4gTG93
ZXN0IEZyZXF1ZW5jeTogNDAwIE1Iei4NCg0KQW5kIG91ciBidWlsZHMgYXJlIGJhY2sgdG8gYmVp
bmcgZmFzdCB3aXRoIGBhbWRfcHN0YXRlPWFjdGl2ZSBhbWRfcHJlZmNvcmU9ZW5hYmxlIGFtZF9w
c3RhdGUuc2hhcmVkX21lbT0xYC4NCg0KTW9yZ2FuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQpGcm9tOiBNYXJpbyBMaW1vbmNpZWxsbyA8bWFyaW8ubGltb25jaWVsbG9AYW1kLmNvbT4g
DQpTZW50OiBUaHVyc2RheSwgU2VwdGVtYmVyIDUsIDIwMjQgODoxMiBBTQ0KVG86IEpvbmVzLCBN
b3JnYW4gPE1vcmdhbi5Kb25lc0B2aWFzYXQuY29tPg0KQ2M6IGxpbnV4LXBtQHZnZXIua2VybmVs
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgRGF2aWQgQXJjYXJpIDxkYXJjYXJp
QHJlZGhhdC5jb20+OyBEaGFuYW5qYXkgVWd3ZWthciA8RGhhbmFuamF5LlVnd2VrYXJAYW1kLmNv
bT47IHJhZmFlbEBrZXJuZWwub3JnOyB2aXJlc2gua3VtYXJAbGluYXJvLm9yZzsgZ2F1dGhhbS5z
aGVub3lAYW1kLmNvbTsgcGVycnkueXVhbkBhbWQuY29tOyBza2hhbkBsaW51eGZvdW5kYXRpb24u
b3JnOyBsaS5tZW5nQGFtZC5jb207IHJheS5odWFuZ0BhbWQuY29tDQpTdWJqZWN0OiBSZTogW0VY
VEVSTkFMXSBSZTogW1BBVENIIHYyIDIvMl0gY3B1ZnJlcS9hbWQtcHN0YXRlOiBGaXggdGhlIHNj
YWxpbmdfbWF4X2ZyZXEgc2V0dGluZyBvbiBzaGFyZWQgbWVtb3J5IENQUEMgc3lzdGVtcw0KDQpI
aSBNb3JnYW4sDQoNClBsZWFzZSBhcHBseSB0aGVzZSAzIGNvbW1pdHM6DQoNCmNvbW1pdCAxMjc1
M2Q3MWU4YzUgKCJBQ1BJOiBDUFBDOiBBZGQgaGVscGVyIHRvIGdldCB0aGUgaGlnaGVzdCBwZXJm
b3JtYW5jZSB2YWx1ZSIpIGNvbW1pdCBlZDQyOWM2ODZiNzkgKCJjcHVmcmVxOiBhbWQtcHN0YXRl
OiBFbmFibGUgYW1kLXBzdGF0ZSBwcmVmZXJyZWQgY29yZSBzdXBwb3J0IikgY29tbWl0IDNkMjkx
ZmU0N2ZlMSAoImNwdWZyZXE6IGFtZC1wc3RhdGU6IGZpeCB0aGUgaGlnaGVzdCBmcmVxdWVuY3kg
aXNzdWUgd2hpY2ggbGltaXRzIHBlcmZvcm1hbmNlIikNCg0KVGhlIGZpcnN0IHR3byBzaG91bGQg
aGVscCB5b3VyIHN5c3RlbSwgdGhlIHRoaXJkIHdpbGwgcHJldmVudCBpbnRyb2R1Y2luZyBhIHJl
Z3Jlc3Npb24gb24gYSBkaWZmZXJlbnQgb25lLg0KDQpBc3N1bWluZyB0aGF0IHdvcmtzIHdlIHNo
b3VsZCBhc2sgQHN0YWJsZSB0byBwdWxsIGFsbCAzIGluIHRvIGZpeCB0aGlzIHJlZ3Jlc3Npb24u
DQoNClRoYW5rcywNCg0KT24gOS80LzIwMjQgMDg6NTcsIE1hcmlvIExpbW9uY2llbGxvIHdyb3Rl
Og0KPiBNb3JnYW4sDQo+IA0KPiBJIHdhcyByZWZlcnJpbmcgc3BlY2ZpaWNhbGx5IHRvIHRoZSB2
ZXJzaW9uIHRoYXQgbGFuZGVkIGluIExpbnVzJyB0cmVlOg0KPiBodHRwczovL3VybGRlZmVuc2Uu
dXMvdjMvX19odHRwczovL2dpdC5rZXJuZWwub3JnL3RvcnZhbGRzL2MvODE2NGY3NDMzDQo+IDI2
NF9fOyEhQzVBc204dVJuWlFtbFJsbiFhSVpFREViSVVLRDdPcnhOMGIwS2pvcUtZREwyeU1rd2s0
RUs3eF9vU255SFENCj4gNk1FcTd5dDZKSGpkMFREOURnRVlFV0RjRjU4T0tMOGM3RzExYlQzZFNx
TDhlTSQNCj4gDQo+IEJ1dCB5ZWFoIGl0J3MgZWZmZWN0aXZlbHkgdGhlIHNhbWUgdGhpbmcuwqAg
SW4gYW55IGNhc2UsIGl0J3Mgbm90IHRoZSANCj4gc29sdXRpb24uDQo+IA0KPiBXZSBoYWQgc29t
ZSBpbnRlcm5hbCBkaXNjdXNzaW9uIGFuZCBzdXNwZWN0IHRoaXMgaXMgZHVlIHRvIG1pc3Npbmcg
DQo+IHByZWZjb3JlIHBhdGNoZXMgaW4gNi42IGFzIHRoYXQgZmVhdHVyZSBsYW5kZWQgaW4gNi45
LsKgIFdlJ2xsIHRyeSB0byANCj4gcmVwcm9kdWNlIHRoaXMgb24gYSBSb21lIHN5c3RlbSBhbmQg
Y29tZSBiYWNrIHdpdGggb3VyIGZpbmRpbmdzIGFuZCANCj4gc3VnZ2VzdGlvbnMgd2hhdCB0byBk
by4NCj4gDQo+IFRoYW5rcywNCj4gDQoNCg==

