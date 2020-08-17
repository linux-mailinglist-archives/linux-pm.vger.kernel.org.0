Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76330247B41
	for <lists+linux-pm@lfdr.de>; Tue, 18 Aug 2020 01:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgHQXtV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Aug 2020 19:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgHQXtU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Aug 2020 19:49:20 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E80C061389;
        Mon, 17 Aug 2020 16:49:19 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id y2so10389318ljc.1;
        Mon, 17 Aug 2020 16:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WN60QM6RhGyYRGh3T+NFdDk+UduAdsfiPp4QMyXkDls=;
        b=EFdOPhuDY56AGpu23E6stF1Vw4GmrbNi5paNBlv1oLtRMKQ53RfCDZLL1Vxs/+bt1/
         L02nYDXMxnV/CoJr6YBFqQM2bhBVOPyE1vepFBpC+Gb6yNHW2ZbM347+Y5GHmmDvbHxp
         SHd8Fjp7oBdQCBeLsefALiB8jB0DpBlBI7+aFyz4F13h/k9TKNRdruQaUtrxKhgUSLB+
         fPrTtEspqo1SaXyJ2v3JkPMcy2+17PIYRg3Pn1p7ocq6jscUVhaJVCdoknmCcC0lbNxZ
         KvDi5c7PBRAuG5RiK7ni6Xxjv1KB5ASEKcWbyF6Dg95IadcVyUHCsnonY/5p/1DvhcIi
         Bf7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WN60QM6RhGyYRGh3T+NFdDk+UduAdsfiPp4QMyXkDls=;
        b=Et6WDkdXggAXLa/oI03XBw2suFKc0rf6igCL9KNrzxe7n7oUQSOV+MLnhJM6EurIZU
         0Q0cNspOrKygvRnBIuXCJ8EIMNQEOziywXGTJKY3X/Rirfhbw2K84E6iZq8DXLMa3zrw
         qhAWX0L5fA5rhXpYb7DsKgDZgAWrKY1meIedRwa82LZguRgsvYdaiyLvXesEBbyZj//H
         hiGWKDl2H5Ltl/2riFghckh77kdAJqG0PnmWoSSf6XsWfPca2xJrRNM7vAOBFn5D1gUy
         iLpncivGGB9s+L0FTGnJedo1yiFdO21g2N+jOSuydxDoKGB9J+xV5QI66Rh8qfXYhVEC
         RFgQ==
X-Gm-Message-State: AOAM532STcmtz+jls2UPvlOEVeTQTRPb+7zlUIuuM5eYyVtAwONaQWdF
        NsLf8iPenk+cRV64A/+ok2rsCF6qOEc=
X-Google-Smtp-Source: ABdhPJxfW7zXU+kKx0G2uvxF+UO3KGio/Y2pYeKSYd+x9SyR46tGWZZLzGVmTIUYbxq1EfB7N22LLg==
X-Received: by 2002:a2e:a556:: with SMTP id e22mr7691355ljn.317.1597708157186;
        Mon, 17 Aug 2020 16:49:17 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id i1sm3151711ljg.94.2020.08.17.16.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 16:49:16 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] thermal: core: Fix use-after-free in thermal_zone_device_unregister()
Date:   Tue, 18 Aug 2020 02:48:33 +0300
Message-Id: <20200817234833.23954-1-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The user-after-free bug in thermal_zone_device_unregister() is reported by
KASAN. It happens because struct thermal_zone_device is released during of
device_unregister() invocation, and hence the "tz" variable shouldn't be
touched by thermal_notify_tz_delete(tz->id).

Fixes: 55cdf0a283b8 ("thermal: core: Add notifications call in the framework")
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/thermal/thermal_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 72bf159bcecc..56c355f684df 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1516,7 +1516,7 @@ EXPORT_SYMBOL_GPL(thermal_zone_device_register);
  */
 void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 {
-	int i;
+	int i, tz_id;
 	const struct thermal_zone_params *tzp;
 	struct thermal_cooling_device *cdev;
 	struct thermal_zone_device *pos = NULL;
@@ -1525,6 +1525,7 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 		return;
 
 	tzp = tz->tzp;
+	tz_id = tz->id;
 
 	mutex_lock(&thermal_list_lock);
 	list_for_each_entry(pos, &thermal_tz_list, node)
@@ -1560,14 +1561,13 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 	cancel_delayed_work_sync(&tz->poll_queue);
 
 	thermal_set_governor(tz, NULL);
-
 	thermal_remove_hwmon_sysfs(tz);
 	ida_simple_remove(&thermal_tz_ida, tz->id);
 	ida_destroy(&tz->ida);
 	mutex_destroy(&tz->lock);
 	device_unregister(&tz->device);
 
-	thermal_notify_tz_delete(tz->id);
+	thermal_notify_tz_delete(tz_id);
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_unregister);
 
-- 
2.27.0

