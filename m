Return-Path: <linux-pm+bounces-10634-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22661927E25
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 22:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 475401C224BD
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 20:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A048143C41;
	Thu,  4 Jul 2024 20:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWS7oRg/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7564143897;
	Thu,  4 Jul 2024 20:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720123449; cv=none; b=mCxfMjxqPjYpdTBM2Rv59dnxO5zZPqRYWIPJi9AAZIXgJuWr1RLlRBODEqxij22V8/ErihJRBA775CjO3xgwSy5zy3gq0vlJb+EXqVHopwNkI46o+nI7NUY/z/BkP4ldGtCvyHH1wqLnbVamEYxpU7B2qAL0K8x8w0KwHoGuscc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720123449; c=relaxed/simple;
	bh=goiUSwDQQbUdlwitFN4oZhmti/h9wkjqhN7LCV8ZNK0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=koM+fPsOGDf6UOQoSuYMxwuw7Au8MEKUamdj93m9ri+DEPeelGuMPt2BSd2Kb5hh5ncY+8CGdpFvIkfpLpU2tk2VTZdsysUpPeGv6Co0Lxm1dN4eb+Br1HqYNsMqOriWkIc/nGjHsrI6v3R9iF/ntwOHwVo3UAavbZxZG6ziUcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cWS7oRg/; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-58bac81f3f9so1336097a12.2;
        Thu, 04 Jul 2024 13:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720123446; x=1720728246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bc3YeT/EM02rDJ9ZVDFOKzSfItMjL7IJNOua7Ag9wBc=;
        b=cWS7oRg/VcTf6hsRiVb1WseHU6pagn5+PAkUm7VdEZeai1ZnNRZh+dxPcQTtNmh0/1
         XSGTeb1AQP91kxUkD8tROvrRrgTRFzaLlUAMXuGPFNfj7FPI4AP0G5IZtOvq6r6uTmzO
         C+zczWoAjeQq5hQ3L/sswflAdzZFWobUVLTYmwHZkjehu4LbYTYao8dUdo9oKVZ1MEjf
         vaFoq02ffutWIznvomWhr9tiXWhhxsnxIhpad4DJ+GQqGeTo0hJXYC8xR+PZfaQsRZQV
         0UMnClKjmqgxxC1l264u92jm2dXYye0r4+LousdvRH5SJeQ48sgpBH+lCrdBDjrMBEUf
         rmEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720123446; x=1720728246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bc3YeT/EM02rDJ9ZVDFOKzSfItMjL7IJNOua7Ag9wBc=;
        b=em63XBT6bsVDxYtuN7QkjJmIuXBSqnFf4AoAkkPuyCApWqly6RWRV1b7PiTxs3dI01
         FvJ3fYyRZrz3hAlI3FVueW1mgT3J0PxqBdme5Klr6vxJq7a0GBxkNS+k4qTkcUKy6ns4
         E/457odsEIwt9/MHU4cMP3vVoBKTA5bXJqN0pcEQAlcJKBIUmWKGzchnUor9glYW20fj
         ShsCKyIExfCCojf0jCDA5GZG9fHzP7X2kSGmbHxGDeXI/CDgB7dOT7+21Y4XlXoq4Q5L
         ylOFUenefsyBPvQPSydk1TdscrGWrq9zS7C3V0lbRtR7iqBs6kL0ar2ixjo8SMaSoy5D
         Zbgw==
X-Forwarded-Encrypted: i=1; AJvYcCXnqb113HShHK44RwiJetn41KbX+POF74yHtLq3HT73H/Y+mnu9BefEoAt8awGgho4qrYBeYAW5eRmba7kHPLC5sZ952rFl/mx6XINMLxXxqGhAhLmOOT0u1OkTev0YvDwP+91HgEx0f98yVFwCW3AF8Xwza5uond57/zn8LzwG7psJP9HQp1T9YocUxkXQ17SEmLX/1lGAFmUMiOGIPWYlOQ==
X-Gm-Message-State: AOJu0YxVkunu1fPAuSiVPbXQoc/I0tucAcPQYPbQdMsm5gIttTNmXd8X
	TlMaFVXL4BtpEx1wcQybRI+LGqT7XPqWTe770TQDv1Ry7qwVxNQ3JEDtImv+
X-Google-Smtp-Source: AGHT+IFDJTSX1uCpcBTuOrbISMkx1CBYCBLC08ZhJIr5IXhyiGiy5L7g9lpYAPtDfo5XVoYEA7WUTg==
X-Received: by 2002:a05:6402:2349:b0:57c:aac9:cd8 with SMTP id 4fb4d7f45d1cf-58e5a7e8b66mr1915199a12.8.1720123445407;
        Thu, 04 Jul 2024 13:04:05 -0700 (PDT)
Received: from localhost.localdomain (byx56.neoplus.adsl.tpnet.pl. [83.30.43.56])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58b4a97b1f3sm4091149a12.18.2024.07.04.13.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 13:04:04 -0700 (PDT)
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
Subject: [PATCH v2 3/8] dt-bindings: interconnect: qcom: Add Qualcomm MSM8937 NoC
Date: Thu,  4 Jul 2024 22:02:26 +0200
Message-Id: <20240704200327.8583-4-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240704200327.8583-1-a39.skl@gmail.com>
References: <20240704200327.8583-1-a39.skl@gmail.com>
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
 .../bindings/interconnect/qcom,msm8937.yaml   | 63 +++++++++++++
 .../dt-bindings/interconnect/qcom,msm8937.h   | 93 +++++++++++++++++++
 2 files changed, 156 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,msm8937.yaml
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8937.h

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8937.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8937.yaml
new file mode 100644
index 000000000000..aee79033ffeb
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8937.yaml
@@ -0,0 +1,63 @@
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
+  See also:
+  - dt-bindings/interconnect/qcom,msm8937.h
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
+  '#interconnect-cells':
+    const: 2
+
+patternProperties:
+  '^interconnect-[a-z0-9\-]+$':
+    type: object
+    $ref: qcom,rpm-common.yaml#
+    unevaluatedProperties: false
+    description:
+      The interconnect providers do not have a separate QoS register space,
+      but share parent's space.
+
+    properties:
+      compatible:
+        const: qcom,msm8937-snoc-mm
+
+    required:
+      - compatible
+      - '#interconnect-cells'
+
+required:
+  - compatible
+  - reg
+  - '#interconnect-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+      bimc: interconnect@400000 {
+          compatible = "qcom,msm8937-bimc";
+          reg = <0x00400000 0x5a000>;
+
+          #interconnect-cells = <2>;
+      };
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
2.45.2


