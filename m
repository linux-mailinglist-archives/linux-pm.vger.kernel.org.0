Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E7B3E10B4
	for <lists+linux-pm@lfdr.de>; Thu,  5 Aug 2021 11:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbhHEJAs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Aug 2021 05:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbhHEJAr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Aug 2021 05:00:47 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B76C0613C1
        for <linux-pm@vger.kernel.org>; Thu,  5 Aug 2021 02:00:33 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id y34so9640283lfa.8
        for <linux-pm@vger.kernel.org>; Thu, 05 Aug 2021 02:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JM9iCScYCnpkFv75a57i9R1ggfwz9cSCItbTqo7em1Y=;
        b=y3DFpIbood6Z8HVNcmCAlTaEot6Fbw5o7WJl9eWitbrL8+PfBGI5MKkMbX1RwMyIdY
         okgh1DYBe51yAea82bYFMeOaAAawG+Vsz6PZ2KFYAq4+Nf2mPue4mcekooPQjbRxQZ4Y
         w/kjp82jR91Gm6dIlV70daROhz1ftlt3LYgSkktdBCUSVYQQTdHA/gtAEzQf6rtw2HG0
         ZBpmwwafLVQr1eLEYnPtqmF33FOORr5Ea9VEblKDZT7m3Db33+653xOdMcl0bs2diGpO
         4szt2EwU/V4z2wiB9ejUXeDw0SGdxbvNgqPve199hqwhSbqBFx6eAe8gONxd/fZrBkb+
         m65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JM9iCScYCnpkFv75a57i9R1ggfwz9cSCItbTqo7em1Y=;
        b=CUpgK1lgqdZ89h2EwpfhD16IL2A1E7FPsVTTQTQT64bvwI5zqerDuFI1LuVMTGyGyi
         uFbdzIZWHmcRGJ/k7WeGMXkagskGNVvV/GnFr81ncHfnCR2in7jbOhJRU1l4GL6chkb2
         ut4vbpaFyKhdAbqydSiEgDucsUb3p7lnCjQ9FF5vBMyKsa3vGCOh1+KE2l59+DHeHbba
         /sU9rlGJUWXupuQV1SiGBW1lJq+99rnlab7K5gtqX0+FRivvcE9M5pRJcWk47/JZkKcH
         e+kuAPLJNuZ01fx3zkKm6zhouE8l8cvquoCzVs122yCN04WFpRGB3bo0AWltd+9gK/AV
         QM8w==
X-Gm-Message-State: AOAM532JlGDepK51okc3/bo2zGkjFleYLs+qNThEl7vgJDDJOF7rj3TS
        dlrE0LAZyaVDGQHmHM40YoTbuA==
X-Google-Smtp-Source: ABdhPJzQixjx47Qbe0Ei69raVXjb883x6nrjx9J9NurjcUaeS/CKWsa6LFRSjRXoGv0Z/+Hxj+Tz7g==
X-Received: by 2002:a05:6512:53c:: with SMTP id o28mr2925415lfc.641.1628154031495;
        Thu, 05 Aug 2021 02:00:31 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id z1sm447901lfu.222.2021.08.05.02.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 02:00:31 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH 1/2 v2] dt-bindings: power: Extend battery bindings with type
Date:   Thu,  5 Aug 2021 10:58:27 +0200
Message-Id: <20210805085828.3451909-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This adds a battery-type property and bindings for the different
"technologies" that are used in Linux. More types can be added.

This is needed to convert the custom ST-Ericsson AB8500 battery
properties over to the generic battery bindings.

Cc: devicetree@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Add devicetree list to Cc
- Use "device-chemistry" instead of "battery-type" as this
  has precedence in standards.
I need a bunch of new bindings for switch the STE AB8500 custom
bindings out, but I need to start somewhere, this is as good as
any place to start.
---
 .../devicetree/bindings/power/supply/battery.yaml  | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/battery.yaml b/Documentation/devicetree/bindings/power/supply/battery.yaml
index c3b4b7543591..d56ac484fec5 100644
--- a/Documentation/devicetree/bindings/power/supply/battery.yaml
+++ b/Documentation/devicetree/bindings/power/supply/battery.yaml
@@ -31,6 +31,20 @@ properties:
   compatible:
     const: simple-battery
 
+  device-chemistry:
+    description: This describes the chemical technology of the battery.
+    oneOf:
+      - const: nickel-cadmium
+      - const: nickel-metal-hydride
+      - const: lithium-ion
+        description: This is a blanket type for all lithium-ion batteries,
+          including those below. If possible, a precise compatible string
+          from below should be used, but sometimes it is unknown which specific
+          lithium ion battery is employed and this wide compatible can be used.
+      - const: lithium-ion-polymer
+      - const: lithium-ion-iron-phosphate
+      - const: lithium-ion-manganese-oxide
+
   over-voltage-threshold-microvolt:
     description: battery over-voltage limit
 
-- 
2.31.1

