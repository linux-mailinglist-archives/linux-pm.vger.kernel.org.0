Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2597C3D3483
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jul 2021 08:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbhGWFg7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Jul 2021 01:36:59 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:43412 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229788AbhGWFg7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Jul 2021 01:36:59 -0400
X-UUID: 102d7e6f98aa4d88ba2953fd7f08bc46-20210723
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=0+OFaZT+V5fX2+7/ZvRj5IJQIdPcmVaOWGckKOtfowo=;
        b=WQq95mbqI6E8VGOW4nyRQAH1TwXtzVk0qYlWNnw/HQwoIQxOCjOyYRZERnf7c0tnjPJzdzIlNEvNjdHNwpA5ThTij8wNZWAd25Ueld11gBPbFdBbIUY+yYlkPzDaz4HTVQxnHMOfiRllK6PMtiuNMRxiN8/LcvdxAJBeLIRNBMI=;
X-UUID: 102d7e6f98aa4d88ba2953fd7f08bc46-20210723
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <ben.tseng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 59563751; Fri, 23 Jul 2021 14:17:29 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 23 Jul 2021 14:17:25 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 23 Jul 2021 14:17:25 +0800
Message-ID: <1f92b245537d6390b7b2bde62ce8b99a3df9d445.camel@mediatek.com>
Subject: Re: [PATCH v5 2/3] thermal: mediatek: Add LVTS drivers for SoC
 theraml zones
From:   Ben Tseng <ben.tseng@mediatek.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Fan Chen <fan.chen@mediatek.com>,
        Zhang Rui <rui.zhang@intel.com>, <linux-pm@vger.kernel.org>,
        <srv_heupstream@mediatek.com>
CC:     Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>, <hsinyi@chromium.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Michael Kao <michael.kao@mediatek.com>,
        Yu-Chia Chang <ethan.chang@mediatek.com>
Date:   Fri, 23 Jul 2021 14:17:25 +0800
In-Reply-To: <06b1804c-4675-2997-8c5c-bcdffbcfc4a1@linaro.org>
References: <20210617114707.10618-1-ben.tseng@mediatek.com>
         <20210617114707.10618-3-ben.tseng@mediatek.com>
         <06b1804c-4675-2997-8c5c-bcdffbcfc4a1@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gTW9uLCAyMDIxLTA2LTIxIGF0IDEzOjI2ICswMjAwLCBEYW5pZWwgTGV6Y2FubyB3cm90ZToN
Cj4gT24gMTcvMDYvMjAyMSAxMzo0NywgQmVuIFRzZW5nIHdyb3RlOg0KPiA+IEZyb206IE1pY2hh
ZWwgS2FvIDxtaWNoYWVsLmthb0BtZWRpYXRlay5jb20+DQo+ID4gDQo+ID4gQWRkIGEgTFZUUyAo
TG93IHZvbHRhZ2UgdGhlcm1hbCBzZW5zb3IpIGRyaXZlciB0byByZXBvcnQganVuY3Rpb24NCj4g
PiB0ZW1wZXJhdHVyZXMgaW4gTWVkaWF0ZWsgU29DIGFuZCByZWdpc3RlciB0aGUgbWF4aW11bSB0
ZW1wZXJhdHVyZQ0KPiA+IG9mIHNlbnNvcnMgYW5kIGVhY2ggc2Vuc29yIGFzIGEgdGhlcm1hbCB6
b25lLg0KPiANCj4gSSB0aGluayB3ZSBhbHJlYWR5IHRhbGtlZCBhYm91dCB0aGF0LiBXZSBkb24n
dCB3YW50IGEgdGhlcm1hbCBzZW5zb3INCj4gZHJpdmVyIHRvIGFnZ3JlZ2F0ZSB0aGUgdGVtcGVy
YXR1cmVzIGJ1dCBjcmVhdGUgc29tZSBraW5kb2YgdmlydHVhbA0KPiBzZW5zb3Igd2l0aCBhIHBy
b3BlcnR5IChtaW4sIG1heCwgYXZnLCAuLi4pIHdoaWNoIGlzIHVzYWJsZSBieQ0KPiBhbnlvbmUu
DQo+IA0KPiBbIC4uLiBdDQo+IA0KPiANCj4gDQoNCkRlYXIgRGFuaWVsLA0KDQpTb3JyeSBmb3Ig
dGhlIGxhdGUgcmVwbHkuDQoNCkFmdGVyIHN1cnZleSAsSSdtIG5vdCBzdXJlIHdoZXRoZXIgdGhl
IHBhdGNoWzFdIGlzIHRoZSBhcmNoaXRlY3R1cmUgb2YNCnZpcnR1YWwgdGhlcm1hbCBzZW5zb3Ig
d2hpY2ggeW91IGNvbW1lbnRlZC4NCg0KT3IsIGlzIHRoZXJlIGFueSBleGlzdGluZyBmcmFtZXdv
cmsgb24gbWFpbmxpbmUgYWxyZWFkeSBzdXBwb3J0IHZpcnR1YWwNCnNlbnNvcj8NCkNvdWxkIHlv
dSBoZWxwIHRvIHByb3ZpZGUgcmVmZXJlbmNlIHRvIHVzPw0KVGhhbmsgeW91IHNvIG11Y2guDQoN
ClsxXSANCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1wbS9wYXRj
aC8xNjA2NDY2MjA0LTMxNjU3LTEtZ2l0LXNlbmQtZW1haWwtZ2FvLnl1bnhpYW82QGdtYWlsLmNv
bS8NCg0KQlJzDQpCZW4NCg0KDQoNCg==

