Return-Path: <linux-pm+bounces-24451-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C54A6DA7D
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 13:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F29201704A1
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 12:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FA6261582;
	Mon, 24 Mar 2025 12:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gm2f9qjb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171E025F7A3
	for <linux-pm@vger.kernel.org>; Mon, 24 Mar 2025 12:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742820790; cv=none; b=NgXgLjlVhKtZVv7pw5oSTO1qiQ9ugxzg50P4qHv2jo0zYQ5rRMGotROaf/Wj+JZPQ6sDdo5X2E/o8+xiAV2ebx5e+q7KW1exmKtn/rBtiOSj8aEQ3qP4lJ2kfWypLU8j+e2vqE50M6IQ9ex+F52h8FPQrrQ3B7QDr3OQrv2V0E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742820790; c=relaxed/simple;
	bh=rbqS5rDyjhAr0cFlh6cZN2ee3PXweGA4qM7ad4MATTg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TkW+XzeHKutVk9WNBQobL3CRIs+oMK+tjyUn0JKjoBuf5bnGtpSRW6snTesLTGYGxU2vLI7q4Un2d0MDaRW7+bufvb14ruxm2LlznLcaWvxcRcJWk6yEoydr0MKChWEX3uDt5Zw1yfVPQzAHEjDo/gVp0JP9LYwX6+RYiFSOMyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Gm2f9qjb; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43d0953d3e1so3899035e9.2
        for <linux-pm@vger.kernel.org>; Mon, 24 Mar 2025 05:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742820786; x=1743425586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SwCok12sX9NbWRz4qhUA5h3zsbyOHF7oWQm31idZcPE=;
        b=Gm2f9qjbBAWXjnRit39m+tfugcpjSRtlx/xEmZx0Szdg7ZHPRRcKf6VwSG+rUSrZOh
         G2me8x3iiRvwvR/UEO8XDxIPjMgapgHb9pdxVB6KUyoxRqcepuCv44Hul7McUfbrM1WF
         TOcSuDla9N6rnHzajtH9l/1k8FiEmsmIxp9DYmbcNCm+56fNCdOckoU5oVrU0WToJ1k4
         xMZwwo9tHzQtVirLj+Td3tyXs3z9gKBd4ol3j1zshFgyw9HGVn9kayGK8XYJ0TkHFDx9
         hJ10sJGD86QJCG9XQ5eYyJW8ALlkR1et4AFLQn1sJbjQ9UkvrqsTTdU0ZJzymT1NzGhI
         /TUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742820786; x=1743425586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SwCok12sX9NbWRz4qhUA5h3zsbyOHF7oWQm31idZcPE=;
        b=mRHmM66Oct81D5PNQeOL81G1j54r1/3xQLjIHx0UQOFgAq5WzLKuGZOsi23LKVg8kP
         FhcjoGvUCL6jPgtVw57vDxnqty4Xv9Ye6dTUpLCbSjXMAZDioPOvEiLl3CizzWoveO+Q
         iVoPlMLdB1AhbCEmAPjdGp+8Kh4qE/gkmtPPl1sjec8CxSJdmtkJoIP3ifaLqHy75XKR
         fDrJhoQx8vqkgEWeFnh9fWfOAntkBeDZH9pcoNbhXYt9+WJ6UBZ4QKIhgm6sLF6tWkAm
         +xECn0iUPB7ahFlm48FYqcvCP4apUvopisAykyPBTv1BLsQv/mMDQeTyheuMxJ7M4Ju5
         lRTg==
X-Forwarded-Encrypted: i=1; AJvYcCU0e37zwXqARqGBjNGwHBSmtqi8Gor/PRynlphylRTGvkDvFiN7yM5sVkWrhdJSYnfMVyaqaRfckw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz386afifhLqfWv9wlBHnzsdYFf9l1Xriaf6FoOpMj3wapIxvQE
	g8l1xWUDQCf9Ld+ZnX8J9boPjjEor8iEkFNBgBNhg/tIDFouGXM0PCRBDLo8www=
