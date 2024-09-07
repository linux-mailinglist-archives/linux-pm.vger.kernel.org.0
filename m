Return-Path: <linux-pm+bounces-13822-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E11970169
	for <lists+linux-pm@lfdr.de>; Sat,  7 Sep 2024 11:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3C1F1C20F33
	for <lists+linux-pm@lfdr.de>; Sat,  7 Sep 2024 09:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D211537A2;
	Sat,  7 Sep 2024 09:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6YIgLKi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B241B85DC;
	Sat,  7 Sep 2024 09:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725701845; cv=none; b=GF4GcF7XWVeg1UjE72JfD1GczC0P79E/jIcOQAgfALMLWhyLcJ4dUvkEMB5ChHVfnaDfYQScd6SyuWrpfqSE75VVgN11OLy79A/4oUpbyN/x/tp/SiAkNV1MxTxosK+oMR5hHb9P1jp/LAwOFShyB9rhmnLBgqWfeK6ZaKAqQEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725701845; c=relaxed/simple;
	bh=/HkWIIBaenmNDloYfSwD6k7mEiNUjJ/ZQFgBNyDIJ+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cwPww8efcGLYItXzPTjkV2Q+gyxOqGTk7qoi1Finbb2C9+7wvr4FbC6SSFHnu16lwHsRPIOwuoyJ5mzWZqRM/yVl79UlXN9yUkMSStDKQUm7CxMSNy9KDSXrSH3Al7X1WK5GaWaqjbe4JBRuZF80+Cp69yakBpk/VoZxYr/SphE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6YIgLKi; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42bb8c6e250so22974845e9.1;
        Sat, 07 Sep 2024 02:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725701842; x=1726306642; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3yNj1JZ7jvi4HdnGaQnEyGcyECRnyZY7b3G0EK+f3ZE=;
        b=Q6YIgLKi3wEToWlEQZYNd9FT56W8MuAX15c1fufkV/9fnlRbYfO0WXwkRHZmWJQmJa
         kSngjiOFh8H1a431D68HDYgXt1KfqpiEY+qo+TZLBvBYIRUDzB0bXCgeo2H971y5AEsZ
         jodN9c3G8ixYEh5LSFE2hva50U/XZybVa3Beabb/qhgZx0wGzw+oZsDDPqG38gG4rdMJ
         qg4eqs+/FRAjmBDZgmp+9R1Nhyrzz7a2RZL7tsXqy0pupDP6T7+U7yQnq6LRCKFZ5XOb
         GCMHB0FVD6BO/LpXijAfuAEJi3VdCSyyE2Z4zpSK+hKdg+BftmYArZojm9+6s/ek4Bf+
         5XOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725701842; x=1726306642;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3yNj1JZ7jvi4HdnGaQnEyGcyECRnyZY7b3G0EK+f3ZE=;
        b=ugII6O6BONraOW+ha2rhHePj3PLUM4a0daq9V0i/vSBZznjVJ8KSPlgViuidD6AzW0
         hd3Qw/KcoeQ2eRr+CprN98sayuWAeZ5UWPdIFNS/pwPKu2zyITxR/L7lfXavOkwD1BYS
         czeM9sZOSBS/soMnBa9kWCqAQBmhc3da3KpCDTeTOHWvjBejHi75KwTkYBCE+EHZ1m/S
         IEmc62naPBEmyHHmukl5YBEwI8KjSh+CLIs8zjL+WNKD3tnfjORmvbaROv49p9gCRq9m
         2hm0wCEl62XFrFPjwIoAu9hIEpt/BkEmNE2FKO+nZ14pts6G0JpytIuryVX7Fpbzy1US
         m6Mg==
X-Forwarded-Encrypted: i=1; AJvYcCUIGMmj0DwjspIqbU/92TI7YBPMtvXn2J5hLHRpBjUjbZXAJ4psmm3cUPf0hn/Mdi4/Ib6yYvqDt4SZiww=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdQVx8LjrtZbenON7fIzgdILCKoweAcB19bvqC4IoKhUSzkv64
	hD5uyQi4xbLSP9JI57WQuCDMFmOl+uFdlRFbxz217hfH7UkEC+qb
X-Google-Smtp-Source: AGHT+IEc/n1LBfCTATPX41pUOQ5veLzxFYjQq7SsrzYrM4A6P23u9IhRTbpdumJArJgRPAUgKiJWEw==
X-Received: by 2002:a05:600c:4715:b0:428:e866:3933 with SMTP id 5b1f17b1804b1-42c9f9d6629mr36612455e9.22.1725701842426;
        Sat, 07 Sep 2024 02:37:22 -0700 (PDT)
Received: from [192.168.1.130] (51B6DC2A.dsl.pool.telekom.hu. [81.182.220.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895665108sm986433f8f.28.2024.09.07.02.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 02:37:22 -0700 (PDT)
From: "=?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?=" <trabarni@gmail.com>
X-Google-Original-From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Sat, 07 Sep 2024 11:37:18 +0200
Subject: [PATCH] power: supply: bq27xxx: Fix registers of bq27426
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240907-fix_bq27426-v1-1-bdd48c4706ad@mainlining.org>
X-B4-Tracking: v=1; b=H4sIAM0e3GYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDSwNz3bTMivikQiNzEyMzXYMUA6OkJKPEZAtDEyWgjoKiVKA02LTo2Np
 aAD/COwddAAAA
To: =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725701841; l=2602;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=/HkWIIBaenmNDloYfSwD6k7mEiNUjJ/ZQFgBNyDIJ+w=;
 b=PC1BvbWo1ySey7QA9JEakM3Ht9MrAG4L0pjog3buxHlDfep03l/VNAD4NUOUXEop8ykTDcoO2
 gUNPV0BUeqYCvKUkODTYSYLVffyeu/mfwUmo02JOZka6N2CMV702vPE
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

Correct bq27426 registers, according to technical reference manual
it does not have Design Capacity register so it is not register
compatible with b27421.

Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 drivers/power/supply/bq27xxx_battery.c | 37 ++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 750fda543308..51fb88aca0f9 100644
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
base-commit: 9aaeb87ce1e966169a57f53a02ba05b30880ffb8
change-id: 20240907-fix_bq27426-0d02bb2ac814

Best regards,
-- 
Barnabás Czémán <barnabas.czeman@mainlining.org>


