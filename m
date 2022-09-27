Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D20B5EC653
	for <lists+linux-pm@lfdr.de>; Tue, 27 Sep 2022 16:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbiI0OeJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Sep 2022 10:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbiI0OdS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Sep 2022 10:33:18 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E78DCEAC
        for <linux-pm@vger.kernel.org>; Tue, 27 Sep 2022 07:33:16 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id o5so6685729wms.1
        for <linux-pm@vger.kernel.org>; Tue, 27 Sep 2022 07:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=vcQTbtSOs9FbsFbv8V2t/E69I1IFg9ZKCW8F5npsSmY=;
        b=UsnDTFpTZY9iEAZY89udiS2H8oFx1xN21c1A5ekW7mNlbvTO38RgICG92ha+NCQn27
         T8G4+ISAfbQQOxUA7WhRlgower4SIb+NT1f7TZ9DHHBswxkSsNs3mHN3I5qSJoRr+M7J
         +nsHXZRK26/tzWeFaF0roiSiG2kBG3Cz05G0Nhhda7nf6xud63NtuQC1cYWbpSPsnonG
         1Hdg4vr5ImHE5bANac+NsTOW7SnIpm6GouF2jg8zfU5F5b4uo5BVoajFt/boLNromI8o
         wpZfUDdoZMnfsAqGaUEPHlfFgQBxbC990z9Kujc0v/Socbkh9SFhriCL8fhxKJGaeCDE
         WCyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=vcQTbtSOs9FbsFbv8V2t/E69I1IFg9ZKCW8F5npsSmY=;
        b=VZEUIRrAOofA3GIWH9cPBZiKV4QD1tnlH+IiCiRj2kvJeqm53/EJotKm7yYbfzff8l
         yqcIGJgWtvzsKvLQ4amKeJ0lFCtzsv+qtcoKpSTQRqbmoonSNxBbuK2oiRYSxliIbloz
         3FzINgHu4JbJMWtp/fnR36mmnEkLK9JZKRJk/w8RtayIWvQwfd2IbjF9zakUyUpXWpEJ
         AX8HSPQ/OlUr8IVOP1og8kUL0hPhBsQWMqPAIDTyDiqzwSy7H0pYJvAs6pZ98deCW1+C
         s9sTOLPA97ZkBizJwr1Et+mHe7K5j4mDWTsZ0kOQM0iPlwjdyv2qDRs6pTMM7WLopfQs
         VzDw==
X-Gm-Message-State: ACrzQf2e1iQEK+LLK8iimL2MwpHJUz3vJSlUN934EUZwiCAr8dSyj00Y
        ZEHbWG9gr76Pf/BN/6FEIheENw==
X-Google-Smtp-Source: AMsMyM5h9ZxEcceHlPSr9cO0s9KeNurNccRDoxKa+l7lB4Dhk0VCEAG3bDt/RGkzcfEoTRGoad7FlA==
X-Received: by 2002:a1c:f008:0:b0:3b4:fd2e:3ede with SMTP id a8-20020a1cf008000000b003b4fd2e3edemr3002901wmb.133.1664289195081;
        Tue, 27 Sep 2022 07:33:15 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b003b4924493bfsm17518371wmq.9.2022.09.27.07.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 07:33:14 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v6 17/29] thermal/of: Remove of_thermal_is_trip_valid()
Date:   Tue, 27 Sep 2022 16:32:27 +0200
Message-Id: <20220927143239.376737-18-daniel.lezcano@linaro.org>
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
index b00fc1913734..e9b3af6c2084 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -138,16 +138,6 @@ thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
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

