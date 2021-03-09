Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA20B3331AD
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 23:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbhCIWnC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 17:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhCIWm4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Mar 2021 17:42:56 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13807C06174A
        for <linux-pm@vger.kernel.org>; Tue,  9 Mar 2021 14:42:56 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id d15so19103647wrv.5
        for <linux-pm@vger.kernel.org>; Tue, 09 Mar 2021 14:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MUZ+0f1MMpnUEJ4a2J6EdFMV+wQUIe9TSPtGUldR/hk=;
        b=s822vc9+x/Dq+3b8vhn5JB+q6n/TaZFZTgy5tpUU+Ly/AMYvK9PjZDZ+UOucjXSTxG
         gahynK+1hhzvPDnPurnEUaU4lqdVWA+TpooeaFJptOOvxGHEPs3UqG1hELM/WkndTM3K
         AlqG9RhLBSUp06dp1/FOYM4b5d8v7IJ9I9tm1fReqgcjofWK3jJq9S9SliQLwtSJAys/
         m59+G8HYrdD5XFmbpnpQ8ByJV41BNhChGbi/R6nBLP/h/L4QDKf5USrnPjR0UAo8rapD
         jdYM4Wss+MSFYs4Wbbr87mRQXXzt6aE40AHv8kXxdBCxeeqMqCATuK/fjo2NrPpuQsjt
         5hjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MUZ+0f1MMpnUEJ4a2J6EdFMV+wQUIe9TSPtGUldR/hk=;
        b=Tkdnkq/OVSiTm+bvAt82335RQnPGEZedBF9zhLrT67Mjm6AjvHkqFw+SciueIeGpNJ
         3o2fREKjhP7aIDNJ39tdd5IGJQit4VKApQ+1DYFiEx9iXyE5fAZFx0Mk1w+1Ah2E6J2s
         7aubM1uA/hqqEx8hVQFKgdXJ2RLuOs1R7p+Hp/quc6Ol+VZH5tRmE1x010KusMAFC5Q1
         NXkY2s7QOksnZn2O6TcKkX+ahukXZ1hxqNd3Rtq8dYC7r3fAc6NQFK0V8rY9T0s8kO0k
         6jInYgGpQ8aVTLFh0S+xmvsvakQppZmH3m8TB7ewN/j4yvF8p8Z6Z0pi/7pK23VekXfu
         nOZA==
X-Gm-Message-State: AOAM530NPfkSq3u/OefyIjAjvBeJXJhzWpP82oUmlVYQ+YJ9TqxguHbp
        kdN0EYcGwUU1LFfyZLK5s1GmRg==
X-Google-Smtp-Source: ABdhPJzUyV6I1QijS8Ko0ei9rDgjs/1XxzRU35MtbjUtjHeyZrSHnsjlQEaisXWTscLgowYi6RsmRQ==
X-Received: by 2002:adf:f148:: with SMTP id y8mr128607wro.107.1615329774764;
        Tue, 09 Mar 2021 14:42:54 -0800 (PST)
Received: from localhost.localdomain ([82.142.0.212])
        by smtp.gmail.com with ESMTPSA id p16sm30352179wrt.54.2021.03.09.14.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 14:42:54 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com
Subject: [PATCH v2 3/5] powercap/drivers/dtpm: Simplify the dtpm table
Date:   Tue,  9 Mar 2021 23:42:42 +0100
Message-Id: <20210309224244.27225-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210309224244.27225-1-daniel.lezcano@linaro.org>
References: <20210309224244.27225-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The dtpm table is an array of pointers, that forces the user of the
table to define initdata along with the declaration of the table
entry. It is more efficient to create an array of dtpm structure, so
the declaration of the table entry can be done by initializing the
different fields.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/powercap/dtpm.c     |  4 ++--
 drivers/powercap/dtpm_cpu.c |  4 +++-
 include/linux/dtpm.h        | 22 +++++++++-------------
 3 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
index d00f55f0ee30..74d9603bd42a 100644
--- a/drivers/powercap/dtpm.c
+++ b/drivers/powercap/dtpm.c
@@ -610,7 +610,7 @@ int dtpm_create(const char *name, struct dtpm *dtpm, struct dtpm *parent)
 
 static int __init dtpm_init(void)
 {
-	struct dtpm_descr **dtpm_descr;
+	struct dtpm_descr *dtpm_descr;
 
 	pct = powercap_register_control_type(NULL, "dtpm", NULL);
 	if (IS_ERR(pct)) {
@@ -619,7 +619,7 @@ static int __init dtpm_init(void)
 	}
 
 	for_each_dtpm_table(dtpm_descr)
-		(*dtpm_descr)->init(*dtpm_descr);
+		dtpm_descr->init();
 
 	return 0;
 }
diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index 628d4d6d83a6..983f1ca27dc3 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -204,7 +204,7 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
 	return ret;
 }
 
-int dtpm_register_cpu(struct dtpm *parent)
+static int __init dtpm_cpu_init(void)
 {
 	int ret;
 
@@ -241,3 +241,5 @@ int dtpm_register_cpu(struct dtpm *parent)
 
 	return 0;
 }
+
+DTPM_DECLARE(dtpm_cpu, dtpm_cpu_init);
diff --git a/include/linux/dtpm.h b/include/linux/dtpm.h
index d724c5a7b2f4..5f71ddc18ee9 100644
--- a/include/linux/dtpm.h
+++ b/include/linux/dtpm.h
@@ -34,25 +34,23 @@ struct dtpm_ops {
 	void (*release)(struct dtpm *);
 };
 
-struct dtpm_descr;
-
-typedef int (*dtpm_init_t)(struct dtpm_descr *);
+typedef int (*dtpm_init_t)(void);
 
 struct dtpm_descr {
-	struct dtpm *parent;
-	const char *name;
 	dtpm_init_t init;
 };
 
 /* Init section thermal table */
-extern struct dtpm_descr *__dtpm_table[];
-extern struct dtpm_descr *__dtpm_table_end[];
+extern struct dtpm_descr __dtpm_table[];
+extern struct dtpm_descr __dtpm_table_end[];
 
-#define DTPM_TABLE_ENTRY(name)			\
-	static typeof(name) *__dtpm_table_entry_##name	\
-	__used __section("__dtpm_table") = &name
+#define DTPM_TABLE_ENTRY(name, __init)				\
+	static struct dtpm_descr __dtpm_table_entry_##name	\
+	__used __section("__dtpm_table") = {			\
+		.init = __init,					\
+	}
 
-#define DTPM_DECLARE(name)	DTPM_TABLE_ENTRY(name)
+#define DTPM_DECLARE(name, init)	DTPM_TABLE_ENTRY(name, init)
 
 #define for_each_dtpm_table(__dtpm)	\
 	for (__dtpm = __dtpm_table;	\
@@ -74,8 +72,6 @@ void dtpm_destroy(struct dtpm *dtpm);
 
 int dtpm_create(const char *name, struct dtpm *dtpm, struct dtpm *parent);
 
-int dtpm_register_cpu(struct dtpm *parent);
-
 int dtpm_register(const char *name, struct dtpm *dtpm);
 
 void dtpm_unregister(const char *name);
-- 
2.17.1

