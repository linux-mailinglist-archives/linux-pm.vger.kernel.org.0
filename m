Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5D119186B
	for <lists+linux-pm@lfdr.de>; Tue, 24 Mar 2020 19:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbgCXSFS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Mar 2020 14:05:18 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46166 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbgCXSFR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Mar 2020 14:05:17 -0400
Received: by mail-io1-f65.google.com with SMTP id a20so11798695ioo.13;
        Tue, 24 Mar 2020 11:05:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nyDEVt1mvrogKhA8Gqx9BDr8ZhtFuURVk0awOOjdRAk=;
        b=FRvVpYZQ7kbHljZAiALiNAYG2hMeiVKXcQ1YWleARDSyLEBqaXP1dJpny0a+TDuhUh
         qYHnfX6qZDseEAXVITgxaKuiaG6+MNuN81fk8cjdTcp78Ogomzzflo+4Fy7sMtYFymhi
         wjMStuKRdM+uNSEFGmjL58iBB0VnBZZ7SbD0LXbLlGFURR1vkyjkYV1V9NH8ZCqdxsLh
         l1UuunmM0F9PZ9sf4PH2fbHAEUWK7X5odUv3t0qWossqDTG2SLurJPzdh5hnMFEJqDGs
         e445soVE84Y1uOIl/XiXYencK70axgE4+dPhRPG0eVc3SweVfZ62lwb6cf8Snyk1IeoK
         sjUQ==
X-Gm-Message-State: ANhLgQ2xeVxUvivr1m/NbjGu4HMGnRTP6KJE+953m0Xoc+ftFHbawdAy
        UE38gKZ6k65O8Ou1KnwvGA==
X-Google-Smtp-Source: ADFU+vviVLJ2406W4da5BKPv3JBD0h+tKl7SMZvgGaaTsZAT3LHrZ3tTM5vdWhgLvBrZ8lN+deNRYw==
X-Received: by 2002:a02:740d:: with SMTP id o13mr25847674jac.113.1585073114974;
        Tue, 24 Mar 2020 11:05:14 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.250])
        by smtp.googlemail.com with ESMTPSA id h12sm5348493iob.22.2020.03.24.11.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 11:05:14 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: thermal: tsens: Fix nvmem-cell-names schema
Date:   Tue, 24 Mar 2020 12:05:12 -0600
Message-Id: <20200324180513.3882-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There's a typo 'nvmem-cells-names' in the schema which means the correct
'nvmem-cell-names' in the examples are not checked. The possible values
are wrong too both in that the 2nd entry is not specified correctly and the
values are just wrong based on the dts files in the kernel.

Fixes: a877e768f655 ("dt-bindings: thermal: tsens: Convert over to a yaml schema")
Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Amit Kucheria <amit.kucheria@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/thermal/qcom-tsens.yaml          | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index eac644d9e238..7a38d2116059 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -52,13 +52,12 @@ properties:
     description:
       Reference to an nvmem node for the calibration data
 
-  nvmem-cells-names:
+  nvmem-cell-names:
     minItems: 1
     maxItems: 2
     items:
-      - enum:
-        - caldata
-        - calsel
+      - const: calib
+      - const: calib_sel
 
   "#qcom,sensors":
     allOf:
@@ -124,7 +123,7 @@ examples:
                  <0x4a8000 0x1000>; /* SROT */
 
            nvmem-cells = <&tsens_caldata>, <&tsens_calsel>;
-           nvmem-cell-names = "caldata", "calsel";
+           nvmem-cell-names = "calib", "calib_sel";
 
            interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
            interrupt-names = "uplow";
-- 
2.20.1

