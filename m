Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E34F90894
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2019 21:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbfHPTmw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Aug 2019 15:42:52 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13159 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbfHPTmv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Aug 2019 15:42:51 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d57073b0000>; Fri, 16 Aug 2019 12:42:51 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 16 Aug 2019 12:42:49 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 16 Aug 2019 12:42:49 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 16 Aug
 2019 19:42:49 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 16 Aug 2019 19:42:49 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.166.126]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d5707350001>; Fri, 16 Aug 2019 12:42:48 -0700
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
Subject: [PATCH v9 14/22] clk: tegra: Share clk and rst register defines with Tegra clock driver
Date:   Fri, 16 Aug 2019 12:41:59 -0700
Message-ID: <1565984527-5272-15-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565984527-5272-1-git-send-email-skomatineni@nvidia.com>
References: <1565984527-5272-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565984572; bh=o6rk830OCvPUp4Y9Ub5IhFbtsD+qecod9DB8emdiYiU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=XIq2kGB7ILBzBPBbFX6jtfFNVHH8r/39NRxwq96HHIcO2Zt+A6jP/q9hudkZk+4ah
         KXZVwHEEtrceWc/gUENE40rhoZHNb1DYKBTyyn9XjPqcF9JIXn6NddZASqoHkkJXTq
         HZJ9m/YnO/p9jmDFRMg+K0jbMnvfhfMYenEGZDJFPWCQl4SCxdloD1IE/6exqafvIm
         Olwocuj2akhSXgqFYTjixlP1QCSv/gKi+YwjhBWaVovj6G/VHWitMXHxLcGMtDaGYf
         Ygq5ntquUSCXkfLqTvaKdUi+urf8oWMCAhUBJmf62J96Jl8KfBCGS+NvFIAgFBaZkc
         /LP/JsSUeiC8g==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Move CLK_OUT_ENB and RST_DEVICES registers to clk.h to share these with
Tegra clock driver.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/clk/tegra/clk.c | 45 ---------------------------------------------
 drivers/clk/tegra/clk.h | 45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/drivers/clk/tegra/clk.c b/drivers/clk/tegra/clk.c
index eb08047fd02f..33ac88ee324a 100644
--- a/drivers/clk/tegra/clk.c
+++ b/drivers/clk/tegra/clk.c
@@ -16,51 +16,6 @@
 
 #include "clk.h"
 
-#define CLK_OUT_ENB_L			0x010
-#define CLK_OUT_ENB_H			0x014
-#define CLK_OUT_ENB_U			0x018
-#define CLK_OUT_ENB_V			0x360
-#define CLK_OUT_ENB_W			0x364
-#define CLK_OUT_ENB_X			0x280
-#define CLK_OUT_ENB_Y			0x298
-#define CLK_ENB_PLLP_OUT_CPU		BIT(31)
-#define CLK_OUT_ENB_SET_L		0x320
-#define CLK_OUT_ENB_CLR_L		0x324
-#define CLK_OUT_ENB_SET_H		0x328
-#define CLK_OUT_ENB_CLR_H		0x32c
-#define CLK_OUT_ENB_SET_U		0x330
-#define CLK_OUT_ENB_CLR_U		0x334
-#define CLK_OUT_ENB_SET_V		0x440
-#define CLK_OUT_ENB_CLR_V		0x444
-#define CLK_OUT_ENB_SET_W		0x448
-#define CLK_OUT_ENB_CLR_W		0x44c
-#define CLK_OUT_ENB_SET_X		0x284
-#define CLK_OUT_ENB_CLR_X		0x288
-#define CLK_OUT_ENB_SET_Y		0x29c
-#define CLK_OUT_ENB_CLR_Y		0x2a0
-
-#define RST_DEVICES_L			0x004
-#define RST_DEVICES_H			0x008
-#define RST_DEVICES_U			0x00C
-#define RST_DEVICES_V			0x358
-#define RST_DEVICES_W			0x35C
-#define RST_DEVICES_X			0x28C
-#define RST_DEVICES_Y			0x2a4
-#define RST_DEVICES_SET_L		0x300
-#define RST_DEVICES_CLR_L		0x304
-#define RST_DEVICES_SET_H		0x308
-#define RST_DEVICES_CLR_H		0x30c
-#define RST_DEVICES_SET_U		0x310
-#define RST_DEVICES_CLR_U		0x314
-#define RST_DEVICES_SET_V		0x430
-#define RST_DEVICES_CLR_V		0x434
-#define RST_DEVICES_SET_W		0x438
-#define RST_DEVICES_CLR_W		0x43c
-#define RST_DEVICES_SET_X		0x290
-#define RST_DEVICES_CLR_X		0x294
-#define RST_DEVICES_SET_Y		0x2a8
-#define RST_DEVICES_CLR_Y		0x2ac
-
 /* Global data of Tegra CPU CAR ops */
 static struct tegra_cpu_car_ops dummy_car_ops;
 struct tegra_cpu_car_ops *tegra_cpu_car_ops = &dummy_car_ops;
diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
index 55c4b78280be..ba123ba4a1da 100644
--- a/drivers/clk/tegra/clk.h
+++ b/drivers/clk/tegra/clk.h
@@ -10,6 +10,51 @@
 #include <linux/clkdev.h>
 #include <linux/delay.h>
 
+#define CLK_OUT_ENB_L			0x010
+#define CLK_OUT_ENB_H			0x014
+#define CLK_OUT_ENB_U			0x018
+#define CLK_OUT_ENB_V			0x360
+#define CLK_OUT_ENB_W			0x364
+#define CLK_OUT_ENB_X			0x280
+#define CLK_OUT_ENB_Y			0x298
+#define CLK_ENB_PLLP_OUT_CPU		BIT(31)
+#define CLK_OUT_ENB_SET_L		0x320
+#define CLK_OUT_ENB_CLR_L		0x324
+#define CLK_OUT_ENB_SET_H		0x328
+#define CLK_OUT_ENB_CLR_H		0x32c
+#define CLK_OUT_ENB_SET_U		0x330
+#define CLK_OUT_ENB_CLR_U		0x334
+#define CLK_OUT_ENB_SET_V		0x440
+#define CLK_OUT_ENB_CLR_V		0x444
+#define CLK_OUT_ENB_SET_W		0x448
+#define CLK_OUT_ENB_CLR_W		0x44c
+#define CLK_OUT_ENB_SET_X		0x284
+#define CLK_OUT_ENB_CLR_X		0x288
+#define CLK_OUT_ENB_SET_Y		0x29c
+#define CLK_OUT_ENB_CLR_Y		0x2a0
+
+#define RST_DEVICES_L			0x004
+#define RST_DEVICES_H			0x008
+#define RST_DEVICES_U			0x00C
+#define RST_DEVICES_V			0x358
+#define RST_DEVICES_W			0x35C
+#define RST_DEVICES_X			0x28C
+#define RST_DEVICES_Y			0x2a4
+#define RST_DEVICES_SET_L		0x300
+#define RST_DEVICES_CLR_L		0x304
+#define RST_DEVICES_SET_H		0x308
+#define RST_DEVICES_CLR_H		0x30c
+#define RST_DEVICES_SET_U		0x310
+#define RST_DEVICES_CLR_U		0x314
+#define RST_DEVICES_SET_V		0x430
+#define RST_DEVICES_CLR_V		0x434
+#define RST_DEVICES_SET_W		0x438
+#define RST_DEVICES_CLR_W		0x43c
+#define RST_DEVICES_SET_X		0x290
+#define RST_DEVICES_CLR_X		0x294
+#define RST_DEVICES_SET_Y		0x2a8
+#define RST_DEVICES_CLR_Y		0x2ac
+
 /**
  * struct tegra_clk_sync_source - external clock source from codec
  *
-- 
2.7.4

