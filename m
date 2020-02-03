Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53756150A1D
	for <lists+linux-pm@lfdr.de>; Mon,  3 Feb 2020 16:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgBCPps (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Feb 2020 10:45:48 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:35238 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbgBCPpr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Feb 2020 10:45:47 -0500
Received: by mail-pj1-f65.google.com with SMTP id q39so6598515pjc.0;
        Mon, 03 Feb 2020 07:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JyS09fTXqCgfMqvRZ+BlVT4vb3SNbwWixmfuMn82Wus=;
        b=va1Y23/Dt1OTf4zMwQrWKUzkv0ug+Eb1ELDUFXEXTXj1n1HfSL4Zl44YAcO9tpKmQw
         n5RC15bY6uQwQMOtJjBe08PJY29sC3nk/jINiAbFVj/Tp926UWivuTBkVeKF+D7xJ3io
         w92FdoVchAn0oI6Zu/BWWERnzqx0t03OS3n01EW1IpargCqCEFM0cunr00DJin/I+AMq
         smXHUUKnBayba01JP9tn4QFq4nW7ykuCmq1uheTZw9UEKizGn5SYe4zOEMpFVupZoNVP
         4ZKWbpb2xXRkIcE6ohpE+saMP23uSFVLv+CuYoEI6egEVGOA8Ey3s9Ze9266hTtL89Ym
         m+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JyS09fTXqCgfMqvRZ+BlVT4vb3SNbwWixmfuMn82Wus=;
        b=r7sSEgvUL92VgQojWVtmUSczolMlLZcnfVE7icVKLaKll5qgXfBXVAJSwjcIqy6AaC
         +MtjxQmQxHtKs4w7ZRwXNsMEtRxQ5gs/Bjo0EGOmbSfEG59BFj2n+Y7s3WTPjGLPCkem
         gAzWdixzavJiS+ODGmlBS3mX1L4r0XNIZ49yXaHstt71WQ53DyH6xxmQjj2Ja7lKvdpz
         wIi5wxbIj3LquYhaptf8bCDqqEBVkmSXFBKhs21wjm48RU75duObOtYn8sxHAbEYuC3g
         3kgniKCUd9e2KoW6SxfnAcrskYt1vxoyxYxvSx/PR35Uwm1WAFKZE6I//ISvoZedo6dp
         dK6g==
X-Gm-Message-State: APjAAAUzh/zIgxg5MFulhBQc+D4NS5pfwiaOCmXbk6ZJvCA+uOENOjw3
        GqRei2+rf4jCUWuXCEUuwYeQhjJZ
X-Google-Smtp-Source: APXvYqydgJ4ZZc45ZDxrZOII/LQJHOId7HwH/4C+OHIif4mcfbgPMPOAZbUe/U0ppEahIKUrywq3NA==
X-Received: by 2002:a17:90b:11d0:: with SMTP id gv16mr30407161pjb.109.1580744746520;
        Mon, 03 Feb 2020 07:45:46 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id m71sm272290pje.0.2020.02.03.07.45.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Feb 2020 07:45:45 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] cpufreq: make cpufreq_global_kobject static
Date:   Mon,  3 Feb 2020 15:45:17 +0000
Message-Id: <20200203154517.2347-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The cpufreq_global_kobject is only used internally by cpufreq.c
after this:

commit 2361be236662 ("cpufreq: Don't create empty
/sys/devices/system/cpu/cpufreq directory")

Make it static.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/cpufreq/cpufreq.c | 4 +---
 include/linux/cpufreq.h   | 3 ---
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 4adac3a8c265..a0831d3d5ed1 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -105,6 +105,7 @@ bool have_governor_per_policy(void)
 }
 EXPORT_SYMBOL_GPL(have_governor_per_policy);
 
+static struct kobject *cpufreq_global_kobject;
 struct kobject *get_governor_parent_kobj(struct cpufreq_policy *policy)
 {
 	if (have_governor_per_policy())
@@ -2745,9 +2746,6 @@ int cpufreq_unregister_driver(struct cpufreq_driver *driver)
 }
 EXPORT_SYMBOL_GPL(cpufreq_unregister_driver);
 
-struct kobject *cpufreq_global_kobject;
-EXPORT_SYMBOL(cpufreq_global_kobject);
-
 static int __init cpufreq_core_init(void)
 {
 	if (cpufreq_disabled())
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 018dce868de6..0fb561d1b524 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -201,9 +201,6 @@ static inline bool policy_is_shared(struct cpufreq_policy *policy)
 	return cpumask_weight(policy->cpus) > 1;
 }
 
-/* /sys/devices/system/cpu/cpufreq: entry point for global variables */
-extern struct kobject *cpufreq_global_kobject;
-
 #ifdef CONFIG_CPU_FREQ
 unsigned int cpufreq_get(unsigned int cpu);
 unsigned int cpufreq_quick_get(unsigned int cpu);
-- 
2.17.1

