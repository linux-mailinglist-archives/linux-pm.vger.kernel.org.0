Return-Path: <linux-pm+bounces-18772-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BFD9E8535
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 14:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB17F28175B
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 13:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA588155A34;
	Sun,  8 Dec 2024 13:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="qn2pEQut"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE740152E0C;
	Sun,  8 Dec 2024 13:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733662965; cv=none; b=DW9yOOVBe3bPfnG35CQvyugv4EmX+0HrXKcGVFhKUcEieOAU5tcfPhGe/3ynMdVLJkPRjGkTUBRoHJsuPGdWStNo4rHOH64bHpyLW6d44tbq2IYQqsJKJ7YxCP4OYBEfwhcvfp9toVq95/S0z1J5z9XUR0jK4/9wZEVNVFql1VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733662965; c=relaxed/simple;
	bh=wackexuuy/tX4Ge1IQFEEL57UViuMocgJIv7Eib30eg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BTL5bzGmU1cO08NgM9eOhooOL/Nesmi4hRuxNgPBvCzan7dweQgk4hbtcHZaevhN2B7YD2ZOpSfCpTE4qSlL1EtD4KQLuk1U4W5Xn/A8GhW09Ir8w+AT10LO2TSl4dJHnA6Z8P8ektjHfgM6S2OzfO2y/9yJEdRxaX/SALceEA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=qn2pEQut; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733662958;
	bh=wackexuuy/tX4Ge1IQFEEL57UViuMocgJIv7Eib30eg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qn2pEQut+iwY0mcH5jTK0fdwXJ+JUYKFeVVTW+SPw5lNu9IxSsZTqlpOY9LbQoWQ/
	 wbtc+dNoPcUWwiPMOeib4r1qxaRJit4oFn7HGvaZOUh13tyJxD7ox+fJ77zvuOr+Wq
	 IFnDJk6Jxtr9qQ4F+vQjD/MkHQ8WDW08jz+B0PmY=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 08 Dec 2024 14:02:36 +0100
Subject: [PATCH 04/14] power: supply: ab8500: use
 power_supply_for_each_psy()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241208-power-supply-dev_to_psy-v1-4-f95de9117558@weissschuh.net>
References: <20241208-power-supply-dev_to_psy-v1-0-f95de9117558@weissschuh.net>
In-Reply-To: <20241208-power-supply-dev_to_psy-v1-0-f95de9117558@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Maximilian Luz <luzmaximilian@gmail.com>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 platform-driver-x86@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733662957; l=4968;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=wackexuuy/tX4Ge1IQFEEL57UViuMocgJIv7Eib30eg=;
 b=KKXkaIgt5BEtsKBwAMpRQ0UY+SrSVxTBffR13yya8XHVi/qPjrwPO5Khsmauiu+x2xczSxePZ
 6dFdbkNkUpGCA1dY7fV6JTMUmCDQRajZKZlIj9swcW215f3NPwh7VYC
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Simplify the callbacks by removing the need to convert a 'struct device'
into a 'struct power_supply'.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/ab8500_btemp.c    | 5 ++---
 drivers/power/supply/ab8500_chargalg.c | 5 ++---
 drivers/power/supply/ab8500_charger.c  | 5 ++---
 drivers/power/supply/ab8500_fg.c       | 5 ++---
 4 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/ab8500_btemp.c
index 37039e28fc4bd27844e36ee69e700fed24d5ee8d..0c13867a33539d7f300965fe5543e09829f38b2b 100644
--- a/drivers/power/supply/ab8500_btemp.c
+++ b/drivers/power/supply/ab8500_btemp.c
@@ -540,10 +540,9 @@ static int ab8500_btemp_get_property(struct power_supply *psy,
 	return 0;
 }
 
