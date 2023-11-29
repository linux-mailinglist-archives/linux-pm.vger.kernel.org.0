Return-Path: <linux-pm+bounces-497-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D40F37FD9F6
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 15:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 034131C20C4A
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 14:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E311A328D8;
	Wed, 29 Nov 2023 14:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="THdZcrwD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2674710C0
	for <linux-pm@vger.kernel.org>; Wed, 29 Nov 2023 06:44:16 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a00a9c6f1e9so975577066b.3
        for <linux-pm@vger.kernel.org>; Wed, 29 Nov 2023 06:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701269054; x=1701873854; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kY4CV7CKGUv1An9Req6wZsfE2xwWp6glJl1T37o8EEY=;
        b=THdZcrwD35pd9bHz9iWkgnzfxQdOUc/hjzV/b3FQRfHxedX6D+rCKQvAjncWv6aYKO
         wkRHPM0bbno/g8gTh/Z5AH7yV+pkvX9/nvFszkYLBu/IWbl2O90Yp7StmKS3Ejhd5eqJ
         LSzvdE9dX1GxlGX0VALd01vJPvSn53VGVD+zBO16YxABcjDWc+59UT3D8Q1j0TpsuV6r
         aRLHkU1GgDNHWhzx3hj0Mxx7bi/Z8JWiGzhC8MH4BjFWnddFpKEHHRpkIK+DbbPWkeeF
         1Z/+utdnZGEO8z+rKfAHApfA5CSHlVWCsI4+Lpdb5bjMYhBT5Dna1m/voal82CKvc0n0
         P3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701269054; x=1701873854;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kY4CV7CKGUv1An9Req6wZsfE2xwWp6glJl1T37o8EEY=;
        b=roy7WaP9T1jmFk/HtfeDSB65Q4sxoPgy+QbpJtR1RHXV2Q1QuP9ptGcF3dKlWjW9To
         a0UFLjHklrGEsBDYfaRqftUc6oqzzREpFLJ5WDiQlIG/4kqrxbP7XWGDH3S3Ta09p/8o
         1dVRt6+CVp+IM6aHrzuk9rb4dQWBfUy1uOYe2szNT/ikHBA/3Z7K4f+bGlnz8XJSmHfA
         PksnH3pMMp9nl8Ca98uyCCqJACKxHaz0hoPgxnW17fkt6e7N2ipAXOSEU2RI8owYALQq
         y+Sp1c1fDtDpv+72RQKgFdBwHyJBEASm3fUOMcD0FgfcywI5DdKuLvDDSw9ujWGcdkTN
         cTXQ==
X-Gm-Message-State: AOJu0YywXBos1kmcFMLpISDdTEaMQZvbXHFhpySvDU3rwwQ7hWB1DkQl
	Jf+FoEmAZYyXWRiDBoKBgR43xQ==
X-Google-Smtp-Source: AGHT+IF7CtdWKm3fVMPwy2RLHWJcbXp2iLGlzIimpu9ZMuURlS+1C4tsjaADWXIxRfBcWRkz7v4PBQ==
X-Received: by 2002:a17:906:209c:b0:a17:80d6:2d2c with SMTP id 28-20020a170906209c00b00a1780d62d2cmr1433424ejq.7.1701269054515;
        Wed, 29 Nov 2023 06:44:14 -0800 (PST)
Received: from [10.167.154.1] (178235187166.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.166])
        by smtp.gmail.com with ESMTPSA id e27-20020a1709062c1b00b009fda627abd9sm7913738ejh.79.2023.11.29.06.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 06:44:14 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 29 Nov 2023 15:43:59 +0100
Subject: [PATCH v3 02/12] dt-bindings: display: msm: Add reg bus and
 rotator interconnects
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231125-topic-rb1_feat-v3-2-4cbb567743bb@linaro.org>
References: <20231125-topic-rb1_feat-v3-0-4cbb567743bb@linaro.org>
In-Reply-To: <20231125-topic-rb1_feat-v3-0-4cbb567743bb@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Loic Poulain <loic.poulain@linaro.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Georgi Djakov <djakov@kernel.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 Robert Marko <robimarko@gmail.com>, Das Srinagesh <quic_gurus@quicinc.com>, 
 cros-qcom-dts-watchers@chromium.org
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701269042; l=10738;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=AHiYS8NEeTqp0o7Ra9EntWm/9fcrolhkvnRhcfWO7Hs=;
 b=UEeCIMBJat9wWZpjgiB1nrF2fjeekxOR7HtK4SCyU+971fCan0yhgVYwmYuwlpRVHpVfY7bLw
 eNx5mjzd/D+DlZTOACJQZYsOSKjBf5Iz0DWYXTHQrdHAHxiLPK0eqbd
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Apart from the already handled data bus (MAS_MDP_Pn<->DDR), there are
other connection paths:
- a path that connects rotator block to the DDR.
- a path that needs to be handled to ensure MDSS register access
  functions properly, namely the "reg bus", a.k.a the CPU-MDSS CFG
  interconnect.

