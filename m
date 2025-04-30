Return-Path: <linux-pm+bounces-26455-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C714AA4B39
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 14:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 039CB18917BA
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 12:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EEC238173;
	Wed, 30 Apr 2025 12:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUiKTT4S"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB0A1E50B;
	Wed, 30 Apr 2025 12:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746016405; cv=none; b=aM6WKaFn5PHiimYukl8D3CCxip5zP7JNs/skEEHO7DAqQqwrn0qJRwamrL72qOmVuBTo5zGlRZYJp95HQBRPUaKE+tr/3eunIxbjd85yVATsoACAH9e4i0mYfu/nIXmwpLg+5+cXmKWFzfG3QOe9zOpIyfSJs5dt0zMWYYEOQ68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746016405; c=relaxed/simple;
	bh=QE1eXScalgHxmtyBUCAnISzUPz40vvQfz63m7tDwp9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XFr/FcPy6lcoqyxMskiLxfMTXYl0QhbMC/uHxYFwWjLS0sivgjZOVNB5uMjsbt2ntN9rzuKR8TvfrvHR37WdDLfxsPx6J/B1ce+QBsWqgz1Fbbtge7WgUfKNBdKJl0OECBlEFCct/3CTJDTLgCIopNmLx1vy4qq3BQSIOChFaKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUiKTT4S; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-736a72220edso7297802b3a.3;
        Wed, 30 Apr 2025 05:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746016403; x=1746621203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wdSQcajlIK6tpma2Sr4n3i15ecfXz4VYvl04vQPW1MA=;
        b=bUiKTT4SnffW0AyWif+HrlTsXd+BJIXn8wWXC6vXVb1aIrJa5tlRjpSmE01sJfGv5v
         zGffr/r5301kPOvgtfI9u+mn/tzfwHIPhTHdsZBkKDjolEW5gEBxfDr4UuQ3kpIEYzkT
         fjlq+4SsZlFGePiBkp4SmZzfDHBZuxVHSd3xiYLPnd9zRK7bzc2gqHT5URiCGLzFDaJb
         0v41QG/2dcY3gpEZlSoPdNcaEeF11COQ15NqkXoLDHvrUSXVWdx6cH0RSGmEJYv2v7aG
         O1XZbfRHq5loDIW1B4ZxCCS3p3+G38WWl1qu2m7J2SJv8PhoCdq4R9h1z46zMG4T7OFW
         e2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746016403; x=1746621203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wdSQcajlIK6tpma2Sr4n3i15ecfXz4VYvl04vQPW1MA=;
        b=aCpFxNP3KQMHJwQ87X1cLZuW4l7l7UpDBxRkd7/YsdlvvoSRED59hU5TwQpvvdRjHg
         cILV5OZsQ+YunN1y/yvyxNt19lu6Naq05wvCCE94vQdiYJv38YecHyMwjdQGIeGBNtxi
         jDT0FfkgtVqoD7xZ++FRjik6XekSZ7t1+h3CxYUKRX8zxPs83LzdSGvskNNkhaC7pwwN
         d2WK4EN5qVaYWgzY34WbhTiIu1CKdzsJhxZzjP9U8Et8WLR8NGh64O+1oMcJ3CJicc0q
         w5Jyp8i55wwJCwKZ21PE4DQg/lcUCUAmsUVhOIKjCsHgxNvsDAgC9tUsGV5REDrpfAtQ
         AEvA==
