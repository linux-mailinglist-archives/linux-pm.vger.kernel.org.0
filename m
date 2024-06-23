Return-Path: <linux-pm+bounces-9828-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC619138E1
	for <lists+linux-pm@lfdr.de>; Sun, 23 Jun 2024 10:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 977E02811E5
	for <lists+linux-pm@lfdr.de>; Sun, 23 Jun 2024 08:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA8C54757;
	Sun, 23 Jun 2024 08:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Orp1t91x"
X-Original-To: linux-pm@vger.kernel.org
Received: from msa.smtpout.orange.fr (msa-217.smtpout.orange.fr [193.252.23.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CDE17C7C;
	Sun, 23 Jun 2024 08:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719129902; cv=none; b=GulOU+tva4SLnBVPsbDAE29lPvjzvorQah3x0Ts1vKvcFnEs1P2vZtzNR4juxt1keZ8Pn74q6ff/TQjpvJp28SOpqLo4SIduA4QZmulcPhW4i2WXwzTorPglqvEz61aleTUyGnxlt8yZYYTPACf6fdc/Ip3OTYt3fYMs92ry/JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719129902; c=relaxed/simple;
	bh=L+fBNEeK6lDWZjdsWdDStuilRXSXt+4gjCSKof+Ck14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kRxtel2WHYnIhlDi9jdZjrKC29Jy72pduADLwYufj6ynynjnXUbYPMhhsFDz1dqpK3/yHFpjytHXyzgjzOglrEHdKGQPkyD8WW1zeStSL56VwcaoNOblgGNW4uRYqFHokHFpiWTnbDMZmKw6L3uFQ1I8v00eaoRAXNqiwlcXfas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Orp1t91x; arc=none smtp.client-ip=193.252.23.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.222.230])
	by smtp.orange.fr with ESMTPA
	id LIDRshykYqHypLIDRsPqzn; Sun, 23 Jun 2024 10:04:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1719129890;
	bh=iSV7OMQHyo5A+TPl27ELYTFtKHhEE1HTiDYIXwhqgZY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Orp1t91xeBDFmihYa8h5KObI0070Jlfu2IeYnVhCvZ+XoumsjKWG3Sou9P3enz2jH
	 xL973V89/xBGmUwbMAeVm8DgZFq23vhXDoZ1dEV/rbsC+eX0C6kvejB3GxhiS47ZX5
	 yko6epdo40nV+/wwXmQhPtuftRiFyT+yY0CisZEhfamXTAll26gV64OLAWcStmXEdR
	 UajfaSzkoB8oDIRWjSaW7d9GzzB/5tQ8Hrs7w+nnCCBQjaB7Z5fH04Clzg64zduT1E
	 CYRt3zeNZtxZTqkG53Pk8X+k10P/rGENhDkjcrwv9xiCr/q55Tel3m/JbonmWxx5wq
	 FBNcSa5aciv0g==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 23 Jun 2024 10:04:50 +0200
X-ME-IP: 86.243.222.230
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: linus.walleij@linaro.org,
	Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 2/2] power: supply: samsung-sdi-battery: Constify struct power_supply_maintenance_charge_table
Date: Sun, 23 Jun 2024 10:04:45 +0200
Message-ID: <6caafd0ac2556a40405273b1a4badc508ea8e9b0.1719125040.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <d01818abd880bf435d1106a9a6cc11a7a8a3e661.1719125040.git.christophe.jaillet@wanadoo.fr>
References: <d01818abd880bf435d1106a9a6cc11a7a8a3e661.1719125040.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct power_supply_maintenance_charge_table' is not modified in this
driver.

Constifying this structure moves some data to a read-only section, so
increase overall security.

In order to do it, some code also needs to be adjusted to this new const
qualifier.

On a x86_64, with allmodconfig:
Before:
======
$ size drivers/power/supply/samsung-sdi-battery.o
   text	   data	    bss	    dec	    hex	filename
   4055	   4584	      0	   8639	   21bf	drivers/power/supply/samsung-sdi-battery.o

After:
=====
$ size drivers/power/supply/samsung-sdi-battery.o
   text	   data	    bss	    dec	    hex	filename
   4087	   4552	      0	   8639	   21bf	drivers/power/supply/samsung-sdi-battery.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only

