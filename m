Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFAF689448
	for <lists+linux-pm@lfdr.de>; Sun, 11 Aug 2019 23:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfHKVZ0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 11 Aug 2019 17:25:26 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44452 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfHKVYs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Aug 2019 17:24:48 -0400
Received: by mail-lf1-f68.google.com with SMTP id v16so1262761lfg.11;
        Sun, 11 Aug 2019 14:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zC/znG0N0CSKGhWxUGhpQfsWmb43MyH6pjJkqgSDjCY=;
        b=K8NcLYdsw7FG99yjT/5n8KVqLeoX9eQZ0iJ1vI1fsYXSQijSMHtN1Mk1HJjepckLv1
         xU2rVvoKgSl5WmEsH+DsFG2LeY9QyQrAUmRMxfF8k575YWYWH51qSzEnw1mFz7GmeU8i
         kRR0YMsMWtp2NUIMclB3EepFJkUkQNAWpt1/awG+hp8NH4tLqoH8Ca5n21wgrOM9npKc
         zeVyYSwpiAhxTLXhuoQufEdKkWwtAuL4SrGGCPR2jVM8p0BSRtPAO/Ax2tsiYJfcoAS5
         90MR0UtmxW7OGiDVNFjZ7Y0xwaTnFisaSxOUPuVZzZ1fuVwd06Ll2XE5vMf74pl1KnZN
         XYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zC/znG0N0CSKGhWxUGhpQfsWmb43MyH6pjJkqgSDjCY=;
        b=nxoZ9QC6OsOB1j+Yp/E5KCk5eq/bSfN3VQYHDZfEnSoNrpwJfx+lvQb6cmidnrWP+V
         ijx+AkDoK9VErNhNUDtp5HJgeGch/6/H6rdzGDhL97asIw4zjTwxOP6fof6taMZopLf/
         poWVFt/UeM9Lw9Sk5Ar5zbmhNSwO23J+SfttaG9KhZJ3punHwbe29T5uCCq3SqBXxIZ1
         ujOn18vI4tV8weqaT8Xz5PnE3mTjBitBNcfXJufbv8dYpAoZpHNPsNNYnUWMGf/H1Qgz
         559kHnMlcrc+zzUuwJj2T1uX1SfhR3YwZGyk84zIb2qvngqqQSuOmy7DquVGt3ny0ePh
         O7iA==
X-Gm-Message-State: APjAAAX1Xx6dtKqXdQaJkjEQw/cE8RjgKwhchWCIgNFkQDJkiEbb4V2H
        1aEiCe6YYTLOvkJyMY/P4RA=
X-Google-Smtp-Source: APXvYqz9CzUPng5ieKnkGyAjk4IrmRR5TZoxbQAlst8NmjkUuY4kKHm3bZHGqLjWeEVsXCyt3Of61w==
X-Received: by 2002:ac2:5c4f:: with SMTP id s15mr19582043lfp.74.1565558684259;
        Sun, 11 Aug 2019 14:24:44 -0700 (PDT)
Received: from localhost.localdomain ([94.29.34.218])
        by smtp.gmail.com with ESMTPSA id f1sm20470806ljk.86.2019.08.11.14.24.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 14:24:43 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 11/19] PM / devfreq: tegra30: Use CPUFreq notifier
Date:   Mon, 12 Aug 2019 00:23:07 +0300
Message-Id: <20190811212315.12689-12-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190811212315.12689-1-digetx@gmail.com>
References: <20190811212315.12689-1-digetx@gmail.com>
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
 drivers/devfreq/tegra30-devfreq.c | 173 ++++++++++++++++++++++++++----
 1 file changed, 153 insertions(+), 20 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index a2623de56d20..a260812f7744 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -17,6 +17,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/reset.h>
+#include <linux/workqueue.h>
 
 #include "governor.h"
 
@@ -34,6 +35,8 @@
 #define ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN		BIT(30)
 #define ACTMON_DEV_CTRL_ENB					BIT(31)
 
+#define ACTMON_DEV_CTRL_STOP					0x00000000
+
 #define ACTMON_DEV_UPPER_WMARK					0x4
 #define ACTMON_DEV_LOWER_WMARK					0x8
 #define ACTMON_DEV_INIT_AVG					0xc
@@ -159,7 +162,10 @@ struct tegra_devfreq {
 
 	struct clk		*emc_clock;
 	unsigned long		max_freq;
-	struct notifier_block	rate_change_nb;
+	struct notifier_block	clk_rate_change_nb;
+
+	struct delayed_work	cpufreq_update_work;
+	struct notifier_block	cpu_rate_change_nb;
 
 	struct tegra_devfreq_device devices[ARRAY_SIZE(actmon_device_configs)];
 
@@ -207,10 +213,10 @@ static unsigned long do_percent(unsigned long val, unsigned int pct)
 	return val * pct / 100;
 }
 
