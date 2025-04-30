Return-Path: <linux-pm+bounces-26459-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1EEAA4B4E
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 14:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DD191BA4FA0
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 12:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F9325C82D;
	Wed, 30 Apr 2025 12:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OeAILLLI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA86925B1C2;
	Wed, 30 Apr 2025 12:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746016435; cv=none; b=a49ahLeb/o28AJxT+3eXSqjAhP02szT7p+JoPwY+hdWwSOcsTBkBLBoZSa+74QmTD57I96b+Xewtfc2f7aHvk2NZ9AyI/zDGMZ6/rHuc/PiBMfv6ChfzS16YH6+P4ziYxSslVDNi41aTN8Ghr/rnKw1NVdH2JxENbzf3b0zubKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746016435; c=relaxed/simple;
	bh=w3jz2F7DYQyYj2UyhyQ+qsvOLyYvH1eF//AIxNpzRxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rJLQo4ig4Rehpq5wLGXHp9W7TTs5gRLvtEFuEVsHLgH2rsytmxGThRu/3GADTbX4m9S34GuDtZrTAiVxLWsSF9qaW1TkwzP+yTzeE30RRG6yi7JTCcBBUcj7pqAv8srj6lZ85Vd5maWm0XWloP/qcAvrd3w10Tva3yYLXwg1k0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OeAILLLI; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-73bf5aa95e7so6124353b3a.1;
        Wed, 30 Apr 2025 05:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746016433; x=1746621233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VjF1aak/Vxutzt5SCKZiyBKrPP8O+zRq73MMdmerku4=;
        b=OeAILLLI7vYZnEmF92hQdX/jXviRT7qXx3quKueIeV+PZHPDoc4LknH4xDLfpB/XUY
         0r6LVpH1rtoqkRxDq8vcXeXTH6+Rqtny11aZ0LFb69+5RIuUxGiHRpkJAyTgfIekEWK8
         s7E4E5aJ9X0cLvyiUCB2cKZYiJv054mkibVuWaXuAEPVdm43DZaC0g/URScdBZnwEA6d
         /X0azvnhYYYc2S8uuDo8rf6a6EE0QLOcxnKzhieaQBQ3gfyaWtNJGy6n4RrbcjkO6wxS
         NfAZrT49I0BHovqkXbQQtrrSOoMy9JqfAvkbu+z5qGT0pfrs96L/A7Ik3Yol1NEcmcpD
         Eb1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746016433; x=1746621233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VjF1aak/Vxutzt5SCKZiyBKrPP8O+zRq73MMdmerku4=;
        b=GDEY5350rv3OjBthAPeouqxHfIJofoQqWkcivaVc8S+xOokYLRzci9W+h38CAZVzgV
         E3s6Oox/TssGF6I9qOsK69L2yvFCPV2dBt143ZyKjGWZ0oU6Ag2dhQ8jG52EGmg81oL0
         7S5Wx0B6hee5c2atmxk6o0cMKNCIbPES2KMT2120R9SE6lB4iksm2IVeuenzWflNo2xf
         gcGNRpmmtpEM3p5SQLyai+kgoWhgdj2kbXOJz2C+ZHev93UUiWOhus64QO6gKart6gzO
         ZIWMZ56LT3Q9QEBxxl9W1FLGiamlDN6S8QplE71JGQS+2OWckArJ/FxhLXL+UqCF2Cs1
         HP4g==
X-Forwarded-Encrypted: i=1; AJvYcCUJ9s3MRoaMWbWbh6aiPbeoASLI4i08j8F92RuxMjRGw/c8H81RcFrTsgFcLXRaCF4DyCw6dZkvOclCl1U=@vger.kernel.org, AJvYcCVuY0SHSnf7Y5wjej8Ts1/JXlKH7DPXgEOZ9CYzy09TcXTlpEUIM7VtdKBsgrFEp/B3zavEhXgRMW3KvG8v/Q0575U=@vger.kernel.org, AJvYcCXnkDlU0jJAgLnDIXGURNWgLud34ldLyudILkLT4BC8A5lzhx4sBCQkN/8zL90XmiOCU7RSjlj6BXc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi7qjg9pSDWrg2Ukg90WCgl8GcDqOUBBkkEtXgg8+OjB1HLeW4
	a7jdAgcffTyGAHhp6NJ3Px72XH8ajm0OwiugBRl/RpYBdrza1rll
