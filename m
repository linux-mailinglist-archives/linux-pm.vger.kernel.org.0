Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2616F648548
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiLIP1R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiLIP0n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C8290769
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:37 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599593;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Su/PdEQz7p0BFZAOW4vj+QK+0xOD98we4M9Y6JshWTo=;
        b=ujQLg+AHEjsqQXJT2xeXOg3F3Da8BuY7bfNQYXor48bWNCtwLRHpL2S3Zjnbhaqhfbkv5+
        g1IpF/9J/cvP5P4FYdYU5QGrWB9yG+RznyzppP/P8QR0uyYF/5/hZMtF+ip1dbvKEMM9GJ
        a4C6koLPVLTGvY/vpB0b3Z7GB1f1EmfSNKqLExxa758YvUVQlu1x8gwoQeKZ0blB64EzIt
        q+STTO4JsCHpc/99e4ZUFICeNuSS+UuJpVMozHlZCZr09mc18tD5ctnomv4bM/comEVvPA
        8NkiCrP/MovCesoWAfZH8k0E7+njwnZ6Dh7N3weTn3BCRFWHeGIKaIvb+oHBzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599593;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Su/PdEQz7p0BFZAOW4vj+QK+0xOD98we4M9Y6JshWTo=;
        b=r8ja9LVDUPXoSpmkci/B6h08CPkJVfgOnV1ZUSh/SGjpDlQk8xpG+2Bkf5jEL9t9FrcssS
        /mbEI1RirlVnLtBQ==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/of: Remove of_thermal_get_crit_temp()
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
        amitk@kernel.org
In-Reply-To: <20221003092602.1323944-20-daniel.lezcano@linaro.org>
References: <20221003092602.1323944-20-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <167059959365.4906.10245141462546793374.tip-bot2@tip-bot2>
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

Commit-ID:     9b3175c5373f295685a9ed99669bc4719594bf2c
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//9b3175c5373f295685a9ed99669bc4719594bf2c
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 03 Oct 2022 11:25:52 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Thu, 08 Dec 2022 14:30:42 +01:00

thermal/of: Remove of_thermal_get_crit_temp()

The generic version of of_thermal_get_crit_temp() can be used. Let's
remove this ops which is pointless.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20221003092602.1323944-20-daniel.lezcano@linaro.org
---
 drivers/thermal/thermal_of.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 494e9c3..bd87218 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -19,20 +19,6 @@
 
 #include "thermal_core.h"
 
-static int of_thermal_get_crit_temp(struct thermal_zone_device *tz,
-				    int *temp)
-{
-	int i;
-
-	for (i = 0; i < tz->num_trips; i++)
-		if (tz->trips[i].type == THERMAL_TRIP_CRITICAL) {
-			*temp = tz->trips[i].temperature;
-			return 0;
-		}
-
-	return -EINVAL;
-}
-
 /***   functions parsing device tree nodes   ***/
 
 static int of_find_trip_id(struct device_node *np, struct device_node *trip)
@@ -529,7 +515,6 @@ struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor,
 		goto out_kfree_trips;
 	}
 
-	of_ops->get_crit_temp = of_ops->get_crit_temp ? : of_thermal_get_crit_temp;
 	of_ops->bind = thermal_of_bind;
 	of_ops->unbind = thermal_of_unbind;
 
