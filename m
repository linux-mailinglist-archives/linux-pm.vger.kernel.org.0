Return-Path: <linux-pm+bounces-6453-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2AE8A631B
	for <lists+linux-pm@lfdr.de>; Tue, 16 Apr 2024 07:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D79DE28237B
	for <lists+linux-pm@lfdr.de>; Tue, 16 Apr 2024 05:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872733C064;
	Tue, 16 Apr 2024 05:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UDi5ZzDi"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1B23B78D
	for <linux-pm@vger.kernel.org>; Tue, 16 Apr 2024 05:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713245991; cv=none; b=Za4kGBCxuiYsAz8hqos35FpcZsbXNonhwCuF4/FsRXg/vL7/d69BZlxWQaFT2m1hmd0X86NKQllu5zefFo/1O8mNGujWpOdbesFIEGMx00zY/iRzJHs3QZxdUEA4Ogkosypa9qS7SosPKE25lRDxjTZJWvSTwF16spbyt+ufKiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713245991; c=relaxed/simple;
	bh=Nku8TS1wMiFLplVVxpdO3JkSes4YA0gaL2IquRgtu/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J78TvjITuv7IL370cSy9QuRFGkPl6pZESLbBGzanRgtB5djUeBwm1jVkyioCd4tYoBCk+vChLEHEcA71YTG2h35a778b0WBetjBEWR/b+8GFUk30DZS+OMSb4AtLH2Sj6sA8GvsLAF6VhbHwDhTJNSehKCRKvDq19nXnGcwun84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UDi5ZzDi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713245988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0PPjH5ogqqD10NyBQ3gLfVf4axP6G/LJix2SPW5Xsxo=;
	b=UDi5ZzDinfUIsDF/sOfIVF0PJMroy9NgzNYdLibBBQ8YBKZkAsOmX6cFKMK3s9LC957K+W
	DCe1EZR3dwLG6JfcVaGaQqPGSD5483dktELdlK/+lLU8wBV3Fv1VojdCh2m2V3Qa8TPeyL
	TrE9CgTT14yL4XoHn7WoC0gHwSRiSgA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-466-1X0Gv_-hOau6Wqr_aXJ1Fw-1; Tue,
 16 Apr 2024 01:39:43 -0400
X-MC-Unique: 1X0Gv_-hOau6Wqr_aXJ1Fw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 02F683803916;
	Tue, 16 Apr 2024 05:39:43 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4970C51EF;
	Tue, 16 Apr 2024 05:39:36 +0000 (UTC)
From: Kate Hsuan <hpa@redhat.com>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	linux-leds@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	=?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Kate Hsuan <hpa@redhat.com>
Subject: [PATCH v6 1/5] platform: x86-android-tablets: other: Add swnode for Xiaomi pad2 indicator LED
Date: Tue, 16 Apr 2024 13:39:05 +0800
Message-ID: <20240416053909.256319-2-hpa@redhat.com>
In-Reply-To: <20240416053909.256319-1-hpa@redhat.com>
References: <20240416053909.256319-1-hpa@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

KTD2026 LED controller manages the indicator LED for Xiaomi pad2. The ACPI
for it is not properly made so the kernel can't get a correct description.

This work adds a description for this RGB LED controller and also sets a
trigger to indicate the changing event (bq27520-0-charging). When it is
charging, the indicator LED will be turned on.

Signed-off-by: Kate Hsuan <hpa@redhat.com>
---
 .../platform/x86/x86-android-tablets/other.c  | 82 +++++++++++++++++++
 .../x86/x86-android-tablets/shared-psy-info.h |  2 +
 2 files changed, 84 insertions(+)

diff --git a/drivers/platform/x86/x86-android-tablets/other.c b/drivers/platform/x86/x86-android-tablets/other.c
index bc6bbf7ec6ea..c77d56454f2d 100644
--- a/drivers/platform/x86/x86-android-tablets/other.c
+++ b/drivers/platform/x86/x86-android-tablets/other.c
@@ -13,6 +13,8 @@
 #include <linux/input.h>
 #include <linux/platform_device.h>
 
+#include <dt-bindings/leds/common.h>
+
 #include "shared-psy-info.h"
 #include "x86-android-tablets.h"
 
@@ -593,6 +595,83 @@ const struct x86_dev_info whitelabel_tm800a550l_info __initconst = {
 	.gpiod_lookup_tables = whitelabel_tm800a550l_gpios,
 };
 
