Return-Path: <linux-pm+bounces-32291-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35666B24A43
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 15:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A3457B06E2
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 13:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AA82E7F35;
	Wed, 13 Aug 2025 13:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1GK3eTe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC7A2E718B;
	Wed, 13 Aug 2025 13:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755090674; cv=none; b=aytgRsCMk5l0bx9ZGPojlIn+5NRoLjOLMKITchdVg2J2IWZvegj1rN3hRO+EgTd6QsMc1YFS72Vkffdg7mfGMyvxeBi2bvh0t0pS7oIzH4/s7knOmSXRZIj1AcOkrri4Tk199BHDyuOCwjptepCGgootYY8ytz0geKVjZBwdG9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755090674; c=relaxed/simple;
	bh=0nWjFYh74w2mIcJjfCn/sF1211cVnM+5dP9HRvjwS7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WIUo5cz1TTjDCTCHH3IU3lk/KS0+BvDJSyop717BLrVqazS0FDJkZOToyQPUmo8lGdSHqqtXPD19JJHQub3lPn5ldAq7ouNncUBgsujttcNZo6AJhIQSckOHb0EZ+NEeDt9coX+05Dif4oD5/a17eCdvZr/k+r2h+ISuzgI4/Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1GK3eTe; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-32128c5fc44so857267a91.1;
        Wed, 13 Aug 2025 06:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755090672; x=1755695472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PMqGPn5i1dBgX26P0LPYzxtUAGEpZYYhsp9BiJes8v0=;
        b=U1GK3eTemfNES5g/OqLWMa14IfknnmtUKEtJg1P2MVImERq7ucX0+lHiP3WyLQE617
         lXjLcgHyFb62d8GTyUhhNavFHRnKeWNQ1Va+ZN1flIDysQMD3Y9Jrs6vM4UEKFTprCRQ
         VGuXObT9p3sX8Goels8jxHrhLY1zcsusJdqThoM4uWZHoy6bAtN0hPHEj4sNhSEhm4LW
         qoWwr+u1OzsKrQmDBvuVPpfYlOezltNepvbGU0ApMc1QYPjPYHsxGjL4ANUz9N2T20Qw
         vWN2uIJUzwohWY5Nwq5x6QE4WyUn64T66Ryi2DZZsAfohIBR8zR1xRcJp1JnNXoQIUAj
         Z+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755090672; x=1755695472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PMqGPn5i1dBgX26P0LPYzxtUAGEpZYYhsp9BiJes8v0=;
        b=AliPsjWkR167LCdqXOsp9XEwNAcIzmLKdlL6pmhlH0E4+3+//LrFAEdh+/uXc+c0bC
         JSbzNvaw57AeZvYJyXf9klQsEitnrPSzfjk6m924+LsnrHG/E8QVRiUzjML3VeSo3iBc
         pqYg8Zt9bo3tSt4Pmpzliv0Qi5WGKpNmvE30kDr3mZavPg7JhQdmO/ZAPze8gZTzcAyD
         D5ZEluxWEFFz3TMwXo1woamzMx4MkZxWRwV84L9CuY57K8lCRcJwq48SA4/BCvfdpv1g
         kg+3vkcCoKWmjGem4MxqGpp5WjOTYg/wJ+LKyrWlSHsEqyRGZIymMh5SiLDSkxzZ+3Im
         z1oA==
X-Forwarded-Encrypted: i=1; AJvYcCVIBbhg+tkhSkvdduEmWqbEIuwXuk1IsJOSe1rclaOgY/au+ibv4NJ/UE1XflBuROYvHi95GWgmmXtvpo+adBVLSnM=@vger.kernel.org, AJvYcCX5tWJqe10w8Ab19UmKdDLOTIs2N7nsV4mlySqMKF0Vl49uAiemdWhmmGa6cz70BXnmXfktlQ8AAXPAODs=@vger.kernel.org, AJvYcCXXg9KYwFO8aD/zjE57WUx0tKSkFPa+TiLxep4PrBW+1GZpgOACpPVgM7/q36qepI4XN8u72YpnIsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwBxc/p2T/4Pxm24cWzA6pL4nZ+D2dmt33+UWNS1EC2eA+nI5Q
	A7gMHkNNs5Pj0td31UIL5SqNYq1tKqwGtgkFsCgfcizB+8oI6a6lLY+g
