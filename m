Return-Path: <linux-pm+bounces-32287-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A0AB24A4E
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 15:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B5ED16B3B4
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 13:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB342E7657;
	Wed, 13 Aug 2025 13:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Muy+WfJ7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D612E7188;
	Wed, 13 Aug 2025 13:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755090643; cv=none; b=V6Vrft+XaOvNhtIn6dEXAsimWBI8Ti4bvW6XNL2Jwg/8/V5r/p3tgx9aVPym3Yi0bng+PBHzHPuo7hqWAX75pf/blZudhc1jrhT4N7WuBzCMlt7xeGy2PyxlxksSj+VVLczsMqAYxdOlP7YufKZZFC/05beWIvJTg8c44qBcLaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755090643; c=relaxed/simple;
	bh=b5OW2nvC0OiS+NDU9XbBImsCJbeszsgz9w9AdKXNSzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qmIx4slUNsLXa4c1e53aqw5Ecb1lISzF1aK02uMlP5Vsqr5ZIalDLronOPWhQgRvfXkWYy36rwYS5iNnYZHwt56fprWVKrML31vaK1XQ2ZurghcJkedXnHB9mrkBWHce/UlrKO0AU9bn85APrrPcZTyj/V46/HMllIvUyXopxfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Muy+WfJ7; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3218283cf21so4300709a91.3;
        Wed, 13 Aug 2025 06:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755090642; x=1755695442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVrou259Nqx2mf6vUTvrTuOu7ushA+qQgGCR5MKGSus=;
        b=Muy+WfJ7BVXgwy8ozeDHvo6Wv6ox3Vpwrzv1y7Jlc4K2XhHtP9vFXmr/7x3KwSrkW3
         o/wfzwLY5y3wXsXCTi4n0p7bTAcSkldwn47Vv4wkq8E93KB+munwZw4kH61g4ExaAZXH
         gaiHpId11Pd/XoymfST/l7+Z9+bBZmW0hW0+2E6xjhwL/DdG8946gBovIqgj4AAboZwA
         4p1h1alSQ+o9AGk1bhErjr9d24TbN8J3bCj+ncLFAcIJqUJn2ahZeaUlXFhDoxjRxzpG
         QpSNLS47Z9LCsimyavZZvI58FBdWMifxmCz5a3UTzM6vnySM0NVOEMCjLjkoVxCKrPsV
         /ung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755090642; x=1755695442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MVrou259Nqx2mf6vUTvrTuOu7ushA+qQgGCR5MKGSus=;
        b=G/UQ+p+69IzBQdlYWF+JfZZc4NTZpiqOV/d/3OgvqaVgWceczwNt0l7I6I4vWYXgZK
         OV9fccQd0PFy5kauwvzy3FZu/gq8DfPBVkclSAtdrJVs+E4kQBFYWNZeQCPvgycuhKP6
         aWaYZTPqfQUmu+19CmSgC7veuODXlUSRFTn44aiiOKsENur++OG33LwUtTJnSFJwtR4G
         POytco88eNcDsxk37XjgdbjYHNowKhekWUp6hlhBWhGvKmYuauCCJCC/sc3AaSgMtH8R
         Zcx53Id/1TdhaNH22BtHa7suFZnooRV7tarBwCeWI173WPCecSkUykqT385NymMRy8l3
         2U8g==
X-Forwarded-Encrypted: i=1; AJvYcCV8sJ9Z0K6d3crQUokddx7YJ27If0ZqReBw7AREywlmfLJY8VQDTC9XFg+RzsU+x0ZJze3B0P7slRrp0AE=@vger.kernel.org, AJvYcCVI+sFSa5mI8SnfpmPU4qmJmHAvQCTkmN8JbQQH3rRbtVE5+EGQlF7JhHfgzCcaKj526ucccRqcLDEux/IEQZVJUy0=@vger.kernel.org, AJvYcCVoWMmHTH08xQJfbe0O1R2HoCs7ii0OmiHzF90H0Qdt+8Fn99+vjoe9qbLcFLeRegA/TEcUBi42rec=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKjiFbTDARYgh0PM6HfObfvdWVcfdzSmLfaLa1/hPmjIxyp4aI
	V76yulxCM4Ggw0ByDtcT1MTx2KHbcdS+B/2fnZE92jQ8mWahzJ6bHTPWXgjVxzth
X-Gm-Gg: ASbGncttz3K878GQg0JbaXnMWEhisZ4kodJx4HLVni9OGv0FTnj8eZyXRAUlZ080JJW
	OcNDxIJpknZnlUvt3h7A4caoU/QisLXuHlzP2E9IMqUnBBdXxcMCgAETXRc97f91Hk/hSP8EYro
	f/hpapnczyJxEVaNKDv0atuMoaureTiKukkgUyDeuhBYdC4ewAlGFbZjM3MY8CF9ek4XGzVBw6V
	RGNktJJOigG4Vx1exAXMErI9QlFIaLIApnwWDAW+m3NPtsvbkT7K+kMMOAC3xQL+z+cYWLV5Oy7
	xmyaY3VJP223SL9lFeJCR7EyyEDYMfMKSoj3q0i5shAjKyYW0aUw86K6sxIvvwYXl3RGZ+4DB9w
	iVN9js2Mc+xy2Cl2e0EsRU0yEWTjW8zk=
X-Google-Smtp-Source: AGHT+IF9eIDvu72BaiBaVH/s5UjG5F3YVyyMdRM4uurQwBv+OhAFEyxqshUJkkmFATqSx/qzFuLPNw==
X-Received: by 2002:a17:90b:58e7:b0:312:26d9:d5b2 with SMTP id 98e67ed59e1d1-321d0b2940dmr4886750a91.0.1755090641390;
        Wed, 13 Aug 2025 06:10:41 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.216])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32325765df6sm161504a91.12.2025.08.13.06.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 06:10:40 -0700 (PDT)
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
Subject: [PATCH v7 3/7] thermal/drivers/exynos: Remove redundant IS_ERR() checks for clk_sec clock
Date: Wed, 13 Aug 2025 18:39:47 +0530
Message-ID: <20250813131007.343402-4-linux.amoon@gmail.com>
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

Remove unnecessary IS_ERR() checks for the clk_sec clock,
the clk_enable() and clk_disable() functions can handle NULL clock
pointers, so the additional checks are redundant and have been removed
to simplify the code.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v7: None
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
2.50.1


