Return-Path: <linux-pm+bounces-21328-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7FAA272EB
	for <lists+linux-pm@lfdr.de>; Tue,  4 Feb 2025 14:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05AC118828AA
	for <lists+linux-pm@lfdr.de>; Tue,  4 Feb 2025 13:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD2D213259;
	Tue,  4 Feb 2025 13:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nizkzqTS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224B820D4FD;
	Tue,  4 Feb 2025 13:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738674638; cv=none; b=raZynTiuzjmMpIafX4VWzxsLwrW9iTPf5PHwwJEfSzG/5cLLaen0to41rOoHSa8wUKhh4iTuMjFAOcKoSBXi3cbHStWfYwLmNVLy2SAj1g+mypVNK9kJdWy3XhNBlqO1IDqsD87K51MQecfoKZJpFtHfhUwQlv7hJoBQXihbgbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738674638; c=relaxed/simple;
	bh=9tzbQloTVlXYoOuUK3F9IbenJ6Yspq92dEOK7eX4dns=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=px8cu0lUwBSpZ9B54Kp0CyEXBbgcU40vfNCYbJ3S+fZYy4GsPayQUgO4eyXL1oFVheACBNdA4+/q+0nNDEKXv4nQaz+qGB++LzLL0aiKVtISFoCIsJ/e56xjlZNwOD+UjoBQ0FRkS2QYwDfHU9v4Cn0DV28z4FCLu8FPZUWa70M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nizkzqTS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EEB1EC4CEDF;
	Tue,  4 Feb 2025 13:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738674638;
	bh=9tzbQloTVlXYoOuUK3F9IbenJ6Yspq92dEOK7eX4dns=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=nizkzqTS/pFplMdkLUoPjHF+flnTkjvUdzdqhqRjN4XV8Z8WmQRxhla8JfTOFkmgi
	 8qG7jyYpsB/14lwVZxE6xr655R3PbcbtGU+I0ZAbPN7oZXiUGCxpSucJthNPgojWLB
	 ZxR++DUP0MwaVXgxbie+Chn6DA+yn1h1sfCyxl+9NUdpnMD7sshefrc9IuqATaxSiC
	 Flr2ym6kRrQke6HVaP9B9j6zYgCo7ZMxXQz0p+hslmA8/cqXk3N9DmDiy5w4ZQs0q0
	 7eWeUgr9aOhoFniZ0ZoJljG5GHzR65We8mah1+JqIFL/pbiMf3FmTfdwC5DD8SFdAq
	 WWLJIUS9Yendg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E188EC02194;
	Tue,  4 Feb 2025 13:10:37 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Tue, 04 Feb 2025 14:10:31 +0100
Subject: [PATCH] power: supply: max1720x: add health property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-max1720x_health-v1-1-97ebbe4a0bc5@liebherr.com>
X-B4-Tracking: v=1; b=H4sIAMYRomcC/x3MTQqAIBBA4avErBPGqQi6SkSIjjnQHxohRHdPW
 n6L9x5IHIUTDNUDkW9JcuwFuq7ABrMvrMQVAyF1qKlRm8m6J8xzYLNeQVlkx9g69E5Dqc7IXvJ
 /HKf3/QA3iZM9YQAAAA==
X-Change-ID: 20250123-max1720x_health-c0ede04d0fd1
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dimitri Fedrau <dima.fedrau@gmail.com>, 
 Thomas Antoine <t.antoine@uclouvain.be>, 
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738674636; l=3559;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=Rx3BHuxKX4jLbGUvrYB+xiYMQ7GjWqSEoUzSJP/Ox1M=;
 b=CqOtEfgiE0TlDmKQuBp3RVGzDnF09JPYrytSuOQ8jNEGb9Q3bnwTzWrRHrqHfVVMVYyyCFhuT
 2+jHsfk+HenCaUF4xZu9RJikiQry9OHje7gJEnTrVhaCNO5E4XJFiqX
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

Add health property, which checks that temperature, voltage and current are
within limits for the battery. Limits can be programmed in non-volatile
memory.

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
 drivers/power/supply/max1720x_battery.c | 47 +++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/power/supply/max1720x_battery.c b/drivers/power/supply/max1720x_battery.c
