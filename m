Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B167E497188
	for <lists+linux-pm@lfdr.de>; Sun, 23 Jan 2022 13:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236343AbiAWMtr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Jan 2022 07:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbiAWMtr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Jan 2022 07:49:47 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0AAC06173B
        for <linux-pm@vger.kernel.org>; Sun, 23 Jan 2022 04:49:46 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id d12-20020a17090a628c00b001b4f47e2f51so14944465pjj.3
        for <linux-pm@vger.kernel.org>; Sun, 23 Jan 2022 04:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H4VFK06JndyOFW8C0SfR310BagEjOeINyHP/kSf4B1U=;
        b=mGvQlJVtSt6O4MtaGftzlhmTWrOVF8/RbP7HmD4g1GAhzinE8zfSpAOx/FH9PCy1hZ
         0IaHXJW520J4k011Xzwf1mTogfp1rr1YhlugGBjZce+0+d4qfBXfAJG6F9Q3Q6GCivl+
         TKoKPTDJFjJBXn7kY961XzpAfYwevhKyrKLWBw4dwTXk8I/bjlxujVKvQX7OxGYP8ixP
         /Evnu1kfE5kirymKb+GesLRFdfh/p4513X2X83mvTXwdPk/8+n30+r0Kwl+iJFlFXWl2
         X3jVzK4Vq66erBURCHXOsFghAsHrgBfv80xrSEPQ90xo1GN8Sa98v85ua6MFuGVngZ2J
         bR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H4VFK06JndyOFW8C0SfR310BagEjOeINyHP/kSf4B1U=;
        b=iYpLYbhJudOaAPylcUQbCZgW8elOxtRJKYQjgyPvo5jFH2eSNDn5sasCYrGDHKy8rW
         lEWlesYdtvXkBgrL08L4uinBwkY9l5GFC7z5++UIaZNXehwjOSuJmK1oA8iBmngnvAuy
         0jSw7KJb++3cnlqSKuji32761pgGDQcJwRzGxxrURNn8GEX+QJ5ZF3MCI7S/UZ9LAflu
         iywF275XC2HU9MQDABDTufev/gt5N1u2vGYHccpKwL/dKLLl4kiK3ddCV0y4e/fgBqvT
         20kYLmaS/lZe24eDuph7KWJzgSPdlJxZOW7f1F7KkHRGOciNwO6KsdGCOWBh7Z8Y8+90
         jFKQ==
X-Gm-Message-State: AOAM530wY8bxPL32vgwsr0yeHMbtgeBkiXq78RF57/lUtlE/iJT27xQ6
        qTWzzyPG8oHNFuh6zPcyvNA6FdOYG5P3vA==
X-Google-Smtp-Source: ABdhPJx0GwqNjUAV5Satjqlf4IVfHdvbqsV0eId+JIpWHOdPxDGIxbyzsncvxsmq90QMCqNvmGDspQ==
X-Received: by 2002:a17:90a:550e:: with SMTP id b14mr9054799pji.98.1642942185931;
        Sun, 23 Jan 2022 04:49:45 -0800 (PST)
Received: from pek-lpggp6.wrs.com (unknown-105-123.windriver.com. [147.11.105.123])
        by smtp.gmail.com with ESMTPSA id om6sm9765972pjb.24.2022.01.23.04.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 04:49:45 -0800 (PST)
From:   Kevin Hao <haokexin@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/3] cpufreq: Move to_gov_attr_set() to cpufreq.h
Date:   Sun, 23 Jan 2022 20:45:06 +0800
Message-Id: <20220123124508.463305-1-haokexin@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

So it can be reused by other codes.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/cpufreq/cpufreq_governor_attr_set.c | 5 -----
 include/linux/cpufreq.h                     | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor_attr_set.c b/drivers/cpufreq/cpufreq_governor_attr_set.c
index a6f365b9cc1a..771770ea0ed0 100644
--- a/drivers/cpufreq/cpufreq_governor_attr_set.c
+++ b/drivers/cpufreq/cpufreq_governor_attr_set.c
@@ -8,11 +8,6 @@
 
 #include "cpufreq_governor.h"
 
-static inline struct gov_attr_set *to_gov_attr_set(struct kobject *kobj)
-{
-	return container_of(kobj, struct gov_attr_set, kobj);
-}
-
 static inline struct governor_attr *to_gov_attr(struct attribute *attr)
 {
 	return container_of(attr, struct governor_attr, attr);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 1ab29e61b078..f0dfc0b260ec 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -658,6 +658,11 @@ struct gov_attr_set {
 /* sysfs ops for cpufreq governors */
 extern const struct sysfs_ops governor_sysfs_ops;
 
+static inline struct gov_attr_set *to_gov_attr_set(struct kobject *kobj)
+{
+	return container_of(kobj, struct gov_attr_set, kobj);
+}
+
 void gov_attr_set_init(struct gov_attr_set *attr_set, struct list_head *list_node);
 void gov_attr_set_get(struct gov_attr_set *attr_set, struct list_head *list_node);
 unsigned int gov_attr_set_put(struct gov_attr_set *attr_set, struct list_head *list_node);
-- 
2.31.1

