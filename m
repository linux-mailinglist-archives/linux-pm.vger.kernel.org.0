Return-Path: <linux-pm+bounces-34631-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71374B57248
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 10:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2A0D17E076
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 08:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0D42EBBA1;
	Mon, 15 Sep 2025 08:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkhM5i9L"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B044D2EA73C
	for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 08:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757923349; cv=none; b=ki6I5iuu5Ktlh210RrRbkv/5caCaesLvI/9NmsWT+yuC5enLVFJjkyGS6AowUwb1x43+lajSLoAWHx+27YSOr7GgsVdprBXmqBkBWLjvBXMwvMAmIFwftkCHLNZG5kg8ym7gQ/HxY8vG0xPgJByJP+B0RQCePUcAItMUKrriWaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757923349; c=relaxed/simple;
	bh=2HS2x4Zwn3/d1ZJd+mHwB+t2npx1DDRup9HpkomrkfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mukry4BB0Fy3uYp4rR5ulCfCJf8Bg0HinSx7TR8W26zRGDPnfCzEoWCHKRDTEbBPVISJJDlyUqcZILtIEiQCObSWRMJwpjsc/bR+R00LiEVeUOkxCN9pO7f7f4fZFR3BScX0U8BjJexziXi2MRlLq8EpegryDWUtKjb7TVSQYNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EkhM5i9L; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55f72452a8eso4513028e87.3
        for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 01:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757923345; x=1758528145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcvS1l+DUe5XdhH4VUkP5ymD62cqO3nzvy0Q17N2d10=;
        b=EkhM5i9LV+fdycvVn6mwYHfiey2jyjmlIooaNyDJLG9Vfeh4zdlN2VlDbBiahI7aII
         0cONOl+65nphgOEwKQ4plT/zmY8+/Qww8nVjFGDzA3m4w4C5XTbytVO5gyWEq5AvGxXU
         0hHPuGrNY5DdOp9Ljjmip6kFv3KJbkNMWhfBXq/J2L2WiQv94glmev+S4CjNpf5b9n9W
         5QKGOPOTaYHR4c6R0iAHm2/wasKj9iAvUGgPU4qXAP5ju2ZxWnbY5NvBU2RrWOuM8jO7
         W5i3y1Avv+8brGYpXGSfYGHiBCM9aAvcy/aqyvl1ugC3SSRwb9qYOTaEy2yfKu8jMdOW
         UoAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757923345; x=1758528145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QcvS1l+DUe5XdhH4VUkP5ymD62cqO3nzvy0Q17N2d10=;
        b=Caiy8vCYCGHm+cTzGJDVoQLoLZFRNNH88VRUuJ2IRIWBJY1sUamOfrv/nECjq8MSow
         RH8B1V5UdUyaLqtb7Q41gywZckIjRw7GCSKjRpHi6jh0kOqaXtYnDO2cfzH69Ksh1c7s
         dWEoS3Q4pMeS3ClyG6o09imLyOzIjRQy+Kd5JcwoYjXTiOARrHbOi/h50Q6EqSV67fxy
         3ncz3+vgS6OSeD6yjvhjTjcAK4RT3GLTh+uDL3GYtXGU+1gr9ty87VKCuJHQ85Ehpe3J
         nd/eepiw23y7xcLLXvEzjNO8uDXHlTZ5bKzWCHPZRd3XnYgizSdUANDanEsXR3Q4+86k
         ANuw==
X-Forwarded-Encrypted: i=1; AJvYcCWav2OA7Bofx3SMuGanvmR9nuZjDFWw21CDnCoeehqte+AvO9zhIUa8jGNKdnZ/IP2qzIcAbIS6wQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjcHnlH2hdXezFn55CM5/SdKWcPRVAOqqxBSbmbWra2oFgywpi
	w3KbL1BT/b4/K2VADvA/XX54DTsBCRwUgvGLyoNSirLy/NJdpPjml9jW
X-Gm-Gg: ASbGncsz5IvPMEL1TwTvENqmEz6ZQ3uiczwzyd7g4ryzgWqe4cBgKnDE0powt+ugFll
	gcJ/sHC7SBPz7Y3CYbO7Dlj31bucvb4H/guc+ydPz/xxvDRFpyHsHegbH8XHI3n+T8DD7OOBREB
	7FpRpJHs8MtybB+HB/oP+1rdx5gOSxy++f2wDjTLEAmUV87l4309wggQsYbIHOVPLzXZQj2GNw6
	3pqYDMjzj5EqYiTrnHLdLoGGL/8KQfsOEWhofhzWkUdKm91snRiRTeGEL9sSU8zYcuGBtZntQlx
	X+ZzoaVLjBl6s7CYW3LEpGWq42BPAoJsAivF1xN22UbgwFGyvaOC3xQpjYhP3R8XcBPZ8uVVM6b
	1vyCaL7liSNiq66QZNLq0RXf8
X-Google-Smtp-Source: AGHT+IG3XB+VvXjojvfZWSOr8AupWtLXNT3yogCB7qwPpJNLsWVULqrW/kotBHJYn0rOd1mx07GyJg==
X-Received: by 2002:a05:6512:2513:b0:55f:6883:cd26 with SMTP id 2adb3069b0e04-5704d1f4373mr3419989e87.32.1757923345366;
        Mon, 15 Sep 2025 01:02:25 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e6460dec4sm3392381e87.103.2025.09.15.01.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 01:02:24 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <treding@nvidia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Dmitry Osipenko <digetx@gmail.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 03/11] dt-bindings: memory: Document Tegra114 Memory Controller
