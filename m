Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 789411E3FAA
	for <lists+linux-pm@lfdr.de>; Wed, 27 May 2020 13:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387987AbgE0LRe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 May 2020 07:17:34 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:54360 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387397AbgE0LRe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 May 2020 07:17:34 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04RBBXim014001;
        Wed, 27 May 2020 13:17:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=rr7ePK+lAdwpvBXNXavKI3R8C4Kk3NnESgyEf8criWw=;
 b=rtJegCKLGvavFARM5Tsya5iX1vUKjOfVvlDqgiXKgSH2EczQYLVHm73X+qT0TgJGffee
 zGjSVlLyKwR54Vwd4f2Ywmivh32IoRcyNUka5YTHXrMpWwsrEyi2EtZvglA7OVQasdkK
 pvGUlrfBcUvBVP05+f/WyJCJfCB2lvq3JBnDBKEdWiIC6TtP6desLTJj+O3Gim2cVnK3
 +gSCRncK1uiqJ5p61WCxSc4LOYdi9FjwowMyexgkB3IVgVjz2rKMMsYR4stRiqNMAtVe
 fzUC+Fqf2LqZQ0mP5JfyaIl3mF0SloAovp4AOaty3AKt0Gn2dPtVCYs9MfX0VAAIu/Pm yw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 316tqh51y3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 May 2020 13:17:11 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 86F1010002A;
        Wed, 27 May 2020 13:17:10 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag5node1.st.com [10.75.127.13])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 64AEC2A4D83;
        Wed, 27 May 2020 13:17:10 +0200 (CEST)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG5NODE1.st.com
 (10.75.127.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 May
 2020 13:17:09 +0200
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Wed, 27 May 2020 13:17:09 +0200
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
CC:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        Hugues FRUCHET <hugues.fruchet@st.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC RESEND 0/3] Introduce cpufreq minimum load QoS
Thread-Topic: [RFC RESEND 0/3] Introduce cpufreq minimum load QoS
Thread-Index: AQHWM3CeA6bTrCFpTUymlrJxXTw8j6i7lUyAgAATBIA=
Date:   Wed, 27 May 2020 11:17:09 +0000
Message-ID: <ab4340c0-bda3-e752-9073-e162e6325bb1@st.com>
References: <20200526151619.8779-1-benjamin.gaignard@st.com>
 <jhjk10xu1tq.mognet@arm.com>
