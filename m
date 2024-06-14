Return-Path: <linux-pm+bounces-9172-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FC09088A9
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 11:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F9621C21023
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 09:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536911A2FA6;
	Fri, 14 Jun 2024 09:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n8RO82co"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E2F1A2544
	for <linux-pm@vger.kernel.org>; Fri, 14 Jun 2024 09:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718358448; cv=none; b=iBlqUCucESk0HNfQ1l6K37QiF7YJuRPAPQekXaE6SqHuEVl9++Jircq01Em/8oUF+KaekphX0nbCSQUWe0FwJiKVc6K9GqYt9Vt0E9Np3jwIPEGY/w3BfrjCs5FA3PsoAHui6dwYazEdqnY4cN5nI5YpuTruUsqZVm6RhRzQ/34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718358448; c=relaxed/simple;
	bh=PTWaCGHhxDG3JPho0JTkQVwDMdXBskC1S/cinQsqs34=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q0cFgl6YDMl/OVISHO4OFXo8ZoXTdiF0/1X+E19YiI+n2q20qDAscaVjKBSQTZzBcPn1LeCkyNru4pEjGCONh6bD5Xxn/1sIAcUih3wfmKUL9BlNPkxbpeWdwepDOkqeFhA+vgSgcXgeTZYmCw3PJAdLfKFd6KCUTeFKHxbj+Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n8RO82co; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6265d48ec3so279265166b.0
        for <linux-pm@vger.kernel.org>; Fri, 14 Jun 2024 02:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718358443; x=1718963243; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R2gPriGbKHdVX74nqBWMkbblvztnZeI8q7lI51XJyjE=;
        b=n8RO82coUuSwayFApPgbCsc4AxTRvRPM2KrNVoqsg2+5oWaGsXBOs6kIVAhuWqwr4l
         zK9eD7w3RrIo4qBggVkwSRz9OBoYTQpjEazeKHiYwciezqMWD80n/w1Kn7lU0wF/DOhH
         hRR2t/0qDoMVb2S/8rhCsBhpUo2AU+vP2N7Pdp0BplGXqEHkE+1ZILau2emeFAfNN0d/
         iwXKplDF1xRNHANBSLm4uIBMnXdUfB/XQLaBIX3qXMH7xPxGyYigDihxdNnUyIZRRclq
         IxFUOIJJnlSv4O2UdhNieCQ2GSzstFVzgMWEsNXhIJO6Ha6BCXIdellPxXCVcOWOr46M
         CsSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718358443; x=1718963243;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R2gPriGbKHdVX74nqBWMkbblvztnZeI8q7lI51XJyjE=;
        b=U8mCmkHv+C/DE0J46/UG6jz4wYRopwKMmOsT3fELmjWeG0PWOl6OP9VD8ljim+Z6X+
         jMLoaAYEYwUd/+QxXv4Pr1jsvYdVSoeaJD47b5xHIO8X3OUA1VuCXQwmJ/hwMepTsBEk
         zvldAdKGkzPq/mGb2x9dMFU+kiTySe4SRsA5WeHCsvD252T6TTtXg0pygRhAHVuLWe2L
         AMcX927+FMBpf5+kS79/iDPTdsFeAsvFnvKtb5x11wuaSBaULzM7VUo+kjsxXS4Sk1cv
         S1/IRpLkxvUmt9UEhgTXT5WXRrGALy6uBmQ1nwLCH3tZ4Jn4b+I7zE8GWf/MR3EuPRRc
         A7lA==
X-Gm-Message-State: AOJu0Yy0j3VR7QNuMz0wzKC4lY02X++tzfQCVtSXxQfgkgvO4QNCON4S
	uHvuXT8Mx2F40mra3sr4nnK+Nf678AwdVy8/nIjaJvYeBraNKXH9BAla9LkyJYs=
