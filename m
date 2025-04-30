Return-Path: <linux-pm+bounces-26456-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9F5AA4B3E
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 14:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 826787A6ED0
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 12:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FBE2550B3;
	Wed, 30 Apr 2025 12:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4tvZ6ZK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A40A238173;
	Wed, 30 Apr 2025 12:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746016415; cv=none; b=czD4IrYmdEwIrwudarll+6ReWGS/MZISvHD8lXgaOjX//A28MMRFYP1xWKEvediuBDCq2j7+juARON15wiBqnHYb6BZW9OK/iJ1pKDjBgEImJDartKrxdQgqlmUQns7WDGT6aduIc0FILqs0mM9zDxRrDmfykd+3H0S8+uL8tLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746016415; c=relaxed/simple;
	bh=rsd0oMU+vi8Z/ml6XTpNx91MJVE9xBPx9VtmVuORW8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zov8Z1wZGfIEkJ5G7pUI1ZFBxDKqXNk3HDTJPLrtSCtwzI02b7heMcD+nvsB90P1SVqSZwySxMUoSdqa/Dx2msfUexL0yDNgp1wr/1RJCF5qtbfyaAl4EmQUq0hMr7TE2znPAUm98gTPpVIatyS56JVT8l2Q5wyFU1eE/kL0TkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4tvZ6ZK; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7396f13b750so7939373b3a.1;
        Wed, 30 Apr 2025 05:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746016413; x=1746621213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lf55HjdhhKhvLLEeAhmoJNEvXS6+XdwBwTK225CdBtY=;
        b=H4tvZ6ZKwUtmDCWK+eyiVyIxS4FpQfush7PJ25/ZtBsFtfzOjgIm0mytgtqpKhJCKx
         58xN+coyCtJ/fHuhSxQNbZQgXPDo0zbbiCjRO/fWSA18AA1yX4mQC2Z12/2DokNahnLN
         1VuopbRQs/J372XwPu+DoBSczB39mo5LeScWFPFvJj8Ya66vu4EbXofgxsAQPLuc3EJh
         X8AEKfhmzeYIvo4O5ndHOwjyCcfYBNy0ARcVSfTETBjHgbumlc3Qm7ASrvVaC3Kmd5dv
         xNXGdS0YjGnkD4RMfDBseO/nvqtClhRJIDJhYc24if4dHvjF7vghAQrWMUHm2yISQxmt
         bi2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746016413; x=1746621213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lf55HjdhhKhvLLEeAhmoJNEvXS6+XdwBwTK225CdBtY=;
        b=IesaIv47wWapEbbM6xS7Kvy6vo2l19TaR31KMCkBuczF3EHBeTnM8LBGMNDTm08ogf
         WO6Z3IVKnTHnt/DBY3HAKGsCBwGiM1BvwUxIrt9riGyoM59FybzeVCfu1vDqazoRMHiI
         IzMHXFoxN9vN/c4zode7Kl4FAWb7Z1d99fnFEM3iTgVaXmmYHHpM7lPkYFj2qYqT0qsw
         5n/wbCC9McA0PJTQRkWWksLiwr0AFpE955g+S/i5gTIz9GlvQy7zViqM4/k1PbxIAIjn
         UPfZiZ8eeHC2CArBDYH3YORseNw5PoGDSsXzMHFnfPk8o8TZtWU/AtfQ4hbhEKdqvloB
         F5zw==
X-Forwarded-Encrypted: i=1; AJvYcCUnhGFqeCDUfBnEOJME1AneFFZsfjHU++JlMhwD1PNbC60CLqM+dgTX+XToxyHv7IVk/8nAwinAQ0vMqFU=@vger.kernel.org, AJvYcCVeFnX77UjycTkTRRfhMKgM6AQ3M2VnZud85Hu8/ifunL2MK49mSmp2J6YZkwOXZYBzpK9vl1uGs+tOprFMP92CvS8=@vger.kernel.org, AJvYcCXNyuja8HVJo6aK0Z8zraOE+XRbSKDFU1p5BTUxKPUHYkvmBIZc9GJobDN+z9kVpD8e/YHXN9kXN5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTrKdvHc0h8DQBZ0DfMAvo59u7lKorDMGCmfJbKzbcPaJOy3So
	WFpmfEjiaL5UprwrQeZt03vKY4dVqv3TFYySdDPRV1CaB9ugTXtc
