Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F31E79089B
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2019 21:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbfHPTmv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Aug 2019 15:42:51 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13150 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbfHPTmr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Aug 2019 15:42:47 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d5707380000>; Fri, 16 Aug 2019 12:42:48 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 16 Aug 2019 12:42:46 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 16 Aug 2019 12:42:46 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 16 Aug
 2019 19:42:45 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 16 Aug 2019 19:42:45 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.166.126]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d5707330001>; Fri, 16 Aug 2019 12:42:45 -0700
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
Subject: [PATCH v9 13/22] clk: tegra210: Use fence_udelay during PLLU init
Date:   Fri, 16 Aug 2019 12:41:58 -0700
Message-ID: <1565984527-5272-14-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565984527-5272-1-git-send-email-skomatineni@nvidia.com>
References: <1565984527-5272-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565984568; bh=PRKOkpHyMl0u9ptcwmTgBDTAVVQUlEvBmGS6LChWh10=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=NchmTv+jae/K4+4X7pQfrid9rAthJzgrqd5tqI6V7onAmGN2FV/qiRhNxdRK37wxY
         CA/gQWnqyNTGIedTgw8cLGdNKdQnkxy0bk0iBuYLzixFW/tBKxD658RND31D7zRiS8
         vo4YR4E/64OewUGtoWdstBuI3S7eeYjXz6wor7uqdP44pxHHU5ksVhNTaMxmcUUyq2
         D3yJVEd8Y5/jM8VoB5p0qRjnzn1ebGoq6FeVJraWxlW70h7/3qOL8QoweI7Sac3thj
         DkRgoNgAhWJ2QvYEC01gClpFHOVA1iPkQrS8C0xD0QLjTmEbij/DUVfV+DBCmB8Hwh
         hb09CmPx2t1EA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch uses fence_udelay rather than udelay during PLLU
initialization to ensure writes to clock registers happens before
waiting for specified delay.

Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/clk/tegra/clk-tegra210.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra210.c b/drivers/clk/tegra/clk-tegra210.c
index df172d5772d7..4c9538bd28ad 100644
--- a/drivers/clk/tegra/clk-tegra210.c
+++ b/drivers/clk/tegra/clk-tegra210.c
@@ -2841,7 +2841,7 @@ static int tegra210_enable_pllu(void)
 	reg = readl_relaxed(clk_base + pllu.params->ext_misc_reg[0]);
 	reg &= ~BIT(pllu.params->iddq_bit_idx);
 	writel_relaxed(reg, clk_base + pllu.params->ext_misc_reg[0]);
-	udelay(5);
+	fence_udelay(5, clk_base);
 
 	reg = readl_relaxed(clk_base + PLLU_BASE);
 	reg &= ~GENMASK(20, 0);
@@ -2849,7 +2849,7 @@ static int tegra210_enable_pllu(void)
 	reg |= fentry->n << 8;
 	reg |= fentry->p << 16;
 	writel(reg, clk_base + PLLU_BASE);
-	udelay(1);
+	fence_udelay(1, clk_base);
 	reg |= PLL_ENABLE;
 	writel(reg, clk_base + PLLU_BASE);
 
@@ -2895,12 +2895,12 @@ static int tegra210_init_pllu(void)
 		reg = readl_relaxed(clk_base + XUSB_PLL_CFG0);
 		reg &= ~XUSB_PLL_CFG0_PLLU_LOCK_DLY_MASK;
 		writel_relaxed(reg, clk_base + XUSB_PLL_CFG0);
-		udelay(1);
+		fence_udelay(1, clk_base);
 
 		reg = readl_relaxed(clk_base + PLLU_HW_PWRDN_CFG0);
 		reg |= PLLU_HW_PWRDN_CFG0_SEQ_ENABLE;
 		writel_relaxed(reg, clk_base + PLLU_HW_PWRDN_CFG0);
-		udelay(1);
+		fence_udelay(1, clk_base);
 
 		reg = readl_relaxed(clk_base + PLLU_BASE);
 		reg &= ~PLLU_BASE_CLKENABLE_USB;
-- 
2.7.4

