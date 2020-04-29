Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC99C1BD9C4
	for <lists+linux-pm@lfdr.de>; Wed, 29 Apr 2020 12:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgD2Kh2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Apr 2020 06:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgD2Kh2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Apr 2020 06:37:28 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2267C03C1AE
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2020 03:37:27 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 188so1454660wmc.2
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2020 03:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ajg0V3YAnieY8dp7jTqVJrYiDVgIPrXCOEB/FDyd0IQ=;
        b=DIXfay/duBznmXB5ADvUzPnyxxtfIxj2kizhan9HisAwxNdjLTa9l9i34gr0wqk+xa
         2uanBNCtdDDTcrKxiKdyuGrCXH7HBG+yfZXWa2pdBp8lCpCnGKL0Ls2zQkox09/Mpzhw
         FZGjZ7b4fdPWGsKhHWwwHmbv/9x9fX8Wz+BHSQZYT+yxx89w0Fiqa8v3d5jRt8Jbtf8s
         8s5RCIs36RQOsJvNFWuPXx7N6wNGWHwA5BhBM8VCLlZAfOlTHJQCLZ0mudu5YNzTwJbf
         u7P+sm/ev50j2OXnv85QUHDySZCx66DCWZOUPqqDrwJi29iaIJ/S6F81weuQ/XuYqzRe
         RFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ajg0V3YAnieY8dp7jTqVJrYiDVgIPrXCOEB/FDyd0IQ=;
        b=jeKMjmXFLEBkiMhfxVBdIkBaaoiixETtPpjPySTF9cPZ4NSu35XoizB18BC69/z4c4
         DKU3+YGpNH87NLbCXPVXTe1bLzKsGRVYi4u3WePjbRZ1a+xNxhRbfTcTiJB+yZTFWieK
         lp6ome1HU4QEzgJ5ppCd0CBdAdgNLo7xMXc/RHe0er7npx8P2NjxUA5GNruZw+R1saJw
         JuGOvxgA/KZ27BhZuQGvknZ0EPpo8HZJJ16Pp6jmNB35INfmJcIr9A+S/sS8oRc8O1mL
         DGC7MAD29w/hH14v4g/2GZRhx+AnT18jAa4CxnzXTEbDWaxZlitJJrEnrXh8Arr5LRet
         X9HA==
X-Gm-Message-State: AGi0PuYvCa/Zi8/r1az8ByolL53mkomqfnaO+h3uIDTG6NOgzWY/b2w6
        sXp8uLNSNAe6/zqkllB2i6L8fA==
X-Google-Smtp-Source: APiQypL2Sn2tfnITVPTTIZTbiEuPWWxOp8fRjGWJTovGUEqEE9S7DWyLRwyQAHtRin4DiTrlvqRpGQ==
X-Received: by 2002:a1c:bd08:: with SMTP id n8mr2479044wmf.23.1588156646488;
        Wed, 29 Apr 2020 03:37:26 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:d494:5741:b700:698f])
        by smtp.gmail.com with ESMTPSA id f23sm6899576wml.4.2020.04.29.03.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 03:37:25 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     lukasz.luba@arm.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-pm@vger.kernel.org (open list:CPU IDLE TIME MANAGEMENT FRAMEWORK),
        linux-kernel@vger.kernel.org (open list),
        linux-arm-kernel@lists.infradead.org (open list:CPUIDLE DRIVER - ARM
        PSCI)
Subject: [PATCH v4 4/4] thermal: cpuidle: Register cpuidle cooling device
Date:   Wed, 29 Apr 2020 12:36:42 +0200
Message-Id: <20200429103644.5492-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200429103644.5492-1-daniel.lezcano@linaro.org>
References: <20200429103644.5492-1-daniel.lezcano@linaro.org>
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
 - V4:
   - Do not check the return value as the function does no longer return one
---
 drivers/cpuidle/cpuidle-arm.c  | 3 +++
 drivers/cpuidle/cpuidle-psci.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
index 9e5156d39627..8c758920d699 100644
--- a/drivers/cpuidle/cpuidle-arm.c
+++ b/drivers/cpuidle/cpuidle-arm.c
@@ -8,6 +8,7 @@
 
 #define pr_fmt(fmt) "CPUidle arm: " fmt
 
+#include <linux/cpu_cooling.h>
 #include <linux/cpuidle.h>
 #include <linux/cpumask.h>
 #include <linux/cpu_pm.h>
@@ -124,6 +125,8 @@ static int __init arm_idle_init_cpu(int cpu)
 	if (ret)
 		goto out_kfree_drv;
 
+	cpuidle_cooling_register(drv);
+
 	return 0;
 
 out_kfree_drv:
diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index bae9140a65a5..1f38e0dfc9b2 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -9,6 +9,7 @@
 #define pr_fmt(fmt) "CPUidle PSCI: " fmt
 
 #include <linux/cpuhotplug.h>
+#include <linux/cpu_cooling.h>
 #include <linux/cpuidle.h>
 #include <linux/cpumask.h>
 #include <linux/cpu_pm.h>
@@ -313,6 +314,8 @@ static int __init psci_idle_init_cpu(int cpu)
 	if (ret)
 		goto out_kfree_drv;
 
+	cpuidle_cooling_register(drv);
+
 	return 0;
 
 out_kfree_drv:
-- 
2.17.1