Changes in v2
  - Add Linus Walleij <linus.walleij@linaro.org> in Cc  [Sebastian Reichel]
  - Also update ab8500_chargalg.c  [Sebastian Reichel, kernel test robot]

v1: https://lore.kernel.org/all/02c6ad69a3ace192c9d609b7336a681a8fc7ba94.1717253900.git.christophe.jaillet@wanadoo.fr/
---
 drivers/power/supply/ab8500_chargalg.c     | 2 +-
 drivers/power/supply/power_supply_core.c   | 2 +-
 drivers/power/supply/samsung-sdi-battery.c | 2 +-
 include/linux/power_supply.h               | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/ab8500_chargalg.c b/drivers/power/supply/ab8500_chargalg.c
index 55ab7a28056e..854491ad3ecd 100644
--- a/drivers/power/supply/ab8500_chargalg.c
+++ b/drivers/power/supply/ab8500_chargalg.c
@@ -1225,8 +1225,8 @@ static bool ab8500_chargalg_time_to_restart(struct ab8500_chargalg *di)
  */
 static void ab8500_chargalg_algorithm(struct ab8500_chargalg *di)
 {
+	const struct power_supply_maintenance_charge_table *mt;
 	struct power_supply_battery_info *bi = di->bm->bi;
-	struct power_supply_maintenance_charge_table *mt;
 	int charger_status;
 	int ret;
 
diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 022d0e4bf621..8f6025acd10a 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1072,7 +1072,7 @@ int power_supply_vbat2ri(struct power_supply_battery_info *info,
 }
 EXPORT_SYMBOL_GPL(power_supply_vbat2ri);
 
-struct power_supply_maintenance_charge_table *
+const struct power_supply_maintenance_charge_table *
 power_supply_get_maintenance_charging_setting(struct power_supply_battery_info *info,
 					      int index)
 {
diff --git a/drivers/power/supply/samsung-sdi-battery.c b/drivers/power/supply/samsung-sdi-battery.c
index 725fbe09379e..b63fd2758c2f 100644
--- a/drivers/power/supply/samsung-sdi-battery.c
+++ b/drivers/power/supply/samsung-sdi-battery.c
@@ -613,7 +613,7 @@ static struct power_supply_battery_ocv_table samsung_ocv_cap_eb585157lu[] = {
 	{ .ocv = 3300000, .capacity = 0},
 };
 
-static struct power_supply_maintenance_charge_table samsung_maint_charge_table[] = {
+static const struct power_supply_maintenance_charge_table samsung_maint_charge_table[] = {
 	{
 		/* Maintenance charging phase A, 60 hours */
 		.charge_current_max_ua = 600000,
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 5061eeecf62e..72dc7e45c90c 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -736,7 +736,7 @@ struct power_supply_battery_info {
 	int overvoltage_limit_uv;
 	int constant_charge_current_max_ua;
 	int constant_charge_voltage_max_uv;
-	struct power_supply_maintenance_charge_table *maintenance_charge;
+	const struct power_supply_maintenance_charge_table *maintenance_charge;
 	int maintenance_charge_size;
 	int alert_low_temp_charge_current_ua;
 	int alert_low_temp_charge_voltage_uv;
@@ -810,7 +810,7 @@ power_supply_temp2resist_simple(struct power_supply_resistance_temp_table *table
 				int table_len, int temp);
 extern int power_supply_vbat2ri(struct power_supply_battery_info *info,
 				int vbat_uv, bool charging);
-extern struct power_supply_maintenance_charge_table *
+extern const struct power_supply_maintenance_charge_table *
 power_supply_get_maintenance_charging_setting(struct power_supply_battery_info *info, int index);
 extern bool power_supply_battery_bti_in_range(struct power_supply_battery_info *info,
 					      int resistance);
@@ -824,7 +824,7 @@ extern int power_supply_set_battery_charged(struct power_supply *psy);
 static inline bool
 power_supply_supports_maintenance_charging(struct power_supply_battery_info *info)
 {
-	struct power_supply_maintenance_charge_table *mt;
+	const struct power_supply_maintenance_charge_table *mt;
 
 	mt = power_supply_get_maintenance_charging_setting(info, 0);
 
-- 
2.45.2


