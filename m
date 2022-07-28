Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68860584346
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jul 2022 17:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbiG1Plm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jul 2022 11:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiG1Pll (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jul 2022 11:41:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D78675B7
        for <linux-pm@vger.kernel.org>; Thu, 28 Jul 2022 08:41:40 -0700 (PDT)
Date:   Thu, 28 Jul 2022 15:41:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659022899;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZHLsE+dmKR2lC02P9Rp0F5nRIXPpN/DovuEV64zRjWM=;
        b=scAxiktTFZVREs5JBZnc/1d4GBRFQXSEMfmvPJpMoYR639y46jbpPUOoaNONSULync1F0/
        cygUrwt/zZSoD/6YgDgKqX9UAqo/r5sXr3Vu3x/CllmTwJEq5qaedmvCZfeC01dVEAdXZX
        x5Dp+4tpgrVXRZPIvPb9yJfMmKloBGB/A78/bonGT6kzeyVtY6BUSvqnc3eNWU7WVS7AUr
        B7llAfnXxHlP8Bgu1MSn80BDK0CC333ImOdnn1sY51FkB4eefHpXP6yWFXiA5GJJzCGMdR
        /oPVFlPHI0FeEmlEJI378OGzD1U64zXidSSQVSmoGhUvh1TerHROhOWcU1uyjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659022899;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZHLsE+dmKR2lC02P9Rp0F5nRIXPpN/DovuEV64zRjWM=;
        b=cLt9zKSVtXxG0nC2cKf47w8yhIzowoo2Thxpqc+RPdZkQzu4FewbmKwLqN2RUi83PYcKHq
        6NopQpn5nZBoJmBA==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/of: Replace device node match with
 device node search
Cc:     Alexandre Bailon <abailon@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Daniel Lezcano <daniel.lezcano@linexp.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220722200007.1839356-3-daniel.lezcano@linexp.org>
References: <20220722200007.1839356-3-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Message-ID: <165902289827.15455.1490577087618999353.tip-bot2@tip-bot2>
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

Commit-ID:     a3193edcbdf9a8ae73b6e1f2da96e920582c1849
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//a3193edcbdf9a8ae73b6e1f2da96e920582c1849
Author:        Daniel Lezcano <daniel.lezcano@linexp.org>
AuthorDate:    Fri, 22 Jul 2022 21:59:59 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 28 Jul 2022 17:29:53 +02:00

thermal/of: Replace device node match with device node search

The thermal_of code builds a trip array associated with the node
pointer in order to compare the trip point phandle with the list.

The thermal trip is a thermal zone property and should be moved
there. If some sensors have hardcoded trip points, they should use the
exported structure instead of redefining again and again their own
structure and data to describe exactly the same things.

In order to move this to the thermal.h header and allow more cleanup,
we need to remove the node pointer from the structure.

Instead of building storing the device node, we search directly in the
device tree the corresponding node. That results in a simplification
of the code and allows to move the structure to thermal.h

Cc: Alexandre Bailon <abailon@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
Link: https://lore.kernel.org/r/20220722200007.1839356-3-daniel.lezcano@linexp.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_of.c | 64 ++++++++++++++++++++++++-----------
 1 file changed, 44 insertions(+), 20 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index b65d435..9295bc5 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -671,6 +671,35 @@ EXPORT_SYMBOL_GPL(devm_thermal_zone_of_sensor_unregister);
 
 /***   functions parsing device tree nodes   ***/
 
+static int of_find_trip_id(struct device_node *np, struct device_node *trip)
+{
+	struct device_node *trips;
+	struct device_node *t;
+	int i = 0;
+
+	trips = of_get_child_by_name(np, "trips");
+	if (!trips) {
+		pr_err("Failed to find 'trips' node\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Find the trip id point associated with the cooling device map
+	 */
+	for_each_child_of_node(trips, t) {
+
+		if (t == trip)
+			goto out;
+		i++;
+	}
+
+	i = -ENXIO;
+out:
+	of_node_put(trips);
+
+	return i;
+}
+
 /**
  * thermal_of_populate_bind_params - parse and fill cooling map data
  * @np: DT node containing a cooling-map node
@@ -686,14 +715,13 @@ EXPORT_SYMBOL_GPL(devm_thermal_zone_of_sensor_unregister);
  * Return: 0 on success, proper error code otherwise
  */
 static int thermal_of_populate_bind_params(struct device_node *np,
-					   struct __thermal_bind_params *__tbp,
-					   struct thermal_trip *trips,
-					   int ntrips)
+					   struct __thermal_bind_params *__tbp)
 {
 	struct of_phandle_args cooling_spec;
 	struct __thermal_cooling_bind_param *__tcbp;
 	struct device_node *trip;
 	int ret, i, count;
+	int trip_id;
 	u32 prop;
 
 	/* Default weight. Usage is optional */
@@ -708,18 +736,14 @@ static int thermal_of_populate_bind_params(struct device_node *np,
 		return -ENODEV;
 	}
 
-	/* match using device_node */
-	for (i = 0; i < ntrips; i++)
-		if (trip == trips[i].np) {
-			__tbp->trip_id = i;
-			break;
-		}
-
-	if (i == ntrips) {
-		ret = -ENODEV;
+	trip_id = of_find_trip_id(np, trip);
+	if (trip_id < 0) {
+		ret = trip_id;
 		goto end;
 	}
 
+	__tbp->trip_id = trip_id;
+
 	count = of_count_phandle_with_args(np, "cooling-device",
 					   "#cooling-cells");
 	if (count <= 0) {
@@ -868,6 +892,7 @@ static struct __thermal_zone
 __init *thermal_of_build_thermal_zone(struct device_node *np)
 {
 	struct device_node *child = NULL, *gchild;
+	struct device_node *trips;
 	struct __thermal_zone *tz;
 	int ret, i;
 	u32 prop, coef[2];
@@ -910,13 +935,13 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
 	}
 
 	/* trips */
-	child = of_get_child_by_name(np, "trips");
+	trips = of_get_child_by_name(np, "trips");
 
 	/* No trips provided */
-	if (!child)
+	if (!trips)
 		goto finish;
 
-	tz->ntrips = of_get_child_count(child);
+	tz->ntrips = of_get_child_count(trips);
 	if (tz->ntrips == 0) /* must have at least one child */
 		goto finish;
 
@@ -927,14 +952,12 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
 	}
 
 	i = 0;
-	for_each_child_of_node(child, gchild) {
+	for_each_child_of_node(trips, gchild) {
 		ret = thermal_of_populate_trip(gchild, &tz->trips[i++]);
 		if (ret)
 			goto free_trips;
 	}
 
-	of_node_put(child);
-
 	/* cooling-maps */
 	child = of_get_child_by_name(np, "cooling-maps");
 
@@ -954,13 +977,13 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
 
 	i = 0;
 	for_each_child_of_node(child, gchild) {
-		ret = thermal_of_populate_bind_params(gchild, &tz->tbps[i++],
-						      tz->trips, tz->ntrips);
+		ret = thermal_of_populate_bind_params(gchild, &tz->tbps[i++]);
 		if (ret)
 			goto free_tbps;
 	}
 
 finish:
+	of_node_put(trips);
 	of_node_put(child);
 
 	return tz;
@@ -981,6 +1004,7 @@ free_trips:
 	for (i = 0; i < tz->ntrips; i++)
 		of_node_put(tz->trips[i].np);
 	kfree(tz->trips);
+	of_node_put(trips);
 	of_node_put(gchild);
 free_tz:
 	kfree(tz);
