Return-Path: <linux-pm+bounces-14299-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF2D97956D
	for <lists+linux-pm@lfdr.de>; Sun, 15 Sep 2024 10:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E005B1F2385C
	for <lists+linux-pm@lfdr.de>; Sun, 15 Sep 2024 08:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138C64087C;
	Sun, 15 Sep 2024 08:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVGeY8vI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3A713BAE3;
	Sun, 15 Sep 2024 08:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726387730; cv=none; b=bJeu8DUmbtRsh/ga7ttTgGQ8NoJafH9+29wzRuqswkyGCIK7VWPiUq/KwVT1c5HY7Bby3jIhyLZoZACXnt7t/bfuRb5J8TZV/b1gnmu8jUYIhV1Q5rqX39LgAmrZATk8lymTgopqI3k+JDZQ/Cmhe634B4OOqCRHOxNuDaX1tzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726387730; c=relaxed/simple;
	bh=gxcmwltno7gzJ41Nz8gyYVTEjmeGDyce97eI2RwGLXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AtpDhMCGMwq2NN6xBqOjmJV4ckE9TVU5rut+gdpmYI7f+uvZnN6sV1PGqv6LE/EzdseETIawxkHNd9jMRxz73f3mcf4TvQ24F1txNv34ac28QpVpyEGghBpN/X+A45OSiBdwvQv8YpsunKrAYDz8uwb00GHfPNXUDCvuhPl7C8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVGeY8vI; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-205909afad3so37027475ad.2;
        Sun, 15 Sep 2024 01:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726387727; x=1726992527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qYZTFW41o+4HCo/KseCTomc1lLuFsUX/gJnprrWHX8=;
        b=UVGeY8vIAdoaQvqveM0SFDZRcaR9NqroAlfGJh4KxEq+5u6skN1SPGRhr5McLabnmg
         r3B2KproZTAFYrPMw+oLiRpHCXb9Hr+vWEHAe8WYavUUvg60BSw93UsWPDK/p5X5zD0u
         /Dl5FTBhuWeRHUv6fgL10I3EsIraB3EPDlCgKgY9Ycm2BrcaP/hvSKbP5J1pEng+svGC
         f2vpk//3xkIVrWPzj5I+Lj0SenzmYvs1pqdPNkfIoH1ve7u6TXnO+FHjZBBNeDGXVOfT
         OfGXk0ete8LxtD42bTqytRigi5bePGASiTIT9ECP9FSkCppEseZ7nrcu3Hz13/SRCOuS
         rJPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726387727; x=1726992527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5qYZTFW41o+4HCo/KseCTomc1lLuFsUX/gJnprrWHX8=;
        b=BxjQlOri68cZAbZ3c5rHp9a9mOZeai7jhhMYYIxREngVKhgMn9ldnOQ9jRHSeRwXui
         8bh1mvBxSAAJmWVWJPLDZG9MU4uyCGIIaZNnfIw/ilTadwUhx1B05NLFQtn81Xfw5whZ
         WwymWX+5zK8/pzl0n7q0CCL5iUCrgBHFp88wJf2KlTbueQTwgJ7z4z/tj3wtjKdlNIja
         E1fYvXuRdQIlvfLE+DZiyg9VOWSxb+wiKTCtC6QSPc0BfwbmckOer8jV/A3O0iyspQ6R
         f23LDR2NfoBhdnwN/Be/x0U0YjW5I4TycMhjMVHKzdoAmEMehAoaIFCW5Bwn/3zGTOeD
         k87Q==