X-Gm-Gg: ASbGncuVw/n0g6gHpeCT1o2V5pJxKf4AwAK8FWmry70B4Um0qaNmegdom5Kd2gDdvyq
	qUalgbytTbQjV9DozzYyMzHnHs8Ysd5ochMdcu8McmFXaFHWvf8wTiforIGN4zWABTHciiFtGBs
	1/6eLmPhP6EdTYOOD9fhkpXFtMDbSJtHTd9N6CnOk8WgI4ciLEfNekJpOIFB5gFeFBs3jJark4r
	TNblHxS27rA5oaAaEs5p+6vyGNe160XrF8SxwTTCZUhpwt9hvhbxajULY+lturV9cp3n0/AmnfX
	R6V1vAyzUy8Qp1Woobo/Q8a5SiR+GSvx+DluVcBDnC9+NdkzyxGNiBYzrWYgThUe/wTx
X-Google-Smtp-Source: AGHT+IEZtcOQ6XXGYyC8h5oFZTZe66HCgwwQp/S+UZCCHfUIYSyU4Nysg4iUWn4IaFpqshLaOPlPSw==
X-Received: by 2002:a05:600c:1d1c:b0:439:88bb:d00b with SMTP id 5b1f17b1804b1-43d50a3d1c6mr35133295e9.5.1742820786323;
        Mon, 24 Mar 2025 05:53:06 -0700 (PDT)
Received: from krzk-bin.. ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9efdedsm11003553f8f.96.2025.03.24.05.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 05:53:05 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Georgi Djakov <djakov@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Barnabas Czeman <barnabas.czeman@mainlining.org>,
	Brian Masney <masneyb@onstation.org>,
	Odelu Kukatla <quic_okukatla@quicinc.com>,
	Rohit Agarwal <quic_rohiagar@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: interconnect: Correct indentation and style in DTS example
Date: Mon, 24 Mar 2025 13:53:02 +0100
Message-ID: <20250324125302.82167-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DTS example in the bindings should be indented with 2- or 4-spaces and
aligned with opening '- |', so correct any differences like 3-spaces or
mixtures 2- and 4-spaces in one binding.  While re-indenting, drop
unused labels.

No functional changes here, but saves some comments during reviews of
new patches built on existing code.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/interconnect/qcom,msm8939.yaml   |  8 +++---
 .../bindings/interconnect/qcom,msm8953.yaml   | 20 ++++++-------
 .../bindings/interconnect/qcom,msm8974.yaml   | 18 ++++++------
 .../bindings/interconnect/qcom,rpm.yaml       | 12 ++++----
 .../bindings/interconnect/qcom,rpmh.yaml      | 28 +++++++++----------
 .../interconnect/qcom,sdx75-rpmh.yaml         | 16 +++++------
 6 files changed, 51 insertions(+), 51 deletions(-)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8939.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8939.yaml
index 4b08be72bbd7..534644cccdcb 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,msm8939.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8939.yaml
@@ -70,8 +70,8 @@ examples:
         reg = <0x00580000 0x14000>;
         #interconnect-cells = <1>;
 
-          snoc_mm: interconnect-snoc {
-              compatible = "qcom,msm8939-snoc-mm";
-              #interconnect-cells = <1>;
-          };
+        snoc_mm: interconnect-snoc {
+            compatible = "qcom,msm8939-snoc-mm";
+            #interconnect-cells = <1>;
+        };
     };
diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8953.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8953.yaml
index 343ff62d7b65..56cdb77b369a 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,msm8953.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8953.yaml
@@ -84,17 +84,17 @@ additionalProperties: false
 
 examples:
   - |
-      #include <dt-bindings/clock/qcom,gcc-msm8953.h>
+    #include <dt-bindings/clock/qcom,gcc-msm8953.h>
 
