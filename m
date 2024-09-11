Return-Path: <linux-pm+bounces-13995-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A64A1974D3D
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 10:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 696192889F3
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 08:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD6518784E;
	Wed, 11 Sep 2024 08:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsDvA4GR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B63187345;
	Wed, 11 Sep 2024 08:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726044466; cv=none; b=KcUoyCGdwnVgyoVHIR3UVSUf5W0Uld3suS4rKO9BmSb8IoyLSvhUoI7vjiRKCmzoD5APKnGyT1e7Q0Y/1r4y3gxuPpM7axqfxyokSJTxFA9ctCnJk+sCa0y2rsuoLuYeOdqLkg24d+7uLAU7ajaaUMY+EXQ/vBKH+rgIKac1mQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726044466; c=relaxed/simple;
	bh=e+RwqZ0KKDj0FMI96kxmn78KGmId4jrdpNHTTf1PFeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jFVtV2c8cCEtjTKk41a12xTcEXyzRFFfmRMU8ofRY5E9r9SUsHUtocpWVtUsEUhvvDCObioiGh3r+N+o1GcsrnJR+GRHucY4w1bblgRfgWkTclFJ7bVRoIzbqwboPm73YJvhp0+elFdO/PJUuhQynBvUY75So0zVum3K4Duy1tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hsDvA4GR; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-718e11e4186so1637962b3a.2;
        Wed, 11 Sep 2024 01:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726044464; x=1726649264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AmXdf6OWZ+6DgSIhVYS2VQN3ZnSKQAowmzyE0LCVjPI=;
        b=hsDvA4GR/p8xsokoa9hgZiNW3PMWXxcbDTT8Fdq54aR9Rpp+m45AjamsK61xJYfv6H
         He56DarxMnkEgxopnIojp9l6o6zU6qz+qJkNa6cxsOQNQaW5XV5rB0TfzzU90WF2ofOZ
         nLymzD6Z51cS70Tr9FPFIFhQkraIQE0ULZQ6t4d1P3o+Ia2kDMzmO2EjeNgoX0bGeKU+
         ixsa/kUHGKk502mFpvC/YefoZazSh6Mu2ruLwo/lNhODMuoyDrxfqhY8ZJ/tzyh5zXmX
         6NrQEvnVfn/HN0LgW4FEtCj9Qqnl3FkG2F72aFNV1vRrq1ZdB1tgNnUuppnzZX5NCoPA
         Lr3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726044464; x=1726649264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AmXdf6OWZ+6DgSIhVYS2VQN3ZnSKQAowmzyE0LCVjPI=;
        b=uh/xCnt3+ZU0n74ZAHZA62+Bv3KLiV7RfQ7fXzoLnsgLxzAJHVCsbWLMojCVufJRkg
         7oDEaX72cuOZXFkMoDFI639ORIQFuR4CNzxaJVKjdgqEnHhhhsV9jgnjaYNgC4gwiCwg
         9gUPx0cEpM1dJTpwEjKoTZaKVZe2b2ElZPs+rpnddOlFWRNLzoJtZwR97D93y3oQWgU3
         ZsYk+ZWruLMTkSfztOolwJutkZYFhFQ7PVEZFd6vDLY+aNMXBmdm5GHQCYQ8rA8G+fmA
         1BFLN8VVR4vdfv7jQPGX8NTTFeHAqAB4WyY1B0OgIaGxgRuNxOUkZln7mj5zI1q27JIt
         ofyw==
X-Forwarded-Encrypted: i=1; AJvYcCU0XQFeKweMIhkHGwlIleJ9FwB6bENP62UNNcbtMoJJj+IadEqbbRgG28j/sXwZmkqsN0ELqjNa/F+d2qLz@vger.kernel.org, AJvYcCUEkskz5m3J3O5o916O5S4BRL94M2p0HL5NTzWu/2UqF0ghBNAlNn09Q3/IOwthl75j7MPQil61cu4=@vger.kernel.org, AJvYcCVgPf5j0FMCpyeRTToj4VTHUyyh6XsfkFdJJr+/HxMEBhP+LcTkMHrbLSY/DcQhzyzLCQKRH7zwpbCirw==@vger.kernel.org, AJvYcCVw1tqto7rktW9IF2oPNdL5s1vZ2AveLEcwEM0bZjOQjzBr/DuVsImeIsK1OP8vlmC9GvCioWdYpr0f@vger.kernel.org, AJvYcCXcaRLSio3VG+2bRg21TV6EfWd1f3/ybtxXIx1OxmM69eD9hbLIZ/nrXHL9X5wzd5cyhk/p/cYjzahFb2PtgbY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6pHr+nYDEuaiveeC/ZjEp4Ds/MCkfPWZBmf78XUFTDiM+GDLR
	qIZBbuJ9EJASrfi4E02FjjPkcQeITe7bYIzPMQbRWe06+JGT6jax
X-Google-Smtp-Source: AGHT+IE5ml0se5Ym/mHN+1lct8Gh6o22KIxJaN+WlMCEv67cVuSqhlXchJvBOtUM8B5UPM4aL6o2kA==
X-Received: by 2002:a05:6a00:945a:b0:714:15ff:a2a4 with SMTP id d2e1a72fcca58-71916df43f7mr3070313b3a.13.1726044464385;
        Wed, 11 Sep 2024 01:47:44 -0700 (PDT)
Received: from nick-mbp.ust.hk (wf121-022.ust.hk. [175.159.121.22])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71909095177sm2530125b3a.112.2024.09.11.01.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 01:47:43 -0700 (PDT)
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
Subject: [PATCH 11/22] dt-bindings: arm: apple: Add A10X devices
Date: Wed, 11 Sep 2024 16:41:01 +0800
Message-ID: <20240911084353.28888-13-towinchenmi@gmail.com>
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

Add the following apple,t8011 based platforms:

- Apple TV 4K
- iPad Pro (2nd Generation) (10.5 Inch)
- iPad Pro (2nd Generation) (12.9 Inch)

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 .../devicetree/bindings/arm/apple.yaml          | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/apple.yaml b/Documentation/devicetree/bindings/arm/apple.yaml
index 873b62035bc4..2831a662f5d5 100644
--- a/Documentation/devicetree/bindings/arm/apple.yaml
+++ b/Documentation/devicetree/bindings/arm/apple.yaml
@@ -51,6 +51,12 @@ description: |
   - iPad 6
   - iPad 7
 
+  Devices based on the "A10X" SoC:
+
+  - Apple TV 4K (1st generation)
+  - iPad Pro (2nd Generation) (10.5 Inch)
+  - iPad Pro (2nd Generation) (12.9 Inch)
+
   Devices based on the "M1" SoC:
 
   - Mac mini (M1, 2020)
@@ -188,6 +194,17 @@ properties:
           - const: apple,t8010
           - const: apple,arm-platform
 
+      - description: Apple A10X SoC based platforms
+        items:
+          - enum:
+              - apple,j105a # Apple TV 4K (1st Generation)
+              - apple,j120  # Apple iPad Pro 2 (12.9-inch) (Wi-Fi)
+              - apple,j121  # Apple iPad Pro 2 (12.9-inch) (Cellular)
+              - apple,j207  # Apple iPad Pro 2 (10.5-inch) (Wi-Fi)
+              - apple,j208  # Apple iPad Pro 2 (10.5-inch) (Cellular)
+          - const: apple,t8011
+          - const: apple,arm-platform
+
       - description: Apple M1 SoC based platforms
         items:
           - enum:
-- 
2.46.0