Date: Mon, 15 Sep 2025 11:01:49 +0300
Message-ID: <20250915080157.28195-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250915080157.28195-1-clamor95@gmail.com>
References: <20250915080157.28195-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Tegra114 support into existing Tegra124 MC schema with the most
notable difference in the amount of EMEM timings.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../nvidia,tegra124-mc.yaml                   | 97 ++++++++++++++-----
 1 file changed, 74 insertions(+), 23 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml
index 7b18b4d11e0a..9cc9360d3bd0 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml
@@ -19,7 +19,9 @@ description: |
 
 properties:
   compatible:
-    const: nvidia,tegra124-mc
+    enum:
+      - nvidia,tegra114-mc
+      - nvidia,tegra124-mc
 
   reg:
     maxItems: 1
@@ -64,29 +66,10 @@ patternProperties:
 
           nvidia,emem-configuration:
             $ref: /schemas/types.yaml#/definitions/uint32-array
-            description: |
+            description:
               Values to be written to the EMEM register block. See section
-              "15.6.1 MC Registers" in the TRM.
-            items:
-              - description: MC_EMEM_ARB_CFG
-              - description: MC_EMEM_ARB_OUTSTANDING_REQ
-              - description: MC_EMEM_ARB_TIMING_RCD
-              - description: MC_EMEM_ARB_TIMING_RP
-              - description: MC_EMEM_ARB_TIMING_RC
-              - description: MC_EMEM_ARB_TIMING_RAS
-              - description: MC_EMEM_ARB_TIMING_FAW
-              - description: MC_EMEM_ARB_TIMING_RRD
-              - description: MC_EMEM_ARB_TIMING_RAP2PRE
-              - description: MC_EMEM_ARB_TIMING_WAP2PRE
-              - description: MC_EMEM_ARB_TIMING_R2R
-              - description: MC_EMEM_ARB_TIMING_W2W
-              - description: MC_EMEM_ARB_TIMING_R2W
-              - description: MC_EMEM_ARB_TIMING_W2R
-              - description: MC_EMEM_ARB_DA_TURNS
-              - description: MC_EMEM_ARB_DA_COVERS
-              - description: MC_EMEM_ARB_MISC0
-              - description: MC_EMEM_ARB_MISC1
-              - description: MC_EMEM_ARB_RING1_THROTTLE
+              "20.11.1 MC Registers" in the Tegea114 TRM or
+              "15.6.1 MC Registers" in the Tegra124 TRM.
 
         required:
           - clock-frequency
@@ -109,6 +92,74 @@ required:
   - "#iommu-cells"
   - "#interconnect-cells"
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,tegra114-mc
+    then:
+      patternProperties:
+        "^emc-timings-[0-9]+$":
+          patternProperties:
+            "^timing-[0-9]+$":
+              properties:
+                nvidia,emem-configuration:
+                  items:
+                    - description: MC_EMEM_ARB_CFG
+                    - description: MC_EMEM_ARB_OUTSTANDING_REQ
+                    - description: MC_EMEM_ARB_TIMING_RCD
+                    - description: MC_EMEM_ARB_TIMING_RP
+                    - description: MC_EMEM_ARB_TIMING_RC
+                    - description: MC_EMEM_ARB_TIMING_RAS
+                    - description: MC_EMEM_ARB_TIMING_FAW
+                    - description: MC_EMEM_ARB_TIMING_RRD
+                    - description: MC_EMEM_ARB_TIMING_RAP2PRE
+                    - description: MC_EMEM_ARB_TIMING_WAP2PRE
+                    - description: MC_EMEM_ARB_TIMING_R2R
+                    - description: MC_EMEM_ARB_TIMING_W2W
+                    - description: MC_EMEM_ARB_TIMING_R2W
+                    - description: MC_EMEM_ARB_TIMING_W2R
+                    - description: MC_EMEM_ARB_DA_TURNS
+                    - description: MC_EMEM_ARB_DA_COVERS
+                    - description: MC_EMEM_ARB_MISC0
+                    - description: MC_EMEM_ARB_RING1_THROTTLE
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,tegra124-mc
+    then:
+      patternProperties:
+        "^emc-timings-[0-9]+$":
+          patternProperties:
+            "^timing-[0-9]+$":
+              properties:
+                nvidia,emem-configuration:
+                  items:
+                    - description: MC_EMEM_ARB_CFG
+                    - description: MC_EMEM_ARB_OUTSTANDING_REQ
+                    - description: MC_EMEM_ARB_TIMING_RCD
+                    - description: MC_EMEM_ARB_TIMING_RP
+                    - description: MC_EMEM_ARB_TIMING_RC
+                    - description: MC_EMEM_ARB_TIMING_RAS
+                    - description: MC_EMEM_ARB_TIMING_FAW
+                    - description: MC_EMEM_ARB_TIMING_RRD
+                    - description: MC_EMEM_ARB_TIMING_RAP2PRE
+                    - description: MC_EMEM_ARB_TIMING_WAP2PRE
+                    - description: MC_EMEM_ARB_TIMING_R2R
+                    - description: MC_EMEM_ARB_TIMING_W2W
+                    - description: MC_EMEM_ARB_TIMING_R2W
+                    - description: MC_EMEM_ARB_TIMING_W2R
+                    - description: MC_EMEM_ARB_DA_TURNS
+                    - description: MC_EMEM_ARB_DA_COVERS
+                    - description: MC_EMEM_ARB_MISC0
+                    - description: MC_EMEM_ARB_MISC1
+                    - description: MC_EMEM_ARB_RING1_THROTTLE
+
 additionalProperties: false
 
 examples:
-- 
2.48.1


