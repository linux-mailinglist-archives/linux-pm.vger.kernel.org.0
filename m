Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC697A2D25
	for <lists+linux-pm@lfdr.de>; Sat, 16 Sep 2023 03:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235779AbjIPBuQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Sep 2023 21:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237926AbjIPBtq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Sep 2023 21:49:46 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB96F1BF2;
        Fri, 15 Sep 2023 18:49:40 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6c0ab18e084so330684a34.1;
        Fri, 15 Sep 2023 18:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694828980; x=1695433780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/xuPSclHlLs4o7tZAEr9Oqaj9rM7BhYSGMKkn2Xlw7U=;
        b=IW61rrtjcpZefue1pw5RFD1yWu/DmKI2Irb6Emf05LKsij6wiq8BA61wzQdkRJeRtD
         j8/pfV7oklI6MO6qSvuIcDAEsmy93MsT/Ah7CGXtKPzqM+AsARtgvSuvDLUvqpuZ13fq
         aCU5KlIbobiV40kqH6Rmd2YB1fGKb/rDcGMumd0UVUnCHkm/bykY9NrUUUrUiRDBxbH+
         hzTKQIBKq+FgbhUJTrotLQNhGeyev5UonxMXRSVorIcHng/JFD/WKkMZBgGGb26R1DSk
         ax72l7H/X5CHUqvmO46Ui5E6Sb3oJWxgT4PrG8o2r6NbO51NkLSZqjVeeTci9GAVUpc9
         rQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694828980; x=1695433780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/xuPSclHlLs4o7tZAEr9Oqaj9rM7BhYSGMKkn2Xlw7U=;
        b=kpRSzLGYTmrVHiEbnrhYnGlaLQKREs4aQKxSQvi6gjvMkhS2+RSXOznv1Ub2v9lpQW
         mwStaoMneaM/Ze+URlTaxd57DgTw36G4Qs5/LIF25tSUgp6zTxqNzcU1u34MTe87jBhR
         cjCeMdVamiqE7yZMNrF6Xo/DF/CRJp3IaBkdcCjcXqZc4HvnAZ/wbGvuVW5sgj8xa5vg
         vUebj3LYiR2cdhTGv4/0nsx4cE6B1locT2cYKOZD6BWwTEeAONc4GRehApkI2VTkB0Xv
         mmb7epvZM0xHGdJhnbgpabI6xmwonozTPFW7mGfo4lTSXzBJUzGly8yrv42ApdjGcL+m
         VDOQ==
X-Gm-Message-State: AOJu0YxqLisTG9NvY62SdX4Txhk0X6DOgJDBehJUmLGu/OPr8s0TzSCs
        VMIMUHpua9L89i7PTJ3YLmM=
X-Google-Smtp-Source: AGHT+IEnrdg2UFlAMJmRKoqFTkmjZ8+iLTyvNwpjr/5YB7Y1QSm3vTF0XpBV41lXZwQbETA/e6c5WQ==
X-Received: by 2002:a05:6870:4250:b0:1d5:bda7:132d with SMTP id v16-20020a056870425000b001d5bda7132dmr3393225oac.4.1694828980117;
        Fri, 15 Sep 2023 18:49:40 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:bb17:c38c:aa6:be85])
        by smtp.gmail.com with ESMTPSA id eg38-20020a05687098a600b001c4b473581fsm2519986oab.12.2023.09.15.18.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 18:49:39 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     rafael@kernel.org
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v8 1/3] dt-bindings: thermal-zones: Document critical-action
Date:   Fri, 15 Sep 2023 22:49:26 -0300
Message-Id: <20230916014928.2848737-1-festevam@gmail.com>
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

Document the critical-action property to describe the thermal action
the OS should perform after the critical temperature is reached.

The possible values are "shutdown" and "reboot".

The motivation for introducing the critical-action property is that
different systems may need different thermal actions when the critical
temperature is reached.

For example, a desktop PC may want the OS to trigger a shutdown
when the critical temperature is reached.

However, in some embedded cases, such behavior does not suit well,
as the board may be unattended in the field and rebooting may be a
better approach.

The bootloader may also benefit from this new property as it can check
the SoC temperature and in case the temperature is above the critical
point, it can trigger a shutdown or reboot accordingly.

Signed-off-by: Fabio Estevam <festevam@denx.de>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes since v7:
- Made critical-action a property of the top-level thermal-zone node. (Rafael)

 .../devicetree/bindings/thermal/thermal-zones.yaml        | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
index 4f3acdc4dec0..d28f3fe1045d 100644
--- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
+++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
@@ -48,6 +48,14 @@ properties:
       platform-data regarding temperature thresholds and the mitigation actions
       to take when the temperature crosses those thresholds.
 
+  critical-action:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      The action the OS should perform after the critical temperature is reached.
+    enum:
+      - shutdown
+      - reboot
+
 patternProperties:
   "^[a-zA-Z][a-zA-Z0-9\\-]{1,12}-thermal$":
     type: object
-- 
2.34.1

