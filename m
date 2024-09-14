Return-Path: <linux-pm+bounces-14224-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D73E9978DBC
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 07:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FD2A1C220AB
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 05:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4D515534E;
	Sat, 14 Sep 2024 05:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkzICgeq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF97154452;
	Sat, 14 Sep 2024 05:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726291552; cv=none; b=S56fA3K5RQ+8LZE1ko5H9GBPB8n5oez4T6lu9TjRW25Jc8BARcqDGK7/9XjNd8x+C5boyQchgu6BwpTYXx9Q365v6L5ifUAD4qFveRaMFcoaUrpzvdQ9hz0lreSGxN5BemK9lNweoIl3rtn/HeVLl5ffGp4sP0t/0cp1Ktj4Hu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726291552; c=relaxed/simple;
	bh=H7nQJyFzW8irtHgkfEKc3loIPXzwU0X7CnNA7CmXOoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KF8t63IooyXxJIvydgNRxvFSd1VrubHjAgurQQEGdqimZu26mdTvTOmz6N1jVZMpbfX592PLcn6pJkpgMlwQI5PSu0/G1l+BLYke5A4uHJJnkCOOwnX2NB58aKmDeRrm/y+guQivIv/ugVhK5eHf3jCTtkis8XkeWedfcmvYvh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HkzICgeq; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7d4f8a1626cso1242458a12.3;
        Fri, 13 Sep 2024 22:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726291550; x=1726896350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8dRPdb1DUSAE0eGOvVsLMam6fepF10fMmDJkxTXGz1I=;
        b=HkzICgeq+Vgu0eLqF6nmah6/pJYqGytbOV0zRS16yFIZVteerHGZ9Aewfzh/RhKtyl
         N8ddWia4XNMiv7NMMZ2aQ30KePneCP54K+9o/9YOnHGdEPyPDdZecm7rjKNoLfra6+LF
         CfXeDw62tMYV6AiRWkhZEE6JY2nAziYuIV4qWTo8j4GbsNHP20GQg4G8onyLPmek3xIJ
         0RLVcs9DmoI0WyRiikicoDX+H+ENuGP+XhjaCqlkGVHU3vgybfjkN7kxUKCi9NM/BCKR
         q/Cc5WExgIrjZkhZBNE8o5vI4f1Uh81x+mGjjT4ugSRxezG2d+BojTdxNyaJWi5gg9Ik
         11Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726291550; x=1726896350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8dRPdb1DUSAE0eGOvVsLMam6fepF10fMmDJkxTXGz1I=;
        b=HdvG1gHVjtCAQsdtK71rGQOhrzavIaptfJM/MWkkRUFfRPR7Dp01tPotbU1bYnx9rt
         d8pnndERM3abdNX5nSODsie6/6jAHZbMy4Jevp2vyxxC7UxCeU8gB2ZZvGEg6dz4VT/4
         KN8wM+JX7EdPE65qXibLIJHjTiN2rNX2Grvjgha8xKCRZLMtr+IAuBgrONdXCH2XIEeN
         M7NX7zAxQeCu71UD/JqNUeW5J0uZPFD1bzkxjlbNOS7mIInqeYNHO2zJqwFCa4968w2L
         zAxQB4y7CdfD49wxQhiKE2MAf0N/RZmcI2WoEF6yBHVfyb6zWOtCxZOC2K/cGs3tm1lE
         270g==
X-Forwarded-Encrypted: i=1; AJvYcCUSc66hzaDpq0lM635K+mUnNNZXq/S2F65hHu8zH9uGih8+rNhqBwFXHgU7jBfgVfJO7yJMEUawDgTz2ll4@vger.kernel.org, AJvYcCVxrkxQb1ta1fz9F4iz060Pg3HxqvfvHoKoWnvC5Nk+6WGjDTd4Dh1Rx1sk8CC4kgHaG9Jkde4NWXagwcKeLck=@vger.kernel.org, AJvYcCXQ93k8//go4xp5zKDXf7Ln2MLXL5QOUMgQ/XPgtiAr/tqkInhDrmQB9UYpRUFoJ6q0aceRjw/gFUU=@vger.kernel.org, AJvYcCXShd06LzjKX0uqv6fBsnYINOSZnFoKL1itf1q1dPzuIrkBONORsNvDIZOBvxiQa6oYnwrlxkQ8qh4CfQ==@vger.kernel.org, AJvYcCXtZnWx2IAldOUlCpMXI0pgF/1cj/4A9IKIKFRT0f94qGzpfzdkEWuWNeTIiGNZsA31kkjuLUCRP2VF@vger.kernel.org
X-Gm-Message-State: AOJu0YwttGW/JWDCv1dk/ZKWNiCh11GwaGGbjPy0HipXnguXwlvBbkG2
	YFZwTvDFndzUbZhbg6wp60PZ7cV3C7FIcH/55yM64Fiq9l1SvFyx
X-Google-Smtp-Source: AGHT+IE3vGhI8pjucNbbwbxrDykfqnEFixVSB+R94RGRk7HIBhBBek4yxU+zR5U5cppdjic22bhwyw==
X-Received: by 2002:a05:6a21:a4c4:b0:1cf:590f:ddad with SMTP id adf61e73a8af0-1d112b60f07mr8963836637.15.1726291550547;
        Fri, 13 Sep 2024 22:25:50 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71944b7b749sm391223b3a.113.2024.09.13.22.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 22:25:50 -0700 (PDT)
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
Subject: [PATCH v2 08/22] dt-bindings: arm: apple: Add A9 devices
Date: Sat, 14 Sep 2024 13:17:17 +0800
Message-ID: <20240914052413.68177-12-towinchenmi@gmail.com>
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
index 0e6a51fad2fc..baf0ef632231 100644
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


