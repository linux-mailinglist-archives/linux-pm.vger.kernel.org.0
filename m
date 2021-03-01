Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13CC432939D
	for <lists+linux-pm@lfdr.de>; Mon,  1 Mar 2021 22:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240491AbhCAV3I (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Mar 2021 16:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244234AbhCAVXq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Mar 2021 16:23:46 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A91C061793
        for <linux-pm@vger.kernel.org>; Mon,  1 Mar 2021 13:23:06 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id a18so9463125wrc.13
        for <linux-pm@vger.kernel.org>; Mon, 01 Mar 2021 13:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tdxUTGi9m/Gz5i3ZHWaGA+tNFidX5BqMkBrNPYV1F7w=;
        b=KM2HsdgmAOVLJ1XnyzbihJMlr8Fmo8S4dS1XE40nyf802ZCVjhThMwBuViSrCwPEYp
         W1HPDn+yN4tm3QqxdFwb6ItVi5mCFxFV9T9pMbc3s5ZfHRfCSDJTLq22lWPaE84n9Y5D
         MM+b0sy+zysJy7LMXUJQAThlED5fZM2zBWM9+Tokh1Dl1wi9/dFIN1EKEyB9IB4ZFiiC
         Nssx+OFx2DmKMgpvA4V269Srznwf6tzHDNmZ4gR9YQkb3fVwS8IhGvYJMkwHTCbKKznO
         J7YZX/Qk2OYQzim7Xjau1V6mnXnwVV+omdsa3narIoOl/YFuDq97NCm6gm2p97oWBe72
         ZhTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tdxUTGi9m/Gz5i3ZHWaGA+tNFidX5BqMkBrNPYV1F7w=;
        b=NY2QombJvMw7hcgyiGmIeaz1APNHvLF+kWH3cFg1ekAWddG9QZn3URnIppBLCxZzOR
         7kqRs7NmYR4wxmtmmMk8YiMPU6hlZ/upQhk+7dG8osb8NND6FyYCTMAb0BCqA6aPxca1
         lis86vUiquxJ6klRzGiFhIbEG3EnAFJkK27h2FXU4ptJvC8x0gC20SIWRpzf7p937foX
         P+/6wOm18sATQyaQ8v8AdMqRGl+keAHUdPMShWeY7sM91SHUymnQzDlfrXG+rZ4pBOkZ
         U6S9ZGJmaNOHqLKyJedYRGhjg1xe1f+eHLvnFRS/ne2pJab/1eELEvdFm0zwA9xy4VeT
         rRqA==
X-Gm-Message-State: AOAM532NiJg9WFQHd2lkjuOJIKda7lZV38DczvYiP2lh/v6KcK/3LQfs
        KERvC6sfJuxgzDl2ezuEb41leQ==
X-Google-Smtp-Source: ABdhPJwr4ucvJyW+l8AOCC+PsIIT1OFFFxKB09wXQbxwBkRKSy9D67rvMxqXwNwgykCH+/uPW2Ydag==
X-Received: by 2002:a5d:570b:: with SMTP id a11mr18660666wrv.281.1614633785103;
        Mon, 01 Mar 2021 13:23:05 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-144-192.adsl.proxad.net. [82.252.144.192])
        by smtp.gmail.com with ESMTPSA id o11sm6783866wrq.74.2021.03.01.13.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 13:23:04 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 3/5] powercap/drivers/dtpm: Simplify the dtpm table
Date:   Mon,  1 Mar 2021 22:21:47 +0100
Message-Id: <20210301212149.22877-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210301212149.22877-1-daniel.lezcano@linaro.org>
References: <20210301212149.22877-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The dtpm table is an array of pointers, that forces the user of the
table to define initdata along with the declaration of the table
entry. It is more efficient to create an array of dtpm structure, so
the declaration of the table entry can be done by initializing the
different fields.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/powercap/dtpm.c     |  4 ++--
 drivers/powercap/dtpm_cpu.c |  4 +++-
 include/linux/dtpm.h        | 22 +++++++++-------------
 3 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
index 20728a28ff0d..a1a70dc48f63 100644
--- a/drivers/powercap/dtpm.c
+++ b/drivers/powercap/dtpm.c
@@ -607,7 +607,7 @@ int dtpm_create(const char *name, struct dtpm *dtpm, struct dtpm *parent)
 
 static int __init dtpm_init(void)
 {
-	struct dtpm_descr **dtpm_descr;
+	struct dtpm_descr *dtpm_descr;
 
 	pct = powercap_register_control_type(NULL, "dtpm", NULL);
 	if (IS_ERR(pct)) {
@@ -616,7 +616,7 @@ static int __init dtpm_init(void)
 	}
 
 	for_each_dtpm_table(dtpm_descr)
-		(*dtpm_descr)->init(*dtpm_descr);
+		dtpm_descr->init();
 
 	return 0;
 }
diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index 1a10537c4434..c5fe98eeec52 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -207,7 +207,7 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
 	return ret;
 }
 
-int dtpm_register_cpu(struct dtpm *parent)
+static int __init dtpm_cpu_init(void)
 {
 	int ret;
 
@@ -223,3 +223,5 @@ int dtpm_register_cpu(struct dtpm *parent)
 
 	return 0;
 }
+
+DTPM_DECLARE(dtpm_cpu, dtpm_cpu_init);
diff --git a/include/linux/dtpm.h b/include/linux/dtpm.h
index 447ea6c60b59..8a2dbbc334b9 100644
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

