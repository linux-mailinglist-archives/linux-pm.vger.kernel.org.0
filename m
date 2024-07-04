Return-Path: <linux-pm+bounces-10632-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAAC0927E1D
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 22:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 298E2B22543
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 20:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D599C2F23;
	Thu,  4 Jul 2024 20:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFgE3ZVi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11280142E76;
	Thu,  4 Jul 2024 20:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720123441; cv=none; b=C7oqAzREBojfnqMlEH4QS1TMJ35I/U5XQ2XIXAXdZWfKGMhHz78ydY4Exto9IOTWtC7jzC+1g4TXHuj/K/Dyg3+tQgDHqrIsyq3IxwshtRrR/xkW+Z2dD9Z3eVuAemUtUs/McagJXlzkmh9A/qo3RJzLlebJbPtFGoTOTMUJlyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720123441; c=relaxed/simple;
	bh=2xFzq8mUYds7R+xcnkCZCfCT6a63vMpqL5KnromD6N8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q9D37m5mSBTksOl/ytFfQx7JCHbNsEi3zEJK9p4dWeep9fyFmpOBfgzH9QwEcaA5FUV0jmku2oeX0rbuDOjKwGocO5cHRtGnYGMU7zl9yRSu5BtxHps4sksXVh3teWurwm2wKg9qwaYYq8XFqdSIGplVEK5ZwcTm1xYHVwcUTFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFgE3ZVi; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-58b966b4166so1192716a12.1;
        Thu, 04 Jul 2024 13:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720123438; x=1720728238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tnAp6cac5EwSHMmZg+RExidLib98jAbgbNsm5ebvFpc=;
        b=mFgE3ZVif7JmygdkZFU4ahIB0V9z1E03labzlU97oUxaauPnTZxi8kMwllKa5AjhRK
         50i0CXwafe7WkvIePjWilf7DKWQxxFwg1hQLiDEUGVBAuCIucGf/RAia6ET3N3M3WASX
         fOR+dMVjESt+xvztDbAbRaUVx2piMLSQG2olBwFySgAg8Q762B1dX8r1CZgTPoSV0Siz
         EYaEva2Ujhuzm0es1k4SoCndajLwzqWdHrdzxPmlE/cTVhqetefbaQoRb+XmUwdpAXGw
         nv2K43BkFQdz3HGR9vOeA/50992PEdEucKXxxHLEUmwCCQ4K6QfOvfwrn+c3EWNoAvji
         4TWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720123438; x=1720728238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tnAp6cac5EwSHMmZg+RExidLib98jAbgbNsm5ebvFpc=;
        b=c96pOvW844TOtfL8uJig2VJYkiJ4PW5fbxq6n4AeGFOMaZLXFIHDdrSV7ZLnnQ39Z2
         guGxEYndQA7mCjHbxzY7fO1iZQUz9w5KFYFDshqxuLmf9qWnwnhYtjfz8UA7Rrh1Vq8n
         TkD84E4Xbb66uGihBzbSVb3hbXSKJcOCfFJiBJS3QXZEDZ/4p14a8PNpls4lWq4Wz7eh
         dzUxv2pSLpe4QAgvrVHMS89vHeHeyDFjPLX6YlKqdCuORjbRg9bH6S3/giEvNbQPgIAu
         KtRWih0cPRXGM5BB5CePIlkSkn9uOmbkFLbd9OuOTIFWEOTSFmW3e36Rlw6xVX6iUisr
         XUCQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1GDCzsAybmlEK+A9kI2JNjAuItXfKp6JvtMsqRdSdo+AmgQ3datT/MqPfeUXC9mZnqrPlEIdBXkDz8nCM0HuPQfMh+nULl16dOHQoAbyHGQ6oActgawM/MMHvgypLDy8kHHOCtYIvFUaP4+sDPFw9Sv8rdYEJ6zRTo8aWPccJyp8ayJEijFgjVY8ws6b62a+EstQ64j5nrZBWwQOKk4WY4g==
X-Gm-Message-State: AOJu0YxuQr+nniuEZ+ArCORAFAA6XpcehN2q8tDykRsRufzrW9Vyt3Ru
	ePf2LN6EXMD9Bo6EKMnDX4gbq7KUcNoH+4SlL4G0Ulv20PPqbTRnxU585cm6
X-Google-Smtp-Source: AGHT+IGbV/EVDjHD4Ktw5avCEv1MAOIVyQ6A835rCoq7HJJXkOoY0auq48IxSE+sRBqH0UOHhf3aOw==
X-Received: by 2002:a05:6402:2742:b0:58d:842:6272 with SMTP id 4fb4d7f45d1cf-58e59c37858mr2083112a12.25.1720123437824;
        Thu, 04 Jul 2024 13:03:57 -0700 (PDT)
Received: from localhost.localdomain (byx56.neoplus.adsl.tpnet.pl. [83.30.43.56])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58b4a97b1f3sm4091149a12.18.2024.07.04.13.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 13:03:57 -0700 (PDT)
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
Subject: [PATCH v2 1/8] dt-bindings: interconnect: qcom: Add Qualcomm MSM8976 NoC
Date: Thu,  4 Jul 2024 22:02:24 +0200
Message-Id: <20240704200327.8583-2-a39.skl@gmail.com>
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

Add bindings for Qualcomm MSM8976 Network-On-Chip interconnect devices.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 .../bindings/interconnect/qcom,msm8976.yaml   | 63 ++++++++++++
 .../dt-bindings/interconnect/qcom,msm8976.h   | 97 +++++++++++++++++++
 2 files changed, 160 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,msm8976.yaml
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8976.h

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8976.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8976.yaml
new file mode 100644
index 000000000000..fcb50f60dce3
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8976.yaml
@@ -0,0 +1,63 @@
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
+  See also:
+  - dt-bindings/interconnect/qcom,msm8976.h
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
+        const: qcom,msm8976-snoc-mm
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
+          compatible = "qcom,msm8976-bimc";
+          reg = <0x00400000 0x62000>;
+
+          #interconnect-cells = <2>;
+      };
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
2.45.2


