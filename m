Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B64C36C223
	for <lists+linux-pm@lfdr.de>; Tue, 27 Apr 2021 11:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235322AbhD0JwY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Apr 2021 05:52:24 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:12420 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235323AbhD0JwV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Apr 2021 05:52:21 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1619517099; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=nQJGAMkPLqna+SnbfjlmVGk8+T8HGlcaCxY8C3QkxuI=; b=GT8f1V+IeAgR9adJ5nE8Teg7hF2RipqcBPf+Gq4YcmRmPehANfgT8b7w9wiqEDAnWuow3RQU
 kC+CQx4Uuabpx2REAZmexI249mseeqZq7rcYe0ZQgtntxX4XsmuD6g8Bn2PSLrn/S1XNumX4
 aKTHJ7aohZqC1SN4Y/J3Q+9p0GQ=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 6087deaa2cc44d3aeac6ba40 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 27 Apr 2021 09:51:38
 GMT
Sender: okukatla=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 90DFEC43217; Tue, 27 Apr 2021 09:51:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from okukatla1-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okukatla)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BCCE5C43460;
        Tue, 27 Apr 2021 09:51:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BCCE5C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=okukatla@codeaurora.org
From:   Odelu Kukatla <okukatla@codeaurora.org>
To:     georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        evgreen@google.com, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     sboyd@kernel.org, ilina@codeaurora.org, seansw@qti.qualcomm.com,
        sibis@codeaurora.org, elder@linaro.org, linux-pm@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org,
        Odelu Kukatla <okukatla@codeaurora.org>
Subject: [v2 3/3] arm64: dts: sc7280: Add interconnect provider DT nodes
Date:   Tue, 27 Apr 2021 15:20:58 +0530
Message-Id: <1619517059-12109-4-git-send-email-okukatla@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1619517059-12109-1-git-send-email-okukatla@codeaurora.org>
References: <1619517059-12109-1-git-send-email-okukatla@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the DT nodes for the network-on-chip interconnect buses found
on sc7280-based platforms.

Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 88 ++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 2cc4785..6b22021 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -7,6 +7,7 @@
 
 #include <dt-bindings/clock/qcom,gcc-sc7280.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
+#include <dt-bindings/interconnect/qcom,sc7280.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/mailbox/qcom-ipcc.h>
 #include <dt-bindings/power/qcom-aoss-qmp.h>
@@ -1115,6 +1116,93 @@
 				clock-names = "xo";
 				#clock-cells = <1>;
 			};
+
+			apps_bcm_voter: bcm_voter {
+				compatible = "qcom,bcm-voter";
+			};
+		};
+
+		clk_virt: interconnect {
+			compatible = "qcom,sc7280-clk-virt";
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		cnoc2: interconnect@1500000 {
+			reg = <0 0x1500000 0 0x1000>;
+			compatible = "qcom,sc7280-cnoc2";
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		cnoc3: interconnect@1502000 {
+			reg = <0 0x1502000 0 0x1000>;
+			compatible = "qcom,sc7280-cnoc3";
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		mc_virt: interconnect@1580000 {
+			reg = <0 0x1580000 0 0x4>;
+			compatible = "qcom,sc7280-mc-virt";
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		system_noc: interconnect@1680000 {
+			reg = <0 0x1680000 0 0x15480>;
+			compatible = "qcom,sc7280-system-noc";
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		aggre1_noc: interconnect@16e0000 {
+			compatible = "qcom,sc7280-aggre1-noc";
+			reg = <0 0x016e0000 0 0x1c080>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		aggre2_noc: interconnect@1700000 {
+			reg = <0 0x1700000 0 0x2b080>;
+			compatible = "qcom,sc7280-aggre2-noc";
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		mmss_noc: interconnect@1740000 {
+			reg = <0 0x1740000 0 0x1e080>;
+			compatible = "qcom,sc7280-mmss-noc";
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		lpass_ag_noc: interconnect@3c40000 {
+			reg = <0 0x03c40000 0 0xf080>;
+			compatible = "qcom,sc7280-lpass-ag-noc";
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		dc_noc: interconnect@90e0000 {
+			reg = <0 0x90e0000 0 0x5080>;
+			compatible = "qcom,sc7280-dc-noc";
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		gem_noc: interconnect@9100000 {
+			reg = <0 0x9100000 0 0xe2200>;
+			compatible = "qcom,sc7280-gem-noc";
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		nsp_noc: interconnect@a0c0000 {
+			reg = <0 0x0a0c0000 0 0x10000>;
+			compatible = "qcom,sc7280-nsp-noc";
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 	};
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

