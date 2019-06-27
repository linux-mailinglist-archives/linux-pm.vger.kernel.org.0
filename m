Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D16758CCA
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2019 23:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfF0VNk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jun 2019 17:13:40 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35482 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfF0VMe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jun 2019 17:12:34 -0400
Received: by mail-lj1-f193.google.com with SMTP id x25so3830062ljh.2;
        Thu, 27 Jun 2019 14:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rT7WusTkaDJX5d485Q/wjdPqyYnk7xVmJC7ThwbYLvQ=;
        b=BjHQSOhnPMN2IzuF6BigNtpNFN2OZ6oskaZT2KbQaEKttawWLN3iCHYXm8FNCJc2Ul
         c3+nWAm0VnLRDaKS0lf81PwIFgsj8SYWUVeKjnsMjHYge24/VOedb/5uWxO4MdmE0tjO
         n1UqWrxLtgYnLoW7JH+3dYcHGrMrbp0kTieya5qUHvryW1WFc9FzgumuqopTpx3an1ud
         hLzVKqDhV0s5z/YBIcX6dTJc83VLrFdu/NizmTUoPvPJ0z/N+RO2fNkW2gIWQWi3MA+a
         z3EhrnFJAbEPE3jt5g01IHM5GO0VVdYPy8NfvJDKQcbgegGwIVBZGw6RIKW2UvoK1PkG
         /rBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rT7WusTkaDJX5d485Q/wjdPqyYnk7xVmJC7ThwbYLvQ=;
        b=BZ6R7+dIpLJWOaUGgc0u+VOqqI3BmWbjxYO9zzvCwI6jiao/IG2LnIywjSMr4JxAKV
         4ftVyRFFdpEEpwhUXIMEnVcAbcy+ILWACb9jbfwS3HgaBFDcuUbU+pY9W/i/kC2Z824Z
         aAQIpy9HmSx4W1ioQYugZcCvmZ65kSlbWqylU6/exv25L1WyR/mviKhsC+Ma9nHGB3Xj
         xpB4edTBefJfHxZJ84culMxWRKuV0ZM5/xCB8GENxoaLSm0K0i+j5zN0fRmeBzvKa23d
         hDxH5/z6UOlqzyW4sjjIcCQM93GDPdH6fw8AvZIC4HPs3gpcgtOFgEXsYPra0mLwRXfc
         3TeQ==
X-Gm-Message-State: APjAAAVLAG28IXePHnDXjZLaCpLbOpjqkzeLCcQ6rZZDNioE7KVsYzcs
        +2RvnONSqgHp6ot6ulw6t+g=
X-Google-Smtp-Source: APXvYqwDgv3KAF9i0NI5S46sVYk/lj6hJM7WW1477x0EE0zHybpmyH3N1ykbIpihCThr+7+ZW4vtyQ==
X-Received: by 2002:a2e:9dc1:: with SMTP id x1mr3977399ljj.0.1561669951819;
        Thu, 27 Jun 2019 14:12:31 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id p29sm30485ljp.87.2019.06.27.14.12.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 14:12:31 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/22] PM / devfreq: tegra30: Move clk-notifier's registration to governor's start
Date:   Fri, 28 Jun 2019 00:11:01 +0300
Message-Id: <20190627211115.21138-9-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190627211115.21138-1-digetx@gmail.com>
References: <20190627211115.21138-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is no point in receiving of the notifications while governor is
stopped, let's keep them disabled like we do for the CPU freq-change
notifications. This also fixes a potential use-after-free bug if
notification happens after device's removal.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 33 ++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 502511ac4602..1751d17f9a1c 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -575,6 +575,19 @@ static int tegra_actmon_start(struct tegra_devfreq *tegra)
 	actmon_writel(tegra, ACTMON_SAMPLING_PERIOD - 1,
 		      ACTMON_GLB_PERIOD_CTRL);
 
+	/*
+	 * CLK notifications are needed in order to reconfigure the upper
+	 * consecutive watermark in accordance to the actual clock rate
+	 * to avoid unnecessary upper interrupts.
+	 */
+	err = clk_notifier_register(tegra->emc_clock,
+				    &tegra->clk_rate_change_nb);
+	if (err) {
+		dev_err(tegra->devfreq->dev.parent,
+			"Failed to register rate change notifier\n");
+		return err;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++)
 		tegra_actmon_configure_device(tegra, &tegra->devices[i]);
 
@@ -601,6 +614,8 @@ static int tegra_actmon_start(struct tegra_devfreq *tegra)
 	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++)
 		tegra_actmon_stop_device(&tegra->devices[i]);
 
+	clk_notifier_unregister(tegra->emc_clock, &tegra->clk_rate_change_nb);
+
 	return err;
 }
 
@@ -617,6 +632,8 @@ static void tegra_actmon_stop(struct tegra_devfreq *tegra)
 
 	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++)
 		tegra_actmon_stop_device(&tegra->devices[i]);
+
+	clk_notifier_unregister(tegra->emc_clock, &tegra->clk_rate_change_nb);
 }
 
 static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
@@ -861,22 +878,14 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, tegra);
 
+	tegra->clk_rate_change_nb.notifier_call = tegra_actmon_clk_notify_cb;
 	tegra->cpu_rate_change_nb.notifier_call = tegra_actmon_cpu_notify_cb;
 	INIT_WORK(&tegra->update_work, tegra_actmon_delayed_update);
 
-	tegra->clk_rate_change_nb.notifier_call = tegra_actmon_clk_notify_cb;
-	err = clk_notifier_register(tegra->emc_clock,
-				    &tegra->clk_rate_change_nb);
-	if (err) {
-		dev_err(&pdev->dev,
-			"Failed to register rate change notifier\n");
-		goto remove_opps;
-	}
-
 	err = devfreq_add_governor(&tegra_devfreq_governor);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to add governor: %d\n", err);
-		goto unreg_notifier;
+		goto remove_opps;
 	}
 
 	tegra_devfreq_profile.initial_freq = clk_get_rate(tegra->emc_clock);
@@ -892,9 +901,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 remove_governor:
 	devfreq_remove_governor(&tegra_devfreq_governor);
 
-unreg_notifier:
-	clk_notifier_unregister(tegra->emc_clock, &tegra->clk_rate_change_nb);
-
 remove_opps:
 	dev_pm_opp_remove_all_dynamic(&pdev->dev);
 
@@ -911,7 +917,6 @@ static int tegra_devfreq_remove(struct platform_device *pdev)
 	devfreq_remove_device(tegra->devfreq);
 	devfreq_remove_governor(&tegra_devfreq_governor);
 
-	clk_notifier_unregister(tegra->emc_clock, &tegra->clk_rate_change_nb);
 	dev_pm_opp_remove_all_dynamic(&pdev->dev);
 
 	reset_control_reset(tegra->reset);
-- 
2.22.0