X-Google-Smtp-Source: AGHT+IEf3+S0MhgY0wukGRo771V3bdpj3ZA5SXQwPVRN2B+sO2RVirDXSDvX66hTXcXM0U1zEb/VKQ==
X-Received: by 2002:a17:906:4f16:b0:a6e:f997:7d91 with SMTP id a640c23a62f3a-a6f60d42257mr139307566b.38.1718358443385;
        Fri, 14 Jun 2024 02:47:23 -0700 (PDT)
Received: from [127.0.1.1] ([78.10.206.163])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f9c84csm164966366b.222.2024.06.14.02.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 02:47:22 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 14 Jun 2024 11:46:21 +0200
Subject: [PATCH 22/22] dt-bindings: thermal: cleanup examples indentation
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240614-dt-bindings-thermal-allof-v1-22-30b25a6ae24e@linaro.org>
References: <20240614-dt-bindings-thermal-allof-v1-0-30b25a6ae24e@linaro.org>
In-Reply-To: <20240614-dt-bindings-thermal-allof-v1-0-30b25a6ae24e@linaro.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Vasily Khoruzhick <anarsoul@gmail.com>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Anson Huang <Anson.Huang@nxp.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Amit Kucheria <amitk@kernel.org>, 
 =?utf-8?q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, 
 Heiko Stuebner <heiko@sntech.de>, Biju Das <biju.das.jz@bp.renesas.com>, 
 Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Pascal Paillet <p.paillet@foss.st.com>, Keerthy <j-keerthy@ti.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Scott Branden <sbranden@broadcom.com>, 
 zhanghongchen <zhanghongchen@loongson.cn>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, imx@lists.linux.dev, 
 linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 linux-rpi-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=21269;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=PTWaCGHhxDG3JPho0JTkQVwDMdXBskC1S/cinQsqs34=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmbBFzHrd9GOiKwbzJMror8sT+hnOlEceWGq75k
 7UM0c1D222JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZmwRcwAKCRDBN2bmhouD
 1yuHEACQQW+ctgqsyxcNpgAHqwclHpTy68YBzjAnl4LzShLU/IKf0yY+RsTopyTrhoi2a8uqxym
 tb/2s73RE2G0GQGl6ovK2iXBnX57zoQHgEiM+npaJaO8VOeo7SqdNFVMogAV6tQqsJ1at1ApsyZ
 /Rsq7yRCQMOME6Fh7mGb6xsxi1vn1Pe0Pmx4FAHcDlZORtDY0q5uCrzuV5ox3hLALkNxy2gR5Cr
 SLzND16UJibYdb1DDPgARuC8T62okbBouAY/sxXbD1ri9KpKOpZTfq6tXSAwe7Uq16dVk5gMTZH
 pgz9p2yaqZ3YfQfLfClz44hpM5JFAHpK2OQaW8XDXDhcHASmA30A2JGeJjHAvt+E9157G2e5XGX
 vDOkH5TldhWe0Jf3WqfvqF7pJd4iQhNpBbqTglUIDZo7RnwYPyXsQqIQFVUMkp513EZQ513iQJk
 ImwdYUGZHbNyg642Bju3dWO6ydMpKIpRLinsMHViIFI0XOIa+GYqW5n9XrRo95RsEZAJBGiamw1
 kztcCY3tAQVxMZCXBalUMhCJsldG+yK0kybQ42JUjgLYIP/pYJ6Gbl4FRdBTCwORdDwCufh4p5a
 J2cutoXsbGMslNy/H3IVMfdFi//qegvrgHFSYaxZlHeyvMtwjOw0yJvviRhsuBz//He4zuLCH8k
 8ea1P+ZuXQH2j3w==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Preferred indentation for DTS examples in the bindings is 4-space.  It
