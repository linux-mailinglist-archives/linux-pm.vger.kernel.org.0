Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6FCE8942B
	for <lists+linux-pm@lfdr.de>; Sun, 11 Aug 2019 23:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfHKVYk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 11 Aug 2019 17:24:40 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46095 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbfHKVYj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Aug 2019 17:24:39 -0400
Received: by mail-lf1-f68.google.com with SMTP id n19so4570929lfe.13;
        Sun, 11 Aug 2019 14:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1OA59L/PDO/fIoCl0NQYE6ljbPRlOkug9V9TGpbxlIc=;
        b=JUv9lW5njksmaD8ch2/SJNVcVcX8NtbJeEzG840Ig1el7pRWb+UlPcVvtj6DRQgp/O
         WXgKkDtg6sBpi+hwcw0u3FiIvTleXHAuSb8HHWiITJnAOLfCMv2RE91O1mMED8w1xYcC
         GB6sXqHgsrCmj6FR4pKffnLTDuU7oqvwRHiaaFmv/Klm0KAUB4AEgrrExxPrjaSCfu2+
         5qGOzNCTtFOrS/WHvuP0VzsB3vwfKT2xHfsZSTPq5l81vGGsq2F0XONuvJax0wpfgUg5
         Dk79MITunH879dnyGzwvVtAwEooyIZdtLu24DgzKdrVMF/ueEJI9yIv8n2vKmqQf9wBT
         T9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1OA59L/PDO/fIoCl0NQYE6ljbPRlOkug9V9TGpbxlIc=;
        b=AC40eqop6Tekm4ZKovsS1Inn47zldps5nC2Bu7tcuxnX2I2gyjcrJgYO17q/l3VnkB
         tcIHadDtya/y8Q5sV+wgJZY5TvUchRldLdNdR2LFVIje1qMBn9GbNNIy3fSbwQMMNMCp
         1a/WxX/Mn976vez1OvPV6PsCnqsaPq9ASxW1UURHqPwbVZp3+HOJle2GBVNLYqK8KL+w
         TU50vsm0aAFIF+l9nXZjaos3aCofAZtI1FGw6w1QycvNhs08OmNbe1QF25p+BbFO2zmI
         nfmF2pLvCx/rRSukNV2gWjJ5T33gtCKitg7y4DH9r0dWRCHuJ6curerjcrPsbImTQXiP
         TRvg==
X-Gm-Message-State: APjAAAVX30FnIlbIUJ9kONZ7LHE+QO/JS1cRMl1i31KFHNFKzvUXA2Sm
        GzM12pzZiITLfiHgi+Ph7caL7ps6
X-Google-Smtp-Source: APXvYqxjNpeeSLWI0UiOnnxT6EHSg5NjwRTzCnnRQgyc+Pe1MOP/1PoEPTX5sVZQceEoiX5Rx2OgDQ==
X-Received: by 2002:ac2:42cc:: with SMTP id n12mr18145019lfl.47.1565558676793;
        Sun, 11 Aug 2019 14:24:36 -0700 (PDT)
Received: from localhost.localdomain ([94.29.34.218])
        by smtp.gmail.com with ESMTPSA id f1sm20470806ljk.86.2019.08.11.14.24.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 14:24:35 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 03/19] PM / devfreq: tegra30: Handle possible round-rate error
Date:   Mon, 12 Aug 2019 00:22:59 +0300
Message-Id: <20190811212315.12689-4-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190811212315.12689-1-digetx@gmail.com>
References: <20190811212315.12689-1-digetx@gmail.com>
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
index 8be6a33beb9c..bfee9d43de1e 100644
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

