Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBFB0392738
	for <lists+linux-pm@lfdr.de>; Thu, 27 May 2021 08:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhE0GPA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 May 2021 02:15:00 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:62122 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbhE0GO5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 May 2021 02:14:57 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1622096004; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=lXTsfZqPcbDCxCHnsnI5ikdYUjfJEBZAI3C9A6ale4U=; b=vEYfG44NIdrjLa3ykNKbrCWy8vEs1Tpcyd2cPRQGV4KhAsqvsYCLgkNuLNpWYBQDvIonVtSs
 pFpKBAhezpmCjOKPaLKR4g2B2VHXG2Hpq2QrCKqunjUZmDdd+2JX0eEVc0kO7Or6pwWfxRgG
 q20Uc11bqCFYwYzg6f4zB7792i4=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 60af386df752fca66830b2e4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 27 May 2021 06:13:01
 GMT
Sender: rnayak=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 920D7C43460; Thu, 27 May 2021 06:13:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B8009C43217;
        Thu, 27 May 2021 06:12:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B8009C43217
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        bjorn.andersson@linaro.org, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, rojay@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v2 1/3] dt-bindings: power: Introduce 'assigned-performance-states' property
Date:   Thu, 27 May 2021 11:42:27 +0530
Message-Id: <1622095949-2014-2-git-send-email-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622095949-2014-1-git-send-email-rnayak@codeaurora.org>
References: <1622095949-2014-1-git-send-email-rnayak@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

While most devices within power-domains which support performance states,
scale the performance state dynamically, some devices might want to
set a static/default performance state while the device is active.
These devices typically would also run off a fixed clock and not support
dynamically scaling the device's performance, also known as DVFS techniques.
Add a property 'assigned-performance-states' which client devices can
use to set this default performance state on their power-domains.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 .../devicetree/bindings/power/power-domain.yaml    | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/power-domain.yaml b/Documentation/devicetree/bindings/power/power-domain.yaml
index aed51e9..88cebf2 100644
--- a/Documentation/devicetree/bindings/power/power-domain.yaml
+++ b/Documentation/devicetree/bindings/power/power-domain.yaml
@@ -66,6 +66,19 @@ properties:
       by the given provider should be subdomains of the domain specified
       by this binding.
 
+  assigned-performance-states:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+       Some devices might need to configure their power domains in a default
+       performance state while the device is active. These devices typically
+       would also run off a fixed clock and not support dynamically scaling the
+       device's performance, also known as DVFS techniques. The list of performance
+       state values should correspond to the list of power domains specified as part
+       of the power-domains property. Each cell corresponds to one power-domain.
+       A value of 0 can be used for power-domains with no performance state
+       requirement. In case the power-domains have OPP tables associated, the values
+       here would typically match with one of the entries in the OPP table.
+
 required:
   - "#power-domain-cells"
 
@@ -131,3 +144,40 @@ examples:
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

