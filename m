Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32222C245B
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2019 17:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731504AbfI3PeN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Sep 2019 11:34:13 -0400
Received: from mail-eopbgr820079.outbound.protection.outlook.com ([40.107.82.79]:7424
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732010AbfI3PeN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 30 Sep 2019 11:34:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8TvRXDhqHNnqfM6/bNCSI11HrCi8R4ZLbNUXKAQAw4nRao+F6cACZkwsfQtCRkPVpYXXOgJsVOU115OaxW8cQwVbe+4aOJ4ZkBQN1n6v3+9SWMiSSG55zh40tp1NzdmRuAMyygVOEJE3uCH6ry6F9J7LYaHimRvGTXNhbAIuIGhV8nJ7vMaYYGI//5TJvm2bjPXuXXKKn0g91EGBL62TBhfL16gmLPdP9adatdsPSgJbSKoLoyIWUeCOHanEfUOuA36zVzrkNO33hNRymZsKy/LxOl12PPCqrI0/oaOQ/3kpZj7ftKfNYuLmPboWNUtPdNXs2U+K1GCiWE0r4699w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10jqaYodUVx4a1v837RyVdKbnM+ndk/riX2vgy2TnAU=;
 b=bZtHcloup0V0oEiMNt2dtW1niCR1z+y9rBG2RtnpMeH2hqGadO0a+OXJfLP2r1UjrdtZw+7VrXDuW49iVtEx88GOossS9dHZf1Xe8oZEMHfXm3DOZjDSeliX/L+UTPaWADtHd8SJawkQOcBwufZuQtloLx7PVTyDXG8V96vf3vtj/go1ANTn+GAgCh6jzixsVmEn7dMHM+zTU2MH9S8RyjgmfjNj9bblpQ+zqoH0OkDKLCFBSJ8pvDSVyBHYDEFUlDoNmfQ0pn37gCKE/I0qD3j67kZYNeaudHkh3Mo2H/ItSECBDysH6QgLeOW+WitPWvca6mBHg+cWBwrNmTmTWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10jqaYodUVx4a1v837RyVdKbnM+ndk/riX2vgy2TnAU=;
 b=3Bvc/KPTYx4O9XzTtspIJGpRZTaXn26s3mFD3qvS8moNMeJcRfnLocCJXfZvahWyqc/b7HZUDvH1qngu1kciUVQSLyCrLg6TVWWx328rPAjYzwO7C1qz1X2rg6CAbpaP4Fl+qAMxoDgx3OL2T9R1WTFPoFZXN01FoUpaXehUgnc=
Received: from SN6PR12MB2736.namprd12.prod.outlook.com (52.135.107.27) by
 SN6PR12MB2685.namprd12.prod.outlook.com (52.135.103.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Mon, 30 Sep 2019 15:34:09 +0000
Received: from SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::b1e3:1867:e650:796c]) by SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::b1e3:1867:e650:796c%6]) with mapi id 15.20.2305.017; Mon, 30 Sep 2019
 15:34:09 +0000
From:   "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
To:     shuah <shuah@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Thomas Renninger <trenn@suse.com>, Pu Wen <puwen@hygon.com>,
        Borislav Petkov <bp@suse.de>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Fontana <rfontana@redhat.com>
Subject: Re: [PATCH 1/2] Modify cpupower to schedule itself on cores it is
 reading MSRs from
Thread-Topic: [PATCH 1/2] Modify cpupower to schedule itself on cores it is
 reading MSRs from
Thread-Index: AQHVbj8CzXj8hQvM60aQ8slBTBcq36c/7v4AgAR9goA=
Date:   Mon, 30 Sep 2019 15:34:09 +0000
Message-ID: <251f40a6-9dd6-9611-ce77-b8eee4cf8fc8@amd.com>
References: <20190918163445.129103-1-Janakarajan.Natarajan@amd.com>
 <b90697df-e898-31d2-5149-c223cb11ba5c@kernel.org>
