Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C100140725
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2020 10:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgAQJ64 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jan 2020 04:58:56 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45814 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729031AbgAQJ6f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jan 2020 04:58:35 -0500
Received: by mail-wr1-f66.google.com with SMTP id j42so22014300wrj.12
        for <linux-pm@vger.kernel.org>; Fri, 17 Jan 2020 01:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O5CKnxBPyh6lWIgILUFSDA2osEdYf21WQdUAZp/aFck=;
        b=wakchtKvileTvklgLRyoie2dWce48tltV9J/dKopx+siHZapWmai5o0B8zLYMmsAib
         5URaUe9LYTguzzkYvRCh5Js9/0T5sXtAyAsXJAaZr8N2HgAJi/Lwjcsz0kBAZZ9RwTJy
         Tfca0BJ3EYO2bpK9oVXXxPwDo6Ij35siyu4ZbEBN/xBYWR190acqpBRY3rcGEVh/JuTt
         bwU6sDzVWecQAlYXdoADAmaQh7QLdqrwQOF9vlxfZD+wj0wnQYpLGw62Jw582ixnhw2e
         /kYd2co38tDyZeJlLy4zIPyunwf47ADVXS4NH0KqDj2VaLLc75WokYSKyj8/BSnYt0bI
         zvQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O5CKnxBPyh6lWIgILUFSDA2osEdYf21WQdUAZp/aFck=;
        b=GrcJeckoOOcL5gkX+Bivy9r+4A/uIMsoXehEgARN/At/eVf4MTXU5kTMN8D4EkT3p6
         /1xmb52VMtYzmO0bQ5wWt9TdyoVt6X4LYWnfOw7U6h5/gdkO+tHJXSsykBvA2omhse6J
         cfajofG3IF5sIiKJcmsq3VKMf29xfzF/5LVP5pXljHqGqyh/TfDRlWS4tXhWV6uPQQBC
         pE08aYC39DMK8opazvR8Jyali8A9G03k/s/I2XhHoVHVbtfcSwiVZHGJO2pf5CV0YRca
         AdeVG9xkMgVQMM1vnMRp2fP7aNvi47IRoY/6V0JkaKsCyTwaVUCRs9viq6uN/RKn7QiV
         HM0w==
X-Gm-Message-State: APjAAAWNELtE1Y8Mo92xYI/UuYqzf/LuJMS53so1Dur7NZA3/fgYyKz5
        K0ZRiOzfaQqRNA8oaD1KGdvmgA==
X-Google-Smtp-Source: APXvYqyXyKpF2sbfFQHjqIqFuszkga3DBasWdf2GABxEJFPnnhZdT9t4pDOpBopNZr2igEQHsvspIw==
X-Received: by 2002:adf:f28c:: with SMTP id k12mr2227372wro.360.1579255113012;
        Fri, 17 Jan 2020 01:58:33 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id r62sm9967007wma.32.2020.01.17.01.58.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Jan 2020 01:58:32 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 11/12] dt-bindings: interconnect: Add Qualcomm MSM8916 DT bindings