X-Forwarded-Encrypted: i=1; AJvYcCVbmgHIcZRi9NUoZAaKbwiWx8dg4dI942m/yqGyv43mqzmur2WqObou7dTZ9QHsXN3EN1FBsZLjMIU=@vger.kernel.org, AJvYcCXB6OIhYwkldPogf3XPJHqXbWE2/UDaYr7RNmtFyCYQiXs7TJoMhLTzkqUe2LsIcFM8jKgSjgRt2uC4H4hQFlqaR0Q=@vger.kernel.org, AJvYcCXDCvSWfz1Cu3T0Mry0fQ5gExKfp45phxS9w+gBm6uAQeYSbmFY9ElwgSrmD6YrwB7//NlW+Ar9Fdr/R7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNwTmUheLBgjw6UOJMfSQsH3raFYC87wIkfwT/ko016g0Z+Qp3
	RXOtnV6b7mK2MqeqZNx6nC5nLyT8lHFzwlLPFEK09MFuK4RgyPhx
X-Gm-Gg: ASbGncspuQ+uBoM6BPms8UV2fIK+Fsc+vKKgc+GxmicLzFSYg8pDM5xjsnPke59cPGa
	LjrDZkIqHubFc0mOOivmrG57iCeSQGMzKMMfN3nWJOB0egfGwPhGdkmcgUleB3nIRIFLmkUIrTZ
	W9O1ETcAbmWu5TgK1soPGYGHUectO5ZfWTKR4t2tiyekMCI5dNjDdDo0T9qRn21uGi+sXHIWwEz
	YuRklUl4UgIY0FncgCHdXZsXQog/Jg+x5WkqYEke3VaaHkwkK1bVdV7zXkoA9YzQYOqRNYwmOg9
	tSq2a8AqBsjxTSXec8LSJnk2OwlXUO8+6yX655nqLQO+hkdOA6GGnw==
X-Google-Smtp-Source: AGHT+IHnOJsQBzhcQ9TpiZPoszqGigEVNYSAiSPMVGDgh4sokgxfVZhCYJ5Y/qEVZ0ImZ9OkSIKYNg==
X-Received: by 2002:aa7:88cb:0:b0:730:97a6:f04 with SMTP id d2e1a72fcca58-7403899a55bmr4461719b3a.7.1746016403161;
        Wed, 30 Apr 2025 05:33:23 -0700 (PDT)
Received: from localhost.localdomain ([110.44.101.8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a62e23sm1522627b3a.147.2025.04.30.05.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 05:33:22 -0700 (PDT)
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
Subject: [PATCH v6 0/4] Exynos Thermal code improvement
Date: Wed, 30 Apr 2025 18:02:56 +0530
Message-ID: <20250430123306.15072-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.49.0
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

v6: Add new patch to use devm_clk_get_enabled
    and Fix few typo in subject as suggested by Daniel.
v5: Drop the guard mutex patch
v4: Tried to address Lukasz review comments.

Tested on Odroid U3 amd XU4 SoC boards.
Build with clang with W=1 enable.

[4] https://lore.kernel.org/all/20250410063754.5483-2-linux.amoon@gmail.com/
[3] https://lore.kernel.org/all/20250310143450.8276-2-linux.amoon@gmail.com/
[2] https://lore.kernel.org/all/20250216195850.5352-2-linux.amoon@gmail.com/
[1] https://lore.kernel.org/all/20220515064126.1424-1-linux.amoon@gmail.com/
[0] https://lore.kernel.org/lkml/CANAwSgS=08fVsqn95WHzSF71WTTyD2-=K2C6-BEz0tY0t6A1-g@mail.gmail.com/T/#m77e57120d230d57f34c29e1422d7fc5f5587ac30

Thanks
-Anand

Anand Moon (4):
  thermal/drivers/exynos: Refactor clk_sec initialization inside
    SOC-specific case
  thermal/drivers/exynos: Use devm_clk_get_enabled() helpers
  thermal/drivers/exynos: Remove redundant IS_ERR() checks for clk_sec
    clock
  thermal/drivers/exynos: Fixed the efuse min max value for exynos5422

 drivers/thermal/samsung/exynos_tmu.c | 100 ++++++++++-----------------
 1 file changed, 35 insertions(+), 65 deletions(-)


base-commit: b6ea1680d0ac0e45157a819c41b46565f4616186
-- 
2.49.0


