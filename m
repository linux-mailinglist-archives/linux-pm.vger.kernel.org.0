Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF177B2850
	for <lists+linux-pm@lfdr.de>; Fri, 29 Sep 2023 00:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbjI1WWX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Sep 2023 18:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbjI1WWW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Sep 2023 18:22:22 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3FE1B4;
        Thu, 28 Sep 2023 15:21:39 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c5cc63ce27so22324885ad.0;
        Thu, 28 Sep 2023 15:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695939699; x=1696544499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SN+WpjnbWQ/SgFseTyvAxaRi1FEF0pQJe3jhNkS4sxk=;
        b=h474tLifb8ZTBeEWJIkBSxbkegdJipf6Vknl1cwrYdfXyHzupyQ91T3jdrS8Zv2HgM
         AdN+MaVi7fTfHSWsrIstoO5P67a+UjLwD+2TyrWs59lOeneeHhxm+b5wVAfHAcyXI7cc
         hcCjvKvx3wjnpi2+ioPhqQAzKZj4FYpt5Lv0/eqVg4Vf4gnpH/HiylqEjIxwTWIzessb
         1GBt4c9q5TjDRXIVa9d0jUjA/PXpzG5KAG8riEyfw7Px3OsiD/IfOLsOpeNiWa8RAWq0
         fz5MQVpx7lRzeNXDYI5Pq1yaNu/BXj7QGQd2JfEB4UYy7nWKSebxFT1oupUmRacAPNsX
         bpGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695939699; x=1696544499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SN+WpjnbWQ/SgFseTyvAxaRi1FEF0pQJe3jhNkS4sxk=;
        b=GqSdFbAEciOlrgT8N2wpfINGUHPVHwJxdx8q7z2rc30kQZGBFxi7H+BJbKMMZFCy1V
         quqVHzBKpbN4S0q00a3yv8dWKk31HuVld583gOT+0PX5tIZDNzBVQQvEG+A2hTi2SXn+
         qGMd12+9M/whj0YsCzOjIdkhGqaM4wMky8jud4qqjvYXWIjcTUAtvu6A67VpaSms+GrE
         K8Xc0hh+0gKjSB8l1tme5SqSqfEd0CC2VgFA5M6H/aIQB2QCC5rkHSDFTiiTbQaHCJVE
         fUj2UCGfc4rrCGg7Nsr+hiNEBBDPS7UmwGQW0h6z+PYU2gDri7PrXEXK6TMKfADMqdPV
         /0nw==
X-Gm-Message-State: AOJu0YxW8De4RurVmK2lP595zw2BNXumciLOp+sFCUwMbje0cT08xpSB
        dO0f1zq+id/Lc+6GayR9i5rZ21KOgHE=
X-Google-Smtp-Source: AGHT+IFKC5eW58DWkRcEJ8zCdITc/FL/EvrMuPT1Z3eEzdTvMoFYtFSjSTYoXxg7k0FFa2pdAuNAKw==
X-Received: by 2002:a17:902:e845:b0:1b3:d8ac:8db3 with SMTP id t5-20020a170902e84500b001b3d8ac8db3mr2544181plg.6.1695939698581;
        Thu, 28 Sep 2023 15:21:38 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:386c:ba81:a385:9374])
        by smtp.gmail.com with ESMTPSA id v7-20020a170902b7c700b001c61073b064sm9610002plz.69.2023.09.28.15.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 15:21:37 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     daniel.lezcano@linaro.org
Cc:     rafael@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Subject: [PATCH v3] dt-bindings: thermal: qoriq-thermal: Adjust fsl,tmu-range min/maxItems
Date:   Thu, 28 Sep 2023 19:21:30 -0300
Message-Id: <20230928222130.580487-1-festevam@gmail.com>
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

The number of fsl,tmu-range entries vary among the several NXP SoCs.

- lx2160a has two fsl,tmu-range entries  (fsl,qoriq-tmu compatible)
- imx8mq has four fsl,tmu-range entries. (fsl,imx8mq-tmu compatible)
- imx93 has seven fsl,tmu-range entries. (fsl,qoriq-tmu compatible)

Change minItems and maxItems accordingly.

This fixes the following schema warning:

imx93-11x11-evk.dtb: tmu@44482000: fsl,tmu-range: 'oneOf' conditional failed, one must be fixed:
        [2147483866, 2147483881, 2147483906, 2147483946, 2147484006, 2147484071, 2147484086] is too long

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v1:
- Adjust min/maxItems to cover all NXP SoCs.

 Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml b/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
index ee4780f186f9..60b9d79e7543 100644
--- a/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
@@ -36,7 +36,8 @@ properties:
     description: |
       The values to be programmed into TTRnCR, as specified by the SoC
       reference manual. The first cell is TTR0CR, the second is TTR1CR, etc.
-    minItems: 4
+    minItems: 2
+    maxItems: 7
 
   fsl,tmu-calibration:
     $ref: /schemas/types.yaml#/definitions/uint32-matrix
-- 
2.34.1

