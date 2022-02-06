Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865384AAFDA
	for <lists+linux-pm@lfdr.de>; Sun,  6 Feb 2022 15:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbiBFOFM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 6 Feb 2022 09:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238942AbiBFOFL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Feb 2022 09:05:11 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15CBC043186
        for <linux-pm@vger.kernel.org>; Sun,  6 Feb 2022 06:05:10 -0800 (PST)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 54A124030D
        for <linux-pm@vger.kernel.org>; Sun,  6 Feb 2022 13:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644155899;
        bh=lR5QuC/RulAMRDxY+ifBfJU5LKjeK10Pu1tPwMpMBhw=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=EAeFM7ZggH40rvREqA3XT6QsWPNVOLaXLDWUFruDdS8EZvazUPOquh/AmraR9PxUP
         CMO7heFsIO0JE1gW0QOF8pQ8pHdUWzft9vRFAtm7MjlG+CJrbWDWEs/YM4NJF7f74P
         vtjlzwdCDN664rgtF2YemXQzTNx7zWV9/Omlxu/49/UZvIF37lVRAeEDr//HBRuWOU
         BAxIpeHeifFcEF1FjgZYKhwO+waw1ivZwy60NEIW7v//1wffRPcrgsaIQvhaSjQm+u
         XAsS4v5YPrvrwRpT3pgYTKbknaMbQxqIo9Ppd24nC5wi3DWMsScM5e9VKVknohTjUF
         bUuWaZxAxxylw==
Received: by mail-wm1-f72.google.com with SMTP id bg16-20020a05600c3c9000b0034bea12c043so10552443wmb.7
        for <linux-pm@vger.kernel.org>; Sun, 06 Feb 2022 05:58:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lR5QuC/RulAMRDxY+ifBfJU5LKjeK10Pu1tPwMpMBhw=;
        b=bO1AMVZxaTyvCjHHwd6LmZmMhmzFwUJq+43EkJvi0Dz4pT1SFKhZeKndY0dyWWC+Wu
         tKkoqMm5GKN1PVxgM7XbsNuemcygOcu0KkwDJSR/hQijx+8iDats2eYDKkAVTxrv+JjK
         fK5ZRH2+DQJUwiTZme8nZ1c717EOrgZXa9alpYzRtzXhGIJwAzOyzFaiXqqV98vZ+bME
         WSOgRBczV9zoISDDxSGV3Hh2nVFfgWnjN55eO2HSxQ+4qop2LLtKqz0tMs05EwCHEiQo
         FQ830T28SkZNRiMtDhEuHunMKuAx7h2scHYCMEdJsW14DtcOM6DJX8AD8JGuZLUXF7T1
         5uzg==
X-Gm-Message-State: AOAM533fCVw1Na6gNtovZKxYUafmHB2n/zLkQH4Py83yXpuDsy2z03ZF
        WvJxDEbZ4hvrDiSr3AXlHMwQ4mFk6IvvdtJsbdZ4VCEr3vHgPw87zKP7gieamoLEIR+envh8mk4
        sldEQq6552B3Y5RugQ7DG/J3tF3j1EN12F0nl
X-Received: by 2002:a05:600c:3d0c:: with SMTP id bh12mr10822069wmb.179.1644155896254;
        Sun, 06 Feb 2022 05:58:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwTX+molkn93Ebp+4k6R2HYipWuqcMWZxzQzfvUagW0IQOkjly+1ESbyJzirwTgRGM+iphQMw==
X-Received: by 2002:a05:600c:3d0c:: with SMTP id bh12mr10822054wmb.179.1644155896117;
        Sun, 06 Feb 2022 05:58:16 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id e9sm8296888wrg.60.2022.02.06.05.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 05:58:15 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 4/8] dt-bindings: memory: lpddr3: adjust IO width to spec
Date:   Sun,  6 Feb 2022 14:58:03 +0100
Message-Id: <20220206135807.211767-5-krzysztof.kozlowski@canonical.com>
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

According to JEDEC Standard No. 209-3 (table 3.4.1 "Mode Register
Assignment and Definition in LPDDR3 SDRAM"), the LPDDR3 supports only
16- and 32-bit IO width.  Drop the unsupported others.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/memory-controllers/ddr/jedec,lpddr3.yaml           | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml
index e36f3607e25a..d6787b5190ee 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml
@@ -34,10 +34,8 @@ properties:
     description: |
       IO bus width in bits of SDRAM chip.
     enum:
-      - 64
       - 32
       - 16
-      - 8
 
   manufacturer-id:
     $ref: /schemas/types.yaml#/definitions/uint32
-- 
2.32.0

