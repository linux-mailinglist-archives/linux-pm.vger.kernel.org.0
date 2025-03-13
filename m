Return-Path: <linux-pm+bounces-23971-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 424ECA5EF1C
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 10:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0C4D17D045
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 09:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AB9265CB7;
	Thu, 13 Mar 2025 09:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MFVQu7Lc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEAF2641DD
	for <linux-pm@vger.kernel.org>; Thu, 13 Mar 2025 09:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856919; cv=none; b=caqgY7W148RA0GLG4kvUE+WZsDWPnjb4R9Or0PFSsfc3FK4de6Iz9QjtD07Xsy19TTei3uEwGrrAYafrNhS/Gzx3agjRDt1fF/z0gHr0PO9/eyud7hRz4weFKyK/w+/54XePcAmMjNFByFlYmFE9xjzkHjl/UZGpV4J3GwNawJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856919; c=relaxed/simple;
	bh=lgWjTBUuPBm2rSyOlWilGxloVDsYf3mREg200N6emfY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D7kLxUhYpz1kSw12dhlVQOYNCKw8e1vCgiRJ5wSMuJKu/fZzTn09R+eDOWD1VTGbYZ1QbsU72GtKTMmNaHhj2wpDMmchwbCyQNQzIOb5YlvjFBQ/9q9q8VuvG9L7X34o4pX1SLTwPUn2LbjaywdOjG2xwRqQvB5CkAMdUC+gXgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MFVQu7Lc; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38c62ef85daso44187f8f.3
        for <linux-pm@vger.kernel.org>; Thu, 13 Mar 2025 02:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741856915; x=1742461715; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ILgSQHDxgkKe38HVj8nfhqursLYO9kMPnqoqfjxULgY=;
        b=MFVQu7Lc/1Cq6Kyn4cV0IWAgEp/YDo7YuJNR87HoOLGeCePPi3e8Iubyu/5lEBMYHv
         PJIHy8UX26ilYxE8A+abKAfVhVjSJnizmTeedxyYfjsaj6yY3h54EmGMP8xe8IzfGoZd
         oM5WrEeRWhpKJkanp9wwQlPk2Elyn6+xDej323xwryLUMgG5S5VO6ElTWrS/mZ/fOruX
         lYsIhPSXS0YTBJc9D6aSGSUPUZfmBspDa4iSmZGWXGz2J08CpimDTPmIwOBSsUPDSqIL
         EiOBhWnBiq2CyEbBDlwC3AS9LgyqLcxWbewPAfFCqp2YDB6LCJwfPvn2ZpG105f0wS5g
         ++1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741856915; x=1742461715;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ILgSQHDxgkKe38HVj8nfhqursLYO9kMPnqoqfjxULgY=;
        b=fta6XJqhx+f8VQ5zc/RrpWBQkQJu8SfSMIq9jPQQ0RtuKio9zUPjMZP1sigXrqqGbI
         YsYDAKGPwNMXOnxxjLZWi1LPrcDByrpg6qaMfD9Fs6IT4C+s16DM1Zf+yQc9Dzn66PYR
         X70N/jjrgl08pK3wr2nPGZ8pPg75rTb23WN5El/nsUfVdfJFbKWNu0wz04VGuxwRo0XW
         m+fE1so3p3zmCLOg0nGlY3gPlf9VXY+Bf7Vsq0zTdU+PhVSTu4pxpSiPsJkBkbTqkG1L
         yOW6wuaQakRtvcSLMjQWlApARQQ/BvUYNlCQ04puKLkzL7hO/wGIGbcrOKw3TVm1icto
         jh9A==
X-Gm-Message-State: AOJu0Yxda96B44CZE/HKy+2EFMxuuDkJsotCbLEuD57isluzdjA/3GZs
	Cftk9tz/p6oJ7L+LbeX7+Q9tr5wZCl6wCU3G/XxQVTbkbND0xz/hOOJ+xLXhZgXvDoRfGJtzTPx
	V
X-Gm-Gg: ASbGncuhUa51xdKwvR3liJk+ox3TNzBUQ8RrWqvEu/JbOFi32VJ+ermKnweDg3o/vlm
	WTkNXh4q9O/VPAk4otVnTKHSLqqMDTu5LUofnuMhPQBMZu+UHh7oPCfMW4Tt9mwkMdYQNQ33LTT
	91yf2IeDuAf25QXNczyDZOiYoixLUGhsFx6G6epM+m+iW92JTxKlY6TLwyijFmQcZnQLkfPVtcM
	JA45bpx0FMxCAgHPc2PZ1XOGpQZh2SdbAukQfXECrZoFhbYF9XY4IKEQU6VxHaCddrtIm4LJPoq
	OfajwkjKZj8CxKNjdRYvWVhX8knbhdQQJ/xzGjEd45tarM6+vhYshe3zxCQ=
