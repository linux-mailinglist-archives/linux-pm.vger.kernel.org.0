Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84AB911374F
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2019 22:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbfLDV4d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Dec 2019 16:56:33 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:41419 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728321AbfLDV4c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Dec 2019 16:56:32 -0500
Received: by mail-pf1-f201.google.com with SMTP id x6so443817pfx.8
        for <linux-pm@vger.kernel.org>; Wed, 04 Dec 2019 13:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=HTj7qDEyn7lWOc8wN7N9p4zwloLaqZI5Kwhl1CHvASs=;
        b=FNE+dvQ3Mq0b4Wyo5066ThivwAnSBjfmu6aIePqxE+l5w6agVE8AenI5PHTlPPlBMs
         Snx2liF4lHh0C8dJP3UWvO/pvuNMWWmSzUv5qcgEoFyrXMBFfA5WkMvGbzeH2oiIf4i9
         5NM8wqdGF5I9edmQr7ZXkoScCiqQ5Na3etSVYuK6DW4D4XI3WLuJPOwUT3DIqbgzcPUQ
         EPo4NkQ3u/oxSl4OiR4BSmOLh5Hf/WKwWFyrG8loAeMXwziywVgdWSoFH+sNuGw329DA
         te3VYThX2ns0vn1k/aPWhw1IkTCLua1eWCZqnMaZbQHwcQVuELtSQe+CwSQ3fReGcb02
         +utw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=HTj7qDEyn7lWOc8wN7N9p4zwloLaqZI5Kwhl1CHvASs=;
        b=jA63oNyhaqmE3QFx8Odr+AoadtCQSKuwkFD89nQE0r1sxKoAoCS8wYa+AbUajtZF/h
         49XvwVoCFtqVMjMSbY9qY+V52BQVk9i67gFGht+OhX5fjvU/u07ikeXZksaPGdpPue50
         2ruULsMT+twnB5gdWFvvvq64Y62wNhKrbxgvUyF8OrILwSZJ2kcyhfoz9ZHC3QfzFcyt
         6I72PflExwcw1WZXxJ2I4y13GkScQX5XGyeo4hjBBWQCM9Rr73HiLZDt+92/JxCcMRtU
         CkMdcDf/WP3LRfGPOsJzOp6YNYXuqgav2WP60frXB4RTzX9KrJgBs4z80q16mXh81uzT
         FQQg==
X-Gm-Message-State: APjAAAU17orJnBoY1o78+Cz4/WzQSO1CylTzNdZJWPLP8IdsRZcolvyj
        a7nOng+Io4a6hoHQcHx7x0q4V0w=
X-Google-Smtp-Source: APXvYqy+7GSIcR47tRTMK1KMDNHau+jIvwK+ll3f9hyx0cPiCnroMCqhrnksPp4nW+y+QPc8LCAPtbc=
X-Received: by 2002:a63:6507:: with SMTP id z7mr5942883pgb.322.1575496591590;
 Wed, 04 Dec 2019 13:56:31 -0800 (PST)
Date:   Wed,  4 Dec 2019 13:56:18 -0800
In-Reply-To: <20191204215618.125826-1-wvw@google.com>
Message-Id: <20191204215618.125826-3-wvw@google.com>
Mime-Version: 1.0
References: <CAHLCerOD2wOJq7QNGBOcLvkMz4wvc1+6Hk2+ZD__NFged3tLcw@mail.gmail.com>
 <20191204215618.125826-1-wvw@google.com>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH v2 2/2] thermal: create softlink by name for thermal_zone and cooling_device
From:   Wei Wang <wvw@google.com>
Cc:     wei.vince.wang@gmail.com, Wei Wang <wvw@google.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
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
---
 drivers/thermal/thermal_core.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 64fbb59c2f44..4f55e3f16265 100644
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
 
@@ -997,9 +1000,15 @@ __thermal_cooling_device_register(struct device_node *np,
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
@@ -1165,6 +1174,8 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
 			}
 		}
 	}
+	if (cdev_link_kobj)
+		sysfs_remove_link(cdev_link_kobj, cdev->type);
 
 	mutex_unlock(&thermal_list_lock);
 
@@ -1348,6 +1359,12 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 
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
@@ -1419,6 +1436,8 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 			}
 		}
 	}
+	if (tz_link_kobj)
+		sysfs_remove_link(tz_link_kobj, tz->type);
 
 	mutex_unlock(&thermal_list_lock);
 
-- 
2.24.0.393.g34dc348eaf-goog

