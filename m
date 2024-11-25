Return-Path: <linux-pm+bounces-18088-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 029469D88E8
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 16:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B70EE282EC7
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 15:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D784B1B4137;
	Mon, 25 Nov 2024 15:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYVA6AMT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F171B3958;
	Mon, 25 Nov 2024 15:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732547644; cv=none; b=Pg450QhdqpUy/Hrvs0wrrAtoBN31kYnQX8gIklpyve2MUF5ddck2yrZJV4foUsh9jQlreXoT5JRz/TRN1ZBwydP4rethvV2Fx1KVUkdmVrgUfqhclVGc4GngesW6BDfFTtMMDNaggTB4c6lii8fDsiIpyy21tzn+hBI14HrgIjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732547644; c=relaxed/simple;
	bh=ZkVMLpzLhNcQRs+hYBFMGEpR1j3Q+8DIRycGutk5qFw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ClhMCeNUNhVk4PeSO5DU7a+XNlX3W1or13XrwbxBcroxyRnR3EkIZKH2LhPS0Uu3yymDSmHQofKddmgfeFc4DyHuajin3NwFVEN8TJpzs7KZ29StiPNAhRzW5o5SSmKMcF8PTkmViVTUhx6Dk05JzExUFQBovdsjbF4Xm5s9y44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TYVA6AMT; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-431616c23b5so25845855e9.0;
        Mon, 25 Nov 2024 07:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732547641; x=1733152441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aNqsWnnw8BGInX15AWtsvHkwZEzBkzeRqwkk8eEPsng=;
        b=TYVA6AMT13Y2iZSJx28rs0xWcsZuO7kCR5EJS/IQcc7OnIhgQGFzkVlqn0hVleXar8
         7iePNRgYGVAwULjc5Lc9s1i0u9LO6pAlKWsFl4C23DT+4eidAZ07zot0F2Ts+jEweKkI
         Z7qWKScRMGfnw/iBAYko8DyIvG5Az8/elmiLdPqoBzI37Jsz45SIY9PGt3avzM14DS4o
         D+Z1vsayaaObqWVtyTQtC3ddvAyOXJLtvuMTz4lp5QFuU/45g9UL9c8+Xmlx+gVHNLHg
         cfhfPzTAy6xKyknOuJDwZAVH+lj9kbZQdbrI5AKu9L++/aFcffYxGGYxGtqYglbyN6v7
         31ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732547641; x=1733152441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aNqsWnnw8BGInX15AWtsvHkwZEzBkzeRqwkk8eEPsng=;
        b=iVX+ERcRMd63IhpCYZjFzU1ifJaHbDTjm2HcRlhNsO65Plzs0vAnVxiUofNxhBq7XW
         2VwveMvhF9sS7SLe0CxOoQJixBa6aV82UzaRu2HLKXd+DwgdD4Xk0v2kVF3j4fINiCb5
         kajSz6hmQko65eCu9R8kXn0pCxsHYQYmrjmEuqNjwHmo0xJ4kADPytk6/Dg+/CPBlQW7
         gZwoFsdL7NPLQpzrPFCjCvTEymrzv7mafw7bDhNxNn5iDaVyxUjeOWGZvoHncUkZd/Ed
         fYCGnPS2ma60MOzOzgA+xDlCQJxoQy4nozZcmtRDO4qwiKOEdKDepQTHTekxsgJdz1pp
         OJ1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVt8rIpfzCR2umBpNNsYnc3OswiWA6uwNlI8PpJ/rd0sTwSDUkCezv7kE3snMB+AKoz/B4QLCooGTMgN7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnpAF4hu09KZt8UlAD5MCPF9gJwNWNlG59lrd2RmPYn7q/hoqK
	8Ad0ek3IplMZUSQBuyvPfEWYKpEV9ub9Nm0dAxYtD3QYXP4dC/4wnZOmL1zaWys=
X-Gm-Gg: ASbGnctvBoccqgrTE58GC2+g1AVyVYJU/UzybW2r8EGDZI5hvOVMTDVZUpErfrV0fFH
	kdur6p9xdvP4u1L8qY03bAQRZwn4cf6rAJxe7RyS/SBLyQAhaAu8z0zsZ8ixKsHQ/cQm4d33pz8
	qZ0y46EB9kybcIycsuzi1acQ1YPC+wryhi2LIV2wE5dEiXWyUVyIvUQJlMhdKMDuWol3F2GsjDm
	E5X4k9hXYo3Cit1R9Oqp//YbnTXYv2qBtSAcsxzO4a7kcINGA==
X-Google-Smtp-Source: AGHT+IF6cah2hlbidazZqbUHsgc9CVqqI7DE8AJtVnzWIsk1Hvwwpb2oG/QsWZ/8OSrcgI4JmcuFUA==
X-Received: by 2002:a05:600c:4f52:b0:434:9ff4:24a1 with SMTP id 5b1f17b1804b1-4349ff425c8mr30466125e9.13.1732547641053;
        Mon, 25 Nov 2024 07:14:01 -0800 (PST)
