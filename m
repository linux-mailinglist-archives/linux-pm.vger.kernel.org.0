Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21CC59E71C
	for <lists+linux-pm@lfdr.de>; Tue, 23 Aug 2022 18:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244232AbiHWQWw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Aug 2022 12:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244681AbiHWQWc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Aug 2022 12:22:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852462767CB
        for <linux-pm@vger.kernel.org>; Tue, 23 Aug 2022 05:43:22 -0700 (PDT)
Date:   Tue, 23 Aug 2022 12:43:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661258600;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UwNyGv8uVCUqB8Pbuwv78qQJntUYdiwf9jcQBBkkV4c=;
        b=o1A1WPAyZx+0VNz0zFX78iBrWCEvpVz3hxuHx2ZhdUM3d+4Bt1hSzMG4QduZonUpVKprv5
        zebYRDleiFgqvRrGZ3Yg86NkTWobn/iRWRmohB+xlfp2BMrMTK6pkWqdBH4xGy38jucK4J
        Q2O20ZxtHP+iUYBNGJllvijC0Y1DTAvYv5sanKPCtHq6Nokznc0lv6G6HgQR63fH/NnYsM
        RZNQl13dJiXzF5F+JheAfzW6K24YSjsuniEcYA9A/gNKGN2r1pf5B6kwZAf6YPpX1t7Sp+
        mnuuey9cHhpwH4y5k2B6IXFTsKPA8MhqLn6PQODWQy3BvQByg7oFarU6YDcisQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661258600;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UwNyGv8uVCUqB8Pbuwv78qQJntUYdiwf9jcQBBkkV4c=;
        b=gDGHpGSQvDyzKb2Va/KdzAETp71xYKS8ec99WkmX0EGiWrRX4Plo9uP1uDb9AadPX7cRf1
        gwkZc/Tqm1CChyBA==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/of: Return -ENODEV instead of -EINVAL
 if registration fails
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Walle <michael@walle.cc>,
        Guenter Roeck <linux@roeck-us.net>, rui.zhang@intel.com,
        amitk@kernel.org
In-Reply-To: <20220809085629.509116-2-daniel.lezcano@linaro.org>
References: <20220809085629.509116-2-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <166125859964.401.4688531304508093686.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     9d6792df07367aab42009d2b24c62c11a5968ee3
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//9d6792df07367aab42009d2b24c62c11a5968ee3
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Tue, 09 Aug 2022 10:56:27 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 17 Aug 2022 14:09:37 +02:00

thermal/of: Return -ENODEV instead of -EINVAL if registration fails

The previous version of the OF code was returning -ENODEV if no
thermal zones description was found or if the lookup of the sensor in
the thermal zones was not found.

The backend drivers are expecting this return value as an information
about skipping the sensor initialization and considered as normal.

Fix the return value by replacing -EINVAL by -ENODEV and remove the
error message as this missing is not considered as an error.

Fixes: 3bd52ac87347 ("thermal/of: Rework the thermal device tree initialization")
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Tested-by: Michael Walle <michael@walle.cc>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20220809085629.509116-2-daniel.lezcano@linaro.org
---
 drivers/thermal/thermal_of.c |  9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 15b342f..072e054 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -1062,8 +1062,8 @@ static struct device_node *of_thermal_zone_find(struct device_node *sensor, int 
 
 	np = of_find_node_by_name(NULL, "thermal-zones");
 	if (!np) {
-		pr_err("Unable to find thermal zones description\n");
-		return ERR_PTR(-EINVAL);
+		pr_debug("No thermal zones description\n");
+		return ERR_PTR(-ENODEV);
 	}
 
 	/*
@@ -1102,7 +1102,7 @@ static struct device_node *of_thermal_zone_find(struct device_node *sensor, int 
 			}
 		}
 	}
-	tz = ERR_PTR(-EINVAL);
+	tz = ERR_PTR(-ENODEV);
 out:
 	of_node_put(np);
 	return tz;
@@ -1376,7 +1376,8 @@ struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor,
 
 	np = of_thermal_zone_find(sensor, id);
 	if (IS_ERR(np)) {
-		pr_err("Failed to find thermal zone for %pOFn id=%d\n", sensor, id);
+		if (PTR_ERR(np) != -ENODEV)
+			pr_err("Failed to find thermal zone for %pOFn id=%d\n", sensor, id);
 		return ERR_CAST(np);
 	}
 
