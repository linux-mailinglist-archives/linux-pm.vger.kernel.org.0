Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 927F661802
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 00:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbfGGWf2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jul 2019 18:35:28 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46427 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728167AbfGGWf1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jul 2019 18:35:27 -0400
Received: by mail-qt1-f196.google.com with SMTP id h21so14059827qtn.13;
        Sun, 07 Jul 2019 15:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GZ96cU5HmVV0tuL41y22oWuoLKod2s58C7+TO/6oSIs=;
        b=bzCwVILkXkLPQr7G9owqFb/CujCyPJYv83lKqkyFeGOFb93UTssrZogzuaTtQ7zaJN
         sqlyqP8FGhKgWo9psaXWqXe+Eoil0ewLDkKgYk8kI//zTI59Z7DfSD3RhRWP6iLP0GXt
         Hm544UmyPLRHnARCmCYupkq6ctTMTgbuFM9ABVlZJ4cSFs5/+SD8jZ271n5RON/Oc9sY
         GOpZAH1tYeUZZ5/n5Az9RR51cWF4ORrvEGZCBxPt38wiGOcEdQXAI8CItmQA0k3xCxWb
         5XtPIlKqzeANGmUgAv6+quuxbMv5orcgsTE02Uy33oPBH9kzq5/nlb9s5D5gspJUEq3S
         8rRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GZ96cU5HmVV0tuL41y22oWuoLKod2s58C7+TO/6oSIs=;
        b=lmEQ/E+0jZFicPieLBOQOUB1NOc7zG5ahGR/uO5r5jyriTgoUVpeZD+/qykHYyp2xi
         ETiGOKKSGVxP8+z2n3iKjVf9aEx76G/ZDZOMMuVU+/WdhuFul328qAouSSh3BZkh49Vr
         bY3I+CuykwImOmarx0lOE4K6RYeNhkw7E7foMt09nVqkpDfNpJJYh2/ZajRMfEehvHGE
         jGlQhOkd49TAWUC5kys32fHZpyWFU20mLc0kfjH1QYLSRlVQX7JiL+nHfakOIyCH09Of
         2Wekup+r+2AqsMIk47Qfs20Qbmq0rp82f5/VPxBgApUXS0FJAY4Gq4BTvkMInkJmpM8s
         9Nug==
X-Gm-Message-State: APjAAAW6RCUuk2hixCQ/sSkeTmi13ZwiIRGCxa79/pGFNGD2at66Irj7
        zhZ7+gv7Ziyv6GMCfs3ao7A=
X-Google-Smtp-Source: APXvYqyMQtUrKV07BcXhuvpVU7NrK+8bdE8chNiCIrhqZTbt2gWmtjSYyq8rQIltT3OcJZ1nmTOvhA==
X-Received: by 2002:a0c:c68d:: with SMTP id d13mr12403746qvj.145.1562538926823;
        Sun, 07 Jul 2019 15:35:26 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id p4sm6998453qkb.84.2019.07.07.15.35.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 15:35:26 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 11/24] PM / devfreq: tegra30: Add debug messages
Date:   Mon,  8 Jul 2019 01:32:50 +0300
Message-Id: <20190707223303.6755-12-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190707223303.6755-1-digetx@gmail.com>
References: <20190707223303.6755-1-digetx@gmail.com>
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
index 878c9396bb8c..c6c4a07d3e07 100644
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
@@ -422,6 +449,8 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
 
 	device_writel(dev, dev_ctrl, ACTMON_DEV_CTRL);
 	device_writel(dev, ACTMON_INTR_STATUS_CLEAR, ACTMON_DEV_INTR_STATUS);
+
+	actmon_device_debug(tegra, dev, "isr-");
 }
 
 static unsigned long actmon_update_target(struct tegra_devfreq *tegra,
@@ -712,6 +741,7 @@ static struct devfreq_dev_profile tegra_devfreq_profile = {
 static int tegra_governor_get_target(struct devfreq *devfreq,
 				     unsigned long *freq)
 {
+	struct device *ddev = devfreq->dev.parent;
 	struct devfreq_dev_status *stat;
 	struct tegra_devfreq *tegra;
 	struct tegra_devfreq_device *dev;
@@ -734,6 +764,11 @@ static int tegra_governor_get_target(struct devfreq *devfreq,
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

