Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56806156C19
	for <lists+linux-pm@lfdr.de>; Sun,  9 Feb 2020 19:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgBISee (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 9 Feb 2020 13:34:34 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:36016 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727847AbgBISee (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 9 Feb 2020 13:34:34 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581273273; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=WEUzY0FPO/OVyoym48sbVljLfX7T73LcByjAThJDfHs=; b=RhxZ4zcJqG7d7Zw0bNKFmfuk8ClXAgGsJp/4+ovo5azVyruwTUmb/r5agUPPhB5soZNjlKFA
 mwRXMgyGSk3T6XIfOw4livxhxGnLWXnW0gG98g4EHiKyN/31+BKOSnua0j0/8LrgthEBwghc
 6OkoTgdbs9CbtxRGvzx8omPmciY=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e4050b7.7f41f9985c70-smtp-out-n02;
 Sun, 09 Feb 2020 18:34:31 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 851FBC447A4; Sun,  9 Feb 2020 18:34:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D8C0CC433A2;
        Sun,  9 Feb 2020 18:34:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D8C0CC433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     robh+dt@kernel.org, georgi.djakov@linaro.org, evgreen@chromium.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mark.rutland@arm.com,
        daidavid1@codeaurora.org, saravanak@google.com, mka@chromium.org,
        linux-pm@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v3 1/6] dt-bindings: interconnect: Convert qcom,sdm845 to DT schema
Date:   Mon, 10 Feb 2020 00:04:06 +0530
Message-Id: <20200209183411.17195-2-sibis@codeaurora.org>
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

Convert the qcom,sdm845 interconnect provider binding to DT schema.

Signed-off-by: David Dai <daidavid1@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 .../bindings/interconnect/qcom,sdm845.txt     | 24 -----------
 .../bindings/interconnect/qcom,sdm845.yaml    | 43 +++++++++++++++++++
 2 files changed, 43 insertions(+), 24 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm845.yaml

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt b/Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt
deleted file mode 100644
index 5c4f1d9116307..0000000000000
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
index 0000000000000..11a495dbfc520
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sdm845.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,sdm845.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title:  Qualcomm SDM845 Network-On-Chip Interconnect
+
+maintainers:
+  - Georgi Djakov <georgi.djakov@linaro.org>
+
+description: |
+   SDM845 interconnect providers support system bandwidth requirements through
+   RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
+   able to communicate with the BCM through the Resource State Coordinator (RSC)
+   associated with each execution environment. Provider nodes must reside within
+   an RPMh device node pertaining to their RSC and each provider maps to a
+   single RPMh resource.
+
+properties:
+  compatible:
+    enum:
+      - qcom,sdm845-rsc-hlos
+
+  '#interconnect-cells':
+    const: 1
+
+required:
+  - compatible
+  - '#interconnect-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+      #include <dt-bindings/interconnect/qcom,sdm845.h>
+
+      apps_rsc: rsc {
+              rsc_hlos: interconnect {
+                      compatible = "qcom,sdm845-rsc-hlos";
+                      #interconnect-cells = <1>;
+              };
+      };
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
