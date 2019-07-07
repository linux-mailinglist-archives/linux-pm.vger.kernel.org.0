Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56CDD617D7
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 00:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbfGGWfT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jul 2019 18:35:19 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45771 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbfGGWfT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jul 2019 18:35:19 -0400
Received: by mail-qk1-f193.google.com with SMTP id s22so11844875qkj.12;
        Sun, 07 Jul 2019 15:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0e7rvBkRZtsgKkmjKUB6YCiStdbbh2Mug1KxsKGWUgI=;
        b=G74u2+9J4ZGb8115Z7GXCQByUUxxOuppXYOLSfGsjLAbEBA3F4U4IZkQkjMCmFU4IW
         KFtGX1OFJ21KPQjysRppJulgVBHtxo0WQMScvci2+1Bh0o0S6ptF8mPB3Oa8s2btI3LC
         UZ4LNkV8HGy6SziVLoGHuOd6EvExfvfdTPZCCYQMfeV9a9g78kPD8m7k4/999F9KLE5t
         pO0zV9GppIH/jJOskTeX2h/UazYw+hMJDHE5SpNkvdWK1gHFmD3lLM9x/xRJKGUSbDMG
         rc3mjYVKPv3lZRebyKO0MVT/BcBhikovaFkO8V0qXvh9AP0roeF93cgBzIUXdinSbOT8
         YxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0e7rvBkRZtsgKkmjKUB6YCiStdbbh2Mug1KxsKGWUgI=;
        b=cvSZYC/qC3w2jRweDKaP+WXt6GBdEWAl2hCF7b8NBY7TN2kBI0jM1E+4bZHD/Kot07
         vtZgC6AVmoX3xEaEw13wggS40wNnCmElhdMcl/8nEuhxt/xHqbiqIoUb8qpPzQ7cNKfO
         aQE5dhXHtCm3w0XSt8gXNSD+/fJNFEXo5mvTgEW6kh0dn+QHGQ4PwfT7P5Tf7ADJikDL
         IwM1cHLLFw8nxnbuLBOhpwsauYzFVSa3O+h4OAaUZ2NdHPatBe1p+GLTlcMtyx5sizeJ
         h+MJ3M5WjQH6aYdx3A9Cmm0z5OiHvrozJB1Uv3uGSjW0Cv4LmOLnCP/6j7MjnIs0VO1B
         IpZg==
X-Gm-Message-State: APjAAAWq5VA03fJcTdYY9cwQMoq2oqGSeX6l6gp36MjrCvAwwQPkrXMW
        ULR8nhlWtFV3RRCTfB4ihb4=
X-Google-Smtp-Source: APXvYqw62o5FWT+iUe3r3vnNRvwthjiFwTphb3GCGM2SZvz5sLPQubrWqLNH4apJvAzbelChZbFv9w==
X-Received: by 2002:a37:6290:: with SMTP id w138mr11218440qkb.139.1562538918044;
        Sun, 07 Jul 2019 15:35:18 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id p4sm6998453qkb.84.2019.07.07.15.35.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 15:35:17 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/24] PM / devfreq: tegra30: Use CPUFreq notifier
Date:   Mon,  8 Jul 2019 01:32:46 +0300
Message-Id: <20190707223303.6755-8-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190707223303.6755-1-digetx@gmail.com>
References: <20190707223303.6755-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The CPU's client need to take into account that CPUFreq may change
while memory activity not, staying high. Thus an appropriate frequency
notifier should be used in addition to the clk-notifier.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 105 +++++++++++++++++++++++++-----
 1 file changed, 88 insertions(+), 17 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 2bf65409ddd8..48a799fa5f63 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -17,6 +17,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/reset.h>
+#include <linux/workqueue.h>
 
 #include "governor.h"
 
