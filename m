Return-Path: <linux-pm+bounces-8825-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A979B901772
	for <lists+linux-pm@lfdr.de>; Sun,  9 Jun 2024 20:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03E0AB20D67
	for <lists+linux-pm@lfdr.de>; Sun,  9 Jun 2024 18:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C42151C5A;
	Sun,  9 Jun 2024 18:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwL6S0kZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EED50291;
	Sun,  9 Jun 2024 18:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717957301; cv=none; b=o/WdXwmA/yWmce7HgcTaToSuJIWirdcGcg44Um5vc87bV4l5yNVQuFjrSzgAHMdctDG1dURxrSzMCPiUxRN0dRgWtgtGG01h5XSo/00Zwk1+mDaTxe6d5y4jkb9SuMS2SezAF4X1FwQ/3Z0vpWyoJIV9MfSIg6Vvd3m7rxEeNZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717957301; c=relaxed/simple;
	bh=YtYeox3KTAiw8H+/Vi2xPxcWacWcFZQGWwbjDKuoM6A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PxRie6N5Adb23FoU5Ok3yN430Unpde/ARi4QODCW8bwn9u9mGLHv1XqdrtryXBfaYr4ZERewlhHgSrwgvkF2pemhtCo0rszVaoCC2vW7vJ6HixEg2y4vmIATLtcAwcDyp+cjdPNwnZcwVt7KovMiwn2A8xRvpbYEVzlkMElpdKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EwL6S0kZ; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ebe6495aedso2964961fa.0;
        Sun, 09 Jun 2024 11:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717957297; x=1718562097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JdWsFHoKDkTGJhSwxKx2d1KGuTWA24rmre8w4e+eERg=;
        b=EwL6S0kZhS5YHKREbqdE+U6T2QqHieO6eJcbAkyRK4EklG5RLL2sLrEBwqPbumFxAj
         fpp6d8K08xRmZT0z7D5ugh07hxh3trpjl8VxT9KkTjM6O55Zb0fVZOmnrl5cboJDeuek
         ihobNLX0YI3HY0sLUyNg9/xbw3yZvxo+tigsN/kmQem7BxaOBdiOk86KbWprgMQRwSEk
         pbgVQmgMIL1Ow9WHJ+CHuywH5/izwY5BR5RB4hOC/nl5ge0O3Y9PFeyzDWIzZiBIYUqK
         D2HGURf/Ga1J4F8PuPDZ452cqL1RfReT+BrW8wzvhveopxhfLhUueuh/ZrM1rRmv1xtp
         8HYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717957297; x=1718562097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JdWsFHoKDkTGJhSwxKx2d1KGuTWA24rmre8w4e+eERg=;
        b=MamBdaJ8/A+O0yAx/XjsO17iC7je3ZBs//P7GSBm3auMgzS+2v2txZoHlGibooNLIr
         URw7Jug5VINk63rkGMI4MakIjRf31IQQW5SnpN2Q+zy93ujqCcdI+y8ldqxCtRaWEBl9
         KaZAiM6Od/9HD/qgBbFsdXqODzFXGBIrcmhDf6MOnHWyvdO28qfK7cpkAnoVd+rV9eSO
         1iHus01MSSRUz+AtAswQIbcbNXcsA1Tr788sMEnzGFC/ALxW1VC8PV1dWVgUrsa5hMo1
         BJUdNL2M21WH3DF8s+rhUN6OeCR+0kG82pNVFRJ/kCnQK/fm519RQbd20zm+hWr5yhf2
         oGGw==
