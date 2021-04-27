Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0905736CBF0
	for <lists+linux-pm@lfdr.de>; Tue, 27 Apr 2021 21:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238740AbhD0TpS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Apr 2021 15:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238970AbhD0TpS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Apr 2021 15:45:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF09C061574
        for <linux-pm@vger.kernel.org>; Tue, 27 Apr 2021 12:44:34 -0700 (PDT)
Date:   Tue, 27 Apr 2021 19:44:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619552673;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UuAQPj5lYvKDp3juv0H7KiQHS6joNDFqJ+4nCU1Nykw=;
        b=L8uYylLh0DAYM+7Q6LtFH7Wlc2Lwgbho8kqjXL9OgLTkyY/JUgqnLE/BelTX501EhXw8Ms
        Z3kDsqK1W4FMEvFreLQjrRiBedPAcVjVXTEXZE74WqEospuWQIkkg8c/FeVGNxJQAuQRRE
        a2bufkYLWJoMlyEyM/t4QSoV8YnciwuyBIfBnI0xY++P1TGkILtkr0kryOlP4KiiX3QOQX
        z2EA8AK4Oyx5u2mFlVvSahfnojrKJwLBGvbWWDZ3aVd5G7gyb5FAYNX7KAV5BnG5KB3U3a
        6FwaGZ/grCMnxBj7Je89upCtWaSuGRNJrnbRKiWNhgatlEcW3jLchxUA9t7bQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619552673;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UuAQPj5lYvKDp3juv0H7KiQHS6joNDFqJ+4nCU1Nykw=;
        b=HYpd8UO3D3MPGTcGBBDjtbAs3BUw4J1QThqG07gunB4lzmtSI+oTcvtX0Wk5INs8ka1r4l
        H5scYU6AHh/horDQ==
From:   "thermal-bot for Zhen Lei" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/ti-soc-thermal/ti-bandgap:
 Rearrange all the included header files alphabetically
Cc:     Zhen Lei <thunder.leizhen@huawei.com>, Keerthy <j-keerthy@ti.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210406091912.2583-2-thunder.leizhen@huawei.com>
References: <20210406091912.2583-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Message-ID: <161955267233.29796.1764788966833145464.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     5a4a8235fee69b5a31cf1c56a9fa14b0d21a930c
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//5a4a8235fee69b5a31cf1c56a9fa14b0d21a930c
Author:        Zhen Lei <thunder.leizhen@huawei.com>
AuthorDate:    Tue, 06 Apr 2021 17:19:12 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 20 Apr 2021 19:02:16 +02:00

thermal/drivers/ti-soc-thermal/ti-bandgap: Rearrange all the included header files alphabetically

For the sake of lisibility, reorder the header files alphabetically.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Reviewed-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210406091912.2583-2-thunder.leizhen@huawei.com
---
 drivers/thermal/ti-soc-thermal/ti-bandgap.c | 34 ++++++++++----------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
index d81af89..008fbed 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -9,29 +9,29 @@
  *   Eduardo Valentin <eduardo.valentin@ti.com>
  */
 
-#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/cpu_pm.h>
+#include <linux/device.h>
+#include <linux/err.h>
 #include <linux/export.h>
+#include <linux/gpio/consumer.h>
 #include <linux/init.h>
-#include <linux/kernel.h>
 #include <linux/interrupt.h>
-#include <linux/clk.h>
-#include <linux/gpio/consumer.h>
-#include <linux/platform_device.h>
-#include <linux/err.h>
-#include <linux/types.h>
-#include <linux/spinlock.h>
-#include <linux/sys_soc.h>
-#include <linux/reboot.h>
-#include <linux/of_device.h>
-#include <linux/of_platform.h>
-#include <linux/of_irq.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
-#include <linux/cpu_pm.h>
-#include <linux/device.h>
-#include <linux/pm_runtime.h>
-#include <linux/pm.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/pm_runtime.h>
+#include <linux/reboot.h>
+#include <linux/spinlock.h>
+#include <linux/sys_soc.h>
+#include <linux/types.h>
 
 #include "ti-bandgap.h"
 
