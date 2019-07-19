Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9DA6EBA1
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2019 22:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388057AbfGSUcn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Jul 2019 16:32:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56646 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388011AbfGSUcj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jul 2019 16:32:39 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5A11661836; Fri, 19 Jul 2019 20:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563568358;
        bh=4lOKewWx4DPDxGEDzYunri8E48SbXykONHMaszyMNJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MuKW9PO3LhK8Z0Il7yDSpaw+SAFXMWLK9VM5ohg7L1e3qYimW3QZYGlkmN7fbnkQl
         6rdx1SUOiblEWCH2sxBT5O9PBfzWtALT8nsK9dhi4DrmyJPmbMefBO76zPs3sFKL+L
         TVZ7bS0kliC1Gm3GauDyLne6v08zogMADkD/HGbQ=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 187386182E;
        Fri, 19 Jul 2019 20:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563568357;
        bh=4lOKewWx4DPDxGEDzYunri8E48SbXykONHMaszyMNJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KsvKiwi3lTIfJjgyxHQ2OXd0AU64RWvMQiGAmdvWj/qF1ZR1371E3HrgNRh3vuopV
         rI7wcjQ4F8ddQk7xTKUsCb++p2Hq+/O3EQVBNMP3fgmPQwvwjPitC+gxmsH0XEgLQu
         t9EiVcHVKXgz7/H700x4pNWdQilF+T0MmuOTqa0o=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 187386182E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=daidavid1@codeaurora.org
From:   David Dai <daidavid1@codeaurora.org>
To:     georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        robh+dt@kernel.org
Cc:     David Dai <daidavid1@codeaurora.org>, evgreen@google.com,
        ilina@codeaurora.org, seansw@qti.qualcomm.com, elder@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: sdm845: Redefine interconnect provider DT nodes
Date:   Fri, 19 Jul 2019 13:32:24 -0700
Message-Id: <1563568344-1274-3-git-send-email-daidavid1@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1563568344-1274-1-git-send-email-daidavid1@codeaurora.org>
References: <1563568344-1274-1-git-send-email-daidavid1@codeaurora.org>
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
index e7d78bc..204222e 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -610,6 +610,62 @@
 			#power-domain-cells = <1>;
 		};
 
+		aggre1_noc: interconnect@16e0000 {
+			compatible = "qcom,sdm845-aggre1_noc";
+			reg = <0 0x16e0000 0 0xd080>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voter = <&apps_bcm_voter>;
+		};
+
+		aggre2_noc: interconnect@1700000 {
+			compatible = "qcom,sdm845-aggre2_noc";
+			reg = <0 0x1700000 0 0x3b100>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voter = <&apps_bcm_voter>;
+		};
+
+		config_noc: interconnect@1500000 {
+			compatible = "qcom,sdm845-config_noc";
+			reg = <0 0x1500000 0 0x5080>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voter = <&apps_bcm_voter>;
+		};
+
+		dc_noc: interconnect@14e0000 {
+			compatible = "qcom,sdm845-dc_noc";
+			reg = <0 0x14e0000 0 0x400>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voter = <&apps_bcm_voter>;
+		};
+
+		gladiator_noc: interconnect@17900000 {
+			compatible = "qcom,sdm845-gladiator_noc";
+			reg = <0 0x17900000 0 0xd080>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voter = <&apps_bcm_voter>;
+		};
+
+		mem_noc: interconnect@1380000 {
+			compatible = "qcom,sdm845-mem_noc";
+			reg = <0 0x1380000 0 0x27200>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voter = <&apps_bcm_voter>;
+		};
+
+		mmss_noc: interconnect@1740000 {
+			compatible = "qcom,sdm845-mmss_noc";
+			reg = <0 0x1740000 0 0x1c1000>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voter = <&apps_bcm_voter>;
+		};
+
+		system_noc: interconnect@1620000 {
+			compatible = "qcom,sdm845-system_noc";
+			reg = <0 0x1620000 0 0x18080>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voter = <&apps_bcm_voter>;
+		};
+
 		qfprom@784000 {
 			compatible = "qcom,qfprom";
 			reg = <0 0x00784000 0 0x8ff>;
@@ -2801,9 +2857,8 @@
 				};
 			};
 
-			rsc_hlos: interconnect {
-				compatible = "qcom,sdm845-rsc-hlos";
-				#interconnect-cells = <1>;
+			apps_bcm_voter: bcm_voter {
+				compatible = "qcom,sdm845-bcm-voter";
 			};
 		};
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