X-Forwarded-Encrypted: i=1; AJvYcCWAFNcnG8S9aMqiZIDGX/fGaZXDUpQerGngwz2V/6fLFFYVyrDHFim5x570DAdwE+V2Vqxhq4ws+r0wGurGbkYy9GvEQ1+NrEtpEs21Cf/ZJ6Wcmi9bxJCH7krlsYBdqtOxboiYWYObYqyV1M21wFXxT2q3v5zrcrj4P8+RlaeQB8jfiv4j128dWrmYTPaYSevSbJ4sPEeqxgTso9kP0WaGvQ==
X-Gm-Message-State: AOJu0YxOrcB8oGglTejDK1i7eoD9QSkVKtxFdUfnwh6jmw8+p27s9c24
	8JcDO/fJceVQPcCSgWS5euFU3OUw/+7+mOPWtEJJSC0/xXXKIzdWgwf6M0Do
X-Google-Smtp-Source: AGHT+IHvsVQ6/IXtc7O4ceI2ZMK9+S9aJ/rRuUqRgZCWDFFn8XH6HPB5v/Zt+VLRj0x4VELAGAYxwQ==
X-Received: by 2002:a2e:351a:0:b0:2eb:d620:88d9 with SMTP id 38308e7fff4ca-2ebd6208a5cmr19656451fa.30.1717957297171;
        Sun, 09 Jun 2024 11:21:37 -0700 (PDT)
