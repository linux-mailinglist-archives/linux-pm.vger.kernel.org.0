Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9465386E2C
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2019 01:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405088AbfHHXrf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Aug 2019 19:47:35 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17878 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404958AbfHHXrH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Aug 2019 19:47:07 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d4cb47c0000>; Thu, 08 Aug 2019 16:47:08 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 08 Aug 2019 16:47:06 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 08 Aug 2019 16:47:06 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 8 Aug
 2019 23:47:06 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 8 Aug
 2019 23:47:05 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 8 Aug 2019 23:47:06 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.110]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d4cb4790002>; Thu, 08 Aug 2019 16:47:05 -0700
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
Subject: [PATCH v8 18/21] soc/tegra: pmc: Configure core power request polarity
Date:   Thu, 8 Aug 2019 16:46:57 -0700
Message-ID: <1565308020-31952-19-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565308020-31952-1-git-send-email-skomatineni@nvidia.com>
References: <1565308020-31952-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565308028; bh=+irRG9Bl8eDAFdqPLYIcqsrOHQrSrUdohaTd6jMdMg0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=paAudQjNv+ydg4gPQrA7tRN//Qu6z1Oc2iEbAlsllRXPZrgvoRn0wyLmct3J/zgXB
         gtS6zWupwrBB0K/dfYT4w+C8CJXs6lCGvmJ7Xx9FUWDd/iNaLle+g5FQgEq92sHfTR
         9AxTdu77XqQiPC3cQNeMnZhTO9SvF1LE4PMi12VyCf7XFmbJsLI10lWNRYl2q0GanN
         VSRILDBWhcrn0hg+Ufkfs2VQrUP6heioS6NxAWvCsbgvld4mzsn2VxPlPKhC4MqcBw
         ztxMepROsCF6wS8i8NVZjW7ILR1szmiQVDrcY/jhFH6XBykKbGTVVk/Q47AgrbAUUL
         fEjNQ3JjACUbg==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch configures polarity of the core power request signal
in PMC control register based on the device tree property.

PMC asserts and de-asserts power request signal based on it polarity
when it need to power-up and power-down the core rail during SC7.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 3aa71c28a10a..e013ada7e4e9 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -56,6 +56,7 @@
 #define  PMC_CNTRL_SIDE_EFFECT_LP0	BIT(14) /* LP0 when CPU pwr gated */
 #define  PMC_CNTRL_SYSCLK_OE		BIT(11) /* system clock enable */
 #define  PMC_CNTRL_SYSCLK_POLARITY	BIT(10) /* sys clk polarity */
+#define  PMC_CNTRL_PWRREQ_POLARITY	BIT(8)
 #define  PMC_CNTRL_MAIN_RST		BIT(4)
 
 #define PMC_WAKE_MASK			0x0c
@@ -2290,6 +2291,11 @@ static void tegra20_pmc_init(struct tegra_pmc *pmc)
 	else
 		value |= PMC_CNTRL_SYSCLK_POLARITY;
 
+	if (pmc->corereq_high)
+		value &= ~PMC_CNTRL_PWRREQ_POLARITY;
+	else
+		value |= PMC_CNTRL_PWRREQ_POLARITY;
+
 	/* configure the output polarity while the request is tristated */
 	tegra_pmc_writel(pmc, value, PMC_CNTRL);
 
-- 
2.7.4

