Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D7C64853C
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbiLIP1I (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbiLIP0l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2828B386
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:35 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599592;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=37gGABeL/ImycR4zP/wPQUHz2101y/5nALJUNoAcM6U=;
        b=blf57VbRtykzHjQcOJ0q962rLHfJWwA9ssrgxKo6Gf6Jki6U/UbgJaQAPkpmWmwDKMOSHg
        LRPvY4bJbRrIGLQLuthaK7WRVayBz+dNpFOH/u8Sy54m0U3ptY9xmF/P+hpEzWTEVFNeBa
        49lCEw2Qr/kklRd1edmWcci4OA5L9+CDWfd1oX8Q9v5YezdaDZ/77Cv0P7QkpuYnPMdh33
        1TPscA+NbSW/XzC9tczzFVhF2sj7fqAmtwh9Os794WU6fOxXoQUa37eNFjlt+SmK8Y+JZ8
        oZqeI8szboHw3BkRV4ivAt0dGsE+Pm0K6Kmi5XBgEhmRdz6o2ht/gkxsZkMR+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599592;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=37gGABeL/ImycR4zP/wPQUHz2101y/5nALJUNoAcM6U=;
        b=Y0ngqlSZscMuRzeWuj2fSiiNt5V/8oX6g+pS6WFWJJy8BWJ5Aij81jKlYKYrbpR3g9yT8J
        3+xbNdKNfeoGh2Dg==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/cxgb4: Use generic
 thermal_zone_get_trip() function
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>, rui.zhang@intel.com,
        amitk@kernel.org
In-Reply-To: <20221003092602.1323944-28-daniel.lezcano@linaro.org>
References: <20221003092602.1323944-28-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <167059959237.4906.1351902830277842178.tip-bot2@tip-bot2>
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

Commit-ID:     0c5a6658c5482ec7fe1f5ac526bd61ce83c06fb0
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//0c5a6658c5482ec7fe1f5ac526bd61ce83c06fb0
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 03 Oct 2022 11:26:00 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Thu, 08 Dec 2022 14:30:43 +01:00

thermal/drivers/cxgb4: Use generic thermal_zone_get_trip() function

The thermal framework gives the possibility to register the trip
points with the thermal zone. When that is done, no get_trip_* ops are
needed and they can be removed.

Convert ops content logic into generic trip points and register them with the
thermal zone.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/r/20221003092602.1323944-28-daniel.lezcano@linaro.org
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h         |  2 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.c | 39 ++-----------
 2 files changed, 7 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
index 5657ac8..fca9533 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
@@ -1079,8 +1079,6 @@ struct mbox_list {
 #if IS_ENABLED(CONFIG_THERMAL)
 struct ch_thermal {
 	struct thermal_zone_device *tzdev;
-	int trip_temp;
-	int trip_type;
 };
 #endif
 
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.c
index 9a6d652..95e1b41 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.c
@@ -29,36 +29,12 @@ static int cxgb4_thermal_get_temp(struct thermal_zone_device *tzdev,
 	return 0;
 }
 
-static int cxgb4_thermal_get_trip_type(struct thermal_zone_device *tzdev,
-				       int trip, enum thermal_trip_type *type)
-{
-	struct adapter *adap = tzdev->devdata;
-
-	if (!adap->ch_thermal.trip_temp)
-		return -EINVAL;
-
-	*type = adap->ch_thermal.trip_type;
-	return 0;
-}
-
-static int cxgb4_thermal_get_trip_temp(struct thermal_zone_device *tzdev,
-				       int trip, int *temp)
-{
-	struct adapter *adap = tzdev->devdata;
-
-	if (!adap->ch_thermal.trip_temp)
-		return -EINVAL;
-
-	*temp = adap->ch_thermal.trip_temp;
-	return 0;
-}
-
 static struct thermal_zone_device_ops cxgb4_thermal_ops = {
 	.get_temp = cxgb4_thermal_get_temp,
-	.get_trip_type = cxgb4_thermal_get_trip_type,
-	.get_trip_temp = cxgb4_thermal_get_trip_temp,
 };
 
+static struct thermal_trip trip = { .type = THERMAL_TRIP_CRITICAL } ;
+
 int cxgb4_thermal_init(struct adapter *adap)
 {
 	struct ch_thermal *ch_thermal = &adap->ch_thermal;
@@ -79,15 +55,14 @@ int cxgb4_thermal_init(struct adapter *adap)
 	if (ret < 0) {
 		num_trip = 0; /* could not get trip temperature */
 	} else {
-		ch_thermal->trip_temp = val * 1000;
-		ch_thermal->trip_type = THERMAL_TRIP_CRITICAL;
+		trip.temperature = val * 1000;
 	}
 
 	snprintf(ch_tz_name, sizeof(ch_tz_name), "cxgb4_%s", adap->name);
-	ch_thermal->tzdev = thermal_zone_device_register(ch_tz_name, num_trip,
-							 0, adap,
-							 &cxgb4_thermal_ops,
-							 NULL, 0, 0);
+	ch_thermal->tzdev = thermal_zone_device_register_with_trips(ch_tz_name, &trip, num_trip,
+								    0, adap,
+								    &cxgb4_thermal_ops,
+								    NULL, 0, 0);
 	if (IS_ERR(ch_thermal->tzdev)) {
 		ret = PTR_ERR(ch_thermal->tzdev);
 		dev_err(adap->pdev_dev, "Failed to register thermal zone\n");
