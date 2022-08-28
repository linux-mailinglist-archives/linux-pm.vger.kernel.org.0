Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4775A3F76
	for <lists+linux-pm@lfdr.de>; Sun, 28 Aug 2022 21:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiH1TaQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 28 Aug 2022 15:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiH1TaN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 28 Aug 2022 15:30:13 -0400
Received: from vorpal.se (vorpal.se [IPv6:2a01:7e00::f03c:91ff:fe73:398e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DB51902D;
        Sun, 28 Aug 2022 12:30:05 -0700 (PDT)
Received: by vorpal.se (Postfix) with ESMTPSA id 9ED24147F4;
        Sun, 28 Aug 2022 19:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=vorpal.se; s=2019;
        t=1661715004; bh=lZxnb9+Ch0KJgjfNLj2NHVG0apxT/rDWUg7oW4PPHVg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bevWrfOAa1eR6Waxr3EfqTl3ZDKOR7pBbL0oLsdiHnzqMqXXimwmuNCmYazbR6E/J
         s0eC9/3v/WxP4xYYY8MDq1w0SlBqe2cFmbRMa3KSF4dBdURs/a19qQ+RsvjqeEeGep
         G2SXcPNmHVZ715M+XS7OisSJ+HQecrZO7Ou09MkQuGSHncGRT1rb5QspdT/dPzru1+
         cYLgKVkzVEv0suJiXg1O11GHwNYyhehs6IS7VY4J6Q9qKn8W7Op4gpMO8fmohQMTqd
         52N7d0kQtgK0JwmJEz8TgH3uEZ1q26UgTI5EKf6QvgAjprKGZ5KJ7MT5RyHF8HnP48
         8NgkeVujkPV4w==
From:   Arvid Norlander <lkml@vorpal.se>
To:     platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Azael Avalos <coproscefalo@gmail.com>,
        Arvid Norlander <lkml@vorpal.se>
Subject: [PATCH 2/3] platform/x86: Battery charge mode in toshiba_acpi (sysfs)
Date:   Sun, 28 Aug 2022 21:29:19 +0200
Message-Id: <20220828192920.805253-3-lkml@vorpal.se>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220828192920.805253-1-lkml@vorpal.se>
References: <20220828192920.805253-1-lkml@vorpal.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
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
 drivers/platform/x86/toshiba_acpi.c | 93 +++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index c927d5d0f8cd..8e272b4336c6 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -44,6 +44,7 @@
 #include <linux/rfkill.h>
 #include <linux/iio/iio.h>
 #include <linux/toshiba.h>
+#include <acpi/battery.h>
 #include <acpi/video.h>
 
 MODULE_AUTHOR("John Belmonte");
@@ -2981,6 +2982,88 @@ static int toshiba_acpi_setup_backlight(struct toshiba_acpi_dev *dev)
 	return 0;
 }
 
+
+/* ACPI battery hooking */
+static ssize_t charge_control_end_threshold_show(struct device *device,
+						 struct device_attribute *attr,
+						 char *buf)
+{
+	int state;
+	int status;
+
+	if (toshiba_acpi == NULL) {
+		pr_err("Toshiba ACPI object invalid\n");
+		return -ENODEV;
+	}
+
+	status = toshiba_battery_charge_mode_get(toshiba_acpi, &state);
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
@@ -3063,6 +3146,9 @@ static int toshiba_acpi_remove(struct acpi_device *acpi_dev)
 		rfkill_destroy(dev->wwan_rfk);
 	}
 
+	if (dev->battery_charge_mode_supported)
+		battery_hook_unregister(&battery_hook);
+
 	if (toshiba_acpi)
 		toshiba_acpi = NULL;
 
@@ -3246,6 +3332,13 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
 
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
2.37.2

