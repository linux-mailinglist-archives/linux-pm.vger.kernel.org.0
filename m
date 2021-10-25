Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB0D1438FDE
	for <lists+linux-pm@lfdr.de>; Mon, 25 Oct 2021 09:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbhJYHEa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Oct 2021 03:04:30 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:8406 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230231AbhJYHEa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Oct 2021 03:04:30 -0400
X-UUID: 2613ae1d897a4b80af2e0c3bf6b977b6-20211025
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=JYEHkPbny/fgEcN4WO1FiAROIntx5S4sOKdNHuBlf0c=;
        b=g5Li1EZ8sI4Xe7wVlQOyA8tnx8MDsWeLRmek4ddTl3oZRCcnLOQE/8OyiwPlF10MBayfyMPdZr+/HshAip06aiK7fFQiPjAKOSFaYIg1MX+WIOQUvIesenSJa1ET53QJ1hbHZflKuSeASJh+vWk2Qoubuu9GFEy+je/tuitXpwQ=;
X-UUID: 2613ae1d897a4b80af2e0c3bf6b977b6-20211025
Received: from mtkmbs10n1.mediatek.inc [(172.27.6.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 58710718; Mon, 25 Oct 2021 14:41:58 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 25 Oct 2021 15:01:59 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 25 Oct 2021 15:01:58 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
CC:     Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v4 3/3] usb: mtu3: enable wake-up interrupt after runtime_suspend called
Date:   Mon, 25 Oct 2021 15:01:55 +0800
Message-ID: <20211025070155.2995-3-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211025070155.2995-1-chunfeng.yun@mediatek.com>
References: <20211025070155.2995-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

VXNlIHRoZSBuZXcgQVBJIGRldl9wbV9zZXRfZGVkaWNhdGVkX3dha2VfaXJxX3JldmVyc2UoKSB0
byByZXF1ZXN0DQpkZWRpY2F0ZWQgd2FrZS11cCBpbnRlcnJ1cHQsIGR1ZSB0byB3ZSB3YW50IHRv
IGVuYWJsZSB0aGUgd2FrZSBJUlENCmFmdGVyIHJ1bm5pbmcgLT5ydW50aW1lX3N1c3BlbmQoKS4N
Cg0KU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29t
Pg0KLS0tDQp2NDogbmV3IHBhdGNoDQotLS0NCiBkcml2ZXJzL3VzYi9tdHUzL210dTNfcGxhdC5j
IHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0K
DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvbXR1My9tdHUzX3BsYXQuYyBiL2RyaXZlcnMvdXNi
L210dTMvbXR1M19wbGF0LmMNCmluZGV4IGYxMzUzMTAyMmY0YS4uNDMwOWVkOTM5MTc4IDEwMDY0
NA0KLS0tIGEvZHJpdmVycy91c2IvbXR1My9tdHUzX3BsYXQuYw0KKysrIGIvZHJpdmVycy91c2Iv
bXR1My9tdHUzX3BsYXQuYw0KQEAgLTMzNyw3ICszMzcsNyBAQCBzdGF0aWMgaW50IG10dTNfcHJv
YmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJCWdvdG8gY29tbV9pbml0X2VycjsN
CiANCiAJaWYgKHNzdXNiLT53YWtldXBfaXJxID4gMCkgew0KLQkJcmV0ID0gZGV2X3BtX3NldF9k
ZWRpY2F0ZWRfd2FrZV9pcnEoZGV2LCBzc3VzYi0+d2FrZXVwX2lycSk7DQorCQlyZXQgPSBkZXZf
cG1fc2V0X2RlZGljYXRlZF93YWtlX2lycV9yZXZlcnNlKGRldiwgc3N1c2ItPndha2V1cF9pcnEp
Ow0KIAkJaWYgKHJldCkgew0KIAkJCWRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIHNldCB3YWtldXAg
aXJxICVkXG4iLCBzc3VzYi0+d2FrZXVwX2lycSk7DQogCQkJZ290byBjb21tX2V4aXQ7DQotLSAN
CjIuMTguMA0K

