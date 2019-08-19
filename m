Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C58AE927EE
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2019 17:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfHSPGr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Aug 2019 11:06:47 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33598 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbfHSPGr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Aug 2019 11:06:47 -0400
Received: by mail-pf1-f193.google.com with SMTP id g2so1336952pfq.0
        for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2019 08:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q/NTPkOgDugnvtYxQIl6YcfkOy753zBm8BGZ6A5khjo=;
        b=cbryQW+rH/l8O0Rtq/NobBlIcTmxaxsowrvUhF0QRs4xG8S1/e71FsW1NvF2ioT5Xv
         YoCLj7VwjszCCu1lC9dZZYGu3rCwcy8Hxw7UQa+nzSzTZ+eu5N1V9EW1UOB6eOouFO4e
         1hhpLcUGc3PmR6PUgZUD24UGB9g4Hz23dNGcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q/NTPkOgDugnvtYxQIl6YcfkOy753zBm8BGZ6A5khjo=;
        b=rTkgPmHTYDeAKaewbApMCcSGd3XgYWBtqSmC/6xwkRI2PyYtemHtOhXQiv6mkd0CSH
         TljIRNlKcvKRV+MIthOAf4GHH6p9+UTmquGvj6Hih/Rvau8YW33NSAOsEn9QV9oOgRg7
         mV+5byJSfwiAm0KQUsZDqDCAxXRKwlMNNeIH87MR16MerOwRmXBKkcL40y3LolWC3KCr
         aD77yGvImrlxuaT4CWDqZXKNBICFkAn6FQ2No1AZ/b7VqQXKPrUUYSynXbXG4e9NJYIp
         I5MH+wjmrNFOKx3Mxvi1CvGFoCe1RcBfd8HfNJ2/zqa8YNr5DOO0v2Dr4GF8vsu6rsHO
         ZLKA==
X-Gm-Message-State: APjAAAVY9k+yJqvXe85xyAocB4BowShOA+TNSgYZpGVkHKDjZ5/Arrf6
        5jjUV/JDNySUIPmhvLGOU+1cG/Xie67vkQ==
X-Google-Smtp-Source: APXvYqziatdcegsm47IZ2SKkce4FGwnbnKrzL4YiIlB/LMr7jkFO1bNDTgTsYR7gqNI+FDNZDsSPmQ==
X-Received: by 2002:a63:4823:: with SMTP id v35mr20332666pga.138.1566227206544;
        Mon, 19 Aug 2019 08:06:46 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b126sm3001659pfb.110.2019.08.19.08.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 08:06:46 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Qian Cai <cai@lca.pw>, Tri Vo <trong@android.com>
Subject: [PATCH v2] PM / wakeup: Register wakeup class kobj after device is added
Date:   Mon, 19 Aug 2019 08:06:45 -0700
Message-Id: <20190819150645.178871-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The device_set_wakeup_enable() function can be called on a device that
hasn't been registered with device_add() yet. This allows the device to
be in a state where wakeup is enabled for it but the device isn't
published to userspace in sysfs yet.

