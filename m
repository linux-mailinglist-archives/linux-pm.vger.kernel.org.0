Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B064A19C40D
	for <lists+linux-pm@lfdr.de>; Thu,  2 Apr 2020 16:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387985AbgDBO2V (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Apr 2020 10:28:21 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39296 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732950AbgDBO2K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Apr 2020 10:28:10 -0400
Received: by mail-wr1-f65.google.com with SMTP id p10so4453396wrt.6
        for <linux-pm@vger.kernel.org>; Thu, 02 Apr 2020 07:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uPGWZu5ngtNrn+ryPQoiCELQ8McZSJI9oUiugafXI6g=;
        b=o/I/qpgoI9N99qSUGVAT2YPVoswXsiEWtTfuGeSlJdhScbZ3X4vD5MITtdD2ivhgJ5
         OCri0l9wcpQJH5ocUtjZ5Mdbw8P+zrmnJ2jW9g47zE9Un0xoBZbELZfmQM3pUbwoW5Hk
         QYfoDeM2UKlcIgfTIhbwdfRhtGh+0wATUYmx0tjnHiLebUpMjYl8cySoCI7nr94JlyFr
         4qc4WRUkQGnplFloQnD+CMGlosHCl4eJxz4S3mheJqioDBkstd4mN8zOo5DePghB9u3N
         oI9BffCtmo2mmHgwxB79zp1kyEccpVKI5YqsTsn3KMjxsXqLzIjAFftiRQnIMsnC7HIk
         SerQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uPGWZu5ngtNrn+ryPQoiCELQ8McZSJI9oUiugafXI6g=;
        b=cJo/+Durvu5HfyOGjoX+dQEcm32kxdVL01TXv+krfAi15CIbxSeigz5mu4+T4F8G/J
         37QOAIXPFh1delMrXzQcuRyFOtbkv3S/GAw40e3tUOzDiLGy26jiM4+q2U3Dwy87/T9G
         iMKSR4dq+qomXdJSVSPNnGO4+9/c/KGdU6BOEVeHbH+u4JX4auU8+Fi1KfhmSEH9WiKO
         y/FIu9xke0dIPOdYn5M4YZLu/ohZeroX5nZOSXfl6PLwDjCKPnKlOuuJ4kqZQqcyQxrl
         wDZqrMk1FkYJTeW/7Qxj+oXbgquywfnYks8VYBvXxTQjJqgXuQKWMDd8txwcxyOA6s6f
         y4Xw==
X-Gm-Message-State: AGi0PuYySQVByd+Dtr6n4cWGftf/3GxruFeNMaDGmW8r5bCCnZcsn51v
        cwn2Xft56tIYpHsPNMF91aKgwQ==
X-Google-Smtp-Source: APiQypLr+kmTgxc1wi7I6ig12mHv0Z8OIQw228a6dHKFf0g2cnttGL+l6yk85yPVmfezHeqA+NiQag==
X-Received: by 2002:a05:6000:1251:: with SMTP id j17mr3845212wrx.228.1585837688069;
        Thu, 02 Apr 2020 07:28:08 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:4b2:e366:e86f:261a])
        by smtp.gmail.com with ESMTPSA id a7sm7045186wmm.34.2020.04.02.07.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 07:28:07 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     amit.kucheria@verdurent.com,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V2 6/9] thermal: Move get_thermal_instance to the internal header
Date:   Thu,  2 Apr 2020 16:27:44 +0200
Message-Id: <20200402142747.8307-6-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200402142747.8307-1-daniel.lezcano@linaro.org>
References: <20200402142747.8307-1-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The function is not used any place other than the thermal
directory. It does not make sense to export its definition in the
global header as there is no use of it.

Move the definition to the internal header and allow better
self-encapsulation.

Take the opportunity to add the parameter names to make checkpatch
happy and remove the pointless stubs.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.h | 5 +++++
 include/linux/thermal.h        | 6 ------
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 5fb2bd9c7034..c95689586e19 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -74,6 +74,11 @@ struct thermal_trip {
 
 int get_tz_trend(struct thermal_zone_device *tz, int trip);
 
+struct thermal_instance *
+get_thermal_instance(struct thermal_zone_device *tz,
+		     struct thermal_cooling_device *cdev,
+		     int trip);
+
 /*
  * This structure is used to describe the behavior of
  * a certain cooling device on a certain trip point
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 8006ba5de855..47e745c5dfca 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -414,8 +414,6 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
 int thermal_zone_get_slope(struct thermal_zone_device *tz);
 int thermal_zone_get_offset(struct thermal_zone_device *tz);
 
-struct thermal_instance *get_thermal_instance(struct thermal_zone_device *,
-		struct thermal_cooling_device *, int);
 void thermal_cdev_update(struct thermal_cooling_device *);
 void thermal_notify_framework(struct thermal_zone_device *, int);
 #else
@@ -473,10 +471,6 @@ static inline int thermal_zone_get_offset(
 		struct thermal_zone_device *tz)
 { return -ENODEV; }
 
-static inline struct thermal_instance *
-get_thermal_instance(struct thermal_zone_device *tz,
-	struct thermal_cooling_device *cdev, int trip)
-{ return ERR_PTR(-ENODEV); }
 static inline void thermal_cdev_update(struct thermal_cooling_device *cdev)
 { }
 static inline void thermal_notify_framework(struct thermal_zone_device *tz,
-- 
2.17.1

