Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3689A7C64BE
	for <lists+linux-pm@lfdr.de>; Thu, 12 Oct 2023 07:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377186AbjJLFpj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Oct 2023 01:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbjJLFpi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Oct 2023 01:45:38 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13BBC6
        for <linux-pm@vger.kernel.org>; Wed, 11 Oct 2023 22:45:34 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-57b8cebf57dso337577eaf.0
        for <linux-pm@vger.kernel.org>; Wed, 11 Oct 2023 22:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697089534; x=1697694334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=emz03f3uxdP7Dq6lqeINaZBEdrIm5oTH0vEaEEX0iS4=;
        b=cPOboPIuiGULl4ywyZ+vTEQcal+KjFCxEMwe15M2MbtNNriSed1lShRfcXNd79Goer
         vKpixXkX+1Dw1vvpzyX7zYh0c0fMTR4KTgXyXExgM+D528MdTxjF33+pERUVPYG81D+N
         CezrrKC0Rm6J/I5E/R9TADosnlXtou/t/157XBl+/l1wAdg4sM9UHR4a0WfLyJvbUzrc
         SIIe6GxvwQLxDnmBSk/PdPW99pQOth0EbxojzjucdinhR7u7oDMHZEKraKn0ArLNX2/b
         cV3bhIcKQNwHjLH6kLypQSx81wi1gPb2VWoeaLs8D1sGbuBzcjdK3b7u1d2HrmSd5V61
         30EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697089534; x=1697694334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=emz03f3uxdP7Dq6lqeINaZBEdrIm5oTH0vEaEEX0iS4=;
        b=O0QV8OcigccSVjw5U0uSTZCswcR00VuZbztXZkrPVWy/lOYphnAIWv/g9j5ChoDEaY
         B2qm2+LYIfol2hmHPIMa+76AQvFbBCjYdUkAEGgEBHhqZA3I41N5e/qm5xtW03eEhb2f
         fW6gVIG4VbgaOUP/9QF2FQf16fl8oK0YEgGJN/uWHTxX6IR0R+4mkX4R/VkUNOfIek0r
         S+iIkQmxgeGYvVRhXsL6V6SBzh+9hsgPtuxh5WLUhd40cpb7MTc/XC1unSOmtg3mWgrL
         QxhRF5ytCfq95TXk1MxtLOudAYzvnaWXxAb89jWkvIBwB4elRrdZ/f80R5M9D6O1E4ON
         PxKw==
X-Gm-Message-State: AOJu0YykEzBf/5AeLwbn2FPzPzZ1U9ysTpn/F7qnSQjnSHfhzJMsPpJb
        V2j0x+xPIdjM2KzIHYRwENUl
X-Google-Smtp-Source: AGHT+IEa4ITQ7yK7AB4m1jUONyc64PhUz5xW9XA5u9AoOeAABMbEGbk8OhiCUuiI4hpIBoDJrwXKCg==
X-Received: by 2002:a05:6870:2c99:b0:1e9:a741:44f3 with SMTP id oh25-20020a0568702c9900b001e9a74144f3mr2647290oab.14.1697089534033;
        Wed, 11 Oct 2023 22:45:34 -0700 (PDT)
Received: from localhost.localdomain ([120.138.12.180])
        by smtp.gmail.com with ESMTPSA id c5-20020a633505000000b0057cb5a780ebsm812396pga.76.2023.10.11.22.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 22:45:33 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v6 1/5] dt-bindings: ufs: common: add OPP table
Date:   Thu, 12 Oct 2023 11:15:08 +0530
Message-Id: <20231012054512.10963-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231012054512.10963-1-manivannan.sadhasivam@linaro.org>
References: <20231012054512.10963-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Except scaling UFS and bus clocks, it's necessary to scale also the
voltages of regulators or power domain performance state levels.  Adding
Operating Performance Points table allows to adjust power domain
performance state, depending on the UFS clock speed.

OPPv2 deprecates previous property limited to clock scaling:
freq-table-hz.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../devicetree/bindings/ufs/ufs-common.yaml   | 35 +++++++++++++++++--
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/ufs/ufs-common.yaml b/Documentation/devicetree/bindings/ufs/ufs-common.yaml
index bbaee4f5f7b2..985ea8f64de8 100644
--- a/Documentation/devicetree/bindings/ufs/ufs-common.yaml
+++ b/Documentation/devicetree/bindings/ufs/ufs-common.yaml
@@ -20,11 +20,25 @@ properties:
       items:
         - description: Minimum frequency for given clock in Hz
         - description: Maximum frequency for given clock in Hz
+    deprecated: true
     description: |
+      Preferred is operating-points-v2.
+
       Array of <min max> operating frequencies in Hz stored in the same order
-      as the clocks property. If this property is not defined or a value in the
-      array is "0" then it is assumed that the frequency is set by the parent
-      clock or a fixed rate clock source.
+      as the clocks property. If either this property or operating-points-v2 is
+      not defined or a value in the array is "0" then it is assumed that the
+      frequency is set by the parent clock or a fixed rate clock source.
+
+  operating-points-v2:
+    description:
+      Preferred over freq-table-hz.
+      If present, each OPP must contain array of frequencies stored in the same
+      order for each clock.  If clock frequency in the array is "0" then it is
+      assumed that the frequency is set by the parent clock or a fixed rate
+      clock source.
+
+  opp-table:
+    type: object
 
   interrupts:
     maxItems: 1
@@ -75,8 +89,23 @@ properties:
 
 dependencies:
   freq-table-hz: [ clocks ]
+  operating-points-v2: [ clocks, clock-names ]
 
 required:
   - interrupts
 
+allOf:
+  - if:
+      required:
+        - freq-table-hz
+    then:
+      properties:
+        operating-points-v2: false
+  - if:
+      required:
+        - operating-points-v2
+    then:
+      properties:
+        freq-table-hz: false
+
 additionalProperties: true
-- 
2.25.1