X-Google-Smtp-Source: AGHT+IGKnblChG5aj7F20E/ZbGuy3EkBkhV5BYFgRAEyDthTZcDrxIAPMPB4DtyATCqkmzaKRhL1/g==
X-Received: by 2002:a05:6000:1564:b0:38f:2113:fb66 with SMTP id ffacd0b85a97d-3913bbb7c55mr6487289f8f.9.1741856914566;
        Thu, 13 Mar 2025 02:08:34 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb40cd78sm1414706f8f.78.2025.03.13.02.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 02:08:33 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 13 Mar 2025 10:08:22 +0100
Subject: [PATCH 3/3] dt-bindings: cpufreq: cpufreq-qcom-hw: Narrow
 properties on SDX75, SA8775p and SM8650
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-dt-bindings-cpufreq-qcom-epss-v1-3-62b0f96ba888@linaro.org>
References: <20250313-dt-bindings-cpufreq-qcom-epss-v1-0-62b0f96ba888@linaro.org>
In-Reply-To: <20250313-dt-bindings-cpufreq-qcom-epss-v1-0-62b0f96ba888@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1987;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=lgWjTBUuPBm2rSyOlWilGxloVDsYf3mREg200N6emfY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBn0qCLfEH5UJDAFMqaQ2DbkzgGdEbn37syewUAy
 l6r7fLHoOOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ9KgiwAKCRDBN2bmhouD
 12njD/0eY0bJXpbonUjf7E+cC3ki7olCu78ZoetuTKptbm682BMmu7YIaXDMFe9sQKZZl5hT8x6
 y/HrDw51U8QFxOtyIoqdbclTBld/jSuLfKGhftUSmmX40Gjd/t+CoAp6D/gR6xhD0IZrTR5LzpK
 GNiymRe4JfXtNr1zge85k8gfhT3WsbwAe6Wne37U38lpHYAN2HxBoif9qIeH8u59Mc9mgxek8Ts
 1SABCgcu66eSoDxEmhWXOLU72a6JpgeXMU2yNtGVDWYLPnZkUbCoASv0t3dI+IkJwBumHSDOmqw
 ijFiUMBisvPA6cCl2K22LzT2qIrEedwNI9jn8GRyUPGotkkco2HSg8fMv1gxuWm/Olx7Ib4MQML
 nfrs2wV0rpeOadULI4gwDuUtwcKk9IvlXjrWe57U0brsNlpZe0kLK4dtHMd5zbEJDVxjhIIz/rO
 oPdi52vX0vXfA1nj9+4SslywPSOM9mmC9V3QzPWmN9X5+y3v4ObsG4hAkP6ay1pC2tLyS5cyA0U
 CaVAlwy7uunKGmAlnjY56AKy2QHt5u5nfBhftiIMkghivBIcG/52o9p8ThggCpx+1KNom3d+PpR
 ODbmwwXm12nxzGO7VJeSOsBSCvkfsK34MHKzfmKx6h8SV9RRrTQXNb0kSxWgcVmb3sKOOGVr9Nw
 3nrUZdyP+gBt4yQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Add SDX75 and SA8775p compatibles to respective if:then: blocks to
narrow their properties and add a new section for SM8650 with four 'reg'
and 'interrupts' (top-level already allows four).

SA8755p DTS comes without interrupts, but only because they might not
be available for OS under given firmware.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/cpufreq/cpufreq-qcom-hw.yaml          | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
index 5c53ceb265b6f0f98509ef1f45aa246e95a20a22..e94baf77d785fa089f2448cf56bd29d52b7b3621 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
@@ -111,6 +111,7 @@ allOf:
             enum:
               - qcom,qcm2290-cpufreq-hw
               - qcom,sar2130p-cpufreq-epss
+              - qcom,sdx75-cpufreq-epss
     then:
       properties:
         reg:
@@ -132,6 +133,7 @@ allOf:
             enum:
               - qcom,qdu1000-cpufreq-epss
               - qcom,sa8255p-cpufreq-epss
+              - qcom,sa8775p-cpufreq-epss
               - qcom,sc7180-cpufreq-hw
               - qcom,sc8180x-cpufreq-hw
               - qcom,sc8280xp-cpufreq-epss
@@ -212,6 +214,29 @@ allOf:
           minItems: 2
           maxItems: 2
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm8650-cpufreq-epss
+    then:
+      properties:
+        reg:
+          minItems: 4
+          maxItems: 4
+
+        reg-names:
+          minItems: 4
+          maxItems: 4
+
+        interrupts:
+          minItems: 4
+          maxItems: 4
+
+        interrupt-names:
+          minItems: 4
+          maxItems: 4
 
 examples:
   - |

-- 
2.43.0


