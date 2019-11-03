Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7C52ED4DF
	for <lists+linux-pm@lfdr.de>; Sun,  3 Nov 2019 21:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbfKCUmL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 Nov 2019 15:42:11 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38339 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728229AbfKCUmK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 Nov 2019 15:42:10 -0500
Received: by mail-lj1-f195.google.com with SMTP id y23so14975145ljc.5;
        Sun, 03 Nov 2019 12:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T6ehYayj/CsEjREzCecGwtuH1vTkkw6hdLvoIOrkLyE=;
        b=Ptgdzv4188nCij+3Y1+uj2V7WEUNb4/7dxYNQWUfW5/EdACAxMbj3dyNfyJZ1tspwk
         4rVRzkSy3P9BqCgtlyU2PF+hoCX06hKqVrz6ii1iyrsoZA2nHnSFoF2Ol10rhQmRCIQG
         SoDiwrEo2nshbpVPwB66QuzA2el9Bl7W5tAU7rtgJ+LjR3NVT5N0PZGIIijARIpm6VXF
         BCz6Bhr+nsWraaLqXeMr6dsDHkNsK3P66yPnSx1g+TniQsdDvVZpX6GrGyq1Wf2WoYLs
         vQlEjkkmcSNgFX4qZZmhgX3i+zlBKqWkj1LkqKbCmUHNvUPy9pYE2cIZIpWVlXTUXPmX
         z3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T6ehYayj/CsEjREzCecGwtuH1vTkkw6hdLvoIOrkLyE=;
        b=SJB+Lahn5HLD+BjI9l5essrxzNfoi8hU2sn+UPvmI86E9CFtt5Rv+clhlfqg7HkEOo
         JARrKRg0cdtyqzVbfzNyOSollxCIt/D0V5WSWNmiZwtTxZMOmPf3JE/Me8YGkv3etzWC
         FQoiM7nwBUrfp7wgbP7WydmBO1+I48x9og+I33ez19MKgdLvTYL9vuFHDlz5fAahbz14
         d1Klw5Mcq1gHgEN95LBrH/pr+ZT+rsp/sFlS8DnjFCfmXxuwuQqocf7wfc1e8ywkmOCe
         D/xn/K0s/fieem8oJ47hg8vBO76xK3WfOETP1ykhk03ltRLHLbekCxpXLITuNyTrQabk
         BsvQ==
X-Gm-Message-State: APjAAAVn/P4JRTVWiMirKOTiC8q8mpxqkgsLOTY7cLJeAe2rf00LO60p
        FEhLChQKYQ+LcGNreJcHr9M=
X-Google-Smtp-Source: APXvYqzv42KLMu8jlJL0jhswKJbINknrWxI1NCCkixsiBipoWEE1FReIAwTejtTyjUDIWZYq5MS9nQ==
X-Received: by 2002:a2e:9a95:: with SMTP id p21mr12344939lji.175.1572813728080;
        Sun, 03 Nov 2019 12:42:08 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id e22sm7099853ljg.73.2019.11.03.12.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 12:42:07 -0800 (PST)
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
Subject: [PATCH v8 06/18] PM / devfreq: tegra30: Use kHz units uniformly in the code
Date:   Sun,  3 Nov 2019 23:41:18 +0300
Message-Id: <20191103204130.2172-7-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191103204130.2172-1-digetx@gmail.com>
References: <20191103204130.2172-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Part of the code uses Hz units and the other kHz, let's switch to kHz
everywhere for consistency. A small benefit from this change (besides
code's cleanup) is that now powertop utility correctly displays devfreq's
stats, for some reason it expects them to be in kHz.

Tested-by: Peter Geis <pgwipeout@gmail.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 7d7b7eecc19c..9ccde64be0a0 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -448,7 +448,7 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
 	rate = dev_pm_opp_get_freq(opp);
 	dev_pm_opp_put(opp);
 
-	err = clk_set_min_rate(tegra->emc_clock, rate);
+	err = clk_set_min_rate(tegra->emc_clock, rate * KHZ);
 	if (err)
 		return err;
 
@@ -477,7 +477,7 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
 	stat->private_data = tegra;
 
 	/* The below are to be used by the other governors */
-	stat->current_frequency = cur_freq * KHZ;
+	stat->current_frequency = cur_freq;
 
 	actmon_dev = &tegra->devices[MCALL];
 
@@ -527,7 +527,7 @@ static int tegra_governor_get_target(struct devfreq *devfreq,
 		target_freq = max(target_freq, dev->target_freq);
 	}
 
-	*freq = target_freq * KHZ;
+	*freq = target_freq;
 
 	return 0;
 }
@@ -663,7 +663,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 			goto remove_opps;
 		}
 
-		err = dev_pm_opp_add(&pdev->dev, rate, 0);
+		err = dev_pm_opp_add(&pdev->dev, rate / KHZ, 0);
 		if (err) {
 			dev_err(&pdev->dev, "Failed to add OPP: %d\n", err);
 			goto remove_opps;
@@ -686,7 +686,8 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 		goto unreg_notifier;
 	}
 
-	tegra_devfreq_profile.initial_freq = clk_get_rate(tegra->emc_clock);
+	tegra_devfreq_profile.initial_freq = tegra->cur_freq;
+
 	devfreq = devfreq_add_device(&pdev->dev, &tegra_devfreq_profile,
 				     "tegra_actmon", NULL);
 	if (IS_ERR(devfreq)) {
-- 
2.23.0

