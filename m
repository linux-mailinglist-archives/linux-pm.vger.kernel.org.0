Return-Path: <linux-pm+bounces-14221-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B1F978DAC
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 07:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6427828B33E
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 05:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983C85A4D5;
	Sat, 14 Sep 2024 05:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPS31ki3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22471148317;
	Sat, 14 Sep 2024 05:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726291539; cv=none; b=k060PpxIBjpYjsl/BDVn3HlqI0uG5cIob/niS5Se5NbOOG49JMSFEgDYzMyewZkNlQQiWThPCm/K3yh5effWsrg7eiUO9N8nzQed9G/JKGDBTz4nDUNg6FhJT7a12KgG6MjGKJe5SOwcInDcppp2bQ8EEVMKuG2RmwYXMhn17zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726291539; c=relaxed/simple;
	bh=3+weNr3YHXXle+uvM36RE/m2aNy1s05BypLmiMF5zgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rOdwmxmbrFg8/2XRQeBiq/xrQfZOyAT9H1hcYy88W2vPDHZFalLQF4U50rWBYy/xEOGzvEhBvQCQwLjY+hLz23BzWSMVnKXb/9YbpBhcThu+vNaWYyEPObkjtog6LGFyLiV/WxbM+Ou/fKYaevBYVpdhJcfe5CPeC28ZH/uH2aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZPS31ki3; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-718e56d7469so1310972b3a.0;
        Fri, 13 Sep 2024 22:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726291537; x=1726896337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4+YQsSwFfB4huKc7g5jUWuJSmEqvrijMAe7lXahRno=;
        b=ZPS31ki3MEVjfSK2GCGWdELiTcQME2UNd8OX3Deiyb3ncub/88+2zHSS5rPnZkpR2P
         GVvX7JyIIXEbkAnSyS5ZND3rQmp1jmfzPVQfjkDR4wKLlW422VagHBuHH8MSa/BLWH6T
         m/KOsyuOQMQmCD7XpwhO9/WRVfPQlPI8FUsHKE7GGYDADSdamUcSroKQe9Ubf8uSpcxj
         3QRpc71Ba1zmVSbQRspk69ALd8GPoAMB7lnt41CG1UMyh3Yy6RBWxGojoXbHogoKEpV/
         PlN8JO+qLWS7A2yb6HbMRADLmiDqQrfmYxdACM4sfCPo25QfkBo1PkCfShGX8BiYu+P0
         HHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726291537; x=1726896337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A4+YQsSwFfB4huKc7g5jUWuJSmEqvrijMAe7lXahRno=;
        b=dYeK0DoyVstpQXBtRHntyuQWZZFpKc2pAzSbq/9nRIMnokIkoX0F8qjxvT+kiEJWrm
         aRPkurpHnZsyODr48/ifr3+41vsbsD9yEngv6W76EUiKQDTp+zeqMkkSosZ/Ko6OfpZc
         rZamO4uMx/ab84zwgojmjWxGyK+rwTdwBVckcam3ibS+zSDDhCUnj2JYqcqzDxTvDteW
         lLnUsnYmMfOOIxqWn1bwKEqS8YuvvCpjE9+tSxvB5758Q7yI0ho6XWUNNw8XCV5Hd6Ke
         jffP64f2lxoL5kbMToYLLI6hjrHAVp1RTQgK8llnsl1SUiQm5Fwy9BHhCvAnemjDw2jX
         FCLw==
