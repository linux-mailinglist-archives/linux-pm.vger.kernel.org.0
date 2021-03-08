Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1135330A1F
	for <lists+linux-pm@lfdr.de>; Mon,  8 Mar 2021 10:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbhCHJQ6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Mar 2021 04:16:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhCHJQ5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Mar 2021 04:16:57 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7474C06174A
        for <linux-pm@vger.kernel.org>; Mon,  8 Mar 2021 01:16:56 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id l11so7207242wrp.7
        for <linux-pm@vger.kernel.org>; Mon, 08 Mar 2021 01:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ahYwzRQmSJrX4v8ks57+n/tweaGVoFJT9QTc8vhlUHg=;
        b=y5axN+kyadsACGS9H0rIrwW2rocmwOJ8uPJYHgOeRJvnJKYfpYihv+L4gMntc6PGuG
         gZXlw67BU0r28fxfQFrGXjXQ/2dYuK9fF7Fgij3RACAVLYNEKjaSeaxs0jEpzIfMC42g
         uLMCCHKTrllVRFW+l2BbDPBet0E3UYCttsJaBHZCZaXLQ8HhN7GtXZZnqlJiOrVmi5NF
         ZSKjCDAd3Ha4LiVasrST5LhE3eY1fNfuWNjBDUpNrmhaXIdK+y4IxLf4RiKcN06gkbWW
         ATbU8HW/+gq7o0snmBZjuEBPtHGbUlBCin6C5lbv8SyFfIKAsHQrbASK8FyLfglge2oO
         CsgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ahYwzRQmSJrX4v8ks57+n/tweaGVoFJT9QTc8vhlUHg=;
        b=KOiRE05aizYEwk4Ckk3/EsHAWHrsw+id7p4SMLPdA2lMuxlyAxVHHX0+rI22JGhLEA
         kOc5SA2hamP5sy/YXjICmEwakMwBx2ObIXvnbq20xlc/QetFq37NPdKVfEZHQpU0hHkx
         B8niCACaMBMyQDDc0MQ80INxz3A7Mi7WoFAwkWd47TrLTvD9kzz6shoM3CjCCURz4HhC
         xRVnRIdu9qRJNyXaXtl5b6yyX0aEy8CLgBOYl7oN/EmzlFT1ykq90n45mr4o0/ws/ZhR
         iSh2Bl4EoHU9fdvPsiAE+ivsWXJDMqfK3VFlJ1oTK/GgHcAwZS+cg2hBz0wiHF54SEE/
         9QDw==
X-Gm-Message-State: AOAM533pPf7uCEQeRSppj8YdKdNNRD6c6JmMabLxKMRdNUlIpo9sH7u8
        Rdj807l2TxFL7hXpEcNN9Ax3rQ==
X-Google-Smtp-Source: ABdhPJzOZbG/uZWyiLJK0PKAfddis9oaxt1apnwd/HczTnwAtpejwGlzbiYiw7Wz0N0GGQynqZO2+w==
X-Received: by 2002:adf:9bcf:: with SMTP id e15mr21168990wrc.276.1615195015567;
        Mon, 08 Mar 2021 01:16:55 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-141-80.adsl.proxad.net. [82.252.141.80])
        by smtp.gmail.com with ESMTPSA id i17sm6068135wrp.77.2021.03.08.01.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 01:16:55 -0800 (PST)
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
Subject: [PATCH v5 3/4] PM / devfreq: panfrost: Use devfreq cooling device registration
Date:   Mon,  8 Mar 2021 10:16:44 +0100
Message-Id: <20210308091646.28096-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210308091646.28096-1-daniel.lezcano@linaro.org>
References: <20210308091646.28096-1-daniel.lezcano@linaro.org>
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

