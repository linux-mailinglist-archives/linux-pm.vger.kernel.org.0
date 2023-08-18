Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09ECC7808B0
	for <lists+linux-pm@lfdr.de>; Fri, 18 Aug 2023 11:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241308AbjHRJgX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Aug 2023 05:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359195AbjHRJf4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Aug 2023 05:35:56 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCED35A4
        for <linux-pm@vger.kernel.org>; Fri, 18 Aug 2023 02:35:53 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RRxXh0RZ3z1GF9w;
        Fri, 18 Aug 2023 17:34:28 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 18 Aug
 2023 17:35:50 +0800
From:   Ruan Jinjie <ruanjinjie@huawei.com>
To:     <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next] thermal/drivers/imx: Use the devm_clk_get_enabled() helper function
Date:   Fri, 18 Aug 2023 17:35:24 +0800
Message-ID: <20230818093525.1059106-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

With devm_clk_get_enabled() the call to clk_disable_unprepare() can be
dropped from the error path and the remove callback.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
 drivers/thermal/imx8mm_thermal.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/thermal/imx8mm_thermal.c b/drivers/thermal/imx8mm_thermal.c
index e89b11b3f2b9..c74df5de0450 100644
--- a/drivers/thermal/imx8mm_thermal.c
+++ b/drivers/thermal/imx8mm_thermal.c
@@ -313,16 +313,10 @@ static int imx8mm_tmu_probe(struct platform_device *pdev)
 	if (IS_ERR(tmu->base))
 		return PTR_ERR(tmu->base);
 
-	tmu->clk = devm_clk_get(&pdev->dev, NULL);
+	tmu->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(tmu->clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(tmu->clk),
-				     "failed to get tmu clock\n");
-
-	ret = clk_prepare_enable(tmu->clk);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to enable tmu clock: %d\n", ret);
-		return ret;
-	}
+				     "failed to enable tmu clock\n");
 
 	/* disable the monitor during initialization */
 	imx8mm_tmu_enable(tmu, false);
@@ -338,7 +332,7 @@ static int imx8mm_tmu_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev,
 				"failed to register thermal zone sensor[%d]: %d\n",
 				i, ret);
-			goto disable_clk;
+			return ret;
 		}
 		tmu->sensors[i].hw_id = i;
 
@@ -349,7 +343,7 @@ static int imx8mm_tmu_probe(struct platform_device *pdev)
 
 	ret = imx8mm_tmu_probe_set_calib(pdev, tmu);
 	if (ret)
-		goto disable_clk;
+		return ret;
 
 	/* enable all the probes for V2 TMU */
 	if (tmu->socdata->version == TMU_VER2)
@@ -359,10 +353,6 @@ static int imx8mm_tmu_probe(struct platform_device *pdev)
 	imx8mm_tmu_enable(tmu, true);
 
 	return 0;
-
-disable_clk:
-	clk_disable_unprepare(tmu->clk);
-	return ret;
 }
 
 static int imx8mm_tmu_remove(struct platform_device *pdev)
@@ -372,7 +362,6 @@ static int imx8mm_tmu_remove(struct platform_device *pdev)
 	/* disable TMU */
 	imx8mm_tmu_enable(tmu, false);
 
-	clk_disable_unprepare(tmu->clk);
 	platform_set_drvdata(pdev, NULL);
 
 	return 0;
-- 
2.34.1

