Return-Path: <linux-pm+bounces-8823-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A48901768
	for <lists+linux-pm@lfdr.de>; Sun,  9 Jun 2024 20:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EC0A1C20935
	for <lists+linux-pm@lfdr.de>; Sun,  9 Jun 2024 18:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52994D8C4;
	Sun,  9 Jun 2024 18:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAtHiqbX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F5F4D8AE;
	Sun,  9 Jun 2024 18:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717957293; cv=none; b=FGOT5DJ5OoJRnC1txAoS5hbGynrpGajT2hcZGlYJb/imJDAXRm7OqPnwgXNA++34WseQV1r2SI/LYOsW3/kin9JOkgPDR3jAjDtaXdZxDbjcnWGWharXYDfxdt11bC4NJEo80l/epNv/jN8C53nCIN8vsPWdJgzcoCfVkRFsXho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717957293; c=relaxed/simple;
	bh=ziRlSJW9/STMYE8qL339Gew9QD0QOSsY2zJstVkSd5I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hrq7M9Jwfw1/p2xpYVr5q78XzUWD9F//OqRK8NfoGv3cZFoO3tVV/IIk0v54hHO39Dn2Xd+JSx7a2tBw7ULzmZUDfE91r/DpEnvB0bBo/wgwFcHoIsQWiV+V7PxR+FKmPaT2gIkpyKm3XXPU+6flDzdb86X4ZtS03tvuf+x+wT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DAtHiqbX; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ebe0a81dc8so6297761fa.2;
        Sun, 09 Jun 2024 11:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717957290; x=1718562090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWsqy146Wz8gtIigu1ZwZda5tu61ILNT8EB35qWgat8=;
        b=DAtHiqbXryWhtjjoHgJ8jVLp8d3axEkqRimKcn/GKpvFxHh5oa3GgBpw0Kga78qHM3
         ynsJnviKEU8NceKQSsw+TqWe1015JbaSI9YYIcz5/nUw03rV0mSZLEJtjIhTfLY1Gw7J
         tAeruDDNVhYHiYk8yYFRGRbfUqSt6EaGpHVAlH/95/IGNteqk9fUWb6HHFqWZoxCmwb8
         dgwuMBI3qWQ08lNgKzc1I1TWsG9Lx0eNXBpp+SivPUEOIKqfqo/RdtBlbM9FR7vaXR/G
         xy1kYe+Y58JmQ4qzDvFmkAVq/CYnHtD6Fx6jVH6ym84yBpTfLYPzCe5+SWjFufuB21rq
         8LlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717957290; x=1718562090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aWsqy146Wz8gtIigu1ZwZda5tu61ILNT8EB35qWgat8=;
        b=tSsuOf+fS6DQdvO89g5T8DLL2XuS3GxX+EIfU65jzHCDeHfW3l85fH/CoXrf6eu+tH
         VkblwIb6xRLlPQmIMzy812B5jfRb1HktJhUmfUkBF1ZKbIC8NFozJXZucL0QjOM6Hewu
         vYQtZ6lu8fbsguDkArgn5oUeTwkqyz+SQtUBNtopSPMY9xxnRV34QOYCYjwvYdXNYazg
         35QHfVFSAGSwLWSDYpf1SDsWAvQznz3jyHYS6laNFY791l2jwee+0GGMuHoU49JyrzCj
         fHFzTDyrW7IKU9O8sBpp5jI/2RkMZsI+FNDxmxUFjx5i1Gpz9zIME0ZLCSFti/K8jIQj
         J52w==
