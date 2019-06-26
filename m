Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 491B755D1A
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2019 02:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfFZAzz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 20:55:55 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34024 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfFZAzz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jun 2019 20:55:55 -0400
Received: by mail-pf1-f196.google.com with SMTP id c85so335535pfc.1
        for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2019 17:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZH9pz9jwu4qSUkcBx6Vk/IqRHzhjHUsyIVkpL60Swl8=;
        b=D0An4mBXSqsbKOerqmMG76my0jFonSgGoQ9lXTNwC0lnsi/GzYY7tNkjG7ML8PFCTe
         L5SZ6mA6NgROf/H9yufsFfuF8/LnGduD1GqMzR6qfPDIj04iI8IzoQFewEF++vkILogv
         lOnHarWlXSjiOgaWsnbyORbPpuNUGrO53ImPsJ6sh3nWUPckZzyN/OfxhXnwF5KSQHUF
         iTdNNtAfRr2hjRHFvhwNUc4ywAq/7L6N6nYD/D4kmsK1rRprQGrXVaNsZvQxtV2fmuFK
         2Bt9mieJl8ER+LXcPErd94oc1vvh99y36jXdAXMgnt2YRRAzdTFGsBCIz8SidrqrPkef
         mxdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZH9pz9jwu4qSUkcBx6Vk/IqRHzhjHUsyIVkpL60Swl8=;
        b=MkgySCDFoIEMA+WSnmj4uYD/4Tp75tg3JQa2TkBngCNZ7c028XcEllmh2QVqkH/8Ht
         Z8/AEhKknmO9wMHV5akYTkJ5b3Z1zSaAQ7v9nRKQw4aqhRPonodikeCa52UmyGfnYNsV
         udCb/dQboPmUMmfOcMPjtt9CYhZdpQjIYXNje7w4YOgJTBZ35PvAUdg7rjgJdVAe601x
         4RE9StyBvTbhDr2dXWdIaDo5vkUTxtnC3YsNhyMYp4imZISzGpMFi0JPyNibs/+ztfHR
         Nd0Myxz+qNqMBDcvUwVEHKq8dOO7P+/8VDs+IYM3jG/nw0k1Yo0zKGjHGfVZB7STTWYT
         vgKg==
X-Gm-Message-State: APjAAAWXlP6PrNfz+HQ7KJlxGKq2dqweD/71p81j96Hq+g7dHVUhzJNk
        lbz1QemFW0KjT9wY0FjYoFTz2Q==
X-Google-Smtp-Source: APXvYqyQTqBfnDtdh3tfNZjdlWeKq9e5/FbK5oG0V3qRl993CrBe2nXpuXTJ8A1GTshr6x3yDEUXig==
X-Received: by 2002:a17:90a:cd04:: with SMTP id d4mr925767pju.128.1561510554543;
        Tue, 25 Jun 2019 17:55:54 -0700 (PDT)
Received: from trong0.mtv.corp.google.com ([2620:0:1000:1601:acd:159c:264f:41eb])
        by smtp.gmail.com with ESMTPSA id f197sm16227499pfa.161.2019.06.25.17.55.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 17:55:54 -0700 (PDT)
From:   Tri Vo <trong@android.com>
To:     rjw@rjwysocki.net, gregkh@linuxfoundation.org,
        viresh.kumar@linaro.org
Cc:     rafael@kernel.org, hridya@google.com, sspatil@google.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel-team@android.com--annotate, Tri Vo <trong@android.com>
Subject: [PATCH] PM / wakeup: show wakeup sources stats in sysfs
Date:   Tue, 25 Jun 2019 17:54:49 -0700
Message-Id: <20190626005449.225796-1-trong@android.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Userspace can use wakeup_sources debugfs node to plot history of suspend
blocking wakeup sources over device's boot cycle. This information can
then be used (1) for power-specific bug reporting and (2) towards
attributing battery consumption to specific processes over a period of
time.

However, debugfs doesn't have stable ABI. For this reason, expose wakeup
sources statistics in sysfs under /sys/power/wakeup_sources/<name>/

Add following attributes to each wakeup source. These attributes match
the columns of /sys/kernel/debug/wakeup_sources.

  active_count
  event_count
  wakeup_count
  expire_count
  active_time (named "active_since" in debugfs)
  total_time
  max_time
  last_change
  prevent_suspend_time

Embedding a struct kobject into struct wakeup_source changes lifetime
requirements on the latter. To that end, change deallocation of struct
wakeup_source using kfree to kobject_put().