Describe these paths to allow using them in device trees and in the
driver.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
[Konrad: rework for one vs two MDP paths, update examples]
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../devicetree/bindings/display/msm/mdss-common.yaml   | 18 ++++++++++++++----
 .../bindings/display/msm/qcom,qcm2290-mdss.yaml        | 14 ++++++++++----
 .../bindings/display/msm/qcom,sc7180-mdss.yaml         | 14 ++++++++++----
 .../bindings/display/msm/qcom,sc7280-mdss.yaml         | 14 ++++++++++----
 .../bindings/display/msm/qcom,sm6115-mdss.yaml         | 10 ++++++++++
 .../bindings/display/msm/qcom,sm6125-mdss.yaml         |  8 ++++++--
 .../bindings/display/msm/qcom,sm6350-mdss.yaml         |  8 ++++++--
 .../bindings/display/msm/qcom,sm6375-mdss.yaml         |  8 ++++++--
 .../bindings/display/msm/qcom,sm8450-mdss.yaml         | 13 ++++++++-----
 9 files changed, 80 insertions(+), 27 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/mdss-common.yaml b/Documentation/devicetree/bindings/display/msm/mdss-common.yaml
index f69196e4cc76..c6305a6e0334 100644
--- a/Documentation/devicetree/bindings/display/msm/mdss-common.yaml
+++ b/Documentation/devicetree/bindings/display/msm/mdss-common.yaml
@@ -61,17 +61,27 @@ properties:
 
   ranges: true
 
+  # This is not a perfect description, but it's impossible to discern and match
+  # the entries like we do with interconnect-names
   interconnects:
     minItems: 1
     items:
       - description: Interconnect path from mdp0 (or a single mdp) port to the data bus
       - description: Interconnect path from mdp1 port to the data bus
+      - description: Interconnect path from CPU to the reg bus
 
   interconnect-names:
-    minItems: 1
-    items:
-      - const: mdp0-mem
-      - const: mdp1-mem
+    oneOf:
+      - minItems: 1
+        items:
+          - const: mdp0-mem
+          - const: cpu-cfg
+
+      - minItems: 2
+        items:
+          - const: mdp0-mem
+          - const: mdp1-mem
+          - const: cpu-cfg
 
   resets:
     items:
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
index d71a8e09a798..f0cdb5422688 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
@@ -36,10 +36,14 @@ properties:
     maxItems: 2
 
   interconnects:
-    maxItems: 1
+    items:
+      - description: Interconnect path from mdp0 port to the data bus
+      - description: Interconnect path from CPU to the reg bus
 
   interconnect-names:
-    maxItems: 1
+    items:
+      - const: mdp0-mem
+      - const: cpu-cfg
 
 patternProperties:
   "^display-controller@[0-9a-f]+$":
@@ -98,8 +102,10 @@ examples:
         interrupt-controller;
         #interrupt-cells = <1>;
 
-        interconnects = <&mmrt_virt MASTER_MDP0 &bimc SLAVE_EBI1>;
-        interconnect-names = "mdp0-mem";
+        interconnects = <&mmrt_virt MASTER_MDP0 &bimc SLAVE_EBI1>,
+                        <&bimc MASTER_APPSS_PROC &config_noc SLAVE_DISPLAY_CFG>;
+        interconnect-names = "mdp0-mem",
+                             "cpu-cfg";
 
         iommus = <&apps_smmu 0x420 0x2>,
                  <&apps_smmu 0x421 0x0>;
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sc7180-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sc7180-mdss.yaml
index 3432a2407caa..7a0555b15ddf 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sc7180-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sc7180-mdss.yaml
@@ -36,10 +36,14 @@ properties:
     maxItems: 1
 
   interconnects:
-    maxItems: 1
+    items:
+      - description: Interconnect path from mdp0 port to the data bus
+      - description: Interconnect path from CPU to the reg bus
 
   interconnect-names:
-    maxItems: 1
+    items:
+      - const: mdp0-mem
+      - const: cpu-cfg
 
 patternProperties:
   "^display-controller@[0-9a-f]+$":
@@ -106,8 +110,10 @@ examples:
         interrupt-controller;
         #interrupt-cells = <1>;
 
-        interconnects = <&mmss_noc MASTER_MDP0 &mc_virt SLAVE_EBI1>;
-        interconnect-names = "mdp0-mem";
+        interconnects = <&mmss_noc MASTER_MDP0 &mc_virt SLAVE_EBI1>,
+                        <&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_DISPLAY_CFG>;
+        interconnect-names = "mdp0-mem",
+                             "cpu-cfg";
 
         iommus = <&apps_smmu 0x800 0x2>;
         ranges;
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sc7280-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sc7280-mdss.yaml
index bbb727831fca..2947f27e0585 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sc7280-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sc7280-mdss.yaml
@@ -36,10 +36,14 @@ properties:
     maxItems: 1
 
   interconnects:
