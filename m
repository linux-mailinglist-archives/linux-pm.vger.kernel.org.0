Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 306EF2DA440
	for <lists+linux-pm@lfdr.de>; Tue, 15 Dec 2020 00:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgLNXlB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Dec 2020 18:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbgLNXk5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Dec 2020 18:40:57 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99828C06138C
        for <linux-pm@vger.kernel.org>; Mon, 14 Dec 2020 15:40:00 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id a6so15282099wmc.2
        for <linux-pm@vger.kernel.org>; Mon, 14 Dec 2020 15:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=365sGsgJNcvgkVzei9+4ZgSu6iZEYSl+7/l7/Wor6X4=;
        b=IJ/I+X0HMVRT5A2fpWqr8R0hwgyYg5m5wPjgcUTbuOIurubce0Hq34PjQ/pvejV+qD
         F8HnNcPy9isnlqUQXotXE4Hq6DLqcXDT79PJDh3Ftxad+OgH03L1Xi7SM7nKJL3yNsLz
         xaO9LxgcgBT8JSC6h+2/P7fjVxMr+EZ49aq4cY8K6Q/bjWQTPe2wQj+feDCbCQ6LYCcA
         dfkgHiXz6bZw8+2BFL8n46v5ON3IvCBqZkoODDGSNRH8YFILYlbRUvjTM602e7+LxP4w
         YiSz6JuFm8MNhpoMNahZlbn1+dU0/1tE6S2HDVbuM1RjmtMN/pmWdV6mLoVNK+U8JbXp
         i9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=365sGsgJNcvgkVzei9+4ZgSu6iZEYSl+7/l7/Wor6X4=;
        b=P4ASv9s6Rp7+QouoR71zWHLd7f7hjIRMd4012CUF1Zl6FK4gO1IwwW7x0p4oUbuWw4
         MIJ9uR72vpY/LC0/YGlGM8EKqMSFF3hB3DR5r8GolBGFmCAw7fsqLPUsSn72USlc6Dg+
         /4ui5N5eINyVtZDECXIdjsk8q61Zslx+C02imSbf+VTCD/Snuieu1N1svi9lKJTBFLUi
         7DcBQRjtMJ12C1TLqlXuSg2fJPREoQMWVx3wm071RV59qBEjPt2rxAZbGHc9zFehCbfQ
         n4G+pHeIBKTEjk/gY660DvZaV6Wt+nlYICJh8wQSHrP1u+YhcwM6b3YJGTibw5kR8FmN
         kQcA==
X-Gm-Message-State: AOAM531x2+Va6Vt7eh+yRS8A7ozdpFTh4hZlKsZ6GUX7ZTTeQsq+giv4
        p3MSRh6dUSHTqCYx6j6So9qUng==
X-Google-Smtp-Source: ABdhPJxVG+DU4ESNHxS3DkeqMHIZr9xrvF81urluDVLgK9AhwJptlUccvv4l9amFhQlebSpBmrgr7A==
X-Received: by 2002:a7b:c3c8:: with SMTP id t8mr29888592wmj.88.1607989199169;
        Mon, 14 Dec 2020 15:39:59 -0800 (PST)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:e842:4086:6f24:55a6])
        by smtp.gmail.com with ESMTPSA id h3sm34145075wmm.4.2020.12.14.15.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 15:39:58 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     mjg59@codon.org.uk, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, amitk@kernel.org,
        thara.gopinath@linaro.org
Subject: [PATCH 2/6] thermal/core: Remove unused functions rebind/unbind exception
Date:   Tue, 15 Dec 2020 00:38:05 +0100
Message-Id: <20201214233811.485669-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201214233811.485669-1-daniel.lezcano@linaro.org>
References: <20201214233811.485669-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The functions thermal_zone_device_rebind_exception and
thermal_zone_device_unbind_exception are not used from anywhere.

Remove that code.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 37 ----------------------------------
 drivers/thermal/thermal_core.h |  4 ----
 2 files changed, 41 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 567bc6f254c0..a0f0c33c8d9c 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -598,26 +598,6 @@ static void thermal_zone_device_check(struct work_struct *work)
 	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
 }
 
-void thermal_zone_device_rebind_exception(struct thermal_zone_device *tz,
-					  const char *cdev_type, size_t size)
-{
-	struct thermal_cooling_device *cdev = NULL;
-
-	mutex_lock(&thermal_list_lock);
-	list_for_each_entry(cdev, &thermal_cdev_list, node) {
-		/* skip non matching cdevs */
-		if (strncmp(cdev_type, cdev->type, size))
-			continue;
-
-		/* re binding the exception matching the type pattern */
-		thermal_zone_bind_cooling_device(tz, THERMAL_TRIPS_NONE, cdev,
-						 THERMAL_NO_LIMIT,
-						 THERMAL_NO_LIMIT,
-						 THERMAL_WEIGHT_DEFAULT);
-	}
-	mutex_unlock(&thermal_list_lock);
-}
-
 int for_each_thermal_governor(int (*cb)(struct thermal_governor *, void *),
 			      void *data)
 {
@@ -685,23 +665,6 @@ struct thermal_zone_device *thermal_zone_get_by_id(int id)
 	return match;
 }
 
-void thermal_zone_device_unbind_exception(struct thermal_zone_device *tz,
-					  const char *cdev_type, size_t size)
-{
-	struct thermal_cooling_device *cdev = NULL;
-
-	mutex_lock(&thermal_list_lock);
-	list_for_each_entry(cdev, &thermal_cdev_list, node) {
-		/* skip non matching cdevs */
-		if (strncmp(cdev_type, cdev->type, size))
-			continue;
-		/* unbinding the exception matching the type pattern */
-		thermal_zone_unbind_cooling_device(tz, THERMAL_TRIPS_NONE,
-						   cdev);
-	}
-	mutex_unlock(&thermal_list_lock);
-}
-
 /*
  * Device management section: cooling devices, zones devices, and binding
  *
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 8df600fa7b79..e50c6b2909fe 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -118,10 +118,6 @@ struct thermal_instance {
 
 int thermal_register_governor(struct thermal_governor *);
 void thermal_unregister_governor(struct thermal_governor *);
-void thermal_zone_device_rebind_exception(struct thermal_zone_device *,
-					  const char *, size_t);
-void thermal_zone_device_unbind_exception(struct thermal_zone_device *,
-					  const char *, size_t);
 int thermal_zone_device_set_policy(struct thermal_zone_device *, char *);
 int thermal_build_list_of_policies(char *buf);
 
-- 
2.25.1

