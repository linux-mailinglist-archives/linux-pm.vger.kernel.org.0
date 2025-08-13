Return-Path: <linux-pm+bounces-32284-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4351AB24A35
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 15:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94C325844FF
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 13:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB912E62B8;
	Wed, 13 Aug 2025 13:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzDWttRR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF36E26FA6E;
	Wed, 13 Aug 2025 13:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755090618; cv=none; b=kw+8CQ6CoTIxdXTBkNj0dKjOeAslhkSVZFt0oQsoj/fuwV51pe2Gd/kwF6bwurAa5si0Z6Sujjlj/MHpEmSKrt18JSf44tkmPjsZId8jOy33fBdLb7nwcevOVA3YVNw6CMZhaB7Nw8XhZbZXZjNAch2ESLrCpb98et9WjDgaNK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755090618; c=relaxed/simple;
	bh=PxRLgfDUZ5M7CMDjuiGWnXQZWXZ4r0JiCDjmksMnW84=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C6yYbYoPYJRuYodsjeEo3SyfDQ4LP179+vaB6r6BolSpZzLxDpducLtiwMV7QppKefAk8sAaIbnveac6OzmkJdZyDJw269THmQx5ahGx2MkdYLx9V/qbtaS1pTu049b3K8cBkcbr3CIm+FhZHWHsKgEYBqgzkgTBC++2QmlTuPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZzDWttRR; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2406fe901fcso68847065ad.3;
        Wed, 13 Aug 2025 06:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755090616; x=1755695416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ScJXeGO5IweQbEuH9vxc5nxPkJnywpOyzMXLuxo14s4=;
        b=ZzDWttRRblMmrIa/ZnO8jRnqnODyFUm5GmtxEn/1SLO0Ts4fhgH+VTbPfByO5xlP5B
         FanXtuUL04+MSMdLTz51LLwYD4oiW/WOW06H4XUiUK8eOElykhNPK+zU537TxxT96HLH
         047S+2CZLNabt36XSobf7tCZ6IzaGNFi7n3eNsu8SCKnvhkVxa7eB8mYZLtdjp/HrAGs
         UylqfOIJ31Sro+WHhsNC3n2WsXnIKfOjvy+E8XqaSTk5GEMZj1zMAn12LfuHFzbrohGr
         DTFfojrd9Ow5QPx7gxX5REhlLVxKDWJbTqGiXuaczZrs//C40CE5R7bixoJcNwPJNV6b
         qOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755090616; x=1755695416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ScJXeGO5IweQbEuH9vxc5nxPkJnywpOyzMXLuxo14s4=;
        b=GRiWQiy/4yxU11XhcMjiMKGs2dCJx6Ifqzhg4apBWeMrd1Lb7XVmeMnViCtEmMbBqr
         85Tam5pYaKnHhcUCDCVppRDruDdU6lJeylACbYzGGhQsy7Z9qkUgCd5kMoIWEtJ2QP5Z
         2n0susWlHq64vaShDzt8TM8ESHPrPiF+Uu3ctFHxpFdwgCkT73xetLgThCbIw/JbRRhw
         iDMN8CxqJTPAodMumgUUs7WQYO2W47jCGxjJU8vIeglEZYeenXqhiv/AYNGTL4sNZ8RM
         IyJwf6DDhRJA+Axom9jy1VtZ8b1GCqgOkYMQdF9TLVxLNeaxMRqPsDavEewX+3/h6kd2
         kw5w==
X-Forwarded-Encrypted: i=1; AJvYcCUJwulRz/bE9g096Y+218zOSR9zOb+Myq61a7yfBmZTtyEJM7dqopkuyzPayTRsLYxrZQ0Z+P+94Ck=@vger.kernel.org, AJvYcCWQekjQsABMKWLHZZMW95UYCJAc4ZKVYWRIlhy3Cm01TiyGcXk0HZh9FTtGOC55aUYf8Is/xf/nPcACuUap9vO97AY=@vger.kernel.org, AJvYcCWzS+gVlPcBvF1oF7bLctPvoGJJVIZga2nAxE7v1ShJFzM7UF+xi6PtTCbpzJPapRQCHz/wLINLFRUgaAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmaivVWzy+V1Bt2VxYKcbE/yzoWvHE1Uid0fcRe+Cbrb0tIUTQ
	u6YZejHss4Lch3mfB3RZ9M6d2BOAO/EmxmS90SSdsf7vkDqhn2yAtjLwFeex1DN7
