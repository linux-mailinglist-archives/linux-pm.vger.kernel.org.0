Return-Path: <linux-pm+bounces-21194-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AFCA2459F
	for <lists+linux-pm@lfdr.de>; Sat,  1 Feb 2025 00:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E3507A23D0
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jan 2025 23:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F061B86E9;
	Fri, 31 Jan 2025 23:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2Y4yrEh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6591AF4EA;
	Fri, 31 Jan 2025 23:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738365444; cv=none; b=kr31paMrEtEhMjugZEavwJmT5EJ87pedLzcLhHJ4iYp5TOeU7b+ofL5qOs3DjuQqQyySKAYcP3CXE8Re4kJyJU6PnqPQEA5txUya2oHF0oZbXg/fCPybX2QUGuXpic+mNpq6RI7HC8liko3ZfHH16NuwuJIN4mqKvwcxQRxlTGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738365444; c=relaxed/simple;
	bh=gHMiTOPVRMWnLkIZqILMO8HdLfSWIvKnxHa3x9lGjsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=man9xj/GonTU2Un/yg/oQEUHl8W2/WkRgfIVlobs4ahFbHrxQtfXooz/tXZWM82qYWuuLGpJV0eC00Pyn1lEzfuPMCq2+7ZBnu9Fja7ROj4pL63FI1Jl5KwhsoAH7FO8Knz9sz4UUMG39NFo0dKuWNaxqpLdMNjxHu4A7AT3wSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2Y4yrEh; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-71e15717a2dso1345410a34.3;
        Fri, 31 Jan 2025 15:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738365441; x=1738970241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=afgQizDC60JMpdo9r7FEtCBrD/nRn7NdVuy+nRLagYA=;
        b=K2Y4yrEh+kKpsX/8BWOyqB7LriNY1CNtVg9w5+o3pUkk8Uu0pQ+Z1tKSyqcIlePQov
         BgH8rd/oKJihic5FWANTit/jkiOysGAKQWmvO1qoWaVb5PdbFBYYd9X4qYHQyYewV0zf
         ODBdFR0BnquL8O6Fj3HdMcBdnvyYi3sExNzPQK5tECJJC8n75KLiTH64YaEoqxtSUOYj
         Zqr+5yVyxIGRa8EiPRzXcMV0vDRRX4c+FUII5zDDhbh6WwxuetJXX2xPibBxh8MFjBPt
         FZTj+AjfcWDBXup+lao5SejYdoHlvr6XQtNLy/jVBDkPc3bsjvTM7rThe/crVrsLPyJS
         /JLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738365441; x=1738970241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=afgQizDC60JMpdo9r7FEtCBrD/nRn7NdVuy+nRLagYA=;
        b=noYhmonMy/F7841NwBs28UfUEv1xws3v1Fr5AcluTDp47lH/DW3VrwauputMz5KsbX
         r+hUAPQbm8CnvSkfBQ0JIcFSndQULamtNc3lsw+CbGLjMllji/dj2w5RLFNn+iWE48ho
         /9FgFHNOD9z4RWOhiSes9rDrdbzvxasbiK5whspzxOI/hN+JGHCdLOXGjPXfOOZnlQmZ
         QmtpNDrfL18L4pGwfEVmBNFRy1lpQhGaZ7za5Cj9p92D8LMPXF8lVGFa66H6X064fCUO
         yrX+/lAgqzRJWwt3RyI90bIadZrQBtHbhZ7CVg4dfxzt/2peFQ5NgPc6Pz+7OfgC6PwB
         ll/g==
X-Forwarded-Encrypted: i=1; AJvYcCVaD4hs14CVtQ1eZARu6/iJ0pVBVWKmBnhlPUPwejRo6CHtkpi5p8eUlI5knkqOO4Zm93Dm/232+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKpoGwaxb5lMsMmrhIhWX05AXnSmFbm95679pcbrqKpvfB7+AF
	XG4NCNBXJY+ws94HdytgLW/1YcH+yJ59PcuxBsD8hbTDRPaDmGl5
X-Gm-Gg: ASbGncuTxIjB1ohFFxd9GTB/Exi0dD0QGd7pqpu8q072D9+8eRKbyThvfIzlcofUobi
	DGsH2Em3lNAKyIilJjb/oG3ruiNkw7hwOSKTartysPp7kfmVvBVcbzkXTr7XY/uedcK+NSq/IOi
	uLH1i2+m1IxbIE0qvUI8LRfKYZmkGAvXSiTTJqClEyEIEPKUzqlm2fS+zuhrCCcfVdxSvCSVEDZ
	mhcH2G3zYeq9vM91aCk6EEB1zUlVUsnWMZ1eLbX997w3P9PRqIPV3gS141L2BuiIMYA6Kf+dtfR
	8hbLWtJWLmzEsxZiG8jRP3uJTbRSIpoh4VY=
