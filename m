Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79378113C39
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 08:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbfLEHUW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 02:20:22 -0500
Received: from mail-yb1-f201.google.com ([209.85.219.201]:49214 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfLEHUV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Dec 2019 02:20:21 -0500
Received: by mail-yb1-f201.google.com with SMTP id 191so1691482ybc.16
        for <linux-pm@vger.kernel.org>; Wed, 04 Dec 2019 23:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=ts1yBosTiHCFk+FM0gulija97H50ynj8MItVpiYvleQ=;
        b=ld8GY3TacvMwKqP04HpCI65PJfosSibr/XBnqjhUGqK8lCLovwEHCSicuYg0080tyP
         dfZbzuPfYYv3pcb1iC+/CjCG+fUQxrimPBy9fyQjgXTDZs1PPcwNfw3HCWbiFE7wRUKk
         UXIsBTWrF8A4dbgQooSvDgo/pV1rNrkqUuGILp+GFV2cUEVt5BpP6dJJCCd1gu0Gz93w
         5mBfZHtVfBwJN9vRkQ1DcqJdelveL3SzXxVZcPfFgUTSzGwNBav4M86qMp+cHgOwnQrg
         7tm3S/98VeIjDpYfSS1hAII/y8JDlNG2vNIvj/6oUTS8FiojrKMPKnf640QM1RQNpCR3
         +hcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=ts1yBosTiHCFk+FM0gulija97H50ynj8MItVpiYvleQ=;
        b=eJangxs3XGAi2JHZuXH9owGAj8tH5Z0cvG86xN/TIN9eWo92ztoiNT9ONW79nPvnbf
         GaDYqVl4OupdBFMTX96NJOWASfpzyDHY2UQCFl5wJ4Y5uvwGM5wAigtVOEAiN7JAZ2Mo
         s1pYyPkhzADDohwxQNeRYahkno/jx+3Et8pClJc2Cnv8lDusQ/yU2xvpyqtopSXjW7Ez
         PE6dPBEph9v9cRs+XAkSSrpeOsAg5RgI4m1yFcG4ns5QgG/WsALqOjkjVd9ZAPURgj4t
         qT9vhgHMUxZ0e7Y4elCM6Ng/VSnfMfEQSraE8VsJux4cIAnHUwm3yKt6hshbuq2PYRaj
         Vikw==
X-Gm-Message-State: APjAAAXd7+i7OViwc+fpG83M7TFQonqjChb3XjT3H+E7q9l3U53ZFvax
        mvY94fbv28HxDIVwC/lL4TMMjwg=
X-Google-Smtp-Source: APXvYqwPLL22lSTzNWHq5MEuCpLUubSt5RY0lxSgL1kQNEi44mvvHms6QnuzTkyPX1MHD1unKh/9ObE=
X-Received: by 2002:a0d:d911:: with SMTP id b17mr5123945ywe.269.1575530419968;
 Wed, 04 Dec 2019 23:20:19 -0800 (PST)
Date:   Wed,  4 Dec 2019 23:19:53 -0800
In-Reply-To: <20191205071953.121511-1-wvw@google.com>
Message-Id: <20191205071953.121511-4-wvw@google.com>
Mime-Version: 1.0
References: <20191205071953.121511-1-wvw@google.com>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH v3 3/3] thermal: create softlink by name for thermal_zone and cooling_device
From:   Wei Wang <wvw@google.com>
Cc:     wei.vince.wang@gmail.com, Wei Wang <wvw@google.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amit.kucheria@linaro.org>
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The paths thermal_zone%d and cooling_device%d are not intuitive and the
numbers are subject to change due to device tree change. This usually
leads to tree traversal in userspace code.
The patch creates `tz-by-name' and `cdev-by-name' for thermal zone and
cooling_device respectively.

Signed-off-by: Wei Wang <wvw@google.com>
Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/thermal_core.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 9db7f72e70f8..7872bd527f3f 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -22,6 +22,7 @@
 #include <net/netlink.h>
 #include <net/genetlink.h>
 #include <linux/suspend.h>
+#include <linux/kobject.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/thermal.h>
@@ -46,6 +47,8 @@ static DEFINE_MUTEX(poweroff_lock);
 
 static atomic_t in_suspend;
 static bool power_off_triggered;
+static struct kobject *cdev_link_kobj;
+static struct kobject *tz_link_kobj;
 
 static struct thermal_governor *def_governor;
 
@@ -999,9 +1002,15 @@ __thermal_cooling_device_register(struct device_node *np,
 		return ERR_PTR(result);
 	}
 
-	/* Add 'this' new cdev to the global cdev list */
+	/* Add 'this' new cdev to the global cdev list and create link*/
 	mutex_lock(&thermal_list_lock);
 	list_add(&cdev->node, &thermal_cdev_list);
+	if (!cdev_link_kobj)
+		cdev_link_kobj = kobject_create_and_add("cdev-by-name",
+						cdev->device.kobj.parent);
+	if (!cdev_link_kobj || sysfs_create_link(cdev_link_kobj,
+						&cdev->device.kobj, cdev->type))
+		dev_err(&cdev->device, "Failed to create cdev-by-name link\n");
 	mutex_unlock(&thermal_list_lock);
 
 	/* Update binding information for 'this' new cdev */
@@ -1167,6 +1176,8 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
 			}
 		}
 	}
+	if (cdev_link_kobj)
+		sysfs_remove_link(cdev_link_kobj, cdev->type);
 
 	mutex_unlock(&thermal_list_lock);
 
@@ -1354,6 +1365,12 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 
 	mutex_lock(&thermal_list_lock);
 	list_add_tail(&tz->node, &thermal_tz_list);
+	if (!tz_link_kobj)
+		tz_link_kobj = kobject_create_and_add("tz-by-name",
+						tz->device.kobj.parent);
+	if (!tz_link_kobj || sysfs_create_link(tz_link_kobj,
+						&tz->device.kobj, tz->type))
+		dev_err(&tz->device, "Failed to create tz-by-name link\n");
 	mutex_unlock(&thermal_list_lock);
 
 	/* Bind cooling devices for this zone */
@@ -1425,6 +1442,8 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 			}
 		}
 	}
+	if (tz_link_kobj)
+		sysfs_remove_link(tz_link_kobj, tz->type);
 
 	mutex_unlock(&thermal_list_lock);
 
-- 
2.24.0.393.g34dc348eaf-goog

