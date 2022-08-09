Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE83558E2A1
	for <lists+linux-pm@lfdr.de>; Wed, 10 Aug 2022 00:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbiHIWGJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Aug 2022 18:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiHIWFf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Aug 2022 18:05:35 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2386F12A95
        for <linux-pm@vger.kernel.org>; Tue,  9 Aug 2022 15:05:29 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id p10so15734734wru.8
        for <linux-pm@vger.kernel.org>; Tue, 09 Aug 2022 15:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Bvo7EJO01qiFSqaGbT4JiAGDEh8uk0vvz3ltgjeJ4xY=;
        b=CAWsRL4Ep4kicXkJntoYYRIcd5mxS+P+lyhev3U4OgFFKo31iklfxZ8YBswYrWQo8q
         r/7/d7aaRZyY0QjEAprQWpzmQvCErYj3/ESOm+yenMF1AmwmopLxHHkZ6bhIjLyvUa2E
         mx9Pl7YIEkZFIxkeTLe97cmpc7b3Eox4Qnkg8+wrftdtcWob5llvFamt98DJGvzxclFb
         oz2J0+x/OFDEE+v4CO43Nc2mVzGvqsvpdavHoMM2k8uYEZ93m/gJ6DQRO0FeDcuIhdYf
         YpI23rxd4CsZqAruWv/kqq8A9BcwWvtDasVKL9qB8dB8X1d9wH+QMPugcEbzRWvPo4tf
         a5MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Bvo7EJO01qiFSqaGbT4JiAGDEh8uk0vvz3ltgjeJ4xY=;
        b=0Q3BLwEe7ibNX6Z9crjp4gNPa/cEAT0Z8iM+I00l9eY6NK7Mvwqk6Ba0+cHqQp//qO
         cZSvFnV/0jSBhdb3rehVYczLx0q/7QutbgLLRsieoO49trynpVc552mrMjG7ZisKGGeQ
         qHXmjcr3joCN8QJKawip4g29rAGt7FiWb7712q1z1YPADMO6O5DaIDB+dUQOQ5SWtlW0
         EpxFWUc43GhY2XsxViAmQJpzwz8k/9xz81RyKaZp03H0YJiUMG9KV2mtteM3MylrocUc
         jNzPWXApLEa7f9bpMt5kAcRuMvq2HT7y0XCcp+89EiHtuYpe2LW3tvZGeW+bJAYmrSbu
         AD9A==
X-Gm-Message-State: ACgBeo2CXWdWFQ2tb0JLWipA6xNj2H2xyxxEh1SQgcPhtRs1Sl43ND6s
        5kIQqIdE/lQxrApjkKs7enH7tg==
X-Google-Smtp-Source: AA6agR73C8FYlygjs2eWSiL4P5CCNWIL9h5r5LJCnL/XSF0M8E+RfGw1MC6lcPFkWKuYH6Yi8UW67A==
X-Received: by 2002:adf:f94b:0:b0:21e:46fe:bcdb with SMTP id q11-20020adff94b000000b0021e46febcdbmr14731147wrr.143.1660082727580;
        Tue, 09 Aug 2022 15:05:27 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c3b1500b003a317ee3036sm293583wms.2.2022.08.09.15.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 15:05:27 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Peter=20K=C3=A4stle?= <peter@piie.net>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org (open list:ACER ASPIRE ONE
        TEMPERATURE AND FAN DRIVER)
Subject: [PATCH v2 23/26] thermal/drivers/acerhdf: Use generic thermal_zone_get_trip() function
Date:   Wed, 10 Aug 2022 00:04:33 +0200
Message-Id: <20220809220436.711020-24-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220809220436.711020-1-daniel.lezcano@linaro.org>
References: <20220809220436.711020-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The thermal framework gives the possibility to register the trip
points with the thermal zone. When that is done, no get_trip_* ops are
needed and they can be removed.

Convert ops content logic into generic trip points and register them with the
thermal zone.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Peter Kästle <peter@piie.net>
---
 drivers/platform/x86/acerhdf.c | 73 ++++++++++++----------------------
 1 file changed, 26 insertions(+), 47 deletions(-)

diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
index 3463629f8764..a7407aa032ba 100644
--- a/drivers/platform/x86/acerhdf.c
+++ b/drivers/platform/x86/acerhdf.c
@@ -46,6 +46,8 @@
  * measured by the on-die thermal monitor are within 0 <= Tj <= 90. So,
  * assume 89°C is critical temperature.
  */
+#define ACERHDF_DEFAULT_TEMP_FANON 60000
+#define ACERHDF_DEFAULT_TEMP_FANOFF 53000
 #define ACERHDF_TEMP_CRIT 89000
 #define ACERHDF_FAN_OFF 0
 #define ACERHDF_FAN_AUTO 1
