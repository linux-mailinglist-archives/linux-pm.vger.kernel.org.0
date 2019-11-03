Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13306ED4D9
	for <lists+linux-pm@lfdr.de>; Sun,  3 Nov 2019 21:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbfKCUmH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 Nov 2019 15:42:07 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42817 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727551AbfKCUmH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 Nov 2019 15:42:07 -0500
Received: by mail-lj1-f194.google.com with SMTP id n5so4359308ljc.9;
        Sun, 03 Nov 2019 12:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QriNmcLUT52c0PWl9XCAOvuUeyuuGYT8NGYlPG2RmN8=;
        b=kCDk9f7xEip6MeGHEgLyD8cQViJUFB/SVw4Rubeavm1a02dJGNqT/tZMot1gOaLTr6
         lharTHfNWNwLVLbexwJWGdhBcQzXJTLQK/nH41A3XeIrMGdMrkjRWKfFExJcHPIe97+g
         UiJ+VCEoQ+0VSm1iT0Ioh1dLXhC2VroFkbpOA9JtFsfnwLTPuOyr6hAutIO3FOH3b7AP
         wM+yyCfWJ4vEv22R76exGgbbMl4aLnX3lebT0NDdGqjGIQYDPBnEpxObRcfCxe6DIBl1
         J9yFxTVRL7yfBrreGCld5xTUZCNldWf1bFarHjBc+NuB7ohpbOYUHguf6fo4HwLCAywI
         D60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QriNmcLUT52c0PWl9XCAOvuUeyuuGYT8NGYlPG2RmN8=;
        b=sHhJKrroQRqqbyW3et9UOyiC7x3EUFZZPd2VsUIZhIhxoOsKRtmD8Za9cXo+Owzdxs
         78lzBT0b+Kh++TYCI5zDsAf7+bBvVCy+svvLOaU1KqLWNqID8/n+GByVW3lq/L6pyejm
         avhNJ0vrhtalJ8eLN7GypBardI4dLgAlFK2+11eGZxdGvFAGmZ6el+3S7c0FAQsMi78p
         cXxgk3mwfvDTFRJ1VFR3diXphqQFMhuG7BNvplwAT9yU1XjFHae4NhysUNpwOrWGSD8k
         2btX1qvpTNrEFyuS9qa1w8E7RoYmtHiyVB9NgDgQZ6Dwhk5Os7RCwtuDHrgabGromSOT
         O+9A==
X-Gm-Message-State: APjAAAWOsfOjGX19R5wk3TtMKB9d57dmvDMXVF3mL+mne1r345Nqn2Gu
        SC0NOq0L7U+xapqbfUHcm2I=
X-Google-Smtp-Source: APXvYqzxA2LguehKpphJlozORkBCFa9kiG3ef0U95Nzq2/UE2nIP7Ug+YNuBKiSc/3Sew45phR6rdg==
X-Received: by 2002:a05:651c:28a:: with SMTP id b10mr15511570ljo.124.1572813725246;
        Sun, 03 Nov 2019 12:42:05 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id e22sm7099853ljg.73.2019.11.03.12.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 12:42:04 -0800 (PST)
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
Subject: [PATCH v8 03/18] PM / devfreq: tegra30: Handle possible round-rate error
Date:   Sun,  3 Nov 2019 23:41:15 +0300
Message-Id: <20191103204130.2172-4-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191103204130.2172-1-digetx@gmail.com>
References: <20191103204130.2172-1-digetx@gmail.com>
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

