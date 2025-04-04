Return-Path: <linux-pm+bounces-24825-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC67A7C262
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 19:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DF1F1B60357
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 17:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF66214A9C;
	Fri,  4 Apr 2025 17:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="VXKxz8nD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-81.smtpout.orange.fr [80.12.242.81])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C733213D539;
	Fri,  4 Apr 2025 17:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743787692; cv=none; b=WCzb2Fq/GEjasdhSVTo28QS13tr9jklQlrlMx3ppAR/k4vz1MUy0rG4jMQzJu8r6nn5F5oszigTlqaALdV7KcahFJM1gwp/uUGzfWQj0JgyPHlKHJTJLGgZj29lBAlMn9N68UljuTy/EPFWFX+04cNXTsHgQfGqYBBAwZwoYsiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743787692; c=relaxed/simple;
	bh=EZGg8Gsu11BD2bNrVJs8YMypzinC9NMtnPqW0GajYIY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WeCLcpVI83ntOrlsta0UhgFRZzTbjd2j5cUBgoRNIr6aMQT8Wyzhp0usI6XwbiSLUSYc8nn9EJ6KeoMH4xxoFPA+D97kRwcWo7JUjFGXQN/yLgvwQSR3RE02tOldepkwbHDopYV4aKkK/Ikj9GikQfs/55pXB/2bgMN36fzCdPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=VXKxz8nD; arc=none smtp.client-ip=80.12.242.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id 0kpmujQtk0cMk0kppu7Xwj; Fri, 04 Apr 2025 19:28:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1743787685;
	bh=IVF5MH+xrIg+FKCXHElsJo5pQsZIf4uqVbohRHguyNA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=VXKxz8nD+qB8M9bxkYi5SuOD8uDi0oYHBR3SfucxOYlAx/Nh654Z5BQYqi2VCpATW
	 n8dLPnYK6bDVwPp4xPQcKcAQm1U6Q060fBIzG9z3u8i97Qi+xFuf/M2kmKGgYLy3DM
	 75Zvay3ky5Egz2TmEUEzxaLWufO9yePhrJaT/eAkAEgs1sNDL7JVQwiTopkoIyoj2V
	 Jn68Y0OnTrHYplv4s/5OaID9BaMxX+D73brEOa1q7MKg7NzKGwFOzRzSIJ7PSlPzWA
	 ywLl5XJzbanbd/IpAjwNyEeNf4T7xgWk/xArVtpKt6SoUxG065seFptoIg6TDoKPjR
	 zvVWncsvcpDMQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 04 Apr 2025 19:28:05 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	patches@opensource.cirrus.com,
	linux-pm@vger.kernel.org
Subject: [PATCH] power: supply: wm831x: Constify struct chg_map and some arrays
Date: Fri,  4 Apr 2025 19:27:38 +0200
Message-ID: <0edde57b691db7f920d121fdbd5ebc3fb24f30f1.1743787625.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct chg_map' is not modified in this driver.

Constifying these structures moves some data to a read-only section, so
increase overall security.

While at it, also constify a few other arrays.

On a x86_64, with allmodconfig, as an example:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  14263	   1744	      0	  16007	   3e87	drivers/power/supply/wm831x_power.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  14695	   1288	      0	  15983	   3e6f	drivers/power/supply/wm831x_power.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only.
---
 drivers/power/supply/wm831x_power.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/power/supply/wm831x_power.c b/drivers/power/supply/wm831x_power.c
index 538055b29dec..6acdba7885ca 100644
--- a/drivers/power/supply/wm831x_power.c
+++ b/drivers/power/supply/wm831x_power.c
@@ -89,7 +89,7 @@ static int wm831x_wall_get_prop(struct power_supply *psy,
 	return ret;
 }
 
-static enum power_supply_property wm831x_wall_props[] = {
+static const enum power_supply_property wm831x_wall_props[] = {
 	POWER_SUPPLY_PROP_ONLINE,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 };
@@ -120,7 +120,7 @@ static int wm831x_usb_get_prop(struct power_supply *psy,
 	return ret;
 }
 
-static enum power_supply_property wm831x_usb_props[] = {
+static const enum power_supply_property wm831x_usb_props[] = {
 	POWER_SUPPLY_PROP_ONLINE,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 };
@@ -171,21 +171,21 @@ struct chg_map {
 	int reg_val;
 };
 
-static struct chg_map trickle_ilims[] = {
+static const struct chg_map trickle_ilims[] = {
 	{  50, 0 << WM831X_CHG_TRKL_ILIM_SHIFT },
 	{ 100, 1 << WM831X_CHG_TRKL_ILIM_SHIFT },
 	{ 150, 2 << WM831X_CHG_TRKL_ILIM_SHIFT },
 	{ 200, 3 << WM831X_CHG_TRKL_ILIM_SHIFT },
 };
 
-static struct chg_map vsels[] = {
+static const struct chg_map vsels[] = {
 	{ 4050, 0 << WM831X_CHG_VSEL_SHIFT },
 	{ 4100, 1 << WM831X_CHG_VSEL_SHIFT },
 	{ 4150, 2 << WM831X_CHG_VSEL_SHIFT },
 	{ 4200, 3 << WM831X_CHG_VSEL_SHIFT },
 };
 
-static struct chg_map fast_ilims[] = {
+static const struct chg_map fast_ilims[] = {
 	{    0,  0 << WM831X_CHG_FAST_ILIM_SHIFT },
 	{   50,  1 << WM831X_CHG_FAST_ILIM_SHIFT },
 	{  100,  2 << WM831X_CHG_FAST_ILIM_SHIFT },
@@ -204,7 +204,7 @@ static struct chg_map fast_ilims[] = {
 	{ 1000, 15 << WM831X_CHG_FAST_ILIM_SHIFT },
 };
 
-static struct chg_map eoc_iterms[] = {
+static const struct chg_map eoc_iterms[] = {
 	{ 20, 0 << WM831X_CHG_ITERM_SHIFT },
 	{ 30, 1 << WM831X_CHG_ITERM_SHIFT },
 	{ 40, 2 << WM831X_CHG_ITERM_SHIFT },
@@ -215,7 +215,7 @@ static struct chg_map eoc_iterms[] = {
 	{ 90, 7 << WM831X_CHG_ITERM_SHIFT },
 };
 
-static struct chg_map chg_times[] = {
+static const struct chg_map chg_times[] = {
 	{  60,  0 << WM831X_CHG_TIME_SHIFT },
 	{  90,  1 << WM831X_CHG_TIME_SHIFT },
 	{ 120,  2 << WM831X_CHG_TIME_SHIFT },
@@ -235,7 +235,7 @@ static struct chg_map chg_times[] = {
 };
 
 static void wm831x_battery_apply_config(struct wm831x *wm831x,
-				       struct chg_map *map, int count, int val,
+				       const struct chg_map *map, int count, int val,
 				       int *reg, const char *name,
 				       const char *units)
 {
@@ -462,7 +462,7 @@ static int wm831x_bat_get_prop(struct power_supply *psy,
 	return ret;
 }
 
-static enum power_supply_property wm831x_bat_props[] = {
+static const enum power_supply_property wm831x_bat_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_ONLINE,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
@@ -470,7 +470,7 @@ static enum power_supply_property wm831x_bat_props[] = {
 	POWER_SUPPLY_PROP_CHARGE_TYPE,
 };
 
-static const char *wm831x_bat_irqs[] = {
+static const char * const wm831x_bat_irqs[] = {
 	"BATT HOT",
 	"BATT COLD",
 	"BATT FAIL",
-- 
2.49.0