-static int ab8500_btemp_get_ext_psy_data(struct device *dev, void *data)
+static int ab8500_btemp_get_ext_psy_data(struct power_supply_ext *ext, void *data)
 {
 	struct power_supply *psy;
-	struct power_supply *ext = dev_get_drvdata(dev);
 	const char **supplicants = (const char **)ext->supplied_to;
 	struct ab8500_btemp *di;
 	union power_supply_propval ret;
@@ -617,7 +616,7 @@ static int ab8500_btemp_get_ext_psy_data(struct device *dev, void *data)
  */
 static void ab8500_btemp_external_power_changed(struct power_supply *psy)
 {
-	power_supply_for_each_device(psy, ab8500_btemp_get_ext_psy_data);
+	power_supply_for_each_psy(psy, ab8500_btemp_get_ext_psy_data);
 }
 
 /* ab8500 btemp driver interrupts and their respective isr */
diff --git a/drivers/power/supply/ab8500_chargalg.c b/drivers/power/supply/ab8500_chargalg.c
index 14e1b448bd39b286404f31509dbe006d16390877..3af92b1f9b1709e5929fee26cad7bd4de3b3417f 100644
--- a/drivers/power/supply/ab8500_chargalg.c
+++ b/drivers/power/supply/ab8500_chargalg.c
@@ -844,10 +844,9 @@ static void handle_maxim_chg_curr(struct ab8500_chargalg *di)
 	}
 }
 
-static int ab8500_chargalg_get_ext_psy_data(struct device *dev, void *data)
+static int ab8500_chargalg_get_ext_psy_data(struct power_supply_ext *ext, void *data)
 {
 	struct power_supply *psy;
-	struct power_supply *ext = dev_get_drvdata(dev);
 	const char **supplicants = (const char **)ext->supplied_to;
 	struct ab8500_chargalg *di;
 	union power_supply_propval ret;
@@ -1231,7 +1230,7 @@ static void ab8500_chargalg_algorithm(struct ab8500_chargalg *di)
 	int ret;
 
 	/* Collect data from all power_supply class devices */
-	power_supply_for_each_device(di->chargalg_psy, ab8500_chargalg_get_ext_psy_data);
+	power_supply_for_each_psy(di->chargalg_psy, ab8500_chargalg_get_ext_psy_data);
 
 	ab8500_chargalg_end_of_charge(di);
 	ab8500_chargalg_check_temp(di);
diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index cece8d6753ac14f8970c13ce6b2d91e678733574..1042d37424f5b0351edd02b5c76e58dd447d1783 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -1894,10 +1894,9 @@ static int ab8500_charger_update_charger_current(struct ux500_charger *charger,
 	return ret;
 }
 
-static int ab8500_charger_get_ext_psy_data(struct device *dev, void *data)
+static int ab8500_charger_get_ext_psy_data(struct power_supply *ext, void *data)
 {
 	struct power_supply *psy;
-	struct power_supply *ext = dev_get_drvdata(dev);
 	const char **supplicants = (const char **)ext->supplied_to;
 	struct ab8500_charger *di;
 	union power_supply_propval ret;
@@ -1961,7 +1960,7 @@ static void ab8500_charger_check_vbat_work(struct work_struct *work)
 	struct ab8500_charger *di = container_of(work,
 		struct ab8500_charger, check_vbat_work.work);
 
-	power_supply_for_each_device(&di->usb_chg, ab8500_charger_get_ext_psy_data);
+	power_supply_for_each_psy(&di->usb_chg, ab8500_charger_get_ext_psy_data);
 
 	/* First run old_vbat is 0. */
 	if (di->old_vbat == 0)
diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index 78871a2143de34c7e1a81882ab7105fbf19387ec..549403c6f73c1581d373c6df83cbc255ab1c2e82 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -2174,10 +2174,9 @@ static int ab8500_fg_get_property(struct power_supply *psy,
 	return 0;
 }
 
-static int ab8500_fg_get_ext_psy_data(struct device *dev, void *data)
+static int ab8500_fg_get_ext_psy_data(struct power_supply *ext, void *data)
 {
 	struct power_supply *psy;
-	struct power_supply *ext = dev_get_drvdata(dev);
 	const char **supplicants = (const char **)ext->supplied_to;
 	struct ab8500_fg *di;
 	struct power_supply_battery_info *bi;
@@ -2402,7 +2401,7 @@ static int ab8500_fg_init_hw_registers(struct ab8500_fg *di)
  */
 static void ab8500_fg_external_power_changed(struct power_supply *psy)
 {
-	power_supply_for_each_device(psy, ab8500_fg_get_ext_psy_data);
+	power_supply_for_each_psy(psy, ab8500_fg_get_ext_psy_data);
 }
 
 /**

-- 
2.47.1


