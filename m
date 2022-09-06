Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533945AF175
	for <lists+linux-pm@lfdr.de>; Tue,  6 Sep 2022 19:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239266AbiIFRBR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Sep 2022 13:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234638AbiIFRAD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Sep 2022 13:00:03 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CC01A839
        for <linux-pm@vger.kernel.org>; Tue,  6 Sep 2022 09:47:46 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id c11so12128416wrp.11
        for <linux-pm@vger.kernel.org>; Tue, 06 Sep 2022 09:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Brk79K68Pth5JpZf/n4X97+hyNwde3ZvZaEoGdSbClA=;
        b=jObwUaNeQVo3B8xvm7KVeFg8MPjFZ0xfyWRYhOlBbUCRb9chVNg/QtV1JfrSyNI0Gn
         ijk1xiKAGKyS8Pp3OAN8fL3nt+HFD3m1KyykqIJerck7bvpIOmgyGOk4aW0kTiPQdDuj
         B5hBjO219QAq6BfP0nGTTsQuBMf253if+rj8ykit7A0zj1US7OfhjSyKH7+JvPtjiUOP
         4qFnEHXdZoj6olrol+8XuRNC3o8oUq9PHCPSX2DQh/OpaZ3wiyosYyxoUG2qM4xeCSkP
         vGBwRu663wZNMp7ewN5f7jCDnPlikElaF+pcUH699mOORUb1B6//92tpd9z9nVCADQxz
         rc3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Brk79K68Pth5JpZf/n4X97+hyNwde3ZvZaEoGdSbClA=;
        b=2UyQC0heKHuroVk/+EtxthKYMuVAnLPdI47U3oRPuVbmPemw6YWe1/5AAdBIvuvxge
         Cu0hpFPd687a6g4eZnYyEzeYPBCBakLj702iNdsj1iJXJZJzQe4o4JHTvkp+G8XTzC15
         Au495x25TU+M3DiK1BudMooNmUYrTGWSuEbbZZ161FlUYiGH6zODpCl8CUKxr+B0E9a6
         bmyFqVWp3cvK29xodrTh5N+qpeQ4y5v3O4qgaVzoADJ338ruDbp8S/C4Lt73A7ijkKh+
         iBx3+D0yoi4IALJRlHdpNc5cY7RszbOVy5mjW9INzQ4mo02TVkMYWt4QLokMnIcH25+b
         pijA==
X-Gm-Message-State: ACgBeo1+kjKmesvcpqPfORwjdJXLzDhCCqkBOaS+SNwmuriFBAR0UD97
        Vtv3lU7a18UiTpoIMRtybYWz4Q==
X-Google-Smtp-Source: AA6agR7O6ixwCX6kbf6Gq+MqS0DkGwc5S54QbBzEfZMb1tqJ1YIQ8vrgacetb+2nmxpdYRCk3zY6dA==
X-Received: by 2002:adf:e109:0:b0:225:4ca5:80d5 with SMTP id t9-20020adfe109000000b002254ca580d5mr27573916wrz.465.1662482865881;
        Tue, 06 Sep 2022 09:47:45 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id e27-20020adf9bdb000000b0021f0ff1bc6csm7426600wrc.41.2022.09.06.09.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 09:47:45 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v3 07/30] thermal/of: Remove unused functions
Date:   Tue,  6 Sep 2022 18:46:57 +0200
Message-Id: <20220906164720.330701-8-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220906164720.330701-1-daniel.lezcano@linaro.org>
References: <20220906164720.330701-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

