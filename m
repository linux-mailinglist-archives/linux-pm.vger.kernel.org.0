Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 896415B030
	for <lists+linux-pm@lfdr.de>; Sun, 30 Jun 2019 17:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfF3PCq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 30 Jun 2019 11:02:46 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43414 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfF3PCq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 30 Jun 2019 11:02:46 -0400
Received: by mail-qk1-f193.google.com with SMTP id m14so9019448qka.10;
        Sun, 30 Jun 2019 08:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dc1ZOlpC7lAGBUCKs27bntMMiI+Lv0N6AfkWh/PXjOk=;
        b=fRHGr0NQRl6QvXdXDos0N3g4OnlcsrnOQydwKjK+U2IPKj0928RwVCgGi3IQaSs4qH
         zPnvOEb3KyEDJP8ctxwqL1pH2KxsDKBww8OhmSBtRf+rpS26HQHOvzUQjiLg5OAAGRwm
         XsG82J9zo8YnkJJxcZe1VI4GIepME7KctKg0TBO+EcFT8kGbfyb56T2bEiM1s2hUtJA6
         qoD6XoT0J+kRNHp6YEtaXh7s2UVAXQ/bw9CfgufMCSHubvoFK2EuVBjtwZfdPSLiMwTZ
         aNkMziMnF4hCh4P+zLJcg+c8dKBysA4k/3VaxQrBB1kZMKecjWDZBRh48zPPkqdxlmZn
         e0vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dc1ZOlpC7lAGBUCKs27bntMMiI+Lv0N6AfkWh/PXjOk=;
        b=tmXw4pwLCcluUAXI/onrQySsT4VxF06JvA7q53NGm8Wg9BGfgJLH+94bAYweYujYc6
         Tx3mkK4735S+Mj40iS0YYQUXZ0FcAZNOxesztaLQGUFm2hvGj/olqE8K0qxym6XtnMee
         gZJQRAT9eYNQ9OCFRsbT3MCODG2yYJiVSkimPE9XPbFijZSeMhHoRqw3sZ0ICXJWtgM0
         0/h0AE0T136Q3Q2hGx9ZUIKtrPbYUgFnLS3qS5tZzE/E2Jp8dszn3c7UBnC2qI6XEVzw
         wwjZqmePOTevpM0HwEwVtnHuFM8vNV8v+1bnaGTAJvsZ3b1kF6YQUtCzydkL4v3LA17f
         FI/g==
X-Gm-Message-State: APjAAAVaa8rb6Yv2Ea5wFsVJKtd2to/6O/k8U31Cr8n/I8Y9g4C9AJkB
        ZVs/K3MQQVkRowN5oVNZS04=
X-Google-Smtp-Source: APXvYqyb4A8fxnJFGSVk29kqD4iLsI5nw1fUR6ng/0RGFELkKo5n83itxm+NC7Wif+yG0dLGI4k+bA==
X-Received: by 2002:a37:795:: with SMTP id 143mr17084419qkh.140.1561906964588;
        Sun, 30 Jun 2019 08:02:44 -0700 (PDT)
Received: from localhost ([2601:184:4780:7861:5010:5849:d76d:b714])
        by smtp.gmail.com with ESMTPSA id s11sm4077384qte.49.2019.06.30.08.02.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 30 Jun 2019 08:02:44 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
Cc:     freedreno@lists.freedesktop.org, aarch64-laptops@lists.linaro.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] clk: inherit clocks enabled by bootloader
Date:   Sun, 30 Jun 2019 08:01:39 -0700
Message-Id: <20190630150230.7878-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190630150230.7878-1-robdclark@gmail.com>
References: <20190630150230.7878-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

The goal here is to support inheriting a display setup by bootloader,
although there may also be some non-display related use-cases.

Rough idea is to add a flag for clks and power domains that might
already be enabled when kernel starts, and which should not be
disabled at late_initcall if the kernel thinks they are "unused".

