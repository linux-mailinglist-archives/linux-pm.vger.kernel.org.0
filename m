Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 462A3F81A2
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2019 21:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfKKU5M (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 15:57:12 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33636 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbfKKU5L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Nov 2019 15:57:11 -0500
Received: by mail-lj1-f193.google.com with SMTP id t5so15343944ljk.0;
        Mon, 11 Nov 2019 12:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r/nohohxRUMshQs6j2Da0FE/YxPnOOD2XZg9k5AEvZQ=;
        b=d+MjqgYBlvBJrc8Jcf9CovJLPhwry8+7PcJUP1QHms45xANHtVvgvfA1MPXW7UiZf9
         4HHKtv8oLg07p2QWVAoUTeTlpBq7jSRBERkmz+1dv8xLGTV8/LQk0K5eywhm3CCb+IX0
         wpUV6tFH6yVahbVBg40rAVhli206TPnnVHHWcUHqC6L5VDQzljHWhW6HKzCZVC3keVYk
         DkS27rRbx3/ZOtRfG1pgNShnZfEgtj9MV1t8tuNr4RNWF6ewnUqwVKxwj1qw9qTJzE5f
         HoktscE6hPFCShDTGjf+5h+jcoTh/X9dMPZ5fxvNeCEDk9LhjEQtNZR1FFcdbikIBDUr
         uRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r/nohohxRUMshQs6j2Da0FE/YxPnOOD2XZg9k5AEvZQ=;
        b=qJWXlsVNbm53CqZhmNtQCTB0PNxzrsgCGwyPRabi3KfmQuOUwVszvsBzjQj6cqinVa
         eREp83f0PnZeopzdrb30v5s6HfA5sdE8nai5klJOoOY/6xHgSCce8ychEzBejUtEzTKN
         IYoyY3Ku9/EryIpHC448KcaG9KesWbazQITda83N0v9K2cMpCS68++0FwtXGiAKbtk+Q
         UOdlstEhnzq6oOuWWmGforqr8ON+3ox3P9qQoG/WTktxPMCKicHnJP8tE9srpTURg8If
         iRZW6otzvhHmPyYLYmLyT8ZX+6C1nfJw1gr357vVRh+c7SFoV97zueAosRjk63NZdc7h
         KTdA==
X-Gm-Message-State: APjAAAUwfYPOiVsi1xiTvzaw+sNwDL56/jTEDPALItRMREUlEERt61W7
        bzIxtey/uebfwoTa5UhjWGo=
X-Google-Smtp-Source: APXvYqxBEnhUVWw2j4RDVZgbbw9rwVz2nRII/o0f5IQFygcvvF5m+16VRHTvWD289iiuNEvRC74FyA==
X-Received: by 2002:a2e:94d6:: with SMTP id r22mr17340469ljh.7.1573505827793;
        Mon, 11 Nov 2019 12:57:07 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id q124sm7423784ljq.93.2019.11.11.12.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 12:57:07 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/10] clk: tegra: Add custom CCLK implementation
Date:   Mon, 11 Nov 2019 23:54:10 +0300
Message-Id: <20191111205419.16768-2-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191111205419.16768-1-digetx@gmail.com>
References: <20191111205419.16768-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

CCLK stands for "CPU Clock", CPU core is running off CCLK. CCLK supports
multiple parents, it has internal clock divider and a clock skipper.
PLLX is the main CCLK parent that provides clock rates above 1GHz and it
has special property such that the CCLK's internal divider is set into
bypass mode when PLLX is selected as a parent for CCLK.

This patch forks generic Super Clock into CCLK implementation which takes
into account all CCLK specifics. The proper CCLK implementation is needed
by the upcoming Tegra20 CPUFreq driver update that will allow to utilize
the generic cpufreq-dt driver by moving intermediate clock selection into
the clock driver.

Note that technically this patch could be squashed into clk-super.c, but
it is cleaner to have a separate source file. Also note that currently all
CCLKLP bits are left in the clk-super.c and only CCLKG is supported by
clk-tegra-super-cclk. It shouldn't be difficult to move the CCLKLP bits,
but CCLKLP is not used by anything in kernel and thus better not to touch
it for now.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/tegra/Makefile               |   1 +
 drivers/clk/tegra/clk-tegra-super-cclk.c | 178 +++++++++++++++++++++++
 drivers/clk/tegra/clk.h                  |  11 +-
 3 files changed, 188 insertions(+), 2 deletions(-)
 create mode 100644 drivers/clk/tegra/clk-tegra-super-cclk.c

