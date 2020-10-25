Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A23C29849F
	for <lists+linux-pm@lfdr.de>; Sun, 25 Oct 2020 23:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1418690AbgJYWV4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Oct 2020 18:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1419244AbgJYWSE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Oct 2020 18:18:04 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31B9C0613D0;
        Sun, 25 Oct 2020 15:18:02 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id 23so7704759ljv.7;
        Sun, 25 Oct 2020 15:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3xIGrSZ6X+ak6zBINy7RZS8xGDxf4foS2bMs13tOL/o=;
        b=NkBDiifD/zDI1IWoNVHSzB6BXUKWj0bmzCRUjQkOXjXJj5bbeavfi//sykmu72M926
         uFvgVzhaIyBjIUfhx9xnOQQ1XGwvolTh3TwhuK27A/Rb0g44nJCj7nzx8a22mDYBRBIY
         vQ0fIcq2BYnGgneHw9LIv8Gw/3vrevGk4RYdZkC4hW26eu5gWZUJfU6jN/Enwr7EOe9J
         poGgzrVopKHU18IshUyGeay+S9q1I1aYs0gS5B2XffnX9LowRU+w8YLTAOR+moU3MWNA
         2a25Hq3EzFCJFFOEb86PwAPGbKHp+FM0QqTsYH1xPHgWUfHw/V8jQKbOR2eWxefz3D5N
         J+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3xIGrSZ6X+ak6zBINy7RZS8xGDxf4foS2bMs13tOL/o=;
        b=czk5aZhA63NJ1+DiiJXWpXU5IJ59OUAy/91C8p/kDQhA5SOp6+T5KIn0pXd3TtO5Ie
         phl56180EbtBmAzrrkaeI2xpKp9wEZvF5fq+hneDVTDn+Cm3Z+52UHv1MQllRi0l3jFP
         VSWh7odQsUFrRHbzgKxD2R+bnQ964Zwx9sdLUH5SeSLjkVCs1rJOc4JRrLflmNREllBt
         FhZJVZ2C0n+xBNytqaZyjBN2KIsF2U/TJBKtfji/JS4GvZH7923vV8YAS1dpDqd61LWW
         EP+mjgUsNWp7sP7NqQly5AM4O6HFX+nPOYKUGoUeNts8/biDQZapqTQUn/PY/fPYoKmW
         1LnQ==
X-Gm-Message-State: AOAM5339QNBPgp4ayWGFitByf83iZxp3judMlNXY29PDpdPfBEpruUqd
        ZZI1N+OrtArsI9rGca31rUY=
X-Google-Smtp-Source: ABdhPJxXVlrmBcb0453eBCXLRSREXqV+o5rIXN7u7XAZfnIw5Inm5Yw1WMEb0ElXDmPWKiPz23Yk3w==
X-Received: by 2002:a2e:7601:: with SMTP id r1mr4308153ljc.54.1603664281328;
        Sun, 25 Oct 2020 15:18:01 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.gmail.com with ESMTPSA id k13sm932423ljh.136.2020.10.25.15.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 15:18:00 -0700 (PDT)
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
Subject: [PATCH v6 11/52] dt-bindings: memory: tegra30: emc: Document OPP table and voltage regulator
Date:   Mon, 26 Oct 2020 01:16:54 +0300
Message-Id: <20201025221735.3062-12-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201025221735.3062-1-digetx@gmail.com>
References: <20201025221735.3062-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Document new OPP table and voltage regulator properties which are needed
for supporting dynamic voltage-frequency scaling of the memory controller.
Some boards may have a fixed core voltage regulator, hence it's optional
because frequency scaling still may be desired.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../memory-controllers/nvidia,tegra30-emc.yaml       | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-emc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-emc.yaml
index c243986db420..0a2e2c0d0fdd 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-emc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-emc.yaml
@@ -39,6 +39,15 @@ properties:
     description:
       Phandle of the Memory Controller node.
 
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
@@ -218,6 +227,7 @@ required:
   - clocks
   - nvidia,memory-controller
   - "#interconnect-cells"
+  - operating-points-v2
 
 additionalProperties: false
 
@@ -230,6 +240,8 @@ examples:
         clocks = <&tegra_car 57>;
 
         nvidia,memory-controller = <&mc>;
+        operating-points-v2 = <&dvfs_opp_table>;
+        core-supply = <&vdd_core>;
 
         #interconnect-cells = <0>;
 
-- 
2.27.0

