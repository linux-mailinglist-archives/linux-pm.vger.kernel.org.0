Return-Path: <linux-pm+bounces-23658-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1775A575AA
	for <lists+linux-pm@lfdr.de>; Sat,  8 Mar 2025 00:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F91E3AE1B0
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 23:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F088258CE9;
	Fri,  7 Mar 2025 23:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="jZFybx2L"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C12D1B0F11;
	Fri,  7 Mar 2025 23:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741388550; cv=none; b=pDxChcQaPYB09eR8ceP6I9bb0rgZRQwnJIqwnpsSGvxe8HxDbOXP/KvbhdffG9MCxiqWhdYVw8+IdrBTyEwSKA0/oUCN8FafFp6OHkLZtkOOdHDI/NsfXzc089nQEAWUgxzOl4ib5QBlXGmxxH8XBQ2s0Kn4Zdv34h+atQxiDCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741388550; c=relaxed/simple;
	bh=SoNEziyvGgKhUQ6TOuU1ybgmFsUuCAx7PBtGLbxk0Qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J8tCvQaccZ8Bxz1iJkRcR0PNHRRXSnBN6FMZ1hUHiVR15r4uBC6Tiu8DF35P0S6P2Yi1HTNXHfa8ZYb3eZEEDEVtEezJDtTYgFm8e1i2KEUaOcXS38wXttl8vNkq9YtdTIVsEj33GQybNmrw+vdGUGAUn637fLkwJOmetK8fqDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=jZFybx2L; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=R+yDZqBmrY7R81jPy3BAIpyzLTLF7d2CCpAj0+tuUBU=; b=jZFybx2L5mF/hKUN
	gS0YYuXAyvd0zPjjkomBFGCmB4i8vTt3b1a0vvexWRbqVRTEY9fISL6v3FmdF4AW8qQO4uWn7OOgj
	bofL4YS+CL8+IlnTYHmCwvMMhcmiQk1BgQncqhsZyygtgrphXf6un0UwhmDQ3t20sARtPnEf8FdZu
	vTEDbU8ykFG9cXm8MBYR27CFE/9crQDE9tCgMVcx4yRBsUJj3WXUpGKEy202g4kBzZUFz7zT+sT2m
	f95v0hgfJ4ij78BpWxjO/xhu8foLEnQZbDCr0+3i6u3ivALosP1jtet13PquEWr+/v3tn9mw7kguN
	3NpxVHCXwF99bnAvUg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tqgi3-003XFb-0o;
	Fri, 07 Mar 2025 23:02:27 +0000
From: linux@treblig.org
To: sre@kernel.org,
	linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 2/3] power: supply: ds2760: Remove unused ds2760_battery_set_charged
Date: Fri,  7 Mar 2025 23:02:24 +0000
Message-ID: <20250307230225.128775-3-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307230225.128775-1-linux@treblig.org>
References: <20250307230225.128775-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

With power_supply_set_battery_charged() deleted in the previous
patch, there's no one left to call the set_charged method.
The only implemented is in ds2760, unwire it and delete the
associated functions and data.

(Arguably it might be time to delete ds2760 since I don't
think there are any users left)

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/power/supply/ds2760_battery.c | 49 ---------------------------
 1 file changed, 49 deletions(-)

diff --git a/drivers/power/supply/ds2760_battery.c b/drivers/power/supply/ds2760_battery.c
index 83bdec5a2bda..a7f7d4c3f1ee 100644
--- a/drivers/power/supply/ds2760_battery.c
+++ b/drivers/power/supply/ds2760_battery.c
@@ -112,7 +112,6 @@ struct ds2760_device_info {
 	struct power_supply_desc bat_desc;
 	struct workqueue_struct *monitor_wqueue;
 	struct delayed_work monitor_work;
-	struct delayed_work set_charged_work;
 	struct notifier_block pm_notifier;
 };
 
@@ -489,50 +488,6 @@ static void ds2760_battery_external_power_changed(struct power_supply *psy)
 }
 
 
-static void ds2760_battery_set_charged_work(struct work_struct *work)
-{
-	char bias;
-	struct ds2760_device_info *di = container_of(work,
-		struct ds2760_device_info, set_charged_work.work);
-
-	dev_dbg(di->dev, "%s\n", __func__);
-
-	ds2760_battery_read_status(di);
-
-	/* When we get notified by external circuitry that the battery is
-	 * considered fully charged now, we know that there is no current
-	 * flow any more. However, the ds2760's internal current meter is
-	 * too inaccurate to rely on - spec say something ~15% failure.
-	 * Hence, we use the current offset bias register to compensate
-	 * that error.
-	 */
-
-	if (!power_supply_am_i_supplied(di->bat))
-		return;
-
-	bias = (signed char) di->current_raw +
-		(signed char) di->raw[DS2760_CURRENT_OFFSET_BIAS];
-
-	dev_dbg(di->dev, "%s: bias = %d\n", __func__, bias);
-
-	w1_ds2760_write(di->dev, &bias, DS2760_CURRENT_OFFSET_BIAS, 1);
-	w1_ds2760_store_eeprom(di->dev, DS2760_EEPROM_BLOCK1);
-	w1_ds2760_recall_eeprom(di->dev, DS2760_EEPROM_BLOCK1);
-
-	/* Write to the di->raw[] buffer directly - the CURRENT_OFFSET_BIAS
-	 * value won't be read back by ds2760_battery_read_status() */
-	di->raw[DS2760_CURRENT_OFFSET_BIAS] = bias;
-}
-
-static void ds2760_battery_set_charged(struct power_supply *psy)
-{
-	struct ds2760_device_info *di = power_supply_get_drvdata(psy);
-
-	/* postpone the actual work by 20 secs. This is for debouncing GPIO
-	 * signals and to let the current value settle. See AN4188. */
-	mod_delayed_work(di->monitor_wqueue, &di->set_charged_work, HZ * 20);
-}
-
 static int ds2760_battery_get_property(struct power_supply *psy,
 				       enum power_supply_property psp,
 				       union power_supply_propval *val)
@@ -692,7 +647,6 @@ static int w1_ds2760_add_slave(struct w1_slave *sl)
 	di->bat_desc.set_property	= ds2760_battery_set_property;
 	di->bat_desc.property_is_writeable =
 				  ds2760_battery_property_is_writeable;
-	di->bat_desc.set_charged	= ds2760_battery_set_charged;
 	di->bat_desc.external_power_changed =
 				  ds2760_battery_external_power_changed;
 
@@ -747,8 +701,6 @@ static int w1_ds2760_add_slave(struct w1_slave *sl)
 	}
 
 	INIT_DELAYED_WORK(&di->monitor_work, ds2760_battery_work);
-	INIT_DELAYED_WORK(&di->set_charged_work,
-			  ds2760_battery_set_charged_work);
 	di->monitor_wqueue = alloc_ordered_workqueue(name, WQ_MEM_RECLAIM);
 	if (!di->monitor_wqueue) {
 		retval = -ESRCH;
@@ -774,7 +726,6 @@ static void w1_ds2760_remove_slave(struct w1_slave *sl)
 
 	unregister_pm_notifier(&di->pm_notifier);
 	cancel_delayed_work_sync(&di->monitor_work);
-	cancel_delayed_work_sync(&di->set_charged_work);
 	destroy_workqueue(di->monitor_wqueue);
 }
 
-- 
2.48.1


