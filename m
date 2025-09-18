Return-Path: <linux-pm+bounces-34986-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E85B86291
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 19:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 965717E2AD9
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 17:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8B931A7E8;
	Thu, 18 Sep 2025 17:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="caGcVahm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67182319606
	for <linux-pm@vger.kernel.org>; Thu, 18 Sep 2025 17:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758215222; cv=none; b=GrbhKIOe/eXzIgs7tRs3HIaHcR5tDddWJgEqxcpzYA3GJAYod1uhAtgYtVNgAhUQo9D6HpShaTaWfWLANMyokd6j9dGHKHMpacCt8Z6siHbIOHENr6FvI9rGdTDtawvM2d8VwvxIOJvDsS4xzzf6UGijwilC6COq0/tzZEh5gAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758215222; c=relaxed/simple;
	bh=tlZW2B/voUhQGw4c+vxZjRtNn5NJaMUoI/L38vxG2ac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cvNKEbKk9GD7nNNQX1yPUBknp6oSHvnkAutJyqbg9QqL4YR81vRornJNgYdsY/tz8j/gq/lUK70uG5inFmRN4iaS7kBo0Ys9sA8ZTZLCqlWvp0gjL/ByZJ3wY8YHiMXJ8JvphozT7WL2CI6CcFzYeJBDWUmJfakO9T+nFMni1TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=caGcVahm; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b0411b83aafso189637466b.1
        for <linux-pm@vger.kernel.org>; Thu, 18 Sep 2025 10:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758215219; x=1758820019; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iXhHiAQ9NOSOJzNF711OarjiP/VLzvoqXrEe2ztdQB0=;
        b=caGcVahmOublmejxgqJiV7OsE89vw4efSn7MhblaUIgLV8GiVOBTZtUBhBActdNdv3
         7uNZUJbvP1V6t4oK+P8ClKOo6BpxLB/O3RnrJ85ro4iGN5Yl0+ytZceU+sDLNtStUa66
         QQ5N5zY5z10ZNBibQWX2+I8ay349zuE+1HtlotBjj+qQ0bHE9uX29Ghz4a7bIxGRF6pD
         zHGp33SEGpgiw8s3b1fC1i9ObLS9xFBN/YUNxkZAM3UdJevsJiU59Cvxj566AixuY5i8
         2r9iknVEhtPzJNNJ+fW0d2Yy2xFQ/BfyqTiBp45NcznJ/5jh0TzWU44yCIqv3mjDzJiO
         +r0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758215219; x=1758820019;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iXhHiAQ9NOSOJzNF711OarjiP/VLzvoqXrEe2ztdQB0=;
        b=hO5EV/ArMTlg9LDxs1yY0McM+10CxF657eDTy2cCqHPHAb/ilQKULovuaQFPsNyYmM
         1IWqjymbFbYBgkEkJm8fyWZ2fM56pqviy++pev4HUQL723xtoJsVl5NQOJswJ+fs3Yhd
         Uli1mMufzxQdj3crgG50J0ifmuaoPKQGtcrhM9SBuLOLSKxf84A9AtNmpVrvHWUvK8fY
         062d0FIqh5xCJUYb1J+i4fhiG6Rj76yve7UsF0CTpamnWVXSZ+gsDmnFDHM16LWS2Myp
         xjJ+jVVxkJIefhKtlXdvUPC3nbtK71R0lNECmEgSqmH4m4FctqNpKYj7VBdCephynNaV
         vN0w==
X-Forwarded-Encrypted: i=1; AJvYcCVW41h/6ZqzjyOlKTx5SmxjJt8hkCLEVMY3CKEnF48FZPY7ur4WFKVBpHh97UPIJD+ZCpnGQdNq6g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWO7qZ0NGWgom4SzUVhVrd6nj0jp97xEeq6FDGNfi4BFeOPz3N
	w1lHoOM3fyV0NP5H5NVQmsa7hT2Eoq1Hawo9BvFSvYQ11MYlNIzVn9Z8
