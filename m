Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64A53435F71
	for <lists+linux-pm@lfdr.de>; Thu, 21 Oct 2021 12:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbhJUKoM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Oct 2021 06:44:12 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:58573 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbhJUKoM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Oct 2021 06:44:12 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1634812917; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=YNKJJhqT7RyNQ/bpCQuxzrbnZdRVhM2WLYXwCBixS+U=; b=s9odeqMxSQ98kXiBE81sF+2l0cEk6o9R1wPJgdM8ndSJp/rDbCOPDUQ1FJJcUN1NJvcLKztX
 RIwsEOXOyzvUwXBpqwBr6FeRBOyXERIPr7S/9nhH1bVRsbNgHhw5N3xCtXSBQ6HrqXOzT/YR
 sWk3r1xlAcH1oDcUkJl4DFkYH70=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 617143db59612e0100e4349f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 21 Oct 2021 10:41:31
 GMT
Sender: okukatla=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 89129C4361A; Thu, 21 Oct 2021 10:41:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from okukatla1-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okukatla)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 46AA9C4360C;
        Thu, 21 Oct 2021 10:41:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 46AA9C4360C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Odelu Kukatla <okukatla@codeaurora.org>
To:     georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        evgreen@google.com, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     sboyd@kernel.org, mdtipton@codeaurora.org, sibis@codeaurora.org,
        saravanak@google.com, okukatla@codeaurora.org,
        seansw@qti.qualcomm.com, elder@linaro.org,
        linux-pm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org
Subject: [v8 3/3] arm64: dts: qcom: sc7280: Add EPSS L3 interconnect provider
Date:   Thu, 21 Oct 2021 16:10:57 +0530
Message-Id: <1634812857-10676-4-git-send-email-okukatla@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1634812857-10676-1-git-send-email-okukatla@codeaurora.org>
References: <1634812857-10676-1-git-send-email-okukatla@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add Epoch Subsystem (EPSS) L3 interconnect provider node on SC7280
SoCs.

Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index d74a4c8..0b55742 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -3687,6 +3687,14 @@
 			};
 		};
 
+		epss_l3: interconnect@18590000 {
+			compatible = "qcom,sc7280-epss-l3";
+			reg = <0 0x18590000 0 0x1000>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
+			clock-names = "xo", "alternate";
+			#interconnect-cells = <1>;
+		};
+
 		cpufreq_hw: cpufreq@18591000 {
 			compatible = "qcom,cpufreq-epss";
 			reg = <0 0x18591000 0 0x1000>,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

