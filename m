Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D364455DBE
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2019 03:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfFZBgQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 21:36:16 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34230 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfFZBfC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jun 2019 21:35:02 -0400
Received: by mail-lj1-f195.google.com with SMTP id p17so438047ljg.1;
        Tue, 25 Jun 2019 18:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jlaXfET5L4G5Q3oIQtoqkvvOO4wQfddYSuicKTgAAs4=;
        b=d76iGYySwJ0HbA4wCBB+K32trR9n3aJVDFZN2YnYjGSzsm0e64Yz8n4bH8W1a3K1r6
         A9wfrE4tYzEjpJ8AGFSFj2hZ9bOZ+P0scmxD1GmUkdnnl13j5YMvdT1xWxkgvc8pttMv
         jDgQVoNzo1gFIuPCaub+3RLOgs0ZpCgO5Vk4et4p8dxvtr78hh0dDeIdDMo+y8bcfQdh
         82vBcb/8XTcIll5nRHMhAdD5UFxK22tl2arG0TR2R92afEZdKpNwVO14ZmIv/szULp7M
         9uwtfEAgAIo+XHJsnOf6vtH9ae5ELJPJp04AP3pVL1BVI+R/K3ZVrIzf9CyMkMcy35JM
         EsGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jlaXfET5L4G5Q3oIQtoqkvvOO4wQfddYSuicKTgAAs4=;
        b=XIQA/X4MdkpgklrCuGejBzxk+BXJ6Cq7nl6OY6wOvkORe0LTL0mJckZtbjmpMhBDDL
         wXt9KLmVYYUnE1qXOWQzZgUNLbLm4NtrBTOMwnsIqJIh3lMgtBSs05+OGMiZAIvBa7VV
         I978Y2Mb8bAzc5MdcWL//p+oD55VaEvd6LiPLq3NxMBmzX0LpXBIdR5dbGFBCEbFOMM9
         DuwNmOA2CjDxj7PwxBjmOdiyuCvFiWaRF/cHawai4A9KSYqK8jQePgBxmFo8Fl8Bvk5N
         cWojvF1DheMDBcq9IiAiIkETpnu+R524jZ8lDkiGPgpsf8cKDIaKgm/U9S2GAgFDkN62
         IMDQ==
X-Gm-Message-State: APjAAAU6dmpppXIMZ8MIySm5xdR5yY9gnshSRvRzz62MOtRtLSbvpS34
        szZYU6X/8dRe/Im7NB6W5vA=
X-Google-Smtp-Source: APXvYqzZI/OpEA23RBsypoJZPODUG/O5VXeaDl28dauVTNmrLDwEX4dDM3FyHgwoNcQhAlXZ0S5Hug==
X-Received: by 2002:a2e:9788:: with SMTP id y8mr879030lji.41.1561512899879;
        Tue, 25 Jun 2019 18:34:59 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id 199sm2549581ljf.44.2019.06.25.18.34.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 18:34:59 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/17] PM / devfreq: tegra30: Handle possible round-rate error
Date:   Wed, 26 Jun 2019 04:32:37 +0300
Message-Id: <20190626013252.30470-4-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190626013252.30470-1-digetx@gmail.com>
References: <20190626013252.30470-1-digetx@gmail.com>
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

