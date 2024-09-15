Return-Path: <linux-pm+bounces-14296-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 553EC97955F
	for <lists+linux-pm@lfdr.de>; Sun, 15 Sep 2024 10:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3746B21A61
	for <lists+linux-pm@lfdr.de>; Sun, 15 Sep 2024 08:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461474962B;
	Sun, 15 Sep 2024 08:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEGpwP31"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48CC47F69;
	Sun, 15 Sep 2024 08:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726387716; cv=none; b=MkzuYDRL8WlCFme394H3g9Y0teZD8ptq5znx1HQF0V7HuVjmTLMW18LKVeFF4hcIFqnaRdnjLnlsXQRAvvJQGRTJ5eqj6baTzGpBWwnUn6d4P/Qh8+qPqFQA15YOO7RV8OaFN7QbWu/J5YyBrEHrwEQAxEbesZxyV2/QE/lIT4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726387716; c=relaxed/simple;
	bh=1do3oMHa+zZtMgWoYxSILBP1btrTVDMYuMavL2iJt/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YUIenfkLBlI7aC5qqn6iVRFcwvOxS6x1OkXSzbPcybOYFg4SK8i2PIWQ1yOmzoCYh0FIcE2UAjPT1JOwyuOWd/DBD2veWXb6+C9Pec3jiCIUnw8tjBFOzn0/rYDXysUVQgH+Uf99z/Ra93yfigk8hGQwAJGZiAB0Ptyn62RSEP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEGpwP31; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2054feabfc3so28480915ad.1;
        Sun, 15 Sep 2024 01:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726387714; x=1726992514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cx9QUOiQgqEszXRAMdnqMOxDufFUf+ALloEhf90CVgc=;
        b=YEGpwP314ulxrN8OlnGP0kN2LzRzOMj2Ia7B4VGmVTJ4O/n7Y2ghE2GvqqzNe7dEuU
         0flp5DrRET0gGontU341S9WrpU4cgVaSefDtMJskj6CSVeIc4NEj+jgKCQ5nvUbGBPv7
         DPVQgIS0Y+j11+4JdbZBr45Tc8a1EbVO3fg3K0PMAcwy87on10ZZMwoQ7W7P6b1FtxaT
         Hncsv+ejG5r3Sij3RkO2NWC6I17LneZ2efIT05WHEw6oxV55Po4mXqv3o0PjsdHoKADB
         bcyGEZBf7fgrYsJQUDQreng9vjaFNPBi39oy/NI/pgAswh65q+FGKJqUs5FqSQIARL7y
         luhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726387714; x=1726992514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cx9QUOiQgqEszXRAMdnqMOxDufFUf+ALloEhf90CVgc=;
        b=NZo4Dy8p2VWT+nXlA34jAUxl2bOCMdG4NF3FvOebhVjPRLsC7PuAfoA3pYAtuy7+EB
         ZO/baNDHdPJhLvpy620ySaBg55+XBGLrVASSrzsNUCLhyoaWz2HdGun7vmymO8Z+rW0c
         7I2wMZNh85hP5NA9kO2jqthQHPCtwUQr/IhLMriqa9epCcKEtXV022iqUudPF3HoFudr
         LULalLG6669jKxPf6PI/JxFmcE8/bnOE3ApKgohFIE6MBql3KIr9rJtZ/OG6TswJtXj/
         GWUc5s34BdMZoJseuXuE7QQhvvWCCLlg5x/KDcXgX6fkz/pShgiThLnwJMHeha9uo0y9
         sOzw==
