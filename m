Return-Path: <linux-pm+bounces-14301-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B11A7979579
	for <lists+linux-pm@lfdr.de>; Sun, 15 Sep 2024 10:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3D031C216A8
	for <lists+linux-pm@lfdr.de>; Sun, 15 Sep 2024 08:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBE3142E6F;
	Sun, 15 Sep 2024 08:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEKhgSiv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B9F14264A;
	Sun, 15 Sep 2024 08:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726387738; cv=none; b=uKUCITtMX8mx7g5vThXVdXRuASc+V1DS5AKONL8kjGaATpFnzLr8yAID2GM3tea43GVKiVjRGSyvNmZT/e1EFK6TkNi//7rjTjGQVQil14Uc+D03uJzHcES2vNkrxZ9Ugja63lCYytFDN6YLuXhMKi0pD82WM7FEbAIw32icWVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726387738; c=relaxed/simple;
	bh=V0wAJ3KgOJQBQptHA1TQBm5dVVW7DLpAyWuD7rLAvWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oGj9kMWPTgtEK/L1bLSZgPXCBHG3f3BvcuSoMcPyANER9uQKTfNqjEtY0QZdeenvkH0qZiG6oDf99ogLzhu6JiZ1enLUS9pKuz7PGdcT4WTndGLoajqJ7N5NfnpeFum64Vm3vAr9Io6UssuJNEjjvDtBZu5HQmLKRMB+LsrSQMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEKhgSiv; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2055136b612so43564705ad.0;
        Sun, 15 Sep 2024 01:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726387736; x=1726992536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ed1R7heD4sdGMJhfePEjEjpAPx6TqwKkotv7yYVzxAA=;
        b=hEKhgSiv1Nrwe9UiYbPXCB7QW250D+Q1QAHrfRusDnQ2QDxVdwxFA8DsvZqptYdjwc
         zK1ApWzp9maix2YZ/7BHRaaT3yMVssBpxpg0/0MtbD233TjwhZAIF03y1jnFJDADWpZ4
         7K/kd0znhjQ1lRitLgNV3vpiBXoqjyf99k5kqhd72ELAuvUDlb+l/kTyoL2NdfRNaelb
         OISzIbXONnNDX5ZLfId0Oq62m2EvJ0XkBbspFIf6Ta9PGYUL3nxqx59QGNjld6plgkwz
         Li8qXQacMs8teq0yjpLZcuBvSfRxindLntqgLAzWynselX21xG/qKntZ1YxPHavutfrZ
         nABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726387736; x=1726992536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ed1R7heD4sdGMJhfePEjEjpAPx6TqwKkotv7yYVzxAA=;
        b=hzJTfU29xkej91fKNXslBh7mGoH+3OMi3lHNys0NXBpEaVApXktGWWw26XQ4/IdywC
         ZV/iENjNlqbU8VmlF/ruOW8WPNir4oXT6zIVLtqv92aB9kxuZMWChxaeyjMt0YODUroX
         4TZ8sMH09AzsOL/ZalpWS0O3w3UTfhpekYIdBHW1HYwYuU8e7AVOHNhTipnCTcn1Fnso
         tTt13zj7PaWyMpMF1UatHdoAUVwJII3iIMHCkRshJbAUL4kyvAARy9EmTyo9Ul2WHUnd
         VgOLDo9YbVp82Z3UO5E83BKn0f5pTFuCCsJsUXLbRMM4+C+V4l+1vVLarMGlA6sY6hsq
         MtMg==
X-Forwarded-Encrypted: i=1; AJvYcCU+UDad25XhLigwOADFr2QZ2RNsjU/ytMa+7ljfr7Lb0g12PKYKXBoC6oeFywNsf9IV7g0UWjRgpL0=@vger.kernel.org, AJvYcCUjUkAtV04ds9u1seFLey4nQhj/9olkobltdAG9LXiaUz8gFZ/yM0myb7wp0+HNYrU9e4WmUNIAHW0b@vger.kernel.org, AJvYcCV2K+/LqU2YBTW2Cmyr4jB5SxyD84AQN9WVdgzWSy/VM8A/hh99B3yszjo+597XZ0S2oa+/c1WRtxoPzQ==@vger.kernel.org, AJvYcCW975XGPH+fnF6w/42YAOTqWHqwMrMgftYpScRTBC0kCVV+tIGLeZW/u0oIuCXoZm2SRrdmjA+X/v50KAEh@vger.kernel.org, AJvYcCWo0qjQcTEPEj9940ktGPa3/QwKqB0geXWtZMRpiCtDvD2DNYrpEzlGD3nnGtaHHzI6Qio+RgMGsmkYIdYdJC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYfkj16alXkRKBX3LZZqoX7YUNEcA2F3z6008EeKuub0TiJi7i
	EWho6aL/T7b3ydc1HBQJiTWpPtdUoNPRwT3+vkN2Dh4RHhxKX6XU
X-Google-Smtp-Source: AGHT+IFbDyCZVl6iP8XvNmmycr8jxaFszAHA+o3/EO9f1b67FPVQuzwl/gzw75MizW/8mo2h1TzMqQ==
X-Received: by 2002:a17:902:f548:b0:206:9ab3:2ebc with SMTP id d9443c01a7336-2076e3f32eemr160906225ad.47.1726387736158;
        Sun, 15 Sep 2024 01:08:56 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-207945db012sm18248865ad.19.2024.09.15.01.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 01:08:55 -0700 (PDT)
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
Subject: [PATCH v3 09/20] dt-bindings: arm: apple: Add A10 devices
Date: Sun, 15 Sep 2024 15:58:54 +0800
Message-ID: <20240915080733.3565-10-towinchenmi@gmail.com>
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
index 253dae759f10..b6a2916fb0f6 100644
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


