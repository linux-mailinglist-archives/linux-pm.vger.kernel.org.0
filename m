Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F7933A6D9
	for <lists+linux-pm@lfdr.de>; Sun, 14 Mar 2021 17:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbhCNQsl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 14 Mar 2021 12:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234060AbhCNQsU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 14 Mar 2021 12:48:20 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D15C061574;
        Sun, 14 Mar 2021 09:48:19 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id r3so45024451lfc.13;
        Sun, 14 Mar 2021 09:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LiaeMeg77iCNPwaeoUvcx6yt3UgqX4r3m0DGzmVHc7k=;
        b=Bo+luRyx+wIRDgsLy1CAQY9EO2TzBrh0CKRmBVe4QOtY1at8eMVQWt0YH2pCZMr3lI
         682lvwXw16HCYT4+bqHwfxoNXrgF99DkU3ql5vrzC1IYEy05zNVCaG7ubRx1Y6D/Aq/z
         XdlihO/6xHaQwCUuBZycUWGX7NdKKCfXOB47BW0yxIcs86uQq+1qzf1SFD/VZ95kZ6oG
         O1DWIUrP9Ve1VyVEwu6yIv6zT1zSOngFs57HwrjSDhIUwjXUEKADNjH3AlcJji5DXfdY
         QC2CuVZGsL2h6A5TbiG0SBjZjuwLINia/9/qsOwfUqqMDDeVKvjaQ8jtYlZm4UO3UXIt
         UE+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LiaeMeg77iCNPwaeoUvcx6yt3UgqX4r3m0DGzmVHc7k=;
        b=VizMArREEgx0C0H8sSHM/H+LKUld0/QYJn52yx7bY1tT7yYjojyUR4mh4qJdRt3V2m
         eLBkaLptbYuP0B8spVdl2D7sPYpaOm7xEkIAlu5KluyvgKSc4HW9fBS5kdWSgnfw1265
         3PhVS34NNay8YeVhRk8FTcEmg5y9ymMqMjDG4hYDXaZqtWBEx6s3JRKH1FPwov8xBIAy
         Um9lYbo8MrFBlfvzDBgcQr8fISLpT/9BHYbqAE9VqqMe2TfLp/BPz4DpFM3GYaRy4Hil
         ce35npBk7UHkL+l+JXo/AcBIBNjqyOT8qjSCOJBdbpZ0BM+dxuh6eN3RezHXZXAjYfaY
         uKqA==
X-Gm-Message-State: AOAM530Ap6a7VAG6zqKfIkpnYWWPNydCWEMppknWunrGZutYcn2yRW4P
        1oo3EuxwlxsdkcvuKvHp370=
X-Google-Smtp-Source: ABdhPJwfJq+4jPr6rtIh6eZDqNFxvIVZs41TL1ewSYUxXqebzNFCg+kqRn3ecfdLGIYBq2/SBEWV9Q==
X-Received: by 2002:ac2:4576:: with SMTP id k22mr5599043lfm.523.1615740498271;
        Sun, 14 Mar 2021 09:48:18 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.gmail.com with ESMTPSA id a3sm2387993lfr.55.2021.03.14.09.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 09:48:18 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Paul Fertser <fercerpav@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/6] soc/tegra: Add devm_tegra_core_dev_init_opp_table()
Date:   Sun, 14 Mar 2021 19:48:05 +0300
Message-Id: <20210314164810.26317-2-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210314164810.26317-1-digetx@gmail.com>
References: <20210314164810.26317-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add common helper which initializes OPP table for Tegra SoC core devices.

Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
Tested-by: Paul Fertser <fercerpav@gmail.com> # PAZ00 T20
Tested-by: Nicolas Chauvet <kwizart@gmail.com> # PAZ00 T20 and TK1 T124
Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/common.c | 137 +++++++++++++++++++++++++++++++++++++
 include/soc/tegra/common.h |  30 ++++++++
 2 files changed, 167 insertions(+)

diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
index 3dc54f59cafe..bdcf314b46c1 100644
--- a/drivers/soc/tegra/common.c
+++ b/drivers/soc/tegra/common.c
@@ -3,9 +3,16 @@
  * Copyright (C) 2014 NVIDIA CORPORATION.  All rights reserved.
  */
 
+#define dev_fmt(fmt)	"tegra-soc: " fmt
+
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/export.h>
 #include <linux/of.h>
+#include <linux/pm_opp.h>
 
 #include <soc/tegra/common.h>
+#include <soc/tegra/fuse.h>
 
 static const struct of_device_id tegra_machine_match[] = {
 	{ .compatible = "nvidia,tegra20", },
@@ -31,3 +38,133 @@ bool soc_is_tegra(void)
 
 	return match != NULL;
 }
