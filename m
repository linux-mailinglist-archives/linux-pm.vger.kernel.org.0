Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C01192D5C76
	for <lists+linux-pm@lfdr.de>; Thu, 10 Dec 2020 14:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389700AbgLJNzH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Dec 2020 08:55:07 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:9864 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389696AbgLJNzB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Dec 2020 08:55:01 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CsFkW2LVzz7C9w;
        Thu, 10 Dec 2020 21:53:39 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Thu, 10 Dec 2020 21:54:04 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <nsaenzjulienne@suse.de>, <linux-pm@vger.kernel.org>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] thermal: broadcom: simplify the return expression of bcm2711_thermal_probe()
Date:   Thu, 10 Dec 2020 21:54:32 +0800
Message-ID: <20201210135432.1249-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Simplify the return expression.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/thermal/broadcom/bcm2711_thermal.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/thermal/broadcom/bcm2711_thermal.c b/drivers/thermal/broadcom/bcm2711_thermal.c
index 67c2a737bc9d..1ec57d9ecf53 100644
--- a/drivers/thermal/broadcom/bcm2711_thermal.c
+++ b/drivers/thermal/broadcom/bcm2711_thermal.c
@@ -102,11 +102,7 @@ static int bcm2711_thermal_probe(struct platform_device *pdev)
 	priv->thermal = thermal;
 
 	thermal->tzp->no_hwmon = false;
-	ret = thermal_add_hwmon_sysfs(thermal);
-	if (ret)
-		return ret;
-
-	return 0;
+	return thermal_add_hwmon_sysfs(thermal);
 }
 
 static struct platform_driver bcm2711_thermal_driver = {
-- 
2.22.0