is also preferred not to have redundant/unused labels. No functional
change

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/thermal/amlogic,thermal.yaml          | 18 ++---
 .../bindings/thermal/brcm,avs-ro-thermal.yaml      | 16 ++--
 .../devicetree/bindings/thermal/brcm,avs-tmon.yaml | 16 ++--
 .../devicetree/bindings/thermal/qcom-tsens.yaml    | 88 ++++++++++------------
 .../bindings/thermal/rcar-gen3-thermal.yaml        | 64 ++++++++--------
 .../devicetree/bindings/thermal/rcar-thermal.yaml  | 60 +++++++--------
 .../devicetree/bindings/thermal/rzg2l-thermal.yaml | 36 ++++-----
 .../devicetree/bindings/thermal/sprd-thermal.yaml  | 42 +++++------
 .../bindings/thermal/ti,am654-thermal.yaml         | 10 +--
 9 files changed, 172 insertions(+), 178 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
index e52fc40e215d..725303e1a364 100644
--- a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
@@ -50,13 +50,13 @@ unevaluatedProperties: false
 
 examples:
   - |
-        cpu_temp: temperature-sensor@ff634800 {
-                compatible = "amlogic,g12a-cpu-thermal",
-                             "amlogic,g12a-thermal";
-                reg = <0xff634800 0x50>;
-                interrupts = <0x0 0x24 0x0>;
-                clocks = <&clk 164>;
-                #thermal-sensor-cells = <0>;
-                amlogic,ao-secure = <&sec_AO>;
-        };
+    temperature-sensor@ff634800 {
+        compatible = "amlogic,g12a-cpu-thermal",
+                     "amlogic,g12a-thermal";
+        reg = <0xff634800 0x50>;
+        interrupts = <0x0 0x24 0x0>;
+        clocks = <&clk 164>;
+        #thermal-sensor-cells = <0>;
+        amlogic,ao-secure = <&sec_AO>;
+    };
 ...
diff --git a/Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml b/Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml
index 0271a0bc1843..29a9844e8b48 100644
--- a/Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml
@@ -35,14 +35,14 @@ unevaluatedProperties: false
 
 examples:
   - |
