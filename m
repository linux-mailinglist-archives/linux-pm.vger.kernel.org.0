Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD207BBE50
	for <lists+linux-pm@lfdr.de>; Fri,  6 Oct 2023 20:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbjJFSFH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Oct 2023 14:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbjJFSFG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Oct 2023 14:05:06 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C22C6;
        Fri,  6 Oct 2023 11:05:04 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c76ef40e84so4030915ad.0;
        Fri, 06 Oct 2023 11:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696615503; x=1697220303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hk+HMYmdsBSiI3wko9Q700ZyaXdyPZJ6QDWD9D8aPsE=;
        b=K9Adg8vA9t3KF6YnAlHcmvze4uzQeE8WNbQR9jcEVCgI3Gg9g6WcrkVdSBnLhy8LPd
         e6iIeH3FP1Thy11jhLYEZSnQUdaJWTM+fqE2PaDojgVKsT6zGL6XXXV8kMXCAqduGGLL
         2jja62LPL3MicR9P/yqZjxYWF4fVaOjhbsKe6NG2AjwDXuYoy8ZeyVGK7CSm5VnylsKI
         8jlHICXJX5/B7+47eUKb19g6YQylyUN2VR4M4ADeCKXSYb5tps8ZsThJ+aV/iEji1JwL
         An8iBSEpq5skaGBZ04xR731In5I11YaJ6hL3m76OviC6rzH/VqpKNQ2x885VhO6XFmt3
         DXhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696615503; x=1697220303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hk+HMYmdsBSiI3wko9Q700ZyaXdyPZJ6QDWD9D8aPsE=;
        b=G1ZHSKmkEarkDUuvP+w1njNaC/C+RExliIX02t62qgBL2kK94DBlkiDlHzYN4sCJdj
         mulUvHv9gIAojZXQoVeASdvkx4mdRH0UB4BbsoXNVceZ2AXDharuFncO6hAAGIHagR7s
         YFhlV/ifUf6DLRxjEpze06uFuqP3oBrx7Bk4edyjOiSkC1QNbBLFUK+vUuFXYcWDZisw
         jn4wcbLpB9P/RPSIJGWUp3Qy7JFUsWCuQRNZVMs+//u38kl6/j8KocgbqIu5dKVRQcdq
         hhM1tH9xJ6v1aCph9NoLjnNDd0s8yJC6Wyql9QUH+UFt6XAnNuscNuI4Ndx/fbGU/QE4
         1z9Q==
X-Gm-Message-State: AOJu0YxLCCul0EbjsaZ7gCWMGKNzB7k9ETgVcLE5SBYHNotmW1QGHJz/
        trFgU++DAQbNAxQk2VWG7Najal+At50=
X-Google-Smtp-Source: AGHT+IHMT9wrw66+siRHGmq7PA4f3HQHS7miNS9pasTVAwUJXcnycWb+h8LEPFjQaBHOtVVDF4qUGw==
X-Received: by 2002:a17:902:dacd:b0:1b3:d8ac:8db3 with SMTP id q13-20020a170902dacd00b001b3d8ac8db3mr9336899plx.6.1696615502715;
        Fri, 06 Oct 2023 11:05:02 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:d018:9da6:2e69:1658])
        by smtp.gmail.com with ESMTPSA id f11-20020a17090274cb00b001bb1f0605b2sm4165355plt.214.2023.10.06.11.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:05:02 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     daniel.lezcano@linaro.org
Cc:     rafael@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v10 1/4] dt-bindings: thermal-zones: Document critical-action
Date:   Fri,  6 Oct 2023 15:04:50 -0300
Message-Id: <20231006180453.2903342-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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

For example, in a desktop PC, it is desired that a shutdown happens
after the critical temperature is reached.

However, in some embedded cases, such behavior does not suit well,
as the board may be unattended in the field and rebooting may be a
better approach.

The bootloader may also benefit from this new property as it can check
the SoC temperature and in case the temperature is above the critical
point, it can trigger a shutdown or reboot accordingly.

Signed-off-by: Fabio Estevam <festevam@denx.de>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes since v9:
- Emphasize that critical-action should be used with care. (Daniel)

 .../bindings/thermal/thermal-zones.yaml          | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
index 4f3acdc4dec0..f88fbafecb01 100644
--- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
+++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
@@ -75,6 +75,22 @@ patternProperties:
           framework and assumes that the thermal sensors in this zone
           support interrupts.
 
+      critical-action:
+        $ref: /schemas/types.yaml#/definitions/string
+        description: |
+          The action the OS should perform after the critical temperature is reached.
+          By default the system will shutdown as a safe action to prevent damage
+          to the hardware, if the property is not set.
+          The shutdown action should be always the default and preferred one.
+          Choose 'reboot' with care, as the hardware may be in thermal stress,
+          thus leading to infinite reboots that may cause damage to the hardware.
+          Make sure the firmware/bootloader will act as the last resort and take
+          over the thermal control.
+
+        enum:
+          - shutdown
+          - reboot
+
       thermal-sensors:
         $ref: /schemas/types.yaml#/definitions/phandle-array
         maxItems: 1
-- 
2.34.1

