Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74791648546
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbiLIP1P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbiLIP0n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BF38E5B8
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:37 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599594;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=34QPOjYoDbhLTi4mstwfS6OfqGq2S9PSbVHfZ3UDsUY=;
        b=YVLfp1fQXaRFB0nFSEmtBWw1RZwWdFZft5fO//vfvFKOC+C7JiBE6cjxxWKBUGEQS0vr6i
        OnoXyo73l7+OLaAzCoyWxCmutR8HvBtV+xLLtzHJEAypyJGBQvnY6/XEWS0uur7Np9zhXC
        2st/HMSVCqMA95kcVb1zhwZTCeG8uXs4wiiFu3pTyXNOWgUfcg0SARjt2N9bMLUS0MopAX
        Lpo/VfixpLCVHs4eth4Bb9ieUmH7hEvpN/2ySOW1dn8AETmaNbIbcwP5u/J2CjvozJFEp/
        YDJ3TLmfBhSSsK2eZfbK7LJixZoZHJhKc8ujtd2/xAKZFRZCtfKbL7OnUwzeGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599594;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=34QPOjYoDbhLTi4mstwfS6OfqGq2S9PSbVHfZ3UDsUY=;
        b=HIcfhZTM/BLd6PkvPn+oJBwC+GqSFW7HIr2HTEi7dJk4SBFune51yiSLH6/+AiCUIN2Wdk
        m7tdJAto6EBmbdDQ==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/of: Remove of_thermal_set_trip_hyst()
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
        amitk@kernel.org
In-Reply-To: <20221003092602.1323944-19-daniel.lezcano@linaro.org>
References: <20221003092602.1323944-19-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <167059959380.4906.14762586318894067457.tip-bot2@tip-bot2>
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

Commit-ID:     f00295bf50b581ecda6fad24dd8d713c2158e5da
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//f00295bf50b581ecda6fad24dd8d713c2158e5da
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 03 Oct 2022 11:25:51 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Thu, 08 Dec 2022 14:30:42 +01:00

thermal/of: Remove of_thermal_set_trip_hyst()

The thermal core is providing the generic thermal_zone_set_trip()
function which does exactly what the OF ops function is doing.

It is pointless to define our own version, just remove the ops and the
thermal_zone_set_trip() will take care of it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20221003092602.1323944-19-daniel.lezcano@linaro.org
---
 drivers/thermal/thermal_of.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 4e54d62..494e9c3 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -19,18 +19,6 @@
 
 #include "thermal_core.h"
 
-static int of_thermal_set_trip_hyst(struct thermal_zone_device *tz, int trip,
-				    int hyst)
-{
-	if (trip >= tz->num_trips || trip < 0)
-		return -EDOM;
-
-	/* thermal framework should take care of data->mask & (1 << trip) */
-	tz->trips[trip].hysteresis = hyst;
-
-	return 0;
-}
-
 static int of_thermal_get_crit_temp(struct thermal_zone_device *tz,
 				    int *temp)
 {
@@ -541,7 +529,6 @@ struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor,
 		goto out_kfree_trips;
 	}
 
-	of_ops->set_trip_hyst = of_ops->set_trip_hyst ? : of_thermal_set_trip_hyst;
 	of_ops->get_crit_temp = of_ops->get_crit_temp ? : of_thermal_get_crit_temp;
 	of_ops->bind = thermal_of_bind;
 	of_ops->unbind = thermal_of_unbind;
