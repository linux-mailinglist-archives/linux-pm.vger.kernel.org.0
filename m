Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A30F73301A
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jun 2023 13:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344526AbjFPLlt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Jun 2023 07:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344110AbjFPLlj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Jun 2023 07:41:39 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965E9295B
        for <linux-pm@vger.kernel.org>; Fri, 16 Jun 2023 04:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qSQ36GOQMsCGqj5eIWmJSjK+G3EMBz7U7jaAgg3L9Mk=; b=sUaTSKJVyxnWldu2CKE5MVl0sC
        ZJ+3FsfNBgV7/GKDT7B46wpHZp0ih58nECqRJkE3Tsl6OFFfmZY/99D3NInSjbZ0Bq0AM3CMJfdWI
        c1r71AoJBKCE5sAzSPkMTI5Nse8VNSE00lOmAoLNeCK7IFJY+4i797paz2/b8n/ESj4CqtFssHvC2
        HU4Q7OsXOeN+W9ZVHPJtPmUNZpS0p7IdXpEzCoyn/w3pBSrQTqhMrYYqPvWwFS4FI8vjZqhT6isf9
        qCF1x+hP8PLK4ElEIYxv92wSVBktvQLWhH3A+2bq4T1nT5MXZRtkdIkFJVdFAsTq0KmTC/wDtQdLh
        VVZT2mCw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:59816 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1qA7pb-0004vB-Fr; Fri, 16 Jun 2023 12:41:31 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <rmk@rmk-PC.armlinux.org.uk>)
        id 1qA7pa-00EZw7-R9; Fri, 16 Jun 2023 12:41:30 +0100
From:   "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Josua Mayer <josua@solid-run.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH] cpufreq: armada-8k: add ap807 support
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qA7pa-00EZw7-R9@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date:   Fri, 16 Jun 2023 12:41:30 +0100
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add support for the Armada AP807 die to armada-8k. This uses a
different compatible for the CPU clock which needs to be added to
the cpufreq driver.

This commit takes a different approach to the WindRiver patch
"cpufreq: armada: enable ap807-cpu-clk" in that rather than calling
of_find_compatible_node() for each compatible, we use a table of
IDs instead.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/cpufreq/armada-8k-cpufreq.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/armada-8k-cpufreq.c b/drivers/cpufreq/armada-8k-cpufreq.c
index b0fc5e84f857..8afefdea4d80 100644
--- a/drivers/cpufreq/armada-8k-cpufreq.c
+++ b/drivers/cpufreq/armada-8k-cpufreq.c
@@ -21,6 +21,13 @@
 #include <linux/pm_opp.h>
 #include <linux/slab.h>
 
+static const struct of_device_id __maybe_unused armada_8k_cpufreq_of_match[] = {
+	{ .compatible = "marvell,ap806-cpu-clock" },
+	{ .compatible = "marvell,ap807-cpu-clock" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, armada_8k_cpufreq_of_match);
+
 /*
  * Setup the opps list with the divider for the max frequency, that
  * will be filled at runtime.
@@ -127,7 +134,8 @@ static int __init armada_8k_cpufreq_init(void)
 	struct device_node *node;
 	struct cpumask cpus;
 
-	node = of_find_compatible_node(NULL, NULL, "marvell,ap806-cpu-clock");
+	node = of_find_matching_node_and_match(NULL, armada_8k_cpufreq_of_match,
+					       NULL);
 	if (!node || !of_device_is_available(node)) {
 		of_node_put(node);
 		return -ENODEV;
@@ -204,12 +212,6 @@ static void __exit armada_8k_cpufreq_exit(void)
 }
 module_exit(armada_8k_cpufreq_exit);
 
-static const struct of_device_id __maybe_unused armada_8k_cpufreq_of_match[] = {
-	{ .compatible = "marvell,ap806-cpu-clock" },
-	{ },
-};
-MODULE_DEVICE_TABLE(of, armada_8k_cpufreq_of_match);
-
 MODULE_AUTHOR("Gregory Clement <gregory.clement@bootlin.com>");
 MODULE_DESCRIPTION("Armada 8K cpufreq driver");
 MODULE_LICENSE("GPL");
-- 
2.30.2

