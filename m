Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1CA58CBE
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2019 23:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfF0VMi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jun 2019 17:12:38 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44764 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbfF0VMh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jun 2019 17:12:37 -0400
Received: by mail-lj1-f194.google.com with SMTP id k18so3769083ljc.11;
        Thu, 27 Jun 2019 14:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ipb6n9YkTNtFlFpFTuwt8+O2jfr86EGSOnnMq4sKQ5w=;
        b=Kfcwg+UitddN4/m98nYzqKtIJIK37ycyZrvXSRxao1oN0Js5zubWSpST4nRczH0u6l
         gwubHDBDb0R9Iv6ECV3sYwivlhLOYsByL3M9/ykBtD0lKMDrYP5bEoxODDiGkYj1KXIY
         W3Pwof0c/eP0vOcusE3NMfenYo7SpYX3Raa7wA0amX1857rPSWk3K6Qbr5whLDuF7J6x
         vt8d9lsy2N0PmBzTm4pjHIljeEiPP/a3R4aM8xyCgQY/POB/RR/R7nohX94MwudDyNuY
         S/AfvuZPBcakrgPVyB8uYqxE8B2yJ+ZbjvKtT9TEwd7Cr+gBYMAyfD+ocy7ymIGt7xVV
         ZVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ipb6n9YkTNtFlFpFTuwt8+O2jfr86EGSOnnMq4sKQ5w=;
        b=kfYKYg9kaMlu95v9wTuFZQdR/UDjB7fHxFHN+IlqghaZJlAF4A+XWIFKIjokh3wDhG
         LE/JspwbEqOR5WjrXoURuQHStUY/pEhMua6I3wMawcdzD5n/uiMWcuDw3leM16KOoOFj
         5Jz0oE35mE/CP6PAnyFsKjcFywNI9BYszG+SiFGYgoElQaXIQWG6l3RxACuoq1+cDtLH
         Srw/jlu3fgC/Su4ORpgA2wnkwCMaQueIM7i4buOwRMEQOmC58KxnTQzVS5j3ykAurhVj
         LHW3vDsDzRKfeS86c1gSrsX43a2Mxti0QKWDkvSDoNf2CC6YwdOkEi3lykHDoQP+5qmG
         G6Ig==
X-Gm-Message-State: APjAAAWYGapAGtzkcpZguhy7XBPtRaXvT+DeFx9zE7gBXSZ21+VTsbzP
        PX9m6SP83dUMu2BhvgUu1vY=
X-Google-Smtp-Source: APXvYqwp8np4KNoQosM69NR5sRaGyVdJLbwDsKQf2/hBP6Dq4cb6jgQ2pSYEYnoNX2dQllxJv7Nl3g==
X-Received: by 2002:a2e:5b0f:: with SMTP id p15mr3902667ljb.82.1561669955132;
        Thu, 27 Jun 2019 14:12:35 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id p29sm30485ljp.87.2019.06.27.14.12.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 14:12:34 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/22] PM / devfreq: tegra30: Add debug messages
Date:   Fri, 28 Jun 2019 00:11:04 +0300
Message-Id: <20190627211115.21138-12-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190627211115.21138-1-digetx@gmail.com>
References: <20190627211115.21138-1-digetx@gmail.com>
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
index 65f0363dbf1b..47a47be276ee 100644
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
@@ -711,6 +740,7 @@ static struct devfreq_dev_profile tegra_devfreq_profile = {
 static int tegra_governor_get_target(struct devfreq *devfreq,
 				     unsigned long *freq)
 {
+	struct device *ddev = devfreq->dev.parent;
 	struct devfreq_dev_status *stat;
 	struct tegra_devfreq *tegra;
 	struct tegra_devfreq_device *dev;
@@ -733,6 +763,11 @@ static int tegra_governor_get_target(struct devfreq *devfreq,
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

