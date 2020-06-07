Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E08C1F0E9B
	for <lists+linux-pm@lfdr.de>; Sun,  7 Jun 2020 20:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbgFGS7f (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jun 2020 14:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728763AbgFGS5i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jun 2020 14:57:38 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DC7C08C5C4;
        Sun,  7 Jun 2020 11:57:37 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id a9so14202620ljn.6;
        Sun, 07 Jun 2020 11:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cD6QbvUalU2rLnxp32Ky1as2vyVdkG0FzQ7kZtLukL0=;
        b=Zx0/1hMmV7JwuNDcTuFV87FFDLC9+B+dp2Kag8nEP32tfGG5AY7TIUMc5Q7YDrzw2m
         O4i4KTIf5oK4nZn4+oexDWc/UTRN6lcMtPrFqS5enX8R/af9d8R0wKnG5fCtg2cJFC6g
         OQzHs3HBAlv9Lkr8C3Fnk9aaYxFXGE+muRsGNuIHnABt/N5fl+QbyaL6jumFFJnlNPSm
         pfk7CwdRr8ZZJ0FxjpNXw6nQnHfAQk9TTrnaYl02uP8fPEKLhMoghDEQDVvIcmQUKlk5
         pdrxaZcfM2bra4USw9NiHTFEqSyTlmhm6HWHgHhYchrb9QfP0xko0hFciysthIve7UHr
         HYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cD6QbvUalU2rLnxp32Ky1as2vyVdkG0FzQ7kZtLukL0=;
        b=CV/AvR4BxaXLDrtoVMajEwMqQmv8j6GPw7heiFLQ57hiVkSsvUT+WxSbCIKwi3n6yK
         pbBih4n3/FzVqM+69VYdWipcpZVB9bz4c90+J7M+MlBjtxOq1346/JCFGw3OZLBu1m1V
         C3hDzU9ICuuKPrR2URRjRQ20MjGfm0QlTrCZlni2atdoSFJXDl0Vt3e1lROsIvpCgwX7
         19F40NLrPMgole14wh+4EUghE9NlCtNMWjfaDO0ZZIGQH5ny9/4f1UgnNNumD7aPIX7R
         s1n+Bt1/5KgHkCvR5Tu3gjgGPeijMCLRpHDXgbqCzKBoKI9GzLESWoD705od/JhbDjwH
         C/HQ==
X-Gm-Message-State: AOAM530LAuMz4W/hWD07gZ+qqSyADK402eAT1EkoxqyRW8QISMoWtuhk
        ytGFgO9ZPWvRwxM8Sb69NJg=
X-Google-Smtp-Source: ABdhPJxChLqhfKyGO8SHp6W8FYtkQdwFMh936C6G5u6017yDCRww2zRNxFkr6ioy8DMgy7hzU2gVdQ==
X-Received: by 2002:a05:651c:333:: with SMTP id b19mr9508872ljp.204.1591556256356;
        Sun, 07 Jun 2020 11:57:36 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id e21sm3650953ljb.135.2020.06.07.11.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 11:57:35 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 20/39] dt-bindings: memory: tegra30: mc: Document new interconnect property
Date:   Sun,  7 Jun 2020 21:55:11 +0300
Message-Id: <20200607185530.18113-21-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200607185530.18113-1-digetx@gmail.com>
References: <20200607185530.18113-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Memory controller is interconnected with memory clients and with the
external memory controller. Document new interconnect property which
turns memory controller into interconnect provider.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../bindings/memory-controllers/nvidia,tegra30-mc.yaml       | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.yaml
index 84fd57bcf0dc..5436e6d420bc 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.yaml
@@ -57,6 +57,9 @@ properties:
   "#iommu-cells":
     const: 1
 
+  "#interconnect-cells":
+    const: 1
+
 patternProperties:
   "^emc-timings-[0-9]+$":
     type: object
@@ -120,6 +123,7 @@ required:
   - clock-names
   - "#reset-cells"
   - "#iommu-cells"
+  - "#interconnect-cells"
 
 additionalProperties: false
 
@@ -135,6 +139,7 @@ examples:
 
         #iommu-cells = <1>;
         #reset-cells = <1>;
+        #interconnect-cells = <1>;
 
         emc-timings-1 {
             nvidia,ram-code = <1>;
-- 
2.26.0

