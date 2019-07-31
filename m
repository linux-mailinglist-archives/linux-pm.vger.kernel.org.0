Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 396647CF98
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 23:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbfGaVL7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 17:11:59 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:10584 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729092AbfGaVLK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2019 17:11:10 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d4203ec0001>; Wed, 31 Jul 2019 14:11:08 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 31 Jul 2019 14:11:08 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 31 Jul 2019 14:11:08 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 31 Jul
 2019 21:11:08 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 31 Jul
 2019 21:11:07 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 31 Jul 2019 21:11:08 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.102.167]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d4203eb0006>; Wed, 31 Jul 2019 14:11:07 -0700
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
Subject: [PATCH v7 09/20] clk: tegra: clk-super: Add save and restore support
Date:   Wed, 31 Jul 2019 14:10:52 -0700
Message-ID: <1564607463-28802-10-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564607463-28802-1-git-send-email-skomatineni@nvidia.com>
References: <1564607463-28802-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1564607469; bh=VmKb5n/2JIR1zlI4AVRsVa2NqvfH91G42xKZvFw0+7s=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=rFz2cCw5Z2lh2J88SbyFIBGUWr0rLUMfo4pDT+/i2m5q1MBwBmrtF69FvGxk/e+Nx
         fvm6LlxfQ9kVUUhXr3GKBCU8d5knVTv7tPLW3UErVWLiLKGFd2SozLUeSYp/ZCIdm8
         JhnOsgj0C+dHhPbfYYInCkyWilw30aIerqEmy3Gdbwm7PiVrUEBzV/xjsbA2CsU0L7
         Rvc72kRReLbbjxGLGKTe/pxyKbjaYxbZnKQInXF+dzArFJq46ESBJ7dm5pUlYtjxNt
         upbVw+Wm3JS4BO8cQsHXg22CDpDeJeoaeiKY6Kh+6byDrYhFeD4RT38u5sqQKJIAvC
         gF8SWN6jgjZHA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch implements save and restore context for clk_super_mux
and clk_super.

During system supend, core power goes off the and context of Tegra
CAR registers is lost.

So during suspend entry, context of super clock registers are saved
through save_context clk_ops and are restored through restore_context
clk_ops to have them in same state as before suspend.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/clk/tegra/clk-super.c | 39 +++++++++++++++++++++++++++++++++++++++
 drivers/clk/tegra/clk.h       |  1 +
 2 files changed, 40 insertions(+)

diff --git a/drivers/clk/tegra/clk-super.c b/drivers/clk/tegra/clk-super.c
index e2a1e95a8db7..be0551cb5587 100644
--- a/drivers/clk/tegra/clk-super.c
+++ b/drivers/clk/tegra/clk-super.c
@@ -124,9 +124,27 @@ static int clk_super_set_parent(struct clk_hw *hw, u8 index)
 	return err;
 }
 
+static int clk_super_mux_save_context(struct clk_hw *hw)
+{
+	struct tegra_clk_super_mux *mux = to_clk_super_mux(hw);
+
+	mux->parent_index_ctx = clk_super_get_parent(hw);
+
+	return 0;
+}
+
+static void clk_super_mux_restore_context(struct clk_hw *hw)
+{
+	struct tegra_clk_super_mux *mux = to_clk_super_mux(hw);
+
+	clk_super_set_parent(hw, mux->parent_index_ctx);
+}
+
 static const struct clk_ops tegra_clk_super_mux_ops = {
 	.get_parent = clk_super_get_parent,
 	.set_parent = clk_super_set_parent,
+	.save_context = clk_super_mux_save_context,
+	.restore_context = clk_super_mux_restore_context,
 };
 
 static long clk_super_round_rate(struct clk_hw *hw, unsigned long rate,
@@ -162,12 +180,33 @@ static int clk_super_set_rate(struct clk_hw *hw, unsigned long rate,
 	return super->div_ops->set_rate(div_hw, rate, parent_rate);
 }
 
+static int clk_super_save_context(struct clk_hw *hw)
+{
+	struct tegra_clk_super_mux *super = to_clk_super_mux(hw);
+
+	super->parent_index_ctx = clk_super_get_parent(hw);
+
+	return 0;
+}
+
+static void clk_super_restore_context(struct clk_hw *hw)
+{
+	struct tegra_clk_super_mux *super = to_clk_super_mux(hw);
+	struct clk_hw *div_hw = &super->frac_div.hw;
+
+	clk_super_set_parent(hw, super->parent_index_ctx);
+
+	super->div_ops->restore_context(div_hw);
+}
+
 const struct clk_ops tegra_clk_super_ops = {
 	.get_parent = clk_super_get_parent,
 	.set_parent = clk_super_set_parent,
 	.set_rate = clk_super_set_rate,
 	.round_rate = clk_super_round_rate,
 	.recalc_rate = clk_super_recalc_rate,
+	.save_context = clk_super_save_context,
+	.restore_context = clk_super_restore_context,
 };
 
 struct clk *tegra_clk_register_super_mux(const char *name,
diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
index f8de447f505b..d397dda7c6d0 100644
--- a/drivers/clk/tegra/clk.h
+++ b/drivers/clk/tegra/clk.h
@@ -701,6 +701,7 @@ struct tegra_clk_super_mux {
 	u8		div2_index;
 	u8		pllx_index;
 	spinlock_t	*lock;
+	u8		parent_index_ctx;
 };
 
 #define to_clk_super_mux(_hw) container_of(_hw, struct tegra_clk_super_mux, hw)
-- 
2.7.4