-static unsigned long actmon_cpu_to_emc_rate(struct tegra_devfreq *tegra)
+static unsigned long actmon_cpu_to_emc_rate(struct tegra_devfreq *tegra,
+					    unsigned int cpu_freq)
 {
 	struct tegra_actmon_emc_ratio *ratio = actmon_emc_ratios;
-	unsigned int cpu_freq = cpufreq_quick_get(0);
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(actmon_emc_ratios); i++, ratio++) {
@@ -244,7 +250,8 @@ tegra_actmon_account_cpu_freq(struct tegra_devfreq *tegra,
 		return target_freq;
 
 	if (dev->avg_freq > tegra_actmon_dev_avg_dependency_freq(tegra, dev))
-		static_cpu_emc_freq = actmon_cpu_to_emc_rate(tegra);
+		static_cpu_emc_freq = actmon_cpu_to_emc_rate(
+						tegra, cpufreq_quick_get(0));
 	else
 		static_cpu_emc_freq = 0;
 
@@ -543,8 +550,8 @@ static irqreturn_t actmon_thread_isr(int irq, void *data)
 	return handled ? IRQ_HANDLED : IRQ_NONE;
 }
 
-static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
-				       unsigned long action, void *ptr)
+static int tegra_actmon_clk_notify_cb(struct notifier_block *nb,
+				      unsigned long action, void *ptr)
 {
 	struct clk_notifier_data *data = ptr;
 	struct tegra_devfreq_device *dev;
@@ -555,7 +562,7 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
 	if (action != POST_RATE_CHANGE)
 		return NOTIFY_OK;
 
-	tegra = container_of(nb, struct tegra_devfreq, rate_change_nb);
+	tegra = container_of(nb, struct tegra_devfreq, clk_rate_change_nb);
 
 	freq = data->new_rate / KHZ;
 
@@ -586,6 +593,94 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
+static void tegra_actmon_delayed_update(struct work_struct *work)
+{
+	struct tegra_devfreq *tegra = container_of(work, struct tegra_devfreq,
+						   cpufreq_update_work.work);
+
+	mutex_lock(&tegra->devfreq->lock);
+	update_devfreq(tegra->devfreq);
+	mutex_unlock(&tegra->devfreq->lock);
+}
+
+static unsigned long
+tegra_actmon_cpufreq_contribution(struct tegra_devfreq *tegra,
+				  unsigned int cpu_freq)
+{
+	unsigned long freq, static_cpu_emc_freq;
+
+	/* check whether CPU's freq is taken into account at all */
+	freq = tegra_actmon_dev_avg_dependency_freq(tegra,
+						    &tegra->devices[MCCPU]);
+	if (tegra->devices[MCCPU].avg_freq <= freq)
+		return 0;
+
+	static_cpu_emc_freq = actmon_cpu_to_emc_rate(tegra, cpu_freq);
+
+	/* compare static CPU-EMC freq with MCALL */
+	freq = tegra->devices[MCALL].avg_freq +
+	       tegra->devices[MCALL].boost_freq;
+
+	freq = tegra_actmon_upper_freq(tegra, freq);
+
+	if (freq == tegra->max_freq || freq >= static_cpu_emc_freq)
+		return 0;
+
+	/* compare static CPU-EMC freq with MCCPU */
+	freq = tegra->devices[MCCPU].avg_freq +
+	       tegra->devices[MCCPU].boost_freq;
+
+	freq = tegra_actmon_upper_freq(tegra, freq);
+
+	if (freq == tegra->max_freq || freq >= static_cpu_emc_freq)
+		return 0;
+
+	return static_cpu_emc_freq;
+}
+
+static int tegra_actmon_cpu_notify_cb(struct notifier_block *nb,
+				      unsigned long action, void *ptr)
+{
+	struct cpufreq_freqs *freqs = ptr;
+	struct tegra_devfreq *tegra;
+	unsigned long old, new, delay;
+
+	if (action != CPUFREQ_POSTCHANGE)
+		return NOTIFY_OK;
+
+	tegra = container_of(nb, struct tegra_devfreq, cpu_rate_change_nb);
+
+	/*
+	 * Quickly check whether CPU frequency should be taken into account
+	 * at all, without blocking CPUFreq's core.
+	 */
+	if (mutex_trylock(&tegra->devfreq->lock)) {
+		old = tegra_actmon_cpufreq_contribution(tegra, freqs->old);
+		new = tegra_actmon_cpufreq_contribution(tegra, freqs->new);
+		mutex_unlock(&tegra->devfreq->lock);
+
+		/*
+		 * If CPU's frequency shouldn't be taken into account at
+		 * the moment, then there is no need to update the devfreq's
+		 * state because ISR will re-check CPU's frequency on the
+		 * next interrupt.
+		 */
+		if (old == new)
+			return NOTIFY_OK;
+	}
+
+	/*
+	 * CPUFreq driver should support CPUFREQ_ASYNC_NOTIFICATION in order
+	 * to allow asynchronous notifications. This means we can't block
+	 * here for too long, otherwise CPUFreq's core will complain with a
+	 * warning splat.
+	 */
+	delay = msecs_to_jiffies(ACTMON_SAMPLING_PERIOD);
+	schedule_delayed_work(&tegra->cpufreq_update_work, delay);
+
+	return NOTIFY_OK;
+}
+
 static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
 					  struct tegra_devfreq_device *dev)
 {
@@ -617,9 +712,16 @@ static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
 	device_writel(dev, val, ACTMON_DEV_CTRL);
 }
 
