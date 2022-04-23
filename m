Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7831450CC94
	for <lists+linux-pm@lfdr.de>; Sat, 23 Apr 2022 19:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236604AbiDWRcc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 23 Apr 2022 13:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236592AbiDWRcb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 23 Apr 2022 13:32:31 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0CE1773E4
        for <linux-pm@vger.kernel.org>; Sat, 23 Apr 2022 10:29:31 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id bq30so19454989lfb.3
        for <linux-pm@vger.kernel.org>; Sat, 23 Apr 2022 10:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K0dNu+gsqOsxvzV6RiPi+gSx/YRNnpZCOhUTB2E6Dzg=;
        b=degRmRrPVD/1fmRH7fyjR4dGwJ8xCTdh9hKWC1sBp87/2q71LfLfDM1gaxM/soeUrd
         tNJqQH7SYqdBTAPR7Qk+xOBnSEJ5w91M3+s/eKzyzzrHNsyxT/UJwYHq68pUB7EgEkG4
         +b/mYcF4lZlyzw4qEbmaCbrP7SZXT21q1BIKXVPGWar2pqiavFxqbGCUkrIikmQPWA7u
         H9zFR9IhmWsK4nYzLgZ4968RNoCbFzAHHHiwkmKJWmJgTGZtxfvJbttrFU5ctOk8uF/S
         uBPA6s1zWaEw+ofDIYFwyKuj34yr3V3+jBPNbGP3PqEO69ZKeI648DrQETbA83uFEgdB
         CRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K0dNu+gsqOsxvzV6RiPi+gSx/YRNnpZCOhUTB2E6Dzg=;
        b=dK/H597EDKITWQZRepwnTkeXKHKam24OowpG8o0mC50ciVm0qFLqtdBI6lF42RFWrO
         5aHnC6enu/AAtXipk2zI/B/94zqUiIZzX48YwiQsQ3JeQX1bGl/7GBp4eNhXLXKcrNv7
         ZVVH85MRzB++ECUqWfrA91wO7btZMiJnkNdIvNllNl3WK8uh/ur138hcsvs3Scd2TMbd
         FrPhv1Y3eKpqp+cheov7HD0ErHEPI4Jphy1mdSIO0z8lhi32KtA5NQmuP1KFvYV/FCCz
         OCJYToKkJVKBIL7l2+lttKznQJMMX9CjdbXce+cC+P3bOJu3AgY93ovgBzDatviIEDds
         F5Qw==
X-Gm-Message-State: AOAM5329baQvQNz+L0koyP/5D7MendDluctvNgZwRJv42kEUeGG0ZUAS
        IhJI9tygpjaB45ueibyCoTxBnBhJbC0+iQ==
X-Google-Smtp-Source: ABdhPJxyDr9YUisZsW0MjciEFJb1IqNiS+d9KYhk3dtxXOoEbaDP+rnMZ4Iq5owNWLV3pQUAvMJMGw==
X-Received: by 2002:a05:6512:321b:b0:44a:78f2:500b with SMTP id d27-20020a056512321b00b0044a78f2500bmr70662lfe.434.1650734969980;
        Sat, 23 Apr 2022 10:29:29 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id x22-20020a2e9c96000000b0024da6072587sm602331lji.80.2022.04.23.10.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 10:29:29 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] power: supply: ab8500_fg: Allocate wq in probe
Date:   Sat, 23 Apr 2022 19:27:27 +0200
Message-Id: <20220423172727.1197901-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The workqueue is allocated in bind() but all interrupts are
registered in probe().

Some interrupts put work on the workqueue, which can have
bad side effects.

Allocate the workqueue in probe() instead, destroy it in
.remove() and make unbind() simply flush the workqueue.

Fixes: 1c1f13a006ed ("power: supply: ab8500: Move to componentized binding")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/ab8500_fg.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index 97ac588a9e9c..ec8a404d71b4 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -3037,13 +3037,6 @@ static int ab8500_fg_bind(struct device *dev, struct device *master,
 {
 	struct ab8500_fg *di = dev_get_drvdata(dev);
 
-	/* Create a work queue for running the FG algorithm */
-	di->fg_wq = alloc_ordered_workqueue("ab8500_fg_wq", WQ_MEM_RECLAIM);
-	if (di->fg_wq == NULL) {
-		dev_err(dev, "failed to create work queue\n");
-		return -ENOMEM;
-	}
-
 	di->bat_cap.max_mah_design = di->bm->bi->charge_full_design_uah;
 	di->bat_cap.max_mah = di->bat_cap.max_mah_design;
 	di->vbat_nom_uv = di->bm->bi->voltage_max_design_uv;
@@ -3067,8 +3060,7 @@ static void ab8500_fg_unbind(struct device *dev, struct device *master,
 	if (ret)
 		dev_err(dev, "failed to disable coulomb counter\n");
 
-	destroy_workqueue(di->fg_wq);
-	flush_scheduled_work();
+	flush_workqueue(di->fg_wq);
 }
 
 static const struct component_ops ab8500_fg_component_ops = {
@@ -3117,6 +3109,13 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 	ab8500_fg_charge_state_to(di, AB8500_FG_CHARGE_INIT);
 	ab8500_fg_discharge_state_to(di, AB8500_FG_DISCHARGE_INIT);
 
+	/* Create a work queue for running the FG algorithm */
+	di->fg_wq = alloc_ordered_workqueue("ab8500_fg_wq", WQ_MEM_RECLAIM);
+	if (di->fg_wq == NULL) {
+		dev_err(dev, "failed to create work queue\n");
+		return -ENOMEM;
+	}
+
 	/* Init work for running the fg algorithm instantly */
 	INIT_WORK(&di->fg_work, ab8500_fg_instant_work);
 
@@ -3227,6 +3226,8 @@ static int ab8500_fg_remove(struct platform_device *pdev)
 {
 	struct ab8500_fg *di = platform_get_drvdata(pdev);
 
+	destroy_workqueue(di->fg_wq);
+	flush_scheduled_work();
 	component_del(&pdev->dev, &ab8500_fg_component_ops);
 	list_del(&di->node);
 	ab8500_fg_sysfs_exit(di);
-- 
2.35.1

