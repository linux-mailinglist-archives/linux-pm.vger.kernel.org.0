Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE6B11FE5D
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2019 07:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfLPGET (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Dec 2019 01:04:19 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:37669 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726436AbfLPGET (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Dec 2019 01:04:19 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576476258; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=WfYVZRY7NUJGi0SdNulsMWXe+awHuELnsj9TepITErQ=; b=uhmQ9C4IQj6Yt68iFfEflwejGJfI8BYSEUIvr1PADO1vcB0hUXr3l6CBwjUAXr4TtUnxDpkp
 8OeEa3DrVMUnq/oWNjYrEYh9f96bEXZOyIxdwACN3A2LWVSo9TDP7T88RH06LvIGbAeErdof
 ZgjoulDC3IonV6q7SsXdQs4caIc=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5df71d2d.7fb8ca01de68-smtp-out-n02;
 Mon, 16 Dec 2019 05:59:09 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BDB89C4479D; Mon, 16 Dec 2019 05:59:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from davidai-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: daidavid1)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E1231C433A2;
        Mon, 16 Dec 2019 05:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E1231C433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=daidavid1@codeaurora.org
From:   David Dai <daidavid1@codeaurora.org>
To:     georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        robh+dt@kernel.org
Cc:     David Dai <daidavid1@codeaurora.org>, evgreen@google.com,
        sboyd@kernel.org, ilina@codeaurora.org, seansw@qti.qualcomm.com,
        elder@linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v1 4/4] arm64: dts: sdm845: Redefine interconnect provider DT nodes
Date:   Sun, 15 Dec 2019 21:58:45 -0800
Message-Id: <1576475925-20601-5-git-send-email-daidavid1@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1576475925-20601-1-git-send-email-daidavid1@codeaurora.org>
References: <1576475925-20601-1-git-send-email-daidavid1@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the DT nodes for each of the Network-On-Chip interconnect
buses found on SDM845 based platform and redefine the rsc_hlos
child node as a bcm-voter device to better represent the hardware.

Signed-off-by: David Dai <daidavid1@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 61 ++++++++++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index ddb1f23..7c617a9 100644
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
+			reg = <0 0x016e0000 0 0xd080>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		aggre2_noc: interconnect@1700000 {
+			compatible = "qcom,sdm845-aggre2-noc";
+			reg = <0 0x01700000 0 0x3b100>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		mmss_noc: interconnect@1740000 {
+			compatible = "qcom,sdm845-mmss-noc";
+			reg = <0 0x01740000 0 0x1c1000>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
 		ufs_mem_hc: ufshc@1d84000 {
 			compatible = "qcom,sdm845-ufshc", "qcom,ufshc",
 				     "jedec,ufs-2.0";
@@ -3100,6 +3149,13 @@
 			#mbox-cells = <1>;
 		};
 
+		gladiator_noc: interconnect@17900000 {
+			compatible = "qcom,sdm845-gladiator-noc";
+			reg = <0 0x17900000 0 0xd080>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
 		apps_rsc: rsc@179c0000 {
 			label = "apps_rsc";
 			compatible = "qcom,rpmh-rsc";
@@ -3174,9 +3230,8 @@
 				};
 			};
 
-			rsc_hlos: interconnect {
-				compatible = "qcom,sdm845-rsc-hlos";
-				#interconnect-cells = <1>;
+			apps_bcm_voter: bcm-voter {
+				compatible = "qcom,sdm845-bcm-voter";
 			};
 		};
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