-    maxItems: 1
+    items:
+      - description: Interconnect path from mdp0 port to the data bus
+      - description: Interconnect path from CPU to the reg bus
 
   interconnect-names:
-    maxItems: 1
+    items:
+      - const: mdp0-mem
+      - const: cpu-cfg
 
 patternProperties:
   "^display-controller@[0-9a-f]+$":
@@ -118,8 +122,10 @@ examples:
         interrupt-controller;
         #interrupt-cells = <1>;
 
-        interconnects = <&mmss_noc MASTER_MDP0 &mc_virt SLAVE_EBI1>;
-        interconnect-names = "mdp0-mem";
+        interconnects = <&mmss_noc MASTER_MDP0 &mc_virt SLAVE_EBI1>,
+                        <&gem_noc MASTER_APPSS_PROC &cnoc2 SLAVE_DISPLAY_CFG>;
+        interconnect-names = "mdp0-mem",
+                             "cpu-cfg";
 
         iommus = <&apps_smmu 0x900 0x402>;
         ranges;
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml
index dde5c2acead5..309de1953c88 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml
@@ -29,6 +29,16 @@ properties:
   iommus:
     maxItems: 2
 
+  interconnects:
+    items:
+      - description: Interconnect path from mdp0 port to the data bus
+      - description: Interconnect path from CPU to the reg bus
+
+  interconnect-names:
+    items:
+      - const: mdp0-mem
+      - const: cpu-cfg
+
 patternProperties:
   "^display-controller@[0-9a-f]+$":
     type: object
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6125-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6125-mdss.yaml
index 671c2c2aa896..3deb9dc81c9c 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm6125-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6125-mdss.yaml
@@ -35,10 +35,14 @@ properties:
     maxItems: 1
 
   interconnects:
-    maxItems: 2
+    items:
+      - description: Interconnect path from mdp0 port to the data bus
+      - description: Interconnect path from CPU to the reg bus
 
   interconnect-names:
-    maxItems: 2
+    items:
+      - const: mdp0-mem
+      - const: cpu-cfg
 
 patternProperties:
   "^display-controller@[0-9a-f]+$":
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6350-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6350-mdss.yaml
index e1dcb453762e..c9ba1fae8042 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm6350-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6350-mdss.yaml
@@ -35,10 +35,14 @@ properties:
     maxItems: 1
 
   interconnects:
-    maxItems: 2
+    items:
+      - description: Interconnect path from mdp0 port to the data bus
+      - description: Interconnect path from CPU to the reg bus
 
   interconnect-names:
-    maxItems: 2
+    items:
+      - const: mdp0-mem
+      - const: cpu-cfg
 
 patternProperties:
   "^display-controller@[0-9a-f]+$":
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.yaml
index b15c3950f09d..8e8a288d318c 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.yaml
@@ -35,10 +35,14 @@ properties:
     maxItems: 1
 
   interconnects:
-    maxItems: 2
+    items:
+      - description: Interconnect path from mdp0 port to the data bus
+      - description: Interconnect path from CPU to the reg bus
 
   interconnect-names:
-    maxItems: 2
+    items:
+      - const: mdp0-mem
+      - const: cpu-cfg
 
 patternProperties:
   "^display-controller@[0-9a-f]+$":
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.yaml
index 001b26e65301..747a2e9665f4 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.yaml
@@ -30,10 +30,10 @@ properties:
     maxItems: 1
 
   interconnects:
-    maxItems: 2
+    maxItems: 3
 
   interconnect-names:
-    maxItems: 2
+    maxItems: 3
 
 patternProperties:
   "^display-controller@[0-9a-f]+$":
@@ -91,9 +91,12 @@ examples:
         reg = <0x0ae00000 0x1000>;
         reg-names = "mdss";
 
-        interconnects = <&mmss_noc MASTER_MDP_DISP 0 &mc_virt SLAVE_EBI1_DISP 0>,
-                        <&mmss_noc MASTER_MDP_DISP 0 &mc_virt SLAVE_EBI1_DISP 0>;
-        interconnect-names = "mdp0-mem", "mdp1-mem";
+        interconnects = <&mmss_noc MASTER_MDP_DISP &mc_virt SLAVE_EBI1_DISP>,
+                        <&mmss_noc MASTER_MDP_DISP &mc_virt SLAVE_EBI1_DISP>,
+                        <&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_DISPLAY_CFG>;
+        interconnect-names = "mdp0-mem",
+                             "mdp1-mem",
+                             "cpu-cfg";
 
         resets = <&dispcc DISP_CC_MDSS_CORE_BCR>;
 

-- 
2.43.0


