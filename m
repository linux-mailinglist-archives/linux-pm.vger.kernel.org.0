Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 475B87ADC1
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 18:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732869AbfG3Qcf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 12:32:35 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33057 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732844AbfG3Qcf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2019 12:32:35 -0400
Received: by mail-wm1-f67.google.com with SMTP id h19so45683016wme.0;
        Tue, 30 Jul 2019 09:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VR4VQoyRWVM0Kw8sF0Cq63P0RsRTjzSwRUSf5aLb+kM=;
        b=MWE4WW8GNN3YtmUCKPM0OyJFHS8jupaKtDda+b3Uj95xUzLJgurNgANypEL54gNyio
         ddnvMzR1dY71YuA2PIZGG1l3UedhYG9nsI6RBn+HPxr5ltmqoQK/mVaqecsDLL/8rej5
         JEYdjN00M/8nvXhGjWGK3qGcd/LD/jAhgp78jzM927eSM2M40M+Azbl0HK/0fFsJKce2
         OOuUzyAVuhaym7EH7fq7yg9nSNCmfhPGdghXEriDXbeMfFgwGKElExWiEWO0xYMYQkvh
         gFeqksUm/XZJpoVLyE+vbx1J1GUprQsnkbhP4fABHW0M5PSBsalyd/quHlSO4txaOBLW
         8Tjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VR4VQoyRWVM0Kw8sF0Cq63P0RsRTjzSwRUSf5aLb+kM=;
        b=QmjdEELPb67CB34z7GNCqfaWVajbUSc73326fxo5VFqDX8UqZtmX9DB1AUen8CEk3n
         MAIcKfbOIkq92bDSgkmfg8aQDlVK0lF9KdwxRzmPmYJ9+sgZ4eIAebDoHKObd7aUtl3m
         gqSFsRGXiQbfIo93iTHQdYWKkZHb8axOYQr+GUK5m87HS0GpRVgoUjNncNW38SaJs9Kw
         jNE4skek1vaJfoIAP1sM6lJmEJIXcYTNN8qLyFiRp/XxgcosXe2UBXng+SMe+sflFH7h
         gY01SbNQOeY0TmV8satbPm3agAdAQgK/tyhW1q7uLLyt1cAswDWuygqnxDxSw24WSUO7
         QUkw==
X-Gm-Message-State: APjAAAW9a2cHKZ+dmqmOoo/BWN0EDGiiGgg8hnyJ/ht89HSxrKCJAejH
        qYHJjTmKiuzLH+wQMv4KLPw=
X-Google-Smtp-Source: APXvYqyvc3G94+KKmdSDAPS3KKe4j7pACWN9X3kiv6FnPGmP+xR5AVtwWZXy0qPOPVzPrLyrZEuQhw==
X-Received: by 2002:a1c:7c11:: with SMTP id x17mr39389104wmc.22.1564504351727;
        Tue, 30 Jul 2019 09:32:31 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id c65sm64835175wma.44.2019.07.30.09.32.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 09:32:31 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 10/20] PM / devfreq: tegra30: Reduce unnecessary interrupts activity
