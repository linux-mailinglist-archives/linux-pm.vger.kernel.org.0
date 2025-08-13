Return-Path: <linux-pm+bounces-32288-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E53FBB24A46
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 15:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5A291B61EB1
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 13:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632F72E7BB8;
	Wed, 13 Aug 2025 13:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChkuyXHm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5402E7BB1;
	Wed, 13 Aug 2025 13:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755090651; cv=none; b=kWQ1i1aA1bInk51iDqWlgaa22nMjWqQ68FSIa7m6zhoQRrPZDZu/OE76ykKk04g6HXmvYCNqPxP8V0wbM6NA2zWl6HLl9FG8cNkJ7fdjAsoQvmiffuQNt4hSQK/U8RMP0lvPYSqeVNUnOPua36FbqCTtKpXj2dN77btcARHiwSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755090651; c=relaxed/simple;
	bh=bgDOTihFN7L3uo6z3OGyDLMdghqDtCb8HF1nArl4feQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JNwjdRi0g9BMSm9tFAWrPQXXLIK9i5uw5c+99ei3/vVok/xbTTX+d0bHP+gUOtTygS12h8kxxHPATBmeEh+1+Wml7P1UdhQ5ghp7S8Gw2KuWodJ1PaQpg3wXTP+NPa6EtXU1CmneQPxgFr+f1T2Oj2h4VH2V+nxRvyc7EdShlvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ChkuyXHm; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-23ffdea3575so43733475ad.2;
        Wed, 13 Aug 2025 06:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755090649; x=1755695449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eEgfXQmBvwIZTKnjUPX92QY8u5Mv9cN/Yg04BQtYTgI=;
        b=ChkuyXHmvppplfR2sJ7q+UXYTc+wt+/60mWKOq18MRL4tD9ikdi0R8QB0orWjhl0BM
         B/p79IQsIx73V2cy9B+PmsgUXJiJ0DXUJAC7SCz4m1f05NylK0ojzGLVyJPQk7h+QZxt
         yT8F0Ydov0BlU24ltowG9atnml6G2/8TuWqCBALClxofDGMuPzit//7mKKIHTU71Ae4b
         YHV+jily6vnx9TEfhZSgaonQdFry3OsVUwX7QuuvEUNEr2xYklGiVsPrfBsSE4mSFyhj
         kB3VXFTll29V6gmEXMOeN4Kl8i6QhUJoE7SmOjmR6ZrhCiASnAef6+AbA5MDsT/nPGIm
         /QrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755090649; x=1755695449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eEgfXQmBvwIZTKnjUPX92QY8u5Mv9cN/Yg04BQtYTgI=;
        b=wcg/3N5utRfwnV3VjQKrrW3UQfzb6YZXDSmfXnV8OVaPrjgsS778rJSSPy5oynaJi1
         MGdmt/no040WgC2r1tnhmtnJqQS2mlsDb+HryADUMtpcfS0E6AYGwQUPtBGNZVgRGPwK
         1pqSMTRK/7YdM3Je6sjK4O/tq/2PQcs9vnQzbeqz0bgYOPidcAH6dmL0r0A/9s1I+7TT
         jWNKn3gvU715aq3LHiX1ldSmV3S6elVIDu9nJ2mkIhgHhX/1K8FLf9wXYwtmJinSYHDm
         hx7gCHHHX16XQPek3c5XmO+rsu5CIj5XxSbHeKAsHhR9IWgnzJV4CcHF8MZthLA1sd51
         f0tw==
X-Forwarded-Encrypted: i=1; AJvYcCVmD2G0Rvt4x27zanqSYFzVCmERb7ZUW54l4bOB59O4rw4/PCUcALjU6JXsdGGuU4hhmq6gXpEkzbE=@vger.kernel.org, AJvYcCVz4Gns2sq9fLncWek5yk1h8JCEL08LEPEPv/TOYN99W3EMk9idvBv3gfY1R5H96TW9a/kTdTJwMZSBm4Pa5ISLVmQ=@vger.kernel.org, AJvYcCW8SLm4FVXX9+H8/ZWFT0SS9KO+6thrQtmdojxDPYxJ05QBiohW0Cc/MRpvWsbOq8IkNVu0KmPN80opFgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbiOUMtE0Stbn/TRDwARQOogHBr73x677UwXVfyTzFODvAVi68
	UwiF2FVf9n1yacol7V2YCPDegbhEWyClaLy37IteE7lXQGhjKot3Cmbw
