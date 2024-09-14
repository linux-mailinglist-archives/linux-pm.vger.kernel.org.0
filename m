Return-Path: <linux-pm+bounces-14225-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E48978DC0
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 07:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CFE81F24C87
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 05:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E732154452;
	Sat, 14 Sep 2024 05:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JuZRMsbH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18D3156225;
	Sat, 14 Sep 2024 05:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726291557; cv=none; b=oRDtEglPdKsKGQDNAIjzsD25JzBJ+00QiQ4ZyexS2+BRaGj6IN33whMTdsPHwQS7SBsCFTIBbvwOZjEEQlHkK7kPlh373mUvxFkrcXx6p32YcET/0Bnkzs9FpvdCUFDGrq/50WJezdP+d39ahRDKhVHYY1hmzAwWQioigXICxE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726291557; c=relaxed/simple;
	bh=Ol6jk5QblITohJFz2fUul+jrAnYdlIQVymi/NwT8lpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n+gt+/xHgWr+X8WZe/2oGpiLu8gYThh81O4SBzsrGkHRmVBECgAdsDdHxL9yIbG257n1yRK3L0Bw0HHr9ISMxj8KniGz3BEV0faz/PV/hRZtOQh2e7T9QYHReUD+Vbtf6LGfmQmVD2egKPlhG9GQdWl265NKRgkf+9hgSvVn7VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JuZRMsbH; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71798661a52so2160138b3a.0;
        Fri, 13 Sep 2024 22:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726291555; x=1726896355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ov/z3kQKwuY1dKrf8PnilixoqOfE5RUmtJyOePMWLLc=;
        b=JuZRMsbHL3We9fweSo4W83Tcl4LT/opks5jBFRlJyj/6A2E8X9trxJz7Cz/qnuTION
         z6jW8evd5h40qLTXgthOYZfZDVpGL8m4il+txHuyPiaPNfPZja9NUPQ5wJvH5EqLZNhP
         3B+XjZTkSH5Hax1yAZ/HEdMdUIri8b04ixCWsq1VN9ZpDbJjinXxLJpe1WnXWyj+M9Yl
         XdymZdg8sLSk+aYjwIA/aO5m0y6FJcRMdJk7LuS7RimvGlg5DHEj+JdWoMViifs6TtS2
         J1f+1OaR005DmFST+lO8KViIJdL4sfk54JuBfMUIuULA1jToLxtieSUZUksmy51O/Mhq
         FYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726291555; x=1726896355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ov/z3kQKwuY1dKrf8PnilixoqOfE5RUmtJyOePMWLLc=;
        b=g5+/ELJz6vilrD0X+mWMszWlOey84S2nz8RO6KjoFhQleXHMv2xVhsAt/UYEA9VeJu
         AdtyUgXmC8abpVFeLyp7KfBfaMilABDYB18+rcLveEHkdGxwyYe84MQgmwAE45a4mmtN
         +B8r20xdAZ1CGp6lGkAjcsVb8n5w7jALy+kMOm9o2PwVwOxADdm8afMheUQc56WcRQqX
         mZVn0l94PjO6RVx3M6QFYHtcZJQCySpqCLrw7Dc20EwMK/UGnaZ1iC0tIlPuDff2Zur/
         LoST/goT9aRS6Jm+syedVi5TUB3Q3X4YOM2a/1dc+A/SUyr4SQsY2BDl7SVgw+y7EWIW
         GsDw==
X-Forwarded-Encrypted: i=1; AJvYcCUh7Vy6D03skhxDlr3GWINoWPnEcdosxK47XUwKgdHV7fwzE2vFG1dqbjWsLeAcqebeMZq3XtAr12/nuiI3@vger.kernel.org, AJvYcCV098EZYMIq32afL4MUVYXRsIvgVkz9zNB7EMI9j8g6omGjm3xFgn8YRZD29jk29DMdT3r7ae/VpTyAFw==@vger.kernel.org, AJvYcCV1bBTC55iu81f3hCNvBrGaewtisxMEuYqyf8JWKmJ97TaoUbaLrO7N3gPcAw09n6JfAOUEDBjZpaLW@vger.kernel.org, AJvYcCVSL00ik9YbdAiT/MuQg5kivzGSn05Q58RdDjXYZuanKLWEdYpaXRT/h0BSEe6Kt/0oeKHQnr89C9c=@vger.kernel.org, AJvYcCXrdVl/TAZ6vp4OHL5MB13Zom9oCOP3H7fNJsRCZ89LgzcoXSkLPNbjJKmIgv29pt4gzYeJMjsU64sAaR1mqPg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz7seSlITHg1PCNBJJIAw0BQ936vc7P0jrgvK0YI/IqKB7z0U5
	WFUjlwnVYCuanVVb4tkCJE2m8/PGVOHkZDyoSVrhG+Qd2rDinYLf
X-Google-Smtp-Source: AGHT+IFIA/8fSoKR1ME+95F6ZI/st19HfcPTmRKqgyxSxqYmWUIfRmCy7rU0G9QWYOYBGXWyB6rB4g==
X-Received: by 2002:a05:6a00:2d87:b0:70d:36ad:3f67 with SMTP id d2e1a72fcca58-7192643c3ddmr12846073b3a.11.1726291554984;
        Fri, 13 Sep 2024 22:25:54 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71944b7b749sm391223b3a.113.2024.09.13.22.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 22:25:54 -0700 (PDT)
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
Subject: [PATCH v2 09/22] dt-bindings: arm: apple: Add A9X devices
Date: Sat, 14 Sep 2024 13:17:18 +0800
Message-ID: <20240914052413.68177-13-towinchenmi@gmail.com>
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

Adds the following apple,s8001 based platforms:

- iPad Pro (9.7 Inch)
- iPad Pro (12.9 Inch) (1st generation)

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 Documentation/devicetree/bindings/arm/apple.yaml | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/apple.yaml b/Documentation/devicetree/bindings/arm/apple.yaml
index baf0ef632231..11873b2a9421 100644
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


