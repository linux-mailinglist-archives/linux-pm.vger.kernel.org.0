Return-Path: <linux-pm+bounces-32290-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAA8B24A56
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 15:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A908D179B74
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 13:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7232E92A8;
	Wed, 13 Aug 2025 13:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQT3oZga"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872052E5B3B;
	Wed, 13 Aug 2025 13:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755090667; cv=none; b=MajC2FoLfyAB8eDuGPlktstvtABtGPhPaLQVymPMQBbpzpeDpCO2RF6HLvbnGvDy7hRRcerS4+XAAyxTzJMs7JqeB5lTeIunygQ0pprre+QnV3MGj1i2gDuxWfCaVo8j8S47IkvUM4gd6Vp4eQ3HH70t+7wniXiVWJUnjgZEGbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755090667; c=relaxed/simple;
	bh=c6zDxKpJeeYVmGh+A1tB2vQLSCv+7l0ekLVzjCo7skY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AJG5TV9TBSB//GmjS0HbeuIWPH5KufVHANdzxXsvkNXZRJ3iF3dHcCFlbzEVieE3ZqIMV2lYu7X8OCUcE27mnqQsp6okhpPdJRNZEs05F2fcRoXKhrZOkbQ31eayqNhvSw6kkmFcfV0+h/200M/S17TgXhaiMz5wYy/ojEM6LQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQT3oZga; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-321cf75482fso897590a91.0;
        Wed, 13 Aug 2025 06:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755090665; x=1755695465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqYPU935xT6Mbxf99JNTihbkL+VHpmHTTHKi4lhwoZ8=;
        b=FQT3oZgaF+4Epa0t/zCDigWLIzodEoD+gylVJRYVCZwzmMMgN2k9Zwg+rKUnjKE51L
         zt4eMKRTAlzq0xtfXL28SF6fbt8aFYDjCqfau1LNmQ7SFVw3+A3SeJo9DI2h50WHhEM1
         11TaPh3R5W3A9E4Wmx31IbTLtKQwxQE+TWCCW1VbW7j+uQDUiJc9EFMhRLwvdi7VCO6V
         bnkbvjU3XAexMoUl3oqm4gPJQStu8pf4n7D3gbnx8IAX+mwuOSjyuIjFK5RiLgIMdvsz
         baYBsNsRWYyPaIVf4He9eAKmpeagrBDyheurzZH4ZiPjBQ7/m7bNIqdciufqyVqrxUqF
         Wq8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755090665; x=1755695465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fqYPU935xT6Mbxf99JNTihbkL+VHpmHTTHKi4lhwoZ8=;
        b=grmoPXXs2l9X2qzQqdjHNteyNYZA8CRTuEL5zT1eg9qeX7xgXa3lLeB3xcMde67Bnb
         DkMo7mtxVouGe7jz3fYUaahQ6KGU4PBEMK7ZtFwUUuHQ7uFrqJ1IOOrhRdmKSvoA/jx0
         zNrpeJbImgDcBKDB8K78gZjpMznKTX1z0LaaKLiJJ75rx1qe5GAokhUvfz8Qj2VKdLnK
         iaAdnEBHB0trlap3xo5B8zesTC7Ouaogq39BoU2s4EgXgEPdRchKtJBVmP4EGuV2Urpc
         kamxEgYVk63CXIpMg/C5Yx43GQvM0lwSZPAeUrxB+QSqHYOZhkOXmTVckEaFqIYIbep5
         JTQA==
X-Forwarded-Encrypted: i=1; AJvYcCUZZ15lc0A+/0mV39aUF+wpCEJaJYdLDCgWz7h8jEVN+dpLNc6xofqOIXO89DbAMCadsyAnzdlTCLWdKv4=@vger.kernel.org, AJvYcCWnkv2hlsOWTh/Hh+JGSTdVJnEj1cl5GhhlsYGiX54Y9SNh69VjI7EC2iLHOPthRX6TzTUilD8fAd0XIAXhC3Aw9ho=@vger.kernel.org, AJvYcCXLzC0HpPeX5gT/dydeLbMqeU0H7TEbhfrJDUZ8X6afBH8fHE2YnOqWT1/zWyVJ4jX33nIFamW4gss=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm2dh44yB5dhFsUZJ8usi5C9Heurf+XYIjrMpO9q5d4DYCD3Ct
	OypwTGA5H6SZKiV8sAANI/CXwt00QE168UXF/c6ITb+pvZq7LEAHWHb6
