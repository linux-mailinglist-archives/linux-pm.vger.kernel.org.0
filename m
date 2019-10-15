Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24A12D6F77
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2019 08:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfJOGNy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Oct 2019 02:13:54 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:43954 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbfJOGNy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Oct 2019 02:13:54 -0400
Received: by mail-pl1-f202.google.com with SMTP id f8so11434448plj.10
        for <linux-pm@vger.kernel.org>; Mon, 14 Oct 2019 23:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:cc;
        bh=DFJlUv3R2tvxSh8wj2z2rPk5wlDmklaGa42vbJhXkJA=;
        b=ofZhNagGO/RutpOWP60t/B7g/QAUMiKkkistW5ofAZdYiEZRlBEruprFDM6I6PxLZy
         8KTprRzP9E4b8XM3NWG4eUc6A0T18xd40aGxpktcC8PMv7IX1puYOtclbr9YnAIKijke
         YyEfNr6s+ibNpfJBNLEbptgb5d0Z8Y67rS7J4YwgG5V1C5lVsD/z2MQpR7mQcld3XHEy
         XKqFMzbwFNQhMKlULVjexe8PC/eyFB1ke3rf3Aq7aarPxCdwkp3mSbUQ1jI1wr7wqert
         eaF6sAroReMPMLc+tOANlAHFAKZKqA6whVoZN9CEh9a0n2zF5Yd+hO5HldJqER92ZVxK
         w87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=DFJlUv3R2tvxSh8wj2z2rPk5wlDmklaGa42vbJhXkJA=;
        b=e/YooWcPIiMBGJ9vX6Oqv6YqOuoonO8baM7ol68CiVp3qJVfUhBGQeNuB/ODDBHqEu
         RRUlvf+xN8/AKQEGNqmyhuoDAlC1ugj6y7V37h3GraeXADNe35PqE4wok6Pcso3/nm4j
         ThrBzNz6OPiIu1rAN1GxJsmq65zOTH7O1prMxbCkes4O4h8HB5IZnwcJQRoPR07/rSV/
         fpKdcYnbVWKrtsMErp0ifS4pIdUqw+4jDrMTVPXY5aMCQ9Bgy5gkoosmiIpQR0O14wNp
         2Bm82RI6IQ7nZGT2F/5040c48AKEZ9o0XB1MFqdOqgYUIU+Vmzdyml3P7kHhbXq9mc2l
         +N7A==
X-Gm-Message-State: APjAAAXaST1UjRwyToyZOofVYyQsGPR7vvD3RSk0dyqtVWB/NfDxL8tp
        y2/RcCj5vMhNAqoivBwmvV0HjrI=
X-Google-Smtp-Source: APXvYqx8PE/ef+PfXpxjA+3FMGl7Rmrnp8UmCkFbl/oqJ1a6GNCs4DWzHk7Uqy5wEBKktQfolcUBGCA=
X-Received: by 2002:a63:3003:: with SMTP id w3mr34876350pgw.364.1571120033122;
 Mon, 14 Oct 2019 23:13:53 -0700 (PDT)
Date:   Mon, 14 Oct 2019 23:13:49 -0700
Message-Id: <20191015061349.141448-1-wvw@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: [PATCH] thermal: create softlink by name for thermal_zone and cooling_device
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
 drivers/thermal/thermal_core.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index d4481cc8958f..0ff8fb1d7b0a 100644
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
 
@@ -954,7 +957,7 @@ __thermal_cooling_device_register(struct device_node *np,
 	struct thermal_zone_device *pos = NULL;
 	int result;
 
-	if (type && strlen(type) >= THERMAL_NAME_LENGTH)
+	if (!type || !type[0] || strlen(type) >= THERMAL_NAME_LENGTH)
 		return ERR_PTR(-EINVAL);
 
 	if (!ops || !ops->get_max_state || !ops->get_cur_state ||
@@ -989,9 +992,15 @@ __thermal_cooling_device_register(struct device_node *np,
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
@@ -1157,6 +1166,8 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
 			}
 		}
 	}
+	if (cdev_link_kobj)
+		sysfs_remove_link(cdev_link_kobj, cdev->type);
 
 	mutex_unlock(&thermal_list_lock);
 
@@ -1340,6 +1351,12 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 
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
@@ -1411,6 +1428,8 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 			}
 		}
 	}
+	if (tz_link_kobj)
+		sysfs_remove_link(tz_link_kobj, tz->type);
 
 	mutex_unlock(&thermal_list_lock);
 
-- 
2.23.0.700.g56cf767bdb-goog

