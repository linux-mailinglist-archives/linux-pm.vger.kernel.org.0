Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75FBC44F281
	for <lists+linux-pm@lfdr.de>; Sat, 13 Nov 2021 11:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235827AbhKMKpc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 13 Nov 2021 05:45:32 -0500
Received: from todd.t-8ch.de ([159.69.126.157]:59913 "EHLO todd.t-8ch.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235804AbhKMKpa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 13 Nov 2021 05:45:30 -0500
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1636800156;
        bh=aTqKITwe2LA7y1VMDsmOTFPBsA/vzvyEueKa2dGlxMk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ln286Z6jptypnEoyobbtP9PxcPsWu8r/CKukBuUJkpJlubmpTSIXJf+RzbRNShdsu
         gJE8y00lA+rNzGD29LBgmuRg5TU7yewEpdrv1p5YRy8mkkzt82tZPsvqdIXwYYcPGi
         iwdb27ZTDLmhYeNN7WWcnbreYbdPkPG60lRd04TQ=
To:     linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        Mark Gross <markgross@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc:     =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org, linrunner@gmx.net, bberg@redhat.com,
        hadess@hadess.net, markpearson@lenovo.com,
        nicolopiazzalunga@gmail.com, njoshi1@lenovo.com, smclt30p@gmail.com
Subject: [PATCH 2/4] power: supply: add helpers for charge_behaviour sysfs
Date:   Sat, 13 Nov 2021 11:42:23 +0100
Message-Id: <20211113104225.141333-3-linux@weissschuh.net>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211113104225.141333-1-linux@weissschuh.net>
References: <20211113104225.141333-1-linux@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

These helper functions can be used by drivers to implement their own
sysfs-attributes.
This is useful for ACPI-drivers extending the default ACPI-battery with
their own charge_behaviour attributes.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/power_supply_sysfs.c | 51 +++++++++++++++++++++++
 include/linux/power_supply.h              |  9 ++++
 2 files changed, 60 insertions(+)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index c3d7cbcd4fad..171341bcef1d 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -133,6 +133,12 @@ static const char * const POWER_SUPPLY_SCOPE_TEXT[] = {
 	[POWER_SUPPLY_SCOPE_DEVICE]	= "Device",
 };
 
+static const char * const POWER_SUPPLY_CHARGE_BEHAVIOUR_TEXT[] = {
+	[POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO]		= "auto",
+	[POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE]	= "inhibit-charge",
+	[POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE]	= "force-discharge",
+};
+
 static struct power_supply_attr power_supply_attrs[] = {
 	/* Properties of type `int' */
 	POWER_SUPPLY_ENUM_ATTR(STATUS),
@@ -226,6 +232,51 @@ static enum power_supply_property dev_attr_psp(struct device_attribute *attr)
 	return  to_ps_attr(attr) - power_supply_attrs;
 }
 
+ssize_t power_supply_charge_behaviour_show(struct device *dev,
+					   unsigned int available_behaviours,
+					   enum power_supply_charge_behaviour current_behaviour,
+					   char *buf)
+{
+	bool match = false, available, active;
+	ssize_t count = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(POWER_SUPPLY_CHARGE_BEHAVIOUR_TEXT); i++) {
+		available = available_behaviours & BIT(i);
+		active = i == current_behaviour;
+
+		if (available && active) {
+			count += sprintf(buf + count, "[%s] ",
+					 POWER_SUPPLY_CHARGE_BEHAVIOUR_TEXT[i]);
+			match = true;
+		} else if (available) {
+			count += sprintf(buf + count, "%s ",
+					 POWER_SUPPLY_CHARGE_BEHAVIOUR_TEXT[i]);
+		}
+	}
+
+	if (!match) {
+		dev_warn(dev, "driver reporting unsupported charge behaviour\n");
+		return -EINVAL;
+	}
+
+	if (count)
+		buf[count - 1] = '\n';
+
+	return count;
+}
+EXPORT_SYMBOL_GPL(power_supply_charge_behaviour_show);
+
+int power_supply_charge_behaviour_parse(unsigned int available_behaviours, const char *buf)
+{
+	int i = sysfs_match_string(POWER_SUPPLY_CHARGE_BEHAVIOUR_TEXT, buf);
+
+	if (available_behaviours & BIT(i))
+		return i;
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(power_supply_charge_behaviour_parse);
+
 static ssize_t power_supply_show_usb_type(struct device *dev,
 					  const struct power_supply_desc *desc,
 					  union power_supply_propval *value,
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 70c333e86293..71f0379c2af8 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -546,4 +546,13 @@ static inline
 void power_supply_remove_hwmon_sysfs(struct power_supply *psy) {}
 #endif
 
+#ifdef CONFIG_SYSFS
+ssize_t power_supply_charge_behaviour_show(struct device *dev,
+					   unsigned int available_behaviours,
+					   enum power_supply_charge_behaviour behaviour,
+					   char *buf);
+
+int power_supply_charge_behaviour_parse(unsigned int available_behaviours, const char *buf);
+#endif
+
 #endif /* __LINUX_POWER_SUPPLY_H__ */
-- 
2.33.1

