Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3954534DEB8
	for <lists+linux-pm@lfdr.de>; Tue, 30 Mar 2021 04:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbhC3Cvd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Mar 2021 22:51:33 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:41025 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229762AbhC3Cv2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Mar 2021 22:51:28 -0400
X-UUID: 0c137f90c13f436787ea52a2694f622c-20210330
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=h3tgTgAhTPVHl6C7nGiDPVcZVqzWaFEKu+Mj0evMIr4=;
        b=LI7e3Glzwpjv1aUej04C4LHb49W1O+HP+7QCPeYeNiwA4nkulkaLUAjZKbYHa+kRIPbMAy1thXHAoqgRTqNU235yUxSLgW3TvMS5vlolspzNH3jHdEQ31HWUtfeX6ONqGonQuGvD1wl5dqC1buA0UCC7mYVMLyMBDi1Ta0S9fpk=;
X-UUID: 0c137f90c13f436787ea52a2694f622c-20210330
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <michael.kao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1474408315; Tue, 30 Mar 2021 10:51:25 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 30 Mar 2021 10:51:24 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 30 Mar 2021 10:51:24 +0800
Message-ID: <1617072684.13941.2.camel@mtksdccf07>
Subject: Re: [PATCH v2] thermal: cpufreq_cooling: fix slab OOB issue
From:   Michael Kao <michael.kao@mediatek.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     Zhang Rui <rui.zhang@intel.com>, <fan.chen@mediatek.com>,
        <linux-pm@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>,
        brian-sy yang <brian-sy.yang@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        "Eduardo Valentin" <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-mediatek@lists.infradead.org>, <hsinyi@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 30 Mar 2021 10:51:24 +0800
In-Reply-To: <20201229050831.19493-1-michael.kao@mediatek.com>
References: <20201229050831.19493-1-michael.kao@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

