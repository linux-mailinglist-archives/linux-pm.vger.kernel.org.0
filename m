Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2533E8895
	for <lists+linux-pm@lfdr.de>; Wed, 11 Aug 2021 05:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232885AbhHKDF3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Aug 2021 23:05:29 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:33918 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232169AbhHKDF3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Aug 2021 23:05:29 -0400
X-UUID: 5fdea8a68a2c4537a2dfac1576dfd4d7-20210811
X-UUID: 5fdea8a68a2c4537a2dfac1576dfd4d7-20210811
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 833135956; Wed, 11 Aug 2021 11:05:04 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 11 Aug 2021 11:05:02 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 11 Aug 2021 11:05:01 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Ikjoon Jang <ikjn@chromium.org>
Subject: [PATCH v3 2/2] usb: xhci-mtk: enable wake-up interrupt after runtime_suspend called
Date:   Wed, 11 Aug 2021 11:04:29 +0800
Message-ID: <1628651069-22162-2-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1628651069-22162-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1628651069-22162-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use new function dev_pm_wake_irq_set_late_enabled_status() to enable
dedicated wake-up interrupt after xhci_mtk_runtime_suspend() is called.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v3: new patch
---
 drivers/usb/host/xhci-mtk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index 7ff0cd707ba1..6fb6f6853129 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -611,6 +611,7 @@ static int xhci_mtk_probe(struct platform_device *pdev)
 			dev_err(dev, "set wakeup irq %d failed\n", wakeup_irq);
 			goto dealloc_usb3_hcd;
 		}
+		dev_pm_wake_irq_set_late_enabled_status(dev);
 		dev_info(dev, "wakeup irq %d\n", wakeup_irq);
 	}
 
-- 
2.25.1

