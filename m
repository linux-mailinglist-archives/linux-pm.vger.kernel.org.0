Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7D68ECDB7
	for <lists+linux-pm@lfdr.de>; Sat,  2 Nov 2019 08:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbfKBH5Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 2 Nov 2019 03:57:25 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5251 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726044AbfKBH5Z (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 2 Nov 2019 03:57:25 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 09E422574E8412012078;
        Sat,  2 Nov 2019 15:57:22 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Sat, 2 Nov 2019
 15:57:12 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <edubezval@gmail.com>, <j-keerthy@ti.com>, <rui.zhang@intel.com>,
        <daniel.lezcano@linaro.org>, <amit.kucheria@verdurent.com>
CC:     <linux-pm@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] thermal: ti-soc-thermal: Remove dev_err() on platform_get_irq() failure
Date:   Sat, 2 Nov 2019 15:56:54 +0800
Message-ID: <20191102075654.36700-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

platform_get_irq() will call dev_err() itself on failure,
so there is no need for the driver to also do this.
This is detected by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/thermal/ti-soc-thermal/ti-bandgap.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
index 2fa78f7..89c3ba7 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -787,10 +787,9 @@ static int ti_bandgap_talert_init(struct ti_bandgap *bgp,
 	int ret;
 
 	bgp->irq = platform_get_irq(pdev, 0);
-	if (bgp->irq < 0) {
-		dev_err(&pdev->dev, "get_irq failed\n");
+	if (bgp->irq < 0)
 		return bgp->irq;
-	}
+
 	ret = request_threaded_irq(bgp->irq, NULL,
 				   ti_bandgap_talert_irq_handler,
 				   IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
-- 
2.7.4


