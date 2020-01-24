Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2FF31491E6
	for <lists+linux-pm@lfdr.de>; Sat, 25 Jan 2020 00:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbgAXXVo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Jan 2020 18:21:44 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40173 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729163AbgAXXVo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jan 2020 18:21:44 -0500
Received: by mail-pf1-f195.google.com with SMTP id q8so1833397pfh.7
        for <linux-pm@vger.kernel.org>; Fri, 24 Jan 2020 15:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g62W9zyRnLaJvDqXWj9zO8N5kgKMPJ8ADRZEejZYC2Q=;
        b=NacjkgaMLSdt+bsZ95POQ3P8F3AcKOaUf16/7ejq/BM3me1p5THLD3dOZQPhl8/0HY
         ZSGcc47t42ZxfBVVNOGc7hAj8y8QhLz4C+jTWChwtGlWcryTzna5cuT5g5uXRUyyZSWF
         J6ikdpifo/xuobAzVSTAX1zb7k9lCco3O4L6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g62W9zyRnLaJvDqXWj9zO8N5kgKMPJ8ADRZEejZYC2Q=;
        b=IyB/pzTsLGi38PkDM7zziiHWbHMAS72Qij37L1Hy4l7O6PTji6gu8bmdrDOd59hDot
         SF4Seu9nLaN2vt0GaQha430gbzOUlEjcpSAxtkTm3wZWYceXVMG9AzS9E6uyu9X9VXs3
         K40OgNfLQKJOlfW4fpVIzi4CFLUdvTaZ/SUgWzyDOTOS+K0pBafMjREmQ65aWBlEfija
         pJJsIFo63ybv0+t1OZR5yoo3MY8UODHE2WBdvMB2E5SGflvqpJlDuoY7cycLemQzrLsw
         wGrod/z5KoAsdh/ZM8PIdlCXcbK1c9ooa3LEOqePJGmP9JlNXRQI1JBSo2LAA41DWgqn
         FJUg==
X-Gm-Message-State: APjAAAVCkB7cph5/ra9/hCSvaAd+/R+eU1Thlh46zRyjLV1f4FR//x5m
        fQWn/xB3K0HpQlDK1wbuOuY4yg==
X-Google-Smtp-Source: APXvYqzzQ2d9Yma0Fs4fWCdE079O/MMZDb2R3jVairL1yz4v+98wPBb4ze64gBctzviVo3BaJwfYLQ==
X-Received: by 2002:a62:cece:: with SMTP id y197mr5690912pfg.9.1579908102978;
        Fri, 24 Jan 2020 15:21:42 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id b12sm2823103pfr.26.2020.01.24.15.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 15:21:42 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     enric.balletbo@collabora.com, groeck@chromium.org,
        bleung@chromium.org, lee.jones@linaro.org, sre@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Jon Flatley <jflat@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v8 1/4] platform: chrome: Add cros-usbpd-notify driver
Date:   Fri, 24 Jan 2020 15:18:32 -0800
Message-Id: <20200124231834.63628-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Jon Flatley <jflat@chromium.org>

ChromiumOS uses ACPI device with HID "GOOG0003" for power delivery
related events. The existing cros-usbpd-charger driver relies on these
events without ever actually receiving them on ACPI platforms. This is
because in the ChromeOS kernel trees, the GOOG0003 device is owned by an
ACPI driver that offers firmware updates to USB-C chargers.

Introduce a new platform driver under cros-ec, the ChromeOS embedded
controller, that handles these PD events and dispatches them
appropriately over a notifier chain to all drivers that use them.

On platforms that don't have the ACPI device defined, the driver gets
instantiated for ECs which support the EC_FEATURE_USB_PD feature bit,
and the notification events will get delivered using the MKBP event
handling mechanism.

Co-Developed-by: Prashant Malani <pmalani@chromium.org>
Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
Reviewed-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Jon Flatley <jflat@chromium.org>
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes in v8(pmalani@chromium.org):
- Fix style nits.
- Remove unrequired header.
- Remove #ifdef CONFIG_OF dependency for platform driver registration.
- Add module compile text to Kconfig help section.

Changes in v7(pmalani@chromium.org):
- Removed use of module_platform_driver() and module_acpi_driver() since
  that was causing redefinition compilation errors on arm64 defconfig.
  Instead, explicitly defined the init and exit routines and
  register/unregister the platform and ACPI drivers there.
- Alphabetize #include header.

Changes in v6(pmalani@chromium.org):
- Fix build error from typo in cros_usbpd_notify_acpi_device_ids
  variable name.

Changes in v5(pmalani@chromium.org):
- Split the driver into platform and ACPI variants, each enclosed by
  CONFIG_OF and CONFIG_ACPI #ifdefs respectively.
- Updated the copyright year to 2020.
- Reworded the commit message and Kconfig description to incorporate
  the modified driver structure.

Changes in v4(pmalani@chromium.org):
- No code changes, but added new version so that versioning is
  consistent with the next patch in the series.

