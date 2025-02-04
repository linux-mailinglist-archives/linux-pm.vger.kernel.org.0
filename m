Return-Path: <linux-pm+bounces-21338-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6440DA276B2
	for <lists+linux-pm@lfdr.de>; Tue,  4 Feb 2025 17:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FB453A1EB7
	for <lists+linux-pm@lfdr.de>; Tue,  4 Feb 2025 16:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD312153C3;
	Tue,  4 Feb 2025 16:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKTH7g6S"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9020A21518C;
	Tue,  4 Feb 2025 16:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738684864; cv=none; b=mGCwsUMk6kNnHXmTw/w8u0ki0f47aCtw6AfhPKxbvGvNuzNr/ghKqOo+gYqYIHZ8Pb9325ew3MjcWNTa1hZ8GdbpHBT24H2DRxjhm6uTG3Z/kbEk844N6Ic+4H9vpVV9w09Ylf3TY9LIaMj2Wb/7BSr39Wu9CskacU+7RFOoyd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738684864; c=relaxed/simple;
	bh=KF1RI0pWVfFg5Lp0NhxhVbEfbY0U8P5jbD5u3v6nUfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aix/KQWlQNSxbyEZxAx3/jwJgC1PCw7g7el2rcWXkW4beGJScqpsSdC0G4B0qyTap0gtWzXReZuTklRRdp506c8YrjFnYN4jypS4vjQg6CID3WCwrpjgOPrF/pKFSTi8PIUIlVp6IeDlmKhv2MYb9aqdv/D5yD8m2Gt/M6xbyYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UKTH7g6S; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3eb98b3b63dso1523169b6e.1;
        Tue, 04 Feb 2025 08:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738684861; x=1739289661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EreKa/glmB4TstqqkbwQwKQ5lTDJJhw97SZDxkdhrLc=;
        b=UKTH7g6SRCn5/SLrF8QmJkOYcp72/nNsJ1ztuMwpI3zz1JUW3RyH3R3S9yOWZBhPQ2
         0yBkj+1CCGZ8BB4/z5Y5GYLxUKcoXbnzazHWmG+pJ1H4KC6jtjxzz6F2DywkwygnRAFE
         eAYY6CxAWjY5HRgmqbj/cBacaUBjE6/Gn56G1+f8E2S/a3hmfl4ASvshYv5vIC5gbpfm
         YyLGe7XhInJqvdIkY9LgIqptMCwcpixaNtfgPVy5xtb8m90l6T7XaNB7X74B35jdCIat
         H0b/+5JqnhH0KcrftjXgsHSr59N/t1BnLBa1fePB3EJoHHFveplH/yyFzgIDeXdbfLkU
         V8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738684861; x=1739289661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EreKa/glmB4TstqqkbwQwKQ5lTDJJhw97SZDxkdhrLc=;
        b=u+7KfB5KIddQn5VuAmsax1yOOdfEouRusEvquqAZmOzKH+MjPAN0hfN4UB9Qf9qjmM
         MHsTCRbknXLK3a9Bjx+JXZBVjCgtExpROpnQw7JcaifsI3Ipqq3BSd3CliwD4ymrjho4
         oUU3OnoDfuoHUcnsTCUJ3MQQD9DJnwILEZ4GaPVyGL5rNlQIw+7hs3439Sn1ki9f73DQ
         JsxDZG8WgdqIrqRR0CZr3p9j3ijMKwtH0hBU5gafgVeBCFF/b7/OPvZH3pYTyjnbeaXt
         Ly8MmfOKfT3CdLd6QBgrm1pzZBnwrBeDqdxiUy9XuO2pnLtcAGQb2ac8W0oKFxJP101U
         EUEA==
X-Forwarded-Encrypted: i=1; AJvYcCWy436pYszY1qsaWTlxztSRljU76W2KPVx8aHoc/DG52okOLYYnwFnuT/kw/9YtfKdtHxLkcuYOEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwyEo6/ZDmExvhy4bDlE7rMSHYq53aao+QPwuaghgzCipw2GZz+
	raI6WZbcXIInkRD/+jTWAusB3Jy4VPkK/E9AwCuPSpJpchETjDBT
