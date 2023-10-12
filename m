Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED28A7C7559
	for <lists+linux-pm@lfdr.de>; Thu, 12 Oct 2023 19:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379631AbjJLR6u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Oct 2023 13:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347367AbjJLR6s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Oct 2023 13:58:48 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1DFDE;
        Thu, 12 Oct 2023 10:58:46 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9a9f139cd94so201469366b.2;
        Thu, 12 Oct 2023 10:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697133525; x=1697738325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Na7qEhQMzmgECrh7kCLViTW0+wjTG3BvT0gTVRTb1co=;
        b=cKB13n2yKiBD/+PeliRSCVQYcidNla4SJ8EDGAsYzS2/32zgNBqo5nhj7zdmbdyevP
         6OLJoKfqisvvIQ+IGJ/Yri8+idaHbc4G2hhjGMbNVf5Ou0sqeN20GvbxR0XzzEAR6tgB
         OMSDXI1gFF2YGrqDxMIAweyr6BEhW3C63JFOUSky17x8tTj0xW3tTblms8gDZxOZYrAF
         vB/uP2H2LeMHVzlrAdwmJehXLpPq2GSJtK1GU2Lncd2o2oSoOjmx7UtO5zInVsErpuUE
         ydZOpEImveOqnlDQ3S2bLE1fjLQlYBXwHtqLt2LnDvxakfSMby9FUeLLeiwTcBcp0sKU
         IVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697133525; x=1697738325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Na7qEhQMzmgECrh7kCLViTW0+wjTG3BvT0gTVRTb1co=;
        b=KNclR0pOen7fgix9c80TCBLF4VfSt4OiK9g8aCCQt5tSL5/w7z68oKdQnOBXHuHv2r
         qymt4IgAvKo0V5sLz1St+yK4x82MJ5Gszd6idKfg60QnwORD18Uce7C37JyEA+4EB362
         CO2cuwU8xjSZErkq+2YA3dGBxPrHJ1lKnqcz7SW7VOEBd1hjWQdGa27y1MAcLtqyWnOO
         WCw2l4DIhFk/mfzVha8kkYLiAh7WD2nSi6bwdWMOKNZQpuB0yvYIxZAG/ojRKqwB3j77
         TuHIm35cqEzM3sHctSQ8GXKFcIurhEWZ5s++7vRG0qxS+Wa/G7T0W9GxYDtn2/Jq0ghq
         X5tw==
X-Gm-Message-State: AOJu0YyDrkrjKV+c0YlNBBcUg/puCRiSXGCxFEo93L60v2asLE0OmJGT
        B9Q7LdzUUCbZrMOJNOVaM8o=
X-Google-Smtp-Source: AGHT+IFsGm9j0df0xfB5g2DVVwguqau1uG6sbL8fG+3Kle7Qv1Kxdj2UGMlkZhbvgbFmTlKGn6hrfw==
X-Received: by 2002:a17:907:1b11:b0:9ae:6ffd:bdf7 with SMTP id mp17-20020a1709071b1100b009ae6ffdbdf7mr27150064ejc.39.1697133524718;
        Thu, 12 Oct 2023 10:58:44 -0700 (PDT)
Received: from localhost (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id p8-20020a170906b20800b009adce1c97ccsm11335626ejz.53.2023.10.12.10.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 10:58:43 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Jon Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v2 02/13] dt-bindings: thermal: tegra: Document throttle temperature
Date:   Thu, 12 Oct 2023 19:58:23 +0200
Message-ID: <20231012175836.3408077-3-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231012175836.3408077-1-thierry.reding@gmail.com>
References: <20231012175836.3408077-1-thierry.reding@gmail.com>
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

From: Thierry Reding <treding@nvidia.com>

Each throttling configuration needs to specify the temperature threshold
at which it should start throttling. Previously this was tied to a given
trip point as a cooling device and used the temperature specified for
that trip point. This doesn't work well because the throttling mechanism
is not a cooling device in the traditional sense.

Instead, allow device trees to specify the throttle temperature in the
throttle configuration directly so that the throttle doesn't need to be
exposed as a cooling device.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v2:
- rename temperature to temperature-millicelsius and drop $ref
- add hysteresis-millicelsius property

 .../bindings/thermal/nvidia,tegra124-soctherm.yaml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml
index 04a2ba1aa946..0eb6277082fe 100644
--- a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml
+++ b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml
@@ -121,6 +121,20 @@ properties:
               # high (85%, TEGRA_SOCTHERM_THROT_LEVEL_HIGH)
               - 3
 
+          temperature-millicelsius:
+            minimum: -273000
+            maximum: 200000
+            description: The temperature threshold (in millicelsius) that,
+              when crossed, will trigger the configured automatic throttling.
+
+          hysteresis-millicelsius:
+            description: An unsigned integer expressing the hysteresis delta
+              (in millicelsius) with respect to the threshold temperature
+              property above. Throttling will be initiated when the
+              temperature falls below (temperature - hysteresis). This avoids
+              situations where throttling is repeatedly initiated and stopped
+              because of minor temperature variations.
+
           # optional
           # Tegra210 specific and valid only for OCx throttle events
           nvidia,count-threshold:
-- 
2.42.0

