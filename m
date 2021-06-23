Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B3E3B23D7
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jun 2021 01:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhFWXJw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Jun 2021 19:09:52 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:46058 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbhFWXJt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Jun 2021 19:09:49 -0400
Received: by mail-io1-f54.google.com with SMTP id b7so5505944ioq.12;
        Wed, 23 Jun 2021 16:07:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C+uE8+nAEXOxgiCH++oPG1+J3LkqFr8mIOEqRnmwPBw=;
        b=HYbM5eKv9VPhY0Tv4e0HkKfM1BjAfVrh2L1i63HWQD7sGuwSuuxsHiP13nzrDbn510
         8wlUedJcrJu6mVl7e8z+DBjUXmzYPWNZPJEyuoCP+eK3RUrQK4JCXmZ5I3nTZSjEzoRe
         +q6HNnKcHDSrNv63Ijo8BmkH8DBqQzwidRRbi9zN6t8Ec503dqLNMoxJkTnBdmnk5l97
         esbkWUu0juC4UghNhas1OtnnZzm0w+XqcOlNGYdQdicX4D4fRGrvE9V7tB6iDxvVIpvJ
         c0RwDp2ZDOCgLz+bHnmLFXCGB++Fr431GN2pjmsxa5B0UBpq3j3qxXSIHLJgVSf6CNV0
         Sr8g==
X-Gm-Message-State: AOAM533x6qQzb6WMrQqQ3xDw1JWCgLY9NFxeZ8sHqqpSyBa7b7ASmqYv
        Hkchzv6i9sVB0w5iGp0o3A==
X-Google-Smtp-Source: ABdhPJwzuEWwG8Oagt2CTbbJroe3LynjgOu1pCwS9+oZVovJWP3h2Wsz8MenFNLJPGxpp+FNp6bSgg==
X-Received: by 2002:a02:90cb:: with SMTP id c11mr1863165jag.53.1624489651145;
        Wed, 23 Jun 2021 16:07:31 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.248])
        by smtp.googlemail.com with ESMTPSA id t15sm694356ile.28.2021.06.23.16.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 16:07:30 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Georgi Djakov <djakov@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 1/2] dt-bindings: Clean-up OPP binding node names in examples
Date:   Wed, 23 Jun 2021 17:07:21 -0600
Message-Id: <20210623230722.3545986-2-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210623230722.3545986-1-robh@kernel.org>
References: <20210623230722.3545986-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In preparation to convert OPP bindings to DT schema, clean-up a few OPP
binding node names in the binding examples.

Cc: Georgi Djakov <djakov@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-pm@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml   | 2 +-
 Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml   | 2 +-
 .../devicetree/bindings/interconnect/fsl,imx8m-noc.yaml       | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
index 894ba217ab32..260afff8cfbb 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
@@ -108,7 +108,7 @@ examples:
       resets = <&reset 0>, <&reset 1>;
     };
 
-    gpu_opp_table: opp_table0 {
+    gpu_opp_table: opp-table {
       compatible = "operating-points-v2";
 
       opp-533000000 {
diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
index 696c17aedbbe..d209f272625d 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
@@ -160,7 +160,7 @@ examples:
       #cooling-cells = <2>;
     };
 
-    gpu_opp_table: opp_table0 {
+    gpu_opp_table: opp-table {
       compatible = "operating-points-v2";
 
       opp-533000000 {
diff --git a/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml b/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
index a8873739d61a..b8204ed22dd5 100644
--- a/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
+++ b/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
@@ -81,10 +81,10 @@ examples:
         noc_opp_table: opp-table {
             compatible = "operating-points-v2";
 
-            opp-133M {
+            opp-133333333 {
                 opp-hz = /bits/ 64 <133333333>;
             };
-            opp-800M {
+            opp-800000000 {
                 opp-hz = /bits/ 64 <800000000>;
             };
         };
-- 
2.27.0

