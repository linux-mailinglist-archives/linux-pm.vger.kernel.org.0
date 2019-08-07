Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBBB842BD
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2019 05:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfHGDB4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Aug 2019 23:01:56 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44192 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbfHGDBz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Aug 2019 23:01:55 -0400
Received: by mail-pl1-f195.google.com with SMTP id t14so38645086plr.11
        for <linux-pm@vger.kernel.org>; Tue, 06 Aug 2019 20:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HCWtXmm8PXUeDMR1t8C344/4HIGAq2JhsfErKkKrQRY=;
        b=poCmGXNSsGWW5k/jTH72xOiKGf0zy+71CD3ty2E9Akpw9FfY4p9ThFtsmcL0+ZqKzL
         tP+FBARsBFLsfw7UC5cziJzKlNZ1n6ZMxp8m2guKlRmDLvliIJwjvl4Pnb16dW/fSzUy
         ZVk6kYzGhQqcEkLiYhVGW/FxwevRqX5HvUmlJvq1pMK9J5Bjv/xDgIE4zTuZwhQy3/Lq
         LxVhIDvDg93CRSL8e7aCPSu/ekB+SGEHBtIBKR3xhidzXt8jUVoT7NDpnW1tUqAQFfNY
         86K7XpyfqBOcERR0ntDTfbDGy7BzDfsWmRoFcExRhhVXH/Lh/1V5m/bhiM8voU6ojzXC
         HuJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HCWtXmm8PXUeDMR1t8C344/4HIGAq2JhsfErKkKrQRY=;
        b=PewrKjuot0fx/ZFNausX2+FYqzkw0cM+iNpif291INUdZRZPd1BhKzn+iDvmUcDkt1
         n7EJpLAFDLGqwq29tRKHlr21RXv/7JHB+fwlc5tKsu60bopldGqf5lt9q/PkNvqhokO9
         BsNiLQFcOgEh6ZPtk+7f7SYRVOEwatLSzpkNqSSkuRCvzbS/oCUkYIeLZfasO+rlprhC
         4/M4KbhVyNtodMRjP2Lx6fi0uRbzVktbBQ35cni28UIHr7CV8F0ZbBq8tpqIW7SHb4CE
         6z2nCXCJp4EHggv7Z/8zJBlH79SGvMjYoRx/h5cVBnJ/S1teDGOnXpJwj5cW11ZRM0Lx
         WDqA==
X-Gm-Message-State: APjAAAVzvIULLJAbwiZnY3Zq+aFrtXZ334gyfsFGnk8FOgtl63nJ5z6D
        lFboi7y7JgxEZ1X46tklKrM=
X-Google-Smtp-Source: APXvYqyGSOodV13okJuPrZL6qyh68pdRMaBxUK/4KTFp56Jcfw8tstkFG1FJ+KP2brtaFr5XH17m3Q==
X-Received: by 2002:a17:902:aa8a:: with SMTP id d10mr6312287plr.154.1565146915338;
        Tue, 06 Aug 2019 20:01:55 -0700 (PDT)
Received: from huyue2.ccdomain.com ([218.189.10.173])
        by smtp.gmail.com with ESMTPSA id w132sm91449652pfd.78.2019.08.06.20.01.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 20:01:54 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-pm@vger.kernel.org, huyue2@yulong.com, zhangwen@yulong.com
Subject: [PATCH v2] thermal/drivers/core: Use put_device() if device_register() fails
Date:   Wed,  7 Aug 2019 11:01:30 +0800
Message-Id: <20190807030130.11856-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1.windows.2
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

Never directly free @dev after calling device_register(), even if it
returned an error! Always use put_device() to give up the reference
initialized. Clean up the rollback block also.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
v2: clean up rollback code, update commit message

 drivers/thermal/thermal_core.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 6bab66e..bae1e41 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -985,7 +985,7 @@ static void bind_cdev(struct thermal_cooling_device *cdev)
 	result = device_register(&cdev->device);
 	if (result) {
 		ida_simple_remove(&thermal_cdev_ida, cdev->id);
-		kfree(cdev);
+		put_device(&cdev->device);
 		return ERR_PTR(result);
 	}
 
@@ -1240,6 +1240,7 @@ struct thermal_zone_device *
 	struct thermal_zone_device *tz;
 	enum thermal_trip_type trip_type;
 	int trip_temp;
+	int id;
 	int result;
 	int count;
 	struct thermal_governor *governor;
@@ -1266,11 +1267,13 @@ struct thermal_zone_device *
 	INIT_LIST_HEAD(&tz->thermal_instances);
 	ida_init(&tz->ida);
 	mutex_init(&tz->lock);
-	result = ida_simple_get(&thermal_tz_ida, 0, 0, GFP_KERNEL);
-	if (result < 0)
+	id = ida_simple_get(&thermal_tz_ida, 0, 0, GFP_KERNEL);
+	if (id < 0) {
+		result = id;
 		goto free_tz;
+	}
 
-	tz->id = result;
+	tz->id = id;
 	strlcpy(tz->type, type, sizeof(tz->type));
 	tz->ops = ops;
 	tz->tzp = tzp;
@@ -1292,7 +1295,7 @@ struct thermal_zone_device *
 	dev_set_name(&tz->device, "thermal_zone%d", tz->id);
 	result = device_register(&tz->device);
 	if (result)
-		goto remove_device_groups;
+		goto release_device;
 
 	for (count = 0; count < trips; count++) {
 		if (tz->ops->get_trip_type(tz, count, &trip_type))
@@ -1343,14 +1346,12 @@ struct thermal_zone_device *
 	return tz;
 
 unregister:
-	ida_simple_remove(&thermal_tz_ida, tz->id);
-	device_unregister(&tz->device);
-	return ERR_PTR(result);
-
-remove_device_groups:
-	thermal_zone_destroy_device_groups(tz);
+	device_del(&tz->device);
+release_device:
+	put_device(&tz->device);
+	tz = NULL;
 remove_id:
-	ida_simple_remove(&thermal_tz_ida, tz->id);
+	ida_simple_remove(&thermal_tz_ida, id);
 free_tz:
 	kfree(tz);
 	return ERR_PTR(result);
-- 
1.9.1

