Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A6632FFF4
	for <lists+linux-pm@lfdr.de>; Sun,  7 Mar 2021 10:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbhCGJpu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Mar 2021 04:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbhCGJpj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Mar 2021 04:45:39 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F2EC06175F
        for <linux-pm@vger.kernel.org>; Sun,  7 Mar 2021 01:45:39 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id l12so8109571wry.2
        for <linux-pm@vger.kernel.org>; Sun, 07 Mar 2021 01:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ahYwzRQmSJrX4v8ks57+n/tweaGVoFJT9QTc8vhlUHg=;
        b=IMCG9brrQt9OXxOqUu9VRJQSaHO249Bi5pskoqucaUgqlSLXajvgNyj8fB5buczLrp
         NVzKgCJwG8EjWaUo5rmBNG9GjT98RRRikYuauNSDXyxBFgM3QAxKN1/BAmCP1yQcKV5y
         HJQbIvC+0sdx6bnuGncA1cURxt62iFmsLIXkdh4WgWW/1u/HpYi8XiZ0Rvjw8fQJMOSi
         OUVmQjNb6FqCNZTMJguKbtukfUWtL7y5ebBdfxq1gZ76G+4qJhEiWGAezl5cY1Us0jPb
         yw/KbYm6ulF7YkGN3s6IFni73fZttTj1qdwcAA0x3zqgCf+2wpvcV6M5ToWnvpEjBFn4
         sUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ahYwzRQmSJrX4v8ks57+n/tweaGVoFJT9QTc8vhlUHg=;
        b=Qhg+A2e/Ho8KIHz8MjoS2O8Lp+sIZ69nxbo5a4hde69SUvBwa36uYjOfFgxC+rl8F8
         x7riJw/FH553vwiLLpXYZJmoGJjLx4N0lcbR4OxC2fagie6N1wbgWm4MOJk5NGEa5f9U
         6Nx2sKcEhgPefCf2/VMF2MewEvtAVKI5HI7ZDqEC/uIAfUVoaSRUuENyAag5TfUBtj9d
         M/WfeBO5ZCzHfuIlsGS+18ztf383Aj+1oIA3l16rLvqcRK8/8R9AAklNrn2zKYigukAe
         ikUNzarZtfgaZlC9vh3pAZk/PsaTJFCmS1YIH7H/QHNxJH1K2McNbmQ1tW/BDbitXPtS
         Acnw==
X-Gm-Message-State: AOAM5300nAhZ3mJr3d9NrVCAJfQCd+yz+b8u1Nw/MurcnTY9GJ6nNJl0
        XLD1M00A4dmfGoGRo9QTVfLmHQ==
X-Google-Smtp-Source: ABdhPJyOGcafMeDaZLkMwnxAp2OBU2WWlF+NGAqbnYf+vb2lNG153g6/PTKMSqI0795e+xjNGw42eQ==
X-Received: by 2002:a5d:5492:: with SMTP id h18mr6433869wrv.340.1615110338036;
        Sun, 07 Mar 2021 01:45:38 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-141-80.adsl.proxad.net. [82.252.141.80])
        by smtp.gmail.com with ESMTPSA id z7sm12790737wrt.70.2021.03.07.01.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 01:45:37 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     cwchoi00@gmail.com
Cc:     lukasz.luba@arm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, steven.price@arm.com,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org (open list:ARM MALI PANFROST DRM DRIVER)
Subject: [PATCH v3 3/4] devfreq/drivers/panfrost: Use devfreq cooling device registration
Date:   Sun,  7 Mar 2021 10:45:17 +0100
Message-Id: <20210307094519.9032-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210307094519.9032-1-daniel.lezcano@linaro.org>
References: <20210307094519.9032-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The devfreq core code is able to register the devfreq device as a
cooling device if the 'is_cooling_device' flag is set in the profile.

Use this flag and remove the cooling device registering code.

Tested on rock960.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 14 +-------------
 drivers/gpu/drm/panfrost/panfrost_devfreq.h |  3 ---
 2 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index 56b3f5935703..4d96edf1bc54 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -3,7 +3,6 @@
 
 #include <linux/clk.h>
 #include <linux/devfreq.h>
-#include <linux/devfreq_cooling.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 
@@ -80,6 +79,7 @@ static struct devfreq_dev_profile panfrost_devfreq_profile = {
 	.polling_ms = 50, /* ~3 frames */
 	.target = panfrost_devfreq_target,
 	.get_dev_status = panfrost_devfreq_get_dev_status,
+	.is_cooling_device = true,
 };
 
 int panfrost_devfreq_init(struct panfrost_device *pfdev)
@@ -90,7 +90,6 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 	struct device *dev = &pfdev->pdev->dev;
 	struct devfreq *devfreq;
 	struct opp_table *opp_table;
-	struct thermal_cooling_device *cooling;
 	struct panfrost_devfreq *pfdevfreq = &pfdev->pfdevfreq;
 
 	opp_table = dev_pm_opp_set_regulators(dev, pfdev->comp->supply_names,
@@ -139,12 +138,6 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 	}
 	pfdevfreq->devfreq = devfreq;
 
-	cooling = devfreq_cooling_em_register(devfreq, NULL);
-	if (IS_ERR(cooling))
-		DRM_DEV_INFO(dev, "Failed to register cooling device\n");
-	else
-		pfdevfreq->cooling = cooling;
-
 	return 0;
 
 err_fini:
@@ -156,11 +149,6 @@ void panfrost_devfreq_fini(struct panfrost_device *pfdev)
 {
 	struct panfrost_devfreq *pfdevfreq = &pfdev->pfdevfreq;
 
-	if (pfdevfreq->cooling) {
-		devfreq_cooling_unregister(pfdevfreq->cooling);
-		pfdevfreq->cooling = NULL;
-	}
-
 	if (pfdevfreq->opp_of_table_added) {
 		dev_pm_opp_of_remove_table(&pfdev->pdev->dev);
 		pfdevfreq->opp_of_table_added = false;
diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.h b/drivers/gpu/drm/panfrost/panfrost_devfreq.h
index db6ea48e21f9..470f5c974703 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.h
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.h
@@ -9,14 +9,11 @@
 
 struct devfreq;
 struct opp_table;
-struct thermal_cooling_device;
-
 struct panfrost_device;
 
 struct panfrost_devfreq {
 	struct devfreq *devfreq;
 	struct opp_table *regulators_opp_table;
-	struct thermal_cooling_device *cooling;
 	bool opp_of_table_added;
 
 	ktime_t busy_time;
-- 
2.17.1

