Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 165635001F
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2019 05:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfFXDRE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Jun 2019 23:17:04 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45665 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfFXDRE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Jun 2019 23:17:04 -0400
Received: by mail-lj1-f196.google.com with SMTP id m23so11009176lje.12;
        Sun, 23 Jun 2019 20:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KuK/HJBB+sabov/uStjAYnZLIz/87lFFGThs8FI3mQo=;
        b=ADKaGoys8uZe39G6vzOfMQxp52ANy6A8hq08yILdHzRwsJVTh+iQef/bZ0c7nOSR2g
         AGya6G9fkSdH5RxY+V2hNNkAWm6Wz7mQSGtpYlh6K6DcKTipdnO24viU0h37W5p/GZoo
         G+Xa3l7M30vhz8jLJBsgDfLfXZ1Vd74dhbSODGuaEYXX/XYe0ZyQ8fe96Mj8XozKbzL9
         brIlGizU9frPWEfQ6XONvPJ5UFx8t0dOJ9sp/QktoVRpc9M1P5gghU45p1kAplBoUxng
         48iancZgoiCC2wH8EBvGh5ln1UnY1Ld4ynmRtCFmmF4bpddAsss6Pn8dZ5VeakjnnKXY
         aFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KuK/HJBB+sabov/uStjAYnZLIz/87lFFGThs8FI3mQo=;
        b=QX/X5Y6hAf4mNd+OAT9F5NFxcQH1bdwgEr35Rwnqcmx+dKbE6SapsPvyFXiLzR/6IP
         RSZDvKUncIRK3MQKqoc7ABeX4vleUtW9vgDh3kMe9oE9Oci66gCIm5T460gX3dquVEUC
         pNxFOXOp0dIGo9beU2qJnkq29YamrEBWuTwazT8pCP7EGwj19BCdrHkZYMkjYWff5rlw
         l9gxawyBfXz/buInfe8sF35xcCuww4KwQvYPJcfjD1vu+Won/yip09AdKVnWCzkLseNn
         V7p5RvM8UdcOr5P2N+Q8SpTyQUNjTRYm0OBAU95DVHc8SsDs2J8RYmrAYuV7leW6HQoU
         v+zg==
X-Gm-Message-State: APjAAAUUqmXpIl0s4JDyN7AkVCjLgvezuRZwY530mIsWcN/8Ot1GNRfY
        FwQ8TP6VUwpwKGgn39gahw/tyXBa
X-Google-Smtp-Source: APXvYqy5wejoCrg2EumLvR8/AjNLGElfUZlXldTgYEiYg4AcGai9CAXpJIsQcoAxhNsF+F1yekcT7w==
X-Received: by 2002:a2e:959a:: with SMTP id w26mr33411080ljh.150.1561326522191;
        Sun, 23 Jun 2019 14:48:42 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id m17sm1460029lfb.9.2019.06.23.14.48.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jun 2019 14:48:41 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 07/11] PM / devfreq: tegra30: Reset boosting if clock rate changed
Date:   Mon, 24 Jun 2019 00:46:54 +0300
Message-Id: <20190623214658.11680-8-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190623214658.11680-1-digetx@gmail.com>
References: <20190623214658.11680-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is a situation when memory activity is going up, hence boosting up
starts to happen, and then governor ramps memory clock rate up. In this
case consecutive events may be stopped if new "COUNT" is within watermarks
range, meanwhile old boosting value remains, which is plainly wrong and
results in unneeded "go down" events after ramping up. In a result of this
change unnecessary interrupts activity goes even lower.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index fc278f2f1b62..6fb3ca125438 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -631,6 +631,24 @@ static void tegra_actmon_stop(struct tegra_devfreq *tegra)
 		tegra_actmon_stop_device(&tegra->devices[i]);
 }
 
+static void tegra_actmon_stop_boosting(struct tegra_devfreq *tegra)
+{
+	struct tegra_devfreq_device *dev = tegra->devices;
+	unsigned int i;
+	u32 dev_ctrl;
+
+	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++, dev++) {
+		if (!dev->boost_freq)
+			continue;
+
+		dev_ctrl = device_readl(dev, ACTMON_DEV_CTRL);
+		dev_ctrl &= ~ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
+		device_writel(dev, dev_ctrl, ACTMON_DEV_CTRL);
+
+		dev->boost_freq = 0;
+	}
+}
+
 static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
 				u32 flags)
 {
@@ -656,6 +674,16 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
 	if (err)
 		goto restore_min_rate;
 
+	/*
+	 * Hence boosting-up could be active at the moment of the rate-change
+	 * and in this case boosting should be reset because it doesn't relate
+	 * to the new state. If average won't follow shortly in a case of going
+	 * UP, then clock rate will drop back on next update due to the missed
+	 * boosting.
+	 */
+	if (rate != devfreq->previous_freq)
+		tegra_actmon_stop_boosting(tegra);
+
 	return 0;
 
 restore_min_rate:
-- 
2.22.0

