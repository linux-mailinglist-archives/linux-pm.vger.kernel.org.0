Return-Path: <linux-pm+bounces-18967-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF619EBC4F
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 22:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 334F6284246
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 21:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0A023F9F8;
	Tue, 10 Dec 2024 21:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="kuJEHULn"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54C623EA65;
	Tue, 10 Dec 2024 21:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733867769; cv=none; b=O/GI3iwUicpXbYs6wzHHeV3x6kO+lJNT/yVQRcuZ7+lqSdHer/vJjetnfjGp2/BNEDJuKv6x6zziCxvP1t9hxCw2MzJeaHrD3IrEGPycL0k6q73ebxOgg0MVa1LK/VQN93psGLj9eUTB1gd0Nt10E813BGUgRZJ1HcRW1BwF7FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733867769; c=relaxed/simple;
	bh=goF6k+Ph7DIdoZBnI38IEZG2dxk4fykSLv1y2mFaQo8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LpV8vEzzNLwEipbXVYCZ3uZrL/cZSNbQN38Ffyx3bY4zHKjuU01UFhmi7ArSFvIbhI/hJMGImynpGT7D/WHZHE73Y+pqb8Ige0AsRFlNrwUoAcpbWX8t5CJoFM8UAdNzY9E6xrtRKY0xVIAg5zQB4XQ1FpnQjVnShDJKd13BcGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=kuJEHULn; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733867760;
	bh=goF6k+Ph7DIdoZBnI38IEZG2dxk4fykSLv1y2mFaQo8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kuJEHULncm7WPVwlPHIzCOeaQ3SqgiS7cafhO4heh1vGrpHs5THLPPGC7ewXVeGPF
	 zQU7M26epTlinYqlVzhWMtR8BMS+NFeVhNvgav26y+5sQDJhJ1I1Pm1vSPKWdkl0fb
	 oicuEkepxROAfxydWbKoxPousvih+dzrJHbxW6OE=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 10 Dec 2024 22:55:51 +0100
Subject: [PATCH v2 04/14] power: supply: ab8500: use
 power_supply_for_each_psy()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241210-power-supply-dev_to_psy-v2-4-9d8c9d24cfe4@weissschuh.net>
References: <20241210-power-supply-dev_to_psy-v2-0-9d8c9d24cfe4@weissschuh.net>
In-Reply-To: <20241210-power-supply-dev_to_psy-v2-0-9d8c9d24cfe4@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Maximilian Luz <luzmaximilian@gmail.com>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 platform-driver-x86@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733867760; l=4960;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=goF6k+Ph7DIdoZBnI38IEZG2dxk4fykSLv1y2mFaQo8=;
 b=Mqq0SZ/2DXKYlgInJwFx+T7fbMDjb5F12yJVrVsiM8yk9FjeBdKEqPWZ4c9BX7MTah49UpJ8r
 Gc7i7xTQ6xDDwZQERqsd40hpmFdplS6/57vOcRaX0aKKMyBHKuS16ET
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
index 37039e28fc4bd27844e36ee69e700fed24d5ee8d..b00c84fbc33c2abae72d104f4645ba327ad10cfd 100644
--- a/drivers/power/supply/ab8500_btemp.c
+++ b/drivers/power/supply/ab8500_btemp.c
@@ -540,10 +540,9 @@ static int ab8500_btemp_get_property(struct power_supply *psy,
 	return 0;
 }
 
-static int ab8500_btemp_get_ext_psy_data(struct device *dev, void *data)
+static int ab8500_btemp_get_ext_psy_data(struct power_supply *ext, void *data)
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
index 14e1b448bd39b286404f31509dbe006d16390877..7a8d1feb8e905d95b010fa907a95ea7db0b3b5a4 100644
--- a/drivers/power/supply/ab8500_chargalg.c
+++ b/drivers/power/supply/ab8500_chargalg.c
@@ -844,10 +844,9 @@ static void handle_maxim_chg_curr(struct ab8500_chargalg *di)
 	}
 }
 
-static int ab8500_chargalg_get_ext_psy_data(struct device *dev, void *data)
+static int ab8500_chargalg_get_ext_psy_data(struct power_supply *ext, void *data)
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


