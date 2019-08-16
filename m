Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA7E908AE
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2019 21:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfHPTmj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Aug 2019 15:42:39 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13133 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727671AbfHPTmi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Aug 2019 15:42:38 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d5707300001>; Fri, 16 Aug 2019 12:42:40 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 16 Aug 2019 12:42:38 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 16 Aug 2019 12:42:38 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 16 Aug
 2019 19:42:37 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 16 Aug
 2019 19:42:37 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 16 Aug 2019 19:42:37 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.166.126]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d5707280001>; Fri, 16 Aug 2019 12:42:37 -0700
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
Subject: [PATCH v9 10/22] clk: tegra: clk-super: Add restore-context support
Date:   Fri, 16 Aug 2019 12:41:55 -0700
Message-ID: <1565984527-5272-11-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565984527-5272-1-git-send-email-skomatineni@nvidia.com>
References: <1565984527-5272-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565984560; bh=peNaX+OjsKzvMnF5xQX40g75Dzd96yXRP1cP47w7Vug=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=B6KJUfZc305XAYCa0nyLta3ptXRda7xoNqLsA8+HbjEJenqbgjcXljiR7NtRnRbMz
         xS5GZurWxClZUumuCTcNn8azFWgSERJGka9uxfosZW/Vh8DmVhE9xTSskHjLe/9iP9
         //agjuPf8omen2+AZz/96K1hh6+oF7wQf2nibH/Ubn6dtebFOBUXP9ta/t2lroX+/U
         wWEz8XrcNqepksTk1sG8gXtkGM21JHCMCltWVpLFjQRfIdBv1R1AALLm032kn+90i9
         3PM7d4pViuOrDESUV9odhUIDHsYAJGcRD+ZdP94No7d6c3grSf0s/oI9ojQEOXXcTE
         hngf4dcI4TM9g==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch implements restore_context for clk_super_mux and clk_super.

During system supend, core power goes off the and context of Tegra
CAR registers is lost.

So on system resume, context of super clock registers are restored
to have them in same state as before suspend.

Acked-by: Thierry Reding <treding@nvidia.com>
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

