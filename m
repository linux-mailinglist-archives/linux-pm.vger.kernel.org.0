Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 137882FF40E
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jan 2021 20:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbhAUTQR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Jan 2021 14:16:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbhAUTPI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2021 14:15:08 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0DAC06174A;
        Thu, 21 Jan 2021 11:14:27 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id j3so3772336ljb.9;
        Thu, 21 Jan 2021 11:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6KWQI8XD7L6EDXDFReXNozccameFVZf4WSpONfuhC2U=;
        b=d1h027qiGtzmqxfp3brM4N5sDpzRXXr8lK3gA9nhMLzUfxUSMhLbLCciyh8Ec+H7x0
         cctjyjuCP5WGhCECoKU6D4KFz62BbASk6uFJQfCt0mzI3qBaeKUNVcpvk3TkJsGWS75u
         NFRKmvF+YQjQR5450zyByMK6WNKbeYX+8F60bAggWWyiQ616lskiYL3PcPz0ofxahSXE
         VeDUHhY8EY6fIZo3+C7WTRioU2mVbMt+3HWzeIGSrt62S/aXXWsMzR5UJWElCLT4GlQz
         /h/Bb9cNRXnCvHklAcFwBeDzDg11wsWPSVKu0mH1rXHPectmYpjLvXXeV1+sOlYRTLXO
         /y0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6KWQI8XD7L6EDXDFReXNozccameFVZf4WSpONfuhC2U=;
        b=PSgC4iZtrH4eqPLH60+pmqMh86LQ37ZAsob+gDtLfghK3JsufjN8p/DRVfQGsFGbLt
         z7v+guqLNW1eq8aAQYhgTJS7oYvgmyhyj5EPEgE52SHcJFV9r2eV9RubGMEC6tkOOJZv
         QGW/y4hS9HSSEW1i4K93phC3WwBcKKiTAoC2fMnHSacSmumoedGirSKvTnuz+Lh1PWz9
         AnM500pFOq2xZOdbsC8Tqh8cqBwsaeJQlXIea9e7YJ54spraE5hlK28jsidM0Rm0FQmM
         qiFlMq05HHbAzvMAh2D7Hn+eppJw1FJAt6FqG35+gQEfj6bmPZcajtdy7qdfjIwmTsg5
         kRIw==
X-Gm-Message-State: AOAM533mXbDWUsLgZxzqhQSwvuxX9uyL5MnuhvdxU+xnV3dTiwSnR7a9
        tshSx/anSUA0GJDHv+Gq+HI=
X-Google-Smtp-Source: ABdhPJx1Q0Qo9k/uDxQk4+fgSogXKXxXSjpY3pCvtz9JDz2xYLZ0baZM5V1k+iUkva4Z79qWt7wZzQ==
X-Received: by 2002:a2e:b8c5:: with SMTP id s5mr374840ljp.335.1611256465700;
        Thu, 21 Jan 2021 11:14:25 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.gmail.com with ESMTPSA id o11sm613304lfi.267.2021.01.21.11.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 11:14:25 -0800 (PST)
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
Subject: [PATCH v4] soc/tegra: Add devm_tegra_core_dev_init_opp_table()
Date:   Thu, 21 Jan 2021 22:14:10 +0300
Message-Id: <20210121191410.13781-1-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add common helper which initializes OPP table for Tegra SoC core devices.

Tested-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Nicolas Chauvet <kwizart@gmail.com>
Tested-by: Matt Merhar <mattmerhar@protonmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---

Changelog:

v4: - Fixed inconsistency of "params" argument naming. I renamed "cfg"
      to "params" in v3, but missed to rename the doc-comment and
      prototype in tegra/common.h.

    - Fixed missing doc-comment for @dev.

v3: - This patch is factored out from [1] to ease merging of the patches
      that will use the new helper. The goal is to get this new helper
      into 5.12, this should remove dependency on this patch for a several
      patchsets of a different subsystems (DRM, media, memory, etc) that
      will target 5.13.

      @Thierry/Jon, please review and apply this patch for 5.12!

      [1] https://patchwork.ozlabs.org/project/linux-tegra/list/?series=221130

    - The v3 got couple very minor cleanup improvements in comparison to [1],
      like a removed unused variable and improved comments in the code.

 drivers/soc/tegra/common.c | 138 +++++++++++++++++++++++++++++++++++++
 include/soc/tegra/common.h |  30 ++++++++
 2 files changed, 168 insertions(+)

diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
index 3dc54f59cafe..6d9110fd3645 100644
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
@@ -31,3 +38,134 @@ bool soc_is_tegra(void)
 
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
2.29.2

