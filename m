Return-Path: <linux-pm+bounces-32289-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 605C4B24A54
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 15:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5D18173EA6
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 13:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECCB2E717F;
	Wed, 13 Aug 2025 13:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7RQRQMF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22A52E716D;
	Wed, 13 Aug 2025 13:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755090664; cv=none; b=fJIjAsrWcB5j/7h4tn6Nezpt9DPNEcM5e5g0bT7NREJc2LdJUxobxcRRRDaUL1wHMxT1pYwagQwk2329s2oHfHJOZch5nMMq3lj5mQmxKg56vZOb+kFq9QwX0ag+MGDKCh1dORnGK5urgcZf8AiD/kojhTnKA8YY6XEDUBEiPbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755090664; c=relaxed/simple;
	bh=b98dUnoToCsBmGX1G41vyacrvIuf64eUskTa822rac0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JnOPx/VD7L8BVNMZ82cXl7IQZFh5ptKCPQ4EkkhT6T/sP8ER2Z6aUTwYXBzIq+Dqo5WY21hTjAShmVMMiGHoTObQkaqB5am1NxysZMqnWBvGiZDNfCRVo88hzw356Oq4GLQM99ddrA2yOT+Ba+5T4SJ5t0BVQeqaJevNXgOefpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7RQRQMF; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-31f255eb191so6741649a91.0;
        Wed, 13 Aug 2025 06:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755090662; x=1755695462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLjx2S6qya2QQP45Rnk1O89a+/wYhcHKpSOmbPHkRVo=;
        b=j7RQRQMF+A5kF03E1rUxWKW7TuBiP1lFQEUSna/vrA3k6kRQynz9Wl1P5y9LjcbDHK
         7qRgjyk/CUvnTUr9g9szC9lawNYMyjk3FVp9VqT1qUlV+AahK9QUkIVW3BFWADa4gUoE
         +JAoe0aySP3ARYUo2HgvBzJBTj05WqgvED1hW86n2rpHoosBPqMII9BrfUcxasNfK3RZ
         Dps3Vx8ENTHEVCNXsmmXjRdkIZr41pUtUkTL0X4mKn6/ptgd6eNMAE1tNZSnNu2NWIc6
         mn2MYyoyixRdeD5Gs3Ufc0ysz47/DfH7UdsImy9Ro1GL82Yqyj5gohcogaA8IZZU9SEG
         mD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755090662; x=1755695462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yLjx2S6qya2QQP45Rnk1O89a+/wYhcHKpSOmbPHkRVo=;
        b=E+8KYcubQx3nkoZcRalmcpHIlz3MFUsDtoWqFUscCRsMAfpygStm99XNJRm5D+Gbu/
         slavF6crz8aR7Zm8Bz3bXFXr3UmmEJrNraPX12Ker7utcpehwv7+arjewFi6WjQ31cVG
         Vjjqw/mRB2tpSzDLTrKArdscyj2iGwPL9jFBERnp2EMkjY7FmBon0vR42zucLm/VWX+a
         8T6AjerEQG3aNkrglhKbX2lm5b3nVyPRT8yX/Ify+qDyrVJnI0YwAsCDVhjci79H+qZa
         oP5ZDei5M8KnKs9yTySDXFUVk6iR38SfYsspGUhBSIyw0SaUUwdpudfpNYxzOrqV99SH
         4qdw==
X-Forwarded-Encrypted: i=1; AJvYcCVIMfHky/gnGMHY8v22KO7WcTXVOco7lfcK6p+8O2qkFQLDVW7OblRh22DgCiLiloaLZ2Tj0zoM8dQ=@vger.kernel.org, AJvYcCWcKQJUQnWFZEdtJZLMGSAEYT9MNq79QBWa/8yJ5irNg3IssU+gFgacNEc8QegfhGfC45JaklUDyt+4Aus=@vger.kernel.org, AJvYcCXwOnSxBZjpXivVLk/45+s+u1uY4ASDapeoMKZq931gMGN71FtVLKhB1bnM+hTfFFG7nLhrtT1ln+/oU5j0/P1r/iw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw69LxFkPk3pKINb2U14gNpHdKeGk53C0QWPo5yag1jarw0tOyM
	faaGp+SLZgIsIH6+3bsvq5aVnjmfZkkb/TVVexR1JNePGne0QhEFS8o8
X-Gm-Gg: ASbGncufpAoRu1Kr7aJxhyN8g02V2CxIdoj6i3Sk1UgsowVHfkpq1I02zwOwFcpqgyw
	bpZwKcGS1/exhOt5YuTSxWGEHQJ2VPKs5X+GZ7YQuQTqlWw/MRMrk7QFuKSc8czR+/VxfMH09zr
	AesgQlHGEWqdr2f8OkSA9Tah2vSIGihRzulGdg3dzttNUF9Alq7pzTPOkVCfeHnjst0QjuTlUUT
	vbmH/I4E9LomscMaiKyaRzxKj9V9/Ehmc3r/Wp3jWdUtuy1cFJOayH7vlU2YHlpF5ikmbcnR9oW
	ms1KjISN85r0CNNNr4szLEhvnbjN0s86paM5kDu/7ClSRT+bjAsYun4XB6in8nbcPbu/Lu9J53T
	3FV5NF1rdOSUCZ9Erh6G2z+EPAO55SRE=
