Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3AA5EC63A
	for <lists+linux-pm@lfdr.de>; Tue, 27 Sep 2022 16:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbiI0Od2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Sep 2022 10:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbiI0Oc5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Sep 2022 10:32:57 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C53461708
        for <linux-pm@vger.kernel.org>; Tue, 27 Sep 2022 07:32:54 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id x18so15299337wrm.7
        for <linux-pm@vger.kernel.org>; Tue, 27 Sep 2022 07:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=abNjzxC9KSYgYlQOmWQSgo4rKZqyrGSmTM4tjbmhmc8=;
        b=U+ZrO9KZo3xLCm9VIgoTP3fzFdLMtLOxiQtgDcjlXydUKmiaE+/HrLj4MyGLILEyBy
         twHM1ShBtYRiaZC1F3d1964QMf4mPnNWmkYZG7quA71J7X+HXYsbdW1lEja6HLAI/08b
         AF2OEyVc5pEiCZLa1TYyakN36VR/jpWgvZsBjEwafQAOn3z0Cfh1ZmOP8BUVbydfGZm5
         K0XuqXxNsuMgjbgpu7h7X0lcwXewbPyGQY0SLYd9XN9QIlUoluE1CdYm4dUJuRwXyhT+
         QzPnbo5E82p8VQKae844BsUsRA/xvwx+apjzu15HK0VZ7WGF0HNp8dQUsw6Rv5Qe0gSz
         UAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=abNjzxC9KSYgYlQOmWQSgo4rKZqyrGSmTM4tjbmhmc8=;
        b=yWUr33Z4G927ZkMBGzufpmqIjQHGaIrvgHLpsnwB0gQ4O2K7v4LPWg/3Z68s8z9Qb1
         LxbzvnpFrgzrxctkDhl8/BaDI36CmqlWidoh9McWZxW77hDyb9bIHwcEGAsCGk3b8BlQ
         aGDqbS32/zjJKtNLFWCy0ZMXN90CCjY+ivy4uEQRMWe3OUkBZnoDm5+RWQb3+QDqFgAJ
         5k+QhEoUNC3xALn5cG13u84C2Htr2D4E5kLx2RXzFPH5IUWHbky2hN6TiDyWM+eiRCX4
         0Qj5/WIzbHj7vODKsYxqiilJzoxad7K19t0d2chOx4a9NsqC87LP/6WFOy1hSnqL0Fw0
         AVEg==
X-Gm-Message-State: ACrzQf3jJMP5ovNlUttsNKSnXHzE2sbK5lHjc9Zutm5pAcWOrk29TMIl
        gkdfC4ZAtkPkj7uJgMfITzbQ/A==
X-Google-Smtp-Source: AMsMyM5wlwaOn5uLKobrsBqFeh2lHsp+tg7pTO6yx+okWwuyTjRDRLhXfGuN0g2BIT6sKeQoEzn+pA==
X-Received: by 2002:adf:fb50:0:b0:22a:e4e9:a6b3 with SMTP id c16-20020adffb50000000b0022ae4e9a6b3mr16867664wrs.467.1664289173388;
        Tue, 27 Sep 2022 07:32:53 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b003b4924493bfsm17518371wmq.9.2022.09.27.07.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 07:32:52 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v6 02/29] thermal/sysfs: Always expose hysteresis attributes
Date:   Tue, 27 Sep 2022 16:32:12 +0200
Message-Id: <20220927143239.376737-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220927143239.376737-1-daniel.lezcano@linaro.org>
References: <20220927143239.376737-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Instead of avoiding to expose the hysteresis attributes of a thermal
zone when its get_trip_hyst() operation is not defined, which is
confusing, expose them always and use the default
thermal_zone_get_trip() function returning 0 hysteresis when that
operation is not present.

The hysteresis of 0 is perfectly valid, so this change should not
introduce any backwards compatibility issues.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_sysfs.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index d093d7aa64c6..6c45194aaabb 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -426,23 +426,20 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
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
 
@@ -475,9 +472,6 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
 		}
 		attrs[indx + tz->num_trips] = &tz->trip_temp_attrs[indx].attr.attr;
 
-		/* create Optional trip hyst attribute */
-		if (!tz->ops->get_trip_hyst)
-			continue;
 		snprintf(tz->trip_hyst_attrs[indx].name, THERMAL_NAME_LENGTH,
 			 "trip_point_%d_hyst", indx);
 
@@ -514,8 +508,7 @@ static void destroy_trip_attrs(struct thermal_zone_device *tz)
 
 	kfree(tz->trip_type_attrs);
 	kfree(tz->trip_temp_attrs);
-	if (tz->ops->get_trip_hyst)
-		kfree(tz->trip_hyst_attrs);
+	kfree(tz->trip_hyst_attrs);
 	kfree(tz->trips_attribute_group.attrs);
 }
 
-- 
2.34.1

