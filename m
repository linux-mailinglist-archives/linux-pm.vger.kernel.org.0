Return-Path: <linux-pm+bounces-25080-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C1BA83985
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 08:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4982117780D
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 06:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0492045A0;
	Thu, 10 Apr 2025 06:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5r8k8MZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799FE204588;
	Thu, 10 Apr 2025 06:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744267111; cv=none; b=mzirZ3Ys4XeDDvYfGom3LeNtWIHu4KI1JMci5cy12wjeTd8gx+i5xnmwpGwf5cbuMi18Lqru9tDwU+jRKUSYoTk9CzGY3yIUL9s692zNzyWdMWvfwI7rPKlHl/6PLJsgAFljaICJSLIVZZ05tG/JHAsawuxW4V9vYqKKF9VSdFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744267111; c=relaxed/simple;
	bh=dSHRhmk880+LUvoNTvzX98ByhUndNuKtjnVonbl/qlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q2Uqdx/VSR7XYhYIRU2d2Py8Anyp3ZukodBW/vTDYvrB7LUJ/IX6o9GpjD0zmWxmua3MbckrpGFzuqKRMiIU8lKPuEIBI2KwZ4oh5vxVvVl/fwCCaqOD/Ba4tHq7mKz1+lgxb7VaXxuJHQfiAA2v3dl5qIPTdYOsoWpcEYd9Tqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5r8k8MZ; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-af50f56b862so371513a12.1;
        Wed, 09 Apr 2025 23:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744267110; x=1744871910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pwBWVtKLvZUX90IaL1GXJa6X4Osy8NtQPUZg6YVkZI8=;
        b=X5r8k8MZEDb9xBVZY2h5NjFvpecFFuwO8eavTrJUX1rA8kTgzdS5Wtw58qSwt1SIOU
         M1Ande5GVRI0nRIsDNuy7RMdWDJJ2c62nvmYnt6OzE4jjebLTWhhfEkStO+9XDH+Skiz
         fMT3WBlAjxanIqRWaxsScQPIxNkFk2UpcMA18qX0muXhGWR7BmRTVNTAMmlTCOjVgedD
         k+lokIuKXZ7ye6Z6p+cAKWBbCwzzEsNEkRJYMPnVlT9Zo5qn3u6lmN/qlB4emxhDMUSv
         x+FYL/GZV0yXIYkqRa4fOFNvaV4wM01A/zrjNQ6BTpzSB7FVpuKIUuVDg+5uYmdK0RRL
         V/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744267110; x=1744871910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pwBWVtKLvZUX90IaL1GXJa6X4Osy8NtQPUZg6YVkZI8=;
        b=sJwgVPK09UaGSPsDvZNYWDzt3yINnoRSuNFkXXVf3CyxB2wp5G9mbYSpMf8WUg3Ylo
         QS6Ze5fuZVJcAlrkQXZB9c02p/iaIBHmOd+/WlzO2sq0JmqPmw7Gw9zeim3T4y0ddj8s
         Edi/g7jqSy4gB6PZvOEnYI6NgPELIu36jVjlnUiXGN9mKex3HRGgbDdqdgpmVl0K7kJq
         enXdsmRbIgoMDEc3UJT1g4Cg5GzQQFf324UWnn8/+YfV5BVHgu6jptuwW4WDz6LdeTxf
         nU02alddW6iJHVJxG/rOF1OzkVEfevdQ3PDKaeL4GLm70wZqu3uor30b2tBd6DyK8bv6
         QMmA==
X-Forwarded-Encrypted: i=1; AJvYcCUklbX/1oVU/OL1BecUfo0z2LtFF2jOmL19DwOSibS2Vu6o7Q2f9D3XuV0Ud+D+/UTreNMKsIsbjVejAwtSGDUfC0M=@vger.kernel.org, AJvYcCUmVN2FqTen98jA/fkQ2B0CCM8CoSsuKGZ93xL1/zJjH5MEVPDq7qPH7SK/tqC24yq92wLdi2jylRvZ094=@vger.kernel.org, AJvYcCVGVrBt8JBdO2EMpcCEQygVMWnwuWRc2tTJoqWnxvPgTBmAYPUzR35JtROBAhUJNEKFmQ/7E5xE+k4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/LrBLr4+8WzSRtgSIp2g+QsDDdqEw7gePUd8w4Lo2SlVU5Oy1
	tUjXTceVr8dahXgP5QuQy+nBKRt9BYYXjXnuUTMfs2Kolhi4+sMT
X-Gm-Gg: ASbGncvuc3UcHy2XTQ6QoWNdIWidxWBBQIihTQW/jN+Xi3S8ZqkiBhismcFfydfFrPk
	zd25oSSXK52fuMAnaaY8boJcL9MGw/Daje2TzoOFpv7taL2PnHe9htfVUxofunA7clo0XTtK42b
	NAIh2mcxlPsus4pv2ahZwfxV1Vy5t/xlbQfDTOzlvRAJrIogPVN9ziQjfzT258B6fa9uodBzdLZ
	sNoQrMiNJH+K9d+nnMNJpnKiC72dBAfAy8Ja99vmgf+f7SGZn8tNHTvS/xdrgMBWtJEEOYUb33T
	MMlsi1j/1c1oFPaRfg9VgF1x55qwK12tys55S5XIfXggGgdccro61CY=
X-Google-Smtp-Source: AGHT+IHqaItgHXzm5GD1OOSPTM/mlSU8yR/6mCWuApDW+XD5J+FRkiOjtHdGHPDLxBBGTZ1nuFcFiw==
X-Received: by 2002:a17:90b:56c3:b0:305:5f25:fd30 with SMTP id 98e67ed59e1d1-30718b5408dmr2785207a91.4.1744267109577;
        Wed, 09 Apr 2025 23:38:29 -0700 (PDT)
Received: from localhost.localdomain ([103.221.69.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd57865csm973145a91.2.2025.04.09.23.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 23:38:28 -0700 (PDT)
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
Subject: [PATCH v5 3/3] drivers/thermal/exymos: Fixed the efuse min max value for exynos5422
Date: Thu, 10 Apr 2025 12:07:50 +0530
Message-ID: <20250410063754.5483-4-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410063754.5483-1-linux.amoon@gmail.com>
References: <20250410063754.5483-1-linux.amoon@gmail.com>
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
v5: None
v4: None
v3: Improve the logic to convert if/else to switch
---
 drivers/thermal/samsung/exynos_tmu.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index ac3b9d2c900c..a71cde0a4b17 100644
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


