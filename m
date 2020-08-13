Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A344E2440A8
	for <lists+linux-pm@lfdr.de>; Thu, 13 Aug 2020 23:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgHMVed (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 17:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgHMVec (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 17:34:32 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823FBC061757;
        Thu, 13 Aug 2020 14:34:32 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id v12so7788039ljc.10;
        Thu, 13 Aug 2020 14:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fZLsHIDpnTF+VfT0D85OABvcYZ+3mXctvnf5hSJQWzI=;
        b=cEJlGGyeVOnUqLHStkUx6OeQErNRTVSS220RFZE6V8zt+iutywGEiDiWgxjOwmvT0W
         QzHpMjc5mPTLcGxJ2ANM0rQHnB/BWFzwv1dv5PTx2/OnLnAxHKQKpUq7vf6gU+UePgRo
         R82mDt9eh/+PIbdPd8SNW8gE30QIDV0U9eMs+0vTiVZe/GDv2bhzqv0Mbc2zRz8MTFex
         MdhehJ/5k/Y7HLiQDC3mWACmwSEpjXc0c7bGjpHZutU43yvHm67c59185gu1yjgiz9xw
         kJY5hODB9QVq4gjuzkNUx3c42T/R4KiR6M8NGQ6mWlZAE6m2Y3wG0ikeH3uG/MvqVVY/
         yBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fZLsHIDpnTF+VfT0D85OABvcYZ+3mXctvnf5hSJQWzI=;
        b=VbJQPDGoOS37oBuzW9j00IOVhgcpTIeqVrTP8T4iUBnLSPF2d3rv7arX8b1bcrbHBn
         3HbMf3s7Hgn2wf7z4sOod1SfJm7rIpuqPJLNhTZZqjycMDS9BtAUpBkF3Mf1fjiICY8l
         YcXbYYskvmW7W7rjBoxLvaqBCiBgXYoXlPreErhy/wrjIez15u+iGLcyNadmzwinZRFP
         0s/nHBzXdq1fAhSCmxcWp4cY4mAiMqbpvKbT0zEhdPfKEVC6hMzoMx9f1fDvOPD/eRta
         rjZLLe2CFH12/hOMlT3zetOtHAFQ53Vu53nuE+1LW7gjtGtreIo0c3c246+9msDa6j25
         jHhg==
X-Gm-Message-State: AOAM530tsAF3FkZLlRa+uuUxlFRO2IpAlghpEo6HwirHzGtelArV2I1X
        KNsWXdl94atb93Nv/LNCQLc=
X-Google-Smtp-Source: ABdhPJxvfXQdfIk92pJtg8kgylRAvmzl0C/vMZ0PbV7h+vJYE5TyhNAGmBca3vdh/RJ0c0/LYmIYyg==
X-Received: by 2002:a2e:b8cf:: with SMTP id s15mr3072321ljp.166.1597354470954;
        Thu, 13 Aug 2020 14:34:30 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id j2sm1345309ljb.98.2020.08.13.14.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 14:34:30 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Heidelberg <david@ixit.cz>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Bruce E . Robertson" <bruce.e.robertson@intel.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Jonghwa Lee <jonghwa3.lee@samsung.com>,
        John Stultz <john.stultz@linaro.org>,
        Vinay Simha BN <simhavcs@gmail.com>,
        linux-tegra@vger.kernel.org
Subject: [PATCH v3 01/10] dt-bindings: battery: Add temperature properties
Date:   Fri, 14 Aug 2020 00:34:00 +0300
Message-Id: <20200813213409.24222-2-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200813213409.24222-1-digetx@gmail.com>
References: <20200813213409.24222-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Document generic battery temperature properties.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../bindings/power/supply/battery.yaml        | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/battery.yaml b/Documentation/devicetree/bindings/power/supply/battery.yaml
index 932b736ce5c0..0c7e2e44793b 100644
--- a/Documentation/devicetree/bindings/power/supply/battery.yaml
+++ b/Documentation/devicetree/bindings/power/supply/battery.yaml
@@ -82,6 +82,27 @@ properties:
       An array containing the temperature in degree Celsius,
       for each of the battery capacity lookup table.
 
+  operating-range-celsius:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: operating temperature range of a battery
+    items:
+      - description: minimum temperature at which battery can operate
+      - description: maximum temperature at which battery can operate
+
+  ambient-celsius:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: safe range of ambient temperature
+    items:
+      - description: alert when ambient temperature is lower than this value
+      - description: alert when ambient temperature is higher than this value
+
+  alert-celsius:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: safe range of battery temperature
+    items:
+      - description: alert when battery temperature is lower than this value
+      - description: alert when battery temperature is higher than this value
+
 required:
   - compatible
 
@@ -130,6 +151,9 @@ examples:
         /* table for 10 degree Celsius */
         ocv-capacity-table-2 = <4250000 100>, <4200000 95>, <4185000 90>;
         resistance-temp-table = <20 100>, <10 90>, <0 80>, <(-10) 60>;
+        operating-range-celsius = <(-30) 50>;
+        ambient-celsius = <(-5) 50>;
+        alert-celsius = <0 40>;
       };
 
       charger@11 {
-- 
2.27.0

