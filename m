Return-Path: <linux-pm+bounces-14222-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3142A978DB1
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 07:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BCC61C2251B
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 05:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F107314A4F5;
	Sat, 14 Sep 2024 05:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsybKzgH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B544149E0E;
	Sat, 14 Sep 2024 05:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726291543; cv=none; b=j5EdfuLPvW6R6wlld7IrQt3Nfvnx+ewJwIx7HYc484AkGpzzEzVMuMpWkDc/2StPH8ZkfDGVnmtXQeEDOsFTBG8FpPavwq1rKEd+xXxLYh9zjDkkfikqMWYP9c9V3mB7SbinsCA2W6TwtskvdAaSw0Ue2gTutHctb30XtJJZ+A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726291543; c=relaxed/simple;
	bh=OlUaaTcJopX4ImU/3+mDs+QLmMEXACQQudQfC4ZPFbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tsdXQ7GPvDHJDW1row/DKD5sSlH14/AZHncpa8K8f3jdJ+U1hUbu9ogNTdwwhAlgwQSNw5+e57Go18oMyzo0UJkQrsSvOeTLgIWFQC8ncwEd0/vWqpENaWmbJeJ4vJkb27B9u6OlmVDw1Le9BeXADiFlkR94bo6+Luyt6rGubnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SsybKzgH; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7191df6b5f5so2072213b3a.0;
        Fri, 13 Sep 2024 22:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726291542; x=1726896342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ntbAqOWLE9Au/hBzMqkK764zm8fpYo/AOME1Agv7PAo=;
        b=SsybKzgHE7VRmqDrWX6pGsup4u0thRB2+VCCqPiX+66M1iHaQYiZAcn8fNQoN4Hz/L
         AxLxi0K6rKMz/K5dLapPPXdFHCx+XtvD7aab+hvqENajhjahygjZp+lfAajR9wTsIgcE
         mCter4ahLMUi5L+Sa5PsqDRf0hAnzevEXZ6DtMzz3joFsA7Jno5CJ/ZpDIj+E6HdqTMw
         hHrknCA5gzd6AhRrPsqgP6g+4ftqaubZna7zzI+Cd7Rt8g3KDKb/507kw6KwrJCr8St6
         nRE9WutXysz85mze2PeKWrX5FHaKYiwqk91iHUrDsfEPEALOQZqlmPB8jzBtzPGI49Wv
         NHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726291542; x=1726896342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ntbAqOWLE9Au/hBzMqkK764zm8fpYo/AOME1Agv7PAo=;
        b=sJsNrB6jwFbE7IGBn+QvJXdaGEIeOAM6fd9XVlIAftZiOag1T9HmLLs6KKM94qFsAD
         jOcLVliYZNeVYOgE0WO/HD4IhmTjkF/LUr8t9wajMHhwBhfCMCgCEz1yYPlRT/xOwLus
         0Ts57wqwU0euiwdN4Ulddi9i3Fgk+HlZPHLeUgrTAwMkQrVmcbnUsd4MkhbL/dd6m6lE
         YAy45liqSXjTfeNh5YqaG2UOq45xMfgWgDZYuX4qs13p2MLs9Cqb+/q0SJjdBKwt19aW
         l6LeHCOwmMR2MgOKfTXBulCiAfHz5ZrapN8fc/M8Bz8LX5BpG0i3OU71x27Ik7iAv+xJ
         KpJg==
X-Forwarded-Encrypted: i=1; AJvYcCUha1ZwffEXVWgAd6woSYjZ6Kuz20OzhF+BbcEOFOvsV6e91h9osaOV7fldvP6JGB2z5qBInYB9GChWRbdk@vger.kernel.org, AJvYcCUlAabxWeicIjMFwBHyIdTp8QoXRijW7m57rj4+qYQf7TSLyQnzxmEh15UyuXW2f2Ssm4U5B6ZAtQ7nR8PtsQ0=@vger.kernel.org, AJvYcCVearCpXz7XvEHNSnMb8mdjCg3BTGK5q/0Wnak1l5BsniG5lPAmxPDAKO6knqpbXtcR7cKodzNlDug=@vger.kernel.org, AJvYcCW9eAT+GYncDMNDQjhPmQpgK/4yUDCw9GqsNua0mOC1xnEEUXovRhNyIyseLYqr6ByYvClVyJaxnJPR@vger.kernel.org, AJvYcCWOHqflsqU5bf4j5CGWqUgHO8GG0DXYea0ksjqno/bkR8AvO2oYdKNnCfGLHl5ICliJzJHHDWp4z16KEA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7P1NfwIa7SrofbXiOlyCPSVsvxKrSF8qc3r+taHJjtjSfJQbu
	Eh+4EgL/vnmdU3lJSHZYBHexFbZ6x0+zPvPqA8qC0wOp/fPt2Cbf
X-Google-Smtp-Source: AGHT+IHUCDMF0XJkmpK9w39MJw1j+WBVI/KKw6WJabD93/gkagaR8BS4v4H9pSU7zGPGaXPd3iORnw==
X-Received: by 2002:a05:6a20:e30b:b0:1cf:6d67:c078 with SMTP id adf61e73a8af0-1cf76237989mr12510902637.42.1726291541763;
        Fri, 13 Sep 2024 22:25:41 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71944b7b749sm391223b3a.113.2024.09.13.22.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 22:25:41 -0700 (PDT)
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
Subject: [PATCH v2 06/22] dt-bindings: arm: apple: Add A8 devices
Date: Sat, 14 Sep 2024 13:17:15 +0800
Message-ID: <20240914052413.68177-10-towinchenmi@gmail.com>
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

This adds the following apple,t7000 based platforms:

 - iPhone 6
 - iPhone 6 Plus
 - iPad mini 4
 - iPod touch 6
 - Apple TV HD

The remaining HomePod is not supported as part of this patch.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 .../devicetree/bindings/arm/apple.yaml        | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/apple.yaml b/Documentation/devicetree/bindings/arm/apple.yaml
index 59f5be84aedf..691f3af19622 100644
--- a/Documentation/devicetree/bindings/arm/apple.yaml
+++ b/Documentation/devicetree/bindings/arm/apple.yaml
@@ -19,6 +19,14 @@ description: |
   - iPad mini 2
   - iPad mini 3
 
+  Devices based on the "A8" SoC:
+
+  - iPhone 6
+  - iPhone 6 Plus
+  - iPad mini 4
+  - iPod touch 6
+  - Apple TV HD
+
   Devices based on the "M1" SoC:
 
   - Mac mini (M1, 2020)
@@ -89,6 +97,18 @@ properties:
           - const: apple,s5l8960x
           - const: apple,arm-platform
 
+      - description: Apple A8 SoC based platforms
+        items:
+          - enum:
+              - apple,j42d # Apple TV HD
+              - apple,j96  # iPad mini 4 (Wi-Fi)
+              - apple,j97  # iPad mini 4 (Cellular)
+              - apple,n56  # iPhone 6 Plus
+              - apple,n61  # iPhone 6
+              - apple,n102 # iPod touch 6
+          - const: apple,t7000
+          - const: apple,arm-platform
+
       - description: Apple M1 SoC based platforms
         items:
           - enum:
-- 
2.46.0