X-Gm-Gg: ASbGnctr1Leyi9M+YH2yeBEH27qSPdr+RMDBjB1IvUFwg5GOf43969BvabyCqO9ObMF
	86Demj5d2UmDxlgS0iY3pSNYwZ0lTW2D5dkXCmRHgfv/dY21tNiwAqRYEgAsrzX1OFzwbPGGwW0
	hrZym6RmmyiDaCs646aY8CvZtXlVPyCC8cqdD2U9Mnis63K4E2xxilWDbCSaMkAmYoKdjKjPquF
	CkekCGu3vRo6V9Zaqg02vFcoZXYF1lwBSMg5JaDLyAJk2OsfqPSFxBL/mzdG338t/NTyrJZQ0F6
	xNTfzFyvnx5azWq+JcrmBBLHUDQCAP38okAdOcUTG3nKftwYp0ns7U2WOdDQ+3kde4g/mMbXI3N
	erwMT0bOpge+DBmevqxaaStZHmNI4rRSJPS3F38g=
X-Google-Smtp-Source: AGHT+IEkSREupr8I8wGDjc+n3QX/mxxViqwmPzAR/4zg2V5deiPg/FgrUVtbfIwH2hoHluertLZuqQ==
X-Received: by 2002:a17:907:dac:b0:af9:414d:9c2 with SMTP id a640c23a62f3a-b1baf60b810mr776506366b.3.1758215218559;
        Thu, 18 Sep 2025 10:06:58 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.240.27])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b1fd271f895sm225845366b.97.2025.09.18.10.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 10:06:58 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 18 Sep 2025 20:06:52 +0300
Subject: [PATCH v4 8/9] power: supply: max77705_charger: use
 REGMAP_IRQ_REG_LINE macro
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-max77705_77976_charger_improvement-v4-8-11ec9188f489@gmail.com>
References: <20250918-max77705_77976_charger_improvement-v4-0-11ec9188f489@gmail.com>
In-Reply-To: <20250918-max77705_77976_charger_improvement-v4-0-11ec9188f489@gmail.com>
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758215207; l=3504;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=tlZW2B/voUhQGw4c+vxZjRtNn5NJaMUoI/L38vxG2ac=;
 b=+Gg83ESg6SDRCrcIlLzLQiyXT2ShbXP8kQln9pygdmDQKF4XryODTSj1nJNRVzv/Hxft/SyMB
 ez0tdREGk0ZA3NdnC56HFyKBPKEvEuluMjhXyLpbn5dGeJ5qllBMLiF
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Refactor regmap_irq declarations with REGMAP_IRQ_REG_LINE saves a few
lines on definitions.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 drivers/power/supply/max77705_charger.c | 16 ++++++-------
 include/linux/power/max77705_charger.h  | 42 +++++++++++++--------------------
 2 files changed, 24 insertions(+), 34 deletions(-)

