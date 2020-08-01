Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF7B235259
	for <lists+linux-pm@lfdr.de>; Sat,  1 Aug 2020 14:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbgHAMbj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 1 Aug 2020 08:31:39 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:39917 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729048AbgHAMb2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 1 Aug 2020 08:31:28 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596285087; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=hisy07I44yu/agL+79uzriw5tATAjx3B1y5hwSPytJ0=; b=K9AR4NNuWaDZvWyL3aCRs7WEnjvlBccjlGTW5GCJbTZ+agaVniUB2PQJ764K3yzcJG1saXf2
 z4GdwXo4ZSIw/b/k15OzryTmXNrcQEzKbGUCbPXG+CINdRmN7fGawPpl9FncWkdCaPV/5app
 qzTizxW/DABQPBpEqZaZeg77OJM=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f25609390893260dd1d00ae (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 01 Aug 2020 12:31:15
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B8C1CC433A1; Sat,  1 Aug 2020 12:31:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6BD75C43395;
        Sat,  1 Aug 2020 12:31:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6BD75C43395
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     robh+dt@kernel.org, georgi.djakov@linaro.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, jonathan@marek.ca,
        linux-pm@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH 4/7] dt-bindings: interconnect: Add EPSS L3 DT binding on SM8250
Date:   Sat,  1 Aug 2020 18:00:46 +0530
Message-Id: <20200801123049.32398-5-sibis@codeaurora.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200801123049.32398-1-sibis@codeaurora.org>
References: <20200801123049.32398-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add Epoch Subsystem (EPSS) L3 interconnect provider binding on SM8250
SoCs.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 .../devicetree/bindings/interconnect/qcom,osm-l3.yaml          | 1 +
 include/dt-bindings/interconnect/qcom,osm-l3.h                 | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
index b6945c11eb46b..d6a95c3cb26f2 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
@@ -20,6 +20,7 @@ properties:
       - qcom,sc7180-osm-l3
       - qcom,sdm845-osm-l3
       - qcom,sm8150-osm-l3
+      - qcom,sm8250-epss-l3
 
   reg:
     maxItems: 1
diff --git a/include/dt-bindings/interconnect/qcom,osm-l3.h b/include/dt-bindings/interconnect/qcom,osm-l3.h
index 54858ff7674d7..61ef649ae5655 100644
--- a/include/dt-bindings/interconnect/qcom,osm-l3.h
+++ b/include/dt-bindings/interconnect/qcom,osm-l3.h
@@ -9,4 +9,7 @@
 #define MASTER_OSM_L3_APPS	0
 #define SLAVE_OSM_L3		1
 
+#define MASTER_EPSS_L3_APPS	0
+#define SLAVE_EPSS_L3_SHARED	1
+
 #endif
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

