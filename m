Return-Path: <linux-pm+bounces-21196-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A92A2459A
	for <lists+linux-pm@lfdr.de>; Sat,  1 Feb 2025 00:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E343B1889864
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jan 2025 23:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EFB1F3FFA;
	Fri, 31 Jan 2025 23:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNX7uDaD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E44E1B85D7;
	Fri, 31 Jan 2025 23:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738365445; cv=none; b=S/qOq8NPIV5HpH/fGrD00G+W6+Q028gG0b1jyOAK03QbVA4BfJ/nGFjpZYfGuSPDEjq9r9WHs94Usy0Pl6Y8ELZpd30egd0AilaToh0FM0i4G5B3SfGctO2oNTYFzWECiJHNFdsTHl+o97OKoOUsueezMeR/td5Z3Ej0lflyw/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738365445; c=relaxed/simple;
	bh=IEY9ErTuFfVaSJ9cLvDWiM8qfCPKp286AcHbTTYJngI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eUNVbhpRVu+bv5VuhTGknruYgulkPuk8owRdbg7szBmR4lIY/Oo1XDFcmW1AQZcu8H6435mIm7BSZuJueBRhKj4X2cowmIIkhR3xJ8cRQ7YSNg38z50SlWXrBztE5cr9OlNd4W1d7WJRDtdV4PfQ4rX5OdUgn9F9mbDnyCUEWsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNX7uDaD; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3eb880e5ac2so1448435b6e.2;
        Fri, 31 Jan 2025 15:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738365443; x=1738970243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b6RZRMBZ4GNAqGDERJs8E4i7kY25Yy4QpxNyKVAYuxs=;
        b=eNX7uDaDcDu1G10or/E3UGC5wkjzeN0gMF8buJM98qbi9xtfBDxrCHc0GwCa/Qxdov
         R34dPcjEiemSfTlMsui+U+B4+kQfnZDy+dXmMPVAc2LRuoNY3x/dIr+LoQuTWdmqNNDo
         I3w/N1cetAU2Oc0KoMW1pxhTKFlx+rJsKc+Zk2l2+KTYbnF6PAskk+aREAowW5Dr7aFP
         41Vlx82rRpXFagsGsONxK2WyvxPxTUZoxr5dxIg8aa0q3PUFGGPHFjUPMakFLMyUUuWD
         Xi0/ZFwwsszQoa9LKlNDJkaca+BVZi/5ltAsfChncPxtTJy6ENQ52evo2rg0b56zc5Jd
         Ju+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738365443; x=1738970243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b6RZRMBZ4GNAqGDERJs8E4i7kY25Yy4QpxNyKVAYuxs=;
        b=keSVwL0tOiGSGKbYSnz1e2Iqvr61TXbb4WQvxwsOBlkMaE5dZ6IKSFY0U0Hk7x5mnG
         0RDrZUXlBQJKWAlcCL1MiZ5oTAqqSZMRLM4+eDVpPLLa8sSEzbUW6g4V30pal+eyNl1A
         xFFu/JHR9IzrGUaOatrsk/cVZ7/bEn+dA5B8K2lFOc0p4AOlmjQDrRF85zf40uCMhWbB
         yi8BA/Wt5VtdwUkOBRqjhwf02jLBd7wsdrYVOQr3yAUBuD2qEiEczpuTnyEBbXzhFKlq
         8oLIV3M9gU8pgkKb7sly3o548bYpRthnw3ruRc0HQ+Ple73NDb8nM9OKR4NzenIhcwXi
         xbEA==
X-Forwarded-Encrypted: i=1; AJvYcCVFU8ZCuJfP5fCLahGc405DhuSf5n7A3gTB71SK53SikDZL8QDJEVkq4LCJSmFbfXBoxzTk1DQk6A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwavRLe5D/KmFsrYhersNtrPW9pgDyx2gJD22JcfLHulZpPWACM
	fPcXbYxtHMXQuFU88JsdJ2AClqq2AxooTeV3lMgW89ZZk2D/9dwO
