Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0B7330F45
	for <lists+linux-pm@lfdr.de>; Mon,  8 Mar 2021 14:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhCHNdc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Mar 2021 08:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbhCHNdJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Mar 2021 08:33:09 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E452C06174A
        for <linux-pm@vger.kernel.org>; Mon,  8 Mar 2021 05:33:09 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id r15-20020a05600c35cfb029010e639ca09eso3811378wmq.1
        for <linux-pm@vger.kernel.org>; Mon, 08 Mar 2021 05:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qhmm7MrKdTwC31wHH2vNUCLubMqn0qUwkRrssLNEi9A=;
        b=AsXKRlBzMj0XqlLBUSGMnj9q7R25iT3ReJ1aBIzxK5qMrDGI4AodKxv7xhQnLIYMSr
         IgtD9xTbcZinvX1DTIKbwQMqaMZ5LlwXz/YnLpe0UYWDRf9GCGWwPw8JqwWGqy5AdFVM
         5uBNLkIvIW9+61z4LDbG3yTjPIiUt2rs1ITGRfBbD6+ubiwdjdAfDhZnaIsvqApCxpmi
         +xbIUcpcqbpNycytOe41v80mt4YW8OLqVu5TqwEVyv4SuFShvHiIcbRDMDrjUt5vWpAR
         BKO//asvN27/7ZE+Br7z8wHIn2MRvJQiiq6ApHDgeEWhD1qAYPy5zKTgwA6GIteoOT86
         MQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qhmm7MrKdTwC31wHH2vNUCLubMqn0qUwkRrssLNEi9A=;
        b=RXbigb7RJqwQSvxSwneARMWdYJ11hKzwGFvcQArApuRBimA5658eDSeYxNtmL9QWcC
         EQ2kh86KAHDDte9L00xSPugevHaJfPGIDmxWymlhompqWX5qCumlwL6SZib8kmvSlCLS
         tUmZ9LXsnAFXJW8CnbNSuou/IBNpkWEU9lH2Sb1XO8jjQvKZH7h0aPUyMqPWXKp8aKzz
         QYZOQjIp/zFYvXntOvmRf3yUTQfF6g05b6bhiU/Tpm7N0KT1q04VVgllAgihxPlfidlX
         SxiYtfjQWaIIryyvVHXIlRVUXRRnLX8z0DMytuNNEmOrXcLbhUKUpyyb7lip2/lRYM+2
         pGwg==
X-Gm-Message-State: AOAM5326WdL+zfM2NhQ+6f9koyS7lQKnPCdJ06YTQP2eeRBRg5VoH2ym
        3c57IhO9Y/w7B1G/PMio5a0uXg==
X-Google-Smtp-Source: ABdhPJzc7k7+hcfsVTeHZPjo+8UHo38FjEwTstABQwgjRNLXsQcHQ0cgL60pxCqJfdWeZLfA7x4xGA==
X-Received: by 2002:a7b:c4c9:: with SMTP id g9mr22581123wmk.82.1615210387861;
        Mon, 08 Mar 2021 05:33:07 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-141-80.adsl.proxad.net. [82.252.141.80])
        by smtp.gmail.com with ESMTPSA id m11sm18942665wrz.40.2021.03.08.05.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 05:33:07 -0800 (PST)
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
Subject: [PATCH v6 3/4] PM / devfreq: panfrost: Use devfreq cooling device registration
Date:   Mon,  8 Mar 2021 14:30:39 +0100
Message-Id: <20210308133041.10516-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210308133041.10516-1-daniel.lezcano@linaro.org>
References: <20210308133041.10516-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The devfreq core code is able to register the devfreq device as a
cooling device if the 'is_cooling_device' flag is set in the profile.

Use this flag and remove the cooling device registering code.

Tested on rock960.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Steven Price <steven.price@arm.com>
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

