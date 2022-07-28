Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F9F584348
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jul 2022 17:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbiG1Plo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jul 2022 11:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbiG1Pln (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jul 2022 11:41:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E4C68DD8
        for <linux-pm@vger.kernel.org>; Thu, 28 Jul 2022 08:41:42 -0700 (PDT)
Date:   Thu, 28 Jul 2022 15:41:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659022901;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dnFdOzK/Af5hk1Hi8VPBvbbXGsA6WXymXuKImulqPC0=;
        b=rwmGGb6Mcq2KLAv5/vegRiF5NCXVPlHTPCYHGtoYqrI9MOchCzeJ8esblEClAIz8FkiUgQ
        3cXoWdzoG9cIDsSh23ENn0AGmOOL28OnIn0xH60JSE6+OZYwlsxkkRkCzJVqe32ClkdZV6
        0+CAa4cH8ul5FxsXATzSfKVysOahaL2dRFlzcYiMlVUeY2Rkk5Eg6cp7X/acHX+tcHe/ap
        CkBSd5oH9jAhUxgORoRdpi0KXNSVjopShVcKaA8X+3yjgq/ZvwPDScsn7+cXC55WZ5jR8B
        p/erhS0b1P7eZi+AiiVKbd7u/IQeiTVMu86evLxarg0weG0b51v5Sm1wH8cEyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659022901;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dnFdOzK/Af5hk1Hi8VPBvbbXGsA6WXymXuKImulqPC0=;
        b=DUjeKMdyuLPBG/W/JdoDwjDLoXZdY2//arr5G9qkf9R9tPiYKZrT6loU6kuTZYgK3ZFYRE
        y6hCF9e0YYujjJAQ==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/core: Avoid calling ->get_trip_temp()
 unnecessarily
Cc:     Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, amitk@kernel.org
In-Reply-To: <20220718145038.1114379-2-daniel.lezcano@linaro.org>
References: <20220718145038.1114379-2-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <165902290020.15455.15499193366780016881.tip-bot2@tip-bot2>
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

Commit-ID:     50e53291e9f188a44652f11606ae6b544facdccc
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//50e53291e9f188a44652f11606ae6b544facdccc
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 18 Jul 2022 16:50:36 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 28 Jul 2022 17:29:52 +02:00

thermal/core: Avoid calling ->get_trip_temp() unnecessarily

As the trip temperature is already available when calling the function
handle_critical_trips(), pass it as a parameter instead of having this
function calling the ops again to retrieve the same data.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20220718145038.1114379-2-daniel.lezcano@linaro.org
---
 drivers/thermal/thermal_core.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index cdc0552..20e11be 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -340,12 +340,8 @@ void thermal_zone_device_critical(struct thermal_zone_device *tz)
 EXPORT_SYMBOL(thermal_zone_device_critical);
 
 static void handle_critical_trips(struct thermal_zone_device *tz,
-				  int trip, enum thermal_trip_type trip_type)
+				  int trip, int trip_temp, enum thermal_trip_type trip_type)
 {
-	int trip_temp;
-
-	tz->ops->get_trip_temp(tz, trip, &trip_temp);
-
 	/* If we have not crossed the trip_temp, we do not care. */
 	if (trip_temp <= 0 || tz->temperature < trip_temp)
 		return;
@@ -384,7 +380,7 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
 	}
 
 	if (type == THERMAL_TRIP_CRITICAL || type == THERMAL_TRIP_HOT)
-		handle_critical_trips(tz, trip, type);
+		handle_critical_trips(tz, trip, trip_temp, type);
 	else
 		handle_non_critical_trips(tz, trip);
 	/*
