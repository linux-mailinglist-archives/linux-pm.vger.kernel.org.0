Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7EEA45B01A
	for <lists+linux-pm@lfdr.de>; Wed, 24 Nov 2021 00:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240354AbhKWXa1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Nov 2021 18:30:27 -0500
Received: from todd.t-8ch.de ([159.69.126.157]:55485 "EHLO todd.t-8ch.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240234AbhKWXaY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Nov 2021 18:30:24 -0500
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1637710028;
        bh=ubpC/4tVq2wPO3RjwZsGHEo8sdCshhNkUuFARYO2hlg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NlNIdkYeXjBMf+ZkMSwEKARWpzUuFtUM2v0++eDFPVXVW4niDr99KpYrElnPCIb8y
         N9AwJQ4WdlIycMz1wiM/h0BBykWYhxWY2ZpuqmueQ6uwxrno/C7TErErBNovVupROV
         PozOZri5Xf7+O5KwNKhu4TccJLlP0jNNy7tAz5bA=
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
Subject: [PATCH v2 2/4] power: supply: add helpers for charge_behaviour sysfs
Date:   Wed, 24 Nov 2021 00:27:02 +0100
Message-Id: <20211123232704.25394-3-linux@weissschuh.net>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211123232704.25394-1-linux@weissschuh.net>
References: <20211123232704.25394-1-linux@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1637710019; l=3306; s=20211113; h=from:subject; bh=ubpC/4tVq2wPO3RjwZsGHEo8sdCshhNkUuFARYO2hlg=; b=eMMI5CuiEYHqc4kRREJLyPoXw87ZNBQLiFITVqfqWbxdFeYulEM3XuvMKUX/rYNsPq2wSKDvlvgF STKS7sEnB1waXnU7NezjuI2a5lywAbjMtty01u2JVV8nlrWlFBwQ
X-Developer-Key: i=linux@weissschuh.net; a=ed25519; pk=9LP6KM4vD/8CwHW7nouRBhWLyQLcK1MkP6aTZbzUlj4=
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
 drivers/power/supply/power_supply_sysfs.c | 55 +++++++++++++++++++++++
 include/linux/power_supply.h              |  9 ++++
 2 files changed, 64 insertions(+)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index c3d7cbcd4fad..5e3b8c15ddbe 100644
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
@@ -484,3 +490,52 @@ int power_supply_uevent(struct device *dev, struct kobj_uevent_env *env)
 
 	return ret;
 }
+
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
+			count += sysfs_emit_at(buf, count, "[%s] ",
+					       POWER_SUPPLY_CHARGE_BEHAVIOUR_TEXT[i]);
+			match = true;
+		} else if (available) {
+			count += sysfs_emit_at(buf, count, "%s ",
+					       POWER_SUPPLY_CHARGE_BEHAVIOUR_TEXT[i]);
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
+	if (i < 0)
+		return i;
+
+	if (available_behaviours & BIT(i))
+		return i;
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(power_supply_charge_behaviour_parse);
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
2.34.0

