Return-Path: <linux-pm+bounces-22174-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8599A37758
	for <lists+linux-pm@lfdr.de>; Sun, 16 Feb 2025 21:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9765D169088
	for <lists+linux-pm@lfdr.de>; Sun, 16 Feb 2025 19:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB5F1A255C;
	Sun, 16 Feb 2025 19:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKv13VV+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FC31A239A;
	Sun, 16 Feb 2025 19:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739735971; cv=none; b=HCF5nXMAJlp9oCp0EKigDV42dme1zTYYVkA1hwqxGMG6YxNIQFV4FlKtDugp6HoCj3llD2nV5WF+xyGRaJxgOv6XF8YFIUisHY6EJJBBec/GrHrdM2zpm4r1t4jVEYXMSQ+bh3eQrwI/2Ki5mOPRipTEq6kqCQ70IxwKKhA349I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739735971; c=relaxed/simple;
	bh=dvfBmclEY5NMi4uT22TQeDgcdw5WxDAB63id8ISXwWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BErZmjE7hz1XBoinKokDbujNgQqApfpscIzhMI0Fc32DxeEyjI1mBgc35Le72byi2O8n9YIVT0zZiAjEiU0dYFzhcbpWwwC+UZp/bxMPu5pFPUC7eLvxU42/DouUEPgaD7zZ/aPTQMdGmvi1jFx4kXXKq3AiJTB+OXCEa7D/Ib0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKv13VV+; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21f61b01630so73303265ad.1;
        Sun, 16 Feb 2025 11:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739735969; x=1740340769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fU2o4X95qtgokOtXyuTuOjB5JSG2sKXAjoLOfp+pRM=;
        b=bKv13VV+TBYRKjKiedWHi5kt8ARIdBZn/mFMrHYW5iKrgKUrPJ/aav4nFY83JhdvXx
         ZMGTYz9INEee720aZ6evugofd83Aucm2VAQ019SKFZaOCJPE63plXU+KpqCBcoNNu0UL
         DzepZVxYWEA/JWrRozDqquViCz4v0WE0Xh7XkFw3K5n61jwEUY0MOp5hDEiH3bWQ20Lw
         +m8luWiaN6cobWeNNmDo1Fgf8JbmK4cn0V02STbiMhWrxqivGXPCFQNcHNyeG2MlfrPB
         Z5UHN9uRTS8fPoeKZmunwCG1AskAQHVWQWDMWktgs/pOqU1tQex5Cb0iieCsQnL+YlAM
         QKFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739735969; x=1740340769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3fU2o4X95qtgokOtXyuTuOjB5JSG2sKXAjoLOfp+pRM=;
        b=cih6jkfCQN/DDqXlXfFNpmdZx4tMDm/OEF5OiGslBDTvgJBilZflA2eMXKin8QaAKJ
         EbtpZsnBl8oHpk/OdhgJi7wDlGn3QiKrKRAuYBNYkS/h87bjlblOs03+2GUCXYNzle5P
         14uZ6HnYIciUIgjegmJD8X7Khfezd88I9eHJTOeNAozN3T1sNeJgOQJphAMpr3JhNOmb
         Q9HMN/qq+EoMpM1yjsdGxJaiITZciG5aTqH0ka8UM8jkzVfcYPVkYTRCKTjFo5Oi3Hbn
         3bDLgila83vv2/ZrLJlWJdnFh2qv2Av1Ed3+6aovTt7nMrvIxbxMyAnP5jB3z0H6zMaM
         mJWw==
X-Forwarded-Encrypted: i=1; AJvYcCU5IfpWJAmgVT4FKG67hu3wFZFIXdS/VYj5T+U4xm24GBjfxFaDzfmaEmbHaVhgp+c89aYJiI4xM8bqBv+UrVpIEwM=@vger.kernel.org, AJvYcCXMa5FOwyRDd/pd36miSPq8d+qEvEi1eBtA+n4O/FXHnpCB4lABZFV6RvcfAjQIQto4dw/wAg0JQJw=@vger.kernel.org, AJvYcCXu8VBNYOtAO/7/5mRCPreCD8nVAkljhAuEMAEHQig34BaENQH1f9Aflqjbxeygm0+0OAW5rxNLD6q/e2U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Z/cMUXSqa2rRwQ8lBM/AFD0sq+Yd86+wyIbK27NuVdaqkaps
	V+Q6YYf10TSWEvCgaUOFyEZssopLdAinWQGxhYYPCxb6G8kfDcjHUaPe1g==
X-Gm-Gg: ASbGncscWbS/l9rrB1/J/pRjXB3qX8T9Yb+yllMZKZYyZXXxjgvcC5GPho+ejQnF+7u
	Ajid09tfgX8j3nQ1KsEXHdxsfvhbqZ8XH9PwahIWprnPpJrpBzBmnfPqcq4S53ftfRPJ69X3E8l
	Sdr7RzBhyXwaN6a/yd54GzssA1twxcTJrZtwsmdX+hvnOyc/pJM9IoXN4hiaVjTRFZr4C4GOurX
	I2CE7TdS9M6aI+0FTVG0E2Oj1tw4b4/7ODOLTbrSnFQcDtLk8wC2ihq3f7ADhQY195p+PwRkIqN
	Gwur87S1YQ92fWyOGGMlzHtTd/00KQ==
X-Google-Smtp-Source: AGHT+IF7AzoUr1XgA1+Ea19Qvyb6/a9hAQAMMD8i2pvWMA2A5gLxhj2+OjivqU0UpmUYjnEdPJhzfg==
X-Received: by 2002:a05:6a00:4643:b0:725:f1e9:5334 with SMTP id d2e1a72fcca58-7323c751ab9mr30761565b3a.8.1739735969416;
        Sun, 16 Feb 2025 11:59:29 -0800 (PST)
Received: from localhost.localdomain ([110.44.101.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73265098570sm3023559b3a.22.2025.02.16.11.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 11:59:28 -0800 (PST)
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
Subject: [PATCH v3 3/4] drivers/thermal/exymos: Fixed the efuse min max value for exynos5422
Date: Mon, 17 Feb 2025 01:28:36 +0530
Message-ID: <20250216195850.5352-4-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250216195850.5352-1-linux.amoon@gmail.com>
References: <20250216195850.5352-1-linux.amoon@gmail.com>
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

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v3: improve the commit message, fixing the warning wtth W=1
---
 drivers/thermal/samsung/exynos_tmu.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 8d26000c73aa..fe090c1a93ab 100644
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
2.48.1


