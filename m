Return-Path: <linux-pm+bounces-21566-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 752ACA2CEE9
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 22:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B51793A035F
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 21:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6111A5B9E;
	Fri,  7 Feb 2025 21:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8BC4Y82"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5616E1632E6;
	Fri,  7 Feb 2025 21:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738962982; cv=none; b=Zk9JjqKGyKqQfZ+4Vty4a8bjDUb4/5lmxuyusq385kRhatXx5XNW87qOCjFA4lp4sLl/7poe1EFRrmJO4nSUtk6nBIXJNm5JpUNiLUHDbtBCBTjgc/osEFwbqwhu4hxfg2FmMvM1tdDz46jsO/7G8TlIGqaZq1hAfU4MnSehCvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738962982; c=relaxed/simple;
	bh=7UeGg7kv2sa4bxLDoXxtgLeU2ienhLhTjM5Q559+ZZo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZAfTZlJqibWD995msJQr+Y+7Y3ZpQcWvp+wbRQpH+Np4tmxD/AiG++fmx8dZBxWfsfQaCaCITPayKokh4NxTXP6wjd0y70WZuO0PRvV0ul9RteaIBSRgUGJ2SFvZCinSXHBjgu7RHQsbFXnEHttLVo4nwXMl2q5R8IOWBEkJCNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8BC4Y82; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ab77e266c71so310482066b.2;
        Fri, 07 Feb 2025 13:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738962978; x=1739567778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IwG2TZZCnC4z1hhgqrczl6WgTQXFK9VgDmfSGJz4e6M=;
        b=Z8BC4Y82e5HUabZm0FegVpKGNr6fLQfsfgbOgTkU4q1lxquOjbizp4+32NWYwJvI0o
         kZp8n7fzPj9Knn1du28DPev2HJv52C751sFzuB1WlV6buK2Oa1IhnJknTNvoaYmxFKyB
         411fTiR29KuNXEKv+V1/BxlPt132b1AaSNtc0M8jsD0WGbOr6cqn0s0BwDiAXFcCTUSi
         xbNh4LfoYBHi1cqXYPYeV3b6lvSXbRr/xlIMWSpw/hi+QLm/SnYqUEKo1DDfv+OeYcHY
         Bz69mzyD1pDkj1BZukFczZ5w6uEZWJJzupbR3cL2ZeKHapHOllwFdQospG4pomW7CKkm
         8zNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738962978; x=1739567778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IwG2TZZCnC4z1hhgqrczl6WgTQXFK9VgDmfSGJz4e6M=;
        b=s1Wx3GnIelzBPNKHgbGs5tH9yljyGJ/7WjD192fIjclbqJ4ivKKErFpmQsmPyh1jIP
         UnR/pCNB+dtu0mxU+IB56jTDjVBgywg3ywnk8PJi55BbLdLgWAi4eroT2kyTkFHyfGLv
         zU0k8+bVPeCdfwsKX0zCaKRqFZ+U+U5zpzMNCbbYo5Ro7/WmfFRoPOyp5euHUSw/Mi9D
         F5r9MPgD6nU4SH4dm1Qq/70r6q/+bk+xZBiUOtt4fVdxKN7e/TdhwYbQZokPHVoyB9jY
         31oiBIsDs4BeaIJDskJ5QcSWrFruAC2Tw3Oyew3lgVcgjU9WstxPoMbiN0MBPYPXbn4K
         4lDA==
X-Forwarded-Encrypted: i=1; AJvYcCV3Bi7vCzexd3tPrmlkgX8MceigD2/+bUmiJQpxWz4EUHdD/f1Vup/KlG3SpkwGVOnoDckwiHcaRA==@vger.kernel.org, AJvYcCWbJRXZZ87T21YdVho69SJFP+5BPHAW8shAMLMKDVgVmYp0PCQ4kd2zfhAIVymSG8mb6GZBvnTQTPLoKD4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywfx5HphBwQIXvF07bxkyrS+NK0IjrYOC8Ky9ZO4d5vrrD+CNk
	+rUur4Jp46OI7LeEf0O6vTbTLV+7uyaJLFk0XM/+YzyBwNux74V2
X-Gm-Gg: ASbGnctNLwFfMjKKOAt/qaDAik2aTYJFmwUnoNmzFqjliKPTK7org4IJ7MQ1HTNez5D
	G54Y3OSrGXGlr1Dt7SPPb0Eef0UCp8W4jCm+uyNgu5PmksGbahIEWTrfonlvD6ZKVU+fb61W2WR
	ePlJOBlhuYxilebzMtEYTRbfsL8RlJHnc/SDeBcHIv0nIq7zu7fkOW7z+XTx9Sk99YiBVXtLsfC
	veh2Mwn+Ck7QhxDnzO/MxcMh3liQHDw6xRtN6XBnDzarTppPGfj8XgTU2O9woxmKpaJnN5uDg76
	9GzKtvY=
X-Google-Smtp-Source: AGHT+IGYGdd2zv2zP9WwcMHOXICBYpICTNM9xNJKemUMbj/E8DNPGIBoyxQG0nsLcJxVB0uBtbuBYA==
X-Received: by 2002:a17:907:c04:b0:aaf:74d6:6467 with SMTP id a640c23a62f3a-ab789cbe9d5mr545320766b.42.1738962978210;
        Fri, 07 Feb 2025 13:16:18 -0800 (PST)
