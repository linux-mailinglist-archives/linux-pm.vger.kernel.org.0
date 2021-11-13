Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D585B44F284
	for <lists+linux-pm@lfdr.de>; Sat, 13 Nov 2021 11:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbhKMKpd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 13 Nov 2021 05:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235821AbhKMKpa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 13 Nov 2021 05:45:30 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BC0C061767;
        Sat, 13 Nov 2021 02:42:38 -0800 (PST)
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1636800156;
        bh=QxJBOoxYey+j4x0YV6CgxD72MhZoalFtY91GcglpMkM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=senmAwS+5Prs+xkmfqgK4DzCHV/0/Wy1mE+ytdQMgJjrcqgDkWTPYeR0haIOTVXHC
         UruuOEfepHFSJ6Do9OeiMqjA06Bmu3M7KEFJuWfohZc4ehKJHm0mZNeXlTN7ZX5YkC
         rOO+bYVQKbUPwYN0DmRUr2HS3mmq6Ou5Dh75O7u4=
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
Subject: [PATCH 1/4] power: supply: add charge_behaviour attributes
Date:   Sat, 13 Nov 2021 11:42:22 +0100
Message-Id: <20211113104225.141333-2-linux@weissschuh.net>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211113104225.141333-1-linux@weissschuh.net>
References: <20211113104225.141333-1-linux@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 Documentation/ABI/testing/sysfs-class-power | 14 ++++++++++++++
 include/linux/power_supply.h                |  7 +++++++
 2 files changed, 21 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index f7904efc4cfa..cece094764f8 100644
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
-- 
2.33.1

