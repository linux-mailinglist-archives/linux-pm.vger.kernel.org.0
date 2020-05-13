Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48E661D1E65
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 20:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390363AbgEMS4d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 May 2020 14:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390361AbgEMS4d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2020 14:56:33 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38190C061A0C;
        Wed, 13 May 2020 11:56:33 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id D71732A251E
Received: by jupiter.universe (Postfix, from userid 1000)
        id 6A140480100; Wed, 13 May 2020 20:56:29 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv1 02/19] power: supply: core: add capacity error margin property
Date:   Wed, 13 May 2020 20:55:58 +0200
Message-Id: <20200513185615.508236-3-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513185615.508236-1-sebastian.reichel@collabora.com>
References: <20200513185615.508236-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a property for reporting the error margin expected
by fuel gauge chips.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 Documentation/ABI/testing/sysfs-class-power | 15 +++++++++++++++
 drivers/power/supply/power_supply_sysfs.c   |  1 +
 include/linux/power_supply.h                |  1 +
 3 files changed, 17 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index bf3b48f022dc..2f896555ae23 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -74,6 +74,21 @@ Description:
 		Access: Read, Write
 		Valid values: 0 - 100 (percent)
 
+What:		/sys/class/power_supply/<supply_name>/capacity_error_margin
+Date:		April 2019
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Battery capacity measurement becomes unreliable without
+		recalibration. This values provides the maximum error
+		margin expected to exist by the fuel gauge in percent.
+		Values close to 0% will be returned after (re-)calibration
+		has happened. Over time the error margin will increase.
+		100% means, that the capacity related values are basically
+		completely useless.
+
+		Access: Read
+		Valid values: 0 - 100 (percent)
+
 What:		/sys/class/power_supply/<supply_name>/capacity_level
 Date:		June 2009
 Contact:	linux-pm@vger.kernel.org
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index d21b4e0edf38..e664774a2d1e 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -178,6 +178,7 @@ static struct power_supply_attr power_supply_attrs[] = {
 	POWER_SUPPLY_ATTR(CAPACITY),
 	POWER_SUPPLY_ATTR(CAPACITY_ALERT_MIN),
 	POWER_SUPPLY_ATTR(CAPACITY_ALERT_MAX),
+	POWER_SUPPLY_ATTR(CAPACITY_ERROR_MARGIN),
 	POWER_SUPPLY_ENUM_ATTR(CAPACITY_LEVEL),
 	POWER_SUPPLY_ATTR(TEMP),
 	POWER_SUPPLY_ATTR(TEMP_MAX),
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 1f60731ec7fe..453a85f25635 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -139,6 +139,7 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_CAPACITY, /* in percents! */
 	POWER_SUPPLY_PROP_CAPACITY_ALERT_MIN, /* in percents! */
 	POWER_SUPPLY_PROP_CAPACITY_ALERT_MAX, /* in percents! */
+	POWER_SUPPLY_PROP_CAPACITY_ERROR_MARGIN, /* in percents! */
 	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
 	POWER_SUPPLY_PROP_TEMP,
 	POWER_SUPPLY_PROP_TEMP_MAX,
-- 
2.26.2

