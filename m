Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8E8061815
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 00:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfGGWfL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jul 2019 18:35:11 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41179 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727958AbfGGWfK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jul 2019 18:35:10 -0400
Received: by mail-qt1-f195.google.com with SMTP id d17so14851054qtj.8;
        Sun, 07 Jul 2019 15:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jlaXfET5L4G5Q3oIQtoqkvvOO4wQfddYSuicKTgAAs4=;
        b=czl8I5gKhvk++0w3bldmz2Eq/vwY8HztKcv8wW9FTnbwxNtiFcizqR82uXjUTfqlig
         +hQtXM8L0mCju6DNcI/nfEkNCfsSWIzSH7VI3cu8qa6LogDH7i/gQyXYam/MADIfzVPh
         hajAw6LKCUZj3xO3UurFlAAehcWucTx2rjF3uTbHr4uCkbvpkGQarQpNfRaoP52bnEru
         GYrZURTCotI9k9Foq77QAXKcNdZ43d5d0duio1vD5uUVtOrVXIMqb2qVYAwlRKhYds8X
         mbqJMqc2p5RIZr9anaFAUH3b029UwsqrOgcW+ZbLpe9KxBfkkxdaH4AUotf7iDed8cVp
         hDlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jlaXfET5L4G5Q3oIQtoqkvvOO4wQfddYSuicKTgAAs4=;
        b=pZVRXgxqeZSKu7d0YuUFqVz0+LgtZxK48MMfn9YYcNDhsiL58hMMvzgtCTFn9SzxS9
         okJTfEaEYll6jRDof/vVFkQahrU3twGBM+H3vZDf6MEXi4kydBFTFPq3MQy2TEVIRZe5
         Sdc1xOd1Zrt9L3pLeKMKdcoA5hcOgzWOJXgyWZYeBAQjdZeDQyxzalGE6vXxBbKp6kBq
         8lLwXv2adrGENSfTRr/POYYYKiOAWHur+6xqdeKM8C52G6WRQbpncdvzBVOVJDMPmtvK
         b3uexafWaVJvFCFbiRwk+WxVWVAeHtFCAlgikqVsrnNBD1n+W7NwuvkEfZAdbecu5fiM
         Roig==
X-Gm-Message-State: APjAAAU6ZaYMJNVheF5NC2L5SId1n8jM/92frXvjL4eL1jpg4v2ZmfPM
        LfAk1op56pPD5nySddrLbZI=
X-Google-Smtp-Source: APXvYqwlHqqL6FMXYIr2G3oyRdB0MjQ5KfEpKQYzgJhaNraQ8mJW6QYclTmjH6f/+dLaBVRN0AVKPw==
X-Received: by 2002:ac8:26e3:: with SMTP id 32mr8646003qtp.79.1562538909214;
        Sun, 07 Jul 2019 15:35:09 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id p4sm6998453qkb.84.2019.07.07.15.35.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 15:35:08 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/24] PM / devfreq: tegra30: Handle possible round-rate error
Date:   Mon,  8 Jul 2019 01:32:42 +0300
Message-Id: <20190707223303.6755-4-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190707223303.6755-1-digetx@gmail.com>
References: <20190707223303.6755-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The EMC clock rate rounding technically could fail, hence let's handle
the error cases properly.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 5e2b133babdd..5e606ae3f238 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -592,8 +592,8 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	struct tegra_devfreq_device *dev;
 	struct tegra_devfreq *tegra;
 	struct devfreq *devfreq;
-	unsigned long rate;
 	unsigned int i;
+	long rate;
 	int err;
 
 	tegra = devm_kzalloc(&pdev->dev, sizeof(*tegra), GFP_KERNEL);
@@ -650,8 +650,14 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 
 	reset_control_deassert(tegra->reset);
 
-	tegra->max_freq = clk_round_rate(tegra->emc_clock, ULONG_MAX) / KHZ;
+	rate = clk_round_rate(tegra->emc_clock, ULONG_MAX);
+	if (rate < 0) {
+		dev_err(&pdev->dev, "Failed to round clock rate: %ld\n", rate);
+		return rate;
+	}
+
 	tegra->cur_freq = clk_get_rate(tegra->emc_clock) / KHZ;
+	tegra->max_freq = rate / KHZ;
 
 	for (i = 0; i < ARRAY_SIZE(actmon_device_configs); i++) {
 		dev = tegra->devices + i;
@@ -662,6 +668,13 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	for (rate = 0; rate <= tegra->max_freq * KHZ; rate++) {
 		rate = clk_round_rate(tegra->emc_clock, rate);
 
+		if (rate < 0) {
+			dev_err(&pdev->dev,
+				"Failed to round clock rate: %ld\n", rate);
+			err = rate;
+			goto remove_opps;
+		}
+
 		err = dev_pm_opp_add(&pdev->dev, rate, 0);
 		if (err) {
 			dev_err(&pdev->dev, "Failed to add OPP: %d\n", err);
-- 
2.22.0

