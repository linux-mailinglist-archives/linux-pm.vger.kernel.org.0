Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DDB789B23
	for <lists+linux-pm@lfdr.de>; Sun, 27 Aug 2023 05:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjH0D2j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 26 Aug 2023 23:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjH0D2K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 26 Aug 2023 23:28:10 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BDB1BF
        for <linux-pm@vger.kernel.org>; Sat, 26 Aug 2023 20:28:07 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4ff8f2630e3so3295388e87.1
        for <linux-pm@vger.kernel.org>; Sat, 26 Aug 2023 20:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693106885; x=1693711685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3g6MqdL49Zw746Urhy4bMomELw3at37JA0MQmf1GuE=;
        b=gZk56rsSYpXAtZqre3gL4WDl+llYm5Y/XTTsBsqgcBqBQjzzQaPHSBKjjhoktElCIU
         YSCz19InOb9kqtX51/vxWYqCwzzwaZX67t4eZNTeLIIhsDhO6XbsSCSE5zSqPwsxB48G
         qrJG0ZeX6n27VTUZMfVzl3vAtnOzzLnvXBM0YrgmAoQJ/KCr28rxNHnnfzEoKDmzYoq5
         c7Cel9JOe10uJYXJZfcbmGezlHZapIszYnj5TvIErU0gWnUmgvVVtIS4Oh7kfxtLtE1a
         fkd63af0itIVNH7bpiM3KTV1KIpYvLjWABP+W+Fn0lh38L7YZxx8Tg05ZI50yhY/d8Z3
         3tEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693106885; x=1693711685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t3g6MqdL49Zw746Urhy4bMomELw3at37JA0MQmf1GuE=;
        b=SpUTp2uwkxSvVwKK8D+b6TuylKUIQ26yT3cm7I1RVcuBdRTXss5Mmu6wJsvjJOnZqz
         QD+g21pygZfVY8vFYFqPc1Rl/wNwLglgBrhsMOrmOfcUIOYSZDte565YygBakDcL9CK7
         tsZESrYa7H4qzkBj+qaeil6HdghtIw7xfdGedXifmg7B8oRWRp4Yx5WSMNt0xGYyEE4Z
         FZTdirdkEV1BSzz+wAW7GMdE4dk4qaMsg0P9RdElC0e6w22r2Q8cgIny6WToAY9W+xa9
         TIDNUb8Dedlr5JpKB/WNMBX7LGTODt4CHfJLdoO7axDNvmB8HQw7Q8FaU5YHoFp3xsyh
         DzFw==
X-Gm-Message-State: AOJu0YzAWWTSAa8TnprORWc2hlFnRT7o2oagFn0pyNQxGrQdA+zJKzzl
        XbYRLI5/YfS1rzqTIRCSoj125g==
X-Google-Smtp-Source: AGHT+IFlwxRzeXJbJzLv94IcpMX3D6twL2DPEVf13PUuJa+IErq+Vxh/s+6EYL1dtdv/ufVKhAWDwA==
X-Received: by 2002:a19:6705:0:b0:4f8:7513:8cb0 with SMTP id b5-20020a196705000000b004f875138cb0mr13589811lfc.2.1693106885517;
        Sat, 26 Aug 2023 20:28:05 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id w7-20020ac254a7000000b004fb99da37e3sm955709lfk.220.2023.08.26.20.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 20:28:05 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/6] dt-bindings: opp: opp-v2-kryo-cpu: support Qualcomm Krait SoCs
Date:   Sun, 27 Aug 2023 06:27:58 +0300
Message-Id: <20230827032803.934819-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230827032803.934819-1-dmitry.baryshkov@linaro.org>
References: <20230827032803.934819-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Exted the opp-v2-kryo-cpu.yaml to support defining OPP tables for the
previous generation of Qualcomm CPUs, 32-bit Krait-based platforms.

It makes no sense to use 'operating-points-v2-kryo-cpu' compatibility
node for the Krait cores. Add support for the Krait-specific
'operating-points-v2-krait-cpu' compatibility string and the relevant
opp-microvolt subclasses properties.

The listed opp-supported-hw values are applicable only to msm8996 /
msm8996pro platforms. Remove the enum as other platforms will use other
bit values. It makes little sense to list all possible values for all
the platforms here.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../devicetree/bindings/opp/opp-v2-kryo-cpu.yaml     | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
index bbbad31ae4ca..4e84d06d5ff9 100644
--- a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
+++ b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
@@ -26,7 +26,9 @@ description: |
 
 properties:
   compatible:
-    const: operating-points-v2-kryo-cpu
+    enum:
+      - operating-points-v2-krait-cpu
+      - operating-points-v2-kryo-cpu
 
   nvmem-cells:
     description: |
@@ -63,14 +65,16 @@ patternProperties:
           5:  MSM8996SG, speedbin 1
           6:  MSM8996SG, speedbin 2
           7-31:  unused
-        enum: [0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7,
-               0x9, 0xd, 0xe, 0xf,
-               0x10, 0x20, 0x30, 0x70]
+
+          Other platforms use bits directly corresponding to speedbin index.
 
       clock-latency-ns: true
 
       required-opps: true
 
+    patternProperties:
+      '^opp-microvolt-speed[0-9]+-pvs[0-9]+$': true
+
     required:
       - opp-hz
 
-- 
2.39.2

