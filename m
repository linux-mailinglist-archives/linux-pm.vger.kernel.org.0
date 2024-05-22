Return-Path: <linux-pm+bounces-8059-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A36A68CC94B
	for <lists+linux-pm@lfdr.de>; Thu, 23 May 2024 01:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58DA2282B37
	for <lists+linux-pm@lfdr.de>; Wed, 22 May 2024 23:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF75A1487DF;
	Wed, 22 May 2024 23:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nl+MTlwd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7727979950;
	Wed, 22 May 2024 23:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716418900; cv=none; b=VTC91y8dH1YiDKmC9+tlWCXQvXh/2/pXobUHpLxeqKkmjFTgJaTmydYrWAwm9Y/cHGOQ2hlp5/I6WaM26pQaeeo9JxRNTSxu/VkvTYtL7GslWngJ2caV665w5at0uDRlYFtifHqNFJEdqwNh0TB7c0CCc0lvX56Hu6YkZ/Tx1HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716418900; c=relaxed/simple;
	bh=LbN79ILVGJmypIKRIiXwODJW0beN4emgcWPm/0DnbDE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kZCwiiMt4fkUlFOSxr72dxI82xUjFMpz3pb5Iyx0p2oJNcQMQd+Yryl7SwDOVbrPUFaClLd03ga9ObMfvANFFI+VOhOzK814LjZhEV8xSiHjvkKx5zvnSuXnRXl9nTmG+YjbqkxCMQlLIvJXbSRg13CRFwrunz9hJSVahfMjUQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nl+MTlwd; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-23d477a1a4fso3664397fac.3;
        Wed, 22 May 2024 16:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716418898; x=1717023698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVMsWZbFnMr/zKM0R1fwfE/XyN3eszTblppaMZhLZMo=;
        b=nl+MTlwdX6Z9jixt1kPLDZrMP2+SAm+EfbXqRoFxl6WTehAzJd32NWTfDdIxZvOB1I
         OM8PmP8+dULvaJtT4xi1YMg1itg8Gj/iHU+Z6UtXE7qQQdd5LakQPb3vWtPhTxna2EcJ
         ezi+rJnZKAIsZ8HMmGpk93Aw86WEQ1758N64KyhHYPYN6fqOJCnUu2DUwNxXQLogjGBr
         dESqljyWGrYlS9LRr0NjH7IpMJL6k5zR5iNRfKk3tljdOjJamCC6EZ5H4fI9a2+o0PF6
         fs58xv9aTSRRjFpqs4kNhkvxFtq8OLwLZCdxOmAQOBY6v7rmKkBAeALQg4Ld5AR0SpYk
         KwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716418898; x=1717023698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bVMsWZbFnMr/zKM0R1fwfE/XyN3eszTblppaMZhLZMo=;
        b=Z9WNR9bXcgK14XHbKHMkasOBVjiX/ZOiSG3YRBfRJZot2xYWXjbxtU2+MPttIzbncm
         RueHkBzpJLkrMzfeQqMP+syzVeDYTJmdulghGstxMjN862XbXMqTgm/X/BpY/tKhX2VY
         tU+Iqn+ZSNGLwNtq4T4NuMtfDg1ZusSx/xVhmLvO/secbDkSB2N2hCm1b0iPVDZQ9MQr
         mUl1quU+gV3djJSYhjkixv48XclHopN0K7NO8uReJgxBw80fjxge1BLoZ8k5voCCJbfT
         gqMK/aldlEzSBKIVnzw3wCS2oJoWmKVfPgU0EZ8KRCm/f6sEXcsRLuocdNKFAYsIVwQb
         /J0A==
X-Forwarded-Encrypted: i=1; AJvYcCWWZZ6uaaTluvWj2IwuqTtk6eqGjKhe+2MxInxermGaVo5HrghHXvQW7/7Aj8veqHLzWDYsYDYzxUtK6DGXjAlKPXWZdV+0DOA=
X-Gm-Message-State: AOJu0YzCCE1s0UbG5/gZO1X8T6WsOK3skuPrrmUvtOShDwcWgv6DplJI
	xXYqTZldth5349VEgeFXG2kvQJkEpKgNT51Rac1Sf2KhVFpb36gq
