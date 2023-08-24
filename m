Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267497875FC
	for <lists+linux-pm@lfdr.de>; Thu, 24 Aug 2023 18:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242676AbjHXQuX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Aug 2023 12:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242730AbjHXQuV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Aug 2023 12:50:21 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA92E51;
        Thu, 24 Aug 2023 09:50:20 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1c530d5468bso3087fac.0;
        Thu, 24 Aug 2023 09:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692895819; x=1693500619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LQzPJ69QFgZSREU/WQOief2g/Hd/McjGIAtKEDDg4Y4=;
        b=qHKIXZqy5mAwolyDls8HzGyC7caP01VtcV3dXMQ58Ksd6nIkv3JmZeSltn/CZfthlk
         kbTbKrKIA+YSGdZs6CJCLGxREU1G4NbE2ZLtdISB7oYgn3hq74MVtLj2m4C/U5QxT1c2
         GLexrd0B8Q1FGNiCotoRIkuyWsWmyS1j5x9p16mDLbeh+YE+UwGozYq2ZPkd1tTdxiDS
         nEpSJvGfNB/Y6m0V9re/c+4qq4697o+yDENLGrLrIFZe6yMhxxnbFRbvlbOgckPDSrid
         OlnNypE2kUow4uBh6eK89z3HA5XLyu+I1iCuCHaS3PMS9949hl8usew78Gf8OstyNUrr
         0epg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692895819; x=1693500619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LQzPJ69QFgZSREU/WQOief2g/Hd/McjGIAtKEDDg4Y4=;
        b=ciIAFGVBGCvOtIrUcaveqSjiOGHwpj+8viOSsJCqe3a3n571WsMlx5NsOC64Yv8wdN
         j++MOD856DrcvEg9Fv4gZPnVXLSkFFqpuuzpGb68bs3Dj5MLFErpQKIlKPRp3MkQ7AOL
         043lNCZ/w5WQcMlaEK4eS2FKVx2bvYnYaDOopSOidXPq7LQ93LL1i1o2SgfQhh3vheoo
         3mZX737qrn0B1lis04W+9CQBjBPzzie6XK4Gcrf4UJnHShHLSVNYN2B79uAuRjIDPVLH
         9Qt6lLUXmSIpjrLnzPDTCatTUYdxk7yyE+6ZDAgivKwUry78x6Lzb3SKyeT+FECr1vKQ
         TEHw==
X-Gm-Message-State: AOJu0YzrkZEBL9J2fj/yLCWaEmIwW/3+LS2fNrJ4mfbBHkrGFDrnSPRE
        ADJWBQWECvH+00rRe6JVQmQ=
X-Google-Smtp-Source: AGHT+IHwtmI4+6vMWUV20/wljnduxoQ+rNOxal9oLmU3GNrp42Ax8ePoatDY25q0ooX9ieGkuCIMsw==
X-Received: by 2002:a05:6870:2199:b0:1bf:dfed:c9a4 with SMTP id l25-20020a056870219900b001bfdfedc9a4mr17975969oae.5.1692895819216;
        Thu, 24 Aug 2023 09:50:19 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:12f9:9354:2260:4588])
        by smtp.gmail.com with ESMTPSA id zf21-20020a0568716a9500b001c51990e2a0sm5697990oab.53.2023.08.24.09.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 09:50:18 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Subject: [PATCH v5 1/2] dt-bindings: imx8mm-thermal: Document nxp,reboot-on-critical
Date:   Thu, 24 Aug 2023 13:50:10 -0300
Message-Id: <20230824165011.569386-1-festevam@gmail.com>
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

Currently, after the SoC reaches the critical temperature, the board
goes through a poweroff mechanism.

In some cases, such behavior does not suit well, as the board may be
unattended in the field and rebooting may be a better approach.

The bootloader may also check the temperature and only allow the boot to
proceed when the temperature is below a certain threshold.

Introduce the 'nxp,reboot-on-critical' property to indicate that the
board will go through a reboot after the critical temperature is reached.

When this property is absent, the default behavior of forcing a shutdown
is kept.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v4:
- None. Went back to using device tree property.

 .../devicetree/bindings/thermal/imx8mm-thermal.yaml         | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/imx8mm-thermal.yaml b/Documentation/devicetree/bindings/thermal/imx8mm-thermal.yaml
index d2c1e4573c32..9ac70360fd35 100644
--- a/Documentation/devicetree/bindings/thermal/imx8mm-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/imx8mm-thermal.yaml
@@ -32,6 +32,12 @@ properties:
   clocks:
     maxItems: 1
 
+  nxp,reboot-on-critical:
+    description: Property to indicate that the system will go through a reboot
+      after the critical temperature is reached. If absent, the system will
+      go through shutdown after the critical temperature is reached.
+    type: boolean
+
   nvmem-cells:
     maxItems: 1
     description: Phandle to the calibration data provided by ocotp
-- 
2.34.1

