Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0639959E71D
	for <lists+linux-pm@lfdr.de>; Tue, 23 Aug 2022 18:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242926AbiHWQWg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Aug 2022 12:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244354AbiHWQWH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Aug 2022 12:22:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBF59E124
        for <linux-pm@vger.kernel.org>; Tue, 23 Aug 2022 05:43:01 -0700 (PDT)
Date:   Tue, 23 Aug 2022 12:42:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661258579;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mKPk8Z3N3enYeV0vBioN18Cbb82er52ix79TR1j2kNM=;
        b=OeENLWJn26diJSWbCZnyIn64xYLisCK1/idtwqbbNqT7/hSRlZ9XC+t78bB7xquK39Xj2k
        L3OJBR8NcWK/5g2Uhxv0Xd50W9mVc8VMoWVIgD8uwF7ttAj5/+8FZjGnuZ0jurrYYhnRcQ
        kqX8vH+7gLmv5FZj/YunpLi6dxbJ8h+5BuNAzwbgVuXKVMPf+LO66MJalorfR6MKuvuHIA
        CQqbaupjugnpvtgbGl4CGk+9rSr+MF0ld5qn0KF77kaaIQLJwMQPcTLiHNM3QR1wq2zj0v
        3xj0rDMrU4AjpmoQGcx8bQEZeEBh7n+KwUlIoYduQ/BG/CgPc4S2uicF2XLrkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661258579;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mKPk8Z3N3enYeV0vBioN18Cbb82er52ix79TR1j2kNM=;
        b=+dhnOD+kZacqaZYXhLDciGnFBzTDwAA3HPHR50XNpgQdTNX+HeOJWg72rQ+r4sbZIquOPU
        i3fcBiPiyXZ6rZBA==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/banggap: Switch to new of API
Cc:     Daniel Lezcano <daniel.lezcano@linexp.org>,
        Bryan Brattlof <bb@ti.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220804224349.1926752-22-daniel.lezcano@linexp.org>
References: <20220804224349.1926752-22-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Message-ID: <166125857856.401.6272041334707552965.tip-bot2@tip-bot2>
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

Commit-ID:     b86105ed9f3bfead2aaf3daefa99b694ba5da443
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//b86105ed9f3bfead2aaf3daefa99b694ba5da443
Author:        Daniel Lezcano <daniel.lezcano@linexp.org>
AuthorDate:    Fri, 05 Aug 2022 00:43:37 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 17 Aug 2022 14:09:38 +02:00

thermal/drivers/banggap: Switch to new of API

The thermal OF code has a new API allowing to migrate the OF
initialization to a simpler approach. The ops are no longer device
tree specific and are the generic ones provided by the core code.

Convert the ops to the thermal_zone_device_ops format and use the new
API to register the thermal zone with these generic ops.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
Link: https://lore.kernel.org/r/20220804224349.1926752-22-daniel.lezcano@linexp.org
Reviewed-by: Bryan Brattlof <bb@ti.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/k3_bandgap.c       | 12 ++++++------
 drivers/thermal/k3_j72xx_bandgap.c | 12 +++++-------
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/k3_bandgap.c b/drivers/thermal/k3_bandgap.c
index 5d0b3ff..22c9bcb 100644
--- a/drivers/thermal/k3_bandgap.c
+++ b/drivers/thermal/k3_bandgap.c
@@ -139,9 +139,9 @@ static int k3_bgp_read_temp(struct k3_thermal_data *devdata,
 	return 0;
 }
 
-static int k3_thermal_get_temp(void *devdata, int *temp)
+static int k3_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct k3_thermal_data *data = devdata;
+	struct k3_thermal_data *data = tz->devdata;
 	int ret = 0;
 
 	ret = k3_bgp_read_temp(data, temp);
@@ -151,7 +151,7 @@ static int k3_thermal_get_temp(void *devdata, int *temp)
 	return ret;
 }
 
-static const struct thermal_zone_of_device_ops k3_of_thermal_ops = {
+static const struct thermal_zone_device_ops k3_of_thermal_ops = {
 	.get_temp = k3_thermal_get_temp,
 };
 
@@ -213,9 +213,9 @@ static int k3_bandgap_probe(struct platform_device *pdev)
 		writel(val, data[id].bgp->base + data[id].ctrl_offset);
 
 		data[id].tzd =
-		devm_thermal_zone_of_sensor_register(dev, id,
-						     &data[id],
-						     &k3_of_thermal_ops);
+		devm_thermal_of_zone_register(dev, id,
+					      &data[id],
+					      &k3_of_thermal_ops);
 		if (IS_ERR(data[id].tzd)) {
 			dev_err(dev, "thermal zone device is NULL\n");
 			ret = PTR_ERR(data[id].tzd);
diff --git a/drivers/thermal/k3_j72xx_bandgap.c b/drivers/thermal/k3_j72xx_bandgap.c
index 115a44e..16b6bcf 100644
--- a/drivers/thermal/k3_j72xx_bandgap.c
+++ b/drivers/thermal/k3_j72xx_bandgap.c
@@ -247,9 +247,9 @@ static inline int k3_bgp_read_temp(struct k3_thermal_data *devdata,
 }
 
 /* Get temperature callback function for thermal zone */
-static int k3_thermal_get_temp(void *devdata, int *temp)
+static int k3_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct k3_thermal_data *data = devdata;
+	struct k3_thermal_data *data = tz->devdata;
 	int ret = 0;
 
 	ret = k3_bgp_read_temp(data, temp);
@@ -259,7 +259,7 @@ static int k3_thermal_get_temp(void *devdata, int *temp)
 	return ret;
 }
 
-static const struct thermal_zone_of_device_ops k3_of_thermal_ops = {
+static const struct thermal_zone_device_ops k3_of_thermal_ops = {
 	.get_temp = k3_thermal_get_temp,
 };
 
@@ -474,10 +474,8 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 		writel(val, data[id].bgp->cfg2_base + data[id].ctrl_offset);
 
 		bgp->ts_data[id] = &data[id];
-		ti_thermal =
-		devm_thermal_zone_of_sensor_register(bgp->dev, id,
-						     &data[id],
-						     &k3_of_thermal_ops);
+		ti_thermal = devm_thermal_of_zone_register(bgp->dev, id, &data[id],
+							   &k3_of_thermal_ops);
 		if (IS_ERR(ti_thermal)) {
 			dev_err(bgp->dev, "thermal zone device is NULL\n");
 			ret = PTR_ERR(ti_thermal);
