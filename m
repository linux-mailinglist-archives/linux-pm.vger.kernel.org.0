Return-Path: <linux-pm+bounces-14302-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 615C897957F
	for <lists+linux-pm@lfdr.de>; Sun, 15 Sep 2024 10:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28E2D2860BF
	for <lists+linux-pm@lfdr.de>; Sun, 15 Sep 2024 08:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AA0145B11;
	Sun, 15 Sep 2024 08:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrhnuRvF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B40375809;
	Sun, 15 Sep 2024 08:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726387742; cv=none; b=kLyKad6mlxEW6xjIRnaW95zOekX9SF9TZG/GAl1OrtMZ9z4AUPY5xsId6kcjBF4VfAMbT6i52F5XQcmug/oyRjYVZwfKu5vHowvGrjwufsbI+WidfLxWl4+UQKUPUtf/jcfBxpMF/aSRhXCiwXMrm2uG9666/ysRbOCvCmoGngk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726387742; c=relaxed/simple;
	bh=6FSSL/1GJHHM4yYO8TALeYc27Beldx7BQtdFJgXPUnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FdRiRHspuPO6h550nzLwr5RfD57+ZIdBkPexOYXB+bgJXPUStKhTrWGOu7DhTcPabJnMdfruDpnOo86Kn/Vo5sahl+9f4oHdZ8F52k/+6Uka5Xl2C2CyhALtp7mu3MbzTUke/7DIRxD95puo6ao2V+hJ1SYlvnHSiV/aFLlt/YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YrhnuRvF; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2054feabfc3so28482035ad.1;
        Sun, 15 Sep 2024 01:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726387740; x=1726992540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDPaGS6bVIcDNoI2jUHr5/zaB32Tr6Dax7THrbzLs58=;
        b=YrhnuRvF/Q0MsXpJy5+6Ch3+aIlHU1h3/Gr6BBaXksTBuYZR9tA6iZGWkwh1l0UoEx
         inwTe5k2UPi6vL5KWbXjlN2vRAqXnhuldoHH4Enwgodg3Fd/T84pUvasxlbcFhmmtw6j
         IJVp9J+9vHJ3KjAVWc8XTYtB9nVPNWlevHPSk4SUY5h1Yg+kwJ4rOztW9Pn3migpZRgw
         VskYV5a64+NcQwuBYRi0u1TZFnXyleG84NsnUaeT2q1M6wbHDWXwuiQ1AepYItE4yp/9
         TpdhQv0NX4V8NV4FCOQErgFdiZ5t5IRkAkvNq5P6BL+7/AX4k5QTMYLIKusscKR8JgwR
         kFtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726387740; x=1726992540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oDPaGS6bVIcDNoI2jUHr5/zaB32Tr6Dax7THrbzLs58=;
        b=hNOv5HGoDX3NYVV3Ob+Ioo5AU5KFZ/OiCQzTKDH8AMAYi+MyY8FNFsl/qQvbUuZjbV
         jvtI9xldOPtu0oTZrgZREFmbJkay0plbrfxX+i0TD1Su5T89tOHQxNQcJ6M4/Ni93m7S
         WJ8S2DZ7rY2ryFExICpQ5/zKYtkxZa2Z2YAdCH+ag/WFgUfgUhspBiXJDcTxeysvsJBC
         YmMGCcuOEWyrFJo2lhNERB2iWLvs8NI9vs1XApAb94t0b43y9eOCFwnWrXaHU80Kqqq3
         roDvbL3XbxxiMR7Pifl7JOnKdI8MjcBOypt2LhW6y3oyjLqVNbJ9zMA/idEvnqQiy+Uj
         1Zrw==
X-Forwarded-Encrypted: i=1; AJvYcCU2Exa4pqpX0U4Jh2gUsI5pyg2q/nip5DEowzJk7+8pmLKQ6A8sxp+ilwCf7D7Ft3iDA/LD+llnR8HOVJPqipM=@vger.kernel.org, AJvYcCU2R+fVR7BLAkY1iBSIMkpTdFsn34IpsY2sq2A4/toBtGmyK2/BcJpf5b2tIIQ0yAjfNiA0sNwl8FD8xw==@vger.kernel.org, AJvYcCUH6kqH12zDD14+tkt7N2NE//ufFDVB9U3/0Qvq9+PsPyxTWyf+OmX0Tb2nsb76aE8oQGjI6kgsYIsYcaAI@vger.kernel.org, AJvYcCUw+9b6DsUQ8YT8YooARP2SxvykjibVb5vkbFqlvXIQXX3LcjgNV8nndjjI3JQxRuDylif0QJdhHr2k@vger.kernel.org, AJvYcCUyi0za/79pRxOsWYxukG+cnVLqr2rYf5V3hPkA2+ForLUYFVnEGMZ4sfBmez4SXv0l9FilAjLjxfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWAxMx3hJ5YDls0mgRg+efimYbtJxb/O9UOK03QwRRzvxb09Kx
	/S/kqFW278WqYBn364wkNJwlnlzJwj/1D88GQFmVL/jxQAc4WJXp
X-Google-Smtp-Source: AGHT+IEVHTa5Lbfq63PMwEjTcrPbupnkuunt132jqR2BhwlLFkDkPh4npb+kw4rK27I2Cw0H+wTgHw==
X-Received: by 2002:a17:902:f68b:b0:205:8bad:171c with SMTP id d9443c01a7336-2076e31954fmr183465055ad.12.1726387740579;
        Sun, 15 Sep 2024 01:09:00 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-207945db012sm18248865ad.19.2024.09.15.01.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 01:09:00 -0700 (PDT)
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
Subject: [PATCH v3 10/20] dt-bindings: arm: apple: Add A10X devices
Date: Sun, 15 Sep 2024 15:58:55 +0800
Message-ID: <20240915080733.3565-11-towinchenmi@gmail.com>
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

Add the following apple,t8011 based platforms:

- Apple TV 4K
- iPad Pro (2nd Generation) (10.5 Inch)
- iPad Pro (2nd Generation) (12.9 Inch)

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 .../devicetree/bindings/arm/apple.yaml          | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/apple.yaml b/Documentation/devicetree/bindings/arm/apple.yaml
index b6a2916fb0f6..d72d8cb5bf20 100644
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


