Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985DC3CF51C
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jul 2021 09:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbhGTGcz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Jul 2021 02:32:55 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:60952 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234813AbhGTGbv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 20 Jul 2021 02:31:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626765145; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=DAwy1uPNsMkefojwEHZYZzoXLNWdQq69hB3w5j/GATY=; b=IJN2z6ZYjEev/Titi1pZEQTsgg/czQQdou/hE8beWjD4dXJU7fpRuOzn66OK9cwyqBHicnTO
 NeQq02FQ7Ndzt73RXIDfk+oUH3XaZVrj/gqGwtTjTAqkAHN3KDtvUu5W1x8Bpy9hJN5wRqmd
 NTLEftJWRSOZGu6RJXJQTFiyDsg=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 60f6774b17c2b4047da08417 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 20 Jul 2021 07:12:11
 GMT
Sender: rnayak=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AC82CC433F1; Tue, 20 Jul 2021 07:12:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 04EDBC4338A;
        Tue, 20 Jul 2021 07:12:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 04EDBC4338A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     ulf.hansson@linaro.org, bjorn.andersson@linaro.org,
        viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, rojay@codeaurora.org, stephan@gerhold.net,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v5 2/2] arm64: dts: sc7180: Add required-opps for i2c
Date:   Tue, 20 Jul 2021 12:37:56 +0530
Message-Id: <1626764876-10229-3-git-send-email-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626764876-10229-1-git-send-email-rnayak@codeaurora.org>
References: <1626764876-10229-1-git-send-email-rnayak@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

qup-i2c devices on sc7180 are clocked with a fixed clock (19.2 MHz)
Though qup-i2c does not support DVFS, it still needs to vote for a
performance state on 'CX' to satisfy the 19.2 Mhz clock frequency
requirement.

Use 'required-opps' to pass this information from
device tree, and also add the power-domains property to specify
the CX power-domain.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index a5d58eb..cd30185 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -785,8 +785,10 @@
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
+				power-domains = <&rpmhpd SC7180_CX>;
+				required-opps = <&rpmhpd_opp_low_svs>;
 				status = "disabled";
 			};
 
 			spi0: spi@880000 {
@@ -837,8 +839,10 @@
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
+				power-domains = <&rpmhpd SC7180_CX>;
+				required-opps = <&rpmhpd_opp_low_svs>;
 				status = "disabled";
 			};
 
 			spi1: spi@884000 {
@@ -889,8 +893,10 @@
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
+				power-domains = <&rpmhpd SC7180_CX>;
+				required-opps = <&rpmhpd_opp_low_svs>;
 				status = "disabled";
 			};
 
 			uart2: serial@888000 {
@@ -923,8 +929,10 @@
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
+				power-domains = <&rpmhpd SC7180_CX>;
+				required-opps = <&rpmhpd_opp_low_svs>;
 				status = "disabled";
 			};
 
 			spi3: spi@88c000 {
@@ -975,8 +983,10 @@
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
+				power-domains = <&rpmhpd SC7180_CX>;
+				required-opps = <&rpmhpd_opp_low_svs>;
 				status = "disabled";
 			};
 
 			uart4: serial@890000 {
@@ -1009,8 +1019,10 @@
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
+				power-domains = <&rpmhpd SC7180_CX>;
+				required-opps = <&rpmhpd_opp_low_svs>;
 				status = "disabled";
 			};
 
 			spi5: spi@894000 {
@@ -1074,8 +1086,10 @@
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
 						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
+				power-domains = <&rpmhpd SC7180_CX>;
+				required-opps = <&rpmhpd_opp_low_svs>;
 				status = "disabled";
 			};
 
 			spi6: spi@a80000 {
@@ -1126,8 +1140,10 @@
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
 						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
+				power-domains = <&rpmhpd SC7180_CX>;
+				required-opps = <&rpmhpd_opp_low_svs>;
 				status = "disabled";
 			};
 
 			uart7: serial@a84000 {
@@ -1160,8 +1176,10 @@
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
 						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
+				power-domains = <&rpmhpd SC7180_CX>;
+				required-opps = <&rpmhpd_opp_low_svs>;
 				status = "disabled";
 			};
 
 			spi8: spi@a88000 {
@@ -1212,8 +1230,10 @@
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
 						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
+				power-domains = <&rpmhpd SC7180_CX>;
+				required-opps = <&rpmhpd_opp_low_svs>;
 				status = "disabled";
 			};
 
 			uart9: serial@a8c000 {
@@ -1246,8 +1266,10 @@
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
 						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
+				power-domains = <&rpmhpd SC7180_CX>;
+				required-opps = <&rpmhpd_opp_low_svs>;
 				status = "disabled";
 			};
 
 			spi10: spi@a90000 {
@@ -1298,8 +1320,10 @@
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
 						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
+				power-domains = <&rpmhpd SC7180_CX>;
+				required-opps = <&rpmhpd_opp_low_svs>;
 				status = "disabled";
 			};
 
 			spi11: spi@a94000 {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

