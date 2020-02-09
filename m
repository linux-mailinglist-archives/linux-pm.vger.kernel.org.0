Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34FD9156C2C
	for <lists+linux-pm@lfdr.de>; Sun,  9 Feb 2020 19:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbgBISfE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 9 Feb 2020 13:35:04 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:59451 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727952AbgBISfE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 9 Feb 2020 13:35:04 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581273303; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=qJ+RgHmSGKWGGiT5X3DLCdCoaU8PC1L+QDt/KFBvZVk=; b=v6HFKfRM9Zo9WdQh5h+8UY53jdJNzE6N5HTFQ9PJNYrG0vR1ZLb+HX2Jy6J+1JIX8ovMkRCZ
 AKFkE0B3IrkBivhcRzDeXojBMIZOepnFAoCFASJlPzCzhn5OZ5bQA3GLab2qOV0ddugVMpmu
 SaJgNRzxP/c633KCeJmrQ/FpsiM=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e4050d3.7f5ebab6aa78-smtp-out-n01;
 Sun, 09 Feb 2020 18:34:59 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5F0E9C447AC; Sun,  9 Feb 2020 18:34:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BA7B2C43383;
        Sun,  9 Feb 2020 18:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BA7B2C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     robh+dt@kernel.org, georgi.djakov@linaro.org, evgreen@chromium.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mark.rutland@arm.com,
        daidavid1@codeaurora.org, saravanak@google.com, mka@chromium.org,
        linux-pm@vger.kernel.org, Odelu Kukatla <okukatla@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v3 6/6] arm64: dts: sdm845: Redefine interconnect provider DT nodes
Date:   Mon, 10 Feb 2020 00:04:11 +0530
Message-Id: <20200209183411.17195-7-sibis@codeaurora.org>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200209183411.17195-1-sibis@codeaurora.org>
References: <20200209183411.17195-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: David Dai <daidavid1@codeaurora.org>

Add the DT nodes for each of the Network-On-Chip interconnect
buses found on SDM845 based platform and redefine the rsc_hlos
child node as a bcm-voter device to better represent the hardware.

Signed-off-by: David Dai <daidavid1@codeaurora.org>
Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 65 +++++++++++++++++++++++++---
 1 file changed, 60 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index d42302b8889b6..ae7d6617d8b87 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1364,6 +1364,55 @@
 			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		mem_noc: interconnect@1380000 {
+			compatible = "qcom,sdm845-mem-noc";
+			reg = <0 0x01380000 0 0x27200>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		dc_noc: interconnect@14e0000 {
+			compatible = "qcom,sdm845-dc-noc";
+			reg = <0 0x014e0000 0 0x400>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		config_noc: interconnect@1500000 {
+			compatible = "qcom,sdm845-config-noc";
+			reg = <0 0x01500000 0 0x5080>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		system_noc: interconnect@1620000 {
+			compatible = "qcom,sdm845-system-noc";
+			reg = <0 0x01620000 0 0x18080>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		aggre1_noc: interconnect@16e0000 {
+			compatible = "qcom,sdm845-aggre1-noc";
+			reg = <0 0x016e0000 0 0x15080>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		aggre2_noc: interconnect@1700000 {
+			compatible = "qcom,sdm845-aggre2-noc";
+			reg = <0 0x01700000 0 0x1f300>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		mmss_noc: interconnect@1740000 {
+			compatible = "qcom,sdm845-mmss-noc";
+			reg = <0 0x01740000 0 0x1c100>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
 		ufs_mem_hc: ufshc@1d84000 {
 			compatible = "qcom,sdm845-ufshc", "qcom,ufshc",
 				     "jedec,ufs-2.0";
@@ -3098,6 +3147,13 @@
 			status = "disabled";
 		};
 
+		gladiator_noc: interconnect@17900000 {
+			compatible = "qcom,sdm845-gladiator-noc";
+			reg = <0 0x17900000 0 0xd080>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
 		watchdog@17980000 {
 			compatible = "qcom,apss-wdt-sdm845", "qcom,kpss-wdt";
 			reg = <0 0x17980000 0 0x1000>;
@@ -3127,6 +3183,10 @@
 					  <WAKE_TCS    3>,
 					  <CONTROL_TCS 1>;
 
+			apps_bcm_voter: bcm-voter {
+				compatible = "qcom,bcm-voter";
+			};
+
 			rpmhcc: clock-controller {
 				compatible = "qcom,sdm845-rpmh-clk";
 				#clock-cells = <1>;
@@ -3183,11 +3243,6 @@
 					};
 				};
 			};
-
-			rsc_hlos: interconnect {
-				compatible = "qcom,sdm845-rsc-hlos";
-				#interconnect-cells = <1>;
-			};
 		};
 
 		intc: interrupt-controller@17a00000 {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
