Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7EEEEEEEE
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2019 23:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389008AbfKDWBR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Nov 2019 17:01:17 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37767 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388640AbfKDWBQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Nov 2019 17:01:16 -0500
Received: by mail-lf1-f65.google.com with SMTP id b20so13460581lfp.4;
        Mon, 04 Nov 2019 14:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0ir9eKbXc6Lss3IzWfP9NOi9af5oEA76jnD0uxcVIaA=;
        b=upNJ9E2jKEUAAb3pTAh964SRIQ//jhLdM2MAyOGmORh7sLTiMZmBSNBk/sIZ+8f2yQ
         W8vwBRe7jIFoG7FRGzZStkDFoojr3rpirz+FlYDXGKlNR4YX54FEQ/gZC0Hmy8sFaTOR
         7HsQNXMHExEnImP+RAjlJbbxZa3sG5i+57U+dDqvYWEhVnkPgsVgNRfYklrx4jx9k/Zh
         dRLpx6kFq/DowueKVfcqZ6WyozjFkehC9g5pvF7yJ2VqlQuEK/dMSBnNfBM1oUNOqotz
         9OwjYsfnydBS5pGCJp5y8dDDqToZZqTWRf4/fwRySumcUOhv8+IMDTIF/OW9aV7yfqbG
         LsTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0ir9eKbXc6Lss3IzWfP9NOi9af5oEA76jnD0uxcVIaA=;
        b=nFd6C8eOjGR7rdCsCIB1O8YMxk+IkXzVj6OAOjkXFVJJQwmv5Im16kRFovbLndpYvx
         tG9ZjOwWg0Y1hTY1FO4527O0TcpMFvqUgb2cpMfrnmkUikDWA0huqiQCVs5WwVBQe+48
         tOvgoxoLS2gcmSSW/KrSIOuyI/zsIlFVUPL5BwXkwdKqsTGQ99S/XVdmIi85VWQbhZlV
         zOnliemiHUZacuIWoCBsA0/DE2yx4OkKkebxX6kPXxxofbQJFgm9yGdSTgY+rEcWS8Ox
         nb4mM5vWrzFf+Fb+t3pBqilSM8fKW2D5VPU/6bmdz0ElN0LORqjw/OYWsdPXr2fzI5EQ
         pBIg==
X-Gm-Message-State: APjAAAXcQnZ1PB8mReYKcYe7pstog15JylC+hJ4qwGoXjYG/fzf/UmS1
        mqAC+h/WgqY3XT9/QsvsXl0=
X-Google-Smtp-Source: APXvYqyi2f0gTy3fSarJeQdztzRxkcb9mXJ3w4lR7MaZJKVMcWZQ9I7l3ogdw8WyZtfaIGANdfz3QA==
X-Received: by 2002:a19:7515:: with SMTP id y21mr17999797lfe.96.1572904873837;
        Mon, 04 Nov 2019 14:01:13 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id g3sm7454669ljj.59.2019.11.04.14.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 14:01:13 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Peter Geis <pgwipeout@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 15/19] PM / devfreq: tegra30: Use kHz units for dependency threshold
Date:   Tue,  5 Nov 2019 00:56:13 +0300
Message-Id: <20191104215617.25544-16-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104215617.25544-1-digetx@gmail.com>
References: <20191104215617.25544-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The dependency threshold designates a memory activity level below which
CPU's frequency isn't accounted. Currently the threshold is given in
"memory cycle" units and that value depends on the polling interval which
is fixed to 12ms in the driver. Later on we'd want to add support for a
variable polling interval and thus the threshold value either needs to be
scaled in accordance to the polling interval or it needs to be represented
in a units that do not depend on the polling interval.

It is nicer to have threshold value being defined independently of the
polling interval, thus this patch converts the dependency threshold units
from "cycle" to "kHz". Having this change as a separate-preparatory patch
will make easier to follow further patches.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 852bde6249c7..3bd920829bfd 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -96,9 +96,10 @@ struct tegra_devfreq_device_config {
 	unsigned int	boost_down_threshold;
 
 	/*
-	 * Threshold of activity (cycles) below which the CPU frequency isn't
-	 * to be taken into account. This is to avoid increasing the EMC
-	 * frequency when the CPU is very busy but not accessing the bus often.
+	 * Threshold of activity (cycles translated to kHz) below which the
+	 * CPU frequency isn't to be taken into account. This is to avoid
+	 * increasing the EMC frequency when the CPU is very busy but not
+	 * accessing the bus often.
 	 */
 	u32		avg_dependency_threshold;
 };
@@ -126,7 +127,7 @@ static const struct tegra_devfreq_device_config actmon_device_configs[] = {
 		.boost_down_coeff = 90,
 		.boost_up_threshold = 27,
 		.boost_down_threshold = 10,
-		.avg_dependency_threshold = 50000,
+		.avg_dependency_threshold = 16000, /* 16MHz in kHz units */
 	},
 };
 
@@ -311,7 +312,6 @@ static unsigned long actmon_device_target_freq(struct tegra_devfreq *tegra,
 	target_freq = dev->avg_count / ACTMON_SAMPLING_PERIOD;
 	avg_sustain_coef = 100 * 100 / dev->config->boost_up_threshold;
 	target_freq = do_percent(target_freq, avg_sustain_coef);
-	target_freq += dev->boost_freq;
 
 	return target_freq;
 }
@@ -322,15 +322,18 @@ static void actmon_update_target(struct tegra_devfreq *tegra,
 	unsigned long cpu_freq = 0;
 	unsigned long static_cpu_emc_freq = 0;
 
-	if (dev->config->avg_dependency_threshold) {
+	dev->target_freq = actmon_device_target_freq(tegra, dev);
+
+	if (dev->config->avg_dependency_threshold &&
+	    dev->config->avg_dependency_threshold <= dev->target_freq) {
 		cpu_freq = cpufreq_quick_get(0);
 		static_cpu_emc_freq = actmon_cpu_to_emc_rate(tegra, cpu_freq);
-	}
 
-	dev->target_freq = actmon_device_target_freq(tegra, dev);
-
-	if (dev->avg_count >= dev->config->avg_dependency_threshold)
+		dev->target_freq += dev->boost_freq;
 		dev->target_freq = max(dev->target_freq, static_cpu_emc_freq);
+	} else {
+		dev->target_freq += dev->boost_freq;
+	}
 }
 
 static irqreturn_t actmon_thread_isr(int irq, void *data)
@@ -396,15 +399,16 @@ static unsigned long
 tegra_actmon_cpufreq_contribution(struct tegra_devfreq *tegra,
 				  unsigned int cpu_freq)
 {
+	struct tegra_devfreq_device *actmon_dev = &tegra->devices[MCCPU];
 	unsigned long static_cpu_emc_freq, dev_freq;
 
+	dev_freq = actmon_device_target_freq(tegra, actmon_dev);
+
 	/* check whether CPU's freq is taken into account at all */
-	if (tegra->devices[MCCPU].avg_count <
-	    tegra->devices[MCCPU].config->avg_dependency_threshold)
+	if (dev_freq < actmon_dev->config->avg_dependency_threshold)
 		return 0;
 
 	static_cpu_emc_freq = actmon_cpu_to_emc_rate(tegra, cpu_freq);
-	dev_freq = actmon_device_target_freq(tegra, &tegra->devices[MCCPU]);
 
 	if (dev_freq >= static_cpu_emc_freq)
 		return 0;
-- 
2.23.0

