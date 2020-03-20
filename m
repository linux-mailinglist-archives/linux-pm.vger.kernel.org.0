Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFEA18CE00
	for <lists+linux-pm@lfdr.de>; Fri, 20 Mar 2020 13:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgCTMss (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Mar 2020 08:48:48 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:27768 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726925AbgCTMss (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Mar 2020 08:48:48 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02KCd871016964;
        Fri, 20 Mar 2020 13:48:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=2C+GCWBhrcZX26tCjQgEyQLMF2n9xcx1LptRAb/JNO4=;
 b=xi/LH+k7xfxxpNKWNaWn0rDhI3NDdqrwa3yNyj+x+H5fCQdkK7OJchDcdP9CUnlg9K5d
 mvyxOAR+eyYGGqm+lpsWt/o7oGQSnOYE9PK66M7V42acngG/Ptlykd4LkS4WkPHbPIZh
 ShssC7Mqa9BiBllVMcx+VWsHaoPHMJOH6eb30MMsa4hI0XUJ1npogQqeWUOqi0UQWn0x
 SN7nV1wbQYNalhj5uw9EHtMszLQhnlFozkmgct6FqkpcvVCAZ+dD58kXmyic+kmGgVtl
 sP8bRHEgO6K75kobhyO32t8iS0IZzoBlENJY77kJwXNXsPoyr801qbbKNN8cIfzk30RH ug== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2yu6xdr4k6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Mar 2020 13:48:43 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1148C10002A;
        Fri, 20 Mar 2020 13:48:39 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 04EF82ADC3B;
        Fri, 20 Mar 2020 13:48:39 +0100 (CET)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 20 Mar
 2020 13:48:38 +0100
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1473.003; Fri, 20 Mar 2020 13:48:38 +0100
From:   Patrice CHOTARD <patrice.chotard@st.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Erwan LE RAY <erwan.leray@st.com>,
        "Alexandre TORGUE" <alexandre.torgue@st.com>,
        Fabrice GASNIER <fabrice.gasnier@st.com>
Subject: Re: PM / wakeup: Add dev_wakeup_path() helper
Thread-Topic: PM / wakeup: Add dev_wakeup_path() helper
Thread-Index: AQHV/qtJLW56mUXPdUSe6gOaf+QjAKhRTq2AgAAO94A=
Date:   Fri, 20 Mar 2020 12:48:38 +0000
Message-ID: <8d434829-ba4d-e2be-9889-3f6eb88c46b8@st.com>
References: <20200320113233.10219-1-patrice.chotard@st.com>
 <CAPDyKFrWnK-TCMDExYHqpyo+5Fz9tKa0xWeauuQfTT1bQjepqQ@mail.gmail.com>
In-Reply-To: <CAPDyKFrWnK-TCMDExYHqpyo+5Fz9tKa0xWeauuQfTT1bQjepqQ@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.47]
Content-Type: text/plain; charset="utf-8"
Content-ID: <6427126BE4D11F4DA9351D2EC9B8EA5C@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-20_03:2020-03-20,2020-03-20 signatures=0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgVWxmDQoNCk9uIDMvMjAvMjAgMTI6NTUgUE0sIFVsZiBIYW5zc29uIHdyb3RlOg0KPiBPbiBG
cmksIDIwIE1hciAyMDIwIGF0IDEyOjMyLCA8cGF0cmljZS5jaG90YXJkQHN0LmNvbT4gd3JvdGU6
DQo+PiBGcm9tOiBQYXRyaWNlIENob3RhcmQgPHBhdHJpY2UuY2hvdGFyZEBzdC5jb20+DQo+Pg0K
Pj4gQWRkIGRldl93YWtldXBfcGF0aCgpIGhlbHBlciB0byBhdm9pZCB0byBzcHJlYWQNCj4+IGRl
di0+cG93ZXIud2FrZXVwX3BhdGggdGVzdCBpbiBkcml2ZXJzLg0KPiBJIGFtIG9rYXkgYWRkaW5n
IGEgaGVscGVyLCBidXQgd291bGQgYXBwcmVjaWF0ZSBpZiB5b3Ugc2VuZCBhIHNlcmllcw0KPiB0
byBjb252ZXJ0IHRob3NlIHVzaW5nIHRoZSBmbGFnIGN1cnJlbnRseS4NCg0KT2ssIHdlIHdhbnRl
ZCB0byBiZSBzdXJlIHRoYXQgdGhpcyBoZWxwZXIgd2lsbCBiZSBhY2NlcHRlZCBiZWZvcmUgdXBk
YXRpbmcgb3VyIGRyaXZlciB3aXRoIGl0Lg0KDQpBIG5ldyBzZXJpZXMgd2lsbCBiZSBzZW50IGlu
Y2x1ZGluZyB0aGlzIHBhdGNoIGFuZCBkcml2ZXIgdXNpbmcgaXQuDQoNCj4NCj4+IEluIGNhc2Ug
Q09ORklHX1BNX1NMRUVQIGlzIG5vdCBzZXQsIHdha2V1cF9wYXRoIGlzIG5vdCBkZWZpbmVkLA0K
Pj4gZGV2X3dha2V1cF9wYXRoKCkgaXMgcmV0dXJuaW5nIGZhbHNlLg0KPj4NCj4+IFNpZ25lZC1v
ZmYtYnk6IFBhdHJpY2UgQ2hvdGFyZCA8cGF0cmljZS5jaG90YXJkQHN0LmNvbT4NCj4+IC0tLQ0K
Pj4NCj4+IEN1cnJlbnRseSwgaW4gbWFpbmxpbmUga2VybmVsLCBubyBkcml2ZXJzIGFyZSB0ZXN0
aW5nIGRldi0+cG93ZXIud2FrZXVwX3BhdGgNCj4+IGZvciBQTSBwdXJwb3NlLiBBIHN0bTMyIHNl
cmlhbCBkcml2ZXIgcGF0Y2ggd2lsbCBiZSBzdWJtaXR0ZWQgc29vbiBhbmQgd2lsbA0KPj4gbWFr
ZSB1c2FnZSBvZiB0aGlzIGhlbHBlci4NCj4+DQo+PiAgaW5jbHVkZS9saW51eC9wbV93YWtldXAu
aCB8IDEwICsrKysrKysrKysNCj4+ICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQ0K
Pj4NCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3BtX3dha2V1cC5oIGIvaW5jbHVkZS9s
aW51eC9wbV93YWtldXAuaA0KPj4gaW5kZXggYWEzZGE2NjExNTMzLi5kMGJkMTNjMTkyNTMgMTAw
NjQ0DQo+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L3BtX3dha2V1cC5oDQo+PiArKysgYi9pbmNsdWRl
L2xpbnV4L3BtX3dha2V1cC5oDQo+PiBAQCAtODQsNiArODQsMTEgQEAgc3RhdGljIGlubGluZSBi
b29sIGRldmljZV9tYXlfd2FrZXVwKHN0cnVjdCBkZXZpY2UgKmRldikNCj4+ICAgICAgICAgcmV0
dXJuIGRldi0+cG93ZXIuY2FuX3dha2V1cCAmJiAhIWRldi0+cG93ZXIud2FrZXVwOw0KPj4gIH0N
Cj4+DQo+PiArc3RhdGljIGlubGluZSBib29sIGRldmljZV93YWtldXBfcGF0aChzdHJ1Y3QgZGV2
aWNlICpkZXYpDQo+PiArew0KPj4gKyAgICAgICByZXR1cm4gISFkZXYtPnBvd2VyLndha2V1cF9w
YXRoOw0KPiBXaHkgdXNpbmcgIiEhIiBoZXJlPw0KDQpyaWdodCwgbm90IG5lZWRlZCzCoCB3YWtl
dXBfcGF0aCBpcyBhbHJlYWR5IGEgYm9vbGVhbi4uLi4NCg0KVGhhbmtzDQoNClBhdHJpY2UNCg0K
Pg0KPj4gK30NCj4+ICsNCj4+ICBzdGF0aWMgaW5saW5lIHZvaWQgZGV2aWNlX3NldF93YWtldXBf
cGF0aChzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+PiAgew0KPj4gICAgICAgICBkZXYtPnBvd2VyLndh
a2V1cF9wYXRoID0gdHJ1ZTsNCj4+IEBAIC0xNzQsNiArMTc5LDExIEBAIHN0YXRpYyBpbmxpbmUg
Ym9vbCBkZXZpY2VfbWF5X3dha2V1cChzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+PiAgICAgICAgIHJl
dHVybiBkZXYtPnBvd2VyLmNhbl93YWtldXAgJiYgZGV2LT5wb3dlci5zaG91bGRfd2FrZXVwOw0K
Pj4gIH0NCj4+DQo+PiArc3RhdGljIGlubGluZSBib29sIGRldmljZV93YWtldXBfcGF0aChzdHJ1
Y3QgZGV2aWNlICpkZXYpDQo+PiArew0KPj4gKyAgICAgICByZXR1cm4gZmFsc2U7DQo+PiArfQ0K
Pj4gKw0KPj4gIHN0YXRpYyBpbmxpbmUgdm9pZCBkZXZpY2Vfc2V0X3dha2V1cF9wYXRoKHN0cnVj
dCBkZXZpY2UgKmRldikge30NCj4+DQo+PiAgc3RhdGljIGlubGluZSB2b2lkIF9fcG1fc3RheV9h
d2FrZShzdHJ1Y3Qgd2FrZXVwX3NvdXJjZSAqd3MpIHt9DQo+PiAtLQ0KPj4gMi4xNy4xDQo+Pg0K
PiBLaW5kIHJlZ2FyZHMNCj4gVWZmZQ==
