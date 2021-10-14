Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B0242DAED
	for <lists+linux-pm@lfdr.de>; Thu, 14 Oct 2021 15:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbhJNN7Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Oct 2021 09:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbhJNN7X (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Oct 2021 09:59:23 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA70C061755
        for <linux-pm@vger.kernel.org>; Thu, 14 Oct 2021 06:57:13 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id r10so19704902wra.12
        for <linux-pm@vger.kernel.org>; Thu, 14 Oct 2021 06:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CJsCWcU0YdDyrwMeRQ7adfzbBn9rJ1IRoawBpqp6LUY=;
        b=nWdcXGVnk8Oz4L0y1/sfaNNPdvqBC8SWVQ5nnv5b8TQyWXphWKaoUoiCpwNZG8Kmg7
         3dj3uagsMpT5Mkox9mRqXNBxgELAR6KQRJP9qR7cIbMpgcAwTrHHxyN3OM34CHGR60Kf
         uIoST2ZV+XIqKoziuz9ddYYjU2uuTxUp8n0OkD0kamILuU2BO4qcyQAoYlx5tI534hXJ
         8wX7ijJxd8dBsX1S0k56zxW+ymjGBOBsd4ztmANLtNmhWda2bOwt25nOHi8W1weYloLU
         m4XidWIX7hPvKFUYi1gyqqnTuCRudf4eTSdoq2TPK4/ZCBoXD2FMfrqCXrtT1XLD+5mN
         fCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CJsCWcU0YdDyrwMeRQ7adfzbBn9rJ1IRoawBpqp6LUY=;
        b=5BFzov0UA92HJs/jjYWkXPl3ZyPOJpWbv5HvmgoxNxeMRJyf/O1QMMdxN/XvUt2njy
         TV9+N4jAudncbrjf5lAiBLFJUYrNKECdqbM2pnV10g6EXkqPACUaze/LyEXbCpz3w4D7
         bmTFKobOOymH0B/Q+gQ+wOQqOdnS7IfMQv4vr1Re/zyQrUBJDgtIpgTfUJbx/CgSj/1n
         jl9inMVo9Epiff6u5mVlJp9D0+dqv6A5KMOR19ewKGeALE+uMI8r8owqEQ/GGSbQkz5m
         qPY6/8v8GJhoWPb2aT4OKGeEIBrdb9mRInzH+72cVkMMO5qQDcql1wFm4AG/mraqSt8Y
         P41Q==
X-Gm-Message-State: AOAM531OnvPUXpQrSV7ENUk2DTsAOBXpaTQHjGN0bu/9+pSfAG87TU4m
        7EkM/+uFBb5JwJTNC9CJe/Z4rQ==
X-Google-Smtp-Source: ABdhPJwQIpKFObMCc8ia1BlvyYCeOcB3+iofnWS2JorNe065Bk+P85rDl3QiHz/L0kIPBi56mMyzOw==
X-Received: by 2002:a5d:45c9:: with SMTP id b9mr6722258wrs.365.1634219832217;
        Thu, 14 Oct 2021 06:57:12 -0700 (PDT)
Received: from blmsp.lan ([2a02:2454:3e6:c900::97e])
        by smtp.gmail.com with ESMTPSA id d1sm2596480wrr.72.2021.10.14.06.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 06:57:11 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, fparent@baylibre.com,
        khilman@baylibre.com, Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH 1/3] dt-bindings: thermal: mediatek: Add mt8365
Date:   Thu, 14 Oct 2021 15:56:34 +0200
Message-Id: <20211014135636.3644166-2-msp@baylibre.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211014135636.3644166-1-msp@baylibre.com>
References: <20211014135636.3644166-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This unit is present on the mt8365 SoC as well. But there is a
difference in the usage of an apmixed register.

This patch adds a distinct mt8365 to the list of compatibles.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 Documentation/devicetree/bindings/thermal/mediatek-thermal.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
index 5c7e7bdd029a..ba4ebffeade4 100644
--- a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
@@ -14,6 +14,7 @@ Required properties:
   - "mediatek,mt2712-thermal" : For MT2712 family of SoCs
   - "mediatek,mt7622-thermal" : For MT7622 SoC
   - "mediatek,mt8183-thermal" : For MT8183 family of SoCs
+  - "mediatek,mt8365-thermal" : For MT8365 family of SoCs
   - "mediatek,mt8516-thermal", "mediatek,mt2701-thermal : For MT8516 family of SoCs
 - reg: Address range of the thermal controller
 - interrupts: IRQ for the thermal controller
-- 
2.33.0