X-Gm-Gg: ASbGncurlhfozzf/KnejY1CNCjfV3hz+kAgeEnSNREaLMjNfWBJXlb2MIzyOLHEVgSj
	vPy0QWLtR73+Db3TvUqH1j71Zggmk9VpWvc895BrdOcwzyveXtF6UnQixxqHjxniYE0SP/cwBrf
	Ec9UPIaCeR8oZbAKltetfG6xorOydZAh/1jBErmCkfQ6vFR9ls4grWU3rjg4XLTCHED9pUAUyLu
	spMDFGNn2OyRyQ5K00WZ2lWnjGyzkRaDsPQvk1XObeTmRL6SqNCO9Eyv+L+CU7TXuI4g/U+uLx8
	pM/b5KRMfAKT5LzGMRrv09Ah4WRK/MiAOEUi1SYSF3NSg8XhU7Svwc/PueQ+gCKd7KrprgQtU/N
	aIZLIvCClbdIfBCshxkPiZqAY28eXuA4=
X-Google-Smtp-Source: AGHT+IEPKcFPf/H6yHGsr0sS7omSEBlqNNcKUaAqL1joOuoGej9xA/Vpwpo3atGz6DL927Y0FQPKsg==
X-Received: by 2002:a17:90a:c2c8:b0:320:e145:26f3 with SMTP id 98e67ed59e1d1-321d27e34cbmr3948954a91.8.1755090672310;
        Wed, 13 Aug 2025 06:11:12 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.216])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32325765df6sm161504a91.12.2025.08.13.06.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 06:11:11 -0700 (PDT)
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
Subject: [PATCH v7 7/7] thermal/drivers/exynos: Refactor IRQ clear logic using SoC-specific config
Date: Wed, 13 Aug 2025 18:39:51 +0530
Message-ID: <20250813131007.343402-8-linux.amoon@gmail.com>
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

The Exynos TMU driver's IRQ clear logic has been refactored for improved
maintainability and reduced code duplication. A unified
exynos4210_tmu_clear_irqs() implementation now replaces the previous
reliance on SoC-specific functions and hardcoded register mappings.
This new implementation leverages SoC-specific configuration fields
(tmu_intstat, tmu_intclear, and IRQ bit mappings) stored within
exynos_tmu_data. These fields are populated during device setup within
exynos_map_dt_data(), thereby streamlining new SoC integration, ensuring
correct interrupt handling, and improving code clarity. This refactor
simplifies the addition of new SoC support, ensures correct interrupt
handling across platforms, and improves overall code clarity.

Cc: Mateusz Majewski <m.majewski2@samsung.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v7: new patch in this series
    split the IRQ function handler per SoC.
