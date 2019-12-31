Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04C2912D73C
	for <lists+linux-pm@lfdr.de>; Tue, 31 Dec 2019 10:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfLaJAD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Dec 2019 04:00:03 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:26606 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726619AbfLaJAD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Dec 2019 04:00:03 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1577782803; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=mBwAPIc5W10c/SxyhAEscSWTZOm3fmLRnox3jUftHDU=; b=GpIX6ZxzK69Ayw1baesS7zG+hd3ENaG0Mh7RHrqrJac3AEvOvAk23VlvT2caAN5mGTbsmrFh
 7O1sQo2CwHlSW+4ctlbJum4o+miu30WRk6gsJx8VgAL9BjDJpfBiCE+YwcrI3ulb0GWc2o12
 iqHumZp4LLqxBP6LnusKnvybggw=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e0b0e0c.7f34277eff48-smtp-out-n02;
 Tue, 31 Dec 2019 08:59:56 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 30CE6C433CB; Tue, 31 Dec 2019 08:59:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from okukatla1-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okukatla)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 40819C433A2;
        Tue, 31 Dec 2019 08:59:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 40819C433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=okukatla@codeaurora.org
From:   Odelu Kukatla <okukatla@codeaurora.org>
To:     georgi.djakov@linaro.org, daidavid1@codeaurora.org,
        bjorn.andersson@linaro.org, evgreen@google.com,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     sboyd@kernel.org, ilina@codeaurora.org, seansw@qti.qualcomm.com,
        elder@linaro.org, linux-pm@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org,
        Odelu Kukatla <okukatla@codeaurora.org>
Subject: [V2, 3/3] arm64: dts: sc7180: Add interconnect provider DT nodes
Date:   Tue, 31 Dec 2019 14:28:57 +0530
Message-Id: <1577782737-32068-4-git-send-email-okukatla@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1577782737-32068-1-git-send-email-okukatla@codeaurora.org>
References: <1577782737-32068-1-git-send-email-okukatla@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the DT nodes for the network-on-chip interconnect buses found
on sc7180-based platforms.
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 96 ++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 3676bfd..077b1e5 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/clock/qcom,gcc-sc7180.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interconnect/qcom,sc7180.h>
 #include <dt-bindings/phy/phy-qcom-qusb2.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 
@@ -1286,6 +1287,10 @@
 				clock-names = "xo";
 				#clock-cells = <1>;
 			};
+
+			apps_bcm_voter: bcm_voter {
+				compatible = "qcom,sc7180-bcm-voter";
+			};
 		};
 
 		cpufreq_hw: cpufreq@18323000 {
@@ -1298,6 +1303,97 @@
 
 			#freq-domain-cells = <1>;
 		};
+
+		config_noc: interconnect@1500000 {
+			compatible = "qcom,sc7180-config-noc";
+			reg = <0 0x01500000 0 0x28000>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		system_noc: interconnect@1620000 {
+			compatible = "qcom,sc7180-system-noc";
+			reg = <0 0x01620000 0 0x17080>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		mc_virt: interconnect@1630000 {
+			compatible = "qcom,sc7180-mc-virt";
+			reg = <0 0x01630000 0 0x4000>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		qup_virt: interconnect@1650000 {
+			compatible = "qcom,sc7180-qup-virt";
+			reg = <0 0x01650000 0 0x4000>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		aggre1_noc: interconnect@16e0000 {
+			compatible = "qcom,sc7180-aggre1-noc";
+			reg = <0 0x016e0000 0 0x15080>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		aggre2_noc: interconnect@1700000 {
+			compatible = "qcom,sc7180-aggre2-noc";
+			reg = <0 0x01700000 0 0x1f880>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		compute_noc: interconnect@170e000 {
+			compatible = "qcom,sc7180-compute-noc";
+			reg = <0 0x0170e000 0 0x11880>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		mmss_noc: interconnect@1740000 {
+			compatible = "qcom,sc7180-mmss-noc";
+			reg = <0 0x01740000 0 0x1c100>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		ipa_virt: interconnect@1e00000 {
+			compatible = "qcom,sc7180-ipa-virt";
+			reg = <0 0x01e00000 0 0x4000>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		dc_noc: interconnect@9160000 {
+			compatible = "qcom,sc7180-dc-noc";
+			reg = <0 0x09160000 0 0x03200>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		gem_noc: interconnect@9680000 {
+			compatible = "qcom,sc7180-gem-noc";
+			reg = <0 0x09680000 0 0x3e200>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		npu_noc: interconnect@9990000 {
+			compatible = "qcom,sc7180-npu-noc";
+			reg = <0 0x09990000 0 0x1600>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		camnoc_virt: interconnect@ac00000 {
+			compatible = "qcom,sc7180-camnoc-virt";
+			reg = <0 0x0ac00000 0 0x4000>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
 	};
 
 	thermal-zones {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