X-Gm-Gg: ASbGnctXkovRYs1f5xlaKVhfB6izXHVRO0zwPdcjOOpE7ktsCott6xOqdlgdt2crIFr
	3MSYGnt8ycl/tJt1+8r6Y8BEZCGKWNG+5EgZ0XmMI0uA4erD3DH8eb9tQb9iPZNhQrB7qXuM6rW
	+vbV8FpaHTDU8dKEuStyF/qAMqcnv4CEhX2Q5AD7ADaVl5Yamm9h/AjnxCArSqc/v/4SlgeoRp5
	u5k07SHJKcHN8d2umdnOODh3Y5ouQ/6ogsPaTGyzwmRBDGuiDzCRkT6hti864QmEAkHS1j1pvwG
	qJ5k6BijFskZ/ZJUtqilcPjMnKLqX3BcMk4Sd+dMZhSw5kySM9IQTA==
X-Google-Smtp-Source: AGHT+IHJKBDe80VIu8qKthsvPbjAJ96qR6Xh6rsf0+iAijz4bJVrcEqmDWrR6oeCmx91YoLYuQSEJQ==
X-Received: by 2002:a05:6a00:3a29:b0:736:69aa:112c with SMTP id d2e1a72fcca58-74038989dc9mr3923336b3a.9.1746016432889;
        Wed, 30 Apr 2025 05:33:52 -0700 (PDT)
Received: from localhost.localdomain ([110.44.101.8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a62e23sm1522627b3a.147.2025.04.30.05.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 05:33:52 -0700 (PDT)
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
Subject: [PATCH v6 4/4] thermal/drivers/exynos: Fixed the efuse min max value for exynos5422
Date: Wed, 30 Apr 2025 18:03:00 +0530
Message-ID: <20250430123306.15072-5-linux.amoon@gmail.com>
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

As per Exynos5422 user manual e-Fuse range min~max range is 16~76.
if e-Fuse value is out of this range, then thermal sensor may not
sense thermal data properly. Refactors the efuse value
initialization logic within exynos_map_dt_data function by
replacing the nested if-else statements with a switch statement.
Ensures proper initialization of efuse values based on the SOC type.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v6: Add Rb Lukasz and fix typo in subject
v5: None
V4: None
---
 drivers/thermal/samsung/exynos_tmu.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 5f017a78f437..ef216aac13ee 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -899,12 +899,23 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->gain = 8;
 		data->reference_voltage = 16;
 		data->efuse_value = 55;
-		if (data->soc != SOC_ARCH_EXYNOS5420 &&
-		    data->soc != SOC_ARCH_EXYNOS5420_TRIMINFO)
+		data->max_efuse_value = 100;
+		switch (data->soc) {
+		case SOC_ARCH_EXYNOS3250:
+		case SOC_ARCH_EXYNOS4412:
+		case SOC_ARCH_EXYNOS5250:
+		case SOC_ARCH_EXYNOS5260:
 			data->min_efuse_value = 40;
-		else
+			break;
+		case SOC_ARCH_EXYNOS5420:
+		case SOC_ARCH_EXYNOS5420_TRIMINFO:
+			data->min_efuse_value = 16;
+			data->max_efuse_value = 76;
+			break;
+		default:
 			data->min_efuse_value = 0;
-		data->max_efuse_value = 100;
+			break;
+		}
 		break;
 	case SOC_ARCH_EXYNOS5433:
 		data->tmu_set_low_temp = exynos5433_tmu_set_low_temp;
-- 
2.49.0


