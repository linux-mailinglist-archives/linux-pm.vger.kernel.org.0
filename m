Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C058783848
	for <lists+linux-pm@lfdr.de>; Tue, 22 Aug 2023 05:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjHVDFc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Aug 2023 23:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbjHVDFc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Aug 2023 23:05:32 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E05F185
        for <linux-pm@vger.kernel.org>; Mon, 21 Aug 2023 20:05:30 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RVDfS4wZfzLp5v;
        Tue, 22 Aug 2023 11:02:24 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 22 Aug 2023 11:05:28 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 22 Aug
 2023 11:05:27 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-pm@vger.kernel.org>
CC:     <sre@kernel.org>, <lee@kernel.org>, <jahau@rocketmail.com>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next] power: supply: rt5033_charger: fix missing unlock
Date:   Tue, 22 Aug 2023 11:02:07 +0800
Message-ID: <20230822030207.644738-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix missing mutex_unlock() in some error path.

Fixes: 12cc585f36b8 ("power: supply: rt5033_charger: Add cable detection and USB OTG supply")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/power/supply/rt5033_charger.c | 28 ++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/rt5033_charger.c b/drivers/power/supply/rt5033_charger.c
index 4ea769775fa5..6ce83c22c4e9 100644
--- a/drivers/power/supply/rt5033_charger.c
+++ b/drivers/power/supply/rt5033_charger.c
@@ -361,7 +361,8 @@ static int rt5033_charger_set_otg(struct rt5033_charger *charger)
 			0x37 << RT5033_CHGCTRL2_CV_SHIFT);
 	if (ret) {
 		dev_err(charger->dev, "Failed set OTG boost v_out\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out_unlock;
 	}
 
 	/* Set operation mode to OTG */
@@ -369,7 +370,8 @@ static int rt5033_charger_set_otg(struct rt5033_charger *charger)
 			RT5033_CHGCTRL1_MODE_MASK, RT5033_BOOST_MODE);
 	if (ret) {
 		dev_err(charger->dev, "Failed to update OTG mode.\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out_unlock;
 	}
 
 	/* In case someone switched from charging to OTG directly */
@@ -378,9 +380,10 @@ static int rt5033_charger_set_otg(struct rt5033_charger *charger)
 
 	charger->otg = true;
 
+out_unlock:
 	mutex_unlock(&charger->lock);
 
-	return 0;
+	return ret;
 }
 
 static int rt5033_charger_unset_otg(struct rt5033_charger *charger)
@@ -420,8 +423,10 @@ static int rt5033_charger_set_charging(struct rt5033_charger *charger)
 	/* In case someone switched from OTG to charging directly */
 	if (charger->otg) {
 		ret = rt5033_charger_unset_otg(charger);
-		if (ret)
+		if (ret) {
+			mutex_unlock(&charger->lock);
 			return -EINVAL;
+		}
 	}
 
 	charger->online = true;
@@ -448,6 +453,7 @@ static int rt5033_charger_set_mivr(struct rt5033_charger *charger)
 			RT5033_CHGCTRL4_MIVR_MASK, RT5033_CHARGER_MIVR_4600MV);
 	if (ret) {
 		dev_err(charger->dev, "Failed to set MIVR level.\n");
+		mutex_unlock(&charger->lock);
 		return -EINVAL;
 	}
 
@@ -463,7 +469,7 @@ static int rt5033_charger_set_mivr(struct rt5033_charger *charger)
 
 static int rt5033_charger_set_disconnect(struct rt5033_charger *charger)
 {
-	int ret;
+	int ret = 0;
 
 	mutex_lock(&charger->lock);
 
@@ -475,7 +481,8 @@ static int rt5033_charger_set_disconnect(struct rt5033_charger *charger)
 				RT5033_CHARGER_MIVR_DISABLE);
 		if (ret) {
 			dev_err(charger->dev, "Failed to disable MIVR.\n");
-			return -EINVAL;
+			ret = -EINVAL;
+			goto out_unlock;
 		}
 
 		charger->mivr_enabled = false;
@@ -483,16 +490,19 @@ static int rt5033_charger_set_disconnect(struct rt5033_charger *charger)
 
 	if (charger->otg) {
 		ret = rt5033_charger_unset_otg(charger);
-		if (ret)
-			return -EINVAL;
+		if (ret) {
+			ret = -EINVAL;
+			goto out_unlock;
+		}
 	}
 
 	if (charger->online)
 		charger->online = false;
 
+out_unlock:
 	mutex_unlock(&charger->lock);
 
-	return 0;
+	return ret;
 }
 
 static enum power_supply_property rt5033_charger_props[] = {
-- 
2.25.1

