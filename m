Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE6959E6EC
	for <lists+linux-pm@lfdr.de>; Tue, 23 Aug 2022 18:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244636AbiHWQWA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Aug 2022 12:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244646AbiHWQV2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Aug 2022 12:21:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D50B16D2EF
        for <linux-pm@vger.kernel.org>; Tue, 23 Aug 2022 05:42:56 -0700 (PDT)
Date:   Tue, 23 Aug 2022 12:42:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661258574;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PoF/cR7ABZcWeyTVHIAuuAp57p3Nyyg3ln02aGy0E9k=;
        b=ncI/zuKk9ua1ZvS1yDJRZWkwJ2vSk2wTkqOVf1QvjhHK06YzhkzWdWc05WhybL2sFtBl2B
        JdZWttjRLWWWEZscsvtGZ5PN52Knw+wL1224SSj3gD5LJVOCVP2enJ0kGHnT0rw4XbfuG4
        2Q1gEH90r37QMwxPEfUQwSN6eY4UWxzzf2+2LFhSsCe+OV5Rhk8hPJZHgQnAHiF4JKsG5d
        jhJT/upa78ap6UrTFNIcaOd7kb/DcmFwIOamzkkKbAdNVWSnYTmDeo49LiK+6AlHA7ySmf
        DaXEo35j+CqMokgHO6zwGnyiETcjCR6BaXHFjeM/vUfjs0xGz0GN+331HY+ahw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661258574;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PoF/cR7ABZcWeyTVHIAuuAp57p3Nyyg3ln02aGy0E9k=;
        b=fIvFqdm50WQCqgBfOGrmYfJilVMxgz54yYIRpFhoBcQEXFiztUT4sgM1B2dSS+X4CSou0M
        JCCnwQibTrMcgvCg==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] hwmon: pm_bus: core: Switch to new of thermal API
Cc:     Daniel Lezcano <daniel.lezcano@linexp.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220804224349.1926752-27-daniel.lezcano@linexp.org>
References: <20220804224349.1926752-27-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Message-ID: <166125857355.401.10260856921117198578.tip-bot2@tip-bot2>
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

Commit-ID:     613ed3f67609291c9b757d62f1f6734e40cb60d8
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//613ed3f67609291c9b757d62f1f6734e40cb60d8
Author:        Daniel Lezcano <daniel.lezcano@linexp.org>
AuthorDate:    Fri, 05 Aug 2022 00:43:42 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 17 Aug 2022 14:09:38 +02:00

hwmon: pm_bus: core: Switch to new of thermal API

The thermal OF code has a new API allowing to migrate the OF
initialization to a simpler approach. The ops are no longer device
tree specific and are the generic ones provided by the core code.

Convert the ops to the thermal_zone_device_ops format and use the new
API to register the thermal zone with these generic ops.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
Link: https://lore.kernel.org/r/20220804224349.1926752-27-daniel.lezcano@linexp.org
Acked-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/hwmon/pmbus/pmbus_core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index f10bac8..5541d26 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -1270,9 +1270,9 @@ struct pmbus_thermal_data {
 	struct pmbus_sensor *sensor;
 };
 
-static int pmbus_thermal_get_temp(void *data, int *temp)
+static int pmbus_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct pmbus_thermal_data *tdata = data;
+	struct pmbus_thermal_data *tdata = tz->devdata;
 	struct pmbus_sensor *sensor = tdata->sensor;
 	struct pmbus_data *pmbus_data = tdata->pmbus_data;
 	struct i2c_client *client = to_i2c_client(pmbus_data->dev);
@@ -1296,7 +1296,7 @@ static int pmbus_thermal_get_temp(void *data, int *temp)
 	return ret;
 }
 
-static const struct thermal_zone_of_device_ops pmbus_thermal_ops = {
+static const struct thermal_zone_device_ops pmbus_thermal_ops = {
 	.get_temp = pmbus_thermal_get_temp,
 };
 
@@ -1314,8 +1314,8 @@ static int pmbus_thermal_add_sensor(struct pmbus_data *pmbus_data,
 	tdata->sensor = sensor;
 	tdata->pmbus_data = pmbus_data;
 
-	tzd = devm_thermal_zone_of_sensor_register(dev, index, tdata,
-						   &pmbus_thermal_ops);
+	tzd = devm_thermal_of_zone_register(dev, index, tdata,
+					    &pmbus_thermal_ops);
 	/*
 	 * If CONFIG_THERMAL_OF is disabled, this returns -ENODEV,
 	 * so ignore that error but forward any other error.
