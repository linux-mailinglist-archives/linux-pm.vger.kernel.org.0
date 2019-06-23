Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91A6A4FF0B
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2019 04:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfFXCGC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Jun 2019 22:06:02 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35435 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfFXCGC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Jun 2019 22:06:02 -0400
Received: by mail-lf1-f68.google.com with SMTP id a25so8790132lfg.2;
        Sun, 23 Jun 2019 19:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CoGCDWU5MclrhGGEVnaVillFZGoaSyHnpNFbq7mFCgg=;
        b=DzmfaYzEZPvW099BwLfiy6qoSGw7QNyPgWz0ypFI9+dEx70y8wn8nhV7v8JOOQ6Ljo
         ALEITJ2U2nRvFLF7O6Szl0UcFq1F0T9k63jwo9BklyNdlefTMK0c+EjHcLg2nUyHG6bh
         h9TlFWr5KNiTdlnziRBgGT/7Og6bpDCW8349rO+WCUyL55fVCNZvUYygRyj66ur3awzb
         8eDUFwo5WhuJBYHaFC5gsKX/lmfSvJjCOb+B50zZtb1OAPYDFt6hdmhNzYwuEI91DU/A
         3Qu6/cjIjWqNq+ZqMDCA42o9VmBbYBkP8DluUPPSswjw56V/28YJh3bSGe5m7Otj73F6
         pv5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CoGCDWU5MclrhGGEVnaVillFZGoaSyHnpNFbq7mFCgg=;
        b=dHXsX3yMl1g8/6kXSKNAkKEFiuIGrbpg80K5Rynmf4cWU2oPqOGR0G5OzjHV1VGGWC
         +/95GovTFdJVhs4oK+VyaQymav/PteA895dB9S1G7Sb0xhpI1KRPHqQ2ZIYHwN9hBcea
         TyHCl5pLSLm3W1m0hSISqAsjtYNHcCliVdG4gP7tmAeSICA9ygH0qzBUqLuUyPXd76DV
         ySHe2WeKUPETprsuCX9VbbsOrF1OsbehKfVhYC058kbcWtL80mmzKVi98xTn0vbNO1KX
         yulMDsysnvZhFm7qVD3UBoG2UD1A8B+fp2e++/0V2drhohB1gSfA8+ZhAEYq6p5Uw8L0
         WhIw==
X-Gm-Message-State: APjAAAV3xflkXYiikyctTtOKPfj/zDnPpj3vuz5C9utNoSw50OGXdtdR
        dWW/FM6PoZdS9Y/LLZ39wSWi2qDL
X-Google-Smtp-Source: APXvYqz1iIV8lvTrl6GMQx+Iq4q5ajrms+PD6dXVsZBUQhu2LQpucjd+qg8A4cphCy7qaFgeKNY0uw==
X-Received: by 2002:a19:9152:: with SMTP id y18mr33724150lfj.128.1561326519781;
        Sun, 23 Jun 2019 14:48:39 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id m17sm1460029lfb.9.2019.06.23.14.48.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jun 2019 14:48:39 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 05/11] PM / devfreq: tegra30: Rework frequency management logic
Date:   Mon, 24 Jun 2019 00:46:52 +0300
Message-Id: <20190623214658.11680-6-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190623214658.11680-1-digetx@gmail.com>
References: <20190623214658.11680-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The current implementation is inaccurate and results in very intensive
interrupt activity, which neglects the whole idea of polling offload to
hardware. The reason of the shortcoming is that watermarks are not set
up correctly and this results in ACTMON constantly asking to change freq
and then these requests are ignored. Secondly, the CPU's client need to
take into account that CPUFreq may change while memory activity not,
thus an appropriate frequency notifier should be used instead of the
clk-notifier. The end result of this patch is that there are few hundreds
of ACTMON's interrupts instead of tens thousands after few minutes of a
working devfreq, meanwhile the transitions activity stays about the same
and governor becomes more reactive.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 411 ++++++++++++++++++++++--------
 1 file changed, 301 insertions(+), 110 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 4be7858c33bc..813b0f490b90 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -17,6 +17,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/reset.h>