index 11580e414713b7f42354a8bf4e4ef7bee6e33f36..810edda327683761f16ce0d0affc1e0affd90f90 100644
--- a/drivers/power/supply/max1720x_battery.c
+++ b/drivers/power/supply/max1720x_battery.c
@@ -29,6 +29,11 @@
 /* ModelGauge m5 */
 #define MAX172XX_STATUS			0x00	/* Status */
 #define MAX172XX_STATUS_BAT_ABSENT	BIT(3)	/* Battery absent */
+#define MAX172XX_STATUS_IMX		BIT(6)	/* Maximum Current Alert Threshold Exceeded */
+#define MAX172XX_STATUS_VMN		BIT(8)	/* Minimum Voltage Alert Threshold Exceeded */
+#define MAX172XX_STATUS_TMN		BIT(9)	/* Minimum Temperature Alert Threshold Exceeded */
+#define MAX172XX_STATUS_VMX		BIT(12)	/* Maximum Voltage Alert Threshold Exceeded */
+#define MAX172XX_STATUS_TMX		BIT(13)	/* Maximum Temperature Alert Threshold Exceeded */
 #define MAX172XX_REPCAP			0x05	/* Average capacity */
 #define MAX172XX_REPSOC			0x06	/* Percentage of charge */
 #define MAX172XX_TEMP			0x08	/* Temperature */
@@ -250,6 +255,7 @@ static const struct nvmem_cell_info max1720x_nvmem_cells[] = {
 };
 
 static const enum power_supply_property max1720x_battery_props[] = {
+	POWER_SUPPLY_PROP_HEALTH,
 	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_CAPACITY,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
@@ -314,6 +320,43 @@ static int max172xx_current_to_voltage(unsigned int reg)
 	return val * 156252;
 }
 
+static int max172xx_battery_health(struct max1720x_device_info *info,
+				   unsigned int *health)
+{
+	unsigned int status;
+	int ret;
+
+	ret = regmap_read(info->regmap, MAX172XX_STATUS, &status);
+	if (ret < 0)
+		return ret;
+
+	if (status & MAX172XX_STATUS_VMN)
+		*health = POWER_SUPPLY_HEALTH_DEAD;
+	else if (status & MAX172XX_STATUS_VMX)
+		*health = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
+	else if (status & MAX172XX_STATUS_TMN)
+		*health = POWER_SUPPLY_HEALTH_COLD;
+	else if (status & MAX172XX_STATUS_TMX)
+		*health = POWER_SUPPLY_HEALTH_OVERHEAT;
+	else if (status & MAX172XX_STATUS_IMX)
+		*health = POWER_SUPPLY_HEALTH_OVERCURRENT;
+	else
+		*health = POWER_SUPPLY_HEALTH_GOOD;
+
+	/* Clear events which are not self-clearing to detect next events */
+	if (status > 0 && status != MAX172XX_STATUS_IMX) {
+		ret = regmap_set_bits(info->regmap, MAX172XX_STATUS,
+				      MAX172XX_STATUS_VMN |
+				      MAX172XX_STATUS_VMX |
+				      MAX172XX_STATUS_TMN |
+				      MAX172XX_STATUS_TMX);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int max1720x_battery_get_property(struct power_supply *psy,
 					 enum power_supply_property psp,
 					 union power_supply_propval *val)
@@ -323,6 +366,10 @@ static int max1720x_battery_get_property(struct power_supply *psy,
 	int ret = 0;
 
 	switch (psp) {
+	case POWER_SUPPLY_PROP_HEALTH:
+		ret = max172xx_battery_health(info, &reg_val);
+		val->intval = reg_val;
+		break;
 	case POWER_SUPPLY_PROP_PRESENT:
 		/*
 		 * POWER_SUPPLY_PROP_PRESENT will always readable via

---
base-commit: b4a95b8fd3e67c1222c76bdd1078d43c9a11d132
change-id: 20250123-max1720x_health-c0ede04d0fd1

Best regards,
-- 
Dimitri Fedrau <dimitri.fedrau@liebherr.com>



