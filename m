Return-Path: <linux-pm+bounces-13996-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8047974D43
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 10:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E754F1C2580D
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 08:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB851885AC;
	Wed, 11 Sep 2024 08:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dA1inbIa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF341885A3;
	Wed, 11 Sep 2024 08:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726044470; cv=none; b=mSrYYR1oYE3ICd+nYCyuNGGemtd5HoZDKuHHzs8h6wKvCUfYZJe3PT9hINh/qIgMdos6us/m9TYFi8NPZfy5EyKoEmQIvsBRb97UusWx/jtK4RRxYmGzmZZ53f1bkpT8o8z2PPGBZn35m4b31xF+yaGLFniQ/tIzmJX8Q+R/9Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726044470; c=relaxed/simple;
	bh=ppm24EhHTD4hEOGBkzF6TqV/PiS5UAOxThSexqShUAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=emRW3/AeL24nUGl6qf+zt1c7xUHRH3DcWLLjTPDjjkafOoYGwnECFoOiU07s9j1GqMjvrI6lXFJjal+ssPvovvHhUjHWBkJJ9FSDjWUr17RTRryT0Y7JG4pw7Jip9LrmTeDBWBm8I7N2ODsvSxLVDfdNvZFMq7SbP4JLSNSD7iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dA1inbIa; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-718d6ad6050so4092300b3a.0;
        Wed, 11 Sep 2024 01:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726044469; x=1726649269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+WqBT/YEPLVK1UMgD/sAA9WnitOE2/cu5y5DWlVtYk=;
        b=dA1inbIaeI2r0Ud5lIdLy1u+vZ425Gxj7N4Fg46go/eVdEWYIPSblgPbKSs5FiIUtD
         HMd6YgzcBDXHzGlNONqyhOjVbu14xm9oEicqQR6Vz4+iH7IBc2Dvt5PnDUXlwXiaqah7
         DmSqhsuXPJ/9OQGgkfSUkrBYtUcvUe1MMVt8Q9NvSZElNg4326PCp4uNIwSXw0EkFRTL
         pFphHIldAq9gOGBNH3V8YOK+quE3vXZnucfu2ojL1C3ZBGCyWuPHBiFoWAFObZqOFFS6
         RDucmEHPfsFf+GLEDoPhiOWLA1rpjMerdxcGatuecCCccachkuJvfpjC3hDD/94+jLQ7
         WpdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726044469; x=1726649269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L+WqBT/YEPLVK1UMgD/sAA9WnitOE2/cu5y5DWlVtYk=;
        b=e+3fc8hE8GQs9piWwT6+scgZM4jp5M9aploagzq7zmrIxSjat2IC0G7TkS2WNJMHZb
         lWrFgTCMSTM9bRpnomk5oHcDD54cKoM4jkXKT0cGi3P8WRp9nUBmHxFwY3vH+JbdO4iw
         vYh2qXEp5b0OsbWqgPQfvFQTV11SIFtlVA+YXJX2WOxUZ9JPolZk4Tdu8mZUSLJuWVPM
         frDLSU8QXrwnB2cTlIXK55p5TJ+JH2hU5Y9PGYqKSN9i1vmTFb47DkOLukupMIeAFN9o
         i3nNk4UNMl6DlwHV1rUBK50VEeDV84ukitIO9c0YenQ5Yg9mGkOrLhM7zVyg5HZfPyh2
         1fgQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/B9rGi0JfOdl7OeIR+zJV16BxPM99BaZ5IiczgM0DrErN/fqHEW2F4lC2uEbRSPSTrIzxFu2LxR+I@vger.kernel.org, AJvYcCUPlArgRJO/g38TPnfshbERRW7ZDvufFtuI7M1MPULd7ehm66IgKxto4k3LdaXq/P3ilTTMDhGLs3fEjQ==@vger.kernel.org, AJvYcCVm1xN+jn3Me/bY0MyMmtKLJCEe1gXygloMJOmu/enV8f9RRALXvebuqg5CCjZsrw+/vb+0+8AuX79ciT24Vvc=@vger.kernel.org, AJvYcCW5scyz+rXkiosM4jyyLsaATKPwVzlf1Q5LUd00ebmgoP/lILlRmb0ElcFlCQY9VNS28b/a2aZvwCI=@vger.kernel.org, AJvYcCWqyQLxiabxCINJGXDdhEjlaRW2Q3e0UC7ZIY8pYjiV08VgxQ62ER7lUQCCORmmc47dMdYTVpU4mAqQR108@vger.kernel.org
X-Gm-Message-State: AOJu0YxoZidFBQqB6tEVhhxdGze38qfpvGKRul6D3XeTzZhsIHxOga5t
	Q11lPFFeS5E7eTrMFZH2zkTAPKl8kTfBMy7QC/5/gyvuMClhbQTA
X-Google-Smtp-Source: AGHT+IGFBhuKkq7tslhEjhMirf+wLTw0A/dg7JQDlTNh9KZ10jyDQP2kpndSU+9+CF/mEy0DUaEvjw==
X-Received: by 2002:a05:6a00:9141:b0:70d:2693:d215 with SMTP id d2e1a72fcca58-718d5e9daaemr19669536b3a.16.1726044468990;
        Wed, 11 Sep 2024 01:47:48 -0700 (PDT)
Received: from nick-mbp.ust.hk (wf121-022.ust.hk. [175.159.121.22])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71909095177sm2530125b3a.112.2024.09.11.01.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 01:47:48 -0700 (PDT)
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
Cc: Konrad Dybcio <konradybcio@kernel.org>,
	Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>,
	Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH 12/22] dt-bindings: arm: apple: Add A11 devices
Date: Wed, 11 Sep 2024 16:41:02 +0800
Message-ID: <20240911084353.28888-14-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911084353.28888-2-towinchenmi@gmail.com>
References: <20240911084353.28888-2-towinchenmi@gmail.com>
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
index 2831a662f5d5..15e46f13fd2e 100644
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


