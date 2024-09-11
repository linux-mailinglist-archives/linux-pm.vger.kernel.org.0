Return-Path: <linux-pm+bounces-13993-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2D3974D34
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 10:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF1DEB21ADF
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 08:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E264186E3B;
	Wed, 11 Sep 2024 08:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDbYhGbP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A85186E29;
	Wed, 11 Sep 2024 08:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726044457; cv=none; b=rpA+WOdOEXazzCCmxgPPeWEzgKX1h1C5U4TsMfaO9LzuKJeT9y7wf4biJSP2VO07YnMy90HWLk25BVrt9+kacFRpFgzv+Pi5Mj513m3b6f8QXpdmpzP6djWZiHopjNCqnI9GZH9B4yHl71pU/ySMr23Pyyk86wwAt3woncaucIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726044457; c=relaxed/simple;
	bh=rlWe3x1oIfwBFP82rKxvCeoNstM7m0ilhyiMtpKm2J0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XitaRTf1E8Pb1i7ofRrFhZz2osq4oX26/bg3OB8bUdvPxrioXaPN+bfUJ9W8oOMlmBDxPbTUh3S7ABroJRlc7mKo3xeok2QZyfqONZzVImCoZ0WGq70YOphbICgyQ3BG3jb+hmceDNzJZhROAS9sYDLe7PAXmZIGZd6iqgYjvnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDbYhGbP; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71790ed8c2dso5626244b3a.3;
        Wed, 11 Sep 2024 01:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726044455; x=1726649255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsMK5dZnZxr5aimciutwu7vmsAuU926u5lK8CD2rBnM=;
        b=LDbYhGbPtj1ECPmefR0OHMrOmJUfTEjzV+ctrM0k6zt9SqRb2LTSMR/Sd8uIyufAZT
         a/EBixba0Naea4fIs3z1z3F3oeDNYj/FB05ouAKfbouh4o/xRrMrXh2vwcBvBjVEF1cF
         J1s2CKhb5CQjLJniK0ahaL02xNIGy8zAooLynfZpYb1mn05/YtfCRDMU1PJNWFhYxVt4
         p3kBvegJa0f8Ud3LFR+03Kxto4Kazhg87BLO+4UwpRwG4gwm8a+9bEt+GwBubR4E8k/c
         7JOOhD0jIRCGr+VeLLs2iCnxP0qsNMvI9imqrHb9AwhqxpOBEBu5XzbUyGKn6yaLrxEO
         yFBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726044455; x=1726649255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wsMK5dZnZxr5aimciutwu7vmsAuU926u5lK8CD2rBnM=;
        b=oaBez+fF55jiGDnnTDBMhCVPFu6wLNm31co6ZOJmb3oNXEryI2XhOCCCsAednoKxph
         hOVYGXMiWlcPZHs/drSlSrQsGlmDS46lk3mSyLysySQ7mgTikhGye+xZwW1DQmk59Y47
         7MMkPKXJ6ECDmQLpPzA6Cu2wadFWWQMsX/WoyyzEgMIXC4PkzCb4CoMsKGnK2Sd0DsWQ
         RlqBSg+ATgej8U/2Jh5OhH26yESIi/23uAGpzznVcbQW1RZZABU9eBwlDkr8fM2QZ8eh
         BAtOGI7cX3rgNRbpxYnTI3F0yA2dD4E0q6rWPSRndewpVjq6PCFTXHd4AescPHoCQwhk
         FRQA==
X-Forwarded-Encrypted: i=1; AJvYcCUCkWd24z9sAlrQLQkTyR7ZmtGeGUqM3IK8OaktVdFmaQDnBJ3oXOJtCRDIqVs3svfvfbHA/4h+ZmzJqg==@vger.kernel.org, AJvYcCUc6YUo5KHhAkPK4SEbRFQjLGjBj5K5NL78SKNxKpUQtE3b7rOac5H806LtSeqxcYMbvB9kAzltx03uxJCoZKM=@vger.kernel.org, AJvYcCVFkMXshFrr1kt4Sbfz429yI7TdYaddoPd3nSXfQrt36OJFWhVkL4EP+FGlIa0pot3bi8Wo7m2OV3+qJxbC@vger.kernel.org, AJvYcCVNt5TGLNrlBMtQvOxLevq/41bZ2kcLOmvMBoniJ/at9zQMsQcexvGntq1h9H0B4y9QmYETu9N6mcQ=@vger.kernel.org, AJvYcCVkzDynJdXBkePPAsv9FvbcWYl1nPYczWWrZVZx9XflFdCPKJVxvambnb6dJD9tr2OO7Ax9DsHnxZTr@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5bl8y55edPtBQylDDp0XrKgt8WUP/WI480IdU3HPuWJiNg20v
	gqPKyg9bJGlvJ0Cd3kGdaIO0CWj9jQYbRkNK2K10/o25J6Ibbndj
X-Google-Smtp-Source: AGHT+IERnHemvoP5by0tnHvzp2xdkPOo0seCRQgLQ0okm2hEjw0ezJ5MPH2AYtaklWcPO3AzarI53Q==
X-Received: by 2002:a05:6a00:244e:b0:70d:2b95:d9c0 with SMTP id d2e1a72fcca58-718d5e55d73mr28265695b3a.14.1726044455161;
        Wed, 11 Sep 2024 01:47:35 -0700 (PDT)
Received: from nick-mbp.ust.hk (wf121-022.ust.hk. [175.159.121.22])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71909095177sm2530125b3a.112.2024.09.11.01.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 01:47:34 -0700 (PDT)
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
Subject: [PATCH 09/22] dt-bindings: arm: apple: Add A9X devices
Date: Wed, 11 Sep 2024 16:40:59 +0800
Message-ID: <20240911084353.28888-11-towinchenmi@gmail.com>
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

Adds the following apple,s8001 based platforms:

- iPad Pro (9.7 Inch)
- iPad Pro (12.9 Inch) (1st generation)

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 Documentation/devicetree/bindings/arm/apple.yaml | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/apple.yaml b/Documentation/devicetree/bindings/arm/apple.yaml
index f3f100ce8072..27311c75faad 100644
--- a/Documentation/devicetree/bindings/arm/apple.yaml
+++ b/Documentation/devicetree/bindings/arm/apple.yaml
@@ -38,6 +38,11 @@ description: |
   - iPhone SE (2016)
   - iPad 5
 
+  Devices based on the "A9X" SoC:
+
+  - iPad Pro (9.7-inch)
+  - iPad Pro (12.9-inch)
+
   Devices based on the "M1" SoC:
 
   - Mac mini (M1, 2020)
@@ -150,6 +155,16 @@ properties:
           - const: apple,s8003
           - const: apple,arm-platform
 
+      - description: Apple A9X SoC based platforms
+        items:
+          - enum:
+              - apple,j127 # iPad Pro (9.7-inch) (Wi-Fi)
+              - apple,j128 # iPad Pro (9.7-inch) (Cellular)
+              - apple,j98a # iPad Pro (12.9-inch) (Wi-Fi)
+              - apple,j99a # iPad Pro (12.9-inch) (Cellular)
+          - const: apple,s8001
+          - const: apple,arm-platform
+
       - description: Apple M1 SoC based platforms
         items:
           - enum:
-- 
2.46.0


