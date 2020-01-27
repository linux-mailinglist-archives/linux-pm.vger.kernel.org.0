Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B99DD14A4BE
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jan 2020 14:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgA0NSP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jan 2020 08:18:15 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:46942 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725907AbgA0NSP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jan 2020 08:18:15 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00RDCPuc010457;
        Mon, 27 Jan 2020 14:17:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=c+hFzAdIS/ZnJvsdSSsIUfuzk1mAp/1PFd89s5h3LUs=;
 b=OZuaUBMTUdGI7IbENiN6ix0An7f95cN1yX6VPzF/5H71q6NR0vgNn46CX122o8lu1dIT
 o9EL3Zu+aZ1LHcyrOP2e+sPqr91A+z24To2NrXL8PYTVpED06cmJZ10h1HwTc4JKTQs8
 4u2uBkZEbjxdFK/w/aq1njYx0RdBgnWNFUSPULviAQq3PO+kAZkAAuLKD18VIXTS32Aw
 Vwf2VBWDPCTW1DxT1VYpar2grQ9O4kP3vJ2IUrGQnTx7HM5z9ts7hTAiESfZQPD0mmD3
 yruC1jf+w8wbzvGob+gD88iUd22IIhsOH/J1cSyimK1roXxMsWErv98AVTxXhF9dqOcl UA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xrdek8vsm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jan 2020 14:17:55 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 24EBE10002A;
        Mon, 27 Jan 2020 14:17:51 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0F4192AD9F5;
        Mon, 27 Jan 2020 14:17:51 +0100 (CET)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 27 Jan
 2020 14:17:50 +0100
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Mon, 27 Jan 2020 14:17:50 +0100
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
Subject: Re: [PATCH_V3 0/6] thermal: stm32: driver improvements
Thread-Topic: [PATCH_V3 0/6] thermal: stm32: driver improvements
Thread-Index: AQHVx575+Q0vFMQB1USceV4qSXzFT6f+iFaA
Date:   Mon, 27 Jan 2020 13:17:50 +0000
Message-ID: <a400d4e2-4abb-aad8-73f0-57c9300ca351@st.com>
References: <20200110101605.24984-1-p.paillet@st.com>
In-Reply-To: <20200110101605.24984-1-p.paillet@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.47]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F142B21D02B60D49A091256E0AAA3F53@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-27_02:2020-01-24,2020-01-27 signatures=0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

VGhlIGdvYWwgb2YgdGhpcyBwYXRjaHNldCBpcyB0byBpbXByb3ZlIGFuZCBzaW1wbGlmeSB0aGUg
c3RtMzIgdGhlcm1hbA0KPiBkcml2ZXI6DQo+ICogbGV0IHRoZSBmcmFtZXdvcmsgaGFuZGxlIHRo
ZSB0cmlwIHBvaW50czogaXQgdmVyeSBpcyBoYXJkIHRvIHNwbGl0IHRoaXMgcGF0Y2gNCj4gaW50
byBzbWFsbGVyIG9uZXMgYW5kIGtlZXAgZWFjaCBpbmRpdmlkdWFsIHBhdGNoIGZ1bmN0aW9uYWwu
DQo+ICogZml4IGludGVycnVwdCBtYW5hZ2VtZW50IHRvIGF2b2lkIHJlY2VpdmluZyBodW5kcmVk
cyBvZg0KPiBpbnRlcnJ1cHRzIHdoZW4gdGhlIHRlbXBlcmF0dXJlIGlzIGNsb3NlIHRvIHRoZSBs
b3cgdGhyZXNob2xkLg0KPiAqIGltcHJvdmUgdGVtcGVyYXR1cmUgcmVhZGluZyByZXNvbHV0aW9u
DQo+ICogdGhlIGRpcnZlciBpcyBiYWNrYXdyZCBjb21wYXRpYmxlLg0KPg0KPiBQYXNjYWwgUGFp
bGxldCAoNik6DQo+IGNoYW5nZXMgaW4gdjI6DQo+ICogU3BsaXQgImhhbmRsZSBtdWx0aXBsZSB0
cmlwIHBvaW50cyIgcGF0Y2ggdG8gbWFrZSBvbmVzOg0KPiAqICAgcmV3b3JrIHNlbnNvciBtb2Rl
IG1hbmFnZW1lbnQNCj4gKiAgIGRpc2FibGUgaW50ZXJydXB0cyBhdCBwcm9iZQ0KPiAqICJyZW1v
dmUgaGFyZHdhcmUgaXJxIGhhbmRsZXIiIGlzIHNxdWFzaGVkIGluICJoYW5kbGUgbXVsdGlwbGUg
dHJpcCBwb2ludHMiDQpraW5kIHJlbWluZGVyIGZvciByZXZpZXcNCj4gICAgdGhlcm1hbDogc3Rt
MzI6IGZpeCBpY2lmciByZWdpc3RlciBuYW1lDQo+ICAgIHRoZXJtYWw6IHN0bTMyOiByZXdvcmsg
c2Vuc29yIG1vZGUgbWFuYWdlbWVudA0KPiAgICB0aGVybWFsOiBzdG0zMjogZGlzYWJsZSBpbnRl
cnJ1cHRzIGF0IHByb2JlDQo+ICAgIHRoZXJtYWw6IHN0bTMyOiBoYW5kbGUgbXVsdGlwbGUgdHJp
cCBwb2ludHMNCj4gICAgdGhlcm1hbDogc3RtMzI6IGltcHJvdmUgdGVtcGVyYXR1cmUgY29tcHV0
aW5nDQo+ICAgIHRoZXJtYWw6IHN0bTMyOiBmaXggbG93IHRocmVzaG9sZCBpbnRlcnJ1cHQgZmxv
b2QNCj4NCj4gICBkcml2ZXJzL3RoZXJtYWwvc3Qvc3RtX3RoZXJtYWwuYyB8IDM4OCArKysrKysr
KysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEyMCBpbnNlcnRp
b25zKCspLCAyNjggZGVsZXRpb25zKC0pDQo+DQo=
