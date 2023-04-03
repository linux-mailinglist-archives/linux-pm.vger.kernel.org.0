Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347DE6D553D
	for <lists+linux-pm@lfdr.de>; Tue,  4 Apr 2023 01:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbjDCXjU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Apr 2023 19:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233254AbjDCXjT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Apr 2023 19:39:19 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FD12135
        for <linux-pm@vger.kernel.org>; Mon,  3 Apr 2023 16:39:17 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id f22so25517131plr.0
        for <linux-pm@vger.kernel.org>; Mon, 03 Apr 2023 16:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680565157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+VWH39BR0tD6TBtRTKZDQy+oD+lySCuKW3DMMxt3hqg=;
        b=RxAH5qDLmYwGqJXMkUgVLQVRjMkXkXLckmIw9n6mxYJeoCP/UzVXGjVRzQ7XY851sM
         0RX4dM5b7K1QpO0fui5gh/jCsAlXX9T/iBtK0ffusFBvd+uzd4U3LDYHHjFVHUyan2FP
         i3MqW5gf+WeUaxQOhfYttC8x0FsaJ6b8RWKyKBKbWZsjTJiLNhQMizVgu/3kp4/le+dk
         YLg4iItrnOOChEkkZRlXnI4iX8dTn9z+RBQM43yA/qiH4VqGNWa5iLIFiCyDAqo9AEnM
         VjvuTgNqF+FUZfHTvQsksWLoTCnpaoiK9My25RBCL8pnnut9fuXUyYsdRLG6a51o7oCI
         MFRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680565157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+VWH39BR0tD6TBtRTKZDQy+oD+lySCuKW3DMMxt3hqg=;
        b=dfcLh23mshGG5/FoS4Dh6Hc+gAM163aeHmZbxObwXMuCDwn+aAIEAUzGTzeLWh+H6K
         4knqtgK3htoahHgflvRPcsOBB+oLXTnKcGr2JxybwNtfG3oEWtdeRuIu3ojNbndK151a
         KCcA+VkHodkK3PJb0MGdUxTaEViU7cM2nxqsgQOsCN659egm9slQUUdy1V89a84aQoUl
         mxjQC1c4wMx0Z8JnDr/F+uUPHidNIaNe0VMDPkp55YCVVXqqyidHRq60vfvVv5lEgm/v
         caRAlzfOdXg3Kjb5Su0r41/ZD1Q9682QiJoElvTy7dP3SqJ7jrcJy/OeaWRbtmTHBGl3
         0Z0w==
X-Gm-Message-State: AAQBX9fv30J9ShbLuGgzLIO6nHbfGgLGaKgNvKlIaxw143n2yqRPtCkz
        CcQYXNjB1XDxxgu6C/Xq3CP6IQ==
X-Google-Smtp-Source: AKy350ZFDJVctO+b0DsBbl5q+31FsKlMlzHJTkWV4cpWoAfrkbXtTUCzU8OfqSI2a3S4wyzemChAEw==
X-Received: by 2002:a05:6a20:65a1:b0:cc:a8d7:ad7e with SMTP id p33-20020a056a2065a100b000cca8d7ad7emr328230pzh.60.1680565157151;
        Mon, 03 Apr 2023 16:39:17 -0700 (PDT)
Received: from localhost ([122.172.85.8])
        by smtp.gmail.com with ESMTPSA id c22-20020aa78816000000b005a8b28c644esm7526545pfo.4.2023.04.03.16.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 16:39:16 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Yajun Deng <yajun.deng@linux.dev>, linux-kernel@vger.kernel.org
Subject: [PATCH V2] cpufreq: drivers with target_index() must set freq_table
Date:   Tue,  4 Apr 2023 05:09:10 +0530
Message-Id: <8c788b8029b3a11f012915dad6154e7cc481f997.1680563899.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Since the cpufreq core directly uses freq_table, for cpufreq drivers
that set their target_index() callback, make it mandatory for them to
set the same.

Since this is set per policy and normally from policy->init(), do this
from cpufreq_table_validate_and_sort() which gets called right after
->init().

Reported-by: Yajun Deng <yajun.deng@linux.dev>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V2: Move declaration to cpufreq.h.

 drivers/cpufreq/cpufreq.c    | 5 +++++
 drivers/cpufreq/freq_table.c | 7 ++++++-
 include/linux/cpufreq.h      | 1 +
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 6d8fd3b8dcb5..09131c54703f 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -73,6 +73,11 @@ static inline bool has_target(void)
 	return cpufreq_driver->target_index || cpufreq_driver->target;
 }
 
+bool has_target_index(void)
+{
+	return !!cpufreq_driver->target_index;
+}
+
 /* internal prototypes */
 static unsigned int __cpufreq_get(struct cpufreq_policy *policy);
 static int cpufreq_init_governor(struct cpufreq_policy *policy);
diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index 90bfc27ed1ba..c4d4643b6ca6 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -355,8 +355,13 @@ int cpufreq_table_validate_and_sort(struct cpufreq_policy *policy)
 {
 	int ret;
 
-	if (!policy->freq_table)
+	if (!policy->freq_table) {
+		/* Freq table must be passed by drivers with target_index() */
+		if (has_target_index())
+			return -EINVAL;
+
 		return 0;
+	}
 
 	ret = cpufreq_frequency_table_cpuinfo(policy, policy->freq_table);
 	if (ret)
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 65623233ab2f..541013487a0e 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -237,6 +237,7 @@ bool cpufreq_supports_freq_invariance(void);
 struct kobject *get_governor_parent_kobj(struct cpufreq_policy *policy);
 void cpufreq_enable_fast_switch(struct cpufreq_policy *policy);
 void cpufreq_disable_fast_switch(struct cpufreq_policy *policy);
+bool has_target_index(void);
 #else
 static inline unsigned int cpufreq_get(unsigned int cpu)
 {
-- 
2.31.1.272.g89b43f80a514

