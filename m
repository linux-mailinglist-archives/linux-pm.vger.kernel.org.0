Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97E6E3AC9DF
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jun 2021 13:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbhFRLbn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Jun 2021 07:31:43 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:51346 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232288AbhFRLbl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 18 Jun 2021 07:31:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624015772; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=Mvr6DwYqAdmQs+y9t8n9U1xRbG7Nq+qmosOSCCtPFKg=; b=A3BX+L9D8Ajn2Zfuaokvq+3XM2osGrmZK9QxlZeNYCaiav+UpuXoxp6+PTxGomsJgg8AZSVZ
 KFuST6ld79KUGkDsbPxL3AsBQ4HP7DIvc2F1S6JHkTob7+5lz/XSKpe1pqteRz4zZs4a6MZh
 JBXKRlORAoYxyLXb9lSlmyTsQsE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 60cc83992eaeb98b5e3cb0c2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 18 Jun 2021 11:29:29
 GMT
Sender: okukatla=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 03A64C43460; Fri, 18 Jun 2021 11:29:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from okukatla1-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okukatla)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 68908C43217;
        Fri, 18 Jun 2021 11:29:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 68908C43217
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=okukatla@codeaurora.org
From:   Odelu Kukatla <okukatla@codeaurora.org>
To:     georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        evgreen@google.com, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     sboyd@kernel.org, seansw@qti.qualcomm.com, elder@linaro.org,
        linux-pm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        Odelu Kukatla <okukatla@codeaurora.org>
Subject: [V4 3/3] arm64: dts: qcom: sc7280: Add EPSS L3 interconnect provider
Date:   Fri, 18 Jun 2021 16:58:54 +0530
Message-Id: <1624015734-16778-4-git-send-email-okukatla@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1624015734-16778-1-git-send-email-okukatla@codeaurora.org>
References: <1624015734-16778-1-git-send-email-okukatla@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add Epoch Subsystem (EPSS) L3 interconnect provider node on SC7280
SoCs.

Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 38a7f55..7690d7e 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -1153,6 +1153,15 @@
 			};
 		};
 
+		epss_l3: interconnect@18590000 {
+			compatible = "qcom,sc7280-epss-l3";
+			reg = <0 0x18590000 0 1000>, <0 0x18591000 0 0x100>,
+				<0 0x18592000 0 0x100>, <0 0x18593000 0 0x100>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
+			clock-names = "xo", "alternate";
+			#interconnect-cells = <1>;
+		};
+
 		clk_virt: interconnect {
 			compatible = "qcom,sc7280-clk-virt";
 			#interconnect-cells = <2>;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

