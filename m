Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9697B3BABDB
	for <lists+linux-pm@lfdr.de>; Sun,  4 Jul 2021 09:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhGDHnu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Jul 2021 03:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhGDHnt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Jul 2021 03:43:49 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169B9C061765
        for <linux-pm@vger.kernel.org>; Sun,  4 Jul 2021 00:41:15 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 22-20020a17090a0c16b0290164a5354ad0so12477638pjs.2
        for <linux-pm@vger.kernel.org>; Sun, 04 Jul 2021 00:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y2JvDwp3TfASNY2nYjyfxKqjVkgvIs8uvDCzlvHG2AA=;
        b=cbrduWjiQDcg1zBJYNfFqJlwRhenjmvi02OUBwr8M4hyh8/l3aDFwt2Vy1ZRblRZ6K
         1SOfwbZhNI/1AhuNfkurXrnNtEIQp0pcEel+V7xEswXE8qJW3b2gSmIDaTxUNi7RLeca
         vfuEVL191zztFFkSQ7e2PTS+A641GNx76vDII+QCNt7DEsLVNNUpVsKel1P5tcA6s/6e
         BlLVFtK3093ZAiV7/rjobH8nig1pxRbCgsTXE9da1w3CHhbvHP6cP1yKOjXN1nRWUNEW
         F+Hi1pGWY9ajJzGRZdf4BU4PFhVynDvZm5FRQNSz08BY0JrxQ4LfyJzv5zGRDnzVsZhj
         GwgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y2JvDwp3TfASNY2nYjyfxKqjVkgvIs8uvDCzlvHG2AA=;
        b=bjdLnZHaIa7DJ2YRoOP3r/x/fRaZNUxL6cIyc+vdojNwuogE9HZVjrRodbdKbuPmTe
         XyRFTo1jI3t2RJzlVc87sVuwh2F+/IGovK8kNXLXSjQvOgqS4xItGXBtWsCtzq9uH314
         0it6a7Ar0TKMoeSQRtJdYZfq21Vq20Mw7F3DBp+pGkwTswAXsMZyV4MHRyQfSe6QXd0s
         9o9MZ1rEOpyb4mXuEXoM9mB6YYL7yd+x1rA4vGFHJikX7YnkzERjCgvd3pFEp0X/neis
         6QL6GgcnlfOb7spavk1vXAnXzCRQyaGrFQUnqeTJ1fWEZxTAgbZks2gQYeLqe/2GOXGb
         FR5g==
X-Gm-Message-State: AOAM532W6UuuFKlRd7/R893mJlY+9vI67ym5KkOSfb+iNT0rRpEMPd3a
        a2UTnYhi884GgVWsOosALZwJEA==
X-Google-Smtp-Source: ABdhPJwGmTyodmzASq3EdwqjQVy7NsyVqG3mZlScAbL5o9KQK27DmKnTNeCgdySHHZLmg2TcVtdRPw==
X-Received: by 2002:a17:90a:d506:: with SMTP id t6mr8292715pju.26.1625384474616;
        Sun, 04 Jul 2021 00:41:14 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id gz24sm7052956pjb.0.2021.07.04.00.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 00:41:14 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 2/3] dt-bindings: qcom,pon: Add 'qcom,mode-in-imem' support
Date:   Sun,  4 Jul 2021 15:40:44 +0800
Message-Id: <20210704074045.21643-3-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210704074045.21643-1-shawn.guo@linaro.org>
References: <20210704074045.21643-1-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It's not always the case that reboot mode value gets stored in PON
register.  For example, Sony Xperia M4 Aqua phone (MSM8939) uses a
different set of mode value and stores them in IMEM.  Add property
'qcom,mode-in-imem' to distinguish this mechanism from the existing one.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../bindings/power/reset/qcom,pon.yaml        | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
index 7764c804af1d..a6270e39b7a2 100644
--- a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
+++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
@@ -23,6 +23,10 @@ properties:
   reg:
     maxItems: 1
 
+  qcom,mode-in-imem:
+    description: Reboot mode is stored in IMEM rather than PON register
+    type: boolean
+
 patternProperties:
   "^mode-.+":
     $ref: /schemas/types.yaml#/definitions/uint32
@@ -35,6 +39,7 @@ required:
 additionalProperties: false
 
 examples:
+  # Example 1: Reboot mode is stored in PON register
   - |
     pmic {
         #address-cells = <1>;
@@ -47,3 +52,17 @@ examples:
             mode-recovery = <0x1>;
         };
     };
+  # Example 2: Reboot mode is stored in IMEM
+  - |
+    pmic {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pon@800 {
+            compatible = "qcom,pm8916-pon";
+            reg = <0x860065c>;
+            qcom,mode-in-imem;
+            mode-bootloader = <0x77665500>;
+            mode-recovery = <0x77665502>;
+        };
+    };
-- 
2.17.1

