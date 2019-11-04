Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0D8AEEF27
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2019 23:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389401AbfKDWT3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Nov 2019 17:19:29 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41687 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388944AbfKDWBE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Nov 2019 17:01:04 -0500
Received: by mail-lj1-f193.google.com with SMTP id m9so19369751ljh.8;
        Mon, 04 Nov 2019 14:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QriNmcLUT52c0PWl9XCAOvuUeyuuGYT8NGYlPG2RmN8=;
        b=rITuHkgNdE2RiaxYQ+jQXE8w17351TUMhfAxjgzUZqoXp4Gdt5wjTJswkHxZIhCXpD
         STBIuyOLgM8fN3WDmRVA1dX2G6Hb/Rqky3yakDuijpSB2tEcJTwEtKo2S3BYC0E+7jRf
         i9Ygkd6aLquOlCDLomoXNinc2qon8Keq7GDAd4bdAYZc7cMUayGJhMMLsBhzZitSqduq
         m2PdYrH+JG75MyntjtbzweBfg0sfkEdNmrKwvkbAnfeG2I4r4gb0ktzufeUfMDDEbOT5
         7xmGjDjLRBLXOJi1mAYMVZCpRLtdZ+ZrnS4oDNqGZl7TFw2zLsXKu6aBKZdTRl2tQj5S
         Yvqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QriNmcLUT52c0PWl9XCAOvuUeyuuGYT8NGYlPG2RmN8=;
        b=Q97i7jalF5U2DgrIi0ChwaMDu4ApLHma0uIU3ylrBMqnxuWUiUnZ+Tln1KBjyR1lOA
         YIGRneFJnA+HOPcO1ptrQ47Vtz2B3ONME9llFZSeFqaKAGy9eGsXCJnnNnscHWFfbmaj
         F5DpUiJT8Z4l27BlhrsCd3tt5BJz/bv39ZjhRguSeFK58KiiApXvDK/qsXN/QkUU6d68
         H7x/C95ffwRdqpnVsT/yylaUPMsymamfID6RJQKz/0yiD5udlgnaMuAIusBf+p9kqqc1
         V09Wqb5nLsmXiBNydIU1tHBJguy+LDlQn2CK/MEtr1BRI2dfG8wDDGrkGs0GBPc+CbAZ
         vmdA==
X-Gm-Message-State: APjAAAUU7DPa4bPQ1mEnOEb9t5B5OX+M037zDmsp+dKDPLkjbDrnFbsT
        c/JETqfr5+r4ZtV4uLDj9K1GJRPg
X-Google-Smtp-Source: APXvYqxwvIhW+sU2X4l+7sS8n0nLJFbt9HYUO4fqO6OhXtRzNow5UqpvUg/hgz6lepiRR3vG44BToQ==
X-Received: by 2002:a2e:874a:: with SMTP id q10mr20878013ljj.14.1572904862038;
        Mon, 04 Nov 2019 14:01:02 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id g3sm7454669ljj.59.2019.11.04.14.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 14:01:01 -0800 (PST)
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
Subject: [PATCH v9 03/19] PM / devfreq: tegra30: Handle possible round-rate error
Date:   Tue,  5 Nov 2019 00:56:01 +0300
Message-Id: <20191104215617.25544-4-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104215617.25544-1-digetx@gmail.com>
References: <20191104215617.25544-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The EMC clock rate rounding technically could fail, hence let's handle
the error cases properly.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index a0a5f3f7b789..66dfa98d8c6b 100644
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
2.23.0

