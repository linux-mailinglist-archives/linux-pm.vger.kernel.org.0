Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECEB191D08
	for <lists+linux-pm@lfdr.de>; Tue, 24 Mar 2020 23:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbgCXWpr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Mar 2020 18:45:47 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35760 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728428AbgCXWpq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Mar 2020 18:45:46 -0400
Received: by mail-lj1-f195.google.com with SMTP id k21so476409ljh.2;
        Tue, 24 Mar 2020 15:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i84KBCBiRxmlk/8j75g9J/I5JK1LbARaY+Cgps9qf80=;
        b=VwjHIuvS/I5AxBpu1FztDHrHg9fkJAEXuRfoM/Oy6QTXXDmvdnfoI3NqoOZ7h2RHed
         01fIcG+FDVPVj9Xq5KtsU5kcxBMLLdBdd2Mhv1HwJ2jrBx0dK6LF8kdNXZrYg/lRqcBk
         YUi6E956iu9768IjC+JYqs7pwm20v+QWpqXHK6QNw+cs2hrdEY+WKAaIA/NTJbLN67+O
         Gkik/TTmTv3yt+glzltYclwyToVNNuEPXEM2dM9I0f2z3M+bZWDYEJ9QILM0V8mNd2uh
         Edty1CAPXirbJJeiWj5/XyWdcaEFlMkTG+kenkxSDQhX4fQPirxENiVUxO72UFR8GOZN
         Ixgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i84KBCBiRxmlk/8j75g9J/I5JK1LbARaY+Cgps9qf80=;
        b=Xye5pLx1k9cJSgaw0HcW6shKQiHcECh/nd9iMnkm8r4ia/o90YHXckMmLlVznzibxS
         B+mtAmhgUbR2oSYTNVfTzG1KT5NApHbn3M/OtfnN+4HHmtfttr5o4BdwRcJQxwg7LCvY
         xSm+Tn8byAR7FN0PAmhK4fcHZnWz/SQif831EeDpB+CDpSJN+EhAGXTDfeEGvOh3E5VP
         /kVS7OifWrB5bHnFOx2T5le2pAXpsTNs/R/At7ETodyz1ThqgNyiB/I7Urhn8QLSx+hI
         6zvFPxRieMO9szdBrH2cxpbLQMKePX16FwZYZ6uNvi0HZKUIqoNe7SSi0jIu3MspRlLz
         uaEQ==
X-Gm-Message-State: AGi0PuYwjSFyw0lD6/xOTqkKLZMmFkOdkJsxkpPWHyRP75qXpufN7Lv1
        Niqe6YcC1T4CSzIGPNurLNc=
X-Google-Smtp-Source: ADFU+vt6q2Lnq5uIXVNJVdYViUW4m/PQ1vqKcJn9ESjQG7CJNmXYKBUYPZH57nnqE3GoQuDqEhi1pQ==
X-Received: by 2002:a2e:920c:: with SMTP id k12mr8588ljg.209.1585089941006;
        Tue, 24 Mar 2020 15:45:41 -0700 (PDT)
Received: from localhost.localdomain (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.gmail.com with ESMTPSA id d4sm10534279lfa.75.2020.03.24.15.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 15:45:40 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] firmware: trusted_foundations: Different way of L2 cache enabling after LP2 suspend
Date:   Wed, 25 Mar 2020 01:43:34 +0300
Message-Id: <20200324224335.5825-3-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200324224335.5825-1-digetx@gmail.com>
References: <20200324224335.5825-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

ASUS TF300T device may not work properly if firmware is asked to fully
re-initialize L2 cache after resume from LP2 suspend. The downstream
kernel of TF300T uses different opcode to enable cache after resuming
from LP2, this opcode also works fine on Nexus 7 and Ouya devices.
Supposedly, this may be needed by an older firmware versions.

