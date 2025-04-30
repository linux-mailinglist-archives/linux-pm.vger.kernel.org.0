Return-Path: <linux-pm+bounces-26458-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DB0AA4B49
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 14:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBE4A4C5EB5
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 12:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB0A25C6F3;
	Wed, 30 Apr 2025 12:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5r9b7Lu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0550D25B68D;
	Wed, 30 Apr 2025 12:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746016428; cv=none; b=hsbhDAKptCsxb6FmE1ougJD08fWzmjpCsMhwZsGPmUg90S1DZrGP6DBhnL9X0xLeYaerE9d5LMQ8XJeX2urkfikuf0ERX/+FJQzRjmXLnVZXhZSJ/VaAScQeQNYbHV7a/wwyJCfdxHmxyAyQkPkcHjIeO3ObcZLBgh1hMSx4l/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746016428; c=relaxed/simple;
	bh=NaQIDks9q3n5AJ3fdvvvN06Dc2CyVDzyDsG6sNYlTnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jD2cOz2VYmjnC2EEHcpVsIWycXTiKDeUCx5uSIYYYAqFwA2rLF7YXZmNvnnK7OaApzmBvdmsJb5UPwFJGnFFEx0DBV4+qvMmoh9Lrjo+bSjBp8tMhzSF1HE6k1MfOAN0cIHPolTs6MWumpxlpmmBX2vLrYB9kEosMpSVMUJAQVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5r9b7Lu; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-736aa9d0f2aso8931874b3a.0;
        Wed, 30 Apr 2025 05:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746016426; x=1746621226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3SNFYqaM9t1VFZcOe3OuDknXKerjgLDw3YgF3gLBg0=;
        b=H5r9b7Lu94UtIDctKaRmWILKuvdyrb62VIQdkVw+qHZBAfPHdApqu10f1PIxhuXkfb
         Q/bha2NJ1Xe3Epi25HSIqI7ZIoNDA5XRNN94Y6+iwCdsQRRnqOCq6i5sZfg2XvGofX/K
         GBJ2RgPfjdVPBwY1R+uSvzSyoOD/KD33BSSQJ4RwVi++OUkx0WK3Pd5HrI+qJ0NrHpsT
         WhRIqHYTqeUVOyLg38Si28xXDY6J2O5WrupgMfrKbSoHHz3MGCNsRKQqfKmwRcX3l7P9
         I5FRzse5F0mTaHUSaJa7Ca19mrX1Fpth7Eim3O402DVJ3+PDWsQlrh3lS6S2FTqGLOAK
         7FQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746016426; x=1746621226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t3SNFYqaM9t1VFZcOe3OuDknXKerjgLDw3YgF3gLBg0=;
        b=mvQImYw6b52dgRYP6jcxla4pVuT6ektUszNBYMpiACB2NXcDRGRm0NhbNc+I7Dv5iM
         Eij/PqZn1Wm14I/Sz0SETrXbrLS/XNqO4zQF/5j9RSSkXO1Jg5KaGl0memqz+oYNx1tv
         b2rMe0slA7644gpuPfkFDxp5l9cEFcY7eS9cUrbyuWCzdamLv+dyR6F20V+A2dXhGk0n
         LXjxNireBD2bXpk+H++skVYQAOOgHGcoxaIdIHgQx85hI+Vw62DppCILylAZqIG690cD
         KeZ9hHSnjPQvDaBwZGhZVPBlwurnOwf9uRq/M8bpass+qgTeb0xeCcj/yO+9DsLBGXKk
         Q9AQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUU2x+T7joLf6S50Tg3MYzCTtddIKUtu9D0bh63Pel5d+27cAD81kfWtANgZ1SKFtnCWL1Y6xxu0EKU8zM0/7E+pU=@vger.kernel.org, AJvYcCVnN+Z46dmyNVkWGoS8knKocimmDLDCjhU8BoCj3J9DfBHsX4mYbMSGx84tUrDxpclKsumw8f9QLoclnLI=@vger.kernel.org, AJvYcCWMeNi8BCBrXocVGnoqhq/8u5Ho3Y1HObQ3rPqsUR3G9wUJbPRXt47QtzJqRCwXm33YHMrPVkvlSZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcJtlihRpZWPQ3Qv9RWRdB38bH/zQ2yOc0EMpFfPTand9yFF1g
	4KbGCoonCK+pMCVzONCu1Q5ulhTbAfPh+gkrrhJSjNVAdeJWT5yHKfM44Q==
X-Gm-Gg: ASbGncuEp4KRxtAAtuR/e7sHtw8IyoGipOymW67mWfSt9L7j/q+ccxWH4UTHQpXmjac
	l4QC9s/PKUKntpt/oyhfPUp82N7Tj5GOOCgwA+fjI/txUBdCnoPpkfs8fxqMr4153sfMD5FLmdG
	FhLC0qxBFmDiKWu8BnIEkvCnyilT2a67HO7EfqGayA8h/gcc9wsuiVIhWS7H705UZE7QYOeW3I8
	jQqCpgl+eeQ83VQZr6cz+hRj8/Dwyp/s89G7pbMiocWTjHd4myTaEWDOFQZKzopHRpD6qdT+yLc
	33N8KaeWCCP8BCCyoVY9QaGyGj6+5/k97ehEuX9CuMcA6lC8JMo3rw==
X-Google-Smtp-Source: AGHT+IF2qnBTKenZ1AypOYLHMpucMP9SRa5u9iFuGqy1ut0HTtqxttm3kMbnkZczvm/vAv3TieOZ8g==
X-Received: by 2002:a05:6a20:d50b:b0:1f5:709d:e0cb with SMTP id adf61e73a8af0-20a8980fb29mr4306826637.39.1746016426310;
        Wed, 30 Apr 2025 05:33:46 -0700 (PDT)
Received: from localhost.localdomain ([110.44.101.8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a62e23sm1522627b3a.147.2025.04.30.05.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 05:33:45 -0700 (PDT)
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
Subject: [PATCH v6 3/4] thermal/drivers/exynos: Remove redundant IS_ERR() checks for clk_sec clock
Date: Wed, 30 Apr 2025 18:02:59 +0530
Message-ID: <20250430123306.15072-4-linux.amoon@gmail.com>
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

Remove unnecessary IS_ERR() checks for the clk_sec clock,
the clk_enable() and clk_disable() functions can handle NULL clock
pointers, so the additional checks are redundant and have been removed
to simplify the code.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v6: Add Rb - Lukasz and Fix the typo in the subject
v5: None
v4: drop IE_ERR() for clk_unprepare() as its handle in earlier code.
v3: improve the commit message.
---
 drivers/thermal/samsung/exynos_tmu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index aa0726b33c84..5f017a78f437 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -258,8 +258,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 
 	mutex_lock(&data->lock);
 	clk_enable(data->clk);
-	if (!IS_ERR(data->clk_sec))
-		clk_enable(data->clk_sec);
+	clk_enable(data->clk_sec);
 
 	status = readb(data->base + EXYNOS_TMU_REG_STATUS);
 	if (!status) {
@@ -269,8 +268,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 		data->tmu_clear_irqs(data);
 	}
 
-	if (!IS_ERR(data->clk_sec))
-		clk_disable(data->clk_sec);
+	clk_disable(data->clk_sec);
 	clk_disable(data->clk);
 	mutex_unlock(&data->lock);
 
-- 
2.49.0


