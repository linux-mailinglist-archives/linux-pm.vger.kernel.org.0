Return-Path: <linux-pm+bounces-34506-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A24B6B53AE9
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 19:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5423E170F4C
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 17:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FD636C09B;
	Thu, 11 Sep 2025 17:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZoIHOMwm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846B1369990
	for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 17:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757613447; cv=none; b=GB8y+4l+HZJmW5jHNpsNDtvEo4SqhisjN6F2SA37zAgQ8tbSp5mv7lsyYRpSyXzVRNo/zIVrFyziO0WkbX1EexOglxGzZcsEqYk9SAncBK8ERGXeBFzJ47cD1q0DMNXQ33uIA5WdDX77v+BeYy8ZSLIWuD/q2vcORnNSqZV3ZWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757613447; c=relaxed/simple;
	bh=9dpaf1yLVpZXC+LCSl2wXaiQ1SbVZCWbGt+psRKF3+s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SLXUTaQmCMQl8VLRbnEo+goISWsg5FxU8mxhj3GBhsyeO3BjHo9nSQDc4NRPufV2r2+VfFCbc8PxODkVuObCvXfNW/nLYdCnvua6fIoN4oI+8+EkB7kZx1byi5FMyXZqI7zm2tlKuk8nNUfT+avizT0OxsGZyMtoscVqrfjzLMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZoIHOMwm; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-afcb7ae31caso172644266b.3
        for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 10:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757613443; x=1758218243; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7bPgVJ0ul2fxqOmhEEoAxd5RxMtO+yv7dYQnAEtfz3Y=;
        b=ZoIHOMwmL66nesdkD0dT5w/TdgjJRgHYkjfEOO0yh9xXVG9KSiVcok61Q/ymlpjjpL
         j494NtmP5OnliAUXy3gVX8sgESEJcyzJjjODpYJjR4AbgpOXwsuWF7Ybo/knvbjSqN3b
         61PAMqHDeJZPtvR/+V1vBW31jzGYkXqRMcgTGGXKLTMP4DzzVry8URHy6D2CD4uUaaVk
         pa456O2Put+AfaaJzlqkEBlom7wyhUlCsMZaEQym4WKF8VDFQRX2ZtlkzBhGuy/FR0zf
         WntUF/KVKpxTAtd/01vNux8js1h5k9QNUo3R3L+A3lQsnVXTrVKZNdVrGxmTrKhOmuyS
         G8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757613443; x=1758218243;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7bPgVJ0ul2fxqOmhEEoAxd5RxMtO+yv7dYQnAEtfz3Y=;
        b=q0a3qQBXgyf2t7etx55xQpcn4phpuQv53gDrnYkqdeORy4puux3Exv3GAv9/2bn8tg
         hTd4CJgJQCiJ2iWTEJ9lq1CgJOsc2JVd4fIe2JOnjpxhzwmE2KjO5hGIobQJ8C/eoCvd
         TMkB328LMvdqM2wPtqGujLPkV1jZ/nKvdPts+YTnGaypfDtCtkhCwn6uhsQXSd6jdGe0
         38+iDL2giTQwhcLx3DPPoTeL+SkcONf0SJhZOGUMqs2lkyybETCQcLSK09Jh9bdwhFEK
         pSu2WxleO9RNowXR+HroRTx9K9B3S8KwWh5F1grD3lPt11rvPBEOz196Hcaw88JnFVNj
         Y4qQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbTNrctnbONwO5YNdlCOsv1kOoeGQ9oXrs8kvWqQ2FyUba/fln3hOWhybdAv5Q/L2kcvMcizAlDA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEtX1DlmySQPAoXFN0vNd2ZPmDMoEr/O1Fvpwl5U2tEzPebm0B
	2i12ru6IfdXzjn37n9LVquwRNxE9gu23LcrtasYHXbw0QLIRQo3UgUs8Jk1gWA==
X-Gm-Gg: ASbGncuIZ/IcV8vbuZqT6uaN3kYzG5PRnMa4w25ZBgU+hcnbNobJ5s+2uFgT2UFsy+l
	UL4eR6iejngIt/xIp8t7DMpt0tT/X+KWLmxI0XaEa4j3FwF95gcQ3EzMxS7IKOfF1IRf4Q+kyP/
	wY1WSjmKO7ppSMxJZW/W9CY+WyznXLrSxALYJwwWDImILDxcuwJ0Z/CxhYYDTuMukE0IRzCfSgW
	lMiAQioTGPfqb8+tkUPA+MRxIpA26L0bKHLh+hgnapvRII2QKaemvsdK1AwFfXzhbcCMUSCDW1h
	w+EbfuXT6Ig8KG5/1P/351Wo57v9GDMqbi7ynry0gKs5VxmJGckge25NJY7IUPV8oNNjk7gcEZx
	FeMh3Wx46ag8du6+rnnRJ
X-Google-Smtp-Source: AGHT+IGVztii9/rvUD1LMkM8ybVECZCSKfpHLSZEl7RrMuAWfYojiBgxPheP4ePAefhXqjnP7ws1rw==
X-Received: by 2002:a17:907:1c81:b0:b04:4b0d:8e82 with SMTP id a640c23a62f3a-b07c38684aamr574766b.50.1757613443430;
        Thu, 11 Sep 2025 10:57:23 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.240.27])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b07b312845esm171377166b.26.2025.09.11.10.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 10:57:23 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 11 Sep 2025 20:57:15 +0300
Subject: [PATCH v3 7/9] power: supply: max77705_charger: use
 REGMAP_IRQ_REG_LINE macro
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-max77705_77976_charger_improvement-v3-7-35203686fa29@gmail.com>
References: <20250911-max77705_77976_charger_improvement-v3-0-35203686fa29@gmail.com>
In-Reply-To: <20250911-max77705_77976_charger_improvement-v3-0-35203686fa29@gmail.com>
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757613434; l=3504;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=9dpaf1yLVpZXC+LCSl2wXaiQ1SbVZCWbGt+psRKF3+s=;
 b=o9IFT5+Iyu7lNKqmqkmliRMvyQjC9c9df5rz84BcWx4oqZkRkKDtIhP28dHlZsyyYcQLaveSe
 LmPOSVBK1/FBjMaeJjvSKtcnX/5QRwWwOted8WaAfV+eBcP+hZ5ZOrl
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
index 5f831c25b150..940cf3bf6d1a 100644
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


