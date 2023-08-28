Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4F478B2C1
	for <lists+linux-pm@lfdr.de>; Mon, 28 Aug 2023 16:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjH1OO3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Aug 2023 10:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjH1OOO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Aug 2023 10:14:14 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400E5E7;
        Mon, 28 Aug 2023 07:14:12 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6bb1133b063so305804a34.1;
        Mon, 28 Aug 2023 07:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693232051; x=1693836851;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZvuJ7yib7Qh1rYSqHXrFs3LlKgRFn22xpMnqYQXncj0=;
        b=kaxEAx9Jr8UhC4FGucZ/Q+huBydS0on8NPs+X+Qpl+6zCPi4G9/YUNNr1U9lx3Ekj1
         CFr5lLSbmY0nrN1Ppvl1xyjLkfW76ZVQG4xslOwX/fP2leZKxIIZgrs6Iz4aKILSLruV
         nOlbL1DIjr30wtVQZTtN2XtO51iHH3/GJMgoFDPx7tRsR/MOOX57yi+5XY6CLqSYMZDE
         YR08ZeA1gOaRzfbghLdmbaYVFTkD3yRe4kjXIhHVQLwbZ2VsSC1/Py1Zs1G86znbnPUX
         mn/fV6r8jBySjkE8I7ZZqZczzpP1qi6o0xHL5k3sG8YrSrfIBvwRDsLtQn/z09bLO7b4
         kHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693232051; x=1693836851;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZvuJ7yib7Qh1rYSqHXrFs3LlKgRFn22xpMnqYQXncj0=;
        b=QeNbHDl35SAB2TT8Rs7/tlIMo1YWFK9pB5Zq1f9/SkBri6jMIor9deo5qh4m8BI/R1
         m0cR/VQ6/hD2fXbo5m7yVTGWnegbXxSoDdeCUYVYU8bfS+9olXtfj1yjpY4lUS6YIJKb
         KYDX8M/nVCV7ZGAgb/XB9uR2JtzL0K6P5WEZSN8Q+0+pgyi2O6uXMjxCiuAIi0Yz9KAL
         rKnbU6hRKaQxUwZUX8gh6cDSD05F93mFT3Zv/oSpGjGPSHKLLAC/krRNoYuSGa2nkraZ
         IF06Kd1zGXZ6vwvrma/3MTTVDhqw06du5rhXVIO/uwd8aFfh9V1G1+sAXFLz8HckQ63X
         1+0Q==
X-Gm-Message-State: AOJu0YwOC4u/F4lz9cG4xa4CB3+fpqgqyljAWalQXGNLawMBKdIKpzeK
        ciPY3HXzfAagoHQAB6c/sJM=
X-Google-Smtp-Source: AGHT+IGyt6y+8UNi0DgJdFIXSkntcmLgkDt8y6eEpJ/UBkCDo5G6KK1/fb7qGK0oj0lnXYnqnCzNcQ==
X-Received: by 2002:a05:6871:809:b0:1bb:81a1:f44e with SMTP id q9-20020a056871080900b001bb81a1f44emr28734735oap.3.1693232051435;
        Mon, 28 Aug 2023 07:14:11 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:3c37:a69d:a4cd:94fc])
        by smtp.gmail.com with ESMTPSA id l5-20020a056870e90500b001c4ede43955sm4323892oan.31.2023.08.28.07.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 07:14:10 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     daniel.lezcano@linaro.org
Cc:     rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2 1/3] dt-bindings: thermal-zones: Document critical-action
Date:   Mon, 28 Aug 2023 11:13:39 -0300
Message-Id: <20230828141341.1583591-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Fabio Estevam <festevam@denx.de>

Document the critical-action property to describe the thermal
action that will be taken after the critical temperature is reached.

The possible values are "shutdown" and "reboot".

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v1:
- Make 'critical-action' to be of string type.

 .../devicetree/bindings/thermal/thermal-zones.yaml     | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
index 4f3acdc4dec0..a01456356d9f 100644
--- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
+++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
@@ -75,6 +75,16 @@ patternProperties:
           framework and assumes that the thermal sensors in this zone
           support interrupts.
 
+      critical-action:
+        $ref: /schemas/types.yaml#/definitions/string
+        description:
+          The action that happens after the critical temperature is reached.
+          Possible values are "shutdown" and "reboot".
+
+        enum:
+          - shutdown    # Trigger a shutdown after the critical temperature is reached
+          - reboot      # Trigger a reboot after the critical temperature is reached
+
       thermal-sensors:
         $ref: /schemas/types.yaml#/definitions/phandle-array
         maxItems: 1
-- 
2.34.1

