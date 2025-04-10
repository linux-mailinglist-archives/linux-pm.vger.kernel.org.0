Return-Path: <linux-pm+bounces-25077-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E29A8397B
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 08:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9F7C189D92B
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 06:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A3E204089;
	Thu, 10 Apr 2025 06:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhO7ZP2u"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A20202C3A;
	Thu, 10 Apr 2025 06:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744267092; cv=none; b=ptcwqN74m48HDkTdzqWZg6a8PwZyYE/wSXAcGjctCpC/Cg789rf1b9Bh9l7iYp+w7m3sh/bRSOV0fi6DL4bG1kHlQYl9w2HyN7Hr0f3ItKlm3n1VKahsAxWs5LFbjz6KwblNXKUQEenWks8jXHEh+I2VrJOcnmq5ExbICS0e5T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744267092; c=relaxed/simple;
	bh=a78mvXEsQdf24KaSM7lb9nFxXXcB7yhjPlrvNEIwFrI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HV7UvEk6zLgAFKkXyr7PWEp2goScuXaILpkLrKdcXytyP/FrwhSN4APVm8BoZzIjz1R99egVsju1dYGt9DmmOAxvsatYKWoGbPP07fr793NOoz0maw4vSm3au7Ci88GYpSEiD0fRbMznobzJurh5c1B5dBr9gSgv1O0BKmklHHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhO7ZP2u; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-af579e46b5dso377476a12.3;
        Wed, 09 Apr 2025 23:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744267091; x=1744871891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NcMLg0bVur6QOZIc0MU6CnnrjgCDYQKJccLlapmx/J0=;
        b=NhO7ZP2uJRbznVT6v0HmWbAuSDzdF1jLYB6poVlpo9c5kjHyuTKo8khj8E6AN14eTd
         LhAgwBvBX8WbvxSOejRp4tKeo+D2GBiam+8FyNJGQr2MI5/D68+NridQ//QJg8F00wAt
         dG62HEW4A3TNWmt3ZCdpJW5T3bHT6jvOKmTYDW/GVqygdg1B7HlCZUStclY8vfarjiES
         L9FWht5ePyYfsI8K593EjHE1DrwLr4LwEMO4C1TKzaq/64tb8Tfexahl58Hq1PliiWQ8
         lP/3XOVXoNhypO/9HaQk50SmgdExhl7cqAL4NUMhwLP7q5bgr68TfBCZ0WcZ7xhO7Ay7
         Ar5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744267091; x=1744871891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NcMLg0bVur6QOZIc0MU6CnnrjgCDYQKJccLlapmx/J0=;
        b=Icm18sNJfFgLpwiYBDDEhV5wE3xAlI7C+oqWnyCsJdd0fyRhussu7IgNKHt12vPgrA
         Khr6prTvsCGmfy05oJYPRTZfeNbClroGBj9qgYErNCrM87wb/px6Z91QE0I9/xeqw5TY
         CDGnnA/7eVxK4pUNisqN6ud9ZDKJ0AIzcFTMdj8oVm3RiXMpqNqA2wk4jG4s1SEMIdQm
         tsr2Q8xVzo7M5gQdTajmHciucvNyNRgFPb6YNUWryBHdmK+Kt+L3Pc++0ESDUjg/CF1C
         tXo0dj1NGJRjrgixDnZ8N8n6LIcDsweQmu7kTBPUC5vk2Sb79kv61ZanCpH3cznzVQ1O
         Yong==
X-Forwarded-Encrypted: i=1; AJvYcCUpw1jT28sIVU6vk7PqvaolATccvVX1ABy4nYkuU1icCLJQXj8SgDwW+sZMNfC7auKNSs8tIZw1v/Y=@vger.kernel.org, AJvYcCVFNkJbZQMe+SPeAeZcAFlh9kRBQbpHjCfgnbkHpqyBmPXPpp4YakbrWX25ygMDHgaAqcExotbCG70h9gXiWmKtKJ8=@vger.kernel.org, AJvYcCX9IrKZ5hYrUFq3kjYFAMe1jgs4aIpjYtaTUpJzD4a8q8bc8lTGs7sASE/imWkNNlsUCHdwX/TWFA6wXkA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2xrUkAyWqf1t3LePmP0lvTomXR/FqME3QdQ80uJwASfk8LE0V
	z8TRnW8iJTpl06RheRMXIH4PPUyfGn78jNvHQlvP8+wgvWB+/j9i
X-Gm-Gg: ASbGncsJQQYQwstzQyfxPiphAb7uZOUSzo4V6DOPcKq9a/n8NStJUkTeQmPpNIv+iyD
	RU46gpu6+CyTam3b1Tx9jufABb+XlU6VngZaiAlmhVPSjKjJNAhpWly4lTx02q6HCCRaj7wd16W
	aMiATyaGVWt/VzhX1iXHzr/5vSXBQKZQSlWN30msagmf00vymQ60TqIP4Ok9kWiQYDeXkEVX06O
	GRm6qWoWBDoL4SrHL3eGoahEVv5Z+OJ7N4JLeyMRIFDmwTvJfkPfmOp6sJq2BMn7Ji2CfVWIcUd
	U7YLumVHtJ0pANJXnVUZ+Py5yU53YpDIek7pTX8qHXVv4MeB+iJqRVhBvSu+n15KQQ==
X-Google-Smtp-Source: AGHT+IEzlFiw9oXOTTn6w00Ry1p9p+Q6HRePqSFZX9x05obeKymI4HDix9H1LmUQm0dEJKoBbpGD3Q==
X-Received: by 2002:a17:90b:37c4:b0:2ff:618c:a1e0 with SMTP id 98e67ed59e1d1-307e9b3cffcmr1923630a91.29.1744267090551;
        Wed, 09 Apr 2025 23:38:10 -0700 (PDT)
Received: from localhost.localdomain ([103.221.69.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd57865csm973145a91.2.2025.04.09.23.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 23:38:09 -0700 (PDT)
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
Subject: [PATCH v5 0/3] Exynos Thermal code improvement
Date: Thu, 10 Apr 2025 12:07:47 +0530
Message-ID: <20250410063754.5483-1-linux.amoon@gmail.com>
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

v5: Drop the guard mutex patch
v4: Tried to address Lukasz review comments.

Tested on Odroid U3 amd XU4 SoC boards.
Build with clang with W=1 enable.

[3] https://lore.kernel.org/all/20250310143450.8276-2-linux.amoon@gmail.com/
[2] https://lore.kernel.org/all/20250216195850.5352-2-linux.amoon@gmail.com/
[1] https://lore.kernel.org/all/20220515064126.1424-1-linux.amoon@gmail.com/
[0] https://lore.kernel.org/lkml/CANAwSgS=08fVsqn95WHzSF71WTTyD2-=K2C6-BEz0tY0t6A1-g@mail.gmail.com/T/#m77e57120d230d57f34c29e1422d7fc5f5587ac30

Thanks
-Anand

Anand Moon (3):
  drivers/thermal/exynos: Refactor clk_sec initialization inside
    SOC-specific case
  drivers/thermal/exymos: Remove redundant IS_ERR() checks for clk_sec
    clock
  drivers/thermal/exymos: Fixed the efuse min max value for exynos5422

 drivers/thermal/samsung/exynos_tmu.c | 62 ++++++++++++++++------------
 1 file changed, 35 insertions(+), 27 deletions(-)


base-commit: 3b07108ada81a8ebcebf1fe61367b4e436c895bd
-- 
2.49.0


