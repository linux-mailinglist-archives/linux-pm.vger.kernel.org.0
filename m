Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3D62A6AAE
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 17:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731435AbgKDQwG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 11:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731631AbgKDQuM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 11:50:12 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF43C0613D3;
        Wed,  4 Nov 2020 08:50:12 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id d24so23660308ljg.10;
        Wed, 04 Nov 2020 08:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+L0AgvSgV5zDZENr7ejMUrE6rVWnjdgbzZcfj8MC1EU=;
        b=aaTnuWIBAYS6ZP47JBoKRlAsA772cm0hBjPv5pmD2n/04rtLXynK4/jbMzXYWIdbfj
         ECtqSozu0pCQb/R+fw6CjFP7fapfZhOOS2wJK6cwhfLgWTGZ8aw5+mmoFtF/wXi0sX4G
         SPVXVdYyjVL0XzK1YHCtaMTyrq21NFCoHd2x7iYe6NPEZf4uGGIacsKCuOXxLSPrKlkZ
         o9uGZE9fyP6/KvhsBlBC/NN6NBkQdxagl7eI6Nn9fTOVPuK3RIFX8vJ0Cb161CANu7mU
         a98rRJiNKa4z8ehr/FUT5T27M77a3ZVyopRMqrVfkwTwJaBQtZRbACG2L/IlDDOCAcvO
         r6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+L0AgvSgV5zDZENr7ejMUrE6rVWnjdgbzZcfj8MC1EU=;
        b=kY+Bm1LP58STV6MQqQH7Mm/FI/FamGwq0hqRNQkQdcXYQ5oah+Lk63wrsqqXbqqLN6
         GIOackBkw/jQiBF2VVBQCmyFtxPQVb6Tufg2Yea7zd99K8ZsLFzVh6jYkvNElP1b2PeL
         vEQT4c1uUjXG1NFzDnWU+dRh6pAZ6I/jiE8T2yZCuKvCByR7PTQecSBcSYIZ40f9q5yd
         S1+8qh0IIWw1098kPk/cyFgkITpf+32qJnZZRrcin/rjsXcT/TB+H8zAG0xRPkGNnHYK
         S75kXdxz6L55p693JBiqwzTVgVC6+YUuTRaR+Q9oTT9m7KxjdTsMVjC3lO43A8Feqea7
         ZSUw==
X-Gm-Message-State: AOAM532f46sOkDwPghb8KdytZsSE3DnBVz5W86D9EtWKb7MFp1EuqYz/
        dPmEtGz9S2wp6u4tXHcq+98=
X-Google-Smtp-Source: ABdhPJzeadT0yI0FNCvFtGTGtufHtqnn4HTJnoQtVHPu3f+CnHkT3aKeYE1g2GZ5oC149b6TW41ZFQ==
X-Received: by 2002:a2e:b04a:: with SMTP id d10mr193119ljl.85.1604508610928;
        Wed, 04 Nov 2020 08:50:10 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id m2sm454587lfo.25.2020.11.04.08.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:50:10 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v7 34/47] memory: tegra20-emc: Continue probing if timings are missing in device-tree
Date:   Wed,  4 Nov 2020 19:49:10 +0300
Message-Id: <20201104164923.21238-35-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104164923.21238-1-digetx@gmail.com>
References: <20201104164923.21238-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

EMC driver will become mandatory after turning it into interconnect
provider because interconnect users, like display controller driver, will
fail to probe using newer device-trees that have interconnect properties.
Thus make EMC driver to probe even if timings are missing in device-tree.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra20-emc.c | 34 ++++++++++++++----------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index 88619e3ec435..a49658d217a7 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -383,6 +383,11 @@ tegra_emc_find_node_by_ram_code(struct device *dev)
 	u32 value, ram_code;
 	int err;
 
+	if (of_get_child_count(dev->of_node) == 0) {
+		dev_info(dev, "device-tree doesn't have memory timings\n");
+		return NULL;
+	}
+
 	if (!of_property_read_bool(dev->of_node, "nvidia,use-ram-code"))
 		return of_node_get(dev->of_node);
 
@@ -451,6 +456,9 @@ static long emc_round_rate(unsigned long rate,
 	struct tegra_emc *emc = arg;
 	unsigned int i;
 
+	if (!emc->num_timings)
+		return clk_get_rate(emc->clk);
+
 	min_rate = min(min_rate, emc->timings[emc->num_timings - 1].rate);
 
 	for (i = 0; i < emc->num_timings; i++) {
@@ -656,36 +664,26 @@ static int tegra_emc_probe(struct platform_device *pdev)
 	struct tegra_emc *emc;
 	int irq, err;
 
-	/* driver has nothing to do in a case of memory timing absence */
-	if (of_get_child_count(pdev->dev.of_node) == 0) {
-		dev_info(&pdev->dev,
-			 "EMC device tree node doesn't have memory timings\n");
-		return 0;
-	}
-
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(&pdev->dev, "please update your device tree\n");
 		return irq;
 	}
 
-	np = tegra_emc_find_node_by_ram_code(&pdev->dev);
-	if (!np)
-		return -EINVAL;
-
 	emc = devm_kzalloc(&pdev->dev, sizeof(*emc), GFP_KERNEL);
-	if (!emc) {
-		of_node_put(np);
+	if (!emc)
 		return -ENOMEM;
-	}
 
 	emc->clk_nb.notifier_call = tegra_emc_clk_change_notify;
 	emc->dev = &pdev->dev;
 
-	err = tegra_emc_load_timings_from_dt(emc, np);
-	of_node_put(np);
-	if (err)
-		return err;
+	np = tegra_emc_find_node_by_ram_code(&pdev->dev);
+	if (np) {
+		err = tegra_emc_load_timings_from_dt(emc, np);
+		of_node_put(np);
+		if (err)
+			return err;
+	}
 
 	emc->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(emc->regs))
-- 
2.27.0

