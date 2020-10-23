Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A09296924
	for <lists+linux-pm@lfdr.de>; Fri, 23 Oct 2020 06:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370404AbgJWEdt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Oct 2020 00:33:49 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:33656 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S370397AbgJWEdt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Oct 2020 00:33:49 -0400
X-UUID: c36bf2c4ea2b47e18a74213bd0824673-20201023
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=5YtfPoYxtZBRSyiC2VkB5O7C49n+8i4TSqxu4hkRUGI=;
        b=F8PBq/T06NrljqSOBDL8tVx3WwPGZAyqftd/B0gkcCTyelBzeQJxKg0cMMktF5lXImbV5T7jq+umyY0zdkNa2+sRNLMQ372yXQNjw+tyH119OSdGfPtBjlJY89s2YLmG9JiDV0pbALOI2qNcnhNBJBXZTfNxxhiu2lFHM896u2c=;
X-UUID: c36bf2c4ea2b47e18a74213bd0824673-20201023
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <claude.yen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 646458932; Fri, 23 Oct 2020 12:28:29 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 23 Oct 2020 12:28:20 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 23 Oct 2020 12:28:20 +0800
Message-ID: <1603427300.7573.6.camel@mtkswgap22>
Subject: Re: [PATCH] PM / s2idle: Export s2idle_set_ops
From:   claude yen <claude.yen@mediatek.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <wsd_upstream@mediatek.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 23 Oct 2020 12:28:20 +0800
In-Reply-To: <20201022070154.hqvksoj4nss3er2e@bogus>
References: <20201022061748.13730-1-claude.yen@mediatek.com>
         <20201022061748.13730-2-claude.yen@mediatek.com>
         <20201022070154.hqvksoj4nss3er2e@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 029A931861513CD54378A52D951671A7F8FC70A8B55464CB36672ECEF508EE072000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gVGh1LCAyMDIwLTEwLTIyIGF0IDA4OjAyICswMTAwLCBTdWRlZXAgSG9sbGEgd3JvdGU6DQo+
IE9uIFRodSwgT2N0IDIyLCAyMDIwIGF0IDAyOjE3OjQ4UE0gKzA4MDAsIENsYXVkZSBZZW4gd3Jv
dGU6DQo+ID4gQXMgc3VzcGVuZF9zZXRfb3BzIGlzIGV4cG9ydGVkIGluIGNvbW1pdCBhNWU0ZmQ4
NzgzYTINCj4gPiAoIlBNIC8gU3VzcGVuZDogRXhwb3J0IHN1c3BlbmRfc2V0X29wcywgc3VzcGVu
ZF92YWxpZF9vbmx5X21lbSIpLA0KPiA+IGV4cG9ydGluZyBzMmlkbGVfc2V0X29wcyB0byBtYWtl
IGtlcm5lbCBtb2R1bGUgc2V0dXAgczJpZGxlIG9wcyB0b28uDQo+ID4gDQo+ID4gSW4gdGhpcyB3
YXksIGtlcm5lbCBtb2R1bGUgY2FuIGhvb2sgcGxhdGZvcm0gc3VzcGVuZA0KPiA+IGZ1bmN0aW9u
cyByZWdhcmRsZXNzIG9mIFN1c3BlbmQtdG8tUmFtKFMyUikgb3INCj4gPiBTdXNwZW5kLXRvLUlk
bGUoUzJJKQ0KPiA+DQo+IA0KPiBJZiB0aGlzIGlzIGZvciBhcm02NCBwbGF0Zm9ybSwgdGhlbiBO
QUNLLiBZb3UgbXVzdCB1c2UgUFNDSSBhbmQgaXQgd2lsbA0KPiBzZXQgdGhlIG9wcyBhbmQgaXQg
Y2FuJ3QgYmUgbW9kdWxlLg0KPiANCg0KUFNDSSB1c2VzIHN1c3BlbmRfc2V0X29wcyBpbnN0ZWFk
LiBBbmQgc3VzcGVuZF9zZXRfb3BzIGhhcyBiZWVuDQpleHBvcnRlZCB5ZWFycyBhZ28uDQoNClN1
c3BlbmQtdG9fSWRsZShTMkkpIGlzIGFub3RoZXIgc3VzcGVuZCBtZXRob2Qgc3VwcG9ydGVkIGJ5
IGxpbnV4DQprZXJuZWwuIFRoZSBjb3JyZXNwb25kaW5nIHMyaWRsZV9vcHMgY2FuIGJlIGhvb2tl
ZCBieSBzMmlkbGVfc2V0X29wcw0KYnkgdW5kZXJseWluZyBwbGF0Zm9ybXMuICBGb3IgZXhhbXBs
ZSwgUzJJIGlzIG5vdyBpbnRyb2R1Y2VkIGludG8NCk1lZGlhdGVrIFNvQyBwbGF0Zm9ybXMuIEJl
c2lkZXMsIHBvd2VyIG1hbmFnZW1lbnQgZHJpdmVyIGlzIGJ1aWx0IGFzDQprZXJuZWwgbW9kdWxl
Lg0KDQpNb2JpbGUgcGxhdGZvcm1zIGFyZSBub3cgY2FsbCBmb3Iga2VybmVsIGRyaXZlcnMgdG8g
YmUga2VybmVsIG1vZHVsZXMuDQpUaGlzIGNvdWxkIGhlbHAgZHJpdmVycyBlYXNpZXIgdG8gbWln
cmF0ZSB0byBuZXdlciBsaW51eCBrZXJuZWwuDQpSZWY6IGh0dHBzOi8vbGludXhwbHVtYmVyc2Nv
bmYub3JnL2V2ZW50LzcvY29udHJpYnV0aW9ucy83OTAvDQoNClJlZ2FyZHMsDQpDbGF1ZGUgDQo=

