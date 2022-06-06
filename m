Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C705053EF20
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jun 2022 22:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbiFFUDD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jun 2022 16:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233049AbiFFUC7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jun 2022 16:02:59 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAA2167C9;
        Mon,  6 Jun 2022 13:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654545774; x=1686081774;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6VZJe+H1u7IcCz/2BIlajWQNtu3BE7uJ1VjEkW8AnaM=;
  b=pJBjBR3uNZkErKlc0sXqC/tPtIUhAzMrxfNUkhk5dPENwjETIGeMQucF
   ChYq4d6JwMdyuv7YQWwmfVnWrYDDwyba9axwY9cH/90bV0unfCurM6VSH
   C7QsF1cOcHZEISpTtL7hs1hWtA26Sjf+1xiFwypGmRVN7stdI9DXYV11A
   g=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 06 Jun 2022 13:02:53 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 13:02:53 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 6 Jun 2022 13:02:53 -0700
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 6 Jun 2022 13:02:52 -0700
From:   Anjelique Melendez <quic_amelende@quicinc.com>
To:     <corbet@lwn.net>, <sre@kernel.org>, <robh+dt@kernel.org>
CC:     <vkoul@kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        David Collins <quic_collinsd@quicinc.com>,
        Anjelique Melendez <quic_amelende@quicinc.com>
Subject: [PATCH] dt-bindings: power: reset: qcom-pon: update "reg" property details
Date:   Mon, 6 Jun 2022 13:02:05 -0700
Message-ID: <20220606200203.22938-1-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: David Collins <quic_collinsd@quicinc.com>

Update the description of "reg" property to add the PON_PBS base
address along with PON_HLOS base address.  Also add "reg-names"
property description.

Signed-off-by: David Collins <quic_collinsd@quicinc.com>
Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
---

New patch series to sperate this patch from applied patches.
Last comments from original patch series can be found
https://lore.kernel.org/linux-arm-msm/27515993-18f3-8891-4835-9b6a8d7f86b0@quicinc.com/

 bindings/power/reset/qcom,pon.yaml | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/bindings/power/reset/qcom,pon.yaml b/bindings/power/reset/qcom,pon.yaml
index 353f155d..1d8cf900 100644
--- a/bindings/power/reset/qcom,pon.yaml
+++ b/bindings/power/reset/qcom,pon.yaml
@@ -26,8 +26,26 @@ properties:
       - qcom,pm8998-pon
 
   reg:
-    maxItems: 1
+    description: |
+      Specifies the SPMI base address for the PON (power-on) peripheral.  For
+      PMICs that have the PON peripheral (GEN3) split into PON_HLOS and PON_PBS
+      (e.g. PMK8350), this can hold addresses of both PON_HLOS and PON_PBS
+      peripherals.  In that case, the PON_PBS address needs to be specified to
+      facilitate software debouncing on some PMICs.
+    minItems: 1
+    maxItems: 2
 
+  reg-names:
+    description: |
+      For PON GEN1 and GEN2, it should be "pon". For PON GEN3 it should include
+      "pon_hlos" and optionally "pon_pbs".
+    minItems: 1
+    maxItems: 2
+    items:
+      anyOf:
+        - const: pon_hlos
+        - const: pon_pbs
+        - const: pon
   pwrkey:
     type: object
     $ref: "../../input/qcom,pm8941-pwrkey.yaml#"
-- 
2.35.1

