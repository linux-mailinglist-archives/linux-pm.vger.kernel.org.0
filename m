Return-Path: <linux-pm+bounces-15793-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A189A123A
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 21:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 456D5284773
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 19:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB0B197521;
	Wed, 16 Oct 2024 19:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="o5YAmND+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6063618C32C;
	Wed, 16 Oct 2024 19:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729105444; cv=none; b=OOYlSjjhlQQHFjKHZJ+Da1/Ms8cAMED00wsv27mJG4EgfFwdUX5RSU31Ojk0t/0BISMlo5tV0b8/znYHNmkqGcdLS8HxJpgRexWxT4tq7J7fxYK529+i4tcS4SlNMouvFS+QgPCozvLh/mMJI3pt/9PBgg103Vj+eauRPJiIpZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729105444; c=relaxed/simple;
	bh=/74NNXODGmu8ufxQH40ap2ecmtDk4kAjNZoCH931Ing=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rJRyFDnxGKAa3MEg2AcaUW0XqrcVYA3AY42vSW7QGprFopyWrzZzzolCwPTlepOguCmaFsilT2Jlr+pWNKPUcck61XaqXUpoZY5qO/ihbu+0hXehwwEfDjEHlMfx5sHbAK4MZDYQ+XO7Ljcr6epojpF+vr2N+38THEGyurEFqo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=o5YAmND+; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.1.130] (51B6DD9D.dsl.pool.telekom.hu [81.182.221.157])
	by mail.mainlining.org (Postfix) with ESMTPSA id 3365EE4593;
	Wed, 16 Oct 2024 18:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1729104850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g5hHxZIvJPe5a0dvjg8DVu3+r55DcwrKjSAeKs0qEkA=;
	b=o5YAmND+ngZMYKh2PMQYJd6LhOMMHgJsws91B7KLnnxd20gedbEvg5JvqHTMbjwdhX5QXD
	M0CN0s1nxohKluqW2h7kuP/HaZlURDT48xNon2NLJqRe4FaJwE80a7HFIXdzMN9HTE9JeI
	k5Ecbcc/HtZExwJUHq0Ket0RgQJn1krHyrBp4OgmdMxA9yYXRP9C8dI1ywThjxjFytxtIM
	DAmfOn+ggu7jziFuwi44wOvUEtHJi4HztVIcV6lQKHe8g1Z3oWUIyB1gbXlmIvA1WOmACo
	2LljYFdOtfgSrZ14iZdkQFeIDOK+IiMOCbVbjkh0OzIjdQM+CmvwlFz12j/I2w==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Wed, 16 Oct 2024 20:54:05 +0200
Subject: [PATCH v2] power: supply: bq27xxx: Fix registers of bq27426
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241016-fix_bq27426-v2-1-aa6c0f51a9f6@mainlining.org>
X-B4-Tracking: v=1; b=H4sIAMwLEGcC/22MzQoCIRRGX2W46wy9yDi16j1iCP9yLpSWhhSD7
 57NuuX5Ps5ZofhMvsBxWCH7SoVS7IC7AeyiY/CMXGdAjpIfuGJXel/ME5XEkXHH0RjUdhISuvH
 Ivt9b7Tx3Xqi8Uv5s8Sp+6/9OFUww45ycrFR81O501xRvFCmGfcoB5tbaF5zJ9wWrAAAA
X-Change-ID: 20240907-fix_bq27426-0d02bb2ac814
To: =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729104850; l=2798;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=/74NNXODGmu8ufxQH40ap2ecmtDk4kAjNZoCH931Ing=;
 b=BU+Gocp0O/44OGKVTEJlScwaGLeJMdJr97LtB0o0ifE4LEe+7THccUDv1nZ2kVTEbkm4uN+85
 8FiRTEoHyYcAOW4Tb0k5VnS374zypZbayegCJoIm50MKMTFHqGT1DUu
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

Correct bq27426 registers, according to technical reference manual
it does not have Design Capacity register so it is not register
compatible with bq27421.

Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
Changes in v2:
- Fix commit message.
- Link to v1: https://lore.kernel.org/r/20240907-fix_bq27426-v1-1-bdd48c4706ad@mainlining.org
---
 drivers/power/supply/bq27xxx_battery.c | 37 ++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index e47556ec3cfeadd6ce014559d90807b293d781d5..40c5ac7a111886d56f7c7bfe0a0ab2a4838830aa 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -449,9 +449,29 @@ static u8
 		[BQ27XXX_REG_AP] = 0x18,
 		BQ27XXX_DM_REG_ROWS,
 	},
+	bq27426_regs[BQ27XXX_REG_MAX] = {
+		[BQ27XXX_REG_CTRL] = 0x00,
+		[BQ27XXX_REG_TEMP] = 0x02,
+		[BQ27XXX_REG_INT_TEMP] = 0x1e,
+		[BQ27XXX_REG_VOLT] = 0x04,
+		[BQ27XXX_REG_AI] = 0x10,
+		[BQ27XXX_REG_FLAGS] = 0x06,
+		[BQ27XXX_REG_TTE] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_TTF] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_TTES] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_NAC] = 0x08,
+		[BQ27XXX_REG_RC] = 0x0c,
+		[BQ27XXX_REG_FCC] = 0x0e,
+		[BQ27XXX_REG_CYCT] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_AE] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_SOC] = 0x1c,
+		[BQ27XXX_REG_DCAP] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_AP] = 0x18,
+		BQ27XXX_DM_REG_ROWS,
+	},
 #define bq27411_regs bq27421_regs
 #define bq27425_regs bq27421_regs
-#define bq27426_regs bq27421_regs
 #define bq27441_regs bq27421_regs
 #define bq27621_regs bq27421_regs
 	bq27z561_regs[BQ27XXX_REG_MAX] = {
@@ -769,10 +789,23 @@ static enum power_supply_property bq27421_props[] = {
 };
 #define bq27411_props bq27421_props
 #define bq27425_props bq27421_props
-#define bq27426_props bq27421_props
 #define bq27441_props bq27421_props
 #define bq27621_props bq27421_props
 
+static enum power_supply_property bq27426_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
+	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_CHARGE_FULL,
+	POWER_SUPPLY_PROP_CHARGE_NOW,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+};
+
 static enum power_supply_property bq27z561_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_PRESENT,

---
base-commit: 15e7d45e786a62a211dd0098fee7c57f84f8c681
change-id: 20240907-fix_bq27426-0d02bb2ac814

Best regards,
-- 
Barnabás Czémán <barnabas.czeman@mainlining.org>


