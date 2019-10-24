Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAD37E3F36
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2019 00:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730473AbfJXWRl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Oct 2019 18:17:41 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46518 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730392AbfJXWRj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Oct 2019 18:17:39 -0400
Received: by mail-lf1-f66.google.com with SMTP id t8so20394285lfc.13;
        Thu, 24 Oct 2019 15:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P7r1JveAIqyLm3r1wtY/Vz+szyXKA9MyIuS1vQVkji8=;
        b=nlDm8gE56aZHavH/kqueGA1mMGhGRC81srrkwhE+5nH819m9ayNFxEwi1Efzo+VToF
         5caUMbg7Sn4L6MHbQP9MUaTeq+61X+xS/Jea7FEfjwhM9PiXJEgHKmJZtwwIh+6onszk
         HdFJ03+3tc/HHNnRu/iGMC1/ZUW1JsXbsnGyAlCMGs8EEOTzExQHzBoB59v5thNSxCRL
         497cvp82K2ZEFUKzGPBxi/VNSRCYkTqsMNyZuYNn5TjIVqVqlwPHtPRB1NGJEF9HbTzz
         G/wp5dhnPZcDdGY+A6CbBcgolHMkXK+1alnpv0qGKccHHTecsMmWKxRTn5by0mLiPh1Z
         oGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P7r1JveAIqyLm3r1wtY/Vz+szyXKA9MyIuS1vQVkji8=;
        b=Mxr6AXpEwtoU1/dfPb2DBVqXm4gzEytef5FuJoAvT9s241l99SlWa7cFnwf9eTjSWD
         9faFQTqzYKwlKVH1XNMbfygPJm+KVUB1xPcMmgi6NzQztzEwTdXzpV1kK3HBJE8ELWPt
         kHKcOvExWYNTb4F7u6wnvjY6+QlzlSr0Wb9X8ox9VbL1tm7eYF/Zebv9bOunGPap3YSs
         YjLzR/qQvpyKnNczVfPwYLYgRLv4urBzFm4fnX1Gog9WwAzbH8pfru3PNihYY3Xdzqj/
         fUKpGMwRjKxHArKZ10ys15sQVDemwTvs+jMuU0zL8V9ak9fImeRSCdcE9ML2VyOWCbR2
         LV3w==
X-Gm-Message-State: APjAAAVbo9P0ZFwxQNQYC5EnN+vACfVtgWeBOaC4dHiNfpOGtco4dGgW
        5DGcMxd7C5BtnRofOJ7t2oI=
X-Google-Smtp-Source: APXvYqyTApG9CZu/bZ91A7cDtCViE8KDUn7jW/yf/WxGDNmCchp89rCP5mywU6mgZl7C4iFsKbVQrw==
X-Received: by 2002:a19:3845:: with SMTP id d5mr288034lfj.162.1571955455175;
        Thu, 24 Oct 2019 15:17:35 -0700 (PDT)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id i6sm11338765lfo.83.2019.10.24.15.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 15:17:34 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/17] clk: tegra: Add custom CCLK implementation
Date:   Fri, 25 Oct 2019 01:14:00 +0300
Message-Id: <20191024221416.14197-2-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024221416.14197-1-digetx@gmail.com>
References: <20191024221416.14197-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

CCLK stands for "CPU Clock", CPU core is running off CCLK. CCLK supports
multiple parents and it has internal clock divider which uses clock
skipping technique, meaning that CPU's voltage should correspond to the
parent clock rate and not CCLK. PLLX is the main CCLK parent that provides
clock rates above 1GHz and it has special property such that the CCLK's
internal divider is set into bypass mode when PLLX is set as a parent for
CCLK.

This patch forks generic Super Clock into CCLK implementation which takes
into account all CCLK specifics. The proper CCLK implementation is needed
by the upcoming Tegra20 CPUFreq driver update that will allow to utilize
the generic cpufreq-dt driver by moving intermediate clock handling into
the clock driver. Note that technically this all could be squashed into
clk-super, but result will be messier.

Note that currently all CCLKLP bits are left in the clk-super.c and only
CCLKG is supported by clk-tegra-super-cclk. It shouldn't be difficult
to move the CCLKLP bits, but CCLKLP is not used by anything in kernel
and thus better not to touch it for now.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/tegra/Makefile               |   1 +
 drivers/clk/tegra/clk-tegra-super-cclk.c | 130 +++++++++++++++++++++++
 drivers/clk/tegra/clk.h                  |   4 +
 3 files changed, 135 insertions(+)
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
index 000000000000..a032d2701fc9
--- /dev/null
+++ b/drivers/clk/tegra/clk-tegra-super-cclk.c
@@ -0,0 +1,130 @@
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
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+#include "clk.h"
+
+#define PLLP_INDEX	4
+#define PLLX_INDEX	8
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
+	unsigned long pllp_rate;
+	long rate = req->rate;
+
+	if (WARN_ON_ONCE(!pllp_hw || !pllx_hw))
+		return -EINVAL;
+
+	/*
+	 * It is okay to run off PLLP for all CCLK rates below PLLP rate.
+	 * PLLX will be disabled in this case, saving some power.
+	 */
+	pllp_rate = clk_hw_get_rate(pllp_hw);
+
+	if (rate <= pllp_rate) {
+		rate = tegra_clk_super_ops.round_rate(hw, rate, &pllp_rate);
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
+struct clk *tegra_clk_register_super_cclk(const char *name,
+		const char * const *parent_names, u8 num_parents,
+		unsigned long flags, void __iomem *reg, u8 clk_super_flags,
+		spinlock_t *lock)
+{
+	struct tegra_clk_super_mux *super;
+	struct clk *clk;
+	struct clk_init_data init;
+
+	super = kzalloc(sizeof(*super), GFP_KERNEL);
+	if (!super)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &tegra_cclk_super_ops;
+	init.flags = flags;
+	init.parent_names = parent_names;
+	init.num_parents = num_parents;
+
+	super->reg = reg;
+	super->lock = lock;
+	super->width = 4;
+	super->flags = clk_super_flags;
+	super->frac_div.reg = reg + 4;
+	super->frac_div.shift = 16;
+	super->frac_div.width = 8;
+	super->frac_div.frac_width = 1;
+	super->frac_div.lock = lock;
+	super->div_ops = &tegra_clk_frac_div_ops;
+
+	/* Data in .init is copied by clk_register(), so stack variable OK */
+	super->hw.init = &init;
+
+	clk = clk_register(NULL, &super->hw);
+	if (IS_ERR(clk))
+		kfree(super);
+
+	return clk;
+}
diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
index f81c10654aa9..095595a5b8a8 100644
--- a/drivers/clk/tegra/clk.h
+++ b/drivers/clk/tegra/clk.h
@@ -699,6 +699,10 @@ struct clk *tegra_clk_register_super_clk(const char *name,
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

