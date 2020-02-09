Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77B16156C20
	for <lists+linux-pm@lfdr.de>; Sun,  9 Feb 2020 19:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgBISeo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 9 Feb 2020 13:34:44 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:36016 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727916AbgBISen (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 9 Feb 2020 13:34:43 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581273283; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=+1DKsfHKqf3VdpYQ4VsopZ1BmdGLhw90hpkP2xTJYT8=; b=PN69v0S53jYjb8prVM5dvoDm86TQ96bi7p54BW9ofjRhOE6MP2acMuKoVjdg/gzt3DLuTpCe
 9b77/3C3tepGpm5knLHuXR3MTt508mKA2UKDI3P05rzrm2nRQjHncJVQKfxyk/Tshd1hQ/Pn
 wEw00IXy0RC3QPlUVtdd55GT0i0=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e4050c1.7faeb7359e30-smtp-out-n01;
 Sun, 09 Feb 2020 18:34:41 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A5937C447A0; Sun,  9 Feb 2020 18:34:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 509B2C447A3;
        Sun,  9 Feb 2020 18:34:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 509B2C447A3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     robh+dt@kernel.org, georgi.djakov@linaro.org, evgreen@chromium.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mark.rutland@arm.com,
        daidavid1@codeaurora.org, saravanak@google.com, mka@chromium.org,
        linux-pm@vger.kernel.org, Odelu Kukatla <okukatla@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v3 3/6] dt-bindings: interconnect: Update Qualcomm SDM845 DT bindings
Date:   Mon, 10 Feb 2020 00:04:08 +0530
Message-Id: <20200209183411.17195-4-sibis@codeaurora.org>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200209183411.17195-1-sibis@codeaurora.org>
References: <20200209183411.17195-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: David Dai <daidavid1@codeaurora.org>

Redefine the Network-on-Chip devices to more accurately describe
the interconnect topology on Qualcomm's SDM845 platform. Each
interconnect device can communicate with different instances of the
RPMh hardware which are described as RSCs(Resource State Coordinators).

Signed-off-by: David Dai <daidavid1@codeaurora.org>
Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 .../bindings/interconnect/qcom,sdm845.yaml    | 49 +++++++++++++++----
 1 file changed, 40 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sdm845.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sdm845.yaml
index 11a495dbfc520..8b087e0b0b811 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,sdm845.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sdm845.yaml
@@ -13,21 +13,44 @@ description: |
    SDM845 interconnect providers support system bandwidth requirements through
    RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
    able to communicate with the BCM through the Resource State Coordinator (RSC)
-   associated with each execution environment. Provider nodes must reside within
-   an RPMh device node pertaining to their RSC and each provider maps to a
-   single RPMh resource.
+   associated with each execution environment. Provider nodes must point to at
+   least one RPMh device child node pertaining to their RSC and each provider
+   can map to multiple RPMh resources.
 
 properties:
+  reg:
+    maxItems: 1
+
   compatible:
     enum:
-      - qcom,sdm845-rsc-hlos
+      - qcom,sdm845-aggre1-noc
+      - qcom,sdm845-aggre2-noc
+      - qcom,sdm845-config-noc
+      - qcom,sdm845-dc-noc
+      - qcom,sdm845-gladiator-noc
+      - qcom,sdm845-mem-noc
+      - qcom,sdm845-mmss-noc
+      - qcom,sdm845-system-noc
 
   '#interconnect-cells':
     const: 1
 
+  qcom,bcm-voters:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: |
+      List of phandles to qcom,bcm-voter nodes that are required by
+      this interconnect to send RPMh commands.
+
+  qcom,bcm-voter-names:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    description: |
+      Names for each of the qcom,bcm-voters specified.
+
 required:
   - compatible
+  - reg
   - '#interconnect-cells'
+  - qcom,bcm-voters
 
 additionalProperties: false
 
@@ -35,9 +58,17 @@ examples:
   - |
       #include <dt-bindings/interconnect/qcom,sdm845.h>
 
-      apps_rsc: rsc {
-              rsc_hlos: interconnect {
-                      compatible = "qcom,sdm845-rsc-hlos";
-                      #interconnect-cells = <1>;
-              };
+      mem_noc: interconnect@1380000 {
+             compatible = "qcom,sdm845-mem-noc";
+             reg = <0 0x01380000 0 0x27200>;
+             #interconnect-cells = <1>;
+             qcom,bcm-voters = <&apps_bcm_voter>;
+      };
+
+      mmss_noc: interconnect@1740000 {
+             compatible = "qcom,sdm845-mmss-noc";
+             reg = <0 0x01740000 0 0x1c1000>;
+             #interconnect-cells = <1>;
+             qcom,bcm-voter-names = "apps", "disp";
+             qcom,bcm-voters = <&apps_bcm_voter>, <&disp_bcm_voter>;
       };
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
