Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92399330408
	for <lists+linux-pm@lfdr.de>; Sun,  7 Mar 2021 19:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbhCGSwK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Mar 2021 13:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbhCGSvr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Mar 2021 13:51:47 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3082DC06174A
        for <linux-pm@vger.kernel.org>; Sun,  7 Mar 2021 10:51:47 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id n22so4747164wmc.2
        for <linux-pm@vger.kernel.org>; Sun, 07 Mar 2021 10:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lZkNk3yYW/8ijhrD082tSx7qBCi8O3cbnVc/FrlwdlU=;
        b=dUczLlRtPi6GFZOr508UaxiYaO0yZ4r9MUeEXfzW3hreTYSlxeo1+b7ngfUiVx42v6
         GFKFds08mpubQmKkfNrIFhnwnMU+/xogJRhp1B19uV1P6LOqUAAOfWkvoGv8Wz/q+OLP
         JwMxtmbLyohe859codg0DWPyCOr/gRSNB64qgc+aTVO05qc9rou/DQ/b6ARY5KUWrcnr
         WGCnm4ytZmzKra0Al/uAh6vPzKqYdEBU8Zj8WuYLmRxkqax60a9mk1Hs4synIWVlGwoI
         9QJZtwtk9OEssbJgPS9X4vg3dqHFn0xOtyqFa3UnVvaupKU0XBBjEswFDIzNLq2k1Kf7
         Wtqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lZkNk3yYW/8ijhrD082tSx7qBCi8O3cbnVc/FrlwdlU=;
        b=gnuEgaZNN19l/ugfTfu/fw0tytKBBUF2lrGmInMU3AHchx1x6vZ9zOdjwKZqy7YhWw
         vo/tiHWEITcHmTvUyyqIF3SdIDXET/Y9rAUeJRmqP8zVT93/tlzeut/GknKuazWnztW0
         EJ3ar7QoUrom2wdXHMSALJ7WuFWg0DBOMfMAiARj0MKA5c/NQkD7UrDl8Rl2v+SWN5zv
         lsUBtJ1oyFInueKKBh6zLaaMxGcJD1XAVYsAH9QytqRj4hQQYgy2X4mxUe7i3GB8EaJn
         DY+qD+WTd6oBFyl9Qwj7YPjEM0laiDAEjaGWjbHpqylqZfY9V+bCmP7Pxkz4gaIymGVT
         ORrg==
X-Gm-Message-State: AOAM531yD1fMzAty/dWBoIIdrV6ub+MF7EUKYg7rjaj14dUhcLl4PNDf
        ZR6tWtYinHqtMcogtJwGPsWYtQ==
X-Google-Smtp-Source: ABdhPJw7zRqDTtln8kCNCqMqvZNX1pG3+4zNqJfXoAASdGT4ByKjiUbvEBcid+QAZi1YYWqtYSP3OA==
X-Received: by 2002:a05:600c:2247:: with SMTP id a7mr19090730wmm.131.1615143105859;
        Sun, 07 Mar 2021 10:51:45 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-141-80.adsl.proxad.net. [82.252.141.80])
        by smtp.gmail.com with ESMTPSA id v5sm14842965wmh.2.2021.03.07.10.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 10:51:45 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     cwchoi00@gmail.com
Cc:     lukasz.luba@arm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, steven.price@arm.com,
        Qiang Yu <yuq825@gmail.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR LIMA),
        lima@lists.freedesktop.org (moderated list:DRM DRIVERS FOR LIMA)
Subject: [PATCH v4 4/4] devfreq/drivers/lima: Use devfreq cooling device registration
Date:   Sun,  7 Mar 2021 19:51:37 +0100
Message-Id: <20210307185137.24925-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210307185137.24925-1-daniel.lezcano@linaro.org>
References: <20210307185137.24925-1-daniel.lezcano@linaro.org>
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

