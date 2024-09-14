Return-Path: <linux-pm+bounces-14217-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05724978D89
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 07:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FEE0B25798
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 05:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B72199BC;
	Sat, 14 Sep 2024 05:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eoVSVQP/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B0119BA6;
	Sat, 14 Sep 2024 05:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726291493; cv=none; b=Yxbe3lFEyIw+T+M6/MNDx34sI9p4JF0fR5fOuH30H7jNFS0U2BmXT/fH9V8a2KJM2gwpj3irfWtTmo6+iY1c+0MaFLHfsMukn0+E9eu9S8qSDzvl8zCFLOHDlgF1lZUHNWRybUvBW24d7/wIQe3KM88YYRV+lRhOELlOji11KAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726291493; c=relaxed/simple;
	bh=D9QNipp2Cu8jdxZF2ATT6QNQY1AaJfGlXa9a8v3AUeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nCvF2UGCUZRzWn9bR+sARS1CNZgkeJ2rK3fFMTqaLIMdIcAKb+rkAxDYtHmHryCMTXaOHbkR5vMv0ju6HwMn8EMLMLjXsS+R1IJNeNZo06xJjhfDwh3U5kcZoZjVcaZ8Fx/THdVrVYAvMLUzKvYdT3gR5QiPQ/svS2pLqsKELLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eoVSVQP/; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso2112992a12.0;
        Fri, 13 Sep 2024 22:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726291491; x=1726896291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMfm635R2ZedUv0K9CBomURZ5/GwgVeWzLysAHmmerM=;
        b=eoVSVQP/4PZCF7sCaFmgI9aJORT/UWvCzJUxDe7laQMA5+TVOCoxPeFYliBqaBOt9J
         +k6Au1nc8vSTKmXtHb9G5reT2TX6vf7XpIgO79muMXcrGuHCmKzNeyRrM1SRg+1bNO2/
         ud4Cshy6Gx4MLC69s75d7TpBMR+yRQSMsxC6izKjy0eiXVM1w8wWjUFlWzLMG8s0gYzh
         H6lzbPILsBss79wtx0w1r5eYn4JMke/DuhC53KxQQH1l7B3YilVRvcvaMYXq90wgseIC
         V2mLKHBLZQTgjuLjX/hq31lbQuC8i6r7LCCM1Q3a2YlyZZ0diFpi4JHLhrZssv2qjzUX
         Xzew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726291491; x=1726896291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yMfm635R2ZedUv0K9CBomURZ5/GwgVeWzLysAHmmerM=;
        b=q0ikoYkhnBubnXPjx3xql7n0L6cAhMNm2L1l5Gcrc9lzH34sQp2ZTsUJR2ney0Poe2
         kGDjBr6tUIvkP69O/hFCU93k4jI4Yt4h/VY17MsBNUkWeHnzGqXPzjQQ2xYs9AJHgmNa
         hr/LIQp2Pw/VaHlGrbF9qH92fFWbh4kkPE4De6ajwXAL4ZTL22wgM4OGu9o8qRWzeLgC
         n66kUtacpM65AN38ZcZRINo9XprP9uDluntFt2LrhuNdu6TjSheSkT4MeTabz1K41X9f
         7ECzL84Dw+JBf1+MdZ0uBzEFQ9dSNmIJLbnlsVmCdSGAKAlM4Yz/DPLB8tXasgvdrEsW
         AI+g==
X-Forwarded-Encrypted: i=1; AJvYcCUf2zpqNE6m7QNqY9fLbemzFHh/OD1nfju7rOGUKCVLfR191zz4RHLYuH5Hais3uQyZQR+gF1QP4CniUg==@vger.kernel.org, AJvYcCV1Lbw6F91xOqBErCHTafwZxHWUsEUeB1PA0CVui41hOkBN1pU5rFW4M0ND5oDflBvQXKQMunboF91r@vger.kernel.org, AJvYcCVOg4j+MUrAUDJTgoU0PDF1yxeRiMJuIxsKICOwcwNu7JdHnLHQMeL4gzz56ERtV2xYTDqE6UnLBh8B6kXm@vger.kernel.org, AJvYcCWskrHl+mCCz48pQKdbznn0ESl2U57jJEyl+43FcbO4GRYraWkV2FXNxWqBUDZFphCBRaFK1fcfgWphAmKXxaw=@vger.kernel.org, AJvYcCXf5m4YYFUG3RUxs9JvvKcZN1+dzADT+e3XQ9Ou1ayxSjbiMe8d5DEp3nLb9uaCbjBJx/OcP7+v8ME=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi7HFYWJkptuAuXu4au0hmY4F/r1DzmEj1vlDwWcrYyXIuWpLf
	Eymn097EZMLem9w2uDviL29SksPkaA76K74Jf+zzKHjRIuNJMkQnac1Rl9Ky
X-Google-Smtp-Source: AGHT+IF+p2N/v7D/f9QhDmmsA4T7yTXEkaxEH1zZGQX6ejyxliq9F/Sh3KYea+gDrN6bVgpFOAQffQ==
X-Received: by 2002:a05:6a21:58b:b0:1cc:e9bc:2559 with SMTP id adf61e73a8af0-1cf75f0f12emr11241110637.28.1726291491181;
        Fri, 13 Sep 2024 22:24:51 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71944b7b749sm391223b3a.113.2024.09.13.22.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 22:24:50 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Cc: Nick Chan <towinchenmi@gmail.com>,
	Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>,
	Konrad Dybcio <konradybcio@kernel.org>
Subject: [PATCH v2 01/22] dt-bindings: arm: cpus: Add Apple A7-A11 CPU cores
Date: Sat, 14 Sep 2024 13:17:07 +0800
Message-ID: <20240914052413.68177-2-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240914052413.68177-1-towinchenmi@gmail.com>
References: <20240914052413.68177-1-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the following CPU cores:

- apple,cyclone: A7 cores
- apple,typhoon: A8 cores
- apple,twister: A9 cores
- apple,hurricane-zephyr: A10 logical cores
- apple,monsoon: A11 performance cores
- apple,mistral: A11 efficiency cores

In the Apple A10, there are physical performance-efficiency cores that
forms logical cores to software depending on the current p-state, and
only one type of core may be active at one time.

This follows the existing newest-first order.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 Documentation/devicetree/bindings/arm/cpus.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index f308ff6c3532..3959e022079f 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -89,6 +89,12 @@ properties:
       - apple,blizzard
       - apple,icestorm
       - apple,firestorm
+      - apple,mistral
+      - apple,monsoon
+      - apple,hurricane-zephyr
+      - apple,twister
+      - apple,typhoon
+      - apple,cyclone
       - arm,arm710t
       - arm,arm720t
       - arm,arm740t
-- 
2.46.0


