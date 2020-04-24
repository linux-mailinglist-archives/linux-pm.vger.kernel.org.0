Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 785991B6EC1
	for <lists+linux-pm@lfdr.de>; Fri, 24 Apr 2020 09:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgDXHQL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Apr 2020 03:16:11 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:60342 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725898AbgDXHQL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Apr 2020 03:16:11 -0400
X-UUID: 7cd8ab1132dd40b5a838baf9c9488a43-20200424
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=e4Gfsp6Fj3yVSLCW8Oewrus2aSGsU6oP2lyI8Cpz4WE=;
        b=EoqGL+kuEKofpeohP0cMFPeCWmj64VZWeq3EdEBxm0EVGV8kpuYR7IiPz7S55b9t1Y0yNOWozKwkcTOhgCGXT33F1ipIYPxc0+Nsdq67lJ02BBepx780aTmToI/cRP+CUX+8HY1qX6FtNEZeIitGAW1fYV8vUGL+CaueswgsiDA=;
X-UUID: 7cd8ab1132dd40b5a838baf9c9488a43-20200424
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <michael.kao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1070851026; Fri, 24 Apr 2020 15:16:06 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 24 Apr 2020 15:16:05 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 24 Apr 2020 15:16:03 +0800
From:   Michael Kao <michael.kao@mediatek.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <hsinyi@chromium.org>, <linux-pm@vger.kernel.org>,
        <srv_heupstream@mediatek.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Michael Kao <michael.kao@mediatek.com>
Subject: [PATCH] thermal: power_allocate: add upper and lower limits
Date:   Fri, 24 Apr 2020 15:16:01 +0800
Message-ID: <20200424071601.2636-1-michael.kao@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

VGhlIHVwcGVyIGFuZCBsb3dlciBsaW1pdHMgb2YgdGhlcm1hbCB0aHJvdHRsZSBzdGF0ZSBpbiB0
aGUNCmRldmljZSB0cmVlIGRvIG5vdCBhcHBseSB0byB0aGUgcG93ZXJfYWxsb2NhdGUgZ292ZXJu
b3IuDQpBZGQgdGhlIHVwcGVyIGFuZCBsb3dlciBsaW1pdHMgdG8gdGhlIHBvd2VyX2FsbG9jYXRl
IGdvdmVybm9yLg0KDQpTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIEthbyA8bWljaGFlbC5rYW9AbWVk
aWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy90aGVybWFsL3RoZXJtYWxfY29yZS5jIHwgMiArLQ0K
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0t
Z2l0IGEvZHJpdmVycy90aGVybWFsL3RoZXJtYWxfY29yZS5jIGIvZHJpdmVycy90aGVybWFsL3Ro
ZXJtYWxfY29yZS5jDQppbmRleCA5YTMyMWRjNTQ4YzguLmY2ZmVlZDIyNjViZCAxMDA2NDQNCi0t
LSBhL2RyaXZlcnMvdGhlcm1hbC90aGVybWFsX2NvcmUuYw0KKysrIGIvZHJpdmVycy90aGVybWFs
L3RoZXJtYWxfY29yZS5jDQpAQCAtNTk4LDcgKzU5OCw3IEBAIGludCBwb3dlcl9hY3Rvcl9zZXRf
cG93ZXIoc3RydWN0IHRoZXJtYWxfY29vbGluZ19kZXZpY2UgKmNkZXYsDQogCWlmIChyZXQpDQog
CQlyZXR1cm4gcmV0Ow0KIA0KLQlpbnN0YW5jZS0+dGFyZ2V0ID0gc3RhdGU7DQorCWluc3RhbmNl
LT50YXJnZXQgPSBjbGFtcF92YWwoc3RhdGUsIGluc3RhbmNlLT5sb3dlciwgaW5zdGFuY2UtPnVw
cGVyKTsNCiAJbXV0ZXhfbG9jaygmY2Rldi0+bG9jayk7DQogCWNkZXYtPnVwZGF0ZWQgPSBmYWxz
ZTsNCiAJbXV0ZXhfdW5sb2NrKCZjZGV2LT5sb2NrKTsNCi0tIA0KMi4xOC4wDQo=