+#include <linux/workqueue.h>
 
 #include "governor.h"
 
@@ -40,6 +41,7 @@
 #define ACTMON_DEV_AVG_UPPER_WMARK				0x10
 #define ACTMON_DEV_AVG_LOWER_WMARK				0x14
 #define ACTMON_DEV_COUNT_WEIGHT					0x18
+#define ACTMON_DEV_COUNT					0x1c
 #define ACTMON_DEV_AVG_COUNT					0x20
 #define ACTMON_DEV_INTR_STATUS					0x24
 
@@ -47,6 +49,8 @@
 
 #define ACTMON_DEV_INTR_CONSECUTIVE_UPPER			BIT(31)
 #define ACTMON_DEV_INTR_CONSECUTIVE_LOWER			BIT(30)
+#define ACTMON_DEV_INTR_AVG_BELOW_WMARK				BIT(25)
+#define ACTMON_DEV_INTR_AVG_ABOVE_WMARK				BIT(24)
 
 #define ACTMON_ABOVE_WMARK_WINDOW				1
 #define ACTMON_BELOW_WMARK_WINDOW				3
@@ -63,9 +67,8 @@
  * ACTMON_AVERAGE_WINDOW_LOG2: default value for @DEV_CTRL_K_VAL, which
  * translates to 2 ^ (K_VAL + 1). ex: 2 ^ (6 + 1) = 128
  */
-#define ACTMON_AVERAGE_WINDOW_LOG2			6
-#define ACTMON_SAMPLING_PERIOD				12 /* ms */
-#define ACTMON_DEFAULT_AVG_BAND				6  /* 1/10 of % */
+#define ACTMON_AVERAGE_WINDOW_LOG2				6
+#define ACTMON_SAMPLING_PERIOD					12 /* ms */
 
 #define KHZ							1000
 
