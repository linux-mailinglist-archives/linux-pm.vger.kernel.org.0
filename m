Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C15178B8EB
	for <lists+linux-pm@lfdr.de>; Mon, 28 Aug 2023 22:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232885AbjH1UAt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Aug 2023 16:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233603AbjH1UAN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Aug 2023 16:00:13 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759A01BF;
        Mon, 28 Aug 2023 12:59:33 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3a88b1e18f2so375120b6e.0;
        Mon, 28 Aug 2023 12:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693252772; x=1693857572;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aP6+dVRIoBGtGPfNz9CrWfNgMmha9RxGc0n9+Uhkgj0=;
        b=s5v58lrx3GD+2Oyuom+eJ45FTDZYxJP4QYDwKMoKPUw66V67kiG9ESjMnJenp7+qrj
         Sp4VB0k6TFPkGKB6lKz3uMm57j4LOFHF2pkuabDEO0R0eQElFnGLyEjJE//w0cH8vsrv
         L+PKA0zN/vfGFk+oOGbo0xJLK8Vr1goa7lXi+Yiz3B0/Y0B+6F8NvIn0tTZcD16JK42C
         oX44XtzocFHOoPyQ3zF3I8ib4xjzN9mUORlBxIfpdTfrnalYkWz3UfrN1WAn4reexiyL
         bLYjJwRHPuVANTkpFYoqxBoemSEHyL/6Llolfe88Kyv8ola+bc2vDG2fDIMusupejSZ7
         V+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693252772; x=1693857572;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aP6+dVRIoBGtGPfNz9CrWfNgMmha9RxGc0n9+Uhkgj0=;
        b=XubXdP8rHh/PcmadxnccMK43VQpIc+9GZqol+XMcbrH/2itmHEsXp2bf2XhYkY/Ero
         uuaEGYddn53+2705F7OvLCtRdJ4mOe4BxuH0TJfU9/ZcpVMO7amybKZoGFyExH0d1YU9
         kzMJ1Tr1UYCoJrwsujZX3GBqjaS2fr6efkHszDmZWKdRQ3D2wqmVsbf9FURQezQlxQdY
         1RtQYeCCtbbOZb8FYfn+MQpTVe43N0Ojzq4Oa/sUcjnS9e5PnFP7vgDo7Z/Q69ab/19x
         pVdYx4iHLL0hUOT6HhO54cxhaeXybJONWslyyHMymMXK3LZDQp9W9gX2e4ituIq3W3dZ
         rEtw==
X-Gm-Message-State: AOJu0Yw3kts9JZGtOmPbSmKtkWgxdQ6J7GWnbaVuLV9rxUe5gz88j+cH
        A6l4vd9Tv9YgWwpvF5WhkV0=
X-Google-Smtp-Source: AGHT+IGwuMnGGZNDOiBFhRcGnFXqdt2eSy5Ql9DgoSvYLhsqagICySsEvwFLYdN2drjJ8QXsy+nNgw==
X-Received: by 2002:a05:6808:1599:b0:3a8:7446:7aba with SMTP id t25-20020a056808159900b003a874467abamr19596129oiw.5.1693252772668;
        Mon, 28 Aug 2023 12:59:32 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:3c37:a69d:a4cd:94fc])
        by smtp.gmail.com with ESMTPSA id k24-20020a544698000000b003a9a2362f66sm2254341oic.16.2023.08.28.12.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 12:59:32 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     daniel.lezcano@linaro.org
Cc:     rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Subject: [PATCH v3 1/3] dt-bindings: thermal-zones: Document critical-action
Date:   Mon, 28 Aug 2023 16:59:00 -0300
Message-Id: <20230828195902.1645169-1-festevam@gmail.com>
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

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v2:
- Improve the description. (Krzysztof)
- Don't repeat constraints in free form text. (Krzysztof)
- Remove the enum comments. (Krzysztof)

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

