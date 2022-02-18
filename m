Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA274BB487
	for <lists+linux-pm@lfdr.de>; Fri, 18 Feb 2022 09:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbiBRIq2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Feb 2022 03:46:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbiBRIq2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Feb 2022 03:46:28 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3098C2B31B8
        for <linux-pm@vger.kernel.org>; Fri, 18 Feb 2022 00:46:12 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id e3so13364128wra.0
        for <linux-pm@vger.kernel.org>; Fri, 18 Feb 2022 00:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ga1tj+AFlYveqMe1jeMTao9WaR1VFNM4sUtLVu+UA+8=;
        b=byVwya5D4f2ieq/OwO1CPrwtRJ1dfJuDJ69gXkWxSBMGW+zg2Y0/LzmRtsKzINaswd
         vCl4Z/RwUkpetx0GmExa71Ln2zS+Nyx8djfRudck2t42OX3MGOn5DhB1hwXaajnyv4Jk
         wpXyGb4Rkm+1JxtIYMOEzixYX/lXHRx1B3PKTieovYtkWZhdCuMj/0OlOKLXvP8lm0a9
         /pSZ7hyZLM1l5BGl+cvg0T5H6JGCn8s3aldsIx8/mklQgLP5AXRbOmcJqlQ+Mz/qgkiP
         YiKsZNcHoG+o8rq9Kqfmuogf2DhG0UhlsaQHYA5s3deVllby+nxIIVRtSmKPoaRs+/5L
         X7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ga1tj+AFlYveqMe1jeMTao9WaR1VFNM4sUtLVu+UA+8=;
        b=mUgKy39GROLocqm7oCEN1rrIn6DPJll2CEkf+KDKHuo3rxqXduyPr0dk31KDAWQKOE
         dyHtRz/6oFLRHlocCyhp+ds8gGnt3MGaLbbZEStRirCwmAxhcfYtaWRUa0JMUbBP/rFf
         8rnM+7flOAMMG/qFWwcKmaiiYIhO6Xl0+HenCBPDIkBf06omGerAVAaJWXvYIumTjezZ
         aW9Y974YcLEYhhprCn9KtHcx3NTqLlWHNpBK0rpCnc/+b+E5OEm7GDeZ4Kh11Frg0km1
         dtD2DVPUS7O2rWZAWIAg/rXo8hgQjmQtkpFxyu25U8GBgHpHR9doAtPWwHCXR75yqD+u
         WBbQ==
X-Gm-Message-State: AOAM5304GtXhaju7QgCPEZPGxDVeJxmPLXaHG6BLG0u6oYk28b+Nn3gy
        xqCAZi/OtyiT/pW7ZLN0seDg/Q==
X-Google-Smtp-Source: ABdhPJy5XqRsUsreGPMdRmLvLdmZcp7CDeBt/4QFBRfrCK0itSG0hlvVg86fVoJc8Vlbjr4t01qoFA==
X-Received: by 2002:a5d:4750:0:b0:1e7:be55:693b with SMTP id o16-20020a5d4750000000b001e7be55693bmr5262566wrs.715.1645173970738;
        Fri, 18 Feb 2022 00:46:10 -0800 (PST)
Received: from xps-9300.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x7sm33525478wro.21.2022.02.18.00.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 00:46:10 -0800 (PST)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.tseng@mediatek.com, khilman@baylibre.com, mka@chromium.org,
        Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH 1/2] dt-bindings: thermal: Update the bindings to support multiple sensors
Date:   Fri, 18 Feb 2022 09:46:03 +0100
Message-Id: <20220218084604.1669091-2-abailon@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220218084604.1669091-1-abailon@baylibre.com>
References: <20220218084604.1669091-1-abailon@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This adds two optionals properties and update the thermal-sensors
property description to support multiple sensors with a thermal zone.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 .../bindings/thermal/thermal-zones.yaml       | 30 +++++++++++++++++--
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
index 2d34f3ccb2572..9f944c2364589 100644
--- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
+++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
@@ -77,10 +77,24 @@ patternProperties:
 
       thermal-sensors:
         $ref: /schemas/types.yaml#/definitions/phandle-array
-        maxItems: 1
         description:
-          The thermal sensor phandle and sensor specifier used to monitor this
-          thermal zone.
+          An array of thermal sensor phandle and sensor specifier used to
+          monitor this thermal zone.
+          If the array contains more than one sensor then the returned value
+          is the maximum unless aggregation-min or aggregation-avg properties
+          are set.
+
+      aggregation-min:
+        type: boolean
+        description:
+          Return the minimum temperature when the thermal monitor multiple
+          sensors.
+
+      aggregation-avg:
+        type: boolean
+        description:
+          Return the average temperature when the thermal monitor multiple
+          sensors.
 
       coefficients:
         $ref: /schemas/types.yaml#/definitions/uint32-array
@@ -338,5 +352,15 @@ examples:
                             };
                     };
             };
+
+            /* ... */
+
+            soc-max-thermal {
+                    polling-delay-passive = <250>;
+                    polling-delay = <1000>;
+                    thermal-sensors = <&tsens0 5>, <&tsens0 11>;
+                    trips {};
+                    cooling-maps {};
+            };
     };
 ...
-- 
2.34.1

