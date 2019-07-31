Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD32D7CFDD
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 23:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbfGaVM4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 17:12:56 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:10568 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbfGaVLI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2019 17:11:08 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d4203eb0001>; Wed, 31 Jul 2019 14:11:07 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 31 Jul 2019 14:11:07 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 31 Jul 2019 14:11:07 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 31 Jul
 2019 21:11:07 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 31 Jul
 2019 21:11:06 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 31 Jul 2019 21:11:06 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.102.167]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d4203ea0000>; Wed, 31 Jul 2019 14:11:06 -0700
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
Subject: [PATCH v7 03/20] clk: tegra: divider: Save and restore divider rate
Date:   Wed, 31 Jul 2019 14:10:46 -0700
Message-ID: <1564607463-28802-4-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564607463-28802-1-git-send-email-skomatineni@nvidia.com>
References: <1564607463-28802-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1564607467; bh=C/Vv+R//hhu8plFOiaQm9odxXoC5mT2dS2+ZICVm6us=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=pwxbq+T8NVZNQ2v5m2H9tUhZ8r6z6KJZZJw+ahcRMYPgrEHij/p8tiY3QtNT9aOKD
         rJb7h6UXsG8yirbuB4Km/yJN357YigQ6qpfqpp1EQ7YVbbrNkOH2P/Dxfs6Y5Siv8R
         PqrVQvzO/n3Mhyi8q0ipfWldOz12vdwx3SSWDEtcJofhKTRlm576vul6oo1/ZjJ0ha
         uBFPAOy2kM8i8lXr8XRZMqOFXhhe++Kq9PcqP7oMVBK9k7ww+vFntXF0zNDBIANdvm
         FhjGdchDSizs51ZJro6WM4UPSVzZpQUK9DfA58tkpPJczTPj/7V7KrxKpvS+KaUWbm
         lUTBoG48+X9og==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch implements context restore for clock divider.

During system suspend, core power goes off and looses the settings
of the Tegra CAR controller registers.

So on resume, clock dividers are restored back for normal operation.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/clk/tegra/clk-divider.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/clk/tegra/clk-divider.c b/drivers/clk/tegra/clk-divider.c
index e76731fb7d69..ca0de5f11f84 100644
--- a/drivers/clk/tegra/clk-divider.c
+++ b/drivers/clk/tegra/clk-divider.c
@@ -109,10 +109,21 @@ static int clk_frac_div_set_rate(struct clk_hw *hw, unsigned long rate,
 	return 0;
 }
 
+static void clk_divider_restore_context(struct clk_hw *hw)
+{
+	struct clk_hw *parent = clk_hw_get_parent(hw);
+	unsigned long parent_rate = clk_hw_get_rate(parent);
+	unsigned long rate = clk_hw_get_rate(hw);
+
+	if (clk_frac_div_set_rate(hw, rate, parent_rate) < 0)
+		WARN_ON(1);
+}
+
 const struct clk_ops tegra_clk_frac_div_ops = {
 	.recalc_rate = clk_frac_div_recalc_rate,
 	.set_rate = clk_frac_div_set_rate,
 	.round_rate = clk_frac_div_round_rate,
+	.restore_context = clk_divider_restore_context,
 };
 
 struct clk *tegra_clk_register_divider(const char *name,
-- 
2.7.4