Received: from tpt440p.. ([69.63.64.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433cde98988sm131219495e9.42.2024.11.25.07.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 07:14:00 -0800 (PST)
From: "Sicelo A. Mhlongo" <absicsz@gmail.com>
To: linux-pm@vger.kernel.org
Cc: pali@kernel.org,
	sre@kernel.org,
	linux-kernel@vger.kernel.org,
	maemo-leste@lists.dyne.org,
	"Sicelo A. Mhlongo" <absicsz@gmail.com>
Subject: [PATCH] bq27xxx: add voltage min design for bq27000 and bq27200
Date: Mon, 25 Nov 2024 17:12:58 +0200
Message-ID: <20241125151321.45440-1-absicsz@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bq27x00 gauges have an EEPROM register which contains the value of
the voltage that should be considered to be zero battery capacity. Expose
this to userspace using the VOLTAGE_MIN_DESIGN property.

Tested on Nokia N900 with bq27200.

Signed-off-by: Sicelo A. Mhlongo <absicsz@gmail.com>
---
 drivers/power/supply/bq27xxx_battery.c | 39 +++++++++++++++++++++++++-
 include/linux/power/bq27xxx_battery.h  |  1 +
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 40c5ac7a1118..90a5bccfc6b9 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -123,6 +123,7 @@ enum bq27xxx_reg_index {
 	BQ27XXX_DM_BLOCK,	/* Data Block */
 	BQ27XXX_DM_DATA,	/* Block Data */
 	BQ27XXX_DM_CKSUM,	/* Block Data Checksum */
+	BQ27XXX_REG_SEDVF,	/* End-of-discharge Voltage */
 	BQ27XXX_REG_MAX,	/* sentinel */
 };
 
@@ -159,6 +160,7 @@ static u8
 		[BQ27XXX_DM_BLOCK] = INVALID_REG_ADDR,
 		[BQ27XXX_DM_DATA] = INVALID_REG_ADDR,
 		[BQ27XXX_DM_CKSUM] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_SEDVF] = 0x77,
 	},
 	bq27010_regs[BQ27XXX_REG_MAX] = {
 		[BQ27XXX_REG_CTRL] = 0x00,
@@ -184,6 +186,7 @@ static u8
 		[BQ27XXX_DM_BLOCK] = INVALID_REG_ADDR,
 		[BQ27XXX_DM_DATA] = INVALID_REG_ADDR,
 		[BQ27XXX_DM_CKSUM] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_SEDVF] = 0x77,
 	},
 	bq2750x_regs[BQ27XXX_REG_MAX] = {
 		[BQ27XXX_REG_CTRL] = 0x00,
@@ -579,6 +582,7 @@ static enum power_supply_property bq27000_props[] = {
 	POWER_SUPPLY_PROP_POWER_AVG,
 	POWER_SUPPLY_PROP_HEALTH,
 	POWER_SUPPLY_PROP_MANUFACTURER,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
 };
 
 static enum power_supply_property bq27010_props[] = {
@@ -599,6 +603,7 @@ static enum power_supply_property bq27010_props[] = {
 	POWER_SUPPLY_PROP_CYCLE_COUNT,
 	POWER_SUPPLY_PROP_HEALTH,
 	POWER_SUPPLY_PROP_MANUFACTURER,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
 };
 
 #define bq2750x_props bq27510g3_props
@@ -2039,6 +2044,36 @@ static int bq27xxx_battery_voltage(struct bq27xxx_device_info *di,
 	return 0;
 }
 
+/*
+ * Return the design minimum battery Voltage in microvolts
+ * Or < 0 if something fails.
+ */
+static int bq27xxx_battery_read_dmin_volt(struct bq27xxx_device_info *di,
+					  union power_supply_propval *val)
+{
+	int volt;
+
+	/* We only have to read design minimum voltage once */
+	if (di->voltage_min_design > 0) {
+		val->intval = di->voltage_min_design;
+		return 0;
+	}
+
+	volt = bq27xxx_read(di, BQ27XXX_REG_SEDVF, true);
+	if (volt < 0) {
+		dev_err(di->dev, "error reading design min voltage\n");
+		return volt;
+	}
+
+	/* SEDVF = Design EDVF / 8 - 256 */
+	val->intval = volt * 8000 + 2048000;
+
+	/* Save for later reads */
+	di->voltage_min_design = val->intval;
+
+	return 0;
+}
+
 static int bq27xxx_simple_value(int value,
 				union power_supply_propval *val)
 {
@@ -2119,8 +2154,10 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 	 * power_supply_battery_info visible in sysfs.
 	 */
 	case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
-	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
 		return -EINVAL;
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
+		ret = bq27xxx_battery_read_dmin_volt(di, val);
+		break;
 	case POWER_SUPPLY_PROP_CYCLE_COUNT:
 		ret = bq27xxx_battery_read_cyct(di, val);
 		break;
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index 5180dc9f1706..6b190639b08e 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -61,6 +61,7 @@ struct bq27xxx_device_info {
 	struct bq27xxx_access_methods bus;
 	struct bq27xxx_reg_cache cache;
 	int charge_design_full;
+	int voltage_min_design;
 	bool removed;
 	unsigned long last_update;
 	union power_supply_propval last_status;
-- 
2.45.2