+
+static int tegra_core_dev_init_opp_state(struct device *dev)
+{
+	struct dev_pm_opp *opp;
+	unsigned long rate;
+	struct clk *clk;
+	int err;
+
+	clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(clk)) {
+		dev_err(dev, "failed to get clk: %pe\n", clk);
+		return PTR_ERR(clk);
+	}
+
+	/*
+	 * If voltage regulator presents, then we could select the fastest
+	 * clock rate, but driver doesn't support power management and
+	 * frequency scaling yet, hence the top freq OPP will vote for a
+	 * very high voltage that will produce lot's of heat.  Let's select
+	 * OPP for the current/default rate for now.
+	 *
+	 * Clock rate should be pre-initialized (i.e. it's non-zero) either
+	 * by clock driver or by assigned clocks in a device-tree.
+	 */
+	rate = clk_get_rate(clk);
+	if (!rate) {
+		dev_err(dev, "failed to get clk rate\n");
+		return -EINVAL;
+	}
+
+	/* find suitable OPP for the clock rate and supportable by hardware */
+	opp = dev_pm_opp_find_freq_ceil(dev, &rate);
+
+	/*
+	 * dev_pm_opp_set_rate() doesn't search for a floor clock rate and it
+	 * will error out if default clock rate is too high, i.e. unsupported
+	 * by a SoC hardware version.  Hence will find floor rate by ourselves.
+	 */
+	if (opp == ERR_PTR(-ERANGE))
+		opp = dev_pm_opp_find_freq_floor(dev, &rate);
+
+	err = PTR_ERR_OR_ZERO(opp);
+	if (err) {
+		dev_err(dev, "failed to get OPP for %ld Hz: %d\n",
+			rate, err);
+		return err;
+	}
+
+	dev_pm_opp_put(opp);
+
+	/*
+	 * First dummy rate-set initializes voltage vote by setting voltage
+	 * in accordance to the clock rate.  We need to do this because some
+	 * drivers currently don't support power management and clock is
+	 * permanently enabled.
+	 */
+	err = dev_pm_opp_set_rate(dev, rate);
+	if (err) {
+		dev_err(dev, "failed to initialize OPP clock: %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+/**
+ * devm_tegra_core_dev_init_opp_table() - initialize OPP table
+ * @dev: device for which OPP table is initialized
+ * @params: pointer to the OPP table configuration
+ *
+ * This function will initialize OPP table and sync OPP state of a Tegra SoC
+ * core device.
+ *
+ * Return: 0 on success or errorno.
+ */
+int devm_tegra_core_dev_init_opp_table(struct device *dev,
+				       struct tegra_core_opp_params *params)
+{
+	u32 hw_version;
+	int err;
+
+	err = devm_pm_opp_set_clkname(dev, NULL);
+	if (err) {
+		dev_err(dev, "failed to set OPP clk: %d\n", err);
+		return err;
+	}
+
+	/* Tegra114+ doesn't support OPP yet */
+	if (!of_machine_is_compatible("nvidia,tegra20") &&
+	    !of_machine_is_compatible("nvidia,tegra30"))
+		return -ENODEV;
+
+	if (of_machine_is_compatible("nvidia,tegra20"))
+		hw_version = BIT(tegra_sku_info.soc_process_id);
+	else
+		hw_version = BIT(tegra_sku_info.soc_speedo_id);
+
+	err = devm_pm_opp_set_supported_hw(dev, &hw_version, 1);
+	if (err) {
+		dev_err(dev, "failed to set OPP supported HW: %d\n", err);
+		return err;
+	}
+
+	/*
+	 * Older device-trees have an empty OPP table, hence we will get
+	 * -ENODEV from devm_pm_opp_of_add_table() for the older DTBs.
+	 *
+	 * The OPP table presence also varies per-device and depending
+	 * on a SoC generation, hence -ENODEV is expected to happen for
+	 * the newer DTs as well.
+	 */
+	err = devm_pm_opp_of_add_table(dev);
+	if (err) {
+		if (err == -ENODEV)
+			dev_err_once(dev, "OPP table not found, please update device-tree\n");
+		else
+			dev_err(dev, "failed to add OPP table: %d\n", err);
+
+		return err;
+	}
+
+	if (params->init_state) {
+		err = tegra_core_dev_init_opp_state(dev);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devm_tegra_core_dev_init_opp_table);
diff --git a/include/soc/tegra/common.h b/include/soc/tegra/common.h
index 98027a76ce3d..e8eab13aa199 100644
--- a/include/soc/tegra/common.h
+++ b/include/soc/tegra/common.h
@@ -6,6 +6,36 @@
 #ifndef __SOC_TEGRA_COMMON_H__
 #define __SOC_TEGRA_COMMON_H__
 
+#include <linux/errno.h>
+#include <linux/types.h>
+
+struct device;
+
+/**
+ * Tegra SoC core device OPP table configuration
+ *
+ * @init_state: pre-initialize OPP state of a device
+ */
+struct tegra_core_opp_params {
+	bool init_state;
+};
+
+#ifdef CONFIG_ARCH_TEGRA
 bool soc_is_tegra(void);
+int devm_tegra_core_dev_init_opp_table(struct device *dev,
+				       struct tegra_core_opp_params *params);
+#else
+static inline bool soc_is_tegra(void)
+{
+	return false;
+}
+
+static inline int
+devm_tegra_core_dev_init_opp_table(struct device *dev,
+				   struct tegra_core_opp_params *params)
+{
+	return -ENODEV;
+}
+#endif
 
 #endif /* __SOC_TEGRA_COMMON_H__ */
-- 
2.30.2

