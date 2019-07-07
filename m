Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0136617F4
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 00:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbfGGWfv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jul 2019 18:35:51 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36429 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728454AbfGGWft (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jul 2019 18:35:49 -0400
Received: by mail-qt1-f194.google.com with SMTP id z4so12806877qtc.3;
        Sun, 07 Jul 2019 15:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p+2r/O+E4fvVLMNxUO8qZK4WdlrN268i+UKH01Ji1MI=;
        b=X8uspIoSYM48jLCv6CptdUc+JDEoF4OvijWUkQ9RMcZgIzZe+aeJgHcLzSzTz/8Fdf
         2CcSRJA6E8DVtlvf7TdYkVlM/aaHN7y5YbfAjsDMmzq3punQ0GVA1PpzdDLNepttcjXc
         MBcljxrBHuI61no6qQjHRFsaaI3udS/PYU2Nuxpw3R3dpmBC4OY02Rmdg1ilHk7tT5Gq
         3DpipdiiV7AC+Fqfwlg6Bgjm1/rgekeU8yedIUNM+Bxf/fUgObZx84qJ1JpTC5v715tA
         gOkXfgRbDXgJzV6fAKXlQ1SxKL+1d3okZBjmV0W2Er4D2S5eHqz8wfwGFzQBxPAhqMj+
         GBbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p+2r/O+E4fvVLMNxUO8qZK4WdlrN268i+UKH01Ji1MI=;
        b=rWsukh0c18Ba6Fj95AIgkPROo+56uiuvGI28tVPRG6bilrNL6xwjRhk8se1CIWa1kW
         hC7gIJjP45bbJDUsIAw9BoB/vQxBJ0+oiyXoBdvm3Kmolz+Uz2DmdlBvylbVInde2A/y
         Al4H6kAHqFvkEzO/OWjubUegwBHu9BCUT3CcQ1MjUNXZSfka4scUER/v0PYN/ibkk7Ti
         Rbd59s5c2xQqxLBboZOAQe9N+GyX9bizn7FrTqbKUw0gurhtef5m7w9MxxqFlhqsOtUM
         EuYDm+oAar1FPInl/LtPHtkATmfaA+6k8uGno2vlTBjiHSIQNhd8en2K8vM7JymDnKii
         Fviw==
X-Gm-Message-State: APjAAAX1P8gJ08cNhq87zFOl/zADNcKfqUZLErfscXC3C/3YXPyiiTt3
        F4NTys9EZFhJHY0TlCJagwA=
X-Google-Smtp-Source: APXvYqwkzBBxiZBWgjovlFz21cgelqs9FVXG4UTIF9SQUitStZ0cvbkQVcf47vrFK16eq5ZsTw/hHw==
X-Received: by 2002:a05:6214:3a5:: with SMTP id m5mr12364645qvy.7.1562538948728;
        Sun, 07 Jul 2019 15:35:48 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id p4sm6998453qkb.84.2019.07.07.15.35.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 15:35:48 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 21/24] PM / devfreq: tegra30: Synchronize average count on target's update
Date:   Mon,  8 Jul 2019 01:33:00 +0300
Message-Id: <20190707223303.6755-22-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190707223303.6755-1-digetx@gmail.com>
References: <20190707223303.6755-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The average count may get out of sync if interrupt was disabled / avoided
for a long time due to upper watermark optimization, hence it should be
re-synced on each target's update to ensure that watermarks are set up
correctly on EMC rate-change notification and that a correct frequency
is selected for device.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 4d582809acb6..8a674fad26be 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -466,11 +466,41 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
 			      dev->boost_freq, cpufreq_get(0));
 }
 
+static void tegra_devfreq_sync_avg_count(struct tegra_devfreq *tegra,
+					 struct tegra_devfreq_device *dev)
+{
+	u32 avg_count, avg_freq, old_upper, new_upper;
+
+	avg_count = device_readl(dev, ACTMON_DEV_AVG_COUNT);
+	avg_freq = avg_count / ACTMON_SAMPLING_PERIOD;
+
+	old_upper = tegra_actmon_upper_freq(tegra, dev->avg_freq);
+	new_upper = tegra_actmon_upper_freq(tegra, avg_freq);
+
+	/* similar to ISR, see comments in actmon_isr_device() */
+	if (old_upper != new_upper) {
+		dev->avg_freq = avg_freq;
+		dev->boost_freq = 0;
+	}
+}
+
 static unsigned long actmon_update_target(struct tegra_devfreq *tegra,
 					  struct tegra_devfreq_device *dev)
 {
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
+	tegra_devfreq_sync_avg_count(tegra, dev);
+
 	target_freq = min(dev->avg_freq + dev->boost_freq, KHZ_MAX);
 	target_freq = tegra_actmon_account_cpu_freq(tegra, dev, target_freq);
 
-- 
2.22.0

