Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 947AD32F098
	for <lists+linux-pm@lfdr.de>; Fri,  5 Mar 2021 18:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhCEREH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Mar 2021 12:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbhCERDy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Mar 2021 12:03:54 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C657CC061574
        for <linux-pm@vger.kernel.org>; Fri,  5 Mar 2021 09:03:53 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id m1so2082011wml.2
        for <linux-pm@vger.kernel.org>; Fri, 05 Mar 2021 09:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lZkNk3yYW/8ijhrD082tSx7qBCi8O3cbnVc/FrlwdlU=;
        b=TgZURChUGXUbgDO2bV0UsU+s1j/d5KKVOwy39jkcxWe/38xJxE8XgQo917QUm+QWZx
         2rsQ+GfXyOcIsol9aos7nC+fVNMkUvQwzoG5Zz6McgO7oengrXe5q+vHiuUp+foGg+49
         Sda8/VQh1uaa3anhia/BbnTRkLROiFiCh+yjAMM2y4Kt5Z0Vz/E9vgcbBTKTsFBN18Z3
         us1vgkBE5QhZ3hUt66DqUWgUzb23W/10IX7tmRGQrOgYj/m6dnbsJfywsit+pgpB+JW1
         koIJk3T02fYaDHy/Xf2D/JPPaD7P24OeeE/UgmWLHqJ7eLs/J6XJUXjBQPjrNY+FA4nl
         3YoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lZkNk3yYW/8ijhrD082tSx7qBCi8O3cbnVc/FrlwdlU=;
        b=gHeZbZhV5lwSKCZmBNl67mpJ8pEehFZM8jAKGTu7I8rM2NmBETTwmB+gn5yzm6GVvt
         bq9gKH5HbmZXqVRtTAhu03b3I0IoPKlKWEzYE8RJDPkXEQgaiB7bG5FMr66n/El91TW3
         uCgOwHUUp4thpIXdEskSNNUKS5JAJfQ7AYKhsH0t0/QN2KO4x2iWFTeuv6+ZOijd+tku
         Om/luhN0zXiPAPZyfPaWa7GTOBrK/rcq7In5j8GHrXggCT4ZB78+HOYyEkMb8eb319zs
         EmF7JXE1AfrqQUMtF5vA6z5vri/y16uUKAOT3EcH+FydWwv9JwUMV9F1GGWazGuy/aPj
         XfIQ==
X-Gm-Message-State: AOAM530zPWx3MuOgddQA/csgQL5aBowdJxBzLT8inTk9eG5BomL245UD
        TOKJUF/8a/Y3UExldZREUAfxW67ByS9llA==
X-Google-Smtp-Source: ABdhPJweZmT9/DaMkRyVEAelVHMaLzH8C50RUNPjNl2+9ptTTzFrB7lyNizfKFE7Fyek/6A+5FD0Vg==
X-Received: by 2002:a05:600c:35c1:: with SMTP id r1mr9670239wmq.60.1614963832386;
        Fri, 05 Mar 2021 09:03:52 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-141-80.adsl.proxad.net. [82.252.141.80])
        by smtp.gmail.com with ESMTPSA id p17sm4760934wmq.47.2021.03.05.09.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 09:03:51 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     cwchoi00@gmail.com
Cc:     lukasz.luba@arm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, steven.price@arm.com,
        Qiang Yu <yuq825@gmail.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR LIMA),
        lima@lists.freedesktop.org (moderated list:DRM DRIVERS FOR LIMA)
Subject: [PATCH v2 2/4] devfreq/drivers/lima: Use devfreq cooling device registration
Date:   Fri,  5 Mar 2021 18:03:35 +0100
Message-Id: <20210305170338.13647-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210305170338.13647-1-daniel.lezcano@linaro.org>
References: <20210305170338.13647-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The devfreq core code is able to register the devfreq device as a
cooling device if the 'is_cooling_device' flag is set in the profile.

Use this flag and remove the cooling device registering code.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/gpu/drm/lima/lima_devfreq.c | 14 +-------------
 drivers/gpu/drm/lima/lima_devfreq.h |  2 --
 2 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/lima/lima_devfreq.c b/drivers/gpu/drm/lima/lima_devfreq.c
index 5686ad4aaf7c..86aea1bdc4f4 100644
--- a/drivers/gpu/drm/lima/lima_devfreq.c
+++ b/drivers/gpu/drm/lima/lima_devfreq.c
@@ -7,7 +7,6 @@
  */
 #include <linux/clk.h>
 #include <linux/devfreq.h>
-#include <linux/devfreq_cooling.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
@@ -84,17 +83,13 @@ static struct devfreq_dev_profile lima_devfreq_profile = {
 	.polling_ms = 50, /* ~3 frames */
 	.target = lima_devfreq_target,
 	.get_dev_status = lima_devfreq_get_dev_status,
+	.is_cooling_device = true,
 };
 
 void lima_devfreq_fini(struct lima_device *ldev)
 {
 	struct lima_devfreq *devfreq = &ldev->devfreq;
 
-	if (devfreq->cooling) {
-		devfreq_cooling_unregister(devfreq->cooling);
-		devfreq->cooling = NULL;
-	}
-
 	if (devfreq->devfreq) {
 		devm_devfreq_remove_device(ldev->dev, devfreq->devfreq);
 		devfreq->devfreq = NULL;
@@ -110,7 +105,6 @@ void lima_devfreq_fini(struct lima_device *ldev)
 
 int lima_devfreq_init(struct lima_device *ldev)
 {
-	struct thermal_cooling_device *cooling;
 	struct device *dev = ldev->dev;
 	struct opp_table *opp_table;
 	struct devfreq *devfreq;
@@ -173,12 +167,6 @@ int lima_devfreq_init(struct lima_device *ldev)
 
 	ldevfreq->devfreq = devfreq;
 
-	cooling = of_devfreq_cooling_register(dev->of_node, devfreq);
-	if (IS_ERR(cooling))
-		dev_info(dev, "Failed to register cooling device\n");
-	else
-		ldevfreq->cooling = cooling;
-
 	return 0;
 
 err_fini:
diff --git a/drivers/gpu/drm/lima/lima_devfreq.h b/drivers/gpu/drm/lima/lima_devfreq.h
index 2d9b3008ce77..c43a2069e5d3 100644
--- a/drivers/gpu/drm/lima/lima_devfreq.h
+++ b/drivers/gpu/drm/lima/lima_devfreq.h
@@ -9,7 +9,6 @@
 
 struct devfreq;
 struct opp_table;
-struct thermal_cooling_device;
 
 struct lima_device;
 
@@ -17,7 +16,6 @@ struct lima_devfreq {
 	struct devfreq *devfreq;
 	struct opp_table *clkname_opp_table;
 	struct opp_table *regulators_opp_table;
-	struct thermal_cooling_device *cooling;
 
 	ktime_t busy_time;
 	ktime_t idle_time;
-- 
2.17.1

