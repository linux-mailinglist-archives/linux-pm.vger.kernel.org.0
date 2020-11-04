Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5C1A2A6A4E
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 17:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731486AbgKDQtt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 11:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731477AbgKDQtr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 11:49:47 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F50BC0613D3;
        Wed,  4 Nov 2020 08:49:47 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id h6so28021278lfj.3;
        Wed, 04 Nov 2020 08:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7VouJsB+vObe9wiNi+HSaArrhjsYuOEOXN6ddwqBmoE=;
        b=i+A+m+U9oG9PJ2GgdcKu6s6FyOrcp/z8e4pJwLBBVNfvCvHQsAQ4TnbFvqLYOle4EK
         b9pbIRk5rVOi7nBO97CfZA6e4/dZvN3QDyH6Bx9ap8RFchDYecE6HfFRoUIuiZqu68gj
         4fUYV5lirqwpjscHeH2QPyfuLwEZyKY/Qr8W/bb/tQEcAzXENNol9OocqavGROzOEmPF
         PNEvyqFQUlaKxbuAHeimpTdNfvoSW0N8rHf7+ANiNWFGxArhNL4EwO85csk4g/SgLbHp
         eBdPaqLN/JiMCH5HWPiCaM1JjsN3oLnisz1hUpci6Xs+pKIlRziVFxecgFFNdkeSk5bZ
         bjxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7VouJsB+vObe9wiNi+HSaArrhjsYuOEOXN6ddwqBmoE=;
        b=QQwk3lCsCKxPrSB+q2TQIB6AcXsp7m6EOXSJlEKGEiKrtPtyCL4DFb0marOk3I3CTM
         FAfL5BRI3cbAlpTyNLdTe9Dlqi2i2Lj9Sx1AXd0gjn9oV9KBdu+c+gt+S1TsVrgxRhF+
         T3zCEOplmxYlCjvb/1icROsP8K/kx6li1xjHI2e9eBKgf93MTjMf/qNNAn0CJgzcqMzm
         axS/Mz/VqC/zRFg4JTnFfJFcFn6rS3eG0UH8uek0iU9In9E8RlVc2njGnY83ZYYrUI5T
         gcIg3okzbkYsXApnja9jA1nG1Q83wtejYKHgB629zbxMlGhLQuV5hzyFLNVZpqNUfNCh
         +VAA==
X-Gm-Message-State: AOAM532sEu56JUJjQRHMXroE6Joz2e2+G4NdFt+eBX1HBA4m6uQbdAk6
        XBvXEMSKYAoK/kGclNk5VsXhTwq6/j4=
X-Google-Smtp-Source: ABdhPJw6FROJUyYHTBPZolgWGE8NhnAwFz7xveT9/gT29SFiGPKdwlSk6tt7dC7CuIkAEG1ySU0n6A==
X-Received: by 2002:a19:5d0:: with SMTP id 199mr5498039lff.69.1604508585799;
        Wed, 04 Nov 2020 08:49:45 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id m2sm454587lfo.25.2020.11.04.08.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:49:45 -0800 (PST)
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
Subject: [PATCH v7 13/47] dt-bindings: memory: tegra124: emc: Document new interconnect property
Date:   Wed,  4 Nov 2020 19:48:49 +0300
Message-Id: <20201104164923.21238-14-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104164923.21238-1-digetx@gmail.com>
References: <20201104164923.21238-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

External memory controller is interconnected with memory controller and
with external memory. Document new interconnect property which turns
External Memory Controller into interconnect provider.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../bindings/memory-controllers/nvidia,tegra124-emc.yaml    | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml
index 8ae3dae42d6e..ac00832ceac1 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml
@@ -29,6 +29,9 @@ properties:
     items:
       - const: emc
 
+  "#interconnect-cells":
+    const: 0
+
   nvidia,memory-controller:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
@@ -327,6 +330,7 @@ required:
   - clocks
   - clock-names
   - nvidia,memory-controller
+  - "#interconnect-cells"
 
 additionalProperties: false
 
@@ -356,6 +360,8 @@ examples:
 
         nvidia,memory-controller = <&mc>;
 
+        #interconnect-cells = <0>;
+
         emc-timings-0 {
             nvidia,ram-code = <3>;
 
-- 
2.27.0

