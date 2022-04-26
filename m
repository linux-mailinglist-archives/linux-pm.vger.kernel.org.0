Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97FBF510BDA
	for <lists+linux-pm@lfdr.de>; Wed, 27 Apr 2022 00:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355707AbiDZWTl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Apr 2022 18:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355733AbiDZWS4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Apr 2022 18:18:56 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D9D3F321
        for <linux-pm@vger.kernel.org>; Tue, 26 Apr 2022 15:15:47 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id n126-20020a1c2784000000b0038e8af3e788so133016wmn.1
        for <linux-pm@vger.kernel.org>; Tue, 26 Apr 2022 15:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P1RwEk6UMhSV0WlQ0OxuiFr38k8Axw4qKNQEGZIv6iU=;
        b=QKQybkVzURgeI+tMJ8w51LnBMOsyEpcW6GaYr2EWcgioEfA/zFfepWd47I1jyLod97
         IWqQqSRg8mQJeuPG1dlbX96xNfk2QyyXGDeK1bgaOwhXFzjAHQii6b1tv0vRF3ADSPeW
         Iua2IjldIzTPTwBm9EGwt/6fxNGEbJTqmhU0cAzWzUoRh20FBqNhoHsz29o00YpP2HtD
         3ChRcOruxOMapmMdGwdjNtmHcbvJKTGAM6tr+NzvH2uDvhHec3wMwRi1/yqe4EpyVy0f
         zRgnqRSXuY/Ifcm0RGkhGqje87+0MudBdAfOhLVCo5mUWo7kmKnx8jskwcgQqW7n85F3
         Kvqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P1RwEk6UMhSV0WlQ0OxuiFr38k8Axw4qKNQEGZIv6iU=;
        b=e9QJOThLGYX/vX70aVm8SfVYhpnbVZITShunPbNKtNtxfHQckg9WDCBttbzqppR2sQ
         jU+stUzqTm0ix77vfxFECn1bpjbZ4PmSz/iRdagNIB1HbkleQXMUM5z0GUM7p9FVr4xh
         JEbyg/3B35PGSd+IS0rNYX7E1040UTDtvZBLxXAgxusozywpI0XLveEaYQeCDh67Qmbx
         kuEP2oxVnfS2lLC9XKVbDwNqZS3MTZtDefOpjVwZxYV4nY5rv+YM6Y/Xx//IMyxCTbil
         MEU+/Gyoxd9PpX4DKDjhov8KwhNACpyKIIaYO6wiERhEJZf1Um1Cu2V6oOkU4XdxlD5s
         Ua1g==
X-Gm-Message-State: AOAM530DibfjEGjz3EjywcyC6lp0dhKJOephTH02VOYfhiyInPRpooW2
        Wtmdldfh+P/X3SHVJH3eH4CQyQ==
X-Google-Smtp-Source: ABdhPJxcZ4rRyWIm+bCZmxUETGu9bxO2QRKfNWK78Anhv9GWEXiyOvKUHwYfO7F4LI/+1nntyxu55A==
X-Received: by 2002:a05:600c:3509:b0:393:ec9f:e884 with SMTP id h9-20020a05600c350900b00393ec9fe884mr10246330wmq.74.1651011345867;
        Tue, 26 Apr 2022 15:15:45 -0700 (PDT)
Received: from localhost.localdomain (static-176-182-171-101.ncc.abo.bbox.fr. [176.182.171.101])
        by smtp.gmail.com with ESMTPSA id j19-20020adfb313000000b0020aed8ece65sm393314wrd.32.2022.04.26.15.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 15:15:45 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     khilman@baylibre.com, abailon@baylibre.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 14/15] thermal/of: Use thermal trips stored in the thermal zone
Date:   Wed, 27 Apr 2022 00:15:22 +0200
Message-Id: <20220426221523.3056696-15-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426221523.3056696-1-daniel.lezcano@linexp.org>
References: <20220426221523.3056696-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Now that we have the thermal trip stored in the thermal zone in a
generic way, we can rely on them and remove one indirection we found
in the thermal_of code and do one more step forward the removal of the
duplicated structures.

