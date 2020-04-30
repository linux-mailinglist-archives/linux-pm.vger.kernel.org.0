Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00CFB1BF1DB
	for <lists+linux-pm@lfdr.de>; Thu, 30 Apr 2020 09:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgD3HxU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Apr 2020 03:53:20 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:56950 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726358AbgD3HxT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Apr 2020 03:53:19 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03U7qeNP027781;
        Thu, 30 Apr 2020 09:52:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=nNpjPfXaDpTj1MuVss1sEC1CkwsvuNELkclHvxqRjuk=;
 b=mGYUaPC5tsszTgiYAXjw65KfK8FzSp/hg/Kb/mUbkmqRGx6QAnvnXh9gsypDbQ2ODf1M
 bZRxTFR46p8V0vmGwe3FP/W18dQhRxiAKXrdKTpvgiqtKJjgzYKPx620HX0lAiZnOQAh
 qPi+lZslWd68ItaHxvBCmrsobpZWSfzmCuqq2m//xvaRCfgJmxXcvym7NRpzRhVIUzAg
 YrtUNz57ffn6FIi5CD3vzCU+08AiqoKzJzT4yzHzeBGszUIxb0fLaMWu7YKB9vUFVWKK
 b7J7E7rC174mGxqie2A/wE8CPGMjh6uN9nFSYKlxG1dyDlD8X3enjL2SPLGXH0eCbJrS BQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30mhjx2sv8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 09:52:59 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5BDA5100034;
        Thu, 30 Apr 2020 09:52:58 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3BE402AAF69;
        Thu, 30 Apr 2020 09:52:58 +0200 (CEST)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 30 Apr
 2020 09:52:57 +0200
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Thu, 30 Apr 2020 09:52:57 +0200
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     Valentin Schneider <valentin.schneider@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
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
Thread-Index: AQHWGi06wBgeAQBseECYOK/U7Qvw76iQJdAAgAACCYCAAAQ3AIABBseA
Date:   Thu, 30 Apr 2020 07:52:57 +0000
Message-ID: <6b5cde14-58b3-045d-9413-223e66b87bf0@st.com>
References: <20200424114058.21199-1-benjamin.gaignard@st.com>
 <7657495.QyJl4BcWH5@kreacher> <30cdecf9-703a-eb2b-7c2b-f1e21c805add@st.com>
 <70e743cf-b88e-346a-5114-939b8724c83d@arm.com>
