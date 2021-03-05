Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B3A32F096
	for <lists+linux-pm@lfdr.de>; Fri,  5 Mar 2021 18:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbhCEREI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Mar 2021 12:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231380AbhCERD5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Mar 2021 12:03:57 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E70C061756
        for <linux-pm@vger.kernel.org>; Fri,  5 Mar 2021 09:03:56 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id v15so2860786wrx.4
        for <linux-pm@vger.kernel.org>; Fri, 05 Mar 2021 09:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ahYwzRQmSJrX4v8ks57+n/tweaGVoFJT9QTc8vhlUHg=;
        b=swIYYukmXBPaja9sOQciBRpjvLCS+zDwCEO0LYBBETH1USSmuqSzF0c5EQfiCG2Wo2
         GLUPdq8UftrXP9o9q2Eu3qYe6zVzpqQIbQPM3uClUG5+DcyhsuBHBe+fsv5Qrs5K5EfX
         oNfWy6b3fFjbQ6xAo4gIYcM9qYdOUwz3NJk84Bk3TbBXf8p7dSkL0pBOSDclsPQzWJ1z
         XM6+6xA4ghBTSuC6vRQ3m60/51XI68pU/kbjgztoQqNuUg7aWcj0EDDJFfl/Dp6W7Rvo
         2iireZy5lAjM/nLHQ13lB3v80mBbVi2Ka4GHqjgQl87pIk4q0ChWX7Q/P3tHGPNuzOfP
         2l1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ahYwzRQmSJrX4v8ks57+n/tweaGVoFJT9QTc8vhlUHg=;
        b=OKZxbL5kKv2wOMAQOhOJM8wCUWmdf8/6y2S+U5DlyhT0DiX14XcoaDTmdqZYkZwvIP
         Sl48H70MFgNkVhW3BCFyhPz5QPgHqMw1cLd414Vn9+M/cPF8LwtjyXx0ttM9wzeI/k0g
         Lt5X6cD5Nga9gWzuD7OImIFZXXerMDRWFHmTPSEf6B8Co1cte03UBaz9xQAzRhR6R/BQ
         S8xiJmBkYMtxzk7CSebGe25rK+A5UoC7+N5lXc1lW4HIpIWX1QykQ/KRmSvPAcXRKQ8V
         FGybn40zi2MCasN6I8p9PDZh6jkNgYD4I9ea+HcfgiUBwMyW786CgdP5MHPOF3kgD4sA
         7aVg==
X-Gm-Message-State: AOAM530IpEXJZdOPyE7eQUwNJ6+QKzMAMP+5lfPJ8xQmPM0qUB8JCcd8
        EXChRQG8sCQlJ33op0lhN1W4DA==
X-Google-Smtp-Source: ABdhPJy7Len8gQJ8kSf2MO/PaGZMBla5J7H3YzDlCMYsreVJGMZXypBM7ZvREdzhXmXw5/qQmz+p0A==
X-Received: by 2002:a5d:6b0a:: with SMTP id v10mr10296497wrw.183.1614963835502;
        Fri, 05 Mar 2021 09:03:55 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-141-80.adsl.proxad.net. [82.252.141.80])
        by smtp.gmail.com with ESMTPSA id p17sm4760934wmq.47.2021.03.05.09.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 09:03:55 -0800 (PST)
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
Subject: [PATCH v2 4/4] devfreq/drivers/panfrost: Use devfreq cooling device registration
Date:   Fri,  5 Mar 2021 18:03:37 +0100
Message-Id: <20210305170338.13647-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210305170338.13647-1-daniel.lezcano@linaro.org>
References: <20210305170338.13647-1-daniel.lezcano@linaro.org>
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

