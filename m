Return-Path: <linux-pm+bounces-14228-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B75E978DD3
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 07:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F021028D086
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 05:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771E817C991;
	Sat, 14 Sep 2024 05:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HW67/kej"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A25823DD;
	Sat, 14 Sep 2024 05:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726291570; cv=none; b=VAFUGRAi9O72VLfqVcBODZEBxc+Nxy/EUnYL9Gd3YHJmxcLV/a8ATNaEMHsu5LS+tZWBmclWWVqv2aj3Ima0rEL1haQ5b9YmcXee4Rl8TKR5Xvsg1SGUU755UhP7kFlthKzzX8Z9CNXwLBNCEhLuTcJuIPnLZe0J4WntI32Jer4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726291570; c=relaxed/simple;
	bh=LFzv+ybZl24X73SDlUeoq7DGJPVkl9oa6qIMbQ5kWi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fENE44QapfoKZ/ZvdrbuDdzaKJLiy9FVsRZYc9Debws4tFf/wNzJEFPMFso/bG55hdbiT+dyK+0zbI7Ij3hG/GMbEH7QX0+DkmnhxqGWvfSTyRTQAiym6JmDe+USh6RNrmIx7WpdoZyorx1n++gq5qcOlQc0W2OsVvjm9MXSZ5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HW67/kej; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7191fb54147so2019417b3a.2;
        Fri, 13 Sep 2024 22:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726291568; x=1726896368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PxmkdiRq54N1MFYxhlP5pg6YjtYKAD9J3M+YFYas/2E=;
        b=HW67/kejW2RiwJ+hVluF0JvZjc5SBz2qMX6EC9p0p3e+hCCpILvdU82RLJ6dUZDVk8
         YJh2c4c+CV6C9bDqW1L0T5AzUzVB1BjPG9QPVixKLWwje3cWh8xepjgGgVjYBMzFqkiM
         wiEA80+8RXfR058elwca+CxzAfnTNKM3gi/QU25UKAZ8OSQ8lzQppzTgzjgK9nGIaOAB
         97kGQx0QugEIcq8RrReWxSPfvHv9yOKxzH1p5iUXwssvSEiJatNXn1AvHNzTmYIy/N18
         7VDEHD7Fvc9j5iFas1P+sCKmKh1Wkf+TMDbI7YeNG8IaipxdMZjbqxxB1HGrs9aLimAS
         9nnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726291568; x=1726896368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PxmkdiRq54N1MFYxhlP5pg6YjtYKAD9J3M+YFYas/2E=;
        b=qL2Xq2p+m+lA1rCtBUk6rIvoShID3+/2MBftwDULlDwTcTG+KmOz+sHN/Zo7sptxwA
         MPL1LG8d2HaWPkj0MlM9nAoJ1k6vXc5rw+4h5QaMCg4d0mODFzFFPrKNnTCPfAHF3y3/
         5Na/hei49q2gbFEN9bQ937/sEPPIYZBEq+r3CHcgl2TSYlYuRIlE7r6RTFPpM/vcPvc+
         5I0hRwcxwCS2393KSadgg7iznq6QXI9pwU/JR0rYRXhHIbN7bQ8QpNvaG4ggZOJ18cZT
         EdnRpqUnnANJs9O4CKK5nt+P2q+xmzDT+iADKSeEbAeAZ+7bqs4+mAT8SExSOfK5K3Wk
         syiw==
X-Forwarded-Encrypted: i=1; AJvYcCUZR9uFiSayYqgPXboForXrz6xVEZsaNzwycHjgioRpKNTT1fRDhGX6Au3yRUWcb11uw536ZKVDgXN15j7u@vger.kernel.org, AJvYcCUtYYWPmbryvbdqQ2MDxP0jQhxdeQq9g5FVs20tmxk48nu794y9+9GXivl+BBlwZIiyn/noCEg3Lpw=@vger.kernel.org, AJvYcCWKX50Pa+hNx1sIrSV5liTHpcby90vv+UXzpMcLvdsLHCmLi/viB0Ro8bSKofMjoj+n5QWzYQ974b1n@vger.kernel.org, AJvYcCWatrbPbvrWEnhqMhFqjnDPhU61DQpaWVDTFmPTA21ZMYs69mz30PzBlGfvBic2lzvuTJX4tDQTe3UEpW/YMqo=@vger.kernel.org, AJvYcCXmhtpZJfzmhAtV1GMVtWVlhOBtXck5bLOAFhwkC011TQqik6wPEM5jPHGgndZIRwsCPRzOPZFaJz/Cpw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEur9CdSGnRcPOTSusI6piNYaAhmqTYwKuVCzANvBBzjqt2+ru
	6Ed9hUMJsJ6XHykeL7Pz8gzt2DspPgn7A+yoAZCpRPMTNSAIHfsB
X-Google-Smtp-Source: AGHT+IFjCQdTCgKHorV+PEdvKRykkSx/Nf7CjbwpllATeXQDdK8UoGhSnTQE0aLfguSQ90/rKj8SUQ==
X-Received: by 2002:a05:6a00:14d0:b0:717:9768:a4ed with SMTP id d2e1a72fcca58-7192609318dmr15345794b3a.16.1726291568317;
        Fri, 13 Sep 2024 22:26:08 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71944b7b749sm391223b3a.113.2024.09.13.22.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 22:26:08 -0700 (PDT)
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
Subject: [PATCH v2 12/22] dt-bindings: arm: apple: Add A11 devices
Date: Sat, 14 Sep 2024 13:17:21 +0800
Message-ID: <20240914052413.68177-16-towinchenmi@gmail.com>
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

Add the follow apple,t8015 based platforms:

- iPhone 8
- iPhone 8 Plus
- iPhone X

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 .../devicetree/bindings/arm/apple.yaml         | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/apple.yaml b/Documentation/devicetree/bindings/arm/apple.yaml
index 92fb48aafc39..c39fb665a4bd 100644
--- a/Documentation/devicetree/bindings/arm/apple.yaml
+++ b/Documentation/devicetree/bindings/arm/apple.yaml
@@ -57,6 +57,12 @@ description: |
   - iPad Pro (2nd Generation) (10.5 Inch)
   - iPad Pro (2nd Generation) (12.9 Inch)
 
+  Devices based on the "A11" SoC:
+
+  - iPhone 8
+  - iPhone 8 Plus
+  - iPhone X
+
   Devices based on the "M1" SoC:
 
   - Mac mini (M1, 2020)
@@ -205,6 +211,18 @@ properties:
           - const: apple,t8011
           - const: apple,arm-platform
 
+      - description: Apple A11 SoC based platforms
+        items:
+          - enum:
+              - apple,d20  # iPhone 8 (Global)
+              - apple,d21  # iPhone 8 Plus (Global)
+              - apple,d22  # iPhone X (Global)
+              - apple,d201 # iPhone 8 (GSM)
+              - apple,d211 # iPhone 8 Plus (GSM)
+              - apple,d221 # iPhone X (GSM)
+          - const: apple,t8015
+          - const: apple,arm-platform
+
       - description: Apple M1 SoC based platforms
         items:
           - enum:
-- 
2.46.0