If bootloader is enabling display, and kernel is using efifb before
real display driver is loaded (potentially from kernel module after
userspace starts, in a typical distro kernel), we don't want to kill
the clocks and power domains that are used by the display before
userspace starts.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/clk/clk.c                | 48 ++++++++++++++++++++++++++++++++
 drivers/clk/qcom/common.c        | 25 +++++++++++++++++
 drivers/clk/qcom/dispcc-sdm845.c | 22 ++++++++-------
 drivers/clk/qcom/gcc-sdm845.c    |  3 +-
 include/linux/clk-provider.h     | 10 +++++++
 5 files changed, 97 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index aa51756fd4d6..14460e87f508 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -66,6 +66,7 @@ struct clk_core {
 	unsigned long		flags;
 	bool			orphan;
 	bool			rpm_enabled;
+	bool			inherit_enabled; /* clock was enabled by bootloader */
 	unsigned int		enable_count;
 	unsigned int		prepare_count;
 	unsigned int		protect_count;
@@ -1166,6 +1167,9 @@ static void clk_unprepare_unused_subtree(struct clk_core *core)
 	hlist_for_each_entry(child, &core->children, child_node)
 		clk_unprepare_unused_subtree(child);
 
+	if (core->inherit_enabled)
+		return;
+
 	if (core->prepare_count)
 		return;
 
@@ -1197,6 +1201,9 @@ static void clk_disable_unused_subtree(struct clk_core *core)
 	hlist_for_each_entry(child, &core->children, child_node)
 		clk_disable_unused_subtree(child);
 
+	if (core->inherit_enabled)
+		return;
+
 	if (core->flags & CLK_OPS_PARENT_ENABLE)
 		clk_core_prepare_enable(core->parent);
 
@@ -1270,6 +1277,45 @@ static int clk_disable_unused(void)
 }
 late_initcall_sync(clk_disable_unused);
 
