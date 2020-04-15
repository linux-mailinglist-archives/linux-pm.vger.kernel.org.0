Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207501AA119
	for <lists+linux-pm@lfdr.de>; Wed, 15 Apr 2020 14:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409006AbgDOLne (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Apr 2020 07:43:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:35480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2897520AbgDOLnb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 Apr 2020 07:43:31 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E7D5214D8;
        Wed, 15 Apr 2020 11:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586951011;
        bh=009fT8XnlNWgSGFjkqzi9WHS52wJSOjnMq5vvLMSftE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HC8yKBERmY2yh4mSP9ed6QAnCugan1/mEN2q8aSM96pLbELGwP2RMZyVZE2u6/Q3X
         8eldzg2/C0MnFD8ySXdSm5e6tfORzBXCzR4SFbYySo5llCBjBrur/TzmiuErhV3ZA/
         ZqSEzmOFANVDsYwX4ojTna53rfmr0leVCJjsu/ws=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.5 054/106] dt-bindings: thermal: tsens: Fix nvmem-cell-names schema
Date:   Wed, 15 Apr 2020 07:41:34 -0400
Message-Id: <20200415114226.13103-54-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415114226.13103-1-sashal@kernel.org>
References: <20200415114226.13103-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rob Herring <robh@kernel.org>

[ Upstream commit b9589def9f9af93d9d4c5969c9a6c166f070e36e ]

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
Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../devicetree/bindings/thermal/qcom-tsens.yaml          | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index eef13b9446a87..a4df53228122a 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -53,13 +53,12 @@ properties:
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
@@ -125,7 +124,7 @@ examples:
                  <0x4a8000 0x1000>; /* SROT */
 
            nvmem-cells = <&tsens_caldata>, <&tsens_calsel>;
-           nvmem-cell-names = "caldata", "calsel";
+           nvmem-cell-names = "calib", "calib_sel";
 
            interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
            interrupt-names = "uplow";
-- 
2.20.1