X-Google-Smtp-Source: AGHT+IEEf97BL/zbgmnuNLvZSKUkJYvKdUkUca7v2YlKwxzUPi1kNoMYeklM9vj5h8C59YtQztWbhQ==
X-Received: by 2002:a05:6808:2010:b0:3e6:1513:4c04 with SMTP id 5614622812f47-3f323a5cb04mr9239783b6e.20.1738365441716;
        Fri, 31 Jan 2025 15:17:21 -0800 (PST)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf:d061:e6e5:c6da:b514])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f33365bf31sm1099128b6e.34.2025.01.31.15.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 15:17:21 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-sunxi@lists.linux.dev
Cc: devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	lee@kernel.org,
	samuel@sholland.org,
	jernej.skrabec@gmail.com,
	wens@csie.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	sre@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 1/5] power: supply: axp20x_battery: Fix fault handling for AXP717
Date: Fri, 31 Jan 2025 17:14:51 -0600
Message-ID: <20250131231455.153447-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250131231455.153447-1-macroalpha82@gmail.com>
References: <20250131231455.153447-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Correct the fault handling for the AXP717 by changing the i2c write
from regmap_update_bits() to regmap_write_bits(). The update bits
function does not work properly on a RW1C register where we must
write a 1 back to an existing register to clear it.

Additionally, as part of this testing I confirmed the behavior of
errors reappearing, so remove comment about assumptions.

Fixes: 6625767049c2 ("power: supply: axp20x_battery: add support for AXP717")
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/power/supply/axp20x_battery.c | 31 +++++++++++++--------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
index fa27195f074e..3c3158f31a48 100644
--- a/drivers/power/supply/axp20x_battery.c
+++ b/drivers/power/supply/axp20x_battery.c
@@ -466,10 +466,9 @@ static int axp717_battery_get_prop(struct power_supply *psy,
 
 	/*
 	 * If a fault is detected it must also be cleared; if the
-	 * condition persists it should reappear (This is an
-	 * assumption, it's actually not documented). A restart was
-	 * not sufficient to clear the bit in testing despite the
-	 * register listed as POR.
+	 * condition persists it should reappear. A restart was not
+	 * sufficient to clear the bit in testing despite the register
+	 * listed as POR.
 	 */
 	case POWER_SUPPLY_PROP_HEALTH:
 		ret = regmap_read(axp20x_batt->regmap, AXP717_PMU_FAULT,
@@ -480,26 +479,26 @@ static int axp717_battery_get_prop(struct power_supply *psy,
 		switch (reg & AXP717_BATT_PMU_FAULT_MASK) {
 		case AXP717_BATT_UVLO_2_5V:
 			val->intval = POWER_SUPPLY_HEALTH_DEAD;
-			regmap_update_bits(axp20x_batt->regmap,
-					   AXP717_PMU_FAULT,
-					   AXP717_BATT_UVLO_2_5V,
-					   AXP717_BATT_UVLO_2_5V);
+			regmap_write_bits(axp20x_batt->regmap,
+					  AXP717_PMU_FAULT,
+					  AXP717_BATT_UVLO_2_5V,
+					  AXP717_BATT_UVLO_2_5V);
 			return 0;
 
 		case AXP717_BATT_OVER_TEMP:
 			val->intval = POWER_SUPPLY_HEALTH_HOT;
-			regmap_update_bits(axp20x_batt->regmap,
-					   AXP717_PMU_FAULT,
-					   AXP717_BATT_OVER_TEMP,
-					   AXP717_BATT_OVER_TEMP);
+			regmap_write_bits(axp20x_batt->regmap,
+					  AXP717_PMU_FAULT,
+					  AXP717_BATT_OVER_TEMP,
+					  AXP717_BATT_OVER_TEMP);
 			return 0;
 
 		case AXP717_BATT_UNDER_TEMP:
 			val->intval = POWER_SUPPLY_HEALTH_COLD;
-			regmap_update_bits(axp20x_batt->regmap,
-					   AXP717_PMU_FAULT,
-					   AXP717_BATT_UNDER_TEMP,
-					   AXP717_BATT_UNDER_TEMP);
+			regmap_write_bits(axp20x_batt->regmap,
+					  AXP717_PMU_FAULT,
+					  AXP717_BATT_UNDER_TEMP,
+					  AXP717_BATT_UNDER_TEMP);
 			return 0;
 
 		default:
-- 
2.43.0


