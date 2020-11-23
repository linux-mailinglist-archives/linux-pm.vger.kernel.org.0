Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DED392BFD7D
	for <lists+linux-pm@lfdr.de>; Mon, 23 Nov 2020 01:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgKWAbS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 22 Nov 2020 19:31:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgKWAbR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Nov 2020 19:31:17 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227CEC0613CF;
        Sun, 22 Nov 2020 16:31:17 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id u18so21416127lfd.9;
        Sun, 22 Nov 2020 16:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wD654qs0k//gW+67LA4ZZp/K3+FDPI5u/Ahc0zUQPLo=;
        b=nmzXQTBSItX6nvR/ymQPcHulpl/uluIocXFTViVY4SBvamuAiAs0yXnHmv+x+kNhYd
         ZJ0NC0wqLlXFrSzo6YSu4PhkuIqfQM2wvV/tm07css+e6ayxe5riMQKkmjG0J/MmhrgU
         p/C5+4SWOY3pGzaekXX3GiEXyvv1v8PkVzZZ3Il1bdpJdZBkcBPt8vxVHy0dr657cdZq
         bQLPYd/Q5gr0qzeFHMg37igAHuUR0FGNHSK2aPsys39F7bhoHMIUmijt0A6tW3lEkhzj
         f88uuVoffgBqRf0DcWL5KMmRF0oSAQP67BT3P2Elu/vflED1G3HqNLNhLgV9unjhqoIi
         46oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wD654qs0k//gW+67LA4ZZp/K3+FDPI5u/Ahc0zUQPLo=;
        b=UHNbtRhERhIK83ToDsR/DCXQ74LnDuTV6kjNhiq59V40hmkYPmHcqNvR3edgCQtNQP
         wkrMBno88eeFaapj8l4C3j0AWBe6zo68ZKICx9nQqpPHNygl21bsftfGuWwTWHtONvCx
         4sAbM5kwuZC7zxE9oOX0WYaDv2MgT8jnXEj6udzJ/73SYKtk7iTZuV7TiaAv6Zdhi5cP
         qkopKExaYE0PPlYxDB62Kzq59kKC+gziNTOJFkAosWy49d6LusDBv/MBs0mOVKn33c0a
         Zl5Ka+0BKEl0o290ohFf6A0R8DSyT5IXbPBg3O/beeHr6dowhlwgh5wefVAxA7ga9Yw4
         j5fQ==
X-Gm-Message-State: AOAM531kl3syP8u2HKT2xAhr5gTGXf07CL5Wi+mbqaC8f7LyRGgRmJGm
        X1RT+6+roFJhsJm8thNc5QI=
X-Google-Smtp-Source: ABdhPJw8JfjpVCEL5JiOFaotM18+Vjh43E6kx+VAuW0xR6CgjDglL6wZ1E1Z1ImYu1rwOZq2M94dDw==
X-Received: by 2002:a19:fc03:: with SMTP id a3mr13106796lfi.472.1606091475657;
        Sun, 22 Nov 2020 16:31:15 -0800 (PST)
Received: from localhost.localdomain (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.gmail.com with ESMTPSA id r27sm1225823lfn.290.2020.11.22.16.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 16:31:15 -0800 (PST)
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
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v10 02/19] memory: tegra20: Support hardware versioning and clean up OPP table initialization
Date:   Mon, 23 Nov 2020 03:27:06 +0300
Message-Id: <20201123002723.28463-3-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201123002723.28463-1-digetx@gmail.com>
References: <20201123002723.28463-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Support hardware versioning, which is now required for Tegra20 EMC OPP.
Clean up OPP table initialization by using a error code returned by OPP
API for judging about the OPP table presence in a device-tree and remove
OPP regulator initialization because we're now going to use power domain
instead of a raw regulator. This puts Tegra20 EMC OPP preparation on par
with the Tegra30/124 EMC drivers.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra20-emc.c | 48 +++++++++++++-----------------
 1 file changed, 20 insertions(+), 28 deletions(-)

diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index 0320d9df4a20..686aaf477d8a 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -910,43 +910,36 @@ static int tegra_emc_interconnect_init(struct tegra_emc *emc)
 
 static int tegra_emc_opp_table_init(struct tegra_emc *emc)
 {
-	struct opp_table *reg_opp_table = NULL, *clk_opp_table;
-	const char *rname = "core";
+	u32 hw_version = BIT(tegra_sku_info.soc_process_id);
+	struct opp_table *clk_opp_table, *hw_opp_table;
 	int err;
 
-	/*
-	 * Legacy device-trees don't have OPP table and EMC driver isn't
-	 * useful in this case.
-	 */
-	if (!device_property_present(emc->dev, "operating-points-v2")) {
-		dev_err(emc->dev,
-			"OPP table not found, please update your device tree\n");
-		return -ENODEV;
-	}
-
-	/* voltage scaling is optional */
-	if (device_property_present(emc->dev, "core-supply")) {
-		reg_opp_table = dev_pm_opp_set_regulators(emc->dev, &rname, 1);
-		if (IS_ERR(reg_opp_table))
-			return dev_err_probe(emc->dev, PTR_ERR(reg_opp_table),
-					     "failed to set OPP regulator\n");
-	}
-
 	clk_opp_table = dev_pm_opp_set_clkname(emc->dev, NULL);
 	err = PTR_ERR_OR_ZERO(clk_opp_table);
 	if (err) {
 		dev_err(emc->dev, "failed to set OPP clk: %d\n", err);
-		goto put_reg_table;
+		return err;
 	}
 
-	err = dev_pm_opp_of_add_table(emc->dev);
+	hw_opp_table = dev_pm_opp_set_supported_hw(emc->dev, &hw_version, 1);
+	err = PTR_ERR_OR_ZERO(hw_opp_table);
 	if (err) {
-		dev_err(emc->dev, "failed to add OPP table: %d\n", err);
+		dev_err(emc->dev, "failed to set OPP supported HW: %d\n", err);
 		goto put_clk_table;
 	}
 
-	dev_info(emc->dev, "current clock rate %lu MHz\n",
-		 clk_get_rate(emc->clk) / 1000000);
+	err = dev_pm_opp_of_add_table(emc->dev);
+	if (err) {
+		if (err == -ENODEV)
+			dev_err(emc->dev, "OPP table not found, please update your device tree\n");
+		else
+			dev_err(emc->dev, "failed to add OPP table: %d\n", err);
+
+		goto put_hw_table;
+	}
+
+	dev_info(emc->dev, "OPP HW ver. 0x%x, current clock rate %lu MHz\n",
+		 hw_version, clk_get_rate(emc->clk) / 1000000);
 
 	/* first dummy rate-set initializes voltage state */
 	err = dev_pm_opp_set_rate(emc->dev, clk_get_rate(emc->clk));
@@ -959,11 +952,10 @@ static int tegra_emc_opp_table_init(struct tegra_emc *emc)
 
 remove_table:
 	dev_pm_opp_of_remove_table(emc->dev);
+put_hw_table:
+	dev_pm_opp_put_supported_hw(hw_opp_table);
 put_clk_table:
 	dev_pm_opp_put_clkname(clk_opp_table);
-put_reg_table:
-	if (reg_opp_table)
-		dev_pm_opp_put_regulators(reg_opp_table);
 
 	return err;
 }
-- 
2.29.2

