Return-Path: <linux-pm+bounces-14226-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 806CF978DC7
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 07:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8822B24655
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 05:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6414158DA0;
	Sat, 14 Sep 2024 05:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQnFFpsL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB81156886;
	Sat, 14 Sep 2024 05:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726291561; cv=none; b=EvfQPDpBAmkjqymRE9xcSIrFsl1hj6tIuwreckBfg77Z36Q5bDmrtG0foew1ap9L+6JHGarPsCs/jDBz8uOXPSbVwbxhFRidly+uRlnarK+g4kS/vpDY3i9XJDbaiPGC+1syLs1mcXIyQYDRUeiJu3T29kuP6Ow4V0f8zDshnXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726291561; c=relaxed/simple;
	bh=Ip2tb3iy7JRH2Qjba0QEVmokUA/nKu6k64UrMnAWYDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q4Dlb2Q68FcTgjm/3AFPwKbewHXhT7aID98xBjrg69uPwOjzXHPzTLISNwqrWnbdbBgXvIklvbgGIr4vmSSazr4qNDCDHTB/SFgDeOfQvrNM0fUiVXtKyxQezrwEc6ERBiSYk2Mpba+B2HUvA6Y3oYfW0HKJrzFc5MVrDrzpoaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQnFFpsL; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71788bfe60eso2135759b3a.1;
        Fri, 13 Sep 2024 22:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726291559; x=1726896359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XASDwZWUX+C1//Vw0xrpdBLG8ljIMrpmRJ18G2XwTwU=;
        b=VQnFFpsLLNz2GmV9aUpGeuswySXrUQLuUlNRrPdCYYbFwsF7tGojvJ6GyALBXPj/eb
         9T1sWeLhIlHJXfaOGnRlRx7yiwELZnpgmJq8kuF0lsJOoQYiWQYQqv3aXJUFSJcdYFD9
         EHSLrF3o9Z9gLmfnEzTZxurxLVWo1T+Bu9lvYFp652SpWT8StUEhyjap5qv0rMcUnRwo
         w2y3sMf47DaR434HDFMBPdIx8x9nD/RvDjXhTzfsFE1DlO5rxMMQMyze8g5hpJVunkfM
         5YegTGLyjc9GBnCu2vIvm1ykKUynZPQvUEToaPH7+tQ6Bs9NcKCWXcE9kmnl0dJHucL7
         itWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726291559; x=1726896359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XASDwZWUX+C1//Vw0xrpdBLG8ljIMrpmRJ18G2XwTwU=;
        b=W0DDmNFHHgBejVZd31qNpfTQL0cwZogtd6WNtOkX4tVFlXnBub2XdNCzHCp40dZZCE
         RuZNjol+53t1+Jq1zwTuRHDAQ80mElFjR3xxIgqeMBM5vosSzCTW94ZMBnFXcbg7p9Hx
         rbbRHG6nXNw3llFAo8XQeGDhQGNiYU6BMFpqyMAWdHETQ88dnZQUlWZvtmnfqx92IXTV
         dDgZbCAF7xwFnew1IEHQlljBElCNEGk6CFFqem1JFVy2GSPEkbI+xrJe5rGWDqzb/bKu
         785s5Psuz2hsn99nAD5+csxpNFc8kT4AzXo5kj6CwZyHwWxfP2kfUx8kDjh4o46eNX7L
         fs/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVW/oiUM+6ZxtHTjGc0T+m05G/ORg9W+k0DBFAny7lmvruForFtET8oU9x/ZAF7OgDESkwNieA5Wr4=@vger.kernel.org, AJvYcCVXZX+QSt48uLYNOE1VRb7zcssG4IMlaFDeh4FzSomxdzUCnuF4SxKvvQCtREo0A7Tq4gO6Jsd7yRL2pCO7GYk=@vger.kernel.org, AJvYcCWPkKfSaRu1guB3asqrOhpmFNWhTCPzbibCbzGkbmENpUBsLOlQ+v7XATRA5YXlvBydOdZdSn97WQCmykgL@vger.kernel.org, AJvYcCXPrTOUjxF7SWBVKC9TNpX6rbgGtPrfYYRJ1+abYz40b/YWOElXIlV2PiIo+3mPByXjogNUGFGLOD4n@vger.kernel.org, AJvYcCXid1yKj2URvbEyY/sYa/KSET+LvU30Lx81D78hv1YkSeV+Rc8fHXnUoy6TnaOUbgZBO/AC+SPODTcL5w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzer6/wJm1ESr2gLV3x47n+GUJpXqKbov5/xDygo2ie8O97RNpD
	eh7nEw0PdmTK+dtlIbB/bHNY1EkxI5lt6STnu236JUtPeCJ8n4rZ
X-Google-Smtp-Source: AGHT+IGZUn5gSNpsB3krCasHpMWXOgM2hsTIduT6Log7/dlk8WDYq1PZYEh0VB0wLcsuIsqGbHliwQ==
X-Received: by 2002:a05:6a00:acf:b0:714:241d:a323 with SMTP id d2e1a72fcca58-719261e0ebdmr14007202b3a.17.1726291559499;
        Fri, 13 Sep 2024 22:25:59 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71944b7b749sm391223b3a.113.2024.09.13.22.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 22:25:59 -0700 (PDT)
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
Subject: [PATCH v2 10/22] dt-bindings: arm: apple: Add A10 devices
Date: Sat, 14 Sep 2024 13:17:19 +0800
Message-ID: <20240914052413.68177-14-towinchenmi@gmail.com>
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

Adds the following apple,t8010 based platforms:

 - iPhone 7
 - iPhone 7 Plus
 - iPod touch 7
 - iPad 6
 - iPad 7

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 .../devicetree/bindings/arm/apple.yaml        | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/apple.yaml b/Documentation/devicetree/bindings/arm/apple.yaml
index 11873b2a9421..cb33bd1e7a2c 100644
--- a/Documentation/devicetree/bindings/arm/apple.yaml
+++ b/Documentation/devicetree/bindings/arm/apple.yaml
@@ -43,6 +43,14 @@ description: |
   - iPad Pro (9.7-inch)
   - iPad Pro (12.9-inch)
 
+  Devices based on the "A10" SoC:
+
+  - iPhone 7
+  - iPhone 7 Plus
+  - iPod touch 7
+  - iPad 6
+  - iPad 7
+
   Devices based on the "M1" SoC:
 
   - Mac mini (M1, 2020)
@@ -165,6 +173,21 @@ properties:
           - const: apple,s8001
           - const: apple,arm-platform
 
+      - description: Apple A10 SoC based platforms
+        items:
+          - enum:
+              - apple,d10  # iPhone 7 (Qualcomm)
+              - apple,d11  # iPhone 7 (Intel)
+              - apple,d101 # iPhone 7 Plus (Qualcomm)
+              - apple,d111 # iPhone 7 Plus (Intel)
+              - apple,j71b # iPad 6 (Wi-Fi)
+              - apple,j72b # iPad 6 (Cellular)
+              - apple,j171 # iPad 7 (Wi-Fi)
+              - apple,j172 # iPad 7 (Cellular)
+              - apple,n112 # iPod touch 7
+          - const: apple,t8010
+          - const: apple,arm-platform
+
       - description: Apple M1 SoC based platforms
         items:
           - enum:
-- 
2.46.0


