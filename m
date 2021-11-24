Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C09DF45C746
	for <lists+linux-pm@lfdr.de>; Wed, 24 Nov 2021 15:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352370AbhKXObG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Nov 2021 09:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352375AbhKXOa6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Nov 2021 09:30:58 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7217FC12792B
        for <linux-pm@vger.kernel.org>; Wed, 24 Nov 2021 04:55:22 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id s13so4067397wrb.3
        for <linux-pm@vger.kernel.org>; Wed, 24 Nov 2021 04:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ghUVEhvOdMPM8hnbGXgb0N6UgUT3EWuYvvMN4JA07EA=;
        b=oQJj5hVAMy7u0wiJqO2ndgk6q3ojsRidBH05AKCHH3vZHIxzWr/1i73V345ZcbZJCp
         pluyjGSQRE8zPa/C4iAiMHCGe0bDOlqF3hg6nhfVuRsLVfzoe/RL05xzefLLWrzeeXjE
         rAjdmaRBLEw7lhv5+JTPcPOX9mJ8KFl5va3UgKf3e58dBpFnRI1+SH3uIxfI8v2g7QtU
         /9vXLrE7ywZimyAyd1keXIYy5dKjo7nYaxUQGicR48KZv/ywCzxWkSi5YRvHbJ7n3CJT
         AOgA5Lo434icTmnO4mXzCol2My67MWWPIHkR8dFeWced0DRUtPpzfSPnU9A23dnqS0R4
         elLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ghUVEhvOdMPM8hnbGXgb0N6UgUT3EWuYvvMN4JA07EA=;
        b=JAe/6reVJrSJ08M2eibYtcRF+5LAXDFjehYaNV9sgTGos1kqmKUSeT7odqJLRj1IyS
         DN6T0/6XrEISR8ST/kyMg+GRNRNvcSWPMiG8BlncXodMYZMC5jGfH9iapsoST3ozYjrY
         1drDtEKQKevQU1Iqh1jfrL4Mh9MlXTWW2Mm0ilcAwRoxkcIlcB1yA7SGnY+I48m7ui1g
         ccnSXnj6ygBsQA/+MZcNPvdbmLRsHKsrdavP8D2zpBVHXkDS1F6YeXq8cQWBsEIuJsWa
         t/T3B07HepbOJsx8Q2yo7I7RnW0kzhAvv+Ux8scQ0F+tYi7cEtqrF+FaQOfhjVyLo5Tb
         sXAA==
X-Gm-Message-State: AOAM532/69MilgnoY7E2/DMOjGUjM5GjBpMlAJ0quPGg23Cek75RZuNl
        Dup2sM3oCEsugFxy76e1F7U29A==
X-Google-Smtp-Source: ABdhPJxlpgdF5hg+cMXnAogKaLBsAJ5TDlW1lEqovIqCLANX0lMUytsOEGXDgZAd90R5SrSS3gE0uQ==
X-Received: by 2002:a5d:6886:: with SMTP id h6mr16697760wru.287.1637758520904;
        Wed, 24 Nov 2021 04:55:20 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:3395:9073:b941:501e])
        by smtp.gmail.com with ESMTPSA id v8sm14916443wrd.84.2021.11.24.04.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 04:55:20 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org
Cc:     robh@kernel.org, arnd@linaro.org, heiko@sntech.de,
        ulf.hansson@linaro.org, rjw@rjwysocki.net,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, lukasz.luba@arm.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>
Subject: [PATCH 3/5] powercap/drivers/dtpm: Add DT initialization support
Date:   Wed, 24 Nov 2021 13:55:02 +0100
Message-Id: <20211124125506.2971069-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211124125506.2971069-1-daniel.lezcano@linaro.org>
References: <20211124125506.2971069-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The DTPM framework is available but without a way to configure it.

These changes add DT support to initialize the powercap hierarchy via
the powerzones description.

It acts in two steps. First it reads the powerzone dependencies and
build the DTPM hierarchy. Second, it search for all devices which
belongs to a powerzone and attach them to the hierarchy.

This approach makes the initialization self-encapsulated for the DTPM
components.

In order to ensure a nice self-encapsulation, the DTPM table
descriptors contains a couple of initialization functions, one to
setup the DTPM backend and one to initialize it up. With this
approach, the DTPM framework has a very few functions to export.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/powercap/Kconfig    |  1 +
 drivers/powercap/dtpm.c     | 95 +++++++++++++++++++++++++++++++++++--
 drivers/powercap/dtpm_cpu.c |  2 +-
 include/linux/dtpm.h        | 19 +++++++-
 4 files changed, 110 insertions(+), 7 deletions(-)

diff --git a/drivers/powercap/Kconfig b/drivers/powercap/Kconfig
index 8242e8c5ed77..b1ca339957e3 100644
--- a/drivers/powercap/Kconfig
+++ b/drivers/powercap/Kconfig
@@ -46,6 +46,7 @@ config IDLE_INJECT
 
 config DTPM
 	bool "Power capping for Dynamic Thermal Power Management (EXPERIMENTAL)"
+	depends on OF
 	help
 	  This enables support for the power capping for the dynamic
 	  thermal power management userspace engine.
diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
index 0fe70687c198..ebf08c0f489c 100644
--- a/drivers/powercap/dtpm.c
+++ b/drivers/powercap/dtpm.c
@@ -23,6 +23,7 @@
 #include <linux/powercap.h>
 #include <linux/slab.h>
 #include <linux/mutex.h>
+#include <linux/of.h>
 
 #define DTPM_POWER_LIMIT_FLAG 0
 
