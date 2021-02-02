Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5D6B30C972
	for <lists+linux-pm@lfdr.de>; Tue,  2 Feb 2021 19:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238458AbhBBSSa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Feb 2021 13:18:30 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:34431 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238352AbhBBSQW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Feb 2021 13:16:22 -0500
Received: by mail-ot1-f45.google.com with SMTP id d5so5320464otc.1;
        Tue, 02 Feb 2021 10:16:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8dDjqTPK+llWIRGrZH/KSVCS5Q0oIZSoyMWb9i78HpA=;
        b=lUtDETH6QjFhezNga/K6oBhtwpVty5rKUslxX1qXgBDeiN+HufW+N5HA+IVT8POXCw
         /XU483YGhcdgj+3VwyBId8CvrWqhgwvxziwA0t2xizWGph+RtKEt6dtkgciZ9ucG1viz
         7jGDLhGgG5m++fteiAVH0q+0M1ID8TpBhWk3GeXnF2RsaTLUVyfriLVko/yBnjPu2GAX
         S3FiVAXtbBkfbWaHhphPv6K4XVRY7S4ocruFL0ubU/Y0wmtN56APaoNVj5pDjWdX9lEg
         xbl/rDqI8ETavzL1eWUFRc4Jb9RyDzIdslpD06XdgFmQnMdcup0Z/1VDWV0zb+/6z92e
         hIAA==
X-Gm-Message-State: AOAM531b6MtsGbHaM/QTtRpXQz3RvWU8HUdPH491qkMrjJyiGDpMJEVN
        Kkd5DIYbgy2EeV4o1cOKuS2Xes2Usw==
X-Google-Smtp-Source: ABdhPJwDzdTeGq37aNKpjJFMzbUg64rp+M/CU437C9KhLoxSHuWdlKLLpwcNiDt7lcCsYenGpWxp0A==
X-Received: by 2002:a9d:4a8e:: with SMTP id i14mr16786937otf.37.1612289740973;
        Tue, 02 Feb 2021 10:15:40 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id v16sm4805020otq.20.2021.02.02.10.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 10:15:40 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-pm@vger.kernel.org
Subject: [PATCH] dt-bindings: thermal: sun8i: Fix misplaced schema keyword in compatible strings
Date:   Tue,  2 Feb 2021 12:15:38 -0600
Message-Id: <20210202181538.3936235-1-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

A compatible string 'enum' mistakenly has 'const: ' in the compatible
strings. Remove these.

Fixes: 0b28594d67a8 ("dt-bindings: thermal: Add YAML schema for sun8i-thermal driver bindings")
Cc: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: Yangtao Li <tiny.windzz@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Amit Kucheria <amitk@kernel.org>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Jernej Skrabec <jernej.skrabec@siol.net>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/thermal/allwinner,sun8i-a83t-ths.yaml   | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
index 31edd051295a..bf97d1fb33e7 100644
--- a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
+++ b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
@@ -103,12 +103,12 @@ allOf:
         compatible:
           contains:
             enum:
-              - const: allwinner,sun8i-h3-ths
-              - const: allwinner,sun8i-r40-ths
-              - const: allwinner,sun50i-a64-ths
-              - const: allwinner,sun50i-a100-ths
-              - const: allwinner,sun50i-h5-ths
-              - const: allwinner,sun50i-h6-ths
+              - allwinner,sun8i-h3-ths
+              - allwinner,sun8i-r40-ths
+              - allwinner,sun50i-a64-ths
+              - allwinner,sun50i-a100-ths
+              - allwinner,sun50i-h5-ths
+              - allwinner,sun50i-h6-ths
 
     then:
       required:
-- 
2.27.0

