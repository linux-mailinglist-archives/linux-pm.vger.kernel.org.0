Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45C9632FFF7
	for <lists+linux-pm@lfdr.de>; Sun,  7 Mar 2021 10:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbhCGJpv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Mar 2021 04:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbhCGJpl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Mar 2021 04:45:41 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDBAC06174A
        for <linux-pm@vger.kernel.org>; Sun,  7 Mar 2021 01:45:40 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id b18so8115094wrn.6
        for <linux-pm@vger.kernel.org>; Sun, 07 Mar 2021 01:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lZkNk3yYW/8ijhrD082tSx7qBCi8O3cbnVc/FrlwdlU=;
        b=rwqG0rGjDKgDJMDgyrPuL6fMMJ8FUmrimYfMpceWe9MkQbKAflo6IkH5SMQ0xZy9XR
         opslnX4VVS00yl+S+cZsjXsVGexmEyL/1aA+2mQLXU/Hx63HARlTApMASp9/RIjQON8i
         5sbeykvJEJzSN1AcprCRE+EgUGP90baUMv+1YStLGuOU7ffiFtNElY+IKz13LxrRnlgp
         U1MW5w7tJbgVHjKiv5xn25VEvnNCzvjsyzZ77TsZy3ox3BgXwJt4C6mCUT+NjK6I5B5n
         7bf3hQMhcHKcA1rS+DUGAwqAdw+cwpt2L6p1hDgO7x2nR3dMJvZM8DeCAD8gLhyASedW
         tu9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lZkNk3yYW/8ijhrD082tSx7qBCi8O3cbnVc/FrlwdlU=;
        b=BrG4ZkJDiDrpFLufZz642rdOYFxM0yemWxP4YKltpP4EnOR5bzW9bQqT0hKHfijhsE
         GhQ68WL87xF42tYIzKa3MdH+YuHr743nns3q8N+aLBdQTEJRJ3iFF0lDrhqhkG4QrY8r
         hAG4pZ2GfFk/TplrxUq22tVCH30xUY4Y30UW7JJAJg2c6wERtJdQtg3tZMBIlcRc1kfZ
         50M+0RiS7YJNXtrDFexKqy12ZNGd0vySv5fb7ih4jhH3SLwZ+V6P3TO1ex26m9Gwa3q4
         p9rbcEpnWSzo7oKRKnEb/Rid0u/epkfkBl9n21h2k42TYkCQjeoUMKnbK/xsQwoohbwM
         tWdg==
X-Gm-Message-State: AOAM533eYIkDBmqmxTEc+nuy5Y+z4psVQzDgdx6zbQj8uyVKQddQ+M8c
        fYBvrwWcyi5PvfhXWrtyXqzUEA==
X-Google-Smtp-Source: ABdhPJw99kGB8EMsZs3YEBktotNiQ5Quc/vbCuOVi/jHeofv++Ue1b0c6UMEtbJqQj4ihMOuVRQoVw==
X-Received: by 2002:a5d:5043:: with SMTP id h3mr17350887wrt.120.1615110339583;
        Sun, 07 Mar 2021 01:45:39 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-141-80.adsl.proxad.net. [82.252.141.80])
        by smtp.gmail.com with ESMTPSA id z7sm12790737wrt.70.2021.03.07.01.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 01:45:39 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     cwchoi00@gmail.com
Cc:     lukasz.luba@arm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, steven.price@arm.com,
        Qiang Yu <yuq825@gmail.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR LIMA),
        lima@lists.freedesktop.org (moderated list:DRM DRIVERS FOR LIMA)
Subject: [PATCH v3 4/4] devfreq/drivers/lima: Use devfreq cooling device registration
Date:   Sun,  7 Mar 2021 10:45:18 +0100
Message-Id: <20210307094519.9032-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210307094519.9032-1-daniel.lezcano@linaro.org>
References: <20210307094519.9032-1-daniel.lezcano@linaro.org>
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