Received: from localhost.localdomain (bza83.neoplus.adsl.tpnet.pl. [83.30.46.83])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ebd5a63bf2sm6679841fa.33.2024.06.09.11.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 11:21:36 -0700 (PDT)
From: Adam Skladowski <a39.skl@gmail.com>
To: 
Cc: phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Adam Skladowski <a39.skl@gmail.com>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Georgi Djakov <djakov@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] dt-bindings: interconnect: Add Qualcomm MSM8937 DT bindings
Date: Sun,  9 Jun 2024 20:20:56 +0200
Message-Id: <20240609182112.13032-4-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240609182112.13032-1-a39.skl@gmail.com>
References: <20240609182112.13032-1-a39.skl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bindings for Qualcomm MSM8937 Network-On-Chip interconnect devices.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 .../bindings/interconnect/qcom,msm8937.yaml   | 81 ++++++++++++++++
 .../dt-bindings/interconnect/qcom,msm8937.h   | 93 +++++++++++++++++++
 2 files changed, 174 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,msm8937.yaml
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8937.h

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8937.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8937.yaml
new file mode 100644
index 000000000000..39a1ca441bb2
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8937.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,msm8937.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm MSM8937 Network-On-Chip interconnect
+
+maintainers:
+  - Konrad Dybcio <konradybcio@kernel.org>
+
+description: |
+  The Qualcomm MSM8937 interconnect providers support adjusting the
+  bandwidth requirements between the various NoC fabrics.
+
+allOf:
+  - $ref: qcom,rpm-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - qcom,msm8937-bimc
+      - qcom,msm8937-pcnoc
+      - qcom,msm8937-snoc
+
+  reg:
+    maxItems: 1
+
+patternProperties:
+  '^interconnect-[a-z0-9\-]+$':
+    type: object
+    $ref: qcom,rpm-common.yaml#
+    description:
+      The interconnect providers do not have a separate QoS register space,
+      but share parent's space.
+
+    allOf:
+      - $ref: qcom,rpm-common.yaml#
+
+    properties:
+      compatible:
+        const: qcom,msm8937-snoc-mm
+
+    required:
+      - compatible
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmcc.h>
+    #include <dt-bindings/interconnect/qcom,rpm-icc.h>
+
+    bimc: interconnect@400000 {
+        compatible = "qcom,msm8937-bimc";
+        reg = <0x00400000 0x5a000>;
+        #interconnect-cells = <2>;
+    };
+
+    pcnoc: interconnect@500000 {
+        compatible = "qcom,msm8937-pcnoc";
+        reg = <0x00500000 0x13080>;
+        #interconnect-cells = <2>;
+    };
+
+    snoc: interconnect@580000 {
+        compatible = "qcom,msm8937-bimc";
+        reg = <0x00580000 0x16080>;
+        #interconnect-cells = <2>;
+
+          snoc_mm: interconnect-snoc {
+              compatible = "qcom,msm8937-snoc-mm";
+              #interconnect-cells = <2>;
+          };
+    };
diff --git a/include/dt-bindings/interconnect/qcom,msm8937.h b/include/dt-bindings/interconnect/qcom,msm8937.h
new file mode 100644
index 000000000000..98b8a4637aab
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,msm8937.h
@@ -0,0 +1,93 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Qualcomm MSM8937 interconnect IDs
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_MSM8937_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_MSM8937_H
+
+/* BIMC fabric */
+#define MAS_APPS_PROC		0
+#define MAS_OXILI		1
+#define MAS_SNOC_BIMC_0		2
+#define MAS_SNOC_BIMC_2		3
+#define MAS_SNOC_BIMC_1		4
+#define MAS_TCU_0		5
+#define SLV_EBI			6
+#define SLV_BIMC_SNOC		7
+
+/* PCNOC fabric */
+#define MAS_SPDM		0
+#define MAS_BLSP_1		1
+#define MAS_BLSP_2		2
+#define MAS_USB_HS1		3
+#define MAS_XI_USB_HS1		4
+#define MAS_CRYPTO		5
+#define MAS_SDCC_1		6
+#define MAS_SDCC_2		7
+#define MAS_SNOC_PCNOC		8
+#define PCNOC_M_0		9
+#define PCNOC_M_1		10
+#define PCNOC_INT_0		11
+#define PCNOC_INT_1		12
+#define PCNOC_INT_2		13
+#define PCNOC_INT_3		14
+#define PCNOC_S_0		15
+#define PCNOC_S_1		16
+#define PCNOC_S_2		17
+#define PCNOC_S_3		18
+#define PCNOC_S_4		19
+#define PCNOC_S_6		20
+#define PCNOC_S_7		21
+#define PCNOC_S_8		22
+#define SLV_SDCC_2		23
+#define SLV_SPDM		24
+#define SLV_PDM			25
+#define SLV_PRNG		26
+#define SLV_TCSR		27
+#define SLV_SNOC_CFG		28
+#define SLV_MESSAGE_RAM		29
+#define SLV_CAMERA_SS_CFG	30
+#define SLV_DISP_SS_CFG		31
+#define SLV_VENUS_CFG		32
+#define SLV_GPU_CFG		33
+#define SLV_TLMM		34
+#define SLV_BLSP_1		35
+#define SLV_BLSP_2		36
+#define SLV_PMIC_ARB		37
+#define SLV_SDCC_1		38
+#define SLV_CRYPTO_0_CFG	39
+#define SLV_USB_HS		40
+#define SLV_TCU			41
+#define SLV_PCNOC_SNOC		42
+
+/* SNOC fabric */
+#define MAS_QDSS_BAM		0
+#define MAS_BIMC_SNOC		1
+#define MAS_PCNOC_SNOC		2
+#define MAS_QDSS_ETR		3
+#define QDSS_INT		4
+#define SNOC_INT_0		5
+#define SNOC_INT_1		6
+#define SNOC_INT_2		7
+#define SLV_KPSS_AHB		8
+#define SLV_WCSS		9
+#define SLV_SNOC_BIMC_1		10
+#define SLV_IMEM		11
+#define SLV_SNOC_PCNOC		12
+#define SLV_QDSS_STM		13
+#define SLV_CATS_1		14
+#define SLV_LPASS		15
+
+/* SNOC-MM fabric */
+#define MAS_JPEG		0
+#define MAS_MDP			1
+#define MAS_VENUS		2
+#define MAS_VFE0		3
+#define MAS_VFE1		4
+#define MAS_CPP			5
+#define SLV_SNOC_BIMC_0		6
+#define SLV_SNOC_BIMC_2		7
+#define SLV_CATS_0		8
+
+#endif /* __DT_BINDINGS_INTERCONNECT_QCOM_MSM8937_H */
-- 
2.45.1