diff --git a/drivers/power/supply/max77705_charger.c b/drivers/power/supply/max77705_charger.c
index 5c8e46627cb0..8032dfa0c9a2 100644
--- a/drivers/power/supply/max77705_charger.c
+++ b/drivers/power/supply/max77705_charger.c
@@ -50,14 +50,14 @@ static irqreturn_t max77705_chgin_irq(int irq, void *irq_drv_data)
 }
 
 static const struct regmap_irq max77705_charger_irqs[] = {
-	{ .mask = MAX77705_BYP_IM,   },
-	{ .mask = MAX77705_INP_LIMIT_IM,   },
-	{ .mask = MAX77705_BATP_IM,   },
-	{ .mask = MAX77705_BAT_IM,   },
-	{ .mask = MAX77705_CHG_IM,   },
-	{ .mask = MAX77705_WCIN_IM,   },
-	{ .mask = MAX77705_CHGIN_IM,   },
-	{ .mask = MAX77705_AICL_IM,   },
+	REGMAP_IRQ_REG_LINE(MAX77705_BYP_I, BITS_PER_BYTE),
+	REGMAP_IRQ_REG_LINE(MAX77705_INP_LIMIT_I, BITS_PER_BYTE),
+	REGMAP_IRQ_REG_LINE(MAX77705_BATP_I, BITS_PER_BYTE),
+	REGMAP_IRQ_REG_LINE(MAX77705_BAT_I, BITS_PER_BYTE),
+	REGMAP_IRQ_REG_LINE(MAX77705_CHG_I, BITS_PER_BYTE),
+	REGMAP_IRQ_REG_LINE(MAX77705_WCIN_I, BITS_PER_BYTE),
+	REGMAP_IRQ_REG_LINE(MAX77705_CHGIN_I, BITS_PER_BYTE),
+	REGMAP_IRQ_REG_LINE(MAX77705_AICL_I, BITS_PER_BYTE),
 };
 
 static struct regmap_irq_chip max77705_charger_irq_chip = {
diff --git a/include/linux/power/max77705_charger.h b/include/linux/power/max77705_charger.h
index a612795577b6..6653abfdf747 100644
--- a/include/linux/power/max77705_charger.h
+++ b/include/linux/power/max77705_charger.h
@@ -12,34 +12,24 @@
 #include <linux/regmap.h>
 
 /* MAX77705_CHG_REG_CHG_INT */
-#define MAX77705_BYP_I		BIT(0)
-#define MAX77705_INP_LIMIT_I	BIT(1)
-#define MAX77705_BATP_I		BIT(2)
-#define MAX77705_BAT_I		BIT(3)
-#define MAX77705_CHG_I		BIT(4)
-#define MAX77705_WCIN_I		BIT(5)
-#define MAX77705_CHGIN_I	BIT(6)
-#define MAX77705_AICL_I		BIT(7)
-
-/* MAX77705_CHG_REG_CHG_INT_MASK */
-#define MAX77705_BYP_IM		BIT(0)
-#define MAX77705_INP_LIMIT_IM	BIT(1)
-#define MAX77705_BATP_IM	BIT(2)
-#define MAX77705_BAT_IM		BIT(3)
-#define MAX77705_CHG_IM		BIT(4)
-#define MAX77705_WCIN_IM	BIT(5)
-#define MAX77705_CHGIN_IM	BIT(6)
-#define MAX77705_AICL_IM	BIT(7)
+#define MAX77705_BYP_I		(0)
+#define MAX77705_INP_LIMIT_I	(1)
+#define MAX77705_BATP_I		(2)
+#define MAX77705_BAT_I		(3)
+#define MAX77705_CHG_I		(4)
+#define MAX77705_WCIN_I		(5)
+#define MAX77705_CHGIN_I	(6)
+#define MAX77705_AICL_I		(7)
 
 /* MAX77705_CHG_REG_CHG_INT_OK */
-#define MAX77705_BYP_OK		BIT(0)
-#define MAX77705_DISQBAT_OK	BIT(1)
-#define MAX77705_BATP_OK	BIT(2)
-#define MAX77705_BAT_OK		BIT(3)
-#define MAX77705_CHG_OK		BIT(4)
-#define MAX77705_WCIN_OK	BIT(5)
-#define MAX77705_CHGIN_OK	BIT(6)
-#define MAX77705_AICL_OK	BIT(7)
+#define MAX77705_BYP_OK		BIT(MAX77705_BYP_I)
+#define MAX77705_DISQBAT_OK	BIT(MAX77705_INP_LIMIT_I)
+#define MAX77705_BATP_OK	BIT(MAX77705_BATP_I)
+#define MAX77705_BAT_OK		BIT(MAX77705_BAT_I)
+#define MAX77705_CHG_OK		BIT(MAX77705_CHG_I)
+#define MAX77705_WCIN_OK	BIT(MAX77705_WCIN_I)
+#define MAX77705_CHGIN_OK	BIT(MAX77705_CHGIN_I)
+#define MAX77705_AICL_OK	BIT(MAX77705_AICL_I)
 
 /* MAX77705_CHG_REG_DETAILS_00 */
 #define MAX77705_BATP_DTLS		BIT(0)

-- 
2.39.5


