Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D8C5EC665
	for <lists+linux-pm@lfdr.de>; Tue, 27 Sep 2022 16:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbiI0OeE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Sep 2022 10:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbiI0OdS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Sep 2022 10:33:18 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0535BF3918
        for <linux-pm@vger.kernel.org>; Tue, 27 Sep 2022 07:33:15 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id m4so985632wrr.5
        for <linux-pm@vger.kernel.org>; Tue, 27 Sep 2022 07:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=G/YO0fJeKfkSzRqdgqFU3ij4yJaDOnZPHmbsRpXJf/A=;
        b=XDCHuQlzlQD4fYNdSPTBvZkqPSad4A8RfN/HuboYAwvcwMWyp8cRwG4P02pvk81Aci
         TrhBZy00xbYVpFlgmbqt3tgTdSaXRYOTVq+pgUyg4KTEnMh3JX+hqNzIa1Gy6A3UwWxq
         8mAv7U3M9yRphglqXnslFhOwYrXAwRpERPv7Hy/48E7bJqUYNvdvFSjwxDnNnbWiG/fZ
         Iw2VBVl7xIHOXHto1BbVeW18VKMK1dRDWIcNa98htikLou+JreAJGkgSxCaqCGPvfayD
         CueZBL/9sx4aLZIRq/+tp0byyLlZUUtBJAXIg7J+MndNmJMSM9Y6sVD3yB6k4PCtVual
         ZcGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=G/YO0fJeKfkSzRqdgqFU3ij4yJaDOnZPHmbsRpXJf/A=;
        b=aqHzjNgPKgE3GAJ+oeuKbMN9EDWrYZeU/ZOh7eV6RujWgknPy9aETz4XI3UVYR+hdh
         ZVacRJb32R3ztQbQ3ywv0O8tHvQZ5DP6T8lKos/GajUsp+LBzbE7Kxv76GF03jSZ13LM
         VBAmGaYWzNW1ljv5cXi7gxTRRsW9vozyKGRpNcpVvJPVL10qglMR8nEQgNZ9V2HymAWl
         hgwOkRnzTMC+ZNKJCrDwBuwy7CMc4pLvcGi87e56l5egBV68LHFlr5OxeBBK1qj58Nr6
         QypeY8sQSVyqZn63n6Uzb0hQ9WuBS2a0EZRjVYTSIXLuUv3LAmzKzX3O+7vmceEdafM8
         jTLQ==
X-Gm-Message-State: ACrzQf1gS59zOimMs9PBV5On0a2iE59ucBXf+tTbPOmWtQlJ6lUshi/K
        RhtN96QjLlhxDEbAJYmXWUZ4Cg==
X-Google-Smtp-Source: AMsMyM6RT9djNkMi2CqSg3NLsyjtWsYeIJIDaO43YD4C8EmD0iOSotkxPz+UoRaLd423EKk19klfpw==
X-Received: by 2002:a5d:444c:0:b0:22a:e6a2:c498 with SMTP id x12-20020a5d444c000000b0022ae6a2c498mr17321376wrr.531.1664289194081;
        Tue, 27 Sep 2022 07:33:14 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b003b4924493bfsm17518371wmq.9.2022.09.27.07.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 07:33:13 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v6 16/29] thermal/of: Remove of_thermal_get_ntrips()
Date:   Tue, 27 Sep 2022 16:32:26 +0200
Message-Id: <20220927143239.376737-17-daniel.lezcano@linaro.org>
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

The thermal OF code uses the generic trip points to initialize the
thermal zone. Consequently thermal_zone_get_num_trips() can be used
and the of_thermal_get_ntrips() is no longer needed. Remove it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.h |  5 -----
 drivers/thermal/thermal_of.c   | 16 ----------------
 2 files changed, 21 deletions(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index c5990a3fcf8a..b00fc1913734 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -139,13 +139,8 @@ thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
 
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

