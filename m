Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0F841D85A
	for <lists+linux-pm@lfdr.de>; Thu, 30 Sep 2021 13:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350317AbhI3LHR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Sep 2021 07:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350306AbhI3LHH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Sep 2021 07:07:07 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DE8C06176A;
        Thu, 30 Sep 2021 04:05:25 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id b26so20760344edt.0;
        Thu, 30 Sep 2021 04:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sSpzj10NGw5X39ToW4lUkS6X+YqxdosdM3EBUsNMyqE=;
        b=LPlqikM6FebZsUtylYpczSVr+YHzTDbcal/pi6IWk07MZKbRU9C5YLjIxL/17xcGnV
         NzmQ50PXQiIENZtzaL7KooG4GeCMHaujZLuu1LLbmtnZXZNqIcBS8xUtdH33GpRBAtHH
         Vn6nzrq0HstuoBkQO6BaxWTkBCsEvxbtgmU+Ul0S+mI9OTSJiw9fotL81VHgkbHgUgnF
         2mK9CGS8fgQD9kM7voI3LWd0Z+iiW+QgDmq1SlKjuqYriq4yloLW2EkfvenucR3YJle6
         YtLyjQAO8h5BedNWD2vnHyLzkv6nKNbKup74M7/INJDA54wedVNiJsBKgmq8SJzpglBI
         SdpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sSpzj10NGw5X39ToW4lUkS6X+YqxdosdM3EBUsNMyqE=;
        b=PRgfZE2GVyyhTnxJ8Ipx1vtI2Ei26UcOILZ9BOuS2NcA3USVxUEFfUs2xQcOZecYLQ
         P7FlOSoH6HrQDYxRvnuD/eUxy6sPHnYvSpWl42mPA9iZJKH/25OHz3uhLiVXL/smVPwD
         zAixL9Y7vVjqT0K3usT+RqO4xEEbvyHiTj+H/gyHgxuf+5PMwTocXilKAUXFESwNv1wP
         RNHP5k1JIvtwL3J7r3oicSE6OIWiT5NgZl1AhzhvkWWxgQJmny6MC0W/cKbnBjG+3XqG
         lDYt4pb7HBJIHXicWg2ihu/k9sObSzz6omEaHhZD8s2dEEJhL5bz5BlsLCasPFUBFXDI
         mdiQ==
X-Gm-Message-State: AOAM530Fj4sZPPun6ysUBti5U6PHpoh/L4rG/Vwr1Y3aVnsUux581GFi
        Zaw0EBEpZ+SApv+fA1+ftsI=
X-Google-Smtp-Source: ABdhPJz8KFn48cKcsMX/5FRkZiP6w85uVojtvApZQzdqqfzyK4K6D+Wg1oWR9meEf8ZSCfh08OwqUQ==
X-Received: by 2002:a50:d989:: with SMTP id w9mr6590475edj.99.1632999923922;
        Thu, 30 Sep 2021 04:05:23 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id i2sm1305158edv.7.2021.09.30.04.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 04:05:23 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org, p.zabel@pengutronix.de, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] dt-bindings: thermal: allow more resets for tsadc node in rockchip-thermal.yaml
Date:   Thu, 30 Sep 2021 13:05:14 +0200
Message-Id: <20210930110517.14323-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The tsadc node in rk356x.dtsi has more resets defined then currently
allowed by rockchip-thermal.yaml, so fix that in the documentation.
The driver now uses the devm_reset_control_array_get() function,
so reset-names is no longer required, but keep it for legacy reasons.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Changed V2:
  Remove deprecated
---
 .../devicetree/bindings/thermal/rockchip-thermal.yaml      | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml b/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
index b96ea277b..3c074706e 100644
--- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
@@ -37,11 +37,15 @@ properties:
       - const: apb_pclk
 
   resets:
-    maxItems: 1
+    minItems: 1
+    maxItems: 3
 
   reset-names:
+    minItems: 1
     items:
       - const: tsadc-apb
+      - const: tsadc
+      - const: tsadc-phy
 
   "#thermal-sensor-cells":
     const: 1
@@ -71,7 +75,6 @@ required:
   - clocks
   - clock-names
   - resets
-  - reset-names
   - "#thermal-sensor-cells"
 
 additionalProperties: false
-- 
2.20.1