In-Reply-To: <70e743cf-b88e-346a-5114-939b8724c83d@arm.com>
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
Content-ID: <AE1AA8893A6E7D438296C06CD62B8BC8@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-30_02:2020-04-30,2020-04-30 signatures=0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQoNCk9uIDQvMjkvMjAgNjoxMiBQTSwgVmFsZW50aW4gU2NobmVpZGVyIHdyb3RlOg0KPiBPbiAy
OS8wNC8yMDIwIDE2OjU3LCBCZW5qYW1pbiBHQUlHTkFSRCB3cm90ZToNCj4+DQo+PiBPbiA0LzI5
LzIwIDU6NTAgUE0sIFJhZmFlbCBKLiBXeXNvY2tpIHdyb3RlOg0KPj4+IE9uIEZyaWRheSwgQXBy
aWwgMjQsIDIwMjAgMTo0MDo1NSBQTSBDRVNUIEJlbmphbWluIEdhaWduYXJkIHdyb3RlOg0KPj4+
PiBXaGVuIHN0YXJ0IHN0cmVhbWluZyBmcm9tIHRoZSBzZW5zb3IgdGhlIENQVSBsb2FkIGNvdWxk
IHJlbWFpbiB2ZXJ5IGxvdw0KPj4+PiBiZWNhdXNlIGFsbW9zdCBhbGwgdGhlIGNhcHR1cmUgcGlw
ZWxpbmUgaXMgZG9uZSBpbiBoYXJkd2FyZSAoaS5lLiB3aXRob3V0DQo+Pj4+IHVzaW5nIHRoZSBD
UFUpIGFuZCBsZXQgYmVsaWV2ZSB0byBjcHVmcmVxIGdvdmVybm9yIHRoYXQgaXQgY291bGQgdXNl
IGxvd2VyDQo+Pj4+IGZyZXF1ZW5jaWVzLiBJZiB0aGUgZ292ZXJub3IgZGVjaWRlcyB0byB1c2Ug
YSB0b28gbG93IGZyZXF1ZW5jeSB0aGF0DQo+Pj4+IGJlY29tZXMgYSBwcm9ibGVtIHdoZW4gd2Ug
bmVlZCB0byBhY2tub3dsZWRnZSB0aGUgaW50ZXJydXB0IGR1cmluZyB0aGUNCj4+Pj4gYmxhbmtp
bmcgdGltZS4NCj4+Pj4gVGhlIGRlbGF5IHRvIGFjayB0aGUgaW50ZXJydXB0IGFuZCBwZXJmb3Jt
IGFsbCB0aGUgb3RoZXIgYWN0aW9ucyBiZWZvcmUNCj4+Pj4gdGhlIG5leHQgZnJhbWUgaXMgdmVy
eSBzaG9ydCBhbmQgZG9lc24ndCBhbGxvdyB0byB0aGUgY3B1ZnJlcSBnb3Zlcm5vciB0bw0KPj4+
PiBwcm92aWRlIHRoZSByZXF1aXJlZCBidXJzdCBvZiBwb3dlci4gVGhhdCBsZWQgdG8gZHJvcCB0
aGUgaGFsZiBvZiB0aGUgZnJhbWVzLg0KPj4+Pg0KPj4+PiBUbyBhdm9pZCB0aGlzIHByb2JsZW0s
IERDTUkgZHJpdmVyIGluZm9ybXMgdGhlIGNwdWZyZXEgZ292ZXJub3JzIGJ5IGFkZGluZw0KPj4+
PiBhIGNwdWZyZXEgbWluaW11bSBsb2FkIFFvUyByZXNxdWVzdC4NCj4+PiBUaGlzIHNlZW1zIHRv
IGJlIGFkZHJlc3NpbmcgYSB1c2UgY2FzZSB0aGF0IGNhbiBiZSBhZGRyZXNzZWQgd2l0aCB0aGUg
aGVscCBvZg0KPj4+IHV0aWxpemF0aW9uIGNsYW1wcyB3aXRoIGxlc3MgcG93ZXIgb3ZlcmhlYWQu
DQo+PiBEbyBtZWFuIGNsYW1waW5nIHRoZSBwb2xpY3kgZnJlcXVlbmNpZXMgPyBJIG1heSBoYXZl
IG1pc3MgdGhlIEFQSSB0byBkbw0KPj4gdGhhdC4uLg0KPiBJSVVDIFJhZmFlbCBpcyByZWZlcnJp
bmcgdG8gdWNsYW1wLCBpLmUuIHNjaGVkdWxlciB1dGlsaXphdGlvbiBjbGFtcGluZywgc2VlOg0K
Pg0KPiAgICBodHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL2xhdGVzdC9hZG1pbi1ndWlk
ZS9jZ3JvdXAtdjIuaHRtbCNjcHUNCj4NCj4gVGhlIGFib3ZlIGRlc2NyaWJlcyB0aGUgY2dyb3Vw
IGludGVyZmFjZSwgbm90ZSB0aGF0IHlvdSBjYW4gYWxzbyBzZXQgY2xhbXBzDQo+IHBlciB0YXNr
ICh2aWEgc2NoZWRfc2V0YXR0cigpKS4NCj4NCj4gT25lIHRoaW5nIHRoYXQgY29tZXMgdG8gbWlu
ZCBob3dldmVyIGlzIHRoYXQgc2NoZWR1dGlsIG9ubHkgInNlZXMiIHRoZSBjbGFtcHMNCj4gb2Yg
cnVubmFibGUgdGFza3MsIGFuZCBmcm9tIHJlYWRpbmcgeW91ciBjaGFuZ2Vsb2cgeW91IG1heSBu
b3QgaGF2ZSBtb21lbnRzDQo+IHdpdGhvdXQgYW55IChpLmUuIGdlYXJzIGFyZSBncmluZGluZyBp
biBIVykuIFlvdSdkIGhhdmUgdG8gdHJ5IGJvb3N0aW5nDQo+IChzZXR0aW5nIGEgaGlnaCB1Y2xh
bXAubWluKSB3aGF0ZXZlciB0YXNrcyB5b3UgaGF2ZSBvbiB0aGUgc29mdHdhcmUgc2lkZSBhbmQN
Cj4gc2VlIGhvdyBpdCBhbGwgYmVoYXZlcy4NClJlbHlpbmcgb24gdXNlcmxhbmQgc2lkZSBtZWFu
cyB0aGF0IHZhcmlvdXMgYXBwbGljYXRpb25zIG5lZWQgdG8gYmUgYXdhcmUNCm9mIHRoaXMgc3Bl
Y2lmaWMgaGFyZHdhcmUgY2FzZSBhbmQgZml4IGl0LiBJIHdhcyBob3BpbmcgdG8gZmluZCBhIA0K
c29sdXRpb24gaW4gc2lkZSB0aGUga2VybmVsDQp0byBub3QgaW1wYWN0IHRoZSBzb2Z0d2FyZSBz
aWRlLg0KDQo+DQo+Pj4gVGhhbmtzIQ0KPj4+DQo+Pj4NCj4+Pg0K
