Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F065C0108
	for <lists+linux-pm@lfdr.de>; Wed, 21 Sep 2022 17:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiIUPWZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Sep 2022 11:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiIUPWY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Sep 2022 11:22:24 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5DF8E0F2
        for <linux-pm@vger.kernel.org>; Wed, 21 Sep 2022 08:22:22 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MXhqN6ytpzMn81;
        Wed, 21 Sep 2022 23:17:36 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 23:22:18 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 21 Sep
 2022 23:22:18 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-pm@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
CC:     <sre@kernel.org>, <chiaen_wu@richtek.com>
Subject: [PATCH -next] power: supply: mt6370: Fix return value check in mt6370_chg_probe()
Date:   Wed, 21 Sep 2022 23:29:15 +0800
Message-ID: <20220921152915.1506767-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

If create_singlethread_workqueue() fails, it returns a null pointer,
replace IS_ERR() check with NULL pointer check.

Fixes: 233cb8a47d65 ("power: supply: mt6370: Add MediaTek MT6370 charger driver")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/power/supply/mt6370-charger.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/mt6370-charger.c b/drivers/power/supply/mt6370-charger.c
index 716cba259a7a..f27dae5043f5 100644
--- a/drivers/power/supply/mt6370-charger.c
+++ b/drivers/power/supply/mt6370-charger.c
@@ -911,8 +911,8 @@ static int mt6370_chg_probe(struct platform_device *pdev)
 	priv->attach = MT6370_ATTACH_STAT_DETACH;
 
 	priv->wq = create_singlethread_workqueue(dev_name(priv->dev));
-	if (IS_ERR(priv->wq))
-		return dev_err_probe(dev, PTR_ERR(priv->wq),
+	if (!priv->wq)
+		return dev_err_probe(dev, -ENOMEM,
 				     "Failed to create workqueue\n");
 
 	ret = devm_add_action_or_reset(dev, mt6370_chg_destroy_wq, priv->wq);
-- 
2.25.1

