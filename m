Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1EEE55DAB
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2019 03:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfFZBfs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 21:35:48 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35867 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbfFZBfK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jun 2019 21:35:10 -0400
Received: by mail-lf1-f68.google.com with SMTP id q26so373559lfc.3;
        Tue, 25 Jun 2019 18:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lr9hct+Hu7BhNIICiHqz94dDspYUGMjB7un5AqOfkn8=;
        b=Ku0oBhc7ox12UpHV0e4vGJO6Na9rBkoowUz034Hz6tMy4JdaY0pPKq+h+FmwNkItCv
         iD1ydpu/izyo1Giwh4q+fBwR54oexPlg/d+V6TJnl1Z7ikQ8CBiDHlK8EorcWecJOHK5
         rLbKqMdVUsuTxYPueC3BoY0TBoFj0YxmNUMIvPbqf8ZGlt6wcdEGk1MSyZWuw/S0CZXg
         NDzcACOMG706RCQB14/uSSu4Qqlu26PHMag115IMHdmN0Z1r534qhVFeS6/6+CnGWlMv
         JkorFEig9VeTO0GFMNSixAiNY0R9I6fttai83g7fpWxXI1BKQZaWyE8yDMTubkGoppSU
         UdxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lr9hct+Hu7BhNIICiHqz94dDspYUGMjB7un5AqOfkn8=;
        b=b2sVZOfuWbfsAZzAPwgZoJ4xwdKabKpPUR/K5/nM+uF2lju4Y2AxzWmO6tYWqjjO4W
         8Zl7vZ2NVMUjOatw5x+aoU1T4lwnnDnu2/P5hR/drdEK+qgMfKW047w2vIPL2WL/pVlh
         OmDJrQgpuPYstySn1fTB1EaheMEiK59CxM/J/GOrCZAbYr3el2bjqMKQc9fcsH/zXdBA
         KVxg8c4UG6bgeuvbsWQvfDW1P6vS0rM0Ua1wttHlnNKhOKi6TuxcwaO6JJ7aX/x6YmE3
         1rXc6Ph3NkzPKUYkmeE8Az3yKwY1mQIip9YG6aUZpNejONRjoomkr2BkWHQXnPY1eyXm
         /2yQ==
X-Gm-Message-State: APjAAAXIKmmT0hFHWq2qz768pQ4ATQ9+hYh03ylAISYPKC3BI33oOXKv
        Nc/XOnjQSh3xn8Wp0qePhJc=
X-Google-Smtp-Source: APXvYqy0n6S1Lj8myiKSxHCEcfEqaPsT++bQniuhf8JpepIqsAk12irADspqX4dTWQ9iShQkKwveSA==
X-Received: by 2002:ac2:4c29:: with SMTP id u9mr933290lfq.100.1561512907742;
        Tue, 25 Jun 2019 18:35:07 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id 199sm2549581ljf.44.2019.06.25.18.35.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 18:35:07 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/17] PM / devfreq: tegra30: Add debug messages
Date:   Wed, 26 Jun 2019 04:32:45 +0300
Message-Id: <20190626013252.30470-12-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190626013252.30470-1-digetx@gmail.com>
References: <20190626013252.30470-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add debug messages to know about what's happening in hardware and how
driver reacts.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 35 +++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 1e704289c129..8ef7ed8d7e10 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -41,6 +41,7 @@
 #define ACTMON_DEV_AVG_UPPER_WMARK				0x10
 #define ACTMON_DEV_AVG_LOWER_WMARK				0x14
 #define ACTMON_DEV_COUNT_WEIGHT					0x18
+#define ACTMON_DEV_COUNT					0x1c
 #define ACTMON_DEV_AVG_COUNT					0x20
 #define ACTMON_DEV_INTR_STATUS					0x24
 
