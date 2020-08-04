Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C3F23B9DA
	for <lists+linux-pm@lfdr.de>; Tue,  4 Aug 2020 13:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730230AbgHDLrO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Aug 2020 07:47:14 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:31310 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730219AbgHDLrN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Aug 2020 07:47:13 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596541633; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=MVVxVLGT/4i7t0OGDZF+z4Ih6RcEKsys29N0Lo9AUmo=; b=YE1YXSZB7NfVO28HwLmTtqM6FiOEuYSPe7cpp936SoAkLJiE5g4Ib0v6j1YXnhiXvVzAXPh2
 HJbhxXePnzRRIegq0CkHkr730AtFzuE6nC2ME/K9ApuBHb6KFmhGG8jGE5xB4V89Fpn52/S3
 yWO44/56FHoUJj7hlEPAoIsi36I=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n16.prod.us-west-2.postgun.com with SMTP id
 5f294ac08ecb2754f903bc2b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 04 Aug 2020 11:47:12
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E83F9C43395; Tue,  4 Aug 2020 11:47:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DA59EC433C9;
        Tue,  4 Aug 2020 11:47:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DA59EC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        bjorn.andersson@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH 1/3] dt-bindings: power: Introduce 'assigned-performance-states' property
Date:   Tue,  4 Aug 2020 17:16:54 +0530
Message-Id: <1596541616-27688-2-git-send-email-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596541616-27688-1-git-send-email-rnayak@codeaurora.org>
References: <1596541616-27688-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

While most devices within power-domains which support performance states,
scale the performance state dynamically, some devices might want to
set a static/default performance state while the device is active.
These devices typically would also run of a fixed clock and not support
dyamically scaling the device's performance, also known as DVFS techniques.
Add a property 'assigned-performance-states' which client devices can
use to set this default performance state on their power-domains.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 .../devicetree/bindings/power/power-domain.yaml    | 47 ++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/power-domain.yaml b/Documentation/devicetree/bindings/power/power-domain.yaml
index ff5936e..48e9319 100644
--- a/Documentation/devicetree/bindings/power/power-domain.yaml
+++ b/Documentation/devicetree/bindings/power/power-domain.yaml
@@ -66,6 +66,16 @@ properties:
        by the given provider should be subdomains of the domain specified
        by this binding.
 
+  assigned-performance-states:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+       Some devices might need to configure their power domains in a default
+       performance state while the device is active. These devices typcially
+       would also run of a fixed clock and not support dyamically scaling the
+       device's performance, also known as DVFS techniques. The list of performance
+       state values should correspond to the list of power domains specified as part
+       of the power-domains property.
+
 required:
   - "#power-domain-cells"
 
@@ -129,3 +139,40 @@ examples:
             min-residency-us = <7000>;
         };
     };
+
+  - |
+    parent4: power-controller@12340000 {
+        compatible = "foo,power-controller";
+        reg = <0x12340000 0x1000>;
+        #power-domain-cells = <0>;
+    };
+
+    parent5: power-controller@43210000 {
+        compatible = "foo,power-controller";
+        reg = <0x43210000 0x1000>;
+        #power-domain-cells = <0>;
+        operating-points-v2 = <&power_opp_table>;
+
+        power_opp_table: opp-table {
+            compatible = "operating-points-v2";
+
+            power_opp_low: opp1 {
+                opp-level = <16>;
+            };
+
+            rpmpd_opp_ret: opp2 {
+                opp-level = <64>;
+            };
+
+            rpmpd_opp_svs: opp3 {
+                opp-level = <256>;
+            };
+        };
+    };
+
+    child4: consumer@12341000 {
+        compatible = "foo,consumer";
+        reg = <0x12341000 0x1000>;
+        power-domains = <&parent4>, <&parent5>;
+        assigned-performance-states = <0>, <256>;
+    };
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

