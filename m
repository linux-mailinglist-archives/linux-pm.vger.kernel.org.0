Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658E2434205
	for <lists+linux-pm@lfdr.de>; Wed, 20 Oct 2021 01:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbhJSXWY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Oct 2021 19:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbhJSXWX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Oct 2021 19:22:23 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A065C06161C;
        Tue, 19 Oct 2021 16:20:10 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id b189-20020a1c1bc6000000b0030da052dd4fso6161859wmb.3;
        Tue, 19 Oct 2021 16:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wCNp6pRP0whQW8wmwIovrXx3DF0GHE2nJ7BG+D14iAI=;
        b=B5qKM3MIncrmUKRrTKCNJupQHUdbtHvb/DYYsN4VIipcV2tqk8ppCu32SKU1okb70/
         AJ4IaZqhsHIIZ5NbNllcYeQC76uHgAGrJGZF18gSlBajw3xrc2FJCJeTPgC4nvzk+Q0J
         BLDuxRW8ztOCSSKlKCl+7gZs/z85uCFRu1CLeG/AyL1mAu+8nvKTMdwMRnpIw3vzOx47
         RLzt3WBCFO1x5sVSHvxGmyaA3kSUoJwArrHK7rZ4ss1TltBSxFRYPqgu8tDNGwj2V3lN
         jq1U1ScgHQ2izVbOWXe6vB/V0V3G2ROse+Nhv36vazUHfpBDbZciIkeqLaXGDIMmAcYO
         n3vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wCNp6pRP0whQW8wmwIovrXx3DF0GHE2nJ7BG+D14iAI=;
        b=id+LCpq+35hsvhwWYH0+gzD2zCCLuEa12KmT+P25qi3FdM1RK0AY7xkltRrAm5E8Gg
         cTpSKMdV+J2GRf+4QLo11VhS+fVGPn9hdPWMspw/HVa3c1VtDLjzXfWl4janfnTrpeEY
         cYoPFqWrXAV/XkgcN5YDMDkkgqk5b2ERQZxhHEKMCegfou1Rvf9YSV7ydK5KiGVxRnyM
         ZRnrYboOzu4si+KbtxK5fchpQ/MClMS5fft4tK+sYtRkSy03/b0TZkK/sdYuwOyvnkdj
         fgoIwFchfLjSQmNYaKlwCG9+GohzoJXn1G2B7kvdJ+x0PuBBHhISAW9uVfdr73cwJ/EU
         tlGA==
X-Gm-Message-State: AOAM531JAwM4erCJ3gcOfmuCUlprE4vJmGRmOynPHiew+XrPmvGnP+zz
        XB/SZBQ2rVGLKos751QGcL8=
X-Google-Smtp-Source: ABdhPJyFy6jXFXEH5YBEK6YZAIH6fYITYu0JKu13nCIXd2izmF13kuLM6XW0yR/U3p2azgQEMnDcxg==
X-Received: by 2002:a5d:6982:: with SMTP id g2mr47446560wru.51.1634685608867;
        Tue, 19 Oct 2021 16:20:08 -0700 (PDT)
Received: from localhost.localdomain (94-29-39-10.dynamic.spd-mgts.ru. [94.29.39.10])
        by smtp.gmail.com with ESMTPSA id q16sm308983wru.39.2021.10.19.16.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 16:20:08 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Viresh Kumar <vireshk@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        David Heidelberg <david@ixit.cz>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v1] dt-bindings: opp: Allow multi-worded node names
Date:   Wed, 20 Oct 2021 02:19:05 +0300
Message-Id: <20211019231905.2974-1-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Not all OPP table names and OPP entries consist of a single word. In
particular NVIDIA Tegra OPP tables use multi-word names. Allow OPP node
and OPP entry name to have multi-worded names to silence DT checker
warnings about the multi-word names separated by hyphen.

Reviewed-by: David Heidelberg <david@ixit.cz>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 Documentation/devicetree/bindings/opp/opp-v2-base.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
index ae3ae4d39843..298cf24af270 100644
--- a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
+++ b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
@@ -22,7 +22,7 @@ select: false
 
 properties:
   $nodename:
-    pattern: '^opp-table(-[a-z0-9]+)?$'
+    pattern: '^opp-table(-[a-z0-9]+)*$'
 
   opp-shared:
     description:
@@ -33,7 +33,7 @@ properties:
     type: boolean
 
 patternProperties:
-  '^opp-?[0-9]+$':
+  '^opp(-[0-9]+)*$':
     type: object
     description:
       One or more OPP nodes describing voltage-current-frequency combinations.
-- 
2.32.0

