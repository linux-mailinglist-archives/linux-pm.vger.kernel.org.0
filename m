Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9CB3D9068
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jul 2021 16:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236745AbhG1OZU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Jul 2021 10:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236686AbhG1OZM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Jul 2021 10:25:12 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7E8C0617B1
        for <linux-pm@vger.kernel.org>; Wed, 28 Jul 2021 07:24:56 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id f12so3338598ljn.1
        for <linux-pm@vger.kernel.org>; Wed, 28 Jul 2021 07:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1UBua13F+A5CHYAXTN2Yvc4txUC3tULAs/8cg48q4YI=;
        b=usaAQKG9gjs/HixLkYbmV5Vg78JLuU2FwjS5WYkfbd4XmH8nDemPzFjILlRRYV+O9h
         wHK0WfSnIeUW5ZSr2nDOCQEIdW+dChyBkB3B90V6M4h5+PXZy2CyCphL4TPR5H/G1NmY
         Xdv6qKScWzIDwuhcuSNTTzYjsvtaVILD1VDm/vslU9KCuz6POPVJz/J9JmkWVMouAXp1
         EiXk2929yPlRhAxHScl8EA/IfwjpIfDYC/7bRJYJ9bjwzWygVs2cF/ItKIEufZR3dfNn
         UosY3By9VQA/lqTIWA/f2zj2IzseVJWSoLaMobWowsxxoU5V7+01wP/tmAQC34qPltL1
         9SXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1UBua13F+A5CHYAXTN2Yvc4txUC3tULAs/8cg48q4YI=;
        b=TZrTMcf4rahxPv/bWETFMLiszrn93dpC13cUOE4NwBbccn0Rb+82NZSQBuPwmaD1c8
         MJcAlAO7CBbOs2mn4UvQXGrXdsJRKyWSqEiZRYk93SeY0BLaqLfLFuZhx9Ugu0XK4vy6
         yAkXKBZ3r6wwX7WiRr9SHNekWPulnaF/s5AX+llW4SI+gyEq2DH7RjXYtX5hkH12hpa+
         N0rWw4siuQAR7ZuqskMNVEJIu8XsCOKAiMMpVz80m5fFJC9Ck20NP0p5ooc4fqGaTyuh
         6olOfXls2LbuPXqPZLKZPbe/9K/fEriON9lNx8xLpti93/rduuL5G2FVRoapV1k9VE5f
         i6oA==
X-Gm-Message-State: AOAM531OidzVEf+elmhnh/tQq/k8IiclxK5b8cl3NRakW4qXD6P0fKpc
        Zw5ov+zyE6rqBK4ptGtVFOWcHQ==
X-Google-Smtp-Source: ABdhPJxn2Z8txgg95TaIucUtPGJPNjcEmX4ILaMTN9aL/eyREY/1WXLyAoMLpCIWmewCNp2ibPE40w==
X-Received: by 2002:a05:651c:110f:: with SMTP id d15mr67991ljo.275.1627482294412;
        Wed, 28 Jul 2021 07:24:54 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id h4sm15610lft.184.2021.07.28.07.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 07:24:54 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 5/5] clk: qcom: move pm_clk functionality into common code
Date:   Wed, 28 Jul 2021 17:24:45 +0300
Message-Id: <20210728142445.774158-6-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210728142445.774158-1-dmitry.baryshkov@linaro.org>
References: <20210728142445.774158-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Several Qualcomm clock controller drivers use pm_clk functionality.
Instead of having common code in all the drivers, move the pm_clk
handling to the qcom_cc_map/qcom_cc_probe.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/clk/qcom/camcc-sc7180.c       | 28 +++++++-----------
 drivers/clk/qcom/common.c             | 36 +++++++++++++++++++++++
 drivers/clk/qcom/common.h             | 17 +++++++++++
 drivers/clk/qcom/lpasscorecc-sc7180.c | 41 +++++++++------------------
 drivers/clk/qcom/mss-sc7180.c         | 31 ++++++--------------
 drivers/clk/qcom/q6sstop-qcs404.c     | 22 ++++++--------
 drivers/clk/qcom/turingcc-qcs404.c    | 31 ++++++--------------
 7 files changed, 103 insertions(+), 103 deletions(-)

diff --git a/drivers/clk/qcom/camcc-sc7180.c b/drivers/clk/qcom/camcc-sc7180.c
index ce73ee9037cb..cb213b8473a5 100644
--- a/drivers/clk/qcom/camcc-sc7180.c
+++ b/drivers/clk/qcom/camcc-sc7180.c
@@ -1631,8 +1631,16 @@ static const struct regmap_config cam_cc_sc7180_regmap_config = {
 	.fast_io = true,
 };
 
