Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8129D323224
	for <lists+linux-pm@lfdr.de>; Tue, 23 Feb 2021 21:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbhBWUbK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Feb 2021 15:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbhBWUbG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Feb 2021 15:31:06 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0653BC06178A
        for <linux-pm@vger.kernel.org>; Tue, 23 Feb 2021 12:30:25 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id v21so3656082wml.4
        for <linux-pm@vger.kernel.org>; Tue, 23 Feb 2021 12:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yykpmPvGYDmTEhkUF8XP0zuCfszzUH4NGzXYhhdwA9I=;
        b=wQ4+yPNfoBfEttlZnKhap352YVy2WIBwq+kadAzNK8xCdpDe9dKrxlt44D7jfbnOXu
         1TXVonEourvAu3NVkkpnowVh2oWgEY9PDj6RkmXrAyE3rf7e7rjZhrN0adysrWfNcKYs
         nGd+eSNBxgWVWdzARzSVImPz6NpgWA1579/0KdW/JXBdBIejZal1/sZLHcb4TwOe0KD6
         cPVQtIGp4/CJXqIadwJIwTQEczN4FGYVVUOhKqfdhJ4i7VxG1J7N2WnRh/EQ0YVikDA1
         Zp2aJYkF4m/EsdhX+htSxlYeZQTnTIx1caxSv7d15wQuy30iRqyfa8OFdE9MdEDc7WjC
         hhVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yykpmPvGYDmTEhkUF8XP0zuCfszzUH4NGzXYhhdwA9I=;
        b=DMggmmAYFEmtWeNlKsRES82weqAMJ2g+Ux0k8zef016hoEM4pe4RnPi32EPZRmSTES
         eJ5dCfz8I4Ur/dc4izZRhJZ2LXZewmHfIN+vc7wVOZvli6y9xCX8AGCimNrt3VC/k2YI
         RjyhLasPaxICqNNn7PFIVgJwtK3Vpm5LIxqfor5pMAolVV8xAag1urUKBE60NvP64ghR
         QdSSXf3SGIQCxDM509dv0e5J+JtLLr2WYcdWX8hQJL+I02d9nbHvy1LQZxkalAd+odOj
         T7g75Y0C8VnZbvJscqwRCokMSZd7LnnlKUdMlla7ueslOgj6O/5B9lKlE0dwHuDlhJXh
         g9zA==
X-Gm-Message-State: AOAM530yEKQXtEhlvxj7hYTadZfNm5hvwRBIOIxWmhFKEtrGdfLOi5Aa
        eJLl83ImBHxzJid/WdzpbkHD5A==
X-Google-Smtp-Source: ABdhPJxMhFppUV8ZBQGtJDUaq3lxllBWcga9HEUx5gwUgKgHj7ib25xwCj0jYFWfcRaX9DZJTw1M4w==
X-Received: by 2002:a1c:7402:: with SMTP id p2mr452566wmc.43.1614112224419;
        Tue, 23 Feb 2021 12:30:24 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-157-252.adsl.proxad.net. [82.252.157.252])
        by smtp.gmail.com with ESMTPSA id p3sm18288936wro.55.2021.02.23.12.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 12:30:24 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Christian Eggers <ceggers@arri.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        linux-pm@vger.kernel.org (open list:DEVICE FREQUENCY (DEVFREQ)),
        linux-kernel@vger.kernel.org (open list),
        linux-iio@vger.kernel.org (open list:AMS AS73211 DRIVER)
Subject: [PATCH 2/2] units: Use the HZ_PER_KHZ macro
Date:   Tue, 23 Feb 2021 21:30:02 +0100
Message-Id: <20210223203004.7219-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210223203004.7219-1-daniel.lezcano@linaro.org>
References: <20210223203004.7219-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The HZ_PER_KHZ macro definition is duplicated in different subsystems.

The macro now exists in include/linux/units.h, make use of it and
remove all the duplicated ones.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/devfreq/devfreq.c         | 2 +-
 drivers/iio/light/as73211.c       | 3 +--
 drivers/thermal/devfreq_cooling.c | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 6aa10de792b3..4c636c336ace 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -26,6 +26,7 @@
 #include <linux/hrtimer.h>
 #include <linux/of.h>
 #include <linux/pm_qos.h>
+#include <linux/units.h>
 #include "governor.h"
 
 #define CREATE_TRACE_POINTS
@@ -33,7 +34,6 @@
 
 #define IS_SUPPORTED_FLAG(f, name) ((f & DEVFREQ_GOV_FLAG_##name) ? true : false)
 #define IS_SUPPORTED_ATTR(f, name) ((f & DEVFREQ_GOV_ATTR_##name) ? true : false)
-#define HZ_PER_KHZ	1000
 
 static struct class *devfreq_class;
 static struct dentry *devfreq_debugfs;
diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
index 7b32dfaee9b3..3ba2378df3dd 100644
--- a/drivers/iio/light/as73211.c
+++ b/drivers/iio/light/as73211.c
@@ -24,8 +24,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/pm.h>
-
-#define HZ_PER_KHZ 1000
+#include <linux/units.h>
 
 #define AS73211_DRV_NAME "as73211"
 
diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index fed3121ff2a1..fa5b8b0c7604 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -19,10 +19,10 @@
 #include <linux/pm_opp.h>
 #include <linux/pm_qos.h>
 #include <linux/thermal.h>
+#include <linux/units.h>
 
 #include <trace/events/thermal.h>
 
-#define HZ_PER_KHZ		1000
 #define SCALE_ERROR_MITIGATION	100
 
 static DEFINE_IDA(devfreq_ida);
-- 
2.17.1

