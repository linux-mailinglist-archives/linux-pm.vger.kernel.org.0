Return-Path: <linux-pm+bounces-21197-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB5EA2459E
	for <lists+linux-pm@lfdr.de>; Sat,  1 Feb 2025 00:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 126153A684B
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jan 2025 23:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E941F4272;
	Fri, 31 Jan 2025 23:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgxU0J4n"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D994E7081F;
	Fri, 31 Jan 2025 23:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738365446; cv=none; b=u481fiUJ6lof9ftSVWwBrpiIHDpeNXjjET9ibK99YuH/xO1XHwjDYTYs3Z5q6n6a9OOBYAWm0YZsTY7gQZA6fzvuMpjApe2UVNDLRJGBQ64pLopqBOtNQ5WTUNTxJSpiF8xILUKH4JeKl4sTlWTsJpG5ki/uLbnlh0yNqwQn+XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738365446; c=relaxed/simple;
	bh=E/t/k6EfGTIeDC7lGiOVWu6BC0LxkfF4ArWRMg5BOrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rRE+aqLEWFyIG4INj4aLuL2L7BSU5siRgFzfsrtj740xMf5bjfOrFDcldzArAdQDqG5S1VJZWCtv46vjhiJaqFzz0ERagOwsRlaGT7uBMocsrMlPG4/Dx/+3uMw4wguGKLYpnMJoWqOSjCjQNbfwT+c+oGyvn/fw9THGfMkr73M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TgxU0J4n; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-71e15717a2dso1345435a34.3;
        Fri, 31 Jan 2025 15:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738365444; x=1738970244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z74CjKyGOGsBmIUznySLFrDCv0ADaabpNorixVGmQWw=;
        b=TgxU0J4nNpxvLqHJ0RKsfS3glaQ7JpTnuALkAWZXV5mRW9h/3sVPpJfYSI4O+cIFIk
         qPHU9wFPKoNfvOK9stfsXw28aOF4UkYYKHi7GMRxQa3uMXLy00dFbzq9GZX8vadbbGCw
         4QWfUte1b/dtYNpc3vBlF4fcBF/iiBa/iu0bY94DlIwPgXhXht6IptR7MOr3WaQgHPfg
         2pNFo0wvB6iBGTK9/py62yeKGycZYIPJG3/And4UjZXHhbTNP+VpwDB+hHI/gE8sJ3TL
         J+TL7QsON1usxCGbbdups9k2oDY2DMddPTm+hgiV3t3pDi6NQfk5SBVpEJEycvHm4paH
         Rz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738365444; x=1738970244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z74CjKyGOGsBmIUznySLFrDCv0ADaabpNorixVGmQWw=;
        b=LFL4QYFuo2Qg0xhGBgJanvYOVafEbVqtB1i6TDdWxDgHob8AOtVQHZiDA5ljDVruoI
         07XU3L60t5CZFB/MTaH77UegIFFao/G/YDHOh3ejfh5YMLA1a7p6IB5AIxyrIQyTC92/
         sfxkFQ0i98y5dMfOXRGcW6l7txGtuHMUx+a3wZm03s7iuZwFhbQ2PORkKkJXhfZCyMKF
         8UqpUrz3FI2PsuwgRyhDHChMDJVkOzJnL3aDRwkT32oRvia7MYA0qSTvUVarB8xWyHkv
         lRpxE9aabTmBtiBioZD489UHKxRlRvNtzUOv/JfLJvZm9nV64v6qQwOGvBqCk1MmhSoX
         HewA==
X-Forwarded-Encrypted: i=1; AJvYcCUcrCpWThG3p3UIRkhT2Zw+GeswWP6zoEYdoGAwoc0LMhFRkmWTc5HoS4efPwNC6Mg9SDQExZdnSA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxxNSjVH3J08W1miyvl3dtJVVke3AJq8ioTtbBNgCuutGPipGlM
	UTjV6Zs5ATSJhjD9iLDNvwmWNa9nTAgHTMt+g3Ra1e3QTA7fvSt+
X-Gm-Gg: ASbGncvJHuhLA/cNkYKEJS02iKOUPx9dG0KAldyQGEHnk+i7eBHSHRJA8Y6fSLy73Jw
	t4XMHh304In0C/RvyEzVRtegIZywyy8dWT/UfpmmlIbjD7RYDs8pBgASdFkBGqBV3DKXxS+p86k
	yCTLdy9Xnb7HaxSU0GqRW0WqxYZaJs3KHCK8flXevRt9KlyeEQPl5LrMXjabBvd/3L/9WHpHwZt
	BqUq3t7iozYLpbNEb/MFUP03DXq4Des2qVDnLPjXsOzXTeBkkcPJC/AOcMtiH4/fbNTWLGwnSM8
	J9QHBOO+VRprvfhqejgve5ioS7k0GrQ9G9k=
X-Google-Smtp-Source: AGHT+IGhsSOs3k11DfQOkk9ydz9xjmi+WCq+e89tyN+zDtdBn0uZu/QVaP4CDdiW4iSwL+L6Q1sR7g==
X-Received: by 2002:a05:6808:2015:b0:3eb:74ed:5a32 with SMTP id 5614622812f47-3f323a63fd6mr8828111b6e.22.1738365443945;
        Fri, 31 Jan 2025 15:17:23 -0800 (PST)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf:d061:e6e5:c6da:b514])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f33365bf31sm1099128b6e.34.2025.01.31.15.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 15:17:23 -0800 (PST)
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
Subject: [PATCH 4/5] power: supply: axp20x_battery: Update temp sensor for AXP717 from device tree
Date: Fri, 31 Jan 2025 17:14:54 -0600
Message-ID: <20250131231455.153447-5-macroalpha82@gmail.com>
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

Allow a boolean property of "x-powers,no-thermistor" to specify devices
where the ts pin is not connected to anything. This works around an
issue found with some devices where the efuse is not programmed
correctly from the factory or when the register gets set erroneously.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/power/supply/axp20x_battery.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
index 3c3158f31a48..345a1bbe50ad 100644
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
@@ -984,6 +987,22 @@ static void axp717_set_battery_info(struct platform_device *pdev,
 	int ccc = info->constant_charge_current_max_ua;
 	int val;
 
+	axp_batt->ts_disable = (device_property_read_bool(axp_batt->dev,
+							  "x-powers,no-thermistor"));
+
+	/*
+	 * Under rare conditions an incorrectly programmed efuse for
+	 * the temp sensor on the PMIC may trigger a fault condition.
+	 * Allow users to hard-code if the ts pin is not used to work
+	 * around this problem.
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


