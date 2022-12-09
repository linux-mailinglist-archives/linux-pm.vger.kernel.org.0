Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1186064852E
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbiLIP0z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:26:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiLIP0i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BEB8F724
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:33 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599590;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rcH1ArQukMJSBQ0q5k8fptDCw/hjq3H0Q43y2X+0v1w=;
        b=NDMPw25PLn6Y9VuXhQzYhGj4hux0R/fKWvd9j/RTbwV8x3PyUTy2+r0Fl9SG0GgI1AqY9W
        YjTN8dLKCQDhIod5bsFSUhIBYj6pDA2H8pUYJTGE5+Djv2oflHtKQKgF54QChShhBv+pjN
        LgYyLnwz10pcQ9OUYQNpBWt/jO1H9s+gU0BbpLB4E4eVfSQjyxi9ns7EThhkZcbHwdAu/8
        iy/trq47QZXBeVDOiRYaSTMYFEibOlVHuB52fN8v0wDdSgSFl9IFL28pVz+7kgjqVNOUFb
        IInZuKMddV9mV89fOFl6S+9ss3p7By+FKn0XOcLPqDTm2+Q5qQDaRV46UQOBEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599590;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rcH1ArQukMJSBQ0q5k8fptDCw/hjq3H0Q43y2X+0v1w=;
        b=2pQtmJ0YNKdvgS1WsVvSOrMvaJGJcH/EEWJAqamMiS8MS+fQAt3EZn5vYA3tGbWTn8Adp2
        FuE50i3dYTTr08CA==
From:   "thermal-bot for Robert Marko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/tsens: Allow configuring min
 and max trips
Cc:     Robert Marko <robimarko@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220818220245.338396-3-robimarko@gmail.com>
References: <20220818220245.338396-3-robimarko@gmail.com>
MIME-Version: 1.0
Message-ID: <167059958975.4906.13841733269139866172.tip-bot2@tip-bot2>
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

Commit-ID:     0a48def2a10475afb115693fa5a75334cba0ced5
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//0a48def2a10475afb115693fa5a75334cba0ced5
Author:        Robert Marko <robimarko@gmail.com>
AuthorDate:    Fri, 19 Aug 2022 00:02:43 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Thu, 08 Dec 2022 14:30:44 +01:00

thermal/drivers/tsens: Allow configuring min and max trips

IPQ8074 and IPQ6018 dont support negative trip temperatures and support
up to 204 degrees C as the max trip temperature.

So, instead of always setting the -40 as min and 120 degrees C as max
allow it to be configured as part of the features.

Signed-off-by: Robert Marko <robimarko@gmail.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Link: https://lore.kernel.org/r/20220818220245.338396-3-robimarko@gmail.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/qcom/tsens-8960.c | 2 ++
 drivers/thermal/qcom/tsens-v0_1.c | 2 ++
 drivers/thermal/qcom/tsens-v1.c   | 2 ++
 drivers/thermal/qcom/tsens-v2.c   | 2 ++
 drivers/thermal/qcom/tsens.c      | 4 ++--
 drivers/thermal/qcom/tsens.h      | 4 ++++
 6 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
index ee584e5..4585904 100644
--- a/drivers/thermal/qcom/tsens-8960.c
+++ b/drivers/thermal/qcom/tsens-8960.c
@@ -273,6 +273,8 @@ static struct tsens_features tsens_8960_feat = {
 	.adc		= 1,
 	.srot_split	= 0,
 	.max_sensors	= 11,
+	.trip_min_temp	= -40000,
+	.trip_max_temp	= 120000,
 };
 
 struct tsens_plat_data data_8960 = {
diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index 8cdc3d1..04d012e 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -543,6 +543,8 @@ static struct tsens_features tsens_v0_1_feat = {
 	.adc		= 1,
 	.srot_split	= 1,
 	.max_sensors	= 11,
+	.trip_min_temp	= -40000,
+	.trip_max_temp	= 120000,
 };
 
 static const struct reg_field tsens_v0_1_regfields[MAX_REGFIELDS] = {
diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
index a4f561a..1d7f8a8 100644
--- a/drivers/thermal/qcom/tsens-v1.c
+++ b/drivers/thermal/qcom/tsens-v1.c
@@ -306,6 +306,8 @@ static struct tsens_features tsens_v1_feat = {
 	.adc		= 1,
 	.srot_split	= 1,
 	.max_sensors	= 11,
+	.trip_min_temp	= -40000,
+	.trip_max_temp	= 120000,
 };
 
 static const struct reg_field tsens_v1_regfields[MAX_REGFIELDS] = {
diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index 129cdb2..9babc69 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -35,6 +35,8 @@ static struct tsens_features tsens_v2_feat = {
 	.adc		= 0,
 	.srot_split	= 1,
 	.max_sensors	= 16,
+	.trip_min_temp	= -40000,
+	.trip_max_temp	= 120000,
 };
 
 static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index e2511e7..f315104 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -573,8 +573,8 @@ static int tsens_set_trips(struct thermal_zone_device *tz, int low, int high)
 	dev_dbg(dev, "[%u] %s: proposed thresholds: (%d:%d)\n",
 		hw_id, __func__, low, high);
 
-	cl_high = clamp_val(high, -40000, 120000);
-	cl_low  = clamp_val(low, -40000, 120000);
+	cl_high = clamp_val(high, priv->feat->trip_min_temp, priv->feat->trip_max_temp);
+	cl_low  = clamp_val(low, priv->feat->trip_min_temp, priv->feat->trip_max_temp);
 
 	high_val = tsens_mC_to_hw(s, cl_high);
 	low_val  = tsens_mC_to_hw(s, cl_low);
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 1678c5e..8dc21ca 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -499,6 +499,8 @@ enum regfield_ids {
  *              with SROT only being available to secure boot firmware?
  * @has_watchdog: does this IP support watchdog functionality?
  * @max_sensors: maximum sensors supported by this version of the IP
+ * @trip_min_temp: minimum trip temperature supported by this version of the IP
+ * @trip_max_temp: maximum trip temperature supported by this version of the IP
  */
 struct tsens_features {
 	unsigned int ver_major;
@@ -508,6 +510,8 @@ struct tsens_features {
 	unsigned int srot_split:1;
 	unsigned int has_watchdog:1;
 	unsigned int max_sensors;
+	int trip_min_temp;
+	int trip_max_temp;
 };
 
 /**
