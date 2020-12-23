Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8415D2E1929
	for <lists+linux-pm@lfdr.de>; Wed, 23 Dec 2020 08:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgLWG6A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Dec 2020 01:58:00 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:9911 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbgLWG57 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Dec 2020 01:57:59 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4D13sG5Kghz7K0W;
        Wed, 23 Dec 2020 14:56:34 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Wed, 23 Dec 2020 14:57:13 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <support.opensource@diasemi.com>, <rui.zhang@intel.com>,
        <daniel.lezcano@linaro.org>, <amitk@kernel.org>
CC:     <linux-pm@vger.kernel.org>
Subject: [PATCH] thermal: da9062/61: fix platform_get_irq.cocci warnings
Date:   Wed, 23 Dec 2020 14:57:18 +0800
Message-ID: <1608706638-56290-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Remove dev_err() messages after platform_get_irq*() failures.
drivers/thermal/da9062-thermal.c:252:2-9: line 252 is redundant
because platform_get_irq() already prints an error.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/thermal/da9062-thermal.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/da9062-thermal.c b/drivers/thermal/da9062-thermal.c
index 4d74994..3009e6a 100644
--- a/drivers/thermal/da9062-thermal.c
+++ b/drivers/thermal/da9062-thermal.c
@@ -248,10 +248,9 @@ static int da9062_thermal_probe(struct platform_device *pdev)
 		thermal->zone->passive_delay);
 
 	ret = platform_get_irq_byname(pdev, "THERMAL");
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to get platform IRQ.\n");
+	if (ret < 0)
 		goto err_zone;
-	}
+
 	thermal->irq = ret;
 
 	ret = request_threaded_irq(thermal->irq, NULL,
-- 
2.7.4