Received: from tpt440p.. ([41.84.244.74])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab773333a90sm330963266b.130.2025.02.07.13.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 13:16:17 -0800 (PST)
From: "Sicelo A. Mhlongo" <absicsz@gmail.com>
To: pali@kernel.org,
	sre@kernel.org,
	linux-pm@vger.kernel.org
Cc: maemo-leste@lists.dyne.org,
	phone-devel@vger.kernel.org,
	"Sicelo A. Mhlongo" <absicsz@gmail.com>
Subject: [PATCH] power: supply: bq27xxx: Add voltage_max_design property for bq270x0 and bq27x10
Date: Fri,  7 Feb 2025 23:15:13 +0200
Message-ID: <20250207211521.103357-1-absicsz@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Report VOLTAGE_MAX_DESIGN for the bq27x00 and bq27x10 fuel gauges. Per the
datasheet, this value is stored in the Charge Termination Voltage Settings
(QV0 and QV1) of the Pack Configuration register.

Tested on the Nokia N900 with bq27200.

Signed-off-by: Sicelo A. Mhlongo <absicsz@gmail.com>
---
 drivers/power/supply/bq27xxx_battery.c | 37 ++++++++++++++++++++++++++
 include/linux/power/bq27xxx_battery.h  |  1 +
 2 files changed, 38 insertions(+)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 90a5bccfc6b9..abc6d9329776 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -124,6 +124,7 @@ enum bq27xxx_reg_index {
 	BQ27XXX_DM_DATA,	/* Block Data */
 	BQ27XXX_DM_CKSUM,	/* Block Data Checksum */
 	BQ27XXX_REG_SEDVF,	/* End-of-discharge Voltage */
+	BQ27XXX_REG_PKCFG,	/* Pack Configuration */
 	BQ27XXX_REG_MAX,	/* sentinel */
 };
 
@@ -161,6 +162,7 @@ static u8
 		[BQ27XXX_DM_DATA] = INVALID_REG_ADDR,
 		[BQ27XXX_DM_CKSUM] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_SEDVF] = 0x77,
+		[BQ27XXX_REG_PKCFG] = 0x7C,
 	},
 	bq27010_regs[BQ27XXX_REG_MAX] = {
 		[BQ27XXX_REG_CTRL] = 0x00,
@@ -187,6 +189,7 @@ static u8
 		[BQ27XXX_DM_DATA] = INVALID_REG_ADDR,
 		[BQ27XXX_DM_CKSUM] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_SEDVF] = 0x77,
+		[BQ27XXX_REG_PKCFG] = 0x7C,
 	},
 	bq2750x_regs[BQ27XXX_REG_MAX] = {
 		[BQ27XXX_REG_CTRL] = 0x00,
@@ -583,6 +586,7 @@ static enum power_supply_property bq27000_props[] = {
 	POWER_SUPPLY_PROP_HEALTH,
 	POWER_SUPPLY_PROP_MANUFACTURER,
 	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
+	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
 };
 
 static enum power_supply_property bq27010_props[] = {
@@ -604,6 +608,7 @@ static enum power_supply_property bq27010_props[] = {
 	POWER_SUPPLY_PROP_HEALTH,
 	POWER_SUPPLY_PROP_MANUFACTURER,
 	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
+	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
 };
 
 #define bq2750x_props bq27510g3_props
@@ -2044,6 +2049,35 @@ static int bq27xxx_battery_voltage(struct bq27xxx_device_info *di,
 	return 0;
 }
 
+/*
+ * Return the design maximum battery Voltage in microvolts, or < 0 if something
+ * fails. The programmed value of the maximum battery voltage is determined by
+ * QV0 and QV1 (bits 5 and 6) in the Pack Configuration register.
+ */
+static int bq27xxx_battery_read_dmax_volt(struct bq27xxx_device_info *di,
+					  union power_supply_propval *val)
+{
+	int reg_val, qv;
+
+	if (di->voltage_max_design > 0) {
+		val->intval = di->voltage_max_design;
+		return 0;
+	}
+
+	reg_val = bq27xxx_read(di, BQ27XXX_REG_PKCFG, true);
+	if (reg_val < 0) {
+		dev_err(di->dev, "error reading design max voltage\n");
+		return reg_val;
+	}
+
+	qv = (reg_val >> 5) & 0x3;
+	val->intval = 3968000 + 48000 * qv;
+
+	di->voltage_max_design = val->intval;
+
+	return 0;
+}
+
 /*
  * Return the design minimum battery Voltage in microvolts
  * Or < 0 if something fails.
@@ -2158,6 +2192,9 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
 		ret = bq27xxx_battery_read_dmin_volt(di, val);
 		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
+		ret = bq27xxx_battery_read_dmax_volt(di, val);
+		break;
 	case POWER_SUPPLY_PROP_CYCLE_COUNT:
 		ret = bq27xxx_battery_read_cyct(di, val);
 		break;
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index 6b190639b08e..d56e1276aafe 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -62,6 +62,7 @@ struct bq27xxx_device_info {
 	struct bq27xxx_reg_cache cache;
 	int charge_design_full;
 	int voltage_min_design;
+	int voltage_max_design;
 	bool removed;
 	unsigned long last_update;
 	union power_supply_propval last_status;
-- 
2.47.2