Date:   Fri, 17 Jan 2020 11:58:15 +0200
Message-Id: <20200117095816.23575-12-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117095816.23575-1-georgi.djakov@linaro.org>
References: <20200117095816.23575-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Qualcomm MSM8916 platform has several bus fabrics that could be
controlled and tuned dynamically according to the bandwidth demand.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 .../bindings/interconnect/qcom,msm8916.yaml   |  77 ++++++++++++++
 .../dt-bindings/interconnect/qcom,msm8916.h   | 100 ++++++++++++++++++
 2 files changed, 177 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,msm8916.yaml
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8916.h

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8916.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8916.yaml
new file mode 100644
index 000000000000..4107e60cab12
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8916.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,msm8916.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm MSM8916 Network-On-Chip interconnect
+
+maintainers:
+  - Georgi Djakov <georgi.djakov@linaro.org>
+
+description: |
+   The Qualcomm MSM8916 interconnect providers support adjusting the
+   bandwidth requirements between the various NoC fabrics.
+
+properties:
+  compatible:
+    enum:
+      - qcom,msm8916-bimc
+      - qcom,msm8916-pcnoc
+      - qcom,msm8916-snoc
+
+  reg:
+    maxItems: 1
+
+  '#interconnect-cells':
+    const: 1
+
+  clock-names:
+    items:
+      - const: bus
+      - const: bus_a
+
+  clocks:
+    items:
+      - description: Bus Clock
+      - description: Bus A Clock
+
+required:
+  - compatible
+  - reg
+  - '#interconnect-cells'
+  - clock-names
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+      #include <dt-bindings/clock/qcom,rpmcc.h>
+
+      bimc: interconnect@400000 {
+              compatible = "qcom,msm8916-bimc";
+              reg = <0x00400000 0x62000>;
+              #interconnect-cells = <1>;
+              clock-names = "bus", "bus_a";
+              clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
+                       <&rpmcc RPM_SMD_BIMC_A_CLK>;
+      };
+
+      pcnoc: interconnect@500000 {
+              compatible = "qcom,msm8916-pcnoc";
+              reg = <0x00500000 0x11000>;
+              #interconnect-cells = <1>;
+              clock-names = "bus", "bus_a";
+              clocks = <&rpmcc RPM_SMD_PCNOC_CLK>,
+                       <&rpmcc RPM_SMD_PCNOC_A_CLK>;
+      };
+
+      snoc: interconnect@580000 {
+              compatible = "qcom,msm8916-snoc";
+              reg = <0x00580000 0x14000>;
+              #interconnect-cells = <1>;
+              clock-names = "bus", "bus_a";
+              clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
+                       <&rpmcc RPM_SMD_SNOC_A_CLK>;
+      };
diff --git a/include/dt-bindings/interconnect/qcom,msm8916.h b/include/dt-bindings/interconnect/qcom,msm8916.h
new file mode 100644
index 000000000000..359a75feb198
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,msm8916.h
@@ -0,0 +1,100 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Qualcomm interconnect IDs
+ *
+ * Copyright (c) 2019, Linaro Ltd.
+ * Author: Georgi Djakov <georgi.djakov@linaro.org>
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_MSM8916_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_MSM8916_H
+
+#define BIMC_SNOC_SLV			0
+#define MASTER_JPEG			1
+#define MASTER_MDP_PORT0		2
+#define MASTER_QDSS_BAM			3
+#define MASTER_QDSS_ETR			4
+#define MASTER_SNOC_CFG			5
+#define MASTER_VFE			6
+#define MASTER_VIDEO_P0			7
+#define SNOC_MM_INT_0			8
+#define SNOC_MM_INT_1			9
+#define SNOC_MM_INT_2			10
+#define SNOC_MM_INT_BIMC		11
+#define PCNOC_SNOC_SLV			12
+#define SLAVE_APSS			13
+#define SLAVE_CATS_128			14
+#define SLAVE_OCMEM_64			15
+#define SLAVE_IMEM			16
+#define SLAVE_QDSS_STM			17
+#define SLAVE_SRVC_SNOC			18
+#define SNOC_BIMC_0_MAS			19
+#define SNOC_BIMC_1_MAS			20
+#define SNOC_INT_0			21
+#define SNOC_INT_1			22
+#define SNOC_INT_BIMC			23
+#define SNOC_PCNOC_MAS			24
+#define SNOC_QDSS_INT			25
+
+#define BIMC_SNOC_MAS			0
+#define MASTER_AMPSS_M0			1
+#define MASTER_GRAPHICS_3D		2
+#define MASTER_TCU0			3
+#define MASTER_TCU1			4
+#define SLAVE_AMPSS_L2			5
+#define SLAVE_EBI_CH0			6
+#define SNOC_BIMC_0_SLV			7
+#define SNOC_BIMC_1_SLV			8
+
+#define MASTER_BLSP_1			0
+#define MASTER_DEHR			1
+#define MASTER_LPASS			2
+#define MASTER_CRYPTO_CORE0		3
+#define MASTER_SDCC_1			4
+#define MASTER_SDCC_2			5
+#define MASTER_SPDM			6
+#define MASTER_USB_HS			7
+#define PCNOC_INT_0			8
+#define PCNOC_INT_1			9
+#define PCNOC_MAS_0			10
+#define PCNOC_MAS_1			11
+#define PCNOC_SLV_0			12
+#define PCNOC_SLV_1			13
+#define PCNOC_SLV_2			14
+#define PCNOC_SLV_3			15
+#define PCNOC_SLV_4			16
+#define PCNOC_SLV_8			17
+#define PCNOC_SLV_9			18
+#define PCNOC_SNOC_MAS			19
+#define SLAVE_BIMC_CFG			20
+#define SLAVE_BLSP_1			21
+#define SLAVE_BOOT_ROM			22
+#define SLAVE_CAMERA_CFG		23
+#define SLAVE_CLK_CTL			24
+#define SLAVE_CRYPTO_0_CFG		25
+#define SLAVE_DEHR_CFG			26
+#define SLAVE_DISPLAY_CFG		27
+#define SLAVE_GRAPHICS_3D_CFG		28
+#define SLAVE_IMEM_CFG			29
+#define SLAVE_LPASS			30
+#define SLAVE_MPM			31
+#define SLAVE_MSG_RAM			32
+#define SLAVE_MSS			33
+#define SLAVE_PDM			34
+#define SLAVE_PMIC_ARB			35
+#define SLAVE_PCNOC_CFG			36
+#define SLAVE_PRNG			37
+#define SLAVE_QDSS_CFG			38
+#define SLAVE_RBCPR_CFG			39
+#define SLAVE_SDCC_1			40
+#define SLAVE_SDCC_2			41
+#define SLAVE_SECURITY			42
+#define SLAVE_SNOC_CFG			43
+#define SLAVE_SPDM			44
+#define SLAVE_TCSR			45
+#define SLAVE_TLMM			46
+#define SLAVE_USB_HS			47
+#define SLAVE_VENUS_CFG			48
+#define SNOC_PCNOC_SLV			49
+
+#endif
