Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C89F61B21A8
	for <lists+linux-pm@lfdr.de>; Tue, 21 Apr 2020 10:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbgDUIag (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Apr 2020 04:30:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:56340 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbgDUIaf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 21 Apr 2020 04:30:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A3046ACAE;
        Tue, 21 Apr 2020 08:30:33 +0000 (UTC)
From:   Mian Yousaf Kaukab <ykaukab@suse.de>
To:     linux-pm@vger.kernel.org, andy.tang@nxp.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, rjw@rjwysocki.net, shawnguo@kernel.org,
        leoyang.li@nxp.com
Cc:     viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Mian Yousaf Kaukab <ykaukab@suse.de>
Subject: [PATCH v2 2/2] clk: qoriq: add cpufreq platform device
Date:   Tue, 21 Apr 2020 10:30:00 +0200
Message-Id: <20200421083000.16740-2-ykaukab@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200421083000.16740-1-ykaukab@suse.de>
References: <20200421083000.16740-1-ykaukab@suse.de>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a platform device for qoirq-cpufreq driver for the compatible
clockgen blocks.

Reviewed-by: Yuantian Tang <andy.tang@nxp.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
---
v2:
 +Rafael, Stephen, linux-clk
 Add Reviewed-by and Acked-by tags

 drivers/clk/clk-qoriq.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
index d5946f7486d6..374afcab89af 100644
--- a/drivers/clk/clk-qoriq.c
+++ b/drivers/clk/clk-qoriq.c
@@ -95,6 +95,7 @@ struct clockgen {
 };
 
 static struct clockgen clockgen;
+static bool add_cpufreq_dev __initdata;
 
 static void cg_out(struct clockgen *cg, u32 val, u32 __iomem *reg)
 {
@@ -1019,7 +1020,7 @@ static void __init create_muxes(struct clockgen *cg)
 	}
 }
 
-static void __init clockgen_init(struct device_node *np);
+static void __init _clockgen_init(struct device_node *np, bool legacy);
 
 /*
  * Legacy nodes may get probed before the parent clockgen node.
@@ -1030,7 +1031,7 @@ static void __init clockgen_init(struct device_node *np);
 static void __init legacy_init_clockgen(struct device_node *np)
 {
 	if (!clockgen.node)
-		clockgen_init(of_get_parent(np));
+		_clockgen_init(of_get_parent(np), true);
 }
 
 /* Legacy node */
@@ -1447,7 +1448,7 @@ static bool __init has_erratum_a4510(void)
 }
 #endif
 
-static void __init clockgen_init(struct device_node *np)
+static void __init _clockgen_init(struct device_node *np, bool legacy)
 {
 	int i, ret;
 	bool is_old_ls1021a = false;
@@ -1516,12 +1517,35 @@ static void __init clockgen_init(struct device_node *np)
 		       __func__, np, ret);
 	}
 
+	/* Don't create cpufreq device for legacy clockgen blocks */
+	add_cpufreq_dev = !legacy;
+
 	return;
 err:
 	iounmap(clockgen.regs);
 	clockgen.regs = NULL;
 }
 
+static void __init clockgen_init(struct device_node *np)
+{
+	_clockgen_init(np, false);
+}
+
+static int __init clockgen_cpufreq_init(void)
+{
+	struct platform_device *pdev;
+
+	if (add_cpufreq_dev) {
+		pdev = platform_device_register_simple("qoriq-cpufreq", -1,
+				NULL, 0);
+		if (IS_ERR(pdev))
+			pr_err("Couldn't register qoriq-cpufreq err=%ld\n",
+				PTR_ERR(pdev));
+	}
+	return 0;
+}
+device_initcall(clockgen_cpufreq_init);
+
 CLK_OF_DECLARE(qoriq_clockgen_1, "fsl,qoriq-clockgen-1.0", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_2, "fsl,qoriq-clockgen-2.0", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_b4420, "fsl,b4420-clockgen", clockgen_init);
-- 
2.16.4

