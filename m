Return-Path: <linux-pm+bounces-10843-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E0B92B53A
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 12:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66B3BB238A3
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 10:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528A115666D;
	Tue,  9 Jul 2024 10:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmHYBsp2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91181156654;
	Tue,  9 Jul 2024 10:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720520894; cv=none; b=B3bgwxmWvj/Pgx6HgGD4xTXojUHAfUoaQQz1rSh/oiMQlo+j3CLmqTd0+50CX4QSkMKKJgXFRICirokjmIs8vFVQ3Q1EO0UMr1FA2vXFbbrvjhBTl8cD4uT06PSc1T0USH52gLOGDCcf2Llwvib2gMHJpktziiHC0+Ojdt6yD+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720520894; c=relaxed/simple;
	bh=VtortwG8/mfCd+49Ti0kZb5VizhZ08IO9HyRd273TK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k1Dv6jUFMIY/phz9kopt56zXjtXdeHOPPvntEs2Is9OMk8rkE1YnMigs/Dx89gT5QlWRTS6i6aC31OM+MhBygMA/x1FK+mDDq8ZVuKRr71YeNDHhyoARYKXIENTRZnn+I3lV5gtD1p+TvnATCu9lgi2Mp2P6rHcVWcxx3GzD3Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZmHYBsp2; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a77ec5d3b0dso291354266b.0;
        Tue, 09 Jul 2024 03:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720520891; x=1721125691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ArOxbmFmrt2sRDI7Cxk+UFUx1dWaZL7csfOkC4x/+8=;
        b=ZmHYBsp2ytqO4oSx2PS3o/G81dCk6gmPvPkt84yXR5u8mIPQY94Q1XT2XmxUxYWpyh
         JDU+KwzY78DJsSZYVw58En3fqwTd3DepCDPC5BuQeADw2GyyJtswklK4pxlcLZbDRPfv
         ta0Gy4O4YSJvikCNfg3DeY/Igb+x510DDCYaoN8FnrgsKStF1KjBXVOSm9yJUthReLT0
         ddDD/oYxhaRBX4XS8rjv7b/EYgUGjY7UnJ+cV+njP7ncyxUjLnh+a6wudEJj4JiIaov6
         WtAP/dJ5NFjdpo5k3K19gp0DV96Go0Glk8J5EtMzlL/z3ksSF8WnbozDgz6Io8Vg1rgm
         +jtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720520891; x=1721125691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ArOxbmFmrt2sRDI7Cxk+UFUx1dWaZL7csfOkC4x/+8=;
        b=SGx7p9Au4FGs/krRCyRaCEPqY5pfJ4cIH1IU6uhmRq1JTLNyvejAYblZ+JFyIo8NGW
         hPghuRchTrYlhek+yWSL4KFc39RnvOKjFAwsF5gpRulDL3YyoDr2hEfdRqnBEmH0YzrT
         Uh68Py3jEZdx4/frgZ5sSN3xQceXV8Tr5Pp+shiPu8IQKoH7cBOev8wjJ9KtPLEV9Cr3
         a+2wVR+p8Fy6JRSgxMGXpP2L9ayA5MZowq2t/n41wZDaiQRcu5fG5sHfIehROfqPQraY
         17GDGKRVNeo4Z4AvlEwx43uSb7LQyQDbdEIiZnzUW3QQ+Ihxmm71UU+agrAquTcVGj4U
         CETQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+uH1o4RtScLAxfptZXzyw1AtzcQ0hbDH8x+ns1+diDbDocmRZqGosXhUGkyQfd498woRjGbFXQ7uwaQ7EpWkLjDhC/IC/OG5TzYbnYAwe2UKm4BUD7ooImogSgI3v2OmeW7K6YZuzKTu8JQUYopY2R73En5iv05j1RUcjrBLnwwxJS5I0RcMQqGnSlLqGTEMV7KwNwYlTnhGUf7pFG22yww==
X-Gm-Message-State: AOJu0YxQPLQct+cQs5HPhNyNM38Pdyey9mZDqc0bkKcwPxmLUUAbFIAi
	IbJu8GPpAqbcVwQ2ugULETwyDtuWVWZWWIbVw1tKZmK6Q+unQYU4nk4Aeg==
X-Google-Smtp-Source: AGHT+IFz3uGNoEBpmGHng82Qjl4BbpJz3GzrqII8zkZbE5F9ifWSgghv5HWnQIHKysFYMlNtyrC/7w==
X-Received: by 2002:a17:906:c090:b0:a77:de81:c7b0 with SMTP id a640c23a62f3a-a780b6b2ef8mr130215566b.22.1720520890375;
        Tue, 09 Jul 2024 03:28:10 -0700 (PDT)
Received: from localhost.localdomain (bza125.neoplus.adsl.tpnet.pl. [83.30.46.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6bcc21sm66528166b.16.2024.07.09.03.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 03:28:09 -0700 (PDT)
From: Adam Skladowski <a39.skl@gmail.com>
To: 
Cc: phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Adam Skladowski <a39.skl@gmail.com>,
	Georgi Djakov <djakov@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Vladimir Lypak <vladimir.lypak@gmail.com>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Rohit Agarwal <quic_rohiagar@quicinc.com>,
	Danila Tikhonov <danila@jiaxyga.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Barnabas Czeman <barnabas.czeman@mainlining.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH v3 1/9] dt-bindings: interconnect: qcom: Add Qualcomm MSM8976 NoC
Date: Tue,  9 Jul 2024 12:22:46 +0200
Message-ID: <20240709102728.15349-2-a39.skl@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709102728.15349-1-a39.skl@gmail.com>
References: <20240709102728.15349-1-a39.skl@gmail.com>
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
 .../bindings/interconnect/qcom,msm8939.yaml   | 15 ++-
 .../dt-bindings/interconnect/qcom,msm8976.h   | 97 +++++++++++++++++++
 2 files changed, 107 insertions(+), 5 deletions(-)
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8976.h

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8939.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8939.yaml
index fd15ab5014fb..0641a3c992a5 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,msm8939.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8939.yaml
@@ -4,14 +4,14 @@
 $id: http://devicetree.org/schemas/interconnect/qcom,msm8939.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Qualcomm MSM8939 Network-On-Chip interconnect
+title: Qualcomm MSM8939/MSM8976 Network-On-Chip interconnect
 
 maintainers:
   - Konrad Dybcio <konradybcio@kernel.org>
 
-description: |
-  The Qualcomm MSM8939 interconnect providers support adjusting the
-  bandwidth requirements between the various NoC fabrics.
+description:
+  The Qualcomm MSM8939/MSM8976 interconnect providers support
+  adjusting the bandwidth requirements between the various NoC fabrics.
 
 allOf:
   - $ref: qcom,rpm-common.yaml#
@@ -22,6 +22,9 @@ properties:
       - qcom,msm8939-bimc
       - qcom,msm8939-pcnoc
       - qcom,msm8939-snoc
+      - qcom,msm8976-bimc
+      - qcom,msm8976-pcnoc
+      - qcom,msm8976-snoc
 
   reg:
     maxItems: 1
@@ -39,7 +42,9 @@ patternProperties:
 
     properties:
       compatible:
-        const: qcom,msm8939-snoc-mm
+        enum:
+          - qcom,msm8939-snoc-mm
+          - qcom,msm8976-snoc-mm
 
     required:
       - compatible
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


