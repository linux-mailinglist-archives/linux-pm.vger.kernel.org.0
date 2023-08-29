Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22AA678CD1E
	for <lists+linux-pm@lfdr.de>; Tue, 29 Aug 2023 21:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbjH2TmU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Aug 2023 15:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjH2TmL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Aug 2023 15:42:11 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB6ECC;
        Tue, 29 Aug 2023 12:42:08 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1a2dd615ddcso1014950fac.0;
        Tue, 29 Aug 2023 12:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693338127; x=1693942927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NPKoiSiySY1NE/rR+uPxD/EA83oI5+cFaQ2ftn6i8F4=;
        b=gKc540qPAprq+yvqHLss92Ky0TRGkiGy3+mDoPCkxYrbkL3mxD/i+tGN0/xvGLh4At
         JGUuERODrWB7HlCxnm5f2FG2yUL3MMeF1GErB4tIA3T7Abz8Ok5RMYyevoytzbLU4FWA
         fft1yw0zBYCAVtdVRXb+8oX52wcCmyhQd8X37sJYhRpUW0rBOk4ZpvVmorHfBB7DXxsj
         yjFNrmfEC3d4sVuQzo9kW06Gl+OWfpwppf5641cJw7iG1mFpE1JY/frxodgc30dnLhbg
         ztZJuSBjD8jBlO1G6hhwsHmM+6z4cqaXf1EfG0rrldCe44ag7KHaEH30V1mRLf6XGu1a
         eLeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693338127; x=1693942927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NPKoiSiySY1NE/rR+uPxD/EA83oI5+cFaQ2ftn6i8F4=;
        b=MWrummjJs2SnVhUicDltvNnCTbB3dXNZpWQLKrjVFyBcpExy80bqLv1QS5XljuhAfN
         Tc+z5QM6yOYzAH8edOVyKMORFS7dClnsTGHMOOBIa14EjImariRfPV0w6cEtbKFLlNPa
         9OwLj4eQKtsnsLqALSTiNcVTAmljV7iNiCEK0/F/51Ok28wJIKcom2MXaREaX5sad29s
         xxTZ2lu5tUlVjNBbiRx1NPLiZCqvR0YanHIpqV7RMFGL6QBuxx5iE/DQ6OzQgsoBsNjz
         rhxFCGSXM2XO2sPqMhWIq2F9yI8PFcXqjALud51KvIkGv/Vttkzx6DdSD6dlKQokRYcg
         ZqBA==
X-Gm-Message-State: AOJu0YxfzN6iNCcoDqlbPrGbIgn2SIwI29gW0G/1rHS4/wqdwtrx8zaf
        FvY2PcAa0gSzRGjvWvtJ5XTo4fpd36w=
X-Google-Smtp-Source: AGHT+IHmjVcj0hotGYjxO6DtTEN9v1w5eyD2B/JqBCDS26BUNSKY19ILlk0YRHMPexL/YbshAzDcNg==
X-Received: by 2002:a05:6871:296:b0:1bf:9fa2:bfa3 with SMTP id i22-20020a056871029600b001bf9fa2bfa3mr191359oae.1.1693338127249;
        Tue, 29 Aug 2023 12:42:07 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:d5ec:d929:1621:6cc6])
        by smtp.gmail.com with ESMTPSA id c21-20020a9d7855000000b006b9848f8aa7sm4905457otm.45.2023.08.29.12.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 12:42:06 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     daniel.lezcano@linaro.org
Cc:     rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/3] dt-bindings: thermal-zones: Document critical-action
Date:   Tue, 29 Aug 2023 16:41:58 -0300
Message-Id: <20230829194200.1901988-1-festevam@gmail.com>
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
Changes since v4:
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