X-Forwarded-Encrypted: i=1; AJvYcCWjLdOzJ1jLHrHCBf8+4q3EU+KUXs+bsuPivWUxnDMaE9D0QmUTv8nUZ950myb8dZEeimgzYIfWrqkWpgFypuA+u9IYiISltDTJIX1EmqMApJXoEtn5IpuSadR4Yzau97ymmvK9LddkA0jjMf1ePGp9r6bPeoiXF31A4ypdiRoYyHArEp6IfIB94+dkx+2xT/11DI+Iqxu1ljqeDoFSByTVPg==
X-Gm-Message-State: AOJu0YzQJj7AT4+QLOV2uL24qvOZTQWx1Quz0vXKUouPExPVsoMVeL7g
	JDwGdKDZkCtlLfxc/BHsLHmautJxwyEOMIyG6TW2jNcHKWtEWmWnXoNaKca1
X-Google-Smtp-Source: AGHT+IFLEaGF6B4SoeubzpJFEMoylvNqJn3ms5QaONbEAQjbhK4hz3PMn7RKuUGyEmP1KfO4HKtKng==
X-Received: by 2002:a2e:a7c8:0:b0:2eb:e505:ebcd with SMTP id 38308e7fff4ca-2ebe505ee51mr13192241fa.11.1717957289792;
        Sun, 09 Jun 2024 11:21:29 -0700 (PDT)
Received: from localhost.localdomain (bza83.neoplus.adsl.tpnet.pl. [83.30.46.83])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ebd5a63bf2sm6679841fa.33.2024.06.09.11.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 11:21:29 -0700 (PDT)
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
Subject: [PATCH 1/7] dt-bindings: interconnect: Add Qualcomm MSM8976 DT bindings
Date: Sun,  9 Jun 2024 20:20:54 +0200
Message-Id: <20240609182112.13032-2-a39.skl@gmail.com>
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

