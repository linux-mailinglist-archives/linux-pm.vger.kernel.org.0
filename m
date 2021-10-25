Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34DB6438FDA
	for <lists+linux-pm@lfdr.de>; Mon, 25 Oct 2021 09:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbhJYHEZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Oct 2021 03:04:25 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:48850 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230231AbhJYHEY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Oct 2021 03:04:24 -0400
X-UUID: 7a345da0e5be4e14b6e6660e9f782497-20211025
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ACVNGV7J6dLNBN3Vd7NWrXomOBB135OPyOu8ZuL8xJQ=;
        b=BZ1vEmB/b0UdV6rsVCp29DIDuIIWjwWJql/vfXYx+MT0LvmnIhF5tAAsjTeheLrE5mthtLOSyCvmJNH2WZCnxktt5fe83IakxVNL5fj1wjW3d5LVXCNbzuM0eiDvt4SyPbH2QMnTqCbhdeXNQHJr6lYcotVIyZZmQ27egnMHoSE=;
X-UUID: 7a345da0e5be4e14b6e6660e9f782497-20211025
Received: from mtkcas11.mediatek.inc [(172.27.5.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1774734754; Mon, 25 Oct 2021 15:01:56 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 25 Oct 2021 15:01:58 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 25 Oct 2021 15:01:57 +0800
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
Subject: [PATCH v4 2/3] usb: xhci-mtk: enable wake-up interrupt after runtime_suspend called
Date:   Mon, 25 Oct 2021 15:01:54 +0800
Message-ID: <20211025070155.2995-2-chunfeng.yun@mediatek.com>
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

VXNlIG5ldyBmdW5jdGlvbiBkZXZfcG1fc2V0X2RlZGljYXRlZF93YWtlX2lycV9yZXZlcnNlKCkg
dG8gcmVxdWVzdA0KZGVkaWNhdGVkIHdha2UtdXAgaW50ZXJydXB0LCBkdWUgdG8gd2Ugd2FudCB0
byBlbmFibGUgdGhlIHdha2UgSVJRDQphZnRlciBydW5uaW5nIC0+cnVudGltZV9zdXNwZW5kKCku
DQoNClNpZ25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNv
bT4NCi0tLQ0KdjQ6IHVzZSB0aGUgbmV3IGFwaSBkZXZfcG1fc2V0X2RlZGljYXRlZF93YWtlX2ly
cV9yZXZlcnNlKCkNCg0KdjM6IG5ldyBwYXRjaA0KLS0tDQogZHJpdmVycy91c2IvaG9zdC94aGNp
LW10ay5jIHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlv
bigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay5jIGIvZHJpdmVy
cy91c2IvaG9zdC94aGNpLW10ay5jDQppbmRleCBjNTNmNmYyNzZkNWMuLjU4YTBlYWU0ZjQxYiAx
MDA2NDQNCi0tLSBhL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1tdGsuYw0KKysrIGIvZHJpdmVycy91
c2IvaG9zdC94aGNpLW10ay5jDQpAQCAtNjAyLDcgKzYwMiw3IEBAIHN0YXRpYyBpbnQgeGhjaV9t
dGtfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJCWdvdG8gZGVhbGxvY191
c2IyX2hjZDsNCiANCiAJaWYgKHdha2V1cF9pcnEgPiAwKSB7DQotCQlyZXQgPSBkZXZfcG1fc2V0
X2RlZGljYXRlZF93YWtlX2lycShkZXYsIHdha2V1cF9pcnEpOw0KKwkJcmV0ID0gZGV2X3BtX3Nl
dF9kZWRpY2F0ZWRfd2FrZV9pcnFfcmV2ZXJzZShkZXYsIHdha2V1cF9pcnEpOw0KIAkJaWYgKHJl
dCkgew0KIAkJCWRldl9lcnIoZGV2LCAic2V0IHdha2V1cCBpcnEgJWQgZmFpbGVkXG4iLCB3YWtl
dXBfaXJxKTsNCiAJCQlnb3RvIGRlYWxsb2NfdXNiM19oY2Q7DQotLSANCjIuMTguMA0K

