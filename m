Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9E25442CB
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jun 2022 06:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbiFIE6N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jun 2022 00:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbiFIE6L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jun 2022 00:58:11 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FAA101D9
        for <linux-pm@vger.kernel.org>; Wed,  8 Jun 2022 21:58:09 -0700 (PDT)
Received: from fsav118.sakura.ne.jp (fsav118.sakura.ne.jp [27.133.134.245])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 2594w4CC088373;
        Thu, 9 Jun 2022 13:58:04 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav118.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp);
 Thu, 09 Jun 2022 13:58:04 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 2594w4bx088368
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 9 Jun 2022 13:58:04 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <50d84193-a933-1301-b9d9-bf6cc01ee126@I-love.SAKURA.ne.jp>
Date:   Thu, 9 Jun 2022 13:58:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] power: ab8500: Remove flush_scheduled_work() call.
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It seems to me that ab8500 driver is using dedicated workqueues and
is not calling schedule{,_delayed}_work{,_on}(). Then, there will be
no work to flush using flush_scheduled_work().

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Please see commit c4f135d643823a86 ("workqueue: Wrap flush_workqueue()
using a macro") for background.

 drivers/power/supply/ab8500_btemp.c    | 1 -
 drivers/power/supply/ab8500_chargalg.c | 1 -
 drivers/power/supply/ab8500_charger.c  | 2 --
 drivers/power/supply/ab8500_fg.c       | 1 -
 4 files changed, 5 deletions(-)

diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/ab8500_btemp.c
index b7e842dff567..863fabe05bdc 100644
--- a/drivers/power/supply/ab8500_btemp.c
+++ b/drivers/power/supply/ab8500_btemp.c
@@ -697,7 +697,6 @@ static void ab8500_btemp_unbind(struct device *dev, struct device *master,
 
 	/* Delete the work queue */
 	destroy_workqueue(di->btemp_wq);
-	flush_scheduled_work();
 }
 
 static const struct component_ops ab8500_btemp_component_ops = {
diff --git a/drivers/power/supply/ab8500_chargalg.c b/drivers/power/supply/ab8500_chargalg.c
index 431bbc352d1b..454acb1964fc 100644
--- a/drivers/power/supply/ab8500_chargalg.c
+++ b/drivers/power/supply/ab8500_chargalg.c
@@ -1746,7 +1746,6 @@ static void ab8500_chargalg_unbind(struct device *dev, struct device *master,
 
 	/* Delete the work queue */
 	destroy_workqueue(di->chargalg_wq);
-	flush_scheduled_work();
 }
 
 static const struct component_ops ab8500_chargalg_component_ops = {
diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index d04d087caa50..0510e0ee4c60 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -3404,8 +3404,6 @@ static void ab8500_charger_unbind(struct device *dev)
 	/* Delete the work queue */
 	destroy_workqueue(di->charger_wq);
 
-	flush_scheduled_work();
-
 	/* Unbind fg, btemp, algorithm */
 	component_unbind_all(dev, di);
 }
diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index ec8a404d71b4..e49f9b679b6c 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -3227,7 +3227,6 @@ static int ab8500_fg_remove(struct platform_device *pdev)
 	struct ab8500_fg *di = platform_get_drvdata(pdev);
 
 	destroy_workqueue(di->fg_wq);
-	flush_scheduled_work();
 	component_del(&pdev->dev, &ab8500_fg_component_ops);
 	list_del(&di->node);
 	ab8500_fg_sysfs_exit(di);
-- 
2.18.4

