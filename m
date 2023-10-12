Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19C87C755C
	for <lists+linux-pm@lfdr.de>; Thu, 12 Oct 2023 19:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379687AbjJLR6u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Oct 2023 13:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379619AbjJLR6t (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Oct 2023 13:58:49 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0276D8;
        Thu, 12 Oct 2023 10:58:47 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99de884ad25so206765366b.3;
        Thu, 12 Oct 2023 10:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697133526; x=1697738326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0oAnve8cYc6KUjHI3njmCc6tg17dGeZJbr4s0kltN4=;
        b=eCUgyGRjbmBQe+ufO9CcZlZKJsyDZREV7zke4FYsstlJLTrGnKhbhLp8K0eend7eOR
         8G60IoblsvcKOjAaWKh6wFgLfcsJw5e6FDmsTulUpGQrPmAiq7EFnRxIT+RW987TEU+V
         u4ZOc2TcpgzX9XHxGSDukZ52Zc9ag91mn42m2mb4Q6X8AiBXUE3DtP72K7m5930plhoh
         p/t6imtkPZUtbs5FmXibUrs0i2yKpoWkGDp4XA5Z0/LpPdurJnZ/sKst/2jik9YM3FsA
         pwSAcxTGOHI3CqLcFhnH74UFHRoxU1iF34OUAQ0+Ut6zYwaq6wtfarVtzw1fv62mqG9M
         G1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697133526; x=1697738326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q0oAnve8cYc6KUjHI3njmCc6tg17dGeZJbr4s0kltN4=;
        b=j3EIosEyr7hIUCszoyjUYh+ZsPaqL6JO3FAIL9+snwchSpqUdANQqJsFbPardiRqHL
         6KClHEhvgQbCjh4YAtFAWNNDPjr9AcDDKdCdKnRDRIh4dlv3tV2DdO/o+Str3sPRR00b
         +yavrIo0IqNXU3BEhlTpfS9VlshLflt2rrYf9Jahg5/B/VEoybg+sWvPWBHJo+VVCU5l
         JwVO9AvjrKsWE0Yrjn6uRXTMvQQMxrOZ6acYb4W426EyrE0xo8V9A4qmFXx6UcQNK2nI
         44/1vCogCMJLWtWL82/Hdag3bMBLqY2Kk1R5CjxntJ1OcdWcz9UTSx3mvHYEyTJcPhRe
         ybvg==
X-Gm-Message-State: AOJu0YzxjDKAIFF2JCUTtSOhkwZM1ZkaLgL9MMQSa6BkUzHi+tvxUBVC
        WQ1hzEByXuL3dwQ7LZZOAqU=
X-Google-Smtp-Source: AGHT+IHUvOSGncrYRjOb3iBZVORaW42pRMEajVW1II2lJOQdf4sSfG5bya02H7M4bbLWVKlGnkSIbA==
X-Received: by 2002:a17:906:104e:b0:9b2:ba65:db21 with SMTP id j14-20020a170906104e00b009b2ba65db21mr23301796ejj.45.1697133526122;
        Thu, 12 Oct 2023 10:58:46 -0700 (PDT)
Received: from localhost (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id a24-20020a170906685800b009828e26e519sm11283686ejs.122.2023.10.12.10.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 10:58:45 -0700 (PDT)
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
Subject: [PATCH v2 03/13] dt-bindings: thermal: tegra: Add nvidia,thermal-zones property
Date:   Thu, 12 Oct 2023 19:58:24 +0200
Message-ID: <20231012175836.3408077-4-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231012175836.3408077-1-thierry.reding@gmail.com>
References: <20231012175836.3408077-1-thierry.reding@gmail.com>
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

From: Thierry Reding <treding@nvidia.com>

The throttle configurations need to be associated with one or more
thermal zones before they can be enabled, so introduce a new property,
called nvidia,thermal-zones, that contains a list of phandles to the
thermal zones for which a throttle configuration is applicable.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v2:
- new patch to hook up throttling with thermal zones

 .../bindings/thermal/nvidia,tegra124-soctherm.yaml           | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml
index 0eb6277082fe..359344f60a6e 100644
--- a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml
+++ b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml
@@ -161,6 +161,11 @@ properties:
               throttling is engaged after the OC event is deasserted.
             default: 0
 
+          nvidia,thermal-zones:
+            $ref: /schemas/types.yaml#/definitions/phandle
+            description: A list of phandles to the thermal zones that this
+              throttle configuration applies to.
+
   # optional
   nvidia,thermtrips:
     $ref: /schemas/types.yaml#/definitions/uint32-matrix
-- 
2.42.0

