Return-Path: <linux-pm+bounces-13990-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A5B974D24
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 10:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60F922888C4
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 08:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D55185954;
	Wed, 11 Sep 2024 08:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Msd0bO80"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B24315C13F;
	Wed, 11 Sep 2024 08:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726044442; cv=none; b=NLV0Z9b/q8unyCGKwS4QQOHOms9/bPoBxvuJO8YQKLIXoME9CNfk67X8Sz3baguoXqfF86b7ZyzNdTlLzBfFQMhP5iOoOM4743w/zq65oH3IBhCv/WcB/mkbPk2304wOeotxIfgq24tK+Lm2+/LGmY2KpBG49TKXgyOJXKxntrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726044442; c=relaxed/simple;
	bh=pn0dBKtZ/6XIFiLt29sYpVdPgmjVJwfbAGYQjqz2sSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=McTByw5eRhTy+/iDorrMuUGXpAubdBQyMXaWG5LilGVY2cxMsohZI1FdcPNB7NfSZafiiQYCEo/eeILeG51ZF4FfzixV76mp4W3fiLdwWxFzrNQtSf27WY2xiAX/izpSAtYwYvYe7v8YUFLdiGwFRGxYatSF+98boDK+KJjvu/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Msd0bO80; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5daa93677e1so3796543eaf.3;
        Wed, 11 Sep 2024 01:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726044440; x=1726649240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzKuObdjjifIV6p4p1YvXXo1tsy2evI5DY5jece87LM=;
        b=Msd0bO80hzJ90VPHw2nK3RwBj6590p6V1gI9BoezsJR1Wvp0U9MQ84qlN1nVPD1kvR
         VVq138zM0qFamt237omT1kYdmdFWxo9DZL7tqPYjWnlPPznJjmJkYmBBDabBGOoW0qma
         dnfpWlSbf1lvCl8gCocPJpQhPr4gkEl5zbXb4vvxDzGyNJZJPtri51VOMAaB7HAgt9Qt
         E/mziYEPwrMUuq+TRgGGtXVA5Hr/XZmzpFx6Gy7CpGD+d2hIAAx0GxZyeD/u7320LJda
         2UC9gDfEfeP9QHynzWAV6zDiFytgzxXHYsF5BTHDKV7VNlohR0DBAveXNDadaQAgDQK1
         U1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726044440; x=1726649240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tzKuObdjjifIV6p4p1YvXXo1tsy2evI5DY5jece87LM=;
        b=dPX3Iow2cN4yLpGoxOOXsEN6camDqPBqIrX/gnfBFbGt/+LDirCu+9pfCoJT7tdxkD
         L+UuSxzugCa5zqki6SgWEXLwCoQzDkMZiMAXZ1S7Qx10N7Hs7uBZ9wazEJV4igBAwIwe
         plZqp7tMUKlpI3urVIg7mOCHn/S6Gc9MA2QAvLLaMqpA1Yk/vbsdeyTGhJT100htSQnI
         wHx2Z++p/bxjRuwgf+1Bm6coCz8p2kWePAMBfzI/jJuYYdhC02UuI19GbTYFUynF54KS
         CpI4NytYr/wytdMuRRo53UjoBQ4HFHyGbWIZc2sTuIYHu0ClsoR4WWuz1YnryEQs+MZC
         uY1g==
X-Forwarded-Encrypted: i=1; AJvYcCUvPrn5KxcIUJtx/S0fqG/AB0GGxcZf5NzvpUbtq4r7ku4MDW+NI7mKqlVwfn46vdz1HoPWol/2G0U=@vger.kernel.org, AJvYcCVGPBZPS00Ik2U19zyQqyCjwTVh+FVhFHfbvtYTNSa3agzd9g2Siepwy95C5OKo1duMkdbBgSuSTRiZ@vger.kernel.org, AJvYcCW6wzGSfyMJQehGrKQLUmEk6Evii0FsHyJBX/9pK/f8P4cq2oPVtv7o6ok9pA8z5ke3BPVcQdBu56Zkhu6G@vger.kernel.org, AJvYcCWfBKxymVtNYwheRm9wUMS34ZgqecWBewK4qjqaLyyTtJFEdPo1pvnwl0HodGP7vk+IzBTCWZ4128jnAd/jD4A=@vger.kernel.org, AJvYcCXCy7x2DfzZJO6cMx2Y1QE9sMmFzSyf6CFymRRFVYlVC3UfjKBtULoLfUMHPIWB7vbGf+AfHlS3eVHn1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPOeWqUd3hRFbCoTGrw+82KYeDsu2Rblp4qvGA067TP/3X84FT
	YSZEVXRAVDGsVTdYeZkn0dou9rm049cxJJdgJ58BHIQgpkcP2WAZ
X-Google-Smtp-Source: AGHT+IFVGTKfjROcC2dmcDyR3+3zulhvPISRva2vpsWPrxA6OsWKXTSlxZPTNB9nldnbZOUYIt0JaA==
X-Received: by 2002:a05:6871:3786:b0:278:7ea:99d with SMTP id 586e51a60fabf-27b9dc85c23mr7226021fac.41.1726044440522;
        Wed, 11 Sep 2024 01:47:20 -0700 (PDT)
Received: from nick-mbp.ust.hk (wf121-022.ust.hk. [175.159.121.22])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71909095177sm2530125b3a.112.2024.09.11.01.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 01:47:20 -0700 (PDT)
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
Subject: [PATCH 06/22] dt-bindings: arm: apple: Add A8 devices
Date: Wed, 11 Sep 2024 16:40:56 +0800
Message-ID: <20240911084353.28888-8-towinchenmi@gmail.com>
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

This adds the following apple,t7000 based platforms:

 - iPhone 6
 - iPhone 6 Plus
 - iPad Mini 4
 - iPod Touch 6
 - Apple TV HD

The remaining HomePod is not supported as part of this patch.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 .../devicetree/bindings/arm/apple.yaml        | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/apple.yaml b/Documentation/devicetree/bindings/arm/apple.yaml
index 3c81008f0e96..cf4f5d6db1d3 100644
--- a/Documentation/devicetree/bindings/arm/apple.yaml
+++ b/Documentation/devicetree/bindings/arm/apple.yaml
@@ -19,6 +19,14 @@ description: |
   - iPad Mini 2
   - iPad Mini 3
 
+  Devices based on the "A8" SoC:
+
+  - iPhone 6
+  - iPhone 6 Plus
+  - iPad Mini 4
+  - iPod Touch 6
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
+              - apple,n102 # iPod Touch 6
+          - const: apple,t7000
+          - const: apple,arm-platform
+
       - description: Apple M1 SoC based platforms
         items:
           - enum:
-- 
2.46.0


