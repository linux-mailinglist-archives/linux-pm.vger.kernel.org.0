Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19057950F8
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2019 00:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbfHSWmF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Aug 2019 18:42:05 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43900 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728689AbfHSWmC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Aug 2019 18:42:02 -0400
Received: by mail-pl1-f196.google.com with SMTP id 4so1661855pld.10
        for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2019 15:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=avU/iuX5+szENCh6eMm7vCYspNq4hdUwgbH/njQngfc=;
        b=OFND1rmgXyw6LWuY+eLUQRwxvnMhRmpu5MjaxbTwDcTsnS3b0DDRG2yncdO95+ASAn
         6W5aClKomCmX8LC9MdjfJiSb/bE3p3pYKdNr2IRBI5oEtZAsjoGRxITfKj2d/p0jD6ZQ
         YH8iaFIW+Omeh8uDSnOwMgSDqAKOo5tBwspFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=avU/iuX5+szENCh6eMm7vCYspNq4hdUwgbH/njQngfc=;
        b=uNoTN7N0hRhX813S4+LQNWs46n0Je90gO0BSmnsQAmj1eEvCmIiq01ODCcGix+/h0y
         ouxligm4vJHtS4SVuyZVuNJ38/ASJPDrVqFh9487Un0MVjNzB3rQbEYeLluwqU4SAmD7
         hnOrtYYkIuPe8uu54UY8IbEyhbslgSYvpV3M+wugPapf7hs0ghsXqK4lhhHFwEvPxkFF
         SV4K9PdQH76ZoX1aHUyhGMOZvRwuxTUISqWZvFKb5es0TbrOb8i/oEfIEGvhWcwadzaZ
         B2ZQNrY/Jeaqgokz8TmAc1/ikiuKjq/jE4pdjaXwzWJ1B8YoFpI+PfF/5zTnIxwI0RCe
         pzdg==
X-Gm-Message-State: APjAAAXGZyhwigJeE8wLpdspYAMhpslPrXYPDeCSGSXS+H8ahwHoSl4Y
        CmgR4UQ0CUK/jW1ld0eZixYZXLg/ZmV6vQ==
X-Google-Smtp-Source: APXvYqwXdWR0/1wtcv66DD8YVP1tY0at57N7sr2iIEC2dKXHGQ3aZmiWV4/HLCtdF3OfUaFVkZbpAg==
X-Received: by 2002:a17:902:346:: with SMTP id 64mr25022324pld.151.1566254521350;
        Mon, 19 Aug 2019 15:42:01 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id e9sm16841593pge.39.2019.08.19.15.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 15:42:00 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Qian Cai <cai@lca.pw>, Tri Vo <trong@android.com>
Subject: [PATCH v4 1/2] PM / wakeup: Register wakeup class kobj after device is added
Date:   Mon, 19 Aug 2019 15:41:57 -0700
Message-Id: <20190819224158.62954-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
In-Reply-To: <20190819224158.62954-1-swboyd@chromium.org>
References: <20190819224158.62954-1-swboyd@chromium.org>
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
Reviewed-by: Tri Vo <trong@android.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
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

