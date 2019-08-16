Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD5190883
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2019 21:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbfHPTnZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Aug 2019 15:43:25 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:13340 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727908AbfHPTnJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Aug 2019 15:43:09 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d57074f0000>; Fri, 16 Aug 2019 12:43:11 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 16 Aug 2019 12:43:08 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 16 Aug 2019 12:43:08 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 16 Aug
 2019 19:43:07 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 16 Aug
 2019 19:43:07 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 16 Aug 2019 19:43:07 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.166.126]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d57074a0000>; Fri, 16 Aug 2019 12:43:07 -0700
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
Subject: [PATCH v9 20/22] soc/tegra: pmc: Configure deep sleep control settings
Date:   Fri, 16 Aug 2019 12:42:05 -0700
Message-ID: <1565984527-5272-21-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565984527-5272-1-git-send-email-skomatineni@nvidia.com>
References: <1565984527-5272-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565984591; bh=g3u+sp12QfQwVSGZjC7LJissAjUDGtipxhhHXKacplg=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=SkRngtzIZuTY/P1m/fzR34xsvp61H+LQTewT2Xb0N61+z5Xpl8MgkeEmQ9CF53NLe
         ppiPDDQ/nUZV4gDH5pGyZEXK7SLA4HxBpkXpcwrewe85a9IFPDHpyfZSI7pKetkijB
         fVlm6lV2YUPBWBNWvG00HjvMxUKo0xcESWdMAkx3FYiQrbbE9alyLFsV354W0z2iiQ
         G/mczV8+1zpEY4m63gExkAF0zAjOh6iBXc2hlnQi7vz9MEXHjCtQbotDp2PTpJT6cD
         C+BLPgezdrlmcV30GtwkoZb6HUgEPCNQuEoiRFLjnA3Ib7TWLaHfjhC9gPDYinfGmP
         Qfg9Mgh3hdl7A==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Tegra210 and prior Tegra chips have deep sleep entry and wakeup related
timings which are platform specific that should be configured before
entering into deep sleep.

Below are the timing specific configurations for deep sleep entry and
wakeup.
- Core rail power-on stabilization timer
- OSC clock stabilization timer after SOC rail power is stabilized.
- Core power off time is the minimum wake delay to keep the system
  in deep sleep state irrespective of any quick wake event.

These values depends on the discharge time of regulators and turn OFF
time of the PMIC to allow the complete system to finish entering into
deep sleep state.

These values vary based on the platform design and are specified
through the device tree.

This patch has implementation to configure these timings which are must
to have for proper deep sleep and wakeup operations.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 53ed70773872..710969043668 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -88,6 +88,8 @@
 
 #define PMC_CPUPWRGOOD_TIMER		0xc8
 #define PMC_CPUPWROFF_TIMER		0xcc
+#define PMC_COREPWRGOOD_TIMER		0x3c
+#define PMC_COREPWROFF_TIMER		0xe0
 
 #define PMC_PWR_DET_VALUE		0xe4
 
@@ -2277,7 +2279,7 @@ static const struct tegra_pmc_regs tegra20_pmc_regs = {
 
 static void tegra20_pmc_init(struct tegra_pmc *pmc)
 {
-	u32 value;
+	u32 value, osc, pmu, off;
 
 	/* Always enable CPU power request */
 	value = tegra_pmc_readl(pmc, PMC_CNTRL);
@@ -2303,6 +2305,16 @@ static void tegra20_pmc_init(struct tegra_pmc *pmc)
 	value = tegra_pmc_readl(pmc, PMC_CNTRL);
 	value |= PMC_CNTRL_SYSCLK_OE;
 	tegra_pmc_writel(pmc, value, PMC_CNTRL);
+
+	/* program core timings which are applicable only for suspend state */
+	if (pmc->suspend_mode != TEGRA_SUSPEND_NONE) {
+		osc = DIV_ROUND_UP(pmc->core_osc_time * 8192, 1000000);
+		pmu = DIV_ROUND_UP(pmc->core_pmu_time * 32768, 1000000);
+		off = DIV_ROUND_UP(pmc->core_off_time * 32768, 1000000);
+		tegra_pmc_writel(pmc, ((osc << 8) & 0xff00) | (pmu & 0xff),
+				 PMC_COREPWRGOOD_TIMER);
+		tegra_pmc_writel(pmc, off, PMC_COREPWROFF_TIMER);
+	}
 }
 
 static void tegra20_pmc_setup_irq_polarity(struct tegra_pmc *pmc,
-- 
2.7.4