@@ -461,9 +462,69 @@ int dtpm_register(const char *name, struct dtpm *dtpm, struct dtpm *parent)
 	return 0;
 }
 
-static int __init init_dtpm(void)
+static int dtpm_for_each_child_of(struct device_node *root,
+				  struct device_node *np, struct dtpm *parent)
 {
+	struct device_node *child;
+	struct device_node *pz;
+	struct dtpm *dtpm;
+	int ret;
+
+	for_each_child_of_node(root, child) {
+
+		pz = of_parse_phandle(child, "powerzone", 0);
+		if (pz != np)
+			continue;
+
+		dtpm = kzalloc(sizeof(*dtpm), GFP_KERNEL);
+		if (!dtpm)
+			return -ENOMEM;
+
+		dtpm_init(dtpm, NULL);
+
+		ret = dtpm_register(child->name, dtpm, parent);
+		if (ret) {
+			pr_err("Failed to register dtpm node '%s'\n", child->name);
+			return ret;
+		}
+
+		dtpm_set_data(dtpm, child);
+
+		dtpm_for_each_child_of(root, child, dtpm);
+	}
+
+	return 0;
+}
+
+static int for_each_pz_dtpm(struct dtpm *dtpm, struct device_node *pz,
+			    struct device_node *np, dtpm_setup_t setup)
+{
+	struct dtpm *child;
+	int ret = 0;
+
+	if (dtpm_get_data(dtpm) == pz && setup) {
+		ret = setup(dtpm, np);
+		if (ret)
+			return ret;
+	}
+
+	list_for_each_entry(child, &dtpm->children, sibling)
+		ret |= for_each_pz_dtpm(child, pz, np, setup);
+
+	return ret;
+}
+
+static int dtpm_probe(void)
+{
+	struct device_node *np;
+	struct device_node *pz;
+
 	struct dtpm_descr *dtpm_descr;
+	int ret;
+
+	np = of_find_node_by_name(NULL, "powerzones");
+	if (!np)
+		return 0;
 
 	pct = powercap_register_control_type(NULL, "dtpm", NULL);
 	if (IS_ERR(pct)) {
@@ -471,9 +532,35 @@ static int __init init_dtpm(void)
 		return PTR_ERR(pct);
 	}
 
-	for_each_dtpm_table(dtpm_descr)
-		dtpm_descr->init();
+	ret = dtpm_for_each_child_of(np, NULL, NULL);
+	if (ret) {
+		pr_err("Failed to read powerzones hierarchy: %d\n", ret);
+		goto out_release;
+	}
 
+	for_each_node_with_property(np, "powerzone") {
+
+		pz = of_parse_phandle(np, "powerzone", 0);
+
+		of_node_put(np);
+		if (!pz)
+			continue;
+
+		for_each_dtpm_table(dtpm_descr)
+			for_each_pz_dtpm(root, pz, np, dtpm_descr->setup);
+
+		of_node_put(pz);
+	}
+
+	for_each_dtpm_table(dtpm_descr)
+		if (dtpm_descr->init)
+			dtpm_descr->init();
+	
 	return 0;
+
+out_release:
+	powercap_unregister_control_type(pct);
+
+	return ret;
 }
-late_initcall(init_dtpm);
+late_initcall(dtpm_probe);
diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index b740866b228d..6bffb44c75aa 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -269,4 +269,4 @@ static int __init dtpm_cpu_init(void)
 	return 0;
 }
 
-DTPM_DECLARE(dtpm_cpu, dtpm_cpu_init);
+DTPM_DECLARE(dtpm_cpu, dtpm_cpu_init, NULL);
diff --git a/include/linux/dtpm.h b/include/linux/dtpm.h
index d37e5d06a357..7328682f24c9 100644
--- a/include/linux/dtpm.h
+++ b/include/linux/dtpm.h
@@ -32,23 +32,28 @@ struct dtpm_ops {
 	void (*release)(struct dtpm *);
 };
 
+struct device_node;
+
 typedef int (*dtpm_init_t)(void);
+typedef int (*dtpm_setup_t)(struct dtpm *, struct device_node *);
 
 struct dtpm_descr {
 	dtpm_init_t init;
+	dtpm_setup_t setup;
 };
 
 /* Init section thermal table */
 extern struct dtpm_descr __dtpm_table[];
 extern struct dtpm_descr __dtpm_table_end[];
 
-#define DTPM_TABLE_ENTRY(name, __init)				\
+#define DTPM_TABLE_ENTRY(name, __init, __setup)			\
 	static struct dtpm_descr __dtpm_table_entry_##name	\
 	__used __section("__dtpm_table") = {			\
 		.init = __init,					\
+		.setup = __setup,				\
 	}
 
-#define DTPM_DECLARE(name, init)	DTPM_TABLE_ENTRY(name, init)
+#define DTPM_DECLARE(name, init, setup)	DTPM_TABLE_ENTRY(name, init, setup)
 
 #define for_each_dtpm_table(__dtpm)	\
 	for (__dtpm = __dtpm_table;	\
@@ -60,6 +65,16 @@ static inline struct dtpm *to_dtpm(struct powercap_zone *zone)
 	return container_of(zone, struct dtpm, zone);
 }
 
+static inline void dtpm_set_data(struct dtpm *dtpm, void *data)
+{
+	powercap_set_zone_data(&dtpm->zone, data);
+}
+
+static inline void *dtpm_get_data(struct dtpm *dtpm)
+{
+	return powercap_get_zone_data(&dtpm->zone);
+}
+
 int dtpm_update_power(struct dtpm *dtpm);
 
 int dtpm_release_zone(struct powercap_zone *pcz);
-- 
2.25.1

