Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5E181400FE
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2020 01:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbgAQAdT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jan 2020 19:33:19 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36474 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728898AbgAQAdT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jan 2020 19:33:19 -0500
Received: by mail-pl1-f194.google.com with SMTP id a6so9108531plm.3
        for <linux-pm@vger.kernel.org>; Thu, 16 Jan 2020 16:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oENCplfxYS/x7buWRMyVXnbpGnLZpIshtiMHjv9RuL8=;
        b=bV2jRU6y0Hh6CrGd9dfjiMuxbQQNzdSTfEvXeBz9zlwazA3Bv7xhlQ16RLSo1vq3qp
         sKAA1RLxDtCbnfvdl6r0RqQ7/YH45+KPrOXl+ZuKIs0xl6Xly3Iyc3qu4jwwVexcYQEf
         3DIq3zQlj/uLuWIEaVA91MFzhRVQhmIllJ8aQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oENCplfxYS/x7buWRMyVXnbpGnLZpIshtiMHjv9RuL8=;
        b=GDmrB8J/MVt4fBRksJ7m6kZO9zSX1u41+0dsx1q05YWNbWTZ1SQ+LGq1yiEeiKsV+G
         FdW4MU+wVkTLCdsd13DZPTy026QaTf4rF4XO4VD1OhToFzgfXP+aVRk24xSY+rirQE6+
         VQOF8u3IVnC/RMwjATy+NHDALdn4KMf0DspKwlrbNcE7btemgh2OIS0eJZeTQOxAqbo4
         Qe9dYkxiqmKwAcKaQ4y++cwjrR7M/Bjc3p1HrbHOuGAlgPfCXf1isNaHOPK97hbw+ByR
         LJn6KIs994ukSDblaasUx1/oBLIe4qFg0VVcetTjHVaO91dL8D5JuzulW6sdJ6ch4e4k
         gukg==
X-Gm-Message-State: APjAAAWPmg96RX9XjWtEDDuoPm+XKl3a5NNn2rXOv1AEp03Ht/Q7Tnaa
        bgHS/b5mACL4iLeIk/0yTW9LFg==
X-Google-Smtp-Source: APXvYqxq9YT/v0a4+lRet2n7yMQNshcu5xGQDYh95K/OSZa/KOXrXQkzsYGL4BILezDUTMyoUO6WMA==
X-Received: by 2002:a17:902:a5c2:: with SMTP id t2mr40927930plq.86.1579221198354;
        Thu, 16 Jan 2020 16:33:18 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id c188sm667420pga.83.2020.01.16.16.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 16:33:17 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     enric.balletbo@collabora.com, groeck@chromium.org,
        bleung@chromium.org, lee.jones@linaro.org, sre@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Jon Flatley <jflat@chromium.org>,
        Prashant Malani <pmalani@chromium.org>
Subject: [PATCH v7 3/3] power: supply: cros-ec-usbpd-charger: Fix host events
Date:   Thu, 16 Jan 2020 16:28:24 -0800
Message-Id: <20200117002820.56872-3-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200117002820.56872-1-pmalani@chromium.org>
References: <20200117002820.56872-1-pmalani@chromium.org>
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

Reviewed-by: Benson Leung <bleung@chromium.org>
Co-Developed-by: Prashant Malani <pmalani@chromium.org>
Signed-off-by: Jon Flatley <jflat@chromium.org>
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes in v7(pmalani@chromium.org):
- Alphabetize #include header.

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
index 6cc7c3910e098..7eea080048f43 100644
--- a/drivers/power/supply/cros_usbpd-charger.c
+++ b/drivers/power/supply/cros_usbpd-charger.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
+#include <linux/platform_data/cros_usbpd_notify.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
 #include <linux/slab.h>
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