+/* Ignore CLK_INHERIT_BOOTLOADER clocks enabled by bootloader.  This
+ * gives a debug knob to disable inheriting clks from bootloader, so
+ * that drivers that used to work, when loaded as a module, thanks
+ * to disabling "unused" clocks at late_initcall(), can continue to
+ * work.
+ *
+ * The proper solution is to fix the drivers.
+ */
+static bool clk_ignore_inherited;
+static int __init clk_ignore_inherited_setup(char *__unused)
+{
+	clk_ignore_inherited = true;
+	return 1;
+}
+__setup("clk_ignore_inherited", clk_ignore_inherited_setup);
+
+/* clock and it's parents are already prepared/enabled from bootloader,
+ * so simply record the fact.
+ */
+static void __clk_inherit_enabled(struct clk_core *core)
+{
+	unsigned long parent_rate = 0;
+	core->inherit_enabled = true;
+	if (core->parent) {
+		__clk_inherit_enabled(core->parent);
+		parent_rate = core->parent->rate;
+	}
+	if (core->ops->recalc_rate)
+		core->rate = core->ops->recalc_rate(core->hw, parent_rate);
+}
+
+void clk_inherit_enabled(struct clk *clk)
+{
+	if (clk_ignore_inherited)
+		return;
+	__clk_inherit_enabled(clk->core);
+}
+EXPORT_SYMBOL_GPL(clk_inherit_enabled);
+
 static int clk_core_determine_round_nolock(struct clk_core *core,
 					   struct clk_rate_request *req)
 {
@@ -3302,6 +3348,8 @@ static int __clk_core_init(struct clk_core *core)
 		 * are enabled during init but might not have a parent yet.
 		 */
 		if (parent) {
+			if (orphan->inherit_enabled)
+				__clk_inherit_enabled(parent);
 			/* update the clk tree topology */
 			__clk_set_parent_before(orphan, parent);
 			__clk_set_parent_after(orphan, parent, NULL);
diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
index a6b2f86112d8..0d542eeef9aa 100644
--- a/drivers/clk/qcom/common.c
+++ b/drivers/clk/qcom/common.c
@@ -290,6 +290,31 @@ int qcom_cc_really_probe(struct platform_device *pdev,
 	if (ret)
 		return ret;
 
+	/*
+	 * Check which of clocks that we inherit state from bootloader
+	 * are enabled, and fixup enable/prepare state (as well as that
+	 * of it's parents).
+	 */
+	for (i = 0; i < num_clks; i++) {
+		struct clk_hw *hw;
+
+		if (!rclks[i])
+			continue;
+
+		hw = &rclks[i]->hw;
+
+		if (!(hw->init->flags & CLK_INHERIT_BOOTLOADER))
+			continue;
+
+		if (!clk_is_enabled_regmap(hw))
+			continue;
+
+		dev_dbg(dev, "%s is enabled from bootloader!\n",
+			hw->init->name);
+
+		clk_inherit_enabled(hw->clk);
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(qcom_cc_really_probe);
diff --git a/drivers/clk/qcom/dispcc-sdm845.c b/drivers/clk/qcom/dispcc-sdm845.c
index 0cc4909b5dbe..40d7e0ab4340 100644
--- a/drivers/clk/qcom/dispcc-sdm845.c
+++ b/drivers/clk/qcom/dispcc-sdm845.c
@@ -263,6 +263,7 @@ static struct clk_branch disp_cc_mdss_ahb_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "disp_cc_mdss_ahb_clk",
+			.flags = CLK_INHERIT_BOOTLOADER,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -276,6 +277,7 @@ static struct clk_branch disp_cc_mdss_axi_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "disp_cc_mdss_axi_clk",
+			.flags = CLK_INHERIT_BOOTLOADER,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -294,7 +296,7 @@ static struct clk_branch disp_cc_mdss_byte0_clk = {
 				"disp_cc_mdss_byte0_clk_src",
 			},
 			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
+			.flags = CLK_SET_RATE_PARENT | CLK_INHERIT_BOOTLOADER,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -330,7 +332,7 @@ static struct clk_branch disp_cc_mdss_byte0_intf_clk = {
 				"disp_cc_mdss_byte0_div_clk_src",
 			},
 			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
+			.flags = CLK_SET_RATE_PARENT | CLK_INHERIT_BOOTLOADER,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -349,7 +351,7 @@ static struct clk_branch disp_cc_mdss_byte1_clk = {
 				"disp_cc_mdss_byte1_clk_src",
 			},
 			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
+			.flags = CLK_SET_RATE_PARENT | CLK_INHERIT_BOOTLOADER,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -385,7 +387,7 @@ static struct clk_branch disp_cc_mdss_byte1_intf_clk = {
 				"disp_cc_mdss_byte1_div_clk_src",
 			},
 			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
+			.flags = CLK_SET_RATE_PARENT | CLK_INHERIT_BOOTLOADER,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -403,7 +405,7 @@ static struct clk_branch disp_cc_mdss_esc0_clk = {
 				"disp_cc_mdss_esc0_clk_src",
 			},
 			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
+			.flags = CLK_SET_RATE_PARENT | CLK_INHERIT_BOOTLOADER,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -421,7 +423,7 @@ static struct clk_branch disp_cc_mdss_esc1_clk = {
 				"disp_cc_mdss_esc1_clk_src",
 			},
 			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
+			.flags = CLK_SET_RATE_PARENT | CLK_INHERIT_BOOTLOADER,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -439,7 +441,7 @@ static struct clk_branch disp_cc_mdss_mdp_clk = {
 				"disp_cc_mdss_mdp_clk_src",
 			},
 			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
+			.flags = CLK_SET_RATE_PARENT | CLK_INHERIT_BOOTLOADER,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -475,7 +477,7 @@ static struct clk_branch disp_cc_mdss_pclk0_clk = {
 				"disp_cc_mdss_pclk0_clk_src",
 			},
 			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
+			.flags = CLK_SET_RATE_PARENT | CLK_INHERIT_BOOTLOADER,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -494,7 +496,7 @@ static struct clk_branch disp_cc_mdss_pclk1_clk = {
 				"disp_cc_mdss_pclk1_clk_src",
 			},
 			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
+			.flags = CLK_SET_RATE_PARENT | CLK_INHERIT_BOOTLOADER,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -561,7 +563,7 @@ static struct clk_branch disp_cc_mdss_vsync_clk = {
 				"disp_cc_mdss_vsync_clk_src",
 			},
 			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
+			.flags = CLK_SET_RATE_PARENT | CLK_INHERIT_BOOTLOADER,
 			.ops = &clk_branch2_ops,
 		},
 	},
diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
index 7131dcf9b060..fe2498be7bc7 100644
--- a/drivers/clk/qcom/gcc-sdm845.c
+++ b/drivers/clk/qcom/gcc-sdm845.c
@@ -1314,7 +1314,7 @@ static struct clk_branch gcc_disp_ahb_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_disp_ahb_clk",
-			.flags = CLK_IS_CRITICAL,
+			.flags = CLK_IS_CRITICAL | CLK_INHERIT_BOOTLOADER,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -1328,6 +1328,7 @@ static struct clk_branch gcc_disp_axi_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_disp_axi_clk",
+			.flags = CLK_INHERIT_BOOTLOADER,
 			.ops = &clk_branch2_ops,
 		},
 	},
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index bb6118f79784..41b951c8b92b 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -34,6 +34,7 @@
 #define CLK_OPS_PARENT_ENABLE	BIT(12)
 /* duty cycle call may be forwarded to the parent clock */
 #define CLK_DUTY_CYCLE_PARENT	BIT(13)
+#define CLK_INHERIT_BOOTLOADER	BIT(14) /* clk may be enabled from bootloader */
 
 struct clk;
 struct clk_hw;
@@ -349,6 +350,15 @@ void clk_hw_unregister_fixed_rate(struct clk_hw *hw);
 
 void of_fixed_clk_setup(struct device_node *np);
 
+/**
+ * clk_inherit_enabled - update the enable/prepare count of a clock and it's
+ * parents for clock enabled by bootloader.
+ *
+ * Intended to be used by clock drivers to inform the clk core of a clock
+ * that is already running.
+ */
+void clk_inherit_enabled(struct clk *clk);
+
 /**
  * struct clk_gate - gating clock
  *
-- 
2.20.1

