Return-Path: <linux-pm+bounces-35678-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD6CBB3C6A
	for <lists+linux-pm@lfdr.de>; Thu, 02 Oct 2025 13:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FF903A9B9D
	for <lists+linux-pm@lfdr.de>; Thu,  2 Oct 2025 11:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD423112C5;
	Thu,  2 Oct 2025 11:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2K1FyOdl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C47830B522
	for <linux-pm@vger.kernel.org>; Thu,  2 Oct 2025 11:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759404856; cv=none; b=V/ixXzt8MSjoCksSjOoi/CPV/8ZjBTLurOEq0zBkuGlWd4aZVYHDihMN7QJfoSSJjJuQc1LivtQCaNdLvTuXxm0fVJ5j9Y1m6HOGwMCvQ+5FoG/ivgsTGkYI9qlcr+4WIrahu0P6XAcluVp/fhTn2fxYgn2acXMjgKAxbhX25Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759404856; c=relaxed/simple;
	bh=jGzuARMYnBvr8zehQalwEPWJlbunoDDp9WM0aTu/GGg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZP7NgqTHNA4eulZMczbu43Ca6t4bcPZN9M+1qQLyJidCFIvIGPSkBSiD7MG6RvGErSx2bt4COAnR4K0wI6yTlWr4mZ5erA/PG82vopEHmsKPZuiz5jRDMCsFGE9e524a+OSyWJ2DggVvG0aCfycrqDVMZimzSmLB4Wk8FlLjaEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2K1FyOdl; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-63049fca047so1205090a12.2
        for <linux-pm@vger.kernel.org>; Thu, 02 Oct 2025 04:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759404852; x=1760009652; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z336Gm+cXT/UC4w0tslyQ8BibQkKtAXFk7vuVFzlfeA=;
        b=2K1FyOdlo3UIrximlpqg2XmXJQRzmYOWpD/OWzCyUWyTJFxJVp1OLslekisNKc5tXk
         zTMUBYMad/YIL5I76baRdwLYqFePRYLcNYu7p4JftUTZIBUZQtSgXuly1vAfTe345wvL
         kgi2eSbDKGMeW6ZZ2Vl8unvLfuQMcI+lcEbVr72acLCdpKMABUfqgzyNNmXZn3Ji95Sv
         8YPCtuObD0ltufuqlAChcOMP0I/nCWFKGC85PSU8oud8hqQFqh/xY3B3yuYPZeVULd2K
         EOthOqiCaSd27WT1BRWfrJ6lv4pguyMAOwW1NfWcxHDd0TQWlX1b+1rJx6HpPeXzzU9u
         esYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759404852; x=1760009652;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z336Gm+cXT/UC4w0tslyQ8BibQkKtAXFk7vuVFzlfeA=;
        b=JMDVUwf2Szc6MMSDVpV0yxwpYA+XSmGXaP3PwSBdITiPBB7Y26/hrLr97/QSoeHU/o
         EiEqqHUy2mqmLlILlF1s55+adrgDprJaSmULZd3SfPbsSf6U52uxLVLGL51MyxbPdUIm
         ExWoz2d19ObwTC0JHe+hcI8opqVSSqcRqj8OVKvoiwBIxplIFrID4xSifuA/NaDQV3pw
         nDP/I8bz6rBV6P3QqvUCI+0XGjTngvbKNkLqGeIst4H1Wec437p0+t216HdIFMFJk8mg
         aeGqg5d4ILLOS1O/l26FmcFjULotcNuT6rc7WGxYlttx3kgaUdIy6gsHXt4tJ3PXMLxl
         gotQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjIhN1Ncf3ueH+oIESXYVXkwuqDRGYDDEpyGjYfBozvtgN45syhoY1oFGG9aj2791PC2SOZZwZoQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwhEdSQV4phbMkMZ9/kBbhs2f7tLNNxn8jRACBAMKHNy3rbHM7B
	Dl2qSW1KB+o9jW2G9wffjmYAtJt5PXliQ//ziGFDSx75Nig0hzmlnVShI/s4zNkX8PCrRUXpPfp
	rL4j7uA==
