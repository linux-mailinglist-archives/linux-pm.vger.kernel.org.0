Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69B7C94C19
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2019 19:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbfHSRzC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Aug 2019 13:55:02 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40411 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728029AbfHSRzA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Aug 2019 13:55:00 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10so1633448pgj.7
        for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2019 10:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9NWqr+JwdmE3rUyb4GdgfL9AWwSk6AGcDeb8dqG/3fI=;
        b=WnIVT8J6ydLfYohb/i6W/6e6E4sr9avxUmY+kYCvTxcFFgbxjCYkajaGmESPRhjLga
         MVhdgupHHBTl7iRw7M3DSl6aYndsFOCy2uCiGHcXWe3VsXSzeM2acatE3sSRsXeJw3tx
         3tnhsuwQA3btPeZMiEYrf4HpuQUKikqswwitA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9NWqr+JwdmE3rUyb4GdgfL9AWwSk6AGcDeb8dqG/3fI=;
        b=nrFH7ZRHNwJao+hS8LVQ/C9rnj2V861lohwwPuitxnwOcvJR2jA5m7S1K60FCuSv36
         zA8JEN4hfNUv5KKHOBWAD6ym1FkZ+0EwUC8MNR8ckl4S/7+/ct7Kz/xgb0rxyVRUIFoX
         WwEgTBSgU7r9bUm7DsW6ANCug8cVdc+cFcIqwz5iZ4FSROmk1rCvSTMrJktrTvJwzxOg
         XKe9mVaA2YTws4L0luc5UvH5w0IX9/kB/L9owbKzVz4/GACdVAaitj2boDiUYonrHx/N
         Kj47MON639ID805Ia1q6rmRJLDU6x3UMp33Zs6wGN6ZpypIxAJSXAmTkBGX+pCtaox9i
         6tsA==
X-Gm-Message-State: APjAAAVuHwxKJzhnFBcnli+HAQi4GMtNDxVbZ2VI86gpnga0i9JlGmQ+
        yAgqy+nxZ41knAPyak9SMG9LVg==
X-Google-Smtp-Source: APXvYqy/WmipOp/bujsN9XYr+d/NMKC+GGDvLofB6HbJ7WHUJzfxux53Z20LzHZjX0dfT1F281IjZw==
X-Received: by 2002:aa7:90c9:: with SMTP id k9mr24648990pfk.171.1566237299915;
        Mon, 19 Aug 2019 10:54:59 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id h197sm18084237pfe.67.2019.08.19.10.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 10:54:59 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Qian Cai <cai@lca.pw>, Tri Vo <trong@android.com>
Subject: [PATCH v3 1/2] PM / wakeup: Register wakeup class kobj after device is added
Date:   Mon, 19 Aug 2019 10:54:56 -0700
Message-Id: <20190819175457.231058-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
In-Reply-To: <20190819175457.231058-1-swboyd@chromium.org>
References: <20190819175457.231058-1-swboyd@chromium.org>
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

Any different name for pm_wakeup_source_sysfs_add() is fine with me.

 drivers/base/power/power.h        |  9 +++++++++
 drivers/base/power/sysfs.c        |  6 ++++++
 drivers/base/power/wakeup.c       | 10 ++++++----
 drivers/base/power/wakeup_stats.c | 13 +++++++++++++
 4 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
index 57b1d1d88c8e..39a06a0cfdaa 100644
--- a/drivers/base/power/power.h
+++ b/drivers/base/power/power.h
@@ -157,4 +157,13 @@ extern int wakeup_source_sysfs_add(struct device *parent,
 				   struct wakeup_source *ws);
 extern void wakeup_source_sysfs_remove(struct wakeup_source *ws);
 
+extern int pm_wakeup_source_sysfs_add(struct device *parent);
+
+#else /* !CONFIG_PM_SLEEP */
+
+static inline int pm_wakeup_source_sysfs_add(struct device *parent)
+{
+	return 0;
+}
+
 #endif /* CONFIG_PM_SLEEP */
diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index 1b9c281cbe41..d7d82db2e4bc 100644
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
@@ -667,8 +668,13 @@ int dpm_sysfs_add(struct device *dev)
 		if (rc)
 			goto err_wakeup;
 	}
+	rc = pm_wakeup_source_sysfs_add(dev);
+	if (rc)
+		goto err_latency;
 	return 0;
 
+ err_latency:
+	sysfs_unmerge_group(&dev->kobj, &pm_qos_latency_tolerance_attr_group);
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
diff --git a/drivers/base/power/wakeup_stats.c b/drivers/base/power/wakeup_stats.c
index 220a20ff8918..bc5e3945f7a8 100644
--- a/drivers/base/power/wakeup_stats.c
+++ b/drivers/base/power/wakeup_stats.c
@@ -184,6 +184,19 @@ int wakeup_source_sysfs_add(struct device *parent, struct wakeup_source *ws)
 }
 EXPORT_SYMBOL_GPL(wakeup_source_sysfs_add);
 
+/**
+ * pm_wakeup_source_sysfs_add - Add wakeup_source attributes to sysfs
+ * for a device if they're missing.
+ * @parent: Device given wakeup source is associated with
+ */
+int pm_wakeup_source_sysfs_add(struct device *parent)
+{
+	if (!parent->power.wakeup || parent->power.wakeup->dev)
+		return 0;
+
+	return wakeup_source_sysfs_add(parent, parent->power.wakeup);
+}
+
 /**
  * wakeup_source_sysfs_remove - Remove wakeup_source attributes from sysfs.
  * @ws: Wakeup source to be removed from sysfs.
-- 
Sent by a computer through tubes

