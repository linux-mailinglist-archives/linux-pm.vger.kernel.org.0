Return-Path: <linux-pm+bounces-23768-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53945A597B2
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 15:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14734188F85C
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 14:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6001322D79F;
	Mon, 10 Mar 2025 14:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQNkDcHQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55CA22D799;
	Mon, 10 Mar 2025 14:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741617322; cv=none; b=BZAXxKnwjhiSjejp2R73xHkNV3xyBXt21YX9nkDH+VIfcOJGb/zZwpzcq8x3XXrGDWBMuFk4kJnDuOHNnTVA4G7Wvvwnk84YYbuIf3izl6vyBYYs+T5uEQoXrlW+faEIoZuLcGRO+GdsAtc7xPEmwDaXvBlG9aQfcA1JFeWnIls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741617322; c=relaxed/simple;
	bh=Bd0hvtpCmZJet9xwoJfrc2/uWmqC5K4WKXzpW6jKXP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NVMxPNeZOWQ/H4rNKlLzzVOWD7iNi988LnQLitylgZ9oTBc0wKAb2WGqUx/EYF22VsVtOTkkWllK2h7kSVF6doggpaG96UvcZFB8GwQ0XImAA9K+ndpFwZA8kw2nHfmRHoYQVdtJ1Os+52RhugNAr/S7MZB9leGYBiZ5hm7MDcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQNkDcHQ; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ff615a114bso7539214a91.0;
        Mon, 10 Mar 2025 07:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741617320; x=1742222120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+QEal24nNpFB1sUg3m6xqbmF2yfFZnIAbP+jKYgY2yI=;
        b=WQNkDcHQzbT8QzzFO7NXuMrNM5AWiu1L8uB3CvNvjMLKQAKqQWea3VMji44W9aai5g
         9pfaMELAR56NMjNWlVTS0QdPgNR/DDsVcHWFxKAtjYL+bs9Q8022XUd3X6kjAvUxt6Qo
         MR1+ATZTMtV/wCnwRYf/0DR2pHd8pIj1bRzaFAbNlnZRdWs05JZEuYRo6AxaKmVHRzYl
         uZFHF13nM+uYNrOr3RL9Lt5Rc3tLHICHiO1Mnz+rlWvFzrB8hECd9OKhPwjwGCo8wUGo
         NEtE4pgEikN3TPQIWSYwgqmwEZfwHz+jF3uUvvqhqhciXf9RE9ug6Lj7Jyc3tLYBRumY
         7LbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741617320; x=1742222120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+QEal24nNpFB1sUg3m6xqbmF2yfFZnIAbP+jKYgY2yI=;
        b=ae4sHuFaG/MfWNS+YKrdVyGUszN3QJoNv8sLkYXAkbCWoW+IB1LJZTtDmxTGC7+BZI
         nHycrpHh23RtF8k5nFVOkoopxeQvlqmRusr5sncuECpFrN8/Y2kIm8pLKu1oBTW3zMgy
         cTz4ZFNXwCOYRAbRVpX/M/kKwHuSUn1b/AEBP/Na0PIpRD9GrWVvsvuRiPkjRTe48wWo
         v0Uc05le0Nwy7HtgDx7+Lg6se1DzxvCBqlpXyIz83XNyhvo71IDLAOS7a63sRa4kBLSD
         tbn0V/n/cD2GYZF87X034Nx/t0aYsZTksivzDJZzUJQPZe5l23xbARj6DOo8ZcbH/vhR
         4S+g==
X-Forwarded-Encrypted: i=1; AJvYcCUqgFeT0Is3qoazb031tX+Jf1XeS2mcccAxEB+5KCmUmfpuyLamwgsfjLiQv+wfl+MT1apgD3atxOjTFFs=@vger.kernel.org, AJvYcCXYzlv0hcU2TR/B9Q+rtA9IHUZs9QOadHQj9FtxeHSndTE+FcZgx+ZGSes7HWqWXQya01QQKp4HFRAAvMOv7sFB1v8=@vger.kernel.org, AJvYcCXmnMbzpTk3nWSh0iQDKViOjJxDWVdjw5T/JFRnLZvie9Qn/0ZkhPRAYVvnNHhT6CGuNtMEKliH9F4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7dI4jIOqI8eqQyAyGDJ/PHRpw3hRo2DHh74PginspclVhAoVi
	STk0+LYGsUEX1Nimg6/EzQw/nWnM03sxImdQw41CWbqwgGsBcW5h
X-Gm-Gg: ASbGncubtGQY+Cyl6jeubBz9vb27cgM4KeEJyegoQNr+i6+FkY+bZA+s5YekBeeMldf
	PhUPhtzlAHFpLDD/LfpSrLDQvV2IS4bYhn0Bl1Mq6zMz4dkLOiGi2/8FkL1Aol02Kngq9MtRrUP
	3TryoX2S1EGZoT1Nr88bkjBDF+env78uBhSk6YaV3N5pcafkpexIthHooBWbhUO1vmc98+Hi4w7
	mcp3Oecmj6DZyMySO58YKsVW4FWygOxnbgYU5oy3vukrgbtieL9Cbv/k6CtXCvZC3QfhAe3ONx8
	8+ErsTmlTm4ybPJLqw8JCMMoC2dQlVyWAVmkwCiERCPlfysMZaIYeLA5Pag=
X-Google-Smtp-Source: AGHT+IGcgMPRI9hdBCeUstUHpb1PU/WnBc4AvJsnipWByXBWrlcqIrz/Leyj4EN8DuL9JXzghzFyRA==
X-Received: by 2002:a05:6a20:cd0e:b0:1e1:a789:1b4d with SMTP id adf61e73a8af0-1f55611c851mr13246121637.15.1741617319780;
        Mon, 10 Mar 2025 07:35:19 -0700 (PDT)
Received: from localhost.localdomain ([103.221.69.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af281096763sm7785900a12.30.2025.03.10.07.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 07:35:19 -0700 (PDT)
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
Subject: [PATCH v4 3/4] drivers/thermal/exymos: Fixed the efuse min max value for exynos5422
Date: Mon, 10 Mar 2025 20:04:44 +0530
Message-ID: <20250310143450.8276-4-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310143450.8276-1-linux.amoon@gmail.com>
References: <20250310143450.8276-1-linux.amoon@gmail.com>
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
 drivers/thermal/samsung/exynos_tmu.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index ac3b9d2c900ca..a71cde0a4b17e 100644
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


