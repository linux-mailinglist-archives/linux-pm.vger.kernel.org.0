Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810631D1E61
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 20:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389946AbgEMS5y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 May 2020 14:57:54 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51886 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390068AbgEMS4e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2020 14:56:34 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id E38EE2A25D4
Received: by jupiter.universe (Postfix, from userid 1000)
        id 6F40C480102; Wed, 13 May 2020 20:56:29 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv1 04/19] power: supply: core: add POWER_SUPPLY_HEALTH_CALIBRATION_REQUIRED
Date:   Wed, 13 May 2020 20:56:00 +0200
Message-Id: <20200513185615.508236-5-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513185615.508236-1-sebastian.reichel@collabora.com>
References: <20200513185615.508236-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Some battery fuel gauges know when the battery needs to
be recalibrated before providing usable values. This
should be reported via the health property.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 Documentation/ABI/testing/sysfs-class-power | 2 +-
 drivers/power/supply/power_supply_sysfs.c   | 1 +
 include/linux/power_supply.h                | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index e6d7348766b2..216d61a22f1e 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -205,7 +205,7 @@ Description:
 		Valid values: "Unknown", "Good", "Overheat", "Dead",
 			      "Over voltage", "Unspecified failure", "Cold",
 			      "Watchdog timer expire", "Safety timer expire",
-			      "Over current"
+			      "Over current", "Calibration required"
 
 What:		/sys/class/power_supply/<supply_name>/precharge_current
 Date:		June 2017
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 78d5382e69f1..bc79560229b5 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -100,6 +100,7 @@ static const char * const POWER_SUPPLY_HEALTH_TEXT[] = {
 	[POWER_SUPPLY_HEALTH_WATCHDOG_TIMER_EXPIRE] = "Watchdog timer expire",
 	[POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXPIRE]   = "Safety timer expire",
 	[POWER_SUPPLY_HEALTH_OVERCURRENT]	    = "Over current",
+	[POWER_SUPPLY_HEALTH_CALIBRATION_REQUIRED]  = "Calibration required",
 };
 
 static const char * const POWER_SUPPLY_TECHNOLOGY_TEXT[] = {
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 63ffe2a0a87b..ac1345a48ad0 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -61,6 +61,7 @@ enum {
 	POWER_SUPPLY_HEALTH_WATCHDOG_TIMER_EXPIRE,
 	POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXPIRE,
 	POWER_SUPPLY_HEALTH_OVERCURRENT,
+	POWER_SUPPLY_HEALTH_CALIBRATION_REQUIRED,
 };
 
 enum {
-- 
2.26.2

