Return-Path: <linux-pm+bounces-28841-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BF0ADB729
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 18:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A714F7A91BD
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 16:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46E528850A;
	Mon, 16 Jun 2025 16:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLdDLWit"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B04B2877FA;
	Mon, 16 Jun 2025 16:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750091951; cv=none; b=d6DqWOfBXhjk4VNIP8lR5XTl+aqsLargmkuMEpOpwl9e6271/bcqjZ5T7gDR9irWQp57RKB96EnKtswZ2ksD7DVaAH8N8cNR6GIAhYN4GR3E1WW/Cs/2Z0EBMQUgpAhs+GHT7fGt9IDEFuhdKDKmivec+NTCxOoliCvI5fY9eMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750091951; c=relaxed/simple;
	bh=lcss2CHYuOPWg4ZavwbWHTMPueSjyxco/s4ZLvLSEzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ah4/idx2vFrJ1T26shdaBRcL4turmryUAnR55D9HFDeeZRt0oLSxt6aYAnMOA0sGR/+/35e+cidf0zbCEXa5ULz/KRDQZ2UnOAb/3KSO94Pl+2EyVsovD5q9TFX8ZEhv8ev3YDWoc3NI7vdCAEbdmSgmuKwGr1zfMo6KFtgAKVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TLdDLWit; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b2c4e46a89fso3683370a12.2;
        Mon, 16 Jun 2025 09:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750091949; x=1750696749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NENnjXNt0wBvePMagFMwcD8o+YQQgij7ItxOPmmF1pQ=;
        b=TLdDLWitEyqc/EPqJw4+Jn+hnFfjWr4K2aVHW84QWLDSCLuq3lpBAmWTJrjVqemsZP
         EyWyQZ286UUPqhHSkzs2rb0KfV/ymtrmX3I76tWJzgzzbgtyRY+XaAtOP+4yR1wZb4xq
         szUK1plBGIeXD6edzyWhUwssID2wGE7iOM1zhMbpA43lGVPlntzyUJyzsrhOtDWfEumo
         ev6bG1TGY5np0amMERKQqQVnJT0JjPR0vWWIgZk9iZEAjgitNHzJkQ3wTgnTTXkIR1lo
         ZFDCGx/m/gSYXlswN2ghXPpbbUsy+YHNw97H2BK9oQ8isEF8eQxcMC51clmbYyB8kdVY
         UpnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750091949; x=1750696749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NENnjXNt0wBvePMagFMwcD8o+YQQgij7ItxOPmmF1pQ=;
        b=wPovswU6Z9q7IhNhEJSZHkE8Y3qsw9AJB2GRR7boEnk2jHfDwCfXSSjsmJVNx+PIN3
         l8NOHomxbhkTF0UXwcChcsZAwFM303jl6X5Bx2WgN9KmCtIGLkVmleTKKrc6TdcQQmwR
         9mvSH33c8HHEYLipUMb4P4wKrDr0bnGE6f82xk8b1kGqQGXjPm1G03iSQ1li2rgNmWaz
         Y3jPD3EbUhr41GMEf9Cj2hqdzUidJKY0BH1afIkwj/zEj8vP7frFbcBoimcRP53+33M3
         AylEzPcb1MCo55SyUnDxL2TpJarXPcTVjOCf/nTHGbacfWOMPbuu6ZDDfRhzb9ukmgyd
         u7rg==
X-Forwarded-Encrypted: i=1; AJvYcCUqEk7HqHoiYEHTgnj5tBxTAhdZ8P215BcmKkir4YP/NP9OgEpXsOR++F4YBcbjGXvfEzIyJp1tne4Olj6prG+EwX8=@vger.kernel.org, AJvYcCVknfjT/dwxSJOcaA/juioMc9Ns2Kyc/yOLvmlZEKKH8PMQ2EQ1Beud+NlNDXZMMuaSF8tsO09rI1o=@vger.kernel.org, AJvYcCW6ob/mpJQvX77nASd/5zYoh9shQdWencMA7vUXMkIAuprAdgUspW9DKxy6nNh5XiGCrVDvuPiPm1LCa9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTWobpe6a/5wP9lVywIgdP30qgq4Qn21WTk4mUW+u7/GOYJ/KP
	GpDIwSxt45HDk/YRvo0jaWaoFLtUdvUgCLGRKQ5EeemYdTK314wUJTBr
