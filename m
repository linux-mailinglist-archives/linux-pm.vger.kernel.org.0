Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 397BB3F2B21
	for <lists+linux-pm@lfdr.de>; Fri, 20 Aug 2021 13:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239300AbhHTLZA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Aug 2021 07:25:00 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:59621 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239331AbhHTLY6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 20 Aug 2021 07:24:58 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629458661; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=SG52N9WIyiOqT17cKV2tk26WvWqqcDSXT0zoL77AdGM=; b=vnWB5ywKx1mZH2rUN7WjavxAIOBPBVvpEYbbKE0KoKVUseiZ0nDoChT+XsTIiMhSHwwQpnn2
 +1WtwB97VzMoEuzeNAA7PJzNDP4gIbcNAOlElMqcjVazJH1MVWKsNh3P13lftapZ7K0GgHph
 0/1Z/OqyAXbIDYPxQVrNPl7fk7Y=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 611f90d989fbdf3ffe389dac (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 20 Aug 2021 11:24:09
 GMT
Sender: okukatla=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 68EF2C43619; Fri, 20 Aug 2021 11:24:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from okukatla1-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okukatla)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CE631C4338F;
        Fri, 20 Aug 2021 11:23:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org CE631C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Odelu Kukatla <okukatla@codeaurora.org>
To:     georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        evgreen@google.com, Andy Gross <agross@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     sboyd@kernel.org, mdtipton@codeaurora.org, saravanak@google.com,
        okukatla@codeaurora.org, seansw@qti.qualcomm.com, elder@linaro.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: [v7 1/3] dt-bindings: interconnect: Add EPSS L3 DT binding on SC7280
Date:   Fri, 20 Aug 2021 16:53:39 +0530
Message-Id: <1629458622-4915-2-git-send-email-okukatla@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1629458622-4915-1-git-send-email-okukatla@codeaurora.org>
References: <1629458622-4915-1-git-send-email-okukatla@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add Epoch Subsystem (EPSS) L3 interconnect provider binding on SC7280
SoCs.

Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
---
 .../devicetree/bindings/interconnect/qcom,osm-l3.yaml          |  9 ++++++++-
 include/dt-bindings/interconnect/qcom,osm-l3.h                 | 10 +++++++++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
index e701524..919fce4 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
@@ -18,13 +18,20 @@ properties:
   compatible:
     enum:
       - qcom,sc7180-osm-l3
+      - qcom,sc7280-epss-l3
       - qcom,sc8180x-osm-l3
       - qcom,sdm845-osm-l3
       - qcom,sm8150-osm-l3
       - qcom,sm8250-epss-l3
 
   reg:
-    maxItems: 1
+    minItems: 1
+    maxItems: 4
+    items:
+      - description: OSM clock domain-0 base address and size
+      - description: OSM clock domain-1 base address and size
+      - description: OSM clock domain-2 base address and size
+      - description: OSM clock domain-3 base address and size
 
   clocks:
     items:
diff --git a/include/dt-bindings/interconnect/qcom,osm-l3.h b/include/dt-bindings/interconnect/qcom,osm-l3.h
index 61ef649..99534a5 100644
--- a/include/dt-bindings/interconnect/qcom,osm-l3.h
+++ b/include/dt-bindings/interconnect/qcom,osm-l3.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Copyright (C) 2019 The Linux Foundation. All rights reserved.
+ * Copyright (C) 2019, 2021 The Linux Foundation. All rights reserved.
  */
 
 #ifndef __DT_BINDINGS_INTERCONNECT_QCOM_OSM_L3_H
@@ -11,5 +11,13 @@
 
 #define MASTER_EPSS_L3_APPS	0
 #define SLAVE_EPSS_L3_SHARED	1
+#define SLAVE_EPSS_L3_CPU0	2
+#define SLAVE_EPSS_L3_CPU1	3
+#define SLAVE_EPSS_L3_CPU2	4
+#define SLAVE_EPSS_L3_CPU3	5
+#define SLAVE_EPSS_L3_CPU4	6
+#define SLAVE_EPSS_L3_CPU5	7
+#define SLAVE_EPSS_L3_CPU6	8
+#define SLAVE_EPSS_L3_CPU7	9
 
 #endif
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

