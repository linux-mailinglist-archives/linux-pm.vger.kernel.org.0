Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB902235257
	for <lists+linux-pm@lfdr.de>; Sat,  1 Aug 2020 14:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729105AbgHAMbh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 1 Aug 2020 08:31:37 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:36350 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728933AbgHAMbe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 1 Aug 2020 08:31:34 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596285093; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=gIhiReezzOaGTqKnKkoV8bXXS3YqhQfx9Z2l8yG5Upg=; b=H6iLHnuMNaVA69PrnubAzY3JVag/s/pEBIH8TUsIjO43b6sLXAuE9n9vHPIJw7lnl3Of3ohu
 7qUxKQj7FFkMBJwJoXMZhzsvkcns+jsLPp5sFz66jTgdZ9gi52I/lhpzA2jMlAIV2DsPvq8g
 REtKpEjlvzAr6tDx9Hcewv7Yqnc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n20.prod.us-east-1.postgun.com with SMTP id
 5f25609beecfc978d3e75369 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 01 Aug 2020 12:31:23
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 55BD9C433B6; Sat,  1 Aug 2020 12:31:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8503CC433AD;
        Sat,  1 Aug 2020 12:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8503CC433AD
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     robh+dt@kernel.org, georgi.djakov@linaro.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, jonathan@marek.ca,
        linux-pm@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH 6/7] arm64: dts: qcom: sm8150: Add OSM L3 interconnect provider
Date:   Sat,  1 Aug 2020 18:00:48 +0530
Message-Id: <20200801123049.32398-7-sibis@codeaurora.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200801123049.32398-1-sibis@codeaurora.org>
References: <20200801123049.32398-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add Operation State Manager (OSM) L3 interconnect provider node on
SM8150 SoCs.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 0f6d84e8fd299..8563afd205ee9 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -10,6 +10,7 @@
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/clock/qcom,gcc-sm8150.h>
+#include <dt-bindings/interconnect/qcom,osm-l3.h>
 #include <dt-bindings/interconnect/qcom,sm8150.h>
 #include <dt-bindings/thermal/thermal.h>
 
@@ -1184,6 +1185,16 @@ apps_bcm_voter: bcm_voter {
 			};
 		};
 
+		osm_l3: interconnect@18321000 {
+			compatible = "qcom,sm8150-osm-l3";
+			reg = <0 0x18321000 0 0x1400>;
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
+
+			#interconnect-cells = <1>;
+		};
+
 		cpufreq_hw: cpufreq@18323000 {
 			compatible = "qcom,cpufreq-hw";
 			reg = <0 0x18323000 0 0x1400>, <0 0x18325800 0 0x1400>,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

