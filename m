Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54BF178DA68
	for <lists+linux-pm@lfdr.de>; Wed, 30 Aug 2023 20:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236843AbjH3SgQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Aug 2023 14:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245487AbjH3PT0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Aug 2023 11:19:26 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DBDE8;
        Wed, 30 Aug 2023 08:19:23 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-5733d11894dso1047750eaf.0;
        Wed, 30 Aug 2023 08:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693408763; x=1694013563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YRqfnUZnc3uxFvV3HrsnMgzxpGHGjPJ2UGCyRPe16Ro=;
        b=Q+z/A4ggrBCdqc7sDQ33EIrrxtqe3fLJBNhMb6VytJEGwyIF8Eo92IWlgryAl9mkki
         lceMD3cpZO8J7wjqe/S7L1bEn1AUNkFTrv2g/kBIptDAvXMXH2cMB2NYbvlXAuUXcIZq
         6O2NGpSj8vlyRSkPNHQzSJfN5zjEeUTaHhgQKagIBv1u8bfUFw+DPgI6wnnl3Nzk4C+F
         Da9o60rIrsZHEeBRlz+eVPxERlq4IXv8nYa2BJoXvwi5TjqAkM5Eojncqfp8W9V/8E4s
         wrasiLy3SaOYCaeC4jgjhFssrT5LGaBnncGOGtxfCx5IXIu8FkTUYASzgmxeCk+COL/C
         FLEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693408763; x=1694013563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YRqfnUZnc3uxFvV3HrsnMgzxpGHGjPJ2UGCyRPe16Ro=;
        b=hZw5mBBWOIP+yYbLRvzFF16SKqI9YOnGvGTkC0rs2+wWzfZMbNwNdsl70Hxktp8WGE
         fNqEHMr3lQl1HuQ5ZsdXBbzY5h7OyijLnzpsr2FMBWBe3LH1fZvr4NVZ+dGYa84ysNHG
         BJjEShv+EfVAO7m72K1s8EMJAnu652sVpCJcrw/Wlg+o9uUpZ2oM32egPd1qw2iGf2zY
         QOpiGlpf0xGrTdL2zFieAyL4IRuntH59VFHYMbvy7/pwFzCO7vAIAPWuNf0B7QpMWFri
         HDGK00HBMf4LACXmIktuY5G5aG+qhI2Cs9d6TAcSBQmXpqMAxRX8ZdHWqwq/mIScXZA+
         Gg7Q==
X-Gm-Message-State: AOJu0YzVK5DVPSv7w8r4kYl4uzFmsCdX8K3F7jxo24vcwBvYDnj+hMS0
        5q0bTDg3Hf/H5pzIWIxY6H/Y8GgEeAc=
X-Google-Smtp-Source: AGHT+IHktPBlSz49uYINVyiNNhDIO7TAVM7OzuEgcvHckysoiQK+MP045yQtnayLIlBeMhfFQ5Wieg==
X-Received: by 2002:a05:6830:459d:b0:6bc:a824:2750 with SMTP id az29-20020a056830459d00b006bca8242750mr2427595otb.2.1693408762641;
        Wed, 30 Aug 2023 08:19:22 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:5158:34be:358c:6304])
        by smtp.gmail.com with ESMTPSA id d24-20020a056830139800b006b884bbb4f3sm5672559otq.26.2023.08.30.08.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 08:19:21 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     rafael@kernel.org
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 1/3] dt-bindings: thermal-zones: Document critical-action
Date:   Wed, 30 Aug 2023 12:19:06 -0300
Message-Id: <20230830151908.2149847-1-festevam@gmail.com>
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
Changes since v5:
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

