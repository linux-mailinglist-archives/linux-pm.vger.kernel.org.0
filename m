Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 964B92FF416
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jan 2021 20:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbhAUTQ6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Jan 2021 14:16:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbhAUTOy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2021 14:14:54 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B981C061794;
        Thu, 21 Jan 2021 11:01:45 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id o19so4073296lfo.1;
        Thu, 21 Jan 2021 11:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lHjyh7MnV6uiNlbgvZbHpAWHz87CVF0R+X82k3ji/PE=;
        b=aJGmiz+oXm0EHRDMHp7kyCXIYMj/XuK7oa+3WZUSDModbG2ZFD8twjon54RLI0hqrZ
         fYhv133PHtKcGaScG3POQ03Vm3Gj+HL9j0Eq/2U8hHXOr4R3bwDYeLIAtnJS7/v443qq
         R7eLT7nnEYr4cIjTANpNbNEt6LWGKJTd8U3nKmB1C8PbQ/0VvJh0hvJFe+pWkZXJmiMg
         gIT0bqcBMhpE4iHqTUFnJ9b31LSUJAfATEMJwALl0b3fx0GD1kCZ+kHjlu2WHr7onnpA
         GIFovCWGBzLP2XwFY1WiZrDiZEiJL8/Yt5xN5Koiu61aQLRKU8JMrdirUpJCGiqwS1UK
         kOUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lHjyh7MnV6uiNlbgvZbHpAWHz87CVF0R+X82k3ji/PE=;
        b=Bg+1QQjlfRTcJfYphMa6ninJyTaP/m1PXrk38VnqsJN1Sxaf3K4uEOsTVcuNCUL9IK
         jPWUnqjeLxRBgniwtYu2L74JW9Pv0UDMdgQYG6fwFWHDWVQXJb0fYt79bFjgry0qiKXg
         QduZKW71eFnnJSRxF00ZmdVCBWkoVVR3ZMOsWCct0kAXkN2VwjVPdiCsntyLq8fxbkPj
         yXdtbyez5qDg/Yl34iPD3B5egO1DqaxlyvfbNPsgIolFbJUTKQi4H8F/zLnH4CL1pJ2S
         G/z2TL8dad3GV5wnMzBRWykdRByibXxPK6p4uWfJ/F5R5D3r8I9I8gQIHinYRy9NAhYh
         zsHQ==
X-Gm-Message-State: AOAM532BSXmPGuz8u5QU7xlVNhu0uc66oNBl3q/Q84Pa+zd6Cj01YoIN
        cKdxS6mTeTJkklfj/HaDWoCPZisLbso=
X-Google-Smtp-Source: ABdhPJxYwEA872CMBZJRO7q4DBvRTrDJ9hc8oEC2qss8oB4KLHvjih2rSRATBTP8y6hMDhPjU/z/sw==
X-Received: by 2002:ac2:44ce:: with SMTP id d14mr300570lfm.146.1611255703954;
        Thu, 21 Jan 2021 11:01:43 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.gmail.com with ESMTPSA id a4sm654802ljp.14.2021.01.21.11.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 11:01:43 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Matt Merhar <mattmerhar@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3] soc/tegra: Add devm_tegra_core_dev_init_opp_table()
Date:   Thu, 21 Jan 2021 22:01:17 +0300
Message-Id: <20210121190117.25235-1-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add common helper which initializes OPP table for Tegra SoC core devices.

Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
Tested-by: Dmitry Osipenko <digetx@gmail.com> # A500 T20 and Nexus7 T30
Tested-by: Nicolas Chauvet <kwizart@gmail.com> # PAZ00 T20 and TK1 T124
Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
[tested on some other non-upstreamed-yet T20/30/114 devices as well]
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---

Changelog:

v3: - This patch is factored out from [1] to ease merging of the patches
      that will use the new helper. The goal is to get this new helper
      into 5.12, this should remove dependency on this patch for a several
      patchsets of a different subsystems (DRM, media, memory, etc) that
      will target 5.13.

      @Thierry/Jon, please review and apply this patch for 5.12!

      [1] https://patchwork.ozlabs.org/project/linux-tegra/list/?series=221130

    - The v3 got couple very minor cleanup improvements in comparison to [1],
      like a removed unused variable and improved comments in the code.

 drivers/soc/tegra/common.c | 137 +++++++++++++++++++++++++++++++++++++
 include/soc/tegra/common.h |  30 ++++++++
 2 files changed, 167 insertions(+)

diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
index 3dc54f59cafe..6b965471db30 100644
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
+ * @cfg: pointer to the OPP table configuration
+ *
+ * This function will initialize OPP table and sync OPP state of a Tegra SoC
+ * core device.
+ *
+ * Return: 0 on success or errorno.
+ */
+int devm_tegra_core_dev_init_opp_table(struct device *dev,
+				       struct tegra_core_opp_params *params)
+{
+	struct opp_table *opp_table;
+	u32 hw_version;
+	int err;
+
+	opp_table = devm_pm_opp_set_clkname(dev, NULL);
+	if (IS_ERR(opp_table)) {
+		dev_err(dev, "failed to set OPP clk %pe\n", opp_table);
+		return PTR_ERR(opp_table);
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
+	opp_table = devm_pm_opp_set_supported_hw(dev, &hw_version, 1);
+	if (IS_ERR(opp_table)) {
+		dev_err(dev, "failed to set OPP supported HW: %pe\n", opp_table);
+		return PTR_ERR(opp_table);
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
index 98027a76ce3d..18e562496f2a 100644
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
+				       struct tegra_core_opp_params *cfg);
+#else
+static inline bool soc_is_tegra(void)
+{
+	return false;
+}
+
+static inline int
+devm_tegra_core_dev_init_opp_table(struct device *dev,
+				   struct tegra_core_opp_params *cfg)
+{
+	return -ENODEV;
+}
+#endif
 
 #endif /* __SOC_TEGRA_COMMON_H__ */
-- 
2.29.2

