Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161157E1023
	for <lists+linux-pm@lfdr.de>; Sat,  4 Nov 2023 16:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjKDPti (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 4 Nov 2023 11:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKDPth (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Nov 2023 11:49:37 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF2B19D
        for <linux-pm@vger.kernel.org>; Sat,  4 Nov 2023 08:49:33 -0700 (PDT)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id A079586FF2;
        Sat,  4 Nov 2023 16:49:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1699112970;
        bh=jCizlydCKi5lNIqwtZ5Pt5h4wmg7TCkhotbtq3DlS9Y=;
        h=From:To:Cc:Subject:Date:From;
        b=Hf23CKzOW9q4VpdKS87jULRNwuvhPmGKuD544K3NtnSeRSo6ZQiCQOKA/FbD3GcuJ
         u+2EjhqKDDkhbrEaRUhtQhQxzQMybbK/B0NHEonGPFXi3fF1OLAhwE1jBJDNJ9uwpG
         bHur4qoerpblq9BUL1qk0SGEPFCGPSvaB0A/r15q7bALIUgVWDNR+onIV95FOfyHxg
         MLfXDJRHQv3ntUTunc5eayN1JAJL1TbBqgyawGpia1KPuL5pxGra1+2hul4LxWxqRe
         Oi61CVc5NVTbMMM8gAXtzE+tpiMC+AM2xYkRlQDeHuMafHtmm3hJChKhMIXNHwLCVt
         GTBmQGDBK0fsw==
From:   Marek Vasut <marex@denx.de>
To:     linux-pm@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>, Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sre@kernel.org>
Subject: [PATCH] power: supply: bq27xxx: Stop and start delayed work in suspend and resume
Date:   Sat,  4 Nov 2023 16:49:06 +0100
Message-ID: <20231104154920.68585-1-marex@denx.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This driver uses delayed work to perform periodic battery state read out.
This delayed work is not stopped across suspend and resume cycle. The
read out can occur early in the resume cycle. In case of an I2C variant
of this hardware, that read out triggers I2C transfer. That I2C transfer
may happen while the I2C controller is still suspended, which produces a
WARNING in the kernel log.

Fix this by introducing trivial PM ops, which stop the delayed work before
the system enters suspend, and schedule the delayed work right after the
system resumes.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org
---
 drivers/power/supply/bq27xxx_battery.c     | 22 ++++++++++++++++++++++
 drivers/power/supply/bq27xxx_battery_i2c.c |  1 +
 include/linux/power/bq27xxx_battery.h      |  1 +
 3 files changed, 24 insertions(+)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 4296600e8912a..1c4a9d1377442 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -2162,6 +2162,28 @@ void bq27xxx_battery_teardown(struct bq27xxx_device_info *di)
 }
 EXPORT_SYMBOL_GPL(bq27xxx_battery_teardown);
 
+#ifdef CONFIG_PM_SLEEP
+static int bq27xxx_battery_suspend(struct device *dev)
+{
+	struct bq27xxx_device_info *di = dev_get_drvdata(dev);
+
+	cancel_delayed_work(&di->work);
+	return 0;
+}
+
+static int bq27xxx_battery_resume(struct device *dev)
+{
+	struct bq27xxx_device_info *di = dev_get_drvdata(dev);
+
+	schedule_delayed_work(&di->work, 0);
+	return 0;
+}
+#endif /* CONFIG_PM_SLEEP */
+
+SIMPLE_DEV_PM_OPS(bq27xxx_battery_battery_pm_ops,
+		  bq27xxx_battery_suspend, bq27xxx_battery_resume);
+EXPORT_SYMBOL_GPL(bq27xxx_battery_battery_pm_ops);
+
 MODULE_AUTHOR("Rodolfo Giometti <giometti@linux.it>");
 MODULE_DESCRIPTION("BQ27xxx battery monitor driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index 9b5475590518f..3a1798b0c1a79 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -295,6 +295,7 @@ static struct i2c_driver bq27xxx_battery_i2c_driver = {
 	.driver = {
 		.name = "bq27xxx-battery",
 		.of_match_table = of_match_ptr(bq27xxx_battery_i2c_of_match_table),
+		.pm = &bq27xxx_battery_battery_pm_ops,
 	},
 	.probe = bq27xxx_battery_i2c_probe,
 	.remove = bq27xxx_battery_i2c_remove,
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index 7c8d65414a70a..7d8025fb74b70 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -83,5 +83,6 @@ struct bq27xxx_device_info {
 void bq27xxx_battery_update(struct bq27xxx_device_info *di);
 int bq27xxx_battery_setup(struct bq27xxx_device_info *di);
 void bq27xxx_battery_teardown(struct bq27xxx_device_info *di);
+extern const struct dev_pm_ops bq27xxx_battery_battery_pm_ops;
 
 #endif
-- 
2.42.0