-        avs-monitor@7d5d2000 {
-                compatible = "brcm,bcm2711-avs-monitor",
-                             "syscon", "simple-mfd";
-                reg = <0x7d5d2000 0xf00>;
+    avs-monitor@7d5d2000 {
+        compatible = "brcm,bcm2711-avs-monitor",
+                     "syscon", "simple-mfd";
+        reg = <0x7d5d2000 0xf00>;
 
-                thermal: thermal {
-                        compatible = "brcm,bcm2711-thermal";
-                        #thermal-sensor-cells = <0>;
-                };
+        thermal: thermal {
+            compatible = "brcm,bcm2711-thermal";
+            #thermal-sensor-cells = <0>;
         };
+    };
 ...
diff --git a/Documentation/devicetree/bindings/thermal/brcm,avs-tmon.yaml b/Documentation/devicetree/bindings/thermal/brcm,avs-tmon.yaml
index 32730211e15b..081486b44382 100644
--- a/Documentation/devicetree/bindings/thermal/brcm,avs-tmon.yaml
+++ b/Documentation/devicetree/bindings/thermal/brcm,avs-tmon.yaml
@@ -45,11 +45,11 @@ required:
 
 examples:
   - |
-     thermal@f04d1500 {
-          compatible = "brcm,avs-tmon-bcm7445", "brcm,avs-tmon";
-          reg = <0xf04d1500 0x28>;
-          interrupts = <0x6>;
-          interrupt-names = "tmon";
-          interrupt-parent = <&avs_host_l2_intc>;
-          #thermal-sensor-cells = <0>;
-     };
+    thermal@f04d1500 {
+        compatible = "brcm,avs-tmon-bcm7445", "brcm,avs-tmon";
+        reg = <0xf04d1500 0x28>;
+        interrupts = <0x6>;
+        interrupt-names = "tmon";
+        interrupt-parent = <&avs_host_l2_intc>;
+        #thermal-sensor-cells = <0>;
+    };
diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index cce6624228c7..01f9f45b94c2 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -295,22 +295,16 @@ unevaluatedProperties: false
 examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
-    // Example msm9860 based SoC (ipq8064):
-    gcc: clock-controller {
+    thermal-sensor {
+        compatible = "qcom,ipq8064-tsens";
 
-           /* ... */
+        nvmem-cells = <&tsens_calib>, <&tsens_calib_backup>;
+        nvmem-cell-names = "calib", "calib_backup";
+        interrupts = <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "uplow";
 
-           tsens: thermal-sensor {
-                compatible = "qcom,ipq8064-tsens";
-
-                 nvmem-cells = <&tsens_calib>, <&tsens_calib_backup>;
-                 nvmem-cell-names = "calib", "calib_backup";
-                 interrupts = <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>;
-                 interrupt-names = "uplow";
-
-                 #qcom,sensors = <11>;
-                 #thermal-sensor-cells = <1>;
-          };
+        #qcom,sensors = <11>;
+        #thermal-sensor-cells = <1>;
     };
 
   - |
@@ -347,66 +341,66 @@ examples:
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     // Example 1 (legacy: for pre v1 IP):
     tsens1: thermal-sensor@4a9000 {
-           compatible = "qcom,msm8916-tsens", "qcom,tsens-v0_1";
-           reg = <0x4a9000 0x1000>, /* TM */
-                 <0x4a8000 0x1000>; /* SROT */
+        compatible = "qcom,msm8916-tsens", "qcom,tsens-v0_1";
+        reg = <0x4a9000 0x1000>, /* TM */
+              <0x4a8000 0x1000>; /* SROT */
 
-           nvmem-cells = <&tsens_caldata>, <&tsens_calsel>;
-           nvmem-cell-names = "calib", "calib_sel";
+        nvmem-cells = <&tsens_caldata>, <&tsens_calsel>;
+        nvmem-cell-names = "calib", "calib_sel";
 
-           interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
-           interrupt-names = "uplow";
+        interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "uplow";
 
-           #qcom,sensors = <5>;
-           #thermal-sensor-cells = <1>;
+        #qcom,sensors = <5>;
+        #thermal-sensor-cells = <1>;
     };
 
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     // Example 2 (for any platform containing v1 of the TSENS IP):
     tsens2: thermal-sensor@4a9000 {
-          compatible = "qcom,qcs404-tsens", "qcom,tsens-v1";
-          reg = <0x004a9000 0x1000>, /* TM */
-                <0x004a8000 0x1000>; /* SROT */
+        compatible = "qcom,qcs404-tsens", "qcom,tsens-v1";
+        reg = <0x004a9000 0x1000>, /* TM */
+              <0x004a8000 0x1000>; /* SROT */
 
-          nvmem-cells = <&tsens_caldata>;
-          nvmem-cell-names = "calib";
+        nvmem-cells = <&tsens_caldata>;
+        nvmem-cell-names = "calib";
 
-          interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>;
-          interrupt-names = "uplow";
+        interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "uplow";
 
-          #qcom,sensors = <10>;
-          #thermal-sensor-cells = <1>;
+        #qcom,sensors = <10>;
+        #thermal-sensor-cells = <1>;
     };
 
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     // Example 3 (for any platform containing v2 of the TSENS IP):
     tsens3: thermal-sensor@c263000 {
-           compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
-           reg = <0xc263000 0x1ff>,
-                 <0xc222000 0x1ff>;
+        compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
+        reg = <0xc263000 0x1ff>,
+              <0xc222000 0x1ff>;
 
-           interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>,
-                        <GIC_SPI 508 IRQ_TYPE_LEVEL_HIGH>;
-           interrupt-names = "uplow", "critical";
+        interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 508 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "uplow", "critical";
 
-           #qcom,sensors = <13>;
-           #thermal-sensor-cells = <1>;
+        #qcom,sensors = <13>;
+        #thermal-sensor-cells = <1>;
     };
 
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     // Example 4 (for any IPQ8074 based SoC-s):
     tsens4: thermal-sensor@4a9000 {
-           compatible = "qcom,ipq8074-tsens";
-           reg = <0x4a9000 0x1000>,
-                 <0x4a8000 0x1000>;
+        compatible = "qcom,ipq8074-tsens";
+        reg = <0x4a9000 0x1000>,
+              <0x4a8000 0x1000>;
 
-           interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
-           interrupt-names = "combined";
+        interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "combined";
 
-           #qcom,sensors = <16>;
-           #thermal-sensor-cells = <1>;
+        #qcom,sensors = <16>;
+        #thermal-sensor-cells = <1>;
     };
 ...
diff --git a/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml b/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml
index d92e882c9e8d..b6657d64cf3d 100644
--- a/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml
@@ -106,33 +106,33 @@ examples:
     #include <dt-bindings/power/r8a7795-sysc.h>
 
     tsc: thermal@e6198000 {
-            compatible = "renesas,r8a7795-thermal";
-            reg = <0xe6198000 0x100>,
-                  <0xe61a0000 0x100>,
-                  <0xe61a8000 0x100>;
-            interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
-            clocks = <&cpg CPG_MOD 522>;
-            power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-            resets = <&cpg 522>;
-            #thermal-sensor-cells = <1>;
+        compatible = "renesas,r8a7795-thermal";
+        reg = <0xe6198000 0x100>,
+              <0xe61a0000 0x100>,
+              <0xe61a8000 0x100>;
+        interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&cpg CPG_MOD 522>;
+        power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+        resets = <&cpg 522>;
+        #thermal-sensor-cells = <1>;
     };
 
     thermal-zones {
-            sensor_thermal: sensor-thermal {
-                    polling-delay-passive = <250>;
-                    polling-delay = <1000>;
-                    thermal-sensors = <&tsc 0>;
+        sensor_thermal: sensor-thermal {
+            polling-delay-passive = <250>;
+            polling-delay = <1000>;
+            thermal-sensors = <&tsc 0>;
 
-                    trips {
-                            sensor1_crit: sensor1-crit {
-                                    temperature = <90000>;
-                                    hysteresis = <2000>;
-                                    type = "critical";
-                            };
-                    };
+            trips {
+                sensor1_crit: sensor1-crit {
+                    temperature = <90000>;
+                    hysteresis = <2000>;
+                    type = "critical";
+                };
             };
+        };
     };
   - |
     #include <dt-bindings/clock/r8a779a0-cpg-mssr.h>
@@ -140,14 +140,14 @@ examples:
     #include <dt-bindings/power/r8a779a0-sysc.h>
 
     tsc_r8a779a0: thermal@e6190000 {
-            compatible = "renesas,r8a779a0-thermal";
-            reg = <0xe6190000 0x200>,
-                  <0xe6198000 0x200>,
-                  <0xe61a0000 0x200>,
-                  <0xe61a8000 0x200>,
-                  <0xe61b0000 0x200>;
-            clocks = <&cpg CPG_MOD 919>;
-            power-domains = <&sysc R8A779A0_PD_ALWAYS_ON>;
-            resets = <&cpg 919>;
-            #thermal-sensor-cells = <1>;
+        compatible = "renesas,r8a779a0-thermal";
+        reg = <0xe6190000 0x200>,
+              <0xe6198000 0x200>,
+              <0xe61a0000 0x200>,
+              <0xe61a8000 0x200>,
+              <0xe61b0000 0x200>;
+        clocks = <&cpg CPG_MOD 919>;
+        power-domains = <&sysc R8A779A0_PD_ALWAYS_ON>;
+        resets = <&cpg 919>;
+        #thermal-sensor-cells = <1>;
     };
diff --git a/Documentation/devicetree/bindings/thermal/rcar-thermal.yaml b/Documentation/devicetree/bindings/thermal/rcar-thermal.yaml
index 119998d10ff4..221a58d18cad 100644
--- a/Documentation/devicetree/bindings/thermal/rcar-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/rcar-thermal.yaml
@@ -98,8 +98,8 @@ examples:
   # Example (non interrupt support)
   - |
     thermal@ffc48000 {
-            compatible = "renesas,thermal-r8a7779", "renesas,rcar-thermal";
-            reg = <0xffc48000 0x38>;
+        compatible = "renesas,thermal-r8a7779", "renesas,rcar-thermal";
+        reg = <0xffc48000 0x38>;
     };
 
   # Example (interrupt support)
@@ -109,12 +109,12 @@ examples:
     #include <dt-bindings/interrupt-controller/irq.h>
 
     thermal@e61f0000 {
-            compatible = "renesas,thermal-r8a73a4", "renesas,rcar-thermal";
-            reg = <0xe61f0000 0x14>, <0xe61f0100 0x38>,
-                  <0xe61f0200 0x38>, <0xe61f0300 0x38>;
-            interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
-            clocks = <&mstp5_clks R8A73A4_CLK_THERMAL>;
-            power-domains = <&pd_c5>;
+        compatible = "renesas,thermal-r8a73a4", "renesas,rcar-thermal";
+        reg = <0xe61f0000 0x14>, <0xe61f0100 0x38>,
+              <0xe61f0200 0x38>, <0xe61f0300 0x38>;
+        interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&mstp5_clks R8A73A4_CLK_THERMAL>;
+        power-domains = <&pd_c5>;
     };
 
   # Example (with thermal-zone)
@@ -124,32 +124,32 @@ examples:
     #include <dt-bindings/power/r8a7790-sysc.h>
 
     thermal: thermal@e61f0000 {
-      compatible = "renesas,thermal-r8a7790",
-                   "renesas,rcar-gen2-thermal",
-                   "renesas,rcar-thermal";
-            reg = <0xe61f0000 0x10>, <0xe61f0100 0x38>;
-            interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
-            clocks = <&cpg CPG_MOD 522>;
-            power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
-            resets = <&cpg 522>;
-            #thermal-sensor-cells = <0>;
+        compatible = "renesas,thermal-r8a7790",
+                     "renesas,rcar-gen2-thermal",
+                     "renesas,rcar-thermal";
+        reg = <0xe61f0000 0x10>, <0xe61f0100 0x38>;
+        interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&cpg CPG_MOD 522>;
+        power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+        resets = <&cpg 522>;
+        #thermal-sensor-cells = <0>;
     };
 
     thermal-zones {
-            cpu_thermal: cpu-thermal {
-                    polling-delay-passive = <1000>;
-                    polling-delay = <5000>;
+        cpu_thermal: cpu-thermal {
+            polling-delay-passive = <1000>;
+            polling-delay = <5000>;
 
-                    thermal-sensors = <&thermal>;
+            thermal-sensors = <&thermal>;
 
-                    trips {
-                            cpu-crit {
-                                    temperature = <115000>;
-                                    hysteresis = <0>;
-                                    type = "critical";
-                            };
-                    };
-                    cooling-maps {
-                    };
+            trips {
+                cpu-crit {
+                    temperature = <115000>;
+                    hysteresis = <0>;
+                    type = "critical";
+                };
             };
+            cooling-maps {
+            };
+        };
     };
diff --git a/Documentation/devicetree/bindings/thermal/rzg2l-thermal.yaml b/Documentation/devicetree/bindings/thermal/rzg2l-thermal.yaml
index 2f96c0fe0f75..136589f5adee 100644
--- a/Documentation/devicetree/bindings/thermal/rzg2l-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/rzg2l-thermal.yaml
@@ -53,27 +53,27 @@ examples:
     #include <dt-bindings/clock/r9a07g044-cpg.h>
 
     tsu: thermal@10059400 {
-            compatible = "renesas,r9a07g044-tsu",
-                         "renesas,rzg2l-tsu";
-            reg = <0x10059400 0x400>;
-            clocks = <&cpg CPG_MOD R9A07G044_TSU_PCLK>;
-            resets = <&cpg R9A07G044_TSU_PRESETN>;
-            power-domains = <&cpg>;
-            #thermal-sensor-cells = <1>;
+        compatible = "renesas,r9a07g044-tsu",
+                     "renesas,rzg2l-tsu";
+        reg = <0x10059400 0x400>;
+        clocks = <&cpg CPG_MOD R9A07G044_TSU_PCLK>;
+        resets = <&cpg R9A07G044_TSU_PRESETN>;
+        power-domains = <&cpg>;
+        #thermal-sensor-cells = <1>;
     };
 
     thermal-zones {
-            cpu-thermal {
-                    polling-delay-passive = <250>;
-                    polling-delay = <1000>;
-                    thermal-sensors = <&tsu 0>;
+        cpu-thermal {
+            polling-delay-passive = <250>;
+            polling-delay = <1000>;
+            thermal-sensors = <&tsu 0>;
 
-                    trips {
-                            sensor_crit: sensor-crit {
-                                    temperature = <125000>;
-                                    hysteresis = <1000>;
-                                    type = "critical";
-                            };
-                    };
+            trips {
+                sensor_crit: sensor-crit {
+                    temperature = <125000>;
+                    hysteresis = <1000>;
+                    type = "critical";
+                };
             };
+        };
     };
diff --git a/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml b/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
index f65076fc68f9..afa551f6185f 100644
--- a/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
@@ -86,27 +86,27 @@ unevaluatedProperties: false
 
 examples:
   - |
-        ap_thm0: thermal@32200000 {
-                compatible = "sprd,ums512-thermal";
-                reg = <0x32200000 0x10000>;
-                clock-names = "enable";
-                clocks = <&aonapb_gate 32>;
-                #thermal-sensor-cells = <1>;
-                nvmem-cells = <&thm0_sign>, <&thm0_ratio>;
-                nvmem-cell-names = "thm_sign_cal", "thm_ratio_cal";
-                #address-cells = <1>;
-                #size-cells = <0>;
+    thermal@32200000 {
+        compatible = "sprd,ums512-thermal";
+        reg = <0x32200000 0x10000>;
+        clock-names = "enable";
+        clocks = <&aonapb_gate 32>;
+        #thermal-sensor-cells = <1>;
+        nvmem-cells = <&thm0_sign>, <&thm0_ratio>;
+        nvmem-cell-names = "thm_sign_cal", "thm_ratio_cal";
+        #address-cells = <1>;
+        #size-cells = <0>;
 
-                prometheus-sensor@0 {
-                        reg = <0>;
-                        nvmem-cells = <&thm0_sen0>;
-                        nvmem-cell-names = "sen_delta_cal";
-                };
-
-                ank-sensor@1 {
-                        reg = <1>;
-                        nvmem-cells = <&thm0_sen1>;
-                        nvmem-cell-names = "sen_delta_cal";
-                };
+        prometheus-sensor@0 {
+            reg = <0>;
+            nvmem-cells = <&thm0_sen0>;
+            nvmem-cell-names = "sen_delta_cal";
         };
+
+        ank-sensor@1 {
+            reg = <1>;
+            nvmem-cells = <&thm0_sen1>;
+            nvmem-cell-names = "sen_delta_cal";
+        };
+    };
 ...
diff --git a/Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml b/Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml
index 16801aa78bc2..c123d9070525 100644
--- a/Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml
@@ -47,11 +47,11 @@ examples:
         thermal-sensors = <&vtm0 0>;
 
         trips {
-                mpu0_crit: mpu0_crit {
-                        temperature = <125000>; /* milliCelsius */
-                        hysteresis = <2000>; /* milliCelsius */
-                        type = "critical";
-                };
+            mpu0_crit: mpu0_crit {
+                temperature = <125000>; /* milliCelsius */
+                hysteresis = <2000>; /* milliCelsius */
+                type = "critical";
+            };
         };
     };
 ...

-- 
2.43.0