Cc: Alexandre Bailon <abailon@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc; Eduardo Valentin <eduval@amazon.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/thermal_of.c | 53 +++++++++++-------------------------
 1 file changed, 16 insertions(+), 37 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 069b421a54ae..a356a7b2d73d 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -118,12 +118,7 @@ static int of_thermal_set_trips(struct thermal_zone *tz,
  */
 int of_thermal_get_ntrips(struct thermal_zone *tz)
 {
-	struct __thermal_zone *data = tz->devdata;
-
-	if (!data || IS_ERR(data))
-		return -ENODEV;
-
-	return data->ntrips;
+	return tz->ntrips;
 }
 EXPORT_SYMBOL_GPL(of_thermal_get_ntrips);
 
@@ -139,9 +134,7 @@ EXPORT_SYMBOL_GPL(of_thermal_get_ntrips);
  */
 bool of_thermal_is_trip_valid(struct thermal_zone *tz, int trip)
 {
-	struct __thermal_zone *data = tz->devdata;
-
-	if (!data || trip >= data->ntrips || trip < 0)
+	if (trip >= tz->ntrips || trip < 0)
 		return false;
 
 	return true;
@@ -161,12 +154,7 @@ EXPORT_SYMBOL_GPL(of_thermal_is_trip_valid);
 const struct thermal_trip *
 of_thermal_get_trip_points(struct thermal_zone *tz)
 {
-	struct __thermal_zone *data = tz->devdata;
-
-	if (!data)
-		return NULL;
-
-	return data->trips;
+	return tz->trips;
 }
 EXPORT_SYMBOL_GPL(of_thermal_get_trip_points);
 
@@ -273,12 +261,10 @@ static int of_thermal_unbind(struct thermal_zone *thermal,
 static int of_thermal_get_trip_type(struct thermal_zone *tz, int trip,
 				    enum thermal_trip_type *type)
 {
-	struct __thermal_zone *data = tz->devdata;
-
-	if (trip >= data->ntrips || trip < 0)
+	if (trip >= tz->ntrips || trip < 0)
 		return -EDOM;
 
-	*type = data->trips[trip].type;
+	*type = tz->trips[trip].type;
 
 	return 0;
 }
@@ -286,12 +272,10 @@ static int of_thermal_get_trip_type(struct thermal_zone *tz, int trip,
 static int of_thermal_get_trip_temp(struct thermal_zone *tz, int trip,
 				    int *temp)
 {
-	struct __thermal_zone *data = tz->devdata;
-
-	if (trip >= data->ntrips || trip < 0)
+	if (trip >= tz->ntrips || trip < 0)
 		return -EDOM;
 
-	*temp = data->trips[trip].temperature;
+	*temp = tz->trips[trip].temperature;
 
 	return 0;
 }
@@ -301,7 +285,7 @@ static int of_thermal_set_trip_temp(struct thermal_zone *tz, int trip,
 {
 	struct __thermal_zone *data = tz->devdata;
 
-	if (trip >= data->ntrips || trip < 0)
+	if (trip >= tz->ntrips || trip < 0)
 		return -EDOM;
 
 	if (data->ops && data->ops->set_trip_temp) {
@@ -313,7 +297,7 @@ static int of_thermal_set_trip_temp(struct thermal_zone *tz, int trip,
 	}
 
 	/* thermal framework should take care of data->mask & (1 << trip) */
-	data->trips[trip].temperature = temp;
+	tz->trips[trip].temperature = temp;
 
 	return 0;
 }
@@ -321,12 +305,10 @@ static int of_thermal_set_trip_temp(struct thermal_zone *tz, int trip,
 static int of_thermal_get_trip_hyst(struct thermal_zone *tz, int trip,
 				    int *hyst)
 {
-	struct __thermal_zone *data = tz->devdata;
-
-	if (trip >= data->ntrips || trip < 0)
+	if (trip >= tz->ntrips || trip < 0)
 		return -EDOM;
 
-	*hyst = data->trips[trip].hysteresis;
+	*hyst = tz->trips[trip].hysteresis;
 
 	return 0;
 }
@@ -334,13 +316,11 @@ static int of_thermal_get_trip_hyst(struct thermal_zone *tz, int trip,
 static int of_thermal_set_trip_hyst(struct thermal_zone *tz, int trip,
 				    int hyst)
 {
-	struct __thermal_zone *data = tz->devdata;
-
-	if (trip >= data->ntrips || trip < 0)
+	if (trip >= tz->ntrips || trip < 0)
 		return -EDOM;
 
 	/* thermal framework should take care of data->mask & (1 << trip) */
-	data->trips[trip].hysteresis = hyst;
+	tz->trips[trip].hysteresis = hyst;
 
 	return 0;
 }
@@ -348,12 +328,11 @@ static int of_thermal_set_trip_hyst(struct thermal_zone *tz, int trip,
 static int of_thermal_get_crit_temp(struct thermal_zone *tz,
 				    int *temp)
 {
-	struct __thermal_zone *data = tz->devdata;
 	int i;
 
-	for (i = 0; i < data->ntrips; i++)
-		if (data->trips[i].type == THERMAL_TRIP_CRITICAL) {
-			*temp = data->trips[i].temperature;
+	for (i = 0; i < tz->ntrips; i++)
+		if (tz->trips[i].type == THERMAL_TRIP_CRITICAL) {
+			*temp = tz->trips[i].temperature;
 			return 0;
 		}
 
-- 
2.25.1

