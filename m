Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37C32DA3A3
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 04:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404046AbfJQCVH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 22:21:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45348 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbfJQCVH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 22:21:07 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9DD806088D; Thu, 17 Oct 2019 02:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571278865;
        bh=/X2nvYE8arAJyqkCCndBCq0rQxxg6mGCEArXEpJZb0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mtPv5oeSiEopLl8/+T5gAxrKdnHp4MWu0hJPIlROKFhYtY93tmI+98trl0on7jUmc
         ulk1j6IKd4pfiFW4cbvKs8z4rK/XABUGJwGvw2SKEx6RTs7ouOHIziGCmsM1HSpyZs
         U8nOjQbRRLv4i3Kqqm+XfDq60UuVz8H0BQ5M3lws=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BC62F6079C;
        Thu, 17 Oct 2019 02:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571278864;
        bh=/X2nvYE8arAJyqkCCndBCq0rQxxg6mGCEArXEpJZb0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mTngHsQeL0a5pmwyW7AYPQnEreaw8iiVwhP6f60SD/uCQNDOGDSFsWFDiINzR2BCF
         ABhOlCwBCBhk/I1ujmEzdyPcEuceT2/RI5KrnbIGOf01lWRfjM/0JnyDZ6nMGnKE3p
         fEfzFr0g1D3kWt0p0CTp9mQIZitdpNaDmHQWXs/0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BC62F6079C
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
Subject: [RFC PATCH 1/4] dt-bindings: interconnect: Update Qualcomm SDM845 DT bindings
Date:   Wed, 16 Oct 2019 19:20:49 -0700
Message-Id: <1571278852-8023-2-git-send-email-daidavid1@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1571278852-8023-1-git-send-email-daidavid1@codeaurora.org>
References: <1571278852-8023-1-git-send-email-daidavid1@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Redefine the Network-on-Chip devices to more accurately describe
the interconnect topology on Qualcomm's SDM845 platform. Each
interconnect device can communicate with different instances of the
RPMh hardware which are described as RSCs(Resource State Coordinators).

As part of updating the DT bindings, convert the existing sdm845 bindings
to DT schema format using json-schema.

