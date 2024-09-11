Return-Path: <linux-pm+bounces-13989-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDE6974D20
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 10:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A489DB23237
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 08:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE4118455E;
	Wed, 11 Sep 2024 08:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jISJ/f4q"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978FF1714DC;
	Wed, 11 Sep 2024 08:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726044438; cv=none; b=oWJibx8oZC9DXR61h9wcNsFuyTGYeg8YfvfQ+FV4mG7UQ8pzoK20hQglyY+wM75RZ3eCtpabvEy/UmtQZ1sfpgEmkXtcLqH7NfpIxYME8lqxl54KeiscM5G24MpiItJM4TxihzbGbZHG9IswxIKT6eiP9kMaOFULG1BDPO1/Czo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726044438; c=relaxed/simple;
	bh=l3S98+tHOd0H1b7zLM7OaUtryDKYJ3rLNdUtyLsM+EI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gQnKMX1d330CmMqdilAcg/CNfI6g89UzvrPiN5Uv3uy3sfwpaZKaHTLUfg2QXlxMxH5ob3Hayi0kAwG6u8CkIheAN2lIGpJU2yRryF9gI4r2wKvY6qKfAToApn3sQGh334sOr4fuhF2V8uvdWmma+H/SogMST4+E/t//E2397kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jISJ/f4q; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71790ed8c2dso5625954b3a.3;
        Wed, 11 Sep 2024 01:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726044436; x=1726649236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cn5sYAux5rTxj4pwmfhtHMdioh011tWYhtxi8uWrWtg=;
        b=jISJ/f4qxIA88cvnZtyCGyCLN5wzotGwAA84XYVlWpB3BNG2gxNNqQ+oivX7K5gDhO
         Zvm92ksxJTukc/Ykhx3RX3+cCT+G+S5pAMeqTcNSp2ImnKFaylZZvFuzo2LQzW+BAIwi
         MLuq0B3f4ernNCPh3MrgX4TFBeJfhSAT7GTM10RQ2oHT5N4UiMT+rDvwHzqvVsr1agf2
         Wzv5y2txe/vGHB3GAunds01kObgVVfompJS4lMhtayIKZXkY9jcKlKqb+UuhISBlqngT
         GSGtHRSOEs8o6FXo4WyehH/WJU8b6GsbIJWCHlVQse3Aa5LQW4TFsf5lgTM8RzSTwGb+
         LsCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726044436; x=1726649236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cn5sYAux5rTxj4pwmfhtHMdioh011tWYhtxi8uWrWtg=;
        b=Gp6Vhw2coRm61Sm1yOw4Gs1ZWB1sZ+uZDl0hye7q7BiEQnGqut83rUubML4h+udstl
         FRY6KSfOxJxcYAkjm7aRLAe3JPeoDuwZe4X9YnsGOyx8w+MVc/6Jj/dkMlXRHkgPyPFf
         lvgyc9nnOSxjEY6oV/M9tpqREjyV7uYKfonBv9rd+nWe+AgbegHoiYJVwdw3lvoO4tWc
         0J0iatwukp4uL8xGYOYiwzpCf8Tw2xs+J0/eX/TMm7bRObZF8trk0z5XXRzKej/l/gHi
         0Xq2bKcihN8VOEtA1XjiVX6qqCGR/6m/GNWvzEkymvMsWLVyyo8K/qaVsvWWwVO7zNXw
         vIiw==
X-Forwarded-Encrypted: i=1; AJvYcCUpC5A/0dhq1xW87vWxI3ARpr1YA55J3Vxr4mEMZUNDbSc3RRvxIMLQ16YaM/A40DmtTyzqw4eTUUg=@vger.kernel.org, AJvYcCWM97d+0KAtS/Oy32cYR22MZOHPSjmovt3SQ6ls1Ud5dSzjxQuC1k8G2o9fu4AGAfAs5XCtqp5GmGS//nZe@vger.kernel.org, AJvYcCXCzMIvLvlQxSwccBj1FyqASp+flcPKkJd5s+V7V0JAqO+DfywIE5LC9s+IRn8HaE+mjJgtTjf/lm8Fdw==@vger.kernel.org, AJvYcCXZtc+KrVdH1hPXmwG7lvNdODQfsYWAfRAvFK7gdwVqGiqNNLqo7fL0RBKqLgc+QOjrWu4FBlM5998gvwYy7po=@vger.kernel.org, AJvYcCXoIiMRYCsS3BCEudMTPnx0r3VKo3X4KhWX4WQK/LByIio5GXSA9JpQgbg2aqqOrC5GPvbhzDwbRkew@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2X7Xg48/89VyT/6bdxNAWZ0LlQv5BTQ05G4U3rH2+wXmOhuk2
	m3iZ976JpXE998JAUqQS08xzrXx3M8kLliBGzFuY5PD/skjVs5zQ
X-Google-Smtp-Source: AGHT+IH8Ukzpm5G0XVPbr+BqKX3Ni9mTPZT1q2gvljK4KvBtB+LlCuVKaT281dm2/Fohu1/e+dVptQ==
X-Received: by 2002:a05:6a20:d80a:b0:1cf:5c1d:83e2 with SMTP id adf61e73a8af0-1cf5e19e36amr4987577637.39.1726044435788;
        Wed, 11 Sep 2024 01:47:15 -0700 (PDT)
Received: from nick-mbp.ust.hk (wf121-022.ust.hk. [175.159.121.22])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71909095177sm2530125b3a.112.2024.09.11.01.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 01:47:15 -0700 (PDT)
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
Subject: [PATCH 05/22] dt-bindings: arm: apple: Add A7 devices
Date: Wed, 11 Sep 2024 16:40:55 +0800
Message-ID: <20240911084353.28888-7-towinchenmi@gmail.com>
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

This adds the following apple,s5l8960x platforms:

- iPhone 5s
- iPad Air (1)
- iPad Mini 2
- iPad Mini 3

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 .../devicetree/bindings/arm/apple.yaml        | 26 ++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/apple.yaml b/Documentation/devicetree/bindings/arm/apple.yaml
index 883fd67e3752..3c81008f0e96 100644
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
+  - iPad Mini 2
+  - iPad Mini 3
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
+              - apple,j87  # Apple iPad Mini 2 (Cellular, China)
+              - apple,j87m # Apple iPad Mini 3 (Cellular, China)
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