X-Forwarded-Encrypted: i=1; AJvYcCVro2w08dVwwcxLob3WXU4V5jUYTDHnWdj6Dz3GCMd3O4jgVc/pBpw3hrG7vu2swICuxojKTs8PSOlsKg==@vger.kernel.org, AJvYcCWATQRJ53OiVnAs5FHjqrJOSK7WHO81RKzK4UsGev2NXPITu+d/wYk0JsGz2W9zwYO8+dmwpKXcNZI=@vger.kernel.org, AJvYcCWavbeD2ZmI8/l12GoKiOusBfPKAEeKlq1JNR0GECqWlQLK4/zNcYO097WKdP7d46YUfE9ad048HkQ8YC11wz4=@vger.kernel.org, AJvYcCXQYvv3JYTVC8faBXTlukS67OrRs3wweSBIxuh21JvfbT4cW+Yhl7e+XrfRLUAvfhk5COc8vkTjC4iR9PaV@vger.kernel.org, AJvYcCXm/GodgG9GWECgPS7C7EXG+WuEawxXq/H+/oc2VhEaoSMjkns2Fo0SwUz/ma3kTF9KbHGcvs5Mmp0v@vger.kernel.org
X-Gm-Message-State: AOJu0YxeTxNoDMenGMsgVwTQ2Xa4ULWYVwNuv9FZ+pLN1HV2auiaKtPE
	9l6NuluIYpRQNL2UIDbSNGMJ26FLjXHEmdZBLV33XmD3pFIDv0Jr
X-Google-Smtp-Source: AGHT+IFimI8s5LAPCS3+0jjnpyOg+jD/pIMmIa0AqF8LhY6nVUow38MFnojIQT6ZwwEtcTIZdgX2cg==
X-Received: by 2002:a17:903:2282:b0:207:14e7:bdfd with SMTP id d9443c01a7336-2076e306656mr212768345ad.4.1726387727390;
        Sun, 15 Sep 2024 01:08:47 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-207945db012sm18248865ad.19.2024.09.15.01.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 01:08:47 -0700 (PDT)
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
Subject: [PATCH v3 07/20] dt-bindings: arm: apple: Add A9 devices
Date: Sun, 15 Sep 2024 15:58:52 +0800
Message-ID: <20240915080733.3565-8-towinchenmi@gmail.com>
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

Adds the following apple,s8000 and apple,s8003 based platforms:

- iPhone 6s
- iPhone 6s Plus
- iPhone SE (2016)
- iPad 5

apple,s8000 is the Samsung A9, while apple,s8003 is the TSMC A9.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 .../devicetree/bindings/arm/apple.yaml        | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/apple.yaml b/Documentation/devicetree/bindings/arm/apple.yaml
index fecc4953df33..01965890b4ef 100644
--- a/Documentation/devicetree/bindings/arm/apple.yaml
+++ b/Documentation/devicetree/bindings/arm/apple.yaml
@@ -31,6 +31,13 @@ description: |
 
   - iPad Air 2
 
+  Devices based on the "A9" SoC:
+
+  - iPhone 6s
+  - iPhone 6s Plus
+  - iPhone SE (2016)
+  - iPad 5
+
   Devices based on the "M1" SoC:
 
   - Mac mini (M1, 2020)
@@ -121,6 +128,28 @@ properties:
           - const: apple,t7001
           - const: apple,arm-platform
 
+      - description: Apple Samsung A9 SoC based platforms
+        items:
+          - enum:
+              - apple,j71s # iPad 5 (Wi-Fi) (S8000)
+              - apple,j72s # iPad 5 (Cellular) (S8000)
+              - apple,n66  # iPhone 6s Plus (S8000)
+              - apple,n69u # iPhone SE (S8000)
+              - apple,n71  # iPhone 6S (S8000)
+          - const: apple,s8000
+          - const: apple,arm-platform
+
+      - description: Apple TSMC A9 SoC based platforms
+        items:
+          - enum:
+              - apple,j71t # iPad 5 (Wi-Fi) (S8003)
+              - apple,j72t # iPad 5 (Cellular) (S8003)
+              - apple,n66m # iPhone 6s Plus (S8003)
+              - apple,n69  # iPhone SE (S8003)
+              - apple,n71m # iPhone 6S (S8003)
+          - const: apple,s8003
+          - const: apple,arm-platform
+
       - description: Apple M1 SoC based platforms
         items:
           - enum:
-- 
2.46.0


