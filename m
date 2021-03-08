Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89067330F46
	for <lists+linux-pm@lfdr.de>; Mon,  8 Mar 2021 14:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbhCHNdc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Mar 2021 08:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbhCHNdL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Mar 2021 08:33:11 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB28C06175F
        for <linux-pm@vger.kernel.org>; Mon,  8 Mar 2021 05:33:10 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id n22so6059691wmc.2
        for <linux-pm@vger.kernel.org>; Mon, 08 Mar 2021 05:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lZkNk3yYW/8ijhrD082tSx7qBCi8O3cbnVc/FrlwdlU=;
        b=M/AD+I7vDYIzgXiPb3lGfvD8fpS3TPgKXz/BSkCm+skoOnnl/gAtfI1w4j+QJsWeFl
         ePthrlbIuh1GdQT/WEhUZODbL3oaBbUcItYBvmMNxcx2U/xnwJ0ssS9zDlLI6XCdK2iS
         Xtu2+cSnY83dPBhyU02NiIxl7LffDP3pqfxmBmBf0tPEWRca4ZXonoE/eC+gVZ21axiP
         TpxTmVLhB9rbiHstnBOxXTi1J+7o9JtBNnpIyGJINsD14apy1O7HWiBb4ZlzMvCHS9kw
         6Ex1kW75fTtzaOND2JUJYKL84jVK1THIDMTkWHfXgkrmA3swY24Ldfp3hkVO/dOPyYiU
         U7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lZkNk3yYW/8ijhrD082tSx7qBCi8O3cbnVc/FrlwdlU=;
        b=UWI3M8vaO/8lMn3Dz4kyB9E8Cy39IR3LQ6ylkQb6WHXELIIuYVwn7ElS9+q/fGXXVc
         /dNNnhUp5TRRDkwxZAIAO/OLSxH3chm8QBnQ6Ev4N7C/Bt9N3ruW2KzhWbD9APV+Kai5
         RNpSoGEnqdozjQCH2OOz7j/wIBKfP8shmChGZms6erukEroMzi2vKgpB9QTYd26hcoCU
         LcBn4Ww1lXYwbvWZM1hptQdOLd+mfvgss5TgXcfgrGPngb0cNlueDUb1kFHORw6pPv5u
         XJV9y8daz+cNjfKG1spqMQwdgArJeJ9MmASzw4zVFGvXU6a0noxqZjNCxuTxEpf/AmL7
         Z2bw==
X-Gm-Message-State: AOAM532I4+wS5iqNeCGW0aCanpOSp7hSSxsTNqLoq7NCM5JBRyIIGSY6
        BL5ql+Wh9DQd5lPeDdqAUbH6xw==
X-Google-Smtp-Source: ABdhPJwnioQkiEp3+z6Qv31ROIXRxQ4ReAnXp3xN6rJWgiz/US1JMbhImjsoxKyasPz/cuJFA1YWnw==
X-Received: by 2002:a05:600c:210a:: with SMTP id u10mr14186060wml.147.1615210389361;
        Mon, 08 Mar 2021 05:33:09 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-141-80.adsl.proxad.net. [82.252.141.80])
        by smtp.gmail.com with ESMTPSA id m11sm18942665wrz.40.2021.03.08.05.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 05:33:09 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     cwchoi00@gmail.com
Cc:     lukasz.luba@arm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, steven.price@arm.com,
        Qiang Yu <yuq825@gmail.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR LIMA),
        lima@lists.freedesktop.org (moderated list:DRM DRIVERS FOR LIMA)
Subject: [PATCH v6 4/4] PM / devfreq: lima: Use devfreq cooling device registration
Date:   Mon,  8 Mar 2021 14:30:40 +0100
Message-Id: <20210308133041.10516-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210308133041.10516-1-daniel.lezcano@linaro.org>
References: <20210308133041.10516-1-daniel.lezcano@linaro.org>
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

