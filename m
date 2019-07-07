Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5697617F2
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 00:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbfGGWfn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jul 2019 18:35:43 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39038 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728394AbfGGWfn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jul 2019 18:35:43 -0400
Received: by mail-qk1-f196.google.com with SMTP id i125so11861877qkd.6;
        Sun, 07 Jul 2019 15:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gFvx8CkYt0ydsdQnkr7yH87wB5npz5lZgrQg0UbQ1HE=;
        b=Q4nnIVvSiuBoeWdsQQUTIVNdW3u93vplqqsH8qgbLqVJ4G+Z+AK/sJUm7XUopEwyBj
         44BqnTRgYF8RZHD2GsJcCU54+hHqwvsVUaYM38bU/gs+cqPOBdSFRAxcclsFpYzpUmYy
         716pf35drLvbzBM8EcS+T+fOswFxX5GflbxF2LQcqTCLfQB66r6gZig8LXcDKrpYqV1C
         6nwzrQOWtUta9H5fkvlwmNvSlzq6ipMqkVlVy6Kboa9RMWMqvwejid0pj8KOXJ5jjkpu
         Z6TP67YrUc8NXZD2+jco3THamR+kiIofsLmwXnUN7co9HdO/cLWmrKQ0HPPl3AjB2WB+
         1wWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gFvx8CkYt0ydsdQnkr7yH87wB5npz5lZgrQg0UbQ1HE=;
        b=dNwYMXQ72u6czUXdNGu3phdewWS38QVPUlQ8wwri8xpmEDCpmqgnv8BU/zCC/DFcV7
         BqF9An8ftf3z3C31tR2V2DKvkis5rAP6OvKhpFR1merZugDe8s+mWGbdD8yBWxafKEZq
         39AcS78qZHO9wQZOpYeUOGITJsfdUo0IN3lWjYuOCzZCJv8Jv+VEHHhZX+q91MovnFEk
         eIZgdg3Z6vwyXjW4yuiWzz28AKOVD6L8vkmYyaynJD6zEHTacZxFTDLX8PyKs4kWiOTw
         UYWZl/mhsu7taCdQ/eHhAwYYk3hWnYjZNz5Fi9X/9EwBIGjBB94fG5hrx/qosBPOH/vf
         JgRA==
X-Gm-Message-State: APjAAAUol83KD+aF7b4979bm6NrLwdmvr8Y4v6mrWesvOM/If9CtrG2q
        LwvTZ3RinPZcsPQAP23i918=
X-Google-Smtp-Source: APXvYqybKG7bffLAkgIjC5y3sOJ7d7cZq2hkspavk5Bh//mx/BWy7ZskvA7aPMFI/xpUO8mPg4KaIw==
X-Received: by 2002:a37:5f45:: with SMTP id t66mr11847231qkb.286.1562538942186;
        Sun, 07 Jul 2019 15:35:42 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id p4sm6998453qkb.84.2019.07.07.15.35.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 15:35:41 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 18/24] PM / devfreq: tegra30: Optimize CPUFreq notifier
Date:   Mon,  8 Jul 2019 01:32:57 +0300
Message-Id: <20190707223303.6755-19-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190707223303.6755-1-digetx@gmail.com>
References: <20190707223303.6755-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When CPU's memory activity is low or memory activity is high such that
CPU's frequency contribution to the boosting is not taken into account,
then there is no need to schedule devfreq's update. This eliminates
unnecessary CPU activity during of idling caused by the scheduled work.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 73 +++++++++++++++++++++++++++----
 1 file changed, 64 insertions(+), 9 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 43c9c5fbfe91..8d6bf6e9f1ae 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -216,10 +216,10 @@ static inline unsigned long do_percent(unsigned long val, unsigned int pct)
 	return val * pct / 100;
 }
 
-static unsigned long actmon_cpu_to_emc_rate(struct tegra_devfreq *tegra)
+static unsigned long actmon_cpu_to_emc_rate(struct tegra_devfreq *tegra,
+					    unsigned int cpu_freq)
 {
 	const struct tegra_actmon_emc_ratio *ratio = actmon_emc_ratios;
-	unsigned int cpu_freq = cpufreq_get(0);
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(actmon_emc_ratios); i++, ratio++) {
@@ -239,15 +239,15 @@ tegra_actmon_account_cpu_freq(struct tegra_devfreq *tegra,
 			      struct tegra_devfreq_device *dev,
 			      unsigned long target_freq)
 {
-	unsigned long static_cpu_emc_freq;
+	unsigned long cpu_emc_freq = 0;
 
-	if (dev->config->avg_dependency_threshold &&
-	    dev->config->avg_dependency_threshold < dev->avg_freq) {
-		static_cpu_emc_freq = actmon_cpu_to_emc_rate(tegra);
-		target_freq = max(target_freq, static_cpu_emc_freq);
-	}
+	if (!dev->config->avg_dependency_threshold)
+		return target_freq;
 
-	return target_freq;
+	if (dev->avg_freq > dev->config->avg_dependency_threshold)
+		cpu_emc_freq = actmon_cpu_to_emc_rate(tegra, cpufreq_get(0));
+
+	return max(target_freq, cpu_emc_freq);
 }
 
 static unsigned long tegra_actmon_lower_freq(struct tegra_devfreq *tegra,
@@ -531,16 +531,71 @@ static void tegra_actmon_delayed_update(struct work_struct *work)
 	mutex_unlock(&tegra->devfreq->lock);
 }
 
+static unsigned long
+tegra_actmon_cpufreq_contribution(struct tegra_devfreq *tegra,
+				  unsigned int cpu_freq)
+{
+	unsigned long freq, static_cpu_emc_freq;
+
+	/* check whether CPU's freq is taken into account at all */
+	if (tegra->devices[MCCPU].avg_freq <=
+	    tegra->devices[MCCPU].config->avg_dependency_threshold)
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
 static int tegra_actmon_cpu_notify_cb(struct notifier_block *nb,
 				      unsigned long action, void *ptr)
 {
+	struct cpufreq_freqs *freqs = ptr;
 	struct tegra_devfreq *tegra;
+	unsigned long old, new;
 
 	if (action != CPUFREQ_POSTCHANGE)
 		return NOTIFY_OK;
 
 	tegra = container_of(nb, struct tegra_devfreq, cpu_rate_change_nb);
 
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
 	/*
 	 * CPUFreq driver should support CPUFREQ_ASYNC_NOTIFICATION in order
 	 * to allow asynchronous notifications. This means we can't block
-- 
2.22.0