+static const char * const cam_cc_sc7180_pm_clks[] = { "xo", "iface" };
+
+static const struct qcom_cc_pm cam_cc_sc7180_pm = {
+	.pm_clks = cam_cc_sc7180_pm_clks,
+	.num_pm_clks = ARRAY_SIZE(cam_cc_sc7180_pm_clks),
+};
+
 static const struct qcom_cc_desc cam_cc_sc7180_desc = {
 	.config = &cam_cc_sc7180_regmap_config,
+	.pm = &cam_cc_sc7180_pm,
 	.clk_hws = cam_cc_sc7180_hws,
 	.num_clk_hws = ARRAY_SIZE(cam_cc_sc7180_hws),
 	.clks = cam_cc_sc7180_clocks,
@@ -1652,25 +1660,9 @@ static int cam_cc_sc7180_probe(struct platform_device *pdev)
 	struct regmap *regmap;
 	int ret;
 
-	ret = devm_pm_runtime_enable(&pdev->dev);
-	if (ret < 0)
-		return ret;
-
-	ret = devm_pm_clk_create(&pdev->dev);
-	if (ret < 0)
-		return ret;
-
-	ret = pm_clk_add(&pdev->dev, "xo");
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to acquire XO clock\n");
-		return ret;
-	}
-
-	ret = pm_clk_add(&pdev->dev, "iface");
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to acquire iface clock\n");
+	ret = qcom_cc_setup_pm(pdev, &cam_cc_sc7180_desc);
+	if (ret)
 		return ret;
-	}
 
 	ret = pm_runtime_get(&pdev->dev);
 	if (ret)
diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
index ed7c516a597a..def01be085ba 100644
--- a/drivers/clk/qcom/common.c
+++ b/drivers/clk/qcom/common.c
@@ -7,6 +7,8 @@
 #include <linux/module.h>
 #include <linux/regmap.h>
 #include <linux/platform_device.h>
+#include <linux/pm_clock.h>
+#include <linux/pm_runtime.h>
 #include <linux/clk-provider.h>
 #include <linux/reset-controller.h>
 #include <linux/of.h>
