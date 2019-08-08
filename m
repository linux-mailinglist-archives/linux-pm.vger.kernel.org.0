Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDB586E53
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2019 01:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405239AbfHHXsS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Aug 2019 19:48:18 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:12775 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404866AbfHHXrG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Aug 2019 19:47:06 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d4cb4820002>; Thu, 08 Aug 2019 16:47:14 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 08 Aug 2019 16:47:04 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 08 Aug 2019 16:47:04 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 8 Aug
 2019 23:47:04 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 8 Aug 2019 23:47:03 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.110]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d4cb4770006>; Thu, 08 Aug 2019 16:47:03 -0700
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
Subject: [PATCH v8 10/21] clk: tegra: clk-super: Add restore-context support
Date:   Thu, 8 Aug 2019 16:46:49 -0700
Message-ID: <1565308020-31952-11-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565308020-31952-1-git-send-email-skomatineni@nvidia.com>
References: <1565308020-31952-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565308034; bh=w//Hbn4E07WwrvoLDUOaPoY8xfvJCMT98F/MANtJWFA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=mdEa4xvJEy+wUt5Vg5TPqicLdUDeEm4jPNE1vHHoDh7xan1gt5dBse0oxVWlrNAhE
         67zQheJ9gzK6QaaW5JmwjE8MZI/ufdKSVvLRAyBjEMWr2YdMjgMyJtfx/YmUvi8Lqt
         yfmOEJ0pdRQNhMJRo8NOj2okEtvSEzXGIKKGCf8PqVPcudwvFKal0OfHVbEF1ipw8B
         yUqYIJftjmiTL14+W3IH7yYJi5gZP1ztMFTtYhTsz6YmGeR2ingrrViz5MBycGpGup
         HXnN2WQDo3YMjjZLnkWfDNFnKIRjhPUyW4if5Feg5aPC+Hvxe0VYIeWGELs0JV50A8
         nvTF3nAksmi5w==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch implements restore_context for clk_super_mux and clk_super.

During system supend, core power goes off the and context of Tegra
CAR registers is lost.

So on system resume, context of super clock registers are restored
to have them in same state as before suspend.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/clk/tegra/clk-super.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/clk/tegra/clk-super.c b/drivers/clk/tegra/clk-super.c
index e2a1e95a8db7..74c9e913e41c 100644
--- a/drivers/clk/tegra/clk-super.c
+++ b/drivers/clk/tegra/clk-super.c
@@ -124,9 +124,18 @@ static int clk_super_set_parent(struct clk_hw *hw, u8 index)
 	return err;
 }
 
+static void clk_super_mux_restore_context(struct clk_hw *hw)
+{
+	struct clk_hw *parent = clk_hw_get_parent(hw);
+	int parent_id = clk_hw_get_parent_index(hw, parent);
+
+	clk_super_set_parent(hw, parent_id);
+}
+
 static const struct clk_ops tegra_clk_super_mux_ops = {
 	.get_parent = clk_super_get_parent,
 	.set_parent = clk_super_set_parent,
+	.restore_context = clk_super_mux_restore_context,
 };
 
 static long clk_super_round_rate(struct clk_hw *hw, unsigned long rate,
@@ -162,12 +171,24 @@ static int clk_super_set_rate(struct clk_hw *hw, unsigned long rate,
 	return super->div_ops->set_rate(div_hw, rate, parent_rate);
 }
 
+static void clk_super_restore_context(struct clk_hw *hw)
+{
+	struct tegra_clk_super_mux *super = to_clk_super_mux(hw);
+	struct clk_hw *div_hw = &super->frac_div.hw;
+	struct clk_hw *parent = clk_hw_get_parent(hw);
+	int parent_id = clk_hw_get_parent_index(hw, parent);
+
+	super->div_ops->restore_context(div_hw);
+	clk_super_set_parent(hw, parent_id);
+}
+
 const struct clk_ops tegra_clk_super_ops = {
 	.get_parent = clk_super_get_parent,
 	.set_parent = clk_super_set_parent,
 	.set_rate = clk_super_set_rate,
 	.round_rate = clk_super_round_rate,
 	.recalc_rate = clk_super_recalc_rate,
+	.restore_context = clk_super_restore_context,
 };
 
 struct clk *tegra_clk_register_super_mux(const char *name,
-- 
2.7.4

