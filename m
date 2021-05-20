Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D832A389EF8
	for <lists+linux-pm@lfdr.de>; Thu, 20 May 2021 09:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbhETHgY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 May 2021 03:36:24 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3600 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhETHgX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 May 2021 03:36:23 -0400
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fm1dG1DZmzQq5H;
        Thu, 20 May 2021 15:31:30 +0800 (CST)
Received: from dggeme759-chm.china.huawei.com (10.3.19.105) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 15:35:01 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggeme759-chm.china.huawei.com (10.3.19.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 20 May 2021 15:35:00 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <rjw@rjwysocki.net>, <len.brown@intel.com>, <pavel@ucw.cz>,
        <gregkh@linuxfoundation.org>
CC:     <linux-pm@vger.kernel.org>, Tian Tao <tiantao6@hisilicon.com>
Subject: [PATCH] PM / wakeirq: move to use request_irq by IRQF_NO_AUTOEN flag
Date:   Thu, 20 May 2021 15:34:58 +0800
Message-ID: <1621496098-50271-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme759-chm.china.huawei.com (10.3.19.105)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

request_irq() after setting IRQ_NOAUTOEN as below
irq_set_status_flags(irq, IRQ_NOAUTOEN);
request_irq(dev, irq...);
can be replaced by request_irq() with IRQF_NO_AUTOEN flag.

this change is just to simplify the code, no actual functional changes.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/base/power/wakeirq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
index 8e02108..3bad326 100644
--- a/drivers/base/power/wakeirq.c
+++ b/drivers/base/power/wakeirq.c
@@ -182,7 +182,6 @@ int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq)
 
 	wirq->dev = dev;
 	wirq->irq = irq;
-	irq_set_status_flags(irq, IRQ_NOAUTOEN);
 
 	/* Prevent deferred spurious wakeirqs with disable_irq_nosync() */
 	irq_set_status_flags(irq, IRQ_DISABLE_UNLAZY);
@@ -192,7 +191,8 @@ int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq)
 	 * so we use a threaded irq.
 	 */
 	err = request_threaded_irq(irq, NULL, handle_threaded_wake_irq,
-				   IRQF_ONESHOT, wirq->name, wirq);
+				   IRQF_ONESHOT | IRQF_NO_AUTOEN,
+				   wirq->name, wirq);
 	if (err)
 		goto err_free_name;
 
-- 
2.7.4

