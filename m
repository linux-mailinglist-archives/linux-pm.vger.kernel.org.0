Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854C3449C82
	for <lists+linux-pm@lfdr.de>; Mon,  8 Nov 2021 20:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235382AbhKHTcg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Nov 2021 14:32:36 -0500
Received: from todd.t-8ch.de ([159.69.126.157]:34617 "EHLO todd.t-8ch.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230136AbhKHTcf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Nov 2021 14:32:35 -0500
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1636399787;
        bh=lCoxgCkW+ya6kBvkFnYw9vuv4lbSkSjmPSR9jBoDfQI=;
        h=From:To:Cc:Subject:Date:From;
        b=nN+ZeA1gAJzoEnRYXi/+Z8oLrL4em2OLEZ+jEL6wptusYpidOwyLH1XHJQu5bd9HR
         22YE2eOhgerXevLMp3In7Q/ZuAFYTEWipWSPpHZHfyUB0wdm8q6NcY2Cpj0Urzr0Z4
         d7EKmyiWOr9Dorh3tOGTz+WybkU20UwLSUF3/Weo=
To:     linux-pm@vger.kernel.org
Cc:     nicolopiazzalunga@gmail.com, linrunner@gmx.net,
        platform-driver-x86@vger.kernel.org, smclt30p@gmail.com,
        sre@kernel.org,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [RFC v2] standardized attributes for powersupply charge behaviour
Date:   Mon,  8 Nov 2021 20:28:52 +0100
Message-Id: <20211108192852.357473-1-linux@weissschuh.net>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This a revised version of
"[RFC] add standardized attributes for force_discharge and inhibit_charge" [0],
incorporating discussion results.

The biggest change is the switch from two boolean attributes to a single
enum attribute.

[0] https://lore.kernel.org/platform-driver-x86/21569a89-8303-8573-05fb-c2fec29983d1@gmail.com/
---
 Documentation/ABI/testing/sysfs-class-power | 14 ++++++++++++++
 drivers/power/supply/power_supply_sysfs.c   |  1 +
 include/linux/power_supply.h                |  7 +++++++
 3 files changed, 22 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index ca830c6cd809..2f58cfc91420 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -455,6 +455,20 @@ Description:
 			      "Unknown", "Charging", "Discharging",
 			      "Not charging", "Full"
 
+What:		/sys/class/power_supply/<supply_name>/charge_behaviour
+Date:		November 2021
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Represents the charging behaviour.
+
+		Access: Read, Write
+
+		Valid values:
+			================ ====================================
+			auto:            Charge normally, respect thresholds
+			inhibit-charge:  Do not charge while AC is attached
+			force-discharge: Force discharge while AC is attached
+
 What:		/sys/class/power_supply/<supply_name>/technology
 Date:		May 2007
 Contact:	linux-pm@vger.kernel.org
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index c3d7cbcd4fad..26c60587dca1 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -172,6 +172,7 @@ static struct power_supply_attr power_supply_attrs[] = {
 	POWER_SUPPLY_ATTR(CHARGE_CONTROL_LIMIT_MAX),
 	POWER_SUPPLY_ATTR(CHARGE_CONTROL_START_THRESHOLD),
 	POWER_SUPPLY_ATTR(CHARGE_CONTROL_END_THRESHOLD),
+	POWER_SUPPLY_ENUM_ATTR(CHARGE_BEHAVIOUR),
 	POWER_SUPPLY_ATTR(INPUT_CURRENT_LIMIT),
 	POWER_SUPPLY_ATTR(INPUT_VOLTAGE_LIMIT),
 	POWER_SUPPLY_ATTR(INPUT_POWER_LIMIT),
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 9ca1f120a211..70c333e86293 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -132,6 +132,7 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX,
 	POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD, /* in percents! */
 	POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD, /* in percents! */
+	POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR,
 	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
 	POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT,
 	POWER_SUPPLY_PROP_INPUT_POWER_LIMIT,
@@ -202,6 +203,12 @@ enum power_supply_usb_type {
 	POWER_SUPPLY_USB_TYPE_APPLE_BRICK_ID,	/* Apple Charging Method */
 };
 
+enum power_supply_charge_behaviour {
+	POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO = 0,
+	POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE,
+	POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE,
+};
+
 enum power_supply_notifier_events {
 	PSY_EVENT_PROP_CHANGED,
 };

base-commit: 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f
-- 
2.33.1

