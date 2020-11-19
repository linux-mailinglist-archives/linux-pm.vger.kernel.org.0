Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 539D42B8C4D
	for <lists+linux-pm@lfdr.de>; Thu, 19 Nov 2020 08:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgKSH1h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Nov 2020 02:27:37 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:33930 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726302AbgKSH1g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Nov 2020 02:27:36 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AJ7O2O3032168;
        Thu, 19 Nov 2020 08:27:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=nxAKb35TANt5smQzI/hSFX9HkvhZC4uKWxm8+ig5zZc=;
 b=vqoyPYWUu6pml9ty9eDeWJxDcjeEVpccxtxxoeorZUXe6zMdBDHETRKNkwpset7EUC+f
 2/3k1WNEUX8JAOym1MTon/Bz5dc2arhqBMmZ+hxyLaX96xEyA0/laLOr9ONcT13Yz8UH
 bZoEFCIW5Rvk9fPadn2lgo0caLSPnocgcVuAzxlvguHIpySHMDuTz8LRyS1ri1EJt6+v
 AOzxMEZYzHxyCaG7Aso/BumEeqJLglfGOenZjkHS7YpzvTnq2nwR1MAEp1DPO4RSboIy
 f+fwqFQKkprYCz/eE73JVE5GjVp0vYxlHV1Qodkv7XaTJjQCPzkTizjnSSDETrRL+OJK xQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34t5w25fu5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Nov 2020 08:27:29 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B7CEC100034;
        Thu, 19 Nov 2020 08:27:28 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A35E022DA6F;
        Thu, 19 Nov 2020 08:27:28 +0100 (CET)
Received: from SFHDAG2NODE3.st.com (10.75.127.6) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 19 Nov
 2020 08:27:27 +0100
Received: from SFHDAG2NODE3.st.com ([fe80::31b3:13bf:2dbe:f64c]) by
 SFHDAG2NODE3.st.com ([fe80::31b3:13bf:2dbe:f64c%20]) with mapi id
 15.00.1473.003; Thu, 19 Nov 2020 08:27:27 +0100
From:   Patrice CHOTARD <patrice.chotard@st.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Kevin Hilman" <khilman@kernel.org>,
        Erwan LE RAY <erwan.leray@st.com>,
        "Alexandre TORGUE" <alexandre.torgue@st.com>,
        Fabrice GASNIER <fabrice.gasnier@st.com>,
        Pierre Yves MORDRET <pierre-yves.mordret@st.com>,
        Amelie DELAUNAY <amelie.delaunay@st.com>
Subject: Re: [PATCH v1 0/4] PM: Add dev_wakeup_path() helper
Thread-Topic: [PATCH v1 0/4] PM: Add dev_wakeup_path() helper
Thread-Index: AQHWtA81NgzAk5p2+kaegvQD/FNWL6nN3wMAgAEy+IA=
Date:   Thu, 19 Nov 2020 07:27:27 +0000
Message-ID: <3e9ca95b-2053-41c7-6ec8-9f97bbbb6e32@st.com>
References: <20201106073358.8379-1-patrice.chotard@st.com>
 <CAJZ5v0hUnQQ2_DjjdXSE107iPNTt+dqcUxWzAH=fE4Qp7Gnnig@mail.gmail.com>
In-Reply-To: <CAJZ5v0hUnQQ2_DjjdXSE107iPNTt+dqcUxWzAH=fE4Qp7Gnnig@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.44]
Content-Type: text/plain; charset="utf-8"
Content-ID: <291651A206E1274195CCD02DE0C2A317@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-19_05:2020-11-17,2020-11-19 signatures=0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgUmFmYWVsDQoNCk9uIDExLzE4LzIwIDI6MDggUE0sIFJhZmFlbCBKLiBXeXNvY2tpIHdyb3Rl
Og0KPiBPbiBGcmksIE5vdiA2LCAyMDIwIGF0IDg6MzQgQU0gPHBhdHJpY2UuY2hvdGFyZEBzdC5j
b20+IHdyb3RlOg0KPj4gRnJvbTogUGF0cmljZSBDaG90YXJkIDxwYXRyaWNlLmNob3RhcmRAc3Qu
Y29tPg0KPj4NCj4+IEFkZCBkZXZfd2FrZXVwX3BhdGgoKSBoZWxwZXIgdG8gYXZvaWQgdG8gc3By
ZWFkDQo+PiBkZXYtPnBvd2VyLndha2V1cF9wYXRoIHRlc3QgaW4gZHJpdmVycy4NCj4gT0sNCj4N
Cj4+IENjOiBhbWVsaWUuZGVsYXVuYXlAc3QuY29tLA0KPj4gICAgIGVyd2FuX2xlcmF5QHN0LmNv
bSwNCj4+ICAgICBmYWJyaWNlLmdhc25pZXJAc3QuY29tLA0KPj4gICAgIGFsZXhhbmRyZS50b3Jn
dWVAc3QuY29tLA0KPj4gICAgIGFsYWluLnZvbG1hdEBzdC5jb20sDQo+PiAgICAgcGllcnJlLXl2
ZXMubW9yZHJldEBzdC5jb20NCj4+DQo+PiAqKiogQkxVUkIgSEVSRSAqKioNCj4gSG1tPw0KPg0K
Pj4gUGF0cmljZSBDaG90YXJkICg0KToNCj4+ICAgUE0gLyB3YWtldXA6IEFkZCBkZXZfd2FrZXVw
X3BhdGgoKSBoZWxwZXINCj4+ICAgUE06IGRvbWFpbnM6IE1ha2UgdXNhZ2Ugb2YgZGV2aWNlX3dh
a2V1cF9wYXRoKCkgaGVscGVyDQo+PiAgIFBNOiBjb3JlOiBNYWtlIHVzYWdlIG9mIGRldmljZV93
YWtldXBfcGF0aCgpIGhlbHBlcg0KPj4gICBpMmM6IHN0bTMyZjc6IE1ha2UgdXNhZ2Ugb2YgZGV2
X3dha2V1cF9wYXRoKCkgaGVscGVyDQo+IFBsZWFzZSBmb2xkIHRoZSBwYXRjaGVzIGludG8gb25l
IGFuZCBhZGQgdGhlIFItYnkgZnJvbSBVbGYgdG8gaXQuDQoNCk9LLCB0aGUgdjIgaXMgb24gdGhl
IHdheS4NCg0KVGhhbmtzDQoNClBhdHJpY2UNCg0KPg0KPiBUaGFua3Mh