Signed-off-by: David Dai <daidavid1@codeaurora.org>
---
 .../bindings/interconnect/qcom,bcm-voter.yaml      |  45 +++++++++
 .../bindings/interconnect/qcom,sdm845.txt          |  24 -----
 .../bindings/interconnect/qcom,sdm845.yaml         | 108 +++++++++++++++++++++
 3 files changed, 153 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
 delete mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm845.yaml

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml b/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
new file mode 100644
index 0000000..74f0715
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,bcm-voter.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm BCM-Voter Interconnect
+
+maintainers:
+  - David Dai <daidavid1@codeaurora.org>
+
+description: |
+    The Bus Clock Manager (BCM) is a dedicated hardware accelerator
+    that manages shared system resources by aggregating requests
+    from multiple Resource State Coordinators (RSC). Interconnect
+    providers are able to vote for aggregated thresholds values from
+    consumers by communicating through their respective RSCs.
+
+properties:
+  compatible:
+    enum:
+      - qcom,sdm845-bcm-voter
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    apps_rsc: interconnect@179c0000 {
+        compatible = "qcom,rpmh-rsc";
+
+        apps_bcm_voter: bcm_voter {
+            compatible = "qcom,sdm845-bcm-voter";
+        };
+    };
+
+    disp_rsc: interconnect@179d0000 {
+        compatible = "qcom,rpmh-rsc";
+
+        disp_bcm_voter: bcm_voter {
+            compatible = "qcom,sdm845-bcm-voter";
+        };
+    };
diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt b/Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt
deleted file mode 100644
index 5c4f1d9..0000000
--- a/Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-Qualcomm SDM845 Network-On-Chip interconnect driver binding
------------------------------------------------------------
-
-SDM845 interconnect providers support system bandwidth requirements through
-RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
-able to communicate with the BCM through the Resource State Coordinator (RSC)
-associated with each execution environment. Provider nodes must reside within
-an RPMh device node pertaining to their RSC and each provider maps to a single
-RPMh resource.
-
-Required properties :
-- compatible : shall contain only one of the following:
-			"qcom,sdm845-rsc-hlos"
-- #interconnect-cells : should contain 1
-
-Examples:
-
-apps_rsc: rsc {
-	rsc_hlos: interconnect {
-		compatible = "qcom,sdm845-rsc-hlos";
-		#interconnect-cells = <1>;
-	};
-};
-
diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sdm845.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sdm845.yaml
new file mode 100644
index 0000000..1aec321
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sdm845.yaml
@@ -0,0 +1,108 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,sdm845.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title:  Qualcomm SDM845 Network-On-Chip Interconnect
+
+maintainers:
+  - David Dai <daidavid1@codeaurora.org>
+
+description: |
+   SDM845 interconnect providers support system bandwidth requirements through
+   RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
+   able to communicate with the BCM through the Resource State Coordinator (RSC)
+   associated with each execution environment. Provider nodes must point to at
+   least one RPMh device child node pertaining to their RSC and each provider
+   can map to multiple RPMh resources.
+
+properties:
+  reg:
+    maxItems: 1
+
+  compatible:
+    enum:
+      - qcom,sdm845-aggre1-noc
+      - qcom,sdm845-aggre2-noc
+      - qcom,sdm845-config-noc
+      - qcom,sdm845-dc-noc
+      - qcom,sdm845-gladiator-noc
+      - qcom,sdm845-mem-noc
+      - qcom,sdm845-mmss-noc
+      - qcom,sdm845-system-noc
+
+  '#interconnect-cells':
+    const: 1
+
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
+required:
+  - compatible
+  - reg
+  - '#interconnect-cells'
+  - qcom,bcm-voters
+
+additionalProperties: false
+
+examples:
+  - |
+      #include <dt-bindings/interconnect/qcom,sdm845.h>
+
+      mem_noc: interconnect@1380000 {
+             compatible = "qcom,sdm845-mem-noc";
+             reg = <0 0x01380000 0 0x27200>;
+             #interconnect-cells = <1>;
+             qcom,bcm-voters = <&apps_bcm_voter>;
+      };
+
+      dc_noc: interconnect@14e0000 {
+             compatible = "qcom,sdm845-dc-noc";
+             reg = <0 0x014e0000 0 0x400>;
+             #interconnect-cells = <1>;
+             qcom,bcm-voters = <&apps_bcm_voter>;
+      };
+
+      config_noc: interconnect@1500000 {
+             compatible = "qcom,sdm845-config-noc";
+             reg = <0 0x01500000 0 0x5080>;
+             #interconnect-cells = <1>;
+             qcom,bcm-voters = <&apps_bcm_voter>;
+      };
+
+      system_noc: interconnect@1620000 {
+             compatible = "qcom,sdm845-system-noc";
+             reg = <0 0x01620000 0 0x18080>;
+             #interconnect-cells = <1>;
+             qcom,bcm-voters = <&apps_bcm_voter>;
+      };
+
+      aggre1_noc: interconnect@16e0000 {
+             compatible = "qcom,sdm845-aggre1-noc";
+             reg = <0 0x016e0000 0 0xd080>;
+             #interconnect-cells = <1>;
+             qcom,bcm-voters = <&apps_bcm_voter>;
+      };
+
+      aggre2_noc: interconnect@1700000 {
+             compatible = "qcom,sdm845-aggre2-noc";
+             reg = <0 0x01700000 0 0x3b100>;
+             #interconnect-cells = <1>;
+             qcom,bcm-voters = <&apps_bcm_voter>;
+      };
+
+      mmss_noc: interconnect@1740000 {
+             compatible = "qcom,sdm845-mmss-noc";
+             reg = <0 0x01740000 0 0x1c1000>;
+             #interconnect-cells = <1>;
+             qcom,bcm-voters = <&apps_bcm_voter>;
+      };
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

