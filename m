Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBDB1A4BC7
	for <lists+linux-pm@lfdr.de>; Sat, 11 Apr 2020 00:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgDJWNL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Apr 2020 18:13:11 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36760 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgDJWNJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Apr 2020 18:13:09 -0400
Received: by mail-wr1-f67.google.com with SMTP id u13so3393281wrp.3
        for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2020 15:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fxaTwkHtjzC50vJJAtVceJtgHQwtXeZqJh88iIfXOtk=;
        b=LnkOKzUc57woc+efoOdWiBC76HgkeeWvVHT8utSyv4y4uF/vGGV+76MatJbZaG5xOK
         7eG3fFoeF6UJfxp6G9Qfme6y+811y2k3jXR8LqNuNtK+wroOdIE0vuGhIf87Qq1jd6b2
         Yi+mP9KtwPMl5aTcmTDsDZPNHtJydfZv0f301L5YddAEhFVPf2URdVAFMzDcFHDU+POU
         sGcQEfxNlLSMGqyHvmuxmX+jUymb+n70labUzE2R/pXSYpEWVaDrcoBShqBwDsWR98f0
         Hix3Ob7EkD9gwOHgxZQCdQwsY+iGkOcv8kAUI/vzRfi7XpHM1AL7yyfDQi4tXjg9hvup
         lV7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fxaTwkHtjzC50vJJAtVceJtgHQwtXeZqJh88iIfXOtk=;
        b=ozwwb0wGqPF4BrJaQgYf3P+mesPYHxfw5A7Kwj+Vv+1lS9XAPJD/OSv3BaGAPgP1J3
         Khzw/nLU63jZgDRaMo7hNAl4GG+KXChdHKvCKwm6D09sj9IF7DG8Pqb4thARwAn14FT0
         LQ7NJRMvQlLZcbFzuEl5vM+gQZm9xTK8XrvAhKt/UntCRttBWH17ez2VybQ6qXgm4QAY
         p9hAq8RSQwCrmdYBvf6PTKcvIkCB0QnP5SfYYMLNxgEtNs0ooICmGQfxaZLhaKcdaUFK
         G3nnrx382EtjaPEXGEK+MQiKMoACcGb46j5vwj6owVP0oUYI8bUr91xDjWm5fNhbEWV5
         9/1w==
X-Gm-Message-State: AGi0PuZYKS95KJSMaaA2DuAU2JnjbPnQ3OKcMQWOEh3XH/xbLK7hTq1z
        tFHdr7oFp5jf+QqJXw55BLeBhg==
X-Google-Smtp-Source: APiQypL3k7Xms3q1e2VlI7EhK1FEiuXF36sTNcFUnL6N6T04029IelnALYNh/iFMvpS4NCovtiUgDg==
X-Received: by 2002:adf:97ce:: with SMTP id t14mr4408871wrb.263.1586556786788;
        Fri, 10 Apr 2020 15:13:06 -0700 (PDT)
Received: from localhost.localdomain (lns-bzn-59-82-252-135-148.adsl.proxad.net. [82.252.135.148])
        by smtp.gmail.com with ESMTPSA id b14sm4687952wrw.83.2020.04.10.15.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 15:13:06 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     amit.kucheria@verdurent.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org (open list:THERMAL)
Subject: [PATCH 6/6] thermal: core: Make thermal_cdev_update private
Date:   Sat, 11 Apr 2020 00:12:35 +0200
Message-Id: <20200410221236.6484-7-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200410221236.6484-1-daniel.lezcano@linaro.org>
References: <20200410221236.6484-1-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Move the function thermal_cdev_update as an internal thermal function
instead of leaking it around.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.h | 1 +
 include/linux/thermal.h        | 3 ---
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index c95689586e19..4e271016b7a9 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -120,6 +120,7 @@ int thermal_build_list_of_policies(char *buf);
 
 /* Helpers */
 void thermal_zone_set_trips(struct thermal_zone_device *tz);
+void thermal_cdev_update(struct thermal_cooling_device *cdev);
 
 /* sysfs I/F */
 int thermal_zone_create_device_groups(struct thermal_zone_device *, int);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 08969f0be6a0..faf7ad031e42 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -413,7 +413,6 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
 int thermal_zone_get_slope(struct thermal_zone_device *tz);
 int thermal_zone_get_offset(struct thermal_zone_device *tz);
 
-void thermal_cdev_update(struct thermal_cooling_device *);
 void thermal_notify_framework(struct thermal_zone_device *, int);
 #else
 static inline struct thermal_zone_device *thermal_zone_device_register(
@@ -457,8 +456,6 @@ static inline int thermal_zone_get_offset(
 		struct thermal_zone_device *tz)
 { return -ENODEV; }
 
-static inline void thermal_cdev_update(struct thermal_cooling_device *cdev)
-{ }
 static inline void thermal_notify_framework(struct thermal_zone_device *tz,
 	int trip)
 { }
-- 
2.17.1

