Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF121D5010
	for <lists+linux-pm@lfdr.de>; Fri, 15 May 2020 16:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgEOOLG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 May 2020 10:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726226AbgEOOLF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 May 2020 10:11:05 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EBCC05BD09
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2020 07:11:05 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id z72so2838790wmc.2
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2020 07:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=A4+UkWcvLP2WT8CuakkXaohSADBdrjeeNAnbolDDe08=;
        b=NUjZzrQH7/8UPP7L24eoPhEPg6G8tZ2NntXz0lwP2s0+zSuswWa26LQVNl+OrxXnJo
         yudmQee/QQ6NO3s4BTkl/KR8DMF4HZ27qvEvCKr3mSJPwhznPRytkZk6IkZDqL+EJl6m
         cWqf5WDuVjEl6Jm4k1+seLdLsemn5kRPoBbpaTUWwot8wcWQ69n2b8K9k4LUsBKMziay
         4OZ7V9i574hixJhPtRi+84gxc/mEDA1aCqdpQxSS8LjVP9SoUAiHNIdCYLbi6hveqxgN
         C08vZZmrigL+fS+teNs/xXJxLoPmRO6GVbb9r/WY377bW5tJ+29fL0cS3gbrP4PcgPFh
         C5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=A4+UkWcvLP2WT8CuakkXaohSADBdrjeeNAnbolDDe08=;
        b=a3vr1RiuTF2knW9kCuCu6GQUaoaOqI2t0VWZ4eNN2fOS02b1H8kUm+N3kdCxDSWE50
         qcliau/lFpKPcmXx0yytAbyf8IIp0Dh8SnB59mDu1coDStQaeR7iEh1DCKYuEe7Dsnj3
         D2RqDVkmBdt9fbMdzVe5Xc7XydsGFZ+2uH0F0msIr4NZJogx6OQLATAYVps/uubfQsWv
         Lafu/gtRnvwq9/rnCDQIK6qq1vwsTlacXJluuZvgo9EEfjY0lldmU0+QsMvve018Jwx8
         DQHLhz9s+2fdpvhQ1BwQfyiTPUSUCLZfowPahO94OA5ZjLApkttwRx8JcG8l3kbHnS7w
         43Fg==
X-Gm-Message-State: AOAM532MURHfUjj3XAfVAbHTnNIawVrtHvPdokLuY4L0Zu3iW2d+defV
        v9BkxXS4D7DRKPq05Cz/4gXyxw==
X-Google-Smtp-Source: ABdhPJzcMZfZ6NXde6nZJ9Qrvuofbkk+4OFACM9BWBFB//xLPloqviY3hVReBzWCB1pZLgBNCIYCSw==
X-Received: by 2002:a7b:c413:: with SMTP id k19mr4243265wmi.124.1589551863052;
        Fri, 15 May 2020 07:11:03 -0700 (PDT)
Received: from localhost.localdomain (lns-bzn-59-82-252-135-148.adsl.proxad.net. [82.252.135.148])
        by smtp.gmail.com with ESMTPSA id d6sm4432438wra.63.2020.05.15.07.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 07:11:02 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rui.zhang@intel.com
Cc:     amit.kucheria@verdurent.com, srinivas.pandruvada@linux.intel.com,
        arnd@arndb.de, rkumbako@codeaurora.org, ilina@codeaurora.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/4] thermal: core: Add helpers to browse the cdev, tz and governor list
Date:   Fri, 15 May 2020 16:10:30 +0200
Message-Id: <20200515141034.19154-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The cdev, tz and governor list, as well as their respective locks are
statically defined in the thermal_core.c file.

In order to give a sane access to these list, like browsing all the
thermal zones or all the cooling devices, let's define a set of
helpers where we pass a callback as a parameter to be called for each
thermal entity.

We keep the self-encapsulation and ensure the locks are correctly
taken when looking at the list.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 51 ++++++++++++++++++++++++++++++++++
 drivers/thermal/thermal_core.h |  9 ++++++
 2 files changed, 60 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index a6b8c0240656..54208b6deb42 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -638,6 +638,57 @@ void thermal_zone_device_rebind_exception(struct thermal_zone_device *tz,
 	mutex_unlock(&thermal_list_lock);
 }
 
+int for_each_thermal_governor(int (*cb)(struct thermal_governor *, void *),
+			      void *data)
+{
+	struct thermal_governor *gov;
+	int ret = 0;
+
+	mutex_lock(&thermal_governor_lock);
+	list_for_each_entry(gov, &thermal_governor_list, governor_list) {
+		ret = cb(gov, data);
+		if (ret)
+			break;
+	}
+	mutex_unlock(&thermal_governor_lock);
+
+	return ret;
+}
+
+int for_each_thermal_cooling_device(int (*cb)(struct thermal_cooling_device *,
+					      void *), void *data)
+{
+	struct thermal_cooling_device *cdev;
+	int ret = 0;
+
+	mutex_lock(&thermal_list_lock);
+	list_for_each_entry(cdev, &thermal_cdev_list, node) {
+		ret = cb(cdev, data);
+		if (ret)
+			break;
+	}
+	mutex_unlock(&thermal_list_lock);
+
+	return ret;
+}
+
+int for_each_thermal_zone(int (*cb)(struct thermal_zone_device *, void *),
+			  void *data)
+{
+	struct thermal_zone_device *tz;
+	int ret = 0;
+
+	mutex_lock(&thermal_list_lock);
+	list_for_each_entry(tz, &thermal_tz_list, node) {
+		ret = cb(tz, data);
+		if (ret)
+			break;
+	}
+	mutex_unlock(&thermal_list_lock);
+
+	return ret;
+}
+
 void thermal_zone_device_unbind_exception(struct thermal_zone_device *tz,
 					  const char *cdev_type, size_t size)
 {
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 4e271016b7a9..bb8f8aee79eb 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -41,6 +41,15 @@ extern struct thermal_governor *__governor_thermal_table_end[];
 	     __governor < __governor_thermal_table_end;	\
 	     __governor++)
 
+int for_each_thermal_zone(int (*cb)(struct thermal_zone_device *, void *),
+			  void *);
+
+int for_each_thermal_cooling_device(int (*cb)(struct thermal_cooling_device *,
+					      void *), void *);
+
+int for_each_thermal_governor(int (*cb)(struct thermal_governor *, void *),
+			      void *thermal_governor);
+
 struct thermal_attr {
 	struct device_attribute attr;
 	char name[THERMAL_NAME_LENGTH];
-- 
2.17.1

