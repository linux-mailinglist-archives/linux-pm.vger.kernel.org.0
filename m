Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D0E78EE00
	for <lists+linux-pm@lfdr.de>; Thu, 31 Aug 2023 15:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346308AbjHaNC6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Aug 2023 09:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjHaNC5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Aug 2023 09:02:57 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B857E54;
        Thu, 31 Aug 2023 06:02:52 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1cc69d1f9b1so149498fac.1;
        Thu, 31 Aug 2023 06:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693486971; x=1694091771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=omTIcvMAzt4T+uKQ/8Elpf5Oymi8x72R/c1fzEu2FxU=;
        b=sKJtxX0KZ8WU7YKFqTH53PdA8ZyU/uuMuIyrOWGhoFR+EFHDAU2K+sqKsW9fEY0slX
         cPHfgX/+HbitChEdeix4iAjZitU2vBWhYrcETNcdqo/UqWwa6eRItpEjELLo3yZqKuBB
         cW2fF6b1FOJ9NhATmil1mZERsl2wBGd0cZkStQ3U1WKk/4EsAFfxbTGXU0ZvjEWtrvRs
         LHkopSCoJjs3sBvZA5/EWYXMQXYtNFAPCVeowGKLlLCM8bT7Z49tx/KbOA5258teO9PC
         2A5XmB5QUhi+AUoDJF4o+W49NxIIT7vhQ7EEeRIwSWrBWPBtE8plmxcoIk5Hal0Lh44N
         9P4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693486971; x=1694091771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=omTIcvMAzt4T+uKQ/8Elpf5Oymi8x72R/c1fzEu2FxU=;
        b=NgRu8xPS82H+IQIJBDumDz3SJowwkHTsyboBQ79FnLqFbIB0ILyEqr/8c6csNKRI3k
         +9ueuAoS0Eh3JhSHBv3Iv6qz8h8S/iN11a3Am9Bud5AE6FdwrZ0tBF+ncChbhMXABfNS
         0FJQO/++y4exaQ+Ese9lxbWyWHgYttzNybEe7RMknFAKoi4C6N6S0queXiTq4gC5PCUs
         Ih1DCnyhwTkVlbP8/amY0/2VzHqsS2Vj5iftF3H9kYTlXaTQq1QNRvvBwbCWRGzWKigU
         I3lmNPD2jorCsCUw7C9Rlz3nQOW4byYdOhAiAqWzNE7nrwcIOjbUszVByuwzrkX0136V
         1+TQ==
X-Gm-Message-State: AOJu0Yy4xK1sX5k/F/3SQ6LJs1us88QcchFYfQUkdwvIy6LWTXhH72jq
        RVpvrp0b7o9UEKir2fZIMGI=
X-Google-Smtp-Source: AGHT+IEF5yOFMNIe9c1prdEEOUCGWI9g+SkAzt464rq1BAKEX+giD1VS3xPJoM/RXcdBn7rqcVF4mg==
X-Received: by 2002:a05:6870:2381:b0:1c8:d305:5fac with SMTP id e1-20020a056870238100b001c8d3055facmr5563638oap.4.1693486971545;
        Thu, 31 Aug 2023 06:02:51 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:583a:68ca:f232:6448])
        by smtp.gmail.com with ESMTPSA id zh26-20020a0568716b9a00b001bfd65998aesm802155oab.58.2023.08.31.06.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 06:02:50 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     rafael@kernel.org
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 1/3] dt-bindings: thermal-zones: Document critical-action
Date:   Thu, 31 Aug 2023 10:02:40 -0300
Message-Id: <20230831130242.2290502-1-festevam@gmail.com>
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
Changes since v6:
- None.

 .../devicetree/bindings/thermal/thermal-zones.yaml       | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
index 4f3acdc4dec0..c2e4d28f885b 100644
--- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
+++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
@@ -75,6 +75,15 @@ patternProperties:
           framework and assumes that the thermal sensors in this zone
           support interrupts.
 
+      critical-action:
+        $ref: /schemas/types.yaml#/definitions/string
+        description:
+          The action the OS should perform after the critical temperature is reached.
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