@@ -142,9 +145,6 @@ struct tegra_devfreq_device {
 	 * watermark breaches.
 	 */
 	unsigned long boost_freq;
-
-	/* Optimal frequency calculated from the stats for this device */
-	unsigned long target_freq;
 };
 
 struct tegra_devfreq {
@@ -156,7 +156,8 @@ struct tegra_devfreq {
 
 	struct clk		*emc_clock;
 	unsigned long		max_freq;
-	unsigned long		cur_freq;
+
+	struct work_struct	update_work;
 	struct notifier_block	rate_change_nb;
 
 	struct tegra_devfreq_device devices[ARRAY_SIZE(actmon_device_configs)];
@@ -205,42 +206,216 @@ static unsigned long do_percent(unsigned long val, unsigned int pct)
 	return val * pct / 100;
 }
 
+static unsigned long actmon_cpu_to_emc_rate(struct tegra_devfreq *tegra)
+{
+	struct tegra_actmon_emc_ratio *ratio = actmon_emc_ratios;
+	unsigned int cpu_freq = cpufreq_get(0);
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(actmon_emc_ratios); i++, ratio++) {
+		if (cpu_freq >= ratio->cpu_freq) {
+			if (ratio->emc_freq >= tegra->max_freq)
+				return tegra->max_freq;
+			else
+				return ratio->emc_freq;
+		}
+	}
+
+	return 0;
+}
+
+static unsigned long
+tegra_actmon_account_cpu_freq(struct tegra_devfreq *tegra,
+			      struct tegra_devfreq_device *dev,
+			      unsigned long target_freq,
+			      unsigned long count)
+{
+	unsigned long static_cpu_emc_freq;
+
+	if (dev->config->avg_dependency_threshold &&
+	    dev->config->avg_dependency_threshold < count) {
+		static_cpu_emc_freq = actmon_cpu_to_emc_rate(tegra);
+		target_freq = max(target_freq, static_cpu_emc_freq);
+	}
+
+	return target_freq;
+}
+
+static unsigned long tegra_actmon_lower_freq(struct tegra_devfreq *tegra,
+					     unsigned long target_freq)
+{
+	unsigned long lower = target_freq;
+	struct dev_pm_opp *opp;
+
+	opp = dev_pm_opp_find_freq_floor(tegra->devfreq->dev.parent, &lower);
+	if (IS_ERR(opp))
+		lower = 0;
+	else
+		dev_pm_opp_put(opp);
+
+	return lower;
+}
+
+static unsigned long tegra_actmon_upper_freq(struct tegra_devfreq *tegra,
+					     unsigned long target_freq)
+{
+	unsigned long upper = target_freq + 1;
+	struct dev_pm_opp *opp;
+
+	opp = dev_pm_opp_find_freq_ceil(tegra->devfreq->dev.parent, &upper);
+	if (IS_ERR(opp))
+		upper = ULONG_MAX;
+	else
+		dev_pm_opp_put(opp);
+
+	return upper;
+}
+
+static void tegra_actmon_get_lower_upper(struct tegra_devfreq *tegra,
+					 struct tegra_devfreq_device *dev,
+					 unsigned long count,
+					 unsigned long *lower,
+					 unsigned long *upper)
+{
+	unsigned long target_freq, min;
+
+	target_freq = count / ACTMON_SAMPLING_PERIOD * KHZ;
+
+	/*
+	 * Memory frequencies are guaranteed to have 1MHz granularity
+	 * and thus we need this rounding down to get a proper watermarks
+	 * range in a case where target_freq falls into a range of
+	 * next_possible_opp_freq - 1MHz.
+	 */
+	target_freq = round_down(target_freq, 1000000);
+
+	*lower = tegra_actmon_lower_freq(tegra, target_freq);
+
+	/*
+	 * When memory activity is below the minimum bandwidth that EMC
+	 * driver could provide, the upper watermark should be set for
+	 * the second OPP to avoid unnecessary interrupts activity when
+	 * the minimum threshold is crossed towards zero bandwidth.
+	 *
+	 *         ------ target_freq
+	 *         |        ----------------- minimum possible freq
+	 *         v        v
+	 * |0|----------|min freq|----|second freq|----|third freq|---...
+	 *  ^                                ^
+	 *  |                                |
+	 *  ---- lower watermark             ---- upper watermark
+	 */
+	min = tegra_actmon_upper_freq(tegra, 0);
+
+	if (target_freq < min)
+		*upper = tegra_actmon_upper_freq(tegra, min);
+	else
+		*upper = tegra_actmon_upper_freq(tegra, target_freq);
+
+	*lower /= KHZ;
+	*upper /= KHZ;
+
+	/*
+	 * The upper watermark should take into account CPU's frequency
+	 * because cpu_to_emc_rate() may override the target_freq with
+	 * a higher value and thus upper watermark need to be set up
+	 * accordingly to avoid parasitic upper-events.
+	 */
+	*upper = tegra_actmon_account_cpu_freq(tegra, dev, *upper, count);
+
+	*lower *= ACTMON_SAMPLING_PERIOD;
+	*upper *= ACTMON_SAMPLING_PERIOD;
+}
+
 static void tegra_devfreq_update_avg_wmark(struct tegra_devfreq *tegra,
 					   struct tegra_devfreq_device *dev)
 {
-	u32 avg = dev->avg_count;
-	u32 avg_band_freq = tegra->max_freq * ACTMON_DEFAULT_AVG_BAND / KHZ;
-	u32 band = avg_band_freq * ACTMON_SAMPLING_PERIOD;
+	unsigned long count = dev->avg_count;
+	unsigned long lower, upper;
+
+	tegra_actmon_get_lower_upper(tegra, dev, count, &lower, &upper);
 
-	device_writel(dev, avg + band, ACTMON_DEV_AVG_UPPER_WMARK);
+	/*
+	 * We want to get interrupts when MCCPU client crosses the
+	 * dependency threshold in order to into / out of account the
+	 * CPU's freq.
+	 */
+	if (lower == 0 && dev->config->avg_dependency_threshold) {
+		if (count < dev->config->avg_dependency_threshold)
+			upper = dev->config->avg_dependency_threshold;
+		else
+			lower = dev->config->avg_dependency_threshold;
+	}
 
-	avg = max(dev->avg_count, band);
-	device_writel(dev, avg - band, ACTMON_DEV_AVG_LOWER_WMARK);
+	device_writel(dev, lower, ACTMON_DEV_AVG_LOWER_WMARK);
+	device_writel(dev, upper, ACTMON_DEV_AVG_UPPER_WMARK);
 }
 
 static void tegra_devfreq_update_wmark(struct tegra_devfreq *tegra,
 				       struct tegra_devfreq_device *dev)
 {
-	u32 val = tegra->cur_freq * ACTMON_SAMPLING_PERIOD;
+	unsigned long count = device_readl(dev, ACTMON_DEV_COUNT);
+	unsigned long lower, upper, delta;
 
-	device_writel(dev, do_percent(val, dev->config->boost_up_threshold),
-		      ACTMON_DEV_UPPER_WMARK);
+	/*
+	 * Boosting logic kicks-in once lower / upper watermark is hit.
+	 *
+	 *                  count --------       --- upper delta
+	 *                               v       v
+	 * ...--|OPP N|--|lower|<------->-<--------->|upper|--|OPP N+1|--...
+	 *                          ^        ^
+	 *                          |        |
+	 *             lower delta---        |
+	 *                                   |
+	 * average count somewhere there------
+	 */
+
+	tegra_actmon_get_lower_upper(tegra, dev, count, &lower, &upper);
+
+	/* don't forget to take boosting into account */
+	upper += dev->boost_freq;
+
+	/* the lesser memory activity goes, the harder is boost-down */
+	delta = do_percent(count - lower, dev->config->boost_down_threshold);
+	device_writel(dev, count - delta, ACTMON_DEV_LOWER_WMARK);
 
-	device_writel(dev, do_percent(val, dev->config->boost_down_threshold),
-		      ACTMON_DEV_LOWER_WMARK);
+	/* the higher memory activity goes, the softer is boost-up */
+	delta = do_percent(upper - count, dev->config->boost_up_threshold);
+	device_writel(dev, count + delta, ACTMON_DEV_UPPER_WMARK);
 }
 
 static void actmon_isr_device(struct tegra_devfreq *tegra,
 			      struct tegra_devfreq_device *dev)
 {
-	u32 intr_status, dev_ctrl;
+	u32 intr_status, dev_ctrl, avg_intr_mask;
+	bool low_activity = true;
 
 	dev->avg_count = device_readl(dev, ACTMON_DEV_AVG_COUNT);
-	tegra_devfreq_update_avg_wmark(tegra, dev);
-
 	intr_status = device_readl(dev, ACTMON_DEV_INTR_STATUS);
 	dev_ctrl = device_readl(dev, ACTMON_DEV_CTRL);
 
+	avg_intr_mask = ACTMON_DEV_INTR_AVG_BELOW_WMARK |
+			ACTMON_DEV_INTR_AVG_ABOVE_WMARK;
+
+	if (intr_status & avg_intr_mask)
+		tegra_devfreq_update_avg_wmark(tegra, dev);
+
+	/*
+	 * Instantly cutoff boosting if CPU isn't touching memory nearly
+	 * at all for awhile, this result in a more interactive governing.
+	 *
+	 * MCALL doesn't have the minimum activity threshold.
+	 *
+	 * Note that it's important to disabled boosting before calling
+	 * tegra_devfreq_update_wmark() because it takes boosting into
+	 * account.
+	 */
+	if (dev->config->avg_dependency_threshold &&
+	    dev->avg_count < dev->config->avg_dependency_threshold)
+		dev->boost_freq = 0;
+	else
+		low_activity = false;
+
 	if (intr_status & ACTMON_DEV_INTR_CONSECUTIVE_UPPER) {
 		/*
 		 * new_boost = min(old_boost * up_coef + step, max_freq)
@@ -249,12 +424,10 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
 					     dev->config->boost_up_coeff);
 		dev->boost_freq += ACTMON_BOOST_FREQ_STEP;
 
-		dev_ctrl |= ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
-
-		if (dev->boost_freq >= tegra->max_freq)
+		if (dev->boost_freq >= tegra->max_freq && !low_activity)
 			dev->boost_freq = tegra->max_freq;
-		else
-			dev_ctrl |= ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
+
+		tegra_devfreq_update_wmark(tegra, dev);
 	} else if (intr_status & ACTMON_DEV_INTR_CONSECUTIVE_LOWER) {
 		/*
 		 * new_boost = old_boost * down_coef
@@ -263,19 +436,10 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
 		dev->boost_freq = do_percent(dev->boost_freq,
 					     dev->config->boost_down_coeff);
 
-		dev_ctrl |= ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
-
 		if (dev->boost_freq < (ACTMON_BOOST_FREQ_STEP >> 1))
 			dev->boost_freq = 0;
-		else
-			dev_ctrl |= ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
-	}
 
-	if (dev->config->avg_dependency_threshold) {
-		if (dev->avg_count >= dev->config->avg_dependency_threshold)
-			dev_ctrl |= ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
-		else if (dev->boost_freq == 0)
-			dev_ctrl &= ~ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
+		tegra_devfreq_update_wmark(tegra, dev);
 	}
 
 	device_writel(dev, dev_ctrl, ACTMON_DEV_CTRL);
@@ -283,43 +447,20 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
 	device_writel(dev, ACTMON_INTR_STATUS_CLEAR, ACTMON_DEV_INTR_STATUS);
 }
 
-static unsigned long actmon_cpu_to_emc_rate(struct tegra_devfreq *tegra,
-					    unsigned long cpu_freq)
-{
-	unsigned int i;
-	struct tegra_actmon_emc_ratio *ratio = actmon_emc_ratios;
-
-	for (i = 0; i < ARRAY_SIZE(actmon_emc_ratios); i++, ratio++) {
-		if (cpu_freq >= ratio->cpu_freq) {
-			if (ratio->emc_freq >= tegra->max_freq)
-				return tegra->max_freq;
-			else
-				return ratio->emc_freq;
-		}
-	}
-
-	return 0;
-}
-
-static void actmon_update_target(struct tegra_devfreq *tegra,
-				 struct tegra_devfreq_device *dev)
+static unsigned long actmon_update_target(struct tegra_devfreq *tegra,
+					  struct tegra_devfreq_device *dev)
 {
-	unsigned long cpu_freq = 0;
-	unsigned long static_cpu_emc_freq = 0;
-	unsigned int avg_sustain_coef;
-
-	if (dev->config->avg_dependency_threshold) {
-		cpu_freq = cpufreq_get(0);
-		static_cpu_emc_freq = actmon_cpu_to_emc_rate(tegra, cpu_freq);
-	}
+	unsigned long avg_sustain_coef, target_freq;
 
-	dev->target_freq = dev->avg_count / ACTMON_SAMPLING_PERIOD;
 	avg_sustain_coef = 100 * 100 / dev->config->boost_up_threshold;
-	dev->target_freq = do_percent(dev->target_freq, avg_sustain_coef);
-	dev->target_freq += dev->boost_freq;
 
-	if (dev->avg_count >= dev->config->avg_dependency_threshold)
-		dev->target_freq = max(dev->target_freq, static_cpu_emc_freq);
+	target_freq = dev->avg_count / ACTMON_SAMPLING_PERIOD;
+	target_freq = do_percent(target_freq, avg_sustain_coef);
+	target_freq += dev->boost_freq;
+	target_freq = tegra_actmon_account_cpu_freq(tegra, dev, target_freq,
+						    dev->avg_count);
+
+	return target_freq;
 }
 
 static irqreturn_t actmon_thread_isr(int irq, void *data)
@@ -347,26 +488,53 @@ static irqreturn_t actmon_thread_isr(int irq, void *data)
 	return handled ? IRQ_HANDLED : IRQ_NONE;
 }
 
+static void tegra_actmon_update_watermarks(struct tegra_devfreq *tegra)
+{
+	struct tegra_devfreq_device *dev = tegra->devices;
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++, dev++) {
+		tegra_devfreq_update_avg_wmark(tegra, dev);
+		tegra_devfreq_update_wmark(tegra, dev);
+	}
+}
+
+static void tegra_actmon_delayed_update(struct work_struct *work)
+{
+	struct tegra_devfreq *tegra = container_of(work, struct tegra_devfreq,
+						   update_work);
+	unsigned long previous_freq;
+
+	mutex_lock(&tegra->devfreq->lock);
+
+	previous_freq = tegra->devfreq->previous_freq;
+
+	update_devfreq(tegra->devfreq);
+
+	/*
+	 * CPU freq changed and this may result in a change of a target
+	 * memory  rate, hence the watermarks may need to be updated too
+	 * because they depend on the CPU's freq and interrupt events will
+	 * stop if the watermark's range is now larger than it should be.
+	 */
+	if (tegra->devfreq->previous_freq != previous_freq)
+		tegra_actmon_update_watermarks(tegra);
+
+	mutex_unlock(&tegra->devfreq->lock);
+}
+
 static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
 				       unsigned long action, void *ptr)
 {
-	struct clk_notifier_data *data = ptr;
 	struct tegra_devfreq *tegra;
-	struct tegra_devfreq_device *dev;
-	unsigned int i;
 
-	if (action != POST_RATE_CHANGE)
+	if (action != CPUFREQ_POSTCHANGE)
 		return NOTIFY_OK;
 
 	tegra = container_of(nb, struct tegra_devfreq, rate_change_nb);
 
-	tegra->cur_freq = data->new_rate / KHZ;
-
-	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
-		dev = &tegra->devices[i];
-
-		tegra_devfreq_update_wmark(tegra, dev);
-	}
+	/* notifier runs with a disabled preemption */
+	schedule_work(&tegra->update_work);
 
 	return NOTIFY_OK;
 }