---
 drivers/thermal/samsung/exynos_tmu.c | 150 +++++++++++++++++----------
 1 file changed, 96 insertions(+), 54 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 5e581055e3f3..9f94c58e1e74 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -158,6 +158,8 @@ enum soc_type {
  *	0 < reference_voltage <= 31
  * @tzd: pointer to thermal_zone_device structure
  * @enabled: current status of TMU device
+ * @tmu_intstat: interrupt status register
+ * @tmu_intclear: interrupt clear register
  * @tmu_set_low_temp: SoC specific method to set trip (falling threshold)
  * @tmu_set_high_temp: SoC specific method to set trip (rising threshold)
  * @tmu_set_crit_temp: SoC specific method to set critical temperature
@@ -184,6 +186,8 @@ struct exynos_tmu_data {
 	u8 reference_voltage;
 	struct thermal_zone_device *tzd;
 	bool enabled;
+	u32 tmu_intstat;
+	u32 tmu_intclear;
 
 	void (*tmu_set_low_temp)(struct exynos_tmu_data *data, u8 temp);
 	void (*tmu_set_high_temp)(struct exynos_tmu_data *data, u8 temp);
@@ -770,67 +774,90 @@ static irqreturn_t exynos_tmu_threaded_irq(int irq, void *id)
 }
 
 static void exynos4210_tmu_clear_irqs(struct exynos_tmu_data *data)
+{
+	unsigned int val_irq;
+	u32 tmu_intstat = data->tmu_intstat;
+	u32 tmu_intclear = data->tmu_intclear;
+
+	val_irq = readl(data->base + tmu_intstat);
+
+	/* Exynos4210 doesn't support FALL interrupts */
+	writel(val_irq, data->base + tmu_intclear);
+}
+
+static void exynos4412_tmu_clear_irqs(struct exynos_tmu_data *data)
 {
 	unsigned int val_irq, clear_irq = 0;
-	u32 tmu_intstat, tmu_intclear;
+	u32 tmu_intstat = data->tmu_intstat;
+	u32 tmu_intclear = data->tmu_intclear;
 	struct tmu_irq_map irq_map = {0};
 
-	if (data->soc == SOC_ARCH_EXYNOS5260) {
-		tmu_intstat = EXYNOS5260_TMU_REG_INTSTAT;
-		tmu_intclear = EXYNOS5260_TMU_REG_INTCLEAR;
-	} else if (data->soc == SOC_ARCH_EXYNOS7) {
-		tmu_intstat = EXYNOS7_TMU_REG_INTPEND;
-		tmu_intclear = EXYNOS7_TMU_REG_INTPEND;
-	} else if (data->soc == SOC_ARCH_EXYNOS5433) {
-		tmu_intstat = EXYNOS5433_TMU_REG_INTPEND;
-		tmu_intclear = EXYNOS5433_TMU_REG_INTPEND;
-	} else {
-		tmu_intstat = EXYNOS_TMU_REG_INTSTAT;
-		tmu_intclear = EXYNOS_TMU_REG_INTCLEAR;
+	val_irq = readl(data->base + tmu_intstat);
+
+	/* Set SoC-specific interrupt bit mappings */
+	irq_map.fall[2] = BIT(20);
+	irq_map.fall[1] = BIT(16);
+	irq_map.fall[0] = BIT(12);
+	irq_map.rise[2] = BIT(8);
+	irq_map.rise[1] = BIT(4);
+	irq_map.rise[0] = BIT(0);
+
+	/* Map active INTSTAT bits to INTCLEAR */
+	for (int i = 0; i < 3; i++) {
+		if (val_irq & irq_map.fall[i])
+			clear_irq |= irq_map.fall[i];
+		if (val_irq & irq_map.rise[i])
+			clear_irq |= irq_map.rise[i];
 	}
 
+	if (clear_irq)
+		writel(clear_irq, data->base + tmu_intclear);
+}
+
+static void exynos5420_tmu_clear_irqs(struct exynos_tmu_data *data)
+{
+	unsigned int val_irq, clear_irq = 0;
+	u32 tmu_intstat = data->tmu_intstat;
+	u32 tmu_intclear = data->tmu_intclear;
+	struct tmu_irq_map irq_map = {0};
+
 	val_irq = readl(data->base + tmu_intstat);
 
-	/* Exynos4210 doesn't support FALL interrupts */
-	if (data->soc == SOC_ARCH_EXYNOS4210) {
-		writel(val_irq, data->base + tmu_intclear);
-		return;
+	/* Set SoC-specific interrupt bit mappings */
+	irq_map.fall[2] = BIT(24);
+	irq_map.fall[1] = BIT(20);
+	irq_map.fall[0] = BIT(16);
+	irq_map.rise[2] = BIT(8);
+	irq_map.rise[1] = BIT(4);
+	irq_map.rise[0] = BIT(0);
+
+	for (int i = 0; i < 3; i++) {
+		if (val_irq & irq_map.fall[i])
+			clear_irq |= irq_map.fall[i];
+		if (val_irq & irq_map.rise[i])
+			clear_irq |= irq_map.rise[i];
 	}
 
+	if (clear_irq)
+		writel(clear_irq, data->base + tmu_intclear);
+}
+
+static void exynos5433_tmu_clear_irqs(struct exynos_tmu_data *data)
+{
+	unsigned int val_irq, clear_irq = 0;
+	u32 tmu_intstat = data->tmu_intstat;
+	u32 tmu_intclear = data->tmu_intclear;
+	struct tmu_irq_map irq_map = {0};
+
+	val_irq = readl(data->base + tmu_intstat);
+
 	/* Set SoC-specific interrupt bit mappings */
-	switch (data->soc) {
-	case SOC_ARCH_EXYNOS3250:
-	case SOC_ARCH_EXYNOS4412:
-	case SOC_ARCH_EXYNOS5250:
-	case SOC_ARCH_EXYNOS5260:
-		irq_map.fall[2] = BIT(20);
-		irq_map.fall[1] = BIT(16);
-		irq_map.fall[0] = BIT(12);
-		irq_map.rise[2] = BIT(8);
-		irq_map.rise[1] = BIT(4);
-		irq_map.rise[0] = BIT(0);
-		break;
-	case SOC_ARCH_EXYNOS5420:
-	case SOC_ARCH_EXYNOS5420_TRIMINFO:
-		irq_map.fall[2] = BIT(24);
-		irq_map.fall[1] = BIT(20);
-		irq_map.fall[0] = BIT(16);
-		irq_map.rise[2] = BIT(8);
-		irq_map.rise[1] = BIT(4);
-		irq_map.rise[0] = BIT(0);
-		break;
-	case SOC_ARCH_EXYNOS5433:
-	case SOC_ARCH_EXYNOS7:
-		irq_map.fall[2] = BIT(23);
-		irq_map.fall[1] = BIT(17);
-		irq_map.fall[0] = BIT(16);
-		irq_map.rise[2] = BIT(7);
-		irq_map.rise[1] = BIT(1);
-		irq_map.rise[0] = BIT(0);
-		break;
-	default:
-		pr_warn("exynos-tmu: Unknown SoC type %d, using fallback IRQ mapping\n", soc);
-		break;
+	irq_map.fall[2] = BIT(23);
+	irq_map.fall[1] = BIT(17);
+	irq_map.fall[0] = BIT(16);
+	irq_map.rise[2] = BIT(7);
+	irq_map.rise[1] = BIT(1);
+	irq_map.rise[0] = BIT(0);
 
 	/* Map active INTSTAT bits to INTCLEAR */
 	for (int i = 0; i < 3; i++) {
@@ -915,6 +942,8 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->tmu_control = exynos4210_tmu_control;
 		data->tmu_read = exynos4210_tmu_read;
 		data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
+		data->tmu_intstat = EXYNOS_TMU_REG_INTSTAT;
+		data->tmu_intclear = EXYNOS_TMU_REG_INTCLEAR;
 		data->gain = 15;
 		data->reference_voltage = 7;
 		data->efuse_value = 55;
@@ -934,7 +963,14 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->tmu_control = exynos4210_tmu_control;
 		data->tmu_read = exynos4412_tmu_read;
 		data->tmu_set_emulation = exynos4412_tmu_set_emulation;
-		data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
+		data->tmu_clear_irqs = exynos4412_tmu_clear_irqs;
+		if (data->soc == SOC_ARCH_EXYNOS5260) {
+			data->tmu_intstat = EXYNOS5260_TMU_REG_INTSTAT;
+			data->tmu_intclear = EXYNOS5260_TMU_REG_INTCLEAR;
+		} else {
+			data->tmu_intstat = EXYNOS_TMU_REG_INTSTAT;
+			data->tmu_intclear = EXYNOS_TMU_REG_INTCLEAR;
+		}
 		data->gain = 8;
 		data->reference_voltage = 16;
 		data->efuse_value = 55;
@@ -952,7 +988,9 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->tmu_control = exynos4210_tmu_control;
 		data->tmu_read = exynos4412_tmu_read;
 		data->tmu_set_emulation = exynos4412_tmu_set_emulation;
-		data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
+		data->tmu_clear_irqs = exynos5420_tmu_clear_irqs;
+		data->tmu_intstat = EXYNOS_TMU_REG_INTSTAT;
+		data->tmu_intclear = EXYNOS_TMU_REG_INTCLEAR;
 		data->gain = 8;
 		data->reference_voltage = 16;
 		data->efuse_value = 55;
@@ -969,7 +1007,9 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->tmu_control = exynos5433_tmu_control;
 		data->tmu_read = exynos4412_tmu_read;
 		data->tmu_set_emulation = exynos4412_tmu_set_emulation;
-		data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
+		data->tmu_clear_irqs = exynos5433_tmu_clear_irqs;
+		data->tmu_intstat = EXYNOS5433_TMU_REG_INTPEND;
+		data->tmu_intclear = EXYNOS5433_TMU_REG_INTPEND;
 		data->gain = 8;
 		if (res.start == EXYNOS5433_G3D_BASE)
 			data->reference_voltage = 23;
@@ -989,7 +1029,9 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->tmu_control = exynos7_tmu_control;
 		data->tmu_read = exynos7_tmu_read;
 		data->tmu_set_emulation = exynos4412_tmu_set_emulation;
-		data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
+		data->tmu_clear_irqs = exynos5433_tmu_clear_irqs;
+		data->tmu_intstat = EXYNOS7_TMU_REG_INTPEND;
+		data->tmu_intclear = EXYNOS7_TMU_REG_INTPEND;
 		data->gain = 9;
 		data->reference_voltage = 17;
 		data->efuse_value = 75;
-- 
2.50.1


