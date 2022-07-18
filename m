Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF575785C5
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jul 2022 16:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbiGROur (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Jul 2022 10:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234215AbiGROuq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jul 2022 10:50:46 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D49DE00C
        for <linux-pm@vger.kernel.org>; Mon, 18 Jul 2022 07:50:45 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id j29-20020a05600c1c1d00b003a2fdafdefbso7490497wms.2
        for <linux-pm@vger.kernel.org>; Mon, 18 Jul 2022 07:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PtA/Vgq5PiNGud9rKna9mzmJfODWF8PJRqr5/r8NLs4=;
        b=WK95xA/gIiwpzl143+RS3MKXQXXrdJJxlZGcA8WB76YcsXLNVr2m7fmruDnBVxd0rn
         n9xX65WxXW5RdrXz+tzN2/kBce3rxy/N/W9wBYwGQq3dX5y8WAO74XqyVpkTlYetv4jf
         YGWpVSd/YOZYaR8Lo2CRJvFFmEsb77hMtpr8Im7n/qWW9SRLcpNcVrM/fi1QVbj7gjHi
         hsJX5uCU/OvEYEJ8u14deJqrWNn3V3A6TXUkOLcKrgAYTn4TNb2qT6BiS+0JLXc2TO/4
         G01mTposA//H/hajSZXpdRGPfq+e4DyOunhK7qghYfcEc8oMEATEpq7HnI4dQK0gejD3
         ukcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PtA/Vgq5PiNGud9rKna9mzmJfODWF8PJRqr5/r8NLs4=;
        b=Wq8ENW/U6ORqLGLn6N7TLmxOj/aXm7n+g7VltV5Tb9U4paxG65rzwQ6IdGYD/WKagi
         c4Iap4TvifXcQ9ym7YRu0hyoZzyVsxXP+w/mnjhtpJKCxX8XY/q52G2d+rkeXWfSiPDq
         xlfY9hD3yOqa+DxoSBYnSjXm/3CZR/+aBH0YBYN8lL556o23X1GeM/yO2jJaYt2kTKWt
         SpmTQR+4PkbfkofLuhjID6gbucrEbbDtV7Re7wq3y/HdF8Mk3BsIW13X99/qr/DJ0h93
         5oflS+3wuMMnqhm2pWNsjk8pBhTJnLDycurdsXRtg3T7Pj5W/UXjpwVvEiOTBA9Oj/PE
         wKbw==
X-Gm-Message-State: AJIora8WS5au8Ks317Gj/nVCB9vqmsKeW/c/JU+xVVc9VPSDMhf40IES
        dRk34Mj04PiZQUjlT3hYStUqFw==
X-Google-Smtp-Source: AGRyM1ul1T/l+Y5Uxhn8youVNp340vtJvsQN7CPoCjAjbTHRAitsKou9x8R/FUcb8qw2rxAZR3fG0Q==
X-Received: by 2002:a7b:c7d2:0:b0:3a3:209d:cdc6 with SMTP id z18-20020a7bc7d2000000b003a3209dcdc6mr1561325wmk.55.1658155843809;
        Mon, 18 Jul 2022 07:50:43 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:496e:2d41:fd5a:4e5e])
        by smtp.gmail.com with ESMTPSA id r18-20020a05600c35d200b003a310631750sm11643715wmq.35.2022.07.18.07.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 07:50:43 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     quic_manafm@quicinc.com, rui.zhang@intel.com, amitk@kernel.org,
        lukasz.luba@arm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/4] thermal/core: Encapsulate the trip point crossed function
Date:   Mon, 18 Jul 2022 16:50:35 +0200
Message-Id: <20220718145038.1114379-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
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

The routine where the trip point crossed is detected is a strategic
place where different processing will happen. Encapsulate the code in
a function, so all specific actions related with a trip point crossed
can be grouped.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Reviewed by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 0d9e9b175f93..fa5767c6d5f4 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -358,6 +358,25 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
 		tz->ops->critical(tz);
 }
 
+static void handle_thermal_trip_crossed(struct thermal_zone_device *tz, int trip,
+					int trip_temp, int trip_hyst, enum thermal_trip_type trip_type)
+{
+	if (tz->last_temperature == THERMAL_TEMP_INVALID)
+		return;
+
+	if (tz->last_temperature < trip_temp &&
+	    tz->temperature >= trip_temp) {
+		thermal_notify_tz_trip_up(tz->id, trip,
+					  tz->temperature);
+	}
+
+	if (tz->last_temperature >= trip_temp &&
+	    tz->temperature < (trip_temp - trip_hyst)) {
+		thermal_notify_tz_trip_down(tz->id, trip,
+					    tz->temperature);
+	}
+}
+
 static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
 {
 	enum thermal_trip_type type;
@@ -372,16 +391,7 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
 	if (tz->ops->get_trip_hyst)
 		tz->ops->get_trip_hyst(tz, trip, &hyst);
 
-	if (tz->last_temperature != THERMAL_TEMP_INVALID) {
-		if (tz->last_temperature < trip_temp &&
-		    tz->temperature >= trip_temp)
-			thermal_notify_tz_trip_up(tz->id, trip,
-						  tz->temperature);
-		if (tz->last_temperature >= trip_temp &&
-		    tz->temperature < (trip_temp - hyst))
-			thermal_notify_tz_trip_down(tz->id, trip,
-						    tz->temperature);
-	}
+	handle_thermal_trip_crossed(tz, trip, trip_temp, hyst, type);
 
 	if (type == THERMAL_TRIP_CRITICAL || type == THERMAL_TRIP_HOT)
 		handle_critical_trips(tz, trip, type);
-- 
2.25.1