-static void tegra_actmon_start(struct tegra_devfreq *tegra)
+static void tegra_actmon_stop_device(struct tegra_devfreq_device *dev)
+{
+	device_writel(dev, ACTMON_DEV_CTRL_STOP, ACTMON_DEV_CTRL);
+	device_writel(dev, ACTMON_INTR_STATUS_CLEAR, ACTMON_DEV_INTR_STATUS);
+}
+
+static int tegra_actmon_start(struct tegra_devfreq *tegra)
 {
 	unsigned int i;
+	int err;
 
 	actmon_writel(tegra, ACTMON_SAMPLING_PERIOD - 1,
 		      ACTMON_GLB_PERIOD_CTRL);
@@ -627,7 +729,30 @@ static void tegra_actmon_start(struct tegra_devfreq *tegra)
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
@@ -636,11 +761,13 @@ static void tegra_actmon_stop(struct tegra_devfreq *tegra)
 
 	disable_irq(tegra->irq);
 
-	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
-		device_writel(&tegra->devices[i], 0x00000000, ACTMON_DEV_CTRL);
-		device_writel(&tegra->devices[i], ACTMON_INTR_STATUS_CLEAR,
-			      ACTMON_DEV_INTR_STATUS);
-	}
+	cpufreq_unregister_notifier(&tegra->cpu_rate_change_nb,
+				    CPUFREQ_TRANSITION_NOTIFIER);
+
+	cancel_delayed_work_sync(&tegra->cpufreq_update_work);
+
+	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++)
+		tegra_actmon_stop_device(&tegra->devices[i]);
 }
 
 static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
@@ -749,6 +876,7 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
 					unsigned int event, void *data)
 {
 	struct tegra_devfreq *tegra = dev_get_drvdata(devfreq->dev.parent);
+	int ret = 0;
 
 	/*
 	 * Couple device with the governor early as it is needed at
@@ -759,7 +887,7 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
 	switch (event) {
 	case DEVFREQ_GOV_START:
 		devfreq_monitor_start(devfreq);
-		tegra_actmon_start(tegra);
+		ret = tegra_actmon_start(tegra);
 		break;
 
 	case DEVFREQ_GOV_STOP:
@@ -774,11 +902,11 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
 
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
@@ -884,9 +1012,14 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, tegra);
 
-	tegra->rate_change_nb.notifier_call = tegra_actmon_rate_notify_cb;
+	tegra->cpu_rate_change_nb.notifier_call = tegra_actmon_cpu_notify_cb;
+
+	INIT_DELAYED_WORK(&tegra->cpufreq_update_work,
+			  tegra_actmon_delayed_update);
+
+	tegra->clk_rate_change_nb.notifier_call = tegra_actmon_clk_notify_cb;
 	err = clk_notifier_register(tegra->emc_clock,
-				    &tegra->rate_change_nb);
+				    &tegra->clk_rate_change_nb);
 	if (err) {
 		dev_err(&pdev->dev,
 			"Failed to register rate change notifier\n");
@@ -915,7 +1048,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	devfreq_remove_governor(&tegra_devfreq_governor);
 
 unreg_notifier:
-	clk_notifier_unregister(tegra->emc_clock, &tegra->rate_change_nb);
+	clk_notifier_unregister(tegra->emc_clock, &tegra->clk_rate_change_nb);
 
 remove_opps:
 	dev_pm_opp_remove_all_dynamic(&pdev->dev);
@@ -933,7 +1066,7 @@ static int tegra_devfreq_remove(struct platform_device *pdev)
 	devfreq_remove_device(tegra->devfreq);
 	devfreq_remove_governor(&tegra_devfreq_governor);
 
-	clk_notifier_unregister(tegra->emc_clock, &tegra->rate_change_nb);
+	clk_notifier_unregister(tegra->emc_clock, &tegra->clk_rate_change_nb);
 	dev_pm_opp_remove_all_dynamic(&pdev->dev);
 
 	reset_control_reset(tegra->reset);
-- 
2.22.0

