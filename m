Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98E326EB9D
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2019 22:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388013AbfGSUcj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Jul 2019 16:32:39 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56524 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728057AbfGSUci (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jul 2019 16:32:38 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 24D4361793; Fri, 19 Jul 2019 20:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563568357;
        bh=38YnUHQQ+kMCt4pqBfuxeFYA0v57A3TGwosWrrnHLsM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LS9rcHeus0HZ4pxCJx55UzaxFt/x0Fuzi9u9Zneq7mMd/S5h8WYjl9pR+QUt+16k3
         0R0bfJdzU9V4ngdjIfpJ7Cte0BTyleq2+FIYinz8zc3xEUSZYx28ti1QwN0SRLEXwI
         7DbEViVTuZ/QK3wajeDCTyoIowiUsWzR4iUFeHag=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AA02D616F5;
        Fri, 19 Jul 2019 20:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563568356;
        bh=38YnUHQQ+kMCt4pqBfuxeFYA0v57A3TGwosWrrnHLsM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R2VPLu3vB0/KAYdjiK3guPdPtbdRrkubBy72PoWe1gOiWL0kEpj//hH1ZvWtLc9Do
         RRTH3FLwo7nB0XF2YtBX4Wa914qv8pMosjQO4ktirz9wVz7VjEPzoZz6cNlcHhTR6k
         FhyTY036Z45jFV3hkxhcd1PabCqa7pE/m58sWlFs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AA02D616F5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=daidavid1@codeaurora.org
From:   David Dai <daidavid1@codeaurora.org>
To:     georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        robh+dt@kernel.org
Cc:     David Dai <daidavid1@codeaurora.org>, evgreen@google.com,
        ilina@codeaurora.org, seansw@qti.qualcomm.com, elder@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: interconnect: Update Qualcomm SDM845 DT bindings
Date:   Fri, 19 Jul 2019 13:32:23 -0700
Message-Id: <1563568344-1274-2-git-send-email-daidavid1@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1563568344-1274-1-git-send-email-daidavid1@codeaurora.org>
References: <1563568344-1274-1-git-send-email-daidavid1@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Redefine the Network-on-Chip devices to more accurately describe
the interconnect topology on Qualcomm's SDM845 platform. Each
interconnect device can communicate with different instances of the
RPMh hardware which are described as RSCs(Resource State Coordinators).

Signed-off-by: David Dai <daidavid1@codeaurora.org>
---
 .../bindings/interconnect/qcom,bcm-voter.txt       | 32 +++++++++++++++++
 .../bindings/interconnect/qcom,sdm845.txt          | 40 +++++++++++++++++-----
 2 files changed, 63 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.txt

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.txt b/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.txt
new file mode 100644
index 0000000..2cf7da2
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.txt
@@ -0,0 +1,32 @@
+Qualcomm BCM-Voter interconnect driver binding
+-----------------------------------------------------------
+
+The Bus Clock Manager (BCM) is a dedicated hardware accelerator
+that manages shared system resources by aggregating requests
+from multiple Resource State Coordinators (RSC). Interconnect
+providers are able to vote for aggregated thresholds values from
+consumers by communicating through their respective RSCs.
+
+Required properties :
+- compatible : shall contain only one of the following:
+			"qcom,sdm845-bcm-voter",
+
+Examples:
+
+apps_rsc: rsc@179c0000 {
+	label = "apps_rsc";
+	compatible = "qcom,rpmh-rsc";
+
+	apps_bcm_voter: bcm_voter {
+		compatible = "qcom,sdm845-bcm-voter";
+	};
+}
+
+disp_rsc: rsc@179d0000 {
+	label = "disp_rsc";
+	compatible = "qcom,rpmh-rsc";
+
+	disp_bcm_voter: bcm_voter {
+		compatible = "qcom,sdm845-bcm-voter";
+	};
+}
diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt b/Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt
index 5c4f1d9..27f9ed9 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt
@@ -4,21 +4,43 @@ Qualcomm SDM845 Network-On-Chip interconnect driver binding
 SDM845 interconnect providers support system bandwidth requirements through
 RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
 able to communicate with the BCM through the Resource State Coordinator (RSC)
-associated with each execution environment. Provider nodes must reside within
-an RPMh device node pertaining to their RSC and each provider maps to a single
-RPMh resource.
+associated with each execution environment. Provider nodes must point to at
+least one RPMh device child node pertaining to their RSC and each provider
+can map to multiple RPMh resources.
 
 Required properties :
 - compatible : shall contain only one of the following:
-			"qcom,sdm845-rsc-hlos"
+			"qcom,sdm845-aggre1_noc",
+			"qcom,sdm845-aggre2_noc",
+			"qcom,sdm845-config_noc",
+			"qcom,sdm845-dc_noc",
+			"qcom,sdm845-gladiator_noc",
+			"qcom,sdm845-mem_noc",
+			"qcom,sdm845-mmss_noc",
+			"qcom,sdm845-system_noc",
 - #interconnect-cells : should contain 1
+- reg : shall contain base register location and length
+- qcom,bcm-voter : shall contain phandles to bcm voters
 
 Examples:
 
-apps_rsc: rsc {
-	rsc_hlos: interconnect {
-		compatible = "qcom,sdm845-rsc-hlos";
-		#interconnect-cells = <1>;
-	};
+aggre1_noc: interconnect@16e0000 {
+	compatible = "qcom,sdm845-aggre1_noc";
+	reg = <0x16e0000 0xd080>;
+	interconnect-cells = <1>;
+	qcom,bcm-voter = <&apps_bcm_voter>;
 };
 
+mmss_noc: interconnect@1740000 {
+	compatible = "qcom,sdm845-mmss_noc";
+	reg = <0x1740000 0x1c1000>;
+	interconnect-cells = <1>;
+	qcom,bcm-voter = <&apps_bcm_voter>, <&disp_bcm_voter>;
+};
+
+mem_noc: interconnect@1380000 {
+	compatible = "qcom,sdm845-mem_noc";
+	reg = <0 0x1380000 0 0x27200>;
+	#interconnect-cells = <1>;
+	qcom,bcm-voter = <&apps_bcm_voter>, <&disp_bcm_voter>;
+};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

