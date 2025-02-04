Return-Path: <linux-pm+bounces-21337-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 535D4A276AD
	for <lists+linux-pm@lfdr.de>; Tue,  4 Feb 2025 17:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1463164265
	for <lists+linux-pm@lfdr.de>; Tue,  4 Feb 2025 16:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73F5215198;
	Tue,  4 Feb 2025 16:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVBfhA+s"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABCB21517D;
	Tue,  4 Feb 2025 16:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738684863; cv=none; b=NVAqY7RuXaMTCQRAzGrLEnDnvAZZ8SZO2lOk+jMwPNyXwm2DanUri3zB3EUzTwGtjUW7F6/1+CEwxmfJM1KQi0s7/C7WJw1P4VbLGVtUpaVFJP5ArUeUM/Ei2jTsCiQVZCd+QbFLmVjI/jDT6q5CV6kCZ5N5aM1DYFIG/k0SWE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738684863; c=relaxed/simple;
	bh=gHtHSfNR3XwHSs8fl5jUsqaUzIZ9r16vjKwIdtE7nig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cPvsD9Qxu62X0t81Semk6dCegqjk/xj5lhG4VR50WQotp9djxMOrkq6ETTg3OrvBMI+xu/nVqHikDh+3lGWV3siGpyWXxTVbq8dw3eOZsqSbYJxstTpvpPFef6Jj9oETyL6sc8grNnyF4Xx9fk6d0gbg82q1s4Lc4SV73XTaiwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EVBfhA+s; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3eba5848ee4so1444440b6e.3;
        Tue, 04 Feb 2025 08:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738684861; x=1739289661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ivl6HogrA7oXfSru2BLUm6InkAsQKXYHbfgBQ8l+uUo=;
        b=EVBfhA+sdS8ai0UVB338omDtPDsut2lzLzeCD04oHeeTJ9LOv0b+RHTS9wSwLxo+Tg
         iDcVZxCau0MEkTlsNl3bVPYBJW1nC3i68ENLSG/iUZaGhK4m5g5rSNDL3HvfUKRkVnbo
         WbtVCoZMfa3dE/InnwlXL7JAr8eRiWcYt/YhsThNQm3x9WE8yD/1dcPUz4YlqJnjudaB
         CRXVB4qA3U/gJ/Ds3TgomhB3ILclWtTEgLq7PBp8Bt03Xw/QvYBorXAxITNuzDUg8K3s
         aDXmva+CYf0i/9P2uonXLnygybqnmEmCBTYbptO+DmSRlIk8PYJK+ulclLnDnbJJVkb+
         l+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738684861; x=1739289661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ivl6HogrA7oXfSru2BLUm6InkAsQKXYHbfgBQ8l+uUo=;
        b=wL4nFHTqQIdHjwp1SXYKqzl1iP3sLcqHwQ9nCYHr8T9g9SmXHI6cuzA3znkUwSXCNt
         rgL24XrGqfWBc0/hxuD3EQ3yvOk+jTlqgHNK0SVOMOMCKMs9kM8FrbpYcML1ZUYazenK
         oqrVmkB/hYidlTLnuq0/7AFmziIlcaDtg/WLPBZa4ziROj/jRf4MaOzvV7qt9yidaLGJ
         Wf6i1dl4saO7YIN1kVgg6ALF7YQcllwEn5pP//2rUjUrxy7SmV4Z1vCa1ubiRh66nbhB
         K6lyVKNNqf2YCW0MNmppAySiCq8j10WxIkKKXrPxqeo7YlSBH1j/PSOIlLkzq6FQfblR
         cP5w==
X-Forwarded-Encrypted: i=1; AJvYcCWTMkkDu56TK9xPO6jTDR5VoZb+yyP14Zo1dGiSGDQpeEZsjXCbAfUciFCQ8SEGInxfDqVga+kSZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJnu6RfXkDh5//56wUfNVMSRgivpLOfdC5eyUDlgM710Wch7gM
	qcm/yBaQar+0XsyIsZ4Ye4pX8pEaI5BJAxX5b9wFuz8UloCWpudsbWJumA==
X-Gm-Gg: ASbGncv6DUJv1z+I68kozPmeI00AsPvkfVS71eCtpAILCU53RgoSW3kcg3Q0sQBD8PJ
	ttDCBznIPV7Cjzy12uHcwHo5vu6pdGbdOwgYoJusv79tPZBZK+BYUnYzwpAByMCoGdH+UlMS1le
	o0BrWPGNHdUcLtu2ATEm+m/8tfmTfNIcar28OiK4SVQAq3Ivzz3t/7sHZPzYSXspZovdAcENquP
	Fo53CJ3kIuKwSGbW4jNm06Z0JBUbN/O0TB9pPAjtxGQy3ybpZ0G7ATyV8spJwKvMDs6XiZ/vy9B
	8dX0I6uTBvAWQXkSIT8IrQy0aZMvOrbH89E=
X-Google-Smtp-Source: AGHT+IHy0B2vYqgAr9PIDLfyic3sok55FBROOwkHMKSQuiGSE7DGkWQzewjBscPIUMOj2/aA2OWPdw==
X-Received: by 2002:a05:6808:2f07:b0:3ea:6149:d6fd with SMTP id 5614622812f47-3f323a14825mr20694508b6e.2.1738684860768;
        Tue, 04 Feb 2025 08:01:00 -0800 (PST)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf:f8ca:b029:fcc5:5836])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f33365be86sm3039570b6e.31.2025.02.04.08.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 08:01:00 -0800 (PST)
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
Subject: [PATCH V2 2/4] mfd: axp20x: AXP717: Add AXP717_TS_PIN_CFG to writeable  regs
Date: Tue,  4 Feb 2025 09:58:32 -0600
Message-ID: <20250204155835.161973-3-macroalpha82@gmail.com>
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

Add AXP717_TS_PIN_CFG (register 0x50) to the table of writeable
registers so that the temperature sensor can be configured by the
battery driver.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/mfd/axp20x.c       | 1 +
 include/linux/mfd/axp20x.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index cff56deba24f..e9914e8a29a3 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -224,6 +224,7 @@ static const struct regmap_range axp717_writeable_ranges[] = {
 	regmap_reg_range(AXP717_VSYS_V_POWEROFF, AXP717_VSYS_V_POWEROFF),
 	regmap_reg_range(AXP717_IRQ0_EN, AXP717_IRQ4_EN),
 	regmap_reg_range(AXP717_IRQ0_STATE, AXP717_IRQ4_STATE),
+	regmap_reg_range(AXP717_TS_PIN_CFG, AXP717_TS_PIN_CFG),
 	regmap_reg_range(AXP717_ICC_CHG_SET, AXP717_CV_CHG_SET),
 	regmap_reg_range(AXP717_DCDC_OUTPUT_CONTROL, AXP717_CPUSLDO_CONTROL),
 	regmap_reg_range(AXP717_ADC_CH_EN_CONTROL, AXP717_ADC_CH_EN_CONTROL),
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


