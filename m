Return-Path: <linux-pm+bounces-15190-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2C09915AD
	for <lists+linux-pm@lfdr.de>; Sat,  5 Oct 2024 12:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2FEB1F232D8
	for <lists+linux-pm@lfdr.de>; Sat,  5 Oct 2024 10:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AF61487DF;
	Sat,  5 Oct 2024 10:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="VN7QjWKX"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A901231CA7;
	Sat,  5 Oct 2024 10:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728122689; cv=none; b=qWs/R67zBVRbAe0DSyc2x/mh1kzS/RQIswiiwaGsUQpY1XhWZczu4PICvSmmetAFIY8LgMgNYSxEOT8feBzHZJ7VQ3O8iRIsTp4EoNblAyUB1GufyB1wf+uKju6b+gF9oTmG8HC6CJICUOI2t0zpYSatIn9ps1iKSMA7bxdFau0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728122689; c=relaxed/simple;
	bh=4qTTd8cHY8k//IB2AglhRt3irpRoC0iA10R9Vbg+F/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=exbJ8j+ZJNgbj3zn7JtlyJMBixtt8iSVvZWrg9KI0hzc78UgIrlRrHzldscmV1AmWzH9vy+79eO3aTWjlLKWmqbeRMHbh5ZcoFuFGbQuNNq5Aad86OrilF8z+/ulfw/+26rHdhHoWbe3g1rCnJGVAtdlGng2Z8jCr1FQLZb2eCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=VN7QjWKX; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1728122684;
	bh=4qTTd8cHY8k//IB2AglhRt3irpRoC0iA10R9Vbg+F/4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VN7QjWKXFo6jglN3i1vC7Ju5aPAgAG201MP5fTmnz8VIAOc/25zmbsBB8H/sFdK0r
	 oxxvMY6I0KG9L4Fb4xTaZb/9uRueVxxMZFrMLRc9GP3Z7v41GF+ZMCQZiq9SDmPMxy
	 VYfcOsC6QxuljbArpqLf/Pv8WqM9cjENHoEi5n5c=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 05 Oct 2024 12:04:17 +0200
Subject: [PATCH 1/7] power: supply: core: constify
 power_supply_battery_info::resist_table
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241005-power-supply-battery-const-v1-1-c1f721927048@weissschuh.net>
References: <20241005-power-supply-battery-const-v1-0-c1f721927048@weissschuh.net>
In-Reply-To: <20241005-power-supply-battery-const-v1-0-c1f721927048@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728122683; l=2652;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=4qTTd8cHY8k//IB2AglhRt3irpRoC0iA10R9Vbg+F/4=;
 b=tK9N8tIuwWtttiO3whPdsgexMcPtCHKhcx+7OvB8PdFIWnJbarRuXMd6DMZYNPv0/HcfS/JRX
 4NBROc0m8mACyCeeLhUhg7X6w4qZth+qoC3q3ezhbeHNzv+Od+1JyUh
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The power supply core never modifies the resist table.
Reflect this in the API, so drivers can mark their static tables as
const.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/power_supply_core.c | 4 ++--
 include/linux/power_supply.h             | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 49534458a9f7d3f6d7c01bd91fa1bb6ed23bc7ad..a01703fa83c0d90ec630782e67aa3c2c406d51dd 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -798,7 +798,7 @@ int power_supply_get_battery_info(struct power_supply *psy,
 		goto out_ret_pointer;
 
 	info->resist_table_size = len / (2 * sizeof(__be32));
-	resist_table = info->resist_table = devm_kcalloc(&psy->dev,
+	info->resist_table = resist_table = devm_kcalloc(&psy->dev,
 							 info->resist_table_size,
 							 sizeof(*resist_table),
 							 GFP_KERNEL);
@@ -982,7 +982,7 @@ EXPORT_SYMBOL_GPL(power_supply_battery_info_get_prop);
  *
  * Return: the battery internal resistance percent
  */
-int power_supply_temp2resist_simple(struct power_supply_resistance_temp_table *table,
+int power_supply_temp2resist_simple(const struct power_supply_resistance_temp_table *table,
 				    int table_len, int temp)
 {
 	int i, high, low;
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 910d407ebe6323aaf4b31f0081f2cdd4be43a9fa..9253411c105f27177181f9b0a84285a7b24bc954 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -752,7 +752,7 @@ struct power_supply_battery_info {
 	int temp_max;
 	struct power_supply_battery_ocv_table *ocv_table[POWER_SUPPLY_OCV_TEMP_MAX];
 	int ocv_table_size[POWER_SUPPLY_OCV_TEMP_MAX];
-	struct power_supply_resistance_temp_table *resist_table;
+	const struct power_supply_resistance_temp_table *resist_table;
 	int resist_table_size;
 	const struct power_supply_vbat_ri_table *vbat2ri_discharging;
 	int vbat2ri_discharging_size;
@@ -805,7 +805,7 @@ power_supply_find_ocv2cap_table(struct power_supply_battery_info *info,
 extern int power_supply_batinfo_ocv2cap(struct power_supply_battery_info *info,
 					int ocv, int temp);
 extern int
-power_supply_temp2resist_simple(struct power_supply_resistance_temp_table *table,
+power_supply_temp2resist_simple(const struct power_supply_resistance_temp_table *table,
 				int table_len, int temp);
 extern int power_supply_vbat2ri(struct power_supply_battery_info *info,
 				int vbat_uv, bool charging);

-- 
2.46.2