+/*
+ * The fwnode for ktd2026 on Xaomi pad2. It composed of a RGB LED node
+ * with three subnodes for each color. The RGB LED node is named
+ * "multi-led" to align with the name in the device tree.
+ */
+
+/* main fwnode for ktd2026 */
+static const struct software_node ktd2026_node = {
+	.name = "ktd2026"
+};
+
+static const struct property_entry ktd2026_rgb_led_props[] = {
+	PROPERTY_ENTRY_U32("reg", 0),
+	PROPERTY_ENTRY_U32("color", LED_COLOR_ID_RGB),
+	PROPERTY_ENTRY_STRING("function", "indicator"),
+	PROPERTY_ENTRY_STRING("linux,default-trigger", "bq27520-0-charging"),
+	{ }
+};
+
+static const struct software_node ktd2026_rgb_led_node = {
+	.name = "multi-led",
+	.properties = ktd2026_rgb_led_props,
+	.parent = &ktd2026_node,
+};
+
+static const struct property_entry ktd2026_blue_led_props[] = {
+	PROPERTY_ENTRY_U32("reg", 0),
+	PROPERTY_ENTRY_U32("color", LED_COLOR_ID_BLUE),
+	{ }
+};
+
+static const struct software_node ktd2026_blue_led_node = {
+	.properties = ktd2026_blue_led_props,
+	.parent = &ktd2026_rgb_led_node,
+};
+
+static const struct property_entry ktd2026_green_led_props[] = {
+	PROPERTY_ENTRY_U32("reg", 1),
+	PROPERTY_ENTRY_U32("color", LED_COLOR_ID_GREEN),
+	{ }
+};
+
+static const struct software_node ktd2026_green_led_node = {
+	.properties = ktd2026_green_led_props,
+	.parent = &ktd2026_rgb_led_node,
+};
+
+static const struct property_entry ktd2026_red_led_props[] = {
+	PROPERTY_ENTRY_U32("reg", 2),
+	PROPERTY_ENTRY_U32("color", LED_COLOR_ID_RED),
+	{ }
+};
+
+static const struct software_node ktd2026_red_led_node = {
+	.properties = ktd2026_red_led_props,
+	.parent = &ktd2026_rgb_led_node,
+};
+
+static const struct software_node *ktd2026_node_group[] = {
+	&ktd2026_node,
+	&ktd2026_rgb_led_node,
+	&ktd2026_green_led_node,
+	&ktd2026_blue_led_node,
+	&ktd2026_red_led_node,
+	NULL
+};
+
+static int __init xiaomi_mipad2_init(void)
+{
+	return software_node_register_node_group(ktd2026_node_group);
+}
+
+static void xiaomi_mipad2_exit(void)
+{
+	software_node_unregister_node_group(ktd2026_node_group);
+}
+
 /*
  * If the EFI bootloader is not Xiaomi's own signed Android loader, then the
  * Xiaomi Mi Pad 2 X86 tablet sets OSID in the DSDT to 1 (Windows), causing
@@ -616,6 +695,7 @@ static const struct x86_i2c_client_info xiaomi_mipad2_i2c_clients[] __initconst
 			.type = "ktd2026",
 			.addr = 0x30,
 			.dev_name = "ktd2026",
+			.swnode = &ktd2026_node,
 		},
 		.adapter_path = "\\_SB_.PCI0.I2C3",
 	},
@@ -624,4 +704,6 @@ static const struct x86_i2c_client_info xiaomi_mipad2_i2c_clients[] __initconst
 const struct x86_dev_info xiaomi_mipad2_info __initconst = {
 	.i2c_client_info = xiaomi_mipad2_i2c_clients,
 	.i2c_client_count = ARRAY_SIZE(xiaomi_mipad2_i2c_clients),
+	.init = xiaomi_mipad2_init,
+	.exit = xiaomi_mipad2_exit,
 };
diff --git a/drivers/platform/x86/x86-android-tablets/shared-psy-info.h b/drivers/platform/x86/x86-android-tablets/shared-psy-info.h
index c2d2968cddc2..8c33ec47ee12 100644
--- a/drivers/platform/x86/x86-android-tablets/shared-psy-info.h
+++ b/drivers/platform/x86/x86-android-tablets/shared-psy-info.h
@@ -29,4 +29,6 @@ extern const char * const bq24190_modules[];
 extern const struct platform_device_info int3496_pdevs[];
 extern struct gpiod_lookup_table int3496_reference_gpios;
 
+extern const struct software_node ktd2026_leds_node;
+
 #endif
-- 
2.44.0