X-Google-Smtp-Source: AGHT+IHV88oyfqtBf2DtpCEKgt1vkDjkfjLKVgWMl/91X6UtdjP7QV90zUlO8YXIk/uwFs7b2yRK5Q==
X-Received: by 2002:a17:90a:e18d:b0:321:380b:9e85 with SMTP id 98e67ed59e1d1-321d0d65539mr3875136a91.8.1755090656709;
        Wed, 13 Aug 2025 06:10:56 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.216])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32325765df6sm161504a91.12.2025.08.13.06.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 06:10:55 -0700 (PDT)
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
Subject: [PATCH v7 5/7] thermal/drivers/exynos: Remove unused base_second mapping and references
Date: Wed, 13 Aug 2025 18:39:49 +0530
Message-ID: <20250813131007.343402-6-linux.amoon@gmail.com>
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

The base_second field has been removed from struct exynos_tmu_data
because it was unused. This cleanup also eliminates its mapping in
exynos_map_dt_data() and ensures that TRIMINFO access in
exynos4412_tmu_initialize() consistently uses the base field across
all SoCs. This streamlines the code and optimizes memory usage.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v7: new patch in this series,
   Improve the commit message
   simplify the logic to TRIMINFO for all SoC.
---
 drivers/thermal/samsung/exynos_tmu.c | 30 +++++++---------------------
 1 file changed, 7 insertions(+), 23 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 3d12e95703bf..146f29fadea9 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -139,12 +139,11 @@ enum soc_type {
  * struct exynos_tmu_data : A structure to hold the private data of the TMU
  *			    driver
  * @base: base address of the single instance of the TMU controller.
- * @base_second: base address of the common registers of the TMU controller.
  * @irq: irq number of the TMU controller.
  * @soc: id of the SOC type.
  * @lock: lock to implement synchronization.
  * @clk: pointer to the clock structure.
- * @clk_sec: pointer to the clock structure for accessing the base_second.
+ * @clk_sec: pointer to the clock structure for accessing the gpu clk.
  * @sclk: pointer to the clock structure for accessing the tmu special clk.
  * @cal_type: calibration type for temperature
  * @efuse_value: SoC defined fuse value
@@ -172,7 +171,6 @@ enum soc_type {
  */
 struct exynos_tmu_data {
 	void __iomem *base;
-	void __iomem *base_second;
 	int irq;
 	enum soc_type soc;
 	struct mutex lock;
@@ -444,24 +442,17 @@ static void exynos4412_tmu_initialize(struct platform_device *pdev)
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
 	unsigned int trim_info, ctrl;
 
-	if (data->soc == SOC_ARCH_EXYNOS3250 ||
-	    data->soc == SOC_ARCH_EXYNOS4412 ||
-	    data->soc == SOC_ARCH_EXYNOS5250) {
-		if (data->soc == SOC_ARCH_EXYNOS3250) {
-			ctrl = readl(data->base + EXYNOS_TMU_TRIMINFO_CON1);
-			ctrl |= EXYNOS_TRIMINFO_RELOAD_ENABLE;
-			writel(ctrl, data->base + EXYNOS_TMU_TRIMINFO_CON1);
-		}
+	if (data->soc == SOC_ARCH_EXYNOS3250) {
+		ctrl = readl(data->base + EXYNOS_TMU_TRIMINFO_CON1);
+		ctrl |= EXYNOS_TRIMINFO_RELOAD_ENABLE;
+		writel(ctrl, data->base + EXYNOS_TMU_TRIMINFO_CON1);
+	} else {
 		ctrl = readl(data->base + EXYNOS_TMU_TRIMINFO_CON2);
 		ctrl |= EXYNOS_TRIMINFO_RELOAD_ENABLE;
 		writel(ctrl, data->base + EXYNOS_TMU_TRIMINFO_CON2);
 	}
 
-	/* On exynos5420 the triminfo register is in the shared space */
-	if (data->soc == SOC_ARCH_EXYNOS5420_TRIMINFO)
-		trim_info = readl(data->base_second + EXYNOS_TMU_REG_TRIMINFO);
-	else
-		trim_info = readl(data->base + EXYNOS_TMU_REG_TRIMINFO);
+	trim_info = readl(data->base + EXYNOS_TMU_REG_TRIMINFO);
 
 	sanitize_temp_error(data, trim_info);
 }
@@ -974,13 +965,6 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	data->base_second = devm_ioremap(&pdev->dev, res.start,
-					resource_size(&res));
-	if (!data->base_second) {
-		dev_err(&pdev->dev, "Failed to ioremap memory\n");
-		return -ENOMEM;
-	}
-
 	return 0;
 }
 
-- 
2.50.1


