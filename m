Return-Path: <linux-pm+bounces-23657-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2D7A575A9
	for <lists+linux-pm@lfdr.de>; Sat,  8 Mar 2025 00:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6270170E79
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 23:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0F4258CEA;
	Fri,  7 Mar 2025 23:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="VGhZ72qm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9A019006F;
	Fri,  7 Mar 2025 23:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741388550; cv=none; b=LI/HaCO4SAicwB2PuJTDEeySURT6oEDE6lfh7pu7HtS/E8X6jUW+H4ODLZBLAQFmViAm4LJ+MTLvINgsfYsTUCJnCbPICyTsaUMFIiBEF33nGAMhgbNTFMYs31w/FEL7HBeIzQTlyWvwgAI0wwhGr9j8Eay6xo9Ug1CZ8mvNBVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741388550; c=relaxed/simple;
	bh=/vuVUlwiJC1vlB8rYoBU/EU5I/W3M2F4MRh4xrG4JIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IeCoyMZ5/hP26BAM2wvt2zuo5jVZxWCkQHZomohUMa3cdoFXCUcq0lsU8VSaU0x/SPzd/eneXJFIv2jjw8q/SI/K3sNkJ2s80PL3TEBLk8+njUmAI37J//99AMLIVsxknSOV+IAaGBo4jgrGosPeWQcFIAgZNb73MxWAuFN4w3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=VGhZ72qm; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=OvaaM5K1iTaNPtb1WzCdYsTgO1bTNP7eXeSy1JzDb1I=; b=VGhZ72qm6JhBDu9g
	cPlTJtGfHTeNsmBwdbyiJCtuNA1hYKGPlmjR1tW7f3+mbEF3libN2GaKc1Z259kiOZu5wKsXq31MC
	nHlRt45pwcFrVj/YUSgCcZCqY+XjL1MkrxDkhvB3TYPjwOu2NGbrO0YZrsq3IwBtbJsAykKI6daro
	9Oy3J4B3iRvH2hDi0rY6kAKi7RuBHaAf2cKb8gS6WIVpxscvN0arU8VPqCejVSFBrALgyTuX5ooeT
	m2RHt3O/JZ5BhGl2vEVQKy6K+3Nu813XQeXDrVXneEr2mX+fTnqdXF+YC1TXeC/61RBFtExFEuXM1
	/TrCjpZcEiiYKltPAw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tqgi2-003XFb-2b;
	Fri, 07 Mar 2025 23:02:26 +0000
From: linux@treblig.org
To: sre@kernel.org,
	linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 1/3] power: supply: core: Remove unused power_supply_set_battery_charged
Date: Fri,  7 Mar 2025 23:02:23 +0000
Message-ID: <20250307230225.128775-2-linux@treblig.org>
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

power_supply_set_battery_charged() has been unused since 2019's
commit 0f884f8a090e ("ARM: pxa: remove raumfeld board files and
defconfig")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/power/supply/power_supply_core.c | 13 -------------
 include/linux/power_supply.h             |  1 -
 2 files changed, 14 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 76c340b38015..47e0fea84917 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -449,19 +449,6 @@ int power_supply_get_property_from_supplier(struct power_supply *psy,
 }
 EXPORT_SYMBOL_GPL(power_supply_get_property_from_supplier);
 
-int power_supply_set_battery_charged(struct power_supply *psy)
-{
-	if (atomic_read(&psy->use_cnt) >= 0 &&
-			psy->desc->type == POWER_SUPPLY_TYPE_BATTERY &&
-			psy->desc->set_charged) {
-		psy->desc->set_charged(psy);
-		return 0;
-	}
-
-	return -EINVAL;
-}
-EXPORT_SYMBOL_GPL(power_supply_set_battery_charged);
-
 static int power_supply_match_device_by_name(struct device *dev, const void *data)
 {
 	const char *name = data;
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 6ed53b292162..5afc5946eb03 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -852,7 +852,6 @@ extern int power_supply_am_i_supplied(struct power_supply *psy);
 int power_supply_get_property_from_supplier(struct power_supply *psy,
 					    enum power_supply_property psp,
 					    union power_supply_propval *val);
-extern int power_supply_set_battery_charged(struct power_supply *psy);
 
 static inline bool
 power_supply_supports_maintenance_charging(struct power_supply_battery_info *info)
-- 
2.48.1