@@ -154,7 +155,10 @@ struct tegra_devfreq {
 
 	struct clk		*emc_clock;
 	unsigned long		max_freq;
-	struct notifier_block	rate_change_nb;
+	struct notifier_block	clk_rate_change_nb;
+
+	struct work_struct	update_work;
+	struct notifier_block	cpu_rate_change_nb;
 
 	struct tegra_devfreq_device devices[ARRAY_SIZE(actmon_device_configs)];
 
@@ -456,8 +460,8 @@ static irqreturn_t actmon_thread_isr(int irq, void *data)
 	return handled ? IRQ_HANDLED : IRQ_NONE;
 }
 
-static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
-				       unsigned long action, void *ptr)
+static int tegra_actmon_clk_notify_cb(struct notifier_block *nb,
+				      unsigned long action, void *ptr)
 {
 	struct clk_notifier_data *data = ptr;
 	struct tegra_devfreq_device *dev;
@@ -467,7 +471,7 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
 	if (action != POST_RATE_CHANGE)
 		return NOTIFY_OK;
 
-	tegra = container_of(nb, struct tegra_devfreq, rate_change_nb);
+	tegra = container_of(nb, struct tegra_devfreq, clk_rate_change_nb);
 
 	/*
 	 * EMC rate could change due to three reasons:
@@ -496,6 +500,37 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
+static void tegra_actmon_delayed_update(struct work_struct *work)
+{
+	struct tegra_devfreq *tegra = container_of(work, struct tegra_devfreq,
+						   update_work);
+
+	mutex_lock(&tegra->devfreq->lock);
+	update_devfreq(tegra->devfreq);
+	mutex_unlock(&tegra->devfreq->lock);
+}
+
+static int tegra_actmon_cpu_notify_cb(struct notifier_block *nb,
+				      unsigned long action, void *ptr)
+{
+	struct tegra_devfreq *tegra;
+
+	if (action != CPUFREQ_POSTCHANGE)
+		return NOTIFY_OK;
+
+	tegra = container_of(nb, struct tegra_devfreq, cpu_rate_change_nb);
+
+	/*
+	 * CPUFreq driver should support CPUFREQ_ASYNC_NOTIFICATION in order
+	 * to allow asynchronous notifications. This means we can't block
+	 * here for too long, otherwise CPUFreq's core will complain with a
+	 * warning splat.
+	 */
+	schedule_work(&tegra->update_work);
+
+	return NOTIFY_OK;
+}
+
 static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
 					  struct tegra_devfreq_device *dev)
 {
@@ -527,9 +562,16 @@ static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
 	device_writel(dev, val, ACTMON_DEV_CTRL);
 }
 
-static void tegra_actmon_start(struct tegra_devfreq *tegra)
+static void tegra_actmon_stop_device(struct tegra_devfreq_device *dev)
+{
+	device_writel(dev, 0x00000000, ACTMON_DEV_CTRL);
+	device_writel(dev, ACTMON_INTR_STATUS_CLEAR, ACTMON_DEV_INTR_STATUS);
+}
+
+static int tegra_actmon_start(struct tegra_devfreq *tegra)
 {
 	unsigned int i;
+	int err;
 
 	actmon_writel(tegra, ACTMON_SAMPLING_PERIOD - 1,
 		      ACTMON_GLB_PERIOD_CTRL);
@@ -537,7 +579,30 @@ static void tegra_actmon_start(struct tegra_devfreq *tegra)
 	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++)
 		tegra_actmon_configure_device(tegra, &tegra->devices[i]);
 
+	/*
+	 * We are estimating CPU's memory bandwidth requirement based on
+	 * amount of memory accesses and system's load, judging by CPU's
+	 * frequency. We also don't want to receive events about CPU's
+	 * frequency transaction when governor is stopped, hence notifier
+	 * is registered dynamically.
+	 */
+	err = cpufreq_register_notifier(&tegra->cpu_rate_change_nb,
+					CPUFREQ_TRANSITION_NOTIFIER);
+	if (err) {
+		dev_err(tegra->devfreq->dev.parent,
+			"Failed to register rate change notifier: %d\n", err);
+		goto err_stop;
+	}
+
 	enable_irq(tegra->irq);
