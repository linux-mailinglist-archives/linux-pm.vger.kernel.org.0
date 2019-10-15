Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28F60D81E7
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2019 23:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389850AbfJOVSY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Oct 2019 17:18:24 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42887 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbfJOVRF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Oct 2019 17:17:05 -0400
Received: by mail-lj1-f194.google.com with SMTP id y23so21723526lje.9;
        Tue, 15 Oct 2019 14:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7xbFab5w+z8oPGuGoizSXNjpUrRQM06nz1UpWD5n1gs=;
        b=PI2ztGhX6G+eTN5wxOnEvU+jnYK3ucCK4n7/ucpGetS8gifhnuwOtIDKdrQK9OrijX
         9RsJ81t62XqtY0OXi2Lx7fF5x8fGlm53PMimF/1l0s6bPTC+GCKW+6FD+dkmAC2LbVEw
         o2/SOTchgRT6F7F10Jf4jNNk05kNVB0xLz/7zxMJYEiQ1EvpeprKgwQTOeFBGGhZMgCa
         2eEqjjlRO7Md0C0hKtq71vOO6kG0M0WapzUw5bAx6g/ojK5kfqPVXVwqTfDF5/zuu6VA
         ar75Wbhy566QERlrPsu2QC/3YiBHjbAbs0M0tAVHEfEjvj/yNTxpk/BlvPDxnfYU1eWe
         cONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7xbFab5w+z8oPGuGoizSXNjpUrRQM06nz1UpWD5n1gs=;
        b=UTPHIfoZDE1rK1/PFuZoGk0+HrSmHKe4EP6Tav9TtsmnDNjDV4UUZZuy1aupqUqy82
         HAZM42ItrHggr/0zioZwAGDpx7Vutm1ZzNet8b2aprZD8u5df7qHecbRjWqn4PXSmxct
         QhETpFgSAgayjd1QC49zTsF3uC8XOHuCLDLI7niVcBA90U97VIq9COHVX7k/9TRawJvu
         Ob+oEp5E54Hc2VGw6HmiSft/gPyD5oeW5TrbJ9J1dMnXtgaiRNkyRF3E5RDo2UcoeJJG
         5fV2ygJJNvTnAmFdStBd4qEHzgpi0vMxfsn0NrRDU2SHOohu9fOxDgvuoq9BC9nyD/ZZ
         8ooQ==
X-Gm-Message-State: APjAAAXiMMDSvEXqLhf3fI6M/0Y4QDyH6ds3AFtjlFiBRg1mOY8YP4kK
        oMHHrDCfcTejkqlW1Ktqj58=
X-Google-Smtp-Source: APXvYqyrIAUwcH5Ok6jcSErAPszXnbt4fsivAE3JbjH91ZVJBOWC/tjrCxc3XAheLtlvBsFgP3Icng==
X-Received: by 2002:a2e:95d9:: with SMTP id y25mr24066214ljh.217.1571174220087;
        Tue, 15 Oct 2019 14:17:00 -0700 (PDT)
Received: from localhost.localdomain ([94.29.10.250])
        by smtp.gmail.com with ESMTPSA id t16sm5269186ljj.29.2019.10.15.14.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 14:16:59 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 01/17] clk: tegra: Add custom CCLK implementation
Date:   Wed, 16 Oct 2019 00:16:02 +0300
Message-Id: <20191015211618.20758-2-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015211618.20758-1-digetx@gmail.com>
References: <20191015211618.20758-1-digetx@gmail.com>
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
 drivers/clk/tegra/clk-tegra-super-cclk.c | 131 +++++++++++++++++++++++
 drivers/clk/tegra/clk.h                  |   4 +
 3 files changed, 136 insertions(+)
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
index 000000000000..9b41365c4331
--- /dev/null
+++ b/drivers/clk/tegra/clk-tegra-super-cclk.c
@@ -0,0 +1,131 @@
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
+	super->frac_div.flags = TEGRA_DIVIDER_SUPER;
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

