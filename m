Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6736295106
	for <lists+linux-pm@lfdr.de>; Wed, 21 Oct 2020 18:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438286AbgJUQmj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Oct 2020 12:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438273AbgJUQmi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Oct 2020 12:42:38 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40110C0613D4
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2020 09:42:38 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b8so3943088wrn.0
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2020 09:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oJ1aKiINz0LrDU7aEXlCXE8tQqMpnuCeNmVOG6Ww0Oo=;
        b=ejJUXrzhfpQggo3vO73m1qC2ZK7LYm9EZfc6A/LtRy5ByuRubgYG+fwFBIu/0V1H/2
         jTA5a9YkArTcVWbMcngRM0EWvr66+7EAn2ztGJMgE2LmPfRwRLKjZx8WdZyUwcaVPyqI
         9yLQ45kLhXWMK1Ewzxsxh7thE//owACHFh7d/XjLVC1rFo6Fdc6vuappjtg05+7Zl+M1
         lvlNIjnjClBhbepPGXcvJFciSUDz4kvHnJGltnpDGllNWmTKEv/dHFfb8dYOHohXlUdI
         ihJ/JE2NIGn/uhQ6bNEChusM1zoVZja207abAl9HYHeFYeldjuCCj5mbY03a4VwSQUJG
         yS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oJ1aKiINz0LrDU7aEXlCXE8tQqMpnuCeNmVOG6Ww0Oo=;
        b=gtmR7IouiWz3DLHlcTgW9zxU7q1MWVlRPNS16NNu5BSMid1cQ9g953ApdU5XS+tM2x
         YektpTxh1nkqwFsTpV6iXFyPXYnI8HYVso2KeXwmEtJ2okaOhbuNP6Qaq9CYDziFox0M
         /3XsOCGwwFkduePlI6g1AOMH/f3e0r2a40iuSmnvgyGRFytkQxmQlzLH+a0mtyhhmiYx
         nyPTTVqSnPtRsaDtaxUEMLI995rqCO7BN6XwSBzh1f9hY064ehYsYgbaOfmsWO6Wo8DG
         +DU9RMaGDsd3juRRnb9DW6QgD54ALrlCOygUxzZEWRVedJ9cWHpIYQjHemrAhp+kOFaw
         pn/Q==
X-Gm-Message-State: AOAM5318P+LmGTnFBcpFEhMh9O37vJNsja0aEW8Y4KtRAJfW0NeSww8P
        ivPx0NkmloKa7ihTudf/O/DnyQ==
X-Google-Smtp-Source: ABdhPJx73zW9wIrp01tKrd0AfCe57dEOyLM7D7HDQ0Xn+ABvJXdf/J86jJpZPTzBTZV6B1/xQWM35g==
X-Received: by 2002:a5d:4fc5:: with SMTP id h5mr5545357wrw.145.1603298556934;
        Wed, 21 Oct 2020 09:42:36 -0700 (PDT)
Received: from localhost.localdomain (58.164.185.81.rev.sfr.net. [81.185.164.58])
        by smtp.gmail.com with ESMTPSA id a3sm5321724wrh.94.2020.10.21.09.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 09:42:36 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org, amitk@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 2/3] dt-bindings: thermal: mediatek: add documentation for MT8516 SoC
Date:   Wed, 21 Oct 2020 18:42:30 +0200
Message-Id: <20201021164231.3029956-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021164231.3029956-1-fparent@baylibre.com>
References: <20201021164231.3029956-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add binding documentation for the MediaTek MT8516 SoC.
The SoC thermal IP is similar to MT2701.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 Documentation/devicetree/bindings/thermal/mediatek-thermal.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
index 2d20f6b0dca0..5c7e7bdd029a 100644
--- a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
@@ -14,6 +14,7 @@ Required properties:
   - "mediatek,mt2712-thermal" : For MT2712 family of SoCs
   - "mediatek,mt7622-thermal" : For MT7622 SoC
   - "mediatek,mt8183-thermal" : For MT8183 family of SoCs
+  - "mediatek,mt8516-thermal", "mediatek,mt2701-thermal : For MT8516 family of SoCs
 - reg: Address range of the thermal controller
 - interrupts: IRQ for the thermal controller
 - clocks, clock-names: Clocks needed for the thermal controller. required
-- 
2.28.0