Reported-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Tested-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Tested-by: Jasper Korten <jja2000@gmail.com>
Tested-by: David Heidelberg <david@ixit.cz>
Tested-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/pm.c                     |  4 ++++
 drivers/firmware/trusted_foundations.c       | 21 ++++++++++++++++++--
 include/linux/firmware/trusted_foundations.h |  1 +
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index d1e1a61b12cf..6452ebf68d40 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -216,6 +216,8 @@ int tegra_pm_enter_lp2(void)
 	restore_cpu_complex();
 	cpu_cluster_pm_exit();
 
+	call_firmware_op(prepare_idle, TF_PM_MODE_NONE);
+
 	return err;
 }
 
@@ -391,6 +393,8 @@ static int tegra_suspend_enter(suspend_state_t state)
 
 	local_fiq_enable();
 
+	call_firmware_op(prepare_idle, TF_PM_MODE_NONE);
+
 	return 0;
 }
 
diff --git a/drivers/firmware/trusted_foundations.c b/drivers/firmware/trusted_foundations.c
index fc544e19b0a1..1389fa9418a7 100644
--- a/drivers/firmware/trusted_foundations.c
+++ b/drivers/firmware/trusted_foundations.c
@@ -19,6 +19,7 @@
 
 #define TF_CACHE_ENABLE		1
 #define TF_CACHE_DISABLE	2
+#define TF_CACHE_REENABLE	4
 
 #define TF_SET_CPU_BOOT_ADDR_SMC 0xfffff200
 
@@ -29,6 +30,7 @@
 #define TF_CPU_PM_S1		0xffffffe4
 #define TF_CPU_PM_S1_NOFLUSH_L2	0xffffffe7
 
+static unsigned long tf_idle_mode = TF_PM_MODE_NONE;
 static unsigned long cpu_boot_addr;
 
 static void tf_generic_smc(u32 type, u32 arg1, u32 arg2)
@@ -85,25 +87,40 @@ static int tf_prepare_idle(unsigned long mode)
 			       cpu_boot_addr);
 		break;
 
+	case TF_PM_MODE_NONE:
+		break;
+
 	default:
 		return -EINVAL;
 	}
 
+	tf_idle_mode = mode;
+
 	return 0;
 }
 
 #ifdef CONFIG_CACHE_L2X0
 static void tf_cache_write_sec(unsigned long val, unsigned int reg)
 {
-	u32 l2x0_way_mask = 0xff;
+	u32 enable_op, l2x0_way_mask = 0xff;
 
 	switch (reg) {
 	case L2X0_CTRL:
 		if (l2x0_saved_regs.aux_ctrl & L310_AUX_CTRL_ASSOCIATIVITY_16)
 			l2x0_way_mask = 0xffff;
 
+		switch (tf_idle_mode) {
+		case TF_PM_MODE_LP2:
+			enable_op = TF_CACHE_REENABLE;
+			break;
+
+		default:
+			enable_op = TF_CACHE_ENABLE;
+			break;
+		}
+
 		if (val == L2X0_CTRL_EN)
-			tf_generic_smc(TF_CACHE_MAINT, TF_CACHE_ENABLE,
+			tf_generic_smc(TF_CACHE_MAINT, enable_op,
 				       l2x0_saved_regs.aux_ctrl);
 		else
 			tf_generic_smc(TF_CACHE_MAINT, TF_CACHE_DISABLE,
diff --git a/include/linux/firmware/trusted_foundations.h b/include/linux/firmware/trusted_foundations.h
index 2549a2db56aa..be5984bda592 100644
--- a/include/linux/firmware/trusted_foundations.h
+++ b/include/linux/firmware/trusted_foundations.h
@@ -32,6 +32,7 @@
 #define TF_PM_MODE_LP1_NO_MC_CLK	2
 #define TF_PM_MODE_LP2			3
 #define TF_PM_MODE_LP2_NOFLUSH_L2	4
+#define TF_PM_MODE_NONE			5
 
 struct trusted_foundations_platform_data {
 	unsigned int version_major;
-- 
2.25.1