@@ -307,6 +309,8 @@ int qcom_cc_probe(struct platform_device *pdev, const struct qcom_cc_desc *desc)
 {
 	struct regmap *regmap;
 
+	qcom_cc_setup_pm(pdev, desc);
+
 	regmap = qcom_cc_map(pdev, desc);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
@@ -320,6 +324,8 @@ int qcom_cc_probe_by_index(struct platform_device *pdev, int index,
 {
 	struct regmap *regmap;
 
+	qcom_cc_setup_pm(pdev, desc);
+
 	regmap = qcom_cc_map_by_index(pdev, desc, index);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
@@ -328,4 +334,34 @@ int qcom_cc_probe_by_index(struct platform_device *pdev, int index,
 }
 EXPORT_SYMBOL_GPL(qcom_cc_probe_by_index);
 
+int qcom_cc_really_setup_pm(struct platform_device *pdev, const struct qcom_cc_pm *pm)
+{
+	int ret;
+	int i;
+
+	if (!pm)
+		return -EINVAL;
+
+	ret = devm_pm_runtime_enable(&pdev->dev);
+	if (ret)
+		return ret;
+
+	if (pm->num_pm_clks) {
+		ret = devm_pm_clk_create(&pdev->dev);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < pm->num_pm_clks; i++) {
+		ret = pm_clk_add(&pdev->dev, pm->pm_clks[i]);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "Failed to acquire %s pm clk\n", pm->pm_clks[i]);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(qcom_cc_really_setup_pm);
+
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/qcom/common.h b/drivers/clk/qcom/common.h
index bb39a7e106d8..ea4394439712 100644
--- a/drivers/clk/qcom/common.h
+++ b/drivers/clk/qcom/common.h
@@ -19,8 +19,15 @@ struct clk_hw;
 #define PLL_VOTE_FSM_ENA	BIT(20)
 #define PLL_VOTE_FSM_RESET	BIT(21)
 
+/* This can be used from within the qcom_cc_desc or separately */
+struct qcom_cc_pm {
+	const char *const *pm_clks;
+	size_t num_pm_clks;
+};
+
 struct qcom_cc_desc {
 	const struct regmap_config *config;
+	const struct qcom_cc_pm *pm;
 	struct clk_regmap **clks;
 	size_t num_clks;
 	const struct qcom_reset_map *resets;
@@ -54,6 +61,16 @@ extern int qcom_cc_register_board_clk(struct device *dev, const char *path,
 				      const char *name, unsigned long rate);
 extern int qcom_cc_register_sleep_clk(struct device *dev);
 
+extern int qcom_cc_really_setup_pm(struct platform_device *pdev, const struct qcom_cc_pm *pm);
+
+static inline int qcom_cc_setup_pm(struct platform_device *pdev, const struct qcom_cc_desc *desc)
+{
+	if (!desc->pm)
+		return 0;
+
+	return qcom_cc_really_setup_pm(pdev, desc->pm);
+}
+
 extern struct regmap *qcom_cc_map(struct platform_device *pdev,
 				  const struct qcom_cc_desc *desc);
 extern int qcom_cc_really_probe(struct platform_device *pdev,
diff --git a/drivers/clk/qcom/lpasscorecc-sc7180.c b/drivers/clk/qcom/lpasscorecc-sc7180.c
index ac09b7b840ab..af1b04615d1d 100644
--- a/drivers/clk/qcom/lpasscorecc-sc7180.c
+++ b/drivers/clk/qcom/lpasscorecc-sc7180.c
@@ -338,8 +338,16 @@ static struct regmap_config lpass_core_cc_sc7180_regmap_config = {
 	.fast_io = true,
 };
 
+static const char * const lpass_core_sc7180_pm_clks[] = { "iface" };
+
+static const struct qcom_cc_pm lpass_core_sc7180_pm = {
+	.pm_clks = lpass_core_sc7180_pm_clks,
+	.num_pm_clks = ARRAY_SIZE(lpass_core_sc7180_pm_clks),
+};
+
 static const struct qcom_cc_desc lpass_core_hm_sc7180_desc = {
 	.config = &lpass_core_cc_sc7180_regmap_config,
+	.pm = &lpass_core_sc7180_pm,
 	.gdscs = lpass_core_hm_sc7180_gdscs,
 	.num_gdscs = ARRAY_SIZE(lpass_core_hm_sc7180_gdscs),
 };
@@ -356,35 +364,16 @@ static const struct qcom_cc_desc lpass_audio_hm_sc7180_desc = {
 	.num_gdscs = ARRAY_SIZE(lpass_audio_hm_sc7180_gdscs),
 };
 
-static int lpass_create_pm_clks(struct platform_device *pdev)
-{
-	int ret;
-
-	pm_runtime_use_autosuspend(&pdev->dev);
-	pm_runtime_set_autosuspend_delay(&pdev->dev, 500);
-
-	ret = devm_pm_runtime_enable(&pdev->dev);
-	if (ret)
-		return ret;
-
-	ret = devm_pm_clk_create(&pdev->dev);
-	if (ret)
-		return ret;
-
-	ret = pm_clk_add(&pdev->dev, "iface");
-	if (ret < 0)
-		dev_err(&pdev->dev, "failed to acquire iface clock\n");
-
-	return ret;
-}
-
 static int lpass_core_cc_sc7180_probe(struct platform_device *pdev)
 {
 	const struct qcom_cc_desc *desc;
 	struct regmap *regmap;
 	int ret;
 
-	ret = lpass_create_pm_clks(pdev);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 500);
+
+	ret = qcom_cc_really_setup_pm(pdev, &lpass_core_sc7180_pm);
 	if (ret)
 		return ret;
 
@@ -423,11 +412,9 @@ static int lpass_core_cc_sc7180_probe(struct platform_device *pdev)
 static int lpass_hm_core_probe(struct platform_device *pdev)
 {
 	const struct qcom_cc_desc *desc;
-	int ret;
 
-	ret = lpass_create_pm_clks(pdev);
-	if (ret)
-		return ret;
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 500);
 
 	lpass_core_cc_sc7180_regmap_config.name = "lpass_hm_core";
 	desc = &lpass_core_hm_sc7180_desc;
diff --git a/drivers/clk/qcom/mss-sc7180.c b/drivers/clk/qcom/mss-sc7180.c
index 5a1407440662..47feca261985 100644
--- a/drivers/clk/qcom/mss-sc7180.c
+++ b/drivers/clk/qcom/mss-sc7180.c
@@ -7,7 +7,6 @@
 #include <linux/platform_device.h>
 #include <linux/module.h>
 #include <linux/pm_clock.h>
-#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 
 #include <dt-bindings/clock/qcom,mss-sc7180.h>
@@ -63,35 +62,23 @@ static struct clk_regmap *mss_sc7180_clocks[] = {
 	[MSS_AXI_NAV_CLK] = &mss_axi_nav_clk.clkr,
 };
 
+static const char * const mss_sc7180_pm_clks[] = { "cfg_ahb" };
+
+static const struct qcom_cc_pm mss_sc7180_pm = {
+	.pm_clks = mss_sc7180_pm_clks,
+	.num_pm_clks = ARRAY_SIZE(mss_sc7180_pm_clks),
+};
+
 static const struct qcom_cc_desc mss_sc7180_desc = {
 	.config = &mss_regmap_config,
+	.pm = &mss_sc7180_pm,
 	.clks = mss_sc7180_clocks,
 	.num_clks = ARRAY_SIZE(mss_sc7180_clocks),
 };
 
 static int mss_sc7180_probe(struct platform_device *pdev)
 {
-	int ret;
-
-	ret = devm_pm_runtime_enable(&pdev->dev);
-	if (ret)
-		return ret;
-
-	ret = devm_pm_clk_create(&pdev->dev);
-	if (ret)
-		return ret;
-
-	ret = pm_clk_add(&pdev->dev, "cfg_ahb");
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to acquire iface clock\n");
-		return ret;
-	}
-
-	ret = qcom_cc_probe(pdev, &mss_sc7180_desc);
-	if (ret < 0)
-		return ret;
-
-	return 0;
+	return qcom_cc_probe(pdev, &mss_sc7180_desc);
 }
 
 static const struct dev_pm_ops mss_sc7180_pm_ops = {
diff --git a/drivers/clk/qcom/q6sstop-qcs404.c b/drivers/clk/qcom/q6sstop-qcs404.c
index 507386bee07d..e19ee2b047ac 100644
--- a/drivers/clk/qcom/q6sstop-qcs404.c
+++ b/drivers/clk/qcom/q6sstop-qcs404.c
@@ -8,7 +8,6 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm_clock.h>
-#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 
 #include <dt-bindings/clock/qcom,q6sstopcc-qcs404.h>
@@ -117,6 +116,13 @@ static struct regmap_config q6sstop_regmap_config = {
 	.fast_io	= true,
 };
 
+static const char * const q6sstop_qcs404_pm_clks[] = { NULL };
+
+static const struct qcom_cc_pm q6sstop_qcs404_pm = {
+	.pm_clks = q6sstop_qcs404_pm_clks,
+	.num_pm_clks = ARRAY_SIZE(q6sstop_qcs404_pm_clks),
+};
+
 static struct clk_regmap *q6sstop_qcs404_clocks[] = {
 	[LCC_AHBFABRIC_CBC_CLK] = &lcc_ahbfabric_cbc_clk.clkr,
 	[LCC_Q6SS_AHBS_CBC_CLK] = &lcc_q6ss_ahbs_cbc_clk.clkr,
@@ -159,19 +165,7 @@ static int q6sstopcc_qcs404_probe(struct platform_device *pdev)
 	const struct qcom_cc_desc *desc;
 	int ret;
 
-	ret = devm_pm_runtime_enable(&pdev->dev);
-	if (ret)
-		return ret;
-
-	ret = devm_pm_clk_create(&pdev->dev);
-	if (ret)
-		return ret;
-
-	ret = pm_clk_add(&pdev->dev, NULL);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to acquire iface clock\n");
-		return ret;
-	}
+	ret = qcom_cc_really_setup_pm(pdev, &q6sstop_qcs404_pm);
 
 	q6sstop_regmap_config.name = "q6sstop_tcsr";
 	desc = &tcsr_qcs404_desc;
diff --git a/drivers/clk/qcom/turingcc-qcs404.c b/drivers/clk/qcom/turingcc-qcs404.c
index 4543bda793f4..a2ac9e6da13c 100644
--- a/drivers/clk/qcom/turingcc-qcs404.c
+++ b/drivers/clk/qcom/turingcc-qcs404.c
@@ -9,7 +9,6 @@
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/pm_clock.h>
-#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 
 #include <dt-bindings/clock/qcom,turingcc-qcs404.h>
@@ -100,35 +99,23 @@ static const struct regmap_config turingcc_regmap_config = {
 	.fast_io	= true,
 };
 
+static const char * const turingcc_pm_clks[] = { NULL };
+
+static const struct qcom_cc_pm turingcc_pm = {
+	.pm_clks = turingcc_pm_clks,
+	.num_pm_clks = ARRAY_SIZE(turingcc_pm_clks),
+};
+
 static const struct qcom_cc_desc turingcc_desc = {
 	.config = &turingcc_regmap_config,
+	.pm = &turingcc_pm,
 	.clks = turingcc_clocks,
 	.num_clks = ARRAY_SIZE(turingcc_clocks),
 };
 
 static int turingcc_probe(struct platform_device *pdev)
 {
-	int ret;
-
-	ret = devm_pm_runtime_enable(&pdev->dev);
-	if (ret)
-		return ret;
-
-	ret = devm_pm_clk_create(&pdev->dev);
-	if (ret)
-		return ret;
-
-	ret = pm_clk_add(&pdev->dev, NULL);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to acquire iface clock\n");
-		return ret;
-	}
-
-	ret = qcom_cc_probe(pdev, &turingcc_desc);
-	if (ret < 0)
-		return ret;
-
-	return 0;
+	return qcom_cc_probe(pdev, &turingcc_desc);
 }
 
 static const struct dev_pm_ops turingcc_pm_ops = {
-- 
2.30.2