X-Gm-Gg: ASbGncvN80HHyAxcUPCN619WjqJH4v35ZnbVkI2vszMwwq5TlwOse9vtXHrK5aply54
	JoRF1zIJ+8zqEIIRBE7wz7RXRBpp7vb6/98ENF58BhzqoRU0Ws7aUZ8UfnCNMeuevbyrAzuzc79
	uUHRB0z9hcnfX5evqMkzXvGjbdQ2+3cVZ+gKo7ErLw10E6GFf08hihx8jVNGPJgcUZY2oUb9rTc
	61S4oZVKCfCs6BDTk7K6f8E5xMarpp5syfd8gjWMulKDr1gRpwjwVLJU2FG3bzYIs28W9PeVlyV
	PEJrY4v/+hGQyCnrLaISpD2YMztF0lkxPo4=
X-Google-Smtp-Source: AGHT+IFDTbTeKnf7somAR/gbcEcKZyGG5BhbzPu0AxnisSfPlBNH3bQ3i0JKMOx/PEVM6WOznG5JOQ==
X-Received: by 2002:a05:6808:19a4:b0:3e6:580e:f12c with SMTP id 5614622812f47-3f323a3eb95mr9621238b6e.10.1738365443167;
        Fri, 31 Jan 2025 15:17:23 -0800 (PST)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf:d061:e6e5:c6da:b514])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f33365bf31sm1099128b6e.34.2025.01.31.15.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 15:17:22 -0800 (PST)
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
Subject: [PATCH 3/5] mfd: axp20x: AXP717: Add AXP717_TS_PIN_CFG to writeable regs
Date: Fri, 31 Jan 2025 17:14:53 -0600
Message-ID: <20250131231455.153447-4-macroalpha82@gmail.com>
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

Add AXP717_TS_PIN_CFG (register 0x50) to the table of writeable
registers so that the temperature sensor can be configured by the
battery driver.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/mfd/axp20x.c       | 2 +-
 include/linux/mfd/axp20x.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index cff56deba24f..baf51dea98b0 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -222,7 +222,7 @@ static const struct regmap_range axp717_writeable_ranges[] = {
 	regmap_reg_range(AXP717_PMU_FAULT, AXP717_MODULE_EN_CONTROL_1),
 	regmap_reg_range(AXP717_MIN_SYS_V_CONTROL, AXP717_BOOST_CONTROL),
 	regmap_reg_range(AXP717_VSYS_V_POWEROFF, AXP717_VSYS_V_POWEROFF),
-	regmap_reg_range(AXP717_IRQ0_EN, AXP717_IRQ4_EN),
+	regmap_reg_range(AXP717_IRQ0_EN, AXP717_TS_PIN_CFG),
 	regmap_reg_range(AXP717_IRQ0_STATE, AXP717_IRQ4_STATE),
 	regmap_reg_range(AXP717_ICC_CHG_SET, AXP717_CV_CHG_SET),
 	regmap_reg_range(AXP717_DCDC_OUTPUT_CONTROL, AXP717_CPUSLDO_CONTROL),
diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
index c3df0e615fbf..3c5aecf1d4b5 100644
--- a/include/linux/mfd/axp20x.h
+++ b/include/linux/mfd/axp20x.h
@@ -137,6 +137,7 @@ enum axp20x_variants {
 #define AXP717_IRQ2_STATE		0x4a
 #define AXP717_IRQ3_STATE		0x4b
 #define AXP717_IRQ4_STATE		0x4c
+#define AXP717_TS_PIN_CFG		0x50
 #define AXP717_ICC_CHG_SET		0x62
 #define AXP717_ITERM_CHG_SET		0x63
 #define AXP717_CV_CHG_SET		0x64
-- 
2.43.0