X-Gm-Gg: ASbGncvwQsG+bO3zelZ4dstyPpHAhat7HJjOJvxw+MJmqBSLjaLgSZ60nBRzvRCS6Yj
	HCkxGiIb+VAa1ybDsodeUq0wyBbIUD7g2B2gp7kdfDIcg5EaOz3MLNxbABajGHMJ371fNW+W4Iv
	QglYfZbTeFrBjV+6kFCva+cv42wNYAsE8nwnodJC7GgxneNYc0J/V0dag6kVaP5oPwHdzKHRuec
	xZJDim0ZnukSm934t6JqEycAFkJz8VjPxQOTHF4Q+2IJUNho98ieVkjBmRCRCyTa0y1UOFyg+x9
	RGfW0nHw0Uzr/KyUY6cVapp/cmkK6/x5Lt0HTsqLwxeP3FbhGcT+RRbXADz+SoNRTavDr7LZfzZ
	zn8IkX23TfMaHExtGD+a7Ox9oBtA8upI=
X-Google-Smtp-Source: AGHT+IGQetOgmxbvgH8GlqPCrs2OPO9JHPjy7ZNd3WOoXSBNnPAm/Dj6z2ZNFN01W49Z7HuDNX97gQ==
X-Received: by 2002:a17:903:1965:b0:242:a3fc:5900 with SMTP id d9443c01a7336-2430d0dc1eamr41861055ad.8.1755090649047;
        Wed, 13 Aug 2025 06:10:49 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.216])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32325765df6sm161504a91.12.2025.08.13.06.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 06:10:48 -0700 (PDT)
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
Subject: [PATCH v7 4/7] thermal/drivers/exynos: Fixed the efuse min max value for exynos5422
Date: Wed, 13 Aug 2025 18:39:48 +0530
Message-ID: <20250813131007.343402-5-linux.amoon@gmail.com>
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

As per Exynos5422 user manual e-Fuse range min~max range is 16~76.
if e-Fuse value is out of this range, then thermal sensor may not
sense thermal data properly. Additionally, refactors the efuse
initialization logic in exynos_map_dt_data() by replacing nested
if-else blocks with a switch statement for better readability
and maintainability. Ensures correct efuse setup based on SoC type.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v7: drop the Rb Llukasz, as we dropped the nested switch to set efuse.
v6: Add Rb Lukasz and fix typo in subject
v5: None
V4: None
---
 drivers/thermal/samsung/exynos_tmu.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 5f017a78f437..3d12e95703bf 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -884,6 +884,22 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 	case SOC_ARCH_EXYNOS4412:
 	case SOC_ARCH_EXYNOS5250:
 	case SOC_ARCH_EXYNOS5260:
+		data->tmu_set_low_temp = exynos4412_tmu_set_low_temp;
+		data->tmu_set_high_temp = exynos4412_tmu_set_high_temp;
+		data->tmu_disable_low = exynos4412_tmu_disable_low;
+		data->tmu_disable_high = exynos4210_tmu_disable_high;
+		data->tmu_set_crit_temp = exynos4412_tmu_set_crit_temp;
+		data->tmu_initialize = exynos4412_tmu_initialize;
+		data->tmu_control = exynos4210_tmu_control;
+		data->tmu_read = exynos4412_tmu_read;
+		data->tmu_set_emulation = exynos4412_tmu_set_emulation;
+		data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
+		data->gain = 8;
+		data->reference_voltage = 16;
+		data->efuse_value = 55;
+		data->min_efuse_value = 0;
+		data->max_efuse_value = 100;
+		break;
 	case SOC_ARCH_EXYNOS5420:
 	case SOC_ARCH_EXYNOS5420_TRIMINFO:
 		data->tmu_set_low_temp = exynos4412_tmu_set_low_temp;
@@ -899,12 +915,8 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->gain = 8;
 		data->reference_voltage = 16;
 		data->efuse_value = 55;
-		if (data->soc != SOC_ARCH_EXYNOS5420 &&
-		    data->soc != SOC_ARCH_EXYNOS5420_TRIMINFO)
-			data->min_efuse_value = 40;
-		else
-			data->min_efuse_value = 0;
-		data->max_efuse_value = 100;
+		data->min_efuse_value = 16;
+		data->max_efuse_value = 76;
 		break;
 	case SOC_ARCH_EXYNOS5433:
 		data->tmu_set_low_temp = exynos5433_tmu_set_low_temp;
-- 
2.50.1


