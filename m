Return-Path: <linux-pm+bounces-43839-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2I8UEKvnqmkTYAEAu9opvQ
	(envelope-from <linux-pm+bounces-43839-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 15:41:47 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBEA222E78
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 15:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9FF031A1027
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 14:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DF33B5319;
	Fri,  6 Mar 2026 14:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="KrpqSm2A"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F023B52EC
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 14:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772807624; cv=none; b=MkdG6kDv+m0grtOEBu3Q0c+z3riZmxdGWC5cHPdVYIzcYWsXwf51/y0c3TXfu245ytvbbhjjiokhhjsfFc/j3har3wLIh7cbypd+7KoeCcg3oLAlak3saTcH8OyrMHLfWqA4EzzjeI7NwdX+YF9po+y3w83qAa6W+AnOMZHlqD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772807624; c=relaxed/simple;
	bh=2FRt1CMOeDBi+ujSYpU8g2MoZjv4gg2WASiAGR4BCTE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uXDNR6Q5qSW9UYB4Zaym1sxUE9l9s/JGeL3gEfKgP6F0bcP9Ky3EZWgT/mwWlvvokJD5RvLnwz/hpGADkFFywiOHJrn/LQWsn/3R7DJyFxHiw9HJvw7/vsMkcbI8w50eiX/ZMrZPurGWtAjiKKnzvBraQyb34y7aWyXqtym+SzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=KrpqSm2A; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439d8df7620so600063f8f.0
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2026 06:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1772807621; x=1773412421; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IJMru6MZkUAstlWRCj83fHNH00MaKj2n7fewPDh1WhI=;
        b=KrpqSm2AqQbMEpZ97X7YBb9b9OYa0i7OK6dNVe1YJ8dAxQGXX6KbCY+JD0GA+lKrIS
         FR1Gishzf8zuimrT6agzkltVpaSmEihibPRZJFxwieX4qjOpKH1LctNA8Exou7zdXQPW
         kuYfx/LJnifxgy+B531A/+eYkoRG8tXq0kF8te+0aXzI02jkIbh5ey6no+ktRavcPE2M
         QNJ9rhwrb+kEt7eRyh87TqI4mCC7Wd528t1KmzgkN3EnVrYb/rwKiJSnicXevuiQ0+2g
         hDVV6Bnjv7Wb/N5RUu1Bx8tOytSpdo5zin0LrleKcZZWeeRbssEnzCacvx0WI1dlUHxD
         RVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772807621; x=1773412421;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IJMru6MZkUAstlWRCj83fHNH00MaKj2n7fewPDh1WhI=;
        b=mqT6cDSuUqvD7AZjg4I+iYa9ttnu/voPDgv5vu+zVlB51U+Td05ZaLCGXKNVTaFko6
         KOPkxrRE8J+sA4MiU5zsTIbBOBtgocZ72ArXAoIaJVwZFLhehtu+0wjW6zEjWnViKU78
         uckoAQZmsR5wgCopI3IhSAxe7QCYBN7+i/tPAlEqHkbUsRRmP1FJpy3F0UgULQScWh3B
         RadUgE32Isyj4pzWNXY138oDWaqcZUlXpgHFkca/WvMjXIJNCUL5dyICJtIj8orJAgha
         HZEUD76doAYUiCXpkDw6Ytwksd8KMM69aDumG19IH0dX0+3tJ4c0weOB2gKCcyGAFzYI
         6+Uw==
X-Forwarded-Encrypted: i=1; AJvYcCV+0p9knK4h+3RW9YEM1TIBqkXrXx3fAZ8x6eTAipexSY34hK/w89dKLvKepuSphw0Bydrgq3KriA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFWQU4R7+slDXzmM1C/2EiSbJup2+wQJSZkJ1c/8aKGvV6Plup
	ScLMFqgbRr4iGKiwebg0GdSuKjxIDsf4jp7sdS8aCPkGS9qQe091fYGxUrsK/lxjXXQ=
X-Gm-Gg: ATEYQzznxKtuPmxQgOsGCI2Ekb9e5X0kd+UGxhqgPXY1ex87mJkv7lEkFO5D8PuHZSn
	zSwwBBZhVdVj6td+UM3nn67s2WRiUuAnWSmwy8fWImnMRrwXEZnTRQEH0zcH5zVT4uULiy/LDXV
	eJx1ZJY/gM5yYww1/Pup4gni9v8Dd+vLUBufNlnqKzFhVQCpsR24X3rnqxA1CgRaaGlasLAXaqt
	tiy+wLWEk+Twucdb32+7faeozYabWEaWCdUe2Z1KygbzcB+SH2DpcHjbz+WW9sH5MTPdc4dQTtB
	lnC4k/jpbHSBBEqB2T3CYQIFue8EBJdIbDflCAF4RbIryWoYHVtlNqTIBgqEm6sLKDjYRLu/zqI
	vq4raGqdrztgG3MPkGyTTaU0mQk2xrp3AlGcr2APe4GDdVSWD8B2U0F2kBnELpdpyNYY487sLnd
	wjFFi+JauvpYqxYT1g+r2EkdgdMwJVPi/Zgt8nWCbiRlrXWZuEEDShq41cALCYAiauh5yHt4blO
	7gS0A==
X-Received: by 2002:a05:6000:228a:b0:439:c202:99aa with SMTP id ffacd0b85a97d-439da885b6dmr4425282f8f.38.1772807619433;
        Fri, 06 Mar 2026 06:33:39 -0800 (PST)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae. [86.98.192.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8daf2sm4635281f8f.2.2026.03.06.06.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 06:33:39 -0800 (PST)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 06 Mar 2026 18:33:11 +0400
Subject: [PATCH v2 11/11] power: supply: bq257xx: Add support for BQ25792
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-bq25792-v2-11-6595249d6e6f@flipper.net>
References: <20260306-bq25792-v2-0-6595249d6e6f@flipper.net>
In-Reply-To: <20260306-bq25792-v2-0-6595249d6e6f@flipper.net>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chris Morgan <macromorgan@hotmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=22800; i=alchark@flipper.net;
 h=from:subject:message-id; bh=2FRt1CMOeDBi+ujSYpU8g2MoZjv4gg2WASiAGR4BCTE=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSuerpE6XUex9WfJ50S7f1C1x1LNo+12v/s7betn6JEl
 or7T5t3qmMiC4MYF4OlmCLL3G9LbKca8c3a5eHxFWYOKxPIEGmRBgYgYGHgy03MKzXSMdIz1TbU
 MzTUMdYxYuDiFICpzuVl+B9/n336LasXl1/khDTtjEjz8F0k4f9nQ8hNx986DxdbbHNl+F+3b8G
 OkrKDnyxtdqk+63739My7H3tyruSvv5dzovnQxCx2AA==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Rspamd-Queue-Id: ABBEA222E78
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[flipper.net,quarantine];
	R_DKIM_ALLOW(-0.20)[flipper.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43839-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,hotmail.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[flipper.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alchark@flipper.net,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[flipper.net:dkim,flipper.net:email,flipper.net:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Add support for TI BQ25792 integrated battery charger and buck-boost
converter.

It shares high-level logic of operation with the already supported
BQ25703A, but has a different register map, bit definitions and some of
the lower-level hardware states.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/power/supply/bq257xx_charger.c | 491 ++++++++++++++++++++++++++++++++-
 include/linux/mfd/bq257xx.h            |   6 +-
 2 files changed, 492 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/bq257xx_charger.c b/drivers/power/supply/bq257xx_charger.c
index 951abd035fc5..55337a9607fc 100644
--- a/drivers/power/supply/bq257xx_charger.c
+++ b/drivers/power/supply/bq257xx_charger.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/byteorder/generic.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/mfd/bq257xx.h>
@@ -18,12 +19,19 @@ struct bq257xx_chg;
 
 /**
  * struct bq257xx_chip_info - chip specific routines
+ * @default_iindpm_uA: default input current limit in microamps
  * @bq257xx_hw_init: init function for hw
  * @bq257xx_hw_shutdown: shutdown function for hw
  * @bq257xx_get_state: get and update state of hardware
+ * @bq257xx_get_ichg: get maximum charge current (in uA)
  * @bq257xx_set_ichg: set maximum charge current (in uA)
+ * @bq257xx_get_vbatreg: get maximum charge voltage (in uV)
  * @bq257xx_set_vbatreg: set maximum charge voltage (in uV)
+ * @bq257xx_get_iindpm: get maximum input current (in uA)
  * @bq257xx_set_iindpm: set maximum input current (in uA)
+ * @bq257xx_get_cur: get battery current from ADC (in uA)
+ * @bq257xx_get_vbat: get battery voltage from ADC (in uV)
+ * @bq257xx_get_min_vsys: get minimum system voltage (in uV)
  */
 struct bq257xx_chip_info {
 	int default_iindpm_uA;
@@ -47,8 +55,10 @@ struct bq257xx_chip_info {
  * @bq: parent MFD device
  * @charger: power supply device
  * @online: charger input is present
+ * @charging: charger is actively charging the battery
  * @fast_charge: charger is in fast charge mode
  * @pre_charge: charger is in pre-charge mode
+ * @overvoltage: overvoltage fault detected
  * @ov_fault: charger reports over voltage fault
  * @batoc_fault: charger reports battery over current fault
  * @oc_fault: charger reports over current fault
@@ -79,6 +89,53 @@ struct bq257xx_chg {
 	u32 vsys_min;
 };
 
+/**
+ * bq25792_read16() - Read a 16-bit value from device register
+ * @pdata: driver platform data
+ * @reg: register address to read from
+ * @val: pointer to store the register value
+ *
+ * Read a 16-bit big-endian value from the BQ25792 device via regmap
+ * and convert to CPU byte order.
+ *
+ * Return: Returns 0 on success or error on failure to read.
+ */
+static int bq25792_read16(struct bq257xx_chg *pdata, unsigned int reg, u16 *val)
+{
+	__be16 regval;
+	int ret;
+
+	ret = regmap_raw_read(pdata->bq->regmap, reg, &regval, sizeof(regval));
+	if (ret)
+		return ret;
+
+	*val = be16_to_cpu(regval);
+	return 0;
+}
+
+/**
+ * bq25792_write16() - Write a 16-bit value to device register
+ * @pdata: driver platform data
+ * @reg: register address to write to
+ * @val: 16-bit value to write in CPU byte order
+ *
+ * Convert the value to big-endian and write a 16-bit value to the
+ * BQ25792 device via regmap.
+ *
+ * Return: Returns 0 on success or error on failure to write.
+ */
+static int bq25792_write16(struct bq257xx_chg *pdata, unsigned int reg, u16 val)
+{
+	__be16 regval = cpu_to_be16(val);
+	int ret;
+
+	ret = regmap_raw_write(pdata->bq->regmap, reg, &regval, sizeof(regval));
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 /**
  * bq25703_get_state() - Get the current state of the device
  * @pdata: driver platform data
@@ -110,6 +167,43 @@ static int bq25703_get_state(struct bq257xx_chg *pdata)
 	return 0;
 }
 
+/**
+ * bq25792_get_state() - Get the current state of the device
+ * @pdata: driver platform data
+ *
+ * Get the current state of the BQ25792 charger by reading status
+ * registers. Updates the online, charging, overvoltage, and fault
+ * status fields in the driver data structure.
+ *
+ * Return: Returns 0 on success or error on failure to read device.
+ */
+static int bq25792_get_state(struct bq257xx_chg *pdata)
+{
+	unsigned int reg;
+	int ret;
+
+	ret = regmap_read(pdata->bq->regmap, BQ25792_REG1B_CHARGER_STATUS_0, &reg);
+	if (ret)
+		return ret;
+
+	pdata->online = reg & BQ25792_REG1B_PG_STAT;
+
+	ret = regmap_read(pdata->bq->regmap, BQ25792_REG1C_CHARGER_STATUS_1, &reg);
+	if (ret)
+		return ret;
+
+	pdata->charging = reg & BQ25792_REG1C_CHG_STAT_MASK;
+
+	ret = regmap_read(pdata->bq->regmap, BQ25792_REG20_FAULT_STATUS_0, &reg);
+	if (ret)
+		return ret;
+
+	pdata->overvoltage = reg & BQ25792_REG20_OVERVOLTAGE_MASK;
+	pdata->oc_fault = reg & BQ25792_REG20_OVERCURRENT_MASK;
+
+	return 0;
+}
+
 /**
  * bq25703_get_min_vsys() - Get the minimum system voltage
  * @pdata: driver platform data
@@ -133,6 +227,31 @@ static int bq25703_get_min_vsys(struct bq257xx_chg *pdata, int *intval)
 	return ret;
 }
 
+/**
+ * bq25792_get_min_vsys() - Get the minimum system voltage
+ * @pdata: driver platform data
+ * @intval: pointer to store the minimum voltage value
+ *
+ * Read the current minimum system voltage setting from the device
+ * and return it in microvolts.
+ *
+ * Return: Returns 0 on success or error on failure to read.
+ */
+static int bq25792_get_min_vsys(struct bq257xx_chg *pdata, int *intval)
+{
+	unsigned int reg;
+	int ret;
+
+	ret = regmap_read(pdata->bq->regmap, BQ25792_REG00_MIN_SYS_VOLTAGE, &reg);
+	if (ret)
+		return ret;
+
+	reg = FIELD_GET(BQ25792_REG00_VSYSMIN_MASK, reg);
+	*intval = (reg * BQ25792_MINVSYS_STEP_UV) + BQ25792_MINVSYS_MIN_UV;
+
+	return ret;
+}
+
 /**
  * bq25703_set_min_vsys() - Set the minimum system voltage
  * @pdata: driver platform data
@@ -157,6 +276,29 @@ static int bq25703_set_min_vsys(struct bq257xx_chg *pdata, int vsys)
 			    reg);
 }
 
+/**
+ * bq25792_set_min_vsys() - Set the minimum system voltage
+ * @pdata: driver platform data
+ * @vsys: voltage value to set in uV
+ *
+ * Set the minimum system voltage by clamping the requested value
+ * between device limits and writing to the appropriate register.
+ *
+ * Return: Returns 0 on success or error on failure to write.
+ */
+static int bq25792_set_min_vsys(struct bq257xx_chg *pdata, int vsys)
+{
+	unsigned int reg;
+	int vsys_min = pdata->vsys_min;
+
+	vsys = clamp(vsys, vsys_min, BQ25792_MINVSYS_MAX_UV);
+	reg = ((vsys - BQ25792_MINVSYS_MIN_UV) / BQ25792_MINVSYS_STEP_UV);
+	reg = FIELD_PREP(BQ25792_REG00_VSYSMIN_MASK, reg);
+
+	return regmap_write(pdata->bq->regmap,
+			    BQ25792_REG00_MIN_SYS_VOLTAGE, reg);
+}
+
 /**
  * bq25703_get_cur() - Get the reported current from the battery
  * @pdata: driver platform data
@@ -186,6 +328,30 @@ static int bq25703_get_cur(struct bq257xx_chg *pdata, int *intval)
 	return ret;
 }
 
+/**
+ * bq25792_get_cur() - Get the reported current from the battery
+ * @pdata: driver platform data
+ * @intval: pointer to store the battery current value
+ *
+ * Read the current ADC value from the device representing the battery
+ * charge or discharge current and return it in microamps.
+ *
+ * Return: Returns 0 on success or error on failure to read.
+ */
+static int bq25792_get_cur(struct bq257xx_chg *pdata, int *intval)
+{
+	u16 reg;
+	int ret;
+
+	ret = bq25792_read16(pdata, BQ25792_REG33_IBAT_ADC, &reg);
+	if (ret < 0)
+		return ret;
+
+	*intval = (s16)reg * BQ25792_ADCIBAT_STEP_UA;
+
+	return ret;
+}
+
 /**
  * bq25703_get_ichg_cur() - Get the maximum reported charge current
  * @pdata: driver platform data
@@ -209,6 +375,30 @@ static int bq25703_get_ichg_cur(struct bq257xx_chg *pdata, int *intval)
 	return ret;
 }
 
+/**
+ * bq25792_get_ichg_cur() - Get the maximum reported charge current
+ * @pdata: driver platform data
+ * @intval: pointer to store the maximum charge current value
+ *
+ * Read the programmed maximum charge current limit from the device.
+ *
+ * Return: Returns 0 on success or error on failure to read value.
+ */
+static int bq25792_get_ichg_cur(struct bq257xx_chg *pdata, int *intval)
+{
+	u16 reg;
+	int ret;
+
+	ret = bq25792_read16(pdata, BQ25792_REG03_CHARGE_CURRENT_LIMIT, &reg);
+	if (ret)
+		return ret;
+
+	*intval = FIELD_GET(BQ25792_REG03_ICHG_MASK, reg) *
+		  BQ25792_ICHG_STEP_UA;
+
+	return ret;
+}
+
 /**
  * bq25703_set_ichg_cur() - Set the maximum charge current
  * @pdata: driver platform data
@@ -233,6 +423,28 @@ static int bq25703_set_ichg_cur(struct bq257xx_chg *pdata, int ichg)
 			    reg);
 }
 
+/**
+ * bq25792_set_ichg_cur() - Set the maximum charge current
+ * @pdata: driver platform data
+ * @ichg: current value to set in uA
+ *
+ * Set the maximum charge current by clamping the requested value
+ * between device limits and writing to the appropriate register.
+ *
+ * Return: Returns 0 on success or error on failure to write.
+ */
+static int bq25792_set_ichg_cur(struct bq257xx_chg *pdata, int ichg)
+{
+	int ichg_max = pdata->ichg_max;
+	u16 reg;
+
+	ichg = clamp(ichg, BQ25792_ICHG_MIN_UA, ichg_max);
+	reg = FIELD_PREP(BQ25792_REG03_ICHG_MASK,
+			 (ichg / BQ25792_ICHG_STEP_UA));
+
+	return bq25792_write16(pdata, BQ25792_REG03_CHARGE_CURRENT_LIMIT, reg);
+}
+
 /**
  * bq25703_get_chrg_volt() - Get the maximum set charge voltage
  * @pdata: driver platform data
@@ -256,6 +468,30 @@ static int bq25703_get_chrg_volt(struct bq257xx_chg *pdata, int *intval)
 	return ret;
 }
 
+/**
+ * bq25792_get_chrg_volt() - Get the maximum set charge voltage
+ * @pdata: driver platform data
+ * @intval: pointer to store the maximum charge voltage value
+ *
+ * Read the current charge voltage limit from the device.
+ *
+ * Return: Returns 0 on success or error on failure to read value.
+ */
+static int bq25792_get_chrg_volt(struct bq257xx_chg *pdata, int *intval)
+{
+	u16 reg;
+	int ret;
+
+	ret = bq25792_read16(pdata, BQ25792_REG01_CHARGE_VOLTAGE_LIMIT, &reg);
+	if (ret)
+		return ret;
+
+	*intval = FIELD_GET(BQ25792_REG01_VREG_MASK, reg) *
+		  BQ25792_VBATREG_STEP_UV;
+
+	return ret;
+}
+
 /**
  * bq25703_set_chrg_volt() - Set the maximum charge voltage
  * @pdata: driver platform data
@@ -282,6 +518,29 @@ static int bq25703_set_chrg_volt(struct bq257xx_chg *pdata, int vbat)
 			    reg);
 }
 
+/**
+ * bq25792_set_chrg_volt() - Set the maximum charge voltage
+ * @pdata: driver platform data
+ * @vbat: voltage value to set in uV
+ *
+ * Set the maximum charge voltage by clamping the requested value
+ * between device limits and writing to the appropriate register.
+ *
+ * Return: Returns 0 on success or error on failure to write.
+ */
+static int bq25792_set_chrg_volt(struct bq257xx_chg *pdata, int vbat)
+{
+	int vbat_max = pdata->vbat_max;
+	u16 reg;
+
+	vbat = clamp(vbat, BQ25792_VBATREG_MIN_UV, vbat_max);
+
+	reg = FIELD_PREP(BQ25792_REG01_VREG_MASK,
+			 (vbat / BQ25792_VBATREG_STEP_UV));
+
+	return bq25792_write16(pdata, BQ25792_REG01_CHARGE_VOLTAGE_LIMIT, reg);
+}
+
 /**
  * bq25703_get_iindpm() - Get the maximum set input current
  * @pdata: driver platform data
@@ -310,6 +569,30 @@ static int bq25703_get_iindpm(struct bq257xx_chg *pdata, int *intval)
 	return ret;
 }
 
+/**
+ * bq25792_get_iindpm() - Get the maximum set input current
+ * @pdata: driver platform data
+ * @intval: pointer to store the maximum input current value
+ *
+ * Read the current input current limit from the device.
+ *
+ * Return: Returns 0 on success or error on failure to read value.
+ */
+static int bq25792_get_iindpm(struct bq257xx_chg *pdata, int *intval)
+{
+	u16 reg;
+	int ret;
+
+	ret = bq25792_read16(pdata, BQ25792_REG06_INPUT_CURRENT_LIMIT, &reg);
+	if (ret)
+		return ret;
+
+	reg = FIELD_GET(BQ25792_REG06_IINDPM_MASK, reg);
+	*intval = reg * BQ25792_IINDPM_STEP_UA;
+
+	return ret;
+}
+
 /**
  * bq25703_set_iindpm() - Set the maximum input current
  * @pdata: driver platform data
@@ -335,6 +618,29 @@ static int bq25703_set_iindpm(struct bq257xx_chg *pdata, int iindpm)
 			    FIELD_PREP(BQ25703_IINDPM_MASK, reg));
 }
 
+/**
+ * bq25792_set_iindpm() - Set the maximum input current
+ * @pdata: driver platform data
+ * @iindpm: current value in uA
+ *
+ * Set the maximum input current by clamping the requested value
+ * between device limits and writing to the appropriate register.
+ *
+ * Return: Returns 0 on success or error on failure to write.
+ */
+static int bq25792_set_iindpm(struct bq257xx_chg *pdata, int iindpm)
+{
+	u16 reg;
+	int iindpm_max = pdata->iindpm_max;
+
+	iindpm = clamp(iindpm, BQ25792_IINDPM_MIN_UA, iindpm_max);
+
+	reg = iindpm / BQ25792_IINDPM_STEP_UA;
+
+	return bq25792_write16(pdata, BQ25792_REG06_INPUT_CURRENT_LIMIT,
+			       FIELD_PREP(BQ25792_REG06_IINDPM_MASK, reg));
+}
+
 /**
  * bq25703_get_vbat() - Get the reported voltage from the battery
  * @pdata: driver platform data
@@ -359,6 +665,30 @@ static int bq25703_get_vbat(struct bq257xx_chg *pdata, int *intval)
 	return ret;
 }
 
+/**
+ * bq25792_get_vbat() - Get the reported voltage from the battery
+ * @pdata: driver platform data
+ * @intval: pointer to store the battery voltage value
+ *
+ * Read the current ADC value representing the battery voltage
+ * and return it in microvolts.
+ *
+ * Return: Returns 0 on success or error on failure to read value.
+ */
+static int bq25792_get_vbat(struct bq257xx_chg *pdata, int *intval)
+{
+	u16 reg;
+	int ret;
+
+	ret = bq25792_read16(pdata, BQ25792_REG3B_VBAT_ADC, &reg);
+	if (ret)
+		return ret;
+
+	*intval = reg * BQ25792_ADCVSYSVBAT_STEP_UV;
+
+	return ret;
+}
+
 /**
  * bq25703_hw_init() - Set all the required registers to init the charger
  * @pdata: driver platform data
@@ -425,6 +755,61 @@ static int bq25703_hw_init(struct bq257xx_chg *pdata)
 	return ret;
 }
 
+/**
+ * bq25792_hw_init() - Initialize BQ25792 hardware
+ * @pdata: driver platform data
+ *
+ * Initialize the BQ25792 by disabling the watchdog, enabling discharge
+ * current sensing with 5A limit, and configuring input current regulation.
+ * Set the charge current, charge voltage, minimum system voltage, and
+ * input current limit from platform data. Enable and configure the ADC
+ * to measure all available channels.
+ *
+ * Return: Returns 0 on success or error code on error.
+ */
+static int bq25792_hw_init(struct bq257xx_chg *pdata)
+{
+	struct regmap *regmap = pdata->bq->regmap;
+	int ret = 0;
+
+	/* Disable watchdog (TODO: make it work instead) */
+	regmap_write(regmap, BQ25792_REG10_CHARGER_CONTROL_1, 0);
+
+	/*
+	 * Enable battery discharge current sensing, 5A discharge current
+	 * limit, input current regulation
+	 */
+	regmap_write(regmap, BQ25792_REG14_CHARGER_CONTROL_5,
+		     BQ25792_REG14_EN_IBAT |
+		     BQ25792_IBAT_5A |
+		     BQ25792_REG14_EN_IINDPM);
+
+	ret = pdata->chip->bq257xx_set_ichg(pdata, pdata->ichg_max);
+	if (ret)
+		return ret;
+
+	ret = pdata->chip->bq257xx_set_vbatreg(pdata, pdata->vbat_max);
+	if (ret)
+		return ret;
+
+	ret = bq25792_set_min_vsys(pdata, pdata->vsys_min);
+	if (ret)
+		return ret;
+
+	ret = pdata->chip->bq257xx_set_iindpm(pdata, pdata->iindpm_max);
+	if (ret)
+		return ret;
+
+	/* Enable the ADC. */
+	regmap_write(regmap, BQ25792_REG2E_ADC_CONTROL, BQ25792_REG2E_ADC_EN);
+
+	/* Clear per-channel ADC disable bits - enable all channels */
+	regmap_write(regmap, BQ25792_REG2F_ADC_FUNCTION_DISABLE_0, 0);
+	regmap_write(regmap, BQ25792_REG30_ADC_FUNCTION_DISABLE_1, 0);
+
+	return ret;
+}
+
 /**
  * bq25703_hw_shutdown() - Set registers for shutdown
  * @pdata: driver platform data
@@ -437,6 +822,30 @@ static void bq25703_hw_shutdown(struct bq257xx_chg *pdata)
 			   BQ25703_EN_LWPWR, BQ25703_EN_LWPWR);
 }
 
+/**
+ * bq25792_hw_shutdown() - Shutdown BQ25792 hardware
+ * @pdata: driver platform data
+ *
+ * Perform hardware shutdown for the BQ25792. Currently a no-op
+ * as the device does not require special shutdown configuration.
+ */
+static void bq25792_hw_shutdown(struct bq257xx_chg *pdata)
+{
+	/* Nothing to do here */
+}
+
+/**
+ * bq257xx_set_charger_property() - Set a power supply property
+ * @psy: power supply device
+ * @prop: power supply property to set
+ * @val: value to set for the property
+ *
+ * Handle requests to set power supply properties such as input current
+ * limit, constant charge voltage, and constant charge current. Routes
+ * the request to the chip-specific implementation.
+ *
+ * Return: Returns 0 on success or -EINVAL if property is not supported.
+ */
 static int bq257xx_set_charger_property(struct power_supply *psy,
 		enum power_supply_property prop,
 		const union power_supply_propval *val)
@@ -460,6 +869,19 @@ static int bq257xx_set_charger_property(struct power_supply *psy,
 	return -EINVAL;
 }
 
+/**
+ * bq257xx_get_charger_property() - Get a power supply property
+ * @psy: power supply device
+ * @psp: power supply property to get
+ * @val: pointer to store the property value
+ *
+ * Handle requests to get power supply properties, including status,
+ * health, manufacturer, online state, and various voltage/current
+ * measurements. Reads current device state and routes chip-specific
+ * property requests to appropriate handlers.
+ *
+ * Return: Returns 0 on success or -EINVAL if property is not supported.
+ */
 static int bq257xx_get_charger_property(struct power_supply *psy,
 				enum power_supply_property psp,
 				union power_supply_propval *val)
@@ -541,6 +963,17 @@ static enum power_supply_property bq257xx_power_supply_props[] = {
 	POWER_SUPPLY_PROP_USB_TYPE,
 };
 
+/**
+ * bq257xx_property_is_writeable() - Check if a property is writeable
+ * @psy: power supply device
+ * @prop: power supply property to check
+ *
+ * Determines which power supply properties can be written to. Only
+ * charge current limit, charge voltage limit, and input current
+ * limit are writeable.
+ *
+ * Return: Returns 1 if property is writeable, 0 otherwise.
+ */
 static int bq257xx_property_is_writeable(struct power_supply *psy,
 					 enum power_supply_property prop)
 {
@@ -613,6 +1046,17 @@ static void bq257xx_external_power_changed(struct power_supply *psy)
 	power_supply_changed(psy);
 }
 
+/**
+ * bq257xx_irq_handler_thread() - Handle charger interrupt
+ * @irq: interrupt number
+ * @private: pointer to driver private data
+ *
+ * Thread handler for charger interrupts. Triggers re-evaluation of
+ * external power status and updates power supply state in response
+ * to charger events.
+ *
+ * Return: Returns IRQ_HANDLED if interrupt was processed.
+ */
 static irqreturn_t bq257xx_irq_handler_thread(int irq, void *private)
 {
 	struct bq257xx_chg *pdata = private;
@@ -653,6 +1097,22 @@ static const struct bq257xx_chip_info bq25703_chip_info = {
 		.bq257xx_get_min_vsys = &bq25703_get_min_vsys,
 };
 
+static const struct bq257xx_chip_info bq25792_chip_info = {
+		.default_iindpm_uA = BQ25792_IINDPM_DEFAULT_UA,
+		.bq257xx_hw_init = &bq25792_hw_init,
+		.bq257xx_hw_shutdown = &bq25792_hw_shutdown,
+		.bq257xx_get_state = &bq25792_get_state,
+		.bq257xx_get_ichg = &bq25792_get_ichg_cur,
+		.bq257xx_set_ichg = &bq25792_set_ichg_cur,
+		.bq257xx_get_vbatreg = &bq25792_get_chrg_volt,
+		.bq257xx_set_vbatreg = &bq25792_set_chrg_volt,
+		.bq257xx_get_iindpm = &bq25792_get_iindpm,
+		.bq257xx_set_iindpm = &bq25792_set_iindpm,
+		.bq257xx_get_cur = &bq25792_get_cur,
+		.bq257xx_get_vbat = &bq25792_get_vbat,
+		.bq257xx_get_min_vsys = &bq25792_get_min_vsys,
+};
+
 /**
  * bq257xx_parse_dt() - Parse the device tree for required properties
  * @pdata: driver platform data
@@ -698,10 +1158,22 @@ static int bq257xx_parse_dt(struct bq257xx_chg *pdata,
 	return 0;
 }
 
+/**
+ * bq257xx_charger_probe() - Probe routine for charger platform device
+ * @pdev: platform device
+ *
+ * Probe the charger device, allocate driver data structure, select the
+ * appropriate chip-specific function pointers, register the power supply,
+ * parse device tree properties for battery limits, initialize hardware,
+ * and set up the interrupt handler if available.
+ *
+ * Return: Returns 0 on success or error code on failure.
+ */
 static int bq257xx_charger_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct bq257xx_device *bq = dev_get_drvdata(pdev->dev.parent);
+	struct bq257xx_plat *plat = dev_get_platdata(dev);
 	struct bq257xx_chg *pdata;
 	struct power_supply_config psy_cfg = { };
 	int ret;
@@ -713,7 +1185,17 @@ static int bq257xx_charger_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	pdata->bq = bq;
-	pdata->chip = &bq25703_chip_info;
+
+	switch (plat->type) {
+	case BQ25703A:
+		pdata->chip = &bq25703_chip_info;
+		break;
+	case BQ25792:
+		pdata->chip = &bq25792_chip_info;
+		break;
+	default:
+		return dev_err_probe(dev, -EINVAL, "Unknown chip type\n");
+	}
 
 	platform_set_drvdata(pdev, pdata);
 
@@ -751,6 +1233,13 @@ static int bq257xx_charger_probe(struct platform_device *pdev)
 	return ret;
 }
 
+/**
+ * bq257xx_charger_shutdown() - Shutdown routine for charger platform device
+ * @pdev: platform device
+ *
+ * Called during system shutdown to perform charger cleanup, including
+ * disabling watchdog timers or other chip-specific shutdown procedures.
+ */
 static void bq257xx_charger_shutdown(struct platform_device *pdev)
 {
 	struct bq257xx_chg *pdata = platform_get_drvdata(pdev);
diff --git a/include/linux/mfd/bq257xx.h b/include/linux/mfd/bq257xx.h
index b2e38a4a4738..0d568e8b1835 100644
--- a/include/linux/mfd/bq257xx.h
+++ b/include/linux/mfd/bq257xx.h
@@ -353,12 +353,10 @@
 #define BQ25792_REG20_VAC2_OVP_STAT		BIT(1)
 #define BQ25792_REG20_VAC1_OVP_STAT		BIT(0)
 
-#define BQ25792_REG20_OVERVOLTAGE_MASK		(BQ25792_REG20_VBUS_OVP_STAT | \
-						 BQ25792_REG20_VBAT_OVP_STAT | \
+#define BQ25792_REG20_OVERVOLTAGE_MASK		(BQ25792_REG20_VBAT_OVP_STAT | \
 						 BQ25792_REG20_VAC2_OVP_STAT | \
 						 BQ25792_REG20_VAC1_OVP_STAT)
-#define BQ25792_REG20_OVERCURRENT_MASK		(BQ25792_REG20_IBUS_OCP_STAT | \
-						 BQ25792_REG20_IBAT_OCP_STAT | \
+#define BQ25792_REG20_OVERCURRENT_MASK		(BQ25792_REG20_IBAT_OCP_STAT | \
 						 BQ25792_REG20_CONV_OCP_STAT)
 
 /* FAULT Status 1 */

-- 
2.52.0


