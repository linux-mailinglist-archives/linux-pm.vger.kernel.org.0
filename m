Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B52F2333AF1
	for <lists+linux-pm@lfdr.de>; Wed, 10 Mar 2021 12:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbhCJLCr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Mar 2021 06:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbhCJLCT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Mar 2021 06:02:19 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689B1C061760
        for <linux-pm@vger.kernel.org>; Wed, 10 Mar 2021 03:02:19 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id e10so22790882wro.12
        for <linux-pm@vger.kernel.org>; Wed, 10 Mar 2021 03:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MUZ+0f1MMpnUEJ4a2J6EdFMV+wQUIe9TSPtGUldR/hk=;
        b=y0iHqhxGqdzHFL8wfLSo6jm347ZGXsAdHL8hB108DF0MgZmBNmJGhNXA3nURpmzP9R
         abp//oR3F9XH2AkwvGm73nfbIgpQ5etzjh0Iy1EDw44xa0meeCekCOBUUeGxOvHImon3
         GGq2U58SzGoLG5oHyFNAfj6LUVigNi1tpWiQrq90ss6/AWkiBI9JbuohUa2uqpyNUXx5
         bC2C5/FGogFcHndxS9gNeIpEVzFKLDix5JOaEa9yWuujb8OCyzSAFox7qres52K3tzhV
         QYmli1GxoGWk0moXdVCxiKThjzqL8+2sVES9lC0bGGfnRzycsD9c+U6WQBGAJaPw5NLE
         DmxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MUZ+0f1MMpnUEJ4a2J6EdFMV+wQUIe9TSPtGUldR/hk=;
        b=TrxEOYv2qvJkDINRY6J3hKcBexEKXhjnjqo5QEkqpGwh4vCZ0wALKbtybkLiEdKv6E
         mn1NIk9HWnwelyz1xGXNCfbJivNRyt+zwIEgpN0q8scWyl8JyyrXBFS6GDqSdGSoMDXk
         wrDx9CfiEwbAs0UR4PtOiUEzmqdFaWFaFj3Gu8eyGIMKAdbmShp/FlxDy4jadQs89wdM
         tsD+iQR32XejeGXm8dioGb1FLFRXyL++X8ztr1l+jjXKYPv/0o2S9zNjmn0P0k7/Myqs
         SJ2F+IzfYCfFeRYXj8sdPU134kwtk7fylRK3BHWTY0ShWmsT+2VMXxoEG6NkFC0uqOH/
         TtmQ==
X-Gm-Message-State: AOAM533ywumGu1Vc5i960GDP5s8IEzJ3slxhVJ+r8VYa8f3WSd9Y9FuU
        zi149eBfwq8DwvXO8rYMNgABxw==
X-Google-Smtp-Source: ABdhPJyzSobxPU8N7LXQOoOASI5Q6oJTiH5/RRsocNmqz+1DJa7GmDLKGP1Rr2FR5SjPrd8II8zxpA==
X-Received: by 2002:adf:ed46:: with SMTP id u6mr2885348wro.350.1615374138108;
        Wed, 10 Mar 2021 03:02:18 -0800 (PST)
Received: from localhost.localdomain ([82.142.0.212])
        by smtp.gmail.com with ESMTPSA id k4sm36193902wrd.9.2021.03.10.03.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 03:02:17 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com
Subject: [PATCH v3 3/5] powercap/drivers/dtpm: Simplify the dtpm table
Date:   Wed, 10 Mar 2021 12:02:10 +0100
Message-Id: <20210310110212.26512-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210310110212.26512-1-daniel.lezcano@linaro.org>
References: <20210310110212.26512-1-daniel.lezcano@linaro.org>
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

