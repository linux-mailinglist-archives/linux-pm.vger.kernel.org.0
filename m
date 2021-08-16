Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6433D3EDB1D
	for <lists+linux-pm@lfdr.de>; Mon, 16 Aug 2021 18:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbhHPQmW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Aug 2021 12:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbhHPQmV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Aug 2021 12:42:21 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DB3C0613CF
        for <linux-pm@vger.kernel.org>; Mon, 16 Aug 2021 09:41:49 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id u16so7406981wrn.5
        for <linux-pm@vger.kernel.org>; Mon, 16 Aug 2021 09:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jxcnjHPA5B0j7qX5chL1ZJXQsXksmgMefqmaOOvck6g=;
        b=gh2l0B5f6EJ7VXrb+GYCYmriYpOHMNPGU+nz2lisk3yiUpFuUBbr7Tmf1rybpLntdb
         hdpRJ/659TUr0FD1rANpNv/MxCvfr/etPOeFIrH5iuFKbzHh3Wg5gPMP0FxtJYdyG/Sn
         +rvl+qFCJhXyjJeAPjdCxc0/HEbb1U+6mAgWQD/4EedobPEVDBIK4V6Cru7Cu1b+pkOx
         hjEAfM3awnc2wpXxrBZXNT7nNy/xb+LBP1kv/HQJmSZDm8E8B8s3TyfMoEdUlGX95Ar3
         hQbuKj9KYNazwHZdUkPr1axAssNcx9D5NC9LBJ7PhLJg9ACo/PgzOY/Ay61t0PcRmaIe
         imDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jxcnjHPA5B0j7qX5chL1ZJXQsXksmgMefqmaOOvck6g=;
        b=A7MHgcLFMwMmQMHBRWdg4k+nhegmhrhUMTTY6CfnAy+zdsyEpl5gwhiAnHf4JCwYmX
         9UJ+IDoEBwe8W/u9JsfTPTybGbDUUknQpXQ6q1NTQYvCJLUsfU4TJq/GHTSmWOSRqbDA
         UzEAZB1FoQHNNC57i4NOoFnRd8GjlxstbmphNbPF1TEu4r3VQ5WPUVJih65MXMfiuLor
         J9wmIPLhvE+FrplC22iFA/fv9PfQ8fYltazHAhG9vwvGnOf3Var0iOHZwZiIDCJ36qQQ
         e7e6geWkgxcLoTWpAnodhchwauJZ+nDDG5KgILqsBIJ+rZvYH+CRq3W1G/YnMcX1BT5i
         uqgg==
X-Gm-Message-State: AOAM532zDEU3dqpW4otyXLVsQZ81LBUa3wvQ7+qzXoo48OaA+9USPyYf
        X97XvZNeaNopmb3s/fp2u4wPdA==
X-Google-Smtp-Source: ABdhPJz88fBErB0TXJjcCkHN84Q0xoZWg8NEBr1BSB0Iw+EaQ1/y6x2qK2vtpblHlClHO8Q5N0gAHQ==
X-Received: by 2002:adf:f292:: with SMTP id k18mr19621618wro.249.1629132107978;
        Mon, 16 Aug 2021 09:41:47 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3a81:3690:b885:8dcf:f8c6:7841])
        by smtp.gmail.com with ESMTPSA id m10sm15211730wro.63.2021.08.16.09.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 09:41:47 -0700 (PDT)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, robh+dt@kernel.org,
        matthias.bgg@gmail.com
Cc:     ben.tseng@mediatek.com, michael.kao@mediatek.com,
        ethan.chang@mediatek.com, fparent@baylibre.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH 1/3] dt-bindings: thermal: Add binding document for mt8195 thermal controller
Date:   Mon, 16 Aug 2021 18:43:05 +0200
Message-Id: <20210816164307.557315-2-abailon@baylibre.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210816164307.557315-1-abailon@baylibre.com>
References: <20210816164307.557315-1-abailon@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds binding document for mt8195 thermal controller.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 .../devicetree/bindings/thermal/mediatek-thermal-lvts.yaml  | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/mediatek-thermal-lvts.yaml b/Documentation/devicetree/bindings/thermal/mediatek-thermal-lvts.yaml
index 69ffe7b14c212..2e1ae00d4fd18 100644
--- a/Documentation/devicetree/bindings/thermal/mediatek-thermal-lvts.yaml
+++ b/Documentation/devicetree/bindings/thermal/mediatek-thermal-lvts.yaml
@@ -12,7 +12,11 @@ maintainers:
 
 properties:
   compatible:
-    const: mediatek,mt6873-lvts
+    oneOf:
+      - items:
+          - enum:
+              - mediatek,mt6873-lvts
+              - mediatek,mt8195-lvts
 
   reg:
     maxItems: 1
-- 
2.31.1

