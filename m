Return-Path: <linux-pm+bounces-14303-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1F5979584
	for <lists+linux-pm@lfdr.de>; Sun, 15 Sep 2024 10:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DED341C203D6
	for <lists+linux-pm@lfdr.de>; Sun, 15 Sep 2024 08:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DC1147C98;
	Sun, 15 Sep 2024 08:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRHlfhpN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7BB1474B5;
	Sun, 15 Sep 2024 08:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726387747; cv=none; b=K6HBUWzPNlK/e8VfrPoC3KrkNHZiNJcjhaKbgG0eiQvGLft6v2IA9TQZ0l+xPyDnMwL778B6lINvZAjZHTudpHhMlYzfCElkbMsPovyZckKSUWT10epLnMzGr7dG5A39GWXm/D3pu9PXK9kUZ9ssnvuwl0Ahnsw8Toyv1oJy5pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726387747; c=relaxed/simple;
	bh=CU0qhw7cssybn85/OXxghtzpEYf+3Z8n2rJk8dTkCQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lIMwk99u6lvzsQrhnHSRqsBfjlZALr6ErEpLFHHfa2XSF3BX6K5vIrbasHQ6X2GSRrKGC7Z9VpTN/ihhEjW+/7ZOxPfaC5mGQYXOZpuR7z0rh3TWRgapMwC8dlW05nkS+HDWGXCGC6diCFH3UvDcyYGKbpFluX5pTHhP0I560Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRHlfhpN; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20570b42f24so36534535ad.1;
        Sun, 15 Sep 2024 01:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726387745; x=1726992545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iRXUjLR/JiIWhsC/W3OBy+N3UT+NZIrNxtiZw/1dARQ=;
        b=SRHlfhpNv3RLiIxOtzhkdiVDS27ZODgV27WRuXWhK7+CIQF/S1qKhHFuBFpMzc/Wp9
         B+MkYryBTBzB9uYnOUnP//OCQvRfpSEVyTCvtRPhOWk477FuRSbrkpOANF8EMpyzxPvK
         Z29jt4MiVokmNAaPp/uD4N7ihnrYl4JjnqApDZjDigQwjJP+8iCBwyFQ06wAODxYK6xm
         oVLmVCNhNbZVf3x7UiugrisY0uMTYP43L1ggXekNIdQp+BCkEaemBJ48QkIZvgHjBFKF
         Q8M2nMPa3qMP3A2ZInw6vh1HuffrFCRYoB7NIADleOse+60PNCFle7wDpHGqksBhTWgl
         OolA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726387745; x=1726992545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iRXUjLR/JiIWhsC/W3OBy+N3UT+NZIrNxtiZw/1dARQ=;
        b=GI0ONyfiFZaat08AIt0slnle9+aPXdrUo0d1xBkgKoIPVXawuBBPBJuKnN/WA3TNJ2
         U4eY9J2KvcoSPPfF0psmTgNYkGC45usN6kLtleaZtWgqE8ts/njRDDoxugGTb+vZDnuX
         ZyZ0SEqeIAdJ15OhMfmVOzUN3P2xz17XE+6OiDxFkkWKq26dZvdrrUMz+y/o1YAhLgqG
         igJshVqUJ9u6OmO3KBuNxrQjv/kw9NkciPX/Dj0aHxgw7jVPQPuK5Xk0KY6jr8Zudb6h
         DS+GePOoMEcC08NTJ8jTRKha8RtfrTe9nOT1IJq8IBiaFeKUn2EnTYWjsmNoJ5aBdVNH
         VbrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrrsGbX5d10IahNrDNp9RpQzo4U26KkQN7i3Vte16FRDtlRb14HsCWvl2/tnMO665XzFeaE+FZ3zqnPe2H2tw=@vger.kernel.org, AJvYcCVLiJrRJLrdBCUVb+tsMQZbygeWG9LJf+86aQxKgWQVvKvaTZSr1+94uLrcB5PikkGDkb+4bz3wCH1Pyg==@vger.kernel.org, AJvYcCVwWpyFmC2gnmytehWSF9R21y/Ed9lGW4z1a4ATDUk0WnOeKMzA6ZYTvD6g0i0AqicHDd0LAQtF0P0FgRhq@vger.kernel.org, AJvYcCXNdmWYVvH8OUm56JZmf72U8oGGx5SzjL3ullCvOqOyIXBvJv+LH2EOPaJIZA0OWwx5SNyvHlMB2Qf/@vger.kernel.org, AJvYcCXRFD2A1yXuPP205XjNYgF754OyNRjuddt9MdOY3eiId1FrOPljRG1q4Sj8vJKn8luhVaTJXi/rxPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBB8e6NgOLfsPwQz1CWdziigsOmwWM4W3CgzvJ4+1kcFTCgDHl
	3Ana9ws224WmWlYWoLJ0ktpTmB5A71uzJ0uq65oQsQQDEyrcmE1D
X-Google-Smtp-Source: AGHT+IHbRHqKWnf46snj8Bwlc2hxypaMH4tJ1qLy2TOPjmZ2LDGq7qjDWKm36Gnn2Yc1clSRFysgHA==
X-Received: by 2002:a17:903:26ce:b0:206:d66d:a30d with SMTP id d9443c01a7336-2076e3155bdmr135102815ad.6.1726387745011;
        Sun, 15 Sep 2024 01:09:05 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-207945db012sm18248865ad.19.2024.09.15.01.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 01:09:04 -0700 (PDT)
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
Subject: [PATCH v3 11/20] dt-bindings: arm: apple: Add A11 devices
Date: Sun, 15 Sep 2024 15:58:56 +0800
Message-ID: <20240915080733.3565-12-towinchenmi@gmail.com>
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

Add the follow apple,t8015 based platforms:

- iPhone 8
- iPhone 8 Plus
- iPhone X

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 .../devicetree/bindings/arm/apple.yaml         | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/apple.yaml b/Documentation/devicetree/bindings/arm/apple.yaml
index d72d8cb5bf20..db32bda29336 100644
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


