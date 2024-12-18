Return-Path: <linux-pm+bounces-19437-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7DF9F6D45
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 19:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6B83188ABC2
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 18:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7718B1FBEB8;
	Wed, 18 Dec 2024 18:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxfPriN3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90921FBE89;
	Wed, 18 Dec 2024 18:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734546545; cv=none; b=GoJDArIQY2dCTif/GEq4TxmjtBZ1RBpTZE4Fs2ZZICfVtx0dsu8AX1eNKx8OIjV1mh1+ZJ13jyrCNeRIFrWhmVzGWfD4D3nMREGtxxQUWs68Wi4X1WIRVwf6zzBrPtTm4NHFNCF45Q7Jbii625J+dpnuWiiRD986QskNTCtua7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734546545; c=relaxed/simple;
	bh=4pn0Hu3mbLIrRljons9IY9VcSA1vxsFdATH588GI0yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f+aUCx2sTnKujJhs0tSBEpTTmFN/mdg1c6QQNYstF03ip0QnlUWPVzbJBxY1Y1V3c5CJi7uod9R/tMLCOjDVVhemUvrtYhAi4JjGNRk2Y+oL6AKVCwNTxa4DIG1lHeRwMoyBTAMqyg+y6aaK4PVzufbZdGG9/YwBVBGvIqSVTX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SxfPriN3; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7fc93152edcso7965a12.0;
        Wed, 18 Dec 2024 10:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734546543; x=1735151343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhYpasr65D04oywlSIN3QZu9V00P1KHiHgVqcAI4Gc0=;
        b=SxfPriN3HRsfHyCeWjxL9g506z/O9x0aMVNFW1rOxhuM5ADup48mdIuf9U4WZFX83R
         HLzgK+YJYh75IpCcoVNF/oDlraDO3AdYe1PoX7qkrwAJR3lqkyAV01sVWq93qnVhxGKj
         VzcDkVYb93r5ETV3ZpR2RDScxfYC9W+0QeX5sdf+MQGNxzzEmA3v5JMM3dQiwdpydrR5
         zHsCUG9ml6uaVEvhj3LkIHyTfqdW2S6fIGg9xAQlgf7DpYd9dnVpwAMDb5EMutKaWLZ9
         20xcKiMaz2Gbx6DDO6Jz1WwUIy5JLM9kE2Li6Jvjd07Ig8dlNF8AlVFG68JaNYTQ7imB
         FKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734546543; x=1735151343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JhYpasr65D04oywlSIN3QZu9V00P1KHiHgVqcAI4Gc0=;
        b=W28pw3dabfb4c++M8i5wuNSu06BVWasgb715MbeHNRVARLbg6H2yAmVd3FflKztupQ
         Xu1J57rRdsKzFMZmENkx+1FfWaL4tDM6B541YMjWBNber5u+94XP5zIg3dp4zo0mXU32
         x2AIVBFIUNlxxpdmiZiOsNGTkJC8B1GVtzxu7wtQQPtTAIjLwuHo8e+Zl/TIOfELI13m
         v+hS8hOF/j0wjVlBE6qWhFFY5ZDKtQvUuY3H2YXwr0CbAuBk7FH36A2NqybxTRm6Ljkf
         KjwTNyfVKoVMCR794XRhRpB3s13VWs4Srw5Vsto4q+biomQT/tvDx6bPZW+l5QMD7ABG
         lbGA==
X-Forwarded-Encrypted: i=1; AJvYcCUcptemfViwwOgJYdioqmdDB+hPKUVQr0ww0nFIh5NH545349u1Z+LtkFcGdWjr+VPtrqPfLZ5SY1Ad@vger.kernel.org, AJvYcCWrOtXZp8F5lUoqnm18XyPRnMTJ2R1yrNBP8O6deApon4Cskdkt+UaZ+07mPfjb+jRD7d2T6B72GOg=@vger.kernel.org, AJvYcCXbpvcKEyicYlb0LrxIR5Ijf2w+KkkJozvin20H85rlHmJCuuLC/eVvGq4HZdXPDbs++nRZgoGyI/h0eqe/@vger.kernel.org
X-Gm-Message-State: AOJu0YxxCIZYO7xvJDUy+VVk30j7T5YYqDspLiB7ftz7UZtGzAvcm3tw
	eqGxWv88aepyqjbcWLEajvwCWl0KeXLeC2tw+TJeY+qanncRxVRC
X-Gm-Gg: ASbGncsRZOXwd7BsSPkAkFRZ2MAkSjTz/kbKPfkbEylptzRlFqm6xc/ihy8690kjTgi
	b7weX9D68C1YeESj8dUbizm60acrMxc7Wh9WrAjsxwXXNM6ZXQgIMZ2DYxJqt0ARTQCxbfLEyhY
	gqKJc/CF007ahQnXFMS0WlsqULgSNB+PK4U0nQupvs445QxFCodkf1AVB4oel5/AhGVKGktMcnH
	QHwDkTSdAYX5gwyiAaEYH0jOZVPWDt94WfhKhXO556dEG5MYTzCWUIS/Q==
X-Google-Smtp-Source: AGHT+IHxbY/o3QfZaUi3hlJYtIOkRSgPETDeI9GVA24+K7rvStkNiiEjw923gS1zVQfPSU4+ivzQUA==
X-Received: by 2002:a17:90a:f945:b0:2ef:949c:6f6b with SMTP id 98e67ed59e1d1-2f4437bf688mr461691a91.13.1734546543178;
        Wed, 18 Dec 2024 10:29:03 -0800 (PST)
Received: from nick-mbp.. ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-218a1dcb3ffsm79202565ad.75.2024.12.18.10.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 10:29:02 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Asahi Linux <asahi@lists.linux.dev>,
	Linux ARM Kernel Architecture <linux-arm-kernel@lists.infradead.org>,
	Linux power management <linux-pm@vger.kernel.org>,
	Devicetree <devicetree@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Cc: Nick Chan <towinchenmi@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/7] dt-bindings: cpufreq: apple,cluster-cpufreq: Add A7-A11, T2 compatibles
Date: Thu, 19 Dec 2024 02:25:03 +0800
Message-ID: <20241218182834.22334-2-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218182834.22334-1-towinchenmi@gmail.com>
References: <20241218182834.22334-1-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatibles for Apple A7-A11, T2 SoCs.

Apple A7, A8, A8X gets the per-SoC compatible and the A7
"apple,s5l8960x-cluster-cpufreq" compatible.

Apple A9, A9X, A10, A10X, T2, A11 gets the per-SoC compatible, M1
"apple,t8103-cluster-cpufreq" compatible, then the
"apple,cluster-cpufreq" fallback compatible.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 .../bindings/cpufreq/apple,cluster-cpufreq.yaml        | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml b/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml
index 76cb9726660e..896276b8c6bb 100644
--- a/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml
@@ -24,9 +24,17 @@ properties:
               - apple,t8112-cluster-cpufreq
           - const: apple,cluster-cpufreq
       - items:
-          - const: apple,t6000-cluster-cpufreq
+          - enum:
+              - apple,s8000-cluster-cpufreq
+              - apple,t8010-cluster-cpufreq
+              - apple,t8015-cluster-cpufreq
+              - apple,t6000-cluster-cpufreq
           - const: apple,t8103-cluster-cpufreq
           - const: apple,cluster-cpufreq
+      - items:
+          - const: apple,t7000-cluster-cpufreq
+          - const: apple,s5l8960x-cluster-cpufreq
+      - const: apple,s5l8960x-cluster-cpufreq
 
   reg:
     maxItems: 1
-- 
2.47.1