X-Gm-Gg: ASbGncsp0/erjg4Uv0LUnd3o01xfxYluDPVmUwCpr8nQwKuDlwkGetcdbZo2z/QDm6P
	8GLWYQHCXUFxBknVC2SwP//DgtdZQcR6RlesP4nL4Y8MUQkxhxRKsnfYIoMVSwijeFD2HaIFMs2
	fZEOBynRcCTrCeEoicRgsPOtO+KXSbKMyHjBwIg3VuAIrVmpoqfD/CVpWh6XMbpG6I9rcNKiXJD
	r2Zi3DxfoCDKaVgMYuaT2j1uNYIM0PPukkrBp1t78VRo4JwDdp1B8SEEd2IXyz0Ycn5KTAsVIwZ
	QHKzG49x3oJ99NJj3iA3kB0a1e+5JVNZeC/d0fwycw/CO6XCyPw3chHgEJzLkw/wqwlGU/gjcIC
	Qg3p3HblNHDy5gCRp5aapL/UmwvCemL8=
X-Google-Smtp-Source: AGHT+IH33+Bx0AadFrZDKSUeKUgXROT5vWDMhH5ZAyjluyaTV5iWp5JdCqXwDtIfUbpUHGZSWzxXnA==
X-Received: by 2002:a17:903:350c:b0:240:99f7:6c10 with SMTP id d9443c01a7336-2430d0dc5a5mr54548855ad.1.1755090615667;
        Wed, 13 Aug 2025 06:10:15 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.216])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32325765df6sm161504a91.12.2025.08.13.06.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 06:10:14 -0700 (PDT)
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
Subject: [PATCH v7 0/7] Exynos Thermal code improvement
Date: Wed, 13 Aug 2025 18:39:44 +0530
Message-ID: <20250813131007.343402-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All,

This patch series is a rework of my previous patch series [1],
where the code changes were not adequately justified.

In this new series, I have improved the commit subject
and commit message to better explain the changes.

v7: Integrated my RFC patch which improves the IRQ framework
    for all the SoC link below.
    [6] https://lore.kernel.org/all/20250616163831.8138-1-linux.amoon@gmail.com/

v6: Add new patch to use devm_clk_get_enabled
    and Fix few typo in subject as suggested by Daniel.
v5: Drop the guard mutex patch
v4: Tried to address Lukasz review comments.

I dont have any Arm64 device the test and verify
Tested on 32 bit Arch Odroid U3 amd XU4 SoC boards.
Build with clang with W=1 enable.

Please sare the feedback on this.

[5] https://lore.kernel.org/all/20250430123306.15072-1-linux.amoon@gmail.com/
[4] https://lore.kernel.org/all/20250410063754.5483-2-linux.amoon@gmail.com/
[3] https://lore.kernel.org/all/20250310143450.8276-2-linux.amoon@gmail.com/
[2] https://lore.kernel.org/all/20250216195850.5352-2-linux.amoon@gmail.com/
[1] https://lore.kernel.org/all/20220515064126.1424-1-linux.amoon@gmail.com/
[0] https://lore.kernel.org/lkml/CANAwSgS=08fVsqn95WHzSF71WTTyD2-=K2C6-BEz0tY0t6A1-g@mail.gmail.com/T/#m77e57120d230d57f34c29e1422d7fc5f5587ac30

Thanks
-Anand

Anand Moon (7):
  thermal/drivers/exynos: Refactor clk_sec initialization inside
    SOC-specific case
  thermal/drivers/exynos: Use devm_clk_get_enabled() helpers
  thermal/drivers/exynos: Remove redundant IS_ERR() checks for clk_sec
    clock
  thermal/drivers/exynos: Fixed the efuse min max value for exynos5422
  thermal/drivers/exynos: Remove unused base_second mapping and
    references
  thermal/drivers/exynos: Handle temperature threshold IRQs with
    SoC-specific mapping
  thermal/drivers/exynos: Refactor IRQ clear logic using SoC-specific
    config

 drivers/thermal/samsung/exynos_tmu.c | 279 ++++++++++++++++-----------
 1 file changed, 163 insertions(+), 116 deletions(-)


base-commit: 8742b2d8935f476449ef37e263bc4da3295c7b58
-- 
2.50.1


