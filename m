Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EADC2564932
	for <lists+linux-pm@lfdr.de>; Sun,  3 Jul 2022 20:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbiGCScL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 Jul 2022 14:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbiGCSb4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 Jul 2022 14:31:56 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53196313
        for <linux-pm@vger.kernel.org>; Sun,  3 Jul 2022 11:31:44 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id g39-20020a05600c4ca700b003a03ac7d540so6701191wmp.3
        for <linux-pm@vger.kernel.org>; Sun, 03 Jul 2022 11:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jk6Zu7YOAs+Rffq4qnY/9T9F1YET7fLb3BWny63zQyY=;
        b=zvNljsfyutvIHJIr7s846lTOdo7lNtsV8c+P0ET1m9aaS5dlkvKqLYpMfJPqfiE38P
         H4m34iPtH2mI9JqinWXmdSMfUntxvX26Ux60ejkdYrfQ9gNoRHTxBz82u903+rLF7yxT
         IitBnc3i92NGCrZ7+Tfv0tliLHcUVRr+dn8KQExFqhSFPsa8eEnMsHnzO+MulZMk3BFc
         18OyWW7QisXop8xvlNlWkaxr7q/3IrykERPUiK5GwrCo6CQ5thymB/0+W5f3eDS6DtZp
         h+eqQvBV44qNP3KghJhNYinq4xvuhu0qe9wlu5eRkgUE0dvydIEELHNaXW/y+kTMvbaH
         Qjlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jk6Zu7YOAs+Rffq4qnY/9T9F1YET7fLb3BWny63zQyY=;
        b=7UWXaaS8FZcfbYZtym1hp/Sd5bto/R44oKFiXN84+3DblNEaWOxBDHRTut63YiYZmo
         0BPgb80E/lMssE+wtNr3sVJCTqbu4QVYglb3OD77zhY5wO/hs8vZE1/sEoXA0A1qqIc8
         NvYJUPjJCyIPNKGftpiThyVJqBSJRIVKPElDvHGyVAExPwed+yI2xarDClsxtOW8TPQt
         cOcOdUdbq4mJZahUo7Fg24ZRsax3EA3FFKWTip8DiVWli5+DcwC0bVNjo1EF8caI9keV
         QNDXJIqjwmLlukj2vqjRBkNh9RDgUsZhOFi9DtYxi8/jKaD9cbt1jK4vsGJknnaF/qI1
         L/rw==
X-Gm-Message-State: AJIora9af/dJXN0n/2S/K3jIs4Waa5xInsY7sIjAdXoHzFmgyLo7+Png
        T995VouNuENooG2zS2zezvPYkA==
X-Google-Smtp-Source: AGRyM1tIj4RTXx38KKeGaCcnVNxP0RuWB2ivIFi83e6UE58tH/+iDzqJowtMdqRA/bbFkFfZy8dcBg==
X-Received: by 2002:a05:600c:154f:b0:3a0:54f9:4388 with SMTP id f15-20020a05600c154f00b003a054f94388mr26423001wmg.16.1656873103107;
        Sun, 03 Jul 2022 11:31:43 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id x10-20020a5d54ca000000b0021b85664636sm27504258wrv.16.2022.07.03.11.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 11:31:42 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, abailon@baylibre.com,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v3 12/12] thermal/of: Initialize trip points separately
Date:   Sun,  3 Jul 2022 20:30:59 +0200
Message-Id: <20220703183059.4133659-13-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220703183059.4133659-1-daniel.lezcano@linexp.org>
References: <20220703183059.4133659-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Self contain the trip initialization from the device tree in a single
function for the sake of making the code flow more clear.

Cc: Alexandre Bailon <abailon@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc; Eduardo Valentin <eduval@amazon.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/thermal_of.c | 84 ++++++++++++++++++++++++------------
 1 file changed, 57 insertions(+), 27 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index bc885729bf23..1aa52df507b6 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -693,7 +693,8 @@ static int of_find_trip_id(struct device_node *np, struct device_node *trip)
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
-		goto finish;
-
-	tz->ntrips = of_get_child_count(trips);
-	if (tz->ntrips == 0) /* must have at least one child */
+	tz->trips = thermal_of_trips_init(np, &tz->ntrips);
+	if (IS_ERR(tz->trips)) {
+		ret = PTR_ERR(tz->trips);
 		goto finish;
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
@@ -952,9 +981,11 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
 
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
@@ -976,7 +1007,6 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
 	kfree(tz->tbps);
 free_trips:
 	kfree(tz->trips);
-	of_node_put(gchild);
 free_tz:
 	kfree(tz);
 	of_node_put(child);
-- 
2.25.1

