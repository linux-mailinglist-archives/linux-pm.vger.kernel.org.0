Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82962A49C1
	for <lists+linux-pm@lfdr.de>; Sun,  1 Sep 2019 16:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbfIAOJM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Sep 2019 10:09:12 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34676 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfIAOJM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Sep 2019 10:09:12 -0400
Received: by mail-pl1-f193.google.com with SMTP id d3so5416914plr.1;
        Sun, 01 Sep 2019 07:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fKYT/Q77eCD/3HEPx1i1zmLRUie0WoMqRiHpoHxh36o=;
        b=tInX4564sgw+N/M+qaCZ+YJxoQF0qdqYZrc6qJVDBUoNZgrTdLh0aCVMbXX0jIMBM3
         y3hfmLjpmxejy6LFuzHLvbAoUjrnGyZAEIg7palB70SowUf/lRyekfck//hJWTKO/yR+
         L2QklZ6LxwYZkDReQle6Qmu3KkiT/uFbpX5SnAa1XmHstzl9y8lv6ocymw6mvstg7ykb
         9PV1DYvqIqg0uzDuWuTmtFbC8LVMEjXy5imH++Wi55mAIXSEaru6WgCvGtqsMrTysHP7
         tbH6Ysn9Ynpg/M5al37q1WrTr9Y9r2mF/EQ8Zw7BSFFD/ct5dCr7vyMdPVbOXalNu8Pr
         +Efg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fKYT/Q77eCD/3HEPx1i1zmLRUie0WoMqRiHpoHxh36o=;
        b=oDgD5BESFd4Kym1QVvf+dpElC8g0HOx7Vl7d08lUGSnWFc4YfgyUdPG4OVUdaMbvwK
         O2oceEi4OjvVKHWmf0JYDc5KLrCaD5pdSjfobkAw40qV/nZi74Y9z7pKmuXtmuCivgew
         y/OtBM9VOIHXOcDQq3XhM74ad9wkVpJ+eBq2hr9btTaJCucA/Vqv/Ugc+X98raB4hG/x
         F8N52kssEKztmMtuXrGDaCrbOqRUIm7VKGMgugNI++OacW089J4+KW5JWVRakeDQuFfk
         IjerPHciqmt/as1WkC9bcfHxJl+2qL/ckgp4UexRkwxCO0QWBXK2RyMWZMoBdRbzv2EK
         D9Ow==
X-Gm-Message-State: APjAAAXjzLVqywkIyTwH0ukpjB8ohohMdmply8WOf+isOGkWXs1QVFfN
        8hnJUPkdDizDPIvDa+9f4xSkDAqVQRE=
X-Google-Smtp-Source: APXvYqz/F7Fkth7rnT39gaCjaEA5F1mFeNB0UY/ZPihkiaEo0O5k2L3a/SWUYY+JNcOA3QavPnkKaA==
X-Received: by 2002:a17:902:1004:: with SMTP id b4mr24664096pla.340.1567346951321;
        Sun, 01 Sep 2019 07:09:11 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:90ef:3420:44ea:a84])
        by smtp.gmail.com with ESMTPSA id c1sm11985651pfd.117.2019.09.01.07.09.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 01 Sep 2019 07:09:10 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/2] PM-runtime: allow userspace to monitor runtime_status changes
Date:   Sun,  1 Sep 2019 23:08:52 +0900
Message-Id: <1567346932-16744-2-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567346932-16744-1-git-send-email-akinobu.mita@gmail.com>
References: <1567346932-16744-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This enables the /sys/devices/.../power/runtime_status attribute to
allow the user space to get notifications via poll/select when the device
runtime PM status is changed.

An example use case is to avoid unnecessary accesses for device statistics
(e.g. diskstats for block devices) while the device is in runtime suspend
by user space LED device actitity trigger.

Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 Documentation/ABI/testing/sysfs-devices-power | 2 ++
 drivers/base/power/power.h                    | 1 +
 drivers/base/power/runtime.c                  | 1 +
 drivers/base/power/sysfs.c                    | 5 +++++
 4 files changed, 9 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-power b/Documentation/ABI/testing/sysfs-devices-power
index 3e50536..47dc357 100644
--- a/Documentation/ABI/testing/sysfs-devices-power
+++ b/Documentation/ABI/testing/sysfs-devices-power
@@ -269,3 +269,5 @@ Description:
 		the current runtime PM status of the device, which may be
 		"suspended", "suspending", "resuming", "active", "error" (fatal
 		error), or "unsupported" (runtime PM is disabled).
+		This attribute allows the user space to get notifications via
+		poll/select when the device runtime PM status is changed.
diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
index ec33fbdb..8891bf4 100644
--- a/drivers/base/power/power.h
+++ b/drivers/base/power/power.h
@@ -74,6 +74,7 @@ extern int pm_qos_sysfs_add_flags(struct device *dev);
 extern void pm_qos_sysfs_remove_flags(struct device *dev);
 extern int pm_qos_sysfs_add_latency_tolerance(struct device *dev);
 extern void pm_qos_sysfs_remove_latency_tolerance(struct device *dev);
+extern void sysfs_notify_runtime_status(struct device *dev);
 
 #else /* CONFIG_PM */
 
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index b753355..3a3e413 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -94,6 +94,7 @@ static void __update_runtime_status(struct device *dev, enum rpm_status status)
 {
 	update_pm_runtime_accounting(dev);
 	dev->power.runtime_status = status;
+	sysfs_notify_runtime_status(dev);
 }
 
 static u64 rpm_get_accounted_time(struct device *dev, bool suspended)
diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index 1b9c281c..e86d8cb 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -734,3 +734,8 @@ void dpm_sysfs_remove(struct device *dev)
 	sysfs_unmerge_group(&dev->kobj, &pm_wakeup_attr_group);
 	sysfs_remove_group(&dev->kobj, &pm_attr_group);
 }
+
+void sysfs_notify_runtime_status(struct device *dev)
+{
+	sysfs_notify(&dev->kobj, "power", "runtime_status");
+}
-- 
2.7.4