X-Forwarded-Encrypted: i=1; AJvYcCVxIXIBnkwTckK8r0EtalIa8HE1VXxPnmXnMKJkAO6B4wGreAWd9D1ATbxJZv06yNObzwIrup2+4zrGrwJb@vger.kernel.org, AJvYcCWDO6G9yt+kf1QJoZBmhkVLogzwga746+m4+pbP+WJi7QW82ry+ZLCkvh21qt8zc8hVETr+BGtE8+1F@vger.kernel.org, AJvYcCWMpJ7MkGSj5qttZo3ZI0yR3CeSPkMXDdcy++B5TEje1QFQU0eOyhi+liOvC2HQhICPolkGIBu/tkA=@vger.kernel.org, AJvYcCWfjfN7dkfFwQDIbnpXRHTAaabIIQZ5gPIC0d8qL+70SDGMdszOdxi2Xa08scN+hfba78AXVjaCt09S+g==@vger.kernel.org, AJvYcCWkH+6/5l+MizXvCRSbIr/09KDE2S5PxoUvl85ndgYJXFNu6wSuk2ZF8AdRR+FYLqZIZ7hNE+G2Yt+3yPZOhUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQpzO+1xewUKL0p6sPUs2u03uTlyE/y1tpo9GPKONtNQrTLh6/
	LNEEoWqtSeWS3Yf3duL20uYjKK0ss452LiaPnWuDFmbXYm0NBBcJ
X-Google-Smtp-Source: AGHT+IFNSoyeirgIMK/595Vgd0JN4ZFIGBPbAzOrW7cJtm/MKE33wVVuObYNcxrXh4Lj2EvKvj/Sgw==
X-Received: by 2002:a17:903:18b:b0:202:301f:36fd with SMTP id d9443c01a7336-2076e361277mr159798905ad.18.1726387714123;
        Sun, 15 Sep 2024 01:08:34 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-207945db012sm18248865ad.19.2024.09.15.01.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 01:08:33 -0700 (PDT)
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
	Konrad Dybcio <konradybcio@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 04/20] dt-bindings: arm: apple: Add A7 devices
Date: Sun, 15 Sep 2024 15:58:49 +0800
Message-ID: <20240915080733.3565-5-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240915080733.3565-1-towinchenmi@gmail.com>
References: <20240915080733.3565-1-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the following apple,s5l8960x platforms:

- iPhone 5s
- iPad Air (1)
- iPad Mini 2
- iPad Mini 3

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 .../devicetree/bindings/arm/apple.yaml        | 26 ++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/apple.yaml b/Documentation/devicetree/bindings/arm/apple.yaml
index 883fd67e3752..89c1e35e404b 100644
--- a/Documentation/devicetree/bindings/arm/apple.yaml
+++ b/Documentation/devicetree/bindings/arm/apple.yaml
@@ -12,7 +12,14 @@ maintainers:
 description: |
   ARM platforms using SoCs designed by Apple Inc., branded "Apple Silicon".
 
-  This currently includes devices based on the "M1" SoC:
+  This currently includes devices based on the "A7" SoC:
+
+  - iPhone 5s
+  - iPad Air (1)
+  - iPad mini 2
+  - iPad mini 3
+
+  Devices based on the "M1" SoC:
 
   - Mac mini (M1, 2020)
   - MacBook Pro (13-inch, M1, 2020)
@@ -65,6 +72,23 @@ properties:
     const: "/"
   compatible:
     oneOf:
+      - description: Apple A7 SoC based platforms
+        items:
+          - enum:
+              - apple,j71  # iPad Air (Wi-Fi)
+              - apple,j72  # iPad Air (Cellular)
+              - apple,j73  # iPad Air (Cellular, China)
+              - apple,j85  # iPad mini 2 (Wi-Fi)
+              - apple,j85m # iPad mini 3 (Wi-Fi)
+              - apple,j86  # iPad mini 2 (Cellular)
+              - apple,j86m # iPad mini 3 (Cellular)
+              - apple,j87  # iPad mini 2 (Cellular, China)
+              - apple,j87m # iPad mini 3 (Cellular, China)
+              - apple,n51  # iPhone 5s (GSM)
+              - apple,n53  # iPhone 5s (LTE)
+          - const: apple,s5l8960x
+          - const: apple,arm-platform
+
       - description: Apple M1 SoC based platforms
         items:
           - enum:
-- 
2.46.0


