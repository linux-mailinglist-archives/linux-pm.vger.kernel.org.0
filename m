Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45E50E92C5
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 23:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbfJ2WGO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Oct 2019 18:06:14 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41290 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727668AbfJ2WGO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Oct 2019 18:06:14 -0400
Received: by mail-lj1-f195.google.com with SMTP id m9so331645ljh.8;
        Tue, 29 Oct 2019 15:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iVf1oDyu1FQjjrrM7m4NSrBwi5WqkrNIMJBlsp+WqzE=;
        b=EAa4L3MmX6btBf14CAgUFPVAPFHuPudPuCeVIK1RBkr4u2aK8Qz5likVaP8yZyB+PC
         K/dhX/8rx56l7VGVZWW8sDJv6tsJoZxVXSvRZfGhFk3M5/rD2M6Z0gPdDx7vtLk8zlsV
         Bre5vq/GuaSGwrVJn2dJ66KiwyfuvUDFNRp9V7Aj3RndxUBj3OM7jsuobNjOo/rNddDb
         UjT9TIwuTgcWmkzK2QuD4hnRZtmAVpRFTs61W9gNZ/HHuCoZo+UBvvB1QR9e21rUTKTh
         QGThhnzXCdPsyNP9VZ/DW9wSG/ViM5HSVkuvV+qPFadHNg8pdq/0hn6bDiGKrS0ZJ5iR
         HccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iVf1oDyu1FQjjrrM7m4NSrBwi5WqkrNIMJBlsp+WqzE=;
        b=m2b9ObHcgO86PzENiVypWW8dTBJLWTYxFEdy5hqnm10xXOvS+fczeWkLLgOXRihLkA
         yTJ3nlr/pCQQSuUQVJ/OV+1t5wKZB4o2m2Yo6MFS/Zy0LnyWERtng4owsQqN9IWjCewX
         ZMVnI5cEmp6AdlwKoNMebD5zaY1Vp0iqzRMtvjzq+VEJhgoR3HvvQs6kMq2lZoCbIhjZ
         RuUj4MOg3cYGA/rU4z8/1JIW2M/UkAtGGvMrPCWNDILA3U095OZjYQcetQsB+NpSoB8j
         n7Hr4JQZynS+aDS2SLwj/J057l7b/wnYv3w43UmEJmLQHJcxgk/FlOzvDEkDN3Wuisi4
         GQfQ==
X-Gm-Message-State: APjAAAXMC43sfFVoYJulfOMd5+L5SF2BhM7fHe4Wq5QqD+k/7ZaoaGgK
        L43QscdP8MzRSZAQdiOzb5Y=
X-Google-Smtp-Source: APXvYqyahn5+T+B85sU2RSOuiCnbCppnvFyVzlgp7moXP/6uE1vUFzrVarRHZATyokreSqRV9oCS3Q==
X-Received: by 2002:a2e:9e4c:: with SMTP id g12mr4227050ljk.62.1572386772100;
        Tue, 29 Oct 2019 15:06:12 -0700 (PDT)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id 12sm51536lje.92.2019.10.29.15.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 15:06:11 -0700 (PDT)
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
Subject: [PATCH v7 03/19] PM / devfreq: tegra30: Handle possible round-rate error
Date:   Wed, 30 Oct 2019 01:00:03 +0300
Message-Id: <20191029220019.26773-4-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191029220019.26773-1-digetx@gmail.com>
References: <20191029220019.26773-1-digetx@gmail.com>
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
2.23.0

