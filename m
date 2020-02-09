Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E050156C22
	for <lists+linux-pm@lfdr.de>; Sun,  9 Feb 2020 19:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgBISes (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 9 Feb 2020 13:34:48 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:25961 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727894AbgBISek (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 9 Feb 2020 13:34:40 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581273280; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=X1DMMJQXo1VU729qqJCdDAlGx9YvyZ8G9TJ4ha5wIY8=; b=cJRgj9J+XXqwmJdvyAiFuQVn4U2Pivny5Y8CAbPDRFX2e2uC1UFBJY4/GbJDjkMgGtUDB3X2
 Hx6sZEPjMCzHtBBEtcCD/muLw1ayzX8FtYuiXztEYjE/EXc4Gqb1tEyYKPCM9qWM6jq/mCr6
 I7lgpze1/PIoPjWAgAK1gzQISG0=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e4050bc.7f0668d0c260-smtp-out-n02;
 Sun, 09 Feb 2020 18:34:36 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 47184C447A2; Sun,  9 Feb 2020 18:34:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3A973C447A5;
        Sun,  9 Feb 2020 18:34:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3A973C447A5
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
Subject: [PATCH v3 2/6] dt-bindings: interconnect: Add YAML schemas for QCOM bcm-voter
Date:   Mon, 10 Feb 2020 00:04:07 +0530
Message-Id: <20200209183411.17195-3-sibis@codeaurora.org>
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

Add YAML schemas for interconnect bcm-voters found on QCOM RPMh-based
SoCs.

Signed-off-by: David Dai <daidavid1@codeaurora.org>
Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 .../bindings/interconnect/qcom,bcm-voter.yaml | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml b/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
new file mode 100644
index 0000000000000..5971fc1df08d9
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
+  - Georgi Djakov <georgi.djakov@linaro.org>
+
+description: |
+  The Bus Clock Manager (BCM) is a dedicated hardware accelerator that manages
+  shared system resources by aggregating requests from multiple Resource State
+  Coordinators (RSC). Interconnect providers are able to vote for aggregated
+  thresholds values from consumers by communicating through their respective
+  RSCs.
+
+properties:
+  compatible:
+    enum:
+      - qcom,bcm-voter
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  # Example 1: apps bcm_voter on SDM845 SoC should be defined inside &apps_rsc node
+  # as defined in Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
+  - |
+
+    apps_bcm_voter: bcm_voter {
+        compatible = "qcom,bcm-voter";
+    };
+
+  # Example 2: disp bcm_voter on SDM845 should be defined inside &disp_rsc node
+  # as defined in Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
+  - |
+
+    disp_bcm_voter: bcm_voter {
+        compatible = "qcom,bcm-voter";
+    };
+...
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
