Return-Path: <linux-pm+bounces-13991-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D97974D2A
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 10:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 030531F27825
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 08:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A500185B6B;
	Wed, 11 Sep 2024 08:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bphm2Him"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D8F176AC8;
	Wed, 11 Sep 2024 08:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726044448; cv=none; b=f9RXrBKnBlJT7cMCVhIkH36YSxQ21UdI0Y2fqAHeeF57wKGsjZB7Vq5dYuXZxWh8hiYspwYwyMKHfLWJ3H+1EC+V20QA41yO9RBXBYJWrdAogonNcsDZVGUPX9Mp/2uticsMSVv3WpnAKANzuO4+sfEiF+vQNlsyTXvIfi0sZgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726044448; c=relaxed/simple;
	bh=P9Pk9/2emirw+58JE8VBpSpv2YhF1/SPfHlNxzzMWCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a16R88tF1MAbIu28UVo4/EtE0/0F9C7pK73u7xEvcN8ByaQfiA3gZzoFHfOY2mOi4RMkJ3TEUfmIdzr2v96wiSmfKrKe5rReZawN8gfU+Wc7uQ6076c2ggJtoLaNcQdiHdXilgDDIcG4Imy+6ecxBzs1tGK8T4WDY+VD7Gd3Zic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bphm2Him; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-718d985b6bbso4678436b3a.2;
        Wed, 11 Sep 2024 01:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726044445; x=1726649245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjvlfmxw0wmD05gyjgPqQBjumudhjLKhpNjbMgXc0gg=;
        b=Bphm2HimP8nDY7p2fJaGDxEgAsE1rShy46lWFroB3JkL0h9HAytu0ixitNQm2H0sUF
         Hn4JGfYPd8t5BKbviaV/cNiju+rV3U07J+yXZqzTUtyKydhGfzXs/vxtwL3LxSUsKYpX
         pPE98dC98W/JQlM4WL5WiUzttslWVxl9OGi9/wetJd5mUVJbW+if+ktxRqdRIVKmgBmE
         3suEguQbs8ZisiNk/lIbmXCcWjmmOKdyGxpdUFtMvmF6K7DMiWWkQum3HrIKQeTHH9Fx
         6Yfs24IiNcXSqqroeN0Zv1JIzVfxOsFRtIfgCZ7cT4o/IHNuWqC7xCtZfbn+k29EreY0
         pzHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726044445; x=1726649245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tjvlfmxw0wmD05gyjgPqQBjumudhjLKhpNjbMgXc0gg=;
        b=Pt3BuoGB702IDAYFXJy84hiJ35fW6xiRwBhdyXAc4l0Vf3zGvsRPtT9/Mb37fCpvCR
         3AJ8Vu6xYR2+F0uvaLdlRYZTHqgkU4OsKuX1AOqR4snz/oo7jLwtJFaRmnLGEx0Uuwd8
         YYjUctizWvHF57tuYaB9E8cZ0yq1JmDGbrRH0N281sNIzU42ebtnc5fAeu5H5+djERnK
         xT0nhsEaFMWqSCPG2CpzW+r9IsLPxj1nJ7j1k6YxNPajyiFJty8c7XuoIxX7Z496feGe
         3VLxqRg3CDIoAcce8RxOeplYsYGxtESvJ93UXcz75AAE3oliy7dz+iBCQrRwWZk015bQ
         7fZA==
X-Forwarded-Encrypted: i=1; AJvYcCUYri/UU4W3UIqxgo4Zu6oj+S/HxODxz1fWn5/B8US2F7/RTEINMwvB99cH2yR9l5pcdp9wusnvd13HX1iKLtE=@vger.kernel.org, AJvYcCVnDc8IYb13Sv35ISF8dswjsXfmE/EHvEbmYdBVVu94ZrctEdhB+dcOY7m6/LIMifjHTYIX3I8oqtQ=@vger.kernel.org, AJvYcCVssaObtfuHrJDMiMhHQ5U27WoUzHhp6ZbG0kAx0r4aI8r12wYCW4aD7arizBoBhc0NWa6prATjTM8EuA==@vger.kernel.org, AJvYcCX58PiYmNAwd4Yn5k2GpWSDA1FfjHaseAOhshGyV8AEj7lFHbYWGcifRS4pfCANEn9LOqIHJUaMZbmQxhLU@vger.kernel.org, AJvYcCXPxlUKw0Xb4clZxpvj3CTk8FUxRaPegQOvaWvoYsh3Wtf1Z7H/cvsteQKVyJVuiNRsR7hQUclQBhOV@vger.kernel.org
X-Gm-Message-State: AOJu0YwdcuqxAtgd7rIDEhJFyGzhpXIMAk/4fK0AWyEAUyfPKQoYyrDL
	Zt2nsL10D1A5qf/SinW2e1S9wfIe8y1RS39w7TgyLhdUqiU7czhe
X-Google-Smtp-Source: AGHT+IGmsJr6r+oK8+NWZ2Lm9pjTz6VxGYA2MokykqymrLP97fXtIw63Lcg8YccJp/K+uK85FctN/w==
X-Received: by 2002:a05:6a20:b40a:b0:1cf:53ea:7fb6 with SMTP id adf61e73a8af0-1cf5e09835bmr4841877637.8.1726044445299;
        Wed, 11 Sep 2024 01:47:25 -0700 (PDT)
Received: from nick-mbp.ust.hk (wf121-022.ust.hk. [175.159.121.22])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71909095177sm2530125b3a.112.2024.09.11.01.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 01:47:24 -0700 (PDT)
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
Subject: [PATCH 07/22] dt-bindings: arm: apple: Add A8X devices
Date: Wed, 11 Sep 2024 16:40:57 +0800
Message-ID: <20240911084353.28888-9-towinchenmi@gmail.com>
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

Add the only platform based on apple,t7001, the iPad Air 2.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 Documentation/devicetree/bindings/arm/apple.yaml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/apple.yaml b/Documentation/devicetree/bindings/arm/apple.yaml
index cf4f5d6db1d3..dd5f0f6eb52b 100644
--- a/Documentation/devicetree/bindings/arm/apple.yaml
+++ b/Documentation/devicetree/bindings/arm/apple.yaml
@@ -27,6 +27,10 @@ description: |
   - iPod Touch 6
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


