Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CADA799E68
	for <lists+linux-pm@lfdr.de>; Sun, 10 Sep 2023 14:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344946AbjIJM5q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Sep 2023 08:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbjIJM5q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 Sep 2023 08:57:46 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC82ACCD;
        Sun, 10 Sep 2023 05:57:41 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-57328758a72so863493eaf.1;
        Sun, 10 Sep 2023 05:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694350661; x=1694955461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=grqhlL3knoEWtAMfMGLrRQSBW7r6euOi5D/2w+ituKo=;
        b=WpoEbILrCrEkuPExC6rJSRoe3ac7Ps9qMyeNyropOKSGPnp2LQotoRex+Jh8AQOLg6
         0NvWBWRQuKFn8KICehwoic/3/vueimV+cH1/vgbXR+Frxj4vYMF3FeoAIiSwP4/N0TBQ
         w0X0FG+yai7RXmxehohUknKcF7SmQF8aATUOz5a5m81QXY3CzRUS6yJ/BwmkRABmvOpa
         sRyuXb5xRr3YUNEuvKY39EgCraVdZIBKGsiEdExaFKHYq10M7Ga4aAgZ5sgP1iHSbqyw
         j5vBqCzTmLru38mgnTSGkxSTOiLFRIl8SVNuKkAzBPGDafwD1nWOgZMVC+HI+f5lw8W3
         UCVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694350661; x=1694955461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=grqhlL3knoEWtAMfMGLrRQSBW7r6euOi5D/2w+ituKo=;
        b=rCDxh9V/hpOFu2+3GCzJFsq8Qwd3qtwMqstA4nGug2RVSPSGmq7tGyDLiYc0ZhS9Ap
         J024Ug4vONHdUaXVWCTgKMorUiRfEuLYa0yeRaClIp7leaAD3tOTA1gKLpJf+ZkxjNEI
         rA7X6IqZiylfvd/qYX7NZejhdhTS2sQNK0mBdTes46VbyMfBy/0CXvANbKchxYs2aTty
         SS3cpN/HKqwPJkvVHqb71WKiIajguKJh4QACptmh2Q//ifQn+Y6qbCTzHqbgO3DMHZ5v
         IcQROb34N/Pfrb+pC/3swkeDT2NR+ZZI11AcNKBu5/vQtKHmCm7BkA52ogcxKW/Byff4
         ia6g==
X-Gm-Message-State: AOJu0Yy5JfUFE8TV2ZZy1JuZCDlpCLeM3hh9Q5NvTelHaQhdOzjjFrQX
        G7NWM6y/zzs10DU2LfQ7Hqk=
X-Google-Smtp-Source: AGHT+IHEpZvvG/cwJtLIZ6GJX6F/gbDVkukTvAOt3ddIqDWNedydPsmarXIMONisTWx1aZiGxnt7DA==
X-Received: by 2002:a05:6870:b014:b0:1c3:c45b:92a7 with SMTP id y20-20020a056870b01400b001c3c45b92a7mr7378747oae.0.1694350661175;
        Sun, 10 Sep 2023 05:57:41 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:8ae8:e729:67d1:f8d9])
        by smtp.gmail.com with ESMTPSA id y2-20020a056870e3c200b001c4ede43955sm3003140oad.31.2023.09.10.05.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 05:57:40 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     shawnguo@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org,
        linux-pm@vger.kernel.org, linux-imx@nxp.com,
        Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2 1/2] arm64: dts: imx93: Add the TMU interrupt
Date:   Sun, 10 Sep 2023 09:57:25 -0300
Message-Id: <20230910125726.1243652-1-festevam@gmail.com>
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

The Thermal Monitoring Unit (TMU) interrupt is number 83.

Describe it in the devicetree to fix the following schema warning:

imx93-11x11-evk.dtb: tmu@44482000: 'oneOf' conditional failed, one must be fixed:
	'interrupts' is a required property
	'interrupts-extended' is a required property
	from schema $id: http://devicetree.org/schemas/thermal/qoriq-thermal.yaml#

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v1:
- None

 arch/arm64/boot/dts/freescale/imx93.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 6f85a05ee7e1..5d36b7a5bbd5 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -385,6 +385,7 @@ anatop: anatop@44480000 {
 			tmu: tmu@44482000 {
 				compatible = "fsl,qoriq-tmu";
 				reg = <0x44482000 0x1000>;
+				interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_TMC_GATE>;
 				little-endian;
 				fsl,tmu-range = <0x800000da 0x800000e9
-- 
2.34.1