-      snoc: interconnect@580000 {
-          compatible = "qcom,msm8953-snoc";
-          reg = <0x580000 0x16080>;
+    interconnect@580000 {
+        compatible = "qcom,msm8953-snoc";
+        reg = <0x580000 0x16080>;
 
-          #interconnect-cells = <2>;
+        #interconnect-cells = <2>;
 
-          snoc_mm: interconnect-snoc {
-              compatible = "qcom,msm8953-snoc-mm";
+        interconnect-snoc {
+            compatible = "qcom,msm8953-snoc-mm";
 
-              #interconnect-cells = <2>;
-          };
-      };
+            #interconnect-cells = <2>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8974.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8974.yaml
index 8004c4baf397..95ce25ce1f7d 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,msm8974.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8974.yaml
@@ -50,13 +50,13 @@ additionalProperties: false
 
 examples:
   - |
-      #include <dt-bindings/clock/qcom,rpmcc.h>
+    #include <dt-bindings/clock/qcom,rpmcc.h>
 
-      bimc: interconnect@fc380000 {
-              reg = <0xfc380000 0x6a000>;
-              compatible = "qcom,msm8974-bimc";
-              #interconnect-cells = <1>;
-              clock-names = "bus", "bus_a";
-              clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
-                       <&rpmcc RPM_SMD_BIMC_A_CLK>;
-      };
+    interconnect@fc380000 {
+        reg = <0xfc380000 0x6a000>;
+        compatible = "qcom,msm8974-bimc";
+        #interconnect-cells = <1>;
+        clock-names = "bus", "bus_a";
+        clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
+                 <&rpmcc RPM_SMD_BIMC_A_CLK>;
+    };
diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
index 5aaa92a7cef7..01d436d4a553 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
@@ -41,10 +41,10 @@ unevaluatedProperties: false
 
 examples:
   - |
-      #include <dt-bindings/clock/qcom,rpmcc.h>
+    #include <dt-bindings/clock/qcom,rpmcc.h>
 
-      bimc: interconnect@400000 {
-          compatible = "qcom,msm8916-bimc";
-          reg = <0x00400000 0x62000>;
-          #interconnect-cells = <1>;
-      };
+    interconnect@400000 {
+        compatible = "qcom,msm8916-bimc";
+        reg = <0x00400000 0x62000>;
+        #interconnect-cells = <1>;
+    };
diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
index 1b9164dc162f..dad3ad2fd93b 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
@@ -127,19 +127,19 @@ unevaluatedProperties: false
 
 examples:
   - |
-      #include <dt-bindings/interconnect/qcom,sdm845.h>
+    #include <dt-bindings/interconnect/qcom,sdm845.h>
 
-      mem_noc: interconnect@1380000 {
-             compatible = "qcom,sdm845-mem-noc";
-             reg = <0x01380000 0x27200>;
-             #interconnect-cells = <1>;
-             qcom,bcm-voters = <&apps_bcm_voter>;
-      };
+    interconnect@1380000 {
+        compatible = "qcom,sdm845-mem-noc";
+        reg = <0x01380000 0x27200>;
+        #interconnect-cells = <1>;
+        qcom,bcm-voters = <&apps_bcm_voter>;
+    };
 
-      mmss_noc: interconnect@1740000 {
-             compatible = "qcom,sdm845-mmss-noc";
-             reg = <0x01740000 0x1c1000>;
-             #interconnect-cells = <1>;
-             qcom,bcm-voter-names = "apps", "disp";
-             qcom,bcm-voters = <&apps_bcm_voter>, <&disp_bcm_voter>;
-      };
+    interconnect@1740000 {
+        compatible = "qcom,sdm845-mmss-noc";
+        reg = <0x01740000 0x1c1000>;
+        #interconnect-cells = <1>;
+        qcom,bcm-voter-names = "apps", "disp";
+        qcom,bcm-voters = <&apps_bcm_voter>, <&disp_bcm_voter>;
+    };
diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sdx75-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sdx75-rpmh.yaml
index 71cf7e252bfc..4b5e9f9b07ec 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,sdx75-rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sdx75-rpmh.yaml
@@ -78,15 +78,15 @@ examples:
     #include <dt-bindings/clock/qcom,rpmh.h>
 
     clk_virt: interconnect-0 {
-            compatible = "qcom,sdx75-clk-virt";
-            #interconnect-cells = <2>;
-            qcom,bcm-voters = <&apps_bcm_voter>;
-            clocks = <&rpmhcc RPMH_QPIC_CLK>;
+        compatible = "qcom,sdx75-clk-virt";
+        #interconnect-cells = <2>;
+        qcom,bcm-voters = <&apps_bcm_voter>;
+        clocks = <&rpmhcc RPMH_QPIC_CLK>;
     };
 
     system_noc: interconnect@1640000 {
-            compatible = "qcom,sdx75-system-noc";
-            reg = <0x1640000 0x4b400>;
-            #interconnect-cells = <2>;
-            qcom,bcm-voters = <&apps_bcm_voter>;
+        compatible = "qcom,sdx75-system-noc";
+        reg = <0x1640000 0x4b400>;
+        #interconnect-cells = <2>;
+        qcom,bcm-voters = <&apps_bcm_voter>;
     };
-- 
2.43.0


