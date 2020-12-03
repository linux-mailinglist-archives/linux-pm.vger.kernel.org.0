Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB4A2CDECA
	for <lists+linux-pm@lfdr.de>; Thu,  3 Dec 2020 20:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731330AbgLCTZi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Dec 2020 14:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731274AbgLCTZf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Dec 2020 14:25:35 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4F5C061A51;
        Thu,  3 Dec 2020 11:24:54 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id 142so3778657ljj.10;
        Thu, 03 Dec 2020 11:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wD654qs0k//gW+67LA4ZZp/K3+FDPI5u/Ahc0zUQPLo=;
        b=RU+7y6X2Cokxex5uZpcneyoWfukNm7Xgd5NGu2amFEgb3nO7ySwnQAKUtQwamMOxIt
         YwD1i8IO9DZD+rA9ew91c25Y7QcM1j10iuAvDvink2wCU1tZz3uDSFXV3IIXPFuV5Dz+
         IaDqNIYNscT0SA6SJQGtehnHl5FGwUIAiYoKdMfoTbZMEBRBdiyzW/Vw+Ap1yz06DjVm
         RYTSr3a0qZstZ49SmEuTwqrnMrWDer3IKqVSsQIGpOSDWwMWbQFqw02yWCG85GxE5XlE
         1iBc/42vsDwYflBtBcqmaxqKbCPHOxeFT39TKurGUF47IdHwimKngxR7mxM5EblBz93M
         xzRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wD654qs0k//gW+67LA4ZZp/K3+FDPI5u/Ahc0zUQPLo=;
        b=j9is6xI66VysJubj9EqL44BQZpm+yc2WjVh8yVkQvkU7aeUFyCpOofssZ/M5gWc/zN
         LN0edeukwLQ+TeOew0h2kprbbc6yCWPeghmqb5CWKGK8EIbi5wUzOXe3y9IxVOosPLfr
         fAn7YLgnKjNaY3Ip61Yx4KvbhQ3rtaXoMnVX563htjbPWdWbaagFyr2xHpozueOJp/92
         dWNWyxYoA1Na7Rf8I7kRmKa5FtxV4NMq6wo0hFxkXr+c0CCx05MtypKEk2PnbvSLjf/F
         R/8V51lVues/Tn+BCzhbOGKzQThATC+3/slpMOMDa/c9MWukDBjv0L/E+tL4n9f52x5t
         kaBg==
X-Gm-Message-State: AOAM533HXKQI2wS9S+tcWQgL8aib0RmHCkoY0kk9/zDHNqN4l5VXzqM3
        Wo2hKPFRxPFXRPAqewaWBHE=
X-Google-Smtp-Source: ABdhPJzNiZORqBwm0FPAZL1hosrKjco0/L021fdqKQBrhREnO/oJvLU+4q6LnoQjLwmP88VYvCS0og==
X-Received: by 2002:a2e:984e:: with SMTP id e14mr2011971ljj.110.1607023493451;
        Thu, 03 Dec 2020 11:24:53 -0800 (PST)
Received: from localhost.localdomain (109-252-192-53.dynamic.spd-mgts.ru. [109.252.192.53])
        by smtp.gmail.com with ESMTPSA id z7sm861932lfq.50.2020.12.03.11.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 11:24:52 -0800 (PST)
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
Subject: [PATCH v11 02/10] memory: tegra20: Support hardware versioning and clean up OPP table initialization
Date:   Thu,  3 Dec 2020 22:24:31 +0300
Message-Id: <20201203192439.16177-3-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201203192439.16177-1-digetx@gmail.com>
References: <20201203192439.16177-1-digetx@gmail.com>
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

