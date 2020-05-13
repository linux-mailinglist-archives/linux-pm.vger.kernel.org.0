Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B88551D1E5D
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 20:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390374AbgEMS4e (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 May 2020 14:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390370AbgEMS4d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2020 14:56:33 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B186FC061A0C;
        Wed, 13 May 2020 11:56:33 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id E65ED2A27A9
Received: by jupiter.universe (Postfix, from userid 1000)
        id 6C7E8480101; Wed, 13 May 2020 20:56:29 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv1 03/19] power: supply: core: add manufacture date properties
Date:   Wed, 13 May 2020 20:55:59 +0200
Message-Id: <20200513185615.508236-4-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513185615.508236-1-sebastian.reichel@collabora.com>
References: <20200513185615.508236-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Some smart batteries store their manufacture date, which is
useful to identify the battery and/or to know about the cell
quality.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 Documentation/ABI/testing/sysfs-class-power | 28 +++++++++++++++++++++
 drivers/power/supply/power_supply_sysfs.c   |  3 +++
 include/linux/power_supply.h                |  3 +++
 3 files changed, 34 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index 2f896555ae23..e6d7348766b2 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -680,3 +680,31 @@ Description:
 		Valid values:
 		- 1: enabled
 		- 0: disabled
+
+What:		/sys/class/power_supply/<supply_name>/manufacture_year
+Date:		January 2020
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the year (following Gregorian calendar) when the device has been
+		manufactured.
+
+		Access: Read
+		Valid values: Reported as integer
+
+What:		/sys/class/power_supply/<supply_name>/manufacture_month
+Date:		January 2020
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the month when the device has been manufactured.
+
+		Access: Read
+		Valid values: 1-12
+
+What:		/sys/class/power_supply/<supply_name>/manufacture_day
+Date:		January 2020
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the day of month when the device has been manufactured.
+
+		Access: Read
+		Valid values: 1-31
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index e664774a2d1e..78d5382e69f1 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -198,6 +198,9 @@ static struct power_supply_attr power_supply_attrs[] = {
 	POWER_SUPPLY_ATTR(PRECHARGE_CURRENT),
 	POWER_SUPPLY_ATTR(CHARGE_TERM_CURRENT),
 	POWER_SUPPLY_ATTR(CALIBRATE),
+	POWER_SUPPLY_ATTR(MANUFACTURE_YEAR),
+	POWER_SUPPLY_ATTR(MANUFACTURE_MONTH),
+	POWER_SUPPLY_ATTR(MANUFACTURE_DAY),
 	/* Properties of type `const char *' */
 	POWER_SUPPLY_ATTR(MODEL_NAME),
 	POWER_SUPPLY_ATTR(MANUFACTURER),
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 453a85f25635..63ffe2a0a87b 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -159,6 +159,9 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_PRECHARGE_CURRENT,
 	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
 	POWER_SUPPLY_PROP_CALIBRATE,
+	POWER_SUPPLY_PROP_MANUFACTURE_YEAR,
+	POWER_SUPPLY_PROP_MANUFACTURE_MONTH,
+	POWER_SUPPLY_PROP_MANUFACTURE_DAY,
 	/* Properties of type `const char *' */
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,
-- 
2.26.2

