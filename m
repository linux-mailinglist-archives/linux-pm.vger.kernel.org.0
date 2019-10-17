Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04FE8DA3A0
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 04:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbfJQCVJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 22:21:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45422 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394411AbfJQCVH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 22:21:07 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C335260923; Thu, 17 Oct 2019 02:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571278866;
        bh=fR97MrSGMpezplngGcizUvbOkXG/OJy4+Tj2GuNq7Wk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nONbCPaFVCvcGVAB4tmfeNv1ihLbU+AzNYVRREYa3192F/2zjFz10zWcWna6jFReg
         0F5OT3ZKoRg4WiFfmp12LzTk2BIdriE2TVUNDV3TjnuqyMUopC0EIpcwFEiPepnIgZ
         3VCfDGhXHJsfY1dGeTym/3yV8QQo415YH0x2iCaw=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from davidai-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: daidavid1@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8E27960716;
        Thu, 17 Oct 2019 02:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571278866;
        bh=fR97MrSGMpezplngGcizUvbOkXG/OJy4+Tj2GuNq7Wk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nONbCPaFVCvcGVAB4tmfeNv1ihLbU+AzNYVRREYa3192F/2zjFz10zWcWna6jFReg
         0F5OT3ZKoRg4WiFfmp12LzTk2BIdriE2TVUNDV3TjnuqyMUopC0EIpcwFEiPepnIgZ
         3VCfDGhXHJsfY1dGeTym/3yV8QQo415YH0x2iCaw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8E27960716
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=daidavid1@codeaurora.org
From:   David Dai <daidavid1@codeaurora.org>
To:     georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        robh+dt@kernel.org
Cc:     David Dai <daidavid1@codeaurora.org>, evgreen@google.com,
        sboyd@kernel.org, ilina@codeaurora.org, seansw@qti.qualcomm.com,
        elder@linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [RFC PATCH 2/4] arm64: dts: sdm845: Redefine interconnect provider DT nodes
Date:   Wed, 16 Oct 2019 19:20:50 -0700
Message-Id: <1571278852-8023-3-git-send-email-daidavid1@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1571278852-8023-1-git-send-email-daidavid1@codeaurora.org>
References: <1571278852-8023-1-git-send-email-daidavid1@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the DT nodes for each of the Network-On-Chip interconnect
buses found on SDM845 based platform and redefine the rsc_hlos
child node as a bcm-voter device to better represent the hardware.

Signed-off-by: David Dai <daidavid1@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 60 ++++++++++++++++++++++++++++++++++--
 1 file changed, 57 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index f406a43..a7ad79d 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1362,6 +1362,54 @@
 			reg = <0 0x01100000 0 0x200000>, <0 0x01300000 0 0x50000>;
 			reg-names = "llcc_base", "llcc_broadcast_base";
 			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
+
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
 		};
 
 		ufs_mem_hc: ufshc@1d84000 {
@@ -3090,6 +3138,13 @@
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
@@ -3164,9 +3219,8 @@
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

