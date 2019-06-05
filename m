Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A215B35A84
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2019 12:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfFEKhQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jun 2019 06:37:16 -0400
Received: from inva020.nxp.com ([92.121.34.13]:56614 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727148AbfFEKhQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 Jun 2019 06:37:16 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B10B41A0838;
        Wed,  5 Jun 2019 12:37:14 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A46D51A00EA;
        Wed,  5 Jun 2019 12:37:14 +0200 (CEST)
Received: from jana.ea.freescale.net (gw_auto.ea.freescale.net [10.171.94.100])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 245E8205FA;
        Wed,  5 Jun 2019 12:37:14 +0200 (CEST)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Jacky Bai <ping.bai@nxp.com>, Anson Huang <Anson.Huang@nxp.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>, kernel@pengutronix.de,
        linux-imx@nxp.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/5] ARM: imx: Switch imx7d to imx-cpufreq-dt for speed-grading
Date:   Wed,  5 Jun 2019 13:37:07 +0300
Message-Id: <12e267d1515b5c2cb9a07af4fd2598c4db94951a.1559730963.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1559730963.git.leonard.crestez@nxp.com>
References: <cover.1559730963.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1559730963.git.leonard.crestez@nxp.com>
References: <cover.1559730963.git.leonard.crestez@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The imx-cpufreq-dt driver can handle speed grading bits on imx7d just
like on imx8mq and imx8mm.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 arch/arm/mach-imx/mach-imx7d.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mach-imx/mach-imx7d.c b/arch/arm/mach-imx/mach-imx7d.c
index 26ca744d3e2b..0b77412795c9 100644
--- a/arch/arm/mach-imx/mach-imx7d.c
+++ b/arch/arm/mach-imx/mach-imx7d.c
@@ -95,10 +95,16 @@ static void __init imx7d_init_machine(void)
 
 	imx_anatop_init();
 	imx7d_enet_init();
 }
 
+static void __init imx7d_init_late(void)
+{
+	if (IS_ENABLED(CONFIG_ARM_IMX_CPUFREQ_DT))
+		platform_device_register_simple("imx-cpufreq-dt", -1, NULL, 0);
+}
+
 static void __init imx7d_init_irq(void)
 {
 	imx_init_revision_from_anatop();
 	imx_src_init();
 	irqchip_init();
@@ -111,7 +117,8 @@ static const char *const imx7d_dt_compat[] __initconst = {
 };
 
 DT_MACHINE_START(IMX7D, "Freescale i.MX7 Dual (Device Tree)")
 	.init_irq	= imx7d_init_irq,
 	.init_machine	= imx7d_init_machine,
+	.init_late      = imx7d_init_late,
 	.dt_compat	= imx7d_dt_compat,
 MACHINE_END
-- 
2.7.4

