Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 456B62A6A4D
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 17:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731425AbgKDQtr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 11:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731472AbgKDQtq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 11:49:46 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16455C0613D3;
        Wed,  4 Nov 2020 08:49:46 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id 126so27996673lfi.8;
        Wed, 04 Nov 2020 08:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G/gWaZVsDrg+B7oJiO/GfuEeS3ySH7bEMjaW24T/nJE=;
        b=ccWrihjAHhkulHQ70bzhiZSEnQyNp//mzVPgwLNcwy58NU6x6EHVJXt0bg7H6ckfjp
         6nxWy9kxJDTswhw1vbgY69ZlPIWn8zLR0vDx22Z4oyvOnr2gpUcJVJ6s9i3EszAX6y+H
         aMXYnXrhWsGnk+1HvI8BWAVMXIkP6KFNgDeQAEYOmgWb1kFz8S4VJxK6Z/dtuSDGU7t7
         sub9cu89dZMxY/tjGhByjNWvOq4aPZjZVFJ0GKmdzMbQign8sgF1rn6HOighSZ4q2RjQ
         w8odjDAWB5scMsfGMgVpoLONwh6ORbFmatrsRPGPkWSM4+Cd8OrliotngJALQLxnLvQn
         UhNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G/gWaZVsDrg+B7oJiO/GfuEeS3ySH7bEMjaW24T/nJE=;
        b=KQlOl2QupCJawXby7nAViDjescpoFUX8WRX12f2CzSP10d58JmGWZzCnIaYBvY899N
         9+FWi6Lj1ldtMPy6ID0+ziWMHf9gQCgrk8Oq4qogI0UiqRcXGzlhwbXEksv4zE4r7AqA
         Xu8clp4tL+7Vrer6QPCEaxTusj5X6peE3X7+ZqyxCzwWlL6t3wJVj+97lsz7Nsa7wa5c
         pw+9yZ7cdp50nI1+Wv6wXZUR+jBoCDMBreyNzLNeVXAZ6UU3/UIMQvqHvvwfw47sHUKJ
         lGnBq70dS0aj7ZiB7ZVc/AsorlZywYNzG0J3rQkOkSa6bhqJ2IyK4JwX7OZCkO1Zhq67
         qGXA==
X-Gm-Message-State: AOAM530BodGZtDcgYzguAk2XWTtnPl9U34YMqHar6A0qbONZvIPu5J5v
        PkEnhcHGwL2Yqqs4xK0cTnY=
X-Google-Smtp-Source: ABdhPJxeuKyJpt41bYMUa63HVmZKLXHDeIqS5FU59NXW9QJP9vR3xVUp6iPAf5ojcqJ1hR07YmjErw==
X-Received: by 2002:a19:c97:: with SMTP id 145mr10418006lfm.81.1604508584629;
        Wed, 04 Nov 2020 08:49:44 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id m2sm454587lfo.25.2020.11.04.08.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:49:44 -0800 (PST)
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
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v7 12/47] dt-bindings: memory: tegra124: mc: Document new interconnect property
Date:   Wed,  4 Nov 2020 19:48:48 +0300
Message-Id: <20201104164923.21238-13-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104164923.21238-1-digetx@gmail.com>
References: <20201104164923.21238-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Memory controller is interconnected with memory clients and with the
External Memory Controller. Document new interconnect property which
turns memory controller into interconnect provider.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../bindings/memory-controllers/nvidia,tegra124-emc.yaml     | 1 +
 .../bindings/memory-controllers/nvidia,tegra124-mc.yaml      | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml
index 278549f9e051..8ae3dae42d6e 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml
@@ -345,6 +345,7 @@ examples:
 
         #iommu-cells = <1>;
         #reset-cells = <1>;
+        #interconnect-cells = <1>;
     };
 
     external-memory-controller@7001b000 {
diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml
index 84d0339505b1..7b18b4d11e0a 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml
@@ -40,6 +40,9 @@ properties:
   "#iommu-cells":
     const: 1
 
+  "#interconnect-cells":
+    const: 1
+
 patternProperties:
   "^emc-timings-[0-9]+$":
     type: object
@@ -104,6 +107,7 @@ required:
   - clock-names
   - "#reset-cells"
   - "#iommu-cells"
+  - "#interconnect-cells"
 
 additionalProperties: false
 
@@ -119,6 +123,7 @@ examples:
 
         #iommu-cells = <1>;
         #reset-cells = <1>;
+        #interconnect-cells = <1>;
 
         emc-timings-3 {
             nvidia,ram-code = <3>;
-- 
2.27.0

