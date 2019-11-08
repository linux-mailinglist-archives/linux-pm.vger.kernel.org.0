Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3331CF580B
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2019 21:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730571AbfKHUFR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Nov 2019 15:05:17 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:39742 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729683AbfKHUFR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Nov 2019 15:05:17 -0500
Received: by mail-yb1-f193.google.com with SMTP id q18so3310848ybq.6;
        Fri, 08 Nov 2019 12:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3HNLscIvkJVm9LDzzKj9NN0fxD/hsQkK7CgwB2NvQEo=;
        b=rnI9Jz/ZrlT1PUiypYH638nYMjA7b+QdhfTNnvDinBcud7rk8/0eK/bTPcu1ZyQHKs
         PqIQtMK2+jQwPbbketix320JR2hkKCCIQL4s5U3nNc7/MZgyEmsiTqB27FhpkGJ7/Wvu
         QEKH/Fg3huxiW8+ZBWyxgBBQMaD5Ka9e129VAJfAu213JGnRka3cBM+44F1gKZkz3Hee
         4cUi3swJzu/AvNs86CqOKRlsL3mX2yggbpv2CZFL+WxaPL4VoWooYqJVGnviIPOMrB/j
         AQ0A/m7pBYVOysj2Qq4O0ayKum3XAPtjOEqTczDKDOMznbDg7drVRm3fy8y9yxMgQcR5
         T5cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3HNLscIvkJVm9LDzzKj9NN0fxD/hsQkK7CgwB2NvQEo=;
        b=FmwaKt0+f9ME7zEP2Oi+wAIsA1OkvOb2NJUzcn+jNowfi4GNkIatEt/OvZb5e/F97s
         3tH2xZipJFz6EkmOoR5YiPFOoPosVOMfnI+pTVCjkEpXzupdmNqoaAG16vQrzDMpNE8e
         JBlh9SuuIVhnZvPfqpqNEFjdh7MdZjDJ1IC+KXouAflyahFiAFC/Ed/NQTg9i//fVCI4
         +pPIuekpOYxDQzSdxxd1pVcHQVfRtPbo2njnds6TkMGoJSQY47FcygxRGDZhsfxNMCeR
         X19SrHCBisVH/Vb2wOZu36JGF2q5+cSOpseMymIV72ZGy0ECmHy3EurUMvOy5f57SvT6
         IPWA==
X-Gm-Message-State: APjAAAWtsU1OFhReOkeIQsuJPnkbHrC9/pWuP8mcWbNjG+GuvBjWGR+6
        D5f9PFDb5KwYQHKWdyywnt+mixuECt3kTA==
X-Google-Smtp-Source: APXvYqx1L5kUsNfzEx/ahu7XGykB+oN23QVD5KIGZ9SJXiWWi5Tbxkuh1whlQE3I8RCG69F4WEq5Cw==
X-Received: by 2002:a25:60c5:: with SMTP id u188mr11044401ybb.237.1573243515241;
        Fri, 08 Nov 2019 12:05:15 -0800 (PST)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id s18sm4109576ywk.33.2019.11.08.12.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 12:05:14 -0800 (PST)
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
Date:   Fri,  8 Nov 2019 14:05:01 -0600
Message-Id: <20191108200501.29864-1-aford173@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The bandgap sensor can be idled when the processor is too, but it
isn't currently being done, so the power consumption of OMAP3
boards can elevated if the bangap sensor is enabled.

This patch attempts to use some additional power management
to idle the clock to the bandgap when not needed.

Suggested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
index 2fa78f738568..7a221f71bc9f 100644
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
+			clk_disable_unprepare(bgp->fclock);
+		break;
+	case CPU_CLUSTER_PM_ENTER_FAILED:
+	case CPU_CLUSTER_PM_EXIT:
+		if (bgp->is_suspended)
+			break;
+		if (TI_BANDGAP_HAS(bgp, CLK_CTRL))
+			clk_prepare_enable(bgp->fclock);
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

