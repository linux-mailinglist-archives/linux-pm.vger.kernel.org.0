Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851105BFB62
	for <lists+linux-pm@lfdr.de>; Wed, 21 Sep 2022 11:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbiIUJnx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Sep 2022 05:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbiIUJng (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Sep 2022 05:43:36 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5953892F4F
        for <linux-pm@vger.kernel.org>; Wed, 21 Sep 2022 02:43:24 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id r133-20020a1c448b000000b003b494ffc00bso8140225wma.0
        for <linux-pm@vger.kernel.org>; Wed, 21 Sep 2022 02:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=re6cY3b7LhtgjVns3TGnT3S1+gVlK6XqwvcFa/mv1ME=;
        b=if94fkKyVeDmS4rsrjEKY0jLhqt8RAB7MHcZOSlPXfssiLW4b5XZrr9HRLjGDDWD45
         BMWFLw896t3N1Oh3z8DCSSB4v0d5la8UBsobrHmrYRe4cu42eRZ4u1dCBGsIgEcPnmsZ
         FAPIOL6ouVt/eM5fh8XrH549WCt0NZy12+5EuvrlSEUq6qc7oVxZ8iEjNjgDL3CszSxr
         LH8AGT06vUxrI8XKP8+wCKYYCgqhr3KbEWd/8Y0cR/ee7ZuSq1oZdLMmWvJ2xrfnCpQC
         Tf0ROVrGxMsXfIShi6TXTcVahIY12JKP0rTDiSLvfCmaRCw0OTHTPuTL0zlBCLzRGWKt
         12VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=re6cY3b7LhtgjVns3TGnT3S1+gVlK6XqwvcFa/mv1ME=;
        b=qcilhRhlkBOp79uOcPLpQvjW+pBixTsHlzqj1/r2LnNTn6Sasdx+vIdEwPpchrMJu/
         tXg8je0KcBWWRv6tTDxhffJcQe844zUzJvmZp2iE0J2dIN3/94vvVlO9VvwxLOlvAkNe
         pPQ+mKkgq9I9MncKaXtZOMn/4vSZOf+7XLx94qd02U0Q6YAdaiqj/iVA2e1MZXhnseqO
         gI+H0Sle8JxJhJINtebZdwP2GJhscJdbfeAu0HByqJpukuK02dLJxt9suAcWle5QVhWD
         gP6udoOu+B4gYg8YhAD911Y8N7akryOiCQSGgwjW6wykBzTwcRu+gO9/xUNMOgd+f6Q8
         q/2Q==
X-Gm-Message-State: ACrzQf3P7pCLvx2Cduqs9ZyA9pUsMzgvQDNEjm3ypOPBaoig6iJKuDd0
        BYkzWQTQhVUKh94oyWnGxNk2UA==
X-Google-Smtp-Source: AMsMyM6GcTTKoFbTWYmunOFf6EX3vj9zN0d69lNq97Xxg6r6qieqUYC8uSJFrhiMWk7bvhoaTbN18w==
X-Received: by 2002:a05:600c:3843:b0:3b4:f86b:e0a4 with SMTP id s3-20020a05600c384300b003b4f86be0a4mr1778407wmr.195.1663753402476;
        Wed, 21 Sep 2022 02:43:22 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id r123-20020a1c2b81000000b003a62052053csm2763917wmr.18.2022.09.21.02.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 02:43:22 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v4 02/30] thermal/sysfs: Do not make get_trip_hyst optional
Date:   Wed, 21 Sep 2022 11:42:15 +0200
Message-Id: <20220921094244.606948-3-daniel.lezcano@linaro.org>
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

The get_trip_hyst() ops is optional. It results all around the thermal
framework code a check against the ops pointer and different action
adding more complexity and making the code less readable and
understandable.

A zero hysteresis value is perfectly valid, so instead of adding more
circumvolutions in the code, create unconditionnaly the hysteresis and
use the thermal_zone_get_trip() function which returns a zero
hysteresis if the get_trip_hyst() is not defined.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_sysfs.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 75f6b151a58b..18cdd7cd0008 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -424,23 +424,20 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
 		return -ENOMEM;
 	}
 
-	if (tz->ops->get_trip_hyst) {
-		tz->trip_hyst_attrs = kcalloc(tz->num_trips,
-					      sizeof(*tz->trip_hyst_attrs),
-					      GFP_KERNEL);
-		if (!tz->trip_hyst_attrs) {
-			kfree(tz->trip_type_attrs);
-			kfree(tz->trip_temp_attrs);
-			return -ENOMEM;
-		}
+	tz->trip_hyst_attrs = kcalloc(tz->num_trips,
+				      sizeof(*tz->trip_hyst_attrs),
+				      GFP_KERNEL);
+	if (!tz->trip_hyst_attrs) {
+		kfree(tz->trip_type_attrs);
+		kfree(tz->trip_temp_attrs);
+		return -ENOMEM;
 	}
 
 	attrs = kcalloc(tz->num_trips * 3 + 1, sizeof(*attrs), GFP_KERNEL);
 	if (!attrs) {
 		kfree(tz->trip_type_attrs);
 		kfree(tz->trip_temp_attrs);
-		if (tz->ops->get_trip_hyst)
-			kfree(tz->trip_hyst_attrs);
+		kfree(tz->trip_hyst_attrs);
 		return -ENOMEM;
 	}
 
@@ -473,9 +470,6 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
 		}
 		attrs[indx + tz->num_trips] = &tz->trip_temp_attrs[indx].attr.attr;
 
-		/* create Optional trip hyst attribute */
-		if (!tz->ops->get_trip_hyst)
-			continue;
 		snprintf(tz->trip_hyst_attrs[indx].name, THERMAL_NAME_LENGTH,
 			 "trip_point_%d_hyst", indx);
 
@@ -512,8 +506,7 @@ static void destroy_trip_attrs(struct thermal_zone_device *tz)
 
 	kfree(tz->trip_type_attrs);
 	kfree(tz->trip_temp_attrs);
-	if (tz->ops->get_trip_hyst)
-		kfree(tz->trip_hyst_attrs);
+	kfree(tz->trip_hyst_attrs);
 	kfree(tz->trips_attribute_group.attrs);
 }
 
-- 
2.34.1

