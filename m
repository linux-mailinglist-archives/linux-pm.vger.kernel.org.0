Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56DF4AAFDC
	for <lists+linux-pm@lfdr.de>; Sun,  6 Feb 2022 15:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237347AbiBFOFM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 6 Feb 2022 09:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236705AbiBFOFL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Feb 2022 09:05:11 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C138FC043185
        for <linux-pm@vger.kernel.org>; Sun,  6 Feb 2022 06:05:10 -0800 (PST)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 89C9240314
        for <linux-pm@vger.kernel.org>; Sun,  6 Feb 2022 13:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644155899;
        bh=lowbJ9HbAqgBRMehsHM/qhZ+cS05q8+wNRQlqfDefTM=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=QzuUqcXvAqovUwxK3ArDV/ylG8vKI2OUpZo6Mx4IjolMhoLB7VKSAxJjBuAxdvVDq
         f1qFXncLcRwIEpKXNB/wVC05BGVSRs2eWHIcWx+lQY+Cw6ymtE4izdZkODbfp8yEJc
         pXJ3iOAJg2G8Ya67ns9bcdzFqBCsVd8zCkQ6s8c4fqTDgalAH7U+SneeyDO2oDFr7k
         RWKh0Rl3PEV329QFmZxg6tO+ptBr/k41K++a0vdN6oa3cuZYO9xD6JUHjbneXhgc09
         wKLgN1ZH1kP9XQPucoFLhrARdMmcgjaNQsABrrgCIiCF3y4a6MjWrftd+54r/3ia3f
         1jEmSHkdHkmCg==
Received: by mail-wm1-f71.google.com with SMTP id h82-20020a1c2155000000b003552c13626cso6186288wmh.3
        for <linux-pm@vger.kernel.org>; Sun, 06 Feb 2022 05:58:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lowbJ9HbAqgBRMehsHM/qhZ+cS05q8+wNRQlqfDefTM=;
        b=2OdCD82Ij6S/NM0s2pX9WweUs8Nm3YH13GW8tijSfrQzHaQiHmgoVjrhvJlBDoT1wk
         NDPpmA4eh+zx0U3J43Gl93yi/Qgwri4ZCe721B/7mZmlabKBYcgqeONHXVyByq8DoQVF
         +JTt3oLnu18Hlcr/yy3v+WBdDFGDyuVQUSI5UZkERtZQdyRKAT2lFuQYhmpBXv4cikiq
         ks4XuO+v/FE0J5R/jeH7zGqVMuMpc1EukC6gg/eGZqMXBca+ZkFTak3L1Azi1qH+4teB
         +9wCwpJBeh7In5SQ6zq8jiYgBeCWz26zvxu/dtWpO2KKrQ7otGbJ9cQTik1XjknscAIZ
         cG8Q==
X-Gm-Message-State: AOAM533Xoaaamx03EYSmb4XoN167I7VSgE30xoaubZVVee6rTcQHvXbk
        D/uszBf0uUy8SshZCKInXWHrZwskD61rMTR9QneSNF1EOtLbGdNbypv7oGC8seb3XCbyDBTR0Z0
        DbW5OI6fsAvFraGcI9F8V7HkAezJoN57BFn7F
X-Received: by 2002:a05:600c:218:: with SMTP id 24mr7316482wmi.95.1644155897618;
        Sun, 06 Feb 2022 05:58:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzFbHkfXy9mwKBU3YQJK1xswUXUcJeL2qs8UreyNLnbIswkcL4WL2NExoBBoPLmzdhlDF7SCw==
X-Received: by 2002:a05:600c:218:: with SMTP id 24mr7316471wmi.95.1644155897470;
        Sun, 06 Feb 2022 05:58:17 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id e9sm8296888wrg.60.2022.02.06.05.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 05:58:16 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 5/8] dt-bindings: memory: lpddr3: deprecate manufacturer ID
Date:   Sun,  6 Feb 2022 14:58:04 +0100
Message-Id: <20220206135807.211767-6-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220206135807.211767-1-krzysztof.kozlowski@canonical.com>
References: <20220206135807.211767-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The memory manufacturer should be described in vendor part of
compatible, so there is no need to duplicate it in a separate property.
Similarly is done in LPDDR2 bindings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/memory-controllers/ddr/jedec,lpddr3.yaml         | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml
index d6787b5190ee..3bcba15098ea 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml
@@ -40,7 +40,9 @@ properties:
   manufacturer-id:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: |
-      Manufacturer ID value read from Mode Register 5.
+      Manufacturer ID value read from Mode Register 5.  The property is
+      deprecated, manufacturer should be derived from the compatible.
+    deprecated: true
 
   revision-id:
     $ref: /schemas/types.yaml#/definitions/uint32-array
-- 
2.32.0

