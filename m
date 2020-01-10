Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5973A136623
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2020 05:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731307AbgAJEdT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jan 2020 23:33:19 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:50888 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731287AbgAJEdT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jan 2020 23:33:19 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1578630798; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=jfLDRag60kVaE0DhagYRMwlRik2GUKie5xFV4fEFToQ=; b=sUKzox6Wm2pKbTNnitfAptRXG/+qBsT9NGsn7DKMTM2C+ufEcrDOWkq38R8IQgE4jOr4t+n8
 KnCjMTf8BNuaVRp/tmFQEKZfKvjddiaLX0/dhX5eEPALj3yfj9P+J2KwdCwlTvTEc9rD6WTe
 u5wunBVBQH5b+hq1tYG9mbc6MvQ=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e17fe8d.7f9d92362a08-smtp-out-n03;
 Fri, 10 Jan 2020 04:33:17 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A1F13C447A1; Fri, 10 Jan 2020 04:33:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from davidai-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: daidavid1)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 196E1C433CB;
        Fri, 10 Jan 2020 04:33:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 196E1C433CB
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
Subject: [PATCH v2 1/6] dt-bindings: interconnect: Convert qcom,sdm845 to DT schema
Date:   Thu,  9 Jan 2020 20:32:59 -0800
Message-Id: <1578630784-962-2-git-send-email-daidavid1@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1578630784-962-1-git-send-email-daidavid1@codeaurora.org>
References: <1578630784-962-1-git-send-email-daidavid1@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert the qcom,sdm845 interconnect provider binding to DT schema.

Signed-off-by: David Dai <daidavid1@codeaurora.org>
---
 .../bindings/interconnect/qcom,sdm845.txt          | 24 ------------
 .../bindings/interconnect/qcom,sdm845.yaml         | 43 ++++++++++++++++++++++
 2 files changed, 43 insertions(+), 24 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm845.yaml

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
index 0000000..61e0097
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
+  - David Dai <daidavid1@codeaurora.org>
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
