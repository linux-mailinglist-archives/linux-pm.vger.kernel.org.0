Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAD064852A
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbiLIP0x (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiLIP0h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E832A8BD2B
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:32 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599589;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hKgeX5ekyTjFxiIorZB6Z1/MVueRfzszmacEkYf7BAM=;
        b=IFgprJZRB8B/0p/hX/54qeGJiWPca+73yzJZAgK4CyB8PTcTwXobzJBnKy0x6GVGyQwoDE
        /nZejRM4ZwSmpuxwyyREZloyhZy1H0RAgucXaRvsfRbjgz1azrt30GokN7RQrT4STbjkxQ
        uT9OpgqFo1xJtFvkVnIimU+1QRzPn3BLOEkrWJPfpcEKRSDAQs2M7+Q8HMoe5Vg2v5X3wG
        dMfuPTsa+5jfBp1N0ToRU+B61dcHteZUNS25NjYxyJ2Z8d60FrHmU1y7ml8WAnzDvLSvSS
        5z9xAyub5/2sGhvqoAvt9KjcvNjJGz3bKjXIMbUyByQMsTmz9vtHQ3HEJ99hgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599589;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hKgeX5ekyTjFxiIorZB6Z1/MVueRfzszmacEkYf7BAM=;
        b=aA/OzrTVIAbLqGmtGmMF418Fc0xrAL4+7cuxvtRxzVYSPqlKegzRCMAXqS+YtvsKj9GteO
        uFGhUsZsuqLlq8Dg==
From:   "thermal-bot for Christian Marangi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/qcom/tsens: Init debugfs only
 with successful probe
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
In-Reply-To: <20221022125657.22530-2-ansuelsmth@gmail.com>
References: <20221022125657.22530-2-ansuelsmth@gmail.com>
MIME-Version: 1.0
Message-ID: <167059958938.4906.8038603702843511422.tip-bot2@tip-bot2>
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

Commit-ID:     4d248fcb7c80e67dc22338ed44e00ac5d96ab0be
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//4d248fcb7c80e67dc22338ed44e00ac5d96ab0be
Author:        Christian Marangi <ansuelsmth@gmail.com>
AuthorDate:    Sat, 22 Oct 2022 14:56:55 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Thu, 08 Dec 2022 14:30:44 +01:00

thermal/drivers/qcom/tsens: Init debugfs only with successful probe

Calibrate and tsens_register can fail or PROBE_DEFER. This will cause a
double or a wrong init of the debugfs information. Init debugfs only
with successful probe fixing warning about directory already present.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Acked-by: Thara Gopinath <thara.gopinath@linaro.org>
Link: https://lore.kernel.org/r/20221022125657.22530-2-ansuelsmth@gmail.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
---
 drivers/thermal/qcom/tsens.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index b7d9782..3ac7804 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -939,8 +939,6 @@ int __init init_common(struct tsens_priv *priv)
 	if (tsens_version(priv) >= VER_0_1)
 		tsens_enable_irq(priv);
 
-	tsens_debug_init(op);
-
 err_put_device:
 	put_device(&op->dev);
 	return ret;
@@ -1182,7 +1180,11 @@ static int tsens_probe(struct platform_device *pdev)
 		}
 	}
 
-	return tsens_register(priv);
+	ret = tsens_register(priv);
+	if (!ret)
+		tsens_debug_init(pdev);
+
+	return ret;
 }
 
 static int tsens_remove(struct platform_device *pdev)
