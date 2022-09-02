Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA885AB7E4
	for <lists+linux-pm@lfdr.de>; Fri,  2 Sep 2022 20:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235966AbiIBSAw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Sep 2022 14:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236047AbiIBSAu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Sep 2022 14:00:50 -0400
Received: from vorpal.se (vorpal.se [IPv6:2a01:7e00::f03c:91ff:fe73:398e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803C9E831B;
        Fri,  2 Sep 2022 11:00:49 -0700 (PDT)
Received: by vorpal.se (Postfix) with ESMTPSA id AC7A7147F4;
        Fri,  2 Sep 2022 18:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=vorpal.se; s=2019;
        t=1662141648; bh=ccHXtgR0Sig4hq5GeRCXK8FfWB+KXPN//Jm+lMKW/qc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T3MbLiEaPU1tJQGbLSp4jfiDuXmuqOob8G0abyDuTWcyh6vEWx46X9C60K59LJfoP
         vs+DKOYMvxWjxPvy4sJNiuZFDlCtRQm4MmlaItW5J2RlFBCMwizQEP5o/S1yLiJWCE
         UyYj7DFe7cgaMfZkRNsX3Xn8ImusS0nMUJKl43SJuL0ka8grXsocxULVf+S02d+Fpg
         Nq+fPPoM22/y7gTeev6kLbya1b6HEtubxfb0Sw+zu0VXQbCzrzrJq0FcPZa76DZEjI
         AT4GbP5sUpxrImSQoanbUmC0WGOS0R4v7gd1n6xTCrzq/O1QavakgAI56QYkE9ORP8
         xFP7INjkiaI4A==
From:   Arvid Norlander <lkml@vorpal.se>
To:     platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Azael Avalos <coproscefalo@gmail.com>,
        Arvid Norlander <lkml@vorpal.se>
Subject: [PATCH v2 2/3] platform/x86: Battery charge mode in toshiba_acpi (sysfs)
Date:   Fri,  2 Sep 2022 20:00:36 +0200
Message-Id: <20220902180037.1728546-3-lkml@vorpal.se>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220902180037.1728546-1-lkml@vorpal.se>
References: <20220902180037.1728546-1-lkml@vorpal.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,RCVD_IN_XBL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This commit adds the ACPI battery hook which in turns adds the sysfs
entries.

Because the Toshiba laptops only support two modes (eco or normal), which
in testing correspond to 80% and 100% we simply round to the nearest
possible level when set.

It is possible that Toshiba laptops other than the Z830 has different set
points for the charging. If so, a quirk table could be introduced in the
future for this. For now, assume that all laptops that support this feature
work the same way.

Tested on a Toshiba Satellite Z830.

Signed-off-by: Arvid Norlander <lkml@vorpal.se>
---
 drivers/platform/x86/toshiba_acpi.c | 97 +++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index c927d5d0f8cd..fc953d6bcb93 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -44,6 +44,7 @@
 #include <linux/rfkill.h>
 #include <linux/iio/iio.h>
 #include <linux/toshiba.h>
+#include <acpi/battery.h>
 #include <acpi/video.h>
 
 MODULE_AUTHOR("John Belmonte");
@@ -2981,6 +2982,92 @@ static int toshiba_acpi_setup_backlight(struct toshiba_acpi_dev *dev)
 	return 0;
 }
 
+
+/* ACPI battery hooking */
+static ssize_t charge_control_end_threshold_show(struct device *device,
+						 struct device_attribute *attr,
+						 char *buf)
+{
+	u32 state;
+	int status;
+
+	if (toshiba_acpi == NULL) {
+		pr_err("Toshiba ACPI object invalid\n");
+		return -ENODEV;
+	}
+
+	status = toshiba_battery_charge_mode_get(toshiba_acpi, &state);
+
+	if (status != 0)
+		return status;
+
+	if (state == 1)
+		return sprintf(buf, "80\n");
+	else
+		return sprintf(buf, "100\n");
+}
+
+static ssize_t charge_control_end_threshold_store(struct device *dev,
+						  struct device_attribute *attr,
+						  const char *buf,
+						  size_t count)
+{
+	u32 value;
+	int rval;
+
+	if (toshiba_acpi == NULL) {
+		pr_err("Toshiba ACPI object invalid\n");
+		return -ENODEV;
+	}
+
+	rval = kstrtou32(buf, 10, &value);
+	if (rval)
+		return rval;
+
+	if (value < 1 || value > 100)
+		return -EINVAL;
+	rval = toshiba_battery_charge_mode_set(toshiba_acpi,
+					       (value < 90) ? 1 : 0);
+	if (rval < 0)
+		return rval;
+	else
+		return count;
+}
+
+static DEVICE_ATTR_RW(charge_control_end_threshold);
+
+static struct attribute *toshiba_acpi_battery_attrs[] = {
+	&dev_attr_charge_control_end_threshold.attr,
+	NULL,
+};
+
+ATTRIBUTE_GROUPS(toshiba_acpi_battery);
+
+static int toshiba_acpi_battery_add(struct power_supply *battery)
+{
+	if (toshiba_acpi == NULL) {
+		pr_err("Init order issue\n");
+		return -ENODEV;
+	}
+	if (!toshiba_acpi->battery_charge_mode_supported)
+		return -ENODEV;
+	if (device_add_groups(&battery->dev, toshiba_acpi_battery_groups))
+		return -ENODEV;
+	return 0;
+}
+
+static int toshiba_acpi_battery_remove(struct power_supply *battery)
+{
+	device_remove_groups(&battery->dev, toshiba_acpi_battery_groups);
+	return 0;
+}
+
+static struct acpi_battery_hook battery_hook = {
+	.add_battery = toshiba_acpi_battery_add,
+	.remove_battery = toshiba_acpi_battery_remove,
+	.name = "Toshiba Battery Extension",
+};
+
 static void print_supported_features(struct toshiba_acpi_dev *dev)
 {
 	pr_info("Supported laptop features:");
@@ -3063,6 +3150,9 @@ static int toshiba_acpi_remove(struct acpi_device *acpi_dev)
 		rfkill_destroy(dev->wwan_rfk);
 	}
 
+	if (dev->battery_charge_mode_supported)
+		battery_hook_unregister(&battery_hook);
+
 	if (toshiba_acpi)
 		toshiba_acpi = NULL;
 
@@ -3246,6 +3336,13 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
 
 	toshiba_acpi = dev;
 
+	/*
+	 * As the battery hook relies on the static variable toshiba_acpi being
+	 * set, this must be done after toshiba_acpi is assigned.
+	 */
+	if (dev->battery_charge_mode_supported)
+		battery_hook_register(&battery_hook);
+
 	return 0;
 
 error:
-- 
2.37.3

