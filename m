Return-Path: <linux-pm+bounces-10845-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B51B92B545
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 12:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 923ABB24837
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 10:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98ADE156886;
	Tue,  9 Jul 2024 10:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mY2/W6m0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C283415624B;
	Tue,  9 Jul 2024 10:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720520949; cv=none; b=m2XJmAf9j/MhIxjm33Cbd0xHWVyy7wVU26Cg9/Rvq+MmzA2dhajJHQZ1d4UX0W1xCftLYAptZgqTQvgbn2roSodPBh5ogNPyBZdX65j48ii+ohylW+RaceI0UzcqVqHQMRyBnOvaDrpV+AVNo7JJiT0kR4dYb2IMLPWSL97aVU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720520949; c=relaxed/simple;
	bh=QSdGoGxgST5IbUcXXcxtRM29lfygDtK+9ZN8/SAELfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YF4h4hmrSXUsDQYYW8ZS+mYCdF2bop+cY96NdOmUp2V/q/7j+h8QDHEiCzBo1e/UKGvdezdZfBXFbyks/REeGMAAar/qMcqNdoCG7xvy8stF2JptTFwiiaD2+w9jZObs8fJTqsGZgXPC2yfNdvMrbwv3JDeOBhwC5pQ8wHlHku4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mY2/W6m0; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a77ec5d3b0dso291485666b.0;
        Tue, 09 Jul 2024 03:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720520945; x=1721125745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GW0tO3JCgHvVvoIbWBwE33L5GqOxknWhpxOsaqnzF40=;
        b=mY2/W6m0KhQYp3AM9ikcKg37Xj9ItFWrPiPbVzxKo3fq+qzv4fxuT1GAY1i6I1TYQw
         d6B6Hz/ViiKpS0Si8PCeje10eoFaB1tlm3nj6IcEHTR9ku73ahAMVrnvjnqqRbtjxo9O
         ed+TzZ6rFmDdfo4GlUr1rfLrO1D0lAQfONtM6UYoLCAF62gDFvkkM9TTxqWfQEuTPuY1
         n58VVa7+NcwxvzrYnKNEqEHgRWnPJQNIyvJLXKv0NzbZ/2ynj1CGRvW5MkhuWU1mo6o7
         FbujrehxSEsOsJKMMRe+iGPaFHBcCI/2PJAS3t0lTmlfa9DhicqsUk8qLbISmGi683qJ
         kdHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720520945; x=1721125745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GW0tO3JCgHvVvoIbWBwE33L5GqOxknWhpxOsaqnzF40=;
        b=dTKT3fTzuv/HBCAjgqIBao7T86omKeT26UrFILI0UMZ/PVFHwffqQXxK4zEOXtMArX
         nDq0/yiDii42wTDzey9sGdAr8NGbGXtY5E3CCAOc4N4N/dQP03h74BFU39toFi/pINuX
         wq8UPs7Jm2s3hVJNoe2OI4zrqD8C6yAfLRdOb5c/jYJTcXcRME69BZhypLDuvAfJkTz7
         DUh7lRyxuiI7zikDGkJS0GFcqVYfPzjPdgx2JyOiJpAHYaEJL9DhNzDCbBm6tjTpYGwv
         8F9SDxt9AMAA2xaCPsdSX1Yv8abQ7j2AJI2XHOhYnbRsPucBi4L8/nZ3DShVwYVvXrmZ
         jonw==
X-Forwarded-Encrypted: i=1; AJvYcCVlCSdYczQjTC06jWTqpQhmYTEyL+yCIs7Zh7cifUeLI7A3b0qA+6XUsqyCnZq7DbJingVh+yl5qQ8250+PPpHpPZKUW9Ci0AP0ldhA7GKVGrgvCeq1YWsIaW82gXDiqchA0Cao3BzueZ/SY7e8qs+PxwwEw0YoqrNm3R4R4FJ2rrUq27zTmLMLvAT5SP8bVRJ/etGuL2JYwQlTl1Jfwy90SA==
X-Gm-Message-State: AOJu0Yxf6Yo8Ip6byU+Th/nFjImmaw+UZksqNL2PL9lfs5h6kcFVBIZ1
	L8YXYCm717FEowQTRG9l2auJuIkLlAxNdFUtZDHot479qafYoo0YWN2oWA==
X-Google-Smtp-Source: AGHT+IHH0z8oVeE/hFya4d9qN2oDo8UiC7jVPknkC4w4LOUzz4NmGTTVlb6Jsiu2fE7Cupt70YTQ/A==
X-Received: by 2002:a17:907:7284:b0:a77:d1ea:ab36 with SMTP id a640c23a62f3a-a780b68a2d7mr172606866b.6.1720520945122;
        Tue, 09 Jul 2024 03:29:05 -0700 (PDT)
Received: from localhost.localdomain (bza125.neoplus.adsl.tpnet.pl. [83.30.46.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6bcc21sm66528166b.16.2024.07.09.03.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 03:29:04 -0700 (PDT)
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
Subject: [PATCH v3 3/9] dt-bindings: interconnect: qcom: Add Qualcomm MSM8937 NoC
Date: Tue,  9 Jul 2024 12:22:48 +0200
Message-ID: <20240709102728.15349-4-a39.skl@gmail.com>
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

Add bindings for Qualcomm MSM8937 Network-On-Chip interconnect devices.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 .../bindings/interconnect/qcom,msm8939.yaml   |  8 +-
 .../dt-bindings/interconnect/qcom,msm8937.h   | 93 +++++++++++++++++++
 2 files changed, 99 insertions(+), 2 deletions(-)
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8937.h

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8939.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8939.yaml
index 0641a3c992a5..d19e20247df8 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,msm8939.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8939.yaml
@@ -4,13 +4,13 @@
 $id: http://devicetree.org/schemas/interconnect/qcom,msm8939.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Qualcomm MSM8939/MSM8976 Network-On-Chip interconnect
+title: Qualcomm MSM8937/MSM8939/MSM8976 Network-On-Chip interconnect
 
 maintainers:
   - Konrad Dybcio <konradybcio@kernel.org>
 
 description:
-  The Qualcomm MSM8939/MSM8976 interconnect providers support
+  The Qualcomm MSM8937/MSM8939/MSM8976 interconnect providers support
   adjusting the bandwidth requirements between the various NoC fabrics.
 
 allOf:
@@ -19,6 +19,9 @@ allOf:
 properties:
   compatible:
     enum:
+      - qcom,msm8937-bimc
+      - qcom,msm8937-pcnoc
+      - qcom,msm8937-snoc
       - qcom,msm8939-bimc
       - qcom,msm8939-pcnoc
       - qcom,msm8939-snoc
@@ -43,6 +46,7 @@ patternProperties:
     properties:
       compatible:
         enum:
+          - qcom,msm8937-snoc-mm
           - qcom,msm8939-snoc-mm
           - qcom,msm8976-snoc-mm
 
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


