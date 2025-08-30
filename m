Return-Path: <linux-pm+bounces-33478-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7058B3CF59
	for <lists+linux-pm@lfdr.de>; Sat, 30 Aug 2025 22:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07BDD1B27355
	for <lists+linux-pm@lfdr.de>; Sat, 30 Aug 2025 20:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB622E8DF4;
	Sat, 30 Aug 2025 20:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eb9DquqY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20B02E8B7C;
	Sat, 30 Aug 2025 20:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756586736; cv=none; b=rZV0cHB8in/Gp/dIHrxhnxTtYryue5HiXoe+oUgS9zbX/4K64NoknxvLbOwDOx9q7V42k6myQvWTRebT8WiKcq19ypXzPyKpHWQ1N54bHiFbU1/5VrS5ap0pHxybv3q/8RNYv1A3oEJ2UhF2qH7aaQ7qV7Xzf5k8MZw+M3RKaVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756586736; c=relaxed/simple;
	bh=pgFJbrzzXm2uXS0F6KuhyNyYP7mNCsrHTRwj+5OYY2c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hHbMRcXUTlmPVvz2GIo3ibeOhjO1sm3NeqiWQqyhiJKnalBDxtCxuiD4nL2ZT/LeEMTFwS8EX337onLL0rXmpq9Hfhr9aDgVbdzGjujUenlUQlUinbQCp12G7oPy7OrDQq64lve8QA4Hl136GoeeUShds8JBW5YSOSw1tBZVgLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eb9DquqY; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6188b5b113eso4149332a12.0;
        Sat, 30 Aug 2025 13:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756586733; x=1757191533; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BuYZl4hDocKxNtexpNOJSI/v2c3MTZcBnj9w0cInRaE=;
        b=eb9DquqY9sow0Rc45rEMH+Yjg7p/bcZO2DqY8NkJYfttlJL0kjH6k7rVqK9jsVG+dV
         ZaOXQnnEhc3mcn9aldIMuzB6xnntO4GvtuZnxcC9EXxngO5vLGPGKxyHrLmRv55q5A8V
         X1APEyqkNmnudg3ImPrYVbA0o7rMcIilTX1oNqMBIiXyM6F5fZ8l7dpTGN7csGWxM7M0
         gysicllHgr5J+V9/8pIK0KxDle5WJYewTTP6ZZ9NI/gDw4GZmtfHBmYumBnPJYoPhQxR
         kon3WAunOR4v9XfOity60yF3fWanmuzBZSWNDUcAkXeCY9u+AiGPvZUwz+mFU0jtN9Ap
         KjLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756586733; x=1757191533;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BuYZl4hDocKxNtexpNOJSI/v2c3MTZcBnj9w0cInRaE=;
        b=KUUOpWavMsvRIwYGFOTpNNwAG9NbYuDdo6Q4SKst8wUr1DhbBGQBiLAIdDtFO4evr8
         jxfprOrFbUnbfpLsCVCsq+pga5BiEe3Aau6tD4aw2L713i+/3jca2m369z5BkhLjDje0
         ssNXZXlnQ6JcKsMXTvmWxqlFYO0GWzILrHWFQwKcsnrd9jvaRyi0pGeJRH7UqQCPZPHB
         VeilAj/I4ihe/MdhoZv4S9EQdqxqtE7or0qusVxLtTaDbtif6RjkSwajA/IoTN6ck9da
         uwOsG//SMQlCeXSuMyTQ0Frc72BeNuHPGGR6YH1THe6wURxM7qCkYhW5cb6dQjihA6AP
         mP1A==
X-Forwarded-Encrypted: i=1; AJvYcCV+Gtfu/R35k0dveHDDkqQ9LVqe+5HpfOQqMc8zwodW8tqNyqAsUNkjt58cEG3biwMODcfvnw5SJKQ=@vger.kernel.org, AJvYcCXq+NwS3vrDM5Dr3Vpj3Dad/PkHiQFBUlQeQ4a5TZTibHYiuyO5qZYx4Nt7FgOlBLxkgw+Fsk+Jbj+x7tg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm1/qmeexVSByxYvpJ11Y5EyhEUsfxss1KQvRloyItncCeFPQr
	B82t+g9Avc+rLOS9Bxm64tV5YNIUIlUkjwFUNB5reHXdqpiOzn29ZzDG
X-Gm-Gg: ASbGncsfGQUygyPxjCm9HSAx+5r8QURH/Kuzg2qHboU+G2jhmAC9z2W0L7fIozYejR8
	vSTzc+AKX44CGh+S0398XydeILKCOTRX4C9zYW+yxqgrfFqMBRKuCi9o6jN0PBGaiS+qBbsBP3r
	vfltDcWRCgfj+9fSr4YU2Ol3XrBvSdstoIKzBKwl79+zSMKk8wms0x5j/hLefye/oVLqJy712wo
	5nVZ2nco4ytFcFJMBQ6N0QpWxi+d6pf23EZYzpBPmDDak4LxpKtWj7jMmOPOcK43BBcCtsYAuyB
	zgkEVKCmp/m2+ebVdsQMacdfnZaXkS4J7u2T9v2MXv9iW+isRsFHu4COui+bb63YICJppjXtXia
	NQuWL8hL0o11BUQMD6poB
X-Google-Smtp-Source: AGHT+IGVSi0cR7Mklv8cW9/vAvsxyOId06xnQwIQTuSGyrpGDhl4MsZng5aqJAzG4okkGeVd5Pzm4w==
X-Received: by 2002:a05:6402:4406:b0:61b:fabb:6d0d with SMTP id 4fb4d7f45d1cf-61d26ac3cc0mr2469435a12.5.1756586733148;
        Sat, 30 Aug 2025 13:45:33 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.240.27])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc52ade4sm4066630a12.45.2025.08.30.13.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 13:45:32 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Sat, 30 Aug 2025 23:45:20 +0300
Subject: [PATCH 7/9] power: supply: max77705_charger: use
 REGMAP_IRQ_REG_LINE macro
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250830-max77705_77976_charger_improvement-v1-7-e976db3fd432@gmail.com>
References: <20250830-max77705_77976_charger_improvement-v1-0-e976db3fd432@gmail.com>
In-Reply-To: <20250830-max77705_77976_charger_improvement-v1-0-e976db3fd432@gmail.com>
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756586721; l=3504;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=pgFJbrzzXm2uXS0F6KuhyNyYP7mNCsrHTRwj+5OYY2c=;
 b=nkiVN5jxRf/7eCjeV4tcxwW7PFS4DD+9jYZVEJE7c4du0WtobjdWDvccyvaBgpPAUf0kwKoqi
 lHt0JqrAMB4BNvL5ILBgpntBCQ9W5sbSEcimbasdNf/HuJcmkuHBjQu
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
index a1b04ec8921e..aa0ffa1fde39 100644
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
index aec908ac5c01..df1d46ff9527 100644
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


