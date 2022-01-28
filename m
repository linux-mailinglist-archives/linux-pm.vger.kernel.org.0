Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23DC649FDAC
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jan 2022 17:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236917AbiA1QKL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Jan 2022 11:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbiA1QKL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Jan 2022 11:10:11 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24C3C061747
        for <linux-pm@vger.kernel.org>; Fri, 28 Jan 2022 08:10:10 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id s6so6224428qvv.11
        for <linux-pm@vger.kernel.org>; Fri, 28 Jan 2022 08:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BW9H3cFAMWnTD35c52x3Htxe4iYr3BTDYJAgx05lFMw=;
        b=TBVZz6piKgCTfaHky7qJRYb4OiK7aZajSS+/10TpPuPGxCBBcV2Gpx2LDqu/T/RWPt
         8wwwxBBOd1n9NCyRISDPaAw6w9ZS+oXRQldKiJK8N/5x6LQaOZennOEBuLm92xovTIyn
         LgFDnyPRKU9tyd/PyCFIwvd4TxED+Is2rpigDaTIYdjZEoqa9t2sq/oUOl1ZQm3N89aP
         ulCGz4gf4DmelRR/K4Rqk+/D4xK60Zu0BUwL3vKbVdKq2rw9drInDSyFeKqdrneczPdY
         Aj6JjKbpb2RgfC0NoHG1itJEMbuHHZ2WfwtppjP4AZTGNxjRaPY/nsOwb4teHWVZuN3Z
         HnwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BW9H3cFAMWnTD35c52x3Htxe4iYr3BTDYJAgx05lFMw=;
        b=1nTr/Ch96qlIpE2yGFMdsRcJVBiqLs+EUhUv7EDL8LrRWTnpFUwMpcnm9SaKqzmqJA
         JV5O2rFZ2E2Sy4rQEtp7dXYg7oi38WWqib0RfaccmazuiO6mq7bl+EcenmKWuooQ4qpa
         WRJ6j1bvKuTPqDVonJcpOxJ9UBveyt828aO987AIZnzyN3iq2lKV+88YXWywzCKew3De
         pDxDoUBGLFioFwa/gdCcNupsi/VZ+pB4KVLY99Brx32gXkqSz5dGsmT+FhzP4UPejvOx
         XB/xDL+Ak6UpCZOZbKwGt09rA6bRKvL9lImshMiskevmkknS46zmX+/OHRfrA9XrXcQF
         l6Sw==
X-Gm-Message-State: AOAM531J16bX1bL4FFNxm6jcqZ0wrrWdGA52P+gOzZwK5+96GKgBZOFK
        3h2ZzA6GPdV8He9bNYIdlyihgA==
X-Google-Smtp-Source: ABdhPJwRIh3C849RZX6hS/6n8q0Ink9qCbIrYeEqnPMjrSUcDhgy8TDSRHB7tWPGDV/RoziOMkXrcQ==
X-Received: by 2002:a05:6214:2261:: with SMTP id gs1mr7640225qvb.125.1643386209903;
        Fri, 28 Jan 2022 08:10:09 -0800 (PST)
Received: from sagittarius-a.sqcorp.co (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id o21sm3339006qtv.68.2022.01.28.08.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 08:10:09 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     djakov@kernel.org, bjorn.andersson@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     jun.nie@linaro.org, shawn.guo@linaro.org, benl@squareup.com,
        dmitry.baryshkov@linaro.org, bryan.odonoghue@linaro.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: interconnect: Create modified msm8939-snoc description
Date:   Fri, 28 Jan 2022 16:10:00 +0000
Message-Id: <20220128161002.2308563-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220128161002.2308563-1-bryan.odonoghue@linaro.org>
References: <20220128161002.2308563-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Subsume msm8939-snoc-mm and msm8939-snoc into the one device.
Looking at the DTS description for this downstream we see that snoc and
snoc_mm share the same address space, the same clocks, indeed the only hint
at all in qcom documentation these to are separate in anyway is boxes drawn
on a diagram.

snoc_mm is in fact simply two higher performance points for multimedia
devices tacked onto the msm8916 snoc which was reused for msm8936/msm8939.

The various client IP blocks make requests to vote for either X0 or GPLL0
clock rates with the multi-media votes indicating a higher operating point.

We don't need to model snoc and snoc_mm separately since the datasheet for
this part shows snoc_mm is not a separate device.

Breaking up snoc into two pieces is a mistake that was made downstream
which we carried over into upstream.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../bindings/interconnect/qcom,rpm.yaml       | 25 +++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
index e4c3c2818119e..1110a242b2132 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
@@ -79,8 +79,6 @@ allOf:
               - qcom,msm8916-snoc
               - qcom,msm8939-bimc
               - qcom,msm8939-pcnoc
-              - qcom,msm8939-snoc
-              - qcom,msm8939-snoc-mm
               - qcom,msm8996-a1noc
               - qcom,msm8996-a2noc
               - qcom,msm8996-bimc
@@ -182,6 +180,29 @@ allOf:
             - description: Aggregate2 USB3 AXI Clock.
             - description: Config NoC USB2 AXI Clock.
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,msm8939-snoc
+
+    then:
+      properties:
+        clock-names:
+          items:
+            - const: bus
+            - const: bus_a
+            - const: bus_mm
+            - const: bus_a_mm
+
+        clocks:
+          items:
+            - description: Bus Clock.
+            - description: Bus A Clock.
+            - description: Bus Clock MultiMedia.
+            - description: Bus A Clock MultiMedia.
+
 examples:
   - |
       #include <dt-bindings/clock/qcom,rpmcc.h>
-- 
2.33.0

