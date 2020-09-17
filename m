Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33EA026D192
	for <lists+linux-pm@lfdr.de>; Thu, 17 Sep 2020 05:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgIQD2H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Sep 2020 23:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbgIQD2E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Sep 2020 23:28:04 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C03C061354
        for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2020 20:22:30 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id n133so829003qkn.11
        for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2020 20:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=myxUO6gc+lFpyY6bxPaw2oxrXJNbpjbu9J+ggDGNP1Q=;
        b=iYF9saol7Uya9S+s+a5H00YbWk1vk/5ld+bL+/IoAQzNJ84leuLdIk4WZKQoc3IjJ7
         458Luy1hzBiiGiPzkWs+JegOxXStBqnEASvcNydckoGa7tcJ7F3c14FGQttP7joLwjfZ
         qw1Eohni5Xmwr8EyOfpZyf2VSI2daffRU4FDuOU+ocHwwIEy8SsNZ8E3bJqTDd9NxNKz
         N1zHygoqOkMvs+n02vrxFKxNZrzLWawNw/FjF74zU0xzcGLt7BkPLhyCZ0MY8D39DkVl
         xia9YMQcIYE6ykJstBekisdhdf0vr588cfSuqVv09iHwjh9ydJg5kh0OXIX+1akr4yqs
         kD+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=myxUO6gc+lFpyY6bxPaw2oxrXJNbpjbu9J+ggDGNP1Q=;
        b=bCfFSWa8Nrciw+FEsS3hmg5P+Dso1/mnn0x+69UDi0nh/pRsoDBqu+rYA77pAO9LqE
         5cBt2+nAEMBfJ6Xy/JiqfHescEwHCmhjfV9YZHxkoeT+a9NuYtNTMgv99oQVXsEtoZ9m
         skByVUCZSFnCQvjLeqp2UplX6PROBHcplAYQph7/S/7+X+l0nTQsbtvonjtOVcc1IMod
         esZIuM6pV7loMyIeP4JTS4kxFwGNXLzi73OlTmDj1N0640PI53+CvlTckK4oSuz1kel4
         nQ0jDKmpEf7B+/4oA5aqjGLHNDuqhte0Ec1sxyuZthD9fAhMo9DkNvSNmtlDs/gjk2Ps
         3Yeg==
X-Gm-Message-State: AOAM531/BFN9WibFQmZaMOYMjDzcWO9dD5eP8typxf9ZII+MXNrzOWrn
        jT0dwXubLyqtWYd8CcgrCPT4Mw==
X-Google-Smtp-Source: ABdhPJyC733LwHdlOPKyh0SJj9Ov7zceVdFCYbRyxyeI44PNS39rWktdOG6zOgaxjUTzbgJIqt7rUg==
X-Received: by 2002:ae9:c310:: with SMTP id n16mr11085776qkg.318.1600312949899;
        Wed, 16 Sep 2020 20:22:29 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id g45sm21370801qtb.60.2020.09.16.20.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 20:22:29 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, robh+dt@kernel.org,
        agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        lukasz.luba@arm.com, amitk@kernel.org
Subject: [PATCH RFC 2/8] thermal: Introduce new property monitor_type for trip point.
Date:   Wed, 16 Sep 2020 23:22:20 -0400
Message-Id: <20200917032226.820371-3-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200917032226.820371-1-thara.gopinath@linaro.org>
References: <20200917032226.820371-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Thermal trip points can be defined to indicate whether a
temperature rise or a temperature fall is to be monitored. This
property can now be defined in the DT bindings for a trip point.
To support this following three changes are introduced to thermal
core and sysfs code.
1. Define a new variable in thermal_trip to capture the monitor
   rising/falling information from trip point DT bindings.
2. Define a new ops in thermal_zone_device_ops that can be populated
   to indicate whether a trip is being monitored for rising or falling
   temperature. If the ops is not populated or if the binding is missing
   in the DT, it is assumed that the trip is being monitored for rising
   temperature. (default behavior today)

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/thermal/thermal_core.h | 2 ++
 include/linux/thermal.h        | 2 ++
 include/uapi/linux/thermal.h   | 5 +++++
 3 files changed, 9 insertions(+)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index e00fc5585ea8..c56addfe2284 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -77,12 +77,14 @@ int power_actor_set_power(struct thermal_cooling_device *cdev,
  * @temperature: temperature value in miliCelsius
  * @hysteresis: relative hysteresis in miliCelsius
  * @type: trip point type
+ * @monitor_type: trip point monitor type
  */
 struct thermal_trip {
 	struct device_node *np;
 	int temperature;
 	int hysteresis;
 	enum thermal_trip_type type;
+	enum thermal_trip_monitor_type monitor_type;
 };
 
 int get_tz_trend(struct thermal_zone_device *tz, int trip);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 42ef807e5d84..a50ed958d0bd 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -72,6 +72,8 @@ struct thermal_zone_device_ops {
 	int (*set_trip_temp) (struct thermal_zone_device *, int, int);
 	int (*get_trip_hyst) (struct thermal_zone_device *, int, int *);
 	int (*set_trip_hyst) (struct thermal_zone_device *, int, int);
+	int (*get_trip_mon_type)(struct thermal_zone_device *, int,
+				     enum thermal_trip_monitor_type *);
 	int (*get_crit_temp) (struct thermal_zone_device *, int *);
 	int (*set_emul_temp) (struct thermal_zone_device *, int);
 	int (*get_trend) (struct thermal_zone_device *, int,
diff --git a/include/uapi/linux/thermal.h b/include/uapi/linux/thermal.h
index c105054cbb57..d3bb4e4fad69 100644
--- a/include/uapi/linux/thermal.h
+++ b/include/uapi/linux/thermal.h
@@ -16,6 +16,11 @@ enum thermal_trip_type {
 	THERMAL_TRIP_CRITICAL,
 };
 
+enum thermal_trip_monitor_type {
+	THERMAL_TRIP_MONITOR_RISING = 0,
+	THERMAL_TRIP_MONITOR_FALLING
+};
+
 /* Adding event notification support elements */
 #define THERMAL_GENL_FAMILY_NAME		"thermal"
 #define THERMAL_GENL_VERSION			0x01
-- 
2.25.1