X-Gm-Gg: ASbGncvRb7rwPbrdhcdXl0GdRZRbKr38LkClFHn5KbFcSJzbEYE82rt1ZWPcMOIw3Na
	hPomGogi0ZOsLhDor27IwfsBJ9V1NDPUaXTi/FSfgp4DGzpuabDvf/Cp/jb5BcBK2CmuDCXC0rR
	s8wa+DLT9ptxPnig+Z+bmK4JjrqpHlHsU7/2/TSVY2Zu13oR9HMlNdEt6n0QS2mlF2w2T1P1PMt
	0oU7Xvcry3bxfjmZd/KOtunzYd+l2U03KRGXvzUsSfiuU7+unQlQiRrF5Yed9N8mwyScH24D21o
	/d2g/MKvTZmVA+48hCKH+XHfmYtQCogh4lZW4ZWyp0tABEQkxoQHZaMgabc9rAx+HWrkU6YCs2K
	xeMJbGQLhnaurtbagXfLo
X-Google-Smtp-Source: AGHT+IEr3XOImum0AShefQhjlb0HC1vQdpy7jXh1LMHfhhnS2hv+Ey/hdEltC+XWyCUiKfzsSfAP4A==
X-Received: by 2002:a17:90b:2fc3:b0:321:9462:49b7 with SMTP id 98e67ed59e1d1-321d289505cmr3515824a91.12.1755090664483;
        Wed, 13 Aug 2025 06:11:04 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.216])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32325765df6sm161504a91.12.2025.08.13.06.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 06:11:03 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-pm@vger.kernel.org (open list:SAMSUNG THERMAL DRIVER),
	linux-samsung-soc@vger.kernel.org (open list:SAMSUNG THERMAL DRIVER),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES),
	linux-kernel@vger.kernel.org (open list),
	llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:clang|llvm)\b)
Cc: Anand Moon <linux.amoon@gmail.com>,
	Mateusz Majewski <m.majewski2@samsung.com>
Subject: [PATCH v7 6/7] thermal/drivers/exynos: Handle temperature threshold IRQs with SoC-specific mapping
Date: Wed, 13 Aug 2025 18:39:50 +0530
Message-ID: <20250813131007.343402-7-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250813131007.343402-1-linux.amoon@gmail.com>
References: <20250813131007.343402-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Exynos TMU interrupt handling mechanism has been refined to utilize
SoC-specific mappings for interrupt clear registers, targeting rising and
falling edge events. This change introduces a tmu_irq_map structure that
defines these edge-specific interrupt bits, improving the accuracy of
thermal event handling by ensuring that only relevant interrupts are
acknowledged and cleared. The exynos4210_tmu_clear_irqs() function has
been refactored to incorporate this mapping. Notably, for Exynos4210,
a check has been added to prevent clearing unsupported falling edge
interrupt bits.

As per user manuals, specific mappings for interrupt status and clear
registers include:

Exynos4412: Falling edge bits at 20, 16, 12, and
		rising edge bits at 8, 4, 0.
Exynos5422: Falling edge bits at 24, 20, 16, and
		rising edge bits at 8, 4, 0.
Exynos5433: Falling edge bits at 23, 17, 16, and
		rising edge bits at 7, 1, 0.

Cc: Mateusz Majewski <m.majewski2@samsung.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v7: New patch in this series
    simpilfy the logic for set and clear rising and failling
    edges of the IRQ clear register.
[0] https://lore.kernel.org/all/20250624075815.132207-1-m.majewski2@samsung.com/
---
 drivers/thermal/samsung/exynos_tmu.c | 70 ++++++++++++++++++++++++----
 1 file changed, 60 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 146f29fadea9..5e581055e3f3 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -197,6 +197,12 @@ struct exynos_tmu_data {
 	void (*tmu_clear_irqs)(struct exynos_tmu_data *data);
 };
 
