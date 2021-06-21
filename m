Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE823AE667
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jun 2021 11:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhFUJtS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Jun 2021 05:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbhFUJtD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jun 2021 05:49:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91980C061760
        for <linux-pm@vger.kernel.org>; Mon, 21 Jun 2021 02:46:49 -0700 (PDT)
Date:   Mon, 21 Jun 2021 09:46:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624268805;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JYDJxUCYzoOzCyvt5NERbFB9iZTPfpSX7H4mshqRr9A=;
        b=QUYJPKlAOAPWHUcNJg6NZ7DQkUzzzXfoRW708pEcQp1l+7cWZBYzXu3KiNPIS9OlHeUFKQ
        2yYQH6bCNF5Ejh154Xn73fH4akB5JpTyb1LDC0FEU9Bx+jW0xNayfKls4i2GAiTu0yxPF2
        Yuq0y7xF2oXkFf2emjh4xjN1ebSb0B5ITS8liYrDaGjgi+GcnlVa1ozLzXWePfKqiTqM0W
        ZU4k9+WwWe3fDE2LCVXMlerSc403e/TdLfDQ5NPxKyF8H4SSx4biR3ncovQsur/DCZYBaB
        wgtja5OlkNw92yr2z7bcBmPzPi/uIszcDRggVAKe2jFhNursQqPYgb6J08Kr7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624268805;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JYDJxUCYzoOzCyvt5NERbFB9iZTPfpSX7H4mshqRr9A=;
        b=qRxPdBDiGuLjeK7K4cgHCtBs8qI5TzWRYOV6E8mqjcjG5K6QOy917xWjkbzRO9V/KPsqNs
        U8ZbLwFD7AhipUCg==
From:   "thermal-bot for Krzysztof Kozlowski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/sprd: Add missing of_node_put
 for loop iteration
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210614192230.19248-2-krzysztof.kozlowski@canonical.com>
References: <20210614192230.19248-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Message-ID: <162426880488.395.12152662445379144394.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     d8ac5bb4ae653e092d7429a7587b73f1662d6ad7
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//d8ac5bb4ae653e092d7429a7587b73f1662d6ad7
Author:        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
AuthorDate:    Mon, 14 Jun 2021 21:22:30 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 14 Jun 2021 22:42:09 +02:00

thermal/drivers/sprd: Add missing of_node_put for loop iteration

Early exits from for_each_available_child_of_node() should decrement the
node reference counter.  Reported by Coccinelle:

  drivers/thermal/sprd_thermal.c:387:1-23: WARNING:
    Function "for_each_child_of_node" should have of_node_put() before goto around lines 391.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Acked-by: Chunyan Zhang <zhang.lyra@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210614192230.19248-2-krzysztof.kozlowski@canonical.com
---
 drivers/thermal/sprd_thermal.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/sprd_thermal.c b/drivers/thermal/sprd_thermal.c
index fe06ccc..fff80fc 100644
--- a/drivers/thermal/sprd_thermal.c
+++ b/drivers/thermal/sprd_thermal.c
@@ -388,7 +388,7 @@ static int sprd_thm_probe(struct platform_device *pdev)
 		sen = devm_kzalloc(&pdev->dev, sizeof(*sen), GFP_KERNEL);
 		if (!sen) {
 			ret = -ENOMEM;
-			goto disable_clk;
+			goto of_put;
 		}
 
 		sen->data = thm;
@@ -397,13 +397,13 @@ static int sprd_thm_probe(struct platform_device *pdev)
 		ret = of_property_read_u32(sen_child, "reg", &sen->id);
 		if (ret) {
 			dev_err(&pdev->dev, "get sensor reg failed");
-			goto disable_clk;
+			goto of_put;
 		}
 
 		ret = sprd_thm_sensor_calibration(sen_child, thm, sen);
 		if (ret) {
 			dev_err(&pdev->dev, "efuse cal analysis failed");
-			goto disable_clk;
+			goto of_put;
 		}
 
 		sprd_thm_sensor_init(thm, sen);
@@ -416,19 +416,20 @@ static int sprd_thm_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev, "register thermal zone failed %d\n",
 				sen->id);
 			ret = PTR_ERR(sen->tzd);
-			goto disable_clk;
+			goto of_put;
 		}
 
 		thm->sensor[sen->id] = sen;
 	}
+	/* sen_child set to NULL at this point */
 
 	ret = sprd_thm_set_ready(thm);
 	if (ret)
-		goto disable_clk;
+		goto of_put;
 
 	ret = sprd_thm_wait_temp_ready(thm);
 	if (ret)
-		goto disable_clk;
+		goto of_put;
 
 	for (i = 0; i < thm->nr_sensors; i++)
 		sprd_thm_toggle_sensor(thm->sensor[i], true);
@@ -436,6 +437,8 @@ static int sprd_thm_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, thm);
 	return 0;
 
+of_put:
+	of_node_put(sen_child);
 disable_clk:
 	clk_disable_unprepare(thm->clk);
 	return ret;