X-Google-Smtp-Source: AGHT+IFAVHO3UURkms4Px09NV4CiDY2z3xTeYtmA76T6c6XpkpIyxX6hgNSwOsfI7DB7ygO5B6MwLch1EDU=
X-Received: from edyb2.prod.google.com ([2002:aa7:df82:0:b0:634:5269:e012])
 (user=srosek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:354f:b0:634:b651:48b9
 with SMTP id 4fb4d7f45d1cf-63678bce60amr7133335a12.4.1759404852085; Thu, 02
 Oct 2025 04:34:12 -0700 (PDT)
Date: Thu,  2 Oct 2025 11:34:03 +0000
In-Reply-To: <20251002113404.3117429-1-srosek@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251002113404.3117429-1-srosek@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251002113404.3117429-6-srosek@google.com>
Subject: [PATCH v3 5/6] ACPI: platform: Add macro for acpi platform driver
From: Slawomir Rosek <srosek@google.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Alex Hung <alexhung@gmail.com>, 
	Hans de Goede <hansg@kernel.org>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, 
	AceLan Kao <acelan.kao@canonical.com>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Tomasz Nowicki <tnowicki@google.com>, 
	Stanislaw Kardach <skardach@google.com>, Michal Krawczyk <mikrawczyk@google.com>, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org, 
	Slawomir Rosek <srosek@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce module_acpi_platform_driver() macro to simplify dynamic
enumeration of ACPI device objects on the platform bus by loadable
modules. Move common code from the intel-hid and intel-vbtn drivers
to the ACPI platform core.

Signed-off-by: Slawomir Rosek <srosek@google.com>
---
 drivers/acpi/acpi_platform.c      | 27 +++++++++++++++++++++++++
 drivers/platform/x86/intel/hid.c  | 33 +++----------------------------
 drivers/platform/x86/intel/vbtn.c | 30 +---------------------------
 include/linux/platform_device.h   | 17 ++++++++++++++++
 4 files changed, 48 insertions(+), 59 deletions(-)

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index 48d15dd785f6..adf32ffa6be6 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -190,6 +190,33 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
 }
 EXPORT_SYMBOL_GPL(acpi_create_platform_device);
 