+/* Map Rise and Falling edges for IRQ Clean */
+struct tmu_irq_map {
+	u32 fall[3];
+	u32 rise[3];
+};
+
 /*
  * TMU treats temperature as a mapped temperature code.
  * The temperature is converted differently depending on the calibration type.
@@ -765,8 +771,9 @@ static irqreturn_t exynos_tmu_threaded_irq(int irq, void *id)
 
 static void exynos4210_tmu_clear_irqs(struct exynos_tmu_data *data)
 {
-	unsigned int val_irq;
+	unsigned int val_irq, clear_irq = 0;
 	u32 tmu_intstat, tmu_intclear;
+	struct tmu_irq_map irq_map = {0};
 
 	if (data->soc == SOC_ARCH_EXYNOS5260) {
 		tmu_intstat = EXYNOS5260_TMU_REG_INTSTAT;
@@ -783,15 +790,58 @@ static void exynos4210_tmu_clear_irqs(struct exynos_tmu_data *data)
 	}
 
 	val_irq = readl(data->base + tmu_intstat);
-	/*
-	 * Clear the interrupts.  Please note that the documentation for
-	 * Exynos3250, Exynos4412, Exynos5250 and Exynos5260 incorrectly
-	 * states that INTCLEAR register has a different placing of bits
-	 * responsible for FALL IRQs than INTSTAT register.  Exynos5420
-	 * and Exynos5440 documentation is correct (Exynos4210 doesn't
-	 * support FALL IRQs at all).
-	 */
-	writel(val_irq, data->base + tmu_intclear);
+
+	/* Exynos4210 doesn't support FALL interrupts */
+	if (data->soc == SOC_ARCH_EXYNOS4210) {
+		writel(val_irq, data->base + tmu_intclear);
+		return;
+	}
+
+	/* Set SoC-specific interrupt bit mappings */
+	switch (data->soc) {
+	case SOC_ARCH_EXYNOS3250:
+	case SOC_ARCH_EXYNOS4412:
+	case SOC_ARCH_EXYNOS5250:
+	case SOC_ARCH_EXYNOS5260:
+		irq_map.fall[2] = BIT(20);
+		irq_map.fall[1] = BIT(16);
+		irq_map.fall[0] = BIT(12);
+		irq_map.rise[2] = BIT(8);
+		irq_map.rise[1] = BIT(4);
+		irq_map.rise[0] = BIT(0);
+		break;
+	case SOC_ARCH_EXYNOS5420:
+	case SOC_ARCH_EXYNOS5420_TRIMINFO:
+		irq_map.fall[2] = BIT(24);
+		irq_map.fall[1] = BIT(20);
+		irq_map.fall[0] = BIT(16);
+		irq_map.rise[2] = BIT(8);
+		irq_map.rise[1] = BIT(4);
+		irq_map.rise[0] = BIT(0);
+		break;
+	case SOC_ARCH_EXYNOS5433:
+	case SOC_ARCH_EXYNOS7:
+		irq_map.fall[2] = BIT(23);
+		irq_map.fall[1] = BIT(17);
+		irq_map.fall[0] = BIT(16);
+		irq_map.rise[2] = BIT(7);
+		irq_map.rise[1] = BIT(1);
+		irq_map.rise[0] = BIT(0);
+		break;
+	default:
+		pr_warn("exynos-tmu: Unknown SoC type %d, using fallback IRQ mapping\n", soc);
+		break;
+
+	/* Map active INTSTAT bits to INTCLEAR */
+	for (int i = 0; i < 3; i++) {
+		if (val_irq & irq_map.fall[i])
+			clear_irq |= irq_map.fall[i];
+		if (val_irq & irq_map.rise[i])
+			clear_irq |= irq_map.rise[i];
+	}
+
+	if (clear_irq)
+		writel(clear_irq, data->base + tmu_intclear);
 }
 
 static const struct of_device_id exynos_tmu_match[] = {
-- 
2.50.1


