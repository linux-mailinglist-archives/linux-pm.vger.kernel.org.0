Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15EE27524FA
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jul 2023 16:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjGMOSc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Jul 2023 10:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjGMOSX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jul 2023 10:18:23 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14932710
        for <linux-pm@vger.kernel.org>; Thu, 13 Jul 2023 07:18:21 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fbb281eec6so1323305e87.1
        for <linux-pm@vger.kernel.org>; Thu, 13 Jul 2023 07:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689257900; x=1691849900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9RUZ+b+emtSv+giCmXNPmhFjp4/hvFKRq4dSR9PST4=;
        b=r86Mnb2sxhN41eDyo1Lz3DzPrPX5ROyFP2J8LlwjDP1AtlgU+TxSvGJvGeLL3wkoWe
         Cb/9weYQqYWEfbFh/CGQ0qj1uMrbTjRVm48CrwWAgz6Y1MMTsKH4gmUGrNeNyPmgnzoz
         I/lRNDtExpc8KFid2vfy61dek6hP6EL7lhcqHIg+6fNcbv8IyVCACsNT+TLUf24d1Wcd
         HxukzMnGtuRHc6Ed/GxXF3lVfclBTHVjen4UXtsoLBJcsF5ECT0Ib/252D7fRnXTQPsj
         bBZYHJvq76LatXZ4tmyrPlz9q2T5vpHcPMqavsHn6wsyfsqtqguhWOzDdUpPOw7yRDwr
         qWvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689257900; x=1691849900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B9RUZ+b+emtSv+giCmXNPmhFjp4/hvFKRq4dSR9PST4=;
        b=XVIU0e2IGZWHQxuGvI54aNc5AC0KilxKCghTq06wt32c8Hh5iHnOJyf8LNLG1bc0bw
         Gfwrk2rVMuwOYv86Au89fL9pJoMKHG96SCelt4eq6+NU4VvcxRJcRXQMCYD/lIwiVGD6
         x1VZYaO4lsCtzp6uHh0WHaMB0tzA1FPVUjGtGMVFYxHhPoXTu0ZAJbslvqtbxdhJopSx
         hPgY1FotfEb8FJ1Goy0wxSr1we/5XwUghQcIVvfiSxan2F+SmpgKV+uaqT0lVf+igbbx
         GMG/7ghZEF6/glZJnVZl9ixYutkxQrplRiREon5KfMR/mdWU+oB6eV10IwLIR/vtW/Ax
         ndnA==
X-Gm-Message-State: ABy/qLaGZL0JnSo2XaB+ZtZ86MDbZuR+Ycm9kOXn3WFR7cIxN6Z1EQjH
        kryKGAhJ0ACDELdGnQjVtDvy3g==
X-Google-Smtp-Source: APBJJlEtOIgr9v3RUPf+YyzUMe6ZSl4eV1/I1QKoIJip3wiMXOFRhWk3dok4wqm9bS/PAQBOgcgiZQ==
X-Received: by 2002:a05:6512:31d3:b0:4f8:6d54:72fa with SMTP id j19-20020a05651231d300b004f86d5472famr1770618lfe.2.1689257900089;
        Thu, 13 Jul 2023 07:18:20 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id w28-20020ac2599c000000b004fb759964a9sm1132426lfn.168.2023.07.13.07.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 07:18:19 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v2 08/11] dt-bindings: firmware: arm,scmi: Extend bindings for protocol@13
Date:   Thu, 13 Jul 2023 16:17:35 +0200
Message-Id: <20230713141738.23970-9-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713141738.23970-1-ulf.hansson@linaro.org>
References: <20230713141738.23970-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The protocol@13 node is describing the performance scaling option for the
ARM SCMI interface, as a clock provider. This is unnecessary limiting, as
performance scaling is in many cases not limited to switching a clock's
frequency.

Therefore, let's extend the binding so the interface can be modelled as a
generic performance domaintoo. The common way to describe this, is to use
the "power-domain" DT bindings, so let's use that.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Updated the DT binding to require "oneOf" #power-domain-cells or
	#clock-cells.

---
 .../devicetree/bindings/firmware/arm,scmi.yaml        | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index b138f3d23df8..563a87dfb31a 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -149,8 +149,15 @@ properties:
       '#clock-cells':
         const: 1
 
-    required:
-      - '#clock-cells'
+      '#power-domain-cells':
+        const: 1
+
+    oneOf:
+      - required:
+          - '#clock-cells'
+
+      - required:
+          - '#power-domain-cells'
 
   protocol@14:
     $ref: '#/$defs/protocol-node'
-- 
2.34.1

