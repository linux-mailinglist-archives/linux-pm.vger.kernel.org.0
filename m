Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E2358E267
	for <lists+linux-pm@lfdr.de>; Wed, 10 Aug 2022 00:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiHIWGB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Aug 2022 18:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiHIWFV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Aug 2022 18:05:21 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B6FF5A7
        for <linux-pm@vger.kernel.org>; Tue,  9 Aug 2022 15:05:19 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n185so6924314wmn.4
        for <linux-pm@vger.kernel.org>; Tue, 09 Aug 2022 15:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Lgd8N3uU6gTm5GRjFj2JU4gbJeAjMmL1s0Ycq3bcw1w=;
        b=ZOZ364iCXqO3rFkPWZSXeqXB0+ptW3ZMFBapQ63J+HscT0rId8fEnHXunULdRppQ5S
         ZORadCG43mxRCkOtkuinFBx+zylDg8IE8+hwfn6qpeaTsZ1MvzV8BXKuZ8NHAEjzcBpU
         uf5ro3kA8tCa8jKFM5N10C1adgUpSnhdQKhJluBI0qnSFbH7NbNel6i6gWhazNxVXSTC
         vfSreiOlEcQqGS5s7CNQxZPr4wrvXiY9RgZAsVqoB8OQgCp+rCLcKUVLwJX58RIfzOd1
         uDSgwHwJjIWxTiTIUqoziEQi/y8DyX9fVoV9CArnt5ST0IQFUf7xxll/y1Om1rE0bQqr
         DHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Lgd8N3uU6gTm5GRjFj2JU4gbJeAjMmL1s0Ycq3bcw1w=;
        b=0Oo49sclfuWAOkjOt3/tIIAbQWtQVkKkbP2LG7loZlH1WWVTi/DGx0ReZyOjsCF00S
         EeLHrMo8Yj+vjEGb+Qveoxj3PixaBJMIBO0kOjOelP7ADGyTxGnkHq1lVCHEnjaFddkM
         0/QI4m1b/lDL11SA9y9fen+BGIRiutzDzROd52W+uLUAfEjcH+1xNXqVi4U60zXI8AN0
         2yDAQHlhITIh3KV4ibShXNsAHeoY+ri/P+HULngZOUFrXTWGldJAtkLjafmm6foygOn/
         2N6ulrbMkek47ngdPsgrJfY4G3anfFnZjVPcXyZecbRqs1RP2IvAHo+tH08EgwGAUQmD
         lubw==
X-Gm-Message-State: ACgBeo1SLtrt2IaMt83cx4aXhXXMeXUae8SWG079+vFXuonNIduURmDg
        icSXIH8yBgeEyUTeF4i2p5K5LpyBMLKRMg==
X-Google-Smtp-Source: AA6agR5eWXzvEi3SVBsTklUemakYhJ3EPm68LCEhMU3ifLXDQ4h6zmfmOTIDLlPjlCzrMFlFp/0cag==
X-Received: by 2002:a05:600c:2d05:b0:3a5:36eb:6ae9 with SMTP id x5-20020a05600c2d0500b003a536eb6ae9mr271239wmf.33.1660082719471;
        Tue, 09 Aug 2022 15:05:19 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c3b1500b003a317ee3036sm293583wms.2.2022.08.09.15.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 15:05:18 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v2 17/26] thermal/core/of: Remove of_thermal_get_ntrips()
Date:   Wed, 10 Aug 2022 00:04:27 +0200
Message-Id: <20220809220436.711020-18-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220809220436.711020-1-daniel.lezcano@linaro.org>
References: <20220809220436.711020-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
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

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.h |  5 -----
 drivers/thermal/thermal_of.c   | 16 ----------------
 2 files changed, 21 deletions(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 04565746afbf..ed60b3be9082 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -143,13 +143,8 @@ thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
 
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
index d8bba0009194..d1208b196b21 100644
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