Add bindings for Qualcomm MSM8976 Network-On-Chip interconnect devices.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 .../bindings/interconnect/qcom,msm8976.yaml   | 107 ++++++++++++++++++
 .../dt-bindings/interconnect/qcom,msm8976.h   |  97 ++++++++++++++++
 2 files changed, 204 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,msm8976.yaml
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8976.h

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8976.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8976.yaml
new file mode 100644
index 000000000000..bc9d08443e7c
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8976.yaml
@@ -0,0 +1,107 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,msm8976.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm MSM8976 Network-On-Chip interconnect
+
+maintainers:
+  - Konrad Dybcio <konradybcio@kernel.org>
+
+description: |
+  The Qualcomm MSM8976 interconnect providers support adjusting the
+  bandwidth requirements between the various NoC fabrics.
+
+properties:
+  compatible:
+    enum:
+      - qcom,msm8976-bimc
+      - qcom,msm8976-pcnoc
+      - qcom,msm8976-snoc
+
+  reg:
+    maxItems: 1
+
+  clock-names:
+    minItems: 1
+    maxItems: 2
+
+  clocks:
+    minItems: 1
+    maxItems: 2
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
+        const: qcom,msm8976-snoc-mm
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
+allOf:
+  - $ref: qcom,rpm-common.yaml#
+  - if:
+      properties:
+        compatible:
+          const: qcom,msm8976-snoc
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: IPA clock from RPMCC
+        clock-names:
+          const: ipa
+
+      required:
+        - clocks
+        - clock-names
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmcc.h>
+    #include <dt-bindings/interconnect/qcom,rpm-icc.h>
+
+    bimc: interconnect@400000 {
+        compatible = "qcom,msm8976-bimc";
+        reg = <0x00400000 0x62000>;
+        #interconnect-cells = <2>;
+    };
+
+    pcnoc: interconnect@500000 {
+        compatible = "qcom,msm8976-pcnoc";
+        reg = <0x00500000 0x14000>;
+        #interconnect-cells = <2>;
+    };
+
+    snoc: interconnect@580000 {
+        compatible = "qcom,msm8976-snoc";
+        reg = <0x00580000 0x1a000>;
+        clocks =  <&rpmcc RPM_SMD_IPA_CLK>;
+        clock-names = "ipa";
+        #interconnect-cells = <2>;
+
+          snoc_mm: interconnect-snoc {
+              compatible = "qcom,msm8976-snoc-mm";
+              #interconnect-cells = <2>;
+          };
+    };
diff --git a/include/dt-bindings/interconnect/qcom,msm8976.h b/include/dt-bindings/interconnect/qcom,msm8976.h
new file mode 100644
index 000000000000..4ea90f22320e
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,msm8976.h
@@ -0,0 +1,97 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Qualcomm MSM8976 interconnect IDs
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_MSM8976_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_MSM8976_H
+
+/* BIMC fabric */
+#define MAS_APPS_PROC		0
+#define MAS_SMMNOC_BIMC	        1
+#define MAS_SNOC_BIMC		2
+#define MAS_TCU_0		3
+#define SLV_EBI		        4
+#define SLV_BIMC_SNOC		5
+
+/* PCNOC fabric */
+#define MAS_USB_HS2		0
+#define MAS_BLSP_1		1
+#define MAS_USB_HS1		2
+#define MAS_BLSP_2		3
+#define MAS_CRYPTO		4
+#define MAS_SDCC_1		5
+#define MAS_SDCC_2		6
+#define MAS_SDCC_3		7
+#define MAS_SNOC_PCNOC		8
+#define MAS_LPASS_AHB		9
+#define MAS_SPDM		10
+#define MAS_DEHR		11
+#define MAS_XM_USB_HS1		12
+#define PCNOC_M_0		13
+#define PCNOC_M_1		14
+#define PCNOC_INT_0		15
+#define PCNOC_INT_1		16
+#define PCNOC_INT_2		17
+#define PCNOC_S_1		18
+#define PCNOC_S_2		19
+#define PCNOC_S_3		20
+#define PCNOC_S_4		21
+#define PCNOC_S_8		22
+#define PCNOC_S_9		23
+#define SLV_TCSR		24
+#define SLV_TLMM		25
+#define SLV_CRYPTO_0_CFG	26
+#define SLV_MESSAGE_RAM	        27
+#define SLV_PDM		        28
+#define SLV_PRNG		29
+#define SLV_PMIC_ARB		30
+#define SLV_SNOC_CFG		31
+#define SLV_DCC_CFG		32
+#define SLV_CAMERA_SS_CFG	33
+#define SLV_DISP_SS_CFG	        34
+#define SLV_VENUS_CFG		35
+#define SLV_SDCC_1		36
+#define SLV_BLSP_1		37
+#define SLV_USB_HS		38
+#define SLV_SDCC_3		39
+#define SLV_SDCC_2		40
+#define SLV_GPU_CFG		41
+#define SLV_USB_HS2		42
+#define SLV_BLSP_2		43
+#define SLV_PCNOC_SNOC		44
+
+/* SNOC fabric */
+#define MAS_QDSS_BAM		0
+#define MAS_BIMC_SNOC		1
+#define MAS_PCNOC_SNOC		2
+#define MAS_QDSS_ETR		3
+#define MAS_LPASS_PROC		4
+#define MAS_IPA		        5
+#define QDSS_INT		6
+#define SNOC_INT_0		7
+#define SNOC_INT_1		8
+#define SNOC_INT_2		9
+#define SLV_KPSS_AHB		10
+#define SLV_SNOC_BIMC		11
+#define SLV_IMEM		12
+#define SLV_SNOC_PCNOC		13
+#define SLV_QDSS_STM		14
+#define SLV_CATS_0		15
+#define SLV_CATS_1		16
+#define SLV_LPASS		17
+
+/* SNOC-MM fabric */
+#define MAS_JPEG		0
+#define MAS_OXILI		1
+#define MAS_MDP0		2
+#define MAS_MDP1		3
+#define MAS_VENUS_0		4
+#define MAS_VENUS_1		5
+#define MAS_VFE_0		6
+#define MAS_VFE_1		7
+#define MAS_CPP		        8
+#define MM_INT_0		9
+#define SLV_SMMNOC_BIMC		10
+
+#endif /* __DT_BINDINGS_INTERCONNECT_QCOM_MSM8976_H */
-- 
2.45.1


