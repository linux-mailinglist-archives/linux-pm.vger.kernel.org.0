Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4CC5BFB75
	for <lists+linux-pm@lfdr.de>; Wed, 21 Sep 2022 11:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbiIUJod (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Sep 2022 05:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiIUJnv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Sep 2022 05:43:51 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67B192F53
        for <linux-pm@vger.kernel.org>; Wed, 21 Sep 2022 02:43:48 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id n35-20020a05600c502300b003b4924c6868so2040532wmr.1
        for <linux-pm@vger.kernel.org>; Wed, 21 Sep 2022 02:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=wKElCC452+uQH9oPG73me3V/zKr0MM7IvUS5jZU3ITo=;
        b=AWx3Cda2QSlM0q9A/EXQu8wsdHcl7/UyCHLIFjGeOM2Ru7n9tgfREM9M3cUTr4izEZ
         U5Wj/01p9Ry48o2n1LM3G0UV/qsHhmB9cw7XxthYQN0L+LyvC9fYhMGus7OLLBaXXKSC
         Wm5YsSxH+R3kn8CqIGMIYrr7oJkoGJbrztVa/Po09BRc8waW1fARXC3LMrgepUAiqmXP
         O33TSa2wisGKRwIXcv023IBu54N35bqfU7uRIepwwJyYuVN/TstdKsIyjuJJaoVI1YLy
         47xULmi5Xn5oJYnX59MjAiU7+Jf5q506tVogT5OHPgGRV0nus3nhFu98YFg4PDWMmFSp
         VfAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=wKElCC452+uQH9oPG73me3V/zKr0MM7IvUS5jZU3ITo=;
        b=pVqJenpGl+S6I4e0QjwCaEHwX1XZgX/ZQKGXsiqpHBbst0HEh5aPEJ/dKTrxOaQiU3
         H5jGO18THOuaJmhSmQtYGGplpKIuIo0/nHCNusm4snFHGqzI631sYfoLB1xZQKKJ82hD
         22IZjUoGXQ9yO5QwDFjOasSss3/i2wfm8HgKm/O1UODxoctxv6fcc0BmxUmXxGHWcos+
         yCmfhIiMnAMSseA7dQ70QokVPdhxuiHRPojHqiRf7gfxS7JJB+2UshL0nbHrKF1zAVCk
         xf5axpyIVfOQPjZ+Ezk93Cm+byOhgWfKvpYgXIxVhPfAn9/rVdYBLm+0VNIbiwnpBQey
         WWig==
X-Gm-Message-State: ACrzQf29djdBvR8X/ZMUKIN53y4Fyy9t0QeUQVmA8RPFZAKgyH0M/ubJ
        kBS27iWU6XNgKvn01ospNkTjxw==
X-Google-Smtp-Source: AMsMyM4RwSXbgtxEvyH6G4shUG1Vs7m0/Uzr5JBgqREIMQIEpqEj536yH5hZQQpdJOzYcEABiaEW8Q==
X-Received: by 2002:a05:600c:3506:b0:3b4:c086:fa37 with SMTP id h6-20020a05600c350600b003b4c086fa37mr5493360wmq.165.1663753427034;
        Wed, 21 Sep 2022 02:43:47 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id r123-20020a1c2b81000000b003a62052053csm2763917wmr.18.2022.09.21.02.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 02:43:46 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v4 17/30] thermal/of: Remove of_thermal_get_ntrips()
Date:   Wed, 21 Sep 2022 11:42:30 +0200
Message-Id: <20220921094244.606948-18-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220921094244.606948-1-daniel.lezcano@linaro.org>
References: <20220921094244.606948-1-daniel.lezcano@linaro.org>
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

The thermal OF code uses the generic trip points to initialize the
thermal zone. Consequently thermal_zone_get_num_trips() can be used
and the of_thermal_get_ntrips() is no longer needed. Remove it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.h |  5 -----
 drivers/thermal/thermal_of.c   | 16 ----------------
 2 files changed, 21 deletions(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 99a5d5281037..0139bc1e4f87 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -137,13 +137,8 @@ thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
 
 /* device tree support */
 #ifdef CONFIG_THERMAL_OF
-int of_thermal_get_ntrips(struct thermal_zone_device *);
 bool of_thermal_is_trip_valid(struct thermal_zone_device *, int);
 #else
-static inline int of_thermal_get_ntrips(struct thermal_zone_device *tz)
-{
-	return 0;
-}
 static inline bool of_thermal_is_trip_valid(struct thermal_zone_device *tz,
 					    int trip)
 {
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 2f533fc94917..89afa59c4915 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -19,22 +19,6 @@
 
 #include "thermal_core.h"
 
-/**
- * of_thermal_get_ntrips - function to export number of available trip
- *			   points.
- * @tz: pointer to a thermal zone
- *
- * This function is a globally visible wrapper to get number of trip points
- * stored in the local struct __thermal_zone
- *
- * Return: number of available trip points, -ENODEV when data not available
- */
-int of_thermal_get_ntrips(struct thermal_zone_device *tz)
-{
-	return tz->num_trips;
-}
-EXPORT_SYMBOL_GPL(of_thermal_get_ntrips);
-
 /**
  * of_thermal_is_trip_valid - function to check if trip point is valid
  *
-- 
2.34.1

