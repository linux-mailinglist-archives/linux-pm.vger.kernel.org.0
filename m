Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36B233CFD20
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jul 2021 17:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237325AbhGTOcK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Jul 2021 10:32:10 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:43711 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240090AbhGTOBD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Jul 2021 10:01:03 -0400
Received: by mail-io1-f42.google.com with SMTP id k16so24188632ios.10;
        Tue, 20 Jul 2021 07:41:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XBmEtxGuro5AHDRV4MlIOBSIJE60xpP6Q488vaMtT4w=;
        b=SYHWdQMfROgL2XdFLoubttcvqJqQqijLuVEaeXh8WtEZCr5jBxI3vpOkNLgauSMtC8
         yl8HMsv2zoEm8DDR4aMd+xYclgJGTiSQAsvCutpfgrmASX4bJVUrfI/ZsGT3nYn/h/XF
         Swl5INsOOBpB3JBovVmmhu85Q2mamzJT8/0MGnHWXYzu9gpU1MrkQJSNSGXMJcMpvUTv
         YlMbIAhbRVSfID7LY7Ay/jl4gWhe7270TNcpjFN8tWeaXfhH+kwguPGjOZ6zVZil82b+
         NSZ/8pE4K67Dku7i0Ib7XN2EpgfV6W6i8qbE5JSW129Xy+xASwGcDsZS0JFY54jdPkuf
         f4jA==
X-Gm-Message-State: AOAM531z+WIVjZiVmfsBOVpZXvxk4lIbvUxi+9z7yVB2xDNkYE5/a3Uy
        O/JgYMIbAAfA2mnQjoEBGg==
X-Google-Smtp-Source: ABdhPJxooJfH/EtsqVVp9aWaE7jnvJiJKvu2tMzpZa406I+JYIozF7V3Rmk+KzkVPfszh9YcgMuFVA==
X-Received: by 2002:a6b:e60f:: with SMTP id g15mr22562813ioh.48.1626792086375;
        Tue, 20 Jul 2021 07:41:26 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.248])
        by smtp.googlemail.com with ESMTPSA id 10sm2091407iln.39.2021.07.20.07.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 07:41:25 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Tony Lindgren <tony@atomide.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        linux-omap@vger.kernel.org, Georgi Djakov <djakov@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
Subject: [PATCH v3 2/3] dt-bindings: Clean-up OPP binding node names in examples
Date:   Tue, 20 Jul 2021 08:41:20 -0600
Message-Id: <20210720144121.66713-2-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210720144121.66713-1-robh@kernel.org>
References: <20210720144121.66713-1-robh@kernel.org>
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
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml   | 2 +-
 Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml   | 2 +-
 .../devicetree/bindings/interconnect/fsl,imx8m-noc.yaml       | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
index 0f73f436bea7..4bea51d1e7ea 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
@@ -136,7 +136,7 @@ examples:
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