@@ -374,11 +542,10 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
 static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
 					  struct tegra_devfreq_device *dev)
 {
-	u32 val = 0;
-
-	dev->target_freq = tegra->cur_freq;
+	u32 val = 0, target_freq;
 
-	dev->avg_count = tegra->cur_freq * ACTMON_SAMPLING_PERIOD;
+	target_freq = clk_get_rate(tegra->emc_clock) / KHZ;
+	dev->avg_count = target_freq * ACTMON_SAMPLING_PERIOD;
 	device_writel(dev, dev->avg_count, ACTMON_DEV_INIT_AVG);
 
 	tegra_devfreq_update_avg_wmark(tegra, dev);
@@ -403,9 +570,16 @@ static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
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
@@ -413,7 +587,30 @@ static void tegra_actmon_start(struct tegra_devfreq *tegra)
 	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++)
 		tegra_actmon_configure_device(tegra, &tegra->devices[i]);
 
+	/*
+	 * We are estimating CPU's memory bandwidth requirement based on
+	 * amount of memory accesses and system's load, judging by CPU's
+	 * frequency. We also don't want to receive events about CPU's
+	 * frequency transaction when governor is stopped, hence
+	 * notifier is registered dynamically.
+	 */
+	err = cpufreq_register_notifier(&tegra->rate_change_nb,
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
@@ -422,11 +619,13 @@ static void tegra_actmon_stop(struct tegra_devfreq *tegra)
 
 	disable_irq(tegra->irq);
 
-	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
-		device_writel(&tegra->devices[i], 0x00000000, ACTMON_DEV_CTRL);
-		device_writel(&tegra->devices[i], ACTMON_INTR_STATUS_CLEAR,
-			      ACTMON_DEV_INTR_STATUS);
-	}
+	cpufreq_unregister_notifier(&tegra->rate_change_nb,
+				    CPUFREQ_TRANSITION_NOTIFIER);
+
+	cancel_work_sync(&tegra->update_work);
+
+	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++)
+		tegra_actmon_stop_device(&tegra->devices[i]);
 }
 
 static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
