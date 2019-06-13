Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF8F14397B
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2019 17:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732315AbfFMPOD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Jun 2019 11:14:03 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33080 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387857AbfFMPNa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jun 2019 11:13:30 -0400
Received: by mail-lf1-f66.google.com with SMTP id y17so15398385lfe.0
        for <linux-pm@vger.kernel.org>; Thu, 13 Jun 2019 08:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bIEZcf0Ho0UOoweei7KFZaJ/8IH+YTouGOqiV8oBRIo=;
        b=Ui+3fA/bx/UdvFs2gdfrNqdoGx1Q8l8fj8olz2nCtNX32T8KWR7VSrsF4JZfuEhcQj
         bF0djxhCV0U+Lf+xnbSowZHczPalRNj7+hYu5Jt1ZWfK23Cpi31fEetHKvxDp5MEAOK3
         0hOnseYcwyeVo/2HiJZPKlxBb0sCZNogMA4+/fvLTR5cgmHd/qQoR8JP+r4wA1oyTj+s
         GKe2WTzCE/ASZqLG7L3M0VuYghCn47WXSTJ/Tj8aqkESme5+cOvIE6m2ut0D7Bv5WDTv
         +odDtPuxab1z9B/XLb9ZxRqFvMCJdYF1bc0pQcfpSx53aebaL5Sa99nQw4gdaP8YQPG/
         58Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bIEZcf0Ho0UOoweei7KFZaJ/8IH+YTouGOqiV8oBRIo=;
        b=i065WIVK0cXBWx8awLPOaPDNz5t7wmfWTfWncM50WFzjDPlqmqUbcGDIaKCRmpzytn
         4gSQMHW/vAFbhtvqQ/DIV0wDzUq7ZfzGwRYZVQyJ9aaJbS/GWqgVMTK01rnnX4SijsC9
         uO8Ef4/82jsSMhQuWektd8l+DRrmnFBQKAGijL16KJSW5jfYDaww9D76A0VbWbVZEn2A
         SdBqtF/g/NAMDIA8KzJgikTZefWYwL+ieIB9aGqfthMscmP5q5JwO+lBCZRIZi19uUwD
         MiKF9QN2HanfF5veExlVpeSM/u0Z5AezNGClIpzxHdJSNxI6f6BrPz4Ct+FJpWrmYVO+
         3iYA==
X-Gm-Message-State: APjAAAVEACWkkEud5tk+ailx3WFvVbz9sdKmRGFbVmq/oEDM9z/1W+1N
        EibYRT1ByGHNlB+iSl6FQryXXQ==
X-Google-Smtp-Source: APXvYqx136FI5AkWpCWJ5s/BW8sJEkcmlnrArz7vKuHGr+Y2cgLPBh4sFBnR42ZOm9fWet/VswWBvw==
X-Received: by 2002:ac2:5a5e:: with SMTP id r30mr2607504lfn.12.1560438807948;
        Thu, 13 Jun 2019 08:13:27 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id k4sm42923ljj.41.2019.06.13.08.13.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Jun 2019 08:13:27 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     robh+dt@kernel.org, bjorn.andersson@linaro.org, agross@kernel.org,
        georgi.djakov@linaro.org
Cc:     vkoul@kernel.org, evgreen@chromium.org, daidavid1@codeaurora.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v4 1/5] dt-bindings: interconnect: Add Qualcomm QCS404 DT bindings
Date:   Thu, 13 Jun 2019 18:13:19 +0300
Message-Id: <20190613151323.10850-2-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190613151323.10850-1-georgi.djakov@linaro.org>
References: <20190613151323.10850-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Qualcomm QCS404 platform has several buses that could be controlled
and tuned according to the bandwidth demand.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---

v4:
- Add the DT header into this patch.
- Pick Bjorn's r-b.

v3:
- Add a reg property and move the interconnect nodes under the "soc" node.

