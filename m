Return-Path: <linux-pm+bounces-17303-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 476E29C3923
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 08:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E55A61F21D62
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 07:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B5D158A1F;
	Mon, 11 Nov 2024 07:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="hTmxkere"
X-Original-To: linux-pm@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09F01552E7;
	Mon, 11 Nov 2024 07:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731311279; cv=none; b=jVJft9hUmC72ybk8044GcGI/ucmp0YDETSby6NxZ0F4bgihJEELT3jqpcsrNCowi1eE15iVSamlOioZM89QzP7Td6/CR3aTg8o30+ZnUH6Rryre0gtSLuJtXO579mftDDGclUrTZfhN9urfx8TsOBvLQRmMvAGYG9CZo6lZy+uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731311279; c=relaxed/simple;
	bh=sK0kWk+8VYxo38aU63eiYOmeLS96q4K2u2uUzpGH55g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pyu/QvZ0lKhJlKFjKyVNoJqz4F0e73uGXECO1ASABRyMmX+ZCeuWSVgfXKFVk+zC05Rkml36YvWWwcXcW2RPF00iaErka9xtcsUviylbxDh4UY7O8r37VOraifef9cfktXzF1c30QFHzidXdUDUaCo1kU7Oaht5ACSpDZ/JEs2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=hTmxkere; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id BA192A0331;
	Mon, 11 Nov 2024 08:47:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=270OS3AUGIEnFR7GA4rh
	i6oZuXf4WByJ/XiZ6z+upJg=; b=hTmxkerenaYvai+eNShRpNfr9sLGUF/Rhxyw
	SeJj8GiuK0I8IGosy9PrtF2Jwjkh5yf59cfFyjeRGQzipmRMmw5KEnuYOZ0gk+cx
	Tyr6ifJnIAxh8FAxuQs6fM2h/plo4hbA2ZeLJbHiak5bG96O3QUS1n6/SoaS9ew9
	fBHKozMt+ge9JlhvoBhO8FbNAie8IY7avfIosVF2URm7V48e+BdUgnTYReVTz5ik
	nGw/s7lXXC9i5C0TunydNUTPFjwhfKbuxRjtmNBjESfxicMDmRql8ogGwP5xhsBR
	WqbHes8GEYKb0zuWZI1thd5LglRQl/ozF5XmbKzvjDctEsCzzdnqd5nhBM/2W48Y
	orTxJZvnZER6Ej+avlOA7Bkr7Jv8ZVeXoVwEN4KWzinGGmUBgU2UM7UHJIwqxB9N
	bXifjkReTzLapXVSudMPcs8H8k5H4Hwg3c+V4zKZL4I2mlHSM6BizNygvJHSzYGi
	bl3/WF1zVnLaLR8wWHWaH9ZgNbN9RjkyWsabbcLfuDxo9+d7K77VLMaw30cQPgBN
	KEfRTvAefAETbymgIAKrAYf+sFLUbM7REQWhs28ZvE92t7B759TarlMHV5a/AktA
	hBH05J1XLumIluavQU7GeHTLDvxXYhNdjwqoHkUv9HNiuWK/5ySb8KbV+wL59pAc
	+5i/Y7Q=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: Samuel Holland <samuel@sholland.org>, Sebastian Reichel
	<sebastian.reichel@collabora.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>,
	Sebastian Reichel <sre@kernel.org>
Subject: [PATCH v4 2/7] power: ip5xxx_power: Fix return value on ADC read errors
Date: Mon, 11 Nov 2024 08:47:15 +0100
Message-ID: <20241111074720.1727163-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241111074720.1727163-1-csokas.bence@prolan.hu>
References: <20241111074720.1727163-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1731311267;VERSION=7980;MC=57183446;ID=287556;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D9485561716B

If ADC read returns an error, the return value was silently ignored,
execution continued and an uninitialized value and a return code of 0
was passed back to userspace. The only exception was
POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT, which bailed out correctly.
Fix returns for the other cases as well.

Fixes: 75853406fa27 ("power: supply: Add a driver for Injoinic power bank ICs")

Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
---
 drivers/power/supply/ip5xxx_power.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/power/supply/ip5xxx_power.c b/drivers/power/supply/ip5xxx_power.c
index 2d4435881a9e..41d91504eb32 100644
--- a/drivers/power/supply/ip5xxx_power.c
+++ b/drivers/power/supply/ip5xxx_power.c
@@ -395,18 +395,24 @@ static int ip5xxx_battery_get_property(struct power_supply *psy,
 
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
 		ret = ip5xxx_battery_read_adc(ip5xxx, &ip5xxx->regs.battery.adc.volt, &raw);
+		if (ret)
+			return ret;
 
 		val->intval = 2600000 + DIV_ROUND_CLOSEST(raw * 26855, 100);
 		return 0;
 
 	case POWER_SUPPLY_PROP_VOLTAGE_OCV:
 		ret = ip5xxx_battery_read_adc(ip5xxx, &ip5xxx->regs.battery.adc.open_volt, &raw);
+		if (ret)
+			return ret;
 
 		val->intval = 2600000 + DIV_ROUND_CLOSEST(raw * 26855, 100);
 		return 0;
 
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 		ret = ip5xxx_battery_read_adc(ip5xxx, &ip5xxx->regs.battery.adc.curr, &raw);
+		if (ret)
+			return ret;
 
 		val->intval = DIV_ROUND_CLOSEST(raw * 149197, 200);
 		return 0;
-- 
2.34.1



