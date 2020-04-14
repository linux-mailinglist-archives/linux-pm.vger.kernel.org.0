Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD5A1A8E40
	for <lists+linux-pm@lfdr.de>; Wed, 15 Apr 2020 00:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634171AbgDNWJM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Apr 2020 18:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2634161AbgDNWJC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Apr 2020 18:09:02 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9BAC061A0C
        for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2020 15:09:02 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id r26so16257036wmh.0
        for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2020 15:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1LHaTJUSb6YlKNJo8uEXGOXHLnntD8wG0lKLYJJal8o=;
        b=pDG1h0WC2l6d+f8gKVw4nIQv4pwuJvFp5v/pEj2Ej+aQGcAYfdxMwxHlGR2KPikBrG
         gm3LjeGPmIer6c6UQcjCLwsewXTnPsijjzDGXkIjU1goeSIBqj9/rujqCsi1G2/tqonr
         JU3A3l89/ENhF1HfgBjCb79ZfDWmUkIlnmph8vbjCrPNjv/+OTh6ZWF8pl+FiNOR+ieK
         SIb5805ZLif7vcibXWvbr2D3dbjNsq+nisSOV01wv2z6Da3AZyCGidMHeYPJTymBnPYw
         XUlrMDABgf7VreSSN0/5Wisng7C2roZHe9ev+0honyQY4Vkn3GrGX2xVtKeLwUfMCfVc
         l0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1LHaTJUSb6YlKNJo8uEXGOXHLnntD8wG0lKLYJJal8o=;
        b=XRKuRDQ7fD8zHeIrSxxLwuefaQeWu5d3ck07wnwGsD8zELT6O3K1uaxJGegv+pWQ0E
         /IWtbLbFbj2z+TU+xQn2OM29nzdVeHa3Hb/8HQYluF37hTWjtTkvRR12bxK5gAgDE+PN
         2M2Xgy9GW+VvsGzuXwW8OMgT7uO0Wn8jTV0D1/yFci55lAj9YN/vI5af1D4eAOEQWl46
         X7w+M0Bc4geS1ofwEk4+GyuOI2oIX7t9G70CIGdi7BHJV7CRx1mnI9f1sgCH64nCoQZG
         sfO54e/0w3t5ltIuvkodwcLWXJvoUGDvvnAikB9QdiQuzA7iHqaqRgQe5ebz1jiJrczN
         W8AA==
X-Gm-Message-State: AGi0PubZbkd9ffZ+eS6GmGbJEYyJJAtXECuQIo6WvMEwnVzdDevPudNn
        jesgsmgQNEG05GN08CHZ8HE4Fg==
X-Google-Smtp-Source: APiQypIRvJtGrIVTCK0IyHmrOcpJv9MiXSRrpOpgvddruNqcOcON9TV5nJ6vkoKOsKdMyUBeF3QwXg==
X-Received: by 2002:a05:600c:414b:: with SMTP id h11mr1899810wmm.9.1586902140997;
        Tue, 14 Apr 2020 15:09:00 -0700 (PDT)
Received: from localhost.localdomain (lns-bzn-59-82-252-135-148.adsl.proxad.net. [82.252.135.148])
        by smtp.gmail.com with ESMTPSA id a7sm4099973wrs.61.2020.04.14.15.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 15:09:00 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     amit.kucheria@verdurent.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-pm@vger.kernel.org (open list:CPU IDLE TIME MANAGEMENT FRAMEWORK),
        linux-kernel@vger.kernel.org (open list),
        linux-arm-kernel@lists.infradead.org (open list:CPUIDLE DRIVER - ARM
        PSCI)
Subject: [PATCH v3 4/4] thermal: cpuidle: Register cpuidle cooling device
Date:   Wed, 15 Apr 2020 00:08:33 +0200
Message-Id: <20200414220837.9284-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200414220837.9284-1-daniel.lezcano@linaro.org>
References: <20200414220837.9284-1-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The cpuidle driver can be used as a cooling device by injecting idle
cycles. The DT binding for the idle state added an optional

When the property is set, register the cpuidle driver with the idle
state node pointer as a cooling device. The thermal framework will do
the association automatically with the thermal zone via the
cooling-device defined in the device tree cooling-maps section.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/cpuidle-arm.c  | 5 +++++
 drivers/cpuidle/cpuidle-psci.c | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
index 9e5156d39627..2406ac0ae134 100644
--- a/drivers/cpuidle/cpuidle-arm.c
+++ b/drivers/cpuidle/cpuidle-arm.c
@@ -8,6 +8,7 @@
 
 #define pr_fmt(fmt) "CPUidle arm: " fmt
 
+#include <linux/cpu_cooling.h>
 #include <linux/cpuidle.h>
 #include <linux/cpumask.h>
 #include <linux/cpu_pm.h>
@@ -124,6 +125,10 @@ static int __init arm_idle_init_cpu(int cpu)
 	if (ret)
 		goto out_kfree_drv;
 
+	ret = cpuidle_cooling_register(drv);
+	if (ret)
+		pr_err("Failed to register the idle cooling device: %d\n", ret);
+
 	return 0;
 
 out_kfree_drv:
diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index edd7a54ef0d3..8e805bff646f 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -9,6 +9,7 @@
 #define pr_fmt(fmt) "CPUidle PSCI: " fmt
 
 #include <linux/cpuhotplug.h>
+#include <linux/cpu_cooling.h>
 #include <linux/cpuidle.h>
 #include <linux/cpumask.h>
 #include <linux/cpu_pm.h>
@@ -305,6 +306,10 @@ static int __init psci_idle_init_cpu(int cpu)
 	if (ret)
 		goto out_kfree_drv;
 
+	ret = cpuidle_cooling_register(drv);
+	if (ret)
+		pr_err("Failed to register the idle cooling device: %d\n", ret);
+
 	return 0;
 
 out_kfree_drv:
-- 
2.17.1

