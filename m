Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 510AE351FAC
	for <lists+linux-pm@lfdr.de>; Thu,  1 Apr 2021 21:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235163AbhDATYq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Apr 2021 15:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234491AbhDATY0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Apr 2021 15:24:26 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568E6C0319D9
        for <linux-pm@vger.kernel.org>; Thu,  1 Apr 2021 11:37:12 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id j20-20020a05600c1914b029010f31e15a7fso3322062wmq.1
        for <linux-pm@vger.kernel.org>; Thu, 01 Apr 2021 11:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jKIZkbItowaPQxULRKcIdraIpHfRIarThuC7TM+kRe0=;
        b=QM22qBLSYYovgxkVDG/SwqB17lGS8Jfn07QAw5CWk7M32iFHuCRkFSNPf6e6d2ZlOC
         1mc4y6MUENMBXNNExNJH0GVwMvmm/h02g5zoVsTwSts10DDyaCU2t+/Ol16UbsAmZfzh
         VC/0g3YEnYNRuJohrnogKsazsL8FNSYacBgv31vF6A36gYM2DsG0Hc3+sP5qQIgMCSx6
         +fjDPMD2zTdEN2D5QzEoWaCDCU/2RJaeLO4Xh/DmTgPzGjWozLm6vi7QC7W1br1C+u6E
         xp6F64GNSuenaThmCXoJ7pmP9BN9j35JTL/SS9j5Y90fPUoewcuIrxFTLPTouddOrJvJ
         GVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jKIZkbItowaPQxULRKcIdraIpHfRIarThuC7TM+kRe0=;
        b=LG1c/CAKKng+umyg1diIANw9NzaeZzfIqSaYZPa1LbxJItNcIEn9ecTg/QzAL3+Otv
         T04C4aMHCprnNXz8NQ7vTou5zx5Xdd3TM3PKivuP95EuvZ3cGkhGF8MUw7sA7gBdNegN
         t4S/dRR0JCw5imrHja8AFJgfwFzgowxgoZN+h5+QzKDmLORa6RrK46XicB5HIKTpGHe8
         YDz++GLgFGmCMXy0nQqdDazypEfxtPXepHeDZJmZwWrZsOXuP1awX2VLXz+P1HMzClLN
         D7Ui4+it8R8C1+zUPH/ZXG/9SqgP+779nV/lgpHnbEolK1LlnGmp5iVn503u92tbSz9h
         c19w==
X-Gm-Message-State: AOAM532ZKjS3c15X1zrp/YdYTIljsObhLQ/K2lh/DPoXsfwqqXcUKMAb
        LJsUuKg0ByqlGmgz63pBlOW0ZGEGIAlLrQ==
X-Google-Smtp-Source: ABdhPJzNG3HEPqAipzK217TBu+/uLXZ8OJWI8IgFiMJR9EBdbV3HA9SFm9T7SZHqNX3uxwJs8F5XtQ==
X-Received: by 2002:a1c:94:: with SMTP id 142mr9612353wma.0.1617302231005;
        Thu, 01 Apr 2021 11:37:11 -0700 (PDT)
Received: from localhost.localdomain ([82.142.26.252])
        by smtp.gmail.com with ESMTPSA id b131sm9111490wmb.34.2021.04.01.11.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 11:37:10 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukasz.luba@arm.com, rafael@kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH v6 3/7] powercap/drivers/dtpm: Simplify the dtpm table
Date:   Thu,  1 Apr 2021 20:36:50 +0200
Message-Id: <20210401183654.27214-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210401183654.27214-1-daniel.lezcano@linaro.org>
References: <20210401183654.27214-1-daniel.lezcano@linaro.org>
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
 include/linux/dtpm.h        | 20 +++++++++-----------
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
index a707cc2965a1..d9aac107c927 100644
--- a/drivers/powercap/dtpm.c
+++ b/drivers/powercap/dtpm.c
@@ -583,7 +583,7 @@ int dtpm_register(const char *name, struct dtpm *dtpm, struct dtpm *parent)
 
 static int __init dtpm_init(void)
 {
-	struct dtpm_descr **dtpm_descr;
+	struct dtpm_descr *dtpm_descr;
 
 	pct = powercap_register_control_type(NULL, "dtpm", NULL);
 	if (IS_ERR(pct)) {
@@ -592,7 +592,7 @@ static int __init dtpm_init(void)
 	}
 
 	for_each_dtpm_table(dtpm_descr)
-		(*dtpm_descr)->init(*dtpm_descr);
+		dtpm_descr->init();
 
 	return 0;
 }
diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index 9deafd16a197..74b39a1082e5 100644
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
index 577c71d4e098..2ec2821111d1 100644
--- a/include/linux/dtpm.h
+++ b/include/linux/dtpm.h
@@ -33,25 +33,23 @@ struct dtpm_ops {
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
-- 
2.17.1

