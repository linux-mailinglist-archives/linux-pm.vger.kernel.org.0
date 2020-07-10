Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7720321B2C5
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 11:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgGJJyw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jul 2020 05:54:52 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:12443 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726962AbgGJJyX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jul 2020 05:54:23 -0400
X-UUID: 854289983ac2406f8d1ffcb0d27085af-20200710
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Fvop1Xi8e3CCer4hzPo+dzNj1YEbgfsUqzHs+K07MU8=;
        b=bkVT7c8kI2Ki1B9auzjEfqdWDuXsHIaEEtnCoi9kYIJ2iE1Qw3zyXsrNmW3iAcsLa5L5dAdQHqD3MJBlS4cU3U3eEtbZaHaBlFdx69Z2iI6M7kZE9W0qXX4+pgJJjeuB3lmf9sM6tHx8sPp08Z5jWiv0+hmgAnVwNj6sk+5JKGo=;
X-UUID: 854289983ac2406f8d1ffcb0d27085af-20200710
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <henry.yen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1191701866; Fri, 10 Jul 2020 17:54:19 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 10 Jul 2020 17:54:17 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 10 Jul 2020 17:54:17 +0800
Message-ID: <1594374857.4941.2.camel@mtksdccf07>
Subject: [RESEND] Mediatek thermal driver update
From:   mtk17045 <henry.yen@mediatek.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Zhang Rui <rui.zhang@intel.com>
CC:     <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Steven Liu" <steven.liu@mediatek.com>,
        Michael Kao <michael.kao@mediatek.com>
Date:   Fri, 10 Jul 2020 17:54:17 +0800
In-Reply-To: <1588238074-19338-1-git-send-email-henry.yen@mediatek.com>
References: <1588238074-19338-1-git-send-email-henry.yen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: FDD4EEAC6AF5878663B9D9568B8EF0AF65527131D094D04143DF25D416B81CBA2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gVGh1LCAyMDIwLTA0LTMwIGF0IDE3OjE0ICswODAwLCBIZW5yeSBZZW4gd3JvdGU6DQo+IE1l
ZGlhdGVrIG93bnMgdHdvIHRoZXJtYWwgc3lzdGVtcywgd2hpY2ggYXJlIGFsbW9zdCB0aGUgc2Ft
ZSBleGNlcHQgZm9yDQo+IHRoZSB3YXkgb2YgcmVhZGluZyBjYWxpYnJhdGlvbiBkYXRhIGFuZCBj
b252ZXJ0aW5nIHRlbXBlcmF0dXJlLg0KPiBNVDgxNzMsIE1UODE4MywgTVQyNzAxIGFuZCBNVDI3
MTIgYmVsb25ncyB0byB2ZXJzaW9uIDEgdGhlcm1hbCBzeXN0ZW0sDQo+IGFuZCBNVDc2MjIgYmVs
b25ncyB0byB2ZXJzaW9uIDIuIFRoZSBjdXJyZW50IGNvZGUgaGFzIGFscmVhZHkgc3VwcG9ydGVk
DQo+IHZlcnNpb24gMSBzeXN0ZW0uIFRoZW4gdGhpcyBwYXRjaHNldCB3aWxsIGFkZCB0aGUgc3Vw
cG9ydCBmb3IgYW5vdGhlcg0KPiBwbGF0Zm9ybSAoZS5nLiwgTVQ3NjIyIFNvQykuDQo+IA0KPiBD
aGFuZ2Vsb2c6DQo+IA0KPiB2MjoNCj4gKiByZW9yZ2FuaXplIHRoZSBvcmRlciBvZiB0aGUgdHdv
IHBhdGNoZXMNCj4gKiByZW1vdmUgdW5uZWNlc3NhcnkgLmV4dHJhY3QgYW5kIC5jb252ZXJ0IGNh
bGxiYWNrcw0KPiAqIGFkZCBmaXhlcyB0YWcNCj4gDQo+IHYxOg0KPiAqIGluaXRpYWwgcG9zdA0K
PiANCj4gSGVucnkgWWVuICgyKToNCj4gICB0aGVybWFsOiBtZWRpYXRlazogcHJlcGFyZSB0byBh
ZGQgc3VwcG9ydCBmb3Igb3RoZXIgcGxhdGZvcm1zDQo+ICAgdGhlcm1hbDogbWVkaWF0ZWs6IGFk
ZCB0c2Vuc29yIHN1cHBvcnQgZm9yIFYyIHRoZXJtYWwgc3lzdGVtDQo+IA0KPiAgZHJpdmVycy90
aGVybWFsL210a190aGVybWFsLmMgfCAyMzQgKysrKysrKysrKysrKysrKysrKysrKysrKystLS0t
LS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDE4MSBpbnNlcnRpb25zKCspLCA1MyBkZWxldGlvbnMo
LSkNCj4gDQpKdXN0IGdlbnRseSBwaW5nLiAgICANCk1hbnkgdGhhbmtzLg0K