X-Gm-Gg: ASbGncsPGUHIYitsKjOMS3Pu+bcxdKMNoXz2MhgOKDyEDqFJVqtD6GXIj1rR2w8JySU
	QkyhRRsJblbfLmwNKN5Zof0KRTQprn2yvL9TBLmOE4vfu7oQkMRKdzuPj1YObyc7K1sFg6j0czI
	4kPfXqdsXKYKm9po6+8T/S90Xwve+Ybd1QRP3DhsFbHEqdDYPx3YkceyqbPPxAK9sdLq34e/RYo
	ZSofKx9N/jqVQsCjEsQP+xfIuScjRgyFQxrzg9YK148LcfhbeeYJVZwdFqy9cdFF1TZ0cIO/vbJ
	4rwt3CfM9b3RkLD04IHDPA4RrOQwGOOuk/M=
X-Google-Smtp-Source: AGHT+IGeGnwNAQQbAZ7tdK5UNnD+KvjhU24dSFYNW9jKpCCzvwyJZPwS0UtSP1LLuECg7rLx0xGjMA==
X-Received: by 2002:a05:6808:3c8a:b0:3eb:512e:24e5 with SMTP id 5614622812f47-3f3237fc128mr18821605b6e.0.1738684861490;
        Tue, 04 Feb 2025 08:01:01 -0800 (PST)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf:f8ca:b029:fcc5:5836])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f33365be86sm3039570b6e.31.2025.02.04.08.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 08:01:01 -0800 (PST)
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
Subject: [PATCH V2 3/4] power: supply: axp20x_battery: Update temp sensor for  AXP717 from device tree
Date: Tue,  4 Feb 2025 09:58:33 -0600
Message-ID: <20250204155835.161973-4-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250204155835.161973-1-macroalpha82@gmail.com>
References: <20250204155835.161973-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Allow a boolean property of "x-powers,no-thermistor" to specify devices
where the ts pin is not connected to anything. This works around an
issue found with some devices where the efuse is not programmed
correctly from the factory or when the register gets set erroneously.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/power/supply/axp20x_battery.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
index 3c3158f31a48..f4cf129a0b68 100644
--- a/drivers/power/supply/axp20x_battery.c
+++ b/drivers/power/supply/axp20x_battery.c
@@ -89,6 +89,8 @@
 #define AXP717_BAT_CC_MIN_UA		0
 #define AXP717_BAT_CC_MAX_UA		3008000
 
+#define AXP717_TS_PIN_DISABLE		BIT(4)
+
 struct axp20x_batt_ps;
 
 struct axp_data {
@@ -117,6 +119,7 @@ struct axp20x_batt_ps {
 	/* Maximum constant charge current */
 	unsigned int max_ccc;
 	const struct axp_data	*data;
+	bool ts_disable;
 };
 
 static int axp20x_battery_get_max_voltage(struct axp20x_batt_ps *axp20x_batt,
@@ -984,6 +987,24 @@ static void axp717_set_battery_info(struct platform_device *pdev,
 	int ccc = info->constant_charge_current_max_ua;
 	int val;
 
+	axp_batt->ts_disable = (device_property_read_bool(axp_batt->dev,
+							  "x-powers,no-thermistor"));
+
+	/*
+	 * Under rare conditions an incorrectly programmed efuse for
+	 * the temp sensor on the PMIC may trigger a fault condition.
+	 * Allow users to hard-code if the ts pin is not used to work
+	 * around this problem. Note that this requires the battery
+	 * be correctly defined in the device tree with a monitored
+	 * battery node.
+	 */
+	if (axp_batt->ts_disable) {
+		regmap_update_bits(axp_batt->regmap,
+				   AXP717_TS_PIN_CFG,
+				   AXP717_TS_PIN_DISABLE,
+				   AXP717_TS_PIN_DISABLE);
+	}
+
 	if (vmin > 0 && axp717_set_voltage_min_design(axp_batt, vmin))
 		dev_err(&pdev->dev,
 			"couldn't set voltage_min_design\n");
-- 
2.43.0


