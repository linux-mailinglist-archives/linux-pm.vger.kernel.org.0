Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD8184FEAD
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2019 03:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfFXBv1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Jun 2019 21:51:27 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39180 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfFXBv1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Jun 2019 21:51:27 -0400
Received: by mail-lj1-f195.google.com with SMTP id v18so10906114ljh.6;
        Sun, 23 Jun 2019 18:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nYRS9MdYmFFWPAiEhPZWw0w+9h3W9S26RozsmwY92Y0=;
        b=DCITDwuX98eZYywKaF/pbpnW5bIW/EDVriGnq9GO16ZrW41YmdlOJSlLQgdnbVUjld
         4eBdf/qjEQiyJZd0xJDSx2mwt4AsJd9zC8rXoXQ1e/R/raissCfOloEeT6T0ocmTuGle
         ZeekxnpMbt64xoey0x4v2IIlT9ZMRHrIeKKk2dVIT2uk7y/OTrOFVMGfK1er5ANXlmhJ
         6sHLDaoLEz1bMOg/BrmnDbtQykqZ8ythYr2Wji9UN0WMf5pBgfW69mkudbswaHTgjPRU
         D1zAkQBpWTEUkokbCv7npcIZgB0g5qB1uMeRYzNHbC/Xed7eelrW9tikjrs1O1Nr10Y0
         P/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nYRS9MdYmFFWPAiEhPZWw0w+9h3W9S26RozsmwY92Y0=;
        b=O8plqKYa6l3EszuZPaKos7QxYuH12R3fpx/sA0hbL9zylX5z/UCKQEud3NYwTJYt5S
         jCGF8I9db2xQ9g1l1ey7Gvei3BQz7PQEy7J6W+XDlfy+G/qz0A1KmB5dT69+L6e2gVQC
         a2QLySgertTXBfB2j2CVnMKXi4TOuM0o0bLqQViM3MvyoBPkr1/d4MvxLmi15yuOHenI
         a/xq6ZnavD18kA0/ogpdm01fpJMfNjtTYdzqqhlfD0xAQnMdJqbHmdZ0M75K2XJRop1+
         Lna33DXunrLIhd82Q7cjW4Mz9rmEAcm+wPUOTK5ZCGSe3w6NTobniGc0eKIAdN5KAxBR
         Dygw==
X-Gm-Message-State: APjAAAXQ4XRHMYROF/CG3IR5vecugS0wLho7rPntPlEqDgnDYDwi4R3H
        sQt1iq7JfTEnEfIc6u2eKXewq2fv
X-Google-Smtp-Source: APXvYqyc6zd1A7+jfFcgBuyYeoPiDicRsI/iIka3Ng3nzxm60bZJocNHEwfvzNCFK6/5dhzUzmW0fQ==
X-Received: by 2002:a2e:3c1a:: with SMTP id j26mr33315913lja.230.1561326525033;
        Sun, 23 Jun 2019 14:48:45 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id m17sm1460029lfb.9.2019.06.23.14.48.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jun 2019 14:48:44 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 10/11] PM / devfreq: tegra30: Add debug messages
Date:   Mon, 24 Jun 2019 00:46:57 +0300
Message-Id: <20190623214658.11680-11-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190623214658.11680-1-digetx@gmail.com>
References: <20190623214658.11680-1-digetx@gmail.com>
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
 drivers/devfreq/tegra30-devfreq.c | 33 +++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 168bfe78e525..452bc10d2d72 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -277,6 +277,8 @@ static void tegra_actmon_get_lower_upper(struct tegra_devfreq *tegra,
 					 unsigned long *lower,
 					 unsigned long *upper)
 {
+	struct device *ddev = tegra->devfreq->dev.parent;
+	u32 offset = dev->config->offset;
 	unsigned long target_freq, min;
 
 	target_freq = count / ACTMON_SAMPLING_PERIOD * KHZ;
@@ -312,6 +314,9 @@ static void tegra_actmon_get_lower_upper(struct tegra_devfreq *tegra,
 	else
 		*upper = tegra_actmon_upper_freq(tegra, target_freq);
 
+	dev_dbg(ddev, "%03x: target_freq %lu lower freq %lu upper freq %lu\n",
+		offset, target_freq, *lower, *upper);
+
 	*lower /= KHZ;
 	*upper /= KHZ;
 
@@ -384,12 +389,32 @@ static void tegra_devfreq_update_wmark(struct tegra_devfreq *tegra,
 	device_writel(dev, count + delta, ACTMON_DEV_UPPER_WMARK);
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
 	bool low_activity = true;
 
+	actmon_device_debug(tegra, dev, "isr+");
+
 	dev->avg_count = device_readl(dev, ACTMON_DEV_AVG_COUNT);
 	intr_status = device_readl(dev, ACTMON_DEV_INTR_STATUS);
 	dev_ctrl = device_readl(dev, ACTMON_DEV_CTRL);
@@ -451,6 +476,8 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
 	device_writel(dev, dev_ctrl, ACTMON_DEV_CTRL);
 
 	device_writel(dev, ACTMON_INTR_STATUS_CLEAR, ACTMON_DEV_INTR_STATUS);
+
+	actmon_device_debug(tegra, dev, "isr-");
 }
 
 static unsigned long actmon_update_target(struct tegra_devfreq *tegra,
@@ -737,6 +764,7 @@ static struct devfreq_dev_profile tegra_devfreq_profile = {
 static int tegra_governor_get_target(struct devfreq *devfreq,
 				     unsigned long *freq)
 {
+	struct device *ddev = devfreq->dev.parent;
 	struct devfreq_dev_status *stat;
 	struct tegra_devfreq *tegra;
 	struct tegra_devfreq_device *dev;
@@ -759,6 +787,11 @@ static int tegra_governor_get_target(struct devfreq *devfreq,
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

