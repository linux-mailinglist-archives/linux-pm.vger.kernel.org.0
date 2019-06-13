Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDD44396A
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2019 17:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732317AbfFMPNr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Jun 2019 11:13:47 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44794 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388387AbfFMPNh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jun 2019 11:13:37 -0400
Received: by mail-lj1-f195.google.com with SMTP id k18so18891832ljc.11
        for <linux-pm@vger.kernel.org>; Thu, 13 Jun 2019 08:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3sc3DlT2aHgDUBPzbdNbG/lF95Cth+rPWMq4ZM26quY=;
        b=eEpipQxFUi5JXVuC+9r5W5Dtcce8K9zV/fB94gGq3bd6eQw119DSEiWZNKIRc9Ggbg
         9YkACR96hRoi/t4EMMWKn59rKmzvTqlvEGtS/hoKOX4346Z8QFShpMQOGKLF15Qym6vi
         RFbjxmk+c7eGQa9IcwTKduCmZe3IZ0+aZ+Y0ucR3sVrEoZFQEHBsVHN0wSo34QRnnFJz
         XPar90/oJgWgoN3g3Bspp5lDSu3Sojz64UcSqw+lp8UtjB7cgP2b/Su4IlxjwHfzCDGz
         S4ndeRvLm8bl9KXUvsw6o/S0aqWezgDQzusmXWAbrmR6lWHEQzLMayKxfh/zMR2HyjuP
         +EtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3sc3DlT2aHgDUBPzbdNbG/lF95Cth+rPWMq4ZM26quY=;
        b=ErGkbPvunprCcC0kHvPD9T3ieRgTb/XSyaE7tzTzuvQgnllukubVWYBkWKvl/GaYwI
         0Q50Qb3NbfT9jrrJvLky67mxADoRkGd/kme9ztFw9N5tg3nbOxTye9hscGJg5lDVvh/d
         ZvkFeDDk9s+qmRLLyddlhiQFpbSlFLXpQeOmX41cc42VddMayxaRud9S6z674Q53E3Dq
         M0bnGtAOxq5fFF/WeDnVLLgr4rYVSRgV72loYdNYneHRj8kEFORlGPkMLx+3HksZlfUH
         HO/ca9Mmcm8WcgVpOs7x/UC9qzvckCweLNE/vJNyLA6BR4jGDmtfCCZHjOBFEGsonmm+
         m26Q==
X-Gm-Message-State: APjAAAWfUCMJlhIZtXXHFUqKZ5eMLf0Xwj1cpKdePPQktrpssj+J4rhL
        HFBnG+Q2Is00oKsDPQ46xY+tNg==
X-Google-Smtp-Source: APXvYqzusDCujmFK4AzstrHu0895D+ENcdhXdXlWYYdL7SR9aGRx+EF4RNcKjHie1X+EbB9DngrWRQ==
X-Received: by 2002:a2e:5b5b:: with SMTP id p88mr38323127ljb.192.1560438815349;
        Thu, 13 Jun 2019 08:13:35 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id k4sm42923ljj.41.2019.06.13.08.13.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Jun 2019 08:13:34 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     robh+dt@kernel.org, bjorn.andersson@linaro.org, agross@kernel.org,
        georgi.djakov@linaro.org
Cc:     vkoul@kernel.org, evgreen@chromium.org, daidavid1@codeaurora.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v4 5/5] arm64: dts: qcs404: Add interconnect provider DT nodes
Date:   Thu, 13 Jun 2019 18:13:23 +0300
Message-Id: <20190613151323.10850-6-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190613151323.10850-1-georgi.djakov@linaro.org>
References: <20190613151323.10850-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the DT nodes for the network-on-chip interconnect buses found
on qcs404-based platforms.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---

v4:
- Insert the NoC DT nodes after rng@ to keep the nodes sorted by address.
- Pick Bjorn's r-b.

v3:
- Update according to the new binding: add reg property and moved under the
  "soc" node.

 arch/arm64/boot/dts/qcom/qcs404.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index ffedf9640af7..da1dbf515bd9 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2018, Linaro Limited
 
+#include <dt-bindings/interconnect/qcom,qcs404.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,gcc-qcs404.h>
 #include <dt-bindings/clock/qcom,rpmcc.h>
@@ -266,6 +267,33 @@
 			clock-names = "core";
 		};
 
+		bimc: interconnect@400000 {
+			reg = <0x00400000 0x80000>;
+			compatible = "qcom,qcs404-bimc";
+			#interconnect-cells = <1>;
+			clock-names = "bus_clk", "bus_a_clk";
+			clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
+				<&rpmcc RPM_SMD_BIMC_A_CLK>;
+		};
+
+		pcnoc: interconnect@500000 {
+			reg = <0x00500000 0x15080>;
+			compatible = "qcom,qcs404-pcnoc";
+			#interconnect-cells = <1>;
+			clock-names = "bus_clk", "bus_a_clk";
+			clocks = <&rpmcc RPM_SMD_PNOC_CLK>,
+				<&rpmcc RPM_SMD_PNOC_A_CLK>;
+		};
+
+		snoc: interconnect@580000 {
+			reg = <0x00580000 0x23080>;
+			compatible = "qcom,qcs404-snoc";
+			#interconnect-cells = <1>;
+			clock-names = "bus_clk", "bus_a_clk";
+			clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
+				<&rpmcc RPM_SMD_SNOC_A_CLK>;
+		};
+
 		tlmm: pinctrl@1000000 {
 			compatible = "qcom,qcs404-pinctrl";
 			reg = <0x01000000 0x200000>,