X-Gm-Gg: ASbGncsqiHshlYzObK3jac4eZEiXnyrUUpO8jrL86ps2gea2rd0OQlQcw/PvH6xqwN+
	wcatICVpXN9u4aLOxdLC+o5mnfdwCk8hA20walSMkjl9r06+9cy6PfgjS2JOKo1PY8u+YUvAhkY
	fGklu5D0ZvhbFw6LJWDIFaNEE8HHpqNZ8YMGh5AKm66rkvgY3D47OaHkPxG/y116+HW6R8xi0rc
	KdPgZzLBeiHX6rMsq0zr5mQHt519tpnpwKdjzENyv0co+LsHrKTvmJ8yqTFg5n2hz7Dcn8C9L9L
	gmz009O/aX90uN7EX+N44Kk70WXwu+Ygao6qsRIvM5G0EyG0hHqsdA==
X-Google-Smtp-Source: AGHT+IEXIBRnItsxJgHarmeNLTYGAGyI0xDlMc36p/yim3EbyhEaIx8/EJ3h3jrPHK0gWcrJ56Volg==
X-Received: by 2002:a05:6a00:2405:b0:73e:b65:bc47 with SMTP id d2e1a72fcca58-74038a8762amr4013535b3a.17.1746016412720;
        Wed, 30 Apr 2025 05:33:32 -0700 (PDT)
Received: from localhost.localdomain ([110.44.101.8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a62e23sm1522627b3a.147.2025.04.30.05.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 05:33:32 -0700 (PDT)
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
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v6 1/4] thermal/drivers/exynos: Refactor clk_sec initialization inside SOC-specific case
Date: Wed, 30 Apr 2025 18:02:57 +0530
Message-ID: <20250430123306.15072-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430123306.15072-1-linux.amoon@gmail.com>
References: <20250430123306.15072-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the initialization of the clk_sec clock to be inside the
SOC_ARCH_EXYNOS5420_TRIMINFO case. It ensures that the clk_sec clock
is only initialized for the specified SOC and not for other SOCs,
thereby simplifying the code. The clk_sec clock is used by the TMU
for GPU on the Exynos 542x platform.

Removed redundant IS_ERR() checks for the clk_sec clock since error
handling is already managed internally by clk_unprepare() functions.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v6: Add Rb Lukasz and try to address Daniel review coments.
v5: None
v4: Fix the aligment of code clk for clk_prepare in proper if/else block.
    update the commit for clk_sec used.
    checked to goto clean up all the clks are proper.
    drop IS_ERR() check for clk_sec.
v3: improve the commit message.
---
 drivers/thermal/samsung/exynos_tmu.c | 36 +++++++++++++---------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 47a99b3c5395..04517d52afbd 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -1040,26 +1040,26 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 	if (IS_ERR(data->clk))
 		return dev_err_probe(dev, PTR_ERR(data->clk), "Failed to get clock\n");
 
-	data->clk_sec = devm_clk_get(dev, "tmu_triminfo_apbif");
-	if (IS_ERR(data->clk_sec)) {
-		if (data->soc == SOC_ARCH_EXYNOS5420_TRIMINFO)
-			return dev_err_probe(dev, PTR_ERR(data->clk_sec),
-					     "Failed to get triminfo clock\n");
-	} else {
-		ret = clk_prepare(data->clk_sec);
-		if (ret) {
-			dev_err(dev, "Failed to get clock\n");
-			return ret;
-		}
-	}
-
 	ret = clk_prepare(data->clk);
 	if (ret) {
 		dev_err(dev, "Failed to get clock\n");
-		goto err_clk_sec;
+		return ret;
 	}
 
 	switch (data->soc) {
+	case SOC_ARCH_EXYNOS5420_TRIMINFO:
+		data->clk_sec = devm_clk_get(dev, "tmu_triminfo_apbif");
+		if (IS_ERR(data->clk_sec)) {
+			ret = dev_err_probe(dev, PTR_ERR(data->clk_sec),
+					    "Failed to get clk_sec clock\n");
+			goto err_clk;
+		}
+		ret = clk_prepare(data->clk_sec);
+		if (ret) {
+			dev_err(dev, "Failed to prepare clk_sec clock\n");
+			goto err_clk_sec;
+		}
+		break;
 	case SOC_ARCH_EXYNOS5433:
 	case SOC_ARCH_EXYNOS7:
 		data->sclk = devm_clk_get(dev, "tmu_sclk");
@@ -1112,11 +1112,10 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 
 err_sclk:
 	clk_disable_unprepare(data->sclk);
+err_clk_sec:
+	clk_unprepare(data->clk_sec);
 err_clk:
 	clk_unprepare(data->clk);
-err_clk_sec:
-	if (!IS_ERR(data->clk_sec))
-		clk_unprepare(data->clk_sec);
 	return ret;
 }
 
@@ -1128,8 +1127,7 @@ static void exynos_tmu_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(data->sclk);
 	clk_unprepare(data->clk);
-	if (!IS_ERR(data->clk_sec))
-		clk_unprepare(data->clk_sec);
+	clk_unprepare(data->clk_sec);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.49.0