RGVhciBEYW5pZWwsDQoNCktpbmRseSBwaW5nLg0KQ2FuIHRoaXMgcGF0Y2ggYmUgbWVyZ2VkPyBP
ciBhbnkgY29tbWVudD8NCg0KQlIsDQpNaWNoYWVsDQoNCk9uIFR1ZSwgMjAyMC0xMi0yOSBhdCAx
MzowOCArMDgwMCwgTWljaGFlbCBLYW8gd3JvdGU6DQo+IEZyb206IGJyaWFuLXN5IHlhbmcgPGJy
aWFuLXN5LnlhbmdAbWVkaWF0ZWsuY29tPg0KPiANCj4gU2xhYiBPT0IgaXNzdWUgaXMgc2Nhbm5l
ZCBieSBLQVNBTiBpbiBjcHVfcG93ZXJfdG9fZnJlcSgpLg0KPiBJZiBwb3dlciBpcyBsaW1pdGVk
IGJlbG93IHRoZSBwb3dlciBvZiBPUFAwIGluIEVNIHRhYmxlLA0KPiBpdCB3aWxsIGNhdXNlIHNs
YWIgb3V0LW9mLWJvdW5kIGlzc3VlIHdpdGggbmVnYXRpdmUgYXJyYXkNCj4gaW5kZXguDQo+IA0K
PiBSZXR1cm4gdGhlIGxvd2VzdCBmcmVxdWVuY3kgaWYgbGltaXRlZCBwb3dlciBjYW5ub3QgZm91
bmQNCj4gYSBzdWl0YWJsZSBPUFAgaW4gRU0gdGFibGUgdG8gZml4IHRoaXMgaXNzdWUuDQo+IA0K
PiBCYWNrdHJhY2U6DQo+IFs8ZmZmZmZmZDAyZDJhMzdmMD5dIGRpZSsweDEwNC8weDVhYw0KPiBb
PGZmZmZmZmQwMmQyYTU2MzA+XSBidWdfaGFuZGxlcisweDY0LzB4ZDANCj4gWzxmZmZmZmZkMDJk
Mjg4Y2U0Pl0gYnJrX2hhbmRsZXIrMHgxNjAvMHgyNTgNCj4gWzxmZmZmZmZkMDJkMjgxZTVjPl0g
ZG9fZGVidWdfZXhjZXB0aW9uKzB4MjQ4LzB4M2YwDQo+IFs8ZmZmZmZmZDAyZDI4NDQ4OD5dIGVs
MV9kYmcrMHgxNC8weGJjDQo+IFs8ZmZmZmZmZDAyZDc1ZDFkND5dIF9fa2FzYW5fcmVwb3J0KzB4
MWRjLzB4MWUwDQo+IFs8ZmZmZmZmZDAyZDc1YzJlMD5dIGthc2FuX3JlcG9ydCsweDEwLzB4MjAN
Cj4gWzxmZmZmZmZkMDJkNzVkZWY4Pl0gX19hc2FuX3JlcG9ydF9sb2FkOF9ub2Fib3J0KzB4MTgv
MHgyOA0KPiBbPGZmZmZmZmQwMmU2ZmNlNWM+XSBjcHVmcmVxX3Bvd2VyMnN0YXRlKzB4MTgwLzB4
NDNjDQo+IFs8ZmZmZmZmZDAyZTZlYWQ4MD5dIHBvd2VyX2FjdG9yX3NldF9wb3dlcisweDExNC8w
eDFkNA0KPiBbPGZmZmZmZmQwMmU2ZmFjMjQ+XSBhbGxvY2F0ZV9wb3dlcisweGFlYy8weGRlMA0K
PiBbPGZmZmZmZmQwMmU2ZjlmODA+XSBwb3dlcl9hbGxvY2F0b3JfdGhyb3R0bGUrMHgzZWMvMHg1
YTQNCj4gWzxmZmZmZmZkMDJlNmVhODg4Pl0gaGFuZGxlX3RoZXJtYWxfdHJpcCsweDE2MC8weDI5
NA0KPiBbPGZmZmZmZmQwMmU2ZWRkMDg+XSB0aGVybWFsX3pvbmVfZGV2aWNlX2NoZWNrKzB4ZTQv
MHgxNTQNCj4gWzxmZmZmZmZkMDJkMzUxY2I0Pl0gcHJvY2Vzc19vbmVfd29yaysweDVlNC8weGUy
OA0KPiBbPGZmZmZmZmQwMmQzNTJmNDQ+XSB3b3JrZXJfdGhyZWFkKzB4YTRjLzB4ZmFjDQo+IFs8
ZmZmZmZmZDAyZDM2MDEyND5dIGt0aHJlYWQrMHgzM2MvMHgzNTgNCj4gWzxmZmZmZmZkMDJkMjg5
OTQwPl0gcmV0X2Zyb21fZm9yaysweGMvMHgxOA0KPiANCj4gRml4ZXM6IDM3MWEzYmM3OWMxMWIg
KCJ0aGVybWFsL2RyaXZlcnMvY3B1ZnJlcV9jb29saW5nOiBGaXggd3JvbmcgZnJlcXVlbmN5IGNv
bnZlcnRlZCBmcm9tIHBvd2VyIikNCj4gU2lnbmVkLW9mZi1ieTogYnJpYW4tc3kgeWFuZyA8YnJp
YW4tc3kueWFuZ0BtZWRpYXRlay5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgS2FvIDxt
aWNoYWVsLmthb0BtZWRpYXRlay5jb20+DQo+IFJldmlld2VkLWJ5OiBMdWthc3ogTHViYSA8bHVr
YXN6Lmx1YmFAYXJtLmNvbT4NCj4gLS0tDQo+IA0KPiBDaGFuZ2VzIGZyb20gdjE6DQo+IC0gYWRk
IGZpeGVzIHRhZw0KPiAtIGFkZCByZXZpZXdlZC1ieQ0KPiANCj4gIGRyaXZlcnMvdGhlcm1hbC9j
cHVmcmVxX2Nvb2xpbmcuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdGhlcm1hbC9jcHVm
cmVxX2Nvb2xpbmcuYyBiL2RyaXZlcnMvdGhlcm1hbC9jcHVmcmVxX2Nvb2xpbmcuYw0KPiBpbmRl
eCBjYzI5NTlmMjJmMDEuLmZiMzNiMzQ4MGE4ZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy90aGVy
bWFsL2NwdWZyZXFfY29vbGluZy5jDQo+ICsrKyBiL2RyaXZlcnMvdGhlcm1hbC9jcHVmcmVxX2Nv
b2xpbmcuYw0KPiBAQCAtMTIzLDcgKzEyMyw3IEBAIHN0YXRpYyB1MzIgY3B1X3Bvd2VyX3RvX2Zy
ZXEoc3RydWN0IGNwdWZyZXFfY29vbGluZ19kZXZpY2UgKmNwdWZyZXFfY2RldiwNCj4gIHsNCj4g
IAlpbnQgaTsNCj4gIA0KPiAtCWZvciAoaSA9IGNwdWZyZXFfY2Rldi0+bWF4X2xldmVsOyBpID49
IDA7IGktLSkgew0KPiArCWZvciAoaSA9IGNwdWZyZXFfY2Rldi0+bWF4X2xldmVsOyBpID4gMDsg
aS0tKSB7DQo+ICAJCWlmIChwb3dlciA+PSBjcHVmcmVxX2NkZXYtPmVtLT50YWJsZVtpXS5wb3dl
cikNCj4gIAkJCWJyZWFrOw0KPiAgCX0NCg0K