+
+	return 0;
+
+err_stop:
+	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++)
+		tegra_actmon_stop_device(&tegra->devices[i]);
+
+	return err;
 }
 
 static void tegra_actmon_stop(struct tegra_devfreq *tegra)
@@ -546,11 +611,13 @@ static void tegra_actmon_stop(struct tegra_devfreq *tegra)
 
 	disable_irq(tegra->irq);
 
-	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
-		device_writel(&tegra->devices[i], 0x00000000, ACTMON_DEV_CTRL);
-		device_writel(&tegra->devices[i], ACTMON_INTR_STATUS_CLEAR,
-			      ACTMON_DEV_INTR_STATUS);
-	}
+	cpufreq_unregister_notifier(&tegra->cpu_rate_change_nb,
+				    CPUFREQ_TRANSITION_NOTIFIER);
+
+	cancel_work_sync(&tegra->update_work);
+
+	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++)
+		tegra_actmon_stop_device(&tegra->devices[i]);
 }
 
 static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
@@ -659,6 +726,7 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
 					unsigned int event, void *data)
 {
 	struct tegra_devfreq *tegra = dev_get_drvdata(devfreq->dev.parent);
+	int ret = 0;
 
 	/*
 	 * Couple device with the governor early as it is needed at
@@ -669,7 +737,7 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
 	switch (event) {
 	case DEVFREQ_GOV_START:
 		devfreq_monitor_start(devfreq);
-		tegra_actmon_start(tegra);
+		ret = tegra_actmon_start(tegra);
 		break;
 
 	case DEVFREQ_GOV_STOP:
@@ -684,11 +752,11 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
 
 	case DEVFREQ_GOV_RESUME:
 		devfreq_monitor_resume(devfreq);
-		tegra_actmon_start(tegra);
+		ret = tegra_actmon_start(tegra);
 		break;
 	}
 
-	return 0;
+	return ret;
 }
 
 static struct devfreq_governor tegra_devfreq_governor = {
@@ -794,9 +862,12 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, tegra);
 
-	tegra->rate_change_nb.notifier_call = tegra_actmon_rate_notify_cb;
+	tegra->cpu_rate_change_nb.notifier_call = tegra_actmon_cpu_notify_cb;
+	INIT_WORK(&tegra->update_work, tegra_actmon_delayed_update);
+
+	tegra->clk_rate_change_nb.notifier_call = tegra_actmon_clk_notify_cb;
 	err = clk_notifier_register(tegra->emc_clock,
-				    &tegra->rate_change_nb);
+				    &tegra->clk_rate_change_nb);
 	if (err) {
 		dev_err(&pdev->dev,
 			"Failed to register rate change notifier\n");
@@ -823,7 +894,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	devfreq_remove_governor(&tegra_devfreq_governor);
 
 unreg_notifier:
-	clk_notifier_unregister(tegra->emc_clock, &tegra->rate_change_nb);
+	clk_notifier_unregister(tegra->emc_clock, &tegra->clk_rate_change_nb);
 
 remove_opps:
 	dev_pm_opp_remove_all_dynamic(&pdev->dev);
@@ -841,7 +912,7 @@ static int tegra_devfreq_remove(struct platform_device *pdev)
 	devfreq_remove_device(tegra->devfreq);
 	devfreq_remove_governor(&tegra_devfreq_governor);
 
-	clk_notifier_unregister(tegra->emc_clock, &tegra->rate_change_nb);
+	clk_notifier_unregister(tegra->emc_clock, &tegra->clk_rate_change_nb);
 	dev_pm_opp_remove_all_dynamic(&pdev->dev);
 
 	reset_control_reset(tegra->reset);
-- 
2.22.0

