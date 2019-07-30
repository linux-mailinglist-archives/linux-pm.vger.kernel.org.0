Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D22287ADC0
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 18:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732877AbfG3Qcg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 12:32:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45991 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732860AbfG3Qcg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2019 12:32:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id f9so66460409wre.12;
        Tue, 30 Jul 2019 09:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gdeErmdc8u99cfqR6bopaNzFUYq6DgK0A7xW8/rOWUE=;
        b=JmoydR9Zkor7ywvcUZ/Wjjdcu8jp2AxAI7TkTQ7/UG3ALXMvwIWhMG9n0FRbllPP16
         y1wKvm477XLeSBeBlOt4ahD7yYmrFBU+15OVBhhEGJCdz/ELX66WtLstsRTuAeV4KjTf
         QyAlCQINE6HRpsxNx+Y7Jb5CZN/wZL4ajhWyygudpWm0Ov5UEsUxnw2n44vX9IDCkGJS
         soKxtXxcaHQsyhExKXUPKK+tQhmSqfgq8z6BPgWN3Yu1qMm9+/JQRYmoLlJZ3oRo/yF/
         W+TTOtPSefsn4YOT/m5VJbffPq2JUPHcCDHFD0iPp4TYe9VW2ZudwB3Yje6LmEh5MjSR
         9G5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gdeErmdc8u99cfqR6bopaNzFUYq6DgK0A7xW8/rOWUE=;
        b=HJ+B+0uYvTjKv0ptbXLZ7iPe1qVf7K/mtfysGqL8DTUh9c1zhCVOrD7lDvlce3g+A2
         oLDQaNeUAAXU/S9vT01AXarRg0ChIIQXAaq7CAA3KvH+s1sTvDXxfgGCH5WCU5ImPyeI
         fiKdB9Ds0uVQwO3/4oFaxceLap6jst96xGjA4hhMMF0NYILaBR2zHktMPBhRaoazctCs
         06peZNbWIreIriwH5c/8+oKg5rSzXWOmSKL34xepm5OUG4VtGaIXm6bHdfRmjMaxGQP9
         tQ35tS9CstIf/henEFRJb6/fYHK4Zh5Pq+Thf3YmXGm5DE1RUAlEik3Az1TlnAemGNQf
         nEUw==
X-Gm-Message-State: APjAAAVO9/Segd5jPbfmDWybtxUaNmhKsFQn2/msqtvq0nAzKp4b+YtS
        D+ZRb1LzX4OpW7DU0ihf8lA=
X-Google-Smtp-Source: APXvYqyV7B0rvaKAgtplvUqwJvJ4F6cIHZdSemCwlRrZISDg+Fr/Kv/tRdomrMVYVy0AOeygVvSwtg==
X-Received: by 2002:adf:cd90:: with SMTP id q16mr46820862wrj.118.1564504352993;
        Tue, 30 Jul 2019 09:32:32 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id c65sm64835175wma.44.2019.07.30.09.32.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 09:32:32 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 11/20] PM / devfreq: tegra30: Use CPUFreq notifier
Date:   Tue, 30 Jul 2019 19:22:27 +0300
Message-Id: <20190730162236.6063-12-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730162236.6063-1-digetx@gmail.com>
References: <20190730162236.6063-1-digetx@gmail.com>
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
 drivers/devfreq/tegra30-devfreq.c | 171 ++++++++++++++++++++++++++----
 1 file changed, 151 insertions(+), 20 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index a2623de56d20..17de24d2ae32 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -17,6 +17,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/reset.h>
+#include <linux/workqueue.h>
 
 #include "governor.h"
 
@@ -159,7 +160,10 @@ struct tegra_devfreq {
 
 	struct clk		*emc_clock;
 	unsigned long		max_freq;
-	struct notifier_block	rate_change_nb;
+	struct notifier_block	clk_rate_change_nb;
+
+	struct delayed_work	cpufreq_update_work;
+	struct notifier_block	cpu_rate_change_nb;
 
 	struct tegra_devfreq_device devices[ARRAY_SIZE(actmon_device_configs)];
 
@@ -207,10 +211,10 @@ static unsigned long do_percent(unsigned long val, unsigned int pct)
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
@@ -244,7 +248,8 @@ tegra_actmon_account_cpu_freq(struct tegra_devfreq *tegra,
 		return target_freq;
 
 	if (dev->avg_freq > tegra_actmon_dev_avg_dependency_freq(tegra, dev))
-		static_cpu_emc_freq = actmon_cpu_to_emc_rate(tegra);
+		static_cpu_emc_freq = actmon_cpu_to_emc_rate(
+						tegra, cpufreq_quick_get(0));
 	else
 		static_cpu_emc_freq = 0;
 
@@ -543,8 +548,8 @@ static irqreturn_t actmon_thread_isr(int irq, void *data)
 	return handled ? IRQ_HANDLED : IRQ_NONE;
 }
 
-static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
-				       unsigned long action, void *ptr)
+static int tegra_actmon_clk_notify_cb(struct notifier_block *nb,
+				      unsigned long action, void *ptr)
 {
 	struct clk_notifier_data *data = ptr;
 	struct tegra_devfreq_device *dev;
@@ -555,7 +560,7 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
 	if (action != POST_RATE_CHANGE)
 		return NOTIFY_OK;
 
-	tegra = container_of(nb, struct tegra_devfreq, rate_change_nb);
+	tegra = container_of(nb, struct tegra_devfreq, clk_rate_change_nb);
 
 	freq = data->new_rate / KHZ;
 
@@ -586,6 +591,94 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
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
@@ -617,9 +710,16 @@ static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
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
@@ -627,7 +727,30 @@ static void tegra_actmon_start(struct tegra_devfreq *tegra)
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
@@ -636,11 +759,13 @@ static void tegra_actmon_stop(struct tegra_devfreq *tegra)
 
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
@@ -749,6 +874,7 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
 					unsigned int event, void *data)
 {
 	struct tegra_devfreq *tegra = dev_get_drvdata(devfreq->dev.parent);
+	int ret = 0;
 
 	/*
 	 * Couple device with the governor early as it is needed at
@@ -759,7 +885,7 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
 	switch (event) {
 	case DEVFREQ_GOV_START:
 		devfreq_monitor_start(devfreq);
-		tegra_actmon_start(tegra);
+		ret = tegra_actmon_start(tegra);
 		break;
 
 	case DEVFREQ_GOV_STOP:
@@ -774,11 +900,11 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
 
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
@@ -884,9 +1010,14 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 
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
@@ -915,7 +1046,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	devfreq_remove_governor(&tegra_devfreq_governor);
 
 unreg_notifier:
-	clk_notifier_unregister(tegra->emc_clock, &tegra->rate_change_nb);
+	clk_notifier_unregister(tegra->emc_clock, &tegra->clk_rate_change_nb);
 
 remove_opps:
 	dev_pm_opp_remove_all_dynamic(&pdev->dev);
@@ -933,7 +1064,7 @@ static int tegra_devfreq_remove(struct platform_device *pdev)
 	devfreq_remove_device(tegra->devfreq);
 	devfreq_remove_governor(&tegra_devfreq_governor);
 
-	clk_notifier_unregister(tegra->emc_clock, &tegra->rate_change_nb);
+	clk_notifier_unregister(tegra->emc_clock, &tegra->clk_rate_change_nb);
 	dev_pm_opp_remove_all_dynamic(&pdev->dev);
 
 	reset_control_reset(tegra->reset);
-- 
2.22.0

