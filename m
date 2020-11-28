Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 201342C742D
	for <lists+linux-pm@lfdr.de>; Sat, 28 Nov 2020 23:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731661AbgK1Vts (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 28 Nov 2020 16:49:48 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:8470 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730098AbgK1Shz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 28 Nov 2020 13:37:55 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Cjht84KQXzhj0M;
        Sat, 28 Nov 2020 14:49:04 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Sat, 28 Nov 2020
 14:49:18 +0800
From:   Zhang Qilong <zhangqilong3@huawei.com>
To:     <kuba@kernel.org>, <fugang.duan@nxp.com>, <davem@davemloft.net>,
        <rjw@rjwysocki.net>, <geert@linux-m68k.org>
CC:     <netdev@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH v2] PM: runtime: replace pm_runtime_resume_and_get with pm_runtime_resume_and_get_sync
Date:   Sat, 28 Nov 2020 14:52:43 +0800
Message-ID: <20201128065243.2870987-1-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In the pm_runtime_resume_and_get, pm_runtime_resume() is
synchronous. Caller had to look into the implementation
to verify that a change for pm_runtime_resume_and_get [0].
So we use pm_rauntime_resume_and_get_sync to replace it to
avoid making the same mistake while fixing
pm_runtime_get_sync.

[0]https://lore.kernel.org/netdev/20201110092933.3342784-1-zhangqilong3@huawei.com/T/#t
Fixes: dd8088d5a896 ("PM: runtime: Add pm_runtime_resume_and_get to deal with usage counter")
Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
---
Changelog:
v2
- change the fixes tag.
---
 drivers/net/ethernet/freescale/fec_main.c | 10 +++++-----
 include/linux/pm_runtime.h                |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 04f24c66cf36..6bfc46da2943 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1808,7 +1808,7 @@ static int fec_enet_mdio_read(struct mii_bus *bus, int mii_id, int regnum)
 	int ret = 0, frame_start, frame_addr, frame_op;
 	bool is_c45 = !!(regnum & MII_ADDR_C45);
 
-	ret = pm_runtime_resume_and_get(dev);
+	ret = pm_runtime_resume_and_get_sync(dev);
 	if (ret < 0)
 		return ret;
 
@@ -1867,7 +1867,7 @@ static int fec_enet_mdio_write(struct mii_bus *bus, int mii_id, int regnum,
 	int ret, frame_start, frame_addr;
 	bool is_c45 = !!(regnum & MII_ADDR_C45);
 
-	ret = pm_runtime_resume_and_get(dev);
+	ret = pm_runtime_resume_and_get_sync(dev);
 	if (ret < 0)
 		return ret;
 
@@ -2273,7 +2273,7 @@ static void fec_enet_get_regs(struct net_device *ndev,
 	u32 i, off;
 	int ret;
 
-	ret = pm_runtime_resume_and_get(dev);
+	ret = pm_runtime_resume_and_get_sync(dev);
 	if (ret < 0)
 		return;
 
@@ -2974,7 +2974,7 @@ fec_enet_open(struct net_device *ndev)
 	int ret;
 	bool reset_again;
 
-	ret = pm_runtime_resume_and_get(&fep->pdev->dev);
+	ret = pm_runtime_resume_and_get_sync(&fep->pdev->dev);
 	if (ret < 0)
 		return ret;
 
@@ -3768,7 +3768,7 @@ fec_drv_remove(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	int ret;
 
-	ret = pm_runtime_resume_and_get(&pdev->dev);
+	ret = pm_runtime_resume_and_get_sync(&pdev->dev);
 	if (ret < 0)
 		return ret;
 
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index b492ae00cc90..c83edb7473fc 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -387,14 +387,14 @@ static inline int pm_runtime_get_sync(struct device *dev)
 }
 
 /**
- * pm_runtime_resume_and_get - Bump up usage counter of a device and resume it.
+ * pm_runtime_resume_and_get_sync - Bump up usage counter of a device and resume it.
  * @dev: Target device.
  *
  * Resume @dev synchronously and if that is successful, increment its runtime
  * PM usage counter. Return 0 if the runtime PM usage counter of @dev has been
  * incremented or a negative error code otherwise.
  */
-static inline int pm_runtime_resume_and_get(struct device *dev)
+static inline int pm_runtime_resume_and_get_sync(struct device *dev)
 {
 	int ret;
 
-- 
2.25.4

