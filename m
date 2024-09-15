Return-Path: <linux-pm+bounces-14300-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40928979572
	for <lists+linux-pm@lfdr.de>; Sun, 15 Sep 2024 10:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA9301F22654
	for <lists+linux-pm@lfdr.de>; Sun, 15 Sep 2024 08:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA6F13DBA0;
	Sun, 15 Sep 2024 08:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVGfL7AE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEAA13D600;
	Sun, 15 Sep 2024 08:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726387733; cv=none; b=D8J8fXDERv4ALEW6kLoKPB1aP7kiXlAiimcDBrwSM+imvLgV8QwCVbPuEumKQnFRYGFDGn6QoBZa2W3gupROBCEKGbxiL3MmNpbEoIuQXU1+MPz39ofEMzjfN4Og7JpuORAn53+/QkKfkDs4+OCNhDChc9dcAQvRvfcPkNkRdgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726387733; c=relaxed/simple;
	bh=3LdvS5KGovWfSeQULeKu1Eh61BWUO6KIHw9jqYb/UhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L/VMnI7JMDmmYNWIOcWCuGNBpBf6zszPZR2xjla5ugFEc6Nh7cmWBDCc2ZypW1xFbU+ADmbDBmqaUMjkIpmID2+LlYGoOxUAWhgrZwXzspaRV+lqd54vWRllvO9Fp95CI7sRaFppva2/lIwnUjlkt0fo4/gYlTF9NhsFJR03AM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVGfL7AE; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20570b42f24so36533765ad.1;
        Sun, 15 Sep 2024 01:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726387732; x=1726992532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NfQDIayDgRSXuWv63W1u5ddzHt/doIYQe5CKmJXlfPM=;
        b=YVGfL7AEZtEahqIabao2POhCqNuEIzupkaNiv7ECQLTdh9v91zHJ1e7SIPUE/ZOi+K
         vfcqYfwieoBmhdQ2ek5aXwT86RsgDfE9qiSluQU5mLVMe2mgHcK/DoHgcNePwvPH7V17
         uMQVOLPefyjZzZAHZymxD4IUhNjH4LYfkasKhto88QMlNcai5VDU6R1G8IZ6tCjlmB8O
         pEPQ9iV8N1fAxb2EqUfmXTQBKruFyKkg67tCPW493sjKzRbTs4LqQAnZ/eKJn3JfawuZ
         A9K/FAkL06RGz7PUv7FsXNLl8uJwSd1JUgH2BtTywgYE3UrhJzdEiYn9xHdjFMV76/TM
         muhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726387732; x=1726992532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NfQDIayDgRSXuWv63W1u5ddzHt/doIYQe5CKmJXlfPM=;
        b=TE6AlIjj/URKOQc0tUt6MvMJqW8HRYq5lLxsrPfavqQwbxO0foLjcUPAEcwE3KXF0U
         9SwDYylseWTiZQ1a8SWhDqbCfJxFKSqcGf8I0agTz48LVh3UwabgxPXOg2csSw9pV279
         5BoK6XtS9C/z/u2v2UJStKzfjF/U0r8IKAeknumTjFWavuUR/FuLmH0+YVxtEuZJp8iO
         92fIQ5UEBGXcpDDvc4yd3jw42yQxeqvFM2VfHLJpifhLc1U6VwhhiqVDM4dl1s/b0XgB
         22C7k9eil2Uz2hNtVf/m9VsRYHNXC0liV/v9i9dEENKl1u9YtkY7CdvPXfvICV+6Gb7v
         JROw==
X-Forwarded-Encrypted: i=1; AJvYcCV6E+vuQqwHyWndr5iP9bOqAsdSg1H2cVsqYlRI05Q9uGFimtmLaL31ZK5OLqecTSBtOBoMnkjg+B7yujQm@vger.kernel.org, AJvYcCVKx9nzfYDVfJZ/aNF2Hd7ZG0K+j8RK1kW39MjNZKoOaLK99LWk6OaQyIxVN6fBx2PnJm+oHXjjq5RL@vger.kernel.org, AJvYcCW69ob2hiPmj+lByMvVZUwl6RnUWXz23U2SZJ+4WMoiMQlRUulnevcykVVFq1Dow5FHxPW9xhMisL8GXg==@vger.kernel.org, AJvYcCXAVLhaFNIUSqdWU8k4MdAVi7qC0u7JOGJen0/nXvJNGiW8g4LO+TQUiRj5zkvk0eyUWtcDSwY2tjM=@vger.kernel.org, AJvYcCXXfoZ5ThvcaJ5OuNjM6l42gJto2bzypEgsqQAm1mddqD5vq5H1pGvSTa7Yc3cZ8EEJPz4WH21jnSep/12LIg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YynX9aNjA4Np999RH4bsaB4/tD9uluwNDpu6YMJ2u/LgMpYzQys
	DARd+ASoUPepShRu/fmHJXFZc/cm0MFjL2nv6FKITln6IUUDwLp0
X-Google-Smtp-Source: AGHT+IFOtN5uiGIayog+A9Flfpjuxk8iaRJ/48tqT+xmoUDhN7D1/BPYbrd6n5qAFH+0CEEMWl3LOQ==
X-Received: by 2002:a17:902:ea02:b0:205:6c15:7b6e with SMTP id d9443c01a7336-2076e45a90dmr151107885ad.60.1726387731764;
        Sun, 15 Sep 2024 01:08:51 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-207945db012sm18248865ad.19.2024.09.15.01.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 01:08:51 -0700 (PDT)
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
Subject: [PATCH v3 08/20] dt-bindings: arm: apple: Add A9X devices
Date: Sun, 15 Sep 2024 15:58:53 +0800
Message-ID: <20240915080733.3565-9-towinchenmi@gmail.com>
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

Adds the following apple,s8001 based platforms:

- iPad Pro (9.7 Inch)
- iPad Pro (12.9 Inch) (1st generation)

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 Documentation/devicetree/bindings/arm/apple.yaml | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/apple.yaml b/Documentation/devicetree/bindings/arm/apple.yaml
index 01965890b4ef..253dae759f10 100644
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