In-Reply-To: <jhjk10xu1tq.mognet@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <39E329C3251EC747879CFC71C308FA00@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-27_03:2020-05-27,2020-05-27 signatures=0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQoNCk9uIDUvMjcvMjAgMTI6MDkgUE0sIFZhbGVudGluIFNjaG5laWRlciB3cm90ZToNCj4gSGkg
QmVuamFtaW4sDQo+DQo+IE9uIDI2LzA1LzIwIDE2OjE2LCBCZW5qYW1pbiBHYWlnbmFyZCB3cm90
ZToNCj4+IEEgZmlyc3Qgcm91bmQgWzFdIG9mIGRpc2N1c3Npb25zIGFuZCBzdWdnZXN0aW9ucyBo
YXZlIGFscmVhZHkgYmUgZG9uZSBvbg0KPj4gdGhpcyBzZXJpZXMgYnV0IHdpdGhvdXQgZm91bmQg
YSBzb2x1dGlvbiB0byB0aGUgcHJvYmxlbS4gSSByZXNlbmQgaXQgdG8NCj4+IHByb2dyZXNzIG9u
IHRoaXMgdG9waWMuDQo+Pg0KPiBBcG9sb2dpZXMgZm9yIHNsZWVwaW5nIG9uIHRoYXQgcHJldmlv
dXMgdGhyZWFkLg0KPg0KPiBTbyB3aGF0IGhhZCBiZWVuIHN1Z2dlc3RlZCBvdmVyIHRoZXJlIHdh
cyB0byB1c2UgdWNsYW1wIHRvIGJvb3N0IHRoZQ0KPiBmcmVxdWVuY3kgb2YgdGhlIGhhbmRsaW5n
IHRocmVhZDsgaG93ZXZlciBpZiB5b3UgdXNlIHRocmVhZGVkIElSUXMgeW91DQo+IGdldCBSVCB0
aHJlYWRzLCB3aGljaCBhbHJlYWR5IGdldCB0aGUgbWF4IGZyZXF1ZW5jeSBieSBkZWZhdWx0IChh
dCBsZWFzdA0KPiB3aXRoIHNjaGVkdXRpbCkuDQo+DQo+IERvZXMgdGhhdCBub3Qgd29yayBmb3Ig
eW91LCBhbmQgaWYgc28sIHdoeT8NClRoYXQgZG9lc24ndCB3b3JrIGJlY2F1c2UgYWxtb3N0IGV2
ZXJ5dGhpbmcgaXMgZG9uZSBieSB0aGUgaGFyZHdhcmUgYmxvY2tzDQp3aXRob3V0IGNoYXJnZSB0
aGUgQ1BVIHNvIHRoZSB0aHJlYWQgaXNuJ3QgcnVubmluZy4gSSBoYXZlIGRvbmUgdGhlIA0KdGVz
dHMgd2l0aCBzY2hlZHV0aWwNCmFuZCBvbmRlbWFuZCBzY2hlZHVsZXIgKHdoaWNoIGlzIHRoZSBv
bmUgSSdtIHRhcmdldGluZykuIEkgaGF2ZSBubyANCmlzc3VlcyB3aGVuIHVzaW5nDQpwZXJmb3Jt
YW5jZSBzY2hlZHVsZXIgYmVjYXVzZSBpdCBhbHdheXMga2VlcCB0aGUgaGlnaGVzdCBmcmVxdWVu
Y2llcy4NCg0KDQo+DQo+PiBXaGVuIHN0YXJ0IHN0cmVhbWluZyBmcm9tIHRoZSBzZW5zb3IgdGhl
IENQVSBsb2FkIGNvdWxkIHJlbWFpbiB2ZXJ5IGxvdw0KPj4gYmVjYXVzZSBhbG1vc3QgYWxsIHRo
ZSBjYXB0dXJlIHBpcGVsaW5lIGlzIGRvbmUgaW4gaGFyZHdhcmUgKGkuZS4gd2l0aG91dA0KPj4g
dXNpbmcgdGhlIENQVSkgYW5kIGxldCBiZWxpZXZlIHRvIGNwdWZyZXEgZ292ZXJub3IgdGhhdCBp
dCBjb3VsZCB1c2UgbG93ZXINCj4+IGZyZXF1ZW5jaWVzLiBJZiB0aGUgZ292ZXJub3IgZGVjaWRl
cyB0byB1c2UgYSB0b28gbG93IGZyZXF1ZW5jeSB0aGF0DQo+PiBiZWNvbWVzIGEgcHJvYmxlbSB3
aGVuIHdlIG5lZWQgdG8gYWNrbm93bGVkZ2UgdGhlIGludGVycnVwdCBkdXJpbmcgdGhlDQo+PiBi
bGFua2luZyB0aW1lLg0KPj4gVGhlIGRlbGF5IHRvIGFjayB0aGUgaW50ZXJydXB0IGFuZCBwZXJm
b3JtIGFsbCB0aGUgb3RoZXIgYWN0aW9ucyBiZWZvcmUNCj4+IHRoZSBuZXh0IGZyYW1lIGlzIHZl
cnkgc2hvcnQgYW5kIGRvZXNuJ3QgYWxsb3cgdG8gdGhlIGNwdWZyZXEgZ292ZXJub3IgdG8NCj4+
IHByb3ZpZGUgdGhlIHJlcXVpcmVkIGJ1cnN0IG9mIHBvd2VyLiBUaGF0IGxlZCB0byBkcm9wIHRo
ZSBoYWxmIG9mIHRoZSBmcmFtZXMuDQo+Pg0KPj4gVG8gYXZvaWQgdGhpcyBwcm9ibGVtLCBEQ01J
IGRyaXZlciBpbmZvcm1zIHRoZSBjcHVmcmVxIGdvdmVybm9ycyBieSBhZGRpbmcNCj4+IGEgY3B1
ZnJlcSBtaW5pbXVtIGxvYWQgUW9TIHJlc3F1ZXN0Lg0KPj4NCj4+IEJlbmphbWluDQo+Pg0KPj4g
WzFdIGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDIwLzQvMjQvMzYwDQo+Pg0KPj4gQmVuamFtaW4g
R2FpZ25hcmQgKDMpOg0KPj4gICAgUE06IFFvUzogSW50cm9kdWNlIGNwdWZyZXEgbWluaW11bSBs
b2FkIFFvUw0KPj4gICAgY3B1ZnJlcTogZ292ZXJub3I6IFVzZSBtaW5pbXVtIGxvYWQgUW9TDQo+
PiAgICBtZWRpYTogc3RtMzItZGNtaTogSW5mb3JtIGNwdWZyZXEgZ292ZXJub3JzIGFib3V0IGNw
dSBsb2FkIG5lZWRzDQo+Pg0KPj4gICBkcml2ZXJzL2NwdWZyZXEvY3B1ZnJlcV9nb3Zlcm5vci5j
ICAgICAgICB8ICAgNSArDQo+PiAgIGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0vc3RtMzIvc3RtMzIt
ZGNtaS5jIHwgICA4ICsrDQo+PiAgIGluY2x1ZGUvbGludXgvcG1fcW9zLmggICAgICAgICAgICAg
ICAgICAgIHwgIDEyICsrDQo+PiAgIGtlcm5lbC9wb3dlci9xb3MuYyAgICAgICAgICAgICAgICAg
ICAgICAgIHwgMjEzICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gICA0IGZpbGVz
IGNoYW5nZWQsIDIzOCBpbnNlcnRpb25zKCspDQo=