diff --git a/drivers/clk/tegra/Makefile b/drivers/clk/tegra/Makefile
index df966ca06788..f04b490f5416 100644
--- a/drivers/clk/tegra/Makefile
+++ b/drivers/clk/tegra/Makefile
@@ -14,6 +14,7 @@ obj-y					+= clk-tegra-audio.o
 obj-y					+= clk-tegra-periph.o
 obj-y					+= clk-tegra-pmc.o
 obj-y					+= clk-tegra-fixed.o
+obj-y					+= clk-tegra-super-cclk.o
 obj-y					+= clk-tegra-super-gen4.o
 obj-$(CONFIG_TEGRA_CLK_EMC)		+= clk-emc.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += clk-tegra20.o
diff --git a/drivers/clk/tegra/clk-tegra-super-cclk.c b/drivers/clk/tegra/clk-tegra-super-cclk.c
new file mode 100644
index 000000000000..7bcb9e8d0860
--- /dev/null
+++ b/drivers/clk/tegra/clk-tegra-super-cclk.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Based on clk-super.c
+ * Copyright (c) 2012, NVIDIA CORPORATION.  All rights reserved.
+ *
+ * Based on older tegra20-cpufreq driver by Colin Cross <ccross@google.com>
+ * Copyright (C) 2010 Google, Inc.
+ *
+ * Author: Dmitry Osipenko <digetx@gmail.com>
+ * Copyright (C) 2019 GRATE-DRIVER project
+ */
+
+#include <linux/bits.h>
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+#include "clk.h"
+
+#define PLLP_INDEX		4
+#define PLLX_INDEX		8
+
+#define SUPER_CDIV_ENB		BIT(31)
+
+static u8 cclk_super_get_parent(struct clk_hw *hw)
+{
+	return tegra_clk_super_ops.get_parent(hw);
+}
+
+static int cclk_super_set_parent(struct clk_hw *hw, u8 index)
+{
+	return tegra_clk_super_ops.set_parent(hw, index);
+}
+
+static int cclk_super_set_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long parent_rate)
+{
+	return tegra_clk_super_ops.set_rate(hw, rate, parent_rate);
+}
+
+static unsigned long cclk_super_recalc_rate(struct clk_hw *hw,
+					    unsigned long parent_rate)
+{
+	if (cclk_super_get_parent(hw) == PLLX_INDEX)
+		return parent_rate;
+
+	return tegra_clk_super_ops.recalc_rate(hw, parent_rate);
+}
+
+static int cclk_super_determine_rate(struct clk_hw *hw,
+				     struct clk_rate_request *req)
+{
+	struct clk_hw *pllp_hw = clk_hw_get_parent_by_index(hw, PLLP_INDEX);
+	struct clk_hw *pllx_hw = clk_hw_get_parent_by_index(hw, PLLX_INDEX);
+	struct tegra_clk_super_mux *super = to_clk_super_mux(hw);
+	unsigned long pllp_rate;
+	long rate = req->rate;
+
+	if (WARN_ON_ONCE(!pllp_hw || !pllx_hw))
+		return -EINVAL;
+
+	/*
+	 * Switch parent to PLLP for all CCLK rates that are suitable for PLLP.
+	 * PLLX will be disabled in this case, saving some power.
+	 */
+	pllp_rate = clk_hw_get_rate(pllp_hw);
+
+	if (rate <= pllp_rate) {
+		if (super->flags & TEGRA20_SUPER_CLK)
+			rate = pllp_rate;
+		else
+			rate = tegra_clk_super_ops.round_rate(hw, rate,
+							      &pllp_rate);
+
+		req->best_parent_rate = pllp_rate;
+		req->best_parent_hw = pllp_hw;
+		req->rate = rate;
+	} else {
+		rate = clk_hw_round_rate(pllx_hw, rate);
+		req->best_parent_rate = rate;
+		req->best_parent_hw = pllx_hw;
+		req->rate = rate;
+	}
+
+	if (WARN_ON_ONCE(rate <= 0))
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct clk_ops tegra_cclk_super_ops = {
+	.get_parent = cclk_super_get_parent,
+	.set_parent = cclk_super_set_parent,
+	.set_rate = cclk_super_set_rate,
+	.recalc_rate = cclk_super_recalc_rate,
+	.determine_rate = cclk_super_determine_rate,
+};
+
+static const struct clk_ops tegra_cclk_super_mux_ops = {
+	.get_parent = cclk_super_get_parent,
+	.set_parent = cclk_super_set_parent,
+	.determine_rate = cclk_super_determine_rate,
+};
+
+struct clk *tegra_clk_register_super_cclk(const char *name,
+		const char * const *parent_names, u8 num_parents,
+		unsigned long flags, void __iomem *reg, u8 clk_super_flags,
+		spinlock_t *lock)
+{
+	struct tegra_clk_super_mux *super;
+	struct clk *clk;
+	struct clk_init_data init;
+	u32 val;
+
+	super = kzalloc(sizeof(*super), GFP_KERNEL);
+	if (!super)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.flags = flags;
+	init.parent_names = parent_names;
+	init.num_parents = num_parents;
+
+	super->reg = reg;
+	super->lock = lock;
+	super->width = 4;
+	super->flags = clk_super_flags;
+	super->hw.init = &init;
+
+	if (super->flags & TEGRA20_SUPER_CLK) {
+		init.ops = &tegra_cclk_super_mux_ops;
+	} else {
+		init.ops = &tegra_cclk_super_ops;
+
+		super->frac_div.reg = reg + 4;
+		super->frac_div.shift = 16;
+		super->frac_div.width = 8;
+		super->frac_div.frac_width = 1;
+		super->frac_div.lock = lock;
+		super->div_ops = &tegra_clk_frac_div_ops;
+	}
+
+	/*
+	 * Tegra30+ has the following CPUG clock topology:
+	 *
+	 *        +---+  +-------+  +-+            +-+                +-+
+	 * PLLP+->+   +->+DIVIDER+->+0|  +-------->+0|  ------------->+0|
+	 *        |   |  +-------+  | |  |  +---+  | |  |             | |
+	 * PLLC+->+MUX|             | +->+  | S |  | +->+             | +->+CPU
+	 *  ...   |   |             | |  |  | K |  | |  |  +-------+  | |
+	 * PLLX+->+-->+------------>+1|  +->+ I +->+1|  +->+ DIV2  +->+1|
+	 *        +---+             +++     | P |  +++     |SKIPPER|  +++
+	 *                           ^      | P |   ^      +-------+   ^
+	 *                           |      | E |   |                  |
+	 *                PLLX_SEL+--+      | R |   |       OVERHEAT+--+
+	 *                                  +---+   |
+	 *                                          |
+	 *                         SUPER_CDIV_ENB+--+
+	 *
+	 * Tegra20 is similar, but simpler. It doesn't have the divider and
+	 * thermal DIV2 skipper.
+	 *
+	 * At least for now we're not going to use clock-skipper, hence let's
+	 * ensure that it is disabled.
+	 */
+	val = readl_relaxed(reg + 4);
+	val &= ~SUPER_CDIV_ENB;
+	writel_relaxed(val, reg + 4);
+
+	clk = clk_register(NULL, &super->hw);
+	if (IS_ERR(clk))
+		kfree(super);
+
+	return clk;
+}
diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
index 416a6b09f6a3..ee35a847df08 100644
--- a/drivers/clk/tegra/clk.h
+++ b/drivers/clk/tegra/clk.h
@@ -729,8 +729,10 @@ struct clk *tegra_clk_register_periph_data(void __iomem *clk_base,
  * TEGRA_DIVIDER_2 - LP cluster has additional divider. This flag indicates
  *     that this is LP cluster clock.
  * TEGRA210_CPU_CLK - This flag is used to identify CPU cluster for gen5
- * super mux parent using PLLP branches. To use PLLP branches to CPU, need
- * to configure additional bit PLLP_OUT_CPU in the clock registers.
+ *     super mux parent using PLLP branches. To use PLLP branches to CPU, need
+ *     to configure additional bit PLLP_OUT_CPU in the clock registers.
+ * TEGRA20_SUPER_CLK - Tegra20 doesn't have a dedicated divider for Super
+ *     clocks, it only has a clock-skipper.
  */
 struct tegra_clk_super_mux {
 	struct clk_hw	hw;
@@ -748,6 +750,7 @@ struct tegra_clk_super_mux {
 
 #define TEGRA_DIVIDER_2 BIT(0)
 #define TEGRA210_CPU_CLK BIT(1)
+#define TEGRA20_SUPER_CLK BIT(2)
 
 extern const struct clk_ops tegra_clk_super_ops;
 struct clk *tegra_clk_register_super_mux(const char *name,
@@ -758,6 +761,10 @@ struct clk *tegra_clk_register_super_clk(const char *name,
 		const char * const *parent_names, u8 num_parents,
 		unsigned long flags, void __iomem *reg, u8 clk_super_flags,
 		spinlock_t *lock);
+struct clk *tegra_clk_register_super_cclk(const char *name,
+		const char * const *parent_names, u8 num_parents,
+		unsigned long flags, void __iomem *reg, u8 clk_super_flags,
+		spinlock_t *lock);
 
 /**
  * struct tegra_sdmmc_mux - switch divider with Low Jitter inputs for SDMMC
-- 
2.23.0

