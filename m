Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF29672A14
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jan 2023 22:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjARVMn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Jan 2023 16:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjARVMW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Jan 2023 16:12:22 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0B0613C0
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 13:11:37 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id m15so110022wms.4
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 13:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MbZTt1nKV5Kzktb6N/J9c4cwx0dyU8TgWnYTyorPexI=;
        b=XJ8fx8qgbtpA2yj0y7FDGXBOtSmezFrHxGnXGFlbiODLkUf1IVM49rmBXyp0rn47tv
         HBh/kgCib3lMDyYaGvUIyBbK612QqakthrpNqxNgXaF8M1e6rdQt4cTXFpHn+d9ns7GD
         GQjd2CJnXol3dlHTZI1jBhzMbsjA4pYvqya5yxSNTpakqnenN4jbnrA0vwtGtQ9SHe3G
         wJtD7Jto/KRbAfrjcRGSVGwlG7irYUy0hiZmuuYwvIFH7Ih+N/uBA4Q/Z212ZZMD0EUW
         H8aRUWUREmRNjm0KcPY8jFdZ8wA/BeFCNVRZ3AeDYXK5A7HyejQrWrZR1mEFD+UQa8oE
         yHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MbZTt1nKV5Kzktb6N/J9c4cwx0dyU8TgWnYTyorPexI=;
        b=H5qIw9KOGSqI1nm9CrOMCLrSwq/tV7M0wgNcLncVDN4Fnm86ERtOt2w3E0gR42PUdQ
         /FiC0ReYXm/0YjqJCukEg2dBqlTgh9qtiWI+rS1MAq8f6hpynkZ3eDR1jsSYwDHEZcbC
         500hxBP8Cp52nQTLcgOGY8xxbULyp8xHUXm36ohZWt1Rg+MsHUQifUtRBpWZr3uXMBtO
         DxRhUFbOmFrBUroFqRkSm7eK5Wkhf9VBBy917hlf7LpmFEdFBZh8u7E8odxXOaSydkxF
         V6Ny+SsBVuFgL0Id6mALzajl1/JewQgFcMWOCCRrYfo9y+NZkcelKdc5GxRJ++SE+7qO
         64PA==
X-Gm-Message-State: AFqh2kpRWGt/sBxKZsAHfdbkq2vNRs4r3OQRkYwsFfZu2Sw5qw9K3opw
        AH1bybZHdK9/15FiYsn9MkJ+Bg==
X-Google-Smtp-Source: AMrXdXsV8RveJh+m5ZCwXlPjvyBVaicdsqtarl2MxP1HDcUBEHlTg8ChBtkG0ESaSyfE2sAUcZdk5Q==
X-Received: by 2002:a05:600c:6014:b0:3da:2032:6c0f with SMTP id az20-20020a05600c601400b003da20326c0fmr16523812wmb.31.1674076295926;
        Wed, 18 Jan 2023 13:11:35 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id l27-20020a05600c2cdb00b003d99da8d30asm3198835wmc.46.2023.01.18.13.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 13:11:35 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 5/5] thermal/core: Sort the trip points when registering a thermal zone
Date:   Wed, 18 Jan 2023 22:11:23 +0100
Message-Id: <20230118211123.111493-5-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230118211123.111493-1-daniel.lezcano@linaro.org>
References: <20230118211123.111493-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Most of the drivers are converted to use the generic thermal trip
points. They register a thermal zone with an array of trip points.

However, we don't have the guarantee the trip points are ordered. The
main goal of moving to the generic trip points is to provide a common
structure, ordered, so we can fix sanely how the trip points are
crossed. As a reminder, the detection is fuzzy when the trip points
are defined with hysteresis values, we can have duplicated or
inconsistent trip events.

This change sorts the trip points array when it is registered with the
thermal zone. The direction of the ordering is descending because when
we browse the trip points, we want to check the highest trip points
first as they are higher in temperature, thus higher in priority.

A pr_info() trace tells the trip points have been ordered if it
appears they are not sorted initially.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c |  3 +++
 drivers/thermal/thermal_core.h |  1 +
 drivers/thermal/thermal_trip.c | 28 ++++++++++++++++++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index d0577685085a..394770591771 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1255,6 +1255,9 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
 	if (num_trips > 0 && (!ops->get_trip_type || !ops->get_trip_temp) && !trips)
 		return ERR_PTR(-EINVAL);
 
+	if (trips && thermal_trip_sort(trips, num_trips))
+		pr_info("Thermal trips sorted for thermal zone '%s'\n", type);
+	
 	tz = kzalloc(sizeof(*tz), GFP_KERNEL);
 	if (!tz)
 		return ERR_PTR(-ENOMEM);
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 26350206a98d..4688107fda1d 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -117,6 +117,7 @@ void __thermal_zone_set_trips(struct thermal_zone_device *tz);
 int __thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
 			    struct thermal_trip *trip);
 int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
+int thermal_trip_sort(struct thermal_trip *trips, int num_trips);
 
 /* sysfs I/F */
 int thermal_zone_create_device_groups(struct thermal_zone_device *, int);
diff --git a/drivers/thermal/thermal_trip.c b/drivers/thermal/thermal_trip.c
index 2ef61ff7ffc3..924998f09a5a 100644
--- a/drivers/thermal/thermal_trip.c
+++ b/drivers/thermal/thermal_trip.c
@@ -9,6 +9,34 @@
  */
 #include "thermal_core.h"
 
+/*
+ * The trip points must be ordered in the descending order so when we
+ * browse the trip points we will hit the critical, hot and then the
+ * passive/active trip points. The critical trip point being the first
+ * one to be handled.
+ */
+int thermal_trip_sort(struct thermal_trip *trips, int num_trips)
+{
+	struct thermal_trip tt;
+	int sorted = 0;
+	int i, j;
+
+	for (i = 0; i < num_trips; i++) {
+
+		for (j = i + 1; j < num_trips; j++) {
+
+			if (trips[i].temperature < trips[j].temperature) {
+				tt = trips[i];
+				trips[i] = trips[j];
+				trips[j] = tt;
+				sorted++;
+			}
+		}
+ 	}
+
+	return sorted;
+}
+
 int __for_each_thermal_trip(struct thermal_zone_device *tz,
 			    int (*cb)(struct thermal_trip *,
 				      int trip_id, void *),
-- 
2.34.1

