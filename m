Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C682725FE6
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jun 2023 14:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241065AbjFGMr3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Jun 2023 08:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240931AbjFGMrN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jun 2023 08:47:13 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECA31BE2
        for <linux-pm@vger.kernel.org>; Wed,  7 Jun 2023 05:47:08 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f6454a21a9so524706e87.3
        for <linux-pm@vger.kernel.org>; Wed, 07 Jun 2023 05:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686142026; x=1688734026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yEZ1VzAf/ewGDW/CO5YjzDFKyIheYAdlDwMj1VXqtFc=;
        b=nPt/QsfPsptDpzewzdY7leTqIaUAJpiotvO0q3HqPzfmRErlMhhkfRuG0nRMHSjLBO
         8vmDV4DrC7wghEALhqJhenkRYBm34v31CKfmEpgJiwiIi7GfJf3cL/kE3o0RlgD/TDUx
         KcxT101ueVqqtxYh/wUrXE5us7BGYsrV4dO8K/ZyYDv5TmfZYumby23yLPpsi35zd/w3
         YaUJoH9ZivYsDJ8dPmRiloUWxrAF2yVGnpoQJsnqrnE5G+Llf0CPgza1htQ37ekmWic2
         xA1jjjIEwAG1d4WQsvi+lXv1itWcWXIMaoECCjoWdh0v0dj4x4bAMiQ9+UTNb6Ho1KcH
         7r7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686142026; x=1688734026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yEZ1VzAf/ewGDW/CO5YjzDFKyIheYAdlDwMj1VXqtFc=;
        b=PyNXZXIRCbHWBb47jYkTd9n7KwHc3L4pl3VmRsceX75OR2RA4CE56f/HYhbik5Nhrw
         B28CrM8j975IfFg0ZgBQn8tVVtGA4f1s4qdiMjmNcoKbiyf1SA7Q38+sWoKzwzXUEL01
         6vm4NHreEEfkjvPcELq0M2OEXDWixGJeOr289np8rzMSwvwBLcrvzpE8U2c9BT6xZEtw
         5ljFZgOf2f6gh1uGDHvoxaVqPVMxmfUciqcAhsEV1M22JAq5iytitkfUyByfaMOUWo5Y
         brJv2iBnZST24vd2UUg5SyCEzHm+u3uAA5xb35GZYBXnIC2pWc0liBNoB7oYzXQ32AVu
         REGQ==
X-Gm-Message-State: AC+VfDw8ziPwFvbxC5WwlTpau1p9jcd5XoZyyxHnAX46PWWVDK8MpBEW
        Jz/AqEgRvZKCRUr7BUeAFSGs2g==
X-Google-Smtp-Source: ACHHUZ7oEGJSSteDCq7mlPuEP2JPf6TfeU0SKmori9ql3yVzxm5aBdyrwavRPyxl4ojjTJ0lwm1s7Q==
X-Received: by 2002:a05:6512:14b:b0:4f6:171e:48e with SMTP id m11-20020a056512014b00b004f6171e048emr1979036lfo.22.1686142026612;
        Wed, 07 Jun 2023 05:47:06 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id z7-20020a19f707000000b004f4b3e9e0cesm1781708lfe.297.2023.06.07.05.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 05:47:06 -0700 (PDT)
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
Subject: [PATCH 09/16] dt-bindings: firmware: arm,scmi: Extend bindings for protocol@13
Date:   Wed,  7 Jun 2023 14:46:21 +0200
Message-Id: <20230607124628.157465-10-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607124628.157465-1-ulf.hansson@linaro.org>
References: <20230607124628.157465-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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
generic "performance domain" too. The common way to describe this, is to
use the "power-domain" bindings, so let's use that.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index 5824c43e9893..cff9d1e4cea1 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -145,8 +145,8 @@ properties:
       '#clock-cells':
         const: 1
 
-    required:
-      - '#clock-cells'
+      '#power-domain-cells':
+        const: 1
 
   protocol@14:
     $ref: '#/$defs/protocol-node'
-- 
2.34.1

