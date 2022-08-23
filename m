Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1A959E706
	for <lists+linux-pm@lfdr.de>; Tue, 23 Aug 2022 18:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244520AbiHWQWj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Aug 2022 12:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244476AbiHWQWX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Aug 2022 12:22:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DC410B52F
        for <linux-pm@vger.kernel.org>; Tue, 23 Aug 2022 05:43:06 -0700 (PDT)
Date:   Tue, 23 Aug 2022 12:43:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661258584;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0rA1AtVrELcSXaARKPseEF+hQ/ILnbSNJ5Xw1YcOoWY=;
        b=GrcIkj0YXoI62ZfIKNTSmNE8lSxolV+x6X3MFx6fBqmHXmX34NEl87hRBV0SjiM6k6sH/A
        TXMqkKd8IlVFnl8unp+i3IpjlbZv5dFbXz7FNgnrOy2TNRvKKUP6K9q0ioWNkAtSPNsn8u
        XMnRj3uWiw7rWQRscnysPDSwKKVu7MmmanEOCpNyOfzNZldqrO3JdANhhOFMmuWZuRz7E5
        lvNP5+OZKFgFseebnzJkuVAYDLNV2+8qON8tD18bvzZm2H+okvvr5gIrEAj/61cp5khs/T
        Zkyt+4M08g7NI3fdCXiiOI58gkWlx4533Z1kdSSSqJeJrI2n2jGgmoALfzky+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661258584;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0rA1AtVrELcSXaARKPseEF+hQ/ILnbSNJ5Xw1YcOoWY=;
        b=/+yt3vxqA3jFwXUAPJ4t4P6l2AbtxaQY02YSJD4vHFLrw7BZZFh87XP5mg8g1MRIeOfztE
        X0kJp2ZCylhsGVAw==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/imx: Switch to new of API
Cc:     Daniel Lezcano <daniel.lezcano@linexp.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220804224349.1926752-17-daniel.lezcano@linexp.org>
References: <20220804224349.1926752-17-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Message-ID: <166125858364.401.3316377328503286356.tip-bot2@tip-bot2>
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

Commit-ID:     32fb9a8a9d0db3edee50f9c2fcc74fcc26812b86
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//32fb9a8a9d0db3edee50f9c2fcc74fcc26812b86
Author:        Daniel Lezcano <daniel.lezcano@linexp.org>
AuthorDate:    Fri, 05 Aug 2022 00:43:32 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 17 Aug 2022 14:09:38 +02:00

thermal/drivers/imx: Switch to new of API

The thermal OF code has a new API allowing to migrate the OF
initialization to a simpler approach. The ops are no longer device
tree specific and are the generic ones provided by the core code.

Convert the ops to the thermal_zone_device_ops format and use the new
API to register the thermal zone with these generic ops.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
Link: https://lore.kernel.org/r/20220804224349.1926752-17-daniel.lezcano@linexp.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/imx8mm_thermal.c | 14 +++++++-------
 drivers/thermal/imx_sc_thermal.c | 14 +++++++-------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/thermal/imx8mm_thermal.c b/drivers/thermal/imx8mm_thermal.c
index af666bd..e2c2673 100644
--- a/drivers/thermal/imx8mm_thermal.c
+++ b/drivers/thermal/imx8mm_thermal.c
@@ -96,15 +96,15 @@ static int imx8mp_tmu_get_temp(void *data, int *temp)
 	return 0;
 }
 
-static int tmu_get_temp(void *data, int *temp)
+static int tmu_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct tmu_sensor *sensor = data;
+	struct tmu_sensor *sensor = tz->devdata;
 	struct imx8mm_tmu *tmu = sensor->priv;
 
-	return tmu->socdata->get_temp(data, temp);
+	return tmu->socdata->get_temp(sensor, temp);
 }
 
-static struct thermal_zone_of_device_ops tmu_tz_ops = {
+static const struct thermal_zone_device_ops tmu_tz_ops = {
 	.get_temp = tmu_get_temp,
 };
 
@@ -165,9 +165,9 @@ static int imx8mm_tmu_probe(struct platform_device *pdev)
 	for (i = 0; i < data->num_sensors; i++) {
 		tmu->sensors[i].priv = tmu;
 		tmu->sensors[i].tzd =
-			devm_thermal_zone_of_sensor_register(&pdev->dev, i,
-							     &tmu->sensors[i],
-							     &tmu_tz_ops);
+			devm_thermal_of_zone_register(&pdev->dev, i,
+						      &tmu->sensors[i],
+						      &tmu_tz_ops);
 		if (IS_ERR(tmu->sensors[i].tzd)) {
 			ret = PTR_ERR(tmu->sensors[i].tzd);
 			dev_err(&pdev->dev,
diff --git a/drivers/thermal/imx_sc_thermal.c b/drivers/thermal/imx_sc_thermal.c
index 331a241..10bfa65 100644
--- a/drivers/thermal/imx_sc_thermal.c
+++ b/drivers/thermal/imx_sc_thermal.c
@@ -43,11 +43,11 @@ struct imx_sc_msg_misc_get_temp {
 	} data;
 } __packed __aligned(4);
 
-static int imx_sc_thermal_get_temp(void *data, int *temp)
+static int imx_sc_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	struct imx_sc_msg_misc_get_temp msg;
 	struct imx_sc_rpc_msg *hdr = &msg.hdr;
-	struct imx_sc_sensor *sensor = data;
+	struct imx_sc_sensor *sensor = tz->devdata;
 	int ret;
 
 	msg.data.req.resource_id = sensor->resource_id;
@@ -70,7 +70,7 @@ static int imx_sc_thermal_get_temp(void *data, int *temp)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops imx_sc_thermal_ops = {
+static const struct thermal_zone_device_ops imx_sc_thermal_ops = {
 	.get_temp = imx_sc_thermal_get_temp,
 };
 
@@ -109,10 +109,10 @@ static int imx_sc_thermal_probe(struct platform_device *pdev)
 			break;
 		}
 
-		sensor->tzd = devm_thermal_zone_of_sensor_register(&pdev->dev,
-								   sensor->resource_id,
-								   sensor,
-								   &imx_sc_thermal_ops);
+		sensor->tzd = devm_thermal_of_zone_register(&pdev->dev,
+							    sensor->resource_id,
+							    sensor,
+							    &imx_sc_thermal_ops);
 		if (IS_ERR(sensor->tzd)) {
 			dev_err(&pdev->dev, "failed to register thermal zone\n");
 			ret = PTR_ERR(sensor->tzd);
