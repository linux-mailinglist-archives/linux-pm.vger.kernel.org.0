Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9AE2A6A51
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 17:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731504AbgKDQtw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 11:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731490AbgKDQtt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 11:49:49 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A8EC0613D3;
        Wed,  4 Nov 2020 08:49:48 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id b1so27962111lfp.11;
        Wed, 04 Nov 2020 08:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RsEiBNqevS137X8EgsTINN66YSPI6dqy0hGSUXN1Nl4=;
        b=l0gsx/WOIi+QcOSWIQOGjzVyqftIJLUglBlpPJ+plhlETQraCIxv2lVoACM/kgHZxa
         siE771TZn8MJ6Xi6lXvO2L0NXhWsDbevsF/Z8vfotFQbjb/3YZwUi0idR6s1e39T1T3N
         c9Qt0/JexF7OHne5CT/8NdKAx6zc6qhNgCRc7YajWDLGoRidLr24pGHvZgMYgqgr9/pS
         2lEXNGHw9o2ltXvvPv0yzy1Awe/1+MilQwzp1RCyXnlIsJnPhXQ4YA6EjflowAYuVWyO
         i7iyg17ZOs7yHYNNhzVZX5JTcHeCkFmnWFjad7pnt6HCMcY5PKx9xZJMJGuZgEtCKkjZ
         HwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RsEiBNqevS137X8EgsTINN66YSPI6dqy0hGSUXN1Nl4=;
        b=G90YxhDKqOxEV7FUUMn0P2jaNA33azrdLjf5dS+A1bV0/RwSt+Ysw3DP1IU/ltRtpg
         Y4khDuXw08hC9Acgx4w+WwbVkMa9USmDogyOjfsFl51qp2lM1H7V7kc6LniTGb4omIan
         eq+7X2t+7D+Ep4Ok6kXUWknIeUk2NTnFJiSe6rYb31KpUS8VMKddhv9m50rpThp+Azvt
         bzALQ2XQcdTbLU+Xm2FLDpM8UqyVbVzBW8ZO3C2kAUfI8GqLcSPrRhxQus6mHVNRtSdj
         /A+aTJV6qVSBVaogpG5YpADacK7r13ovdMgoUPzM8rE0vIlzc34rBBAtzXwCt/bduOQi
         Tp/w==
X-Gm-Message-State: AOAM530mOnAjfhsZiLCMv8k2Jy+hwWolk/Z54D+kk/IXQcXPMGoVrK4f
        EqTy9NzX7V5lZZSsPcbxjus=
X-Google-Smtp-Source: ABdhPJz8Dwjo5uSb78kKmSUyVRABa9SgfHctcnMFRcKzAvnBpwfjqTfXnzmZYZRynjQu1olS+RUcQQ==
X-Received: by 2002:a19:e014:: with SMTP id x20mr9473796lfg.444.1604508586969;
        Wed, 04 Nov 2020 08:49:46 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id m2sm454587lfo.25.2020.11.04.08.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:49:46 -0800 (PST)
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
Subject: [PATCH v7 14/47] dt-bindings: memory: tegra124: emc: Document OPP table and voltage regulator
Date:   Wed,  4 Nov 2020 19:48:50 +0300
Message-Id: <20201104164923.21238-15-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104164923.21238-1-digetx@gmail.com>
References: <20201104164923.21238-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Document new OPP table and voltage regulator properties which are needed
for supporting dynamic voltage-frequency scaling of the memory controller.
Some boards may have a fixed core voltage regulator, hence it's optional
because frequency scaling still may be desired.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../memory-controllers/nvidia,tegra124-emc.yaml      | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml
index ac00832ceac1..09bde65e1955 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml
@@ -37,6 +37,15 @@ properties:
     description:
       phandle of the memory controller node
 
+  core-supply:
+    description:
+      Phandle of voltage regulator of the SoC "core" power domain.
+
+  operating-points-v2:
+    description:
+      Should contain freqs and voltages and opp-supported-hw property, which
+      is a bitfield indicating SoC speedo ID mask.
+
 patternProperties:
   "^emc-timings-[0-9]+$":
     type: object
@@ -331,6 +340,7 @@ required:
   - clock-names
   - nvidia,memory-controller
   - "#interconnect-cells"
+  - operating-points-v2
 
 additionalProperties: false
 
@@ -359,6 +369,8 @@ examples:
         clock-names = "emc";
 
         nvidia,memory-controller = <&mc>;
+        operating-points-v2 = <&dvfs_opp_table>;
+        core-supply = <&vdd_core>;
 
         #interconnect-cells = <0>;
 
-- 
2.27.0

