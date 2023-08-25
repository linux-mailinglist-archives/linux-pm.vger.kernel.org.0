Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863117884E4
	for <lists+linux-pm@lfdr.de>; Fri, 25 Aug 2023 12:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjHYK00 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Aug 2023 06:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244407AbjHYKZ6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Aug 2023 06:25:58 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBEA213C;
        Fri, 25 Aug 2023 03:25:55 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6bc57401cb9so113958a34.0;
        Fri, 25 Aug 2023 03:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692959154; x=1693563954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lChd/SApErGIwbFJ4qqX7l4KF8OgUcq2GE8XgvnXy8g=;
        b=nKFmeiC+68/cXbnNU/dCC08Eb25EPsfmBdqzDEppzu1+dkqW9d2Pliv/PuRY5Y88Pk
         TOPB98C1UXa318lT3u5aLXZayyhunKfMQnq6cOdISAUX4qCuliRXw9iqOHr8ys2l9NgV
         Zv9iv1CdRhh9KnHD/4DHAJnB9TzTbrWuMCqDm0FnnWOLOH3eDnqyvuL8IXd5kCSIYOcl
         bDU/WlWGBwKA0W74bYZUnFPv/lbHnvCKRr4GHB37Fyn96XFTK3c1FeWH1NiQZoUY/yMG
         JZD062TPtRHz+VYwCin96SiQeqC7j9bXCto8ZRTx/UFjIzSyM1jiBby0/JcSCqgQaCCp
         qfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692959154; x=1693563954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lChd/SApErGIwbFJ4qqX7l4KF8OgUcq2GE8XgvnXy8g=;
        b=F2IG3rHtQKc+ZaQB8IFoiy/RsL2lIbgmHeOlYrXdq8hjoFNF5/SVYVUh5XH8dDWhb2
         rvH/POS8sMp8BhnTDGszVnX1RkP4/imGSCZGcMX/JyRFR+GHhWduoIMOWafbKq+40wQy
         dgsbsffJ4LKzD7SPk+Jag8aOfWze8sYDqy70RmNPDBg0ea33vpc7LOqW4tjsSQmCgglW
         Kz56wJE7UNTF0kJTdu9DSAFn9fRkJxxAjVOE0AD6YYocA4kUd3gcFLJopoYDgyahS+a6
         m8n2fwUTlKN6UsjBbnxLQmiO4RUj8Uu4fXaHeDKhAZuFpNkV9PEFy/+VQRqJPEM0H9sh
         CdTw==
X-Gm-Message-State: AOJu0YzgjM95yQ9QNH+ipIybZnxMZyy3sXEgOxpage4Ka6WVv1YgLJWV
        r2CTCOPyolSWAqaE/rh4QLlij30vP1w=
X-Google-Smtp-Source: AGHT+IHWPt4qLGFrEuR4p/3V/GdcPng6db4OjyXoOgFLvVBiQfoPtK+uNfbKj9toAxamYnGYlb8tXg==
X-Received: by 2002:a05:6870:ecab:b0:1c8:bbd0:2fd5 with SMTP id eo43-20020a056870ecab00b001c8bbd02fd5mr22645791oab.4.1692959154289;
        Fri, 25 Aug 2023 03:25:54 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:3d89:37d3:ba11:1a82])
        by smtp.gmail.com with ESMTPSA id eb37-20020a056870a8a500b001bf3942ea12sm835916oab.1.2023.08.25.03.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 03:25:53 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     daniel.lezcano@linaro.org
Cc:     rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Subject: [PATCH 1/4] dt-bindings: thermal-zones: Document critical-action
Date:   Fri, 25 Aug 2023 07:24:50 -0300
Message-Id: <20230825102453.836627-1-festevam@gmail.com>
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

The possible values are:

- 0 for shutdown
- 1 for reboot.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 .../devicetree/bindings/thermal/thermal-zones.yaml        | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
index 4f3acdc4dec0..782cbb4ea487 100644
--- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
+++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
@@ -75,6 +75,14 @@ patternProperties:
           framework and assumes that the thermal sensors in this zone
           support interrupts.
 
+      critical-action:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          The action that happens after the critical temperature is reached.
+          Possible values are 0 for shutdown and 1 for reboot.
+
+        enum: [ 0, 1 ]
+
       thermal-sensors:
         $ref: /schemas/types.yaml#/definitions/phandle-array
         maxItems: 1
-- 
2.34.1

