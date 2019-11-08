Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 412FCF58F7
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2019 22:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfKHVAJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Nov 2019 16:00:09 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:39210 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfKHVAJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Nov 2019 16:00:09 -0500
Received: by mail-yw1-f65.google.com with SMTP id d80so2271324ywa.6;
        Fri, 08 Nov 2019 13:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jYXLOtx/N7KVWM/YwJPGjpftc7a7FsHLnMCGgtte7zk=;
        b=Nl5KFeNvPu+lBDSmEGC40fcqoMtBjKsOjBpHdzeaCr3VYgbt4XHTn11ELnLAeNWORa
         mrIWXtoxS4J+jGTOmZFl3RlxKTvPHB8tNlbx7tJQani/rZEvR2xnDXNZ49bOp+p7snVn
         7+mRZEgdx4/9bovxzqBmob9QHnOAmO9zFeFZROA6S4QFyju4nFMYbMv3mQ1GNnO5jZ7p
         AkwrQ/v2YOW7GsYV2B8YmXO1Laydemt3u61X4MTmZ26/4Vww5Nlq4TbrpNA2v8nqhL6V
         ugnPDiQ9WJfMd38Ir461mtjxnW7nBOGilesjoz1GiWyRKXvwbwmxOK7+iijF4VvOyD4r
         9Vxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jYXLOtx/N7KVWM/YwJPGjpftc7a7FsHLnMCGgtte7zk=;
        b=eE605WOngIjaBgtPDK1CttiYUDF6zJYtJbCQUJGzc6+QNR2HHHzU3HL9RlYuOWGd63
         B6XemYCUZp7mAL7Nn07pjFY1MS0YOCCEa9Dmr5BHqpIrJuBf6r0+/DS4ipVahlSFY63N
         cpaVv+2F13mEaJtrLqpoYuw/4OQwjikwmEgZYqI/oImtbAjpua2wfvOV1cDV+76nr1bv
         WhssomJ79t9xwN3FSfYBDZsQkzx/BR4Uc+Y5wlNKBfzZPVu2+M+GJcU7/WoYCAnjWEo2
         cMy0Hb5PBuBuKlJmDefgIMw2XZ/yYB4EDo8Lw/S+MBO7PNCGQBHUJ/ZZmsWJzdP5XYQP
         adUA==
X-Gm-Message-State: APjAAAXAA6FG1nSwgGuQvZk+ai9M1ZzHuJp4y4QkS4a7RTDPNEOWRR4l
        uuS60HJ7alSExZB5wvUc3xjZIf2jp5bnqg==
X-Google-Smtp-Source: APXvYqzT3/qJydQ1euKwNFrGWdgCUlH9bfLCucc02oAC/qUSvpWwX7ufIzrUnWW7WJabswUHWxw7oA==
X-Received: by 2002:a81:9bcf:: with SMTP id s198mr8208710ywg.450.1573246807805;
        Fri, 08 Nov 2019 13:00:07 -0800 (PST)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id d18sm2785043ywh.51.2019.11.08.13.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 13:00:05 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-omap@vger.kernel.org
Cc:     hns@goldelico.com, adam.ford@logicpd.com,
        Adam Ford <aford173@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: ti-soc-thermal:  Enable addition power management
Date:   Fri,  8 Nov 2019 14:59:54 -0600
Message-Id: <20191108205954.20136-1-aford173@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The bandgap sensor can be idled when the processor is, but it
isn't currently being done. The power consumption of OMAP3
boards can elevated if the bangap sensor is enabled, because
the bandgap clock blocks deeper idle states the SoC.

We should idle bandgap with cpu_notifier instead of
runtime PM to avoid tagging it with pm_runtime_irq_safe()
that we want to stop using for drivers in general.

This patch uses additional power management to idle the clock
of the bandgap when it is not needed.

Suggested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
index 2fa78f738568..d203ec041c39 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -26,10 +26,18 @@
 #include <linux/of_irq.h>
 #include <linux/of_gpio.h>
 #include <linux/io.h>
+#include <linux/cpu_pm.h>
+#include <linux/device.h>
+#include <linux/pm_runtime.h>
+#include <linux/pm.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include "ti-bandgap.h"
 
 static int ti_bandgap_force_single_read(struct ti_bandgap *bgp, int id);
+static int bandgap_omap_cpu_notifier(struct notifier_block *nb,
+				  unsigned long cmd, void *v);
 
 /***   Helper functions to access registers and their bitfields   ***/
 
@@ -1025,6 +1033,9 @@ int ti_bandgap_probe(struct platform_device *pdev)
 		}
 	}
 
+	bgp->nb.notifier_call = bandgap_omap_cpu_notifier;
+	cpu_pm_register_notifier(&bgp->nb);
+
 	return 0;
 
 remove_last_cooling:
@@ -1174,6 +1185,38 @@ static int ti_bandgap_suspend(struct device *dev)
 	return err;
 }
 
+static int bandgap_omap_cpu_notifier(struct notifier_block *nb,
+				  unsigned long cmd, void *v)
+{
+	struct ti_bandgap *bgp;
+
+	bgp = container_of(nb, struct ti_bandgap, nb);
+
+	spin_lock(&bgp->lock);
+	switch (cmd) {
+	case CPU_CLUSTER_PM_ENTER:
+		if (bgp->is_suspended)
+			break;
+		ti_bandgap_save_ctxt(bgp);
+		ti_bandgap_power(bgp, false);
+		if (TI_BANDGAP_HAS(bgp, CLK_CTRL))
+			clk_disable(bgp->fclock);
+		break;
+	case CPU_CLUSTER_PM_ENTER_FAILED:
+	case CPU_CLUSTER_PM_EXIT:
+		if (bgp->is_suspended)
+			break;
+		if (TI_BANDGAP_HAS(bgp, CLK_CTRL))
+			clk_enable(bgp->fclock);
+		ti_bandgap_power(bgp, true);
+		ti_bandgap_restore_ctxt(bgp);
+		break;
+	}
+	spin_unlock(&bgp->lock);
+
+	return NOTIFY_OK;
+}
+
 static int ti_bandgap_resume(struct device *dev)
 {
 	struct ti_bandgap *bgp = dev_get_drvdata(dev);
diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.h b/drivers/thermal/ti-soc-thermal/ti-bandgap.h
index bb9b0f7faf99..a21d07a1a23a 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.h
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.h
@@ -12,6 +12,10 @@
 #include <linux/spinlock.h>
 #include <linux/types.h>
 #include <linux/err.h>
+#include <linux/cpu_pm.h>
+#include <linux/device.h>
+#include <linux/pm_runtime.h>
+#include <linux/pm.h>
 
 /**
  * DOC: bandgap driver data structure
@@ -201,6 +205,8 @@ struct ti_bandgap {
 	int				irq;
 	int				tshut_gpio;
 	u32				clk_rate;
+	struct notifier_block		nb;
+	unsigned int is_suspended:1;
 };
 
 /**
-- 
2.20.1