Signed-off-by: Tri Vo <trong@android.com>
---
 drivers/base/power/Makefile       |   2 +-
 drivers/base/power/wakeup.c       |  13 +-
 drivers/base/power/wakeup_sysfs.c | 204 ++++++++++++++++++++++++++++++
 include/linux/pm_wakeup.h         |   9 ++
 kernel/power/wakelock.c           |  13 +-
 5 files changed, 236 insertions(+), 5 deletions(-)
 create mode 100644 drivers/base/power/wakeup_sysfs.c

diff --git a/drivers/base/power/Makefile b/drivers/base/power/Makefile
index e1bb691cf8f1..e6ea9eb46275 100644
--- a/drivers/base/power/Makefile
+++ b/drivers/base/power/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_PM)	+= sysfs.o generic_ops.o common.o qos.o runtime.o wakeirq.o
-obj-$(CONFIG_PM_SLEEP)	+= main.o wakeup.o
+obj-$(CONFIG_PM_SLEEP)	+= main.o wakeup.o wakeup_sysfs.o
 obj-$(CONFIG_PM_TRACE_RTC)	+= trace.o
 obj-$(CONFIG_PM_GENERIC_DOMAINS)	+=  domain.o domain_governor.o
 obj-$(CONFIG_HAVE_CLK)	+= clock_ops.o
diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 5b2b6a05a4f3..6fcbb4d2045f 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -96,12 +96,22 @@ EXPORT_SYMBOL_GPL(wakeup_source_prepare);
 struct wakeup_source *wakeup_source_create(const char *name)
 {
 	struct wakeup_source *ws;
+	int ret;
 
 	ws = kmalloc(sizeof(*ws), GFP_KERNEL);
 	if (!ws)
 		return NULL;
 
 	wakeup_source_prepare(ws, name ? kstrdup_const(name, GFP_KERNEL) : NULL);
+
+	ws->kobj.kset = wakeup_source_kset;
+	ret = kobject_init_and_add(&ws->kobj, &wakeup_source_ktype, NULL, "%s",
+			ws->name);
+	if (ret) {
+		kobject_put(&ws->kobj);
+		return NULL;
+	}
+
 	return ws;
 }
 EXPORT_SYMBOL_GPL(wakeup_source_create);
@@ -147,8 +157,7 @@ void wakeup_source_destroy(struct wakeup_source *ws)
 
 	__pm_relax(ws);
 	wakeup_source_record(ws);
-	kfree_const(ws->name);
-	kfree(ws);
+	kobject_put(&ws->kobj);
 }
 EXPORT_SYMBOL_GPL(wakeup_source_destroy);
 
