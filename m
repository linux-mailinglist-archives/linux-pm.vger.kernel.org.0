Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF2B924CAF1
	for <lists+linux-pm@lfdr.de>; Fri, 21 Aug 2020 04:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbgHUCoM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Aug 2020 22:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbgHUCoJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Aug 2020 22:44:09 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33C3C061385;
        Thu, 20 Aug 2020 19:44:09 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 128so306445pgd.5;
        Thu, 20 Aug 2020 19:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dx/BZ20WfKAvV2mkdGmQP8JhT0k8HCX9a2G2fUQx028=;
        b=C12/NdmXdhnbdKHg8xF7oTky+TCJsSwEfi5y9F2Pe2/zQuDXSkXhxqiLaNOsoIDP8i
         fpqtL6jeGV+UG3KpPecJAASHJ2vlexrmDeVDASoRqBqproQZOGG1gdQBLNR4otRNqR9p
         FlusfAt+7sNZBBhpnCj5RSG/CBpOLj8czZo3J3sh+aUF5svkTbN6TnzqzJstlT5mTL3O
         EuCvOrk+NPahFXMxrRS1WvysmlpnezRzvZqmYMKCQIYICnnvTQww/erlQlwE+A/4Alb7
         hqw55wQy1bAjxwy3YVcjMvkLQ6DtaxPhQlJMIZjI3zjlWvzEW2FGMbxQDK2ZCCmKoAUe
         4ePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dx/BZ20WfKAvV2mkdGmQP8JhT0k8HCX9a2G2fUQx028=;
        b=WJ9bfUPKApfD6hFsZa6edQUFfVHzN6MpPdjvt/nIKLhDkc4O1GyxcJpVEUQ7+PjYFn
         59h7xpl2OHLfJRO92OqF75lzLyf5muk5UC30oKQ23EjE8aTq70xGW1CwyPNglhAl9hrb
         Pa5l+XYaCUzSYW0LwC8LQmRury8l9fhKAqxSc2jbGkNrVaaLi4xItn7td01nVbrsoIPL
         wU9n8+MUYykFs/2FGYxxDlX6AsnPYeOtzsr3lid/6rZ7W7EQ/pOiWbxhjbnLwOODtpev
         MUdSwndtPfm1xvNs62+kPQn54vxFw6odIudPzYvB6FJS7wwzPezuM2NftiBwlvwkNvzD
         Lk3w==
X-Gm-Message-State: AOAM530Ii3VZUqxe+kIDFtMngH2bSJ9jM3PrYcPOoDBxHiJvSLQz0lnX
        3AjfQPA5DwFKwf5ecS0D22flVuE2Q+k=
X-Google-Smtp-Source: ABdhPJwGxKScz30n1Eztir9iL2Up6EZINDBhMijtDsi5IgTsqfMcsV19lPtyASDWWGyrW7dThwN3pQ==
X-Received: by 2002:aa7:84d4:: with SMTP id x20mr725600pfn.96.1597977849269;
        Thu, 20 Aug 2020 19:44:09 -0700 (PDT)
Received: from huyue2.ccdomain.com ([124.156.176.71])
        by smtp.gmail.com with ESMTPSA id b20sm486109pfp.140.2020.08.20.19.44.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Aug 2020 19:44:08 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, zhangwen@yulong.com
Subject: [PATCH] thermal: sysfs: Fall back to vmalloc() for cooling device's statistics
Date:   Fri, 21 Aug 2020 10:44:05 +0800
Message-Id: <20200821024406.10404-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.19.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

We observed warning about kzalloc() when register thermal cooling device
in backlight_device_register(). backlight display can be a cooling device
since reducing screen brightness will can help reduce temperature.

However, ->get_max_state of backlight will assign max brightness of 1024
to states. The memory size can be getting 1MB+ due to states * states.
That is so large to trigger kmalloc() warning.

So, let's use kvzalloc() to avoid the issue, also change kfree -> kvfree.

Suggested-by: Amit Kucheria <amitk@kernel.org>
Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 drivers/thermal/thermal_sysfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index aa99edb..d1703ee 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -16,6 +16,7 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/slab.h>
+#include <linux/mm.h>
 #include <linux/string.h>
 #include <linux/jiffies.h>
 
@@ -919,7 +920,7 @@ static void cooling_device_stats_setup(struct thermal_cooling_device *cdev)
 	var += sizeof(*stats->time_in_state) * states;
 	var += sizeof(*stats->trans_table) * states * states;
 
-	stats = kzalloc(var, GFP_KERNEL);
+	stats = kvzalloc(var, GFP_KERNEL);
 	if (!stats)
 		return;
 
@@ -938,7 +939,7 @@ static void cooling_device_stats_setup(struct thermal_cooling_device *cdev)
 
 static void cooling_device_stats_destroy(struct thermal_cooling_device *cdev)
 {
-	kfree(cdev->stats);
+	kvfree(cdev->stats);
 	cdev->stats = NULL;
 }
 
-- 
1.9.1