+static acpi_status
+__acpi_platform_driver_register_cb(acpi_handle handle, u32 lvl,
+				void *context, void **rv)
+{
+	const struct acpi_device_id *ids = context;
+	struct acpi_device *dev = acpi_fetch_acpi_dev(handle);
+
+	if (dev && acpi_match_device_ids(dev, ids) == 0)
+		if (!IS_ERR_OR_NULL(acpi_create_platform_device(dev, NULL))) {
+			dev_info(&dev->dev,
+				 "created platform device\n");
+		}
+
+	return AE_OK;
+}
+
+int __acpi_platform_driver_register(struct platform_driver *drv,
+				struct module *owner)
+{
+	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT, ACPI_UINT32_MAX,
+			    __acpi_platform_driver_register_cb, NULL,
+			    (void *)drv->driver.acpi_match_table, NULL);
+
+	return __platform_driver_register(drv, owner);
+}
+EXPORT_SYMBOL_GPL(__acpi_platform_driver_register);
+
 void __init acpi_platform_init(void)
 {
 	acpi_reconfig_notifier_register(&acpi_platform_notifier);
diff --git a/drivers/platform/x86/intel/hid.c b/drivers/platform/x86/intel/hid.c
index f25a427cccda..37f990686446 100644
--- a/drivers/platform/x86/intel/hid.c
+++ b/drivers/platform/x86/intel/hid.c
@@ -775,34 +775,7 @@ static struct platform_driver intel_hid_pl_driver = {
  *
  * As a workaround until the ACPI core figures out how to handle
  * this corner case, manually ask the ACPI platform device code to
- * claim the ACPI node.
+ * claim the ACPI node by using module_acpi_platform_driver()
+ * instead of the regular module_platform_driver().
  */
-static acpi_status __init
-check_acpi_dev(acpi_handle handle, u32 lvl, void *context, void **rv)
-{
-	const struct acpi_device_id *ids = context;
-	struct acpi_device *dev = acpi_fetch_acpi_dev(handle);
-
-	if (dev && acpi_match_device_ids(dev, ids) == 0)
-		if (!IS_ERR_OR_NULL(acpi_create_platform_device(dev, NULL)))
-			dev_info(&dev->dev,
-				 "intel-hid: created platform device\n");
-
-	return AE_OK;
-}
-
-static int __init intel_hid_init(void)
-{
-	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
-			    ACPI_UINT32_MAX, check_acpi_dev, NULL,
-			    (void *)intel_hid_ids, NULL);
-
-	return platform_driver_register(&intel_hid_pl_driver);
-}
-module_init(intel_hid_init);
-
-static void __exit intel_hid_exit(void)
-{
-	platform_driver_unregister(&intel_hid_pl_driver);
-}
-module_exit(intel_hid_exit);
+module_acpi_platform_driver(intel_hid_pl_driver);
diff --git a/drivers/platform/x86/intel/vbtn.c b/drivers/platform/x86/intel/vbtn.c
index 232cd12e3c9f..42932479de35 100644
--- a/drivers/platform/x86/intel/vbtn.c
+++ b/drivers/platform/x86/intel/vbtn.c
@@ -390,32 +390,4 @@ static struct platform_driver intel_vbtn_pl_driver = {
 	.remove = intel_vbtn_remove,
 };
 
-static acpi_status __init
-check_acpi_dev(acpi_handle handle, u32 lvl, void *context, void **rv)
-{
-	const struct acpi_device_id *ids = context;
-	struct acpi_device *dev = acpi_fetch_acpi_dev(handle);
-
-	if (dev && acpi_match_device_ids(dev, ids) == 0)
-		if (!IS_ERR_OR_NULL(acpi_create_platform_device(dev, NULL)))
-			dev_info(&dev->dev,
-				 "intel-vbtn: created platform device\n");
-
-	return AE_OK;
-}
-
-static int __init intel_vbtn_init(void)
-{
-	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
-			    ACPI_UINT32_MAX, check_acpi_dev, NULL,
-			    (void *)intel_vbtn_ids, NULL);
-
-	return platform_driver_register(&intel_vbtn_pl_driver);
-}
-module_init(intel_vbtn_init);
-
-static void __exit intel_vbtn_exit(void)
-{
-	platform_driver_unregister(&intel_vbtn_pl_driver);
-}
-module_exit(intel_vbtn_exit);
+module_acpi_platform_driver(intel_vbtn_pl_driver);
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 074754c23d33..3b70b054d8a5 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -264,6 +264,14 @@ extern int __platform_driver_register(struct platform_driver *,
 					struct module *);
 extern void platform_driver_unregister(struct platform_driver *);
 
+/*
+ * use a macro to avoid include chaining to get THIS_MODULE
+ */
+#define acpi_platform_driver_register(drv) \
+	__acpi_platform_driver_register(drv, THIS_MODULE)
+extern int __acpi_platform_driver_register(struct platform_driver *,
+					struct module *);
+
 /* non-hotpluggable platform devices may use this so that probe() and
  * its support may live in __init sections, conserving runtime memory.
  */
@@ -292,6 +300,15 @@ static inline void platform_set_drvdata(struct platform_device *pdev,
 	module_driver(__platform_driver, platform_driver_register, \
 			platform_driver_unregister)
 
+/* module_acpi_platform_driver() - Helper macro for drivers that don't do
+ * anything special in module init/exit.  This eliminates a lot of
+ * boilerplate.  Each module may only use this macro once, and
+ * calling it replaces module_init() and module_exit()
+ */
+#define module_acpi_platform_driver(__platform_driver) \
+	module_driver(__platform_driver, acpi_platform_driver_register, \
+			platform_driver_unregister)
+
 /* builtin_platform_driver() - Helper macro for builtin drivers that
  * don't do anything special in driver init.  This eliminates some
  * boilerplate.  Each driver may only use this macro once, and
-- 
2.51.0.618.g983fd99d29-goog