X-Gm-Gg: ASbGncsmyKDGcmTKnelx7Y1DvkWt2nfkOfJBY7dbsTD5bYZ5WoWOMT6z/3KqxkAH3kA
	uLyfBGyf3iT3x6aW9WH/1b9UnjMUqLbnmlYuuF3LYqqvapjhjf/GhTLnjoJlA2wiDE/4WiMEIqp
	QqOta6YE+e08BHN5wXxyRBWqMZUPfziRvvLl2RlyQ+QpVcPa0tr2f92ZRYGD8x9xIs0ynRR4I1p
	T0sy8jGXn4ycMHuYYsFBumnH2d3Uucuah3BkyYaPLjboNQ6SarVvaubiSruFMeGrm+lfpXnG40K
	K0c1N4T4D7OVjbm/0Cyxz4OMPBGO5zeUd2LwVxh3G1XYRZuW265PCOtPZFDGnNHF192V4KhoS9U
	CTgvpeVZbdw==
X-Google-Smtp-Source: AGHT+IEzKLhcWIZ3LDLciV8dMwLIe97BcGEGz6hip97KqxdgaXHo5SkRpJ0h473Us9HRL34KZAj9pQ==
X-Received: by 2002:a05:6a21:4612:b0:215:db66:2a33 with SMTP id adf61e73a8af0-21fbd4ddb8emr14603050637.16.1750091949552;
        Mon, 16 Jun 2025 09:39:09 -0700 (PDT)
Received: from localhost.localdomain ([45.112.0.181])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe1680c6asm6067882a12.42.2025.06.16.09.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 09:39:08 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-pm@vger.kernel.org (open list:SAMSUNG THERMAL DRIVER),
	linux-samsung-soc@vger.kernel.org (open list:SAMSUNG THERMAL DRIVER),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [RRC v1 2/3] thermal/drivers/exynos: Handle temperature threshold interrupts and clear corresponding IRQs
Date: Mon, 16 Jun 2025 22:08:23 +0530
Message-ID: <20250616163831.8138-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250616163831.8138-1-linux.amoon@gmail.com>
References: <20250616163831.8138-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As per the Exynos TMU user manual the interrupt status register, maps the
active rising and falling edges of interrupt to the appropriate clear bit,
and writes it to the interrupt clear register to acknowledge and
clear the interrupt. This ensures that only the relevant interrupt
is cleared and allows the system to respond appropriately to thermal
events. As per the comment Exynos4210 doesn't support FALL IRQs at all.
So add the check accordingly.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 48 ++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index c625eddcb9f3..b7522b7b1230 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -70,6 +70,20 @@
 #define EXYNOS_EMUL_DATA_MASK	0xFF
 #define EXYNOS_EMUL_ENABLE	0x1
 
+#define INTSTAT_FALL2	BIT(24)
+#define INTSTAT_FALL1	BIT(20)
+#define INTSTAT_FALL0	BIT(16)
+#define INTSTAT_RISE2	BIT(8)
+#define INTSTAT_RISE1	BIT(4)
+#define INTSTAT_RISE0	BIT(0)
+
+#define INTCLEAR_FALL2	BIT(24)
+#define INTCLEAR_FALL1	BIT(20)
+#define INTCLEAR_FALL0	BIT(16)
+#define INTCLEAR_RISE2	BIT(8)
+#define INTCLEAR_RISE1	BIT(4)
+#define INTCLEAR_RISE0	BIT(0)
+
 /* Exynos5260 specific */
 #define EXYNOS5260_TMU_REG_INTEN		0xC0
 #define EXYNOS5260_TMU_REG_INTSTAT		0xC4
@@ -773,7 +787,7 @@ static irqreturn_t exynos_tmu_threaded_irq(int irq, void *id)
 
 static void exynos4210_tmu_clear_irqs(struct exynos_tmu_data *data)
 {
-	unsigned int val_irq;
+	unsigned int val_irq, clearirq = 0;
 	u32 tmu_intstat, tmu_intclear;
 
 	if (data->soc == SOC_ARCH_EXYNOS5260) {
@@ -791,15 +805,29 @@ static void exynos4210_tmu_clear_irqs(struct exynos_tmu_data *data)
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
+	if (data->soc == SOC_ARCH_EXYNOS4210) {
+		writel(val_irq, data->base + tmu_intclear);
+		return;
+	}
+
+	/* Map INTSTAT bits to INTCLEAR bits */
+	if (val_irq & INTSTAT_FALL2)
+		clearirq |= INTCLEAR_FALL2;
+	else if (val_irq & INTSTAT_FALL1)
+		clearirq |= INTCLEAR_FALL1;
+	else if (val_irq & INTSTAT_FALL0)
+		clearirq |= INTCLEAR_FALL0;
+	else if (val_irq & INTSTAT_RISE2)
+		clearirq |= INTCLEAR_RISE2;
+	else if (val_irq & INTSTAT_RISE1)
+		clearirq |= INTCLEAR_RISE1;
+	else if (val_irq & INTSTAT_RISE0)
+		clearirq |= INTCLEAR_RISE0;
+
+	/* Perform proper task for decrease temperature */
+	if (clearirq)
+		writel(clearirq, data->base + tmu_intclear);
 }
 
 static const struct of_device_id exynos_tmu_match[] = {
-- 
2.49.0


