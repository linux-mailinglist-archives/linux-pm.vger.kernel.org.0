Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACB21055DB
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2019 16:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfKUPmy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Nov 2019 10:42:54 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:21930 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726477AbfKUPmy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Nov 2019 10:42:54 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xALFXDfl028623;
        Thu, 21 Nov 2019 16:42:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=6K6SA6MxWiPmIb8PZSMO4AouSBUXf9ocbVHakGWmeeY=;
 b=wacSu0WQFKqxN6GiTws8aia0fMfgsNAN5eqHz7JV4imk1QaIph+NOaHYU6xkQZIrfwdp
 avzBuxD+lEUkTR8FkLqM9DgAtlMPioWpPRSN/IYTMU2Nk7RMU3g0eI2Sli78BNegVQue
 k4JqxH9wBoB/8fyLhBrms5IqiM+UUcY5D5I3IYj3RTmHF9eTWmxAYEPhQ8V4Nqx5QeWo
 d3DlpTh2P4pNWFxK2dTl7zcymtSNNauNA8WImglM5o79GL9EqVTN00RhQeAYsuadwiQp
 AF+NNG3BNnKjHqKC/M5X3EkSwsNRM0R/GYAyHu5Akqv1aeU2fXPTlQACs4KWOfvuYMKW fA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2wa9upcmgs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Nov 2019 16:42:22 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A23D1100034;
        Thu, 21 Nov 2019 16:42:18 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8DC422C8478;
        Thu, 21 Nov 2019 16:42:18 +0100 (CET)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 21 Nov
 2019 16:42:18 +0100
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Thu, 21 Nov 2019 16:42:18 +0100
From:   Pascal PAILLET-LME <p.paillet@st.com>
To:     "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        David HERNANDEZ SANCHEZ <david.hernandezsanchez@st.com>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/5] thermal: stm32: driver improvements
Thread-Topic: [PATCH v2 0/5] thermal: stm32: driver improvements
Thread-Index: AQHVkxQC8UWFfFfMGEiVMCDWvdxpCaeVzZWA
Date:   Thu, 21 Nov 2019 15:42:18 +0000
Message-ID: <6e2eeae4-1f2c-c232-73b0-6d1f16f586d6@st.com>
References: <20191104133020.8820-1-p.paillet@st.com>
In-Reply-To: <20191104133020.8820-1-p.paillet@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.44]
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE2D4140B818E344A5C59FF89DA5E9B8@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-21_03:2019-11-21,2019-11-21 signatures=0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQo+IFRoZSBnb2FsIG9mIHRoaXMgcGF0Y2hzZXQgaXMgdG8gaW1wcm92ZSBhbmQgc2ltcGxpZnkg
dGhlIHN0bTMyIHRoZXJtYWwNCj4gZHJpdmVyOg0KPiAqIHJlbW92ZSBoYXJkd2FyZSBpbnRlcnJ1
cHQgaGFuZGxlciB0aGF0IGlzIHVzZWxlc3MNCj4gKiBsZXQgdGhlIGZyYW1ld3dvcmsgaGFuZGxl
IHRoZSB0cmlwIHBvaW50cw0KPiAqIGZpeCBpbnRlcnJ1cHQgbWFuYWdlbWVudCB0byBhdm9pZCBy
ZWNlaXZpbmcgaHVuZHJlZHMgb2YNCj4gaW50ZXJydXB0cyB3aGVuIHRoZSB0ZW1wZXJhdHVyZSBp
cyBjbG9zZSB0byB0aGUgbG93IHRocmVzaG9sZC4NCj4gKiBpbXByb3ZlIHRlbXBlcmF0dXJlIHJl
YWRpbmcgcmVzb2x1dGlvbg0KZ2VudGxlIHJlbWluZGVyICENCj4gUGFzY2FsIFBhaWxsZXQgKDUp
Og0KPiAgICB0aGVybWFsOiBzdG0zMjogcmVtb3ZlIGhhcmR3YXJlIGlycSBoYW5kbGVyDQo+ICAg
IHRoZXJtYWw6IHN0bTMyOiBmaXggaWNpZnIgcmVnaXN0ZXIgbmFtZQ0KPiAgICB0aGVybWFsOiBz
dG0zMjogaGFuZGxlIG11bHRpcGxlIHRyaXAgcG9pbnRzDQo+ICAgIHRoZXJtYWw6IHN0bTMyOiBp
bXByb3ZlIHRlbXBlcmF0dXJlIHJlc29sdXRpb24NCj4gICAgdGhlcm1hbDogc3RtMzI6IGZpeCBs
b3cgdGhyZXNob2xkIGludGVycnVwdCBmbG9vZA0KPg0KPiAgIGRyaXZlcnMvdGhlcm1hbC9zdC9z
dG1fdGhlcm1hbC5jIHwgMzY3ICsrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gICAx
IGZpbGUgY2hhbmdlZCwgMTExIGluc2VydGlvbnMoKyksIDI1NiBkZWxldGlvbnMoLSkNCj4=
