Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41A53416A12
	for <lists+linux-pm@lfdr.de>; Fri, 24 Sep 2021 04:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbhIXCj1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Sep 2021 22:39:27 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:56326 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S243935AbhIXCj1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Sep 2021 22:39:27 -0400
X-UUID: fb5e923c706d406bb4df0276101afea6-20210924
X-UUID: fb5e923c706d406bb4df0276101afea6-20210924
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1778508314; Fri, 24 Sep 2021 10:37:50 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 24 Sep 2021 10:37:49 +0800
Received: from localhost.localdomain (10.17.3.154) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 24 Sep 2021 10:37:48 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
CC:     Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH RESEND v3 2/2] usb: xhci-mtk: enable wake-up interrupt after runtime_suspend called
Date:   Fri, 24 Sep 2021 10:37:46 +0800
Message-ID: <20210924023746.22423-2-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210924023746.22423-1-chunfeng.yun@mediatek.com>
References: <20210924023746.22423-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
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
index c53f6f276d5c..6c1d898986f2 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -607,6 +607,7 @@ static int xhci_mtk_probe(struct platform_device *pdev)
 			dev_err(dev, "set wakeup irq %d failed\n", wakeup_irq);
 			goto dealloc_usb3_hcd;
 		}
+		dev_pm_wake_irq_set_late_enabled_status(dev);
 		dev_info(dev, "wakeup irq %d\n", wakeup_irq);
 	}
 
-- 
2.18.0