After commit 986845e747af ("PM / wakeup: Show wakeup sources stats in
sysfs"), calling device_set_wakeup_enable() will fail for a device that
hasn't been registered with the driver core via device_add(). This is
because we try to create sysfs entries for the device and associate a
wakeup class kobject with it before the device has been registered.
Let's follow a similar approach that device_set_wakeup_capable() takes
here and register the wakeup class either from
device_set_wakeup_enable() when the device is already registered, or
from dpm_sysfs_add() when the device is being registered with the driver
core via device_add().

Fixes: 986845e747af ("PM / wakeup: Show wakeup sources stats in sysfs")
Reported-by: Qian Cai <cai@lca.pw>
Cc: Qian Cai <cai@lca.pw>
Cc: Tri Vo <trong@android.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Changes from v1:
 * Export wakeup_source_sysfs_add/remove stubs
 * New function to check if we should add the device from
   dpm_sysfs_add()

 drivers/base/power/power.h  |  9 +++++++++
 drivers/base/power/sysfs.c  | 10 +++++++++-
 drivers/base/power/wakeup.c | 10 ++++++----
 include/linux/pm_wakeup.h   | 10 ++++++++++
 4 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
index 57b1d1d88c8e..22a1533ec56b 100644
--- a/drivers/base/power/power.h
+++ b/drivers/base/power/power.h
@@ -156,5 +156,14 @@ static inline void device_pm_init(struct device *dev)
 extern int wakeup_source_sysfs_add(struct device *parent,
 				   struct wakeup_source *ws);
 extern void wakeup_source_sysfs_remove(struct wakeup_source *ws);
+#else /* !CONFIG_PM_SLEEP */
+
+static inline int wakeup_source_sysfs_add(struct device *parent,
+					  struct wakeup_source *ws)
+{
+	return 0;
+}
+
+static inline void wakeup_source_sysfs_remove(struct wakeup_source *ws) {}
 
 #endif /* CONFIG_PM_SLEEP */
diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index 1b9c281cbe41..1468d03ae9fb 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -5,6 +5,7 @@
 #include <linux/export.h>
 #include <linux/pm_qos.h>
 #include <linux/pm_runtime.h>
+#include <linux/pm_wakeup.h>
 #include <linux/atomic.h>
 #include <linux/jiffies.h>
 #include "power.h"
@@ -661,14 +662,21 @@ int dpm_sysfs_add(struct device *dev)
 		if (rc)
 			goto err_runtime;
 	}
+	if (!device_has_wakeup_dev(dev)) {
+		rc = wakeup_source_sysfs_add(dev, dev->power.wakeup);
+		if (rc)
+			goto err_wakeup;
+	}
 	if (dev->power.set_latency_tolerance) {
 		rc = sysfs_merge_group(&dev->kobj,
 				       &pm_qos_latency_tolerance_attr_group);
 		if (rc)
-			goto err_wakeup;
+			goto err_wakeup_source;
 	}
 	return 0;
 
+ err_wakeup_source:
+	wakeup_source_sysfs_remove(dev->power.wakeup);
  err_wakeup:
 	sysfs_unmerge_group(&dev->kobj, &pm_wakeup_attr_group);
  err_runtime:
diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index f7925820b5ca..5817b51d2b15 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -220,10 +220,12 @@ struct wakeup_source *wakeup_source_register(struct device *dev,
 
 	ws = wakeup_source_create(name);
 	if (ws) {
-		ret = wakeup_source_sysfs_add(dev, ws);
-		if (ret) {
-			wakeup_source_free(ws);
-			return NULL;
+		if (!dev || device_is_registered(dev)) {
+			ret = wakeup_source_sysfs_add(dev, ws);
+			if (ret) {
+				wakeup_source_free(ws);
+				return NULL;
+			}
 		}
 		wakeup_source_add(ws);
 	}
diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
index 661efa029c96..986f797a8b26 100644
--- a/include/linux/pm_wakeup.h
+++ b/include/linux/pm_wakeup.h
@@ -79,6 +79,11 @@ static inline bool device_may_wakeup(struct device *dev)
 	return dev->power.can_wakeup && !!dev->power.wakeup;
 }
 
+static inline bool device_has_wakeup_dev(struct device *dev)
+{
+	return dev->power.wakeup && !!dev->power.wakeup->dev;
+}
+
 static inline void device_set_wakeup_path(struct device *dev)
 {
 	dev->power.wakeup_path = true;
@@ -165,6 +170,11 @@ static inline bool device_may_wakeup(struct device *dev)
 	return dev->power.can_wakeup && dev->power.should_wakeup;
 }
 
+static inline bool device_has_wakeup_dev(struct device *dev)
+{
+	return false;
+}
+
 static inline void device_set_wakeup_path(struct device *dev) {}
 
 static inline void __pm_stay_awake(struct wakeup_source *ws) {}

base-commit: 0c3d3d648b3ed72b920a89bc4fd125e9b7aa5f23
-- 
Sent by a computer through tubes