v2:
- No changes.

 .../bindings/interconnect/qcom,qcs404.txt     | 46 ++++++++++
 .../dt-bindings/interconnect/qcom,qcs404.h    | 88 +++++++++++++++++++
 2 files changed, 134 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
 create mode 100644 include/dt-bindings/interconnect/qcom,qcs404.h

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt b/Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
new file mode 100644
index 000000000000..14a827268dda
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
@@ -0,0 +1,46 @@
+Qualcomm QCS404 Network-On-Chip interconnect driver binding
+-----------------------------------------------------------
+
+Required properties :
+- compatible : shall contain only one of the following:
+			"qcom,qcs404-bimc"
+			"qcom,qcs404-pcnoc"
+			"qcom,qcs404-snoc"
+- #interconnect-cells : should contain 1
+
+Optional properties :
+reg : specifies the physical base address and size of registers
+clocks : list of phandles and specifiers to all interconnect bus clocks
+clock-names : clock names should include both "bus_clk" and "bus_a_clk"
+
+Example:
+
+soc {
+	...
+	bimc: interconnect@400000 {
+		reg = <0x00400000 0x80000>;
+		compatible = "qcom,qcs404-bimc";
+		#interconnect-cells = <1>;
+		clock-names = "bus_clk", "bus_a_clk";
+		clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
+			<&rpmcc RPM_SMD_BIMC_A_CLK>;
+	};
+
+	pnoc: interconnect@500000 {
+		reg = <0x00500000 0x15080>;
+		compatible = "qcom,qcs404-pcnoc";
+		#interconnect-cells = <1>;
+		clock-names = "bus_clk", "bus_a_clk";
+		clocks = <&rpmcc RPM_SMD_PNOC_CLK>,
+			<&rpmcc RPM_SMD_PNOC_A_CLK>;
+	};
+
+	snoc: interconnect@580000 {
+		reg = <0x00580000 0x23080>;
+		compatible = "qcom,qcs404-snoc";
+		#interconnect-cells = <1>;
+		clock-names = "bus_clk", "bus_a_clk";
+		clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
+			<&rpmcc RPM_SMD_SNOC_A_CLK>;
+	};
+};
diff --git a/include/dt-bindings/interconnect/qcom,qcs404.h b/include/dt-bindings/interconnect/qcom,qcs404.h
new file mode 100644
index 000000000000..960f6e39c5f2
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,qcs404.h
@@ -0,0 +1,88 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Qualcomm interconnect IDs
+ *
+ * Copyright (c) 2019, Linaro Ltd.
+ * Author: Georgi Djakov <georgi.djakov@linaro.org>
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_QCS404_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_QCS404_H
+
+#define MASTER_AMPSS_M0			0
+#define MASTER_OXILI			1
+#define MASTER_MDP_PORT0		2
+#define MASTER_SNOC_BIMC_1		3
+#define MASTER_TCU_0			4
+#define SLAVE_EBI_CH0			5
+#define SLAVE_BIMC_SNOC			6
+
+#define MASTER_SPDM			0
+#define MASTER_BLSP_1			1
+#define MASTER_BLSP_2			2
+#define MASTER_XI_USB_HS1		3
+#define MASTER_CRYPT0			4
+#define MASTER_SDCC_1			5
+#define MASTER_SDCC_2			6
+#define MASTER_SNOC_PCNOC		7
+#define MASTER_QPIC			8
+#define PCNOC_INT_0			9
+#define PCNOC_INT_2			10
+#define PCNOC_INT_3			11
+#define PCNOC_S_0			12
+#define PCNOC_S_1			13
+#define PCNOC_S_2			14
+#define PCNOC_S_3			15
+#define PCNOC_S_4			16
+#define PCNOC_S_6			17
+#define PCNOC_S_7			18
+#define PCNOC_S_8			19
+#define PCNOC_S_9			20
+#define PCNOC_S_10			21
+#define PCNOC_S_11			22
+#define SLAVE_SPDM			23
+#define SLAVE_PDM			24
+#define SLAVE_PRNG			25
+#define SLAVE_TCSR			26
+#define SLAVE_SNOC_CFG			27
+#define SLAVE_MESSAGE_RAM		28
+#define SLAVE_DISP_SS_CFG		29
+#define SLAVE_GPU_CFG			30
+#define SLAVE_BLSP_1			31
+#define SLAVE_BLSP_2			32
+#define SLAVE_TLMM_NORTH		33
+#define SLAVE_PCIE			34
+#define SLAVE_ETHERNET			35
+#define SLAVE_TLMM_EAST			36
+#define SLAVE_TCU			37
+#define SLAVE_PMIC_ARB			38
+#define SLAVE_SDCC_1			39
+#define SLAVE_SDCC_2			40
+#define SLAVE_TLMM_SOUTH		41
+#define SLAVE_USB_HS			42
+#define SLAVE_USB3			43
+#define SLAVE_CRYPTO_0_CFG		44
+#define SLAVE_PCNOC_SNOC		45
+
+#define MASTER_QDSS_BAM			0
+#define MASTER_BIMC_SNOC		1
+#define MASTER_PCNOC_SNOC		2
+#define MASTER_QDSS_ETR			3
+#define MASTER_EMAC			4
+#define MASTER_PCIE			5
+#define MASTER_USB3			6
+#define QDSS_INT			7
+#define SNOC_INT_0			8
+#define SNOC_INT_1			9
+#define SNOC_INT_2			10
+#define SLAVE_KPSS_AHB			11
+#define SLAVE_WCSS			12
+#define SLAVE_SNOC_BIMC_1		13
+#define SLAVE_IMEM			14
+#define SLAVE_SNOC_PCNOC		15
+#define SLAVE_QDSS_STM			16
+#define SLAVE_CATS_0			17
+#define SLAVE_CATS_1			18
+#define SLAVE_LPASS			19
+
+#endif
