Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFB55BFB53
	for <lists+linux-pm@lfdr.de>; Wed, 21 Sep 2022 11:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbiIUJn6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Sep 2022 05:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbiIUJnj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Sep 2022 05:43:39 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C08792F4A
        for <linux-pm@vger.kernel.org>; Wed, 21 Sep 2022 02:43:29 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id y5so8949449wrh.3
        for <linux-pm@vger.kernel.org>; Wed, 21 Sep 2022 02:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=NVPF6vnmjrMx5FQU0j+pKHlND8VmvL5OT3fQ9b1KMis=;
        b=Zsrvb3mh+DU+uq04wshQdZ/fl6vUAZ6Rn+tYDUa9JYYGCFrCHQ94KJXrfUMzknkMoo
         1smMNmbkcAm3Ynlzpj6C7E2InZ749X67xqnIMG66QCrPVgEKUGPWyN2koqGQkSM/nHVz
         /g5BsZdUV6yl9tQfoKTDpLMeTtkS+uoDJBVOK/c0285ZckytjP3ytTHrg+YzqA4tfQuB
         LaGjRGHS+/tBB+rIybB8J1kt4+ru3Z4f/cSAeAa3SpKLInIiW5JEMscKVKA+WLBk5uMO
         sR9oPOevvrF6E5dhJYkO+u0L30vYSPv7qkjcW6DGo/FQpeTk2xSvEknXD8qfv2PIl12j
         Xfww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=NVPF6vnmjrMx5FQU0j+pKHlND8VmvL5OT3fQ9b1KMis=;
        b=gdPmeuJ0VZUctoav/wLJ/VUwYPfv7IIBTNRbEL2v2fhjDdcspDaNdONpbyqDG8QbYT
         9vEF6NYE1dIWuqujGsljnZlLvXV9XlD2PzKFAwYbW77GKsroBKqmtp6f714nHz92AD8l
         JqWQYmFh/gXWLu1vDVR7I/2GesC8qCFUnkyXyswOfyrg8HP9NLVt/X141vavhbnNEEOB
         GUZEcW7OwfjFg9HeT1vPbEzIZjSMNK5/POJda3eGpM65fRmM6tpNKXceVXfk/lvwMnYl
         n3qbPa2RJ5Z40AoYGDc9mGCjq/mlXhZwpDDD7ZxTEj0UwYDJ5MOEfpF6VMiBjhiT/YHf
         QsVw==
X-Gm-Message-State: ACrzQf3+XiDrcoxJLciJfpVQEp/L6Gt8dWhEx4XSsLaL9LlvboiD7ohc
        iKi5uYepUsiYc3213e6P/BXllQ==
X-Google-Smtp-Source: AMsMyM7oleeE3uJP8SvXFvgO75gAdkEdMSFbe03N6TMcjxB2OAojRmiDVm7qragD1ndSLXM67oreug==
X-Received: by 2002:a05:6000:38e:b0:22a:e302:28e6 with SMTP id u14-20020a056000038e00b0022ae30228e6mr15168907wrf.595.1663753407844;
        Wed, 21 Sep 2022 02:43:27 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id r123-20020a1c2b81000000b003a62052053csm2763917wmr.18.2022.09.21.02.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 02:43:27 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v4 06/30] thermal/of: Use generic thermal_zone_get_trip() function
Date:   Wed, 21 Sep 2022 11:42:19 +0200
Message-Id: <20220921094244.606948-7-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220921094244.606948-1-daniel.lezcano@linaro.org>
References: <20220921094244.606948-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The thermal framework gives the possibility to register the trip
points with the thermal zone. When that is done, no get_trip_* ops are
needed and they can be removed.

The thermal OF code uses the thermal_zone_device_register_with_trips()
function. It builds the trips array and pass it to the register
function. That means the get_trip_* ops are duplicated with what does
already the core code.

Remove them.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_of.c | 36 ------------------------------------
 1 file changed, 36 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index d4b6335ace15..5cce83639085 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -71,39 +71,6 @@ of_thermal_get_trip_points(struct thermal_zone_device *tz)
 }
 EXPORT_SYMBOL_GPL(of_thermal_get_trip_points);
 
-static int of_thermal_get_trip_type(struct thermal_zone_device *tz, int trip,
-				    enum thermal_trip_type *type)
-{
-	if (trip >= tz->num_trips || trip < 0)
-		return -EDOM;
-
-	*type = tz->trips[trip].type;
-
-	return 0;
-}
-
-static int of_thermal_get_trip_temp(struct thermal_zone_device *tz, int trip,
-				    int *temp)
-{
-	if (trip >= tz->num_trips || trip < 0)
-		return -EDOM;
-
-	*temp = tz->trips[trip].temperature;
-
-	return 0;
-}
-
-static int of_thermal_get_trip_hyst(struct thermal_zone_device *tz, int trip,
-				    int *hyst)
-{
-	if (trip >= tz->num_trips || trip < 0)
-		return -EDOM;
-
-	*hyst = tz->trips[trip].hysteresis;
-
-	return 0;
-}
-
 static int of_thermal_set_trip_hyst(struct thermal_zone_device *tz, int trip,
 				    int hyst)
 {
@@ -626,9 +593,6 @@ struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor,
 		goto out_kfree_trips;
 	}
 
-	of_ops->get_trip_type = of_ops->get_trip_type ? : of_thermal_get_trip_type;
-	of_ops->get_trip_temp = of_ops->get_trip_temp ? : of_thermal_get_trip_temp;
-	of_ops->get_trip_hyst = of_ops->get_trip_hyst ? : of_thermal_get_trip_hyst;
 	of_ops->set_trip_hyst = of_ops->set_trip_hyst ? : of_thermal_set_trip_hyst;
 	of_ops->get_crit_temp = of_ops->get_crit_temp ? : of_thermal_get_crit_temp;
 	of_ops->bind = thermal_of_bind;
-- 
2.34.1

