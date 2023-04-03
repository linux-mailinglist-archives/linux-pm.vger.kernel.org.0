Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7D86D3C4A
	for <lists+linux-pm@lfdr.de>; Mon,  3 Apr 2023 06:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjDCEJY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Apr 2023 00:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjDCEJX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Apr 2023 00:09:23 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A389B7AAF
        for <linux-pm@vger.kernel.org>; Sun,  2 Apr 2023 21:09:22 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id om3-20020a17090b3a8300b0023efab0e3bfso31152293pjb.3
        for <linux-pm@vger.kernel.org>; Sun, 02 Apr 2023 21:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680494962;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IFu94iGKIxr0rnW3XDzndZIjAhiSRiBbITi+tUgIJrA=;
        b=bPnPfkBFJy1+lcAM/vPKfoNGlqE1I9mlXD/IPdHdAj0hGvBd8fh4F9Xu5Z9M8pTkub
         zQ5xhZn4LDVRiAQVUbXPOXXsCXZGLawHNIK0pzCT+yOxM27LGGqkRbMELNKr+jUsiQyc
         Ys1IeooSloMOzGXDcLVm+W9OGuMqYBxWz5E3K/reC9AlOzoNtIYfGr1NsPsgx79jsUBn
         x8md3y8fRNV2mG4DVxirRGNVVmR1QBfPgvvJ7h9JkPgRnWfdwWQ1Nhbm7Zuc4XkztsTU
         +pWIdolBv+8HSyGNwPOyuBzU2Uo+HyWsyqMM0qe3HS4s0QotWsPRi+EHWPIJ77/h4oHR
         cNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680494962;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IFu94iGKIxr0rnW3XDzndZIjAhiSRiBbITi+tUgIJrA=;
        b=rTTQaWC59Cg2YZBzPzCvbDVQapr5QWO4LRZ98myLU0+MLBfeUCHy3dTCZ6v41cxtDp
         9HmbQ4FViw9WVIvp1TLBIq0KgIGe4k5qRhqATHcZo5GRigXpu63WKCd5E/kZduynMC0x
         lj5NCLZVaPtaKJGzQgrjhZQts+IVeZtJxGGFgpvyLPrUcMw140dttM32EN8RtkkF2D+M
         j3ococlh9wzO99lNvjJ8A7E0kAxPzmc1alwePTCiZJ9bFYyORfxajI51UrJZtLFhXrWV
         buIGITa2U3D6IQaUOUcIygDonWAtPbw8KPxTfb7vvsuzzj8zMNTpckvQ1kEVbGyFZx/9
         x8EQ==
X-Gm-Message-State: AAQBX9eVdmh6QPs18d8t1YC7qiuJiCR7BCVJNseir65KtEf902wxUVnz
        7zicx5aVjoMkzQFcZFqVd5Tiaw==
X-Google-Smtp-Source: AKy350Ztxo8NluLvD3pxR8t7snsiPIlnL1Ya/mutyPEglsy3x9PZNamKE3IamXnxOZ+ksOl9IZjFng==
X-Received: by 2002:a17:903:210d:b0:1a2:3b6:8319 with SMTP id o13-20020a170903210d00b001a203b68319mr28578838ple.54.1680494961991;
        Sun, 02 Apr 2023 21:09:21 -0700 (PDT)
Received: from localhost ([122.172.85.168])
        by smtp.gmail.com with ESMTPSA id t8-20020a170902a5c800b0019c2b1c4ad4sm5548816plq.6.2023.04.02.21.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 21:09:21 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Yajun Deng <yajun.deng@linux.dev>, linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: drivers with target_index() must set freq_table
Date:   Mon,  3 Apr 2023 09:39:16 +0530
Message-Id: <53d4ed4e5b18a59a48790434f8146fb207e11c49.1680494945.git.viresh.kumar@linaro.org>
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
 drivers/cpufreq/cpufreq.c    | 5 +++++
 drivers/cpufreq/freq_table.c | 9 ++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

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
index 90bfc27ed1ba..c6fc5b0ea91f 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -10,6 +10,8 @@
 #include <linux/cpufreq.h>
 #include <linux/module.h>
 
+bool has_target_index(void);
+
 /*********************************************************************
  *                     FREQUENCY TABLE HELPERS                       *
  *********************************************************************/
@@ -355,8 +357,13 @@ int cpufreq_table_validate_and_sort(struct cpufreq_policy *policy)
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
-- 
2.31.1.272.g89b43f80a514

