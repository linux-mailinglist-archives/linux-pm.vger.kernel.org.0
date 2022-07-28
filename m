Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5D558433F
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jul 2022 17:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiG1Pli (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jul 2022 11:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiG1Plg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jul 2022 11:41:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2C6691C9
        for <linux-pm@vger.kernel.org>; Thu, 28 Jul 2022 08:41:33 -0700 (PDT)
Date:   Thu, 28 Jul 2022 15:41:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659022892;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e8jn+yIVpzOJD06InEZpp4B6Qd2P2DZqlJwk5jrfy6E=;
        b=feWI0px0TH5zu1PgszxCvGR/rafa7fNCdRAHA3i6hNipE/Ws/BbEvS1g+KNTd0nKMuZMLJ
        XeLCzcHWi+221rHZjCXZf6vVtteDRTIJJjE1PyS2XFOS+K/6R0zyeW0Z9TQUqVxv1xy4ex
        Y1OW4zUrz7kG/bkQ2J8GFSJ1he6ZUPBNQeSBG7bdS1yoGOlcTKSIJljI6/BGtRJk02ex3X
        AWLVemNxRqYj5K5J61qgL3GUxP3gbt/boqM0fP2kEbbOq97lUmFbKCc4eT3vk2McUQVFXf
        lUACJiQUJb3vLr59Z7BmKrnS2lOdKI9J8GwqOs1NnpX9FAQZdHDeDX/DlElV/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659022892;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e8jn+yIVpzOJD06InEZpp4B6Qd2P2DZqlJwk5jrfy6E=;
        b=lfGjHgx5PY1aHKlIRNUFdINjeVhT5cSPrkwUSAKL0VRb/6fCctTFiKJ1FYo7JEX31cMky/
        2q2DlfcNTOZBC7CQ==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/of: Initialize trip points separately
Cc:     Alexandre Bailon <abailon@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Daniel Lezcano <daniel.lezcano@linexp.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220722200007.1839356-11-daniel.lezcano@linexp.org>
References: <20220722200007.1839356-11-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Message-ID: <165902288999.15455.10164076334688896417.tip-bot2@tip-bot2>
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

Commit-ID:     d0c75fa2c17f082b32a5f26ff40bf378b12952de
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//d0c75fa2c17f082b32a5f26ff40bf378b12952de
Author:        Daniel Lezcano <daniel.lezcano@linexp.org>
AuthorDate:    Fri, 22 Jul 2022 22:00:07 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 28 Jul 2022 17:29:57 +02:00

thermal/of: Initialize trip points separately

Self contain the trip initialization from the device tree in a single
function for the sake of making the code flow more clear.

Cc: Alexandre Bailon <abailon@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
Link: https://lore.kernel.org/r/20220722200007.1839356-11-daniel.lezcano@linexp.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_of.c | 86 +++++++++++++++++++++++------------
 1 file changed, 57 insertions(+), 29 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 1d0b657..802c30b 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -693,7 +693,8 @@ out:
  *
  * Return: 0 on success, proper error code otherwise
  */
-static int thermal_of_populate_bind_params(struct device_node *np,
+static int thermal_of_populate_bind_params(struct device_node *tz_np,
+					   struct device_node *np,
 					   struct __thermal_bind_params *__tbp)
 {
 	struct of_phandle_args cooling_spec;
@@ -715,7 +716,7 @@ static int thermal_of_populate_bind_params(struct device_node *np,
 		return -ENODEV;
 	}
 
-	trip_id = of_find_trip_id(np, trip);
+	trip_id = of_find_trip_id(tz_np, trip);
 	if (trip_id < 0) {
 		ret = trip_id;
 		goto end;
@@ -849,6 +850,53 @@ static int thermal_of_populate_trip(struct device_node *np,
 	return 0;
 }
 
+static struct thermal_trip *thermal_of_trips_init(struct device_node *np, int *ntrips)
+{
+	struct thermal_trip *tt;
+	struct device_node *trips, *trip;
+	int ret, count;
+
+	trips = of_get_child_by_name(np, "trips");
+	if (!trips) {
+		pr_err("Failed to find 'trips' node\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	count = of_get_child_count(trips);
+	if (!count) {
+		pr_err("No trip point defined\n");
+		ret = -EINVAL;
+		goto out_of_node_put;
+	}
+
+	tt = kzalloc(sizeof(*tt) * count, GFP_KERNEL);
+	if (!tt) {
+		ret = -ENOMEM;
+		goto out_of_node_put;
+	}
+
+	*ntrips = count;
+
+	count = 0;
+	for_each_child_of_node(trips, trip) {
+		ret = thermal_of_populate_trip(trip, &tt[count++]);
+		if (ret)
+			goto out_kfree;
+	}
+
+	of_node_put(trips);
+
+	return tt;
+
+out_kfree:
+	kfree(tt);
+	*ntrips = 0;
+out_of_node_put:
+	of_node_put(trips);
+
+	return ERR_PTR(ret);
+}
+
 /**
  * thermal_of_build_thermal_zone - parse and fill one thermal zone data
  * @np: DT node containing a thermal zone node
@@ -867,7 +915,6 @@ static struct __thermal_zone
 __init *thermal_of_build_thermal_zone(struct device_node *np)
 {
 	struct device_node *child = NULL, *gchild;
-	struct device_node *trips;
 	struct __thermal_zone *tz;
 	int ret, i;
 	u32 prop, coef[2];
@@ -909,28 +956,10 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
 		tz->offset = 0;
 	}
 
-	/* trips */
-	trips = of_get_child_by_name(np, "trips");
-
-	/* No trips provided */
-	if (!trips)
+	tz->trips = thermal_of_trips_init(np, &tz->ntrips);
+	if (IS_ERR(tz->trips)) {
+		ret = PTR_ERR(tz->trips);
 		goto finish;
-
-	tz->ntrips = of_get_child_count(trips);
-	if (tz->ntrips == 0) /* must have at least one child */
-		goto finish;
-
-	tz->trips = kcalloc(tz->ntrips, sizeof(*tz->trips), GFP_KERNEL);
-	if (!tz->trips) {
-		ret = -ENOMEM;
-		goto free_tz;
-	}
-
-	i = 0;
-	for_each_child_of_node(trips, gchild) {
-		ret = thermal_of_populate_trip(gchild, &tz->trips[i++]);
-		if (ret)
-			goto free_trips;
 	}
 
 	/* cooling-maps */
@@ -952,13 +981,14 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
 
 	i = 0;
 	for_each_child_of_node(child, gchild) {
-		ret = thermal_of_populate_bind_params(gchild, &tz->tbps[i++]);
-		if (ret)
+		ret = thermal_of_populate_bind_params(np, gchild, &tz->tbps[i++]);
+		if (ret) {
+			of_node_put(gchild);
 			goto free_tbps;
+		}
 	}
 
 finish:
-	of_node_put(trips);
 	of_node_put(child);
 
 	return tz;
@@ -977,8 +1007,6 @@ free_tbps:
 	kfree(tz->tbps);
 free_trips:
 	kfree(tz->trips);
-	of_node_put(trips);
-	of_node_put(gchild);
 free_tz:
 	kfree(tz);
 	of_node_put(child);
