Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4538F19C418
	for <lists+linux-pm@lfdr.de>; Thu,  2 Apr 2020 16:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387678AbgDBO2g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Apr 2020 10:28:36 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42189 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732450AbgDBO2G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Apr 2020 10:28:06 -0400
Received: by mail-wr1-f65.google.com with SMTP id h15so4439687wrx.9
        for <linux-pm@vger.kernel.org>; Thu, 02 Apr 2020 07:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NLgc/Vk2F+SuJNrnjX/emMROOJG4WMJyyJx9N+UIrh4=;
        b=GxstHCjIcfORLMIREXB1QHdgE3pGnEEDm4SN6Zi8TGTVrQ5CYV/5BkwWKgiYvoAU8w
         oPkzh+OZt30LJizbeh1vI6cCf1I5mvjwyVIDr2N1BVpnOFOzpHUynqTrHNvge3trdt8s
         z+DrEt8f9zRs1wAUruYW91YM0tPhnlvrjuboMvmacQlYLa/a3dLsW8vFykPkmsm3UwfI
         SGb4Xjviydgq9PxNH54skVVxPL+mRS/d/V8JvkHcg80c/IvXF5RasnfNeO+aQtxbP48n
         RKDLMAc+IYNII0UuAtkrPLH0Eh7linMx0P+ErJViaEaTzwdgeHH9yDe+1Mm3xRvwzRyg
         uWUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NLgc/Vk2F+SuJNrnjX/emMROOJG4WMJyyJx9N+UIrh4=;
        b=WZ7BUOJdsr2TjlUmGBsF1+SW3HPUL+e0bZrm6NnxY4eQ+PrCKsBqlC63x7Ql39TetV
         4uCffNSCyNI2OeyMxRnFUgeI1sUx0J0eKR3o8I/CvOHq2UaCr4RDGkaiiN8g45XE5cNr
         x22aNF3AdnlcwLIpWYt2qiIN0AWcQdGzENLXY/MpwDru5aZ/bk2o5DszARdYDJl/L0Nt
         yO9g5L5KR0scF7fdxkagDR+ZNHOo+ge5X1cjvS3/lDrdMqsRNhzWJxQhV9mICpn2hgf+
         WbzLYQVuhhWVNI3vDBJ8ZAP485cxucL+qaliVrudUYTdoVaCGxtMuI4V6IoMLJZkvwcn
         Ue0w==
X-Gm-Message-State: AGi0PuaV9MszayOj6otJmJlc/raNoRfHS1sErpin6vdRkYGu9RnTRJUF
        MY6LVWn09tFOU3IUAX3SHPVkjg==
X-Google-Smtp-Source: APiQypIcclPEKfDgcgG4EZu6WTNMliilqfI+B3Z3wV1gY2jZDEbMOaBz3Lm35cEFBrnGJ5M003Pyeg==
X-Received: by 2002:adf:a21a:: with SMTP id p26mr3843764wra.102.1585837682934;
        Thu, 02 Apr 2020 07:28:02 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:4b2:e366:e86f:261a])
        by smtp.gmail.com with ESMTPSA id a7sm7045186wmm.34.2020.04.02.07.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 07:28:02 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     amit.kucheria@verdurent.com,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V2 2/9] thermal: Move struct thermal_attr to the private header
Date:   Thu,  2 Apr 2020 16:27:40 +0200
Message-Id: <20200402142747.8307-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200402142747.8307-1-daniel.lezcano@linaro.org>
References: <20200402142747.8307-1-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The structure belongs to the thermal core internals but it is exported
in the include/linux/thermal.h

For better self-encapsulation and less impact for the compilation if a
change is made on it. Move the structure in the thermal core internal
header file.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.h | 5 +++++
 include/linux/thermal.h        | 6 +-----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 828305508556..5d08ad60d9df 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -41,6 +41,11 @@ extern struct thermal_governor *__governor_thermal_table_end[];
 	     __governor < __governor_thermal_table_end;	\
 	     __governor++)
 
+struct thermal_attr {
+	struct device_attribute attr;
+	char name[THERMAL_NAME_LENGTH];
+};
+
 /*
  * This structure is used to describe the behavior of
  * a certain cooling device on a certain trip point
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 71cff87dcb46..5aa80fb2fb61 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -35,6 +35,7 @@
 struct thermal_zone_device;
 struct thermal_cooling_device;
 struct thermal_instance;
+struct thermal_attr;
 
 enum thermal_device_mode {
 	THERMAL_DEVICE_DISABLED = 0,
@@ -119,11 +120,6 @@ struct thermal_cooling_device {
 	struct list_head node;
 };
 
-struct thermal_attr {
-	struct device_attribute attr;
-	char name[THERMAL_NAME_LENGTH];
-};
-
 /**
  * struct thermal_zone_device - structure for a thermal zone
  * @id:		unique id number for each thermal zone
-- 
2.17.1