Changes in v3 (pmalani@chromium.org):
- Renamed driver and files from "cros_ec_pd_notify" to
  "cros_usbpd_notify" to be more consistent with other naming.
- Moved the change to include cros-usbpd-notify in the charger MFD
  into a separate follow-on patch.

Changes in v2 (pmalani@chromium.org):
- Removed dependency on DT entry; instead, we will instantiate
  the driver on detecting EC_FEATURE_USB_PD for non-ACPI platforms.
- Modified the cros-ec-pd-notify device to be an mfd_cell under
  usbpdcharger for non-ACPI platforms. Altered the platform_probe() call
  to derive the cros EC structs appropriately.
- Replaced "usbpd_notify" with "pd_notify" in functions and structures.
- Addressed comments from upstream maintainer.

 drivers/platform/chrome/Kconfig               |  13 ++
 drivers/platform/chrome/Makefile              |   1 +
 drivers/platform/chrome/cros_usbpd_notify.c   | 170 ++++++++++++++++++
 .../linux/platform_data/cros_usbpd_notify.h   |  17 ++
 4 files changed, 201 insertions(+)
 create mode 100644 drivers/platform/chrome/cros_usbpd_notify.c
 create mode 100644 include/linux/platform_data/cros_usbpd_notify.h

diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index 5f57282a28da0..e45e0fe057586 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -226,6 +226,19 @@ config CROS_USBPD_LOGGER
 	  To compile this driver as a module, choose M here: the
 	  module will be called cros_usbpd_logger.
 
+config CROS_USBPD_NOTIFY
+	tristate "ChromeOS Type-C power delivery event notifier"
+	depends on CROS_EC
+	help
+	  If you say Y here, you get support for Type-C PD event notifications
+	  from the ChromeOS EC. On ACPI platorms this driver will bind to the
+	  GOOG0003 ACPI device, and on platforms which don't have this device it
+	  will get initialized on ECs which support the feature
+	  EC_FEATURE_USB_PD.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called cros_usbpd_notify.
+
 source "drivers/platform/chrome/wilco_ec/Kconfig"
 
 endif # CHROMEOS_PLATFORMS
diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
index aacd5920d8a18..f6465f8ef0b5e 100644
--- a/drivers/platform/chrome/Makefile
+++ b/drivers/platform/chrome/Makefile
@@ -22,5 +22,6 @@ obj-$(CONFIG_CROS_EC_DEBUGFS)		+= cros_ec_debugfs.o
 obj-$(CONFIG_CROS_EC_SENSORHUB)		+= cros_ec_sensorhub.o
 obj-$(CONFIG_CROS_EC_SYSFS)		+= cros_ec_sysfs.o
 obj-$(CONFIG_CROS_USBPD_LOGGER)		+= cros_usbpd_logger.o
+obj-$(CONFIG_CROS_USBPD_NOTIFY)		+= cros_usbpd_notify.o
 
 obj-$(CONFIG_WILCO_EC)			+= wilco_ec/
