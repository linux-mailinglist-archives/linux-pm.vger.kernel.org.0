Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E82B13B5C8
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2020 00:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbgANX1o (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jan 2020 18:27:44 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44288 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728759AbgANX1o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jan 2020 18:27:44 -0500
Received: by mail-pg1-f195.google.com with SMTP id x7so7136109pgl.11
        for <linux-pm@vger.kernel.org>; Tue, 14 Jan 2020 15:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FjlR2GDiNviLLUnZLpM2xF4e4vLYisf90J5psoo45v0=;
        b=gBSNJE45auewf9yu41Jxx90LA/dvCD7dhGxGpC0eEVxntCV/YQ1saVcFOQRaaeA7cl
         K7kwv+IypGXC1ddYEe/94PFryKsx+mNaK26ojYkMpzLutPE8YylmoKQN40y8pW6gcPPo
         mayG3BljWAw0auet19NA/z1PwsDttjdENN8T4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FjlR2GDiNviLLUnZLpM2xF4e4vLYisf90J5psoo45v0=;
        b=KQBQUPeTG95/Yf6gO9I8JDGccU5Bck07S58puQ1Gc2MbkJVYZihMUD7xZoqGnjfrLh
         7qZsPTe2DbHgllC1lZ0bKLY8I/D8aRd/SaPnuJU6hd0juLWZl+ylfruFtRkkckFjnUf2
         a/thAp8FaNMPu0sZS9AAzeUuLJbVw6ZlaC9uydOlprRG35GSwXgFesDaYhMFFhLTq7Gn
         QDR/P0XzcYfcQ8zWk2gcireR9OXGh70XPRJGco7XCBS4m3lgazOXP/dPpnHeYPUpclcp
         jJ2kgoBlx4KHwTEyZH2iQWG0QyhUM0nioLPF2aw+nNZO1jrRr8Cop5k7wPvM5WyNrVKs
         KxVQ==
X-Gm-Message-State: APjAAAVURBmCDxfbWSbYiSoLk6R1lM810ywVGk8xwuvczYXDC0o0S/rp
        Ub2Zihr7skdCc8EUybLmRILwZQ==
X-Google-Smtp-Source: APXvYqwDndS4zrqzZ5mZ3UDWbotPnktd3lqLLQgqXHTAGMncnphjRT6TtzP6jzd9nW4y1L/PNIqsCw==
X-Received: by 2002:a63:484b:: with SMTP id x11mr30224921pgk.148.1579044463438;
        Tue, 14 Jan 2020 15:27:43 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id u18sm18521839pgn.9.2020.01.14.15.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 15:27:43 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     enric.balletbo@collabora.com, groeck@chromium.org,
        bleung@chromium.org, lee.jones@linaro.org, sre@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Jon Flatley <jflat@chromium.org>,
        Prashant Malani <pmalani@chromium.org>
Subject: [PATCH v6 3/3] power: supply: cros-ec-usbpd-charger: Fix host events
Date:   Tue, 14 Jan 2020 15:22:22 -0800
Message-Id: <20200114232219.93171-3-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200114232219.93171-1-pmalani@chromium.org>
References: <20200114232219.93171-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Jon Flatley <jflat@chromium.org>

There's a bug on ACPI platforms where host events from the ECPD ACPI
device never make their way to the cros-ec-usbpd-charger driver. This
makes it so the only time the charger driver updates its state is when
user space accesses its sysfs attributes.

Now that these events have been unified into a single notifier chain on
both ACPI and non-ACPI platforms, update the charger driver to use this
new notifier.

Signed-off-by: Jon Flatley <jflat@chromium.org>
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes in v6(pmalani@chromium.org):
- Patch first introduced into the series in v6.

 drivers/power/supply/Kconfig              |  2 +-
 drivers/power/supply/cros_usbpd-charger.c | 50 ++++++++---------------
 2 files changed, 19 insertions(+), 33 deletions(-)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 27164a1d3c7c4..ba74ddd793c3d 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -659,7 +659,7 @@ config CHARGER_RT9455
 
 config CHARGER_CROS_USBPD
 	tristate "ChromeOS EC based USBPD charger"
-	depends on CROS_EC
+	depends on CROS_USBPD_NOTIFY
 	default n
 	help
 	  Say Y here to enable ChromeOS EC based USBPD charger
diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/supply/cros_usbpd-charger.c
index 6cc7c3910e098..7f7e051262170 100644
--- a/drivers/power/supply/cros_usbpd-charger.c
+++ b/drivers/power/supply/cros_usbpd-charger.c
@@ -8,6 +8,7 @@
 #include <linux/mfd/cros_ec.h>
 #include <linux/module.h>
 #include <linux/platform_data/cros_ec_commands.h>
+#include <linux/platform_data/cros_usbpd_notify.h>
 #include <linux/platform_data/cros_ec_proto.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
@@ -524,32 +525,21 @@ static int cros_usbpd_charger_property_is_writeable(struct power_supply *psy,
 }
 
 static int cros_usbpd_charger_ec_event(struct notifier_block *nb,
-				       unsigned long queued_during_suspend,
+				       unsigned long host_event,
 				       void *_notify)
 {
-	struct cros_ec_device *ec_device;
-	struct charger_data *charger;
-	u32 host_event;
+	struct charger_data *charger = container_of(nb, struct charger_data,
+						    notifier);
 
-	charger = container_of(nb, struct charger_data, notifier);
-	ec_device = charger->ec_device;
-
-	host_event = cros_ec_get_host_event(ec_device);
-	if (host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_PD_MCU)) {
-		cros_usbpd_charger_power_changed(charger->ports[0]->psy);
-		return NOTIFY_OK;
-	} else {
-		return NOTIFY_DONE;
-	}
+	cros_usbpd_charger_power_changed(charger->ports[0]->psy);
+	return NOTIFY_OK;
 }
 
 static void cros_usbpd_charger_unregister_notifier(void *data)
 {
 	struct charger_data *charger = data;
-	struct cros_ec_device *ec_device = charger->ec_device;
 
-	blocking_notifier_chain_unregister(&ec_device->event_notifier,
-					   &charger->notifier);
+	cros_usbpd_unregister_notify(&charger->notifier);
 }
 
 static int cros_usbpd_charger_probe(struct platform_device *pd)
@@ -683,21 +673,17 @@ static int cros_usbpd_charger_probe(struct platform_device *pd)
 		goto fail;
 	}
 
-	if (ec_device->mkbp_event_supported) {
-		/* Get PD events from the EC */
-		charger->notifier.notifier_call = cros_usbpd_charger_ec_event;
-		ret = blocking_notifier_chain_register(
-						&ec_device->event_notifier,
-						&charger->notifier);
-		if (ret < 0) {
-			dev_warn(dev, "failed to register notifier\n");
-		} else {
-			ret = devm_add_action_or_reset(dev,
-					cros_usbpd_charger_unregister_notifier,
-					charger);
-			if (ret < 0)
-				goto fail;
-		}
+	/* Get PD events from the EC */
+	charger->notifier.notifier_call = cros_usbpd_charger_ec_event;
+	ret = cros_usbpd_register_notify(&charger->notifier);
+	if (ret < 0) {
+		dev_warn(dev, "failed to register notifier\n");
+	} else {
+		ret = devm_add_action_or_reset(dev,
+				cros_usbpd_charger_unregister_notifier,
+				charger);
+		if (ret < 0)
+			goto fail;
 	}
 
 	return 0;
-- 
2.25.0.341.g760bfbb309-goog

