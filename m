Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF751D5013
	for <lists+linux-pm@lfdr.de>; Fri, 15 May 2020 16:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgEOOLI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 May 2020 10:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726140AbgEOOLH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 May 2020 10:11:07 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F65EC061A0C
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2020 07:11:07 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id l11so3785922wru.0
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2020 07:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RJ6XAk7W2stQGCvpULKUDc0FYaIKu2TAbXfun2Pkr3g=;
        b=SLCIRIPgLr81qFn7rCPeQwMQ8ryyFGrY2/HbUJTmnKVab0yEXJjD6YYun/KgxmHLfa
         iTZY5RxWXu/lKag4MbSRKfr8KHpZgny0vACzyjMaRXlXwR2wx9hlK4TzIIzI6CQwPW0t
         C9/T+hIi3zQqpW5KDpNm7YM4k+uUyjHI1g1MxgvxDHCqXH7kJBfQrcQtudhrXouZgFkO
         DZ5si5zjMelJhMBgWbqELsztELd6IYd9ohBo2+zZegUH4RlrUxeFWKUro2gRMbFKV/lB
         sM8OF1pMLTo9sOW/dyaYJu9vhScBU+jDkZ4dfwLIwSxGu3a3RMLIwI0Sw8pqCSm7Ox2A
         aDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RJ6XAk7W2stQGCvpULKUDc0FYaIKu2TAbXfun2Pkr3g=;
        b=GvQX4y12jLP8pcd6/Bfq5nKsY78vbATPU8t+GtjZVknUEY7Hcx8UZvIguIn6O9Mm6J
         DxYeyIH3s9XXrJf9xjvxtGdf3Dh5dQ0JsOi0GUCQ/MW2ZAZMLtX3f1jW2q4CkYtlEr3J
         a5hgeuwa2J3fpSVRI9V3+jqgvP1VdI2vX8DllvyCZ3Ojys7D15pJqhnvEailIqFf3npF
         ocp57Q0kADNHgvfrN0t+SHeFU5qNnNBf6Ukquzs0IZOJBEpPj6pl+aChEMj08gdGQfRZ
         wA+RDzZU3Ue50vV5BSZl8lOQjE0MGn1cmw+Fvikkv6es4q4iFGVLbem9x6vJHKdggAPI
         jMoQ==
X-Gm-Message-State: AOAM532X6Dms4Cjtvvdf2gHHGsF8P5y1SKNzzocujGtMMi0VEIi0KeKT
        nFx70UQxNivLfMxauoTgDdwDYg==
X-Google-Smtp-Source: ABdhPJz9R9uK9GeGOjTdsp9/H/Wl11yJ61q+5QqH0Rh3c29OJGvxW6i6tnnxTCFR1Tjkrlpa3xXmuw==
X-Received: by 2002:a5d:438c:: with SMTP id i12mr4512075wrq.14.1589551865810;
        Fri, 15 May 2020 07:11:05 -0700 (PDT)
Received: from localhost.localdomain (lns-bzn-59-82-252-135-148.adsl.proxad.net. [82.252.135.148])
        by smtp.gmail.com with ESMTPSA id d6sm4432438wra.63.2020.05.15.07.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 07:11:05 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rui.zhang@intel.com
Cc:     amit.kucheria@verdurent.com, srinivas.pandruvada@linux.intel.com,
        arnd@arndb.de, rkumbako@codeaurora.org, ilina@codeaurora.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/4] thermal: core: Get thermal zone by id
Date:   Fri, 15 May 2020 16:10:31 +0200
Message-Id: <20200515141034.19154-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200515141034.19154-1-daniel.lezcano@linaro.org>
References: <20200515141034.19154-1-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The next patch will introduce the generic netlink protocol to handle
events, sampling and command from the thermal framework. In order to
deal with the thermal zone, it uses its unique identifier to
characterize it in the message. Passing an integer is more efficient
than passing an entire string.

This change provides a function returning back a thermal zone pointer
corresponding to the identifier passed as parameter.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 14 ++++++++++++++
 drivers/thermal/thermal_core.h |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 54208b6deb42..6f7a1a7ffd2a 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -689,6 +689,20 @@ int for_each_thermal_zone(int (*cb)(struct thermal_zone_device *, void *),
 	return ret;
 }
 
+struct thermal_zone_device *thermal_zone_get_by_id(int id)
+{
+	struct thermal_zone_device *tz = NULL;
+
+	mutex_lock(&thermal_list_lock);
+	list_for_each_entry(tz, &thermal_tz_list, node) {
+		if (tz->id == id)
+			break;
+	}
+	mutex_unlock(&thermal_list_lock);
+
+	return tz;
+}
+
 void thermal_zone_device_unbind_exception(struct thermal_zone_device *tz,
 					  const char *cdev_type, size_t size)
 {
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index bb8f8aee79eb..7e8f45db6bbf 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -50,6 +50,8 @@ int for_each_thermal_cooling_device(int (*cb)(struct thermal_cooling_device *,
 int for_each_thermal_governor(int (*cb)(struct thermal_governor *, void *),
 			      void *thermal_governor);
 
+struct thermal_zone_device *thermal_zone_get_by_id(int id);
+
 struct thermal_attr {
 	struct device_attribute attr;
 	char name[THERMAL_NAME_LENGTH];
-- 
2.17.1