X-Google-Smtp-Source: AGHT+IEvLg7qLqqYzfccRkThfADAtQ4+ws5h+ipFvfeIxvlW/iwTGPjNP3BA5CsYjGoLnrPJfjrHFw==
X-Received: by 2002:a05:6870:e2cd:b0:245:3678:16d2 with SMTP id 586e51a60fabf-24c68aae036mr4869305fac.22.1716418898427;
        Wed, 22 May 2024 16:01:38 -0700 (PDT)
Received: from localhost.localdomain ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f0ff995ccdsm4155936a34.34.2024.05.22.16.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 16:01:38 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-sunxi@lists.linux.dev
Cc: devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	broonie@kernel.org,
	lgirdwood@gmail.com,
	lee@kernel.org,
	samuel@sholland.org,
	jernej.skrabec@gmail.com,
	wens@csie.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	sre@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 1/4] mfd: axp20x: AXP717: Correct MODULE_ENABLE_CONTROL register name
Date: Wed, 22 May 2024 18:01:29 -0500
Message-Id: <20240522230132.364915-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522230132.364915-1-macroalpha82@gmail.com>
References: <20240522230132.364915-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

The datasheet lists two "MODULE_ENABLE_CONTROL" registers; the first
one is at register 0x0b and the second is at 0x19. Change the name
of the register at 0x19 to AXP717_MODULE_ENABLE_CONTROL_2 to reflect
this.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/mfd/axp20x.c                 | 2 +-
 drivers/regulator/axp20x-regulator.c | 2 +-
 include/linux/mfd/axp20x.h           | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 609e7e149681..16950c3206d7 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -209,7 +209,7 @@ static const struct regmap_access_table axp313a_volatile_table = {
 };
 
 static const struct regmap_range axp717_writeable_ranges[] = {
-	regmap_reg_range(AXP717_MODULE_EN_CONTROL, AXP717_MODULE_EN_CONTROL),
+	regmap_reg_range(AXP717_MODULE_EN_CONTROL_2, AXP717_MODULE_EN_CONTROL_2),
 	regmap_reg_range(AXP717_BOOST_CONTROL, AXP717_BOOST_CONTROL),
 	regmap_reg_range(AXP717_IRQ0_EN, AXP717_IRQ4_EN),
 	regmap_reg_range(AXP717_IRQ0_STATE, AXP717_IRQ4_STATE),
diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 20bef3971fec..a8e91d9d028b 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -837,7 +837,7 @@ static const struct regulator_desc axp717_regulators[] = {
 		 AXP717_LDO1_OUTPUT_CONTROL, BIT(4)),
 	AXP_DESC(AXP717, BOOST, "boost", "vin1", 4550, 5510, 64,
 		 AXP717_BOOST_CONTROL, AXP717_BOOST_V_OUT_MASK,
-		 AXP717_MODULE_EN_CONTROL, BIT(4)),
+		 AXP717_MODULE_EN_CONTROL_2, BIT(4)),
 };
 
 /* DCDC ranges shared with AXP813 */
diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
index 5e86b976c4ca..e0cd66bd3b6d 100644
--- a/include/linux/mfd/axp20x.h
+++ b/include/linux/mfd/axp20x.h
@@ -115,7 +115,7 @@ enum axp20x_variants {
 #define AXP313A_IRQ_STATE		0x21
 
 #define AXP717_ON_INDICATE		0x00
-#define AXP717_MODULE_EN_CONTROL	0x19
+#define AXP717_MODULE_EN_CONTROL_2	0x19
 #define AXP717_BOOST_CONTROL		0x1e
 #define AXP717_IRQ0_EN			0x40
 #define AXP717_IRQ1_EN			0x41
-- 
2.34.1


