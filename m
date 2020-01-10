Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4083136631
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2020 05:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731331AbgAJEdV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jan 2020 23:33:21 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:53933 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731177AbgAJEdU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jan 2020 23:33:20 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1578630800; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=GrR/W/SgcUP00nknn2BhxY4oWqjrKnWJ8ganUzPSUHo=; b=u9VVJ/dV6Jv2lCsmjQYATM5LSaFLZDcUM8UVPD35HagYf1fpu//JAATwcu5+M+jzHgChK6g2
 Y/QOQr5Swkg7FcuBAhwZfk5Ggriv36VMfCZZmSX/FtWJv+MrjpwJlHY4J7RSxLfZwYn9FxN1
 a88PePbG/5N8SojgFjc6fiWhPoY=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e17fe8e.7f30e1bf8df8-smtp-out-n02;
 Fri, 10 Jan 2020 04:33:18 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A2594C433A2; Fri, 10 Jan 2020 04:33:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from davidai-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: daidavid1)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8EB6CC4479C;
        Fri, 10 Jan 2020 04:33:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8EB6CC4479C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=daidavid1@codeaurora.org
From:   David Dai <daidavid1@codeaurora.org>
To:     georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        robh+dt@kernel.org
Cc:     David Dai <daidavid1@codeaurora.org>, evgreen@google.com,
        sboyd@kernel.org, ilina@codeaurora.org, seansw@qti.qualcomm.com,
        elder@linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 2/6] dt-bindings: interconnect: Add YAML schemas for QCOM bcm-voter
Date:   Thu,  9 Jan 2020 20:33:00 -0800
Message-Id: <1578630784-962-3-git-send-email-daidavid1@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1578630784-962-1-git-send-email-daidavid1@codeaurora.org>
References: <1578630784-962-1-git-send-email-daidavid1@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add YAML schemas for interconnect bcm-voters found on QCOM RPMh-based
SoCs.

Signed-off-by: David Dai <daidavid1@codeaurora.org>
---
 .../bindings/interconnect/qcom,bcm-voter.yaml      | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml b/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
new file mode 100644
index 0000000..a6bdf6e
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
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
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
