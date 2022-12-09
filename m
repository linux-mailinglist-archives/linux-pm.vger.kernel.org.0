Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85420648519
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiLIP0h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiLIP0d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:33 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720438E5A0
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:30 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599586;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9rLvq4hcibfP3bxY/7nlAdWyPMcok0lyfU2X+0v1sqY=;
        b=V+J5y8w0YkRlwTiBhsLez4swznipCObtbJy6q0/As5t1iX3m3U3yDWJYZfoo6yKWvemDwf
        I7BLo1G2A0i3YRu2HOMBFxyPjnhkx9lAEGZYvP113pwfg/737ZVpxGIC4xzYBe3dQBs2Re
        YOI2aMrYYSfNzY7FXietkUbupBctQUT/8Oqz10B8iPxgvJWpxmXxHWUHHrxoIk+pFRifLq
        FYJrBDTLX5goUVvcxzouIhZuU+mZ1pQH+aKebYeupfg0S5efe+D7VIFGWBLDCccAi/Pkey
        nX5l1rXUO95SeDML+EJbhqbUgfAzmlF7Hxu+PrZ9VBVBdYmfFRg+JZnnXLnjxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599586;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9rLvq4hcibfP3bxY/7nlAdWyPMcok0lyfU2X+0v1sqY=;
        b=SPybjYdDuju8/d0W+WcKUSFLPFtKKQ5BSeQTtxMP8vj+bQys1Dx9NnxxyuMFYm+E7H3PEd
        vKBUmJyTMO6bXtBA==
From:   "thermal-bot for Bryan Brattlof" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/k3_j72xx_bandgap: Map
 fuse_base only for erratum workaround
Cc:     Bryan Brattlof <bb@ti.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
In-Reply-To: <20221031232702.10339-5-bb@ti.com>
References: <20221031232702.10339-5-bb@ti.com>
MIME-Version: 1.0
Message-ID: <167059958655.4906.3773019382136161143.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     d73b040d88e2ca47746e6b2f7b0c432981a88ee7
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//d73b040d88e2ca47746e6b2f7b0c432981a88ee7
Author:        Bryan Brattlof <bb@ti.com>
AuthorDate:    Mon, 31 Oct 2022 18:26:55 -05:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Thu, 08 Dec 2022 14:30:44 +01:00

thermal/drivers/k3_j72xx_bandgap: Map fuse_base only for erratum workaround

Some of TI's J721E SoCs require a software trimming procedure for the
temperature monitors to function properly. To determine if a particular
J721E is not affected by this erratum, both bits in the WKUP_SPARE_FUSE0
region must be set. Other SoCs, not affected by this erratum, will not
need this region.

Map the 'fuse_base' region only when the erratum fix is needed.

Signed-off-by: Bryan Brattlof <bb@ti.com>
Link: https://lore.kernel.org/r/20221031232702.10339-5-bb@ti.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
---
 drivers/thermal/k3_j72xx_bandgap.c | 34 ++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/k3_j72xx_bandgap.c b/drivers/thermal/k3_j72xx_bandgap.c
index 395a73c..031ea10 100644
--- a/drivers/thermal/k3_j72xx_bandgap.c
+++ b/drivers/thermal/k3_j72xx_bandgap.c
@@ -386,15 +386,32 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 	if (IS_ERR(bgp->cfg2_base))
 		return PTR_ERR(bgp->cfg2_base);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
-	fuse_base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(fuse_base))
-		return PTR_ERR(fuse_base);
-
 	driver_data = of_device_get_match_data(dev);
 	if (driver_data)
 		workaround_needed = driver_data->has_errata_i2128;
 
+	/*
+	 * Some of TI's J721E SoCs require a software trimming procedure
+	 * for the temperature monitors to function properly. To determine
+	 * if this particular SoC is NOT affected, both bits in the
+	 * WKUP_SPARE_FUSE0[31:30] will be set (0xC0000000) indicating
+	 * when software trimming should NOT be applied.
+	 *
+	 * https://www.ti.com/lit/er/sprz455c/sprz455c.pdf
+	 */
+	if (workaround_needed) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
+		fuse_base = devm_ioremap_resource(dev, res);
+		if (IS_ERR(fuse_base))
+			return PTR_ERR(fuse_base);
+
+		if ((readl(fuse_base) & 0xc0000000) == 0xc0000000)
+			workaround_needed = false;
+	}
+
+	dev_dbg(bgp->dev, "Work around %sneeded\n",
+		workaround_needed ? "" : "not ");
+
 	pm_runtime_enable(dev);
 	ret = pm_runtime_get_sync(dev);
 	if (ret < 0) {
@@ -427,13 +444,6 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 		goto err_free_ref_table;
 	}
 
-	/* Workaround not needed if bit30/bit31 is set even for J721e */
-	if (workaround_needed && (readl(fuse_base + 0x0) & 0xc0000000) == 0xc0000000)
-		workaround_needed = false;
-
-	dev_dbg(bgp->dev, "Work around %sneeded\n",
-		workaround_needed ? "" : "not ");
-
 	if (!workaround_needed)
 		init_table(5, ref_table, golden_factors);
 	else
