Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F069648523
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbiLIP0r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiLIP0g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:36 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55578F089
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:30 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599587;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1p4Gtqxl1I568dMMNw+AOYMAWm0Li35HeIqZkXokaFo=;
        b=hovG9q3sXOLKgFauIu1XzmU2sGxtgAqKch1s+2kjpaZUOYhkHPn3DiIpZzoR6FF/gCD1LI
        qU7d6FcLeD4UDToKEzDdEboTsfoeskevqy/VR99rbK2Ive2Ukrg8vupShftk+VmnXkmla+
        Ni8bg29PwWheVNNBcPTvMefZkNb0YWSgKN6gr39zRoYT9/maHu7Z3oERANvsL81jt7gFy/
        mFeFAK8s1o9PyLRFQvrvym0Jy8E3WWJa5AAFBabkHAWF3Au4ygqMrV5OhCLuoOeDa5iOs2
        v622vOgNymfGZ4p2VzLoB7gUFqPJ6HyfQ8Wwj3mCowXRgeVgONt37wEIwMfk0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599587;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1p4Gtqxl1I568dMMNw+AOYMAWm0Li35HeIqZkXokaFo=;
        b=LMqOPT1PICHiduoXB8mOCSx5YpE+4Gn29EN+wFC12okbAc4j8gZAtqZ5Rk7UDE3yeBKoZa
        pSSo3MymB1qRDGCw==
From:   "thermal-bot for Bryan Brattlof" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/k3_j72xx_bandgap: Remove
 fuse_base from structure
Cc:     Bryan Brattlof <bb@ti.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
In-Reply-To: <20221031232702.10339-4-bb@ti.com>
References: <20221031232702.10339-4-bb@ti.com>
MIME-Version: 1.0
Message-ID: <167059958679.4906.1218964985471996440.tip-bot2@tip-bot2>
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

Commit-ID:     825afa5cb1dd1b9133a1853d364c695d964bb53b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//825afa5cb1dd1b9133a1853d364c695d964bb53b
Author:        Bryan Brattlof <bb@ti.com>
AuthorDate:    Mon, 31 Oct 2022 18:26:54 -05:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Thu, 08 Dec 2022 14:30:44 +01:00

thermal/drivers/k3_j72xx_bandgap: Remove fuse_base from structure

'fuse_base' is only needed during the initial probe function to provide
data for a software trimming method for some of TI's devices affected by
the i2128 erratum. The devices not affected will not use this region

Remove fuse_base from the main k3_j72xx_bandgap structure

Signed-off-by: Bryan Brattlof <bb@ti.com>
Link: https://lore.kernel.org/r/20221031232702.10339-4-bb@ti.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
---
 drivers/thermal/k3_j72xx_bandgap.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/k3_j72xx_bandgap.c b/drivers/thermal/k3_j72xx_bandgap.c
index b9d2002..395a73c 100644
--- a/drivers/thermal/k3_j72xx_bandgap.c
+++ b/drivers/thermal/k3_j72xx_bandgap.c
@@ -177,7 +177,6 @@ struct k3_j72xx_bandgap {
 	struct device *dev;
 	void __iomem *base;
 	void __iomem *cfg2_base;
-	void __iomem *fuse_base;
 	struct k3_thermal_data *ts_data[K3_VTM_MAX_NUM_TS];
 };
 
@@ -276,7 +275,7 @@ static int k3_j72xx_bandgap_temp_to_adc_code(int temp)
 }
 
 static void get_efuse_values(int id, struct k3_thermal_data *data, int *err,
-			     struct k3_j72xx_bandgap *bgp)
+			     void __iomem *fuse_base)
 {
 	int i, tmp, pow;
 	int ct_offsets[5][K3_VTM_CORRECTION_TEMP_CNT] = {
@@ -298,16 +297,16 @@ static void get_efuse_values(int id, struct k3_thermal_data *data, int *err,
 		/* Extract the offset value using bit-mask */
 		if (ct_offsets[id][i] == -1 && i == 1) {
 			/* 25C offset Case of Sensor 2 split between 2 regs */
-			tmp = (readl(bgp->fuse_base + 0x8) & 0xE0000000) >> (29);
-			tmp |= ((readl(bgp->fuse_base + 0xC) & 0x1F) << 3);
+			tmp = (readl(fuse_base + 0x8) & 0xE0000000) >> (29);
+			tmp |= ((readl(fuse_base + 0xC) & 0x1F) << 3);
 			pow = tmp & 0x80;
 		} else if (ct_offsets[id][i] == -1 && i == 2) {
 			/* 125C Case of Sensor 3 split between 2 regs */
-			tmp = (readl(bgp->fuse_base + 0x4) & 0xF8000000) >> (27);
-			tmp |= ((readl(bgp->fuse_base + 0x8) & 0xF) << 5);
+			tmp = (readl(fuse_base + 0x4) & 0xF8000000) >> (27);
+			tmp |= ((readl(fuse_base + 0x8) & 0xF) << 5);
 			pow = tmp & 0x100;
 		} else {
-			tmp = readl(bgp->fuse_base + ct_offsets[id][i]);
+			tmp = readl(fuse_base + ct_offsets[id][i]);
 			tmp &= ct_bm[id][i];
 			tmp = tmp >> __ffs(ct_bm[id][i]);
 
@@ -356,6 +355,7 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 	struct thermal_zone_device *ti_thermal;
 	int *ref_table;
 	struct err_values err_vals;
+	void __iomem *fuse_base;
 
 	const s64 golden_factors[] = {
 		-490019999999999936,
@@ -387,9 +387,9 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 		return PTR_ERR(bgp->cfg2_base);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
-	bgp->fuse_base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(bgp->fuse_base))
-		return PTR_ERR(bgp->fuse_base);
+	fuse_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(fuse_base))
+		return PTR_ERR(fuse_base);
 
 	driver_data = of_device_get_match_data(dev);
 	if (driver_data)
@@ -428,7 +428,7 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 	}
 
 	/* Workaround not needed if bit30/bit31 is set even for J721e */
-	if (workaround_needed && (readl(bgp->fuse_base + 0x0) & 0xc0000000) == 0xc0000000)
+	if (workaround_needed && (readl(fuse_base + 0x0) & 0xc0000000) == 0xc0000000)
 		workaround_needed = false;
 
 	dev_dbg(bgp->dev, "Work around %sneeded\n",
@@ -452,7 +452,7 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 			err_vals.refs[1] = PLUS30CREF;
 			err_vals.refs[2] = PLUS125CREF;
 			err_vals.refs[3] = PLUS150CREF;
-			get_efuse_values(id, &data[id], err_vals.errs, bgp);
+			get_efuse_values(id, &data[id], err_vals.errs, fuse_base);
 		}
 
 		if (id == 0 && workaround_needed)
