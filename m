Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77048D797E
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2019 17:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732845AbfJOPMy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Oct 2019 11:12:54 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:9818 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726523AbfJOPMy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Oct 2019 11:12:54 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9FFAkqQ021745;
        Tue, 15 Oct 2019 17:12:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=Dz/82zOXMhfMmklzqpL72vLdKWuedjy+hvTqhAoCBe0=;
 b=UcLs1Mq9WYwpkYMT5Yq7HM/zidaf654mUbnTN7jf3CJG7H/Cmz5LpcYbevsCsbeeBcsx
 Qs+BDE1EZtLgyPWPp97mYe1+/LnJQnw2yoVX/Lj7u3MMwDVX6/IYG88Y10Gl1Uzl/5N7
 7+jbqlFj0LlQRWUbgUiGv9mc60vO9yQx9gPuiy46/U5nlpVSTj/wXirwxZ4AWycOnxjw
 1tbqK4ysBLXKsH7s6j/Nbhi1JpPHTDM5HLvls1rbJnOj0kXQIxMU+2Nys3OAK84VkM6y
 mPcMOMHN/78HMfD1hSVZDxOuoUIlxh2PAP73jH0uJKK0z7Iqn1iSYxz7nhfE9AY7nb93 TQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2vk4a18xk6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Oct 2019 17:12:27 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9D19C100038;
        Tue, 15 Oct 2019 17:12:26 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 83C452C0B1D;
        Tue, 15 Oct 2019 17:12:26 +0200 (CEST)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 15 Oct
 2019 17:12:26 +0200
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Tue, 15 Oct 2019 17:12:26 +0200
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     Ben Dooks <ben.dooks@codethink.co.uk>,
        "linux-kernel@lists.codethink.co.uk" 
        <linux-kernel@lists.codethink.co.uk>
CC:     Amit Kucheria <amit.kucheria@verdurent.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [Linux-stm32] [PATCH] thermal: stm32: make stm_thermal_pm_ops
 static
Thread-Topic: [Linux-stm32] [PATCH] thermal: stm32: make stm_thermal_pm_ops
 static
Thread-Index: AQHVg2LySKg+3iRMIESRd33erHyNMqdbrZeA
Date:   Tue, 15 Oct 2019 15:12:26 +0000
Message-ID: <b5e353bc-1171-1559-351f-2e54ef6749fe@st.com>
References: <20191015141454.15402-1-ben.dooks@codethink.co.uk>
In-Reply-To: <20191015141454.15402-1-ben.dooks@codethink.co.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.45]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C885B1D9DAA4E145A7287A236169A642@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-15_05:2019-10-15,2019-10-15 signatures=0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQpPbiAxMC8xNS8xOSA0OjE0IFBNLCBCZW4gRG9va3Mgd3JvdGU6DQo+IFRoZSBzdG1fdGhlcm1h
bF9wbV9vcHMgc3RydWN0IGlzIG5vdCBleHBvcnRlZCB0byBhbnkNCj4gb3RoZXIgdW5pdHMsIHNv
IG1ha2UgaXQgc3RhdGljIHRvIGF2b2lkIHRoZSBmb2xsb3dpbmcNCj4gc3BhcnNlIHdhcm5pbmc6
DQo+DQo+IGRyaXZlcnMvdGhlcm1hbC9zdC9zdG1fdGhlcm1hbC5jOjU5OToxOiB3YXJuaW5nOiBz
eW1ib2wgJ3N0bV90aGVybWFsX3BtX29wcycgd2FzIG5vdCBkZWNsYXJlZC4gU2hvdWxkIGl0IGJl
IHN0YXRpYz8NCg0KUmV2aWV3ZWQtYnk6IEJlbmphbWluIEdhaWduYXJkIDxiZW5qYW1pbi5nYWln
bmFyZEBzdC5jb20+DQoNClRoYW5rcywNCg0KQmVuamFtaW4NCg0KPg0KPiBTaWduZWQtb2ZmLWJ5
OiBCZW4gRG9va3MgPGJlbi5kb29rc0Bjb2RldGhpbmsuY28udWs+DQo+IC0tLQ0KPiBDYzogWmhh
bmcgUnVpIDxydWkuemhhbmdAaW50ZWwuY29tPg0KPiBDYzogRGFuaWVsIExlemNhbm8gPGRhbmll
bC5sZXpjYW5vQGxpbmFyby5vcmc+DQo+IENjOiBBbWl0IEt1Y2hlcmlhIDxhbWl0Lmt1Y2hlcmlh
QHZlcmR1cmVudC5jb20+DQo+IENjOiBNYXhpbWUgQ29xdWVsaW4gPG1jb3F1ZWxpbi5zdG0zMkBn
bWFpbC5jb20+DQo+IENjOiBBbGV4YW5kcmUgVG9yZ3VlIDxhbGV4YW5kcmUudG9yZ3VlQHN0LmNv
bT4NCj4gQ2M6IGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZw0KPiBDYzogbGludXgtc3RtMzJAc3Qt
bWQtbWFpbG1hbi5zdG9ybXJlcGx5LmNvbQ0KPiBDYzogbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnDQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IC0tLQ0K
PiAgIGRyaXZlcnMvdGhlcm1hbC9zdC9zdG1fdGhlcm1hbC5jIHwgMiArLQ0KPiAgIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy90aGVybWFsL3N0L3N0bV90aGVybWFsLmMgYi9kcml2ZXJzL3RoZXJtYWwvc3Qvc3Rt
X3RoZXJtYWwuYw0KPiBpbmRleCBjZjlkZGM1MmYzMGUuLjQwYmMxM2M2OGZiYSAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy90aGVybWFsL3N0L3N0bV90aGVybWFsLmMNCj4gKysrIGIvZHJpdmVycy90
aGVybWFsL3N0L3N0bV90aGVybWFsLmMNCj4gQEAgLTU5Niw3ICs1OTYsNyBAQCBzdGF0aWMgaW50
IHN0bV90aGVybWFsX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICAgfQ0KPiAgICNlbmRp
ZiAvKiBDT05GSUdfUE1fU0xFRVAgKi8NCj4gICANCj4gLVNJTVBMRV9ERVZfUE1fT1BTKHN0bV90
aGVybWFsX3BtX29wcywgc3RtX3RoZXJtYWxfc3VzcGVuZCwgc3RtX3RoZXJtYWxfcmVzdW1lKTsN
Cj4gK3N0YXRpYyBTSU1QTEVfREVWX1BNX09QUyhzdG1fdGhlcm1hbF9wbV9vcHMsIHN0bV90aGVy
bWFsX3N1c3BlbmQsIHN0bV90aGVybWFsX3Jlc3VtZSk7DQo+ICAgDQo+ICAgc3RhdGljIGNvbnN0
IHN0cnVjdCB0aGVybWFsX3pvbmVfb2ZfZGV2aWNlX29wcyBzdG1fdHpfb3BzID0gew0KPiAgIAku
Z2V0X3RlbXAJPSBzdG1fdGhlcm1hbF9nZXRfdGVtcCw=