@@ -70,8 +72,8 @@ static int kernelmode;
 #endif
 
 static unsigned int interval = 10;
-static unsigned int fanon = 60000;
-static unsigned int fanoff = 53000;
+static unsigned int fanon = ACERHDF_DEFAULT_TEMP_FANON;
+static unsigned int fanoff = ACERHDF_DEFAULT_TEMP_FANOFF;
 static unsigned int verbose;
 static unsigned int list_supported;
 static unsigned int fanstate = ACERHDF_FAN_AUTO;
@@ -137,6 +139,15 @@ struct ctrl_settings {
 	int mcmd_enable;
 };
 
+static struct thermal_trip trips[] = {
+	[0] = { .temperature = ACERHDF_DEFAULT_TEMP_FANON,
+		.hysteresis = ACERHDF_DEFAULT_TEMP_FANON - ACERHDF_DEFAULT_TEMP_FANOFF,
+		.type = THERMAL_TRIP_ACTIVE },
+
+	[1] = { .temperature = ACERHDF_TEMP_CRIT,
+		.type = THERMAL_TRIP_CRITICAL }
+};
+
 static struct ctrl_settings ctrl_cfg __read_mostly;
 
 /* Register addresses and values for different BIOS versions */
@@ -326,6 +337,15 @@ static void acerhdf_check_param(struct thermal_zone_device *thermal)
 		fanon = ACERHDF_MAX_FANON;
 	}
 
+	if (fanon < fanoff) {
+		pr_err("fanoff temperature (%d) is above fanon temperature (%d), clamping to %d\n",
+		       fanoff, fanon, fanon);
+		fanoff = fanon;
+	};
+
+	trips[0].temperature = fanon;
+	trips[0].hysteresis  = fanon - fanoff;
+
 	if (kernelmode && prev_interval != interval) {
 		if (interval > ACERHDF_MAX_INTERVAL) {
 			pr_err("interval too high, set to %d\n",
@@ -424,43 +444,6 @@ static int acerhdf_change_mode(struct thermal_zone_device *thermal,
 	return 0;
 }
 
-static int acerhdf_get_trip_type(struct thermal_zone_device *thermal, int trip,
-				 enum thermal_trip_type *type)
-{
-	if (trip == 0)
-		*type = THERMAL_TRIP_ACTIVE;
-	else if (trip == 1)
-		*type = THERMAL_TRIP_CRITICAL;
-	else
-		return -EINVAL;
-
-	return 0;
-}
-
-static int acerhdf_get_trip_hyst(struct thermal_zone_device *thermal, int trip,
-				 int *temp)
-{
-	if (trip != 0)
-		return -EINVAL;
-
-	*temp = fanon - fanoff;
-
-	return 0;
-}
-
-static int acerhdf_get_trip_temp(struct thermal_zone_device *thermal, int trip,
-				 int *temp)
-{
-	if (trip == 0)
-		*temp = fanon;
-	else if (trip == 1)
-		*temp = ACERHDF_TEMP_CRIT;
-	else
-		return -EINVAL;
-
-	return 0;
-}
-
 static int acerhdf_get_crit_temp(struct thermal_zone_device *thermal,
 				 int *temperature)
 {
@@ -474,13 +457,9 @@ static struct thermal_zone_device_ops acerhdf_dev_ops = {
 	.unbind = acerhdf_unbind,
 	.get_temp = acerhdf_get_ec_temp,
 	.change_mode = acerhdf_change_mode,
-	.get_trip_type = acerhdf_get_trip_type,
-	.get_trip_hyst = acerhdf_get_trip_hyst,
-	.get_trip_temp = acerhdf_get_trip_temp,
 	.get_crit_temp = acerhdf_get_crit_temp,
 };
 
-
 /*
  * cooling device callback functions
  * get maximal fan cooling state
@@ -710,10 +689,10 @@ static int __init acerhdf_register_thermal(void)
 	if (IS_ERR(cl_dev))
 		return -EINVAL;
 
-	thz_dev = thermal_zone_device_register("acerhdf", 2, 0, NULL,
-					      &acerhdf_dev_ops,
-					      &acerhdf_zone_params, 0,
-					      (kernelmode) ? interval*1000 : 0);
+	thz_dev = thermal_zone_device_register_with_trips("acerhdf", trips, ARRAY_SIZE(trips),
+							  0, NULL, &acerhdf_dev_ops,
+							  &acerhdf_zone_params, 0,
+							  (kernelmode) ? interval*1000 : 0);
 	if (IS_ERR(thz_dev))
 		return -EINVAL;
 
-- 
2.34.1

