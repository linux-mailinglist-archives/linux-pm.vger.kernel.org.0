Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 561C786E4E
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2019 01:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404934AbfHHXsL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Aug 2019 19:48:11 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17859 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404919AbfHHXrG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Aug 2019 19:47:06 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d4cb47a0002>; Thu, 08 Aug 2019 16:47:06 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 08 Aug 2019 16:47:05 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 08 Aug 2019 16:47:05 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 8 Aug
 2019 23:47:04 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 8 Aug 2019 23:47:04 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.110]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d4cb4780001>; Thu, 08 Aug 2019 16:47:04 -0700
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
Subject: [PATCH v8 13/21] clk: tegra210: Use fence_udelay during PLLU init
Date:   Thu, 8 Aug 2019 16:46:52 -0700
Message-ID: <1565308020-31952-14-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565308020-31952-1-git-send-email-skomatineni@nvidia.com>
References: <1565308020-31952-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565308026; bh=RJjtD/wR8zo8cV5BUXlwlwAAOA63IpXqmMNKlX37eJo=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=bJHukxtmYY1lD+fE5oOiIEb72edP23a/Wc4qU3ZBcabHZjRo0qGic2nGXyw8zivHf
         2e6S4L6xcOD5/AItHM/b1mtQNAfRfgJxAo7mQX+xzRHVou/QCGjKenqpX0jtIpz4yP
         yDC1IcsbP/VWpXZeNTT+Olp25+K68h4PQfkWViVZTnDmG2YEM8NAUqQgb3T/1qfYGa
         cTFi0uL3MwvKgeZzlBdjtjhXoaZoXGFHdvFNPyv4rr7L0kk7okP9rPX+H3xb5FG/hS
         jL5OjigukBphflm54DdJ2/kcLDy9I2XbKwimJ7XLgWhzvObsW3HqOje5MFmtK4Y0J6
         35bP1bK70UmsQ==
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
index 4721ee030d1c..998bf60b219a 100644
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

