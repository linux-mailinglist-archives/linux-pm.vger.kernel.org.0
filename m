Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2E3785EA8
	for <lists+linux-pm@lfdr.de>; Wed, 23 Aug 2023 19:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236947AbjHWRds (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Aug 2023 13:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234958AbjHWRdr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Aug 2023 13:33:47 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E61FB;
        Wed, 23 Aug 2023 10:33:46 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-570c1364e5eso503965eaf.0;
        Wed, 23 Aug 2023 10:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692812025; x=1693416825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FwlqdGlNb2fSdqkhw4SOtKSTjQqtRCEcXwbk2iTPsLs=;
        b=mJGlhdHghjbvl/TPsGOVA2v5JjkPLbR2Hc3Sm4++Sl1fA6/SZVk74GdTe8QYCTJ2wj
         WqktnQjYbRb25OtlPybZ9LC+4eWUdsjCKfJkETg0yDnw2AvWv4boNV/8AwKt9rWqeASi
         JZXjfw03dsOsWqguq74/r3NiffcYa0glD/VR19YbNuz3qNOuNEh2j2++ZmCIBwN4Rrbu
         i8uzpPYmMPb+e8wSKc6FYabmz2IohBtdvNus2c4L84U25LO0d8fuQv8FYNzXMEaH9uno
         6FR6UMqjJ2cm5VPd5Leyu+XqlH9GFAxCbD/o5ie8Q61lZea51GJzeVeBM0f98s46CBez
         x2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692812025; x=1693416825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FwlqdGlNb2fSdqkhw4SOtKSTjQqtRCEcXwbk2iTPsLs=;
        b=hJ7+q4C4ZtlRMBnmH6KWmVQOl2M+vxmPkLOoS7dMJh1x1bfTtmC5DDKyh4XCEDUP5y
         +qpJ0QXdzSWBGFqHCzZyr7sW1kjsftcwlEGydJGE9DRgWZv1sKkgjS+I6BnBqw9u+Zh6
         +mCW9iexNhaXODja6s3ePboA09kDBP0yVajAfebuckZyEH27lQK52BxyDaRBr8Jcr9wF
         JBEq74vASwHH39OCrjv69mDz2HdPyQvMibEetDq3SJB9fsOvp/A18CCyksIhZEZnGh1y
         SksraZc8NZb0m8+QerDpvLQmRLL0pfzujuNogTSi8k2FfS2o38DDyRjfX8av81dELBa3
         CQlg==
X-Gm-Message-State: AOJu0YzrPBlZ4obCCzS+RkvliuSoa52Kp/fnYtpvXDDo7OOg1M/qp28h
        kAHuitX9Sdz3S8qQJ9TDkf8=
X-Google-Smtp-Source: AGHT+IF5alAbGAScr8G+vTF4uQ56s0FlHwiqn+4+mf5v36BbTIGSeXTWlOlbLwaEjPwnGjSiPtZC7g==
X-Received: by 2002:a4a:37c3:0:b0:570:cad0:fce9 with SMTP id r186-20020a4a37c3000000b00570cad0fce9mr9091111oor.1.1692812025243;
        Wed, 23 Aug 2023 10:33:45 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:ae60:b44a:59b3:894f])
        by smtp.gmail.com with ESMTPSA id a1-20020a4aae41000000b0056d361ca33fsm5949943oon.16.2023.08.23.10.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 10:33:44 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Subject: [PATCH 1/2] dt-bindings: imx8mm-thermal: Document 'nxp,reboot-on-critical'
Date:   Wed, 23 Aug 2023 14:33:33 -0300
Message-Id: <20230823173334.304201-1-festevam@gmail.com>
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

Currently, after the board reaches the critical temperature, the system
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

