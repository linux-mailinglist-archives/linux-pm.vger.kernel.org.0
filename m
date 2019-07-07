Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7CB1617F1
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 00:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbfGGWfs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jul 2019 18:35:48 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45707 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728394AbfGGWfr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jul 2019 18:35:47 -0400
Received: by mail-qt1-f196.google.com with SMTP id j19so16215821qtr.12;
        Sun, 07 Jul 2019 15:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1TkF2WBU9NElZA01Xp4NJYKijXcI19FpfWCfadJruP0=;
        b=dAdBPg8uSV1nSvl9Ay0t7M1zJ3AS/akSVQuSlTERVy5FbM5LKCloAxaVCadl5IatuU
         xF4tzI/aOqVIdRXq+XsgfOecAaU28JX96vnmrtu4dvr94m9jv9P/Os9XQJ5X7nz4ahpC
         gh5vgwiOepjIvql9Eav8BBL9kytVdHotLD9bZjeCWsTIRi4mYkPQux0VaHAn8gU5qoq0
         Jv+9xxFHU1lE7jOy4yDTLxunIFpLpjJj6ZaSLmV/sjbXRh7lqMSYUpa7lyhSIDNIKnSW
         GotEV0ciDVr1gzMWTPKBBDMaIiBpXL9g1jdcf3zQ+m0h8YwDcjdVMcJZElhIQlQlxjRb
         clIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1TkF2WBU9NElZA01Xp4NJYKijXcI19FpfWCfadJruP0=;
        b=s123CJGbSR53WOaOXHMv1XUbqB4cIzK2g17AH7DbJ2AYMVAn9hmuwxgjI9s/FYkWGu
         uZrn9g5yYuewvS88pnxjej0+z1XDtSYFMeZ51n1rTWFVCLWUZojtcn9bMsN2l3bFxJLb
         aec+jl6PBJYw0jxsMjXNX2aKQnzEba/7NT+5q62IApQkLwh6njawC4I5kSEW+v0l4y0z
         d9dHwGMmrjJPdvKv6bVGhBqClCCPlMqh/HwAA2H2cZ9YpNjUgLj1QHJtISzFHb0xDLwC
         L1sHA8fPrb+nPph8R2eY3pOxB9cM59IG9yk39iF+sXHZWcoWpTxoih2/YmnbHCEZfWOT
         PiDQ==
X-Gm-Message-State: APjAAAWdXSIxBmRa345h+/uUpcOjRx/laRt4/G2A0PACjZnnuxo/X8Of
        phZG19ySnE18nTP/OADkf+Y=
X-Google-Smtp-Source: APXvYqyEazblWH42R+qns0bFF0ma7PATFp/OANgMzFGSv3TmFVXaWRNS9OVYxu6JtR4xLJjqz66MNw==
X-Received: by 2002:a0c:c3c7:: with SMTP id p7mr12151212qvi.125.1562538946496;
        Sun, 07 Jul 2019 15:35:46 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id p4sm6998453qkb.84.2019.07.07.15.35.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 15:35:46 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 20/24] PM / devfreq: tegra30: Optimize upper average watermark selection
Date:   Mon,  8 Jul 2019 01:32:59 +0300
Message-Id: <20190707223303.6755-21-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190707223303.6755-1-digetx@gmail.com>
References: <20190707223303.6755-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

I noticed that CPU may be crossing the dependency threshold very
frequently for some workloads and this results in a lot of interrupts
which could be avoided if MCALL client is keeping actual EMC frequency
at a higher rate.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index c3cf87231d25..4d582809acb6 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -314,7 +314,8 @@ static void tegra_actmon_get_lower_upper(struct tegra_devfreq *tegra,
 }
 
 static void tegra_devfreq_update_avg_wmark(struct tegra_devfreq *tegra,
-					   struct tegra_devfreq_device *dev)
+					   struct tegra_devfreq_device *dev,
+					   unsigned long freq)
 {
 	unsigned long avg_threshold, lower, upper;
 
@@ -323,6 +324,15 @@ static void tegra_devfreq_update_avg_wmark(struct tegra_devfreq *tegra,
 	avg_threshold = dev->config->avg_dependency_threshold;
 	avg_threshold = avg_threshold * ACTMON_SAMPLING_PERIOD;
 
+	/*
+	 * If cumulative EMC frequency selection is higher than the
+	 * device's, then there is no need to set upper watermark to
+	 * a lower value because it will result in unnecessary upper
+	 * interrupts.
+	 */
+	if (freq * ACTMON_SAMPLING_PERIOD > upper)
+		upper = freq * ACTMON_SAMPLING_PERIOD;
+
 	/*
 	 * We want to get interrupts when MCCPU client crosses the
 	 * dependency threshold in order to take into / out of account
@@ -392,6 +402,7 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
 			      struct tegra_devfreq_device *dev)
 {
 	u32 intr_status, dev_ctrl, avg_intr_mask, avg_count;
+	unsigned long freq;
 
 	trace_device_isr_enter(tegra->regs, dev->config->offset,
 			       dev->boost_freq, cpufreq_get(0));
@@ -405,8 +416,10 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
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
@@ -525,7 +538,7 @@ static int tegra_actmon_clk_notify_cb(struct notifier_block *nb,
 	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
 		dev = &tegra->devices[i];
 
-		tegra_devfreq_update_avg_wmark(tegra, dev);
+		tegra_devfreq_update_avg_wmark(tegra, dev, freq);
 		tegra_devfreq_update_wmark(tegra, dev, freq);
 	}
 
@@ -630,7 +643,7 @@ static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
 	device_writel(dev, dev->avg_freq * ACTMON_SAMPLING_PERIOD,
 		      ACTMON_DEV_INIT_AVG);
 
-	tegra_devfreq_update_avg_wmark(tegra, dev);
+	tegra_devfreq_update_avg_wmark(tegra, dev, dev->avg_freq);
 	tegra_devfreq_update_wmark(tegra, dev, dev->avg_freq);
 
 	device_writel(dev, ACTMON_COUNT_WEIGHT, ACTMON_DEV_COUNT_WEIGHT);
-- 
2.22.0