Date:   Tue, 30 Jul 2019 19:22:26 +0300
Message-Id: <20190730162236.6063-11-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730162236.6063-1-digetx@gmail.com>
References: <20190730162236.6063-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There are cases where unnecessary ACTMON interrupts could be avoided,
like when one memory client device requests higher clock rate than the
other or when clock rate is manually limited using sysfs devfreq
parameters. These cases could be avoided by tuning upper watermark or
disabling hardware events when min/max boosting thresholds are reached.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 87 ++++++++++++++++++++++++++++---
 1 file changed, 80 insertions(+), 7 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 43d50b4366dd..a2623de56d20 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -312,7 +312,8 @@ static void tegra_actmon_get_lower_upper(struct tegra_devfreq *tegra,
 }
 
 static void tegra_devfreq_update_avg_wmark(struct tegra_devfreq *tegra,
-					   struct tegra_devfreq_device *dev)
+					   struct tegra_devfreq_device *dev,
+					   unsigned long freq)
 {
 	unsigned long avg_dependency_freq, lower, upper;
 
@@ -320,6 +321,22 @@ static void tegra_devfreq_update_avg_wmark(struct tegra_devfreq *tegra,
 
 	avg_dependency_freq = tegra_actmon_dev_avg_dependency_freq(tegra, dev);
 
+	/*
+	 * If cumulative EMC frequency selection (MCALL / min_freq) is
+	 * higher than the device's, then there is no need to set upper
+	 * watermark to a lower value because it will result in unnecessary
+	 * upper interrupts.
+	 *
+	 * Note that average watermarks are also updated after EMC
+	 * clock rate change, hence if clock rate goes down, then the
+	 * watermarks will be set in accordance to the new rate after
+	 * changing the rate. There are other ways to achieve the same
+	 * result, but this one is probably the least churning, although
+	 * it may look a bit convoluted.
+	 */
+	if (freq * ACTMON_SAMPLING_PERIOD > upper)
+		upper = freq * ACTMON_SAMPLING_PERIOD;
+
 	/*
 	 * We want to get interrupts when MCCPU client crosses the
 	 * dependency threshold in order to take into / out of account
@@ -361,7 +378,18 @@ static void tegra_devfreq_update_wmark(struct tegra_devfreq *tegra,
 	tegra_actmon_get_lower_upper(tegra, dev, freq - 1, &lower, &upper);
 
 	delta = do_percent(upper - lower, dev->config->boost_up_threshold);
-	device_writel(dev, lower + delta, ACTMON_DEV_UPPER_WMARK);
+
+	/*
+	 * The memory events count could go a bit higher than the maximum
+	 * defined by the OPPs, hence make the upper watermark infinitely
+	 * high to avoid unnecessary upper interrupts in that case.
+	 */
+	if (freq == tegra->max_freq)
+		upper = ULONG_MAX;
+	else
+		upper = lower + delta;
+
+	device_writel(dev, upper, ACTMON_DEV_UPPER_WMARK);
 
 	/*
 	 * Meanwhile the lower mark is based on the average value
@@ -379,6 +407,7 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
 			      struct tegra_devfreq_device *dev)
 {
 	u32 intr_status, dev_ctrl, avg_intr_mask, avg_count;
+	unsigned long freq;
 
 	intr_status = device_readl(dev, ACTMON_DEV_INTR_STATUS);
 	avg_count = device_readl(dev, ACTMON_DEV_AVG_COUNT);
@@ -389,8 +418,10 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
 	avg_intr_mask = ACTMON_DEV_INTR_AVG_BELOW_WMARK |
 			ACTMON_DEV_INTR_AVG_ABOVE_WMARK;
 
-	if (intr_status & avg_intr_mask)
-		tegra_devfreq_update_avg_wmark(tegra, dev);
+	if (intr_status & avg_intr_mask) {
+		freq = clk_get_rate(tegra->emc_clock) / KHZ;
+		tegra_devfreq_update_avg_wmark(tegra, dev, freq);
+	}
 
 	if (intr_status & ACTMON_DEV_INTR_CONSECUTIVE_UPPER) {
 		/*
@@ -412,6 +443,8 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
 		dev->boost_freq = do_percent(dev->boost_freq,
 					     dev->config->boost_down_coeff);
 
+		dev_ctrl |= ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
+
 		if (dev->boost_freq < (ACTMON_BOOST_FREQ_STEP >> 1))
 			dev->boost_freq = 0;
 	}
@@ -427,8 +460,16 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
 	}
 
 	/* no boosting => no need for consecutive-down interrupt */
-	if (dev->boost_freq == 0)
+	if (dev->boost_freq == 0) {
 		dev_ctrl &= ~ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
+		dev_ctrl |= ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
+	}
+
+	/* boosting max-out => no need for consecutive-up interrupt */
+	if (dev->boost_freq == tegra->max_freq) {
+		dev_ctrl &= ~ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
+		dev_ctrl |= ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
+	}
 
 	device_writel(dev, dev_ctrl, ACTMON_DEV_CTRL);
 	device_writel(dev, ACTMON_INTR_STATUS_CLEAR, ACTMON_DEV_INTR_STATUS);
@@ -437,8 +478,40 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
 static unsigned long actmon_update_target(struct tegra_devfreq *tegra,
 					  struct tegra_devfreq_device *dev)
 {
+	u32 avg_count, avg_freq, old_upper, new_upper, dev_ctrl;
 	unsigned long target_freq;
 
+	/*
+	 * The avg_count / avg_freq is getting snapshoted on device's
+	 * interrupt, but there are cases where actual value need to
+	 * be utilized on target's update, like CPUFreq boosting and
+	 * overriding the min freq via /sys/class/devfreq/devfreq0/min_freq
+	 * because we're optimizing the upper watermark based on the
+	 * actual EMC frequency. This means that interrupt may be
+	 * inactive for a long time and thus making snapshoted value
+	 * outdated.
+	 */
+	avg_count = device_readl(dev, ACTMON_DEV_AVG_COUNT);
+	avg_freq = avg_count / ACTMON_SAMPLING_PERIOD;
+
+	old_upper = tegra_actmon_upper_freq(tegra, dev->avg_freq);
+	new_upper = tegra_actmon_upper_freq(tegra, avg_freq);
+
+	/* similar to ISR, see comments in actmon_isr_device() */
+	if (old_upper != new_upper) {
+		if (dev->boost_freq == tegra->max_freq) {
+			dev_ctrl = device_readl(dev, ACTMON_DEV_CTRL);
+
+			dev_ctrl &= ~ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
+			dev_ctrl |= ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
+
+			device_writel(dev, dev_ctrl, ACTMON_DEV_CTRL);
+		}
+
+		dev->avg_freq = avg_freq;
+		dev->boost_freq = 0;
+	}
+
 	target_freq = dev->avg_freq + dev->boost_freq;
 	target_freq = tegra_actmon_account_cpu_freq(tegra, dev, target_freq);
 
@@ -506,7 +579,7 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
 	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
 		dev = &tegra->devices[i];
 
-		tegra_devfreq_update_avg_wmark(tegra, dev);
+		tegra_devfreq_update_avg_wmark(tegra, dev, freq);
 		tegra_devfreq_update_wmark(tegra, dev, freq);
 	}
 
@@ -522,7 +595,7 @@ static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
 	device_writel(dev, dev->avg_freq * ACTMON_SAMPLING_PERIOD,
 		      ACTMON_DEV_INIT_AVG);
 
-	tegra_devfreq_update_avg_wmark(tegra, dev);
+	tegra_devfreq_update_avg_wmark(tegra, dev, dev->avg_freq);
 	tegra_devfreq_update_wmark(tegra, dev, dev->avg_freq);
 
 	device_writel(dev, ACTMON_COUNT_WEIGHT, ACTMON_DEV_COUNT_WEIGHT);
-- 
2.22.0

