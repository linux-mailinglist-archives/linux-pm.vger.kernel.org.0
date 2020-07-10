Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7D121B72D
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 15:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgGJNwC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jul 2020 09:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728179AbgGJNwB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jul 2020 09:52:01 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F453C08C5DD
        for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2020 06:52:01 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id dm12so2558935qvb.9
        for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2020 06:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jHIyzQC2ceqyL76cAxetV2VUM/9zPrieydXeUmPcEI8=;
        b=X+s9k0k68ktP2Yeh15hRqVvjhNy41w6Uzqg0Vk7k9inbT3pjbSWQdujNRt+liki46B
         FhIFz7QnKATwGL0EUwYendyIQozMppEvO0lv5zZ8HNsCgNbx+U+L0+zu2QX4C1I1E/T4
         gWA5OsfL9+hh3KM5yFCGZZwdc9ddst3WpMG8BalN1+fQVC3B2NHsxl6kcmJ2dvKLp7lU
         RNlnDAYvHYmU5HDdr2ey81GCD8Q7IWO7qsApfKGadFssKOiT9hAhE+8ifWvyqEzDMNc/
         1txVL72Garh01uxaM/fVsIqoMP4d7V2DC4snZ1j09TUu7dv99ln0REkoCEeoQgAiPdzE
         KerA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jHIyzQC2ceqyL76cAxetV2VUM/9zPrieydXeUmPcEI8=;
        b=qe+G+a552P6kBbUJ8gWJjneW3iAgVsp/V4Lqvg39QZTxk+vGgDWSk4ouqskjMPopMD
         IpWGDmdGEx9ygqr7/aS8lKUXpzsVtPVZ0nzhkf29CNm7oX6ZfeB60G/lKLnG3dWpIMC9
         54+rQYm9rkvDK2XlXjbj4Sc7FOJqzEOVGIEuapm+6Tasemtm4UgEAssSrIgpyWARQQlE
         MFQlPj5vnBHwZl+Zg/Ek6kirfEEQDZkgAvOUFAt1hkVF07sYHIRbU89qsK7+/JyIKKaF
         YRUB0r2k4PpKTEyKJQs/VIf9f2vPtRUO/xRDlWB6YawcXefLkO9IUTO0/vhIJbXyY5ll
         ictA==
X-Gm-Message-State: AOAM530/kb7swU9X/TK6OBPM3pCwC7w3S8E3o3OoQcw/YxQR9TbHTDMV
        E/0TolJo77M1uctiyD+dt9UOLQ==
X-Google-Smtp-Source: ABdhPJz2cJ39OfepgrtuKORDQkyAnhUEDijQh4wyfZtt4PxDcz9UPreEn3Pp/nGpclpsYmc7ZBwsJA==
X-Received: by 2002:a0c:b791:: with SMTP id l17mr69514906qve.44.1594389120284;
        Fri, 10 Jul 2020 06:52:00 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id h197sm7574059qke.51.2020.07.10.06.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 06:51:59 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/4] thermal: Modify thermal governors to do nothing for "cold" trip points
Date:   Fri, 10 Jul 2020 09:51:54 -0400
Message-Id: <20200710135154.181454-5-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200710135154.181454-1-thara.gopinath@linaro.org>
References: <20200710135154.181454-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

For now, thermal governors do not support monitoring of falling
temperature. Hence, in case of calls to the governor for trip points marked
as cold, return doing nothing.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/thermal/gov_bang_bang.c       | 8 ++++++++
 drivers/thermal/gov_fair_share.c      | 8 ++++++++
 drivers/thermal/gov_power_allocator.c | 8 ++++++++
 drivers/thermal/gov_step_wise.c       | 8 ++++++++
 4 files changed, 32 insertions(+)

diff --git a/drivers/thermal/gov_bang_bang.c b/drivers/thermal/gov_bang_bang.c
index 991a1c54296d..8324d13de1e7 100644
--- a/drivers/thermal/gov_bang_bang.c
+++ b/drivers/thermal/gov_bang_bang.c
@@ -99,6 +99,14 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
 static int bang_bang_control(struct thermal_zone_device *tz, int trip)
 {
 	struct thermal_instance *instance;
+	enum thermal_trip_type trip_type;
+
+	/* Return doing nothing in case of cold trip point */
+	if (trip != THERMAL_TRIPS_NONE) {
+		tz->ops->get_trip_type(tz, trip, &trip_type);
+		if (trip_type == THERMAL_TRIP_COLD)
+			return 0;
+	}
 
 	thermal_zone_trip_update(tz, trip);
 
diff --git a/drivers/thermal/gov_fair_share.c b/drivers/thermal/gov_fair_share.c
index aaa07180ab48..c0adce525faa 100644
--- a/drivers/thermal/gov_fair_share.c
+++ b/drivers/thermal/gov_fair_share.c
@@ -81,6 +81,14 @@ static int fair_share_throttle(struct thermal_zone_device *tz, int trip)
 	int total_weight = 0;
 	int total_instance = 0;
 	int cur_trip_level = get_trip_level(tz);
+	enum thermal_trip_type trip_type;
+
+	/* Return doing nothing in case of cold trip point */
+	if (trip != THERMAL_TRIPS_NONE) {
+		tz->ops->get_trip_type(tz, trip, &trip_type);
+		if (trip_type == THERMAL_TRIP_COLD)
+			return 0;
+	}
 
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
 		if (instance->trip != trip)
diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 44636475b2a3..2644ad4d4032 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -613,8 +613,16 @@ static int power_allocator_throttle(struct thermal_zone_device *tz, int trip)
 {
 	int ret;
 	int switch_on_temp, control_temp;
+	enum thermal_trip_type trip_type;
 	struct power_allocator_params *params = tz->governor_data;
 
+	/* Return doing nothing in case of cold trip point */
+	if (trip != THERMAL_TRIPS_NONE) {
+		tz->ops->get_trip_type(tz, trip, &trip_type);
+		if (trip_type == THERMAL_TRIP_COLD)
+			return 0;
+	}
+
 	/*
 	 * We get called for every trip point but we only need to do
 	 * our calculations once
diff --git a/drivers/thermal/gov_step_wise.c b/drivers/thermal/gov_step_wise.c
index 2ae7198d3067..009aefda0441 100644
--- a/drivers/thermal/gov_step_wise.c
+++ b/drivers/thermal/gov_step_wise.c
@@ -186,6 +186,14 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
 static int step_wise_throttle(struct thermal_zone_device *tz, int trip)
 {
 	struct thermal_instance *instance;
+	enum thermal_trip_type trip_type;
+
+	/* For now, return doing nothing in case of cold trip point */
+	if (trip != THERMAL_TRIPS_NONE) {
+		tz->ops->get_trip_type(tz, trip, &trip_type);
+		if (trip_type == THERMAL_TRIP_COLD)
+			return 0;
+	}
 
 	thermal_zone_trip_update(tz, trip);
 
-- 
2.25.1