X-Forwarded-Encrypted: i=1; AJvYcCUcFgArD141bFoxTJUfpjsxSIIMPJzGZ9HHBuSqIqCnhykJEsDzrx3OgA/HiOD5DVdAZm/RLE1ojNzbAQ==@vger.kernel.org, AJvYcCVKVRfNSHyeM7WpmIhgEb0Lu58TAipdNAjcmbUdW1KVJbd3AWkCzzCjkSu7qFVhiCg0gEnbvLqIFc+bck5i@vger.kernel.org, AJvYcCWKfDjSP++zKqeEwvO5ohrGW0bq41ieTK3OYoerAgn2dAPg6tjT/LFCxodZdb+40TvGnAASWAzeZXs=@vger.kernel.org, AJvYcCX6d2j3iSp3zXuNseyJwJKXEvuDM+xrPjebnj7b4JMvAm7UGdYv/8+xOq3rukA0VYrEAnZLEhTcUfi0adm6TUo=@vger.kernel.org, AJvYcCXdUZJPDOp/iT4rm8D3WkN7SkfMNHF45CTtViqnazLAsKWuNAPZRd8HV9gNi8pSBNxgCMdSjNhw6bPH@vger.kernel.org
X-Gm-Message-State: AOJu0YzNqU1YpJ9y12eSnK/HT1FUhZplC7GPUF+JOXCov6RJHP7RuZQ9
	xqR36RiwoXtvTwcgdMHZva22lCY+4L+IZTt52pvj60qKehlmm8zB
X-Google-Smtp-Source: AGHT+IGZb4Zp6+TBGYQNTbPKIKUjyE0uB69aRNQKjhc1x4drSXerk5mTA2UjozVOqqCR/y1Ijl5Abg==
X-Received: by 2002:a05:6a20:304a:b0:1d1:1795:4b43 with SMTP id adf61e73a8af0-1d117954cb8mr4443812637.26.1726291537352;
        Fri, 13 Sep 2024 22:25:37 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71944b7b749sm391223b3a.113.2024.09.13.22.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 22:25:37 -0700 (PDT)
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
Subject: [PATCH v2 05/22] dt-bindings: arm: apple: Add A7 devices
Date: Sat, 14 Sep 2024 13:17:14 +0800
Message-ID: <20240914052413.68177-9-towinchenmi@gmail.com>
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

This adds the following apple,s5l8960x platforms:

- iPhone 5s
- iPad Air (1)
- iPad Mini 2
- iPad Mini 3

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 .../devicetree/bindings/arm/apple.yaml        | 26 ++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/apple.yaml b/Documentation/devicetree/bindings/arm/apple.yaml
index 883fd67e3752..59f5be84aedf 100644
--- a/Documentation/devicetree/bindings/arm/apple.yaml
+++ b/Documentation/devicetree/bindings/arm/apple.yaml
@@ -12,7 +12,14 @@ maintainers:
 description: |
   ARM platforms using SoCs designed by Apple Inc., branded "Apple Silicon".
 
-  This currently includes devices based on the "M1" SoC:
+  This currently includes devices based on the "A7" SoC:
+
+  - iPhone 5s
+  - iPad Air (1)
+  - iPad mini 2
+  - iPad mini 3
+
+  Devices based on the "M1" SoC:
 
   - Mac mini (M1, 2020)
   - MacBook Pro (13-inch, M1, 2020)
@@ -65,6 +72,23 @@ properties:
     const: "/"
   compatible:
     oneOf:
+      - description: Apple A7 SoC based platforms
+        items:
+          - enum:
+              - apple,j71  # iPad Air (Wi-Fi)
+              - apple,j72  # iPad Air (Cellular)
+              - apple,j73  # iPad Air (Cellular, China)
+              - apple,j85  # iPad mini 2 (Wi-Fi)
+              - apple,j85m # iPad mini 3 (Wi-Fi)
+              - apple,j86  # iPad mini 2 (Cellular)
+              - apple,j86m # iPad mini 3 (Cellular)
+              - apple,j87  # Apple iPad mini 2 (Cellular, China)
+              - apple,j87m # Apple iPad mini 3 (Cellular, China)
+              - apple,n51  # iPhone 5s (GSM)
+              - apple,n53  # iPhone 5s (LTE)
+          - const: apple,s5l8960x
+          - const: apple,arm-platform
+
       - description: Apple M1 SoC based platforms
         items:
           - enum:
-- 
2.46.0


