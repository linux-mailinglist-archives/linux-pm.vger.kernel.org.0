Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A973267D6
	for <lists+linux-pm@lfdr.de>; Fri, 26 Feb 2021 21:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhBZUHy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Feb 2021 15:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbhBZUHN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Feb 2021 15:07:13 -0500
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [IPv6:2001:4b7a:2000:18::165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A63C06178C;
        Fri, 26 Feb 2021 12:04:48 -0800 (PST)
Received: from localhost.localdomain (abab236.neoplus.adsl.tpnet.pl [83.6.165.236])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id 0B2A71FABA;
        Fri, 26 Feb 2021 21:04:37 +0100 (CET)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/41] arm64: dts: qcom: sdm630: Add MMCC node
Date:   Fri, 26 Feb 2021 21:03:33 +0100
Message-Id: <20210226200414.167762-4-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210226200414.167762-1-konrad.dybcio@somainline.org>
References: <20210226200414.167762-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add MultiMedia Clock Controller node to allow for accessing
and controlling Multimedia Subsystem clocks by their respective
users.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index 0dd838ef5d6e..e2cbe210048e 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -874,6 +874,34 @@ sdhc_1: sdhci@c0c4000 {
 			status = "disabled";
 		};
 
+		mmcc: clock-controller@c8c0000 {
+			compatible = "qcom,mmcc-sdm630";
+			reg = <0x0c8c0000 0x40000>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+			clock-names = "xo",
+					"sleep_clk",
+					"gpll0",
+					"gpll0_div",
+					"dsi0pll",
+					"dsi0pllbyte",
+					"dsi1pll",
+					"dsi1pllbyte",
+					"dp_link_2x_clk_divsel_five",
+					"dp_vco_divided_clk_src_mux";
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
+					<&sleep_clk>,
+					<&gcc GCC_MMSS_GPLL0_CLK>,
+					<&gcc GCC_MMSS_GPLL0_DIV_CLK>,
+					<0>,
+					<0>,
+					<0>,
+					<0>,
+					<0>,
+					<0>;
+		};
+
 		blsp1_dma: dma-controller@c144000 {
 			compatible = "qcom,bam-v1.7.0";
 			reg = <0x0c144000 0x1f000>;
-- 
2.30.1

