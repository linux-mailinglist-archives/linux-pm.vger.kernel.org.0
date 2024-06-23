Return-Path: <linux-pm+bounces-9827-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC38913856
	for <lists+linux-pm@lfdr.de>; Sun, 23 Jun 2024 08:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 615551C20A18
	for <lists+linux-pm@lfdr.de>; Sun, 23 Jun 2024 06:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A1522F14;
	Sun, 23 Jun 2024 06:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Elv+6aT9"
X-Original-To: linux-pm@vger.kernel.org
Received: from msa.smtpout.orange.fr (smtp-72.smtpout.orange.fr [80.12.242.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DBC175AD;
	Sun, 23 Jun 2024 06:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719125219; cv=none; b=SiJSAgPPJf59aEqUrxmnhimZvEt5DQGU+x6QsVVM5hQlUvcnnhR5ZCSf5ttY6ZdFQjvHMTWmRd1khLSymak2ohJu/9eMxEGwPqWj3koputlOXwi+U1s7yExkuH1N1ZBS8I9g6KR+QnBRGbQqRUG0FQYuZcZFsrMJ/HETKO8jp0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719125219; c=relaxed/simple;
	bh=dfq06tE3YCP5kQWMyxxEvvFd4AYUTchihWxC68Enxik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FwnxDgcn7CRWTM2irVzH/mm6vm9BlmW1zje3LHCa2SKGN9iJwRop6BP9wswZRCcglfCs9oP7b5HfJoYDdQIhBFqoamoYlPQ2Zzt7y6+3WiuPZCm1ndYZCE4WWbNxVU+g0rKTGr+RuvN798A9SNoB04V0DMYi5ZSCUKnav8ow3fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Elv+6aT9; arc=none smtp.client-ip=80.12.242.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.222.230])
	by smtp.orange.fr with ESMTPA
	id LGyusGzbVjiKDLGyusn1NL; Sun, 23 Jun 2024 08:45:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1719125144;
	bh=mvaiCxkajJYPoYk09ilckf4bnV5wjXJDRtKrJ6xsPmY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Elv+6aT9owWWgrVNEXrnNg3gMaBiiS/bbuR7YJpWiEUZL6+UuTgwLq2qebsNRBGZf
	 pOKXm/714ZdUwou+L5kDeI3Gr8z/tsx1kHov1pyTkzTUJY9RIZlaVXgKx2LHoo1c6T
	 DBU38JLfgnN2rksB6WrVt7EAv1mrp7HTW/5ifgnROrER2Hla/BGXy6Zxaz6XhpjbYb
	 /RqWqfvQvLwvLIsURE1sYDH7gRBvRAitLNcoI9yGLuJoYKSKHAsI4ZiPBzMN9o1DOD
	 L6zoD5IZTkW+tbFM/HdT05gRBmQbwOEO9dO9z0B5IvEK34g+HiegnWf+g+GJYBKZHX
	 vlS3+07uyCS6w==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 23 Jun 2024 08:45:44 +0200
X-ME-IP: 86.243.222.230
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: linus.walleij@linaro.org,
	Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 1/2] power: supply: samsung-sdi-battery: Constify struct power_supply_vbat_ri_table
Date: Sun, 23 Jun 2024 08:45:33 +0200
Message-ID: <d01818abd880bf435d1106a9a6cc11a7a8a3e661.1719125040.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct power_supply_vbat_ri_table' are not modified in this driver.

Constifying these structures moves some data to a read-only section, so
increase overall security.

In order to do it, some code also needs to be adjusted to this new const
qualifier.

On a x86_64, with allmodconfig:
Before:
======
$ size drivers/power/supply/samsung-sdi-battery.o
   text	   data	    bss	    dec	    hex	filename
    955	   7664	      0	   8619	   21ab	drivers/power/supply/samsung-sdi-battery.o

After:
=====
$ size drivers/power/supply/samsung-sdi-battery.o
   text	   data	    bss	    dec	    hex	filename
   4055	   4584	      0	   8639	   21bf	drivers/power/supply/samsung-sdi-battery.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only

Changes in v2
  - Add Linus Walleij <linus.walleij@linaro.org> in Cc  [Sebastian Reichel]

