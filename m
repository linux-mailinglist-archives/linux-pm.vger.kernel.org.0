Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F53526D4CE
	for <lists+linux-pm@lfdr.de>; Thu, 17 Sep 2020 09:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbgIQHg3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Sep 2020 03:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgIQHg2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Sep 2020 03:36:28 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19500C06174A;
        Thu, 17 Sep 2020 00:36:28 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id k14so853335pgi.9;
        Thu, 17 Sep 2020 00:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LVgjNZrNQHeGVyzoXCZ5eaezteocik+IrAZzCdzJuBs=;
        b=QLoT4iocwJDgRY3jVhIx2DI4949mVscTOINeUfXIxEZ6B5God1X8pv8ghXq9RS/aJa
         oqKXCcAgyLDBPezA0SA2dIdsGYy9EMv6DRb8EhC1h1PMH1PHVlyiTscxmG36D5LJ9Efq
         K+/lgt9VC2Eo9oQc7KdqHaK2GD1N3ZsMkGeWG5TfQTbhMyx2Isgl1aCOrlzfrpGawq9N
         fdx97Ug9bNjbsMuC0bCq5liTXYmQoHovaXNrL0kzAHAOa2rAfzhQLi3Njfu6lW5R9jO3
         t+hcQddrpcL+4PCDb9jQTZ/pkgt1euQmifwy1IRcLi7Oy8joLWCP5VHszTKqkRj3DVby
         f3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LVgjNZrNQHeGVyzoXCZ5eaezteocik+IrAZzCdzJuBs=;
        b=AXhZ2qlT7uRFuDulE0HOXgryTP+7GSdxbBGhCsY1fbhixLqyVbyG4pIdIjDmoRzEaP
         AKp4r6HYBs/H1fnMTARE7M9TkVudB7qc7fXqJLA6f7Eb53Nuh5YKavXtoKhn7dnFPyft
         BUkgBlWcrqSoftlR+P9TMhFs9HQPyFnb0IW5Z9NpEWpAN5tCVkeRnV1WBk82uFVRqfyr
         46XQWZQmXEdyw5aItmFBrqowaMM5ls11ZjjZAc2n4MYDCDIoDoj7EIB35TRAc2VwWdna
         YPqNrCAcidvUqA9Gy0HH63SPNeOD3itTmkw0xcdp7Rghgs3A8o46jYkykOe+qYOzb29q
         3a1g==
X-Gm-Message-State: AOAM530Mg8Qv06nQWqJDR+boJt28Q6l3F93/xDCP24ElRsOU1O4Y0rmc
        cQwaS7jTeGiyM5JAmv1GINk=
X-Google-Smtp-Source: ABdhPJx6RK7QekcSJhCtPgsq4WyKnAmNS0Vif0ivK8GqYif0kzjdgiRloWKMja0iM+RMIh7hEWszHg==
X-Received: by 2002:a63:f342:: with SMTP id t2mr21786819pgj.313.1600328187689;
        Thu, 17 Sep 2020 00:36:27 -0700 (PDT)
Received: from localhost.localdomain ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id 22sm5491834pfw.17.2020.09.17.00.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 00:36:27 -0700 (PDT)
From:   zhuguangqing83@gmail.com
To:     amit.kachhap@gmail.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, javi.merino@kernel.org,
        rui.zhang@intel.com, amitk@kernel.org, rafael.j.wysocki@intel.com,
        zhuguangqing@xiaomi.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] thermal/idle_inject: Fix comment of idle_duration_us and name of latency_ns
Date:   Thu, 17 Sep 2020 15:35:53 +0800
Message-Id: <20200917073553.898-1-zhuguangqing83@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: zhuguangqing <zhuguangqing@xiaomi.com>

The comment of idle_duration_us and the name of latency_ns can be misleading,
so fix them.

Signed-off-by: zhuguangqing <zhuguangqing@xiaomi.com>
---
 drivers/thermal/cpuidle_cooling.c | 2 +-
 include/linux/idle_inject.h       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/cpuidle_cooling.c b/drivers/thermal/cpuidle_cooling.c
index 78e3e8238116..7ecab4b16b29 100644
--- a/drivers/thermal/cpuidle_cooling.c
+++ b/drivers/thermal/cpuidle_cooling.c
@@ -30,7 +30,7 @@ static DEFINE_IDA(cpuidle_ida);
 
 /**
  * cpuidle_cooling_runtime - Running time computation
- * @idle_duration_us: the idle cooling device
+ * @idle_duration_us: CPU idle time to inject in microseconds
  * @state: a percentile based number
  *
  * The running duration is computed from the idle injection duration
diff --git a/include/linux/idle_inject.h b/include/linux/idle_inject.h
index 91a8612b8bf9..fb88e23a99d3 100644
--- a/include/linux/idle_inject.h
+++ b/include/linux/idle_inject.h
@@ -28,6 +28,6 @@ void idle_inject_get_duration(struct idle_inject_device *ii_dev,
 				 unsigned int *idle_duration_us);
 
 void idle_inject_set_latency(struct idle_inject_device *ii_dev,
-			     unsigned int latency_ns);
+			     unsigned int latency_us);
 
 #endif /* __IDLE_INJECT_H__ */
-- 
2.17.1

