Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F4E76DD1A
	for <lists+linux-pm@lfdr.de>; Thu,  3 Aug 2023 03:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbjHCBYi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Aug 2023 21:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjHCBYh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Aug 2023 21:24:37 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5FA30E4
        for <linux-pm@vger.kernel.org>; Wed,  2 Aug 2023 18:24:12 -0700 (PDT)
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RGWLf6ctvzrS7V;
        Thu,  3 Aug 2023 09:23:06 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 3 Aug
 2023 09:24:10 +0800
From:   Chen Jiahao <chenjiahao16@huawei.com>
To:     <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <amitk@kernel.org>, <rui.zhang@intel.com>,
        <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>,
        <aouledameur@baylibre.com>, <void0red@hust.edu.cn>,
        <robh@kernel.org>, <daniel@makrotopia.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     <chenjiahao16@huawei.com>
Subject: [PATCH -next] thermal/drivers/mediatek: Remove repeating warn msg after devm_thermal_add_hwmon_sysfs()
Date:   Thu, 3 Aug 2023 09:23:41 +0800
Message-ID: <20230803012341.2388831-1-chenjiahao16@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Referring to commit 8416ecfb32923 ("thermal/hwmon: Add error
information printing for devm_thermal_add_hwmon_sysfs()"),
return value has already been checked if ret != 0 in
devm_thermal_add_hwmon_sysfs(). Error handling has also been
performed in this case, including print warning message for
debugging.

Removing dev_warn() following devm_thermal_add_hwmon_sysfs()
to clean up redundant warning message.

Signed-off-by: Chen Jiahao <chenjiahao16@huawei.com>
---
 drivers/thermal/mediatek/auxadc_thermal.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/thermal/mediatek/auxadc_thermal.c b/drivers/thermal/mediatek/auxadc_thermal.c
index c537aed71017..7f8450c66646 100644
--- a/drivers/thermal/mediatek/auxadc_thermal.c
+++ b/drivers/thermal/mediatek/auxadc_thermal.c
@@ -1289,9 +1289,7 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 	if (IS_ERR(tzdev))
 		return PTR_ERR(tzdev);
 
-	ret = devm_thermal_add_hwmon_sysfs(&pdev->dev, tzdev);
-	if (ret)
-		dev_warn(&pdev->dev, "error in thermal_add_hwmon_sysfs");
+	devm_thermal_add_hwmon_sysfs(&pdev->dev, tzdev);
 
 	return 0;
 }
-- 
2.34.1

