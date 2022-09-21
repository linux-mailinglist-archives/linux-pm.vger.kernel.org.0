Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771055BFB57
	for <lists+linux-pm@lfdr.de>; Wed, 21 Sep 2022 11:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbiIUJoB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Sep 2022 05:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbiIUJnm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Sep 2022 05:43:42 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E0E92F54
        for <linux-pm@vger.kernel.org>; Wed, 21 Sep 2022 02:43:30 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id n12so8874038wrx.9
        for <linux-pm@vger.kernel.org>; Wed, 21 Sep 2022 02:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Brk79K68Pth5JpZf/n4X97+hyNwde3ZvZaEoGdSbClA=;
        b=dmnUeKZ9VmxqZ4xOtAH5mntnS4VbRL2DzZYxE5575fTKF6+nYj2L7QRBc1ftzZgdC0
         m3FMZ+nUww3dJIRmpri2+CGbUSCDjp0bYvR+isl+Z0/87QTRbJFjkWmBKWoEA1AU0bcc
         8zqVahCPpTuOr31/OFo6+9xfmMb15G59QTPBY3LUpLvGStcZSWqGNv0MvjZT1Q01FDGd
         GRqRfOafPKf+7mCJklkGLoOXC7H3GCARMML+qyJiFwBoKnmKw06ldCN4rYshPY8YoSzu
         NeDlLn5ykBAOd9AdqMvs+uCqPztsmxrJpqFCewUDmPyJ5VoFCDEdOJwyoGAwlF+8IxAy
         iXlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Brk79K68Pth5JpZf/n4X97+hyNwde3ZvZaEoGdSbClA=;
        b=Cl0Zdbkbtf3JoZXUZ0QPrxEVtdGWRAWMxSweR2Q6zpoe0CGJI9L8byj7Xn94WWzJIp
         p1knttoWG/9tTCLGgwB34NY0lAUQu3HnzYP8vs1RvGxT31J1LO99AmRxq4CpaqlMCQNc
         q8g8aW8Nsd4M88JyfMheRsXPDhr7nYZh0f52Jwbl6vk1SsBXD9udMTYaX8VKeE4tkuqg
         20IQQEIGkApPIzZ5AoDbvzUfHeDUiD3tp/ewr2JJXr0D9j6HVBov7kOiNXjkhvhXmIdy
         ekllN66aayjGmPFGcd+NoUWUqVjUXM82XlUq8BuY0FltqzyIDN7dt3UvUelK7yZGtaK0
         sRog==
X-Gm-Message-State: ACrzQf2H2/U+1E8V0Y0ONXlZVnycY4olcoQO88xHuOsJP8LmeyvuGek0
        23tcWXik0m4FXT7iZlRT1PJ25g==
X-Google-Smtp-Source: AMsMyM6tASOb4dFSvzUlr8tlPtjXpzMLi9X4S6s5u6l08yr+UBi33sCrMuAVFW5fHLVRMmYgSnpYug==
X-Received: by 2002:adf:ed81:0:b0:226:a509:14b6 with SMTP id c1-20020adfed81000000b00226a50914b6mr16511433wro.150.1663753409132;
        Wed, 21 Sep 2022 02:43:29 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id r123-20020a1c2b81000000b003a62052053csm2763917wmr.18.2022.09.21.02.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 02:43:28 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v4 07/30] thermal/of: Remove unused functions
Date:   Wed, 21 Sep 2022 11:42:20 +0200
Message-Id: <20220921094244.606948-8-daniel.lezcano@linaro.org>
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

Remove the dead code: of_thermal_get_trip_points()

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.h |  7 -------
 drivers/thermal/thermal_of.c   | 17 -----------------
 2 files changed, 24 deletions(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 1571917bd3c8..99a5d5281037 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -139,8 +139,6 @@ thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
 #ifdef CONFIG_THERMAL_OF
 int of_thermal_get_ntrips(struct thermal_zone_device *);
 bool of_thermal_is_trip_valid(struct thermal_zone_device *, int);
-const struct thermal_trip *
-of_thermal_get_trip_points(struct thermal_zone_device *);
 #else
 static inline int of_thermal_get_ntrips(struct thermal_zone_device *tz)
 {
@@ -151,11 +149,6 @@ static inline bool of_thermal_is_trip_valid(struct thermal_zone_device *tz,
 {
 	return false;
 }
-static inline const struct thermal_trip *
-of_thermal_get_trip_points(struct thermal_zone_device *tz)
-{
-	return NULL;
-}
 #endif
 
 int thermal_zone_device_is_enabled(struct thermal_zone_device *tz);
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 5cce83639085..2f533fc94917 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -54,23 +54,6 @@ bool of_thermal_is_trip_valid(struct thermal_zone_device *tz, int trip)
 }
 EXPORT_SYMBOL_GPL(of_thermal_is_trip_valid);
 
-/**
- * of_thermal_get_trip_points - function to get access to a globally exported
- *				trip points
- *
- * @tz:	pointer to a thermal zone
- *
- * This function provides a pointer to trip points table
- *
- * Return: pointer to trip points table, NULL otherwise
- */
-const struct thermal_trip *
-of_thermal_get_trip_points(struct thermal_zone_device *tz)
-{
-	return tz->trips;
-}
-EXPORT_SYMBOL_GPL(of_thermal_get_trip_points);
-
 static int of_thermal_set_trip_hyst(struct thermal_zone_device *tz, int trip,
 				    int hyst)
 {
-- 
2.34.1

