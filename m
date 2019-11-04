Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99C4EEEF22
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2019 23:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388961AbfKDWBH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Nov 2019 17:01:07 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39558 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388954AbfKDWBH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Nov 2019 17:01:07 -0500
Received: by mail-lj1-f195.google.com with SMTP id y3so19415367ljj.6;
        Mon, 04 Nov 2019 14:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T6ehYayj/CsEjREzCecGwtuH1vTkkw6hdLvoIOrkLyE=;
        b=ppDmwC5Xh+v6xV0lSe3C5w7u7se3COpxCCvOTKHZeLdftrQUB7xAkU5gQ/9Ts6JXn/
         WkCYpfUHyaeR0NpQ+q7Ekb2BBLF9FKNLY1yC2g9tcL4gJwihv3uRUEdItTZXzc0rixHB
         5blDcQsLQvnD0bD0VSd8aiJ1oXfAKjQjU0r45SyOPaFRJgZ1O6xr1OScbvsMNBrBEISF
         +CNhmql/yqDD6rjGmthSDNoBaE4weuBTWIkQPbeCQ08bLHQ99cAq5qwBJiBLlNW674Kc
         l1483nQ9IasMUps6mwuwRslbh6RhfNXhlmXo/L1xH1QIAvF9FOkTeRHFZgH2pqEs4kHY
         en5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T6ehYayj/CsEjREzCecGwtuH1vTkkw6hdLvoIOrkLyE=;
        b=FDlOtejpNI8cslEQw7p0pEZfBFmsikiMAxZ/S07XMDsQ6SCDWqnKki3rK/evDgiekl
         Z25IZSVA8acAt0Z02ULwXwOhEYQJBSWEaKcidtvBMHvu1y9YQKjm456T/icwy+ovmIQX
         yy/qf74mOQieEJwj43oFs7aYHApqyIRr9Axy0q/20nA4nCy4SQZEs3JYKwpR6u9Ys9Xy
         g6f3iQHMIBa42w08X0Kdbj0uzwrEtBUDrZt3P8OOEbxewLLADHVQoXWlCaOGmqKQGjbH
         rQYpsSLonsSRQuQHdRfH+WK5bEeQeIkoq+lXX862tcbAGlVqvrkHyAUZRIbxRtqO8EcZ
         rIRQ==
X-Gm-Message-State: APjAAAXraQeXwANxD1uL51eRTgbcuvVQs1LM+wQslxxYXINPxblc1wMH
        KktbYdRL3sGeiIuGty3bjaA=
X-Google-Smtp-Source: APXvYqxA7PwqHWRG0FVsAvqXyx5yQtN5BTKOLrgcrY2Rar5bVjT3XnXYr5FdQdUKncowxUtB6XcjgQ==
X-Received: by 2002:a2e:c51:: with SMTP id o17mr745640ljd.202.1572904865065;
        Mon, 04 Nov 2019 14:01:05 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id g3sm7454669ljj.59.2019.11.04.14.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 14:01:04 -0800 (PST)
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
Subject: [PATCH v9 06/19] PM / devfreq: tegra30: Use kHz units uniformly in the code
Date:   Tue,  5 Nov 2019 00:56:04 +0300
Message-Id: <20191104215617.25544-7-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104215617.25544-1-digetx@gmail.com>
References: <20191104215617.25544-1-digetx@gmail.com>
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