v1: https://lore.kernel.org/all/bab3f44b62275c91d039b82dac1c32167c0c3bad.1717253900.git.christophe.jaillet@wanadoo.fr/
---
 drivers/power/supply/power_supply_core.c   |  2 +-
 drivers/power/supply/samsung-sdi-battery.c | 24 +++++++++++-----------
 include/linux/power_supply.h               |  4 ++--
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index fefe938c9342..022d0e4bf621 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1024,7 +1024,7 @@ EXPORT_SYMBOL_GPL(power_supply_temp2resist_simple);
 int power_supply_vbat2ri(struct power_supply_battery_info *info,
 			 int vbat_uv, bool charging)
 {
-	struct power_supply_vbat_ri_table *vbat2ri;
+	const struct power_supply_vbat_ri_table *vbat2ri;
 	int table_len;
 	int i, high, low;
 
diff --git a/drivers/power/supply/samsung-sdi-battery.c b/drivers/power/supply/samsung-sdi-battery.c
index b33daab798b9..725fbe09379e 100644
--- a/drivers/power/supply/samsung-sdi-battery.c
+++ b/drivers/power/supply/samsung-sdi-battery.c
@@ -25,7 +25,7 @@ struct samsung_sdi_battery {
  * tables apply depending on whether we are charging or not.
  */
 
-static struct power_supply_vbat_ri_table samsung_vbat2res_discharging_eb_l1m7flu[] = {
+static const struct power_supply_vbat_ri_table samsung_vbat2res_discharging_eb_l1m7flu[] = {
 	{ .vbat_uv = 4240000, .ri_uohm = 160000 },
 	{ .vbat_uv = 4210000, .ri_uohm = 179000 },
 	{ .vbat_uv = 4180000, .ri_uohm = 183000 },
@@ -53,7 +53,7 @@ static struct power_supply_vbat_ri_table samsung_vbat2res_discharging_eb_l1m7flu
 	{ .vbat_uv = 3300000, .ri_uohm = 339000 },
 };
 
-static struct power_supply_vbat_ri_table samsung_vbat2res_charging_eb_l1m7flu[] = {
+static const struct power_supply_vbat_ri_table samsung_vbat2res_charging_eb_l1m7flu[] = {
 	{ .vbat_uv = 4302000, .ri_uohm = 230000 },
 	{ .vbat_uv = 4276000, .ri_uohm = 345000 },
 	{ .vbat_uv = 4227000, .ri_uohm = 345000 },
@@ -73,7 +73,7 @@ static struct power_supply_vbat_ri_table samsung_vbat2res_charging_eb_l1m7flu[]
 	{ .vbat_uv = 3590000, .ri_uohm = 164000 },
 };
 
-static struct power_supply_vbat_ri_table samsung_vbat2res_discharging_eb425161la[] = {
+static const struct power_supply_vbat_ri_table samsung_vbat2res_discharging_eb425161la[] = {
 	{ .vbat_uv = 4240000, .ri_uohm = 160000 },
 	{ .vbat_uv = 4210000, .ri_uohm = 179000 },
 	{ .vbat_uv = 4180000, .ri_uohm = 183000 },
@@ -105,7 +105,7 @@ static struct power_supply_vbat_ri_table samsung_vbat2res_discharging_eb425161la
 	{ .vbat_uv = 3300000, .ri_uohm = 339000 },
 };
 
-static struct power_supply_vbat_ri_table samsung_vbat2res_charging_eb425161la[] = {
+static const struct power_supply_vbat_ri_table samsung_vbat2res_charging_eb425161la[] = {
 	{ .vbat_uv = 4345000, .ri_uohm = 230000 },
 	{ .vbat_uv = 4329000, .ri_uohm = 238000 },
 	{ .vbat_uv = 4314000, .ri_uohm = 225000 },
@@ -182,7 +182,7 @@ static struct power_supply_vbat_ri_table samsung_vbat2res_charging_eb425161la[]
 	{ .vbat_uv = 3590000, .ri_uohm = 164000 },
 };
 
-static struct power_supply_vbat_ri_table samsung_vbat2res_discharging_eb425161lu[] = {
+static const struct power_supply_vbat_ri_table samsung_vbat2res_discharging_eb425161lu[] = {
 	{ .vbat_uv = 4240000, .ri_uohm = 160000 },
 	{ .vbat_uv = 4210000, .ri_uohm = 179000 },
 	{ .vbat_uv = 4180000, .ri_uohm = 183000 },
@@ -214,7 +214,7 @@ static struct power_supply_vbat_ri_table samsung_vbat2res_discharging_eb425161lu
 	{ .vbat_uv = 3300000, .ri_uohm = 339000 },
 };
 
-static struct power_supply_vbat_ri_table samsung_vbat2res_charging_eb425161lu[] = {
+static const struct power_supply_vbat_ri_table samsung_vbat2res_charging_eb425161lu[] = {
 	{ .vbat_uv = 4346000, .ri_uohm = 293000 },
 	{ .vbat_uv = 4336000, .ri_uohm = 290000 },
 	{ .vbat_uv = 4315000, .ri_uohm = 274000 },
@@ -244,7 +244,7 @@ static struct power_supply_vbat_ri_table samsung_vbat2res_charging_eb425161lu[]
 	{ .vbat_uv = 3590000, .ri_uohm = 164000 },
 };
 
-static struct power_supply_vbat_ri_table samsung_vbat2res_discharging_eb485159lu[] = {
+static const struct power_supply_vbat_ri_table samsung_vbat2res_discharging_eb485159lu[] = {
 	{ .vbat_uv = 4240000, .ri_uohm = 160000 },
 	{ .vbat_uv = 4210000, .ri_uohm = 179000 },
 	{ .vbat_uv = 4180000, .ri_uohm = 183000 },
@@ -271,7 +271,7 @@ static struct power_supply_vbat_ri_table samsung_vbat2res_discharging_eb485159lu
 	{ .vbat_uv = 3300000, .ri_uohm = 339000 },
 };
 
-static struct power_supply_vbat_ri_table samsung_vbat2res_charging_eb485159lu[] = {
+static const struct power_supply_vbat_ri_table samsung_vbat2res_charging_eb485159lu[] = {
 	{ .vbat_uv = 4302000, .ri_uohm = 200000 },
 	{ .vbat_uv = 4258000, .ri_uohm = 206000 },
 	{ .vbat_uv = 4200000, .ri_uohm = 231000 },
@@ -291,7 +291,7 @@ static struct power_supply_vbat_ri_table samsung_vbat2res_charging_eb485159lu[]
 	{ .vbat_uv = 3590000, .ri_uohm = 164000 },
 };
 
-static struct power_supply_vbat_ri_table samsung_vbat2res_discharging_eb535151vu[] = {
+static const struct power_supply_vbat_ri_table samsung_vbat2res_discharging_eb535151vu[] = {
 	{ .vbat_uv = 4071000, .ri_uohm = 158000 },
 	{ .vbat_uv = 4019000, .ri_uohm = 187000 },
 	{ .vbat_uv = 3951000, .ri_uohm = 191000 },
@@ -311,7 +311,7 @@ static struct power_supply_vbat_ri_table samsung_vbat2res_discharging_eb535151vu
 	{ .vbat_uv = 3280000, .ri_uohm = 250000 },
 };
 
-static struct power_supply_vbat_ri_table samsung_vbat2res_charging_eb535151vu[] = {
+static const struct power_supply_vbat_ri_table samsung_vbat2res_charging_eb535151vu[] = {
 	{ .vbat_uv = 4190000, .ri_uohm = 214000 },
 	{ .vbat_uv = 4159000, .ri_uohm = 252000 },
 	{ .vbat_uv = 4121000, .ri_uohm = 245000 },
@@ -331,7 +331,7 @@ static struct power_supply_vbat_ri_table samsung_vbat2res_charging_eb535151vu[]
 	{ .vbat_uv = 3510000, .ri_uohm = 228000 },
 };
 
-static struct power_supply_vbat_ri_table samsung_vbat2res_discharging_eb585157lu[] = {
+static const struct power_supply_vbat_ri_table samsung_vbat2res_discharging_eb585157lu[] = {
 	{ .vbat_uv = 4194000, .ri_uohm = 121000 },
 	{ .vbat_uv = 4169000, .ri_uohm = 188000 },
 	{ .vbat_uv = 4136000, .ri_uohm = 173000 },
@@ -401,7 +401,7 @@ static struct power_supply_vbat_ri_table samsung_vbat2res_discharging_eb585157lu
 	{ .vbat_uv = 3161000, .ri_uohm = 452000 },
 };
 
-static struct power_supply_vbat_ri_table samsung_vbat2res_charging_eb585157lu[] = {
+static const struct power_supply_vbat_ri_table samsung_vbat2res_charging_eb585157lu[] = {
 	{ .vbat_uv = 4360000, .ri_uohm = 128000 },
 	{ .vbat_uv = 4325000, .ri_uohm = 130000 },
 	{ .vbat_uv = 4316000, .ri_uohm = 148000 },
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 65082ef75692..5061eeecf62e 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -755,9 +755,9 @@ struct power_supply_battery_info {
 	int ocv_table_size[POWER_SUPPLY_OCV_TEMP_MAX];
 	struct power_supply_resistance_temp_table *resist_table;
 	int resist_table_size;
-	struct power_supply_vbat_ri_table *vbat2ri_discharging;
+	const struct power_supply_vbat_ri_table *vbat2ri_discharging;
 	int vbat2ri_discharging_size;
-	struct power_supply_vbat_ri_table *vbat2ri_charging;
+	const struct power_supply_vbat_ri_table *vbat2ri_charging;
 	int vbat2ri_charging_size;
 	int bti_resistance_ohm;
 	int bti_resistance_tolerance;
-- 
2.45.2