@@ -469,13 +668,13 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
 	struct tegra_devfreq_device *actmon_dev;
 	unsigned long cur_freq;
 
-	cur_freq = READ_ONCE(tegra->cur_freq);
+	cur_freq = clk_get_rate(tegra->emc_clock);
 
 	/* To be used by the tegra governor */
 	stat->private_data = tegra;
 
 	/* The below are to be used by the other governors */
-	stat->current_frequency = cur_freq * KHZ;
+	stat->current_frequency = cur_freq;
 
 	actmon_dev = &tegra->devices[MCALL];
 
@@ -486,7 +685,7 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
 	stat->busy_time *= 100 / BUS_SATURATION_RATIO;
 
 	/* Number of cycles in a sampling period */
-	stat->total_time = ACTMON_SAMPLING_PERIOD * cur_freq;
+	stat->total_time = cur_freq / KHZ * ACTMON_SAMPLING_PERIOD;
 
 	stat->busy_time = min(stat->busy_time, stat->total_time);
 
@@ -505,6 +704,7 @@ static int tegra_governor_get_target(struct devfreq *devfreq,
 	struct devfreq_dev_status *stat;
 	struct tegra_devfreq *tegra;
 	struct tegra_devfreq_device *dev;
+	unsigned long dev_target_freq;
 	unsigned long target_freq = 0;
 	unsigned int i;
 	int err;
@@ -520,9 +720,9 @@ static int tegra_governor_get_target(struct devfreq *devfreq,
 	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
 		dev = &tegra->devices[i];
 
-		actmon_update_target(tegra, dev);
+		dev_target_freq = actmon_update_target(tegra, dev);
 
-		target_freq = max(target_freq, dev->target_freq);
+		target_freq = max(target_freq, dev_target_freq);
 	}
 
 	*freq = target_freq * KHZ;
@@ -534,6 +734,7 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
 					unsigned int event, void *data)
 {
 	struct tegra_devfreq *tegra = dev_get_drvdata(devfreq->dev.parent);
+	int ret = 0;
 
 	/*
 	 * Couple device with the governor early as it is needed at
@@ -544,7 +745,7 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
 	switch (event) {
 	case DEVFREQ_GOV_START:
 		devfreq_monitor_start(devfreq);
-		tegra_actmon_start(tegra);
+		ret = tegra_actmon_start(tegra);
 		break;
 
 	case DEVFREQ_GOV_STOP:
@@ -559,11 +760,11 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
 
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
@@ -642,7 +843,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 		return rate;
 	}
 
-	tegra->cur_freq = clk_get_rate(tegra->emc_clock) / KHZ;
 	tegra->max_freq = rate / KHZ;
 
 	for (i = 0; i < ARRAY_SIZE(actmon_device_configs); i++) {
@@ -671,17 +871,12 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, tegra);
 
 	tegra->rate_change_nb.notifier_call = tegra_actmon_rate_notify_cb;
-	err = clk_notifier_register(tegra->emc_clock, &tegra->rate_change_nb);
-	if (err) {
-		dev_err(&pdev->dev,
-			"Failed to register rate change notifier\n");
-		goto remove_opps;
-	}
+	INIT_WORK(&tegra->update_work, tegra_actmon_delayed_update);
 
 	err = devfreq_add_governor(&tegra_devfreq_governor);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to add governor: %d\n", err);
-		goto unreg_notifier;
+		goto remove_opps;
 	}
 
 	tegra_devfreq_profile.initial_freq = clk_get_rate(tegra->emc_clock);
@@ -697,9 +892,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 remove_governor:
 	devfreq_remove_governor(&tegra_devfreq_governor);
 
-unreg_notifier:
-	clk_notifier_unregister(tegra->emc_clock, &tegra->rate_change_nb);
-
 remove_opps:
 	dev_pm_opp_remove_all_dynamic(&pdev->dev);
 
@@ -716,7 +908,6 @@ static int tegra_devfreq_remove(struct platform_device *pdev)
 	devfreq_remove_device(tegra->devfreq);
 	devfreq_remove_governor(&tegra_devfreq_governor);
 
-	clk_notifier_unregister(tegra->emc_clock, &tegra->rate_change_nb);
 	dev_pm_opp_remove_all_dynamic(&pdev->dev);
 
 	reset_control_reset(tegra->reset);
-- 
2.22.0

