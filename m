Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA08690856
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2019 21:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbfHPTme (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Aug 2019 15:42:34 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13117 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727671AbfHPTma (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Aug 2019 15:42:30 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d5707270000>; Fri, 16 Aug 2019 12:42:31 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 16 Aug 2019 12:42:29 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 16 Aug 2019 12:42:29 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 16 Aug
 2019 19:42:28 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 16 Aug 2019 19:42:28 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.166.126]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d5707230000>; Fri, 16 Aug 2019 12:42:28 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <linus.walleij@linaro.org>,
        <stefan@agner.ch>, <mark.rutland@arm.com>
CC:     <pdeschrijver@nvidia.com>, <pgaikwad@nvidia.com>,
        <sboyd@kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <jckuo@nvidia.com>,
        <josephl@nvidia.com>, <talho@nvidia.com>, <skomatineni@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mperttunen@nvidia.com>, <spatra@nvidia.com>, <robh+dt@kernel.org>,
        <digetx@gmail.com>, <devicetree@vger.kernel.org>,
        <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH v9 08/22] clk: tegra: periph: Add restore_context support
Date:   Fri, 16 Aug 2019 12:41:53 -0700
Message-ID: <1565984527-5272-9-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565984527-5272-1-git-send-email-skomatineni@nvidia.com>
References: <1565984527-5272-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565984551; bh=Iw7xdi6+oXEPCLHWZuUnzXeVEWHm9P1Mfz/SFOgojZQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=hpjFWmoRpyfhFFpo24s/ZNMW/cE69NP7i2554krL9bjJFm4p+5s2DAcpqqCrHPByT
         hIEBxZeAFKQ249hBU8q4hIeAdVn9aOt0CxJmVb6mDWaeIdmCezhQS45MQHp+Xmb3PY
         fi9OhkmR1IHjFY4Y3eTofMcDkGur9dKDm941KBhmvyag/ZECE85ycQoSEf8dVh2WMT
         lf63fL94ol3YtJwfmH3+KSQLEzEcT5yX36bMvZXFEXffBHG7dww/7ptbbPB/zXd28f
         ZByMviowPBbrDa0eWkzo7iUDghWdFOfVNJXQbryraX47QfqSnxFSHlPp8DidhJzE2u
         nvQukDXZCwA8g==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch implements restore_context support for clk-periph and
clk-sdmmc-mux clock operations to restore clock parent and rates
on system resume.

During system suspend, core power goes off and looses the context
of the Tegra clock controller registers.

So on system resume, clocks parent and rate are restored back to
the context before suspend based on cached data.

Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/clk/tegra/clk-periph.c    | 18 ++++++++++++++++++
 drivers/clk/tegra/clk-sdmmc-mux.c | 12 ++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/clk/tegra/clk-periph.c b/drivers/clk/tegra/clk-periph.c
index 58437da25156..c9d28cbadccc 100644
--- a/drivers/clk/tegra/clk-periph.c
+++ b/drivers/clk/tegra/clk-periph.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2012, NVIDIA CORPORATION.  All rights reserved.
  */
 
+#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/export.h>
 #include <linux/slab.h>
@@ -99,6 +100,20 @@ static void clk_periph_disable(struct clk_hw *hw)
 	gate_ops->disable(gate_hw);
 }
 
+static void clk_periph_restore_context(struct clk_hw *hw)
+{
+	struct tegra_clk_periph *periph = to_clk_periph(hw);
+	const struct clk_ops *div_ops = periph->div_ops;
+	struct clk_hw *div_hw = &periph->divider.hw;
+	struct clk_hw *parent = clk_hw_get_parent(hw);
+	int parent_id = clk_hw_get_parent_index(hw, parent);
+
+	if (!(periph->gate.flags & TEGRA_PERIPH_NO_DIV))
+		div_ops->restore_context(div_hw);
+
+	clk_periph_set_parent(hw, parent_id);
+}
+
 const struct clk_ops tegra_clk_periph_ops = {
 	.get_parent = clk_periph_get_parent,
 	.set_parent = clk_periph_set_parent,
@@ -108,6 +123,7 @@ const struct clk_ops tegra_clk_periph_ops = {
 	.is_enabled = clk_periph_is_enabled,
 	.enable = clk_periph_enable,
 	.disable = clk_periph_disable,
+	.restore_context = clk_periph_restore_context,
 };
 
 static const struct clk_ops tegra_clk_periph_nodiv_ops = {
@@ -116,6 +132,7 @@ static const struct clk_ops tegra_clk_periph_nodiv_ops = {
 	.is_enabled = clk_periph_is_enabled,
 	.enable = clk_periph_enable,
 	.disable = clk_periph_disable,
+	.restore_context = clk_periph_restore_context,
 };
 
 static const struct clk_ops tegra_clk_periph_no_gate_ops = {
@@ -124,6 +141,7 @@ static const struct clk_ops tegra_clk_periph_no_gate_ops = {
 	.recalc_rate = clk_periph_recalc_rate,
 	.round_rate = clk_periph_round_rate,
 	.set_rate = clk_periph_set_rate,
+	.restore_context = clk_periph_restore_context,
 };
 
 static struct clk *_tegra_clk_register_periph(const char *name,
diff --git a/drivers/clk/tegra/clk-sdmmc-mux.c b/drivers/clk/tegra/clk-sdmmc-mux.c
index a5cd3e31dbae..8db48966b100 100644
--- a/drivers/clk/tegra/clk-sdmmc-mux.c
+++ b/drivers/clk/tegra/clk-sdmmc-mux.c
@@ -194,6 +194,17 @@ static void clk_sdmmc_mux_disable(struct clk_hw *hw)
 	gate_ops->disable(gate_hw);
 }
 
+static void clk_sdmmc_mux_restore_context(struct clk_hw *hw)
+{
+	struct clk_hw *parent = clk_hw_get_parent(hw);
+	unsigned long parent_rate = clk_hw_get_rate(parent);
+	unsigned long rate = clk_hw_get_rate(hw);
+	int parent_id = clk_hw_get_parent_index(hw, parent);
+
+	clk_sdmmc_mux_set_parent(hw, parent_id);
+	clk_sdmmc_mux_set_rate(hw, rate, parent_rate);
+}
+
 static const struct clk_ops tegra_clk_sdmmc_mux_ops = {
 	.get_parent = clk_sdmmc_mux_get_parent,
 	.set_parent = clk_sdmmc_mux_set_parent,
@@ -203,6 +214,7 @@ static const struct clk_ops tegra_clk_sdmmc_mux_ops = {
 	.is_enabled = clk_sdmmc_mux_is_enabled,
 	.enable = clk_sdmmc_mux_enable,
 	.disable = clk_sdmmc_mux_disable,
+	.restore_context = clk_sdmmc_mux_restore_context,
 };
 
 struct clk *tegra_clk_register_sdmmc_mux_div(const char *name,
-- 
2.7.4

