Return-Path: <linux-pm+bounces-8496-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDBA8D7087
	for <lists+linux-pm@lfdr.de>; Sat,  1 Jun 2024 17:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3135F1C20CDC
	for <lists+linux-pm@lfdr.de>; Sat,  1 Jun 2024 15:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0BD15252B;
	Sat,  1 Jun 2024 15:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="d4x+dacU"
X-Original-To: linux-pm@vger.kernel.org
Received: from msa.smtpout.orange.fr (msa-208.smtpout.orange.fr [193.252.23.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6991CD3D;
	Sat,  1 Jun 2024 15:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717254118; cv=none; b=UBJjZIImEhkWLjMcPt7dT7sb7NHNBXRIOjCy3Yr3bU+srDqjx4wFROqVY/P9D4oUW7BsyLxsDC4OU7bvKpSQtK4+n129S9H/Ov5AhlC03T+ZbEmZ0v2mxsGvVK0NoXBrnO22tJOy8o5/5xVoaFhdwdgvzcwtHKgQZ/ArIx8AzCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717254118; c=relaxed/simple;
	bh=Iq6pUEmxykmMPP8tuQyHJnvOL4YspIfNSqXdp0/B5C0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YLgbDdzQo1OpoDgR7D3wKfZ5Jo2kan7KiawfEnkjYLyGnhDB2QTDh+nI/7MyHIkBlNsvUeqG+CL3mF7cwMwqvehgj7g14Q+HxcoBlrQ8KylrHQC4oFVpJZ/9ZwJGe4NoPrrY3B1uBZ9Z2w4v/Q49Z/DidyuKmd/bw2/AoHu783c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=d4x+dacU; arc=none smtp.client-ip=193.252.23.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id DQDisz5ua13tqDQDisovZV; Sat, 01 Jun 2024 17:00:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1717254035;
	bh=9g+o5AqvViRoCMosYR6L5DJAcKPjQZBiCuO6+wDAnOo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=d4x+dacUmybrb4yy3YoEEOG+Us65Ai8aKGXVPIWyMCkFLnqGIRvU/AHW2+6kapGAX
	 z2de5Vmf4fr0OOJV1XnPMi4GszhsHRg+tQiRD+saXXn/bjZ7R30nWZhPmKofpmLmW8
	 VUf504mTGd7Rhr08106AfF3WAaOsyvIggBazRSepAUfpGr8AkFbdn7BrCo3V4dIpNF
	 korfwXfTDeNGXwpzTCa/PmFrG/7efVSBoCGHJ2ABGbrBaJg8x73fGaeOw9X1tubogK
	 fvR/pQb7PbtHsM4AldcOYuSCTVwB2NaMm+U0Dxt1TJfgxXy993x/EFXpDUbmXwwcLB
	 NT1sX5hYHWn8A==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 01 Jun 2024 17:00:35 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-pm@vger.kernel.org
Subject: [PATCH 1/2] power: supply: samsung-sdi-battery: Constify struct power_supply_vbat_ri_table
Date: Sat,  1 Jun 2024 17:00:28 +0200
Message-ID: <bab3f44b62275c91d039b82dac1c32167c0c3bad.1717253900.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1717253900.git.christophe.jaillet@wanadoo.fr>
References: <cover.1717253900.git.christophe.jaillet@wanadoo.fr>
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
index 8e5705a56b85..3ccf7d47f502 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -760,9 +760,9 @@ struct power_supply_battery_info {
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
2.45.1


