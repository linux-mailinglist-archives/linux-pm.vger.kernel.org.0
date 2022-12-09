Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0F164853B
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbiLIP1J (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiLIP0l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB5F90752
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:35 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599593;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NqHgjVOWoaDaRzKkSO+uxl5YkUVnp6wJPbkpEm8GNM4=;
        b=OSGePnMhO60XxSuENu3IXfDzF2C572kno91bxbetLZ2THAlanNhZ5UvqHHgBICroBoSqG6
        V/v8PpJbS1nqlG+8i4hc1zwMkgtZ2/Yd1bhpUgBw6x3LRWO8jtA81MM4v/G/JjDbPEyvIJ
        f0Op35MnpiqRuDl7+l26aEJDk+PRIdkXjtvVmbs9KyYAOmqMWqAf0VJy/aqQSQKvr8M2r5
        uCZ0QYRhZo8qZEnHmfqICFoiutiLxqYgk5uVB6gpVdv7VPEAR3yBIlGboUeZVm7cMCLcar
        S06l8gMFk5bOvkC2lRuizOkYBmNFzmhYkmpYdw2UOqQiUASpBKbT4GfWXPDOBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599593;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NqHgjVOWoaDaRzKkSO+uxl5YkUVnp6wJPbkpEm8GNM4=;
        b=D8J7PEr6aOxHLKZbr5lqtZXsiFKwVbFqIONv5HHM7pysETRes/IdRBM4Kn3QfPmelm4oAF
        yDFYSgEdAzW7hmBw==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/ti: Remove unused macros
 ti_thermal_get_trip_value() / ti_thermal_trip_is_valid()
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
        amitk@kernel.org
In-Reply-To: <20221003092602.1323944-26-daniel.lezcano@linaro.org>
References: <20221003092602.1323944-26-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <167059959269.4906.1333464194885770214.tip-bot2@tip-bot2>
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

Commit-ID:     a23e3ebef74e2f9c8e58a5052ea6b717cc8fa860
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//a23e3ebef74e2f9c8e58a5052ea6b717cc8fa860
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 03 Oct 2022 11:25:58 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Thu, 08 Dec 2022 14:30:43 +01:00

thermal/drivers/ti: Remove unused macros ti_thermal_get_trip_value() / ti_thermal_trip_is_valid()

The macros:

ti_thermal_get_trip_value()
 ti_thermal_trip_is_valid()

are unused. Remove them.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20221003092602.1323944-26-daniel.lezcano@linaro.org
---
 drivers/thermal/ti-soc-thermal/ti-thermal.h | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal.h b/drivers/thermal/ti-soc-thermal/ti-thermal.h
index c388ecf..4fd2c20 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal.h
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal.h
@@ -38,21 +38,6 @@
 /* Update rates */
 #define FAST_TEMP_MONITORING_RATE				250
 
-/* helper macros */
-/**
- * ti_thermal_get_trip_value - returns trip temperature based on index
- * @i:	trip index
- */
-#define ti_thermal_get_trip_value(i)					\
-	(OMAP_TRIP_HOT + ((i) * OMAP_TRIP_STEP))
-
-/**
- * ti_thermal_is_valid_trip - check for trip index
- * @i:	trip index
- */
-#define ti_thermal_is_valid_trip(trip)				\
-	((trip) >= 0 && (trip) < OMAP_TRIP_NUMBER)
-
 #ifdef CONFIG_TI_THERMAL
 int ti_thermal_expose_sensor(struct ti_bandgap *bgp, int id, char *domain);
 int ti_thermal_remove_sensor(struct ti_bandgap *bgp, int id);
