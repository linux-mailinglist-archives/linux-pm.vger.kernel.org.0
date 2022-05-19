Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F8F52D2CC
	for <lists+linux-pm@lfdr.de>; Thu, 19 May 2022 14:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238010AbiESMoX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 May 2022 08:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbiESMoV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2022 08:44:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A016BA57A
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2022 05:44:20 -0700 (PDT)
Date:   Thu, 19 May 2022 12:44:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652964259;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aqWjEFrzBI1ff8CxF/pYcxM4zJ9pVrTfH5VIk3UT/14=;
        b=cM7N3pbbCyQMYM0DxrOc8BQKD7XWQyj70fstZOEv8ssurtH4wvnvk/keXBjZIJs/D4Un+H
        aPaQz3WlCMlSxo/Dy765T4OzmXB3fZI0ssWA8xlvdTkVV8AxhyPlqyJ4v30pjrPfq8AqGV
        r6nT9avga0AwQPxil7lZMJszQJOIzAZucBArhPeqUdrivPc0pmFe0eQ+yQDHKaq6GdHSsD
        bdUlRsm/Q2wXvtsY4kh+vHcgQs6+eHix10tR7tyMdMnGxo9ajDYZcVfHhuLi0qewZo0Fvc
        0LISsiQUMi5djsQevxZ6vnkat9rK/KT0VeCZp9n8QmvidHnerA0x/S5xNvizFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652964259;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aqWjEFrzBI1ff8CxF/pYcxM4zJ9pVrTfH5VIk3UT/14=;
        b=wlQx4YUfFP/XqGM3fvBo/ocVWGdL6aNl/BjP2AMMekB1X812bsHQu4n9MHRIAl3krbhDwL
        AzYgUGx9Zfyp35Aw==
From:   "thermal-bot for Manaf Meethalavalappu Pallikunhi" 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/thermal_of: Add change_mode
 ops support for thermal_of sensor
Cc:     Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <1646767586-31908-1-git-send-email-quic_manafm@quicinc.com>
References: <1646767586-31908-1-git-send-email-quic_manafm@quicinc.com>
MIME-Version: 1.0
Message-ID: <165296425821.4207.14800599124413692032.tip-bot2@tip-bot2>
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

Commit-ID:     bf70c577516b8d9fbe703371aa98bbea13661cec
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//bf70c577516b8d9fbe703371aa98bbea13661cec
Author:        Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
AuthorDate:    Wed, 09 Mar 2022 00:56:26 +05:30
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 19 May 2022 12:11:51 +02:00

thermal/drivers/thermal_of: Add change_mode ops support for thermal_of sensor

The sensor driver which register through thermal_of interface doesn't
have an option to get thermal zone mode change notification from
thermal core.

Add support for change_mode ops in thermal_of interface so that sensor
driver can use this ops for mode change notification.

Signed-off-by: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
Link: https://lore.kernel.org/r/1646767586-31908-1-git-send-email-quic_manafm@quicinc.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_of.c | 12 ++++++++++++
 include/linux/thermal.h      |  3 +++
 2 files changed, 15 insertions(+)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 9233f7e..da48480 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -203,6 +203,14 @@ static int of_thermal_get_trend(struct thermal_zone_device *tz, int trip,
 	return data->ops->get_trend(data->sensor_data, trip, trend);
 }
 
+static int of_thermal_change_mode(struct thermal_zone_device *tz,
+				enum thermal_device_mode mode)
+{
+	struct __thermal_zone *data = tz->devdata;
+
+	return data->ops->change_mode(data->sensor_data, mode);
+}
+
 static int of_thermal_bind(struct thermal_zone_device *thermal,
 			   struct thermal_cooling_device *cdev)
 {
@@ -408,6 +416,9 @@ thermal_zone_of_add_sensor(struct device_node *zone,
 	if (ops->set_emul_temp)
 		tzd->ops->set_emul_temp = of_thermal_set_emul_temp;
 
+	if (ops->change_mode)
+		tzd->ops->change_mode = of_thermal_change_mode;
+
 	mutex_unlock(&tzd->lock);
 
 	return tzd;
@@ -569,6 +580,7 @@ void thermal_zone_of_sensor_unregister(struct device *dev,
 	tzd->ops->get_temp = NULL;
 	tzd->ops->get_trend = NULL;
 	tzd->ops->set_emul_temp = NULL;
+	tzd->ops->change_mode = NULL;
 
 	tz->ops = NULL;
 	tz->sensor_data = NULL;
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index c314893..365733b 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -299,6 +299,8 @@ struct thermal_zone_params {
  *		   temperature.
  * @set_trip_temp: a pointer to a function that sets the trip temperature on
  *		   hardware.
+ * @change_mode: a pointer to a function that notifies the thermal zone
+ *		   mode change.
  */
 struct thermal_zone_of_device_ops {
 	int (*get_temp)(void *, int *);
@@ -306,6 +308,7 @@ struct thermal_zone_of_device_ops {
 	int (*set_trips)(void *, int, int);
 	int (*set_emul_temp)(void *, int);
 	int (*set_trip_temp)(void *, int, int);
+	int (*change_mode) (void *, enum thermal_device_mode);
 };
 
 /* Function declarations */
