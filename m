Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AECF471A35
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 16:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730044AbfGWOXs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jul 2019 10:23:48 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44962 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388158AbfGWOXs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jul 2019 10:23:48 -0400
Received: by mail-lf1-f67.google.com with SMTP id r15so12500117lfm.11
        for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2019 07:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G8V2fUw4JSueLYaJKR4AvuBzJb29Ov5H2n/AJLCFXtE=;
        b=ghXkVtuJgFQzvZGDE8lW5blyq2wchoxY9ER1xGUSvlzTyjMqt2DxfYFtakSZSMNO06
         hGvShDZeFHm+CiGUzIMfzQwCgedyL+30aaqOvssM8pnLdzJXZJOLJOy2LTMyDhIM+es3
         m+WrwcIYT49zNUW/Is35pF3XTnXulvaTUdiR0+Ag9grt+b1DwMF8uFD7N4kJzHtEkutR
         d59sMzApZLiUXuZYxWSv+kLDwGlTXDMqC8jRmqESZgS3IdOyIuv2pAhli+daFhrvIkce
         OGzwsBNquTX8xQNKmLjDZ1EGmvXfDK4gow0VDh5LQVLqcilPrcYZsms5JDstVPedkMgP
         3+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G8V2fUw4JSueLYaJKR4AvuBzJb29Ov5H2n/AJLCFXtE=;
        b=Ja9ZU3HWh6J9stwKT3oeZU6Lu9q4Ymwx8I9NJUhpP7hmhC0WX7K63dni8cfo3hG0AR
         IinZ3hnhXiUSI0r713lyL8/kTKtdrwXHMHGuqtXmqQz2qETCF/G3QW01wCnyiKIm2VRH
         f6jAPd1KuhAQ0cbVdNThT6JNMDhwWLrEUOOhsmTnMTViBBAXqxQ/jJf3XWjos411c8GB
         UwHB5OcF7oLnpVm2s3Z9nKWqB12uO9pi125BCr19TkDtNa2mxM4NhENaZf7x+DKAzbRM
         5Sw4/fI5My94oafdxzrWY5FlbwH/qkkfveSmH18csdWlHVGgkWkplgY8q6S5n3wKbkoL
         2HOA==
X-Gm-Message-State: APjAAAWrmHXohVJWke3mA/vQO+aOOHdgO8UmEJeXD5z0yBY6ewa/4mhM
        Zb1aLXDuVCa86dFbl2u+CVNWJQ==
X-Google-Smtp-Source: APXvYqxGMpjvRQIuZdw8eHdcKWPLiPk4uGbi5jWdCMUFC9bKwmRkCi0SRCVrSuQPMPXUN+RAm/Rx8g==
X-Received: by 2002:ac2:5231:: with SMTP id i17mr35583893lfl.39.1563891825476;
        Tue, 23 Jul 2019 07:23:45 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id z17sm8048519ljc.37.2019.07.23.07.23.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Jul 2019 07:23:45 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     robh+dt@kernel.org, bjorn.andersson@linaro.org, agross@kernel.org,
        georgi.djakov@linaro.org
Cc:     vkoul@kernel.org, evgreen@chromium.org, daidavid1@codeaurora.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v5 1/5] dt-bindings: interconnect: Add Qualcomm QCS404 DT bindings
Date:   Tue, 23 Jul 2019 17:23:35 +0300
Message-Id: <20190723142339.27772-2-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190723142339.27772-1-georgi.djakov@linaro.org>
References: <20190723142339.27772-1-georgi.djakov@linaro.org>
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

v5:
- Make reg and clocks DT properties required.
- Remove the _clk suffix from clock names.

v4:
- Add the DT header into this patch.
- Pick Bjorn's r-b.

v3:
- Add a reg property and move the interconnect nodes under the "soc" node.

v2:
- No changes.

 .../bindings/interconnect/qcom,qcs404.txt     | 45 ++++++++++
 .../dt-bindings/interconnect/qcom,qcs404.h    | 88 +++++++++++++++++++
 2 files changed, 133 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
 create mode 100644 include/dt-bindings/interconnect/qcom,qcs404.h

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt b/Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
new file mode 100644
index 000000000000..c07d89812b73
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
@@ -0,0 +1,45 @@
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
+reg : specifies the physical base address and size of registers
+clocks : list of phandles and specifiers to all interconnect bus clocks
+clock-names : clock names should include both "bus" and "bus_a"
+
+Example:
+
+soc {
+	...
+	bimc: interconnect@400000 {
+		reg = <0x00400000 0x80000>;
+		compatible = "qcom,qcs404-bimc";
+		#interconnect-cells = <1>;
+		clock-names = "bus", "bus_a";
+		clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
+			<&rpmcc RPM_SMD_BIMC_A_CLK>;
+	};
+
+	pnoc: interconnect@500000 {
+		reg = <0x00500000 0x15080>;
+		compatible = "qcom,qcs404-pcnoc";
+		#interconnect-cells = <1>;
+		clock-names = "bus", "bus_a";
+		clocks = <&rpmcc RPM_SMD_PNOC_CLK>,
+			<&rpmcc RPM_SMD_PNOC_A_CLK>;
+	};
+
+	snoc: interconnect@580000 {
+		reg = <0x00580000 0x23080>;
+		compatible = "qcom,qcs404-snoc";
+		#interconnect-cells = <1>;
+		clock-names = "bus", "bus_a";
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
