Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F5B56C09F
	for <lists+linux-pm@lfdr.de>; Fri,  8 Jul 2022 20:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238905AbiGHScf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Jul 2022 14:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239108AbiGHScW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Jul 2022 14:32:22 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7640612E
        for <linux-pm@vger.kernel.org>; Fri,  8 Jul 2022 11:32:21 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id o16-20020a05600c379000b003a02eaea815so1287955wmr.0
        for <linux-pm@vger.kernel.org>; Fri, 08 Jul 2022 11:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8W1S2KUuL89TqEwWGa5XSTCs1irHk/zbJh1P5bOgERI=;
        b=B0BNs4nOwOtWXpSnh0Sk8e0/yhMsisqXUANXdlv4wV9Ln/BjUKPy5vQf9TWj3QQQ8t
         Z2tzvB+kZ6ohiPy4eh881B/569E7ujYz3jhxrvuAboW0cEXuOqaKc6UbzEf1d1XfIpcU
         cLeBVZ2j96Z+9k52a78bHdo4k7SuvKHoRXfalILLU12WA0eqXstzz2rRJxzsfu6Jhc20
         7FJtbcylNwMGBLTWpxNPbix5P+hS3aUJDdlsiBHjbPACXeqy5ISqlJP8XoAKpnGQs8DQ
         oule4vZpMp4nmQ1Kpw18JHtIOxKILK6dqlxpQHx1OxjVsZI1l7zvwgga5CIVcuegkFDw
         uXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8W1S2KUuL89TqEwWGa5XSTCs1irHk/zbJh1P5bOgERI=;
        b=vyC9ZfliHMvK/RWOjizW3b+xP9Ve7xvp8uKBDfo2WCTdtrAsDKSVaKu+dY+oASPFGL
         ScHqpTFsGW0yvBvW+tpl1b/RD/KrQMkpAZbfeO2DYwhCTuFAMZNVpdNaBTpqyMVnBsGo
         jVur+s7jye1aV7p3NMSNxTs6dk6eMTFvFuba3/MmlCJXZts67kTocXE16osGKRiwKAxl
         MhOE5pwuJIuAd3yeNw9XhMzXaG/9fg0REbqS1PUt6Um3ygstSTAfT9/DbFI2Hs39fkgS
         CC8jwUzZzGwunbS1WhBamRPqSjJX8OlpPh/XFzyNIYRSTxfpwvrixFwlIsaUZ9qHDkcP
         D7tw==
X-Gm-Message-State: AJIora/JOW4NOBXQkBJlGUs3q+37kmEhcZOgxRll9+pkB0H9+1vvuoWd
        pg2Zq03K2nf+nINH+p27QEHWHlO703215A==
X-Google-Smtp-Source: AGRyM1vhfGP9ifazaZ9vpI32bu2RGhrdCwI/+vHiooP3kQWcNm3jdvENg1s6UXKL7QCpNTTxr5yomA==
X-Received: by 2002:a05:600c:22da:b0:3a0:4e7b:4237 with SMTP id 26-20020a05600c22da00b003a04e7b4237mr1159282wmg.101.1657305139981;
        Fri, 08 Jul 2022 11:32:19 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id t9-20020adfeb89000000b0021d887f9468sm4292073wrn.25.2022.07.08.11.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 11:32:19 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     quic_manafm@quicinc.com, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v2 1/3] thermal/core: Encapsulate the trip point crossed function
Date:   Fri,  8 Jul 2022 20:32:07 +0200
Message-Id: <20220708183210.1334839-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
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

The routine where the trip point crossed is detected is a strategic
place where different processing will happen. Encapsulate the code in
a function, so all specific actions related with a trip point crossed
can be grouped.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index cdc0552e8c42..d9f771b15ed8 100644
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