@@ -276,6 +277,9 @@ static void tegra_actmon_get_lower_upper(struct tegra_devfreq *tegra,
 					 unsigned long *lower,
 					 unsigned long *upper)
 {
+	struct device *ddev = tegra->devfreq->dev.parent;
+	u32 offset = dev->config->offset;
+
 	/*
 	 * Memory frequencies are guaranteed to have 1MHz granularity
 	 * and thus we need this rounding down to get a proper watermarks
@@ -288,6 +292,9 @@ static void tegra_actmon_get_lower_upper(struct tegra_devfreq *tegra,
 	*lower = tegra_actmon_lower_freq(tegra, target_freq);
 	*upper = tegra_actmon_upper_freq(tegra, target_freq);
 
+	dev_dbg(ddev, "%03x: target_freq %lu lower freq %lu upper freq %lu\n",
+		offset, target_freq, *lower, *upper);
+
 	*lower /= KHZ;
 	*upper /= KHZ;
 
@@ -367,11 +374,31 @@ static void tegra_devfreq_update_wmark(struct tegra_devfreq *tegra,
 	device_writel(dev, lower + delta, ACTMON_DEV_LOWER_WMARK);
 }
 
+static void actmon_device_debug(struct tegra_devfreq *tegra,
+				struct tegra_devfreq_device *dev,
+				const char *prefix)
+{
+	dev_dbg(tegra->devfreq->dev.parent,
+		"%03x: %s: 0x%08x 0x%08x a %u %u %u c %u %u %u b %lu cpu %u\n",
+		dev->config->offset, prefix,
+		device_readl(dev, ACTMON_DEV_INTR_STATUS),
+		device_readl(dev, ACTMON_DEV_CTRL),
+		device_readl(dev, ACTMON_DEV_AVG_COUNT),
+		device_readl(dev, ACTMON_DEV_AVG_LOWER_WMARK),
+		device_readl(dev, ACTMON_DEV_AVG_UPPER_WMARK),
+		device_readl(dev, ACTMON_DEV_COUNT),
+		device_readl(dev, ACTMON_DEV_LOWER_WMARK),
+		device_readl(dev, ACTMON_DEV_UPPER_WMARK),
+		dev->boost_freq, cpufreq_get(0));
+}
+
 static void actmon_isr_device(struct tegra_devfreq *tegra,
 			      struct tegra_devfreq_device *dev)
 {
 	u32 intr_status, dev_ctrl, avg_intr_mask;
 
+	actmon_device_debug(tegra, dev, "isr+");
+
 	dev->avg_count = device_readl(dev, ACTMON_DEV_AVG_COUNT);
 	intr_status = device_readl(dev, ACTMON_DEV_INTR_STATUS);
 	dev_ctrl = device_readl(dev, ACTMON_DEV_CTRL);
@@ -421,6 +448,8 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
 
 	device_writel(dev, dev_ctrl, ACTMON_DEV_CTRL);
 	device_writel(dev, ACTMON_INTR_STATUS_CLEAR, ACTMON_DEV_INTR_STATUS);
+
+	actmon_device_debug(tegra, dev, "isr-");
 }
 
 static unsigned long actmon_update_target(struct tegra_devfreq *tegra,
@@ -710,6 +739,7 @@ static struct devfreq_dev_profile tegra_devfreq_profile = {
 static int tegra_governor_get_target(struct devfreq *devfreq,
 				     unsigned long *freq)
 {
+	struct device *ddev = devfreq->dev.parent;
 	struct devfreq_dev_status *stat;
 	struct tegra_devfreq *tegra;
 	struct tegra_devfreq_device *dev;
@@ -732,6 +762,11 @@ static int tegra_governor_get_target(struct devfreq *devfreq,
 		dev_target_freq = actmon_update_target(tegra, dev);
 
 		target_freq = max(target_freq, dev_target_freq);
+
+		dev_dbg(ddev, "%03x: upd: dev_target_freq %lu\n",
+			dev->config->offset, dev_target_freq);
+
+		actmon_device_debug(tegra, dev, "upd");
 	}
 
 	*freq = target_freq * KHZ;
-- 
2.22.0

