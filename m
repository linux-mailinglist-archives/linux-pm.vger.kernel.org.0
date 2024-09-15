Return-Path: <linux-pm+bounces-14298-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE28979569
	for <lists+linux-pm@lfdr.de>; Sun, 15 Sep 2024 10:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD2ED1F21BA4
	for <lists+linux-pm@lfdr.de>; Sun, 15 Sep 2024 08:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184C413B5B3;
	Sun, 15 Sep 2024 08:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEMe69sk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C58013A3F4;
	Sun, 15 Sep 2024 08:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726387725; cv=none; b=tsgX1jhfqc+vb3mlcP9fFfKAOGksdN5VUXr137L5Sed9CBbVqEAKw3i9XeQufWkwMcnKpoPnWFvYpfD+1WNE6KgN2KBW29oqu1COaIGL6+IrPiuhFqOiuC+aBJmj+rz9zJi3Z6QdR+bshMWMArKMz42dOFNyRzn+UnDNqVH447I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726387725; c=relaxed/simple;
	bh=LX1yUMUMzroiivpLzHUeZsbW1eLhhAD8n6ENcpLvjXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nmidxAGxbMAUlnF0mzJhWdRUf5Kc4KO78vawE1qsb7WIyxEtATjAg3TdG8T2U2XHiZJUHoGSaVizrF+7pEyDtXKVq5ao0Egvfk9WrQfFsF3KnVQFu/F+wuGFVYPAF1zFvE8WtKsBaqXf6P6aP//l3Z4GV8OdqCQXOVE8Gjgkzic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEMe69sk; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2057c6c57b5so20782945ad.1;
        Sun, 15 Sep 2024 01:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726387723; x=1726992523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oTTMQHgBeG1zBvPSvQGqnSu3NR/w6NwoxxaOUs8e9IA=;
        b=MEMe69skiaCH4qhVC57vGnfYrAii7yDoFQutTZPE1IqDe8H0npC3XKO5DPudmUcOY5
         aKJf8PURWHaoa4JXNo3YdrFxCUPgOWuPRhYb3dmCEmBnPjnYAb1Uo/1HaRzGOe8+50b2
         LdsV1hBKThmiMwNWs4ZEQL2TLJcyeFoMGojsGI4j/PWeD4QnEiC+Qujx2UkLhBe7OVGS
         2tkg9QCsRfA+pFy+nA/Fy+FGHbdNZnzJ0bgySiXyJnAIAmbX2+4sCHRli2uwLIdWM6S1
         Klse6k39A32eAGQG89H5ZSQOanKdlmmezOqjt9S2Wu0UC8t44L2VgsaRqa3gzaypbbPL
         NSig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726387723; x=1726992523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oTTMQHgBeG1zBvPSvQGqnSu3NR/w6NwoxxaOUs8e9IA=;
        b=MSQ7t3H+9j+lPEkdAHzYuecMOotgg4m5wECWadG13ikSS4amqTrWsltTi0t01HKJTJ
         0Dy+GsCGXwpXFJIlt40W/Kvxw87tiVgGib6AJ0wAkjjcOkFKeDQDdKDchlaDNLmimuGz
         3/Ibz9dOcJItnC/WYOox6EG7VNG6cUvAN6vvyRDN+C/wYwSDYivIVvHoW8SC1L58bAfE
         pXBeso0stetxnkBCa8lm8JRLWL8nVFN5Uounmqh4JB7/5FMYIk4wkcYrwwQVtsquwy9S
         2mQD8SA+sER1NA+JpwqGZELP6H3E3DtsRRtrlkbjYy5gfhMGd4RYvqp12OldjnCwZr6E
         Qd3g==
X-Forwarded-Encrypted: i=1; AJvYcCUZ61riXeyGBQl/sfAM4nYa0Ka9EG27yDfQzQmxRkOeN4kIE5J/VGeqrfqHmN/ONyNbKs42YtzDI4HGxvKFgM4=@vger.kernel.org, AJvYcCV94HKRV0VmVyRzXBu390zeoQpVVAt+0lry1OlTzRqzRR8ReYlHRbDVcU5AgGhnAjQjJY/rBjFGO3c=@vger.kernel.org, AJvYcCW3AZ8KXP8e5+rPYn8Y/lZfk+V+vk1zNal0g1Cmqmg2j3/sfXO1NtY8kp7K+GHBxZl+93G7yTyEDOQojhn9@vger.kernel.org, AJvYcCX+5k1tDmmHG8TlteJSq36/PgzDm1/pwkxs3hqdRuhavpwn8fLz6I9MOJL8M/+aKl6TYIcld67tac0bVQ==@vger.kernel.org, AJvYcCXzzE6s2XaIbb+PF66/5zZ5qHeWofEOkxgZRzuvmKWD/weZzuZFIAo3mjUkI8KPuuSIbk0PWBNUpCVq@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/LfkwJbh4Be8ImGIlmxIbtNv9zM0vroNGB58zOOx4TgWkugK3
	2DsQNxheylgvSnWTfPhamD58vFXb3NpYwgtjPmU/tIy78CfubhPx
X-Google-Smtp-Source: AGHT+IEm6DFnxbNtUyFclJfhGbDR4WVSXdUPm+ukl9wfMKJXk1gIa2zQAZdfkRenc7+t6qHYmvPFoQ==
X-Received: by 2002:a17:902:e54b:b0:207:794c:ef24 with SMTP id d9443c01a7336-207794cf0c6mr153102655ad.4.1726387722967;
        Sun, 15 Sep 2024 01:08:42 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-207945db012sm18248865ad.19.2024.09.15.01.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 01:08:42 -0700 (PDT)
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
Subject: [PATCH v3 06/20] dt-bindings: arm: apple: Add A8X devices
Date: Sun, 15 Sep 2024 15:58:51 +0800
Message-ID: <20240915080733.3565-7-towinchenmi@gmail.com>
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

Add the only platform based on apple,t7001, the iPad Air 2.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 Documentation/devicetree/bindings/arm/apple.yaml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/apple.yaml b/Documentation/devicetree/bindings/arm/apple.yaml
index c05a4414c8b6..fecc4953df33 100644
--- a/Documentation/devicetree/bindings/arm/apple.yaml
+++ b/Documentation/devicetree/bindings/arm/apple.yaml
@@ -27,6 +27,10 @@ description: |
   - iPod touch 6
   - Apple TV HD
 
+  Device based on the "A8X" SoC:
+
+  - iPad Air 2
+
   Devices based on the "M1" SoC:
 
   - Mac mini (M1, 2020)
@@ -109,6 +113,14 @@ properties:
           - const: apple,t7000
           - const: apple,arm-platform
 
+      - description: Apple A8X SoC based platforms
+        items:
+          - enum:
+              - apple,j81 # iPad Air 2 (Wi-Fi)
+              - apple,j82 # iPad Air 2 (Cellular)
+          - const: apple,t7001
+          - const: apple,arm-platform
+
       - description: Apple M1 SoC based platforms
         items:
           - enum:
-- 
2.46.0


