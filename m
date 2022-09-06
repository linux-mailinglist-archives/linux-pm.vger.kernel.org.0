Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6805AF19C
	for <lists+linux-pm@lfdr.de>; Tue,  6 Sep 2022 19:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239368AbiIFRB5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Sep 2022 13:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239107AbiIFRAc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Sep 2022 13:00:32 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB6614D38
        for <linux-pm@vger.kernel.org>; Tue,  6 Sep 2022 09:48:00 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id bd26-20020a05600c1f1a00b003a5e82a6474so7804630wmb.4
        for <linux-pm@vger.kernel.org>; Tue, 06 Sep 2022 09:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=NFzfcStR9W+Nwf1uLdi1lXL2TUYpkWfd9XSuLVSwMnk=;
        b=GlrL7+cd7i15KGj/i03cteP5PlR0MefSntaqtO8bBVZNn0tLzJ0+yxoh51iMWUHsMv
         iw1C5tT7/flSA8XgPjK0POZ3eudCtxJYEEIKvVr6IaFG8vCMUo5uD8mlkji7t2zD0rCp
         HSm1oz0t1F3lUUDXgkFPn8++XMmG9TMGr1xipsyZ+gxdINkzKlUD/yAdL45oXRoxjzDZ
         Kk6g76vJhtmj0woHBIh8PcsJfT+yWmfFbMF+nqA7lsNdggx4t2cq0N7yLZv6NhfsWRMc
         MnndEE9u+pWge8p56G4PQwM/a4D9MGueaj4qTORREJXC9u8ShM6NaCxMoqsAmTvmtsbm
         BO7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=NFzfcStR9W+Nwf1uLdi1lXL2TUYpkWfd9XSuLVSwMnk=;
        b=AJB3kTrAT5h7DlmGHjtXbxefVFgLYL392MvUtdrngxuWAkxZSarYsEk+i7kJl2sY1c
         uiIqIs2ZBED1rw9ipPTK/w/vFCIfqVPf+whmZsaBQF0jGY3ILGacKXQlly8mJOls7QH0
         zyH+/7006z8uGS3xscLgjcPtDoeudzN9BwLCpLCuanPeg0DSmx+hoKqCUdBRK+EFYWpD
         bz5fkucYicdi1JM7v0p3rAb9b9jsZDSvSrgLvTMJRXQReaIy6ELWzUsTnhJpKbYI72Zy
         pEtgLcBq6aU9MRcZFyToEqNyYw+COQEA8VGsjvy/+Lj1Mbr7X3c9UaPCaLPUScncZ+5x
         VPOg==
X-Gm-Message-State: ACgBeo3GMDthoqj2tc/DVgJBUycwkoEH3Wof9c3QIpphCMmFJxowXncv
        2xISsOTrjUsDh6EU3LKByz3KlA==
X-Google-Smtp-Source: AA6agR7OEjpnE/6nP3TJEobMFoznkT/eqpKORo8rgq1q+/Ayp66Gc1kLu2gHOPg96pxYxVpU0fNRKg==
X-Received: by 2002:a05:600c:4e15:b0:3a6:152a:9143 with SMTP id b21-20020a05600c4e1500b003a6152a9143mr14260140wmq.20.1662482879938;
        Tue, 06 Sep 2022 09:47:59 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id e27-20020adf9bdb000000b0021f0ff1bc6csm7426600wrc.41.2022.09.06.09.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 09:47:59 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v3 18/30] thermal/of: Remove of_thermal_is_trip_valid()
Date:   Tue,  6 Sep 2022 18:47:08 +0200
Message-Id: <20220906164720.330701-19-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220906164720.330701-1-daniel.lezcano@linaro.org>
References: <20220906164720.330701-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is no benefit with the of_thermal_is_trip_valid() function as it
does the check the thermal_zone_get_trip() is already doing for the
sake of getting the trip point.

As all the calls have been replaced by thermal_zone_get_trip(), there
is no more users of of_thermal_is_trip_valid().

Remove the function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.h | 10 ----------
 drivers/thermal/thermal_of.c   | 19 -------------------
 2 files changed, 29 deletions(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 0139bc1e4f87..4d1af11a6eb4 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -136,16 +136,6 @@ thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
 #endif /* CONFIG_THERMAL_STATISTICS */
 
 /* device tree support */
-#ifdef CONFIG_THERMAL_OF
-bool of_thermal_is_trip_valid(struct thermal_zone_device *, int);
-#else
-static inline bool of_thermal_is_trip_valid(struct thermal_zone_device *tz,
-					    int trip)
-{
-	return false;
-}
-#endif
-
 int thermal_zone_device_is_enabled(struct thermal_zone_device *tz);
 
 #endif /* __THERMAL_CORE_H__ */
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 89afa59c4915..4e54d62720dc 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -19,25 +19,6 @@
 
 #include "thermal_core.h"
 
-/**
- * of_thermal_is_trip_valid - function to check if trip point is valid
- *
- * @tz:	pointer to a thermal zone
- * @trip:	trip point to evaluate
- *
- * This function is responsible for checking if passed trip point is valid
- *
- * Return: true if trip point is valid, false otherwise
- */
-bool of_thermal_is_trip_valid(struct thermal_zone_device *tz, int trip)
-{
-	if (trip >= tz->num_trips || trip < 0)
-		return false;
-
-	return true;
-}
-EXPORT_SYMBOL_GPL(of_thermal_is_trip_valid);
-
 static int of_thermal_set_trip_hyst(struct thermal_zone_device *tz, int trip,
 				    int hyst)
 {
-- 
2.34.1