diff --git a/drivers/platform/chrome/cros_usbpd_notify.c b/drivers/platform/chrome/cros_usbpd_notify.c
new file mode 100644
index 0000000000000..6ead5c62b3c5f
--- /dev/null
+++ b/drivers/platform/chrome/cros_usbpd_notify.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2020 Google LLC
+ *
+ * This driver serves as the receiver of cros_ec PD host events.
+ */
+
+#include <linux/acpi.h>
+#include <linux/module.h>
+#include <linux/mfd/cros_ec.h>
+#include <linux/platform_data/cros_ec_proto.h>
+#include <linux/platform_data/cros_usbpd_notify.h>
+#include <linux/platform_device.h>
+
+#define DRV_NAME "cros-usbpd-notify"
+#define ACPI_DRV_NAME "GOOG0003"
+
+static BLOCKING_NOTIFIER_HEAD(cros_usbpd_notifier_list);
+
+/**
+ * cros_usbpd_register_notify - Register a notifier callback for PD events.
+ * @nb: Notifier block pointer to register
+ *
+ * On ACPI platforms this corresponds to host events on the ECPD
+ * "GOOG0003" ACPI device. On non-ACPI platforms this will filter mkbp events
+ * for USB PD events.
+ *
+ * Return: 0 on success or negative error code.
+ */
+int cros_usbpd_register_notify(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&cros_usbpd_notifier_list,
+						nb);
+}
+EXPORT_SYMBOL_GPL(cros_usbpd_register_notify);
+
+/**
+ * cros_usbpd_unregister_notify - Unregister notifier callback for PD events.
+ * @nb: Notifier block pointer to unregister
+ *
+ * Unregister a notifier callback that was previously registered with
+ * cros_usbpd_register_notify().
+ */
+void cros_usbpd_unregister_notify(struct notifier_block *nb)
+{
+	blocking_notifier_chain_unregister(&cros_usbpd_notifier_list, nb);
+}
+EXPORT_SYMBOL_GPL(cros_usbpd_unregister_notify);
+
+#ifdef CONFIG_ACPI
+
+static int cros_usbpd_notify_add_acpi(struct acpi_device *adev)
+{
+	return 0;
+}
+
+static void cros_usbpd_notify_acpi(struct acpi_device *adev, u32 event)
+{
+	blocking_notifier_call_chain(&cros_usbpd_notifier_list, event, NULL);
+}
+
+static const struct acpi_device_id cros_usbpd_notify_acpi_device_ids[] = {
+	{ ACPI_DRV_NAME, 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, cros_usbpd_notify_acpi_device_ids);
+
+static struct acpi_driver cros_usbpd_notify_acpi_driver = {
+	.name = DRV_NAME,
+	.class = DRV_NAME,
+	.ids = cros_usbpd_notify_acpi_device_ids,
+	.ops = {
+		.add = cros_usbpd_notify_add_acpi,
+		.notify = cros_usbpd_notify_acpi,
+	},
+};
+
+#endif /* CONFIG_ACPI */
+
+static int cros_usbpd_notify_plat(struct notifier_block *nb,
+				  unsigned long queued_during_suspend,
+				  void *data)
+{
+	struct cros_ec_device *ec_dev = (struct cros_ec_device *)data;
+	u32 host_event = cros_ec_get_host_event(ec_dev);
+
+	if (!host_event)
+		return NOTIFY_BAD;
+
+	if (host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_PD_MCU)) {
+		blocking_notifier_call_chain(&cros_usbpd_notifier_list,
+					     host_event, NULL);
+		return NOTIFY_OK;
+	}
+	return NOTIFY_DONE;
+}
+
+static int cros_usbpd_notify_probe_plat(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct cros_ec_dev *ecdev = dev_get_drvdata(dev->parent);
+	struct notifier_block *nb;
+	int ret;
+
+	nb = devm_kzalloc(dev, sizeof(*nb), GFP_KERNEL);
+	if (!nb)
+		return -ENOMEM;
+
+	nb->notifier_call = cros_usbpd_notify_plat;
+	dev_set_drvdata(dev, nb);
+
+	ret = blocking_notifier_chain_register(&ecdev->ec_dev->event_notifier,
+					       nb);
+	if (ret < 0) {
+		dev_err(dev, "Failed to register notifier\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int cros_usbpd_notify_remove_plat(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct cros_ec_dev *ecdev = dev_get_drvdata(dev->parent);
+	struct notifier_block *nb =
+		(struct notifier_block *)dev_get_drvdata(dev);
+
+	blocking_notifier_chain_unregister(&ecdev->ec_dev->event_notifier, nb);
+
+	return 0;
+}
+
+static struct platform_driver cros_usbpd_notify_plat_driver = {
+	.driver = {
+		.name = DRV_NAME,
+	},
+	.probe = cros_usbpd_notify_probe_plat,
+	.remove = cros_usbpd_notify_remove_plat,
+};
+
+static int __init cros_usbpd_notify_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&cros_usbpd_notify_plat_driver);
+	if (ret < 0)
+		return ret;
+
+#ifdef CONFIG_ACPI
+	acpi_bus_register_driver(&cros_usbpd_notify_acpi_driver);
+#endif
+	return 0;
+}
+
+static void __exit cros_usbpd_notify_exit(void)
+{
+#ifdef CONFIG_ACPI
+	acpi_bus_unregister_driver(&cros_usbpd_notify_acpi_driver);
+#endif
+	platform_driver_unregister(&cros_usbpd_notify_plat_driver);
+}
+
+module_init(cros_usbpd_notify_init);
+module_exit(cros_usbpd_notify_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("ChromeOS power delivery notifier device");
+MODULE_AUTHOR("Jon Flatley <jflat@chromium.org>");
+MODULE_ALIAS("platform:" DRV_NAME);
diff --git a/include/linux/platform_data/cros_usbpd_notify.h b/include/linux/platform_data/cros_usbpd_notify.h
new file mode 100644
index 0000000000000..4f2791722b6d3
--- /dev/null
+++ b/include/linux/platform_data/cros_usbpd_notify.h
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ChromeOS EC Power Delivery Notifier Driver
+ *
+ * Copyright 2020 Google LLC
+ */
+
+#ifndef __LINUX_PLATFORM_DATA_CROS_USBPD_NOTIFY_H
+#define __LINUX_PLATFORM_DATA_CROS_USBPD_NOTIFY_H
+
+#include <linux/notifier.h>
+
+int cros_usbpd_register_notify(struct notifier_block *nb);
+
+void cros_usbpd_unregister_notify(struct notifier_block *nb);
+
+#endif  /* __LINUX_PLATFORM_DATA_CROS_USBPD_NOTIFY_H */
-- 
2.25.0.341.g760bfbb309-goog

