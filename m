Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCE078C3D3
	for <lists+linux-pm@lfdr.de>; Tue, 29 Aug 2023 14:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbjH2MKI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Aug 2023 08:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbjH2MJl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Aug 2023 08:09:41 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECC11AB;
        Tue, 29 Aug 2023 05:09:37 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1bb3df62b34so667986fac.0;
        Tue, 29 Aug 2023 05:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693310977; x=1693915777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kr5OflaxijlUu3QWgWc7gDYfy7Y4CSexnvGXkJjSwAM=;
        b=Zm4Z9FqLuM4CWgWGXt+m3PEM0MY6wvQDqxP2lvKwLzbN0Wj6rr/cuHyMvDJNUbXrdL
         AxmhYkiW5qWy8gbiHFCZFKl1nEGJVj7mHv7iWQqxPxlGNUwgqZ4GeDpoofTw7LiRCFU5
         MuA+R4cORFgGRoRKYcA3ryxAHdfht4Vf1wT/XllWl6CHG3bDzLidv0AoNEN4hj4UWrLl
         fDp1vBW+konQSgy8F418o/0XriTMVO2YRh0ByzZyeOLCO6KhzG/tNvQp4xuBrn8gcIgZ
         TLiZ8tMpa/Ki2E9jrdHiYmBzmnzkw+JEoHAQwabGge43ORqgbbjIMec3K+eI2xldY+Mk
         IYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693310977; x=1693915777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kr5OflaxijlUu3QWgWc7gDYfy7Y4CSexnvGXkJjSwAM=;
        b=U/bPPXN0SubJapg9isOcO5d4fqnhFi2SpI3YM3r/DBr2w7B5LXplHtnEPHJblwwy5c
         eoNm1nsUszmxbZ7xgpJl56NPgsNl9R2JgDF0gEeiMFYxj6oN/qK3N3bptKFIb1jOTXGi
         wegrdbMI3yKoJ8wKr/v1UQ/+YvBxbCBgGI5nVEXkQjO7/VMpyST2eDvTzlNuN6JLVQ7w
         GXw1gX9iqmI/bphnI+cS7fO4QPoxnqdTrIb8l946ouxX4iya6/MzBX3tV0gYt58c3POK
         OZ6gYSmb5q/9ypj8Jz2YUQx47UAfP3ziTbZ8MRn20A/Fgw5+GgM2WxX9kGHwriejmmHk
         ZUWQ==
X-Gm-Message-State: AOJu0YxEc7FynjOXiUOS4+/bE33twXCVRCBO1vtxcbcrpcTNFiIKMg8O
        M4f57VXWZjix882mguyEQgjVLjsh4aA=
X-Google-Smtp-Source: AGHT+IGACckcLM25XRNoHKJifC7kN6/HoqpQh0ywe/xf0cp4oBMnbfPwa/Gm2ySVxd1CIWp97W80eQ==
X-Received: by 2002:a05:6870:ecab:b0:1c8:bbd0:2fd5 with SMTP id eo43-20020a056870ecab00b001c8bbd02fd5mr35797067oab.4.1693310976789;
        Tue, 29 Aug 2023 05:09:36 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:d5ec:d929:1621:6cc6])
        by smtp.gmail.com with ESMTPSA id zc17-20020a056871271100b001d0ad5205fesm2000651oab.7.2023.08.29.05.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 05:09:35 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     daniel.lezcano@linaro.org
Cc:     rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/3] dt-bindings: thermal-zones: Document critical-action
Date:   Tue, 29 Aug 2023 09:09:22 -0300
Message-Id: <20230829120924.1711175-1-festevam@gmail.com>
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
Changes since v3:
- Explain why this property is needed. (Krzysztof)
- Added Krzysztof's Reviewed-by tag.

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