diff --git a/drivers/base/power/wakeup_sysfs.c b/drivers/base/power/wakeup_sysfs.c
new file mode 100644
index 000000000000..d872afc645d9
--- /dev/null
+++ b/drivers/base/power/wakeup_sysfs.c
@@ -0,0 +1,204 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/slab.h>
+
+#include "power.h"
+
+struct wakeup_source_attribute {
+	struct attribute attr;
+	ssize_t (*show)(struct wakeup_source *ws,
+			struct wakeup_source_attribute *attr, char *buf);
+	ssize_t (*store)(struct wakeup_source *ws,
+			 struct wakeup_source_attribute *attr, const char *buf,
+			 size_t count);
+};
+
+#define to_wakeup_source_obj(x) container_of(x, struct wakeup_source, kobj)
+#define to_wakeup_source_attr(x) \
+	container_of(x, struct wakeup_source_attribute, attr)
+
+static ssize_t wakeup_source_attr_show(struct kobject *kobj,
+				       struct attribute *attr,
+				       char *buf)
+{
+	struct wakeup_source_attribute *attribute;
+	struct wakeup_source *ws;
+
+	ws = to_wakeup_source_obj(kobj);
+	attribute = to_wakeup_source_attr(attr);
+
+	if (!attribute->show)
+		return -EIO;
+
+	return attribute->show(ws, attribute, buf);
+}
+
+static const struct sysfs_ops wakeup_source_sysfs_ops = {
+	.show = wakeup_source_attr_show,
+};
+
+static void wakeup_source_release(struct kobject *kobj)
+{
+	struct wakeup_source *ws;
+
+	ws = to_wakeup_source_obj(kobj);
+	kfree_const(ws->name);
+	kfree(ws);
+}
+
+static ssize_t wakeup_source_count_show(struct wakeup_source *ws,
+					struct wakeup_source_attribute *attr,
+					char *buf)
+{
+	unsigned long flags;
+	unsigned long var;
+
+	spin_lock_irqsave(&ws->lock, flags);
+	if (strcmp(attr->attr.name, "active_count") == 0)
+		var = ws->active_count;
+	else if (strcmp(attr->attr.name, "event_count") == 0)
+		var = ws->event_count;
+	else if (strcmp(attr->attr.name, "wakeup_count") == 0)
+		var = ws->wakeup_count;
+	else
+		var = ws->expire_count;
+	spin_unlock_irqrestore(&ws->lock, flags);
+
+	return sprintf(buf, "%lu\n", var);
+}
+
+#define wakeup_source_count_attr(_name)			\
+static struct wakeup_source_attribute _name##_attr = {	\
+	.attr	= {					\
+		.name = __stringify(_name),		\
+		.mode = 0444,				\
+	},						\
+	.show	= wakeup_source_count_show,		\
+}
+
+wakeup_source_count_attr(active_count);
+wakeup_source_count_attr(event_count);
+wakeup_source_count_attr(wakeup_count);
+wakeup_source_count_attr(expire_count);
+
+#define wakeup_source_attr(_name) \
+static struct wakeup_source_attribute _name##_attr = __ATTR_RO(_name)
+
+static ssize_t active_time_show(struct wakeup_source *ws,
+				struct wakeup_source_attribute *attr,
+				char *buf)
+{
+	unsigned long flags;
+	ktime_t active_time;
+
+	spin_lock_irqsave(&ws->lock, flags);
+	active_time = ws->active ? ktime_sub(ktime_get(), ws->last_time) : 0;
+	spin_unlock_irqrestore(&ws->lock, flags);
+	return sprintf(buf, "%lld\n", ktime_to_ms(active_time));
+}
+wakeup_source_attr(active_time);
+
+static ssize_t total_time_show(struct wakeup_source *ws,
+			       struct wakeup_source_attribute *attr,
+			       char *buf)
+{
+	unsigned long flags;
+	ktime_t active_time;
+	ktime_t total_time;
+
+	spin_lock_irqsave(&ws->lock, flags);
+	total_time = ws->total_time;
+	if (ws->active) {
+		active_time = ktime_sub(ktime_get(), ws->last_time);
+		total_time = ktime_add(total_time, active_time);
+	}
+	spin_unlock_irqrestore(&ws->lock, flags);
+	return sprintf(buf, "%lld\n", ktime_to_ms(total_time));
+}
+wakeup_source_attr(total_time);
+
+static ssize_t max_time_show(struct wakeup_source *ws,
+			     struct wakeup_source_attribute *attr,
+			     char *buf)
+{
+	unsigned long flags;
+	ktime_t active_time;
+	ktime_t max_time;
+
+	spin_lock_irqsave(&ws->lock, flags);
+	max_time = ws->max_time;
+	if (ws->active) {
+		active_time = ktime_sub(ktime_get(), ws->last_time);
+		if (active_time > max_time)
+			max_time = active_time;
+	}
+	spin_unlock_irqrestore(&ws->lock, flags);
+	return sprintf(buf, "%lld\n", ktime_to_ms(max_time));
+}
+wakeup_source_attr(max_time);
+
+static ssize_t last_change_show(struct wakeup_source *ws,
+				struct wakeup_source_attribute *attr,
+				char *buf)
+{
+	unsigned long flags;
+	ktime_t last_time;
+
+	spin_lock_irqsave(&ws->lock, flags);
+	last_time = ws->last_time;
+	spin_unlock_irqrestore(&ws->lock, flags);
+	return sprintf(buf, "%lld\n", ktime_to_ms(last_time));
+}
+wakeup_source_attr(last_change);
+
+static ssize_t prevent_suspend_time_show(struct wakeup_source *ws,
+					 struct wakeup_source_attribute *attr,
+					 char *buf)
+{
+	unsigned long flags;
+	ktime_t prevent_sleep_time;
+
+	spin_lock_irqsave(&ws->lock, flags);
+	prevent_sleep_time = ws->prevent_sleep_time;
+	if (ws->active && ws->autosleep_enabled) {
+		prevent_sleep_time = ktime_add(prevent_sleep_time,
+			ktime_sub(ktime_get(), ws->start_prevent_time));
+	}
+	spin_unlock_irqrestore(&ws->lock, flags);
+	return sprintf(buf, "%lld\n", ktime_to_ms(prevent_sleep_time));
+}
+wakeup_source_attr(prevent_suspend_time);
+
+static struct attribute *wakeup_source_default_attrs[] = {
+	&active_count_attr.attr,
+	&event_count_attr.attr,
+	&wakeup_count_attr.attr,
+	&expire_count_attr.attr,
+	&active_time_attr.attr,
+	&total_time_attr.attr,
+	&max_time_attr.attr,
+	&last_change_attr.attr,
+	&prevent_suspend_time_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(wakeup_source_default);
+
+struct kobj_type wakeup_source_ktype = {
+	.sysfs_ops = &wakeup_source_sysfs_ops,
+	.release = wakeup_source_release,
+	.default_groups = wakeup_source_default_groups,
+};
+
+struct kset *wakeup_source_kset;
+
+static int __init wakeup_sources_sysfs_init(void)
+{
+	wakeup_source_kset = kset_create_and_add("wakeup_sources", NULL,
+			power_kobj);
+	if (!wakeup_source_kset)
+		return -ENOMEM;
+
+	return 0;
+}
+
+postcore_initcall(wakeup_sources_sysfs_init);
diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
index ce57771fab9b..9af3bdd50557 100644
--- a/include/linux/pm_wakeup.h
+++ b/include/linux/pm_wakeup.h
@@ -57,6 +57,7 @@ struct wakeup_source {
 	unsigned long		wakeup_count;
 	bool			active:1;
 	bool			autosleep_enabled:1;
+	struct kobject		kobj;
 };
 
 #ifdef CONFIG_PM_SLEEP
@@ -100,6 +101,10 @@ extern void pm_relax(struct device *dev);
 extern void pm_wakeup_ws_event(struct wakeup_source *ws, unsigned int msec, bool hard);
 extern void pm_wakeup_dev_event(struct device *dev, unsigned int msec, bool hard);
 
+/* drivers/base/power/wakeup_sysfs.c */
+extern struct kobj_type wakeup_source_ktype;
+extern struct kset *wakeup_source_kset;
+
 #else /* !CONFIG_PM_SLEEP */
 
 static inline void device_set_wakeup_capable(struct device *dev, bool capable)
@@ -179,6 +184,10 @@ static inline void pm_wakeup_ws_event(struct wakeup_source *ws,
 static inline void pm_wakeup_dev_event(struct device *dev, unsigned int msec,
 				       bool hard) {}
 
+/* drivers/base/power/wakeup_sysfs.c */
+static struct kobj_type wakeup_source_ktype;
+static struct kset *wakeup_source_kset;
+
 #endif /* !CONFIG_PM_SLEEP */
 
 static inline void wakeup_source_init(struct wakeup_source *ws,
diff --git a/kernel/power/wakelock.c b/kernel/power/wakelock.c
index 4210152e56f0..71535eebfbbf 100644
--- a/kernel/power/wakelock.c
+++ b/kernel/power/wakelock.c
@@ -124,8 +124,7 @@ static void __wakelocks_gc(struct work_struct *work)
 			wakeup_source_remove(&wl->ws);
 			rb_erase(&wl->node, &wakelocks_tree);
 			list_del(&wl->lru);
-			kfree(wl->name);
-			kfree(wl);
+			kobject_put(&wl->ws->kobj);
 			decrement_wakelocks_number();
 		}
 	}
@@ -153,6 +152,7 @@ static struct wakelock *wakelock_lookup_add(const char *name, size_t len,
 	struct rb_node **node = &wakelocks_tree.rb_node;
 	struct rb_node *parent = *node;
 	struct wakelock *wl;
+	int ret;
 
 	while (*node) {
 		int diff;
@@ -189,6 +189,15 @@ static struct wakelock *wakelock_lookup_add(const char *name, size_t len,
 	}
 	wl->ws.name = wl->name;
 	wl->ws.last_time = ktime_get();
+
+	wl->ws.kobj.kset = wakeup_source_kset;
+	ret = kobject_init_and_add(&wl->ws.kobj, &wakeup_source_ktype, NULL,
+			"%s", wl->ws.name);
+	if (ret) {
+		kobject_put(&wl->ws.kobj);
+		return ERR_PTR(ret);
+	}
+
 	wakeup_source_add(&wl->ws);
 	rb_link_node(&wl->node, parent, node);
 	rb_insert_color(&wl->node, &wakelocks_tree);
-- 
2.22.0.410.gd8fdbe21b5-goog