In-Reply-To: <b90697df-e898-31d2-5149-c223cb11ba5c@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN2PR01CA0071.prod.exchangelabs.com (2603:10b6:800::39) To
 SN6PR12MB2736.namprd12.prod.outlook.com (2603:10b6:805:77::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Janakarajan.Natarajan@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2079ecd0-74fa-433a-b0d4-08d745bba2e3
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: SN6PR12MB2685:|SN6PR12MB2685:
x-microsoft-antispam-prvs: <SN6PR12MB268500D844DB7411689EBCEBE7820@SN6PR12MB2685.namprd12.prod.outlook.com>
x-ms-exchange-transport-forked: True
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01762B0D64
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(199004)(189003)(5660300002)(31696002)(7416002)(2906002)(8936002)(186003)(86362001)(6116002)(4326008)(25786009)(31686004)(3846002)(2201001)(7736002)(36756003)(305945005)(66066001)(81166006)(8676002)(81156014)(66446008)(316002)(6486002)(229853002)(446003)(11346002)(476003)(66556008)(6246003)(66476007)(64756008)(2501003)(478600001)(486006)(66946007)(2616005)(26005)(53546011)(6506007)(386003)(102836004)(52116002)(99286004)(6512007)(54906003)(6436002)(71190400001)(14454004)(76176011)(71200400001)(256004)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2685;H:SN6PR12MB2736.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c29Inabd1Eiw2+JPAK6AV4MGRVjUxXucknYZaR4/jph4Kqmr3gp0aZEJt4T1ktuBtSJPYmPHCsHblI8QylyqGMztfMv+RFpN4h4fGs7kjVycw0Z4j2ofFmzOLO3y1IGqHwlH/SVQRF/kGShLluuUSh1K7YBWY74rpmOZ4qLN0MbT0p5tDR3JXzkYhT4cLC9nSiXsJbABxL0xD+WmbV9f/Mj2ISRYVYLq97XdqCqWthsPOupua1YUPwddeZnzkMyLMh5z4BB5MiHjmwrLpC4T5OvYITcQE515kJAd/8cNV5VlI72k5PRk7HahgnA36y09mDTiofq8BYhz84FJp0dHoX/BJ1iB6HgRqm8zfZhBiPfrE3izHpvWK1pu91Vf/2mGSaoB9q8C6sgOcMbQTei73cPYPxeV7vkOp/Tpbdi41Wo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1BE3C2C23CE44943B748B8333A0FA24C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2079ecd0-74fa-433a-b0d4-08d745bba2e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2019 15:34:09.1905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5PDmeYVRIIowbpizNzvbHNManOqZmI0Aw2JhoVgJC26yVgEEB1pONV4mP9wWuWPHYQ7e1sMJC4tI0/OQBvkIjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2685
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gOS8yNy8yMDE5IDE6NTkgUE0sIHNodWFoIHdyb3RlOg0KPiBPbiA5LzE4LzE5IDEwOjM0IEFN
LCBOYXRhcmFqYW4sIEphbmFrYXJhamFuIHdyb3RlOg0KPj4gTW9kaWZ5IGNwdXBvd2VyIHRvIHNj
aGVkdWxlIGl0c2VsZiBvbiBlYWNoIG9mIHRoZSBjcHVzIGluIHRoZSBzeXN0ZW0gYW5kDQo+PiB0
aGVuIGdldCB0aGUgQVBFUkYvTVBFUkYgcmVnaXN0ZXIgdmFsdWVzLg0KPj4NCj4+IFRoaXMgaXMg
YWR2YW50YWdlb3VzIGJlY2F1c2UgYW4gSVBJIGlzIG5vdCBnZW5lcmF0ZWQgd2hlbiBhIA0KPj4g
cmVhZF9tc3IoKSBpcw0KPj4gZXhlY3V0ZWQgb24gdGhlIGxvY2FsIGxvZ2ljYWwgQ1BVIHRoZXJl
YnkgcmVkdWNpbmcgdGhlIGNoYW5jZSBvZiBoYXZpbmcNCj4+IEFQRVJGIGFuZCBNUEVSRiBiZWlu
ZyBvdXQgb2Ygc3luYy4NCj4NCj4gU29tZWhvdyB0aGlzIGRvZXNuJ3QgcmVhZCByaWdodC4gSXMg
dGhpcyB0aGF0IHlvdSBhcmUgdHJ5aW5nIHRvIGF2b2lkDQo+IEFQRVJGIGFuZCBNUEVSRiBiZWlu
ZyBvdXQgb2Ygc3luYyB3aXRoIHRoaXMgY2hhbmdlPw0KPg0KPiBUaGlzIGRlc2NyaXB0aW9uIGlz
IHJhdGhlciBjb25mdXNpbmcuDQoNCg0KV2UgYXJlIHRyeWluZyB0byBhdm9pZCBhIHNlcGFyYXRl
IElQSSBmb3IgQVBFUkYgYW5kIE1QRVJGLiBXZSBoYXZlIHNlZW4gDQp0aGF0IGEgc2VwYXJhdGUg
SVBJIGZvcg0KDQplYWNoIGNhbiBjYXVzZSBBUEVSRiBhbmQgTVBFUkYgdG8gZ28gb3V0IG9mIHN5
bmMuDQoNCg0KSWYgdGhlIGNwdXBvd2VyIGlzIGFscmVhZHkgZXhlY3V0aW5nIG9uIHRoZSBjb3Jl
IGl0IHdhbnRzIHRvIGdldCB0aGUgDQpBUEVSRi9NUEVSRiBmcm9tLCB0aGVuDQoNCmdlbmVyaWNf
ZXhlY19zaW5nbGUoKSBkb2VzIG5vdCBnZW5lcmF0ZSB0aGUgSVBJIHRvIGV4ZWN1dGUgdGhlIHJk
bXNyKCkuIA0KUmF0aGVyIGl0IGp1c3QgZXhlY3V0ZXMNCg0Kb24gdGhlIGN1cnJlbnQgY3B1Lg0K
DQoNCkkgY2FuIGNoYW5nZSB0aGUgZGVzY3JpcHRpb24gdG8gYWRkIG1vcmUgZGV0YWlsLg0KDQoN
Cj4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBKYW5ha2FyYWphbiBOYXRhcmFqYW4gPEphbmFrYXJh
amFuLk5hdGFyYWphbkBhbWQuY29tPg0KPj4gLS0tDQo+PiDCoCAuLi4vdXRpbHMvaWRsZV9tb25p
dG9yL21wZXJmX21vbml0b3IuY8KgwqDCoMKgwqDCoMKgIHwgMzggKysrKysrKysrKysrKystLS0t
LQ0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygt
KQ0KPj4NCj4+IGRpZmYgLS1naXQgYS90b29scy9wb3dlci9jcHVwb3dlci91dGlscy9pZGxlX21v
bml0b3IvbXBlcmZfbW9uaXRvci5jIA0KPj4gYi90b29scy9wb3dlci9jcHVwb3dlci91dGlscy9p
ZGxlX21vbml0b3IvbXBlcmZfbW9uaXRvci5jDQo+PiBpbmRleCA0NDgwNmE2ZGFlMTEuLjhiMDcy
ZTM5Yzg5NyAxMDA2NDQNCj4+IC0tLSBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL3V0aWxzL2lkbGVf
bW9uaXRvci9tcGVyZl9tb25pdG9yLmMNCj4+ICsrKyBiL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL3V0
aWxzL2lkbGVfbW9uaXRvci9tcGVyZl9tb25pdG9yLmMNCj4+IEBAIC0xMCw2ICsxMCw3IEBADQo+
PiDCoCAjaW5jbHVkZSA8c3RkbGliLmg+DQo+PiDCoCAjaW5jbHVkZSA8c3RyaW5nLmg+DQo+PiDC
oCAjaW5jbHVkZSA8bGltaXRzLmg+DQo+PiArI2luY2x1ZGUgPHNjaGVkLmg+DQo+PiDCoCDCoCAj
aW5jbHVkZSA8Y3B1ZnJlcS5oPg0KPj4gwqAgQEAgLTg2LDE1ICs4NywzMyBAQCBzdGF0aWMgaW50
IG1wZXJmX2dldF90c2ModW5zaWduZWQgbG9uZyBsb25nICp0c2MpDQo+PiDCoMKgwqDCoMKgIHJl
dHVybiByZXQ7DQo+PiDCoCB9DQo+PiDCoCArc3RhdGljIGludCBnZXRfYXBlcmZfbXBlcmYoaW50
IGNwdSwgdW5zaWduZWQgbG9uZyBsb25nICphdmFsLA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgdW5zaWduZWQgbG9uZyBsb25nICptdmFsKQ0KPj4gK3sNCj4+ICvCoMKgwqAgY3B1
X3NldF90IHNldDsNCj4+ICvCoMKgwqAgaW50IHJldDsNCj4+ICsNCj4+ICvCoMKgwqAgQ1BVX1pF
Uk8oJnNldCk7DQo+PiArwqDCoMKgIENQVV9TRVQoY3B1LCAmc2V0KTsNCj4+ICvCoMKgwqAgaWYg
KHNjaGVkX3NldGFmZmluaXR5KGdldHBpZCgpLCBzaXplb2Yoc2V0KSwgJnNldCkgPT0gLTEpIHsN
Cj4+ICvCoMKgwqDCoMKgwqDCoCBkcHJpbnQoIkNvdWxkIG5vdCBtaWdyYXRlIHRvIGNwdTogJWRc
biIsIGNwdSk7DQo+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDE7DQo+PiArwqDCoMKgIH0NCj4+
ICsNCj4+ICvCoMKgwqAgcmV0ID0gcmVhZF9tc3IoY3B1LCBNU1JfQVBFUkYsIGF2YWwpOw0KPj4g
K8KgwqDCoCByZXQgfD0gcmVhZF9tc3IoY3B1LCBNU1JfTVBFUkYsIG12YWwpOw0KPj4gKw0KPj4g
K8KgwqDCoCByZXR1cm4gcmV0Ow0KPj4gK30NCj4+ICsNCj4+IMKgIHN0YXRpYyBpbnQgbXBlcmZf
aW5pdF9zdGF0cyh1bnNpZ25lZCBpbnQgY3B1KQ0KPj4gwqAgew0KPj4gLcKgwqDCoCB1bnNpZ25l
ZCBsb25nIGxvbmcgdmFsOw0KPj4gK8KgwqDCoCB1bnNpZ25lZCBsb25nIGxvbmcgYXZhbCwgbXZh
bDsNCj4+IMKgwqDCoMKgwqAgaW50IHJldDsNCj4+IMKgIC3CoMKgwqAgcmV0ID0gcmVhZF9tc3Io
Y3B1LCBNU1JfQVBFUkYsICZ2YWwpOw0KPj4gLcKgwqDCoCBhcGVyZl9wcmV2aW91c19jb3VudFtj
cHVdID0gdmFsOw0KPj4gLcKgwqDCoCByZXQgfD0gcmVhZF9tc3IoY3B1LCBNU1JfTVBFUkYsICZ2
YWwpOw0KPj4gLcKgwqDCoCBtcGVyZl9wcmV2aW91c19jb3VudFtjcHVdID0gdmFsOw0KPj4gK8Kg
wqDCoCByZXQgPSBnZXRfYXBlcmZfbXBlcmYoY3B1LCAmYXZhbCwgJm12YWwpOw0KPg0KPiBnZXRf
YXBlcmZfbXBlcmYoKSBjb3VsZCByZXR1cm4gZXJyb3IgcmlnaHQ/IEl0IHJldHVybnMgMSB3aGVu
DQo+IHNjaGVkX3NldGFmZmluaXR5KCkgZmFpbHMuIFNob3VsZG4ndCB0aGUgcmV0dXJuIHZhbHVl
IGNoZWNrZWQsDQo+IGluc3RlYWQgb2YgdXNpbmcgYXZhbCBhbmQgbXZhbD8NCg0KDQpXZSBzZXQg
dGhlIGlzX3ZhbGlkW2NwdV0gdG8gdGhlIHJldHVybiB2YWx1ZS4gTGF0ZXIgb24gdGhlIGlzX3Zh
bGlkW2NwdV0NCg0KaXMgY2hlY2tlZCBiZWZvcmUgcHJvY2VlZGluZyB0byBjYWxjdWxhdGUgdGhl
IGVmZmVjdGl2ZSBmcmVxLg0KDQoNClRoYW5rcy4NCg0KDQo+DQo+PiArwqDCoMKgIGFwZXJmX3By
ZXZpb3VzX2NvdW50W2NwdV0gPSBhdmFsOw0KPj4gK8KgwqDCoCBtcGVyZl9wcmV2aW91c19jb3Vu
dFtjcHVdID0gbXZhbDsNCj4+IMKgwqDCoMKgwqAgaXNfdmFsaWRbY3B1XSA9ICFyZXQ7DQo+PiDC
oCDCoMKgwqDCoMKgIHJldHVybiAwOw0KPj4gQEAgLTEwMiwxMyArMTIxLDEyIEBAIHN0YXRpYyBp
bnQgbXBlcmZfaW5pdF9zdGF0cyh1bnNpZ25lZCBpbnQgY3B1KQ0KPj4gwqAgwqAgc3RhdGljIGlu
dCBtcGVyZl9tZWFzdXJlX3N0YXRzKHVuc2lnbmVkIGludCBjcHUpDQo+PiDCoCB7DQo+PiAtwqDC
oMKgIHVuc2lnbmVkIGxvbmcgbG9uZyB2YWw7DQo+PiArwqDCoMKgIHVuc2lnbmVkIGxvbmcgbG9u
ZyBhdmFsLCBtdmFsOw0KPj4gwqDCoMKgwqDCoCBpbnQgcmV0Ow0KPj4gwqAgLcKgwqDCoCByZXQg
PSByZWFkX21zcihjcHUsIE1TUl9BUEVSRiwgJnZhbCk7DQo+PiAtwqDCoMKgIGFwZXJmX2N1cnJl
bnRfY291bnRbY3B1XSA9IHZhbDsNCj4+IC3CoMKgwqAgcmV0IHw9IHJlYWRfbXNyKGNwdSwgTVNS
X01QRVJGLCAmdmFsKTsNCj4+IC3CoMKgwqAgbXBlcmZfY3VycmVudF9jb3VudFtjcHVdID0gdmFs
Ow0KPj4gK8KgwqDCoCByZXQgPSBnZXRfYXBlcmZfbXBlcmYoY3B1LCAmYXZhbCwgJm12YWwpOw0K
Pg0KPiBTYW1lIGNvbW1lbnRzIGFzIGFib3ZlIGhlcmUuDQo+DQo+PiArwqDCoMKgIGFwZXJmX2N1
cnJlbnRfY291bnRbY3B1XSA9IGF2YWw7DQo+PiArwqDCoMKgIG1wZXJmX2N1cnJlbnRfY291bnRb
Y3B1XSA9IG12YWw7DQo+PiDCoMKgwqDCoMKgIGlzX3ZhbGlkW2NwdV0gPSAhcmV0Ow0KPj4gwqAg
wqDCoMKgwqDCoCByZXR1cm4gMDsNCj4+DQo+DQo+IHRoYW5rcywNCj4gLS0gU2h1YWgNCg==
