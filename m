Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26AB1338E53
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 14:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhCLNKE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 08:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbhCLNJt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 08:09:49 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DD6C061761
        for <linux-pm@vger.kernel.org>; Fri, 12 Mar 2021 05:09:49 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id e10so4764182wro.12
        for <linux-pm@vger.kernel.org>; Fri, 12 Mar 2021 05:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y+3de1AeeAJ1f3wvK6vHJ9cHErXRUBGiuppggQN/HY8=;
        b=Pkgj/hKqaE5pZ9CRW1TFxEV3VYj479VPkYabx0stapmnfeYvEipZ62n4iTBYqKsvlG
         0d9JosIdJZp26i9crzbWxJMw15hpPU/hxsJ17qd5uNj2sO+x6SQ6qteZjiPaspB4p3Qj
         dbQa+tw5W4FoPXr5D1ka+3DwwifS+40VImXpTU1aTJX661EwlB31jS0QFu4Ni1E3zum9
         rd++tKPJbXVVk5mHdMTBOpX1/EnJDeDZXYh2y2tB6Bzue2pNvzX628DUnN1lJGyvOgzg
         IK11/3zPDOmaaiYXnrnZZbv0Ojl+NET2GOw8S8jiXNvn1GxTyPyScJvSCMXsYOsJ/GvP
         QNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y+3de1AeeAJ1f3wvK6vHJ9cHErXRUBGiuppggQN/HY8=;
        b=X2od+fYJLn+y9a5hHXqunBldfy/FWBFpza/UwyBgMILZOhi27fq60ymbxUhfotrgcO
         V6R5SaEDV6nOGPWKndUjjYm6MraIzBaq/y3NZHxno4KZDdWzn0JJqB/xkDrb48NOSY7X
         VprszKX5G2yGapvaw1shjnk40Ug3JLhxsOIZzJYpJpUrEKDkPcL3PdrB+kEU3WbM4sV1
         xHd1UNYXpKMTO3Y963g2ofI8fxdc78vYXynxLHoOpETlWHUEoJC0qmwUQUb1+6dnYWCo
         93py316bTKhqTynPLCO5Fk6opaiXqsOsrSGeKkrl4iHHy3FrK+K1dHANTeoGyD//yJK8
         QqQA==
X-Gm-Message-State: AOAM531XPoiIU9jsNe5VdLP2XSHUN3V4l+o0GQy5d5juyxS51ya2jlN3
        eqVkrPtBMcNjI7xz0UQBwN0tcQ==
X-Google-Smtp-Source: ABdhPJw9ebKQtQQ182M7ifS/1h/w2PaM5a9w1mmxlyNwCIRROQkuBDHiCIfrG0dWrOfW9iATnVxnGQ==
X-Received: by 2002:a5d:4445:: with SMTP id x5mr14268622wrr.30.1615554588225;
        Fri, 12 Mar 2021 05:09:48 -0800 (PST)
Received: from localhost.localdomain ([82.142.0.212])
        by smtp.gmail.com with ESMTPSA id q15sm7655033wrr.58.2021.03.12.05.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 05:09:47 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com
Subject: [PATCH v4 3/5] powercap/drivers/dtpm: Simplify the dtpm table
Date:   Fri, 12 Mar 2021 14:04:09 +0100
Message-Id: <20210312130411.29833-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210312130411.29833-1-daniel.lezcano@linaro.org>
References: <20210312130411.29833-1-daniel.lezcano@linaro.org>
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
index 8592a78e47e4..c4fa35fabc40 100644
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

