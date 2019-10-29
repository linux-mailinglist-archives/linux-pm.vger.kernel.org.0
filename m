Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F39DE92C0
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 23:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbfJ2WGS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Oct 2019 18:06:18 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39771 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727854AbfJ2WGR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Oct 2019 18:06:17 -0400
Received: by mail-lj1-f196.google.com with SMTP id y3so347471ljj.6;
        Tue, 29 Oct 2019 15:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6jNeXCdIkB40fsNYI7aXYlCOpSS5aoyB/Q+LbfZiXKA=;
        b=okOcKW6DZqAlvzAKtYGv5pMOXVZdDIy0Y9TxQ7+8exa2kBhxyKG78nhHzkziYa6p8l
         30HQmoDA5QBtZat/nJbWuMc9yKozi32EVmSmk2DmGHtT/8ntFH+tDMXuQZOnddE2+ir+
         b95PCt/Q/8aNgNSixcaav8JHuglBbQ4xfRu75Qo5nZI+bcHpm0zSmVjlawc0w67P5tpE
         JOqmNpTv4J6Lup68QNX49j+0ksZN6wOrmmD/SeaQuNpNiKX080VefaSKbk41OsATOIst
         2teghnsefXht9JyogUWCxJ/nwPY0vMlZwaJgDq0mvBBE1W7RBa9U26+qiRoOamlUmAfm
         Y/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6jNeXCdIkB40fsNYI7aXYlCOpSS5aoyB/Q+LbfZiXKA=;
        b=hESxfv4GO5kWAczD9V+/ggY3b/bX/G6wT5L5j8bKRfFaaViykSvRLp7fsTO2vw+0z1
         IB9EQyIYQMSUD9ko3JAQuj9Ykw303czQn731/CFYoNjMQxAScgZmPhar7arB9LaSAOIE
         nKBPF6W2K4g6ba5PiwCRWz/jDsq+OXAhnekzpDddzAOUstG2gJo+jSGJhyuV4F8TgO8R
         fzNpe0LgxVYsQuSNCaPdaG+xkFb+EXKN2b6rAXtgz5MpV/kVXZFF3mQWNN1xI21nukLC
         rCY9GPVJp80zsS5YkAQyhVKnorjoThtwUba6armLfcilbwxUIdRu5x6YVNn72NKrd5f3
         CEiw==
X-Gm-Message-State: APjAAAUV756h/CTW0eqtZPIYMB0vtB67yYrGviEFaAeSq4+OuPoCIkP4
        71nPl4g749QyecSggZiMj/o=
X-Google-Smtp-Source: APXvYqxZIYjU5mEffisKUBJPwfJdGqslKU0Q5h+Ob4W9TRW3+VRbh6sn57z1B2THMorioJTzPRWn9A==
X-Received: by 2002:a2e:8e21:: with SMTP id r1mr4206144ljk.81.1572386774973;
        Tue, 29 Oct 2019 15:06:14 -0700 (PDT)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id 12sm51536lje.92.2019.10.29.15.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 15:06:14 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 06/19] PM / devfreq: tegra30: Use kHz units uniformly in the code
Date:   Wed, 30 Oct 2019 01:00:06 +0300
Message-Id: <20191029220019.26773-7-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191029220019.26773-1-digetx@gmail.com>
References: <20191029220019.26773-1-digetx@gmail.com>
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
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 1d22f5239cd5..06c5376a7201 100644
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

